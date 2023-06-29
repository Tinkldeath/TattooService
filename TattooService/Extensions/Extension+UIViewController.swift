import UIKit


// MARK: - Input Screen Resize
extension UIViewController {
    
    private static var screenHeight = 0.0
    
    func setupKeyboardLayout() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(disableInTouch))
        self.view.addGestureRecognizer(tap)
        UIViewController.screenHeight = self.view.frame.height
    }
    
    @objc private func keyboardWillAppear(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardValue.cgRectValue
        if self.view.frame.height == UIViewController.screenHeight {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - keyboardFrame.height)
        }
    }
    
    @objc private func keyboardWillDisappear(notification: Notification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIViewController.screenHeight)
    }
    
    @objc private func disableInTouch() {
        self.view.endEditing(true)
    }

}

// MARK: - Presenting
extension UIViewController {
    
    func presentError(_ error: Error) {
        let ac = UIAlertController(title: "Error", message: String(describing: error), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    func presentMessage(_ title: String, _ message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
    func presentMessageWithCompletion(_ title: String, _ message: String, _ completion: @escaping () -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        self.present(ac, animated: true)
    }
    
    func presentLoading() {
        self.view.isUserInteractionEnabled = false
        self.view.alpha = 0.5
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func presentEndLoading() {
        let indicator = self.view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
        self.view.alpha = 1.0
    }
    
}

// MARK: - Navigation
extension UIViewController {
    
    func navigate(storyboardName: String, viewControllerIdentifier: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigate(to: String) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: to) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
