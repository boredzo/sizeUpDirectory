#import "PRHDirectoryWeigher.h"

@implementation PRHDirectoryWeigher

- (unsigned long long) totalSizeOfDirectoryAtURL:(NSURL *)rootURL {
	unsigned long long int totalSize = 0;

	CFURLRef convertedRootURL = NULL;
	CFErrorRef error = NULL;
	if (self.yieldReferenceURLs) {
		convertedRootURL = CFURLCreateFileReferenceURL(kCFAllocatorDefault, (__bridge CFURLRef)rootURL, &error);
	} else {
		convertedRootURL = CFURLCreateFilePathURL(kCFAllocatorDefault, (__bridge CFURLRef)rootURL, &error);
	}

	CFURLEnumeratorRef dirEnum = CFURLEnumeratorCreateForDirectoryURL(kCFAllocatorDefault, convertedRootURL,
		kCFURLEnumeratorDescendRecursively, (__bridge CFArrayRef)@[ (id)kCFURLFileSizeKey ]
	);
	CFURLRef URL = NULL;
	while (CFURLEnumeratorGetNextURL(dirEnum, &URL, NULL) == kCFURLEnumeratorSuccess) {
		CFNumberRef valueNum = NULL;
		if (CFURLCopyResourcePropertyForKey(URL, kCFURLFileSizeKey, &valueNum, &error) && (valueNum != NULL)) {
			signed long long int value;
			if (CFNumberGetValue(valueNum, kCFNumberLongLongType, &value) && (value >= 0))
				totalSize += value;

			if (self.verbose)
				printf("- %s\n", [[(__bridge NSURL *)URL path] UTF8String]);

			CFRelease(valueNum);
		}
	}

	CFRelease(convertedRootURL);

	return totalSize;
}

@end
