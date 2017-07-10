//
//  BKChatGroupModel.swift
//  BayeStyle
//
//  Created by 董招兵 on 2016/11/8.
//  Copyright © 2016年 大兵布莱恩特. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 社群资料的模型

class BKChatGroupModel: RLMObject  {

   dynamic var category : String?
   dynamic var owner_uid : String = ""
   dynamic var groupid : String?
   dynamic var isInGroup : Bool = false
   dynamic var avatar : String?
   dynamic var city : String?
   dynamic var is_public : Bool = true {
        didSet {
        }
    }
   dynamic var is_approval : Bool = true {
        didSet {
        }
    }
   dynamic var created_at : Int             = 0
   dynamic var maxusers : Int               = 0
   dynamic var groupname : String?
   dynamic var desc : String?
   dynamic var province : String?
   dynamic var category_id : String?
   dynamic var pinyin_letter : String      = ""
   dynamic var owners : RLMLinkingObjects<RLMObject>?
   dynamic var member_count : Int          = 0
    open override class func primaryKey() -> String? {
        return "groupid"
    }
    
    convenience init(by json :JSON) {
        self.init()
  
        self.is_approval            = json["is_approval"].boolValue
        self.category               = json["category"].stringValue
        self.groupname              = json["groupname"].stringValue
        self.is_public              = json["is_public"].boolValue
        self.category_id            = json["category_id"].stringValue
        self.province               = json["province"].stringValue
        self.created_at             = json["created_at"].intValue
        self.desc                   = json["desc"].stringValue
        
        self.avatar                 = json["avatar"].stringValue
        self.member_count           = json["member_count"].intValue
        
        self.city                   = json["city"].stringValue
        self.groupid                = json["groupid"].stringValue
        
        self.owner_uid              = json["owner_uid"].stringValue
        self.maxusers               = json["maxusers"].intValue
        
        self.pinyin_letter          = NSString.chineseTransformLetter(self.groupname!)
        
    }
    
    /// 字典数组转模型数组
    class func chatGroupsWithJSONArray(_ jsonArray :[JSON]) -> [BKChatGroupModel] {
        var array : [BKChatGroupModel] = [BKChatGroupModel]()
        for json in jsonArray {
            let chatGroup = BKChatGroupModel(by: json)
            array.append(chatGroup)
        }
        return array
    }
    
    open override class func linkingObjectsProperties() -> [String : RLMPropertyDescriptor] {
        return ["owners" : RLMPropertyDescriptor(with: UserInfo.self, propertyName: "joined_chat_groups")]
    }
    
    
}
