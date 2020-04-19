//
//  ViewController.swift
//  Marvel
//
//  Created by Toni De Gea on 16/04/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var superhero: [Result] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let manager = SuperheroManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.rowHeight = 168.0
        fillTableView()
    }
    
    func fillTableView() {
        manager.getSuperheroes { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self?.superhero = data
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superhero.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuperheroCell", for: indexPath) as? SuperheroCell else {
            return UITableViewCell()
        }
        if (indexPath.row < superhero.count) {
            let onesSuperhero = superhero[indexPath.row]
            let path: String = onesSuperhero.thumbnail.path
            let exten: String = ".\(onesSuperhero.thumbnail.thumbnailExtension)"
            let url: String = path + exten
            let urlFinal = URL(string: url)
            
            if let urlImg = urlFinal {
                cell.configureCell(name: onesSuperhero.name, img: urlImg)
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueDetail", sender: indexPath)
    }
}

extension ViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SuperheroDetailController,
            let indexPath = sender as? IndexPath else {
                return
        }

        destination.superheroDetail = superhero[indexPath.row]
    }

}

