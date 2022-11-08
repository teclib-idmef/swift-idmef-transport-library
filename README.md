# swift-idmef-transport-library

![GitHub top language](https://img.shields.io/github/languages/top/teclib-idmef/swift-idmef-transport-library) 
![GitHub](https://img.shields.io/github/license/teclib-idmef/swift-idmef-transport-library) 
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/teclib-idmef/swift-idmef-transport-library) 
![GitHub release (latest by date)](https://img.shields.io/github/v/release/teclib-idmef/swift-idmef-transport-library) 
![GitHub issues](https://img.shields.io/github/issues/teclib-idmef/swift-idmef-transport-library)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

A Swift library for transporting JSON IDMEFv2 messages. It can be used to transfer Incident Detection Message Exchange Format (IDMEFv2) messages for exchange with other systems.

IDMEFv2 messages can be generated, validated and serialized/deserialized using the [`swift-idmef-library`](https://github.com/teclib-idmef/swift-idmef-library).

This code is currently in an experimental status and is regularly kept in sync with the development status of the IDMEFv2 format, as part of the [SECurity Exchange Format project](https://www.secef.net/).

The latest revision of the IDMEFv2 format specification can be found there: https://github.com/IDMEFv2/IDMEFv2-Specification

You can find more information about the previous version (v1) of the Intrusion Detection Message Exchange Format in [RFC 4765](https://tools.ietf.org/html/rfc4765).

## Compiling the library

The following prerequisites must be installed on your system to install and use this library:

* Swift: version 5.5 or above

The library has the following third-party dependencies:

* swift-idmef-library: https://github.com/teclib-idmef/swift-idmef-library
* Embassy web server: https://github.com/envoy/Embassy.git

**Note**: building using swift automaticaly pulls the needed dependencies.

To compile the library:

``` shell
swift build
``` 

This will build a bundle located in `./.build/`.

## Using the libray

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding `swift-idmef-transport-library` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/teclib-idmef/swift-idmef-transport-library.git", .upToNextMajor(from: "1.0.1"))
]
```

### Client

### Server

## Contributions

All contributions must be licensed under the Apache-2.0 license. See the LICENSE file inside this repository for more information.