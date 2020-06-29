The simplest package manager for CMake-based projects. Does not provide dependency checking.

CNPM may have several senses but I personally prefer 'cheap and nasty package manager'.
Other possible interpretations: CMake Nice Package Manager, CMake New Package Manager,
CNake Package Manager, etc.

CNPM supports the following options:
- CNPM\_ROOT - path where the dependencies will be downloaded and
    extracted. CNPM also accepts the environment variable with the same name. CMake
    variable has greater priority than the environment one.
    If not specified then it defaults to `"${CMAKE_BINARY_DIR}/3rd_party"`.
    The value is stored in the cache so when CMake is called next time CNPM uses
    the path for the packages storage
- CNPM\_FORCE - flag. If specified - all required dependencies (the archive and the extracted
    folder) are removed. I.e. it is needed to reinitialize the environment if some issues
    were occured
- CNPM\_ONLY - flag. If specified then after the environment has been prepared stops
    the execution of CMake. May be useful to create just a local mirror of the env
- CNPM\_REPOSITORY\_URLS - a list of repository URLs delimited by semicolon (CMake-list).
    The URLs are used to download packages.

CNPM package is just an archive (currently only 7z supported). The name of a package obeys
the following scheme:  
    {name}-{version}-{arch}-{build_number}{tag}. version, arch, build\_number and tag
    mustn't contain minuses. Version is a numbers separated by points: 3.4.5.1, 1.0.2.
    Arch is x86, amd64, AnyCPU, etc. Build_number is just a number of the build. Tag is
    an arbitrary string (commit hash, branch name, etc) but has to be started with
    non-digit character.  

The archive has to contain folder with the same name. For example, if there is a
package 'protobuf-2.6.1-x86-0sdk14393\_vs2015up3.7z', then after extracting there will
be a folder with name 'protobuf-2.6.1-x86-0sdk14393\_vs2015up3'.
The package's folder has to contain package.cmake file. This file will be included by
CNPM. It is required to perform some initialization of the package. Check some packages
for details.

Examples:
- `> cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCNPM_ROOT:PATH="c:\path\to\env" ..\project`
    the environment will be downloaded from the default URL and put to "c:\path\to\env"
- `> cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCNPM_REPOSITORY_URLS="http://env.server.org" ..\project`
    use the alternative URL of repository
- `> cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCNPM_FORCE=1 -DCNPM_ONLY=1 ..\project`
    just create a local mirror of the environment

