//
//  ViewController.swift
//  SimpleApp
//
//  Created by Sam on 09/10/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    public private(set) var errorView = ErrorView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.sizeTableHeaderToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureErrorView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configureErrorView() {
        tableView.tableHeaderView = errorView
        
        errorView.onHide = { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.sizeTableHeaderToFit()
            self?.tableView.endUpdates()
        }
        
        errorView.message = "Error"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension UITableView {
    func sizeTableHeaderToFit() {
        guard let header = tableHeaderView else { return }

        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        let needsFrameUpdate = header.frame.height != size.height
        if needsFrameUpdate {
            header.frame.size.height = size.height
            tableHeaderView = header
        }
    }
}
