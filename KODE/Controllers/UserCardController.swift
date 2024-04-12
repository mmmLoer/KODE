import UIKit

class TargetViewController: BaseController {
    private let userImage = UIImageView()
    private let closeButton = UIButton()
    private let userName = UILabel()
    private let department = UILabel()
    private let bottomView = UIView()
    private let ageImage = UIImageView()
    private let dateLabel = UILabel()
    private let ageLabel = UILabel()
    private let phoneImage = UIImageView()
    private let phoneNumber = UILabel()
    private let userTag = UILabel()
    func setName(firstName: String, secondName: String, userTag: String, department: String, date: String, phone: String, age: String, avatarURL: String) {
        userName.text = "\(firstName) \(secondName)"
        self.userTag.text = userTag
        self.department.text = department
        dateLabel.text = date
        phoneNumber.text = "+7-\(phone)"
        ageLabel.text = age
        loadImage(from: avatarURL) { [self] image in
            if let image = image {
                userImage.image = image
            }
        }
    }
}
extension TargetViewController {
    override func addViews() {
        view.addSubview(userName)
        view.addSubview(closeButton)
        view.addSubview(userImage)
        view.addSubview(userTag)
        view.addSubview(department)
        view.addSubview(bottomView)
        bottomView.addSubview(ageImage)
        bottomView.addSubview(dateLabel)
        bottomView.addSubview(ageLabel)
        bottomView.addSubview(phoneImage)
        bottomView.addSubview(phoneNumber)
    }
    override func layoutViews() {
        department.translatesAutoresizingMaskIntoConstraints = false
        userTag.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        ageImage.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneImage.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userImage.heightAnchor.constraint(equalToConstant: 104),
            userImage.widthAnchor.constraint(equalToConstant: 104),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userTag.centerYAnchor.constraint(equalTo: userName.centerYAnchor),
            userTag.leadingAnchor.constraint(equalTo: userName.trailingAnchor, constant: 3),
            department.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            department.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomView.topAnchor.constraint(equalTo: department.bottomAnchor, constant: 10),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ageImage.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            ageImage.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: ageImage.trailingAnchor, constant: 12),
            dateLabel.centerYAnchor.constraint(equalTo: ageImage.centerYAnchor),
            ageLabel.centerYAnchor.constraint(equalTo: ageImage.centerYAnchor),
            ageLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            phoneImage.topAnchor.constraint(equalTo: ageImage.bottomAnchor, constant: 30),
            phoneImage.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            phoneNumber.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: 12),
            phoneNumber.centerYAnchor.constraint(equalTo: phoneImage.centerYAnchor)
        ])

    }
    override func configure() {
        view.backgroundColor = Resouces.Colors.Gray3
        bottomView.backgroundColor = .white
        closeButton.setImage(Resouces.Images.Common.Close, for: .normal)
        closeButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        userImage.image = Resouces.Images.Common.UserImage
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = Resouces.Colors.Purple1
        userImage.layer.cornerRadius = 52
        userTag.font = Resouces.Fonts.interRegular(with: 17)
        userTag.textColor = Resouces.Colors.Gray2
        userName.font = Resouces.Fonts.interBold(with: 24)
        userName.textColor = Resouces.Colors.Black1
        department.font = Resouces.Fonts.interRegular(with: 13)
        department.textColor = Resouces.Colors.Gray4
        dateLabel.font = Resouces.Fonts.interMedium(with: 16)
        dateLabel.textColor = Resouces.Colors.Black1
        ageLabel.font = Resouces.Fonts.interSemiBold(with: 16)
        ageLabel.textColor = Resouces.Colors.Gray2
        phoneNumber.font = Resouces.Fonts.interMedium(with: 16)
        phoneNumber.textColor = Resouces.Colors.Black1
        phoneImage.image = Resouces.Images.Common.Phone
        ageImage.image = Resouces.Images.Common.Star
        let tapList = UITapGestureRecognizer(target: self, action: #selector(callButtonTapped))
        phoneNumber.addGestureRecognizer(tapList)
        phoneNumber.isUserInteractionEnabled = true
    }
    @objc func closeController() {
        dismiss(animated: true, completion: nil)
    }
    @objc func callButtonTapped() {
        if let phoneURL = URL(string: "tel://\(phoneNumber.text!)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                print("Ваше устройство не поддерживает эту функцию.")
            }
        }
    }
}
