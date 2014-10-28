//
//  Week.h
//  AnyPresence SDK
//

/*!
 @header Week
 @abstract Week class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Development;
@class Devo;
@class Discuss;
@class Letter;
@class Prayer;

/*!
 @class Week
 @abstract Generated model object: Week.
 @discussion Use @link //apple_ref/occ/cat/Week(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Week/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Week : APObject {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var theme
 @abstract Generated model property: theme.
 */
@property (nonatomic, strong) NSString * theme;
/*!
 @var weekNumber
 @abstract Generated model property: week_number.
 */
@property (nonatomic, strong) NSNumber * weekNumber;

/*!
 @var development
 @abstract Generated property for has-one relationship to development.
 */
@property (nonatomic, strong) Development * development;
/*!
 @var devo
 @abstract Generated property for has-one relationship to devo.
 */
@property (nonatomic, strong) Devo * devo;
/*!
 @var discuss
 @abstract Generated property for has-one relationship to discuss.
 */
@property (nonatomic, strong) Discuss * discuss;
/*!
 @var letter
 @abstract Generated property for has-one relationship to letter.
 */
@property (nonatomic, strong) Letter * letter;
/*!
 @var prayer
 @abstract Generated property for has-one relationship to prayer.
 */
@property (nonatomic, strong) Prayer * prayer;

@end