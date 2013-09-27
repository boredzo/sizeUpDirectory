#import "PRHDirectoryWeigher.h"

@implementation PRHDirectoryWeigher

- (unsigned long long) totalSizeOfDirectoryAtURL:(NSURL *)rootURL {
	unsigned long long int totalSize = 0;

	rootURL = self.yieldReferenceURLs ? [rootURL fileReferenceURL] : [rootURL filePathURL];

	NSFileManager *manager = [NSFileManager new];
	NSDirectoryEnumerator *dirEnum = [manager enumeratorAtURL:rootURL includingPropertiesForKeys:@[ NSURLFileSizeKey ]
	                 options:0
		        errorHandler:nil];

	for (NSURL *URL in dirEnum) {
		NSNumber *num = nil;
		if ([URL getResourceValue:&num forKey:NSURLFileSizeKey error:NULL]) {
			totalSize += num.unsignedLongLongValue;

			if (self.verbose)
				printf("- %s\n", [[URL path] UTF8String]);
		}
	}

	return totalSize;
}

@end
