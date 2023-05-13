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
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
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
        return stack
    }()
    
    private let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .WhiteDay
        view.register(
            TrackerCell.self,
            forCellWithReuseIdentifier: TrackerCell.identifier
        )
        view.register(
            TrackerCategoryNames.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
             return view
         }()
    
    //MARK: - Properties
    
    private var currentDate = Date()
    private let params = GeometricParams(cellCount: 2, leftInset: 16, rightInset: 16, cellSpacing: 10)
    private let categories: [TrackerCategory] = TrackerCategory.mockData
    private var searchText = ""
    private var visibleCategories: [TrackerCategory] {
        guard !searchText.isEmpty else {
            if categories.isEmpty {
                stackView.isHidden = false
            } else {
                stackView.isHidden = true
            }
            return categories
        }
        
        var result = [TrackerCategory]()
        for category in categories {
            let filteredTrackers = category.trackers.filter { $0.label.contains(searchText) }
            
            if !filteredTrackers.isEmpty {
                result.append(TrackerCategory(label: category.label, trackers: filteredTrackers))
            }
        }
        
        if result.isEmpty {
            stackView.isHidden = false
        } else {
            stackView.isHidden = true
        }
        
        return result
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    struct GeometricParams {
        let cellCount: CGFloat
        let leftInset: CGFloat
        let rightInset: CGFloat
        let cellSpacing: CGFloat
        let paddingWidth: CGFloat
        
        init(cellCount: CGFloat, leftInset: CGFloat, rightInset: CGFloat, cellSpacing: CGFloat) {
            self.cellCount = cellCount
            self.leftInset = leftInset
            self.rightInset = rightInset
            self.cellSpacing = cellSpacing
            self.paddingWidth = leftInset + rightInset + CGFloat(cellCount - 1) * cellSpacing
        }
    }
    func configureViews() {
        view.backgroundColor = .WhiteDay
        [titleLabel, addButton, datePicker, searchBar, stackView, collectionView].forEach { view.addSubview($0) }
        stackView.addArrangedSubview(starIcon)
        stackView.addArrangedSubview(questionLabel)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
 extension TrackersViewController: UICollectionViewDataSource {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         visibleCategories.count
     }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return categories[section].trackers.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let trackersCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.identifier, for: indexPath) as? TrackerCell else {
             return UICollectionViewCell()
         }

         let tracker = visibleCategories[indexPath.section].trackers[indexPath.row]
         trackersCell.configure(with: tracker)

         return trackersCell
     }
 }

// MARK: - UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let availableSpace = collectionView.frame.width - params.paddingWidth
        let cellWidth = availableSpace / params.cellCount
        return CGSize(width: cellWidth, height: 148)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        UIEdgeInsets(top: 8, left: params.leftInset, bottom: 0, right: params.rightInset)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView
    {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "header",
                for: indexPath
            ) as? TrackerCategoryNames
        else { return UICollectionReusableView() }
        
        let label = categories[indexPath.section].label
        view.configure(with: label)
        
        return view
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        )
        
        return headerView.systemLayoutSizeFitting(
            CGSize(
                width: collectionView.frame.width,
                height: UIView.layoutFittingExpandedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
}
// MARK: - AddTrackerViewControllerDelegate
extension TrackersViewController: SetTrackersViewControllerDelegate {
    func didSelectTracker(with type: SetTrackersViewController.TrackerType) {
    }
}

// MARK: - UISearchBarDelegate
 extension TrackersViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
         return true
     }

     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         self.searchText = searchText
         collectionView.reloadData()
     }

     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.text = ""
         searchBar.endEditing(true)
         searchBar.setShowsCancelButton(false, animated: true)
         self.searchText = ""
         collectionView.reloadData()
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
