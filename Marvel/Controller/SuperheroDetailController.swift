//
//  SuperheroDetailController.swift
//  Marvel
//
//  Created by Toni De Gea on 18/04/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit

class SuperheroDetailController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var bttnInfo: UIButton!
    
    
    var superheroDetail: Result? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = superheroDetail?.name
        fillDescription()
        let url: String = (superheroDetail?.thumbnail.path)!
        let url2: String = ".\((superheroDetail?.thumbnail.thumbnailExtension)!)"
        let url3: String = url + url2
        let urlFinal = URL(string: url3)
        
        if let urlImg = urlFinal {
            downloadImage(url: urlImg)
        }
        
        bttnInfo.layer.cornerRadius = 20.0
    }
    
    
    @IBAction func bttnInfo(_ sender: Any) {
        
        if let url = NSURL(string: "http://www.marvel.com"){
            UIApplication.shared.open(url as URL)
           }
    }
    
    func fillDescription() {
        if superheroDetail?.description == "" {
            descriptionLabel.text = "There's no description right now, we're sorry!"
        } else {
            descriptionLabel.text = superheroDetail?.description
        }
    }
    
    func downloadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.thumbnail.image = UIImage.init(data: data!)
            }
        }
    .resume()
    }

    
}



