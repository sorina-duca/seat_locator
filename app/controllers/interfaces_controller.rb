class InterfacesController < ApplicationController

  private


# create a hash mapping the row letter to the row number
def get_correspondence(rows)
  hash_letters = {}
  for number in 1..rows
    hash_letters[('A'..'Z').first(rows)[number - 1]] = number
  end
  hash_letters
end

# added 0.5 if no. of rows is even because there are 2 identical best rows
def get_center_point(rows)
  rows % 2 == 0 ? rows.fdiv(2) + 0.5 : rows.fdiv(2)
end

def seat_letter(seat)
  seat.scan(/[a-zA-Z]/).join('').upcase
end

def seat_column(seat)
  seat.scan(/\d/).join('').to_i
end

def x_dist(seat, rows)
  # get the column of the seat
  column = seat_column(seat)
  # subtract the column number from the number of columns / 2
  (get_center_point(rows) - column).abs
end

def y_dist(seat, rows)
  letter = seat_letter(seat)
  # subtracting one because when you are on row A(first), the y distance is 0
  puts get_correspondence(rows)[letter]
  get_correspondence(rows)[letter] - 1
end

def select_consecutive(array)
  consecutive = []
  for index in 1..array.length - 1
    if seat_column(array[index]) == seat_column(array[index - 1]) + 1
      consecutive << array[index - 1] unless consecutive.include?(array[index - 1])
      consecutive << array[index]
    end
  end
  # get arrays of all consecutive seats
  consecutive.slice_when do |previous, current|
    seat_column(current) != seat_column(previous) + 1
  end.to_a
end

# calculate the distance score for a seat
def score(seat, rows)
  if x_dist(seat, rows) == 0.5
    y_dist(seat, rows)
  elsif y_dist(seat, rows) == 0
    x_dist(seat, rows)
  else
    Math.sqrt(x_dist(seat, rows)**2 + y_dist(seat, rows)**2)
  end
end

# calculate best seat
def best_seat(available_seats, rows)
  # get the pairs of seat and seat score
  seat_dist_pairs = {}
  available_seats.each do |seat|
    seat_dist_pairs[seat] = score(seat, rows)
  end
  seat_dist_pairs.min_by { |v| v }[0]
end


# calculate best groups of seats - fallback nil
def best_group_seats(available_seats, rows, people)
  seat_groups = []
  available_seats
    .group_by { |seat| seat_letter(seat) }  # group by row (e.g. A, B)
    .map { |k, v| v } # get values on each row
    .map {|arr| arr.sort_by { |seat| seat_column(seat) } } #sort asc by seat column
    .map { |array| select_consecutive(array).flatten } #get only the consecutive seats
    .select {|arr| arr.length >= people } # select the groups of seats that could accomodate the no. of people
    .map { |arr| arr.length > people ? get_groups_of_seats(arr, people).flatten : arr }
    .sort_by { |arr| score_array(arr, rows)}
    .first

end

  def get_groups_of_seats(arr, people)
    arrays = []
    for i in 0..people - 1 do
      arrays << arr[i..i+people-1]
      i += 1
    end
    arrays
  end

  def score_array(array, rows)
    array.map {|seat| score(seat, rows)}
         .sum
  end


# ['A1', 'B5', 'B2', 'C7', 'C9']
# ['A1', 'B5', 'B2', 'C7', 'C9', 'b8', 'a3', 'a2', 'b6']


end

#  pry(main)> [["A1", "A2", "A5"], ["B5", "B2"], ["C7", "C8","C9"]].map { |array| select_consecutive(array).flatten }.select {|arr| arr.length >= 3 }
# => [["C7", "C8", "C9"]]
