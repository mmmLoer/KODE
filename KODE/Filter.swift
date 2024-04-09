import Foundation
func filterAndSort(users: [Item], preferredDepartment: String, searchValue: String, alfavitSort: Bool, birthdaySort: Bool) -> [Item] {
    var filteredAndSortedItems = users

    if preferredDepartment != "all" {
        filteredAndSortedItems = users.filter { $0.department == preferredDepartment }
    }

    if !searchValue.isEmpty {
        filteredAndSortedItems = filteredAndSortedItems.filter {
            $0.firstName.lowercased().hasPrefix(searchValue.lowercased()) ||
            $0.lastName.lowercased().hasPrefix(searchValue.lowercased()) ||
            $0.userTag.lowercased().hasPrefix(searchValue.lowercased())
        }
    }

    if alfavitSort {
        filteredAndSortedItems = filteredAndSortedItems.sorted { $0.firstName < $1.firstName }
    }

    if birthdaySort {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let currentYear = Calendar.current.component(.year, from: Date())
        let today = Date()
        let currentYearFormatter = DateFormatter()
        currentYearFormatter.dateFormat = "yyyy-MM-dd"

        filteredAndSortedItems = filteredAndSortedItems.sorted { item1, item2 in
            let item1BirthdayThisYear = currentYearFormatter.date(from: "\(currentYear)-\(item1.birthday.dropFirst(5))")!
            let item2BirthdayThisYear = currentYearFormatter.date(from: "\(currentYear)-\(item2.birthday.dropFirst(5))")!

            let item1NextBirthday = item1BirthdayThisYear < today ? Calendar.current.date(byAdding: .year, value: 1, to: item1BirthdayThisYear)! : item1BirthdayThisYear
            let item2NextBirthday = item2BirthdayThisYear < today ? Calendar.current.date(byAdding: .year, value: 1, to: item2BirthdayThisYear)! : item2BirthdayThisYear

            return item1NextBirthday < item2NextBirthday
        }
    }

    return filteredAndSortedItems
}
