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


### ORM and DB

Sqlite3 makes a nice db for small projects, and is easy to manage.  MySql and Postgres are better
for larger systems with concurrency.  The general dev path is to start with Sqlite3 and transition
to one of the others when necessary.  So... that implies the work of making the ORM somewhat
flexible.

What needs do we have in an orm?

- Map db row to property.
- Map db relation rows to property.
- Store changed back to db.
 - are per-property changes required?
- Ensure db has correct tables.
- Create tables from properties
- properties
 - db-js translation
 - auto-load collections
  - client's application keys


Client Table

- id (rowid)
- external id (hash of public key)
- public key
- allotment
- usage
- default object size limit

Session Table

- id (rowid)
- external id (hash of rowid + salt)
- client id
- expiration

Object Table

- id (rowid)
- external id (hash of rowid + salt)
- owner
- size
- limit
- content
