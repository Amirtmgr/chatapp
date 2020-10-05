//
//  ViewController.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtSender: UITextField!
    @IBOutlet weak var txtReceiver: UITextField!
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func startChat(_ sender: Any) {
        let senderIdtxt = txtSender.text
        let receiverIdtxt = txtReceiver.text
        
        guard let senderId = senderIdtxt, let receiverId = receiverIdtxt else {
            print("Enter correct ids")
            return
        }
        
        if senderId != receiverId {
            //Start chat
            print("Starting Chat.....")
            let vc = Routes.chatViewController
            vc.sender = getUser(withId: senderId)
            vc.receiver = getUser(withId: receiverId)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Enter correct ids")
        }
    }
    
    func getUser(withId : String) -> ChatUser{
        return ChatUser(name: "user" + withId, userId: withId, profileImageUrl: nil)
    }
}

