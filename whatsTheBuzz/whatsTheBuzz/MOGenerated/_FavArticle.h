// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FavArticle.h instead.

#import <CoreData/CoreData.h>

extern const struct FavArticleAttributes {
	__unsafe_unretained NSString *artDescrip;
	__unsafe_unretained NSString *artName;
	__unsafe_unretained NSString *source;
	__unsafe_unretained NSString *url;
} FavArticleAttributes;

@interface FavArticleID : NSManagedObjectID {}
@end

@interface _FavArticle : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FavArticleID* objectID;

@property (nonatomic, strong) NSString* artDescrip;

//- (BOOL)validateArtDescrip:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* artName;

//- (BOOL)validateArtName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* source;

//- (BOOL)validateSource:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@end

@interface _FavArticle (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveArtDescrip;
- (void)setPrimitiveArtDescrip:(NSString*)value;

- (NSString*)primitiveArtName;
- (void)setPrimitiveArtName:(NSString*)value;

- (NSString*)primitiveSource;
- (void)setPrimitiveSource:(NSString*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

@end
