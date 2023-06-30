import UIKit

 protocol CategoryFormViewControllerDelegate: AnyObject {
     func didConfirm(_ data: TrackerCategory.Data)
 }

 final class CategoryFormViewController: UIViewController {
     // MARK: - UI Lazy properties
     private lazy var textField: UITextField = {
         let textField = TextField(placeholder: NSLocalizedString("CategoryFormViewController.textField", comment: "Enter"))
         textField.addTarget(self, action: #selector(didChangedTextField), for: .editingChanged)
         return textField
     }()
     
     private lazy var readyButton: UIButton = {
         let button = UIButton()
         button.backgroundColor = .ypGray
         button.setTitleColor(.ypWhiteDay, for: .normal)
         button.setTitle(NSLocalizedString("TrackerFormViewController.ready", comment: "Ready"), for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         button.layer.cornerRadius = 16
         button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
         button.isEnabled = false
         return button
     }()

     // MARK: - Properties
     weak var delegate: CategoryFormViewControllerDelegate?
     private var data: TrackerCategory.Data
     private var isConfirmButtonEnabled: Bool = false {
         willSet {
             readyButton.backgroundColor = newValue ? .ypBlackDay : .ypGray
             readyButton.isEnabled = newValue ? true : false
         }
     }

     // MARK: - Lifecycle
     init(data: TrackerCategory.Data = TrackerCategory.Data()) {
         self.data = data
         super.init(nibName: nil, bundle: nil)
         textField.text = data.label
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     override func viewDidLoad() {
         super.viewDidLoad()
         configureView()
         configureConstraints()
     }

     // MARK: - Actions
     @objc
     private func didChangedTextField(_ sender: UITextField) {
         if let text = sender.text, !text.isEmpty {
             data.label = text
             isConfirmButtonEnabled = true
         } else {
             isConfirmButtonEnabled = false
         }
     }

     @objc
     private func didTapButton() {
         delegate?.didConfirm(data)
     }
 }

 // MARK: - Layout methods
 private extension CategoryFormViewController {
     func configureView() {
         title = NSLocalizedString("CategoryFormViewController.configureView", comment: "New")
         view.backgroundColor = .ypWhiteDay
         [textField, readyButton].forEach { view.addSubview($0) }
         
         readyButton.translatesAutoresizingMaskIntoConstraints = false
         textField.translatesAutoresizingMaskIntoConstraints = false
     }

     func configureConstraints() {
         NSLayoutConstraint.activate([
             textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
             textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
             textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
             textField.heightAnchor.constraint(equalToConstant: ListOfItems.height),
             readyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
             readyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
             readyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
             readyButton.heightAnchor.constraint(equalToConstant: 60)
         ])
     }
 }
