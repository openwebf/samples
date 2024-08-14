# JSRuntime Thread Mode

This demo illustrates the JSRuntime management in WebF with different threading modes. There are three threading models:

1. Flutter UI Thread.
2. Different dedicated Thread (Different Dedicated threads are used for different WebFPage).
3. Same dedicated Thread (Same Dedicated threads are used for different WebFPage).

For more information about `Dedicated Thread Mode`, see the [documentation](https://openwebf.com/docs/tutorials/performance_optimization/multiple_thread_mode/#sharing-a-single-thread-across-multiple-webf-instances).

And the demo can test two ways to launch a new FlutterEngine:

1. Create a FlutterEngine using FlutterEngineGroup.
2. Create a FlutterEngine directly.


# How to use

Just run it like a normal flutter project.

# How to debug

1. Change the webf dependency in `pubspec.yaml` to a local path.
2. View the creation and destruction logs of JSRuntime on different threads. (Refer to [the test code](https://github.com/openwebf/webf/commit/1b30372558b4b7d4556a0451618dbf3e2250955e))

If we use the webf test code above, interact with the test page as follows: 
 
1. On the home page click the button "FlutterEngineGroup (supported iOS/Android) ". 
2. Click the button "Different dedicated thread" on the new page. 
3. The Webf test page loads successfully Back to the home page.

We can see the following Log:


```
[JSRuntime Lifecycle] threadId 0x16c8e3000 DartIsolateContext construction
[JSRuntime Lifecycle] threadId 0x3090cb000 InitializeJSRuntime Begin
[JSRuntime Lifecycle] threadId 0x3090cb000 InitializeJSRuntime Done
[JSRuntime Lifecycle] threadId 0x3090cb000 FinalizeJSRuntime Begin
[JSRuntime Lifecycle] threadId 0x3090cb000 FinalizeJSRuntime Done
[JSRuntime Lifecycle] threadId 0x16c8e3000 FinalizeJSRuntime Begin
[JSRuntime Lifecycle] threadId 0x16c8e3000 FinalizeJSRuntime Fail. runtime_ == nullptr
```

This indicates that neither the DartIsolateContext construct nor the destructor creates the JSRuntime.