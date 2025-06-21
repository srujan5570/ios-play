import Flutter
import UIKit
import CastarSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var castarInstance: Castar?
  private var clientId: String?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let castarChannel = FlutterMethodChannel(name: "com.example.castarsdk/channel",
                                              binaryMessenger: controller.binaryMessenger)
    
    castarChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      switch call.method {
      case "initializeCastarSDK":
        // For simplicity, we use a default ID on initial load.
        // The user can set a new one from the Flutter UI.
        self.setClientId(clientId: "CSK****FHQlUQZ", result: result)
      case "setClientId":
        if let args = call.arguments as? [String: Any],
           let clientId = args["clientId"] as? String {
          self.setClientId(clientId: clientId, result: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENTS",
                             message: "Client ID is required",
                             details: nil))
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func setClientId(clientId: String, result: @escaping FlutterResult) {
    // Stop existing instance if any, to allow re-initialization with a new key
    if let existingInstance = castarInstance {
      existingInstance.stop()
    }
    
    // Create new instance with the provided client ID
    let castarResult = Castar.createInstance(devKey: clientId)
    
    switch castarResult {
    case .success(let instance):
      self.castarInstance = instance
      self.clientId = clientId
      instance.start()
      print("CastarSDK initialized successfully with client ID: \(clientId)")
      result(true)
      
    case .failure(let error):
      print("Failed to initialize Castar with client ID \(clientId): \(error.localizedDescription)")
      result(FlutterError(code: "CLIENT_ID_FAILED",
                         message: "Failed to init Castar: \(error.localizedDescription)",
                         details: nil))
    }
  }
}
