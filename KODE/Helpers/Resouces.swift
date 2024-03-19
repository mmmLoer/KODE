//
//  Resouces.swift
//  KODE
//
//  Created by Матвей Горохов on 19.03.2024.
//

import UIKit
enum Resouces{
    enum Colors{
        enum navbar{
            static var SearchBackgroundColor = UIColor(hexString: "#F7F7F8")
            static var SearchItemColor = UIColor(hexString: "#C3C3C6")
            static var SelectColor = UIColor(hexString: "#050510")
            static var grayColor = UIColor(hexString: "#97979B")
        }
        static var active = UIColor(hexString: "#E6361D")
        static var backgroundUser = UIColor(hexString: "#5F30F9")
        static var inactive = UIColor(hexString: "#FFFFFF")
        static var backgroundTabBar = UIColor(hexString: "#E6361D")
        static var separator = UIColor(hexString: "#E8ECEF")
    }
    enum Strings {
        static var category = ["Все","Android","iOS", "Designers", "management", "QA", "back_office", "Frontend", "HR", "PR","Backend","support","analytics"]
    }
    enum Images {
        enum TabBar {
            static var SearchIcon = UIImage(named: "SearchIcon")
            static var ListIcon = UIImage(named: "ListIcon")
            static var close = UIImage(named: "X")
                    }
        enum Common {
            static var Selected = UIImage(named: "Selected")
            static var UnSelected = UIImage(named: "UnSelected")
            static var close = UIImage(named: "close")
            static var glass = UIImage(named: "glass")
            static var UserImage = UIImage(named: "UserImage")
            static var Phone = UIImage(named: "Phone")
            static var Star = UIImage(named: "Star")
        }
        
    }
    enum Fonts {
        static func InterMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Medium", size: size) ?? UIFont()
        }
        static func InterRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Regular", size: size) ?? UIFont()
        }
        static func InterSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-SemiBold", size: size) ?? UIFont()
        }
        static func InterBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Bold", size: size) ?? UIFont()
        }
    }
}
