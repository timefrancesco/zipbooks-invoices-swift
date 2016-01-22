//
//  User.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 11/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import RealmSwift
import ObjectMapper

import Foundation

class Expense: Object,Mappable {
    dynamic var id: Int = 0
    dynamic var name: String?
	dynamic var created_at: String?
	dynamic var billed: Int = 0
	dynamic var plaid_transaction_id: String?
	dynamic var customer_id: Int = 0
	dynamic var category: String?
	dynamic var date: String?
	dynamic var customer: Customer?
	dynamic var bank_account_id: Int = 0
	dynamic var image_filename: String?
	dynamic var meta: String?
	dynamic var type: String?
	dynamic var deleted_at: String?
	dynamic var pending: String?
	dynamic var note: String?
	dynamic var updated_at: String?
	dynamic var line_item_id: Int = 0
	dynamic var account_id: Int = 0
	dynamic var archived_at: String?
	dynamic var amount: String?
	dynamic var currency_code: String?
	dynamic var category_id: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
	// MARK: Mappable
	required convenience init?(_ map: Map) {
		self.init()
	}

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
		created_at <- map["created_at"]
		billed <- map["billed"]
		plaid_transaction_id <- map["plaid_transaction_id"]
		customer_id <- map["customer_id"]
		category <- map["category"]
		date <- map["date"]
		customer <- map["customer"]
		bank_account_id <- map["bank_account_id"]
		image_filename <- map["image_filename"]
		meta <- map["meta"]
		type <- map["type"]
		deleted_at <- map["deleted_at"]
		pending <- map["pending"]
		note <- map["note"]
		updated_at <- map["updated_at"]
		line_item_id <- map["line_item_id"]
		account_id <- map["account_id"]
		archived_at <- map["archived_at"]
		amount <- map["amount"]
		currency_code <- map["currency_code"]
		category_id <- map["category_id"]
	}
}

class ExpensePost: Object,Mappable {
    dynamic var amount: Double = 0
    dynamic var date: String?
    dynamic var customer_id: Int = 0
    dynamic var name: String?
    dynamic var category: String?
    dynamic var note: String?
        
    // MARK: Mappable
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        date <- map["date"]
        customer_id <- map["customer_id"]
        name <- map["name"]
        category <- map["category"]
        note <- map["note"]
    }
}