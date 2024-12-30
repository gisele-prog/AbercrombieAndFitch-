//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    private var productData: [ProductCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: ProductCardTC.identifire, bundle: nil), forCellReuseIdentifier:  ProductCardTC.identifire)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        fetchData()
    }
    
    private func fetchData() {
        ProductCardService.shared.fetchPromotions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.productData = products
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching promotions: \(error)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCardTC.identifire, for: indexPath) as? ProductCardTC else {
            return UITableViewCell()
        }
        cell.configure(with: self.productData[indexPath.row])
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
        
        return cell
    }
}
