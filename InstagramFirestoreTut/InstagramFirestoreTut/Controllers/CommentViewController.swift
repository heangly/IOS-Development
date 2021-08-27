//
//  CommentViewController.swift
//  InstagramFirestoreTut
//
//  Created by Heang Ly on 8/25/21.
//

import UIKit

class CommentViewController: UICollectionViewController {
    //MARK: - Properties
    private let post: Post
    private var user: User?
    private var comments = [Comment]()

    private lazy var commentInputView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
        let cv = CommentInputAccessoryView(frame: frame)
        cv.delegate = self
        return cv
    }()

    //MARK: - Lifecycle
    init(post: Post) {
        self.post = post
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1, height: 1   )
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommentViewControllerUI()
        fetchUser()
        fetchComments()
    }

    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }

    override var canBecomeFirstResponder: Bool { return true }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    //MARK: - API
    func fetchUser() {
        UserService.fetchUser { self.user = $0 }
    }
    
    func fetchComments(){
        CommentService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    //MARK: - Helpers
    func configureCommentViewControllerUI() {
        title = "Comments"
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CommentCell.reusuableIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }

}

//MARK: - UICollectionView DataSource
extension CommentViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.reusuableIdentifier, for: indexPath) as! CommentCell
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}


//MARK: - UICollectionViewDelegate
extension CommentViewController: CommentInputAccessoryViewDelegate {
    func inputView(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String) {
      
        guard let user = user else { return }
        showLoader(true)
        
        CommentService.uploadComment(comment: comment, postID: post.postId, user: user) {error in
            self.showLoader(false)
            inputView.clearCommentTextView()
        }
    }
}
