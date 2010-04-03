class OverviewGraph
  def initialize(user)
    @user = user
  end

  def regenerate!
    generate_weight_graph
    generate_bfp_graph
    generate_hours_graph
  end

  def weight_graph_url
    "weight_user#{user.id}.jpg"
  end

  def bfp_graph_url
    "bfp_user#{user.id}.jpg"
  end

  def hours_graph_url
    "hours_user#{user.id}.jpg"
  end

  private

  def fitness_samples
    @fitness_samples ||= FitnessSample.find_all_by_user_id @user.id, :order => 'date ASC'
  end

  def user
    @user
  end

  def graph_helper
    @graph_helper ||= GraphHelper.new
  end

  def activities
    @activities ||= Activity.find_all_by_user_id user.id, :order => 'date ASC'
  end

  def generate_weight_graph
    unless fitness_samples.empty?
      weight_data_set = graph_helper.fitness_samples_to_weight_data_set(fitness_samples, first_date, last_date)
      average_weight_data_set = graph_helper.fitness_samples_to_fourteen_sample_weight_average_data_set(fitness_samples, first_date, last_date)
      data_sets = [average_weight_data_set, weight_data_set]

      graph = graph_helper.generate_graph(data_sets, first_date, last_date)

      # write the file so it can be cached by the server
      File.open("public/images/#{weight_graph_url}", 'w') {|f| f.write(graph.to_blob) }
    end
  end

  def generate_bfp_graph
    unless fitness_samples.empty?
      bf_percent_data_set = graph_helper.fitness_samples_to_body_fat_percentage_data_set(fitness_samples, first_date, last_date)
      average_bf_percent_data_set = graph_helper.fitness_samples_to_fourteen_sample_bfp_average_data_set(fitness_samples, first_date, last_date)
      data_sets = [average_bf_percent_data_set, bf_percent_data_set]

      graph = graph_helper.generate_graph(data_sets, first_date, last_date)

      # write the file so it can be cached by the server
      File.open("public/images/#{bfp_graph_url}", 'w') {|f| f.write(graph.to_blob) }
    end
  end

  def generate_hours_graph
    unless activities.empty?
      total_hours_data_set = graph_helper.activities_to_seven_day_hours_total_data_set(activities, first_date, last_date)
      data_sets = []
      data_sets << total_hours_data_set

      graph = graph_helper.generate_graph(data_sets, first_date, last_date)
      graph.minimum_value = 0

      # write the file so it can be cached by the server
      File.open("public/images/#{hours_graph_url}", 'w') {|f| f.write(graph.to_blob) }
    end
  end

  def first_date
    first_a_date = Activity.first_date_by_user(user.id)

    if FitnessSample.find_all_by_user_id(user.id).length > 0
      first_fs_date = FitnessSample.first_date_by_user(user.id)

      first_date = first_a_date <= first_fs_date ? first_a_date : first_fs_date
    else
      first_date = first_a_date
    end
  end

  def last_date
    last_a_date = Activity.last_date_by_user(user.id)

    if FitnessSample.find_all_by_user_id(user.id).length > 0
      last_fs_date = FitnessSample.last_date_by_user(user.id)

      last_date = last_a_date >= last_fs_date ? last_a_date : last_fs_date
    else
      last_date = last_a_date
    end
  end

end