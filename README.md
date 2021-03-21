# flutter_apod

A simple flutter application featuring Astronomy Picture Of the Day NASA API.

This app showcase:
 - A simple ViewModel approach with ChangeNotifier with a separated repository layer 
   (à la clean/hexagonal architecture)
 - Injecting dependency with provider
 - Running ViewModel test with simulated time with `FakeAsync`. 
   So the correct behavior of the ViewModel is tested in a deterministic fashion.
 - Displaying an "infinite scroll" grid of images  

This toy app allowed to uncover a bug in Flutter 2.0.3 :
There is a socket leak every time an image cannot be loaded 
(when an non ok http code is returned). 
This app has missing days, so a lot of 404 is returned when fetching images.
Over time too many sockets are kept opened, and no more requests can be performed.

## Getting Started

Just launch the app with :

```
flutter run
```

To exhibit the socket leak, run the app and scroll to the bottom, 
at the end it will have a lot of 404 (files not yet uploaded). 
At some point no more request can be perfomed, and fails with (on iOS):

```
dnssd_clientstub deliver_request: socketpair failed 24 (Too many open files)
```

