//
//  Devo.h
//  AnyPresence SDK
//

/*!
 @header Devo
 @abstract Devo class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Week;

/*!
 @class Devo
 @abstract Generated model object: Devo.
 @discussion Use @link //apple_ref/occ/cat/Devo(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Devo/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Devo : APObject {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var insight
 @abstract Generated model property: insight.
 */
@property (nonatomic, strong) NSString * insight;
/*!
 @var reference
 @abstract Generated model property: reference.
 */
@property (nonatomic, strong) NSString * reference;
/*!
 @var verse
 @abstract Generated model property: verse.
 */
@property (nonatomic, strong) NSString * verse;
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