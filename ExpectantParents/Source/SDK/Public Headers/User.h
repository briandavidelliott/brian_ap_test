//
//  User.h
//  AnyPresence SDK
//

/*!
 @header User
 @abstract User class
 */

#import "APObject.h"
#import "Authorizable-Protocol.h"
#import "Typedefs.h"


/*!
 @class User
 @abstract Generated model object: User.
 @discussion Use @link //apple_ref/occ/cat/User(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/User/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface User : APObject <Authorizable> {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var authToken
 @abstract Generated model property: auth_token.
 */
@property (nonatomic, strong) NSString * authToken;
/*!
 @var babyGender
 @abstract Generated model property: baby_gender.
 */
@property (nonatomic, strong) NSString * babyGender;
/*!
 @var babyName
 @abstract Generated model property: baby_name.
 */
@property (nonatomic, strong) NSString * babyName;
/*!
 @var changedPassword
 @abstract Generated model property: changed_password.
 */
@property (nonatomic, strong) NSString * changedPassword;
/*!
 @var country
 @abstract Generated model property: country.
 */
@property (nonatomic, strong) NSString * country;
/*!
 @var dueDate
 @abstract Generated model property: due_date.
 */
@property (nonatomic, strong) NSDate * dueDate;
/*!
 @var email
 @abstract Generated model property: email.
 */
@property (nonatomic, strong) NSString * email;
/*!
 @var favorites
 @abstract Generated model property: favorites.
 */
@property (nonatomic, strong) NSArray * favorites;
/*!
 @var favoritesLastUpdated
 @abstract Generated model property: favorites_last_updated.
 */
@property (nonatomic, strong) NSDate * favoritesLastUpdated;
/*!
 @var firstName
 @abstract Generated model property: first_name.
 */
@property (nonatomic, strong) NSString * firstName;
/*!
 @var lastName
 @abstract Generated model property: last_name.
 */
@property (nonatomic, strong) NSString * lastName;
/*!
 @var optIn
 @abstract Generated model property: opt_in.
 */
@property (nonatomic, strong) NSNumber * optIn;
/*!
 @var password
 @abstract Generated model property: password.
 */
@property (nonatomic, strong) NSString * password;
/*!
 @var provider
 @abstract Generated model property: provider.
 */
@property (nonatomic, strong) NSString * provider;
/*!
 @var purchased
 @abstract Generated model property: purchased.
 */
@property (nonatomic, strong) NSNumber * purchased;
/*!
 @var role
 @abstract Generated model property: role.
 */
@property (nonatomic, strong) NSString * role;
/*!
 @var sessionSecret
 @abstract Generated model property: session_secret.
 */
@property (nonatomic, strong) NSString * sessionSecret;
/*!
 @var sessionToken
 @abstract Generated model property: session_token.
 */
@property (nonatomic, strong) NSString * sessionToken;
/*!
 @var sourceCode
 @abstract Generated model property: source_code.
 */
@property (nonatomic, strong) NSString * sourceCode;
/*!
 @var terms
 @abstract Generated model property: terms.
 */
@property (nonatomic, strong) NSNumber * terms;
/*!
 @var todos
 @abstract Generated model property: todos.
 */
@property (nonatomic, strong) NSArray * todos;
/*!
 @var xSessionId
 @abstract Generated model property: x_session_id.
 */
@property (nonatomic, strong) NSString * xSessionId;


@end