//
//  CustomBackBarButton.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation
import UIKit

final class CustomBarButton: UIButton {
    
    private struct Constants {
        static let fatalError = "init(coder:) has not been implemented"
        
        static let barButtonfontSize: CGFloat = 16
        static let barButtonCornerRadius: CGFloat = 8
        static let barButtonHeight: CGFloat = 32
        static let barButtonWidth: CGFloat = 64
    }
    
    var tapped: (() -> Void)?
    
    var title = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        self.titleLabel?.font = .systemFont(
            ofSize: Constants.barButtonfontSize,
            weight: .regular
        )

        self.backgroundColor = .orange
        self.layer.cornerRadius = Constants.barButtonCornerRadius
        self.layer.masksToBounds = true

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(
                    equalToConstant: Constants.barButtonHeight
                ),
                self.widthAnchor.constraint(
                    equalToConstant: Constants.barButtonWidth
                )
            ]
        )

        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: Button tapped
    
    @objc
    private func buttonTapped() {
        tapped?()
    }
}
