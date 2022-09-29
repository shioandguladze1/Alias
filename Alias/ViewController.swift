//
//  ViewController.swift
//  Alias
//
//  Created by shio andghuladze on 29.09.22.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    private let dbPath = "raw/words.db"

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = WordsDataBaseHelper.shared.readWords(table: "words_ge")
        print(data)
    }
    
    

    


}
