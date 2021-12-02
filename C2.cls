/**
 * @File Name          : ProvarHelper.cls
 * @Description        : 
 * @Author             : Daniel Utrera -> daniel.utrera@s4g.es
 * @Group              : 
 * @Last Modified By   : Daniel Utrera -> daniel.utrera@s4g.es
 * @Last Modified On   : 13/4/2020 10:15:07
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    26/3/2020   Daniel Utrera -> daniel.utrera@s4g.es     Initial Version
**/
public with sharing class ProvarHelper {
    public static void tearDown(){
        /* if([SELECT TestUser__c FROM User WHERE Id = :UserInfo.getUserId()].TestUser__c){ */
        if(1==1){
            Savepoint sp = Database.setSavepoint();
            try{
                String[] deleteQueries=new String[]
                {
                    'SELECT Id  FROM    Bypasser_integraciones__c       WHERE',
                    'SELECT Id  FROM    ServiceAppointment              WHERE',
                    'SELECT Id  FROM    WorkOrder                       WHERE',
                    'SELECT Id  FROM    Case                            WHERE',
                    'SELECT Id  FROM    Contrato__c                     WHERE',
                    'SELECT Id  FROM    Direccion__c                    WHERE',
                    'SELECT Id  FROM    Partner__c                      WHERE',
                    'SELECT Id  FROM    Producto__c                     WHERE',
                    'SELECT Id  FROM    Linea_de_Contrato__c            WHERE',
                    'SELECT Id  FROM    ConfiguracionCompania__c        WHERE',
                    'SELECT Id  FROM    Contact                         WHERE',
                    'SELECT Id  FROM    Account                         WHERE',
                    'SELECT Id  FROM    WorkType                        WHERE',
                    'SELECT Id  FROM    OperatingHours                  WHERE',
                    'SELECT Id  FROM    Gremio__c                       WHERE',
                    'SELECT Id  FROM    Gremio_Configuracion__c         WHERE',
                    'SELECT Id  FROM    Gremio_Recurso_de_Servicio__c   WHERE'
                };
                for(String deleteQuery:deleteQueries){
                    System.debug(deleteQuery+' CreatedById = \''+UserInfo.getUserId()+'\'');
                    sObject[] recordsToDelete=Database.query(deleteQuery+' CreatedById = \''+UserInfo.getUserId()+'\'');
                    if(!recordsToDelete.isEmpty()){
                        Database.delete(recordsToDelete);
                    }
                }
                delete [SELECT Id FROM Bypasser_integraciones__c WHERE CreatedById = :UserInfo.getUserId()];
                /*
                delete [SELECT Id FROM Bypasser_integraciones__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM ServiceAppointment WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM WorkOrder WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Case WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Contrato__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Direccion__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Partner__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Producto__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Linea_de_Contrato__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM ConfiguracionCompania__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Contact WHERE CreatedById = :UserInfo.getUserId()];
                //delete [SELECT Id FROM Account WHERE CreatedById = :UserInfo.getUserId()];
                for(Database.DeleteResult dr:Database.delete([SELECT Id FROM Account WHERE CreatedById = :UserInfo.getUserId()])){
                    System.debug('ID: '+dr.getId()+'__'+dr.isSuccess());
                }
                delete [SELECT Id FROM WorkType WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM OperatingHours WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Gremio__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Gremio_Configuracion__c WHERE CreatedById = :UserInfo.getUserId()];
                delete [SELECT Id FROM Gremio_Recurso_de_Servicio__c WHERE CreatedById = :UserInfo.getUserId()];
                */
                System.debug('RESULTADO: OK');
            }catch(Exception e){
                System.debug('RESULTADO: ERROR');
                System.debug(e);
                Database.rollback(sp);
                throw new DmlException(e.getMessage());
            }
        }else{
            throw new DmlException('No es un usuario de pruebas');
        }
    }
}