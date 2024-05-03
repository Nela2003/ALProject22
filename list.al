page 50150 "Responsible Employee"
{
    Caption = 'PageName';
    PageType = List;
    DataCaptionFields="No..";
  
   

    AutoSplitKey=true;
   MultipleNewLines=true;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Employee test" ;
    
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No.";Rec."No."){
                    ApplicationArea=all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Employee1: record Employee;
                    begin
                       Employee1.SetRange("No.", Rec."No.");
                        if Employee1.FindFirst() then begin
                            Vlera := Employee1."Search Name";

                        end;
                        Rec.Validate(Rec."Employee", Vlera); 
                    end;
                      

                }
                field(Employee;Rec.Employee){
                    ApplicationArea=all;
                }
                field(Date;Rec.Date){
                    ApplicationArea=all;
                }
                field("Report No.";Rec."No.."){
                    // trigger OnValidate();
                    // var page:page "NonConformity Rep";
                    // begin 
                    //  page.hello();   
                    // end;
                    ApplicationArea=all;
                }
                
            }
        }
      
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction();
                begin
                    
                end;



                
            }
        }
    }
    var Vlera: Code[250];


     trigger OnNewRecord(BelowxRec:Boolean)
 var
    myInt: Integer;
 begin
    Rec.SetupNewLine;
 end;



//     trigger OnNewRecord(BelowxRec:Boolean)
//  var
//     myInt: Integer;
//  begin
//     Rec.SetupNewLine;
//  end;
}