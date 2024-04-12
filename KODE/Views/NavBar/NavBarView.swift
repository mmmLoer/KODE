import UIKit

final class NavBarView: BaseView, SearchDelegate {
    weak var delegate: NavBarViewDelegate?
    var searchlabel = SearchView()
    private var separator = UIView()
    private var selectedIndex: IndexPath? = IndexPath(item: 0, section: 0)
    private let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
}
extension NavBarView {
    override func addViews() {
        addSubview(horizontalCollectionView)
        searchlabel.delegate = self
        addSubview(searchlabel)
        addSubview(separator)
    }
    override func layoutViews() {
        NSLayoutConstraint.activate([
            searchlabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            searchlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            searchlabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            searchlabel.heightAnchor.constraint(equalToConstant: 40),
            horizontalCollectionView.topAnchor.constraint(equalTo: searchlabel.bottomAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 36),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: separator.topAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.33),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
        searchlabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    override func configure() {
        separator.backgroundColor = Resouces.Colors.Gray1
        horizontalCollectionView.backgroundColor = .clear
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .left)
    }
    func sortTapped() {
        delegate?.sortTapped()
    }
    func search(search searchValue: String) {
        delegate?.getSearchValue(searchValue: searchValue)
    }
}

extension NavBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            fatalError("Unable to dequeue CategoryCell")
        }
        let categoryItem = Resouces.Strings.category[indexPath.item]
        cell.configure(with: categoryItem)
        cell.setFont(with: (indexPath == selectedIndex) ? Resouces.Fonts.interSemiBold(with: 15) : Resouces.Fonts.interMedium(with: 15))

        cell.setTextColor(with: (indexPath == selectedIndex) ? Resouces.Colors.Black1: Resouces.Colors.Gray2
        )
        cell.setBorderColor(color: indexPath == selectedIndex ? .blue : .clear)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != indexPath {

            let oldIndexPath = selectedIndex
            selectedIndex = indexPath

            delegate?.swapCategory(category: indexPath.item)

            if let oldIndexPath = oldIndexPath {
                collectionView.reloadItems(at: [oldIndexPath])
            }
            collectionView.reloadItems(at: [indexPath])
        }
    }
}
protocol NavBarViewDelegate: AnyObject {
    func swapCategory(category: Int)
    func getSearchValue(searchValue: String)
    func sortTapped()
}
