class InterfacesController < ApplicationController

  def get_venue; end

  def get_best_seat
    @people = params[:people].to_i
    @venue = JSON.load(params[:venue])
    @rows = @venue['venue']['layout']['rows']
    @available_seats = @venue['seats'].keys
    @people.nil? || @people == 1 ? @result = best_seat(@available_seats, @rows) : @result = best_group_seats(@available_seats, @rows, @people)
  end

  private




# ['A1', 'B5', 'B2', 'C7', 'C9']
# ['A1', 'B5', 'B2', 'C7', 'C9', 'b8', 'a3', 'a2', 'b6']


end

#  pry(main)> [["A1", "A2", "A5"], ["B5", "B2"], ["C7", "C8","C9"]].map { |array| select_consecutive(array).flatten }.select {|arr| arr.length >= 3 }
# => [["C7", "C8", "C9"]]
