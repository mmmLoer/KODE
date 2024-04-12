//
//  FilterController.swift
//  KODE
//
//  Created by Матвей Горохов on 21.03.2024.
//

import UIKit

final class FilterViewController: BaseController {
    weak var delegate: SortViewControllerDelegate?
    private let displayName = UILabel()
    private let closeButton = UIButton()
    private let button1 = UIButton()
    private let label1 = UILabel()
    private let button2 = UIButton()
    private let label2 = UILabel()
}
extension FilterViewController {
    func setSort(alfavitSort: Bool) {
        self.button1.setImage(alfavitSort ? Resouces.Images.Common.Selected :
                                Resouces.Images.Common.UnSelected, for: .normal)
        self.button2.setImage(alfavitSort ? Resouces.Images.Common.UnSelected :
                                Resouces.Images.Common.Selected, for: .normal)
    }
    override func addViews() {
        view.addSubview(displayName)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(closeButton)
    }
    override func layoutViews() {
        displayName.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayName.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            button1.heightAnchor.constraint(equalToConstant: 24),
            button1.widthAnchor.constraint(equalToConstant: 24),
            button2.heightAnchor.constraint(equalToConstant: 24),
            button2.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            closeButton.centerYAnchor.constraint(equalTo: displayName.centerYAnchor),
            button1.topAnchor.constraint(equalTo: displayName.bottomAnchor, constant: 30),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 30),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label1.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 12),
            label2.leadingAnchor.constraint(equalTo: button2.trailingAnchor, constant: 12),
            label1.centerYAnchor.constraint(equalTo: button1.centerYAnchor),
            label2.centerYAnchor.constraint(equalTo: button2.centerYAnchor)
        ])
    }
    override func configure() {
        view.backgroundColor = .white
        displayName.text = "Сортировка"
        displayName.font = Resouces.Fonts.interSemiBold(with: 20)
        displayName.textColor = .black
        button1.setImage(Resouces.Images.Common.Selected, for: .normal)
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        label1.text = "По алфавиту"
        label1.textColor = .black
        label1.font = Resouces.Fonts.interMedium(with: 16)
        label2.text = "По дню рождения"
        label2.textColor = .black
        label2.font = Resouces.Fonts.interMedium(with: 16)
        closeButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        closeButton.setImage(Resouces.Images.Common.Close, for: .normal)
    }
    @objc func button1Tapped() {
        delegate?.button1Tapped()
        button1.setImage(Resouces.Images.Common.Selected, for: .normal)
        button2.setImage(Resouces.Images.Common.UnSelected, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    @objc func button2Tapped() {
        delegate?.button2Tapped()
        button2.setImage(Resouces.Images.Common.Selected, for: .normal)
        button1.setImage(Resouces.Images.Common.UnSelected, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    @objc func closeController() {
        dismiss(animated: true, completion: nil)
    }
}

protocol SortViewControllerDelegate: AnyObject {
    func button1Tapped()
    func button2Tapped()
}
