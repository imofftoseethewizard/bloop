# Interactions
# Messages

# TODO

- protocol for block access statistics
- criteria for determining when an agent is malicious or unfaithful
- description of data structures used
- describe index information repositories keep
- describe manager fallback protocol
- move accounting from manager to index
- think about reliablility when indexes compute and hold allotment and usage data

# Data

## Agents

- list of all delegate ids and their keys
- list of all indexes and the ranges they cover
- list of all managers and the ranges they cover
- list of monitors that cover the agent
- list of repositories not in good standing

# Messages

All messages have an 8 byte header.  The first four bytes specify the protocol and version; the
next four specify the message type.

    0000 pp pp pp pp  -- protocol type and version
    0004 mm mm mm mm  -- message type


# Interactions

## General Registrar Interactions

### Obtaining Pool Details

The details about the pool can be obtained by sending the registrar or any manager a
`request-pool-info` message.  The handler responds with a `pool-info` message.  The caller need
not assert identity, and in fact, this is in general a prerequesite for joining a pool, as the new
member needs to create a keypair of a specific size using a specific algorithm, the details of
which are in the `pool-info` message.

`request-pool-info`

This message has no parameters and consists of only the 8 byte header.  It may be sent by anyone.
In response, the handler returns a `pool-info` message.

`pool-info <ipv4 addr> <ipv6 addr> <port> <secure port> <algorithm> <key length> <granularity> <key>`

    0008 xx xx xx xx  -- ipv4 address of registrar
    000c yy yy yy yy  -- ipv6 address of registrar
    0010 yy yy yy yy
    0014 yy yy yy yy
    0018 yy yy yy yy
    001c zz zz ww ww  -- insecure port; secure port
    0020 uu uu vv vv  -- cryptographic algorithm; key length (bits)
    0024 tt tt        -- pool granularity (bytes)
    0026 ss ss ss ss  -- registrar's public key
    002a ...


### Joining a Pool

A new member to a pool joins by sending the registrar a `join` message.  The new member must have
already created a keypair of the proper type and length, and must know the address of the
registrar and its secure port.

`join <ipv4 addr> <ipv6 addr> <port> <secure port> <public key>`

- `<ipv4 addr>` is the 4-byte ip version 4 address of the new member.
- `<ipv6 addr>` is the 16-byte ip version 6 address of the new member.
- `<port>` is the insecure port on the new member which handles the pool protocol.
- `<secure port>` is the secure port (SSL/TLS) on the new member which handles the pool protocol.
- `<public key>` is the public key of the new member; it should be for the algorithm and of the
  size given by the registrar or a manager in the `pool-info` message.

    0008 xx xx xx xx  -- ipv4 address
    000c yy yy yy yy  -- ipv6 address
    0010 yy yy yy yy
    0014 yy yy yy yy
    0018 yy yy yy yy
    001c zz zz ww ww  -- insecure port; secure port
    0020 uu uu uu uu  -- public key of new member
    0024 ...

## Registrar and Manager

### New Manager Registration

The would-be manager should register with the pool to establish its id and make known its key and
location.  Then, by some external process, the registrar should be informed that the actor is
approved to be a manager. Subsequently, the manager calls the registrar and requests its
assignment.  The registrar replies with the assignment as well as the details about the other
managers and agents.

`request-assignment <start-id> <end-id>`

    0008 xx xx xx xx  -- first id of requested range
    000c yy yy yy yy  -- id after the last of requested range

This message is sent by managers to the registrar to request the agent ids that make up the
manager's assignment.  It is primarily used during new manager initialization.  Initially, the
manager makes a request for all ids; that is, with both parameters 0. The registrar responds with
either an `assignment-denied` message, or with an `assigned-agents` message.  The former occurs if
the manager has not asserted its identity, or if it has, but it is not authorized to be manager.
Otherwise, the registrar responds with the ids that are both in the manager's assigned range and
in the range requested.

`assignment-denied`

This message is sent by the registrar in response to a `request-assignment` message in which the
caller is not authorized to be a manager.

`assigned-agents <start id> <end id> <count> <ids>`

    0008 xx xx xx xx  -- first id of manager's assignment
    000c yy yy yy yy  -- id after the last of manager's assignment
    0010 zz zz zz zz  -- number of ids to follow
    0014 w0 w0 w0 w0  -- id of first agent assigned to manager
    0018 w1 w1 w1 w1  -- id of second agent assigned to manager
    001c ...

