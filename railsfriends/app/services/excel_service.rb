require 'axlsx'

class ExcelService
  def self.generate_excel(current_model)
    package = Axlsx::Package.new
    workbook = package.workbook
    @friends = Friend.where(model: current_model)
    workbook.add_worksheet(name: "Friends") do |sheet|
      sheet.add_row ['First Name', 'Last Name', 'Email', 'Phone', 'Twitter']

      # Add more rows with data
      @friends.each do |friend|
        sheet.add_row [friend.first_name, friend.last_name, friend.email, friend.phone, friend.twitter]
      end
    end

    package.to_stream
  end
end

