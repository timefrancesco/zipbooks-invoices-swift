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

class Customer: Object,Mappable {
    
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var city: String?
	dynamic var created_at: String?
	dynamic var country: String?
	dynamic var postal_code: String?
	dynamic var plural: String?
	dynamic var stripe_customer_id: String?
	dynamic var email: String?
	dynamic var website: String?
	dynamic var singular: String?
	dynamic var address_2: String?
	dynamic var deleted_at: String?
	dynamic var attention_to: String?
	dynamic var updated_at: String?
	dynamic var address_1: String?
	dynamic var phone: String?
	dynamic var archived_at: String?
	dynamic var account_id: Int = 0
	dynamic var state: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(_ map: Map) {
        self.init()
    }

	//MARK: Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
		city <- map["city"]
		created_at <- map["created_at"]
		country <- map["country"]
		postal_code <- map["postal_code"]
		plural <- map["plural"]
		stripe_customer_id <- map["stripe_customer_id"]
		email <- map["email"]
		website <- map["website"]
		singular <- map["singular"]
		address_2 <- map["address_2"]
		deleted_at <- map["deleted_at"]
		attention_to <- map["attention_to"]
		updated_at <- map["updated_at"]
		address_1 <- map["address_1"]
		phone <- map["phone"]
		archived_at <- map["archived_at"]
		account_id <- map["account_id"]
		state <- map["state"]
	}
}