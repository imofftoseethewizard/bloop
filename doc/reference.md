## HTTP API Reference

Response bodies are in JSON format.

### Open Issues


- Would it be useful for `<transaction id>/commit` to return the list of resources that were changed?
- What should the format of the websocket API summaries be?


### TODO

##### Devices

Write examples showing proper handling of multiple devices.

##### API Format

A more structured api description, less dependent on HTTP syntax.


##### Access Control Lists

An access control list is an array of objects with the following members `client`,
`application`, `device`, `granted`, and `revoked`.  If `application` or `device` is
provided, then `client` will also be provided.  If none of the ids are provided then `revoked`
will not be provided either, and the access controls given apply to unauthorized sessions.
`granted` and `revoked` are comma-delimited lists of capabilities.  At least one of the two must
be specified.  The capabilities in the two lists are disjoint, though is is permissible, for
example, to grant `signal` and revoke `signal::delete`.


##### Enumeration

An administrative application needs to be able to enumerate resources.  Selection should be by
type, application, size, dates of creation and modification, access control, etc.


##### Post Item

Describe the content of a post item.


##### Resource Metadata

Define the API to get the number of items in a queue, and the size of a queue.

Define the API to get metadata about an block: create time, modification time, size.


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

    POST* /block/new[?transaction=<transaction id>]
    <content>
    ----
    block id
    unauthorized
    quota exceeded

The asterisk near the verb indicates that this API must be requested via HTTPS.  This API takes
one optional parameter which will be referred to in the description as "transaction id".  It also
accepts a post body referred to as "content".  This API also may return the error conditions
listed after the response descriptor.  See the Errors section for details.

#### Complex POST API

    POST* /block/<block id>/access? 
          client=<client id>& 
          [application=<application id>&] 
          [device=<device id>&] 
          [grant=<permissions granted>&] 
          [revoke=<permissions revoked>&] 
          [inherit=<permissions inherited>&]
    <empty>
    ----
    <empty>
    block not found
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

    POST* /<resource type>/<resource id>/delete[?transaction=<transaction id>]
    ----
    <empty>
    unauthorized
    resource not found

If a transaction id is provided, then the resource id must have been provided to the begin
transaction request, either as resource held or locked.  The resource will be deleted when the
transaction is committed.


#### Changing Access Control

    POST* /<resource type>/<resource id>/access?
          [client=<client id>&]
          [application=<application id>&] 
          [device=<device id>&]
          [grant=<comma-separated list of capabilities>&] 
          [revoke=<comma-separated list of capabilities>&] 
          [inherit=<comma-separated list of capabilities>] 
    <empty>
    ----
    <empty>
    resource not found
    unknown client
    unknown application
    unknown device
    unknown capability

This API is used to grant or revoke access rights to a resource.

The client id and application id give the security domain.  Both are omitted then the security
domain is the same as that of the current session.  If the client id is present but the
application id is omitted, then the security domain consists of the client's sessions.  If the
client id is omitted but the application id is present, then the security domain consists of the
sessions of the current client for the given application.  If the client id is specified as `*`,
then the application id must be omitted and the security domain is the unauthorized domain.

TODO: devices

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
          [client=<client id>&]
          [application=<application id>&] 
          [device=<device id>&]
          [grant=<comma-separated list of capabilities>&] 
          [revoke=<comma-separated list of capabilities>&] 
          [inherit=<comma-separated list of capabilities>] 
    <empty>
    ----
    <empty>
    unknown client
    unknown application
    unknown device
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

    POST* /client/<client id>/setQuota?storageLimit=<storage limit>

The session must be authorized with system privileges.

Sets the client's storage limit.  The storage limit is presumed to be in bytes.  It may also be
specified in KB, MB, GB or TB.  Fractions are allowed.  All blocks, keys, queues, and metadata
count against the client's quota.  Clients with zero quota or with excessive usage may not
create new resources, and system administrators may place further restrictions.


#### Administrative Key

    POST* /client/adminKey
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

    POST* /client/registerApplication
    <public half of the application key pair>
    ----
    <application id>
    unauthorized
    invalid key
    id hash collision

The default new resource capabilities for sessions associated with this application will be copied
from the default new resource capabilities for general authorization sessions.
    

#### Revoke Application Key

    POST* /client/revokeApplication?application=<application id>
    <empty>
    ----
    ok
    unauthorized
    not found

Access to all resources by sessions authenticated by the given application will be immediately
terminated, including all signal and relay connections.  No resources will be removed, but some
may become inaccessible except by use of the administrative key.


#### Register Device Key

    POST* /client/registerDevice
    <public half of the device key pair>
    ----
    <device id>
    unauthorized
    invalid key
    id hash collision

