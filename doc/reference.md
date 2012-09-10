## HTTP API Reference

Response bodies are in JSON format.

### Open Issues


- Would it be useful for `<transaction id>/commit` to return the list of resources that were changed?
- What should the format of the websocket API summaries be?


### TODO

##### Access Control Lists

An access control list is an array of objects with the following members `clientId`,
`applicationId`, `deviceId`, `granted`, and `revoked`.  If `applicationId` or `deviceId` is
provided, then `clientId` will also be provided.  If none of the ids are provided then `revoked`
will not be provided either, and the access controls given apply to unauthorized sessions.
`granted` and `revoked` are comma-delimited lists of capabilities.  At least one of the two must
be specified.  The capabilities in the two lists are disjoint, though is is permissible, for
example, to grant `signal` and revoke `signal-delete`.

##### Device ID

Specify device id protocol.  Consider cases for lost devices.


##### Notifications

A socket-based notification service from the server to subscribing clients.  This would allow a
client to know when a queue had been changed without polling.  This would also give the an
administrative application better monitoring ability.

Notification scenarios:


API

    socket /<resource type>/notify? 
          condition=<condition>&
          [client-id=<client id>&]
          [application-id=<application id>]


    wss://example.com/object/notify?condition=delete&client-id=ADE0-0CB24

    wss://example.com/queue/0034-3342-0459-4893/notify?condition=new-post
          
    socket /<resource type>/<resource id>/notify?condition=<condition>

where condition is one of 

    new
    change
    delete
    listen
    connect
    accept
    join
    drop
    close

Capabilities:

    POST* /client/<client id>/access

    notify-new
    notify-change
    notify-delete
    access-notify-new
    access-notify-change
    access-notify-delete

    POST* /<resource type>/<resource id>/access

    notify-change
    notify-delete
    notify-listen
    notify-connect
    notify-accept
    notify-join
    notify-drop
    notify-close
    access-notify-change
    access-notify-delete
    access-notify-listen
    access-notify-connect
    access-notify-accept
    access-notify-join
    access-notify-drop
    access-notify-close


##### Enumeration

An administrative application needs to be able to enumerate resources.  Selection should be by
type, application, size, dates of creation and modification, access control, etc.


##### Post Item

Describe the content of a post item.


##### Resource Metadata

Define the API to get the number of items in a queue, and the size of a queue.

Define the API to get metadata about an object: create time, modification time, size.


##### Rename Object

"Object" is an awkward name to use in Javascript for anything other than the predefined Object
object.  Something that evokes its opacity would be best.



##### Example Websocket API

Add a websocket api in the examples section.


### Reference Format

The reference format is described below by example.


#### Simple GET API

    GET /about/contact
    ----
    { name, [emailAddress], [phoneNumber] }
    

This API returns an object will have between one and three members.  In the description, it may be
noted that at least one of the optional parameters is required.  The path fragment indicates the
location of the API relative to the server's root.  If the server was bound to
`http://example.com/foo`, then the address of this API would be
`http://example.com/foo/about/contact`.


#### Simple POST API

    POST* /object/new[?transaction=<transaction id>]
    <content>
    ----
    objectId
    unauthorized
    quota exceeded

The asterisk near the verb indicates that this API must be requested via HTTPS.  This API takes
one optional parameter which will be referred to in the description as "transaction id".  It also
accepts a post body referred to as "content".  This API also may return the error conditions
listed after the response descriptor.  See the Errors section for details.


#### Simple DELETE API

    DELETE* /queue/<queue id>?[transaction=<transaction id>]
    ----
    <empty>
    queue not found

This API has a variable path portion referred to in the description as "queue id".  If the API is
successful, it will have an empty response body, otherwise it will return the "not found" error.


#### Complex POST API

    POST* /object/<object id>/permit? 
          client-id=<client id>& 
          [application-id=<application id>&] 
          [grant=<permissions granted>&] 
          [revoke=<permissions revoked>&] 
          [inherit=<permissions inherited>&]
    <empty>
    ----
    <empty>
    object not found
    unknown client
    unknown capability


### Generic Resource APIs