This message is sent by the registrar to a manager either in response to a `request-assignment`
message.  The ids are 4-byte agent ids.  The range includes `<start id>`, but not `<end id>`.  If
the connection should drop before all of the ids have been received, then the manager should
resend the `request-assignment` message, requesting the remaining ids.

Once the manager has the ids of its assignees, it should then request suitable-sized blocks of
agent details.

`request-agent-details <count> <ids>`

    0008 xx xx        -- count of ids being requested
    000a w0 w0 w0 w0  -- id of first agent 
    000e w1 w1 w1 w1  -- id of second agent 
    0012 ...

This message is typically sent by a manager to the registrar to obtain the details about a group
of agents.  It may also be sent by an agent to its manager.  In general, agents should not burden
the registrar with this request, as the manager of the agent can also handle this request.  The
handler should respond with an `agent-details` message.

`agent-details <count> <1st agent details> <2nd agent details> ...`

    0008 xx xx        -- count of details being returned
    000a yy yy yy yy  -- id of first agent
    000e ...

  
This message is sent by either the registrar or a manager in response to a `request-agent-details`
message.  The details returned are

- id
- addresses and ports
- standing
- id of manager
- join date (seconds of epoch)
- last contact date (seconds of epoch)
- key

- last update of accounting (seconds of epoch)
- allotment (in bytes)
- usage of allotment (in bytes)
- capacity (in bytes)
- usage of capacity (in bytes)

`request-managers`

This message is sent to the registrar or a manager to obtain the list of managers.  In response,
the handler will send a `manager-details` message.

`manager-details <count> <1st manager details> <2nd manager details>`


Managers inform the registrar when an agent has exhibited a pattern of malicious or unfaithful
behavior, or when a previously problematic agent has recovered.  In turn the registrar informs
other managers.

- `notify-standing-change <id> <state>`

The managers will recommend to the registrar that an agent be ejected when it proves to be
malicious or unfaithful.

- `eject-agent <agent-id> <reason-code>`

The registrar notifies the managers of new agents, and of agent resignations.

- `new-agent <agent-details>`
- `agent-resigned <agent-id>`

## Registrar and All Others

The registrar accepts new members into the pool, handles resignations and ejections from the pool,
acts as the root keyserver, keeps the authoritative list of actors and their standing, and sets
basic policy.

- `accepted <id>`
- `rejected <reason-code>`

## Managers and Indexes

Managers determine which agents will act as indexes, and which ranges they will cover.

- `initiate-index <details>`
- `set-index-range <agent-id-start> <agent-id-end>`
- `terminate-index`


## Managers and Repositories

Managers track usage, allotment, capacity, free space, faithfulness, activity, etc.

- `notify-block-stored <storage-receipt>`
- `notify-block-deleted <deletion-receipt>`
- `notify-block-resized <resize-receipt>`

Managers inform repositories of additions and removals from the set of indexes, changes to index
ranges, additions and removals from the set of monitors, etc.

- `add-indexes <count> <index1> <start1> <end1>...`
- `remove-indexes <count> <index1>...`
- `modify-indexes <count> <index1> <start1> <end1>...`
- `add-monitors <count> <monitor1>...`
- `remove-monitors <count> <monitor1>...`

Managers perform many tasks of the registrar for agents: key services, policy, etc.

- `request-pool-info`
- `pool-info <pool details>`
- `request-actor-info <id>`
- `actor-info <actor details>`
- `notify-standing-change <id> <level>`
- `notify-status-change <id> <status>`

Managers inform agents of changes of standing.

- `update-standing <privilege> <status>`


## Managers and Monitors

Managers determine which agents will be monitors.

- `initiate-monitor <details>`
- `terminate-monitor`

Managers determine which agents a given monitor will cover.

- `set-monitor-range <agent-id-start> <agent-id-end>`

Monitors inform managers when a pattern of malicious or unfaithful behavior is detected.

- `report-problem <agent-id> <reason-code>`


## Indexes and Repositories

Repositories fetch from indexes locations of blocks and random blocks for challenges.

Repositories inform indexes of additions and deletions from storage.  In return indexes provide
signed receipts which are accepted by managers for accounting.

Repositories periodically provide indexes summaries of recent block access.

## Indexes and Other Agents

Agents inform monitors of errors and unusual conditions.

## Repositories and Clients

Repositories provide clients with data.  A repository that has an established relationship with a
client may act as an agent to the pool for the client, storing and deleting data on its behalf.