The primary use of device keys is to provide a separate authority domain for each device a user
owns.  This enables access to resources to be selectively granted to different devices, and allows
a user to cancel the access of a lost device.
    

#### Revoke Device Key

    POST* /client/revokeDevice?device=<device id>
    <empty>
    ----
    ok
    unauthorized
    not found

Access to all resources by sessions authenticated by the given device will be immediately
terminated, including all signal and relay connections.  No resources will be removed, but some
may become inaccessible except by use of the administrative key.


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
          session=<session id>&
          client=<client id>&
          clientSignature=<client signature>&
          [application=<application id>&]
          [applicationSignature=<application signature>&]
          [device=<device id>&]
          [deviceSignature=<device signature>]
    <empty>
    ----
    <empty>
    invalid signature

If successful, the server puts a session cookie on the client; the value of the cookie is
encrypted and contains details about the session, client, and connection.   If not successful,
then the client should respond with some indication of the failure.


#### Register Queue

    POST* client/registerQueue?queue=<queue id>
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

    GET /client?publicKey=<public key>
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

All of the block APIs that modify stored data may optionally include a transaction parameter

    POST https://.../block/new?transaction=<transaction id>

indicating that the call should be included in the specified transaction.


#### Begin Transaction

    POST* beginTransaction?
         [timeout=<seconds>&]
         [holdList=<comma delimited list of block ids>&]
         [lockList=<comma delimited list of block ids>]
    <empty>
    ----
    <transaction id>
    unauthorized

The server begins a transaction for this client.  The transaction id is returned in the response
body, and the transaction is only valid for the session in which it was created.  The blocks
specified in the hold list will be non-modifiable by other clients for the duration of the
transaction.  The blocks specified in the lock list will be neither modifiable, nor readable; the
server should provide an error that is distinct from unauthorized. The timeout gives the time the
server will wait between API calls for this transaction before unilaterally rolling it back; the
server has a minimum allowable timeout, a maximum allowable, and a default; the specified timeout
is clamped to the server's allowable range.  A transaction is completed either by a rollback or
commit.

The client may only modify or delete files that are held or locked by the transaction. Newly
created files will be in the locked state until the transaction is commited.


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
    

The server releases all of the locked blocks and returns.  The transaction cookie is cleared.



### Blocks

A block is an individually addressible and globally transparent datum.  Blocks provide
access-controlled creation, modification, deletion, and signal emission.  Each class of
authenticating session has a separate default access control list for new blocks, and default
content length limits.

Blocks are globally transparent, meaning that anyone who has the address of the block may read its
contents.  Therefore, all confidential material must be encrypted before it is stored in a block.
This policy has two aims: the first is to reduce the random-access latency that would be required
to set up an HTTPS session and validate a client against the access control list of the block; the
second is to encourage application authors to encrypt content.

Blocks may be created either by requesting that submitted content be saved as a block, or by
requesting that an already existing block be copied.  Blocks may be modified in a specific,
restricted sense: the server will change the block content only if the requesting client provides
a hash which matches a hash of the current block contents.  Blocks may be replaced, where the
server changes the content of the block, and responds with the prior content.  Blocks may be
updated, in which case the requesting client is neither required to provide a hash, nor is
provided the prior contents.  Blocks may be deleted.

Block ids may be queried by id range, by date of creation, by date of last modification, and by
originating device or application.

The length of a block's content can be limited.  There is a global limit that applies to all
blocks owned by the client.  Changes to the global limit do not force compliance of existing
blocks, but may cause subsequent errors if the block is later modified, replaced, or updated.
Each block also has an individual content limit.  Initially a block's content limit is taken from
the default block limit associated with the authentication of the current session, that is, there
are distinct default block content limits for all possible tuples of (client, device, and
application).  Furthermore the client has a storage quota, and operations which increase the
client's storage on the server &mdash; such as creating or changing blocks &mdash; may cause an
error.

The access control list for a new block is copied from the default access control list for the
authenticating session.  Much like block content limits, each distinct tuple of (client, device,
and application) has a distinct default access control list.  See the section on Access Control
for specifics.


#### Channels

Blocks provide two kind of channels.  There is the global channel at <span class="identifier">/block/signal</span>,
and block-specific channels at <span class="identifier">/block/&lt;block id&gt;/signal</span>.  The server sends
notifications of changes of state &mdash; signals &mdash; on these channels.  The global channel
carries signals which are not specific to any one block; the specific channels carry signals which
were triggered by changes of state to a block.


<table class="method">
<tr><td class="method-name">socket /block/signal
<tr><td class="heading">Description

