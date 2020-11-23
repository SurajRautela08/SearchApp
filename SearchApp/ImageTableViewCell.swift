//
//  ImageTableViewCell.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: LazyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.cellImage.image = UIImage(data: data)
             }
          }
       }).resume()
    }
    
}
