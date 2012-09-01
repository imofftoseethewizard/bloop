# Browser Modifications

## Loading encrypted media

### Schema

When an image tag is instantiated to an image element, the constructor requests the content
indicated and waits for the request to complete.  If the request handler were aware that the
content is encrypted (through, say, a new url schema such as 'crypt:' or 'crypts:'), then the
handler could delay delivery of the content until the cryptographic algorithm and keys were
provided.  Once decrypted, the content would arrive, and to the rest of the renderer, it would
seem as if there were a network delay.

The handler, being a part of a semantically low-level operation, is probably best contained as a
member of a higher level abstraction relating to cryptography, and when an encrypted resource is
found, simply notifies its parent or owner of the resource's url, and provides access to the
encrypted content and a receiver for the decrypted content.  The higher level abstraction may also
encompass a set of cryptographic utilities (key generation, hashing, encryption/decryption,
entropy-based random number generation, etc...); these utilities would then be near their point of
use. Futher the higher level abstraction needs to present an interface to the script engine,
offering the encryption utilities, and a means to provide keys to decrypt waiting content.

A related issue is file upload. XHR may need a modification to allow the client to specify
encryption. Similarly, form-based upload may also need extension.