//
//  QrCodeReaderViewController.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 3/26/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
import PKHUD
import Alamofire

class ScanQRCodeViewController: UIViewController, QRCodeReaderViewControllerDelegate {

    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        
        readerVC.delegate = self
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)

    }
    
    // MARK: Private Methods
    
    func getCompanyFromQRCode(result: QRCodeReaderResult) {
        
        let parameters : Parameters = ["itemName" : result.value]
        
        Alamofire.request("http://192.241.250.106:9000/getByItemName", parameters: parameters).responseJSON { response in
            
            if let JSON = response.result.value {
                HUD.flash(.success, delay: 2.0)
                print("return item info \(JSON)")
            }
        }
        
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        HUD.show(.progress)
        dismiss(animated: true, completion: nil)
        getCompanyFromQRCode(result: result)
        
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}
