class GraphHelper

  # Generate a PNG blob for on-the-fly generation/display in the web app
  # NOTE: all labels (x-axis values) must match up 
  def generate_graph(data_sets)
    max_value = 0

    # set up the graph
    graph = Gruff::Line.new
#    graph.title = "Top #{@number_of_popular.to_s} Artists"

    data_sets.each do |data_set|
      data_values = data_set[:data_points].map {|item| item[1]}

      graph.data(data_set[:title], data_values)

      # add labels, check max value
      labels = {}
      @index = 0
      data_set[:data_points].each do |item|
        labels[@index] = item[0].to_s
        @index += 1

        # update max value for y-axis scaling
        if (item[1] > max_value)
          max_value = item[1]
        end
 
      end
      graph.labels = labels

    end

    # set y-axis max and min values
    graph.maximum_value = max_value + (0.1 * max_value) 
    graph.minimum_value = 0

#    graph.write("top_artists.png")
 
    # return the graph, most likely to be blobbed inline 
    return graph  
  end

end
