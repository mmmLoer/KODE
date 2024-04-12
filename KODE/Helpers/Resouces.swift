//
//  Resouces.swift
//  KODE
//
//  Created by Матвей Горохов on 19.03.2024.
//

import UIKit
enum Resouces {
    enum Colors {
        static var Black1 = UIColor(hexString: "#050510")
        static var Gray1 = UIColor(hexString: "#C3C3C6")
        static var Gray2 = UIColor(hexString: "#97979B")
        static var Gray3 = UIColor(hexString: "#F7F7F8")
        static var Gray4 = UIColor(hexString: "#55555C")
        static var Purple1 = UIColor(hexString: "#6534FF")
        static var Red1 = UIColor(hexString: "#F44336")
    }
    enum Strings {
        static var category = ["Все", "Android", "iOS", "Designers", "Management", "QA", "Back Office", "Frontend", "HR", "PR", "Backend", "Support", "Analytics"]
    }
    enum Images {
        enum TabBar {
            static var Search = UIImage(named: "Search")
            static var List = UIImage(named: "List")
            static var Clear = UIImage(named: "Clear")
        }
        enum Common {
            static var Selected = UIImage(named: "Selected")
            static var UnSelected = UIImage(named: "UnSelected")
            static var Close = UIImage(named: "Close")
            static var Glass = UIImage(named: "Glass")
            static var UserImage = UIImage(named: "UserImage")
            static var Phone = UIImage(named: "Phone")
            static var Star = UIImage(named: "Star")
        }
    }
    enum Fonts {
        static func interMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Medium", size: size) ?? UIFont()
        }
        static func interRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Regular", size: size) ?? UIFont()
        }
        static func interSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-SemiBold", size: size) ?? UIFont()
        }
        static func interBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Bold", size: size) ?? UIFont()
        }
    }
}
