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

class Invoice: Object,Mappable {
    dynamic var id: Int = 0
    dynamic var customer_id: Int = 0
	dynamic var title: String?
	dynamic var date: String?
	dynamic var google_drive_id: String?
	dynamic var recurring_profile_id: String?
	var actions = List<Action> ()
	dynamic var accept_credit_cards: Int = 0
	var items = List<Item>()
	dynamic var updated_at: String?
	dynamic var terms: String?
	dynamic var external_id: String?
	dynamic var archived_at: String?
	dynamic var account_id: Int = 0
	dynamic var estimate_id: String?
	dynamic var status: String?
	dynamic var dwolla_scheduled_transaction_id: String?
	dynamic var notes: String?
	dynamic var created_at: String?
	dynamic var logo_filename: String?
	dynamic var po_number: String?
	dynamic  var total: String?
	dynamic var deleted_at: String?
	dynamic var number: String?
	var payments = List<Payment>() //TODO: not sure
	dynamic var currency_code: String?
	dynamic var discount: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
	// MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        customer_id <- map["customer_id"]
		title <- map["title"]
		date <- map["date"]
		google_drive_id <- map["google_drive_id"]
		recurring_profile_id <- map["recurring_profile_id"]
		actions <- (map["actions"], ArrayTransform<Action>())
		accept_credit_cards <- map["accept_credit_cards"]
		items <- (map["line_items"], ArrayTransform<Item>())
		updated_at <- map["updated_at"]
		terms <- map["terms"]
		external_id <- map["external_id"]
		archived_at <- map["archived_at"]
		account_id <- map["account_id"]
		estimate_id <- map["estimate_id"]
		status <- map["status"]
		dwolla_scheduled_transaction_id <- map["dwolla_scheduled_transaction_id"]
		notes <- map["notes"]
		created_at <- map["created_at"]
		logo_filename <- map["logo_filename"]
		po_number <- map["po_number"]
		total <- map["total"]
		deleted_at <- map["deleted_at"]
		number <- map["number"]
		payments <- (map["payments"], ArrayTransform<Payment>())
		currency_code <- map["currency_code"]
		discount <- map["discount"]
	}
}

class Action: Object,Mappable {
    dynamic var id: Int = 0
    dynamic var created_at: String?
    dynamic var deleted_at: String?
    dynamic var action: String?
    dynamic var updated_at: String?
    dynamic var invoice_id: Int = 0
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        deleted_at <- map["deleted_at"]
        action <- map["action"]
        updated_at <- map["updated_at"]
        invoice_id <- map["invoice_id"]
    }
}

class Item: Object,Mappable {
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var created_at: String?
    dynamic var notes: String?
    dynamic var tax_id: Int = 0
    dynamic var taxes: Taxes? //it should be an array but it's not, ?!
    dynamic var type: String = ""
    dynamic var deleted_at: String?
    dynamic var rate: String?
    dynamic var updated_at: String?
    //var invoice: invoice? I don't think it's needed, we have the info above
    dynamic var quantity: String = ""
    dynamic var invoice_id: Int = 0
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        created_at <- map["created_at"]
        notes <- map["notes"]
        tax_id <- map["tax_id"]
        taxes <- map["taxes"]
        type <- map["type"]
        deleted_at <- map["deleted_at"]
        rate <- map["rate"]
        id <- map["id"]
        updated_at <- map["updated_at"]
      //  invoice <- map["invoice"]
        quantity <- map["quantity"]
        invoice_id <- map["invoice_id"]
    }
}

class Payment: Object,Mappable {
    dynamic var payment:String = ""
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        payment <- map["payments"]
    }
    
}

//TODO: This below are taxes but the API returns them as a single class instead of an array, I hope it will change since if someone has more than 2 taxes,
// there is no way to retrieve them!!!

class Taxes: Object,Mappable {
    dynamic var secondTax: SecondTax?
    dynamic var firstTax: FirstTax?
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        secondTax <- map["2"]
        firstTax <- map["1"]
    }
}

class FirstTax: Object,Mappable  {
    dynamic var rate: String?
    dynamic var number: String?
    dynamic var id: String?
    dynamic var name: String?
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        rate <- map["rate"]
        number <- map["number"]
        id <- map["id"]
        name <- map["name"]
    }
}

class SecondTax: Object,Mappable  {
    dynamic var rate: String?
    dynamic var number: String?
    dynamic var id: String?
    dynamic var name: String?
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        rate <- map["rate"]
        number <- map["number"]
        id <- map["id"]
        name <- map["name"]
    }
}
