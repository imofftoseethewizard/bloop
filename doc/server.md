# Private Communication Support Server

### Project Phases

#### Version 0.0.1

Prospective delivery date Oct 1st 2012.

##### Server

Supports sessions, auth, key registration, and object API without transactions, access control, or
notifications.

APIs

    /about
    /client/register
    /client/authorize
    /session/new
    /session/sign
    /object/new
    /object/<object id>/
    /object/<object id>/delete
    /object/<object id>/modify
    /object/<object id>/replace
    /object/<object id>/update
    /object/<object id>/limit
    
External Components

- coffeescript
- connect framework
- sqlite3 (npm install sqlite3)
- stanford javascript crypto


###### Authentication

Check for session cookie.  If present, check that it has not expired.

/session/new creates a new 


##### Client

Library with basic crypto utilities.  Sample App: Hello world: create an object containing hello
world (encrypted).  Read object and decrypt.



### Concepts


#### Identities

All clients must have a key pair of the type given by the server's cryptography descriptor.  It is
used to register a client with the server and is the client's principal key.  A client may
register additional key pairs to provide compartmentalized resources for web applications, and in
particular, a key pair reserved for administrative functions.  These keys are used for
identification, communication, and session authorization.


#### Security Domains

The same origin policy implemented by web browsers has proven to be an effective method to
compartmentalize sensitive information.  Without support for this policy, a web application would
not be able to prevent the use of its resources by applications in other domains.

A security domain is the set of all sessions authenticated with one of a set of keys.  The
broadest security domain is the unauthenticated domain.  A client security domain consists of all
sessions authenticated with the client's principal key, administrative key, or any of its
application keys.  An application security domain is a subset of a client's security domain
consisting of those sessions authenticated with the associated application key.


#### Access Control

A capability is the permission to use a specific API on a specific entity.

Each resource has an access control list.  The entries in the list are pairs consisting of a
domain specifier and a set of capability grants and revocations.  The domain specifier is either a
`*`, a client id, or a pair consisting of a client id and an application id.  The domain specifier
describes the security domain to which the grants and revocations apply.  If the domain specifier
is `*`, then the applicable security domain is the unauthenticated domain; if the domain specifier
is a client id, then the applicable domain is client's security domain; if the domain specifier is
a pair, then the applicable domain is the application domain.  For a given session, the actual
capabilities available on a particular resource are a combination of the applicable capabilities,
with the more specific taking precedence.

### Installation

There are three installation scenarios: the first installation of a client by a user; the
installation of a new application when the user already has an established client identity and
an allotment of resources on a server; and the installation of an application that the user
has already installed on a different device.


#### First Installation

Extensions.  IE, Chrome, Firefox, Safari, Opera.

Parameters: host, invitation.  Create client id. Register, send invitation to host. Set up
password, key heirarchy.


#### Installation of New Appliction

An new application needs to get the address of the support server, client's principal key, and
some indication how to get config data and make service requests.


#### Installation of Application on New Device

When a user adds a new device, ideally, the applications should seem to move there naturally.
Obviously if an application is not available for the browser or device, that cannot happen, but in
the case where a version of the application is available, steps should be simple for transferring
authorization to the new device.

For each application on the source device, it creates an application installation url.  The url is
sent via some means (email, file transfer, chat, etc) to the new device.  When the user loads the
url in a browser, the browser installs the application and extracts a payload.  The payload
provides enough details so that in addition to a passphrase supplied by the user, the application
can load it's private data from the server.


### Sample Applications

Several sample applications have been described, both to give examples of how the APIs are used,
but also to ensure that the interfaces are well-structured and complete.  They are an
administrative application, a file system, a contact list, an email client, a blog, a forum
client, and a chat client.

The administrative application allows the client to manage the resources it owns and has access to
on the server. The file system stores documents in heirarchy and enables clients to share files.
The email, forum, and chat client, and the blog are simple demonstrations.  The contact list is
used by the email, forum, and chat clients.


#### Administrative Application

The administrative application is the sole holder of the administrative key, and is therefore
privileged to have all access to all resources owned by the client.  Enables the user to survey
the resources owned by the client, as well as resources which contain one of the clients security
domain in an access control list entry.

The application needs to be able to enumerate resources according to various criteria: type,
application, access, etc.  The application also needs to be able to know when resources have been
added, changed, or deleted.


#### File System

The file system application implements directories and file metadata.  It presents sorted list
views and detail views.

The application needs to use transactions to keep data structures coherent.


#### Contact List

