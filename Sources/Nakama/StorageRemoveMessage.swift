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

public struct StorageRemoveMessage : CollatedMessage {
  private var payload = Server_TStorageRemove()
  
  public init() {
    payload.keys = []
  }
  
  public mutating func remove(bucket: String, collection: String, key: String, version: String?=nil) {
    var record = Server_TStorageRemove.StorageKey()
    record.bucket = bucket
    record.collection = collection
    record.record = key
    if version != nil {
      record.version = version!
    }
    
    payload.keys.append(record)
  }
  
  public func serialize(collationID: String) -> Data? {
    var envelope = Server_Envelope()
    envelope.storageRemove = payload
    envelope.collationID = collationID
    
    return try! envelope.serializedData()
  }
  
  public var description: String {
    return String(format: "StorageRemoveMessage(keys=%@)", payload.keys)
  }
  
}