## Index and Clients

Clients use indexes to find the repositories holding blocks of interest.



Any message issued by an agent that another agent needs for communication with a delegate must be
signed by the issuing agent.

Sizes
 - ids
 - block ids
 - blocks

Actor ids are 4 bytes long.  Block ids are 8 bytes long and consist of the id of the repository
agent which owns the block concatenated with the 4 byte block serial number assigned by the owner
at creation.  Block and actor ids are valid only within their containing pool.  To make a
universal id, the ip address and port of the registrar must be included as well.  On ipv4, this
takes an additional 6 bytes, and on ipv6, 18 bytes, making the maximum length of a universal block
id at 18+8 = 26 bytes.

If a block is at most 64kb long, say, then the maximum amount of storage addressible for a single
owner would be (16 bits + 32 bits = 48 bits) 256 TB.


# Message Format

All numeric values are little endian.

Each message type has a fixed body format.  

## Message Signing

A signed message contains two parts.  The first is the base message; the second is the
signature.  The length of the signature is implicit in the signing algorithm, given by the
registrar, so it is not necessary to include a signature length in the base message.  The base
message is hashed, then encrypted with the caller's private key.  The result is appended to the
base message.  To verify the signature, the recipient decrypts the signature with the public key
of the sender, and then checks that the hash of the base message matches the decrypted signature.

## Pool Protocol version 0.1.0

Pool protocol is id 1, giving the protocol type and version value of 0x01000100.

# Messages

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message type

All messages begin with 4 bytes giving the protocol and protocol version.  The next four bytes are
the message type.  The format following the first 8 bytes is variable and depends on the message
type.


## General Messages

These messages are sent by all agents and delegates and are not specific to any role in the pool.
    
### Hello

    0008: xx xx xx xx -- sender (handler) id
    000c: yy yy yy yy -- session id

Sent by all delegates and agents after accepting a new connection.  Only sent by the handler; only
sent as the first message.

The hello message is sent by the handler once a connection has been initiated.  The caller may
respond with a non-privileged request, or a handshake message if the caller wishes to make a
privileged request.


### Handshake Request

    0008: xx xx xx xx -- sender (caller) id
    000c: yy yy yy yy -- recipient (handler) id
    0010: zz zz zz zz -- session id
    0014: .. .. .. .. -- signature...
    0018: .. .. .. ..

Sent by all actors.  Only sent by the caller.  Sent at most once per session.  Possible responses
are handshake approved or handshake rejected.

The handshake message is sent by the caller to assert identity.  The message contains the ids of
both the handler and caller, as well as the session id that the handler sent in the hello message.
The message must be signed by the caller for it to be accepted.


### Handshake Approved

    0008: xx xx xx xx -- sender (handler) id
    000c: yy yy yy yy -- recipient (caller) id
    0010: zz zz zz zz -- session id
    0014: .. .. .. .. -- signature...
    0018: .. .. .. ..

Sent by all delegates and agents.  Only sent by the caller.  Sent at most once per session.  Sent
in response to a handshake message.

The handshake approved message is sent by the handler in response to a handshake request by the
caller.  If the handler approves the handshake, it returns a similar message to the handshake, in
which it asserts its identity to the caller.  If the handler does not approve, it should send a
handshake denied message.  The message must be signed by the handler.


### Handshake Rejected

    0008: xx xx xx xx -- sender (handler) id
    000c: yy yy yy yy -- recipient (caller) id
    0010: zz zz zz zz -- session id
    0014: ww ww ww ww -- rejection code
    0018: .. .. .. .. -- signature...
    001c: .. .. .. ..

Sent by all delegates and agents.  Only sent by the caller.  Sent at most once per session.  Sent
in response to a handshake message.

Possible rejection codes:
  poor standing
  unknown id
  signature invalid
  sender id mismatch
  recipient id mismatch
  session id mismatch


### Get Pool Details

Can be sent to any delegate or agent.


### Pool Details

    0008: xx xx xx xx -- registrar ipv4 address
    000c: yy yy yy yy -- registrar ipv6 address
    0010: yy yy yy yy
    0014: yy yy yy yy
    0018: yy yy yy yy
    001c: zz zz ww ww -- port; secure port
    0020: cr cr ss ss -- crypto algorithm, key size; signature algorithm, size
    0024: gg gg gg gg -- granularity
    0028: kk kk kk kk -- public key...
    002c: kk kk kk kk