<tr><td class="paragraph">This is intended to be the listening point for the administrative
application, to allow it to have real-time updates of changes to the client's objects.

</table>


<table class="method">
<tr><td class="method-name">socket /block/&lt;block id&gt;/signal
<tr><td class="heading">Description

<tr><td class="paragraph">If the block id is <span class="identifier">all</span>, then the server will send all
signals about all blocks that the session's authentication allows.


</table>

#### Methods

There are several distinct classes of methods: there are methods to create, change, and delete
blocks; there are methods to control the length of blocks, and to control access to blocks; and
there are methods to get information about blocks or the content of blocks.

#### Create, Change, and Delete Methods
<!------------------------------------------------------------------------------
  New
-->
<table class="method">
<tr><td class="method-name">secure POST /block/new
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">transaction               <td>transaction id, optional
</table>

<tr><td class="heading">Body
<tr><td class="paragraph">Content of new block.

<tr><td class="heading">Response
<tr><td class="paragraph">Identifier of new block.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">QuotaExceeded
<tr class="error"><td class="identifier">NoSuchTransaction
</table>

<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::created
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">Creates a new block and stores the content of the request body in it.
The block will be given default limits and access control based on the authentication of the
requesting session.  If a transaction is included, then the new block is added to the locked set
of transaction.

</table>


<!------------------------------------------------------------------------------
  Copy
-->

<table class="method">
<tr><td class="method-name">secure POST /block/copy
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">block                     <td>block id
<tr class="parameter"><td class="identifier">transaction               <td>transaction id, optional
</table>

<tr><td class="heading">Response
<tr><td class="paragraph">Block id of new block containing content from the specified block.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">NotFound
<tr class="error"><td class="identifier">QuotaExceeded
<tr class="error"><td class="identifier">NoSuchTransaction
</table>

<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::created
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">sourceBlock          <td>source block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">This method copies the specified block, creating a new block with its
contents.  It returns the id of the new block.  If a transaction is included, then the new block
is added to the locked set of transaction.

</table>


<!------------------------------------------------------------------------------
  Modify
-->

<table class="method">
<tr><td class="method-name">secure POST /block/&lt;block id&gt;/modify
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">hash                      <td>hash of extant block content
<tr class="parameter"><td class="identifier">transaction               <td>transaction id, optional
</table>

<tr><td class="heading">Body
<tr><td class="paragraph">New content of block.

<tr><td class="heading">Response
<tr><td class="paragraph">Hash of new content as a string.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">NotFound
<tr class="error"><td class="identifier">QuotaExceeded
<tr class="error"><td class="identifier">HashMismatch
<tr class="error"><td class="identifier">NoSuchTransaction
<tr class="error"><td class="identifier">TransactionFault
</table>

<tr><td class="heading">Signal
<tr><td class="paragraph">This method emits two signals:
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::modified
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
<tr class="member"><td class="identifier">priorHash            <td>hash of prior content
</table>

<tr><td class="paragraph">and

<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::changed
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
<tr class="member"><td class="identifier">priorHash            <td>hash of prior content
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">The value of the hash parameter must match the hash of the content
currently stored in the object.  If the hashes do not match, then a hash mismatch error is
returned. If the new content is longer than the old, and if the increase would exceed the client's
quota, then a quota exceeded error is returned. If a transaction is supplied, and if the subject
block is not held or locked by the transaction, then a transaction fault error is returned.
Otherwise, the content is updated with the request body, and the response body contains the hash
of the new content.

</table>



<!------------------------------------------------------------------------------
  Replace
-->

<table class="method">
<tr><td class="method-name">secure POST /block/&lt;block id&gt;/replace
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">transaction               <td>transaction id, optional
</table>

<tr><td class="heading">Body
<tr><td class="paragraph">New content of block.

<tr><td class="heading">Response
<tr><td class="paragraph">Prior content of block.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">NotFound
<tr class="error"><td class="identifier">QuotaExceeded
<tr class="error"><td class="identifier">NoSuchTransaction
<tr class="error"><td class="identifier">TransactionFault
</table>

<tr><td class="heading">Signal
<tr><td class="paragraph">This method emits two signals:
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::replaced
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
<tr class="member"><td class="identifier">priorHash            <td>hash of prior content
</table>

<tr><td class="paragraph">and

<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::changed
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
<tr class="member"><td class="identifier">priorHash            <td>hash of prior content
</table>

