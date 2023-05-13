import UIKit

final class TrackersViewController: UIViewController {
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .WhiteDay
        datePicker.tintColor = .Blue
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar = Calendar(identifier: .iso8601)
        return datePicker
    }()
    
    private lazy var uiSearchTextField: UISearchTextField = {
        let searchField = UISearchTextField()
        searchField.backgroundColor = .WhiteDay
        searchField.textColor = .BlackDay
        searchField.placeholder = "Поиск"
        searchField.delegate = self
        return searchField
    }()
    
    private let starIcon: UIImageView = {
        let starView = UIImageView()
        starView.image = UIImage(named: "StarIcon")
        return starView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Что будем отслеживать?"
        label.textColor = .BlackDay
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let collectionView: UICollectionView = {
             let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
             view.backgroundColor = .WhiteDay
             return view
         }()
    
    //MARK: - Properties
    
    private var searchText = ""
    private var currentDate = Date()
    
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
        
        let setTrackersViewController = SetTrackersViewController()
        setTrackersViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: setTrackersViewController)
        present(navigationController, animated: true)
         
    }
}

// MARK: - EXTENSIONS
 //MARK: - Layout methods

private extension TrackersViewController {
    func configureViews() {
        view.backgroundColor = .WhiteDay
        [titleLabel, addButton, datePicker, uiSearchTextField, stackView, collectionView].forEach { view.addSubview($0) }
        stackView.addArrangedSubview(starIcon)
        stackView.addArrangedSubview(questionLabel)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        uiSearchTextField.translatesAutoresizingMaskIntoConstraints = false
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            uiSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            uiSearchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            uiSearchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: uiSearchTextField.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - AddTrackerViewControllerDelegate
extension TrackersViewController: SetTrackersViewControllerDelegate {
    func didSelectTracker(with type: SetTrackersViewController.TrackerType) {
    }
}

 //MARK: - UISearchTextFieldDelegate

extension TrackersViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return view.endEditing(true)
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        // reload
    }
}

//// MARK: - SHOW PREVIEW
//
//import SwiftUI
//struct CreateTrackersVCProvider: PreviewProvider {
//    static var previews: some View {
//        TrackersViewController().showPreview()
//    }
//}
