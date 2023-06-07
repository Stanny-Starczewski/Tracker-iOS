import UIKit

final class StatisticViewController: UIViewController {
    // MARK: - UI
    private let statisticLabel = UILabel()
    private let mainSpacePlaceholderStack = UIStackView()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        statisticLabel.configureLabel(
            text: "Статистика",
            addToView: view,
            ofSize: 34,
            weight: .bold
        )
        configureViews()
        configureConstraints()
        mainSpacePlaceholderStack.configurePlaceholderStack(imageName: "EmptyStat", text: "Анализировать пока нечего")
    }
}
// MARK: - EXTENSIONS
// MARK: - Layout methods
private extension StatisticViewController {
    func configureViews() {
        [statisticLabel, mainSpacePlaceholderStack].forEach { view.addSubview($0) }
        statisticLabel.translatesAutoresizingMaskIntoConstraints = false
        mainSpacePlaceholderStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        statisticLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        statisticLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1083),
        mainSpacePlaceholderStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.495),
        mainSpacePlaceholderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - SHOW PREVIEW

//import SwiftUI
//struct CreateStatisticVCProvider: PreviewProvider {
//    static var previews: some View {
//        StatisticViewController().showPreview()
//    }
//}
