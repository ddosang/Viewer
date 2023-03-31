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
        collectionView.register(IdolChatCollectionViewCell.identifier.nib, forCellWithReuseIdentifier: IdolChatCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(DateView.identifier.nib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DateView.identifier)
    }
}

extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DateView.identifier, for: indexPath) as? DateView {
            view.dateLabel.text = "2023년 3월 31일 금요일"
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var estimatedFrame = "2023년 3월 31일 금요일".estimatedFrame(with: 17)
        estimatedFrame.size.height += 5
        
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdolChatCollectionViewCell.identifier, for: indexPath) as? IdolChatCollectionViewCell {
            if indexPath.row == 0 {
                cell.isProfileShowing = true
                cell.nameLabel.text = viewModel.messageList[indexPath.row].nickname
            } else if viewModel.messageList[indexPath.row - 1].date.timeString != viewModel.messageList[indexPath.row].date.timeString {
                cell.isProfileShowing = true
                cell.nameLabel.text = viewModel.messageList[indexPath.row].nickname
            }
            
            
            cell.messageLabel.text = viewModel.messageList[indexPath.row].message
            cell.timeLabel.text = viewModel.messageList[indexPath.row].date.timeString
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdolChatCollectionViewCell.identifier, for: indexPath) as? IdolChatCollectionViewCell {
            var estimatedFrame = viewModel.messageList[indexPath.row].message.estimatedFrame(with: 17)
            estimatedFrame.size.height += 10 // messageView height
            
            if indexPath.row == 0 {
                estimatedFrame.size.height += 25 // nameLabel height
            } else if viewModel.messageList[indexPath.row - 1].date.timeString != viewModel.messageList[indexPath.row].date.timeString {
                estimatedFrame.size.height += 25
            }
            
            return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 10) // cell height
        }
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    
}
