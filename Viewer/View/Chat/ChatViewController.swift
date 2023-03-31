//
//  ChatViewController.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit

class ChatViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: MessageViewModel
    
    init(viewModel: MessageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ChatViewController.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = false
        collectionView.register(MeChatCollectionViewCell.identifier.nib, forCellWithReuseIdentifier: MeChatCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
}

extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeChatCollectionViewCell.identifier, for: indexPath) as? MeChatCollectionViewCell {
            cell.messageLabel.text = String(repeating: "t", count: 4 * (indexPath.row + 1))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeChatCollectionViewCell.identifier, for: indexPath) as? MeChatCollectionViewCell {
            var estimatedFrame = String(repeating: "t", count: 4 * (indexPath.row + 1)).estimatedFrame(with: 17)
            estimatedFrame.size.height += 10
            
            return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 10)
        }
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
