IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeStartActivitiesIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[WorkflowTypeStartActivitiesIndex] DROP CONSTRAINT IF EXISTS [FK_WorkflowTypeStartActivitiesIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[WorkflowTypeIndex] DROP CONSTRAINT IF EXISTS [FK_WorkflowTypeIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[WorkflowIndex] DROP CONSTRAINT IF EXISTS [FK_WorkflowIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowBlockingActivitiesIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[WorkflowBlockingActivitiesIndex] DROP CONSTRAINT IF EXISTS [FK_WorkflowBlockingActivitiesIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[UserIndex] DROP CONSTRAINT IF EXISTS [FK_UserIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex_Document]') AND type in (N'U'))
ALTER TABLE [dbo].[UserByRoleNameIndex_Document] DROP CONSTRAINT IF EXISTS [FK_UserByRoleNameIndex_Document_Id]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex_Document]') AND type in (N'U'))
ALTER TABLE [dbo].[UserByRoleNameIndex_Document] DROP CONSTRAINT IF EXISTS [FK_UserByRoleNameIndex_Document_DocumentId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByLoginInfoIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[UserByLoginInfoIndex] DROP CONSTRAINT IF EXISTS [FK_UserByLoginInfoIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByClaimIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[UserByClaimIndex] DROP CONSTRAINT IF EXISTS [FK_UserByClaimIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnpublishLaterPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[UnpublishLaterPartIndex] DROP CONSTRAINT IF EXISTS [FK_UnpublishLaterPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxonomyIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[TaxonomyIndex] DROP CONSTRAINT IF EXISTS [FK_TaxonomyIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublishLaterPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[PublishLaterPartIndex] DROP CONSTRAINT IF EXISTS [FK_PublishLaterPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PageLocationPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[PageLocationPartIndex] DROP CONSTRAINT IF EXISTS [FK_PageLocationPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LayerMetadataIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[LayerMetadataIndex] DROP CONSTRAINT IF EXISTS [FK_LayerMetadataIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GraphSyncPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[GraphSyncPartIndex] DROP CONSTRAINT IF EXISTS [FK_GraphSyncPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeploymentPlanIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[DeploymentPlanIndex] DROP CONSTRAINT IF EXISTS [FK_DeploymentPlanIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DashboardPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[DashboardPartIndex] DROP CONSTRAINT IF EXISTS [FK_DashboardPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentItemIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[ContentItemIndex] DROP CONSTRAINT IF EXISTS [FK_ContentItemIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentAuditTrailEventIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[ContentAuditTrailEventIndex] DROP CONSTRAINT IF EXISTS [FK_ContentAuditTrailEventIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentApprovalPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[ContentApprovalPartIndex] DROP CONSTRAINT IF EXISTS [FK_ContentApprovalPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainedPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[ContainedPartIndex] DROP CONSTRAINT IF EXISTS [FK_ContainedPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoroutePartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[AutoroutePartIndex] DROP CONSTRAINT IF EXISTS [FK_AutoroutePartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuditTrailEventIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[AuditTrailEventIndex] DROP CONSTRAINT IF EXISTS [FK_AuditTrailEventIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AliasPartIndex]') AND type in (N'U'))
ALTER TABLE [dbo].[AliasPartIndex] DROP CONSTRAINT IF EXISTS [FK_AliasPartIndex]
GO
/****** Object:  Table [dbo].[WorkflowTypeStartActivitiesIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[WorkflowTypeStartActivitiesIndex]
GO
/****** Object:  Table [dbo].[WorkflowTypeIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[WorkflowTypeIndex]
GO
/****** Object:  Table [dbo].[WorkflowIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[WorkflowIndex]
GO
/****** Object:  Table [dbo].[WorkflowBlockingActivitiesIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[WorkflowBlockingActivitiesIndex]
GO
/****** Object:  Table [dbo].[UserIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[UserIndex]
GO
/****** Object:  Table [dbo].[UserByRoleNameIndex_Document]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[UserByRoleNameIndex_Document]
GO
/****** Object:  Table [dbo].[UserByRoleNameIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[UserByRoleNameIndex]
GO
/****** Object:  Table [dbo].[UserByLoginInfoIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[UserByLoginInfoIndex]
GO
/****** Object:  Table [dbo].[UserByClaimIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[UserByClaimIndex]
GO
/****** Object:  Table [dbo].[UnpublishLaterPartIndex]    Script Date: 15/03/2021 11:37:12 ******/
DROP TABLE IF EXISTS [dbo].[UnpublishLaterPartIndex]
GO
/****** Object:  Table [dbo].[TaxonomyIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[TaxonomyIndex]
GO
/****** Object:  Table [dbo].[PublishLaterPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[PublishLaterPartIndex]
GO
/****** Object:  Table [dbo].[PageLocationPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[PageLocationPartIndex]
GO
/****** Object:  Table [dbo].[LayerMetadataIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[LayerMetadataIndex]
GO
/****** Object:  Table [dbo].[IndexingTask]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[IndexingTask]
GO
/****** Object:  Table [dbo].[Identifiers]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[Identifiers]
GO
/****** Object:  Table [dbo].[GraphSyncPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[GraphSyncPartIndex]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[Document]
GO
/****** Object:  Table [dbo].[DeploymentPlanIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[DeploymentPlanIndex]
GO
/****** Object:  Table [dbo].[DashboardPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[DashboardPartIndex]
GO
/****** Object:  Table [dbo].[ContentItemIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[ContentItemIndex]
GO
/****** Object:  Table [dbo].[ContentAuditTrailEventIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[ContentAuditTrailEventIndex]
GO
/****** Object:  Table [dbo].[ContentApprovalPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[ContentApprovalPartIndex]
GO
/****** Object:  Table [dbo].[ContainedPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[ContainedPartIndex]
GO
/****** Object:  Table [dbo].[AutoroutePartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[AutoroutePartIndex]
GO
/****** Object:  Table [dbo].[AuditTrailEventIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[AuditTrailEventIndex]
GO
/****** Object:  Table [dbo].[AliasPartIndex]    Script Date: 15/03/2021 11:37:13 ******/
DROP TABLE IF EXISTS [dbo].[AliasPartIndex]
GO
