import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var engineGroup: FlutterEngineGroup?
    var flutterEngines: [Int: FlutterEngine] = [:]
    var flutterEngineCount: Int = 0
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example.flutter/new_engine", binaryMessenger: controller.binaryMessenger)
        
        engineGroup = FlutterEngineGroup(name: "engine_group", project: nil)
        
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
            if call.method == "newFlutterEngine" {
                    self?.createNewEngine()
                    result(nil)
                } else if call.method == "newFlutterEngineWithoutFlutterEngineGroup" {
                    // 执行相应操作
                    self?.createNewEngineWithoutGroup()
                    result(nil)
                } else if call.method == "newDoubleEngine" {
                    // 执行相应操作
                    self?.newDoubleEngine()
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func createNewEngineWithoutGroup() {
        let flutterEngine = FlutterEngine()
        flutterEngine.run(withEntrypoint: "mainWithoutNewEngine")

        GeneratedPluginRegistrant.register(with: flutterEngine)
        let flutterVC = WebFFlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        window?.rootViewController?.present(flutterVC, animated: true, completion: nil)
        
        flutterEngineCount+=1
        flutterEngines[flutterEngineCount] = flutterEngine
        flutterVC.flutterEngineId = flutterEngineCount
        flutterVC.deinitHandler = { [self] (value) in
            destoryEngine(engineId: value)
        }
    }
    
    private func createNewEngine() {
        let newEngine = engineGroup?.makeEngine(withEntrypoint: "mainWithoutNewEngine", libraryURI: nil)
        if ((newEngine) != nil) {
            GeneratedPluginRegistrant.register(with: newEngine!)
        }
        let flutterVC = WebFFlutterViewController(engine: newEngine!, nibName: nil, bundle: nil)
        window?.rootViewController?.present(flutterVC, animated: true, completion: nil)
    }
    
    private func newDoubleEngine() {
        let newEngine1 = engineGroup?.makeEngine(withEntrypoint: "mainDoubleEngine", libraryURI: nil)
        if ((newEngine1) != nil) {
            GeneratedPluginRegistrant.register(with: newEngine1!)
        }
        let newEngine2 = engineGroup?.makeEngine(withEntrypoint: "mainDoubleEngine", libraryURI: nil)
        if ((newEngine2) != nil) {
            GeneratedPluginRegistrant.register(with: newEngine2!)
        }
        let flutterVC = WebFDoubleFlutterViewController(engine1: newEngine1!, engine2: newEngine2!)
        window?.rootViewController?.present(flutterVC, animated: true, completion: nil)
    }
    
    private func destoryEngine(engineId: Int) {
        let flutterEngine = flutterEngines[engineId]
        flutterEngine?.destroyContext();
        flutterEngines.removeValue(forKey: engineId)
    }
}
