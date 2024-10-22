page 50192 "Sales Data Input"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Sales Data Input';

    layout
    {
        area(Content)
        {
            group(InputFields)
            {
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                }
                field(TotalEntries; TotalEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Total Entries';
                    MinValue = 1;
                    MaxValue = 1000;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateData)
            {
                ApplicationArea = All;
                Caption = 'Generate Data';
                Image = NewDocument;

                trigger OnAction()
                var
                    SalesDataGenerator: Codeunit "Sales Data Generator";
                begin
                    if SalesDataGenerator.GenerateRandomSalesData(FromDate, ToDate, TotalEntries) then
                        Message('Data Generated Successfully');
                end;
            }
        }
    }

    var
        FromDate: Date;

        ToDate: Date;

        TotalEntries: Integer;
}