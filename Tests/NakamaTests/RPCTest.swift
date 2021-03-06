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

import XCTest
import Nakama
import PromiseKit

class RPCTest: XCTestCase {
  private let deviceID : String = UUID.init().uuidString
  private let client : Client = Builder.defaults(serverKey: "defaultkey")
  private var session : Session?
  
  override func setUp() {
    super.setUp()
    
    let exp = expectation(description: "Client connect")
    let message = AuthenticateMessage(device: self.deviceID)
    client.register(with: message).then { session in
      self.client.connect(to: session)
      }.then { session in
        self.session = session
        exp.fulfill()
      }.catch{ err in
        XCTAssert(false, "Registration failed: " + (err as! NakamaError).message)
    }
    
    waitForExpectations(timeout: 10, handler: nil)
  }
  
  override func tearDown() {
    client.disconnect()
    super.tearDown()
  }
  
  func testRPC() {
    let exp = expectation(description: "RPC Test")
    let message = RPCMessage(id: "client_rpc_echo")
    client.send(message: message).then { result in
      XCTAssert(result.id == "client_rpc_echo", "RPC ID does not match")
    }.catch{err in
      switch err as! NakamaError {
      case .runtimeFunctionNotFound(_):
        break;
      default:
        XCTAssert(false, "RPC test failed: " + (err as! NakamaError).message)
        return
      }
    }.always {
      exp.fulfill()
    }
    
    waitForExpectations(timeout: 10, handler: nil)
  }
}
