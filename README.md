# sizeUpDirectory

This is a command-line tool that demonstrates two things:

- Using NSDirectoryEnumerator or CFURLEnumerator to walk a directory tree
- Separation between interface (and client) and implementation

The program walks a directory tree and reports the total size of all files therein. To do this, the main program uses an object called a PRHDirectoryWeigher.

The project has two targets: One uses CFURLEnumerator; the other uses NSDirectoryEnumerator.

Both targets use *exactly the same main.m and PRHDirectoryWeigher.h*. The class interface is in exactly one file, shared between both projects; the main program is in exactly one file, shared between both projects.

Only the implementations are in two different files. The main program does not know or need to care whether it is using a CF-based or Foundation-based implementation, which is one part because and one part why there is exactly one interface in front of both implementations.
