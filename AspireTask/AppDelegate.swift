//
//  AppDelegate.swift
//  AspireTask
//
//  Created by Adel Aref on 08/09/2021.
//
let defaults = UserDefaults.standard
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        defaults.apiKey = "57e37940dac450c168b4d63322870c8e"
        return true
    }

}
