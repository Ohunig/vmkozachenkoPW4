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
        static let horizontalPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let fieldHeight: CGFloat = 44
        static let verticalSpacing: CGFloat = 12
        
        static let titleFieldPlaceholder = "Title"
        static let descriptionFieldPlaceholder = "Description"
        
        static let datePickersHeight: CGFloat = 160
        
        static let saveButtonText = "Save"
        static let saveButtonTextSize: CGFloat = 16
        static let saveButtonDisabledAlpha: CGFloat = 0.5
        
        static let labelsTextSize: CGFloat = 14
        static let startLabelText = "Start"
        static let endLabelText = "End"
        
        static let stackTop: CGFloat = 20
        
        static let dateHoursSpace: Int = 1
        
        static let buttonColorAnimationDur: CGFloat = 0.15
    }

    private let interactor: WishEventCreationBusinessLogic

    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()

    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()

    private let saveButton = UIButton(type: .system)
    
    private var stackView: UIStackView?

    private var titleText = "" {
        didSet { validateForm() }
    }

    private var descriptionText = "" {
        didSet { validateForm() }
    }

    private var startDate: Date? {
        didSet { validateForm() }
    }

    private var endDate: Date? {
        didSet { validateForm() }
    }
    
    weak var eventCreationDelegate: WishEventCreationDelegate?

    // MARK: Lifecycle

    init(interactor: WishEventCreationBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        interactor.start()
    }

    // MARK: Configure UI
    
    private func configureUI() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        configureTextFields()
        configureDatePickers()
        configureSaveButton()
        configureStack()
        configureDefaults()
    }
    
    private func configureTextFields() {
        // Title field
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.titleFieldPlaceholder,
            attributes: [
                .foregroundColor: UIColor.gray
            ]
        )
        titleTextField.backgroundColor = .white
        titleTextField.textColor = .black
        titleTextField.borderStyle = .roundedRect
        titleTextField.returnKeyType = .done
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.addTarget(
            self,
            action: #selector(titleChanged(_:)),
            for: .editingChanged
        )

        // Description field
        descriptionTextField.attributedPlaceholder = NSAttributedString(
            string: Constants.descriptionFieldPlaceholder,
            attributes: [
                .foregroundColor: UIColor.gray
            ]
        )
        descriptionTextField.backgroundColor = .white
        descriptionTextField.textColor = .black
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.returnKeyType = .done
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.addTarget(
            self,
            action: #selector(descriptionChanged(_:)),
            for: .editingChanged
        )
        
        NSLayoutConstraint.activate(
            [
                titleTextField.heightAnchor.constraint(
                    equalToConstant: Constants.fieldHeight
                ),
                descriptionTextField.heightAnchor.constraint(
                    equalToConstant: Constants.fieldHeight
                )
            ]
        )
    }
    
    private func configureDatePickers() {
        startDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.preferredDatePickerStyle = .wheels
        startDatePicker.datePickerMode = .dateAndTime
        endDatePicker.datePickerMode = .dateAndTime
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.tintColor = .white
        endDatePicker.tintColor = .white
        
        startDatePicker.addTarget(
            self,
            action: #selector(startDateChanged(_:)),
            for: .valueChanged
        )
        endDatePicker.addTarget(
            self,
            action: #selector(endDateChanged(_:)),
            for: .valueChanged
        )
        
        NSLayoutConstraint.activate(
            [
                startDatePicker.heightAnchor.constraint(
                    equalToConstant: Constants.datePickersHeight
                ),
                endDatePicker.heightAnchor.constraint(
                    equalToConstant: Constants.datePickersHeight
                )
            ]
        )
    }
    
    private func configureSaveButton() {
        saveButton.setTitle(Constants.saveButtonText, for: .normal)
        saveButton.layer.cornerRadius = Constants.cornerRadius
        saveButton.titleLabel?.font = .systemFont(
            ofSize: Constants.saveButtonTextSize,
            weight: .semibold
        )
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .orange
        saveButton.isEnabled = false
        saveButton.alpha = Constants.saveButtonDisabledAlpha
        
        saveButton.addTarget(
            self,
            action: #selector(saveTapped),
            for: .touchUpInside
        )
        
        saveButton.heightAnchor.constraint(
            equalToConstant: Constants.fieldHeight
        ).isActive = true
    }

    private func configureStack() {
        let startLabel = UILabel()
        startLabel.text = Constants.startLabelText
        startLabel.textColor = .orange
        startLabel.font = .systemFont(
            ofSize: Constants.labelsTextSize,
            weight: .medium
        )
        let endLabel = UILabel()
        endLabel.text = Constants.endLabelText
        endLabel.textColor = .orange
        endLabel.font = .systemFont(
            ofSize: Constants.labelsTextSize,
            weight: .medium
        )
        let titleLabel = UILabel()
        titleLabel.text = Constants.titleFieldPlaceholder
        titleLabel.textColor = .orange
        titleLabel.font = .systemFont(
            ofSize: Constants.labelsTextSize,
            weight: .medium
        )
        let descriptionLabel = UILabel()
        descriptionLabel.text = Constants.descriptionFieldPlaceholder
        descriptionLabel.textColor = .orange
        descriptionLabel.font = .systemFont(
            ofSize: Constants.labelsTextSize,
            weight: .medium
        )

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            titleTextField,
            descriptionLabel,
            descriptionTextField,
            startLabel,
            startDatePicker,
            endLabel,
            endDatePicker,
            saveButton
        ])
        stack.axis = .vertical
        stack.spacing = Constants.verticalSpacing
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        
        NSLayoutConstraint.activate(
            [
                stack.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: Constants.horizontalPadding
                ),
                stack.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -Constants.horizontalPadding
                ),
                stack.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Constants.stackTop
                )
            ]
        )

        self.stackView = stack
    }

    private func configureDefaults() {
        let now = Date()
        startDatePicker.date = now
        endDatePicker.date = Calendar.current.date(
            byAdding: .hour,
            value: Constants.dateHoursSpace,
            to: now
        ) ?? now
        startDate = startDatePicker.date
        endDate = endDatePicker.date
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
        saveButton.setTitleColor(color, for: .normal)
    }

    // MARK: Actions

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func titleChanged(_ tf: UITextField) {
        titleText = tf.text ?? ""
    }

    @objc
    private func descriptionChanged(_ tf: UITextField) {
        descriptionText = tf.text ?? ""
    }

    @objc
    private func startDateChanged(_ picker: UIDatePicker) {
        startDate = picker.date
        if let end = endDate, picker.date > end {
            endDatePicker.date = picker.date
            endDate = picker.date
        }
    }

    @objc
    private func endDateChanged(_ picker: UIDatePicker) {
        endDate = picker.date
        if let start = startDate, picker.date < start {
            startDatePicker.date = picker.date
            startDate = picker.date
        }
    }

    @objc private func saveTapped() {
        interactor.loadAddEvent(
            Model.CreateEvent.Request(
                title: titleText,
                description: descriptionText,
                start: startDate ?? Date(),
                end: endDate ?? Date()
            )
        )
        eventCreationDelegate?.wishEventCreated()
    }

    // MARK: Previous validate

    private func validateForm() {
        let isTitleValid = !titleText.trimmingCharacters(in: .whitespaces).isEmpty
        let isDescriptionValid = !descriptionText.trimmingCharacters(in: .whitespaces).isEmpty

        guard let start = startDate, let end = endDate else {
            setSave(enabled: false)
            return
        }

        let isDatesValid = start <= end

        setSave(enabled: isTitleValid && isDescriptionValid && isDatesValid)
    }

    private func setSave(enabled: Bool) {
        saveButton.isEnabled = enabled
        UIView.animate(withDuration: Constants.buttonColorAnimationDur) {
            self.saveButton.alpha = enabled ? 1.0 : Constants.saveButtonDisabledAlpha
        }
    }
}
