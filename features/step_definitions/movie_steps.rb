Given /the following movies exist/ do |movies_table|
  # here we pull each movie from the table and add that movie object
  #  (a hash) to the Movie database
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # page.body provides a string that can get the index of e1 and e2
  #  we then check to be sure that e1 comes before e2 on the page
  first = page.body.index(e1)
  second = page.body.index(e2)
  if first > second
    true
  else
    false
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # split the rating_list into individual ratings and utilize the step
  #  definitions in web_steps.rb to check/uncheck those ratings depending 
  #  on the passed command.
  rating_list.split(', ').each do |rating|
    if uncheck
      step 'I uncheck "ratings['+rating.strip+']"'
    else
      step 'I check "ratings['+rating.strip+']"'
    end
  end
end

Then /I should see all of the movies/ do
  # count the table rows in the movies table on the homepage to be sure
  # the value is the same as our total number of movies in the db
  rows = all('table#movies tr').count-1
  rows.should == Movie.count
end
