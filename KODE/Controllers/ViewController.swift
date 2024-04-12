//
//  ViewController.swift
//  KODE
//
//  Created by Матвей Горохов on 17.03.2024.
//

import UIKit
// MARK: - Initial Setup
class ViewController: BaseController, UITableViewDelegate, NavBarViewDelegate, SortViewControllerDelegate, UISheetPresentationControllerDelegate {
    private let notFinded = UserNotFindedView()
    private var preferredDepartment = "all"
    private var searchValue = ""
    private var errorViewAboutSuperview: NSLayoutConstraint?
    private var errorViewToSuperview: NSLayoutConstraint?
    private var filteredAndSortedItems = [Item]()
    private let userCardScroll = UITableView()
    private var navBar = NavBarView()
    private var temporaryUsers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    private var alfavitSort = true
    private var birthdaySort = false
    private var users = [Item]()
    private var errorView = ErrorView()
    private var usersData = [Item]()
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        userCardScroll.reloadData()
        APIGet()
    }
}
extension ViewController {
    override func addViews() {
        userCardScroll.delegate = self
        navBar.delegate = self
        view.addSubview(errorView)
        view.addSubview(notFinded)
        view.addSubview(navBar)
        view.addSubview(userCardScroll)
    }
    override func layoutViews() {
        NSLayoutConstraint.activate([
            notFinded.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 80),
            notFinded.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            notFinded.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userCardScroll.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            userCardScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userCardScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userCardScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        errorViewAboutSuperview = errorView.bottomAnchor.constraint(equalTo: view.topAnchor)
        errorViewToSuperview = errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        errorViewAboutSuperview?.isActive = true
        errorViewToSuperview?.isActive = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        notFinded.translatesAutoresizingMaskIntoConstraints = false
        navBar.translatesAutoresizingMaskIntoConstraints = false
        userCardScroll.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {
        view.backgroundColor = .white

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        userCardScroll.refreshControl = refreshControl
        userCardScroll.register(UserCardTableViewCell.self, forCellReuseIdentifier: "UserCardCell")
        userCardScroll.dataSource = self
        userCardScroll.rowHeight = UITableView.automaticDimension
        userCardScroll.estimatedRowHeight = 200
        userCardScroll.backgroundColor = .white
        userCardScroll.separatorStyle = .none
    }
}
// MARK: - Sorted Methods
extension ViewController {
    func getSearchValue(searchValue searchValue: String) {
        self.searchValue = searchValue
        sorted()
    }

    func swapCategory(category: Int) {
        let index = category - 1
        if index >= 0 && index < Department.allCases.count - 1 {
            preferredDepartment = Department.allCases[index].rawValue
        } else {
            preferredDepartment = Department.all.rawValue
        }
        sorted()
    }
    func sorted() {
        if temporaryUsers.isEmpty {
            filteredAndSortedItems = filterAndSort(users: usersData, preferredDepartment: preferredDepartment, searchValue: searchValue, alfavitSort: alfavitSort, birthdaySort: birthdaySort)
            self.addUsers(users: filteredAndSortedItems)
            if filteredAndSortedItems.isEmpty {
                notFinded.isHidden = false
                view.bringSubviewToFront(notFinded)
            } else {
                notFinded.isHidden = true
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
        if temporaryUsers.isEmpty {
            return users.count
        } else {
            return temporaryUsers.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCardCell", for: indexPath) as? UserCardTableViewCell else {
            return UITableViewCell()
        }
        if temporaryUsers.isEmpty {
            let user = users[indexPath.row]
            cell.configure(user: user, birthday: birthdaySort)
        } else {
            cell.setsample()
        }
        return cell
    }
    func addUsers(users: [Item]) {
        self.users = users
        userCardScroll.reloadData()
    }
    @objc func refresh(_ sender: UIRefreshControl) {
        self.animateViewUp()
        temporaryUsers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        userCardScroll.reloadData()
        APIGet()
        refreshControl.endRefreshing()
    }
}
// MARK: - UIViewControllerTransitioning Methods
extension ViewController: UIViewControllerTransitioningDelegate {
    func sortTapped() {
        let filterController = FilterViewController()
        filterController.delegate = self
        if let sheet = filterController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.delegate = self
        }
        filterController.transitioningDelegate = self
        present(filterController, animated: true)
        filterController.setSort(alfavitSort: self.alfavitSort)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if temporaryUsers.isEmpty {
            let selectedUser = users[indexPath.row]
            let targetViewController = TargetViewController()
            let outputDateString = dateFormat(date: selectedUser.birthday)
            let age = getAge(date: selectedUser.birthday)
            targetViewController.setName(firstName: selectedUser.firstName, secondName: selectedUser.lastName, userTag: selectedUser.userTag.lowercased(), department: transformString(selectedUser.department), date: outputDateString, phone: selectedUser.phone, age: age, avatarURL: selectedUser.avatarURL)
            targetViewController.modalPresentationStyle = .fullScreen
            targetViewController.transitioningDelegate = self
            present(targetViewController, animated: true, completion: nil)
        }
    }
    func button1Tapped() {
        navBar.searchlabel.filterCollor(alfavitSort: true)
        alfavitSort = true
        birthdaySort = false
        sorted()
    }
    func button2Tapped() {
        navBar.searchlabel.filterCollor(alfavitSort: false)
        alfavitSort = false
        birthdaySort = true
        sorted()
    }
}
