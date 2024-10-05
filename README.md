# fortran-xmpp

A collection of Fortran 2018 interface bindings to the lightweight XMPP client
library [libstrophe](http://strophe.im/libstrophe/).

## Dependencies

The package _libstrophe_ has to be installed with development headers. On
FreeBSD, run:

```
# pkg install net-im/libstrophe
```

On Linux, instead:

```
# apt-get install libstrophe0 libstrophe-dev
```

## Build Instructions

Build and install the Fortran library using the provided Makefile:

```
$ make
$ make install PREFIX=/opt
```

Or, use the [Fortran Package Manager](https://github.com/fortran-lang/fpm):

```
$ fpm build --profile release
```

Link your Fortran programs against `libfortran-xmpp.a` and
`pkg-config --libs libstrophe openssl expat zlib`.

## Fortran Package Manager

You can add *fortran-xmpp* as an FPM dependency:

```toml
[dependencies]
fortran-xmpp = { git = "https://github.com/interkosmos/fortran-xmpp.git" }
```

## Examples

Some example programs can be found in directory `examples/`:

* **basic** – connects to an XMPP server.
* **roster** – prints contact list.

## Licence

ISC
