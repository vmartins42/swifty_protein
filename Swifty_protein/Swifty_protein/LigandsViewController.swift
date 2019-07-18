//
//  LigandsViewController.swift
//  Swifty_protein
//
//  Created by Victor MARTINS on 4/24/19.
//  Copyright © 2019 Victor MARTINS. All rights reserved.
//

import UIKit

class LigandsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var ligandTableView: UITableView!
    
    var arrayLigands: [String] = []
    var ligandsFile = ""
    var searchLigand = [String]()
    var searching = false
    var myIndex = 0
    var myElemTab = ""
    var showAlert : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileURLProject = Bundle.main.url(forResource: "ligands", withExtension: "txt")
        do {
            ligandsFile = try String(contentsOf: fileURLProject!)
        }catch let error as NSError {
            print("pas encore", error)
        }
        self.showAlert = false
        arrayLigands = ligandsFile.lines
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchLigand.count
        } else {
            return arrayLigands.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "LigandCell") as? LigandsTableViewCell
        if searching {
            cell?.ligands = searchLigand[indexPath.row]
        } else {
            cell?.ligands = arrayLigands[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        if searching {
            myElemTab = searchLigand[indexPath.row]
        }else {
            myElemTab = arrayLigands[indexPath.row]
        }
        let name = myElemTab
        if let nurl = NSURL(string: "https://files.rcsb.org/ligands/download/\(name)_model.pdb") {
            print(nurl)
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            let request = NSMutableURLRequest(url: nurl as URL)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                } else if let d = data {
                    print("ici",String(decoding: d, as: UTF8.self).components(separatedBy: "\n"))
                    if String(decoding: d, as: UTF8.self).contains("404") {
                        self.showAlert = true
                        DispatchQueue.main.async {
                            self.viewDidAppear(true)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ligandSegue", sender: (name: name, data: String(decoding: d, as: UTF8.self).components(separatedBy: "\n")))
                        }
                    }
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                }.resume()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLigand = arrayLigands.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        ligandTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ligandSegue" {
            if let destitation = segue.destination as? SceneViewController{
                let sender = sender as! (name: String, data: [String])
                destitation.contentPDB = sender.data
                destitation.name = sender.name
            }
        }
    }
    
    @IBAction func unwindToLigandsList(segue: UIStoryboardSegue) {
        print("IM BACK")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.showAlert == true {
            self.showAlert = false
            let alertController = UIAlertController(title: "Error 👨🏻‍🔬", message: "We can't find this Ligand actually! 🙀", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK 😭", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}


extension String {
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}
