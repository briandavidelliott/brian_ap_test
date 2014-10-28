//
//  Development.h
//  AnyPresence SDK
//

/*!
 @header Development
 @abstract Development class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Week;

/*!
 @class Development
 @abstract Generated model object: Development.
 @discussion Use @link //apple_ref/occ/cat/Development(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Development/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Development : APObject {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var body
 @abstract Generated model property: body.
 */
@property (nonatomic, strong) NSString * body;
/*!
 @var length
 @abstract Generated model property: length.
 */
@property (nonatomic, strong) NSString * length;
/*!
 @var weekId
 @abstract Generated model property: week_id.
 */
@property (nonatomic, strong) NSString * weekId;
/*!
 @var weight
 @abstract Generated model property: weight.
 */
@property (nonatomic, strong) NSString * weight;

/*!
 @var week
 @abstract Generated property for belongs-to relationship to week.
 */
@property (nonatomic, strong) Week * week;

@end