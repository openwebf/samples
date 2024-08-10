import Cocoa
import FlutterMacOS

class WebFFlutterViewController: FlutterViewController {
    var deinitHandler: ((Int) -> Void)?
    var flutterEngineId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        deinitHandler?(flutterEngineId ?? 0)
        
        deinitHandler = nil
    }

}