All resources have four APIs in common: `new`, `delete`, `access`, and `default/access`.  The
syntax of each of these is identical across all resource types.  Any differences in semantics will
be discussed in the respective resource section.

#### Creating a Resource

    POST* /<resource type>/new[?transaction=<transaction id>]
    <content>
    ----
    <resource id>
    unauthorized
    quota exceeded

Access control for the resource will be initialized with defaults for the resource type associated
with the authentication class of the session.

If a transaction id is provided, then the new resource is associated with the specified
transaction.  Until the transaction is either rolled back or commited, the resource will exist,
but will not be available to any other session.  If the transaction is rolled back, the resource
will be deleted.


#### Deleting a Resource

    DELETE* /<resource type>/<resource id>[?transaction=<transaction id>]
    ----
    <empty>
    unauthorized
    resource not found

If a transaction id is provided, then the resource id must have been provided to the begin
transaction request, either as resource held or blocked.  The resource will be deleted when the
transaction is committed.


#### Changing Access Control

    POST* /<resource type>/<resource id>/access?
          [client-id=<client id>&]
          [application-id=<application id>&] 
          [device-id=<device id>&]
          [grant=<comma-separated list of capabilities>&] 
          [revoke=<comma-separated list of capabilities>&] 
          [inherit=<comma-separated list of capabilities>] 
    <empty>
    ----
    <empty>
    resource not found
    unknown client
    unknown capability

This API is used to grant or revoke access rights to a resource.

The client id and application id give the security domain.  Both are omitted then the security
domain is the same as that of the current session.  If the client id is present but the
application id is omitted, then the security domain consists of the client's sessions.  If the
client id is omitted but the application id is present, then the security domain consists of the
sessions of the current client for the given application.  If the client id is specified as `*`,
then the application id must be omitted and the security domain is the unauthorized domain.

Each resource type defines a list of capability types.  The capabilities granted, revoked, and
inherited are comma-separated lists of these identifiers.  The identifier `all` may be used to
indicate all capabilities.

If a matching security descriptor is not found in the resource's access control list entry, an
empty one is created.  The references to capabilities specified as inherited are removed from the
entry.  Revocations are added for those specified as revoked, and any conflicting grants are
removed.  Finally, grants are added for those specified as granted, and any conflicting
revocations are removed.  If the resulting entry is empty, then it is deleted.


#### Changing Default Access Control

    POST* /<resource type>/default/access?
          [client-id=<client id>&]
          [application-id=<application id>&] 
          [grant=<comma-separated list of capabilities>&] 
          [revoke=<comma-separated list of capabilities>&] 
          [inherit=<comma-separated list of capabilities>] 
    <empty>
    ----
    <empty>
    unknown client
    unknown application
    unknown capability

This API is very similar to that used to change access control on a particular resource, except
that the changes here refer to the defaults given to new resources.  Essentially, this provides
access to the access control list prototype for the given resource type.



### General and Administrative

Resource urls have the following three forms:

    /<category>/<id>/<method>?<parameters>
    /<category>/<id>
    /<category>/<method>


#### About

    GET /about
    ----
    { cryptographyDescriptor,
      publicKey,
      contact,
      softwareName,
      softwareVersion,
      softwareOrigin
    }
      
The `cryptographyDescriptor` is a dictionary containing three members: `pairType`,
`symmetricType`, and `hashType`.  Each of these is a string, describing the public-private key
pair algorithm used, the symmetric key algorithm used, and the hash function used, respectively.
Public key is a string representing the public key half of the key pair associated with the
server; the type of the key pair is given by the pair type in the cryptography descriptor.
Contact information, such as email addresses, phone numbers, hosting provider, etc are in the
`contact` dictionary.  The remaining members indicate the name of the software, its version, and
its author(s) or publisher.



#### Register Key

    POST /client/register
    <public half of the client's key>
    ----
    <client id>
    invalid key
    id hash collision


