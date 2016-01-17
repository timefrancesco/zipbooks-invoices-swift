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


class TimeEntry: Object,Mappable {
    dynamic var id: Int = 0
	dynamic var created_at: String?
	dynamic var billed: Int = 0
	dynamic var date: String?
	dynamic var task_id: Int = 0
	dynamic var duration: Int = 0
	dynamic var note: String?
	dynamic var deleted_at: String?
	dynamic var updated_at: String?
	dynamic var account_id: Int = 0
	dynamic var task: Task?
	dynamic var line_item_id: Int = 0
	dynamic var user_id: Int = 0
	dynamic var user: TeamUser?

    override static func primaryKey() -> String? {
        return "id"
    }

	// MARK: Mappable

	required convenience init?(_ map: Map) {
		self.init()
	}

    func mapping(map: Map) {
        id <- map["id"]
		created_at <- map["created_at"]
		billed <- map["billed"]
		date <- map["date"]
		task_id <- map["task_id"]
		duration <- map["duration"]
		note <- map["note"]
		deleted_at <- map["deleted_at"]
		updated_at <- map["updated_at"]
		account_id <- map["account_id"]
		task <- map["task"]
		line_item_id <- map["line_item_id"]
		user_id <- map["user_id"]
		user <- map["user"]
	}
}