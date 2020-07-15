//
//  ViewController.swift
//  NSArchiving
//
//  Created by mac admin on 13/07/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    var userName:String
    
    init(userName:String, address:String) {
          self.userName = userName
      }
    
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey: "userName")
    }
    
    required init?(coder: NSCoder) {
        self.userName = coder.decodeObject(forKey: "userName") as! String
    }
    
}

class ViewController: UIViewController {
    
    var tempPath = "qwrs"
    var obj = [User]()
     var obj1 = [User]()
    
    var dataa:Data?
    
    let u1 = User(userName: "kunal", address: "Bangalore")
    let u2 = User(userName: "Rakesh", address: "Pune")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        obj = [u1, u2]
        archivingData()
        unArchiveData()
    }
    
    func archivingData() {
        
        let fullPath = getDocumentsDirectory().appendingPathComponent(tempPath)
        print(fullPath)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: obj, requiringSecureCoding: false)
            print(data)
            dataa = data //storing
            try data.write(to : fullPath)
            
        } catch let err {
            print(err)
        }
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func unArchiveData() {
        do {
//             let loadedArray  = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [User.self], from: dataa!) as! [User]
            let loadedArray  = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataa!)  as! [User]
            print(loadedArray)
                obj1 = loadedArray
                print(obj1)
            
        } catch let err {
            print(err)
        }
    }


}

