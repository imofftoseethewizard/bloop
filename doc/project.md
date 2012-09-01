Objective
---------

To create a framework for applications which
 - provide unified state over multiple devices
 - run all logic on the client
 - use servers only as storage or communication proxies
 - ensure private data is never transmitted or saved externally in plaintext
 - implemented in html5/javascript, nodejs, python, objective-C on Windows, OS/X, and linux.

### Unified State

A users data should be automatically and synchronized across devices.  Each non-addressable device
must (and addressable devices are encouraged to) keep a copy of the user's data locally.  In
addition to enable device synchronization, each user should have either one addressable device
that is constantly connected to the network, or should use a remote storage solution.

### Logic Restricted to Client

To ensure privacy, a user's data must not exist in plaintext outside of the devices of authorized
users, and therefore, any manipulation of the content of that data must occur on those devices.

### Role of Servers

Since a third-party server is not authorized to view a user's private data, the only functions
left are the storage and transmission of data.  Constantly connected servers store user's data for
loss protection (redundancy and distribution), synchronization of devices, high-latency
communication (eg, email), and achival.  They can also provide relay services so that non-addressable
devices &mdash; such as an html client on a computer behind a firewall &mdash; can act as an
addressable peer to another client.

### Private Data

