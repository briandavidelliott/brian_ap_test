//
//  Section.h
//  AnyPresence SDK
//

/*!
 @header Section
 @abstract Section class
 */

#import "APObject.h"
#import "Typedefs.h"

@class ToDoList;

/*!
 @class Section
 @abstract Generated model object: Section.
 @discussion Use @link //apple_ref/occ/cat/Section(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/Section/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface Section : APObject {
}

/*!
 @var id
 @abstract Generated model property: id.
 @discussion Primary key. Generated on the server.
 */
@property (nonatomic, strong) NSString * id;
/*!
 @var name
 @abstract Generated model property: name.
 */
@property (nonatomic, strong) NSString * name;
/*!
 @var order
 @abstract Generated model property: order.
 */
@property (nonatomic, strong) NSNumber * order;
/*!
 @var toDoListId
 @abstract Generated model property: to_do_list_id.
 */
@property (nonatomic, strong) NSString * toDoListId;

/*!
 @var items
 @abstract Generated property for has-many relationship to items.
 */
@property (nonatomic, strong) NSOrderedSet * items;
/*!
 @var toDoList
 @abstract Generated property for belongs-to relationship to toDoList.
 */
@property (nonatomic, strong) ToDoList * toDoList;

@end