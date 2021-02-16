//
//  ListTableViewCell.swift
//  AlbumList
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblArtist: UILabel!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Init
    func initUI(){
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.lblTitle.textColor = UIColor.black
        self.lblArtist.textColor = UIColor.black
    }
    
    // MARK: - Reset
    func reset(){
        self.lblTitle.text = ""
        self.lblArtist.text = ""
        self.imgCover.image = nil
    }
    
    func loadData(model : Album) {
        self.lblTitle.text = model.collectionName
        self.lblArtist.text = model.artistName
        if let s = model.artworkUrl60{
            let url = URL(string:s )
            let data = try? Data(contentsOf: url!)
            self.imgCover.image = UIImage(data: data!)
        }
    }
}
