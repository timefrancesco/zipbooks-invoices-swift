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

class Task: Object,Mappable {
    
    dynamic var id: Int = 0
    dynamic var name: String?
	dynamic var created_at: String?
	dynamic var desc: String?
	dynamic var project_id: Int = 0
	dynamic var project: Project?
	dynamic var deleted_at: String?
	dynamic var start_date: String?
	dynamic var hourly_rate: String?
	dynamic var end_date: String?
	dynamic var updated_at: String?
	dynamic var account_id: Int = 0
	dynamic var archived_at: String?
	var time_entries = List<TimeEntry>()
	dynamic var billable: Int = 0

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
		desc <- map["description"]
		project_id <- map["project_id"]
		project <- map["project"]
		deleted_at <- map["deleted_at"]
		start_date <- map["start_date"]
		hourly_rate <- map["hourly_rate"]
		end_date <- map["end_date"]
		updated_at <- map["updated_at"]
		account_id <- map["account_id"]
		archived_at <- map["archived_at"]
		time_entries <- (map["time_entries"], ArrayTransform<TimeEntry>())
		billable <- map["billable"]
	}
}

class TaskPost: Object,Mappable {
    dynamic var project_id: Int = 0
    dynamic var name: String?
    dynamic var hourly_rate: Double = 0
    dynamic var billable:  Bool = true
    
    // MARK: Mappable
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        project_id <- map["project_id"]
        name <- map["name"]
        hourly_rate <- map["hourly_rate"]
        billable <- map["billable"]
    }
}