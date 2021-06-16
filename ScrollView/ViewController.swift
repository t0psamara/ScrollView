//
//  ViewController.swift
//  ScrollView
//
//  Created by Nikita Petrenkov on 16.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    /// Скролл вью
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// Массив с полями для ввода текста
    @IBOutlet var textFields: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        connectToNotificationCenter()
    }
    
    /// Осуществляется базовая настройка контроллера
    private func configureView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWillBeHidden))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        for textField in textFields {
            textField.addTarget(self, action: #selector(keyboardWillBeHidden), for: .primaryActionTriggered)
        }
    }
    
    // MARK: - Для обработки клавиатуры
    
    /// Подключаемся к центру уведомлений
    private func connectToNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeShowed(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    /// Срабатывает при вызове клавиатуры
    /// - Parameter notifiaction: Сработанное событие
    @objc private func keyboardWillBeShowed(_ notifiaction: NSNotification) {
        guard let info = notifiaction.userInfo,
              let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        scrollView.contentInset.bottom = keyboardHeight
    }
    
    /// Срабатывает при скрытии клавиатуры
    @objc private func keyboardWillBeHidden() {
        scrollView.contentInset.bottom = 0
        view.endEditing(true)
    }
}