The contact list demonstrates how to share information between applications.


#### Email Client

The email client uses queues to be able to send simple messages to other clients.


#### Forum Client

The forum client demonstrates how to use capabilites to delegate authority.


#### Chat Client

The chat client uses relays to open a communication channel to another client.


#### Blog

The blog demonstrates how to publish documents with limited distribution.  It also demonstrates
how to display encrypted media.

 
## Open Issues




#### Crypt URL Scheme

An http(s) URL that refers to an encrypted resource gives no indication of which key will decrypt
it.  This is problematic in a framework where an agent may be given a URL to a resource for which
it holds the decryption key, but it has no way of knowing which key will work.  To remedy this,
the server uses a custom URL scheme which includes a hash of a key associated with the resource.
If the resource was encrypted with a symmetric key, then that is the associated key.  If the
resource was encrypted with one half of a keypair, then the associated key is the public key of
the pair.  The hash is enclosed in square brackets and comes immediately after the scheme
designator.  It includes a tag indicating the hash algorithm, a space, and then the hash value,
either as hexidecimal or base64.  While there are base64 values that consist entirely of
hexidecimal characters, the length of the hash and the hash function can be used to infer the
radix.  The remainder of the identifier gives the server and path where the resource will be
found.

##### Example 1

The URL

    crypt:[MD5 1cbb71aef00711e1a27300215ddd758a]//tinyurl.com/26nnfp2A

refers to a resource at

    http://tinyurl.com/26nnfp2A

encrypted with a key whose MD5 hash is `1cbb71aef00711e1a27300215ddd758a`.

##### Example 2

The URL

    crypts:[SHA1 arzLVtmNkItNWb62znNSosoc]//example.com/object/2eb06b62-8db9-430a-ac3d-a2b887698e2b

refers to a resource at

    https://example.com/object/2eb06b62-8db9-430a-ac3d-a2b887698e2b

encrypted with a key whose SHA1 hash is `arzLVtmNkItNWb62znNSosoc` in base64.


## Usage Scenarios

The server is designed to support host-proof communication services.  This section details many of
the tasks that these services will require of the server, both as an explanation of how the API is
to be used, and as an exploration to ensure that the API is complete and usable.

The first set of scenarios deal with basic managerial tasks: registering keys, setting privileges,
etc.  Next are a couple relating to object access and storage, then a few dealing with message
queues, and finally a couple more complex scenarios demonstrating the use of relays.


### General and Administrative


#### Server Information

    GET http://.../about

A few details about the server are important prerequisites to initiating client interaction, in
particular, the type of public-private key pairs used for authentication and the cryptographic hash
function used in the modify object API.  This API may also return contact information for the
administrator, a public key or other identification, and a description of the software and its
configuration.


#### New Client

    POST http://.../client/register?key=<public key>

A client's public key must be registered with the server before it can be granted privileges or
use authenticated services.  The server derives the client's id from the public key, and this id
is used in every API that grants privileges.  The registering agent may be the client, or it may
be another.  Multiple registrations for the same key are allowed, since the registration process
deterministically produces the id from the key.  Registration is public and grants no privileges.

The id associated with the key will be returned in the response body.  The server will return an
error if the key is not the correct type.  The server will also return an error in the case that
there is a collision with another key.  It is presumed that the server will use a cryptographic
hash to create an id from a public key, and that the likelihood of a collision is essentially 0.
Nonetheless, the server should ensure that no single id is associated with more than one public
key, and if this case should arise, it must report an error.

If a hash collision does occur, then the caller should generate a new key pair and try again.  In
the case where a client has not accessed the server in sufficiently long that its key has been
dropped, and where after the key was dropped, a different client registers a different key that
produces the same id, there is the risk of confusion in that there may be access control lists
which have endured long enough that the meaning of the id is uncertain.  The risk of compromised
privacy is still very low, since the new client would still not possess the necessary keys to
decrypt the data.

Servers should also be aware of the denial of service attack risks.  The overhead of storing a
public key is small, but with an unthrottled API, a persistent attacker would eventually fill the
storage of the server.  Limiting the number of new keys registered to a given ip address to 1000
per day should slow an attack long enough that it can be detected and defended against well before
storage becomes limited.


#### Authorize Client

    POST* /client/<id>/authorize?allotment=<allotment>
    POST* /client/<id>/authorize?max-queues=<max queues>
    POST* /client/<id>/authorize?max-relays=<max relays>
    POST* /client/<id>/authorize?max-connections=<max connections>

