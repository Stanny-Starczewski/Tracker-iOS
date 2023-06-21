import UIKit

final class StatisticViewController: UIViewController {
    // MARK: - Properties UI
    private let statisticLabel = UILabel()
    private let mainSpacePlaceholderStack = UIStackView()
    private let statisticsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    // MARK: - Properties
    var statisticViewModel: StatisticViewModel?
    private let trackerRecordStore = TrackerRecordStore()
    private let completedTrackersView = StatisticView(name: NSLocalizedString("StatisticViewController.finishedTrackers", comment: "Finished trackers"))
    private let trackerStore = TrackerStore()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        statisticLabel.configureLabel(
            text: (NSLocalizedString("StatisticViewController.title", comment: "")),
            addToView: view,
            ofSize: 34,
            weight: .bold
        )
        configureViews()
        configureConstraints()
        mainSpacePlaceholderStack.configurePlaceholderStack(imageName: "EmptyStat", text: (NSLocalizedString("StatisticViewController.nothingToAnalyze", comment: "")))
        statisticViewModel?.onTrackersChange = { [weak self] trackers in
            guard let self else { return }
            self.checkContent(with: trackers)
            self.setupCompletedTrackersBlock(with: trackers.count)
            checkMainPlaceholderVisability()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statisticViewModel?.viewWillAppear()
    }
    
    // MARK: - Methods
    private func setupCompletedTrackersBlock(with count: Int) {
        completedTrackersView.setNumber(count)
    }
    
    private func checkMainPlaceholderVisability() {
        let isHidden = trackerStore.numberOfTrackers == 0
        mainSpacePlaceholderStack.isHidden = !isHidden
    }
    
    private func checkContent(with trackers: [TrackerRecord]) {
        if trackers.isEmpty {
            statisticsStack.isHidden = true
        } else {
            statisticsStack.isHidden = false
        }
    }
}

// MARK: - EXTENSIONS
// MARK: - Layout methods
private extension StatisticViewController {
    func configureViews() {
        [statisticLabel, mainSpacePlaceholderStack, statisticsStack].forEach { view.addSubview($0) }
        statisticsStack.addArrangedSubview(completedTrackersView)
        statisticLabel.translatesAutoresizingMaskIntoConstraints = false
        mainSpacePlaceholderStack.translatesAutoresizingMaskIntoConstraints = false
        statisticsStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        statisticLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        statisticLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1083),
        mainSpacePlaceholderStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.495),
        mainSpacePlaceholderStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        statisticsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        statisticsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        statisticsStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

final class StatisticView: UIView {
    // MARK: - Layout elements
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    // MARK: - Properties
    private var number: Int {
        didSet {
            numberLabel.text = "\(number)"
        }
    }
    private var name: String {
        didSet {
            nameLabel.text = name
        }
    }
    
    // MARK: - Lifecycle
    required init(number: Int = 0, name: String) {
        self.number = number
        self.name = name
        
        super.init(frame: .zero)
        setNumber(number)
        setName(name)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorder()
    }
    
    // MARK: - Functions
    func setNumber(_ number: Int) {
        self.number = number
    }
    
    func setName(_ name: String) {
        self.name = name
    }
}

// MARK: - Layout methods
extension StatisticView {
    
    func configureViews() {
        translatesAutoresizingMaskIntoConstraints = false
        [numberLabel, nameLabel].forEach { addSubview($0) }
    }
    
    func setupBorder() {
        gradientBorder(
            width: 1,
            colors: UIColor.gradient,
            startPoint: .unitCoordinate(.left),
            endPoint: .unitCoordinate(.right),
            andRoundCornersWithRadius: 12
        )
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: numberLabel.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
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
