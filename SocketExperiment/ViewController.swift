//
//  ViewController.swift
//  SocketExperiment
//
//  Created by TW-LostSeaWay on 11/14/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let client = Client()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        NewMessageSocketEvent(socket: client.socket).listen().subscribe(onNext: { data in
            print(data)
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
