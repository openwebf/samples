import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    var flutterEngineCount: Int = 0
    var flutterEngines: [Int: FlutterEngine] = [:]

    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
                
        let channel = FlutterMethodChannel(name: "com.example.flutter/new_engine", binaryMessenger: flutterViewController.engine.binaryMessenger)
        
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
            if call.method == "newFlutterEngine" {
                result(FlutterMethodNotImplemented)
            } else if call.method == "newFlutterEngineWithoutFlutterEngineGroup" {
                self?.createNewEngine()
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        
        super.awakeFromNib()
    }
    
    private func createNewEngine() {
        let flutterEngine = FlutterEngine(name: "default", project: nil)
        flutterEngine.run(withEntrypoint: "mainWithoutNewEngine")
        
        let flutterVC = WebFFlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterVC.view.frame = self.contentView!.bounds
        RegisterGeneratedPlugins(registry: flutterVC)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.contentViewController?.presentAsModalWindow(flutterVC)
        }

        flutterEngineCount+=1
        flutterEngines[flutterEngineCount] = flutterEngine
        flutterVC.flutterEngineId = flutterEngineCount
        flutterVC.deinitHandler = { [self] (value) in
            destoryEngine(engineId: value)
        }
    }
    
    private func destoryEngine(engineId: Int) {
        let flutterEngine = flutterEngines[engineId]
        flutterEngine?.shutDownEngine();
    }
}
