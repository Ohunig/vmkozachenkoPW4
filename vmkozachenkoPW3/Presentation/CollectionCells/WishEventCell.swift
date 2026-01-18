//
//  WishEventCell.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation
import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier: String = "WishEventCell"
    
    private struct Constants {
        static let fatalError = "init(coder:) has not been implemented"
        
        static let wrapCornerRadius: CGFloat = 16
        static let wrapHorisontalInset: CGFloat = 20
        static let wrapVerticalInset: CGFloat = 16
        
        static let titleFontSize: CGFloat = 32
        static let titleTrailing: CGFloat = 16
        
        static let dateInset: CGFloat = 10
        static let dateFont: CGFloat = 9
        
        static let dateWrapHeight: CGFloat = 32
        
        static let descriprionFontSize: CGFloat = 24
        static let descriptionTop: CGFloat = 12
    }
    
    private let wrapView: UIView = UIView()
    private let dateWrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    
    // MARK: Properties
    
    private var startDate: Date = Date.now
    
    private var endDate: Date = Date.now {
        didSet {
            dateLabel.text = "\(startDate.formatted(date: .numeric, time: .omitted))-\(endDate.formatted(date: .numeric, time: .omitted))"
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    func configure(_ model: WishEventModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.wishDescription
        startDate = model.start ?? Date.now
        endDate = model.end ?? Date.now
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureWrap()
        configureDates()
        configureTitle()
        configureDescription()
    }
    
    private func configureWrap() {
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        wrapView.backgroundColor = .orange
        
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrapView)
        
        NSLayoutConstraint.activate(
            [
                wrapView.leadingAnchor.constraint(
                    equalTo: contentView.leadingAnchor
                ),
                wrapView.trailingAnchor.constraint(
                    equalTo: contentView.trailingAnchor
                ),
                wrapView.topAnchor.constraint(
                    equalTo: contentView.topAnchor
                ),
                wrapView.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor
                )
            ]
        )
    }
    
    private func configureTitle() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(
            ofSize: Constants.titleFontSize,
            weight: .bold
        )
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wrapView.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(
                    equalTo: wrapView.leadingAnchor,
                    constant: Constants.wrapHorisontalInset
                ),
                titleLabel.trailingAnchor.constraint(
                    lessThanOrEqualTo: dateWrapView.leadingAnchor,
                    constant: -Constants.titleTrailing
                ),
                titleLabel.topAnchor.constraint(
                    equalTo: wrapView.topAnchor,
                    constant: Constants.wrapVerticalInset
                )
            ]
        )
    }
    
    private func configureDates() {
        dateWrapView.backgroundColor = .white
        dateWrapView.layer.cornerRadius = Constants.wrapCornerRadius
        
        dateLabel.font = .systemFont(
            ofSize: Constants.dateFont,
            weight: .light
        )
        dateLabel.textColor = .black
        
        dateWrapView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateWrapView.addSubview(dateLabel)
        wrapView.addSubview(dateWrapView)
        
        NSLayoutConstraint.activate(
            [
                // Date label
                dateLabel.leadingAnchor.constraint(
                    equalTo: dateWrapView.leadingAnchor,
                    constant: Constants.dateInset
                ),
                dateLabel.trailingAnchor.constraint(
                    equalTo: dateWrapView.trailingAnchor,
                    constant: -Constants.dateInset
                ),
                dateLabel.centerYAnchor.constraint(
                    equalTo: dateWrapView.centerYAnchor
                ),
                
                // Date wrap
                dateWrapView.topAnchor.constraint(
                    equalTo: wrapView.topAnchor,
                    constant: Constants.wrapVerticalInset
                ),
                dateWrapView.trailingAnchor.constraint(
                    equalTo: wrapView.trailingAnchor,
                    constant: -Constants.wrapHorisontalInset
                ),
                dateWrapView.heightAnchor.constraint(
                    equalToConstant: Constants.dateWrapHeight
                )
            ]
        )
    }
    
    private func configureDescription() {
        descriptionLabel.font = .systemFont(
            ofSize: Constants.descriprionFontSize,
            weight: .regular
        )
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate(
            [
                descriptionLabel.leadingAnchor.constraint(
                    equalTo: wrapView.leadingAnchor,
                    constant: Constants.wrapHorisontalInset
                ),
                descriptionLabel.trailingAnchor.constraint(
                    equalTo: wrapView.trailingAnchor,
                    constant: -Constants.wrapHorisontalInset
                ),
                descriptionLabel.topAnchor.constraint(
                    equalTo: dateWrapView.bottomAnchor,
                    constant: Constants.descriptionTop
                ),
                descriptionLabel.bottomAnchor.constraint(
                    equalTo: wrapView.bottomAnchor,
                    constant: -Constants.wrapVerticalInset
                )
            ]
        )
    }
}
