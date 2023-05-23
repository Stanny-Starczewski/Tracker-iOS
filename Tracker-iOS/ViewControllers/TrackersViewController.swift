import UIKit

final class TrackersViewController: UIViewController {
    // MARK: - UI Lazy properties
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
        button.tintColor = .ypBlackDay
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .ypWhiteDay
        datePicker.tintColor = .ypBlue
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar = Calendar(identifier: .iso8601)
        datePicker.addTarget(self, action: #selector(didChangedDatePicker), for: .valueChanged)
        return datePicker
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .ypWhiteDay
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
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Фильтры", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 16
        button.backgroundColor = .ypBlue
        return button
    }()
    
    //MARK: - Properties
    
    private let mainSpacePlaceholderStack = UIStackView()
    private let searchSpacePlaceholderStack = UIStackView()
    private let trackerLabel = UILabel()
    private var currentDate = Date()
    private let params = UICollectionView.GeometricParams(cellCount: 2, leftInset: 16, rightInset: 16, topInset: 8, bottomInset: 16, height: 148, cellSpacing: 10)
    private var categories: [TrackerCategory] = TrackerCategory.mockData {
        didSet {
            checkMainPlaceholderVisability()
        }
    }
    private var completedTrackers: Set<TrackerRecord> = []
    private var searchText = ""
    private var visibleCategories: [TrackerCategory] {
        let weekday = Calendar.current.component(.weekday, from: currentDate)
        
        var result = [TrackerCategory]()
        for category in categories {
            let trackersByDay = category.trackers.filter { tracker in
                guard let schedule = tracker.schedule else { return true }
                return schedule.contains(WeekDay.allCases[weekday > 1 ? weekday - 2 : weekday + 5])
            }
            if searchText.isEmpty && !trackersByDay.isEmpty {
                result.append(TrackerCategory(label: category.label, trackers: trackersByDay))
            } else {
                let filteredTrackers = trackersByDay.filter { tracker in
                    tracker.label.lowercased().contains(searchText.lowercased())
                }
                
                if !filteredTrackers.isEmpty {
                    result.append(TrackerCategory(label: category.label, trackers: filteredTrackers))
                }
            }
        }
        if result.isEmpty {
            filterButton.isHidden = true
        } else {
            filterButton.isHidden = false
        }
        return result
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        trackerLabel.configureLabel(
            text: "Трекеры",
            addToView: view,
            ofSize: 34,
            weight: .bold
        )
        mainSpacePlaceholderStack.configurePlaceholderStack(imageName: "StarIcon", text: "Что будем отслеживать?")
        searchSpacePlaceholderStack.configurePlaceholderStack(imageName: "EmptyTracker", text: "Ничего не найдено")
        checkMainPlaceholderVisability()
        checkPlaceholderVisabilityAfterSearch()
    }
    
    // MARK: - Actions
    @objc
    private func didTapPlusButton() {
        
        let setTrackersViewController = SetTrackersViewController()
        setTrackersViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: setTrackersViewController)
        present(navigationController, animated: true)
         
    }
    
    @objc
    private func didChangedDatePicker(_ sender: UIDatePicker) {
        currentDate = Date.from(date: sender.date)!
        collectionView.reloadData()
    }
    
    // MARK: - Methods
    private func checkMainPlaceholderVisability() {
        let isHidden = visibleCategories.isEmpty && searchSpacePlaceholderStack.isHidden
        mainSpacePlaceholderStack.isHidden = !isHidden
    }
    
    private func checkPlaceholderVisabilityAfterSearch() {
        let isHidden = visibleCategories.isEmpty && searchBar.text != ""
        searchSpacePlaceholderStack.isHidden = !isHidden
    }
}
// MARK: - EXTENSIONS
 //MARK: - Layout methods
