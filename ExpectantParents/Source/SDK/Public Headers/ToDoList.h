//
//  ToDoList.h
//  AnyPresence SDK
//

/*!
 @header ToDoList
 @abstract ToDoList class
 */

#import "APObject.h"
#import "Typedefs.h"


/*!
 @class ToDoList
 @abstract Generated model object: ToDoList.
 @discussion Use @link //apple_ref/occ/cat/ToDoList(Remote) @/link to add CRUD capabilities.
 The @link //apple_ref/occ/instp/ToDoList/id @/link field is set as primary key (see @link //apple_ref/occ/cat/APObject(RemoteConfig) @/link) in [self init].
 */
@interface ToDoList : APObject {
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
 @var sections
 @abstract Generated property for has-many relationship to sections.
 */
@property (nonatomic, strong) NSOrderedSet * sections;

@end