All clients may write to public message queues, read objects, and inquire about other clients' public
metadata. Unauthorized clients may have other privileges granted to them by authorized clients,
but they cannot own resources until they are authorized by an administrator.  These APIs grant a
client the privilege of creating resources of various kinds.  Space for object storage is
specified by _allotment_; the others are self-explanatory.  The value `unlimited` will remove a
limit; the values `none` and `0` will remove the privilege.

##### Example 1

    POST https://.../client/authorize?id=<a6062907-746d-4ada-a95e-e026c0337f48>?allotment=3gb
    POST https://.../client/authorize?id=<a6062907-746d-4ada-a95e-e026c0337f48>?max-queues=500
    POST https://.../client/authorize?id=<a6062907-746d-4ada-a95e-e026c0337f48>?max-relays=50
    POST https://.../client/authorize?id=<a6062907-746d-4ada-a95e-e026c0337f48>?max-connections=unlimited

The result of these will be to set the client's total storage limit at 3 GB, allow the client to
have up to 500 message queues and 50 relays at one time, and place no limit on connections.  Note
that this is equivalent to

    POST https://.../client/authorize?id=<a6062907-746d-4ada-a95e-e026c0337f48>? \
      allotment=3gb&max-queues=500&max-relays=50&max-connections=unlimited

Connections in this case refers to connections to relays that the client owns.  Connections to
relays that are owned by other clients are accounted to the owning client.

##### Example 2

    POST https://.../client/authorize?id=<a6062907-746d-4ada-a95e-e026c0337f48>?allotment=none&max-relays=0

This will return the client to an unprivileged state.  An allotment of 0 means that the client is
not allowed to have data stored on the server.  Since each queue takes some storage space, that
means that the user will be unable to have message queues.  If, when the client has its privileges
removed, the client has data stored on the server, or non-empty queues, or connections currently
open, then the server may dispose of those resources as it deems fit.  This may be a graceful
running down of usage, or an abrupt eviction.


### Message Service &mdash; Unknown Sender 

While unknown senders are currently primarily spam, there are still useful cases.

In this scenario, there are three agents: the sender, the server, and the receiver.  The receiver
is registered on the server and does not know the sender; the sender is not registered on the
server, but knows the public key of the receiver.

An important part of the protocol is that the content of the message must be encrypted for the
receiver and stored by the sender, forcing the sender to maintain a separate block of storage for
each message sent to each recipient.  While this is a small cost in terms of processing, storage,
and transmission, it is much more expensive than the current cost of sending spam.


#### Step 1: Sender Obtains Receiver's Id and Public Queue

The sender knows the receiver's public key and a server where the receiver has an account.  The
sender needs the receiver's id on the server and the id of the receiver's public message queue.
The sender issues a client inquiry:

    GET http://.../client?public-key=<public key>

The server searches its client database for a matching key and returns a JSON object in the
response if found; otherwise it returns a 404 error.

If the receiver has not registered a public message queue, then the sender cannot send the
message.


#### Step 2: Sender Posts to Receiver's Public Queue

The sender now has the id of the receiver, the receiver's public key, and the id of the receiver's
public message queue.  First, the sender must encrypt the message with the receiver's public key,
and then it must store the message in a location accessible by the receiver, say

    http://sender.com/messages/<receiver id>/<message hash>

Next the sender posts it to the public queue, placing the url in the request body

    POST https://.../queue/<receiver's public queue id>
    <headers>
    http://sender.com/messages/<receiver id>/<message hash>

If the message exceeds the length allowed, the server will respond with error code 413 Request
Entity Too Long. If the receiver's queue is full .... Otherwise, the server will append the
message to the queue, noting the time and the apparent ip address of the sender.


#### Step 3: Receiver Flushes Its Public Queue

At some point later, the receiver will flush its public message queue, and in so doing, retrieve
the message sent by the sender.

    POST https://.../queue/<queue id>/flush

The server returns an array of post entries, each entry giving the sender's ip information, the
date of the message, and the message body.  Each message body is presumed to be a url to the
cryptotext of the message.


#### Step 4: Receiver Retrieves Sender's Message

The receiver now has the ip address of the sender and the url of the message.  The receiver may
elect not to retrieve the message, based on the sender's ip or the url.  If the receiver
approves, then it retrieves the contents of the resource and attempts to decrypt it with its
private key.  It is important that the receiver discard messages containing invalid urls or
urls which point to plaintext bodies.  If the receiver relaxes either condition, then it reduces
the cost of unsolicted messages and encourages the use of the service for spam.


#### Information Leakage

