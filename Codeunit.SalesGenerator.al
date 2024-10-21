codeunit 50136 "Sales Data Generator"
{
    procedure GenerateRandomSalesData(StartDate: Date; EndDate: Date; NumberOfEntries: Integer): Boolean
    var
        SalesForecastEntry: Record "Sales Forecast Entry";
        EntryDate: Date;
        i: Integer;
    begin
        if not ValidateInput(StartDate, EndDate, NumberOfEntries) then
            exit(false);

        SalesForecastEntry.Reset();
        SalesForecastEntry.DeleteAll();

        for i := 1 to NumberOfEntries do begin
            SalesForecastEntry.Init();
            SalesForecastEntry."Entry No" := 0;
            EntryDate := CalcDate(StrSubstNo('<+%1D>', Random(EndDate - StartDate)), StartDate);
            SalesForecastEntry.Validate("Date", EntryDate);
            SalesForecastEntry.Validate("Sales Amount", Random(10000));
            SalesForecastEntry.Insert(true)
        end;

        exit(true);
    end;

    local procedure ValidateInput(StartDate: Date; EndDate: Date; NumberOfEntries: Integer): Boolean

    begin
        if StartDate = 0D then begin
            Error('Enter Start Date before you proceed.');
            exit(false);
        end;
        if EndDate = 0D then begin
            Error('Input End Date.');
            exit(false);
        end;
        if EndDate < StartDate then begin
            Error('End Date must be greater or equals to Start Date.');
            exit(false);
        end;
        if (NumberOfEntries < 1) or (NumberOfEntries > 1000) then begin
            Error('Number of Entries must be between 1 to 1000');
            exit(false);
        end;

        exit(true);
    end;
}