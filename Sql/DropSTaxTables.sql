/****** Object:  Table [dbo].[SampleTable1]    Script Date: 14/08/2020 23:37:44 ******/
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SampleTable1]') AND type in (N'U'))
--DROP TABLE [dbo].[SampleTable1]
--GO
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SampleTable2]') AND type in (N'U'))
--DROP TABLE [dbo].[SampleTable2]
--GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AliasPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[AliasPartIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuditSyncLog]') AND type in (N'U'))
DROP TABLE [dbo].[AuditSyncLog]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoroutePartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[AutoroutePartIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainedPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContainedPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentItemIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContentItemIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeploymentPlanIndex]') AND type in (N'U'))
DROP TABLE [dbo].[DeploymentPlanIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Document]') AND type in (N'U'))
DROP TABLE [dbo].[Document]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Identifiers]') AND type in (N'U'))
DROP TABLE [dbo].[Identifiers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IndexingTask]') AND type in (N'U'))
DROP TABLE [dbo].[IndexingTask]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LayerMetadataIndex]') AND type in (N'U'))
DROP TABLE [dbo].[LayerMetadataIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PageLocationPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[PageLocationPartIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublishLaterPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[PublishLaterPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxonomyIndex]') AND type in (N'U'))
DROP TABLE [dbo].[TaxonomyIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnpublishLaterPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UnpublishLaterPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByClaimIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByClaimIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByLoginInfoIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByLoginInfoIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByRoleNameIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex_Document]') AND type in (N'U'))
DROP TABLE [dbo].[UserByRoleNameIndex_Document]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowBlockingActivitiesIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowBlockingActivitiesIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowIndex]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowTypeIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeStartActivitiesIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowTypeStartActivitiesIndex]
GO
