import UIKit

class CategoryCell: UICollectionViewCell {
    let label = UILabel()
    let borderLayer = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        contentView.addSubview(borderLayer)
        label.translatesAutoresizingMaskIntoConstraints = false
        borderLayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            borderLayer.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3),
            borderLayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderLayer.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderLayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            borderLayer.heightAnchor.constraint(equalToConstant: 2)
        ])
        label.font = Resouces.Fonts.InterMedium(with: 15)
        label.textColor = .black
        label.textAlignment = .center
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setFont(with font: UIFont){
        label.font = font
    }
    func setBorderColor(color:UIColor){
        borderLayer.backgroundColor = color
    }
    func setTextColor(with color: UIColor){
        label.textColor = color
    }
    func configure(with category: String) {
        label.text = category
    }
}

