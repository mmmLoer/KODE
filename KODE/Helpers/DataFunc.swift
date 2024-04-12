import Foundation
// MARK: - Date formate
func correctWordForYear(_ number: Int) -> String {
    let cases = [2, 0, 1, 1, 1, 2]
    let titles = ["год", "года", "лет"]
    return titles[(number % 100 > 4 && number % 100 < 20) ? 2 : cases[min(number % 10, 5)]]
}
func dateFormat(date: String) -> String {
    let inputDateFormat = "yyyy-MM-dd"
    let outputDateFormat = "dd MMMM yyyy"
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = inputDateFormat
    guard let date = dateFormatter.date(from: date) else {
        fatalError("Неверный формат входной строки.")
    }
    dateFormatter.dateFormat = outputDateFormat
    let outputDateString = dateFormatter.string(from: date)
    return outputDateString
}
func dateFormatSmall( date: String) -> String {
    let inputDateFormat = "yyyy-MM-dd"
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = inputDateFormat
    guard let date = dateFormatter.date(from: date) else {
        fatalError("Неверный формат входной строки.")
    }
    dateFormatter.dateFormat = "d"
    var outputDateString = dateFormatter.string(from: date)
    dateFormatter.dateFormat = "MMM"
    outputDateString = "\(outputDateString) \(dateFormatter.string(from: date).prefix(3))"
    return outputDateString
}
func getAge(date: String) -> String {
    let inputDateFormat = "yyyy-MM-dd"
    let outputDateFormat = "dd MMMM yyyy"

    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = inputDateFormat

    guard let dateOfBirth = dateFormatter.date(from: date) else {
        fatalError("Неверный формат входной строки.")
    }
    dateFormatter.dateFormat = outputDateFormat
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
    guard let age = ageComponents.year else {
        fatalError("Ошибка при вычислении возраста.")
    }
    let ageWord = correctWordForYear(age)
    return "\(age) \(ageWord)"
}
// MARK: - Data formate
func transformString(_ string: String) -> String {
    switch string {
    case "ios":
        return "iOS"
    case "qa":
        return "QA"
    case "hr":
        return "HR"
    case "pr":
        return "PR"
    case "back_office":
        return "Back Office"
    default:
        return string.prefix(1).uppercased() + string.dropFirst()
    }
}
