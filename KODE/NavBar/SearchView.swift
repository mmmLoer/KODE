import UIKit

final class SearchView: BaseView{
    weak var delegate: SearchDelegate?
    private var searchTrailingConstraintToSuperview: NSLayoutConstraint?
    private var searchTrailingConstraintToCancel: NSLayoutConstraint?
    private var cancelTrailingConstraintAboutSuperview: NSLayoutConstraint?
    private var cancelTrailingConstraintToSuperview: NSLayoutConstraint?
    private var xTrailing: NSLayoutConstraint?
    private let Search = UIView()
    private let cancelButton = UIButton()
    private let Clear = UIImageView()
    private let elementView = UIView()
    private let textField = UITextField()
    private let searchIcon = UIImageView()
    private let ListIcon = UIImageView()
    private let cancel = UILabel()
    func filterCollor(alfavitSort:Bool){
        self.ListIcon.tintColor = alfavitSort ? Resouces.Colors.Gray1 : Resouces.Colors.Purple1
    }
}
extension SearchView{
    override func addViews() {
        textField.delegate = self
        addSubview(Search)
        addSubview(cancel)
        Search.addSubview(elementView)
        elementView.addSubview(searchIcon)
        elementView.addSubview(textField)
        Search.addSubview(Clear)
        elementView.addSubview(ListIcon)
        cancelTrailingConstraintAboutSuperview = cancel.leadingAnchor.constraint(equalTo: trailingAnchor)
        cancelTrailingConstraintToSuperview = cancel.trailingAnchor.constraint(equalTo: trailingAnchor)
        searchTrailingConstraintToSuperview = Search.trailingAnchor.constraint(equalTo: trailingAnchor)
        searchTrailingConstraintToCancel = Search.trailingAnchor.constraint(equalTo: cancel.leadingAnchor, constant: -12)
    }
    override func layoutViews() {
                NSLayoutConstraint.activate([
            Search.topAnchor.constraint(equalTo: topAnchor),
            Search.bottomAnchor.constraint(equalTo: bottomAnchor),
            Search.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            elementView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            elementView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            elementView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            elementView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            Clear.centerYAnchor.constraint(equalTo: elementView.centerYAnchor),
            Clear.trailingAnchor.constraint(equalTo: Search.trailingAnchor, constant: -12),
            ListIcon.centerYAnchor.constraint(equalTo: elementView.centerYAnchor),
            ListIcon.trailingAnchor.constraint(equalTo: elementView.trailingAnchor),
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
        Clear.translatesAutoresizingMaskIntoConstraints = false
        Search.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        ListIcon.translatesAutoresizingMaskIntoConstraints = false
        elementView.translatesAutoresizingMaskIntoConstraints = false
        cancel.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {
        
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(sect))
        Search.backgroundColor = Resouces.Colors.Gray3
        Search.layer.cornerRadius = 20
        
        cancel.addGestureRecognizer(tapClose)
        cancel.text = "Отмена"
        cancel.textColor = .blue
        cancel.isUserInteractionEnabled = true
        
        searchIcon.isUserInteractionEnabled = true // Включаем взаимодействие с пользователем
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchIconTapped))
        searchIcon.addGestureRecognizer(tapGesture)
        searchIcon.image = Resouces.Images.TabBar.Search?.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = Resouces.Colors.Gray1
        
        let tapX = UITapGestureRecognizer(target: self, action: #selector(textX))
        Clear.image = Resouces.Images.TabBar.Clear
        Clear.tintColor = Resouces.Colors.Gray1
        Clear.addGestureRecognizer(tapX)
        Clear.isUserInteractionEnabled = true
        
        ListIcon.image = Resouces.Images.TabBar.List?.withRenderingMode(.alwaysTemplate)
        ListIcon.tintColor = Resouces.Colors.Gray1
        ListIcon.isUserInteractionEnabled = true // Включаем взаимодействие с пользователем
        let tapList = UITapGestureRecognizer(target: self, action: #selector(listIconTapped))
        ListIcon.addGestureRecognizer(tapList)
        textField.tintColor = .red
        textField.isUserInteractionEnabled = true // Включаем взаимодействие с пользователем
        textField.addGestureRecognizer(tapGesture)
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Введи имя, тег",
            attributes: [NSAttributedString.Key.foregroundColor: Resouces.Colors.Gray1,
                         NSAttributedString.Key.font: Resouces.Fonts.InterMedium(with: 15)]
        )
        Clear.isHidden = true
        textField.returnKeyType = .done
        
        
        textField.backgroundColor = .clear
        textField.borderStyle = .roundedRect
        textField.font = Resouces.Fonts.InterMedium(with: 15)
        }
    @objc private func searchIconTapped() {
        
        ListIcon.isHidden = true
        
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
        if (textField.text != ""){
            Clear.isHidden = false
            xTrailing?.isActive = true
            
        }else{
            Clear.isHidden = true
        }
        delegate?.search(Search: textField.text!)
    }
    @objc private func textX() {
        textField.text = ""
        delegate?.search(Search: textField.text!)}
    
    @objc private func sect(){
        
        xTrailing?.isActive = false
        Clear.isHidden = true
        searchIcon.tintColor = Resouces.Colors.Gray1
        cancelTrailingConstraintAboutSuperview?.isActive = true
        cancelTrailingConstraintToSuperview?.isActive = false
        searchTrailingConstraintToCancel?.isActive = false
        searchTrailingConstraintToSuperview?.isActive = true
        UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in
                self.ListIcon.isHidden = false
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
    func search(Search SearchValue: String)
    func sortTapped()
}
