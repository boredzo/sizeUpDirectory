@interface PRHDirectoryWeigher : NSObject

@property(getter=isVerbose) bool verbose;
@property bool yieldReferenceURLs;

- (unsigned long long) totalSizeOfDirectoryAtURL:(NSURL *)rootURL;

@end
