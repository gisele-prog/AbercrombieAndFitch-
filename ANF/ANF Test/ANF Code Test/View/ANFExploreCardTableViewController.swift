
import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    
    let viewModel: ProductViewModel
    
    // Initializer for dependency injection
    init(viewModel: ProductViewModel = ProductViewModel()) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ProductViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchProducts()
    }
    
    // Setup TableView properties and register cell
    private func setupTableView() {
        tableView.register(UINib(nibName: ProductCardTC.identifier, bundle: nil),
                           forCellReuseIdentifier: ProductCardTC.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }
    
    // Fetch products from ViewModel
    @objc private func fetchProducts() {
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
    
    // Observe for app going to foreground (for refreshing)
    private func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchProducts),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
        
    }
    
    // Cleanup observers on deinit to prevent memory leaks
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // Show error alert when there's an issue
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCardTC.identifier, for: indexPath) as? ProductCardTC else {
            return UITableViewCell() // Handle if we can't dequeue the correct type of cell
        }
        
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product) { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
}


