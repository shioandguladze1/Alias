//
//  DataBaseHelper.swift
//  Alias
//
//  Created by shio andghuladze on 29.09.22.
//

import SQLite3
import Foundation

class WordsDataBaseHelper{
    static let shared = WordsDataBaseHelper()
    
    private var db: OpaquePointer? = nil

    init(){
        db = openDatabase()
    }
    
    private func openDatabase() -> OpaquePointer?
    {
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "db"){
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
                print("error opening database")
                return nil
            }
            else{
                print("Successfully opened connection to database at \(fileURL.path)")
                return db
            }
        }
        return nil
    }
    
    func readWords(table: String = "db_table_name".localized(), condition: String = "") -> [Word] {
        let queryStatementString = "select id, keyword from \(table) \(condition);"
        var queryStatement: OpaquePointer? = nil
        var words : [Word] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let keyword = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                words.append(Word(id: Int(id), keyword: keyword))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return words
     }
    
}

