Open Pool
=========

# Overview

This proposal describes an open source, peer to peer, distributed data storage pool.  The
architecture and protocols enable individual mutually untrusted agents to cooperate and to
exchange local private storage for distributed storage, with reasonable assurance that free riders
and malicious actors are quickly removed from the system and that their effects are detectable,
transient, and reversible.  Each pool relies crucially on a core of actors which are trusted
universally within it; would-be participants who do not trust any existing pool's core can easily
start their own.  Pools are not distributed file systems; they more primitive, only supporting
addressable persistent data.  A file system architecture may be built on top of a pool -- indeed,
that is intended; but it is not required.  In the same way that a disk drive has no information
about or interaction with the notion of a user account, pools are not intended to have any
information about nor connection with individual users; while there may be a correlation between
actors and users, nothing about the design intends this to be one to one, and in fact, greater
security and anonymity are obtained when there is not a strict one to one mapping from users to
actors.  This deliberate limitation of system capabilities allows for other protocols to be built
on top of it, inspired, in part, by the 'separation of concerns' design paradigm.

A pool is a collection of actors, distinguished by privilege level and role.  The highest
privilege level is held by the master; there is only one master per pool.  The master delegates
critical duties to the delegates.  One delegate plays the role of the registrar.  The registrar
accepts new actors into the network, assigns them ids, keeps some basic metadata about them, and
acts as a keyserver.  The rest of the delegates are managers.  Both the master and the delegates
are implicitly considered trustworthy -- to the extent that they will maintain the integrity of
the pool -- by the rest of the pool participants.  Next down on the authority scale are the
agents.  Agents are the repositories, indices, and monitors for the pool.  They are not trusted,
and all services they provide must be both redudantly supplied and regularly audited.  Finally,
there are clients, which are largely anonymous actors consuming the services of the agents.

The principal services of a pool are to store and serve data.  The intended storage data flow is
from a client to a repository which acts on the clients behalf to store the data in the pool.
This relationship between a client and a repository that acts as its agent to the pool is outside
of the scope of this document, but in any case, it should be established prior to the repository
acting as agent for the client.  Repositories serve data without requiring authorization, and for
this reason a block of data is private only to the extent that the owner has encrypted it.  A
repository offers a block of its own storage for use by the pool, and in return obtains the right
to store a comparable amount of its own data in the storage of other pool members.  Index agents
store the locations of blocks of data.  Monitor agents aggregate exceptions and attempt to
identify malicious or unfaithful agents.

Data storage is a relatively slow process.  An actor that wishes to store data must call a
repository.  The actor must prove to the repository that it has the standing to store the data.
If the repository approves, the actor then sends the data.  On completion, the repository sends a
receipt to the actor and notifies an index of the stored data.  The actor may verify that the data
has been stored by asking for a digest from the repository, by attempting to find the data in an
index, or both.  Owing to propagation lags, it may be a few minutes before all indices will be
updated.

If the actor requesting to store data is a client, then the client must assert its identity to the
repository, and they must have a prior relationship in which the repository has agreed to act as
agent for the client.  In this case, the request should contain unique id and optionally a
redundancy level, and the receipt will contain the id of the block in the pool as well as the ids
and addresses of all of the repositories that hold a copy.  If the actor requesting to store the
data is another repository, then the handling repository checks with the registrar to see if the
calling repository is in good standing; the handler also checks with an index to ensure that the
caller still has unused allotment; and the handler challenges the caller to prove that it
faithfully stores at least as much data as it is requesting to store.  To challenge the caller,
the handler selects a set of blocks that the caller has agreed to store, for which there is a copy
available elsewhere in the pool, and which collectively are approximately equal in size to the
data the caller wishes to store.  For each block, the handler selects a random 1 KB range, picks a
seed, requests a digest from all repositories other than the caller which hold a copy of the
block, and the same digest from the caller.  The caller must produce a digest for each block, and
for those blocks which the at least one other repository returned a digest before timeout, the two
must match.  Note that a digest request may include a blackout period, so that the caller can be
prevented from obtaining a digest from one of the redundant repositories.

# Examples

## Client Stores Data

Suppose Alice is an agent in a pool and Chris is a client.  Alice has contributed 1 TB of disk
space to the pool, and in return has a 200 GB storage allowance.  Chris is leasing 100 GB of this
for his own use.  Chris has a photo he would like to store and Alice is his agent in the pool.
Chris breaks the photo up into blocks no larger than the pool's granularity, say 16 KB.  Chris
calls Alice and asserts his identity.  Chris begins making store requests of Alice, one for each
block, each request containing a unique tag or sequence number and a redundancy factor.  In
response, Alice creates a block id for it and stores the data locally.  Additionally, since Chris
would like his data to be stored with 5x redundancy, Alice picks four other agents and stores a
copy of the block with them.  Once this is complete, Alice sends Chris a receipt containing a tag
given in the original storage request, the block id, and the ids of the agents which have a copy.
Chris uses the receipts to map the original blocks to the block ids returned by Alice, and he
creates a manifest of all of the agents who are storing parts of his photo.

