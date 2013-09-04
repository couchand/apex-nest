//d3.nest = function() {
//  var nest = {},
global class Nest
{
//      keys = [],
    List<Accessor> keys = new List<Accessor>();
//      sortKeys = [],
//      sortValues,
//      rollup;
    Aggregator rollup;

//  function map(mapType, array, depth) {
    Object doMap( List<Object> records, Integer depth )
    {
//    if (depth >= keys.length) return rollup
        if ( depth >= keys.size() )
        {
//        ? rollup.call(nest, array) : (sortValues
            if ( rollup != null ) return rollup.rollup( records );
//        ? array.sort(sortValues)
//        : array);
            return records;
        }
//
//    var i = -1,
//        n = array.length,
//        key = keys[depth++],
        Accessor key = keys[depth];
//        keyValue,
//        object,
        Map<Object, Object> theMap = new Map<Object, Object>();
//        setter,
//        valuesByKey = new d3_Map,
        Map<Object, List<Object>> valuesByKey = new Map<Object, List<Object>>();
//        values;
//
//    while (++i < n) {
        for ( Object record : records )
        {
            Object keyValue = key.getFrom( record );
//      if (values = valuesByKey.get(keyValue = key(object = array[i]))) {
            if ( valuesByKey.containsKey( keyValue ) )
            {
//        values.push(object);
                valuesByKey.get( keyValue ).add( record );
//      } else {
            }
            else
            {
//        valuesByKey.set(keyValue, [object]);
                valuesByKey.put( keyValue, new List<Object>{ record } );
//      }
            }
//    }
        }

//    if (mapType) {
//      object = mapType();
//      setter = function(keyValue, values) {
//        object.set(keyValue, map(mapType, values, depth));
//      };
//    } else {
//      object = {};
//      setter = function(keyValue, values) {
        for ( Object keyValue : valuesByKey.keySet() )
        {
//        object[keyValue] = map(mapType, values, depth);
            theMap.put( keyValue, doMap( valuesByKey.get( keyValue ), depth + 1 ) );
        }
//      };
//    }

//    valuesByKey.forEach(setter);
//    return object;
        return theMap;
//  }
    }

//  function entries(map, depth) {
//    if (depth >= keys.length) return map;
//
//    var array = [],
//        sortKey = sortKeys[depth++];
//
//    map.forEach(function(key, keyMap) {
//      array.push({key: key, values: entries(keyMap, depth)});
//    });
//
//    return sortKey
//        ? array.sort(function(a, b) { return sortKey(a.key, b.key); })
//        : array;
//  }

//  nest.map = function(array, mapType) {
    global Object doMap( List<Object> records )
    {
//    return map(mapType, array, 0);
        return doMap( records, 0 );
//  };
    }

//  nest.entries = function(array) {
//    return entries(map(d3.map, array, 0), 0);
//  };

//  nest.key = function(d) {
    global Nest key( Accessor d )
    {
//    keys.push(d);
        keys.add( d );
//    return nest;
        return this;
//  };
    }

//  // Specifies the order for the most-recently specified key.
//  // Note: only applies to entries. Map keys are unordered!
//  nest.sortKeys = function(order) {
//    sortKeys[keys.length - 1] = order;
//    return nest;
//  };

//  // Specifies the order for leaf values.
//  // Applies to both maps and entries array.
//  nest.sortValues = function(order) {
//    sortValues = order;
//    return nest;
//  };

//  nest.rollup = function(f) {
    global Nest rollup( Aggregator f )
    {
//    rollup = f;
        this.rollup = f;
//    return nest;
        return this;
//  };
    }

//  return nest;
//};
}
