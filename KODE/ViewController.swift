//
//  ViewController.swift
//  KODE
//
//  Created by Матвей Горохов on 17.03.2024.
//

import UIKit

class ViewController: BaseController, UITableViewDelegate,NavBarViewDelegate {
    func getSearchValue(searchValue SearchValue: String) {
        
    }
    
    func sortTapped() {
        
    }
    
    func swapCategory(Category: Int) {
        
    }
    
    private let UserCardScroll = UITableView()
    private var NavBar = NavBarView()
    private var temporaryUsers = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    private var birthdaySort = false
    private var users = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        UserCardScroll.reloadData()
        APIManager.shared.getUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let usersData):
                    self.temporaryUsers=[]
                    self.users = usersData.items
                    self.UserCardScroll.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
extension ViewController{
    override func addViews() {
        UserCardScroll.delegate = self
        view.addSubview(NavBar)
        view.addSubview(UserCardScroll)
    }
    override func layoutViews() {
        NSLayoutConstraint.activate([
            
        NavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        NavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        NavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        UserCardScroll.topAnchor.constraint(equalTo: NavBar.bottomAnchor),
        UserCardScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        UserCardScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        UserCardScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NavBar.translatesAutoresizingMaskIntoConstraints = false
        UserCardScroll.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {
        view.backgroundColor = .white
        UserCardScroll.register(UserCardTableViewCell.self, forCellReuseIdentifier: "UserCardCell")
        UserCardScroll.dataSource = self
        UserCardScroll.rowHeight = UITableView.automaticDimension
        UserCardScroll.estimatedRowHeight = 200
        UserCardScroll.backgroundColor = .white
        UserCardScroll.separatorStyle = .none
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if temporaryUsers.count == 0{
            return users.count
        }else{
            return temporaryUsers.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCardCell", for: indexPath) as? UserCardTableViewCell else {
            return UITableViewCell()
        }
        if (temporaryUsers.count == 0 ){
            let user = users[indexPath.row]
            cell.configure(user: user, birthday: birthdaySort)
        }else{
            cell.setsample()
        }
        return cell
    }
}
