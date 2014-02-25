task :nyt => :environment do
  # Template.delete_all
  # Entity.delete_all
  # Asset.delete_all
  
  template = Template.create( :name => "NYT Ad Transcription Template",
                              :description => "A template for transcribing NYT ads",
                              :project => "NYT Ad Archive",
                              :display_width => 600,
                              :default_zoom => 1.5)
                          
  
  
  ad_entity = Entity.create( :name => "Ad Observation",
                                  :description => "",
                                  :help => "Please fill in all of the values",
                                  :resizeable => false,
                                  :width => 450,
                                  :height => 80)
                                  
  
  name_field = EntryField.new( :name => "Name",
                          :field_key => "company_name",
                          :kind => "text",
                          :initial_value => "--",
                          :options => { :text => { :max_length => 100, :min_length => 0}})

  category_field = EntryField.new(:name => "Category",
                          :field_key => "category",
                          :kind => "select",
                          :initial_value => "--",
                          :options => { :select => ['Real Estate', 'Help Wanted', 'Retail', 'NYT'] })
                          
  slogan_field = EntryField.new(:name => "Slogan",
                              :field_key => "slogan",
                              :kind => "text",
                              :initial_value => "--",
                              :options => { :text => { :max_length => 100, :min_length => 0 } })                                                                                  
                                
  ad_entity.entry_fields << name_field
  ad_entity.entry_fields << category_field
  ad_entity.entry_fields << slogan_field                              
  ad_entity.save

  article_entity = Entity.create(:name => "Article",
                              :description => "Any NYT article",
                              :help => "",
                              :resizeable => true,
                              :width => 450,
                              :height => 80)
  
  article_entity.save
  
  template.entities << article_entity
  template.entities << ad_entity
  
  template.save 

  #generate a single asset and a single user for testing just now
  archive_1891 = AssetCollection.create(:title => "NYT Ad Archive", :author => "", :extern_ref => "ad-archive.nytimes.com.s3.amazonaws.com/1891")
  
  Asset.create(:location => "http://ad-archive.nytimes.com.s3.amazonaws.com/1891/01/01/P3/18910101_P3_3463504.png", :display_width => 805, :height => 578, :width => 805, :template => template, :asset_collection => archive_1891)
  Asset.create(:location => "http://ad-archive.nytimes.com.s3.amazonaws.com/1891/01/01/P3/18910101_P3_3463505.png", :display_width => 844, :height => 1046, :width => 844, :template => template, :asset_collection => archive_1891)

  ZooniverseUser.create()
  
end