A client that wishes to use APIs requiring authentication must register with the server.  The
server should use an algorithm for computing a client's id from its key.  A cryptographic hash is
suggested.  The length of the id and the algorithm for computing it should be chosen so that id
collisions essentially never occur.  In the case of a collision, the server should refuse to
register the key and indicate that there was a hash collision; additionally, the server should
notify the administrators that a hash collision has occurred.  Otherwise, the server should send
the id to the client in the body of the response.  The server should make an entry in its database
linking the client's key to the id.


#### Set Quota

    POST* /client/<client id>/set-quota?storage-limit=<storage limit>

The session must be authorized with system privileges.

Sets the client's storage limit.  The storage limit is presumed to be in bytes.  It may also be
specified in KB, MB, GB or TB.  Fractions are allowed.  All objects, keys, queues, and metadata
count against the client's quota.  Clients with zero quota or with excessive usage may not
create new resources, and system administrators may place further restrictions.


#### Administrative Key

    POST* /client/admin-key
    <public half of the administrative key pair>
    ----
    <administrative application id>
    unauthorized
    invalid key
    
    
A client with an admin key can support mulitple security domains (such as to support the browser's
same origin policy).  Once the public admin key is set, it can only be changed in a session
validated with the private admin key, and in fact, in such a session, all APIs are permitted on
all resources owned by the client. 


#### Register Application Key

    POST* /client/register-application
    <public half of the application key pair>
    ----
    <application id>
    unauthorized
    invalid key
    id hash collision

The default new resource capabilities for sessions associated with this application will be copied
from the default new resource capabilities for general authorization sessions.
    

#### Session Authentication

    POST* /session/new
    <empty>
    ----
    <session id>

 
A client that wishes to use APIs requiring authentication must request a session id.  The server
should ensure that the session id is neither guessable, nor a repeat of recent session id.  It
returns the session id to the client in the body of the response.

To sign in, the client must create a string containing its id, '#', and the session id; it must
compute the hash of the string, and then encrypt the hash with its private key.

    POST* /session/sign?
          client-id=<client id>&
          session-id=<session id>&
          [application-id=<application id>&]
          signature=<signature>
    <empty>
    ----
    <empty>
    invalid signature

If successful, the server puts a session cookie on the client; the value of the cookie is
encrypted and contains details about the session, client, and connection.   If not successful,
then the client should respond with some indication of the failure.


#### Register Queue

    POST* client/register-queue?queue-id=<queue id>
    <empty>
    ----
    <empty>
    unauthorized
    not found

If the client wishes to have a public message queue, then it should create a message queue,
provide it with an unauthorized post capability, and call this api to register it. Other clients
that might wish to send an unsolicited message may find the queue by inquiring with either the
client's id or public key.


#### Client Inquiry

    GET /client/<id>
    ----
    { id, publicKey, publicQueue }
    not found

or

    GET /client?public-key=<public key>
    ----
    { id, publicKey, publicQueue }
    not found



### Transaction Support

It is expected that clients will build higher level semantics over the protocol that this server
supports. There will be calls to resource modification APIs that must either all succeed or all
fail.

Note that these transactions are not ACID, but are more a kind of long running transaction where
the intermediate changes of state are visible to other clients.  Instead, these APIs provide the
capability to easily recover from composite operations with potentially inconsistent intermediate
states.  Care should be taken that modifications are performed in an order such that other clients
do not compromise private data, or lose or damage data.

All of the object APIs that modify stored data may optionally include a transaction parameter

    POST https://.../object/new?transaction=<transaction id>

indicating that the call should be included in the specified transaction.


#### Begin Transaction

    POST* begin-transaction?
         [timeout=<seconds>&]
         [hold-list=<comma delimited list of object ids>&]
         [block-list=<comma delimited list of object ids>]
    <empty>
    ----
    <transaction id>
    unauthorized

The server begins a transaction for this client.  The transaction id is returned in the response
body, and the transaction is only valid for the session in which it was created.  This objects
specified in the hold list will be non-modifiable by other clients for the duration of the
transaction.  The objects specified in the lock list will be neither modifiable, nor readable; the
server should provide an error that is distinct from unauthorized. The timeout gives the time the
server will wait between API calls for this transaction before unilaterally rolling it back; the
server has a minimum allowable timeout, a maximum allowable, and a default; the specified timeout
is clamped to the server's allowable range.  A transaction is completed either by a rollback or
commit.

