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

public enum TopicMessageType : Int32 {
  case unknown = -1
  case chat = 0
  case groupJoin = 1
  case groupAdd = 2
  case groupLeave = 3
  case groupKick = 4
  case groupPromoted = 5
  
  internal static func make(from code:Int64) -> TopicMessageType {
    switch code {
    case 0:
      return .chat
    case 1:
      return .groupJoin
    case 2:
      return .groupAdd
    case 3:
      return .groupLeave
    case 4:
      return .groupKick
    case 5:
      return .groupPromoted
    default:
      return .unknown
    }
  }
}

public protocol TopicMessage : CustomStringConvertible {
  /**
   Identifier for this topic message
   */
  var topic : TopicId { get }
  
  /**
   ID of the user that created this message
   */
  var userID : String { get }
  
  /**
   Unique identifier for this message
   */
  var messageID : String { get }
  
  /**
   Unix timestamp of when the message was created
   */
  var createdAt : Int { get }
  
  /**
   Unix timestamp of when the message will expire
   */
  var expiresAt : Int { get }
  
  /**
   Handle of the user that created this message
   */
  var handle : String { get }
  
  /**
   Message type
   */
  var type : TopicMessageType { get }
  
  /**
   The message payload
   */
  var data : String { get }
}

internal struct DefaultTopicMessage : TopicMessage {
  let topic : TopicId
  let userID : String
  let messageID : String
  let createdAt : Int
  let expiresAt : Int
  let handle : String
  let type : TopicMessageType
  let data : String
  
  internal init(from proto: Server_TopicMessage) {
    topic = TopicId.make(from: proto.topic)
    handle = proto.handle
    data = proto.data
    createdAt = Int(proto.createdAt)
    expiresAt = Int(proto.expiresAt)
    
    type = TopicMessageType.make(from: proto.type)
    
    userID = proto.userID
    messageID = proto.messageID
  }
  
  public var description: String {
    return String(format: "DefaultTopicMessage(topic=%@,userID=%@,messageID=%@,createdAt=%d,expiresAt=%d,handle=%@,type=%@,data=%@)", topic.description, userID, messageID, createdAt, expiresAt, handle, type.rawValue, data)
  }
}

public protocol TopicMessageAck : CustomStringConvertible {
  
  /**
   ID of the message that we've acked
   */
  var messageID : String { get }
  
  /**
   When the ack was created
   */
  var createdAt : Int { get }
  
  /**
   When the ack will expire
   */
  var expiresAt : Int { get }
  
  /**
   Handle of the user that sent the ack
   */
  var handle : String { get }
}

internal struct DefaultTopicMessageAck : TopicMessageAck {
  let messageID : String
  let createdAt : Int
  let expiresAt : Int
  let handle : String
  
  internal init(from proto: Server_TTopicMessageAck) {
    handle = proto.handle
    createdAt = Int(proto.createdAt)
    expiresAt = Int(proto.expiresAt)
    
    messageID = proto.messageID
  }
  
  public var description: String {
    return String(format: "DefaultTopicMessageAck(messageID=%@,createdAt=%d,expiresAt=%d,handle=%@,@)", messageID, createdAt, expiresAt, handle)
  }
}
