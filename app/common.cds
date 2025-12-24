using { MigrationService } from '../srv/migration-service';
// using { sap.common } from '@sap/cds/common';

annotate MigrationService.RolloutOverview with @UI.HeaderInfo: {
  TypeName       : 'Rollout',
  TypeNamePlural : 'Rollouts',
  Title          : { Value: RolloutName },
  Description    : { Value: Status }
};

////////////////////////////////////////////////////////////////////////////
//
// FORCE HEADER VISIBILITY (IMPORTANT)
//
annotate MigrationService.RolloutOverview with @UI.PresentationVariant: {
  Visualizations: ['@UI.LineItem']
};

////////////////////////////////////////////////////////////////////////////
//
// Rollout List
//
annotate MigrationService.RolloutOverview with @(
  Common.SemanticKey : [RolloutName],
  UI : {

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

////////////////////////////////////////////////////////////////////////////
//
// Filter behavior
//
annotate MigrationService.RolloutOverview with {

  // Rollout Name → Dropdown (Value Help)
  RolloutName
    @Common.ValueList: {
      CollectionPath: 'RolloutOverview',
      Parameters    : [{
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: RolloutName,
        ValueListProperty: 'RolloutName'
      }]
    }
    @Common.Placeholder: 'Select Rollout';

  // Status → Enum dropdown
  Status
    @Capabilities.FilterRestrictions.AllowedExpressions: ['MultiValue']
    @Common.Placeholder                                : 'Select Status';

  // CurrentMocks → Plain input (NO F4 HELP)
  CurrentMocks
    @Capabilities.FilterRestrictions.AllowedExpressions: ['SingleValue']
    @Common.Placeholder                                : 'Search by Current Mock';
};

////////////////////////////////////////////////////////////////////////////
//
// Disable Global Search
//
annotate MigrationService.RolloutOverview with @Capabilities.SearchRestrictions : {
  Searchable : false
};

////////////////////////////////////////////////////////////////////////////
//
// Object Page
//
// annotate MigrationService.RolloutOverview with @(UI : {

//   HeaderInfo : {
//     TypeName       : 'Rollout',
//     TypeNamePlural : 'Rollouts',
//     Title          : { Value: RolloutName },
//     Description    : { Value: Status }
//   },

//   Facets : [
//     {
//       $Type  : 'UI.ReferenceFacet',
//       Label  : 'Rollout Details',
//       Target : '@UI.FieldGroup#Details'
//     },
//     {
//       $Type  : 'UI.ReferenceFacet',
//       Label  : 'Progress',
//       Target : '@UI.FieldGroup#Progress'
//     },
//     {
//       $Type  : 'UI.ReferenceFacet',
//       Label  : 'Timeline',
//       Target : '@UI.FieldGroup#Timeline'
//     }
//   ],

//   FieldGroup #Details : {
//     Data : [
//       { Value: RolloutName },
//       { Value: Status },
//       { Value: Reason }
//     ]
//   },

//   FieldGroup #Progress : {
//     Data : [
//       { Value: TotalMocks },
//       { Value: CurrentMocks }
//     ]
//   },

//   FieldGroup #Timeline : {
//     Data : [
//       { Value: PlannedDate },
//       { Value: ActualDate },
//       { Value: TimeStamp }
//     ]
//   }
// });
