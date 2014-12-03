CREATE TABLE [dbo].[User]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[EMail] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](500) NULL,
	[CreationDate] [datetime] NULL,
	[ApprovalDate] [datetime] NULL,
	[LastLoginDate] [datetime] NULL,
	[IsLocked] [bit] NOT NULL,
	[PasswordQuestion] [nvarchar](max) NULL,
	[PasswordAnswer] [nvarchar](max) NULL,
	[ActivationToken] [nvarchar](200) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime2](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	),
	 CONSTRAINT [UX_User_EMail] UNIQUE NONCLUSTERED 
	(
		[EMail] ASC
	),
	 CONSTRAINT [UX_User_Login] UNIQUE NONCLUSTERED 
	(
		[Login] ASC
	)
)
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsLocked]  DEFAULT ((0)) FOR [IsLocked]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_EmailConfirmed]  DEFAULT ((0)) FOR [EmailConfirmed]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_PhoneNumberConfirmed]  DEFAULT ((0)) FOR [PhoneNumberConfirmed]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_TwoFactorEnabled]  DEFAULT ((0)) FOR [TwoFactorEnabled]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_LockoutEnabled]  DEFAULT ((0)) FOR [LockoutEnabled]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_AccessFailCount]  DEFAULT ((0)) FOR [AccessFailedCount]
GO

CREATE TABLE [UserRegistrationToken]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NULL,
	[Token] [nchar](10) NOT NULL,
	CONSTRAINT [PK_SecurityToken] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	),
	CONSTRAINT [UX_UserRegistrationToken_Token] UNIQUE NONCLUSTERED 
	(
		[Token] ASC
	)
)
GO

CREATE TABLE [dbo].[Role] (
    [Id]   BIGINT IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([Id] ASC)
)
GO

CREATE TABLE [dbo].[UserRole] (
    [UserId] BIGINT NOT NULL,
    [RoleId] BIGINT NOT NULL,
    CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK_UserRole_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserRole_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_RoleId]
    ON [dbo].[UserRole]([RoleId] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[UserRole]([UserId] ASC);
GO

CREATE TABLE [dbo].[UserLogin] (
    [UserId]        BIGINT NOT NULL,
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [ProviderKey]   NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_UserLogin] PRIMARY KEY CLUSTERED ([UserId] ASC, [LoginProvider] ASC, [ProviderKey] ASC),
    CONSTRAINT [FK_UserLogin_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[UserLogin]([UserId] ASC);
GO

CREATE TABLE [dbo].[UserClaim] (
    [Id]         BIGINT IDENTITY (1, 1) NOT NULL,
    [UserId]     BIGINT NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserClaim] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UserClaim_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_User_Id]
    ON [dbo].[UserClaim]([UserId] ASC);

GO