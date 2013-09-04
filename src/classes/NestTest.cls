@isTest
private class NestTest
{
    static testMethod void map_returnsDistinctKeys()
    {
        List<Object> records = new List<Object> {
            m().foo(1).bar(0),
            m().foo(2),
            m().foo(1).bar(1)
        };

        Nest byFoo = new Nest()
            .key( f('foo') );

        Test.startTest();

            Object nested = byFoo.doMap( records );

        Test.stopTest();

        Map<Object, Object> nestedMap = (Map<Object, Object>)nested;
        System.assert( nestedMap.containsKey(1) );
        System.assert( nestedMap.containsKey(2) );

        List<Object> ones = (List<Object>)nestedMap.get(1);
        List<Object> twos = (List<Object>)nestedMap.get(2);
        System.assertEquals( 2, ones.size() );
        System.assertEquals( 1, twos.size() );
    }

    static testMethod void map_multipleKeyFunctions()
    {
        List<Object> records = new List<Object> {
            m().foo(0).bar(1),
            m().foo(0).bar(2),
            m().foo(1).bar(1),
            m().foo(1).bar(2),
            m().foo(0).bar(2)
        };

        Nest byFooThenBar = new Nest()
            .key( f('foo') )
            .key( f('bar') );

        Test.startTest();

            Object nested = byFooThenBar.doMap( records );

        Test.stopTest();

        Map<Object, Object> nestedMap = (Map<Object, Object>)nested;
        System.assert( nestedMap.containsKey(0) );
        System.assert( nestedMap.containsKey(1) );

        Map<Object, Object> zeros = (Map<Object, Object>)nestedMap.get(0);
        Map<Object, Object> ones = (Map<Object, Object>)nestedMap.get(1);

        System.assert( zeros.containsKey(1) );
        System.assert( zeros.containsKey(2) );
        System.assert( ones.containsKey(1) );
        System.assert( ones.containsKey(2) );

        List<Object> zeroOne = (List<Object>)zeros.get(1);
        List<Object> zeroTwo = (List<Object>)zeros.get(2);
        List<Object> oneOne = (List<Object>)ones.get(1);
        List<Object> oneTwo = (List<Object>)ones.get(2);

        System.assertEquals( 1, zeroOne.size() );
        System.assertEquals( 2, zeroTwo.size() );
        System.assertEquals( 1, oneOne.size() );
        System.assertEquals( 1, oneTwo.size() );
    }

    static MyRecord m()
    {
        return new MyRecord();
    }

    static MyAccessor f( String field )
    {
        return new MyAccessor( field );
    }

    class MyRecord
    {
        Map<String, Object> theMap = new Map<String, Object>();

        MyRecord foo( Integer foo )
        {
            theMap.put( 'foo', foo );
            return this;
        }

        MyRecord bar( Integer bar )
        {
            theMap.put( 'bar', bar );
            return this;
        }

        Object get( String field )
        {
            return theMap.get( field );
        }
    }

    public class MyAccessor implements Accessor
    {
        String key;

        MyAccessor( String key )
        {
            this.key = key;
        }

        public Object getFrom( Object record )
        {
            return ((MyRecord)record).get( key );
        }
    }
}