<tr><td class="heading">Description <tr><td class="paragraph">If the new content is longer than
the old, and if the increase would exceed the client's quota, then a quota exceeded error is
returned. If a transaction is supplied, and if the subject block is not held or locked by the
transaction, then a transaction fault error is returned.  Otherwise, the content is updated with
the request body, and the response body contains the prior content of the block.  The server will
also send a <span class="identifier">block::replaced</span> message over the block's signal channel; the message will
contain the block id, the authentication details of the requesting session, the length of the new
content, the hash of the new content, and the the hash of the old content.

</table>



<!------------------------------------------------------------------------------
  Update
-->

<table class="method">
<tr><td class="method-name">secure POST /block/&lt;block id&gt;/update
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">transaction               <td>transaction id, optional
</table>

<tr><td class="heading">Body
<tr><td class="paragraph">New content of block.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">NotFound
<tr class="error"><td class="identifier">QuotaExceeded
<tr class="error"><td class="identifier">NoSuchTransaction
<tr class="error"><td class="identifier">TransactionFault
</table>


<tr><td class="heading">Signal
<tr><td class="paragraph">This method emits two signals:
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::updated
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
<tr class="member"><td class="identifier">priorHash            <td>hash of prior content
</table>

<tr><td class="paragraph">and

<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::changed
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
<tr class="member"><td class="identifier">length               <td>content length
<tr class="member"><td class="identifier">hash                 <td>hash of content
<tr class="member"><td class="identifier">priorHash            <td>hash of prior content
</table>
<tr><td class="heading">Description

<tr><td class="paragraph">If the new content is longer than the old, and if the increase would
exceed the client's quota, then a quota exceeded error is returned. If a transaction is supplied,
and if the subject block is not held or locked by the transaction, then a transaction fault error
is returned.  Otherwise, the content is updated with the request body.

</table>


<!------------------------------------------------------------------------------
  Delete
-->

<table class="method">
<tr><td class="method-name">secure POST /block/&lt;block id&gt;/delete
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">transaction               <td>transaction id, optional
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">NotFound
<tr class="error"><td class="identifier">NoSuchTransaction
<tr class="error"><td class="identifier">TransactionFault
</table>


<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::deleted
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id
</table>

<tr><td class="heading">Description <tr><td class="paragraph">If a transaction is supplied, and if
the subject block is not held or locked by the transaction, then a transaction fault error is
returned.  Otherwise, the specified block is deleted.

</table>


#### Limit and Access Methods


<!------------------------------------------------------------------------------
  Global Limit
-->

<table class="method">
<tr><td class="method-name">secure POST /block/limit
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">contentLength               <td>maximum allowable
content length
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
</table>

<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::limited
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">limit                <td>block length limit
<tr class="member"><td class="identifier">priorLimit           <td>prior block length limit
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">This method sets the maximum length of all blocks without a specified
content length, or which have a maximum content length of <span class="identifier">inherit</span>.  Blocks may be
longer only if they have been specifically given a longer maximum length.  Extant blocks which
inherit maximum content length are not checked to be in compliance, and if they are not, the
violation might not be discovered until a client attempts to change one of them. The length may be
specified in KB, MB, or GB (case insensitive).  Decimal numbers are parsed, and the result is
rounded to the nearest byte, so that <span class="identifier">contentLength=0.3kb</span> would limit content to 307
bytes, while <span class="identifier">contentLength=0.7kb</span> would limit content to 717 bytes.
</table>


<!------------------------------------------------------------------------------
  Block Limit
-->

<table class="method">
<tr><td class="method-name">secure POST /block/&lt;block id&gt;/limit
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">contentLength               <td>maximum allowable
content length
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">NotFound
</table>

<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::limited
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id, or <span class="identifier">default</span>
<tr class="member"><td class="identifier">limit                <td>block length limit
<tr class="member"><td class="identifier">priorLimit           <td>prior block length limit
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">This method limits the maximum length of the block's content; if the
block id is <span class="identifier">default</span> then the change applies to the default maximum content length
applied to blocks created in sessions with the same authentication details.  It primarily affects
the methods which modify block content: modify, replace, and update.  If the content length
specified is <span class="identifier">none</span>, then any prior limit is removed; if it is <span class="identifier">inherit</span>,
then the limit is taken from the global block limit.  If the length is specified without units, it
is presumed to be bytes. The length may be specified in KB, MB, or GB (case insensitive).  Decimal
numbers are parsed, and the result is rounded to the nearest byte, so that
<span class="identifier">contentLength=0.3kb</span> would limit content to 307 bytes, while
<span class="identifier">contentLength=0.7kb</span> would limit content to 717 bytes.
</table>


<!------------------------------------------------------------------------------
  General Access
-->

