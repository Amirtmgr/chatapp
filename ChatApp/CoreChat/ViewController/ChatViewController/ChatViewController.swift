//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import UIKit
import FirebaseDatabase
import Firebase
import ObjectMapper
import SVProgressHUD

let Placeholder = "Write your message here..."

class ChatViewController: UIViewController {

    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var vInputBar: UIView!
    @IBOutlet weak var btnAttach: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textInput: UITextView!
    
    var messages = [MessageModel]()
    var sender : ChatUser?
    var receiver : ChatUser?
    var chatService : ChatService?
    var _refHandle : DatabaseHandle!
    var _dbRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        designSetup()
        //Database reference to sender message node.
        self._dbRef = self.chatService?.senderMessagesNode
        //Observe node
        self.observeFirebase()
    }
    
    @IBAction func sendMsg(_ sender: Any) {
        //Check message if empty.
        guard let msg = self.textInput.text else {
            return
        }
        if !(isTextEmpty(text: msg)) && msg != Placeholder {
            let msg = MessageModel(senderId: self.sender?.userId, receiverId: self.receiver?.userId, message: self.textInput.text, isMedia: false, isSeen: false)
            self.chatService?.sendMessage(msg)
        }
    }
}

//MARK: User Defined Methods

extension ChatViewController {
    
    func initialSetup(){
        //Register tableviewcells
        self.tvChat.delegate = self
        self.tvChat.dataSource = self
        self.tvChat.estimatedRowHeight = 80
        self.tvChat.rowHeight = UITableView.automaticDimension
        let sentMsgCell = UINib(nibName: "SentMsgTableViewCell", bundle: nil)
        self.tvChat.register(sentMsgCell, forCellReuseIdentifier: SentMsgTVCellId)
        let receiveMsgCell = UINib(nibName: "RecievedMsgTableViewCell", bundle: nil)
        self.tvChat.register(receiveMsgCell, forCellReuseIdentifier: ReceiveMsgTVCellId)
        
        //Instantiate ChatService with sender and receiver users.
        guard let senderUsr = sender, let receiverUsr = receiver else {
            print("Error creating users")
            return
        }
        
        self.chatService = ChatService(sender: senderUsr, receiver: receiverUsr)
        self.chatService?.delegate = self
    }
    
    func designSetup() {
        self.textInput.text = ""
        self.textInput.text = Placeholder
        self.textInput.textColor = UIColor.lightGray
        self.textInput.delegate = self
        self.textInput.selectedTextRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.beginningOfDocument)
    }
}

//Mark: TableView Delegates

extension ChatViewController:UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let msg = self.messages[indexPath.row]
        guard let senderId = msg.senderId, let  myId = self.sender?.userId else {
            print("Error:Empty sernderId")
            return cell
        }
        
        if senderId == myId {
            let sentMsgcell = self.tvChat.dequeueReusableCell(withIdentifier: SentMsgTVCellId, for: indexPath) as! SentMsgTableViewCell
            sentMsgcell.configureCell(msg: self.messages[indexPath.row])
            cell = sentMsgcell
        } else {
            let recievedMsgCell = self.tvChat.dequeueReusableCell(withIdentifier: ReceiveMsgTVCellId, for: indexPath) as! RecievedMsgTableViewCell
            recievedMsgCell.configureCell(msg: self.messages[indexPath.row], sender:self.receiver)
            cell = recievedMsgCell
        }
        return cell
    }
}

//Mark: ChatserviceDelegate
extension ChatViewController:ChatServiceDelegate {
    func messageAdded(_ message: MessageModel) {
        self.textInput.text = nil
        print("firebase message added")
        //Do other things like sending notifications
    }
    
    func messageDeleted(_ message: MessageModel) {
        print("firebase message deleted")
    }
    
    func messageIsDelivered(_ message: MessageModel) {
        print("firebase message delivered")
    }
    
    func messageFailedToDeliver() {
        print("Failed firebase message deleted")
    }

}

//Mark:FirebaseObserver
extension ChatViewController {    
    func  observeFirebase()  {
       // SVProgressHUD.show(withStatus: "Loading chat...")
        self._refHandle = self._dbRef.observe(.childAdded, with: { (snapshot) in
            guard let msg = Mapper<MessageModel>().map(JSONObject: snapshot.value) else {
                print("Error parsing message.")
                return
            }
            self.messages.append(msg)
            self.tvChat.reloadData()
            self.scrollToBottom(animated: true)
        })
    }
}

//Mark:Utils
extension ChatViewController {
    func scrollToBottom(animated:Bool) {
        let rows = self.messages.count
        if rows > 0 {
            let rowIndex = IndexPath(row: rows - 1, section: 0)
            self.tvChat.scrollToRow(at: rowIndex, at: .bottom, animated: animated)
        }
    }
}

//Mark:TextViewDelegate
extension ChatViewController:UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {

            textView.text = Placeholder
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.white
            textView.text = text
        }
        else {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
