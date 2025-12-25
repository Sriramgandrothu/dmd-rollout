using { MigrationService } from '../srv/migration-service';

////////////////////////////////////////////////////////////
// ===================== ROLLOUTS =========================
////////////////////////////////////////////////////////////

// Rollout Header
annotate MigrationService.RolloutOverview with @UI.HeaderInfo: {
  TypeName      : 'Rollout',
  TypeNamePlural: 'Rollouts',
  Title         : { Value: RolloutName },
  Description   : { Value: Status }
};

// Force Header Visibility
annotate MigrationService.RolloutOverview with @UI.PresentationVariant: {
  Visualizations: ['@UI.LineItem']
};

// Rollout List Report
annotate MigrationService.RolloutOverview with @(
  Common.SemanticKey: [RolloutName],
  UI: {
    SelectionFields: [
      RolloutName,
      Status,
      CurrentMocks
    ],

    LineItem       : [
      {
        Value: RolloutName,
        Label: 'Rollout Name'
      },
      {
        Value      : Status,
        Label      : 'Status',
        Criticality: StatusCriticality
      },
      {
        Value: PlannedDate,
        Label: 'Planned Date'
      },
      {
        Value: ActualDate,
        Label: 'Actual Date'
      },
      {
        Value: Reason,
        Label: 'Reason'
      },
      {
        Value: TotalMocks,
        Label: 'Total Mocks'
      },
      {
        Value: CurrentMocks,
        Label: 'Current Mocks'
      },
      {
        Value: TimeStamp,
        Label: 'Last Modified At'
      }
    ]
  }
);

// Rollout Filters
annotate MigrationService.RolloutOverview with {

  RolloutName
  @Common.ValueList: {
    CollectionPath: 'RolloutOverview',
    Parameters: [{
      $Type: 'Common.ValueListParameterInOut',
      LocalDataProperty: RolloutName,
      ValueListProperty: 'RolloutName'
    }]
  }
  @Common.Placeholder: 'Select Rollout';

  Status
  @Common.ValueList: {
    CollectionPath: 'RolloutStatus',
    Parameters: [{
      $Type: 'Common.ValueListParameterInOut',
      LocalDataProperty: Status,
      ValueListProperty: 'Status'
    }]
  }
  @Capabilities.FilterRestrictions.AllowedExpressions: ['MultiValue']
  @Common.Placeholder: 'Select Status';

  CurrentMocks
  @Capabilities.FilterRestrictions.AllowedExpressions: ['SingleValue']
  @Common.Placeholder: 'Search by Current Mock';
};

// Disable Global Search for Rollouts
annotate MigrationService.RolloutOverview with @Capabilities.SearchRestrictions: { Searchable: false };

// Object Page Facets (ONLY MOCKS)
annotate MigrationService.RolloutOverview with @UI.Facets: [
  {
    $Type  : 'UI.ReferenceFacet',
    Label  : 'Mocks',
    Target : 'mocks/@UI.LineItem'
  }
];

////////////////////////////////////////////////////////////
// ===================== MOCKS ===========================
////////////////////////////////////////////////////////////

// Disable Global Search for Mocks
annotate MigrationService.Mocks with @Capabilities.SearchRestrictions: { Searchable: false };

// Mocks Table (Columns as requested)
annotate MigrationService.Mocks with @UI.LineItem: [
  { Value: name,              Label: 'Mock' },
  { Value: status,            Label: 'Status' },
  { Value: startDate,         Label: 'Start Date' },
  { Value: endDate,           Label: 'End Date' },
  { Value: completionPercent, Label: 'Loaded %' },
  { Value: lastModifiedAt,    Label: 'Time' }
];

// Enable Column Filters for Mocks Table
annotate MigrationService.Mocks with {

  // Mock name (text filter)
  name
  @Capabilities.FilterRestrictions.AllowedExpressions: ['SingleValue']
  @Common.Placeholder: 'Filter by Mock';

  // Status (dropdown)
  status
  @Capabilities.FilterRestrictions.AllowedExpressions: ['MultiValue']
  @Common.ValueList: {
    CollectionPath: 'RolloutStatus',
    Parameters: [{
      $Type: 'Common.ValueListParameterInOut',
      LocalDataProperty: status,
      ValueListProperty: 'Status'
    }]
  }
  @Common.Placeholder: 'Select Status';
};

// Mock Object Page Header
annotate MigrationService.Mocks with @UI.HeaderInfo: {
  TypeName      : 'Mock',
  TypeNamePlural: 'Mocks',
  Title         : { Value: name },
  Description   : { Value: status }
};

// Hide Technical ID
annotate MigrationService.Mocks with {
  ID @UI.Hidden: true;
};

// Mock Object Page – Details
annotate MigrationService.Mocks with @UI.FieldGroup #Details: {
  Data: [
    { Value: name },
    { Value: status },
    { Value: completionPercent },
    { Value: startDate },
    { Value: endDate },
    { Value: actualStartDate },
    { Value: actualEndDate },
    { Value: lastModifiedAt }
  ]
};

// Mock Object Page Facet
annotate MigrationService.Mocks with @UI.Facets: [
  {
    $Type  : 'UI.ReferenceFacet',
    Label  : 'Mock Details',
    Target : '@UI.FieldGroup#Details'
  }
];
