global with sharing class AbstractWorker {
    // una linea
    global static String getString(String name)
    {
        List<String> l = [ 
            SELECT field1, field2 
            from Account];

        // javier

        insert l;
        delete l;
        // javier

        return 'javier';
    }

}