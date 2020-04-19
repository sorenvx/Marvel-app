//
//  SuperheroCell.swift
//  Marvel
//
//  Created by Toni De Gea on 17/04/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit

class SuperheroCell: UITableViewCell {
    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 30.0 // las esquinas redondas
        view.configureShadow()
        thumb.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20.0)
        
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func downloadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.thumb.image = UIImage.init(data: data!)
            }
        }
        .resume()
    }
    
    func configureCell(name: String? = nil, img: URL) {
        nameLabel.text = name
        downloadImage(url: img)
        
    }
}



