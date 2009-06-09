class GraphHelper

  # Generate a PNG blob for on-the-fly generation/display in the web app
  # NOTE: all labels (x-axis values) must match up 
  def generate_graph(data_sets, first_date, last_date)
    min_value = 0
    max_value = 0

    # set up the graph
    graph = Gruff::Line.new('600x250')
#    graph.title = "Top #{@number_of_popular.to_s} Artists"

    data_sets.each do |data_set|
      data_values = data_set[:data_points].values

      graph.data(data_set[:title], data_values)

      # add labels, check max value
#      labels = {}
      @index = 0
      data_set[:data_points].values.each do |value|
        # labels[@index] = item[0].to_s
        @index += 1

        # update max value for y-axis scaling
        unless value.nil?
          if (value > max_value)
            max_value = value
          end

          if (min_value == 0)
            min_value = value
          end

          # update the min value for y-axis scaling
          if (value < min_value)
            min_value = value
          end
        end
 
      end
      
      # graph.labels = labels
      graph.labels = labels_for_five_points(first_date, last_date)
    end

    # set y-axis max and min values
    graph.maximum_value = (max_value + (0.1 * max_value)).round
    graph.minimum_value = (min_value - (0.1 * max_value)).round

    # return the graph, most likely to be blobbed inline 
    return graph  
  end

  def initialize_date_hash(first_date, last_date)
    dates = {}

    first_date.upto(last_date) do |date|
      dates[date] = nil
    end

    dates
  end

  def labels_for_five_points(first_date, last_date)
    labels = {}

    # need the array of dates
    dates = []
    first_date.upto(last_date) do |date|
      dates << date
    end

    # need the total # of days involved
    num_of_days = last_date - first_date

    # populate the first 4 labels
    (1..4).each do |number|
      index_number = ((num_of_days / 5) * number).to_i
      puts index_number
      labels[index_number] = label_from_date(dates[index_number])
    end

    # do the last
    index_number = dates.length - 1
    labels[index_number] = label_from_date(dates[index_number])

    labels
  end

  def label_from_data_point(data_point)
    label = "#{data_point[0].month.to_s}/#{data_point[0].mday.to_s}/#{data_point[0].year.to_s[2..3]}"
  end

  def label_from_date(date)
    label = "#{date.month.to_s}/#{date.mday.to_s}/#{date.year.to_s[2..3]}"
  end

  def fitness_samples_to_weight_data_set(fitness_samples)
    points = []

    fitness_samples.each do |fitness_sample|
      points << [ fitness_sample.date, fitness_sample.weight_pounds ]
    end

    data_set = {:title => "Weight (lbs)", :data_points => points}
  end

  def fitness_samples_to_body_fat_percentage_data_set(fitness_samples, first_date, last_date)
    # need every date from first to last so graphs line up and are to time scale
    points = initialize_date_hash(first_date, last_date)

    # take the fitness samples and place them in the appropriate date hash entries
    fitness_samples.each do |fitness_sample|
      # points << [ fitness_sample.date, fitness_sample.body_fat_percentage ]
      points[fitness_sample.date] = fitness_sample.body_fat_percentage
    end
    
    data_set = {:title => "Body Fat %", :data_points => points}
  end

  def fitness_samples_to_seven_day_hours_total_data_set(fitness_samples)
    points = []

    fitness_samples.each do |fitness_sample|
      points << [ fitness_sample.date, fitness_sample_get_previous_weeks_total_hours(fitness_sample) ]
    end
    
    data_set = {:title => "Preceding Week Aerobic Hours", :data_points => points}
  end

  def fitness_sample_get_previous_weeks_total_hours(fitness_sample)
    start_date = fitness_sample.date - 7

    activities = Activity.find(:all, :conditions => "(date <= '#{fitness_sample.date.to_s}') && (date > '#{start_date.to_s}')")

    hours = 0
    activities.each do |activity|
      hours = hours + activity.duration_hours unless activity.duration_hours.nil?
    end

    hours
  end

  def fitness_samples_to_seven_day_weight_average_data_set(fitness_samples)
    points = []

    fitness_samples.each do |fitness_sample|
      points << [ fitness_sample.date, fitness_sample_to_seven_day_weight_average(fitness_sample) ]
    end
    
    data_set = {:title => "Preceding Week Average Weight", :data_points => points}
  end

  def fitness_sample_to_seven_day_weight_average(fitness_sample)
    start_date = fitness_sample.date - 7

    fitness_samples = FitnessSample.find(:all, :conditions => "(date <= '#{fitness_sample.date.to_s}') && (date > '#{start_date.to_s}')")

    total_weight = 0
    fitness_samples.each do |fitness_sample|
      total_weight = total_weight + fitness_sample.weight_pounds unless fitness_sample.weight_pounds.nil?
    end
    average_weight = total_weight / fitness_samples.length

    average_weight 
  end

  def fitness_samples_to_seven_day_bfp_average_data_set(fitness_samples, first_date, last_date)
    points = []

    fitness_samples.each do |fitness_sample|
      points << [ fitness_sample.date, fitness_sample_to_seven_day_bfp_average(fitness_sample) ]
    end
    
    data_set = {:title => "Preceding Week Average Body Fat %", :data_points => points}
  end

  def fitness_sample_to_seven_day_bfp_average(fitness_sample)
    start_date = fitness_sample.date - 7

    fitness_samples = FitnessSample.find(:all, :conditions => "(date <= '#{fitness_sample.date.to_s}') && (date > '#{start_date.to_s}')")

    total_bfp = 0
    fitness_samples.each do |fitness_sample|
      total_bfp = total_bfp + fitness_sample.body_fat_percentage unless fitness_sample.body_fat_percentage.nil?
    end
    average_bfp = total_bfp / fitness_samples.length

    average_bfp
  end

end
