//
//  Album.swift
//  AlbumList
//
//  Created by Joanne Cheng on 16/2/2021.
//  Copyright © 2021 Joanne Cheng. All rights reserved.
//

import Foundation

@objc
class Album: NSObject, Codable {
    
    var amgArtistId: Int?
    var artistId: Int?
    var artistName: String?
    var artistViewUrl: String?
    var artworkUrl100: String?
    var artworkUrl60: String?
    var collectionCensoredName: String?
    var collectionExplicitness: String?
    var collectionId: Int?
    var collectionName: String?
    var collectionPrice: Double?
    var collectionType: String?
    var collectionViewUrl: String?
    var copyright: String?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var releaseDate: String?
    var trackCount: Int?
    var wrapperType: String?
    
    init(dictionary:[String : Any]){
        if let amgArtistId = dictionary["amgArtistId"] as? Int{
            self.amgArtistId = amgArtistId
        }
        if let artistId = dictionary["artistId"] as? Int{
            self.artistId = artistId
        }
        if let artistName = dictionary["artistName"] as? String{
            self.artistName = artistName
        }
        if let artistViewUrl = dictionary["artistViewUrl"] as? String{
            self.artistViewUrl = artistViewUrl
        }
        if let artworkUrl100 = dictionary["artworkUrl100"] as? String{
            self.artworkUrl100 = artworkUrl100
        }
        if let artworkUrl60 = dictionary["artworkUrl60"] as? String{
            self.artworkUrl60 = artworkUrl60
        }
        if let collectionCensoredName = dictionary["collectionCensoredName"] as? String{
            self.collectionCensoredName = collectionCensoredName
        }
        if let collectionExplicitness = dictionary["collectionExplicitness"] as? String{
            self.collectionExplicitness = collectionExplicitness
        }
        if let collectionId = dictionary["collectionId"] as? Int{
            self.collectionId = collectionId
        }
        if let collectionName = dictionary["collectionName"] as? String{
            self.collectionName = collectionName
        }
        if let collectionPrice = dictionary["collectionPrice"] as? Double{
            self.collectionPrice = collectionPrice
        }
        if let collectionType = dictionary["collectionType"] as? String{
            self.collectionType = collectionType
        }
        if let collectionViewUrl = dictionary["collectionViewUrl"] as? String{
            self.collectionViewUrl = collectionViewUrl
        }
        if let copyright = dictionary["copyright"] as? String{
            self.copyright = copyright
        }
        if let country = dictionary["country"] as? String{
            self.country = country
        }
        if let currency = dictionary["currency"] as? String{
            self.currency = currency
        }
        if let primaryGenreName = dictionary["primaryGenreName"] as? String{
            self.primaryGenreName = primaryGenreName
        }
        if let releaseDate = dictionary["releaseDate"] as? String{
            self.releaseDate = releaseDate
        }
        if let trackCount = dictionary["trackCount"] as? Int{
            self.trackCount = trackCount
        }
        if let wrapperType = dictionary["wrapperType"] as? String{
            self.wrapperType = wrapperType
        }
        
    }
}
