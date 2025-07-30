//
//  ViewController.swift
//  SeSAC7Week5
//
//  Created by andev on 7/29/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let button = UIButton()
    let s = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        //serialSync()
        //serialAsnyc()
        //concurrentAsync()
        //concurrentSync()
        globalQualityOfService()
    }
    
    //마지막 작업이 언제 끝날지 알기 위해서는 어떻게 해야 할까? DispatchGroup
    //여러 쓰레드 중, 더 빨리 끝났으면 하는 작업을 고를 수 있을까? QOS
    func globalQualityOfService() {
        
        print("START")
        
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        print("END")
    }
    
    //동기 + 동시
    //실질적으로 메인쓰레드에서 수행함
    func concurrentSync() {
        print("START", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    //비동기 + 동시
    func concurrentAsync() {
        print("START", terminator: " ")
        
        for i in 1...100 {
            
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    //비동기 + 직렬
    func serialAsnyc() {
        print("START", terminator: " ")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    //동기 + 직렬
    func serialSync() {
        //DispatchQueue.main.sync
        print("START", terminator: " ")
        
        //DeadLock
        //        DispatchQueue.main.sync {
        //            for i in 1...100 {
        //                print(i, terminator: " ")
        //            }
        //        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END")
    }
    
    func configureView() {
        navigationItem.title = "네비게이션 타이틀"
        view.backgroundColor = .yellow
        
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(s)
        
        button.setTitle("클릭하기", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        imageView.backgroundColor = .red
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        
        button.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        s.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    @objc func buttonClicked() {
        print(#function)
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2507/Helix_GC_1080.jpg")!
        print("111111111")
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            print("222222222")
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        print("333333333")
    }
}

