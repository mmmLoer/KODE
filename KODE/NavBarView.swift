import UIKit

final class NavBarView: BaseView{
    weak var delegate: NavBarViewDelegate?
    private var Separator = UIView()
    private var selectedIndex: IndexPath? = IndexPath(item: 0, section: 0)
    private let horizontalCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
        }()
}
extension NavBarView{
    override func addViews() {
        addSubview(horizontalCollectionView)
        addSubview(Separator)
    }
    override func layoutViews() {
        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: topAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 36),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: Separator.topAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            Separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            Separator.heightAnchor.constraint(equalToConstant: 0.33),
            Separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            Separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        Separator.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {
        Separator.backgroundColor = Resouces.Colors.Gray1
        horizontalCollectionView.backgroundColor = .clear
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .left)
    }
}


extension NavBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = Resouces.Strings.category[indexPath.item]
        label.sizeToFit()
        
        let width = label.frame.width + 12
        return CGSize(width: width, height: 36)
    }
}

extension NavBarView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        Resouces.Strings.category.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            fatalError("Unable to dequeue CategoryCell")
        }
        let categoryItem = Resouces.Strings.category[indexPath.item]
        cell.configure(with: categoryItem)
        cell.setFont(with: (indexPath == selectedIndex) ? Resouces.Fonts.InterSemiBold(with: 15) : Resouces.Fonts.InterMedium(with: 15))
        
        cell.setTextColor(with: (indexPath == selectedIndex) ? Resouces.Colors.Black1: Resouces.Colors.Gray2
        )
        cell.setBorderColor(color: indexPath == selectedIndex ? .blue : .clear)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath {
            
            let oldIndexPath = selectedIndex
            selectedIndex = indexPath
            
            delegate?.swapCategory(Category: indexPath.item)
            
            if let oldIndexPath = oldIndexPath {
                collectionView.reloadItems(at: [oldIndexPath])
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }
}
protocol NavBarViewDelegate: AnyObject {
    func swapCategory( Category: Int)
}

