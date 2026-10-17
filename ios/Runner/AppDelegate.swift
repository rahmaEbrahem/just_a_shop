import Flutter
import UIKit
import FBSDKCoreKit 
import GoogleSignIn 

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    let handledByGoogle = GIDSignIn.sharedInstance.handle(url)
    if handledByGoogle {
      return true
    }
    
    return ApplicationDelegate.shared.application(app, open: url, options: options)
  }
}