<table class="method">
<tr><td class="method-name">secure POST /block/access
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">application          <td>subject application id, optional
<tr class="parameter"><td class="identifier">device               <td>subject device id, optional
<tr class="parameter"><td class="identifier">inherit              <td>capabilities inherited, optional
<tr class="parameter"><td class="identifier">grant                <td>capabilities granted, optional
<tr class="parameter"><td class="identifier">revoke               <td>capabilities revoked, optional
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">ResourceNotFound
<tr class="error"><td class="identifier">DeviceNotSpecified
<tr class="error"><td class="identifier">UnknownApplication
<tr class="error"><td class="identifier">UnknownDevice
<tr class="error"><td class="identifier">UnknownCapability
</table>

<tr><td class="heading">Capabilities
<tr><td><table class="capabilities">
<tr class="capability"><td class="identifier">new
<tr class="capability"><td class="identifier">list
<tr class="capability"><td class="identifier">limit
<tr class="capability"><td class="identifier">signal::new
<tr class="capability"><td class="identifier">signal::limit
<tr class="capability"><td class="identifier">signal
<tr class="capability"><td class="identifier">access::new
<tr class="capability"><td class="identifier">access::list
<tr class="capability"><td class="identifier">access::limit
<tr class="capability"><td class="identifier">access::signal::new
<tr class="capability"><td class="identifier">access::signal::limit
<tr class="capability"><td class="identifier">access::signal
<tr class="capability"><td class="identifier">access
</table>

<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::access
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">inherited            <td>inherited capabilities list
<tr class="member"><td class="identifier">granted              <td>granted capabilities list
<tr class="member"><td class="identifier">revoked              <td>revoked capabilities list
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">This method changes the access control for two other block methods:
creating a new block, and changing the global block content length limit.  It cannot grant
capabilities to other clients, but can restrict the use of the methods to device- or device- and
application-authenticated sessions.  If device is not specified, then application must not be
specified; if device is specified, then application may be specified.  Both grant and revoke are
comma or whitespace (or both) delimited lists of capabilities.  Capabilites inherited are removed
from the granted and revoked sets in the matching access control entry, then capabilities granted
are added to the granted set and removed from the revoked set, and finally capabilites revoked are
added to the revoked set and removed from the granted set.

</table>


<!------------------------------------------------------------------------------
  Specific Access
-->

<table class="method">
<tr><td class="method-name">secure POST /block/&lt;block id&gt;/access
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">client               <td>subject client id, optional
<tr class="parameter"><td class="identifier">application          <td>subject application id, optional
<tr class="parameter"><td class="identifier">device               <td>subject device id, optional
<tr class="parameter"><td class="identifier">inherit              <td>capabilities inherited, optional
<tr class="parameter"><td class="identifier">grant                <td>capabilities granted, optional
<tr class="parameter"><td class="identifier">revoke               <td>capabilities revoked, optional
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">ResourceNotFound
<tr class="error"><td class="identifier">ClientNotSpecified
<tr class="error"><td class="identifier">DeviceNotSpecified
<tr class="error"><td class="identifier">UnknownClient
<tr class="error"><td class="identifier">UnknownApplication
<tr class="error"><td class="identifier">UnknownDevice
<tr class="error"><td class="identifier">UnknownCapability
</table>

<tr><td class="heading">Capabilities
<tr><td><table class="capabilities">
<tr class="capability"><td class="identifier">delete
<tr class="capability"><td class="identifier">modify
<tr class="capability"><td class="identifier">replace
<tr class="capability"><td class="identifier">update
<tr class="capability"><td class="identifier">limit
<tr class="capability"><td class="identifier">signal::delete
<tr class="capability"><td class="identifier">signal::modify
<tr class="capability"><td class="identifier">signal::replace
<tr class="capability"><td class="identifier">signal::update
<tr class="capability"><td class="identifier">signal::change
<tr class="capability"><td class="identifier">signal::limit
<tr class="capability"><td class="identifier">signal::access
<tr class="capability"><td class="identifier">signal
<tr class="capability"><td class="identifier">access::delete
<tr class="capability"><td class="identifier">access::modify
<tr class="capability"><td class="identifier">access::replace
<tr class="capability"><td class="identifier">access::update
<tr class="capability"><td class="identifier">access::limit
<tr class="capability"><td class="identifier">access::signal::delete
<tr class="capability"><td class="identifier">access::signal::modify
<tr class="capability"><td class="identifier">access::signal::replace
<tr class="capability"><td class="identifier">access::signal::update
<tr class="capability"><td class="identifier">access::signal::change
<tr class="capability"><td class="identifier">access::signal::limit
<tr class="capability"><td class="identifier">access::signal::access
<tr class="capability"><td class="identifier">access::signal
<tr class="capability"><td class="identifier">access
</table>

