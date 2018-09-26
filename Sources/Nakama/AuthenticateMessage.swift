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

public struct AuthenticateMessage : Message {
  private let payload : Nakama_Api_AuthenticateGameCenterRequest
  let endpoint: String
  let shouldCreate: Bool
  
//  public init(custom id: String, shouldCreate: Bool) {
//    var s = Server_AuthenticateRequest()
//    s.custom = id
//
//    self.payload = s
//    self.endpoint = "custom"
//    self.shouldCreate = shouldCreate
//  }
//
//  public init(facebook token: String, shouldCreate: Bool) {
//    var s = Server_AuthenticateRequest()
//    s.facebook = token
//
//    self.payload = s
//    self.endpoint = "facebook"
//    self.shouldCreate = shouldCreate
//  }
//
//  public init(google token: String, shouldCreate: Bool) {
//    var s = Server_AuthenticateRequest()
//    s.google = token
//
//    self.payload = s
//    self.endpoint = "google"
//    self.shouldCreate = shouldCreate
//  }
//
//  public init(steam token: String, shouldCreate: Bool) {
//    var proto = Server_AuthenticateRequest()
//    proto.steam = token
//
//    self.payload = proto
//    self.endpoint = "steam"
//    self.shouldCreate = shouldCreate
//  }
//
//  public init(email address: String, password: String, shouldCreate: Bool) {
//    var s = Server_AuthenticateRequest()
//    s.email = Server_AuthenticateRequest.Email()
//    s.email.email = address
//    s.email.password = password
//
//    self.payload = s
//    self.endpoint = "email"
//    self.shouldCreate = shouldCreate
//  }
  
  public init(gamecenter bundleID: String, playerID: String, publicKeyURL: String, salt: String, timestamp: UInt64, signature: String, shouldCreate: Bool) {
    var s = Nakama_Api_AuthenticateGameCenterRequest()
    s.account = Nakama_Api_AccountGameCenter()
    s.account.bundleID = bundleID
    s.account.playerID = playerID
    s.account.publicKeyURL = publicKeyURL
    s.account.salt = salt
    s.account.timestampSeconds = Int64(timestamp)
    s.account.signature = signature
    
    self.payload = s
    self.endpoint = "gamecenter"
    self.shouldCreate = shouldCreate
  }
  
  public func serialize() -> Data? {
    return try! payload.serializedData()
  }
  
  public var description: String {
    return "\(self)"
//    switch payload.id! {
//    case .device(let device):
//      return String(format: "AuthenticateMessage(device=%@)", device)
//    case .custom(let custom):
//      return String(format: "AuthenticateMessage(custom=%@)", custom)
//    case .facebook(let token):
//      return String(format: "AuthenticateMessage(facebook=%@)", token)
//    case .google(let token):
//      return String(format: "AuthenticateMessage(google=%@)", token)
//    case .steam(let token):
//      return String(format: "AuthenticateMessage(steam=%@)", token)
//    case .email(let email):
//      return String(format: "AuthenticateMessage(email=%@,password=%@)", email.email, email.password)
//    case .gameCenter(let gc):
//      return String(format: "AuthenticateMessage(gamecenter=(bundle_id=%@,player_id=%@,public_key_url=%@,salt=%@,timestamp=%@,signature=%@))", gc.bundleID, gc.playerID, gc.publicKeyURL, gc.salt, gc.timestamp, gc.signature)
//    }
  }
  
}
