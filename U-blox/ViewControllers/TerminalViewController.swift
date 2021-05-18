//
//  TerminalViewController.swift
//  U-blox
//
//  Created by 谭达克 on 2021/5/4.
//  Copyright © 2021 U-blox. All rights reserved.
//

import UIKit
import CoreBluetooth

class TerminalViewController: BaseSerialPortTabBarViewController  {

    

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var tareButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var siButton: UIButton!
    
    @IBAction func clickSI(_ sender: Any) {
        NSLog("click on SI")
        outputLabel.text = "SI"
        //self.sendMessage("SI")
        sendMessage("SI")
    }
    
    @IBAction func clickTare(_ sender: Any) {
        NSLog("click on Tare")
        outputLabel.text = "Tare"
        sendMessage("T")
    }
    
    @IBAction func clickZero(_ sender: Any) {
        NSLog("click on Zero")
        outputLabel.text = "Z"
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TerminalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 44
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSerialPortComplitionHandler = {
            BluetoothManager.shared.currentSerialPort?.setDelegate(delegate: self)
        }

        if BluetoothManager.shared.currentPeripheral!.isSupportingSerialPort {
            outputLabel.text = ""
            tareButton.isEnabled = true
        } else {
            outputLabel.text = "Service unavalible"
            tareButton.isEnabled = false
        }

//        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main) { [weak self] notification in
//            self?.messageViewDistance.constant = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! CGRect).size.height
//            self?.view.setNeedsUpdateConstraints()
//        }
//        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main) { [weak self] _ in
//            self?.messageViewDistance.constant = 0;
//            self?.view.setNeedsUpdateConstraints()
//        }

        //messages = []
        //tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }
}

fileprivate extension TerminalViewController {
    func sendMessage(_ msg: String) {
        let message = msg + "\r\n"
        BluetoothManager.shared.currentSerialPort?.write(data: message.data(using: .utf8) ?? Data())
    }
}

extension TerminalViewController : DataStreamDelegate {
    func onWrite(data: Data) {
        
    }
    
    func onRead(data: Data) {
        let message = String(data: data, encoding: .utf8)!
        outputLabel.text = message
    }
}
