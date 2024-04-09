//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Māris Lakšs on 06/11/2023.
//

import UIKit

// FollowerListVC is a subclass of GFDataLoadingVC superclass
class FollowerListVC: GFDataLoadingVC {
    // Enums are hashable by default
    enum Section {
        case main
    }

    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        // Create an Add (+) button
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        // Add the Add (+) button to the navigation bar
        navigationItem.rightBarButtonItem = addButton
    }

    func configureCollectionView() {
        // Initialize the collectionView
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)
        )
        // Add the collectionView to the view
        view.addSubview(collectionView)
        // Set the delegate
        collectionView.delegate = self
        // Set the collectionView background color
        collectionView.backgroundColor = .systemBackground
        // Register the cell
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }

    func configureSearchController() {
        // Initialize the searchController
        let searchController = UISearchController()
        // Set the searchController delegate
        searchController.searchResultsUpdater = self
        // Set the placeholder
        searchController.searchBar.placeholder = "Search for a username"
        // Set the searchController to the navigationItem
        navigationItem.searchController = searchController
        // Set the search bar to visible
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func getFollowers(username: String, page: Int) {
        // Show the loading view
        showLoadingView()
        // Set isLoadingMoreFollowers to true, then proceed with the network call
        isLoadingMoreFollowers = true
        // This is called 'call site' in Swift
        NetworkManager.shared
            .getFollowers(for: username, page: page) { [weak self] result in
                // [weak self] is a capture list used in closures to avoid strong reference cycles,
                // also known as retain cycles.
                // Unwrap self, as using [weak self] makes it an optional
                guard let self else { return }

                // Dismiss the loading view
                self.dismissLoadingView()

                switch result {
                // In case success, we get an array of followers
                case let .success(followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)

                    // In case the user doesn't have any followers, show the empty state view
                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers. Go follow them 😃."
                        // When presenting a view, remember to switch to main thread
                        // Reason is that this is done on background thread by default
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                    self.updateData(on: self.followers)

                // In case failure, present the alert
                case let .failure(error):
                    self.presentGFAlertOnMainThread(
                        title: "Bad Stuff Happened",
                        message: error.rawValue,
                        buttonTitle: "OK"
                    )
                }

                // Set isLoadingMoreFollowers to false, as the network call has finished
                self.isLoadingMoreFollowers = false
            }
    }

    func configureDataSource() {
        // Initialize the dataSource
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, follower in
                // Initialize the cell
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseID,
                    for: indexPath
                    // Cast default cell to FollowerCell
                ) as! FollowerCell
                // Set the cell data
                cell.set(follower: follower)
                // Return the cell
                return cell
            }
        )
    }

    func updateData(on followers: [Follower]) {
        // Initialize the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // Add the sections
        snapshot.appendSections([.main])
        // Add the items
        snapshot.appendItems(followers)
        // Move from Background to the main thread, to avoid warnings and apply the snapshot
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

    @objc func addButtonTapped() {
        showLoadingView()

        NetworkManager.shared.getUserInfo(for: username) { result in

            // Dismiss the loading view
            self.dismissLoadingView()

            switch result {
            case let .success(user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager
                    .updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                        guard let self else { return }
                        guard let error else {
                            self.presentGFAlertOnMainThread(
                                title: "Success!",
                                message: "User added to Favorites!",
                                buttonTitle: "OK"
                            )
                            return
                        }

                        self.presentGFAlertOnMainThread(
                            title: "Something went wrong",
                            message: error.rawValue,
                            buttonTitle: "OK"
                        )
                    }

            case let .failure(error):
                self.presentGFAlertOnMainThread(
                    title: "Something went wrong",
                    message: error.rawValue,
                    buttonTitle: "OK"
                )
            }
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
        // Get the content offset
        let offsetY = scrollView.contentOffset.y
        // Get the content height
        let contentHeight = scrollView.contentSize.height
        // Get the height of the screen
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            // Guard statement says: make sure that user has more followers & also make sure
            // isLoadingMoreFollowers is false, if not - return
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            // In case both criteria are met, increment the page number & get more followers
            page += 1
            // Start the network call to get more followers
            getFollowers(username: username, page: page)
        }
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Initialize the active array
        //                  W (What)  ?    T (True)       : F (False)
        let activeArray = isSearching ? filteredFollowers : followers
        // Initialize the follower
        let follower = activeArray[indexPath.item]
        // Initialize the udestVC
        let destVC = UserInfoVC()
        // Set the delegate
        destVC.delegate = self
        // Set the username
        destVC.username = follower.login
        // Initialize navController
        let navController = UINavigationController(rootViewController: destVC)
        // Present the destVC
        present(navController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Check if the search bar is empty
        // Use guard let as text: String? { get set } is optional
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        // Filter the followers
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        // Update the data
        updateData(on: filteredFollowers)
    }
}

extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        // Get followers for that user
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)

        if isSearching {
            navigationItem.searchController?.searchBar.text = ""
            navigationItem.searchController?.isActive = false
            navigationItem.searchController?.dismiss(animated: false)
            isSearching = false
        }

        getFollowers(username: username, page: page)
    }
}
