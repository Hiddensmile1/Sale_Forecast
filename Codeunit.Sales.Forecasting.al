codeunit 50124 "Sales Forecaster "
{
    procedure ForecastSales()
    var
        SalesForecastEntry: Record "Sales Forecast Entry";
        TotalSales: Decimal;
        EntryCount: Integer;
        ForecastDate: Date;
        LastDataDate: Date;
        ForecastedSales: Decimal;
    begin
        // This code throw error if you don't have any forecasting and you are trying to find any data in your record, it will throw error
        SalesForecastEntry.Reset();
        if not SalesForecastEntry.FindSet() then begin

            Error('No Sales Data Available for Forecasting');
            exit
        end;
        repeat
            TotalSales += SalesForecastEntry."Sales Amount";
            EntryCount += 1;
            if SalesForecastEntry."Date" > LastDataDate then
                LastDataDate := SalesForecastEntry."Date";
        until SalesForecastEntry.Next() = 0;

        if not GetForecastDate(ForecastDate) then
            exit;
        if ForecastDate <= LastDataDate then begin
            Error('Forecast Date must be greater than the last data date (%1).', LastDataDate);
        end;
        ForecastedSales := CalculateForecast(SalesForecastEntry, ForecastDate);
        Message('Forecasted Sales for %1 is %2', ForecastDate, ForecastedSales);
    end;

    local procedure GetForecastDate(var ForecastDate: Date): Boolean
    var
        ForeCastDataPage: Page "Forecast Date Input";
    begin
        ForeCastDataPage.RunModal();
        ForecastDate := ForeCastDataPage.GetForecastDate();
        if ForecastDate = 0D then begin
            Error('Please Enter a valid forecast date');
            exit(false);
        end;
        exit(true);
    end;


    local procedure CalculateForecast(var SalesForecastEntry: Record "Sales Forecast Entry"; ForecastDate: Date): Decimal
    var
        // Creating multiple variables
        TotalSales: Decimal;
        EntryCount: Integer;
        DaysDifference: Integer;
        AverageDailySales: Decimal;
        WeekDay: Integer;
        MonthDay: Integer;
    begin
        // This discription remove all filters
        SalesForecastEntry.Reset();
        SalesForecastEntry.SetFilter("Date", '>=%1', CalcDate('<-30D>', ForecastDate));
        if SalesForecastEntry.FindSet() then
            repeat
                // This below code means if there are lots of records, it will search through all the records and find the SalesForecastEntry
                TotalSales += SalesForecastEntry."Sales Amount";
                EntryCount += 1;
            until SalesForecastEntry.Next = 0;

        if EntryCount = 0 then
            Error('Not Enough Data for Forecasting');

        AverageDailySales := TotalSales / EntryCount;

        // Adjust for day of the week

        WeekDay := Date2DWY(ForecastDate, 1);
        // The below code is used to find the weekday from this above weekday code
        case WeekDay of
            1, 7:
                AverageDailySales *= 0.7;

            3, 4, 5, 6:
                AverageDailySales *= 1.1;
        end;

        // Adjust for day of the month
        MonthDay := Date2DMY(ForecastDate, 1);
        if (MonthDay >= 1) and (MonthDay <= 5) then
            AverageDailySales *= 1.2
        else if (MonthDay >= 25) and (MonthDay <= 31) then
            AverageDailySales *= 0.9;
        exit(Round(AverageDailySales, 0.01));
    end;
}