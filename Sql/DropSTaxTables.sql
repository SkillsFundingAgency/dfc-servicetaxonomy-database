ALTER TABLE [dbo].[WorkflowTypeStartActivitiesIndex] DROP CONSTRAINT [FK_WorkflowTypeStartActivitiesIndex]
GO
ALTER TABLE [dbo].[WorkflowTypeIndex] DROP CONSTRAINT [FK_WorkflowTypeIndex]
GO
ALTER TABLE [dbo].[WorkflowIndex] DROP CONSTRAINT [FK_WorkflowIndex]
GO
ALTER TABLE [dbo].[WorkflowBlockingActivitiesIndex] DROP CONSTRAINT [FK_WorkflowBlockingActivitiesIndex]
GO
ALTER TABLE [dbo].[UserIndex] DROP CONSTRAINT [FK_UserIndex]
GO
ALTER TABLE [dbo].[UserByRoleNameIndex_Document] DROP CONSTRAINT [FK_UserByRoleNameIndex_Document_Id]
GO
ALTER TABLE [dbo].[UserByRoleNameIndex_Document] DROP CONSTRAINT [FK_UserByRoleNameIndex_Document_DocumentId]
GO
ALTER TABLE [dbo].[UserByLoginInfoIndex] DROP CONSTRAINT [FK_UserByLoginInfoIndex]
GO
ALTER TABLE [dbo].[UserByClaimIndex] DROP CONSTRAINT [FK_UserByClaimIndex]
GO
ALTER TABLE [dbo].[UnpublishLaterPartIndex] DROP CONSTRAINT [FK_UnpublishLaterPartIndex]
GO
ALTER TABLE [dbo].[TaxonomyIndex] DROP CONSTRAINT [FK_TaxonomyIndex]
GO
ALTER TABLE [dbo].[PublishLaterPartIndex] DROP CONSTRAINT [FK_PublishLaterPartIndex]
GO
ALTER TABLE [dbo].[PageLocationPartIndex] DROP CONSTRAINT [FK_PageLocationPartIndex]
GO
ALTER TABLE [dbo].[LayerMetadataIndex] DROP CONSTRAINT [FK_LayerMetadataIndex]
GO
ALTER TABLE [dbo].[DeploymentPlanIndex] DROP CONSTRAINT [FK_DeploymentPlanIndex]
GO
ALTER TABLE [dbo].[ContentItemIndex] DROP CONSTRAINT [FK_ContentItemIndex]
GO
ALTER TABLE [dbo].[ContainedPartIndex] DROP CONSTRAINT [FK_ContainedPartIndex]
GO
ALTER TABLE [dbo].[AutoroutePartIndex] DROP CONSTRAINT [FK_AutoroutePartIndex]
GO
ALTER TABLE [dbo].[AliasPartIndex] DROP CONSTRAINT [FK_AliasPartIndex]
GO
ALTER TABLE [dbo].[TimeFieldIndex] DROP CONSTRAINT [FK_TimeFieldIndex]
GO
ALTER TABLE [dbo].[TextFieldIndex] DROP CONSTRAINT [FK_TextFieldIndex]
GO
ALTER TABLE [dbo].[NumericFieldIndex] DROP CONSTRAINT [FK_NumericFieldIndex]
GO
ALTER TABLE [dbo].[LinkFieldIndex] DROP CONSTRAINT [FK_LinkFieldIndex]
GO
ALTER TABLE [dbo].[HtmlFieldIndex] DROP CONSTRAINT [FK_HtmlFieldIndex]
GO
ALTER TABLE [dbo].[DateTimeFieldIndex] DROP CONSTRAINT [FK_DateTimeFieldIndex]
GO
ALTER TABLE [dbo].[DateFieldIndex] DROP CONSTRAINT [FK_DateFieldIndex]
GO
ALTER TABLE [dbo].[ContentPickerFieldIndex] DROP CONSTRAINT [FK_ContentPickerFieldIndex]
GO
ALTER TABLE [dbo].[BooleanFieldIndex] DROP CONSTRAINT [FK_BooleanFieldIndex]
GO
/****** Object:  Table [dbo].[WorkflowTypeStartActivitiesIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeStartActivitiesIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowTypeStartActivitiesIndex]
GO
/****** Object:  Table [dbo].[WorkflowTypeIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowTypeIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowTypeIndex]
GO
/****** Object:  Table [dbo].[WorkflowIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowIndex]
GO
/****** Object:  Table [dbo].[WorkflowBlockingActivitiesIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WorkflowBlockingActivitiesIndex]') AND type in (N'U'))
DROP TABLE [dbo].[WorkflowBlockingActivitiesIndex]
GO
/****** Object:  Table [dbo].[UserIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserIndex]
GO
/****** Object:  Table [dbo].[UserByRoleNameIndex_Document]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex_Document]') AND type in (N'U'))
DROP TABLE [dbo].[UserByRoleNameIndex_Document]
GO
/****** Object:  Table [dbo].[UserByRoleNameIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByRoleNameIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByRoleNameIndex]
GO
/****** Object:  Table [dbo].[UserByLoginInfoIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByLoginInfoIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByLoginInfoIndex]
GO
/****** Object:  Table [dbo].[UserByClaimIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserByClaimIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UserByClaimIndex]
GO
/****** Object:  Table [dbo].[UnpublishLaterPartIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnpublishLaterPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[UnpublishLaterPartIndex]
GO
/****** Object:  Table [dbo].[TaxonomyIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TaxonomyIndex]') AND type in (N'U'))
DROP TABLE [dbo].[TaxonomyIndex]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sysdiagrams]') AND type in (N'U'))
DROP TABLE [dbo].[sysdiagrams]
GO
/****** Object:  Table [dbo].[PublishLaterPartIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PublishLaterPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[PublishLaterPartIndex]
GO
/****** Object:  Table [dbo].[PageLocationPartIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PageLocationPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[PageLocationPartIndex]
GO
/****** Object:  Table [dbo].[LayerMetadataIndex]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LayerMetadataIndex]') AND type in (N'U'))
DROP TABLE [dbo].[LayerMetadataIndex]
GO
/****** Object:  Table [dbo].[IndexingTask]    Script Date: 25/08/2020 10:12:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IndexingTask]') AND type in (N'U'))
DROP TABLE [dbo].[IndexingTask]
GO
/****** Object:  Table [dbo].[Identifiers]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Identifiers]') AND type in (N'U'))
DROP TABLE [dbo].[Identifiers]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Document]') AND type in (N'U'))
DROP TABLE [dbo].[Document]
GO
/****** Object:  Table [dbo].[DeploymentPlanIndex]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeploymentPlanIndex]') AND type in (N'U'))
DROP TABLE [dbo].[DeploymentPlanIndex]
GO
/****** Object:  Table [dbo].[ContentItemIndex]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentItemIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContentItemIndex]
GO
/****** Object:  Table [dbo].[ContainedPartIndex]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainedPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContainedPartIndex]
GO
/****** Object:  Table [dbo].[AutoroutePartIndex]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AutoroutePartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[AutoroutePartIndex]
GO
/****** Object:  Table [dbo].[AuditSyncLog]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuditSyncLog]') AND type in (N'U'))
DROP TABLE [dbo].[AuditSyncLog]
GO
/****** Object:  Table [dbo].[AliasPartIndex]    Script Date: 25/08/2020 10:12:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AliasPartIndex]') AND type in (N'U'))
DROP TABLE [dbo].[AliasPartIndex]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TimeFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[TimeFieldIndex]
GO
/****** Object:  Table [dbo].[TextFieldIndex]    Script Date: 25/08/2020 15:10:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TextFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[TextFieldIndex]
GO
/****** Object:  Table [dbo].[NumericFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NumericFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[NumericFieldIndex]
GO
/****** Object:  Table [dbo].[LinkFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LinkFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[LinkFieldIndex]
GO
/****** Object:  Table [dbo].[HtmlFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HtmlFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[HtmlFieldIndex]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Document]') AND type in (N'U'))
DROP TABLE [dbo].[Document]
GO
/****** Object:  Table [dbo].[DateTimeFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[DateTimeFieldIndex]
GO
/****** Object:  Table [dbo].[DateFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[DateFieldIndex]
GO
/****** Object:  Table [dbo].[ContentPickerFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContentPickerFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[ContentPickerFieldIndex]
GO
/****** Object:  Table [dbo].[BooleanFieldIndex]    Script Date: 25/08/2020 15:10:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BooleanFieldIndex]') AND type in (N'U'))
DROP TABLE [dbo].[BooleanFieldIndex]
GO
