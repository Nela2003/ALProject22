page 50151 "NonConformity Rep"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "NonConformance Doc Table";
    Caption = 'Nonconformance Quality Report';
    DataCaptionFields="No..";
   
 

    layout
    {
        area(Content)
        {

            field("No.."; Rec."No..")
            {
                Caption = 'No.';
                ApplicationArea = all;
                // trigger OnValidate();
                
                // begin
                //     if Rec."No."<>'' then 
                //  Responsibletable.Validate("Report No.",Rec."No.");
                // //  Employeetest.Validate("Report No.",Rec."No.");
                // Employeetest."Report No.":=Rec."No.";
                // REc.Modify();
                // //  Rec.Modify();
                // end;

            }
            group(General)
            {
                field("Type of nonconformity"; Rec."Type of nonconformity")
                {
                    ApplicationArea = all;
                }
                field("CAQS Employee No."; Rec."CAQS Employee No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate();
                    var
                        Employee1: record Employee;
                    begin
                        Employee1.SetRange("No.", Rec."CAQS Employee No.");
                        if Employee1.FindFirst() then begin
                            Vlera := Employee1."Search Name";

                        end;
                        Rec.Validate("CAQS Employee", Vlera);

                    end;
                }
                field("CAQS Employee"; Rec."CAQS Employee")
                {
                    ApplicationArea = all;




                }
                field("Nonconformity Reason"; Rec."Nonconformity Reason")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;

                    Editable = Vlbool2;
                    trigger OnValidate();
                    begin

                      


                        vlbool2 := false;
                    end;



                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Applicationarea = all;
                    Visible = false;
                    trigger OnValidate();
                    begin

                        Rec."Creation Date" := System.Today();
                     

                        Rec.Validate(Rec."Posting Date", Rec."Creation Date");
                    end;

                }
            }
            
            group("Nonconformity Details")
            {
                field("Item No."; Rec."Item No.")
                {    TableRelation=Item."No.";
                    ApplicationArea = all;
                 


                     trigger OnValidate();
                    var
                        Item: record Item;
                    begin
                        Item.SetRange("No.", Rec."Item No.");
                        if Item.FindFirst() then begin
                            description := Item.Description;

                        end;
                        Rec.Validate("Description", description);

                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Nonconformity Description"; Rec."Nonconformity Description")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Lot; Rec.Lot)
                {
                    ApplicationArea = all;
                }
            }
            group("Corrective/Preventive Action")
            {
                field("Proposal for corrective or preventive action"; Rec."Proposal for corrective or preventive action")
                {
                    ApplicationArea = all;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                }
                field(Penalty; Rec.Penalty)
                {
                    ApplicationArea = all;
                }
                field("Actions taken"; Rec."Actions taken")
                {
                    ApplicationArea = all;
                }

            }
            group(Closed)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        dt1:date;
                    begin
                      
                        if ((Rec.Status=Rec.Status::Closed)and (XRec.Status=xRec.Status::Open)) then begin 
                            vlbool2:=false;
                          dt1:=System.Today();
                          Rec.Validate("Closing NonConformity Date",dt1);
                        
                        end
                         else  if ((Rec.Status=Rec.Status::Open) and (XRec.Status=xRec.Status::Closed)   ) then begin
                                vlbool2:=true;
                                dt1:=0D;
                                Rec.Validate("Closing NonConformity Date",dt1);
                            
                                Rec.Modify();
                             end;
                            end;
                          

                       
                    
                }
                field("Closing NonConformity Date"; Rec."Closing NonConformity Date")
                {
                    ApplicationArea = all;

                   
                    
                    Editable = Vlbool2;
                    
                   
                }
            }

          
          
        }
    }

    actions
    {
        area(Processing)
        {
            action("&Responsible Employee")
            {
                Image = Action;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

               Runobject=Page "Responsible Employee";
               RunPageLink="No.."=field("No..");
              
                ToolTip = 'Responsible Employee of the nonconformity';
            //     trigger OnAction();
            //    var  Employeetable: Record "Employee test";
            //     begin 
                  
            //         Employeetable."Report No.":=Nonconformance.RepNo();

                    
            //     end;
            //     trigger OnAction();
           
            // var test:Record "Employee test";
            //     begin 
            //         Responsibletable.SetRange("Report No.",Rec."No.");
            //         If Responsibletable.FindSet() then begin  repeat
                       
            //                test."No.":=Responsibletable."No.";
            //                test.Employee:=Responsibletable.Employee;
            //                test.Insert();
                           
                           
                        

                      
            //             until Responsibletable.Next()=0;
                  
            //         end;
                  
            //         Page.Run(Page::"Responsible Employee",test);

                      
            //     end;
                  
                    
                   
           
             
            }
            action("&Print")
            {

                Image = Print;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;

               
                // RunObject = Report "Nonconformance Report";
             trigger OnAction();
             var
                myInt: Integer;
                 NonConform:Record "NonConformance Doc Table";
             begin
                Rec.SetRange("No..",Rec."No..");
                if Rec.FindFirst() then begin 
                     Report.Run(50100,true,true,Rec) ;
                end
             
             end;
                
                
            }
            action("Open in Excel")
            {
                Image = Export;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var 
                begin
              ExportReport(Rec);
                end;

            }

        }

    }

    var
    
        Vlera: Code[250];
        Vlbool2: boolean;
        dt: date;
        description:text[100];
      
        //  Response: Record "Responsible Employee table" temporary;
         Employeetest:Record "Employee test";
         Nonconformance:Record "NonConformance Doc Table";
         
         
          
   
    trigger OnAfterGetRecord();
    // var
    //     CompanyInfo: Record "Company Information";
        
    begin
        Rec."Creation Date" := System.WorkDate();
       

        Rec.Validate(Rec."Posting Date", Rec."Creation Date");

      
        

        // Employeetest.Validate("Report No.",Rec."No.");
        // Employeetest."Report No.":=REc."No.";
        // Rec.Modify();
     
        
    end;
        



  
    procedure ExportReport(var ReportRec :Record  "NonConformance Doc Table")
