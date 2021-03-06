/*
 * Copyright 2017 Heroic Labs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

public struct UsersFetchMessage : CollatedMessage {
  public var handles : [String] = []
  public var userIDs: [String] = []
  
  public init(){}
  
  public func serialize(collationID: String) -> Data? {
    var proto = Server_TUsersFetch()
    
    for handle in handles {
      var userfetch = Server_TUsersFetch.UsersFetch()
      userfetch.handle = handle
      proto.users.append(userfetch)
    }
    
    for id in userIDs {
      var userfetch = Server_TUsersFetch.UsersFetch()
      userfetch.userID = id
      proto.users.append(userfetch)
    }
    
    var envelope = Server_Envelope()
    envelope.usersFetch = proto
    envelope.collationID = collationID
    
    return try! envelope.serializedData()
  }
  
  public var description: String {
    return String(format: "UsersFetchMessage(handles=%@,ids=%@)", handles, userIDs)
  }
  
}