The client may only modify or delete files that are held or blocked by the transaction. Newly
created files will be in the blocked state until the transaction is commited.


#### Rollback Transaction

    POST* /rollback?transaction=<transaction id>
    <empty>
    ----
    <empty>
    unauthorized
    transaction already committed
    transaction already rolled back
    no such transaction
    

The server reverses all of the changes since the last call to being transaction.  The server's
response indicates whether or not there was an active transaction.  The transaction cookie is
cleared.


#### Commit

    POST* /commit?transaction=<transaction id>
    <empty>
    ----
    <empty>
    unauthorized
    transaction already committed
    transaction already rolled back
    no such transaction
    

The server releases all of the locked objects and returns.  The transaction cookie is cleared.



### Objects

Objects are opaque binary data.  All non-public content should be encrypted, as all objects have
implicit global read permission.

#### Capabilities

Objects provide the following capabilities:

    delete
    modify
    replace
    update
    limit
    access-delete
    access-modify
    access-replace
    access-update
    access-limit
    access


#### Standard Methods

    POST* /object/new
    POST* /object/default/access
    POST* /object/<object id>/access
    DELETE* /object/<object id>


#### Object Modification

    POST* /object/<object id>/modify?hash=<hash>[&transaction=<transaction id>]
    <content>
    ----
    <hash>
    unauthorized
    not found
    quota exceeded
    hash mismatch


Modification means an incremental change to an object.  The caller must provide a hash of the last
version of the object it received from the server.  The object is replaced by the given content
only if the given hash matches the hash of the object currently stored on the server.


#### Object Replacement

    POST* /object/<object id>/replace[?transaction=<transaction id>]
    <content>
    ----
    <content>
    unauthorized
    not found
    quota exceeded

Replacement replaces the content of object with the content given, returning the prior content.


#### Object Update

    POST* /object/<object id>/update[?transaction=<transaction id>]
    <content>
    ----
    <empty>
    unauthorized
    not found
    quota exceeded

Update changes the content of the object.


#### Object Duplication

    POST* /object/copy/<object id>[?transaction=<transaction id>]
    <empty>
    ----
    <empty>
    unauthorized
    not found
    quota exceeded

A client may copy an object, obtaining a new object id.  This is identical in behavior to a
combination of read and create, but is much more efficient.


#### Object Size Limit

    POST* /object/<object id>/limit?content-length=<content length>
    <empty>
    ----
    <empty>
    unauthorized
    not found


#### Object Default Size Limit

    POST* /object/default/limit?content-length=<content length>
    <empty>
    ----
    <empty>
    unauthorized


### Keys

Keys are kept as a distinct type from objects because of major differences in their importance and
access patterns.  An object might be accessed by any number of clients, and while some objects may
be application state, it is expected that most will be content with limited distribution:
messages, forum posts, blog entries, etc.  A key on the other hand, is generally only accessed by
its owner, and only infrequently, perhaps only as often as the application launches.  Objects are
readable by everyone and available over unsecured http, while keys are (by default) readable by no
one but the owner and require a secure connection.  Furthermore, keys are immutable and are given
an id based a hash of their value.


#### Capabilities

    delete
    get
    access-delete
    access-get
    access


#### Standard Methods

    POST /key/new
    POST* /key/default/access
    POST* /key/<key id>/access
    DELETE* /key/<key id>


#### Retrieving a Key

    GET* /key/<key id>
    ----
    <encrypted key>
    unauthorized
    not found

Unlike the retrieval method for objects, this one requires HTTPS and authentication.


### Queues

Queues are designed to support various types of message services: email, forums, blogs, etc: a
queue that is readable only by its owner and writable by everyone supports an unsolicited email
inbox; a queue that is readable only by its owner and writable by a specified group supports an
email inbox for friends, family, and associates; a queue that has global read permission but only
the owner may write to would be something like a blog or twitter; a queue that has selected read
permission and only owner write permission would be a private distribution of a blog; a queue that
has read and write permission given to a select set could be a forum or a Facebook wall.

