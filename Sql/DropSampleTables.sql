/****** Object:  Table [dbo].[SampleTable1]    Script Date: 14/08/2020 23:37:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SampleTable1]') AND type in (N'U'))
    DROP TABLE [dbo].[SampleTable1];
    PRINT N'[dbo].[SampleTable1] DROPPED';
ELSE
    PRINT N'[dbo].[SampleTable1] NOT FOUND';
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SampleTable2]') AND type in (N'U'))
    DROP TABLE [dbo].[SampleTable1];
    PRINT N'[dbo].[SampleTable2] DROPPED';
ELSE
    PRINT N'[dbo].[SampleTable2] NOT FOUND';
GO