private extension TrackersViewController {
    func configureViews() {
        view.backgroundColor = .ypWhiteDay
        [trackerLabel, addButton, datePicker, searchBar, collectionView, mainSpacePlaceholderStack, searchSpacePlaceholderStack, filterButton].forEach { view.addSubview($0) }
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        trackerLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        mainSpacePlaceholderStack.translatesAutoresizingMaskIntoConstraints = false
        searchSpacePlaceholderStack.translatesAutoresizingMaskIntoConstraints = false
        filterButton.translatesAutoresizingMaskIntoConstraints = false

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            trackerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1083),
            trackerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            datePicker.widthAnchor.constraint(equalToConstant: 120),
            datePicker.centerYAnchor.constraint(equalTo: trackerLabel.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.07019),
            searchBar.topAnchor.constraint(equalTo: trackerLabel.bottomAnchor, constant: 7),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 34),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainSpacePlaceholderStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.495),
            mainSpacePlaceholderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchSpacePlaceholderStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.495),
            searchSpacePlaceholderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            filterButton.widthAnchor.constraint(equalToConstant: 114),
            filterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
//MARK: - UICollectionViewDelegate
extension TrackersViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
 extension TrackersViewController: UICollectionViewDataSource {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         checkMainPlaceholderVisability()
         return visibleCategories.count
     }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return visibleCategories[section].trackers.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let trackerCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.identifier, for: indexPath) as? TrackerCell else {
             return UICollectionViewCell()
         }

         let tracker = visibleCategories[indexPath.section].trackers[indexPath.row]
         let daysCount = completedTrackers.filter { $0.trackerId == tracker.id }.count
         let isCompleted = completedTrackers.contains { $0.date == currentDate && $0.trackerId == tracker.id }
         trackerCell.configure(with: tracker, days: daysCount, isCompleted: isCompleted)
         trackerCell.delegate = self
         return trackerCell
     }
 }

// MARK: - UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let availableSpace = collectionView.frame.width - params.paddingWidth
        let cellWidth = availableSpace / params.cellCount
        return CGSize(width: cellWidth, height: params.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        UIEdgeInsets(top: params.topInset, left: params.leftInset, bottom: params.bottomInset, right: params.rightInset)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "header",
                for: indexPath
            ) as? TrackerCategoryNames
        else { return UICollectionReusableView() }
        
        let label = visibleCategories[indexPath.section].label
        view.configure(with: label)
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
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
        dismiss(animated: true)
        let trackerFormViewController = TrackerFormViewController(type: type)
        trackerFormViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: trackerFormViewController)
        present(navigationController, animated: true)
    }
}

extension TrackersViewController: TrackerFormViewControllerDelegate {
    func didTapConfirmButton(categoryLabel: String, trackerToAdd: Tracker) {
        dismiss(animated: true)
        guard let categoryIndex = categories.firstIndex(where: { $0.label == categoryLabel }) else { return }
        let updatedCategory = TrackerCategory(
            label: categoryLabel,
            trackers: categories[categoryIndex].trackers + [trackerToAdd]
        )
        categories[categoryIndex] = updatedCategory
        collectionView.reloadData()
    }
    
    func didTapCancelButton() {
        dismiss(animated: true)
    }
}

// MARK: - UISearchBarDelegate
 extension TrackersViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        checkPlaceholderVisabilityAfterSearch()
        searchBar.setShowsCancelButton(true, animated: true)
         return true
     }

     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         self.searchText = searchText
         collectionView.reloadData()
         checkPlaceholderVisabilityAfterSearch()
     }

     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.text = ""
         self.searchText = ""
         searchBar.endEditing(true)
         searchBar.setShowsCancelButton(false, animated: true)
         searchBar.resignFirstResponder()
         collectionView.reloadData()
         checkPlaceholderVisabilityAfterSearch()
     }
 }
// MARK: - TrackerCellDelegate
 extension TrackersViewController: TrackerCellDelegate {
     func didTapCompleteButton(of cell: TrackerCell, with tracker: Tracker) {
         let trackerRecord = TrackerRecord(trackerId: tracker.id, date: currentDate)

         if completedTrackers.contains(where: { $0.date == currentDate && $0.trackerId == tracker.id }) {
             completedTrackers.remove(trackerRecord)
             cell.switchAddDayButton(to: false)
             cell.decreaseCount()
         } else {
             completedTrackers.insert(trackerRecord)
             cell.switchAddDayButton(to: true)
             cell.increaseCount()
         }
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
