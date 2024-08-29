//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by mac on 29/08/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init () {}
    
    func saveImage(image: UIImage,imageName: String,folderName: String) {
        
        //create Folder
        createFolderIfNeeded(folderName: folderName)
        
        //get image path
        guard let data = image.pngData(),
              let url = getUrlForImage(imageName: imageName, folderName: folderName) else { return }
        
        //save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error while saving image")
        }
    }
    
    func getImage(fileName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: fileName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
                
        
    }
    func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error while creating folder \(error)")
            }
        }
        
        
    }
    
    private func getUrlForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let url = getUrlForFolder(folderName: folderName) else { return nil }
        return url.appendingPathComponent(imageName)
    }
}
