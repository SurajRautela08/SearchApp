//
//  SearchResultsViewController.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let imageCellIdentifier = "imageCell"
    let searchDetailidentifier = "searchDetailVC"
    var imageArray = [String]()
    var currentImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }

        if identifier == searchDetailidentifier {
            if let vc = segue.destination as? DetailViewController {
            vc.imageNames = self.imageArray
            vc.currentImage = self.currentImage
            }
        }
    }
    
    
}

extension SearchResultsViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier, for: indexPath) as! ImageTableViewCell
        
        if let imageUrl = URL(string: imageArray[indexPath.row]) {
            cell.cellImage.loadImage(fromURL: imageUrl, placeHolderImage: "placeHolderImage")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.currentImage = indexPath.row
        self.performSegue(withIdentifier: searchDetailidentifier, sender: self)
    }
    
    
    
}
