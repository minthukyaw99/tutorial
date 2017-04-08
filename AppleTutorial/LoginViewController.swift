//
//  LoginViewController.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 4/1/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import UIKit
import ChameleonFramework
import FontAwesome_swift
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
  
    @IBOutlet weak var linkedInLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = GradientColor(gradientStyle: .radial, frame: self.view.frame, colors: [UIColor.flatSkyBlueColorDark(),UIColor.flatBlueColorDark()])
        
        facebookLabel.font = UIFont.fontAwesome(ofSize: 20)
        facebookLabel.text = String.fontAwesomeIcon(code: "fa-facebook")
        
        twitterLabel.font = UIFont.fontAwesome(ofSize: 20)
        twitterLabel.text = String.fontAwesomeIcon(code: "fa-twitter")
        
        linkedInLabel.font = UIFont.fontAwesome(ofSize: 20)
        linkedInLabel.text = String.fontAwesomeIcon(code: "fa-linkedin")
        
        email.backgroundColor = UIColor.clear
        email.layer.borderColor = UIColor.flatPowderBlue().cgColor
        email.layer.borderWidth = 1
        email.layer.cornerRadius = 5
        
        
        password.backgroundColor = UIColor.clear
        password.layer.borderColor = UIColor.flatPowderBlue().cgColor
        password.layer.borderWidth = 1
        password.layer.cornerRadius = 5
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        let parameters : Parameters = [
            "email" : email.text ?? 0,
            "password" : password.text ?? 0
        ]
        
        Alamofire.request("http://192.241.250.106:9000/login", method: .post, parameters: parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                
                if "success" == JSON as? String {
                    let userDefault = UserDefaults()
                    userDefault.set(true, forKey: "isLogin")
                    print("alredy login \(userDefault.bool(forKey: "isLogin"))")
                    self.showNextViewController()
                }
            }
        }
    }
    
    private func showNextViewController()
    {
        print("in showNextViewController")
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }


}
