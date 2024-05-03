table 50150 "NonConformance Doc Table"
{
    DataClassification = ToBeClassified;
     Caption='Nonconformance Doc table';
    
      
    
    fields
    { 
        field(1;"No.."; Integer)
        {  Caption='No..';
    
         }
         field(2;"Type of nonconformity"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers=Product,Process,"Quality system";
        }
        field(3;"Nonconformity Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers="Product advertising","Problems in production process","Scheduled check Random check","Non-execution of defined rules/standards";

        }

        field(4; "CAQS Employee No.";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation="Employee"."No.";

        }
        field(17; "CAQS Employee";Code[250])
        {
            DataClassification = ToBeClassified;

            
         
        }
        field(5;"Posting Date"; Date)
        {   
            
                }
       

        
       
        field(6;"Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8;Quantity; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Lot; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Nonconformity Description"; Text[600])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Proposal for corrective or preventive action"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Comments;Text[600])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Penalty; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Actions taken"; Text[600])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers=Open,Closed;
        }
        field(16;"Closing NonConformity Date";Date){

        }
        field(18;"Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            
        }
        field(19;"Company Name";Text[100]){

        }
        field(20;"Company Phone No.";Text[100]){

        }
        field(21;"Company's Email";Text[100]){
            
        }
        field(22;"Picture";Blob){
              Subtype=Bitmap;
              
        }
       
    }
    
    keys
    {
        key(Key1; "No..","CAQS Employee No.")
        {  
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
       
}
