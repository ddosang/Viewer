//
//  MainViewController.swift
//  Viewer
//
//  Created by 임은지 on 2023/03/13.
//

import UIKit
import UniformTypeIdentifiers

class MainViewController: BaseViewController {

    @IBOutlet weak var uploadFileButton: UIButton!
    
    @IBAction func uploadFile(_ sender: Any) {
        let supportedTypes: [UTType] = [UTType.data]
        let documentPickerVC = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        documentPickerVC.delegate = self
        documentPickerVC.allowsMultipleSelection = false
        documentPickerVC.modalPresentationStyle = .formSheet
        self.present(documentPickerVC, animated: true)
        
//        MessageViewModel.fetchMsg()
    }
    
    let viewModel = MessageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        MessageViewModel.storeMsg()
    }

    override func setup() {
        uploadFileButton.setTitle("파일 업로드", for: .normal)
    }
}

extension MainViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        parseCSV(with: urls.first!)
        
        let vc = ChatListViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
    
    func parseCSV(with url: URL) {
        do {
            let data = try Data(contentsOf: url)
            guard let dataEncoded = String(data: data, encoding: .utf8) else { return }
            
            var arr = dataEncoded.components(separatedBy: "\r\n")
            
            // 맨 마지막 한 줄이 비어있다면 삭제.
            if let last = arr.last,
               last == "" {
                arr.removeLast()
            }
            
            // 구분자 | 로 분리.
            let separated = arr.map ({ $0.components(separatedBy: "|") })
            
            // Message 객체로 만들기
            self.viewModel.messageList = separated.compactMap { Message(data: $0) }
        } catch {
            print("Error reading CSV file")
        }
    }
    
    // 날짜별로 쪼개서 [[Message]] 형태로 만들어서 core data 에 저장.
    // core data 에서 읽어올 땐 어쩌지...? 다 읽어야됨...?
}
