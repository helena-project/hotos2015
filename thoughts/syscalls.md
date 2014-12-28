## System Calls

  * `subscribe` registers a callback for an event. An application has at most
    one subscription to an event at a time. Invoking `subscribe` for an event
    that an app is already subsribes to replaces the previous callback with the
    new one.

  * `wait` yields execution to the kernel until events the app has registered
    for are ready to fire. When an event is fired, the kernel invokes the
    corresponding callback in the application

  * `command` yields execution to a driver to perform some functionality (like
    toggling a GPIO pin) and potentially returns a value to the application
    (i.e. polling the current value of a GPIO pin).
