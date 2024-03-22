//
//  FilterController.swift
//  KODE
//
//  Created by Матвей Горохов on 21.03.2024.
//

import UIKit

final class FilterViewController: BaseController{
    weak var delegate:SortViewControllerDelegate?
    private let Title = UILabel()
    private let CloseButton = UIButton()
    private let Button1 = UIButton()
    private let label1 = UILabel()
    private let Button2 = UIButton()
    private let label2 = UILabel()
}
extension FilterViewController{
    func setSort(alfavitSort:Bool){
        self.Button1.setImage(alfavitSort ? Resouces.Images.Common.Selected : Resouces.Images.Common.UnSelected, for: .normal)
        self.Button2.setImage(alfavitSort ? Resouces.Images.Common.UnSelected : Resouces.Images.Common.Selected, for: .normal)
    }
    override func addViews() {
        view.addSubview(Title)
        view.addSubview(Button1)
        view.addSubview(Button2)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(CloseButton)
    }
    override func layoutViews() {
        Title.translatesAutoresizingMaskIntoConstraints = false
        Button1.translatesAutoresizingMaskIntoConstraints = false
        Button2.translatesAutoresizingMaskIntoConstraints = false
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        CloseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Title.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            Button1.heightAnchor.constraint(equalToConstant: 24),
            Button1.widthAnchor.constraint(equalToConstant: 24),
            Button2.heightAnchor.constraint(equalToConstant: 24),
            Button2.widthAnchor.constraint(equalToConstant: 24),
            CloseButton.heightAnchor.constraint(equalToConstant: 24),
            CloseButton.widthAnchor.constraint(equalToConstant: 24),
            CloseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            CloseButton.centerYAnchor.constraint(equalTo: Title.centerYAnchor),
            Button1.topAnchor.constraint(equalTo: Title.bottomAnchor, constant: 30),
            Button2.topAnchor.constraint(equalTo: Button1.bottomAnchor, constant: 30),
            Button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            Button2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label1.leadingAnchor.constraint(equalTo: Button1.trailingAnchor, constant: 12),
            label2.leadingAnchor.constraint(equalTo: Button2.trailingAnchor, constant: 12),
            label1.centerYAnchor.constraint(equalTo: Button1.centerYAnchor),
            label2.centerYAnchor.constraint(equalTo:  Button2.centerYAnchor),
        ])
    }
    override func configure() {
        view.backgroundColor = .white
        Title.text = "Сортировка"
        Title.font = Resouces.Fonts.InterSemiBold(with: 20)
        Title.textColor = .black
        Button1.setImage(Resouces.Images.Common.Selected, for: .normal)
        Button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        Button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        label1.text = "По алфавиту"
        label1.textColor = .black
        label1.font = Resouces.Fonts.InterMedium(with: 16)
        label2.text = "По дню рождения"
        label2.textColor = .black
        label2.font = Resouces.Fonts.InterMedium(with: 16)
        CloseButton.addTarget(self, action: #selector(CloseController), for: .touchUpInside)
        CloseButton.setImage(Resouces.Images.Common.Close, for: .normal)
    }
    @objc func button1Tapped(){
        delegate?.button1Tapped()
        Button1.setImage(Resouces.Images.Common.Selected, for: .normal)
        Button2.setImage(Resouces.Images.Common.UnSelected, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    @objc func button2Tapped(){
        delegate?.button2Tapped()
        Button2.setImage(Resouces.Images.Common.Selected, for: .normal)
        Button1.setImage(Resouces.Images.Common.UnSelected, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    @objc func CloseController(){
        dismiss(animated: true, completion: nil)
    }
}

protocol SortViewControllerDelegate: AnyObject{
    func button1Tapped()
    func button2Tapped()
}

