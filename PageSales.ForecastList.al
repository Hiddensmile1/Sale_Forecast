page 50109 "Sales Forecast Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Forecast Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Sales Amount"; Rec."Sales Amount")
                {
                    ApplicationArea = All;
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
                Caption = 'Generate Random Data';
                Image = NewDocument;

                trigger OnAction()
                var
                    SalesDataInput: Page "Sales Data Input";
                begin
                    SalesDataInput.RunModal();
                end;
            }
            action(ForecastSales)
            {
                ApplicationArea = All;
                Caption = 'Forecast Sales';
                Image = Forecast;

                trigger OnAction()
                var
                    SalesForecaster: Codeunit "Sales Forecaster ";
                begin
                    SalesForecaster.ForecastSales();
                end;
            }
        }
    }
}