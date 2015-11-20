# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

markets_csv = CSV.read("./seed_csvs/markets.csv")
markets_csv.each do |id, name, address, city, county, state, zip|
  hash = {:id => id, :name => name, :address => address, :city => city, :county => county, :state => state, :zip => zip}
  Market.create(hash)
end

vendor_csv = CSV.read("./seed_csvs/vendors.csv")
vendor_csv.each do |id, name, employees, market_id|
  hash = {:id => id, :name => name, :employees => employees, :market_id => market_id}
  Vendor.create(hash)
end

product_csv = CSV.read("./seed_csvs/products.csv")
product_csv.each do |id, name, vendor_id|
  hash = {:id => id, :name => name, :vendor_id => vendor_id}
  Product.create(hash)
end

sale_csv = CSV.read("./seed_csvs/sales.csv")
sale_csv.each do |id, amount, purchase_time, vendor_id, product_id|
  hash = {:id => id, :amount => amount, :purchase_time => purchase_time, :vendor_id => vendor_id, :product_id => product_id}
  Sale.create(hash)
end

begin
  con = PG::Connection
  Market.connection.execute('SELECT setval(\'markets_id_seq\'::regclass, (SELECT MAX(id) FROM markets))')
  Vendor.connection.execute('SELECT setval(\'vendors_id_seq\'::regclass, (SELECT MAX(id) FROM vendors))')
  Product.connection.execute('SELECT setval(\'products_id_seq\'::regclass, (SELECT MAX(id) FROM products))')
  Sale.connection.execute('SELECT setval(\'sales_id_seq\'::regclass, (SELECT MAX(id) FROM sales))')
rescue NameError
end
