import UIKit

final class TrackersViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .bold
                )
            )!,
            target: self,
            action: #selector(didTapPlusButton))
        button.tintColor = .BlackDay
        return button
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .WhiteDay
        configureViews()
        configureConstraints()
        
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapPlusButton() {
        print("Plus tapped")
    }
}
 //MARK: - Layout methods

private extension TrackersViewController {
    func configureViews() {
        view.backgroundColor = .WhiteDay
        view.addSubview(titleLabel)
        view.addSubview(addButton)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13)
        ])
    }
}

// MARK: - SHOW PREVIEW

import SwiftUI
struct CreateTrackersVCProvider: PreviewProvider {
    static var previews: some View {
        TrackersViewController().showPreview()
    }
}
