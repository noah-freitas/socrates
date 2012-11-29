Socrates
========

Features
========
Offline first, "static" content management
------------------------------------------
All lessons and other static course content are stored client-side using
lawnchair.  Offline data storage is automatically synced with your server
store when a network connection is available.

Live student interaction
------------------------
Student work submissions are fed into the app live.  Watch students interact
with each other's work in realtime via: live chat, streaming forums, shared
live-edited documents, and response snippets.

Close integration with content providers
----------------------------------------
The first version of Socrates will be tightly integrated with Github.  This
integration will be modularized so that any data provider can be easily
integrated by a third party.  This integration will extend into the live
and persistent data channels in a plugin architecture that requires no more
than 6 api functions for core functionality.

Simple user management
----------------------
All users are identified by email address, and default Socrates authentication
is handled by Mozilla Persona.