<tr><td class="heading">Signal
<tr><td><table class="members">
<tr class="member"><td class="identifier">type                 <td class="identifier">block::access
<tr class="member"><td class="identifier">client               <td>authenticated client id
<tr class="member"><td class="identifier">application          <td>authenticated application id
<tr class="member"><td class="identifier">device               <td>authenticated device id
<tr class="member"><td class="identifier">block                <td>block id, or <span class="identifier">default</span>
<tr class="member"><td class="identifier">inherited            <td>inherited capabilities list
<tr class="member"><td class="identifier">granted              <td>granted capabilities list
<tr class="member"><td class="identifier">revoked              <td>revoked capabilities list
</table>

<tr><td class="heading">Description
<tr><td class="paragraph">This method changes the control list for the specified block; the
defaults for newly created blocks can be changed by specifiying <span class="identifier">default</span> instead of a
block id. If no client is specified, then both application and device must not be specified as
well.  If client is specified, then device or device and application may be specified. Both grant
and revoke are comma or whitespace (or both) delimited lists of capabilities.  Capabilites
inherited are removed from the granted and revoked sets in the matching access control entry, then
capabilities granted are added to the granted set and removed from the revoked set, and finally
capabilites revoked are added to the revoked set and removed from the granted set.

</table>

#### Block Reflection, Content, and Metadata



<!------------------------------------------------------------------------------
  Get Block Contents
-->

<table class="method">
<tr><td class="method-name">GET /block/&lt;block id&gt;

<tr><td class="heading">Response
<tr><td class="paragraph">The content of the block.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">ResourceNotFound
</table>

<tr><td class="heading">Description

<tr><td class="paragraph">

</table>


<!------------------------------------------------------------------------------
  Block Metadata
-->

<table class="method">
<tr><td class="method-name">GET /block/&lt;block id&gt;/meta

<tr><td class="heading">Response
<tr><td class="paragraph">An object giving details about the block.
<tr><td><table class="members">
<tr class="member"><td class="identifier">createDate           <td>date block was created
<tr class="member"><td class="identifier">lastModifiedDate     <td>date block was last modified
<tr class="member"><td class="identifier">length               <td>length of block in bytes
<tr class="member"><td class="identifier">hash                 <td>hash of block content
<tr class="member"><td class="identifier">device               <td>originating device id, owner sessions only
<tr class="member"><td class="identifier">application          <td>originating application id, owner sessions only
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">ResourceNotFound
</table>

<tr><td class="heading">Description
<tr><td class="paragraph"> This method provides roughly the equivalent of <span class="identifier">HEAD
/block/&lt;block id&gt;</span>.  The returned object 

</table>


<!------------------------------------------------------------------------------
  List Block Ids
-->

<table class="method">
<tr><td class="method-name">secure GET /block/list
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">application          <td>subject application id, optional
<tr class="parameter"><td class="identifier">device               <td>subject device id, optional
<tr class="parameter"><td class="identifier">startIndex           <td>non-negative integer, optional
<tr class="parameter"><td class="identifier">endIndex             <td>non-negative integer, optional
<tr class="parameter"><td class="identifier">count                <td>positive integer, optional
<tr class="parameter"><td class="identifier">startId              <td>block id or block id prefix, optional
<tr class="parameter"><td class="identifier">endId                <td>block id or block id prefix, optional
<tr class="parameter"><td class="identifier">startChangeDate      <td>date or duration relative to now, optional
<tr class="parameter"><td class="identifier">endChangeDate        <td>date or duration relative to now, optional
<tr class="parameter"><td class="identifier">startCreateDate      <td>date or duration relative to now, optional
<tr class="parameter"><td class="identifier">endCreateDate        <td>date or duration relative to now, optional
</table>

<tr><td class="heading">Response
<tr><td class="paragraph">An array of block ids.

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">DeviceNotSpecified
<tr class="error"><td class="identifier">UnknownApplication
<tr class="error"><td class="identifier">UnknownDevice
<tr class="error"><td class="identifier">UnknownCapability
</table>

<tr><td class="heading">Description

<tr><td class="paragraph">

</table>


<!------------------------------------------------------------------------------
  General Access Reflection
-->

<table class="method">
<tr><td class="method-name">secure GET /block/access
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">application          <td>subject application id, optional
<tr class="parameter"><td class="identifier">device               <td>subject device id, optional
<tr class="parameter"><td class="identifier">capability           <td>a general block capability, optional
</table>

