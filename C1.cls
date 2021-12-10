global with sharing class AbstractWorker {
    // una linea
    global static String getString(String name)
    {
        List<String> l = [ 
            SELECT field1, field2 
            from Account];

        return 'javier';
    }

}

global with sharing class Helper {
    public String getString(String name) {
        return 'javier';
    }
}

global with sharing class Service {

    public void doIt() {
        String x = AbstractWorker.getString('javier');
        System.debug(x);

        Helper helper = new Helper();
        x = helper.getString('javier');
        
    }

}
