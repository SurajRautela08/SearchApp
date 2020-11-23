//
//  DetailViewController.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import UIKit
import Foundation
class DetailViewController: UIViewController {

    @IBOutlet weak var swipeImageView: LazyImageView!
    
    var imageNames = [String]()



    var currentImage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {


            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if currentImage == imageNames.count - 1 {
                    currentImage = 0

                }else{
                    currentImage += 1
                }
                if let imageUrl = URL(string: imageNames[currentImage]) {
                    swipeImageView.loadImage(fromURL: imageUrl, placeHolderImage: "placeHolderImage")
                }

            case UISwipeGestureRecognizer.Direction.right:
                if currentImage == 0 {
                    currentImage = imageNames.count - 1
                }else{
                    currentImage -= 1
                }
                if let imageUrl = URL(string: imageNames[currentImage]) {
                    swipeImageView.loadImage(fromURL: imageUrl, placeHolderImage: "placeHolderImage")
                }
            default:
                break
            }
        }
    }
    

    

}
