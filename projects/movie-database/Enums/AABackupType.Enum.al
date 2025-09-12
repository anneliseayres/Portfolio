enum 50450 "AA Backup Type" implements "AA Backup"
{
    Extensible = true;
    
    value(0; CSV)
    {
        Caption = 'CSV', Locked = true;
        Implementation = "AA Backup" = "AA Backup CSV";
    }
     value(1; XSLX)
    {
        Caption = 'XSLX' , Locked = true;
        Implementation = "AA Backup" = "AA Backup XSLX";
    }
     value(2; JSON)
    {
        Caption = 'JSON', Locked = true; 
        Implementation = "AA Backup" = "AA Backup JSON";
    }
     value(3; XML)
    {
        Caption = 'XML', Locked = true;
        Implementation = "AA Backup" = "AA Backup XML";
    }
}