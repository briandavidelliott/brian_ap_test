//
//  Prayer.h
//  AnyPresence SDK
//

/*!
 @header Prayer
 @abstract Prayer class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Week;

/*!
 @class Prayer
 @abstract Generated model object: Prayer.
 @discussion Use @link //apple_ref/occ/cat/Prayer(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Prayer/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Prayer : APObject {
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
 @var salutation
 @abstract Generated model property: salutation.
 */
@property (nonatomic, strong) NSString * salutation;
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