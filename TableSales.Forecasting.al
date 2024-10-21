table 50101 "Sales Forecast Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Sales Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

}