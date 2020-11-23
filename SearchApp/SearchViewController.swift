//
//  ViewController.swift
//  SearchApp
//
//  Created by Suraj on 23/11/20.
//  Copyright © 2020 Suraj. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, ActivityIndicatorPresenter{

    @IBOutlet weak var searchTextField: UITextField!
    
    var activityIndicator = UIActivityIndicatorView()
    
    let searchResultsidentifier = "SearchResultsVC"
    
    var keyword : String?
    let key = "19226569-034d4c34652ae3ab87d0fc709"
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchTextField.text = ""
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        searchTextField.endEditing(true)
        postRequest()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }

        if identifier == searchResultsidentifier {
            if let vc = segue.destination as? SearchResultsViewController {
            vc.imageArray = self.imageArray
            }
        }
    }
    
    
    func postRequest() {
        
        let session = URLSession.shared
        let url = URL(string: "https://pixabay.com/api/?key=\(key)&q=\(keyword!)&image_type=photo")!
        
        self.activityIndicator.startAnimating()
        
        let task = session.dataTask(with: url) { data, response, error in
        
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(SearchResult.self, from: data!)
                print(response)
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()

                    for imageUrl in response.hits {
                        self.imageArray.append(imageUrl.userImageURL)
                    }
                    self.performSegue(withIdentifier: self.searchResultsidentifier, sender: self)

                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    
}

extension SearchViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == searchTextField {
            keyword = textField.text
        }
    }
}


