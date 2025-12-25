using { sap.capire.dmd_rollout as db } from '../db/schema';

service MigrationService {

  entity RolloutStatus as projection on db.RolloutStatus;

  @readonly
  entity RolloutOverview as projection on db.Rollouts {
      key id              as ID,
          name            as RolloutName,
          status          as Status,

          case
            when status = 'COMPLETED'     then 3
            when status = 'IN_PROGRESS'  then 2
            when status = 'ON_HOLD'       then 1
            when status = 'YET_TO_START' then 0
            else 0
          end              as StatusCriticality : Integer,

          startDate        as PlannedDate,
          actualStartDate as ActualDate,
          reason          as Reason,
          totalMocks      as TotalMocks,
          currentmock     as CurrentMocks,
          lastModifiedAt  as TimeStamp,
          mocks
  };

  entity Mocks as projection on db.Mocks;
}
