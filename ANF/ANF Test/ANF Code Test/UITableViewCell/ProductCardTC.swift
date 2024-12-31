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
    @IBOutlet weak var productImgVwAsceptRatioConstrain: NSLayoutConstraint!
    
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
        
        buttonStackVw.spacing = 8
        
        topDecriptionLbl.textColor = .darkGray
        titleLbl.textColor = .black
        promoMsgLbl.textColor = .lightGray
    }
    
    func configure(with product: ProductCard) {
        if let url = URL(string: product.backgroundImage ?? "") {
             ImageLoader.shared.loadAsyncImage(from: url, completion: { image in
                 self.productImgVw.image = image
                 self.setProductImage(with: image)
            })
            
        }
        
        topDecriptionLbl.text = product.topDescription ?? ""
        titleLbl.text = product.title ?? ""
        promoMsgLbl.text = product.promoMessage ?? ""
        self.setBottomDescriptionText(product.bottomDescription)
        
        buttonStackVw.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        product.content?.forEach({ item in
            let button = UIButton(type: .system)
            button.setTitle(item.title, for: UIControl.State())
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.frame.size.height = 60
            button.setTitleColor(.darkGray, for: UIControl.State())
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.layer.borderWidth = 1.5
            button.addAction(UIAction { _ in
                if let url = URL(string: item.target ?? "") {
                        debugPrint(url)
                    UIApplication.shared.open(url)
                }
                
            }, for: .touchUpInside)
            
            buttonStackVw.addArrangedSubview(button)
            
        })
        
    }
    
    func setProductImage(with image: UIImage) {
        
        if let aspectRationConstrain = self.productImgVwAsceptRatioConstrain {
            self.productImgVw.removeConstraint(aspectRationConstrain)
        }
        
        let aspectRatio = image.size.width / image.size.height
        if aspectRatio.isFinite {
            productImgVwAsceptRatioConstrain = self.productImgVw.widthAnchor.constraint(equalTo: self.productImgVw.heightAnchor, multiplier: aspectRatio)
        } else {
            productImgVwAsceptRatioConstrain = self.productImgVw.widthAnchor.constraint(equalTo: self.productImgVw.heightAnchor, multiplier: 1)
        }
       
        
        productImgVwAsceptRatioConstrain.isActive = true
        setNeedsLayout()
        
    }
   
    
    func setBottomDescriptionText(_ text: String?) {
        guard let text = text else {
            bottomDecriptionLbl.text = nil
            return
        }
        if let attributedText = convertHTMLToAttributedString(html: text) {
            bottomDecriptionLbl.attributedText = attributedText
            
        } else {
            bottomDecriptionLbl.text = text
        }
    }
    
    /// Convert HTML string to an attributed string
    private func convertHTMLToAttributedString(html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        do {
            
            let attributedString = try NSMutableAttributedString( data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                             .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil )
            
            //attributedString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0, length: attributedString.length))
            
            return attributedString
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
            return nil
        }
    }
    
    
}
