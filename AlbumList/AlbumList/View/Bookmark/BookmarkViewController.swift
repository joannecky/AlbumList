//
//  BookmarkViewController.swift
//  AlbumList
//
//  Created by Joanne Cheng on 17/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblNoRecord: UILabel!

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
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    // MARK: - Setup
    func setup(){
        setupNavigationBar()
        setupTableView()
        setupContent()
    }
    
    func setupTableView(){
        tableview.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.reloadData()
    }
    
    func setupContent(){
        if(UserDefaultsBookmark.shared.getBookmarkList().count == 0){
            tableview.isHidden = true
            lblNoRecord.isHidden = false
            lblNoRecord.text = "No record"
        }
    }
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Bookmark"
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

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsBookmark.shared.getBookmarkList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.reset()
        cell.loadData(model: UserDefaultsBookmark.shared.getBookmarkList()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = DetailViewController()
        vc.model = UserDefaultsBookmark.shared.getBookmarkList()[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


