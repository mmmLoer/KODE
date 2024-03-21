import UIKit

class TargetViewController: BaseController{
    private let UserImage = UIImageView()
    private let CloseButton = UIButton()
    private let UserName = UILabel()
    private let Department = UILabel()
    private let bottomView = UIView()
    private let AgeImage = UIImageView()
    private let DateLabel = UILabel()
    private let AgeLabel = UILabel()
    private let PhoneImage = UIImageView()
    private let PhoneNumber = UILabel()
    private let UserTag = UILabel()
    func setName(firstName:String, secondName:String, userTag:String, department:String, Date:String, Phone:String, Age:String, avatarURL:String){
        UserName.text = "\(firstName) \(secondName)"
        UserTag.text = userTag
        Department.text = department
        DateLabel.text = Date
        PhoneNumber.text = "+7-\(Phone)"
        AgeLabel.text = Age
        loadImage(from: avatarURL) { [self] image in
            if let image = image {
                UserImage.image = image
            }
        }
    }
}
extension TargetViewController{
    override func addViews() {
        view.addSubview(UserName)
        view.addSubview(CloseButton)
        view.addSubview(UserImage)
        view.addSubview(UserTag)
        view.addSubview(Department)
        view.addSubview(bottomView)
        bottomView.addSubview(AgeImage)
        bottomView.addSubview(DateLabel)
        bottomView.addSubview(AgeLabel)
        bottomView.addSubview(PhoneImage)
        bottomView.addSubview(PhoneNumber)
    }
    override func layoutViews() {
        Department.translatesAutoresizingMaskIntoConstraints = false
        UserTag.translatesAutoresizingMaskIntoConstraints = false
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserImage.translatesAutoresizingMaskIntoConstraints = false
        CloseButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        AgeImage.translatesAutoresizingMaskIntoConstraints = false
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        AgeLabel.translatesAutoresizingMaskIntoConstraints = false
        PhoneImage.translatesAutoresizingMaskIntoConstraints = false
        PhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CloseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            CloseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            UserImage.heightAnchor.constraint(equalToConstant: 104),
            UserImage.widthAnchor.constraint(equalToConstant: 104),
            UserImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            UserImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            UserName.topAnchor.constraint(equalTo: UserImage.bottomAnchor, constant: 10),
            UserName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            UserTag.centerYAnchor.constraint(equalTo: UserName.centerYAnchor),
            UserTag.leadingAnchor.constraint(equalTo: UserName.trailingAnchor, constant: 3),
            Department.topAnchor.constraint(equalTo: UserName.bottomAnchor, constant: 10),
            Department.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomView.topAnchor.constraint(equalTo: Department.bottomAnchor, constant: 10),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            AgeImage.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            AgeImage.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            DateLabel.leadingAnchor.constraint(equalTo: AgeImage.trailingAnchor, constant: 12),
            DateLabel.centerYAnchor.constraint(equalTo: AgeImage.centerYAnchor),
            AgeLabel.centerYAnchor.constraint(equalTo: AgeImage.centerYAnchor),
            AgeLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            PhoneImage.topAnchor.constraint(equalTo: AgeImage.bottomAnchor, constant: 30),
            PhoneImage.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            PhoneNumber.leadingAnchor.constraint(equalTo: PhoneImage.trailingAnchor, constant: 12),
            PhoneNumber.centerYAnchor.constraint(equalTo: PhoneImage.centerYAnchor),
        ])
            
    }
    override func configure() {
        view.backgroundColor = Resouces.Colors.Gray3
        bottomView.backgroundColor = .white
        CloseButton.setImage(Resouces.Images.Common.Close, for: .normal)
        CloseButton.addTarget(self, action: #selector(CloseController), for: .touchUpInside)
        UserImage.image = Resouces.Images.Common.UserImage
        UserImage.layer.masksToBounds = true
        UserImage.backgroundColor = Resouces.Colors.Purple1
        UserImage.layer.cornerRadius = 52
        UserTag.font = Resouces.Fonts.InterRegular(with: 17)
        UserTag.textColor = Resouces.Colors.Gray2
        UserName.font = Resouces.Fonts.InterBold(with: 24)
        UserName.textColor = Resouces.Colors.Black1
        Department.font = Resouces.Fonts.InterRegular(with: 13)
        Department.textColor = Resouces.Colors.Gray4
        DateLabel.font = Resouces.Fonts.InterMedium(with: 16)
        DateLabel.textColor = Resouces.Colors.Black1
        AgeLabel.font = Resouces.Fonts.InterSemiBold(with: 16)
        AgeLabel.textColor = Resouces.Colors.Gray2
        PhoneNumber.font = Resouces.Fonts.InterMedium(with: 16)
        PhoneNumber.textColor = Resouces.Colors.Black1
        PhoneImage.image = Resouces.Images.Common.Phone
        AgeImage.image = Resouces.Images.Common.Star
        let tapList = UITapGestureRecognizer(target: self, action: #selector(callButtonTapped))
        PhoneNumber.addGestureRecognizer(tapList)
        PhoneNumber.isUserInteractionEnabled = true
    }
    @objc func CloseController(){
        dismiss(animated: true, completion: nil)
    }
    @objc func callButtonTapped() {
        if let phoneURL = URL(string: "tel://\(PhoneNumber.text!)") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            }else{
                print("Ваше устройство не поддерживает эту функцию.")
            }
        }
    }
}


