require 'rubygems'
require 'spreadsheet'

class SpreadsheetParser
  attr_accessor :rows

  def initialize(file)
    spreadsheet = Spreadsheet.open(file)
    book = spreadsheet.worksheets.first
    self.rows = book.rows
  end
end
