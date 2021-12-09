// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetAllUsersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllUsers {
      getAllUsers {
        __typename
        email
        id
        username
        createdAt
        updatedAt
      }
    }
    """

  public let operationName: String = "GetAllUsers"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getAllUsers", type: .nonNull(.list(.nonNull(.object(GetAllUser.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAllUsers: [GetAllUser]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAllUsers": getAllUsers.map { (value: GetAllUser) -> ResultMap in value.resultMap }])
    }

    public var getAllUsers: [GetAllUser] {
      get {
        return (resultMap["getAllUsers"] as! [ResultMap]).map { (value: ResultMap) -> GetAllUser in GetAllUser(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetAllUser) -> ResultMap in value.resultMap }, forKey: "getAllUsers")
      }
    }

    public struct GetAllUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Double.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(email: String, id: Double, username: String, createdAt: String, updatedAt: String) {
        self.init(unsafeResultMap: ["__typename": "User", "email": email, "id": id, "username": username, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var id: Double {
        get {
          return resultMap["id"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var username: String {
        get {
          return resultMap["username"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      public var createdAt: String {
        get {
          return resultMap["createdAt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return resultMap["updatedAt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}
