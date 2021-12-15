// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct UserInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - firebaseUserUid
  ///   - firstName
  ///   - lastName
  ///   - email
  ///   - imgUrl
  public init(firebaseUserUid: String, firstName: String, lastName: String, email: String, imgUrl: Swift.Optional<String?> = nil) {
    graphQLMap = ["firebaseUserUID": firebaseUserUid, "firstName": firstName, "lastName": lastName, "email": email, "imgUrl": imgUrl]
  }

  public var firebaseUserUid: String {
    get {
      return graphQLMap["firebaseUserUID"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "firebaseUserUID")
    }
  }

  public var firstName: String {
    get {
      return graphQLMap["firstName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String {
    get {
      return graphQLMap["lastName"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var imgUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["imgUrl"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "imgUrl")
    }
  }
}

public final class CreateUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateUser($input: UserInput!) {
      createUser(input: $input) {
        __typename
        errors {
          __typename
          field
          message
        }
        user {
          __typename
          id
          firebaseUserUID
          firstName
          lastName
          email
          imgUrl
          tier
          createdAt
          updatedAt
        }
      }
    }
    """

  public let operationName: String = "CreateUser"

  public var input: UserInput

  public init(input: UserInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createUser", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(CreateUser.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUser: CreateUser) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.resultMap])
    }

    public var createUser: CreateUser {
      get {
        return CreateUser(unsafeResultMap: resultMap["createUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(errors: [Error]? = nil, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserResponse", "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var errors: [Error]? {
        get {
          return (resultMap["errors"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Error] in value.map { (value: ResultMap) -> Error in Error(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, forKey: "errors")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FieldError"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("field", type: .nonNull(.scalar(String.self))),
            GraphQLField("message", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(field: String, message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "field": field, "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var field: String {
          get {
            return resultMap["field"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "field")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Double.self))),
            GraphQLField("firebaseUserUID", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            GraphQLField("email", type: .nonNull(.scalar(String.self))),
            GraphQLField("imgUrl", type: .scalar(String.self)),
            GraphQLField("tier", type: .nonNull(.scalar(Double.self))),
            GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
            GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Double, firebaseUserUid: String, firstName: String, lastName: String, email: String, imgUrl: String? = nil, tier: Double, createdAt: String, updatedAt: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "firebaseUserUID": firebaseUserUid, "firstName": firstName, "lastName": lastName, "email": email, "imgUrl": imgUrl, "tier": tier, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var firebaseUserUid: String {
          get {
            return resultMap["firebaseUserUID"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firebaseUserUID")
          }
        }

        public var firstName: String {
          get {
            return resultMap["firstName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String {
          get {
            return resultMap["lastName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
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

        public var imgUrl: String? {
          get {
            return resultMap["imgUrl"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "imgUrl")
          }
        }

        public var tier: Double {
          get {
            return resultMap["tier"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "tier")
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
}
