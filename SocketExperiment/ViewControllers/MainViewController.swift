//
//  MainViewController.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/16/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var viewModel = MainViewModel(client: Client())
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSignal()
    }
    
    func bindSignal() {
        loginButton.rx.tap.flatMap{ [unowned self] in
            self.viewModel.login(name: self.nameTextField.text)
        }.subscribe(onNext: { [unowned self] _ in
            self.viewModel.client.userName = self.nameTextField.text!
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatView") as! ChatViewController
            vc.viewModel = ChatViewModel(client: self.viewModel.client)
                
            self.present(vc, animated: true, completion: nil)
                
            }, onError: { error in
                print(error)
        }).addDisposableTo(disposeBag)
    }

}
