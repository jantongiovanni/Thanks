//
//  ProfessionViewController.swift
//  Thanks
//
//  Created by JoesMac on 7/24/18.
//  Copyright © 2018 JoesMac. All rights reserved.
//

import UIKit
import RAMReel
import Parse

class ProfessionViewController: UIViewController, UICollectionViewDelegate {
    
    var dataSource: SimplePrefixQueryDataSource!
    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = SimplePrefixQueryDataSource(data)
        
        ramReel = RAMReel(frame: view.bounds, dataSource: dataSource, placeholder: "Your Profession...", attemptToDodgeKeyboard: true) {
            print("Plain:", $0)
        }
        
        ramReel.hooks.append {
//            let r = Array($0.reversed())
//            let j = String(r)
//            print("Reversed:", j)
            let profession = $0
            PFUser.current()
            
        }
        
        view.addSubview(ramReel.view)
        ramReel.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    fileprivate let data: [String] = {
        do {
            guard let dataPath = Bundle.main.path(forResource: "data", ofType: "txt") else {
                return []
            }
            
            let data = try WordReader(filepath: dataPath)
            return data.words
        }
        catch let error {
            print(error)
            return []
        }
    }()
}
