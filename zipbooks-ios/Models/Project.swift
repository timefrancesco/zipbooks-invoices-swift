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

class Project: Object,Mappable {
    
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var customer: Customer?
	dynamic var created_at: String?
	dynamic var flat_amount: String?
	dynamic var desc: String?
	var users = List<TeamUser>()
	dynamic var budget: String?
	dynamic var customer_id: Int = 0
	dynamic var start_date: String?
	dynamic var deleted_at: String?
	dynamic var hourly_rate: String?
	dynamic var end_date: String?
	var time_entries = List<TimeEntry>()
	dynamic var updated_at: String?
	dynamic var account_id: Int = 0
	dynamic var archived_at: String?
	dynamic var billing_method: String?

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
        customer <- map["customer"]
		created_at <- map["created_at"]
		flat_amount <- map["flat_amount"]
		desc <- map["description"]
		users <- (map["users"], ArrayTransform<TeamUser>())
		budget <- map["budget"]
		customer_id <- map["customer_id"]
		start_date <- map["start_date"]
		deleted_at <- map["deleted_at"]
		hourly_rate <- map["hourly_rate"]
		end_date <- map["end_date"]
		time_entries <- (map["time_entries"], ArrayTransform<TimeEntry>())
		updated_at <- map["updated_at"]
		account_id <- map["account_id"]
		archived_at <- map["archived_at"]
		billing_method <- map["billing_method"]
	}
}

class ProjectPost: Object,Mappable {
    dynamic var customer_id: Int = 0
    dynamic var name: String?
    dynamic var billing_method: String = "project_rate" //can be flat_amount,project_rate,task_rate,staff_rate
    dynamic var hourly_rate: Double = 0 //The project's hourly rate. Required if billing_method = 'project_rate'.
    dynamic var flat_amount:  Double = 0 //The project flat amount. Required if billing_method = 'flat_amount'.
    dynamic var project_description: String?
    
    // MARK: Mappable
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        customer_id <- map["customer_id"]
        name <- map["name"]
        billing_method <- map["billing_method"]
        hourly_rate <- map["hourly_rate"]
        flat_amount <- map["flat_amount"]
        project_description <- map["description"]
    }
}