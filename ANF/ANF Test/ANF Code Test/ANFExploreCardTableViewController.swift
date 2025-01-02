//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import Combine

class ANFExploreCardTableViewController: UITableViewController {
    private let viewModel = ProductViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: ProductCardTC.identifire, bundle: nil), forCellReuseIdentifier: ProductCardTC.identifire)
       fetchProducts()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshPromotions),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    private func fetchProducts() {
        viewModel.fetchProducts { [weak self] error in
            if let error = error {
                self?.showErrorAlert(message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func refreshPromotions() {
       fetchProducts()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCardTC.identifire, for: indexPath) as? ProductCardTC else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
        
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "exploreContentCell", for: indexPath)
//        if let titleLabel = cell.viewWithTag(1) as? UILabel,
//           let titleText = exploreData?[indexPath.row]["title"] as? String {
//            titleLabel.text = titleText
//        }
//        
//        if let imageView = cell.viewWithTag(2) as? UIImageView,
//           let name = exploreData?[indexPath.row]["backgroundImage"] as? String,
//           let image = UIImage(named: name) {
//            imageView.image = image
//        }

    }
}
