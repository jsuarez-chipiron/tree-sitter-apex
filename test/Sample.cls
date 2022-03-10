global with sharing class Class1 {
    // one line comment

    global static String getString(String name)
    {
        List<String> l = [ 
            SELECT field1, field2 
            FROM Account];

        String x = '';
        if ( x?.value ) {
            System.debug('foo');
        }

        if ( 1 <> 2 ) {
            System.debug('foo');
        }

        return (l.size()>42)?'javier':'';
    }

    public void DML_Examples() {
        List<String> l = [ 
            SELECT field1, field2 
            FROM Account];

        insert l;
        update l;
        delete l;
    }

    public void enhancedDMLExample() {
        delete [SELECT id FROM Account];
    }

    public void nullSafeOperator() {
        String myString = myContact?.Account?.RecordType.Name;
    }

    public void notEqualsOperators() {
        if ( 1 <> 2 ) {
            String x = 'foo';
        }

        if ( 1 != 2 ) {
            String x = 'foo';
        }
    }
}
