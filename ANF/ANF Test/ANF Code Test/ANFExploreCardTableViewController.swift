//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
     let viewModel = ProductViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: ProductCardTC.identifire, bundle: nil), forCellReuseIdentifier: ProductCardTC.identifire)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
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
        cell.configure(with: product) { [weak self] in
            guard let self = self else { return  }
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
}