The receiver leaks some information to the sender when it retrieves the message, in both the
timing of the retrieval and the apparent ip address of the request.  Both of these can be
mitigated.  First, either a regularly or stochastically scheduled process to retrieve messages
will prevent the sender from obtaining useful information about the receiver's habits.  Second,
the receiver could use a service like Tor to obscure its location.


### Known Sender Message Service

The bulk of relevant email arrives from a known sender who has been party to a prior exchange.

In this scenario, there are three agents: the sender, the server, and the receiver.  Both the
sender and the receiver are registered on the server and are known to each other.  The sender also
has the id of a private message queue of the receiver and permission to post to it.

Unlike the unknown sender case, the receiver implicitly trusts the sender not to egregiously waste
the receiver's time and resources.  Messages from known senders, therefore, are not as restricted
as those from unknown senders.  In this case, the sender has the option to include the content of
the message in the post to the queue, rather than a url; also, the receiver may opt to make the
maximum post size larger to accomodate that usage.  Regardless of whether the content is in the
post body or in a resource elsewhere, the sender should encrypt the content to the degree it
wishes to maintain privacy; uniform use of encryption is encouraged, even for non-sensitive
messages, to reduce the risk of information leakage.


#### Step 1: Sender Encrypts Message

The sender encrypts the message using the protocol that it and the receiver have agreed to.  It may
be a symmetric key, or the public key of the receiver, etc. 


#### Step 2: Sender Posts Message to Receiver's Private Queue

The sender has two options: if the message is small enough, it may post the content itself into
the queue; alternatively, it could store the message somewhere and provide the url:

    POST https://.../queue/<receiver's private queue id>
    <headers>
    5UMCMUpQ2I6ZdxhBIXB94EC6boHenlrP5PGdJRoSUVjQMpmiKPQd
    38Z+L+nGn2kQsQmMB1wzAx/2Yulrtt/t7c3zABEBAAG0SUFsZXhpcyBDYXJsc29u
    IChnZW5lcmF0ZWQgYnkgUmV0cm9zaG    

or

    POST https://.../queue/<receiver's private queue id>
    <headers>
    http://sender.com/messages/<receiver id>/<message hash>.cryptxt

The sender could also encrypt both the content and the url, if the message is too large to fit in
the queue and the sender does not want the location of the cryptext to be visible to the server.


#### Step 3: Receiver Flushes its Queue and Retrieves the Message

Once the receiver flushes its queue and finds the post from the sender, it must determine the
format and content of the post body.  The sender and receiver may have previously agreed to a
policy, or the receiver might have to infer it from the body itself.  The server places no
restrictions on this.  One option is for the post bodies to be encrypted in all circumstances, and
the receiver determines whether or not the plaintext is the message itself or simply a url to the
message; another option is for the post bodies to be plaintext, and always refer to the encrypted
message.


#### Information Leakage

Like the unknown sender case above, there are potential leakages around url access time and
origin.  However, in the case of a known sender, these are probably less of an issue, since the
sender and receiver probably know each other in person, or at least have some level of trust.


### Clear Text Publishing

Various clear text publishing services are already available (tumblr, twittr, flickr, youtube,
etc), and it is a simple generalization of more restricted publishing, so it is not discussed
here.


### Selective Publishing

Existing selective publishing services have a significant downside: while (it is hoped) the
service provider prevents unauthorized users from viewing sensitive content, the content itself is
visible to the service provider.  Despite internal controls, employees may gain access to private
data.  The service provider may have a security breach, or be compelled to release the information
by legal means.  Further, the service provider can arbitrarily and unilaterally change its privacy
policy, or be acquired by another organization with different values and goals.

In this scenario, there is an author, a server, and many readers.  The author has created a
private queue and given the id to the readers.  The readers have permission to read the queue, but
not to change it.  It is presumed that the author trusts the readers to keep private data
confidential.  Author, in this case, does not strictly refer to a producer of text, but simply a
producer of content.


#### Step 1: Author Encrypts and Saves Content

The author and readers should have already agreed to an encryption protocol.  While a number of
different protocols are possible, the one used here keeps the distribution list confidential from
all but the server.  

First, the author encrypts each publication with a unique symmetric key, and saves it to a
location accessible to all readers, say

    http://.../object/<publication id>


#### Step 2: Author Creates Comment Queue

To allow comments, the author should create a queue to accompany the content.  At the very least,
the comment queue should be readable by all readers, and at the author's discretion, writeable by
all of them as well.  A good choice of symmetric key for the queue is the symmetric key for the
content


