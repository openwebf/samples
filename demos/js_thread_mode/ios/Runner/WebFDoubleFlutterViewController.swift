import UIKit
import Flutter

class WebFDoubleFlutterViewController: UIViewController {
    private let flutterVC1: WebFFlutterViewController
    private let flutterVC2: WebFFlutterViewController

    init(engine1: FlutterEngine, engine2: FlutterEngine) {
        flutterVC1 = WebFFlutterViewController(engine: engine1, nibName: nil, bundle: nil)
        flutterVC2 = WebFFlutterViewController(engine: engine2, nibName: nil, bundle: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(flutterVC1)
        addChild(flutterVC2)
        let safeFrame = self.view.frame
        let halfHeight = self.view.frame.height / 2.0
        flutterVC1.view.frame = CGRect(
          x: safeFrame.minX, y: safeFrame.minY, width: safeFrame.width, height: halfHeight)
        flutterVC2.view.frame = CGRect(
          x: safeFrame.minX, y: flutterVC1.view.frame.maxY, width: safeFrame.width, height: halfHeight)
        self.view.addSubview(flutterVC1.view)
        self.view.addSubview(flutterVC2.view)
        flutterVC1.didMove(toParent: self)
        flutterVC2.didMove(toParent: self)
    }
}
