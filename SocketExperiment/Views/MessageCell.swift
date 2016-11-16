//
//  MessageCell.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/16/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func initContent(message: UserMessage) {
        self.nameLabel.text = message.user
        self.messageLabel.text = message.message
    }

}
