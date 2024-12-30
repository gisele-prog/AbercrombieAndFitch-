//
//  ProductCardTC.swift
//  ANF Code Test
//
//  Created by joie gisele mukamisha on 12/29/24.
//

import UIKit

class ProductCardTC: UITableViewCell {
    // MARK: - All Outlet
    @IBOutlet weak var productImgVw: UIImageView!
    @IBOutlet weak var topDecriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var promoMsgLbl: UILabel!
    @IBOutlet weak var bottomDecriptionLbl: UILabel!
    @IBOutlet weak var buttonStackVw: UIStackView!
    
    // MARK: - Intilizer
    static let identifire = "ProductCardTC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    func setupView() {
        topDecriptionLbl.font = .systemFont(ofSize: 13)
        titleLbl.font = .boldSystemFont(ofSize: 17)
        promoMsgLbl.font = .systemFont(ofSize: 11)
        bottomDecriptionLbl.font = .systemFont(ofSize: 13)
        
    }
    
    func configure(with product: ProductCard) {
        if let url = URL(string: product.backgroundImage ?? "") {
            self.loadAsyncImage(from: url, into: self.productImgVw)
        }
        
        topDecriptionLbl.text = product.topDescription ?? ""
        titleLbl.text = product.title ?? ""
        promoMsgLbl.text = product.promoMessage ?? ""
        bottomDecriptionLbl.text = product.bottomDescription ?? ""
        
        buttonStackVw.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        product.content?.forEach({ item in
            let button = UIButton(type: .system)
            button.setTitle(item.title, for: UIControl.State())
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.addAction(UIAction { _ in
                if let url = URL(string: item.target ?? "") {
                        debugPrint(url)
                    UIApplication.shared.open(url)
                }
                
            }, for: .touchUpInside)
            
            buttonStackVw.addArrangedSubview(button)
            
        })
        
    }
    
    private func loadAsyncImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
                
        }
    }
    
}