<tr><td class="heading">Response
<tr><td class="paragraph">An array of access control entry objects:
<tr><td><table class="members">
<tr class="member"><td class="identifier">client          <td>subject client id
<tr class="member"><td class="identifier">application     <td>subject application id
<tr class="member"><td class="identifier">device          <td>subject device id
<tr class="member"><td class="identifier">granted         <td>granted capabilities list
<tr class="member"><td class="identifier">revoked         <td>revoked capabilities list
</table>

<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">DeviceNotSpecified
<tr class="error"><td class="identifier">UnknownApplication
<tr class="error"><td class="identifier">UnknownDevice
<tr class="error"><td class="identifier">UnknownCapability
</table>

<tr><td class="heading">Description

<tr><td class="paragraph">

</table>


<!------------------------------------------------------------------------------
  Specific Access Reflection
-->

<table class="method">
<tr><td class="method-name">secure GET /block/&lt;block id&gt;/access
<tr><td class="heading">Parameters
<tr><td><table class="parameters">
<tr class="parameter"><td class="identifier">client               <td>subject client id, optional
<tr class="parameter"><td class="identifier">application          <td>subject application id, optional
<tr class="parameter"><td class="identifier">device               <td>subject device id, optional
<tr class="parameter"><td class="identifier">capability           <td>a specific block capability, optional
</table>

<tr><td class="heading">Response
<tr><td class="paragraph">An array of access control entry objects:
<tr><td><table class="members">
<tr class="member"><td class="identifier">client          <td>subject client id
<tr class="member"><td class="identifier">application     <td>subject application id
<tr class="member"><td class="identifier">device          <td>subject device id
<tr class="member"><td class="identifier">granted         <td>granted capabilities list
<tr class="member"><td class="identifier">revoked         <td>revoked capabilities list
</table>


<tr><td class="heading">Errors
<tr><td><table class="errors">
<tr class="error"><td class="identifier">Unauthorized
<tr class="error"><td class="identifier">ClientNotSpecified
<tr class="error"><td class="identifier">DeviceNotSpecified
<tr class="error"><td class="identifier">UnknownClient
<tr class="error"><td class="identifier">UnknownApplication
<tr class="error"><td class="identifier">UnknownDevice
<tr class="error"><td class="identifier">UnknownCapability
</table>

<tr><td class="heading">Description

<tr><td class="paragraph">

</table>

<style>
h1, h2, h3, h4, h5, h6, p, tr, td { font-family: sans-serif }
h6 { margin-bottom: -13; margin-left: 20pt }
table.method { margin-top: 20pt; padding: 0.5em; }
td.method-name { font-family: monospace; font-weight: bold; font-size: 120% }
td.heading { padding-left: 20pt; padding-top: 0.5em; font-weight: bold }
span.identifier, td.identifier { font-family: monospace; font-weight: bold }
tr.parameter table { width: 100% }
td.paragraph { padding-left: 40pt  }
table.capabilities, table.errors, table.members, table.parameters, table.signals { margin-left: 40pt }
table.capabilities td, table.errors td, table.members td, table.parameters td, table.signals td { padding-right: 20pt }
</style>


### Keys

Keys are kept as a distinct type from blocks because of major differences in their importance and
access patterns.  An block might be accessed by any number of clients, and while some blocks may
be application state, it is expected that most will be content with limited distribution:
messages, forum posts, blog entries, etc.  A key on the other hand, is generally only accessed by
its owner, and only infrequently, perhaps only as often as the application launches.  Blocks are
readable by everyone and available over unsecured http, while keys are (by default) readable by no
one but the owner and require a secure connection.  Furthermore, keys are immutable and are given
an id based a hash of their value.


#### Capabilities

    delete
    get
    access::delete
    access::get
    access


#### Standard Methods

    POST /key/new
    POST* /key/default/access
    POST* /key/<key id>/access
    POST* /key/<key id>/delete


#### Retrieving a Key

    GET* /key/<key id>
    ----
    <encrypted key>
    unauthorized
    not found

Unlike the retrieval method for blocks, this one requires HTTPS and authentication.


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
    access::delete
    access::post
    access::read
    access::flush
    access::limit
    access


#### Standard Methods

    POST /queue/new
    POST* /queue/default/access
    POST* /queue/<queue id>/access
    POST* /queue/<queue id>/delete


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
         [startDate=<start date>&]        
         [endDate=<end date>&]
         [count=<count>]
    ----
    <array of posts>
    unauthorized
    queue not found


#### Flushing Posts from a Queue

    POST* /queue/<queue id>/flush?
          [start=<start index>&]        
          [end=<end index>&]        
          [startDate=<start date>&]        
          [endDate=<end date>&]
          [count=<count>]
    <empty>
    ----
    <array of posts>
    unauthorized
    queue not found

