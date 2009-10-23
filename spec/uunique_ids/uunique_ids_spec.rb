require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe "UuniqueIds" do

  it 'should not produce duplicate ids' do
    uuid1 = UUniqueIds.random_create
    uuid2 = UUniqueIds.random_create
    # puts "uuid1 #{uuid1}"
    # puts "uuid2 #{uuid2}"
    (uuid1.match(uuid2)).should be_nil
  end
  
end
