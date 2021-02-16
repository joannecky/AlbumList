//
//  DetailViewController.swift
//  AlbumList
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var btnBookmark: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    
    @IBOutlet weak var lblfGenre: UILabel!
    @IBOutlet weak var lblvGenre: UILabel!

    @IBOutlet weak var lblfTrackCount: UILabel!
    @IBOutlet weak var lblvTrackCount: UILabel!

    @IBOutlet weak var lblfPrice: UILabel!
    @IBOutlet weak var lblvPrice: UILabel!

    @IBOutlet weak var lblfReleaseDate: UILabel!
    @IBOutlet weak var lblvReleaseDate: UILabel!
    
    @IBOutlet weak var lblCopyright: UILabel!
    
    var model: Album? = nil
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    func setup(){
        setupNavigationBar()
        setupLayout()
        setupContent()
    }
    
    func setupLayout(){
        btnBookmark.setImage(UIImage(systemName: "bookmark") , for: .normal)
        lblfGenre.text = "Genre: "
        lblfTrackCount.text = "Track Count: "
        lblfPrice.text = "Price: "
        lblfReleaseDate.text = "Release Date: "
    }
    
    func setupContent(){
        if let s = model?.artworkUrl100{
            let url = URL(string:s )
            let data = try? Data(contentsOf: url!)
            self.imgCover.image = UIImage(data: data!)
        }
        
        lblTitle.text = model?.collectionName
        lblTitle.numberOfLines = 0
        lblTitle.sizeToFit()
        lblArtist.text = model?.artistName
        lblArtist.numberOfLines = 0
        lblArtist.sizeToFit()
        
        lblvGenre.text = model?.primaryGenreName
        if let c = model?.trackCount{
            lblvTrackCount.text = String(c)
        }
        if let c = model?.currency, let p = model?.collectionPrice{
            lblvPrice.text = c + " " + String(p)
        }
        if let r = model?.releaseDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: r)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            lblvReleaseDate.text = dateFormatter.string(from: date)
        }
        lblCopyright.text = model?.copyright
        lblCopyright.numberOfLines = 0
        lblCopyright.sizeToFit()
        
        if let m = model, UserDefaultsBookmark.shared.checkIfBookmarked(model: m){
            btnBookmark.setImage(UIImage(systemName: "bookmark.fill") , for: .normal)
        }else{
            btnBookmark.setImage(UIImage(systemName: "bookmark") , for: .normal)
        }
    }
    
    @IBAction func pressBookmark(_ sender: Any) {
        if let m = model{
            if UserDefaultsBookmark.shared.checkIfBookmarked(model: m){
                btnBookmark.setImage(UIImage(systemName: "bookmark") , for: .normal)
                UserDefaultsBookmark.shared.removeBookmark(model: m)
            }else{
                btnBookmark.setImage(UIImage(systemName: "bookmark.fill") , for: .normal)
                UserDefaultsBookmark.shared.addBookmark(model: m)
            }
        }
    }
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Detail"
        setupNavigationBarLeftBarButton()
    }
    
    private func setupNavigationBarLeftBarButton() {
        let itemButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        itemButton.transform = CGAffineTransform(translationX: -10 , y: 0)
        itemButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        itemButton.widthAnchor.constraint(equalToConstant: itemButton.frame.width).isActive = true
        itemButton.heightAnchor.constraint(equalToConstant: itemButton.frame.height).isActive = true
        itemButton.addTarget(self, action: #selector(ClickBackButton), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: itemButton)
    }
    
    @objc private func ClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