Returned in response to a get pool details message.  If the response comes from an untrusted
source, the registrar listed should be called to check the information.


## Registrar Messages

### Join Pool

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- applicant ipv4 address
    000c: yy yy yy yy -- applicant ipv6 address
    0010: yy yy yy yy
    0014: yy yy yy yy
    0018: yy yy yy yy
    001c: zz zz ww ww -- port; secure port
    0020: kk kk kk kk -- public key...
    0024: kk kk kk kk

Sent to the registrar to join a pool.  If the agent is accepted, the registrar sends and agent new
manager message.


### Agent New Manager

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- agent id
    000c: yy yy yy yy -- primary manager id
    0010: zz zz zz zz -- primary manager ipv4
    0018: ww ww ww ww -- primary manager ipv6
    001c: ww ww ww ww
    0020: ww ww ww ww
    0024: ww ww ww ww
    0028: pp pp ss ss -- port; secure port
    002c: kk kk kk kk -- primary manager's public key...
    0030: kk kk kk kk
    ...
    +000: yy yy yy yy -- 1st alt manager id
    +004: zz zz zz zz -- 1st alt manager ipv4
    +008: ww ww ww ww -- 1st alt manager ipv6
    +00c: ww ww ww ww
    +010: ww ww ww ww
    +014: ww ww ww ww
    +018: pp pp ss ss -- port; secure port
    +01c: kk kk kk kk -- 1st alt manager's public key...
    +020: kk kk kk kk
    ...
    +000: yy yy yy yy -- 2nd alt manager id
    +004: zz zz zz zz -- 2nd alt manager ipv4
    +008: ww ww ww ww -- 2nd alt manager ipv6
    +00c: ww ww ww ww
    +010: ww ww ww ww
    +014: ww ww ww ww
    +018: pp pp ss ss -- port; secure port
    +01c: kk kk kk kk -- 2nd alt manager's public key...
    +020: kk kk kk kk

Sent by the registrar when the agent has been assigned a new manager.




## Repository Messages

The following messages are specific to interactions with a repository.


### Digest Request

    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz ww ww -- offset; length
    0014: ss ss bb bb -- seed; blackout duration (seconds)

A digest request message is sent to a repository to request a cryptographic hash be computed on a
range of bytes of a block stored at the repository.  If the repository has not handled a digest
request with the same block owner, serial, offset, and length recently (i.e., before the
expiration of the blackout period of any prior request matching those values), then it computes
the cryptographic hash of the seed concatenated with the bytes specified and return the result in
a digest result message.  If the block does not exist at this repository, or if the offset and
length are out of range, or if the blackout has not yet expired, then the repository should send
an exception message detailing the failure.


### Digest Result

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 06 00 00 00 -- digest result
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz ww ww -- offset; length
    0014: ss ss dd dd -- seed; digest...
    0018: dd dd dd dd

A digest result message is sent in response to a digest request.  The digest returned will be the
result of a cryptographic hash of the range of the block specified.  The details of the hash used
are given by the registrar of the pool.


### Digest Blackout Active

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz ww ww -- offset; length
    0014: ss ss       -- seed

Sent in response to a digest request when the parameters match a prior request and the blackout
period has not yet expired.


### Block Not Found

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 07 00 00 00 -- block not found
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial

A block not found message is sent if the repository does not hold the block requested.


### Range out of Bounds

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 07 00 00 00 -- block not found
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz ww ww -- range offset; range length
    0014: ll ll       -- block length

A range out of bounds message is sent in response to a digest request when the parameters of the
request specify a range that extends beyond the end of the length of the block.


### Store Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 08 00 00 00 -- store block
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: ll ll .. .. -- block length; block data
    0014: .. .. .. ..

A store block request is sent when the caller wishes to store a block at the handling repository.
If the caller is a repository, then the caller must be the block owner; if the caller is a
delegate, then there is no restriction on the value of the block owner.  If the caller is a
delegate, then the repository will respond with either a store approved message, or an exception,
such as repository full.  If the caller is a repository, then the handling repository should
challenge the caller.  If the caller passes the challenge, then the handling repository should
send a store approved message, otherwise and exception.

If the block already exists on the handler and the length of the new content is less than or equal
to the length of the old, then it should be handled without challenge.  If the new length is
longer, then it should be handled as for an entirely new block.


