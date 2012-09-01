# Properties

## Layers

- storage layer (peers, blocks, allotment, usage)
- object layer (erasure code, encryption, metadata)
- application layer (chat, mail, publishing)

### Storage Layer

- dht
- accounting
- 

Cooperation requires that cheating is not profitable.  Yet for cheating not to be profitable, each
peer's usage must not exceed its allotment, implying that each block stored in the network by a
peer is accountable to that peer.  Even though a block may be an erasure-coded portion of an
encrypted object, there would be a public association between the block and the peer, and
therefore a structural limit to anonymity.  It may be that a peer is acting as an agent for
multiple clients, so that the relationship between the client and the block is not public.


- repository mesh must have accountability
 - implies that repositories can prove they faithfully store data
  - implies that each block has at least two copies in the mesh
  - what storage efficiency is possible w/ erasure coding and 3x to 4x overstorage?
 - implies that capacity and usage can be calculated
 - implies collective behavior that discourages cheating
 - does this imply central registry?
 - can index, monitor, manager tasks be replicated across a dht using multiple hashings?
- 
