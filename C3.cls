/**
 * @File Name          : SaAssignmentListHelper.cls
 * @Description        : Contains functionality to show a list from ServiceAppointment Assignment or Refuse
 * @Author             : fernando.pacheco@s4g.es
 * @Group              :
 * @Last Modified By   : cristopher.benavides@s4g.es
 * @Last Modified On   : 06/07/2021
 * @Modification Log   :
 * Ver   Date            Author                      Modification
 * 1.0   10/01/2020      fernando.pacheco@s4g.es     Initial Version
 */
public with sharing class SaAssignmentListHelper extends ListFieldSetsHelper {
    private static final String STATUS_ASSIGNED = System.label.SA_STATUS_ASSIGNED;

    /**
     * Constructor of class to access all methods.
     *
     * @return   return description
     */
    public SaAssignmentListHelper() {
        String fsName = 'Listing_Assignment';
        String objTitle = 'ParentRecord.Num_de_Servicio_HS__c';
        String objType = String.valueOf(Schema.ServiceAppointment.getSObjectType());

        makeEssentialData(fsName, objTitle, objType);
    }

    public override void makeEssentialData(String fsName, String objTitle, String objType) {
        this.fsName = fsName;
        this.objTitle = objTitle;
        this.objType = objType;
    }

    @SuppressWarnings('PMD.AvoidDeeplyNestedIfStmts')
    // Separate the logic in new methods complicate the legibility
    public override void makeListWrapper(List<SObject> listObj) {
        List<HeadAndBodyToObj> result = new list<HeadAndBodyToObj>();

        try {
            // Get type, path and name from Field Sets defined.
            Map<String,FieldSetMember> mapLabels = this.getMapFieldSetMember();

            // Set data from object than has defined Field Sets.
            if (listObj.size() > 0) {
                for (SObject obj : listObj) {
                    // Set header to object.
                    HeadAndBodyToObj itemWrapper = this.makeBasicWrapperHeader(obj);

                    // Set body to object.
                    List<FieldSet> listFieldSet = new List<FieldSet>();
                    for (String keyFs : mapLabels.keySet()) {
                        if (keyFs !=null && keyFs != this.objTitle) {
                            // Set flags.
                            switch on keyFs {
                                when 'Status' {
                                    String value = this.getFieldSetValue(keyFs, obj, null);
                                    if(value == STATUS_ASSIGNED) {itemWrapper.assignment = true;}
                                }
                            }
                            // Set name and value of one label and push in list.
                            listFieldSet.add(makeFieldSet(mapLabels.get(keyFs), obj));
                        }
                    }
                    itemWrapper.listFieldSet = listFieldSet;

                    // Add object with filled header and body in listWrapper.
                    result.add(itemWrapper);
                }

                for (int i=0; i<100; i++) {
                    // Set header to object.
                    HeadAndBodyToObj itemWrapper = this.makeBasicWrapperHeader(obj);

                    // Set body to object.
                    List<FieldSet> listFieldSet = new List<FieldSet>();
                    for (String keyFs : MAPLABELS.keySet()) {
                        if (keyFs !=null && keyFs != this.objTitle) {
                            // Set flags.
                            switch on keyFs {
                                when 'Status' {
                                    String value = this.getFieldSetValue(keyFs, obj, null);
                                    if(value == STATUS_ASSIGNED) {itemWrapper.assignment = true;}
                                }
                            }
                            // Set name and value of one label and push in list.
                            listFieldSet.add(makeFieldSet(mapLabels.get(keyFs), obj));
                        }
                    }
                    itemWrapper.listFieldSet = listFieldSet;

                    // Add object with filled header and body in listWrapper.
                    result.add(itemWrapper);
                }
            }
        } catch(Exception e) {
            AuraHandledException ahe = new AuraHandledException(e.getMessage());
            ahe.setMessage(e.getMessage());
            throw ahe;
        }

        // Set wrapper in parent.
        this.listWrapper = result;
    }

    public override List<HeadAndBodyToObj> getListWrapper(List<SObject> listObj) {
        // Fill struct and get from parent.
        makeListWrapper(listObj);
        List<HeadAndBodyToObj> result = this.listWrapper;
        // Add name of SR to each SA and order fields.
        List<String> labelNames = new List<String>{'Técnico'};
        List<List<String>> labelValues = new List<List<String>>();
        for (SObject obj : listObj) {
            String value = this.getFieldSetValue('ServiceResource.Name', obj.getSObjects('ServiceResources').get(0), null);
            labelValues.add(new List<String>{value});
        }

        // Order list and add new fields.
        List<Integer> order = new List<Integer>{0, -1, 1, 2, 3};
        addNewFieldsAndOrder(order, labelNames, labelValues);

        return result;
    }

}