//
//  ViewController.swift
//  KODE
//
//  Created by Матвей Горохов on 17.03.2024.
//

import UIKit

class ViewController: BaseController, UITableViewDelegate,NavBarViewDelegate, SortViewControllerDelegate, UISheetPresentationControllerDelegate {
    func button1Tapped() {
        NavBar.Searchlabel.filterCollor(alfavitSort: true)
        alfavitSort = true
        birthdaySort = false
        sorted()
    }
    
    func button2Tapped() {
        NavBar.Searchlabel.filterCollor(alfavitSort: false)
        alfavitSort = false
        birthdaySort = true
        sorted()
    }
    
    private var preferredDepartment = "all"
    private var SearchValue = ""
    private var filteredAndSortedItems = [Item]()
    private let UserCardScroll = UITableView()
    private var NavBar = NavBarView()
    private var temporaryUsers = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    private var alfavitSort = true
    private var birthdaySort = false
    private var users = [Item]()
    private var usersData = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        UserCardScroll.reloadData()
        APIManager.shared.getUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let usersData):
                    self.usersData = usersData.items
                    self.temporaryUsers=[]
                    self.sorted()
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
        NavBar.delegate = self
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
    func getSearchValue(searchValue SearchValue: String) {
        print(SearchValue)
        self.SearchValue = SearchValue
        sorted()
    }
    
    func swapCategory(Category: Int) {
        let index = Category - 1
            if index >= 0 && index < Department.allCases.count - 1 {
                preferredDepartment = Department.allCases[index].rawValue
            } else {
                preferredDepartment = Department.all.rawValue
            }
            sorted()
    }
    func sorted(){
        filteredAndSortedItems = filterAndSort(users: usersData, preferredDepartment: preferredDepartment, searchValue: SearchValue, alfavitSort: alfavitSort, birthdaySort: birthdaySort)
        self.addUsers(users: filteredAndSortedItems)
    }
    func addUsers(users: [Item]){
        self.users = users
        UserCardScroll.reloadData()
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
extension ViewController:UIViewControllerTransitioningDelegate{
    func sortTapped() {
        let FilterController = FilterViewController()
        FilterController.delegate = self
        if let sheet = FilterController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.delegate = self
        }
        FilterController.transitioningDelegate = self
        present(FilterController, animated: true)
        FilterController.setSort(alfavitSort: self.alfavitSort)
    }
}

