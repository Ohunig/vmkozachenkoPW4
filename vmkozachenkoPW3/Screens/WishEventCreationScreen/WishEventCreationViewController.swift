//
//  WishEventCreationViewController.swift
//  vmkozachenkoPW3
//
//  Created by User on 18.01.2026.
//

import Foundation
import UIKit

final class WishEventCreationViewController: UIViewController {
    typealias Model = WishEventCreationModels
    
    private struct Constants {
        static let fatalError = "init(coder:) has not been implemented"
    }
    
    private let interactor: WishEventCreationBusinessLogic
    
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    
    private var titleText = "" {
        didSet {
            validateForm()
        }
    }
    
    private var descriptionText = "" {
        didSet {
            validateForm()
        }
    }
    
    private var startDate: Date? {
        didSet {
            validateForm()
        }
    }
    
    private var endDate: Date? {
        didSet {
            validateForm()
        }
    }
    
    // MARK: Lifecycle
    
    init(interactor: WishEventCreationBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Display updates
    
    func displayStart(_ viewModel: Model.Start.ViewModel) {
        let color = UIColor(
            red: viewModel.red,
            green: viewModel.green,
            blue: viewModel.blue,
            alpha: viewModel.alpha
        )
        view.backgroundColor = color
    }
    
    // MARK: Previous validate
    
    private func validateForm() {
        let isTitleValid = !titleText.trimmingCharacters(in: .whitespaces).isEmpty
        let isDescriptionValid = !descriptionText.trimmingCharacters(in: .whitespaces).isEmpty
        var isDatesValid = false
        guard startDate != nil && endDate != nil else {
            isDatesValid = false
            // todo
            return
        }
        // startDate <= endDate
    }
}
