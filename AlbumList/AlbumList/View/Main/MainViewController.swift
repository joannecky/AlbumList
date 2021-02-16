//
//  MainViewController.swift
//  AlbumList
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var tableview: UITableView!
    
    var list: [Album] = [Album]()

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
        loadSource()
        setupTableView()
    }
    
    func setupTableView(){
        tableview.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.reloadData()
    }
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 229/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Album"
        setupNavigationBarRightBarButton()
    }
    
    private func setupNavigationBarRightBarButton() {
        let itemButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        itemButton.widthAnchor.constraint(equalToConstant: itemButton.frame.width).isActive = true
        itemButton.heightAnchor.constraint(equalToConstant: itemButton.frame.height).isActive = true
        itemButton.setImage(UIImage(systemName: "bookmark") , for: .normal)
        itemButton.addTarget(self, action: #selector(ClickBookmarkButton), for: .touchUpInside)
        itemButton.transform = CGAffineTransform(translationX: 10 , y: 0)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: itemButton)
    }
    
    @objc private func ClickBookmarkButton() {
        var vc = BookmarkViewController()
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func loadSource(){
        if let path = Bundle.main.path(forResource: "source", ofType: "txt") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let results = jsonResult["results"] as? [[String : Any]],
                    let resultCount = jsonResult["resultCount"] as? Int{
                    for r in results{
                        list.append(Album(dictionary: r))
                    }
                  }
              } catch {
                   // handle error
              }
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.reset()
        cell.loadData(model: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = DetailViewController()
        vc.model = list[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