## Client Accesses Data

Chris has a photo stored in the pool as a result of the prior example.  He wishes to view that
photo.  For each block in the manifest, he calls one or more of the agents listed and makes a
request for the block.  He may choose to request only of Alice, if Alice has a high bandwidth;
otherwise he may choose to request from a variety of clients to improve throughput.  Once he has
received the blocks, he reassembles them in order and is able to view his photo.

While this is no improvement over any number of services available, it provides a uniform protocol
for storing backups, photos, media, correspondance, etc, in which the protocol is agnostic to the
content, the content is replicated and universally available, and the granularity and level of
security is entirely within the control of the client.  Furthermore, since the data can be
encrypted before storage, it is essentially without content to those who actually store it, and
the owner of the data retains much more control over it than if it were stored with a service.

## Limited Publication

Suppose that Chris would like to share his photo with two friends, Ed and Martin.  He can encrypt
the image with a symmetric key cipher and then encrypt the key with each of the recipient's keys,
and add that to the manifest.  He then sends the manifest to Ed and Martin.  If Ed would like
to see the photo, he finds the encrypted symmetric key associated with his id in the manifest and
decrypts it with his private key.  Once he has retrieved and assembled the encrypted image, he
decrypts it with the symmetric key.  If Chris would like to remove the photo or remove access
to the photo, then removing or changing the manifest is sufficient.  Unless Ed or Martin copy the
photo and publish it themselves, or reveal the symmetric key, Chris can rely on the photo not
having wider circulation unless he explicitly allows it.

## Communication

Suppose that Chris and Drew would like to have a private communication channel.  Alice is Chris's
agent and Barry is Drew's.  Chris asks Alice to create a data block and gives Drew the id and
Alice's address; Drew asks Barry to create a data block and gives Chris the id and Barry's
address.  Both Chris regularly polls Barry to see if Drew's block has changed; Drew polls Alice
similarly.  When Chris wants to send a message to Drew, he encrypts it with Drew's key and asks
Alice to update the block.  Drew notices that the block has changed, retrieves it, and decrypts it
with his private key.  Note that the agents Alice and Barry need not be in the same pool, and that
either Chris and Drew are in the same pool, or they've previously exchanged public keys.

# Glossary

*Actor* &mdash; A participant in the pool. Can be the master, a delegate, an agent, or a client.

*Agent* &mdash; An identified, untrusted actor.  These actors provide most of the services of the pool.

*Caller* &mdash; In the context of a connection, the agent which initiates.

*Challenge* &mdash; An interchange between two repositories during a store request in which the handler
 requires the caller to prove that it faithfully keeps at least as much data as it is requesting
 to store.

During the store request, the caller states how much data it would like to store. The handler then
randomly selects a set of data blocks that the caller has stored approximately equal in size to
that requested.  In each block, the handler randomly selects some small range, perhaps a few KB in
size. For each block, the handler gets the list of all repositories holding a copy, and sends a
digest request for the block and range to three of them, sending the request to the caller last,
possibly after a slight delay.  If for each of the blocks, the caller's digest matches the digest
of one of the others*, then the challenge has been met.  It is permissible for the handler to time
out and accept an incomplete challenge, provided that the caller has satisfied the challenge for
all blocks that had a response from a repository other than the caller.  (*As a point of fact, all
of the digests should be the same, but as long as the caller and one other respond with matching
digests, then it is reasonable to presume the caller faithfully stores the block.)

*Client* &mdash; An unidentified, untrusted actor.  These actors consume the services of the pool.

*Delegate* &mdash; An identified, trusted actor.  These actors ensure pool integrity and coordinate the
 actions of the agents.

*Digest* &mdash; A digest is a seeded cryptographic hash of a subset of a data block computed by a
 repository.  It is used to challenge a repository to prove that it faithfully keeps a data block.

The digest request contains the id of the block, a seed, an address, a length (in bytes), and
optionally a blackout duration.  The cryptographic hash used is determined by the registrar.  The
seed is prepended to the bytes from the block, and the hash is computed.  The repository should
refuse any request with identical specification of block, seed, address, and length until the
blackout has passed.

*Granularity* &mdash; The size of the largest data block that the pool will accommodate.

Large objects can be broken up into multiple blocks, so it is not a restriction on the size of
entity that can be stored in the pool.  Recognizing that not all agents will be able to deliver
data at the same speed, the granularity should be chosen small enough so that agents on slower
connections do not have overly large transfers to make.  In general, the largest block size should
be around 1/10th the per-second delivery rate of the median agent in the pool.  If the pool is
largely composed of home computers connected via DSL or cable with 100KB/s upload speed, then a
granularity of around 10 KB should work well.  For a pool composed primarily of cloud-based
virtual servers, a much larger block size might be workable.  Note that this only gives an upper
bound on the size of the blocks in the pool.  Smaller blocks of irregular size are permissible as
well.

