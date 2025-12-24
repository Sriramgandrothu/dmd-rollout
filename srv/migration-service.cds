using {sap.capire.dmd_rollout as db} from '../db/schema';

service MigrationService {

    @readonly
    entity RolloutOverview as
        projection on db.Rollouts {

            key name              as RolloutName,
                status            as Status,
                startDate         as PlannedDate,
                actualStartDate   as ActualDate,
                reason            as Reason,
                completionPercent as TotalMocks,
                waveId            as CurrentMocks,
                lastModifiedAt    as TimeStamp
        };

}
