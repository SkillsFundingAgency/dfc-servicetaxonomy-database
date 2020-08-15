
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AliasPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[AliasPartIndex]
GO
PRINT '[dbo].[AliasPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuditSyncLog]') AND type in (N'U'))
DROP TABLE [dbo].[AuditSyncLog]
GO
PRINT '[dbo].[AuditSyncLog] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoroutePartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[AutoroutePartIndex]
GO
PRINT '[dbo].[AliasPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainedPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContainedPartIndex]
GO
PRINT '[dbo].[ContainedPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentItemIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContentItemIndex]
GO
PRINT '[dbo].[ContentItemIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeploymentPlanIndex]') AND type in (N'U'))
DROP TABLE [dbo].[DeploymentPlanIndex]
GO
PRINT '[dbo].[DeploymentPlanIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Document]') AND type in (N'U'))
DROP TABLE [dbo].[Document]
GO
PRINT '[dbo].[Document] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Identifiers]') AND type in (N'U'))
DROP TABLE [dbo].[Identifiers]
GO
PRINT '[dbo].[Identifiers] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IndexingTask]') AND type in (N'U'))
DROP TABLE [dbo].[IndexingTask]
GO
PRINT '[dbo].[IndexingTask] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LayerMetadataIndex]') AND type in (N'U'))
DROP TABLE [dbo].[LayerMetadataIndex]
GO
PRINT '[dbo].[LayerMetadataIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PageLocationPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[PageLocationPartIndex]
GO
PRINT '[dbo].[PageLocationPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublishLaterPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[PublishLaterPartIndex]
GO
PRINT '[dbo].[PublishLaterPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxonomyIndex]') AND type in (N'U'))
DROP TABLE [dbo].[TaxonomyIndex]
GO
PRINT '[dbo].[TaxonomyIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnpublishLaterPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UnpublishLaterPartIndex]
GO
PRINT '[dbo].[UnpublishLaterPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByClaimIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByClaimIndex]
GO
PRINT '[dbo].[UserByClaimIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByLoginInfoIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByLoginInfoIndex]
GO
PRINT '[dbo].[UserByLoginInfoIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByRoleNameIndex]
GO
PRINT '[dbo].[UserByRoleNameIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex_Document]') AND type in (N'U'))
DROP TABLE [dbo].[UserByRoleNameIndex_Document]
GO
PRINT '[dbo].[UserByRoleNameIndex_Document] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserIndex]
GO
PRINT '[dbo].[AliasPartIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowBlockingActivitiesIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowBlockingActivitiesIndex]
GO
PRINT '[dbo].[WorkflowBlockingActivitiesIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowIndex]
GO
PRINT '[dbo].[WorkflowIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowTypeIndex]
GO
PRINT '[dbo].[WorkflowTypeIndex] DROPPED'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeStartActivitiesIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowTypeStartActivitiesIndex]
GO
PRINT '[dbo].[WorkflowTypeStartActivitiesIndex] DROPPED'
