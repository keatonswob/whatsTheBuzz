// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FavArticle.m instead.

#import "_FavArticle.h"

const struct FavArticleAttributes FavArticleAttributes = {
	.artDescrip = @"artDescrip",
	.artName = @"artName",
	.source = @"source",
	.url = @"url",
};

@implementation FavArticleID
@end

@implementation _FavArticle

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FavArticle" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FavArticle";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FavArticle" inManagedObjectContext:moc_];
}

- (FavArticleID*)objectID {
	return (FavArticleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic artDescrip;

@dynamic artName;

@dynamic source;

@dynamic url;

@end

