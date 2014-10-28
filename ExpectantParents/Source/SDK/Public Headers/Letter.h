//
//  Letter.h
//  AnyPresence SDK
//

/*!
 @header Letter
 @abstract Letter class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Week;

/*!
 @class Letter
 @abstract Generated model object: Letter.
 @discussion Use @link //apple_ref/occ/cat/Letter(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Letter/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Letter : APObject {
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
 @var title
 @abstract Generated model property: title.
 */
@property (nonatomic, strong) NSString * title;
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