#### Step 3: Author Creates Distribution List and Manifest

The symmetric key is encrypted with the public key of each reader, and the encrypted keys are listed
in a table associating the reader's id and the key encrypted for that reader.  Additionally, the
author should include an entry for itself.

The author should create a manifest which contains at least the distribution list, the location of
the content, and optionally, the comment queue id.  The author may wish to include other metadata
in the manifest.  The author encrypts the distribution list with a symmetric key.  The symmetric
key is given to the readers after they have permission to read the queue, and is presumed to be
relatively durable, in use for the lifetime of the queue under favorable circumstances.

The author saves the encrypted manifest to another location

    http://.../object/<manifest id>

While the manifest itself may be small enough to post to the queue, it is probably better for it
to have separate storage.  Queue entries generally have a limited lifetime, and if they did not,
then the queue might grow unwieldy.  Further, flushing the queue might render the content
unreadable.


#### Step 4: Author Posts the Manifest to the Queue

Next, the author posts a url to the manifest in the queue

    POST https://.../queue/<publication queue id>
    <headers>
    http://.../object/<manifest id>


#### Step 5: Readers Get Recent Posts from Queue

A reader may choose to retrieve all avaliable manifests

    GET https://.../queue/<publication queue id>

or just the most recent 10

    GET https://.../queue/<publication queue id>?count=10

or manifests 11-20

    GET https://.../queue/<publication queue id>?start=10&count=10

or those from the last week

    GET https://.../queue/<publication queue id>?start-date=-1w


#### Step 6: Readers Locate and Decrypt Content

The reader retrieves the manifest from the url given, decodes it with the symmetric key associated
with the queue, and finds the location of the content and the encrypted key for it in the
distribution list.  The reader then decrypts the content specific symmetric key, loads the
encrypted content, decrypts and views it.


#### Step 7: Readers Make Comments

A reader making a comment is a similar process to steps 1-6, except that the manifest for the
comment should indicate whether the comment is about the post itself or another comment, and the
manifest need not include a queue for comments on the comment.


### Groups, Forums, Walls: Multiparty Message Queues

Forums are similar to comments described above, except that the set up is a little different, and
instead of there being a single author who has full control, there may be several administrators
to moderate forum activity.


#### Set Up

A forum has an owner, administrators, participants, and observers.  The owner creates the queue,
picks the symmetric key, and picks the administrators, giving them permission to flush and permit
as well as read and write.  Participants and observers are invited by administrators; participants
are given read and write permission, while observers may only read the queue.  In general, posts
to a queue acting as a forum should not expire, and the content of the first post should be an
object containing metadata about the forum.


#### Posting

Posting a message to a forum is similar to adding a comment in the Selective Publishing section.


#### Moderation

If need be, one of the administrators can delete inappropriate or unwelcome posts.  Flushing the
post is sufficient, but it would be helpful if a new post were added, stating that the original
post was removed, possibly with other details about who removed it and why.


### File Sharing

File sharing is rather simple.  The owner encrypts the file with a symmetric key, saves it to a
jointly accessible location, and sends the key and location of the file to the recipient.  The
recipient can either access the file in place, with the disadvantage that the owner may delete it
at any time.  Alternatively, the recipient could copy the file to a new location, possibly
decrypting and recrypting it in the process.

    
### Simple Chat

Direct browser to browser connections are not yet available outside of a couple of trial
implementations, so it is not possible to construct a chat session without a third party server.


#### Step 1: Host Creates a Relay

A client that wishes to receive chat connections must create a relay.

    POST https://.../relay/new

The server creates a new relay and returns the id in the body of the response.


#### Step 2: Host Permits Connections to a Relay

Next, the host must allow other clients to attempt to connect to the relay

    POST https://.../relay/<relay id>/permit?id=<other id1>&grant=connect
    POST https://.../relay/<relay id>/permit?id=<other id2>&grant=connect
    ...

The host should then inform the clients of the id of the relay, and that they are permitted to
connect to it.


#### Step 3: Host Listens for Connections

Prior to a client attempting to connect, the host must listen to the relay.

    wss://.../relay/<relay id>/listen

This opens a websocket connection to the server.  As long as the connection is open, the host will
be informed of client connection requests. 


#### Step 4: A Caller Requests a Connection

A client requests a connection to a relay by opening

    wss://.../relay/<relay id>


#### Step 5: Server Notifies Host of Connection Request

When a client requests a connection, the server sends a message to the host, providing the id of
the connection.  The host may discover the id of the caller by

    GET https://.../connection/<connection id>/list


