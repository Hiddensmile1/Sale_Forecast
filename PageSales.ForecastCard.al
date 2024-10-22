page 50134 "Forecast Date Input"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Forecast Date Input';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ForecastDate; ForecastDate)
                {
                    ApplicationArea = All;
                    Caption = 'Forecast Date';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Forecast)
            {
                ApplicationArea = All;
                Caption = 'Ok';
                Image = Approve;
                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        ForecastDate: Date;

    procedure GetForecastDate(): Date
    begin
        exit(ForecastDate);
    end;
}