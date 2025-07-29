//
//  ViewController.swift
//  SeSAC7Week5
//
//  Created by andev on 7/29/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAlert(title: "테스트", message: "Alert", ok: "배경바꾸기") {
            print("버튼을 클릭했어요")
            self.view.backgroundColor = .yellow
        }
    }


}

