//
//  ChatViewController.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/16/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import UIKit
import RxSwift

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var viewModel: ChatViewModel?
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bindSignel()
    }
    
    func bindSignel() {
        viewModel?.messagesVariable.asObservable().subscribe(onNext:{ [unowned self] _ in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)
        
        chatField.rx.text.subscribe(onNext:{ text in
            //TO-DO implement typing
            print("TEXT: \(text)")
        }).addDisposableTo(disposeBag)
        
        sendButton.rx.tap.subscribe(onNext:{ [unowned self] in
            self.viewModel?.sendMessage(msg: self.chatField.text!)
            self.chatField.text = ""
        }).addDisposableTo(disposeBag)
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.messages.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        cell.initContent(message: viewModel?.messages[indexPath.row] as! UserMessage)
        return cell
    }
}
