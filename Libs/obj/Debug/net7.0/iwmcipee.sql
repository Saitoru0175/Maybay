IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Airports] (
    [AirportID] int NOT NULL IDENTITY,
    [AirportCode] nvarchar(max) NOT NULL,
    [AirportName] nvarchar(max) NOT NULL,
    [City] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Airports] PRIMARY KEY ([AirportID])
);
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [Gender] nvarchar(max) NOT NULL,
    [Address] nvarchar(max) NOT NULL,
    [FullName] nvarchar(max) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Passengers] (
    [PassengerID] int NOT NULL IDENTITY,
    [FullName] nvarchar(max) NOT NULL,
    [Phone] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [Gender] nvarchar(max) NOT NULL,
    [Address] nvarchar(max) NOT NULL,
    [NgaySinh] datetime2 NULL,
    CONSTRAINT [PK_Passengers] PRIMARY KEY ([PassengerID])
);
GO

CREATE TABLE [Payments] (
    [PaymentID] int NOT NULL IDENTITY,
    [PaymentDate] datetime2 NULL,
    [PaymentAmount] decimal(18,2) NULL,
    [PaymentMethod] bit NULL,
    CONSTRAINT [PK_Payments] PRIMARY KEY ([PaymentID])
);
GO

CREATE TABLE [RefeshToken] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(max) NOT NULL,
    [Token] nvarchar(max) NOT NULL,
    [JwtId] nvarchar(max) NOT NULL,
    [IsUsed] bit NOT NULL,
    [IsRevoked] bit NOT NULL,
    [AddedDate] datetime2 NOT NULL,
    [ExpiryDate] datetime2 NOT NULL,
    CONSTRAINT [PK_RefeshToken] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Topics] (
    [TopicID] int NOT NULL IDENTITY,
    [name] nvarchar(max) NOT NULL,
    [slug] nvarchar(max) NOT NULL,
    [NgayViet] datetime2 NULL,
    [created_by] int NULL,
    CONSTRAINT [PK_Topics] PRIMARY KEY ([TopicID])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Flights] (
    [FlightID] int NOT NULL IDENTITY,
    [FlightNumber] varchar(50) NOT NULL,
    [DepartureDay] Date NULL,
    [ArrivalTime] time NULL,
    [DepartureTime] time NULL,
    [ArrivlaCity] int NULL,
    [DepartureCity] int NULL,
    [TotalSeats] int NOT NULL,
    [AvailableSeats] int NOT NULL,
    [HinhAnh] nvarchar(max) NOT NULL,
    [created_by] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_Flights] PRIMARY KEY ([FlightID]),
    CONSTRAINT [FK_Flights_Airports_ArrivlaCity] FOREIGN KEY ([ArrivlaCity]) REFERENCES [Airports] ([AirportID]),
    CONSTRAINT [FK_Flights_Airports_DepartureCity] FOREIGN KEY ([DepartureCity]) REFERENCES [Airports] ([AirportID]),
    CONSTRAINT [FK_Flights_AspNetUsers_created_by] FOREIGN KEY ([created_by]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Post] (
    [PostID] int NOT NULL,
    [TopicID] int NOT NULL,
    [title] nvarchar(max) NOT NULL,
    [slug] nvarchar(max) NOT NULL,
    [detail] nvarchar(max) NOT NULL,
    [img] nvarchar(max) NOT NULL,
    [type] nvarchar(max) NOT NULL,
    [created_at] datetime2 NULL,
    [created_by] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_Post] PRIMARY KEY ([PostID]),
    CONSTRAINT [FK_Post_AspNetUsers_created_by] FOREIGN KEY ([created_by]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Post_Topics_PostID] FOREIGN KEY ([PostID]) REFERENCES [Topics] ([TopicID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Fares] (
    [FareID] int NOT NULL IDENTITY,
    [FlightID] int NOT NULL,
    [FareType] nvarchar(max) NOT NULL,
    [FareAmount] decimal(18,2) NOT NULL,
    CONSTRAINT [PK_Fares] PRIMARY KEY ([FareID]),
    CONSTRAINT [FK_Fares_Flights_FlightID] FOREIGN KEY ([FlightID]) REFERENCES [Flights] ([FlightID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Seats] (
    [SeatID] int NOT NULL IDENTITY,
    [FlightID] int NOT NULL,
    [SeatNumber] nvarchar(max) NOT NULL,
    [SeatClass] nvarchar(max) NOT NULL,
    [SeatAvailable] int NOT NULL,
    CONSTRAINT [PK_Seats] PRIMARY KEY ([SeatID]),
    CONSTRAINT [FK_Seats_Flights_FlightID] FOREIGN KEY ([FlightID]) REFERENCES [Flights] ([FlightID]) ON DELETE CASCADE
);
GO

CREATE TABLE [Bookings] (
    [BookingID] int NOT NULL IDENTITY,
    [FlightID] int NOT NULL,
    [PassengerID] int NOT NULL,
    [PaymentID] int NOT NULL,
    [SeatID] int NOT NULL,
    [BookingDate] datetime2 NULL,
    [BookingStatus] bit NOT NULL,
    [TotalPrice] decimal(18,2) NOT NULL,
    [Verification] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Bookings] PRIMARY KEY ([BookingID]),
    CONSTRAINT [FK_Bookings_Flights_FlightID] FOREIGN KEY ([FlightID]) REFERENCES [Flights] ([FlightID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Bookings_Passengers_PassengerID] FOREIGN KEY ([PassengerID]) REFERENCES [Passengers] ([PassengerID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Bookings_Payments_PaymentID] FOREIGN KEY ([PaymentID]) REFERENCES [Payments] ([PaymentID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Bookings_Seats_SeatID] FOREIGN KEY ([SeatID]) REFERENCES [Seats] ([SeatID])
);
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE INDEX [IX_Bookings_FlightID] ON [Bookings] ([FlightID]);
GO

CREATE INDEX [IX_Bookings_PassengerID] ON [Bookings] ([PassengerID]);
GO

CREATE INDEX [IX_Bookings_PaymentID] ON [Bookings] ([PaymentID]);
GO

CREATE INDEX [IX_Bookings_SeatID] ON [Bookings] ([SeatID]);
GO

CREATE INDEX [IX_Fares_FlightID] ON [Fares] ([FlightID]);
GO

CREATE INDEX [IX_Flights_ArrivlaCity] ON [Flights] ([ArrivlaCity]);
GO

CREATE INDEX [IX_Flights_created_by] ON [Flights] ([created_by]);
GO

CREATE INDEX [IX_Flights_DepartureCity] ON [Flights] ([DepartureCity]);
GO

CREATE INDEX [IX_Post_created_by] ON [Post] ([created_by]);
GO

CREATE INDEX [IX_Seats_FlightID] ON [Seats] ([FlightID]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20231219035349_InitData', N'7.0.13');
GO

COMMIT;
GO

