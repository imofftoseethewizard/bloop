Database Model
==============

Sqlite3 will be the underlying database. While a system like MySql or Postgres would allow for
higher concurrency, the data naturally shard along each client.  There is no reason for a
## Entities

- object
- client
- application
- relay
- queue
- queue item
- connection
- capability
- transaction

### Client

##### Properties

- id
- external id
- public key
- privilege
- admin key
- public queue id
- allotment
- max queues
- max relays
- max connections
- usage
- email address

##### Collections

- applications
- objects (probably too big to instantiate efficiently)
- queues
- relays
- connections (possibly too big to instantiate efficiently)

### Object

##### Properties

- id
- external id
- storage location
- size*
- size limit*
- created
- last modified*



Collections
- client
 - applications
 - objects
 - queues
 - relays
 - connections

- object
 - access grants

- relay
 - access grants
 - connections

- queue
 - access grants
 - queue items

- connection
 - access grants

- transaction
 - locked objects
 - held objects
 - added objects
 - removed objects


