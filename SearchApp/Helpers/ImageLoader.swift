//
//  ImageLoader.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import Foundation
import UIKit

class LazyImageView: UIImageView
{

    private let imageCache = NSCache<AnyObject, UIImage>()

    func loadImage(fromURL imageURL: URL, placeHolderImage: String)
    {
        self.image = UIImage(named: placeHolderImage)

        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject)
        {
            print("image loaded from cache for =\(imageURL)")
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async {
            [weak self] in

            if let imageData = try? Data(contentsOf: imageURL)
            {
                print("image downloaded from server...")
                if let image = UIImage(data: imageData)
                {
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
