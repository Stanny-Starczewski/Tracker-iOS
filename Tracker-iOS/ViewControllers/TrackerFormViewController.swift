//import UIKit
//
// protocol TrackerFormViewControllerDelegate: AnyObject {
//     func didTapCancelButton()
//     func didTapConfirmButton()
// }
//
// final class TrackerFormViewController: UIViewController {
//     // MARK: - Layout elements
//     
//     private lazy var textField: UITextField = {
//         textField.placeholder = "Введите название трекера"
//         textField.addTarget(self, action: #selector(didChangedLabelTextField), for: .editingChanged)
//         return textField
//     }()
//     private let validationMessage: UILabel = {
//         let label = UILabel()
//         label.translatesAutoresizingMaskIntoConstraints = false
//         label.font = UIFont.systemFont(ofSize: 17)
//         label.textColor = .red
//         label.text = "Ограничение 38 символов"
//         return label
//     }()
//     private let parametersTableView: UITableView = {
//         let table = UITableView()
//         table.translatesAutoresizingMaskIntoConstraints = false
//         table.separatorStyle = .none
//         table.isScrollEnabled = false
//         table.register(ListCell.self, forCellReuseIdentifier: ListOfItems.identifier)
//         return table
//     }()
//     private lazy var cancelButton: UIButton = {
//         let button = makeButton()
//         button.setTitle("Отменить", for: .normal)
//         button.setTitleColor(.Red, for: .normal)
//         button.backgroundColor = .white
//         button.layer.borderWidth = 1
//         button.layer.borderColor = UIColor.Red.cgColor
//         button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
//         return button
//     }()
//     private lazy var confirmButton: UIButton = {
//         let button = makeButton()
//         button.setTitle("Создать", for: .normal)
//         button.setTitleColor(.white, for: .normal)
//         button.backgroundColor = .Gray
//         button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
//         button.isEnabled = false
//         return button
//     }()
//     private let buttonsStack: UIStackView = {
//         let stack = UIStackView()
//         stack.translatesAutoresizingMaskIntoConstraints = false
//         stack.spacing = 8
//         stack.distribution = .fillEqually
//         return stack
//     }()
//
//     // MARK: - Properties
//     
//     weak var delegate: TrackerFormViewControllerDelegate?
//     private let type: SetTrackersViewController.TrackerType
//
//     private var tracker: Tracker?
//
//     private var labelText = "" {
//         didSet {
//             checkFromValidation()
//         }
//     }
//     private var category: String? = TrackerCategory.sampleData[0].label {
//         didSet {
//             checkFromValidation()
//         }
//     }
//     private var schedule: [WeekDay]? {
//         didSet {
//             checkFromValidation()
//         }
//     }
//     private var emoji: String? {
//         didSet {
//             checkFromValidation()
//         }
//     }
//     private var color: UIColor? {
//         didSet {
//             checkFromValidation()
//         }
//     }
//
//     private var isConfirmButtonEnabled: Bool = false {
//         willSet {
//             if newValue {
//                 confirmButton.backgroundColor = .black
//                 confirmButton.isEnabled = true
//             } else {
//                 confirmButton.backgroundColor = .gray
//                 confirmButton.isEnabled = false
//             }
//         }
//     }
//
//     private var isValidationMessageVisible = false {
//         didSet {
//             checkFromValidation()
//             if isValidationMessageVisible {
//                 validationMessageHeightConstraint?.constant = 22
//                 parametersTableViewTopConstraint?.constant = 32
//             } else {
//                 validationMessageHeightConstraint?.constant = 0
//                 parametersTableViewTopConstraint?.constant = 16
//             }
//         }
//     }
//     private var validationMessageHeightConstraint: NSLayoutConstraint?
//     private var parametersTableViewTopConstraint: NSLayoutConstraint?
//     private let parameters = ["Категория", "Расписание"]
//     private let emojis = emojisArray
//     private let colors = UIColor.bunchOfSChoices
//
//     // MARK: - Lifecycle
//     
//     init(type: SetTrackersViewController.TrackerType) {
//         self.type = type
//         switch type {
//         case .habit:
//             schedule = []
//         case .irregularEvent:
//             schedule = nil
//         }
//         super.init(nibName: nil, bundle: nil)
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     private var collectionViewHeightConstraint: NSLayoutConstraint!
//
//     override func viewDidLoad() {
//         super.viewDidLoad()
//
//         setupContent()
//         setupConstraints()
//
//         emoji = emojis.randomElement()
//         color = colors.randomElement()
//
//         checkFromValidation()
//     }
//
//     // MARK: - Actions
//     
//     @objc
//     private func didChangedLabelTextField(_ sender: UITextField) {
//         guard let text = sender.text else { return }
//         labelText = text
//         if text.count > 38 {
//             isValidationMessageVisible = true
//         } else {
//             isValidationMessageVisible = false
//         }
//     }
//
//     @objc
//     private func didTapCancelButton() {
//         delegate?.didTapCancelButton()
//     }
//
//     @objc
//     private func didTapConfirmButton() {
//         guard let category, let emoji, let color else { return }
//
//         let newTracker = Tracker(
//             label: labelText,
//             emoji: emoji,
//             color: color,
//             schedule: schedule
//         )
//
//         TrackerCategory.sampleData[0].trackers.append(newTracker)
//
//         delegate?.didTapConfirmButton()
//     }
//
//     // MARK: - Methods
//     private func checkFromValidation() {
//         if labelText.count == 0 {
//             isConfirmButtonEnabled = false
//             return
//         }
//
//         if isValidationMessageVisible {
//             isConfirmButtonEnabled = false
//             return
//         }
//
//         if category == nil || emoji == nil || color == nil {
//             isConfirmButtonEnabled = false
//             return
//         }
//
//         if let schedule, schedule.isEmpty {
//             isConfirmButtonEnabled = false
//             return
//         }
//
//         isConfirmButtonEnabled = true
//     }
//     
//     private func makeButton() -> UIButton {
//         let button = UIButton()
//         button.translatesAutoresizingMaskIntoConstraints = false
//         button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//         button.layer.cornerRadius = 16
//         button.layer.masksToBounds = true
//         return button
//     }
// }
//
// // MARK: - Layout methods
// private extension TrackerFormViewController {
//     func setupContent() {
//         switch type {
//         case .habit: title = "Новая привычка"
//         case .irregularEvent: title = "Новое нерегулярное событие"
//         }
//
//         parametersTableView.dataSource = self
//         parametersTableView.delegate = self
//
//         view.backgroundColor = .white
//         view.addSubview(textField)
//         view.addSubview(validationMessage)
//         view.addSubview(parametersTableView)
//         view.addSubview(buttonsStack)
//         buttonsStack.addArrangedSubview(cancelButton)
//         buttonsStack.addArrangedSubview(confirmButton)
//     }
//
//     func setupConstraints() {
//         validationMessageHeightConstraint = validationMessage.heightAnchor.constraint(equalToConstant: 0)
//         parametersTableViewTopConstraint = parametersTableView.topAnchor.constraint(equalTo: validationMessage.bottomAnchor, constant: 16)
//         validationMessageHeightConstraint?.isActive = true
//         parametersTableViewTopConstraint?.isActive = true
//
//         NSLayoutConstraint.activate([
//             // textField
//             textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//             textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
//             textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//             textField.heightAnchor.constraint(equalToConstant: 75),
//             // validationMessage
//             validationMessage.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
//             validationMessage.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
//             // parametersTableView
//             parametersTableView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
//             parametersTableView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
//             parametersTableView.heightAnchor.constraint(equalToConstant: schedule == nil ? ListCell.height : 2 *  ListCell.height),
//             // buttonsStack
//             buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//             buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//             buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//             buttonsStack.heightAnchor.constraint(equalToConstant: 60)
//         ])
//     }
// }
//
// // MARK: - UITableViewDataSource
// extension TrackerFormViewController: UITableViewDataSource {
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         if schedule == nil {
//             return 1
//         }
//         return 2
//     }
//
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         guard let listCell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell
//         else { return UITableViewCell() }
//
//         var position: ListOfItems.Position
//         var value: String? = nil
//
//         if schedule == nil {
//             position = .alone
//             value = category
//         } else {
//             position = indexPath.row == 0 ? .first : .last
//             value = indexPath.row == 0 ? category : nil
//         }
//
//         listCell.configure(label: parameters[indexPath.row], value: value, position: position)
//         return listCell
//     }
// }
//
// // MARK: - UITableViewDelegate
// extension TrackerFormViewController: UITableViewDelegate {
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         // TODO: - handle selection
//     }
//
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//         75
//     }
// }