### Receipt

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0a 00 00 00 -- receipt
    0008: xx xx xx xx -- sender (handler) id
    000c: yy yy yy yy -- recipient (caller) id
    0010: zz zz zz zz -- block owner
    0014: ww ww ww ww -- block serial
    0018: ll ll ss ss -- block length; signature...
    001c: ss ss ss ss

The handling repository is responsible for informing its manager that it has stored a new block.
The handling repository's manager will inform the caller's manager to update the usage of the
caller.


### Block Created

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0c 00 00 00 -- block created
    0008: xx xx xx xx -- tag
    000c: yy yy yy yy -- block owner
    0010: zz zz zz zz -- block serial
    
Sent by a repository acting as the agent of a client in response to the clients create block
message once the block has been created.  Tag is the identifier the client provided in the
create block message.


### Read Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0d 00 00 00 -- read block
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial

Sent to a repository to get the contents of a block.  The repository should send either a block
not found message, or a block content message.


### Read Block Header

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial

Sent to a repository to get the header of a block.  The repository should send either a block
not found message, or a block header message.


### Block content

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0e 00 00 00 -- block content
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz zz zz -- created date (seconds from 1/1/70)
    0014: ww ww ww ww -- last modified date
    0018: ll ll .. .. -- block length; data
    001c: .. .. .. ..
    
Sent in response to a read block message.


### Block Header

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz zz zz -- created date (seconds from 1/1/70)
    0014: ww ww ww ww -- last modified date
    0018: ll ll       -- block length
    
Sent in response to a read block header message.


### Delete Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 10 00 00 00 -- delete block
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial


### Block Deleted

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 11 00 00 00 -- block deleted
    0008: xx xx xx xx -- sender id
    000c: yy yy yy yy -- block owner
    0010: zz zz zz zz -- block serial
    0014: ss ss ss ss -- signature...
    0018: ss ss ss ss

The owner of the block is responsible for informing its manager that the block has been deleted
and should no longer count against its allocation limit.




## Client Messages

The following messages are specific to the interaction between a client and its agent in the pool.


### Create Client Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0b 00 00 00 -- create block
    0008: xx xx xx xx -- tag
    000c: ll ll .. .. -- block length; block data
    0010: .. .. .. ..
    
The create block message is sent by a client to a repository that acts as the clients agent to the
pool.  The tag is an identifier created by the client that will be returned with the block owner
and block serial when the block has been created.


### Update Client Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0f 00 00 00 -- update block
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: ll ll .. .. -- block length; data
    0014: .. .. .. ..


### Client Block Updated

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 0f 00 00 00 -- client block updated
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: ll ll .. .. -- block length


Sent by a client to its agent in the pool to alter the contents of a previously created block.  


### Delete Client Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 10 00 00 00 -- delete block
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial


### Client Block Deleted

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: 10 00 00 00 -- block deleted
    000c: yy yy yy yy -- block owner
    0010: zz zz zz zz -- block serial




## Index Messages

The following messages are specific to interactions with an index.


### Index Add Block 

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    receipt:
    0008: 00 01 00 01 -- pool protocol 0.1.0
    000c: 0a 00 00 00 -- receipt
    0010: xx xx xx xx -- sender (handler) id
    0014: yy yy yy yy -- recipient (caller) id
    0018: zz zz zz zz -- block owner
    001c: ww ww ww ww -- block serial
    0020: ll ll ss ss -- block length; signature...
    0024: ss ss ss ss


### Index Block Added

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- repository
    000c: yy yy yy yy -- block owner 
    0010: zz zz zz zz -- block serial
    0014: ll ll       -- block length


### Index Remove Block 

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    receipt:
    0008: 00 01 00 01 -- pool protocol 0.1.0
    000c: 11 00 00 00 -- block deleted
    0010: xx xx xx xx -- sender id
    0014: yy yy yy yy -- block owner
    0018: zz zz zz zz -- block serial
    001c: ss ss ss ss -- signature...
    0020: ss ss ss ss


### Index Block Removed

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- repository
    000c: yy yy yy yy -- block owner 
    0010: zz zz zz zz -- block serial


### Find Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial

### Block Found

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- block owner
    000c: yy yy yy yy -- block serial
    0010: zz zz       -- host count
    0012: h0 h0 h0 h0 -- host 0 id
    0016: h1 h1 h1 h1 -- host 1 id
    0018: .. .. .. ..

### List Host Storage

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- host id
    000c: yy yy yy yy -- block start
    0010: zz zz       -- block count

Request to list blocks stored on the given agent.