This is similar to reading from the queue, but the posts returned are removed from the queue.


#### Setting Queue Limits

    POST* /queue/<queue id>/limit?
          [queueLength=<queue length>&]
          [postCount=<post count>&]
          [postLength=<post length>&]
          [postResidency=<post residency>]
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

    POST* /relay/default/limit
    POST* /relay/default/access
    POST* /relay/new
    POST* /relay/<relay id>/delete
    POST* /relay/<relay id>/limit  
    POST* /relay/<relay id>/access

#### Limits

    POST* /relay/default/limit?
            [connectionsPerClient=<connections per client>&]
            [connectionsPerApplication=<connections per application>&]
            [connectionsPerDevice=<connections per device>&]
            [messageLength=<message length>&]
            [historyLength=<history length>]
    <empty>
    ----
    ok
    unauthorized
    invalid value


    POST* /relay/<relay id>/limit?
            [connectionsPerClient=<connections per client>&]
            [connectionsPerApplication=<connections per application>&]
            [connectionsPerDevice=<connections per device>&]
            [messageLength=<message length>&]
            [historyLength=<history length>]
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

#### Dropping a Connection

    POST* /relay/<relay id>/drop

#### Reflection

    GET* /relay/default/limit

Returns an object containing members `connectionsPerClient`, `connectionsPerApplication`,
`connectionsPerDevice`, `messageLength` (in bytes) and `historyLength` which describes the limits
given to new relays.


    GET* /relay/default/access?
           [client=<client id>&]
           [application=<application id>&]
           [device=<device id>]

Returns the access control list given to new relays for the specified client, application, or
device.  If none of the parameters are given, then the full access control list will be returned.


    GET* /relay/<relay id>/limit

Similar to `GET* /relay/default/limit`, except that it applies to a specific relay.


    GET* /relay/<relay id>/access

Similar to `GET* /relay/default/access`, except that it applies to a specific relay.


    GET* /relay/<relay id>/clients

Returns a list of all clients currently connected.  Each item in the list is an object with
members `client` and optionally `application` or `device`.  Either one or both of
`application` or `device` may be omitted.


    GET* /relay/<relay id>/received
           [count=<count>&]
           [startIndex=<start index>&]
           [startDate=<start date>&]
           [endDate=<end date>&]
           [client=<client id>&]
           [application=<application id>&]
           [device=<device id>]
    ----
    <message receipts>
    unauthorized
    not found

    GET* /relay/<relay id>/sent?
           [count=<count>&]
           [startIndex=<start index>&]
           [startDate=<start date>&]
           [endDate=<end date>&]
           [client=<client id>&]
           [application=<application id>&]
           [device=<device id>]
    ----
    <message sent records>
    unauthorized
    not found

Message sent records and message receipts both contain the client id of the sender (`sender`) or
recipient (`recipient`) of the message, as well as the time it was received/sent (`timestamp`),
and a hash of the message contents (`messageHash`).

To limit the number of items returned, specify a `count`.  The default is 10; to get all
available, specify `all`.  `startIndex` is used to specify the first item returned.  Normally,
items are returned, newest first, until count has been fulfilled.  To obtain later items, specify
a start index.  `startDate` and `endDate` are used to request items with timestamps in a limited
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
(`client`), and the id of the subject relay (`relay`).  Signals may also include the id of the
application (`application`) or the device (`device`) if the respective qualifications were
authenticated for the triggering session. Additional members specific to each signal type provide
further details.

The signals for `delete`, `connect`, `disconnect`, and `drop` have no further members. `received`
and `sent` also include the hash of the subject message content (`messageHash`).  Signals for
`limit` provide additional members which are identical to those returned by `GET* \relay\<relay
id>\limit`.  Signals for `access` have additional members corresponding to the arguments given to the
triggering request: `subjectClient`, `subjectApplication`, `subjectDevice`, `granted`,
`revoked`, and `inherited`.


##### Relay Capabilities

    delete
    read
    write
    drop
    list
    get::clients
    get::received
    get::sent
    get::limit
    get::access
    get
    signal::delete
    signal::connect
    signal::disconnect
    signal::received
    signal::sent
    signal::drop
    signal::limit
    signal::access
    signal
    access::delete
    access::read
    access::write
    access::drop
    access::list
    access::get::clients
    access::get::received
    access::get::sent
    access::get::limit
    access::get::access
    access::get
    access::signal::delete
    access::signal::connect
    access::signal::disconnect
    access::signal::received
    access::signal::sent
    access::signal::drop
    access::signal::limit
    access::signal::access
    access::signal
    access


### Errors