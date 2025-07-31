//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import SnapKit
import Alamofire

struct Photo: Decodable {
    let id: String
    let author: String
    let download_url: String
}

class PhotoViewController: UIViewController {
    
    var firstList: [Photo] = []
    var secondList: [Photo] = []
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        return tableView
    }()
    
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        return tableView
    }()
     
    let button = {
       let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        let group = DispatchGroup() //enter
        
        group.enter()
        self.call(url: "https://picsum.photos/v2/list?page=1") { value in
            self.firstList.append(contentsOf: value)
            group.leave()
        }
        
        group.enter()
        self.call(url: "https://picsum.photos/v2/list?page=2") { value in
            self.secondList.append(contentsOf: value)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.authorTableView.reloadData()
        }
    }
    
    func call(url: String, completionHandler: @escaping ([Photo]) -> Void) {
        print(#function)
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [Photo].self) { response in
                
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print("fail")
                }
            }
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == authorTableView {
            return secondList.count
        } else {
            return firstList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == authorTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as! AuthorTableViewCell
            let row = secondList[indexPath.row]
            cell.authorLabel.text = row.author
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            let row = firstList[indexPath.row]
            cell.titleLabel.text = row.author
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, tableView)
        
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
     
}

extension PhotoViewController {
    
    func configureHierarchy() {
        view.addSubview(authorTableView)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func configureLayout() {
         
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.top.equalTo(button.snp.bottom)
        }
        
        authorTableView.snp.makeConstraints { make in
            make.leading.equalTo(tableView.snp.trailing)
            make.verticalEdges.equalTo(tableView)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "통신 테스트"
        view.backgroundColor = .white
        //버튼 클릭 시 DetailViewController Present
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print(#function)
        
        let vc = DetailViewController()
        vc.content = { response in
            self.button.setTitle(response, for: .normal)
        }
        let nav = UINavigationController(rootViewController: vc)
        
        //navigationController?.pushViewController(vc, animated: true)
        present(nav, animated: true)
    }
    
}
