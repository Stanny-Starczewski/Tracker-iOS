import UIKit

final class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private lazy var pages: [UIViewController] = {
        let firstPage = UIViewController()
        firstPage.view.backgroundColor = .ypBlue
        let secondPage = UIViewController()
        secondPage.view.backgroundColor = .ypRed
        return [firstPage, secondPage]
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .ypBlackDay
        button.setTitle("Вот это технологии!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueView()
        configureConstraints()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        return pages[nextIndex]
    }
    
    @objc
    private func buttonTapped() {
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
// MARK: - EXTENSIONS
extension OnboardingViewController {
    func configueView() {
        dataSource = self
        delegate = self
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
        view.addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            enterButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

//MARK: - SHOW PREVIEW

//import SwiftUI
//struct CreateOnboardingVC: PreviewProvider {
//    static var previews: some View {
//        OnboardingViewController().showPreview()
//    }
//}
