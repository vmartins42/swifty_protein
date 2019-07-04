//
//  LigandsTableViewCell.swift
//  Swifty_protein
//
//  Created by Victor MARTINS on 4/29/19.
//  Copyright © 2019 Victor MARTINS. All rights reserved.
//

import UIKit

class LigandsTableViewCell: UITableViewCell {

    @IBOutlet weak var ligandLabel: UILabel!
    
    var ligands: String? {
        didSet {
            if let ligand = ligands {
                ligandLabel?.text = ligand
            }
        }
    }
}