Queue entries in general expire after a limited amount of time; this allows the server to keep the
queue size manageable, though the time to live is entirely up to the owner.  The owner may disable
the expiration of entries and manage the queue directly using flush.

Queue creation, deletion, and the setting of limits and permission all require authentication.
Post, read, and flush may require authentication, depending on the queue's permissions.


#### Capabilities

    delete
    post
    read
    flush
    limit
    access-delete
    access-post
    access-read
    access-flush
    access-limit
    access


#### Standard Methods

    POST /queue/new
    POST* /queue/default/access
    POST* /queue/<queue id>/access
    DELETE* /queue/<queue id>


#### Posting

    POST* /queue/<queue id>
    <content>
    ----
    <empty>
    unauthorized
    queue not found
    queue full
    post too large
    quota exceeded


#### Reading Posts from a Queue

    GET* /queue/<queue id>?
         [start=<start index>&]        
         [end=<end index>&]        
         [start-date=<start date>&]        
         [end-date=<end date>&]
         [count=<count>]
    ----
    <array of posts>
    unauthorized
    queue not found


#### Flushing Posts from a Queue

    POST* /queue/<queue id>/flush?
          [start=<start index>&]        
          [end=<end index>&]        
          [start-date=<start date>&]        
          [end-date=<end date>&]
          [count=<count>]
    <empty>
    ----
    <array of posts>
    unauthorized
    queue not found

This is similar to reading from the queue, but the posts returned are removed from the queue.


#### Setting Queue Limits

    POST* /queue/<queue id>/limit?
          [queue-length=<queue length>&]
          [post-count=<post count>&]
          [post-length=<post length>&]
          [post-residency=<post residency>]
    <empty>
    ----
    <empty>
    unauthorized
    queue not found
    invalid queue length
    invalid post count
    invalid post length
    invalid post residency

The queue length gives the maximum length of the queue.  If there is no unit applied, it is
presumed to be in bytes.  Units may be specified as 'kb', 'mb', or 'gb'; case is ignored.  By
default, the queue length is 100K; queues may not have unlimited length.

Post count is another way to limit the total size of the queue.  By default there is no limit to
the number of posts; setting post count to zero indicates unlimited posts.

Post length is specified similarly to queue length.  By default post length is 256 bytes.

Post residency is the length of time a post will be available.  After expiration, posts are
dropped from the queue.  Duration units may be specified as 's', 'min', 'h', 'd', 'w', or 'y', for
seconds, minutes, hours, days, weeks, and years, respectively.  Specify 'none' or 0 to indicate
that posts do not expire.


### Relays

Relays are designed to support chat-like services, that is, low latency exchanges between two or
more clients.  Clients connect to the relay and are allowed to read or write or both, depending on
the access granted by the relay's owner.  Relays also provide a signal connection which notifies
listeners of connections, disconnections, message writes and reads, and other changes of state.


#### Standard Resource APIs

    POST*   /relay/default/limit
    POST*   /relay/default/access
    POST*   /relay/new
    DELETE* /relay/<relay id>
    POST*   /relay/<relay id>/drop
    POST*   /relay/<relay id>/limit  
    POST*   /relay/<relay id>/access

#### Limits

    POST* /relay/default/limit?
            [connections-per-client=<connections per client>&]
            [connections-per-application=<connections per application>&]
            [connections-per-device=<connections per device>&]
            [message-length=<message length>&]
            [history-length=<history length>]
    <empty>
    ----
    ok
    unauthorized
    invalid value


    POST* /relay/<relay id>/limit?
            [connections-per-client=<connections per client>&]
            [connections-per-application=<connections per application>&]
            [connections-per-device=<connections per device>&]
            [message-length=<message length>&]
            [history-length=<history length>]
    <empty>
    ----
    ok
    not found
    unauthorized
    invalid value


The number of connections to a relay may be limited for a given client, application, or device.
The values given must be either a positive integer or `unlimited`.  Initial defaults are for
clients and devices to be allowed unlimited connections, but applications only one.

Messages can be limited to a maximum length; the default is `none`.  Setting the message length to
zero drops all connections and temporarily disables future connections.  The relay can be
re-enabled by setting the message length to a non-zero value.

