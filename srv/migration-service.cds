using { sap.capire.dmd_rollout as db } from '../db/schema';

service MigrationService {

  @readonly
  entity RolloutOverview as
    projection on db.Rollouts {

      key name             as RolloutName,
          status           as Status,
          case
            when status = 'COMPLETED'     then 3
            when status = 'YET_TO_START'  then 0
            when status = 'IN_PROGRESS'   then 2
            when status = 'ON_HOLD'        then 1
            else 0
          end as StatusCriticality : Integer,

          startDate         as PlannedDate,
          actualStartDate  as ActualDate,
          reason            as Reason,
          completionPercent as TotalMocks,
          waveId            as CurrentMocks,
          lastModifiedAt    as TimeStamp
    };
}
