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
    // Initialize with a default client ID or wait for user input
    let defaultClientId = "CSK****FHQlUQZ" // Replace with your actual client ID
    
    let castarResult = Castar.createInstance(devKey: defaultClientId)
    
    switch castarResult {
    case .success(let instance):
      self.castarInstance = instance
      self.clientId = defaultClientId
      instance.start()
      print("CastarSDK initialized successfully with default client ID")
      result(true)
      
    case .failure(let error):
      print("Failed to initialize Castar: \(error.localizedDescription)")
      result(FlutterError(code: "INITIALIZATION_FAILED",
                         message: error.localizedDescription,
                         details: nil))
    }
  }
  
  private func setClientId(clientId: String, result: @escaping FlutterResult) {
    // Stop existing instance if any
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
                         message: error.localizedDescription,
                         details: nil))
    }
  }
}
