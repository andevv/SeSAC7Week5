//
//  DetailViewController.swift
//  SeSAC7Week5
//
//  Created by andev on 7/31/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    let field = UITextField()
    
    var content: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailVC", #function)
        
        view.addSubview(field)
        
        field.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        field.placeholder = "입력해보세요"
        //field.text = content
        
        view.backgroundColor = .lightGray
        navigationItem.title = "디테일 화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        field.becomeFirstResponder()
    }
    
    @objc func closeButtonTapped() {
        print(#function)
        
        field.resignFirstResponder()
        
        //content?(field.text!)
        //dismiss(animated: true)
    }
    

}