*Handler* &mdash; In the context of a connection, the agent which accepts.

*Handshake* &mdash; The process by which two actors assert their identity to each other.

After the handler accepts the connection, it sends its id and a connection id to the caller.  If
the caller wishes to assert its identity to the handler, it responds with a signed message
containing the connection id, the ids of the caller and handler.  If the handler does not already
have the public key of the caller, the handler requests it from the registrar.  The handler checks
the signature of the message, and if it approves, signs the message and returns it.

If the caller does not wish to assert its identity to the handler it responds with a message
containing the connection id and the id of the handler.

Note that clients are allowed to assert their identity in the handshake if they have subscribed to
the handler.

*Id* &mdash; In general, this refers to the id associated by the registrary with an identified actor.  The
 id is derived from the actor's public key by a well-known algorithm.  In general, this will be a
 cryptographic hash of a specific kind and size, optionally followed by a truncation or a
 determinate extension.

*Identified* &mdash; An actor that has a key registered with the pool registrar.  The master, delegates,
 and agents are all identified.  Clients are not.

*Index* &mdash; An agent which allows other actors to find where data is stored, what data each repository
 holds, which manager each agent has, which agents are indexes, which agents are monitors, as well
 as general information about the pool.

*Invitation* &mdash; A message signed by an agent which will allow a client to subscribe to that agent.
The message should contain the id of the pool's master, the id of the inviting agent, a
subscription id, and optionally an expiration.  The inviting agent may also limit the number of
times an invitation can be used, or place any other restriction deemed necessary.

*Key* &mdash; Refers to the public key of an identified actor.  An actor's private key will always be
 referred to in full.

*Manager* &mdash; A delegate responsible for coordinating and monitoring agents.  There must be at least
 one manager per pool.  Each agent has a manager.

*Master* &mdash; An identified, trusted actor.  In each pool, there is only one master.  The master
 initiates the pool, authorizes delegates, picks the registrar, and coordinates the delegates.

*Monitor* &mdash; An agent which aggregates exceptions about other agents, and reports to the appropriate
 manager when a malicious, unfaithful, or problematic pattern of errors occurs.

*Pool* &mdash; A set of actors which cooperate to provide a secure, distributed, peer to peer data storage
service.

*Registrar* &mdash; A delegate responsible for registering the keys of the identified actors, for
 generating their ids, for asserting the authority of the delegates, and for maintaining the
 status of the agents.  There is only one registrar per pool.  The registrar should also provide
 the cryptographic methods that are supported for signatures, a description of the algorithm
 used to create an actor's id from its public key, and the granularity of the pool.

*Repository* &mdash; An agent which stores and serves data.

To store data, an actor calls a repository and asserts its identity during the handshake.  The
caller then sends a message requesting to store data, and includes the amount required.  The
repository may approve the request without challenge, or if the caller is another repository, the
repository may elect to challenge the caller. If the repository does not approve, or if the caller
fails the challenge, then the it replies with a signed refusal, and sends the same to a monitor.
Otherwise, it responds with a simple affirmative, optionally with information about the transfer
protocol, after which it listens for the data.  When the transfer is done, the repository should
reply indicating that it has finished.  The repository may also reply from time to time during the
transfer to indicate the current progress.  After the block has been stored, the handler should
send the caller a signed storage receipt.  Both the handler and the caller should report the new
block to an index.

To retrieve data, an actor calls a repository. The caller is not required to assert its identity
during the handshake.  The caller sends a message containing the block id requested, optionally
with information about the transfer protocol.  If the repository has the block, it sends a message
confirming the protocol, then transmits the data.  If the repository does not have the block, it
may respond with a list of repositories that might contain it, or with a list of indices through
which the block might be found, or a simple message saying that the block could not be found.

To delete data, an actor calls a repository and asserts its identity during the handshake.  Blocks
can only be deleted by a delegate or the agent that created the block.

*Signed* &mdash; A message which has a cryptographic signature; in particular, the signature derived from
 the private key of the sender.

*Subscription* &mdash; The process by which a client register's its key with an agent, and in return
 obtains its id.

The client calls the agent. In response to the handshake, the client sends a signed message
containing the invitation and its public key.  The handler responds with a signed message
containing the connection id, its own id, and the id that it has assigned to the client.  Multiple
subscriptions with the same key are allowed, but they should all return the same id.

*Trusted* &mdash; An actor that plays a critical role in the pool, whose proper operation is necessary to
 maintain pool integrity.  The master and delegates are trusted.

*Unidentified* &mdash; An actor that has not registered a key with the registrar.  Only clients are
 unidentified.

*Untrusted* &mdash; An actor that has no critical role in the pool.  Agents and clients are untrusted.

