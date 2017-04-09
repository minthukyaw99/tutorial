//
//  ProfileViewController.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 4/9/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import UIKit
import AlamofireImage
import FontAwesome_swift

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    let reuseIndentifier = "profileTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "Image")!
        let circularImage = image.af_imageRoundedIntoCircle()
        ProfileImage.image = circularImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier , for: indexPath)
     
     cell.textLabel?.font = UIFont.fontAwesome(ofSize: 12)
     cell.textLabel?.text = "\(String.fontAwesomeIcon(code: "fa-qrcode")!) Scan QR code"
     
     return cell
        
     }

}
