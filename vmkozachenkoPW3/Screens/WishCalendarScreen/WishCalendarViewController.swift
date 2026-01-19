//
//  WishCalendarViewController.swift
//  vmkozachenkoPW3
//
//  Created by User on 17.01.2026.
//

import Foundation
import UIKit

final class WishCalendarViewController: UIViewController {
    typealias Model = WishCalendarModels
    
    private struct Constants {
        static let fatalError = "init(coder:) has not been implemented"
        
        static let horisontalInset: CGFloat = 20
        static let collectionInsets = UIEdgeInsets(
            top: 20,
            left: horisontalInset,
            bottom: 20,
            right: horisontalInset
        )
        
        static let collectionItemHeight: CGFloat = 150
        
        static let backButtonText = "Back"
        static let newButtonText = "New"
    }
    
    private let interactor: WishCalendarBusinessLogic
    
    private var backButton: CustomBarButton = CustomBarButton()
    private var newButton: CustomBarButton = CustomBarButton()
    
    private let wishEventCollection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let wishCalendarDataSource: WishCalendarDataSource
    
    // MARK: Lifecycle
    
    init(
        interactor: WishCalendarBusinessLogic,
        calendarDataSource: WishCalendarDataSource
    ) {
        self.interactor = interactor
        self.wishCalendarDataSource = calendarDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        interactor.loadStart()
    }
    
    // MARK: Configure UI
    
    private func configureUI() {
        configureNavigationBar()
        configureCollection()
    }
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        backButton = CustomBarButton(type: .system)
        backButton.title = Constants.backButtonText
        backButton.tapped = backButtonTapped
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: backButton
        )
        navigationItem.leftBarButtonItem?.hidesSharedBackground = true
        
        newButton = CustomBarButton(type: .system)
        newButton.title = Constants.newButtonText
        newButton.tapped = newButtonTapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: newButton
        )
        navigationItem.rightBarButtonItem?.hidesSharedBackground = true
    }
    
    private func configureCollection() {
        wishEventCollection.delegate = self
        wishEventCollection.dataSource = self
        wishEventCollection.backgroundColor = .clear
        wishEventCollection.showsVerticalScrollIndicator = false
        wishEventCollection.alwaysBounceVertical = true
        wishEventCollection.contentInset = Constants.collectionInsets
        
        wishEventCollection.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
        wishEventCollection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wishEventCollection)
        
        NSLayoutConstraint.activate(
            [
                wishEventCollection.topAnchor.constraint(equalTo: view.topAnchor),
                wishEventCollection.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                ),
                wishEventCollection.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor
                ),
                wishEventCollection.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor
                )
            ]
        )
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
        backButton.setTitleColor(color, for: .normal)
        newButton.setTitleColor(color, for: .normal)
    }
    
    // MARK: Events
    
    @objc
    private func backButtonTapped() {
        interactor.loadGoToMainScreen()
    }
    
    @objc
    private func newButtonTapped() {
        interactor.loadGoToAddEvent()
    }
}

// MARK: - Collection delegate flow layout ext

extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width - 2 * Constants.horisontalInset
        return CGSize(width: width, height: Constants.collectionItemHeight)
    }
}

// MARK: - Collection data source ext

extension WishCalendarViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        wishCalendarDataSource.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseIdentifier,
            for: indexPath
        )
        guard let eventCell = cell as? WishEventCell else {
            return cell
        }
        guard let event = wishCalendarDataSource.getWishEvent(
            at: indexPath.row
        ) else {
            return eventCell
        }
        eventCell.configure(event)
        return eventCell
    }
}

// MARK: - Event creation delegate ext

extension WishCalendarViewController: WishEventCreationDelegate {
    
    func wishEventCreated() {
        wishEventCollection.reloadData()
    }
}
