Graphite module for puppet
==========================

Description
-----------

Puppet module for installing and configuring graphite

Usage
-----

Graphite is a beast. This module tries to tame it a bit.

For your simplest setup, you really only need a cache:

```
graphite::cache { 'a': }

```

This will start up a graphite cache listening on port 2003, 2004, and 7002 to receive metrics and to accept queries from graphite-web and other graphite metrics consumers.

Multiple Caches
---------------

Multiple caches can be managed with this module:

```
graphite::cache {
    'a':
        line_receiver_port => 2003,
        udp_receiver_port => 2003,
        pickle_receiver_port => 2004
        cache_query_port => 7002;
    'b':
        line_receiver_port => 2103,
        udp_receiver_port => 2103,
        pickle_receiver_port => 2104
        cache_query_port => 7102;
}
```

Generally you would want to have these behind a relay instance:

```
class { 'graphite::relay':
    destinations => ['127.0.0.1:2004:a','127.0.0.1:2104:b']
}
```

Aggregator Support
------------------

If you want to have an aggregator running in front of your cache(s), use the `graphite::aggregator` class:

```
class { 'graphite::aggregator':
    destinations => ['127.0.0.1:2014:a'],
}

Other Defines
-------------

* `graphite::relay_rule`
* `graphite::blacklist`
* `graphite::whitelist`
* `graphite::storage_aggregation`
* `graphite::storage_schema`

Contact
-------

If you have problems with this module, please file issues or PRs over at [https://github.com/nationbuilder/puppet-graphite](our project page)
