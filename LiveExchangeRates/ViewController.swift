//
//  ViewController.swift
//  LiveExchangeRates
//
//  Created by Eren Elçi on 5.10.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var ratesArray: [(currency: String, rate: Double)] = []

    override func viewDidLoad() {
        
        title = "1 EURO Döviz Değerleri"
        super.viewDidLoad()
        
        let url = URL(string: "https://data.fixer.io/YOURKEY")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, eror) in
            
            if eror != nil {
                let alert = UIAlertController(title: "Hata", message: eror?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true)
            } else {
                if data != nil {
                    self.parseAPI(json: data!)
                }
                
            }
        }
        task.resume()
         
    }
    
    func parseAPI(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonRates = try? decoder.decode(Rates.self, from: json) {
            
            
            for (currency , rate) in jsonRates.rates {
                ratesArray.append((currency,rate))
                
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var context = cell.defaultContentConfiguration()
        let rate = ratesArray[indexPath.row]
        context.text = rate.currency
        context.secondaryText = String(rate.rate)
        cell.contentConfiguration = context
        return cell
    }
}

