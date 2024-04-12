import UIKit

final class SearchView: BaseView {
    weak var delegate: SearchDelegate?
    private var searchTrailingConstraintToSuperview: NSLayoutConstraint?
    private var searchTrailingConstraintToCancel: NSLayoutConstraint?
    private var cancelTrailingConstraintAboutSuperview: NSLayoutConstraint?
    private var cancelTrailingConstraintToSuperview: NSLayoutConstraint?
    private var xTrailing: NSLayoutConstraint?
    private let search = UIView()
    private let cancelButton = UIButton()
    private let clear = UIImageView()
    private let elementView = UIView()
    private let textField = UITextField()
    private let searchIcon = UIImageView()
    private let listIcon = UIImageView()
    private let cancel = UILabel()
    func filterCollor(alfavitSort: Bool) {
        self.listIcon.tintColor = alfavitSort ? Resouces.Colors.Gray1 : Resouces.Colors.Purple1
    }
}
extension SearchView {
    override func addViews() {
        textField.delegate = self
        addSubview(search)
        addSubview(cancel)
        search.addSubview(elementView)
        elementView.addSubview(searchIcon)
        elementView.addSubview(textField)
        search.addSubview(clear)
        elementView.addSubview(listIcon)
        cancelTrailingConstraintAboutSuperview = cancel.leadingAnchor.constraint(equalTo: trailingAnchor)
        cancelTrailingConstraintToSuperview = cancel.trailingAnchor.constraint(equalTo: trailingAnchor)
        searchTrailingConstraintToSuperview = search.trailingAnchor.constraint(equalTo: trailingAnchor)
        searchTrailingConstraintToCancel = search.trailingAnchor.constraint(equalTo: cancel.leadingAnchor, constant: -12)
    }
    override func layoutViews() {
        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: topAnchor),
            search.bottomAnchor.constraint(equalTo: bottomAnchor),
            search.leadingAnchor.constraint(equalTo: leadingAnchor),

            elementView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            elementView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            elementView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            elementView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            clear.centerYAnchor.constraint(equalTo: elementView.centerYAnchor),
            clear.trailingAnchor.constraint(equalTo: search.trailingAnchor, constant: -12),
            listIcon.centerYAnchor.constraint(equalTo: elementView.centerYAnchor),
            listIcon.trailingAnchor.constraint(equalTo: elementView.trailingAnchor),
            searchIcon.centerYAnchor.constraint(equalTo: elementView.centerYAnchor),
            searchIcon.leadingAnchor.constraint(equalTo: elementView.leadingAnchor),
            textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor),

            textField.topAnchor.constraint(equalTo: elementView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: elementView.bottomAnchor),
            textField.widthAnchor.constraint(equalToConstant: 175),
            cancel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cancel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        xTrailing?.isActive = false
        searchTrailingConstraintToSuperview?.isActive = true
        searchTrailingConstraintToCancel?.isActive = false
        cancelTrailingConstraintAboutSuperview?.isActive = true
        cancelTrailingConstraintToSuperview?.isActive = false
        clear.translatesAutoresizingMaskIntoConstraints = false
        search.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        listIcon.translatesAutoresizingMaskIntoConstraints = false
        elementView.translatesAutoresizingMaskIntoConstraints = false
        cancel.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {

        let tapClose = UITapGestureRecognizer(target: self, action: #selector(sect))
        search.backgroundColor = Resouces.Colors.Gray3
        search.layer.cornerRadius = 20

        cancel.addGestureRecognizer(tapClose)
        cancel.text = "Отмена"
        cancel.textColor = .blue
        cancel.isUserInteractionEnabled = true

        searchIcon.isUserInteractionEnabled = true // Включаем взаимодействие с пользователем
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchIconTapped))
        searchIcon.addGestureRecognizer(tapGesture)
        searchIcon.image = Resouces.Images.TabBar.Search?.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = Resouces.Colors.Gray1

        let clearAction = UITapGestureRecognizer(target: self, action: #selector(textClear))
        clear.image = Resouces.Images.TabBar.Clear
        clear.tintColor = Resouces.Colors.Gray1
        clear.addGestureRecognizer(clearAction)
        clear.isUserInteractionEnabled = true

        listIcon.image = Resouces.Images.TabBar.List?.withRenderingMode(.alwaysTemplate)
        listIcon.tintColor = Resouces.Colors.Gray1
        listIcon.isUserInteractionEnabled = true // Включаем взаимодействие с пользователем
        let tapList = UITapGestureRecognizer(target: self, action: #selector(listIconTapped))
        listIcon.addGestureRecognizer(tapList)
        textField.tintColor = Resouces.Colors.Purple1
        textField.isUserInteractionEnabled = true // Включаем взаимодействие с пользователем
        textField.addGestureRecognizer(tapGesture)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введи имя, тег",
            attributes: [NSAttributedString.Key.foregroundColor: Resouces.Colors.Gray1,
                         NSAttributedString.Key.font: Resouces.Fonts.interMedium(with: 15)]
        )
        clear.isHidden = true
        textField.returnKeyType = .done

        textField.backgroundColor = .clear
        textField.borderStyle = .roundedRect
        textField.font = Resouces.Fonts.interMedium(with: 15)
    }
    @objc private func searchIconTapped() {

        listIcon.isHidden = true

        cancelTrailingConstraintAboutSuperview?.isActive = false
        cancelTrailingConstraintToSuperview?.isActive = true
        searchTrailingConstraintToSuperview?.isActive = false
        searchTrailingConstraintToCancel?.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }

        searchIcon.tintColor = Resouces.Colors.Black1
        textField.becomeFirstResponder()
    }
    @objc private func listIconTapped() {
        delegate?.sortTapped()
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField.text != ""{
            clear.isHidden = false
            xTrailing?.isActive = true

        } else {
            clear.isHidden = true
        }
        delegate?.search(search: textField.text!)
    }
    @objc private func textClear() {
        textField.text = ""
        delegate?.search(search: textField.text!)}

    @objc private func sect() {

        xTrailing?.isActive = false
        clear.isHidden = true
        searchIcon.tintColor = Resouces.Colors.Gray1
        cancelTrailingConstraintAboutSuperview?.isActive = true
        cancelTrailingConstraintToSuperview?.isActive = false
        searchTrailingConstraintToCancel?.isActive = false
        searchTrailingConstraintToSuperview?.isActive = true
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            self.listIcon.isHidden = false
        })

        textField.resignFirstResponder()
    }
}
extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sect()
        return true
    }

}
protocol SearchDelegate: AnyObject {
    func search(search searchValue: String)
    func sortTapped()
}