### Host Storage Listing

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- host id
    000c: yy yy yy yy -- block start
    0010: zz zz zz zz -- block count
    0014: w0 w0 w0 w0 -- block 0 owner
    0018: w1 w1 w1 w1 -- block 0 serial

### List Agent Blocks

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- agent id
    000c: yy yy yy yy -- block start
    0010: zz zz       -- block count

Request to list the blocks owned by the given agent.


### Agent Block Listing

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- agent id
    000c: yy yy yy yy -- block start
    0010: zz zz zz zz -- block count
    0014: w1 w1 w1 w1 -- block 0 serial


### Request Challenge Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- repository id

Requests a randomly selected block stored on the given repository such that the block is not owned
by the repository, and the block is at least 1 kb in length.

### Challenge Block Result

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- repository
    000c: yy yy yy yy -- block owner
    0010: zz zz zz zz -- block serial
    0014: ll ll       -- block length



## Manager Messages

### Notify Manager Hosted Block

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    receipt:
    0008: 00 01 00 01 -- pool protocol 0.1.0
    000c: 0a 00 00 00 -- receipt
    0010: xx xx xx xx -- sender (handler) id
    0014: yy yy yy yy -- recipient (caller) id
    0018: zz zz zz zz -- block owner
    001c: ww ww ww ww -- block serial
    0020: ll ll ss ss -- block length; signature...
    0024: ss ss ss ss

Sent by a repository to its manager when it has stored a block on behalf of another.  The manager
should notify other managers as needed and ensure proper usage accounting.


### Notify Manager Usage Reduced

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    receipt:
    0008: 00 01 00 01 -- pool protocol 0.1.0
    000c: 11 00 00 00 -- block deleted
    0010: xx xx xx xx -- sender id
    0014: yy yy yy yy -- block owner
    0018: zz zz zz zz -- block serial
    001c: ss ss ss ss -- signature...
    0020: ss ss ss ss


### Manager New Agent

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- new agent id
    000c: yy yy yy yy -- new agent ipv4 address
    0010: zz zz zz zz -- new agent ipv6 address
    0014: zz zz zz zz
    0018: zz zz zz zz
    001c: zz zz zz zz
    0020: pp pp ss ss -- port; secure port
    0024: kk kk kk kk -- public key...
    0028: kk kk kk kk

Sent by the registrar to a manager 

### Manager Set Agent Id Range

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- id range start (inclusive)
    000c: yy yy yy yy -- id range end (exclusive)


### Manager Remove Agent

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- agent id


### Get Agent Info

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- agent id

Sent to a manager to obtain information about an agent.

### Agent Info

    0000: 00 01 00 01 -- pool protocol 0.1.0
    0004: qq 00 00 00 -- message id
    0008: xx xx xx xx -- agent id
    000c: yy yy yy yy -- manager id
    0010: zz zz zz zz -- standing
    0014: al al al al -- allotment
    0018: ah ah ah ah
    001c: ul ul ul ul -- usage
    0020: uh uh uh uh
    0024: cl cl cl cl -- capacity
    0028: ch ch ch ch
    002c: fl fl fl fl -- free
    0030: fh fh fh fh 
    0034: kk kk kk kk -- public key
    0038: .. .. .. ..


## Promised Capacity and Allotment

When a repository joins the pool, the registrar assigns it to a manager.  The manager introduces
itself to the repository, providing important information about indexes, monitors, etc.  In
response, the repository informs the manager of the quantity of storage offered to the pool.  The
manager uses the timing of these messages to determine approximate network latency for the
repository.  Next, the manager requests to store several blocks of data on the repository, and
checks that the repository satisfies basic requirements.  Lastly, the manager requests bursts of
data from the repository, increasing the size of each burst until it has an estimate of the
approximate effective output limit of the repository.  This last step may be repeated at various
intervals over the course of the first few weeks of service, until a robust estimate of the
repository's response rate and variance is produced.


## Incentives for Indexes

- Increase in allotment by some fixed factor, spread over a time period
- Allow agents to schedule role as index by time of day and day of week
- Auction index role, with agents offering the least allotment increase they would take
- Estimate agent's index value as a function of network latency, throughput, capacity, reliability
- Collect statistics on when indexes are most used.

## Malicious or Unfaithful

- Pro-rate a repository's allotment based on the fraction of storage refusals and failed
  challenges.
- Base allotment is a fraction of offered storage, allowing the extra to be used as incentive for
  monitors and indexes.