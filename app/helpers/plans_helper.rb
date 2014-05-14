module PlansHelper
  def plan_features(plan)
    set = AppSettings.plans[plan]
    I18n.translate('plans.features',
                   projects: set.n_projects > 0 ? set.n_projects : 'Unlimited',
                   team: set.n_teams > 0 ? set.n_teams : 'unlimited',
                   users: set.n_users > 0 ? set.n_users : 'unlimited',
                   count: set.n_projects
    )
  end
end
