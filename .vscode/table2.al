table 50151 "Employee test"
{   
    DataClassification = ToBeClassified;
    DrillDownPageID=50150 ;
    LookupPageID=50150;
   

  fields
    {
        field(1;"No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation=Employee."No.";
            ValidateTableRelation=false;
            
        }
       
        field(2;"Employee";Code[250]){

        }
        field(3;"No..";Integer){
            Caption='No..';
            //   trigger OnValidate();
            //   begin 
            //     "Report No.":=Nonconformance."No.";
            //     Rec.Modify();
            //   end;  
            TableRelation="NonConformance Doc Table"."No..";
            ValidateTableRelation=false;
        }
        field(4;"Line No.";Integer){

            AutoIncrement=true;
        }
        field(5;"Date";Date){

        }
      
    }
    
    keys
    {
        key(Key1;"Line No.","No..")
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
        Nonconformance:Record "NonConformance Doc Table";
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;



    procedure SetupNewLine()
var
 EmployeeCommentLine: Record "Employee test";
 Employee1:Record Employee;
 begin

 EmployeeCommentLine.SetRange("No..","No..");


 EmployeeCommentLine.SetRange("Date",WorkDate);
 if not EmployeeCommentLine.FindFirst() then begin 
            Date := WorkDate;

        OnAfterSetUpNewLine(Rec, EmployeeCommentLine);
    end;


 
 end;
  [IntegrationEvent(false, false)]
    local procedure OnAfterSetUpNewLine(var EmployeeCommentLine: Record "Employee test"; var CommentLineFilter: Record "Employee test")
    begin
    end;
    
}