History length gives the number of messages that will be kept in the history.  The history is used
by the reflection APIs `received` and `sent`.


#### Reflection

    GET* /relay/default/limit

Returns an object containing members `connectionsPerClient`, `connectionsPerApplication`,
`connectionsPerDevice`, `messageLength` (in bytes) and `historyLength` which describes the limits
given to new relays.


    GET* /relay/default/access?
           [client-id=<client id>&]
           [application-id=<application id>&]
           [device-id=<device id>]

Returns the access control list given to new relays for the specified client, application, or
device.  If none of the parameters are given, then the full access control list will be returned.


    GET* /relay/<relay id>/limit

Similar to `GET* /relay/default/limit`, except that it applies to a specific relay.


    GET* /relay/<relay id>/access

Similar to `GET* /relay/default/access`, except that it applies to a specific relay.


    GET* /relay/<relay id>/clients

Returns a list of all clients currently connected.  Each item in the list is an object with
members `clientId` and optionally `applicationId` or `deviceId`.  Either one or both of
`applicationId` or `deviceId` may be omitted.


    GET* /relay/<relay id>/received
           [count=<count>&]
           [start-index=<start index>&]
           [start-date=<start date>&]
           [end-date=<end date>&]
           [client-id=<client id>&]
           [application-id=<application id>&]
           [device-id=<device id>]
    ----
    <message receipts>
    unauthorized
    not found

    GET* /relay/<relay id>/sent?
           [count=<count>&]
           [start-index=<start index>&]
           [start-date=<start date>&]
           [end-date=<end date>&]
           [client-id=<client id>&]
           [application-id=<application id>&]
           [device-id=<device id>]
    ----
    <message sent records>
    unauthorized
    not found

Message sent records and message receipts both contain the client id of the sender (`sender`) or
recipient (`recipient`) of the message, as well as the time it was received/sent (`timestamp`),
and a hash of the message contents (`messageHash`).

To limit the number of items returned, specify a `count`.  The default is 10; to get all
available, specify `all`.  `start-index` is used to specify the first item returned.  Normally,
items are returned, newest first, until count has been fulfilled.  To obtain later items, specify
a start index.  `start-date` and `end-date` are used to request items with timestamps in a limited
range.

#### Messages

    socket  /relay/<relay id>/

A client may connect to the relay if it has either read or write access.  The server relays
messages written to the relay to all connected clients with read access.


#### Signals

    socket  /relay/<relay id>/signal
  
A client may connect to the relay's signals if it has access to at least one signal.  The server
sends to each client only those signals to which it has access.

Each signal is an object with at least three members.  They type of the signal (`type`), the time
of the triggering event (`timestamp`), the id of the client which requested the triggering event
(`clientId`), and the id of the subject relay (`relayId`).  Signals may also include the id of the
application (`applicationId`) or the device (`deviceId`) if the respective qualifications were
authenticated for the triggering session. Additional members specific to each signal type provide
further details.

The signals for `delete`, `connect`, `disconnect`, and `drop` have no further members. `received`
and `sent` also include the hash of the subject message content (`messageHash`).  Signals for
`limit` provide additional members which are identical to those returned by `GET* \relay\<relay
id>\limit`.  Signals for `access` have additional members corresponding to the arguments given to the
triggering request: `subjectClientId`, `subjectApplicationId`, `subjectDeviceId`, `granted`,
`revoked`, and `inherited`.


##### Relay Capabilities

    delete
    read
    write
    drop
    list
    get-clients
    get-received
    get-sent
    get-limit
    get-access
    get
    signal-delete
    signal-connect
    signal-disconnect
    signal-received
    signal-sent
    signal-drop
    signal-limit
    signal-access
    signal
    access-delete
    access-read
    access-write
    access-drop
    access-list
    access-get-clients
    access-get-received
    access-get-sent
    access-get-limit
    access-get-access
    access-get
    access-signal-delete
    access-signal-connect
    access-signal-disconnect
    access-signal-received
    access-signal-sent
    access-signal-drop
    access-signal-limit
    access-signal-access
    access-signal
    access


### Errors