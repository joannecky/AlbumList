//
//  MainViewModel.swift
//  AlbumList
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

class UserDefaultsBookmark: NSObject{
    
    public static let shared = UserDefaultsBookmark()
    let key: String = "Bookmark"
    
    public func getBookmarkList() -> [Album]{
        if UserDefaults.standard.object(forKey: key) != nil {
            if let savedUserData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let savedUser = try? decoder.decode([Album].self, from: savedUserData) {
                    return savedUser
                }
            }
        }
        saveBookmarkList(list: [])
        return []
    }
    
    func saveBookmarkList(list: [Album]){
        let encoder = JSONEncoder()
        if let encodedModel = try? encoder.encode(list) {
            UserDefaults.standard.set(encodedModel, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    public func checkIfBookmarked(model: Album) -> Bool{
        var list = getBookmarkList()
        for l in list{
            if l.collectionId == model.collectionId{
                return true
            }
        }
        return false
    }
    
    public func addBookmark(model: Album){
        var list = getBookmarkList()
        list.append(model)
        saveBookmarkList(list: list)
    }
    
    public func removeBookmark(model: Album){
        var list = getBookmarkList()
        for i in 0..<list.count{
            if list[i].collectionId == model.collectionId{
                list.remove(at: i)
                saveBookmarkList(list: list)
                return
            }
        }
    }
}
