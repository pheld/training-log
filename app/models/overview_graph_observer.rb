class OverviewGraphObserver < ActiveRecord::Observer
    observe :activity, :climb, :fitness_sample

    def after_create(record)
      regenerate_graphs(record)
    end

    def after_update(record)
      regenerate_graphs(record)
    end

    def regenerate_graphs(record)
      user = record.user || record.activity.user
      Rails.logger.info("Regenerating overview graphs for #{user.login}")
      @graph = OverviewGraph.new(user)
      @graph.regenerate!
    end
    # def after_update(record)
    #   AuditTrail.new(record, "UPDATED")
    # end

end