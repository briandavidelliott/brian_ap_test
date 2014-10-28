//
//  Item.h
//  AnyPresence SDK
//

/*!
 @header Item
 @abstract Item class
 */

#import "APObject.h"
#import "Typedefs.h"

@class Section;

/*!
 @class Item
 @abstract Generated model object: Item.
 @discussion Use @link //apple_ref/occ/cat/Item(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Item/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Item : APObject {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var order
 @abstract Generated model property: order.
 */
@property (nonatomic, strong) NSNumber * order;
/*!
 @var sectionId
 @abstract Generated model property: section_id.
 */
@property (nonatomic, strong) NSString * sectionId;
/*!
 @var value
 @abstract Generated model property: value.
 */
@property (nonatomic, strong) NSString * value;

/*!
 @var section
 @abstract Generated property for belongs-to relationship to section.
 */
@property (nonatomic, strong) Section * section;

@end