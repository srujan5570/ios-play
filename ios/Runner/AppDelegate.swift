import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
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
        self.initializeCastarSDK(result: result)
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
  
  private func initializeCastarSDK(result: @escaping FlutterResult) {
    // TODO: Add CastarSDK integration when framework is properly linked
    print("CastarSDK initialization placeholder - framework not yet linked")
    result(true)
  }
  
  private func setClientId(clientId: String, result: @escaping FlutterResult) {
    // TODO: Add CastarSDK integration when framework is properly linked
    self.clientId = clientId
    print("Client ID set to: \(clientId) - CastarSDK framework not yet linked")
    result(true)
  }
}
