//
//  TransitionViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit

protocol DataPassProtocol {
    func getRandomNumber(a: Int)
}

class TransitionViewController: UIViewController {
    
    private let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("TextEdited"), object: nil)
    }
    
    @objc func notificationReceived(notification: NSNotification) {
        print(#function)
        
        print(notification.userInfo?["nickname"])
        print(notification.userInfo?["text"])
        print(notification.userInfo?["asdasd"])
        
        if let text = notification.userInfo?["text"] as? String {
            centerButton.setTitle(text, for: .normal)
        }
        
    }
    
    private func setupUI() {
        view.addSubview(centerButton)
        view.backgroundColor = .white
         
        centerButton.setTitle("중앙 버튼", for: .normal)
        centerButton.setTitleColor(.white, for: .normal)
        centerButton.backgroundColor = .purple
        centerButton.layer.cornerRadius = 8
         
        centerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        // SnapKit을 사용하여 버튼을 화면 정중앙에 배치
        centerButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    @objc private func buttonTapped() {
        
        let vc = EditViewController()
        
        //타입으로서의 프로토콜 특성을 활용
        vc.myDelegate = self
        
        vc.space = { name in
            print("안녕하세요")
            self.centerButton.setTitle(name, for: .normal)
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension TransitionViewController: DataPassProtocol {
    func getRandomNumber(a: Int) {
        self.centerButton.setTitle("숫자 \(a)", for: .normal)
    }
}
