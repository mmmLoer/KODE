//
//  ViewController.swift
//  KODE
//
//  Created by Матвей Горохов on 17.03.2024.
//

import UIKit
// MARK: - Initial Setup
class ViewController: BaseController, UITableViewDelegate, NavBarViewDelegate, SortViewControllerDelegate, UISheetPresentationControllerDelegate {
    private let NotFinded = UserNotFindedView()
    private var preferredDepartment = "all"
    private var SearchValue = ""
    private var errorViewAboutSuperview: NSLayoutConstraint?
    private var errorViewToSuperview: NSLayoutConstraint?
    private var filteredAndSortedItems = [Item]()
    private let UserCardScroll = UITableView()
    private var NavBar = NavBarView()
    private var temporaryUsers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    private var alfavitSort = true
    private var birthdaySort = false
    private var users = [Item]()
    private var errorView = ErrorView()
    private var usersData = [Item]()
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        UserCardScroll.reloadData()
        APIGet()
    }
}
extension ViewController {
    override func addViews() {
        UserCardScroll.delegate = self
        NavBar.delegate = self
        view.addSubview(errorView)
        view.addSubview(NotFinded)
        view.addSubview(NavBar)
        view.addSubview(UserCardScroll)
    }
    override func layoutViews() {
        NSLayoutConstraint.activate([
        NotFinded.topAnchor.constraint(equalTo: NavBar.bottomAnchor, constant: 80),
        NotFinded.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        NotFinded.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        NavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        NavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        NavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        UserCardScroll.topAnchor.constraint(equalTo: NavBar.bottomAnchor, constant: 16),
        UserCardScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        UserCardScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        UserCardScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        errorView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        errorViewAboutSuperview = errorView.bottomAnchor.constraint(equalTo: view.topAnchor)
        errorViewToSuperview = errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        errorViewAboutSuperview?.isActive = true
        errorViewToSuperview?.isActive = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NotFinded.translatesAutoresizingMaskIntoConstraints = false
        NavBar.translatesAutoresizingMaskIntoConstraints = false
        UserCardScroll.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {
        view.backgroundColor = .white

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        UserCardScroll.refreshControl = refreshControl
        UserCardScroll.register(UserCardTableViewCell.self, forCellReuseIdentifier: "UserCardCell")
        UserCardScroll.dataSource = self
        UserCardScroll.rowHeight = UITableView.automaticDimension
        UserCardScroll.estimatedRowHeight = 200
        UserCardScroll.backgroundColor = .white
        UserCardScroll.separatorStyle = .none
    }
}
// MARK: - Sorted Methods
extension ViewController {
    func getSearchValue(searchValue SearchValue: String) {
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
    func sorted() {
        if temporaryUsers.count == 0 {
            filteredAndSortedItems = filterAndSort(users: usersData, preferredDepartment: preferredDepartment, searchValue: SearchValue, alfavitSort: alfavitSort, birthdaySort: birthdaySort)
            self.addUsers(users: filteredAndSortedItems)
            if filteredAndSortedItems.count==0 {
                NotFinded.isHidden = false
                view.bringSubviewToFront(NotFinded)
            } else {
                NotFinded.isHidden = true
            }
        }
    }
}
// MARK: - API Methods
extension ViewController {
    func APIGet() {
        APIManager.shared.getUsers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let usersData):
                    self.usersData = usersData.items
                    self.temporaryUsers=[]
                    self.sorted()
                case .failure(let error as NSError):
                    if error.code == -1001 {
                        self.errorView.label.text = "Не могу обновить данные \nПроверь соединение с интернетом."
                    } else if error.code == 500 {
                        self.errorView.label.text = "Проблема на стороне сервера \nМы уже занимаемся этой проблемой."
                    } else {
                        self.errorView.label.text = "В приложении произошла ошибка \nСкоро все починим."
                    }
                    self.view.bringSubviewToFront(self.errorView)
                    self.animateViewDown()
                }
            }
        }
    }
}
// MARK: - Animation Methods
extension ViewController {
    func animateViewDown() {
        self.errorViewAboutSuperview?.isActive = false
        self.errorViewToSuperview?.isActive = true
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            })
    }
    func animateViewUp() {
        self.errorViewAboutSuperview?.isActive = true
        self.errorViewToSuperview?.isActive = false

        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            })
    }
}
// MARK: - UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if temporaryUsers.count == 0 {
            return users.count
        } else {
            return temporaryUsers.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCardCell", for: indexPath) as? UserCardTableViewCell else {
            return UITableViewCell()
        }
        if temporaryUsers.count == 0 {
            let user = users[indexPath.row]
            cell.configure(user: user, birthday: birthdaySort)
        } else {
            cell.setsample()
        }
        return cell
    }
    func addUsers(users: [Item]) {
        self.users = users
        UserCardScroll.reloadData()
    }
    @objc func refresh(_ sender: UIRefreshControl) {
        self.animateViewUp()
        temporaryUsers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        UserCardScroll.reloadData()
        APIGet()
        refreshControl.endRefreshing()
    }
}
// MARK: - UIViewControllerTransitioning Methods
extension ViewController: UIViewControllerTransitioningDelegate {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if temporaryUsers.count == 0 {
            let selectedUser = users[indexPath.row]
            let targetViewController = TargetViewController()
            let outputDateString = DateFormat(Date: selectedUser.birthday)
            let age = GetAge(date: selectedUser.birthday)
            targetViewController.setName(firstName: selectedUser.firstName, secondName: selectedUser.lastName, userTag: selectedUser.userTag.lowercased(), department: transformString(selectedUser.department), Date: outputDateString, Phone: selectedUser.phone, Age: age, avatarURL: selectedUser.avatarURL)
            targetViewController.modalPresentationStyle = .fullScreen
            targetViewController.transitioningDelegate = self
            present(targetViewController, animated: true, completion: nil)
        }
    }
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
}