var TempExcelBuffer:Record "Excel Buffer" temporary;
     Reportlbl: label 'Report NonConformance';
      ExcelFileName: label 'Report Nonconformance_%1_%2';
       begin 
   TempExcelBuffer.Reset();
    TempExcelBuffer.DeleteAll();
     TempExcelBuffer.NewRow();
     TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Type of nonconformity"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
     TempExcelBuffer.AddColumn(ReportRec.FieldCaption("CAQS Employee No."),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("CAQS Employee"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Nonconformity Reason"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Posting Date"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Item No."),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption(Quantity),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption(Description),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption(Lot),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Proposal for corrective or preventive action"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption(Comments),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption(Penalty),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Actions taken"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption(Status),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.FieldCaption("Closing NonConformity Date"),false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
       ReportRec.SetRange("No..",Rec."No..");
      if ReportRec.FindSet() then  begin repeat 
TempExcelBuffer.NewRow();
TempExcelBuffer.AddColumn(ReportRec."CAQS Employee",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text);
 TempExcelBuffer.AddColumn(ReportRec."CAQS Employee No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec."CAQS Employee",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec."Nonconformity Reason",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec."Posting Date",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Date  );
      TempExcelBuffer.AddColumn(ReportRec."Item No.",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.Quantity,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.Description,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.Lot,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec."Proposal for corrective or preventive action",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.Comments,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.Penalty,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec."Actions taken",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec.Status,false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Text  );
      TempExcelBuffer.AddColumn(ReportRec."Closing NonConformity Date",false,'',false,false,false,'',TempExcelBuffer."Cell Type"::Date  );
until ReportRec.Next()=0;
      end;

      TempExcelBuffer.CreateNewBook(Reportlbl);
      TempExcelBuffer.WriteSheet(Reportlbl,CompanyName,UserId);
      TempExcelBuffer.CloseBook();
      TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName,CurrentDateTime,UserId));
      TempExcelBuffer.OpenExcel();
    
       end;





       ////////////
       procedure hello();
      
       begin
        REc."No..":=Employeetest."No..";
       end;

                     
}