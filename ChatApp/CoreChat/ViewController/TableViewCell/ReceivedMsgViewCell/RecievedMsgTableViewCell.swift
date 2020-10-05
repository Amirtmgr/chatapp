//
//  RecievedMsgTableViewCell.swift
//  ChatApp
//
//  Created by Amir T Mgr on 9/29/20.
//

import UIKit

public let ReceiveMsgTVCellId = "RecievedMsgTableViewCell"

class RecievedMsgTableViewCell: UITableViewCell {

    @IBOutlet weak var vMsg: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(msg:MessageModel, sender:ChatUser?){
        self.lblMsg.text = msg.message
        self.lblDate.text = msg.getDate()
        self.lblName.text = sender?.name
    }
}
