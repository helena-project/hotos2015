# Execution Model

Tock uses a cooperative, run-to-completion, event-based execution model. Each app
only has a single thread of execution (unlike processes which may be interrupted
by signals). Apps communicate with the kernel by registering callbacks for
particular events. When an app yields (either explicitly using the
`wait_callback` system call, or implicitly by unwiding it's stack completely),
the OS schedules event-callbacks to execute by pushing a new stack frame in the
app. When a callback returns, it returns to the call-point of `wait_callback`.

The Tock OS can run multiple apps simultaneousy, each with its own isolated
memory. For hardware resources that are shared by apps, the OS mediates access
through a system-call interface. Other hardware can be assigned directly to a
particular app, in which case, the app may have direct access to that hardware
through memory registers. For example, the SAM4L has four USARTs -- USART3 is
reserved for STDIO, but others can be assigned for apps dedicated to interfacing
with particular hardware.

App code segments are loaded onto internal flash, alongside the operating
system. On device boot, the OS initializes each app in turn. The initialization
process happens in two steps. First, the OS allocates a segment of memory for
each application's stack, heap and data segments. Next, the app's `initialize`
function is invoked. The `initialize` function can register interest in
particular events, e.g. real or virtualized hardware interrupts like input from
standard-in or an alarm. Specifically, an app subscribes using a the `subscribe`
system call, which takes a namespaced event stream name, a callback function,
and any number of event specific arguments.

