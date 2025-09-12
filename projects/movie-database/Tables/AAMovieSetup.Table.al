table 50451 "AA Movie Setup"
{
    DataClassification = SystemMetadata;
    Caption = 'Movie Setup';

    fields
    {
        field(1; "AA Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }
        field(2; BackupType; Enum "AA Backup Type")
        {
            DataClassification = SystemMetadata;
            Caption = 'Backup Type';

        }
    }
    keys
    {
        key(PK; "AA Primary Key")
        {
            Clustered = true;
        }
    }
}