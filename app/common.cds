using {MigrationService} from '../srv/migration-service';
// using { sap.common } from '@sap/cds/common';

////////////////////////////////////////////////////////////////////////////
//
// Rollout List
//
annotate MigrationService.RolloutOverview with @(
  Common.SemanticKey: [RolloutName],
  UI                : {

    SelectionFields: [
      RolloutName,
      Status,
      CurrentMocks // Mock Name (free search)
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
  RolloutName  @Common.ValueList           : {
    CollectionPath: 'RolloutOverview',
    Parameters    : [{
      $Type            : 'Common.ValueListParameterInOut',
      LocalDataProperty: RolloutName,
      ValueListProperty: 'RolloutName'
    }]
  };

  // Status → Dropdown (Enum auto-handled)
  Status       @Common.ValueList           : {
    CollectionPath: 'RolloutOverview',
    Parameters    : [{
      $Type            : 'Common.ValueListParameterInOut',
      LocalDataProperty: Status,
      ValueListProperty: 'Status'
    }]
  };

  // Mock Name (CurrentMocks) → Free text search
  CurrentMocks @Search.defaultSearchElement: true;
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
