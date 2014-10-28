//
//  Discuss.h
//  AnyPresence SDK
//

/*!
 @header Discuss
 @abstract Discuss class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Week;

/*!
 @class Discuss
 @abstract Generated model object: Discuss.
 @discussion Use @link //apple_ref/occ/cat/Discuss(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Discuss/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Discuss : APObject {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var items
 @abstract Generated model property: items.
 */
@property (nonatomic, strong) NSArray * items;
/*!
 @var weekId
 @abstract Generated model property: week_id.
 */
@property (nonatomic, strong) NSString * weekId;

/*!
 @var week
 @abstract Generated property for belongs-to relationship to week.
 */
@property (nonatomic, strong) Week * week;

@end