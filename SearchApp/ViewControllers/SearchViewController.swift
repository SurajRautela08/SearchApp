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
        self.searchTextField.text = nil
        keyword = nil

    }
    

    @IBAction func searchButtonAction(_ sender: Any) {
        searchTextField.endEditing(true)
        
        if keyword == nil {
            alert(message: "Please Enter some keyword to search")
        } else {
            if let keyword = keyword {
                postRequest(keyword : keyword)

            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }

        if identifier == searchResultsidentifier {
            if let vc = segue.destination as? SearchResultsViewController {
            vc.imageArray = self.imageArray
            }
        }
    }
    
    
}

extension SearchViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == searchTextField {
            keyword = textField.text
        }
    }
}


extension SearchViewController {
    
    func alert(message : String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func postRequest(keyword : String) {
        
        let session = URLSession.shared
        let url = URL(string: "https://pixabay.com/api/?key=\(key)&q=\(keyword)&image_type=photo")!
        
        self.activityIndicator.startAnimating()
        
        let task = session.dataTask(with: url) { data, response, error in
        
            
            if error != nil || data == nil {
                self.alert(message: "error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.alert(message: "Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                self.alert(message: "Wrong MIME type!")
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
                    
                    if self.imageArray.count == 0 {
                        self.alert(message : "No Data Found with this Keyword")
                    } else {
                        self.performSegue(withIdentifier: self.searchResultsidentifier, sender: self)
                    }

                }
            } catch {
                self.alert(message: "JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
    
}
