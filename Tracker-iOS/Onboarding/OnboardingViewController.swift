import UIKit

final class OnboardingViewController: UIPageViewController {
    
    // MARK: - UI Lazy properties
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
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = pages.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .ypBlackDay
        control.pageIndicatorTintColor = UIColor(red: 0.102, green: 0.106, blue: 0.133, alpha: 0.3)
        return control
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Отслеживайте только то, что хотите"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configueView()
        configureConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func buttonTapped() {
        let tabBar = TabBarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    func animateTextChange(for label: UILabel, newText: String) {
        UIView.transition(with: label, duration: 0.3, animations: {
            label.text = newText
        }, completion: nil)
    }
}

// MARK: - EXTENSIONS
// MARK: - Layout methods
extension OnboardingViewController {
    func configueView() {
        dataSource = self
        delegate = self
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }

        [label, pageControl, enterButton].forEach { view.addSubview($0) }
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -160),
            pageControl.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -24),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            enterButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
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
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
            if currentIndex == 1 {
                animateTextChange(for: label, newText: "Даже если это не литры воды и йога")
            } else {
                animateTextChange(for: label, newText: "Отслеживайте только то, что хотите")
            }
        }
    }
}
//MARK: - SHOW PREVIEW

//import SwiftUI
//struct CreateOnboardingVC: PreviewProvider {
//    static var previews: some View {
//        OnboardingViewController().showPreview()
//    }
//}
