//
//  ShopTableViewController.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 4/5/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import UIKit
import ChameleonFramework
import Alamofire
import AlamofireImage

class ShopTableViewController: UITableViewController {

    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.navigationController?.navigationBar.barTintColor = GradientColor(gradientStyle: .radial, frame: self.view.frame, colors: [UIColor.flatSkyBlueColorDark(),UIColor.flatBlueColorDark()])
        self.navigationController?.navigationBar.topItem?.title = "Products"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private functions
    
    private func fetchData()
    {
        
        Alamofire.request("http://192.241.250.106:9000/get").responseJSON { response in
        
            if let JSON = response.result.value {
                let parsed = JSON as! [Any]
                
                for item in parsed {
                    let i = item as! NSArray
                    let price = (i[0] as! NSString).doubleValue
                    let artist = i[1] as! String
                    let description = i[2] as! String
                    let productImg = i[3] as! String
                    let ImageType = i[4] as! String
                    let name = i[5] as! String
                    let manufacturer = i[6] as! String
                    let imageUrl = i[7] as! String
                    let newProduct = Product(p: price,
                                             a: artist,
                                             d: description,
                                             proImg: productImg,
                                             type: ImageType,
                                             n: name,
                                             m: manufacturer,
                                             imageUrl: imageUrl
                        )
                    
                    self.products.append(newProduct)
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    private func setImage(imageView: UIImageView, url: String) {
        
        let url = URL(string: url)!
        let placeholderImage = UIImage(named: "defaultPhoto")!

        imageView.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            filter: CircleFilter(),
            imageTransition: .crossDissolve(0.2)
        )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "productCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductTableViewCell;
        
        let product = products[indexPath.row]
        
        let price = String(format:"%.1f", product.price!)
        self.setImage(imageView: cell.imageView!, url: product.imageUrl!)
        let size = CGSize(width: 50.0, height: 50.0)
        let image = cell.imageView?.image?.af_imageScaled(to: size)
        cell.imageView?.image = image
        cell.productName.text = product.name
        cell.productPrice.text = price
        cell.productType.text = product.itemType
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    


}