#### Step 6a: Host Accepts Caller's Connection Request

If the host accepts the request, it opens

    wss://.../connection/<connection id>

The server then sends the connection id to the waiting client.  The host creates a symmetric key,
encrypts it with the public key of the client, and sends the encrypted key to the client via the
new connection.  Both parties use this key to encrypt their messages.


#### Step 6b: Host Rejects Caller's Connection Request

If the host rejects the connection request, it opens

    POST https://.../connection/<connection-id>/close

The server then notifies the client the connection was rejected and closes the socket.


#### Step 7: Closing the Connection

When the server detects that only one of the two is still connected, it notifies the remaining
party that its counterparty has hung up, and then it closes the socket.


### Multiparty Chat

Multiparty chat is similar to simple chat, though it allows for others to join and leave without
ending the connection, and it provides support for moderation.


#### Joining an Existing Connection

Up until the point that the client has received the encrypted key from the host, multiparty chat
is nearly identical to simple chat.  If there is another chat connection that the server wishes
the new connection to join, then instead of sending a new symmetric key to the client, the host
sends the key for the extant connection instead.  The host should ensure that the client has
permission to join the connection, and after the host sends the encrypted key, it sends a message
to the client instructing it to join the connection.  The client then drops the new connection and
requests

    wss://.../connection/<connection-id>/join

using the connection id given by the host.

Alternatively, if by some other means, the client knows of a connection that it is permitted to
join, it may simply issue the join request, rather than negotiating through the relay.

In a multiparty connection, the server broadcasts each sender's messages to all of the other
parties to the connection.


#### Chat Moderation

The host (or any client with sufficient permission) may act as a moderator.  Moderators may drop
participants, invite new clients, or bar clients from joining a connection.

If a moderator wishes to drop a client, then it requests

    POST https://.../connection/<connection-id>/drop/<client id>

and the server abruptly ends a clients participation in a connection.

To bar a client from joining a connection,

    POST https://.../connection/<connection id>/permit?id=<client id>&revoke=join

and similarly to allow a new client to join,

    POST https://.../connection/<connection id>/permit?id=<client id>&grant=join 

### Installation and Configuration

Install server software.
Add a public key for the administrator.  Needs command line tool.
Prepare databases.
Start server.


### Defunct Keys

The server acts as a keyserver in that it stores public keys and keeps a modest amount of metadata
with each one.  As with all keyservers, there is the problem of abandoned keys accumulating over
time.  Since the keys are primarily for the use of clients of the server (thought they may be used
elsewhere), the server can determine which are infrequently used.  If the client associated with a
key has not authenticated on the server in a year, then the server may choose to drop the key.
Re-registering the client should provide the same id.

  
### Indexing and Search

Must be done on client.




## Utilities

- JSON response body
- SQL search

## Class Reference

### Server

properties
  - list of clients
  - public/private crypto algorithm
  - key size in bits
  - symmetric crypto alogrithm
  - symmetric key size in bits
  - hash function
  - hash size in bits
  - public key of administrator
  - id of administrator

methods
  - compute id from public key
  - register key
  - encrypt
  - sign

### Client

properties
  - id
  - public key
  - privilege level
  - public message queue
  - allotment
  - usage
  - max queues
  - queue count
  - max relays
  - relay count
  - max connections
  - connection count
  - sessions

methods
  - decrypt
  - verify signature

class methods
  - find client by public key
  - find client by id

### Session

properties
  - id
  - client
  - ip address & other connection metadata
  - create date/time
  - last request date/time
  - authenticated?
  - symmetric key (for cookie encryption)

methods
  - validate hash
  - make cookie
  - validate request

### Object

properties
  - id
  - owner
  - acl
  - created date
  - last modified
  - expiration date
  - length
  - max length
  - storage location
  - data

methods
  - modify
  - replace
  - update
  - duplicate

### Queue

properties
  - id
  - owner
  - acl
  - created date
  - last modified
  - posts
  - max posts
  - post count
  - max size
  - current size
  - post residency 
  - max post length

methods
  - add post
  - select posts
  - select and remove posts

### Post

properties
  - id of poster or ip address of anonymous poster
  - length
  - created date
  - expiration date
  - content

### Relay

properties
  - id
  - owner
  - acl
  - listener
  - connections
  - connection count
  - max connections
  - max clients (default)

methods


### Connection

properties
  - id
  - owner
  - acl
  - relay
  - clients
  - client count
  - max clients


Usage

