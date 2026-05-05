USE shl;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[TeamId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Team] ADD  CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Team] ADD  CONSTRAINT [DEFAULT_Team_TeamId]  DEFAULT (newid()) FOR [TeamId]
ALTER TABLE Team
ADD CONSTRAINT UQ_Team_Name UNIQUE (Name);
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[players](
	[PlayerId] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Position] [nvarchar](50) NULL,
	[Nationality] [nvarchar](100) NULL,
	[TeamId] [uniqueidentifier] NULL,
	[Season] [nvarchar](50) NULL,
	[GamesPlayed] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[players] ADD  CONSTRAINT [PK_players] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[players] ADD  CONSTRAINT [UQ_Player] UNIQUE NONCLUSTERED 
(
	[FirstName] ASC,
	[LastName] ASC,
	[TeamId] ASC,
	[Season] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[players] ADD  CONSTRAINT [DEFAULT_players_PlayerId]  DEFAULT (newid()) FOR [PlayerId]
GO
ALTER TABLE [dbo].[players]  WITH CHECK ADD  CONSTRAINT [FK_players_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([TeamId])
GO
ALTER TABLE [dbo].[players] CHECK CONSTRAINT [FK_players_Team]
GO
ALTER TABLE [dbo].[players]  WITH CHECK ADD  CONSTRAINT [CK_players_position] CHECK  (([Position]='Målvakt' OR [Position]='Forward' OR [Position]='Back'))
GO
ALTER TABLE [dbo].[players] CHECK CONSTRAINT [CK_players_position]
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GoalieStats](
	[GoalieStatId] [uniqueidentifier] NOT NULL,
	[SavePercentage] [decimal](5, 2) NULL,
	[GoalsAgainstAverage] [decimal](5, 2) NULL,
	[Shutouts] [int] NULL,
	[Saves] [int] NULL,
	[GoalsAgainst] [int] NULL,
	[PlayerId] [uniqueidentifier] NULL,
	[Season] [nvarchar](50) NULL,
	[Competition] [nvarchar](50) NULL,
	[GamesPlayed] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoalieStats] ADD  CONSTRAINT [PK_GoalieStats] PRIMARY KEY CLUSTERED 
(
	[GoalieStatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GoalieStats] ADD  CONSTRAINT [DEFAULT_GoalieStats_GoalieStatId]  DEFAULT (newid()) FOR [GoalieStatId]
GO
ALTER TABLE [dbo].[GoalieStats]  WITH CHECK ADD  CONSTRAINT [FK_GoalieStats_players] FOREIGN KEY([PlayerId])
REFERENCES [dbo].[players] ([PlayerId])
GO
ALTER TABLE [dbo].[GoalieStats] CHECK CONSTRAINT [FK_GoalieStats_players]
GO



