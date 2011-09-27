require 'RMagick'

module CucumberSnapshot

  class Snapshot
    
    SNAPSHOT_DIRECTORY = Rails.root + 'snapshots'
    EXTENSION = '.png'
    REF_EXTENSION = '_ref.png'
    RES_EXTENSION = '_res.png'
    TMP_EXTENSION = '_tmp.png'
    
    def initialize
    end

    def self.path name
      SNAPSHOT_DIRECTORY.to_s + '/' + name + EXTENSION
    end

    def self.ref_path name
      SNAPSHOT_DIRECTORY.to_s + '/' + name + REF_EXTENSION
    end

    def self.res_path name
      SNAPSHOT_DIRECTORY.to_s + '/' + name + RES_EXTENSION
    end

    def self.tmp_path name
      SNAPSHOT_DIRECTORY.to_s + '/' + name + TMP_EXTENSION
    end

    def self.create_directory
      Dir.mkdir(SNAPSHOT_DIRECTORY) unless File.directory?(SNAPSHOT_DIRECTORY)
    end

    def self.capture page, file_name=page.current_path.to_s
      puts "Snapshot ==> Taking snapshot of #{page.current_path.to_s} as file #{file_name}"
      create_directory

      if exists_reference? file_name
        file_path = path(file_name)
      else
        puts "No Reference file : creating reference Snapshot"
        file_path = ref_path(file_name)
      end
      
      case Capybara.current_driver.to_s  
      when 'selenium'  
       page.driver.browser.save_screenshot file_path
      when 'selenium_chrome'
       page.driver.browser.save_screenshot file_path
      when 'rack_test'
        require 'capybara/util/save_and_open_page'
        page.driver.render Rails.root.join "#{Capybara.save_and_open_page_path}" "#{file_name}.png"
      else  
        puts "Driver #{Capybara.current_driver.to_s} not compatible with Snapshot : please use 'selenium' or selenium_chrome or 'rack_test' driver"
      end
    end

    def self.compare snapshot
      puts "Snapshot: Comparing #{snapshot} with reference"
      compare_images ref_path(snapshot), path(snapshot) 
    end

    def self.compare_images img1, img2
      puts "Snapshot: Comparing #{img1} with #{img2}"
      img1  = Magick::ImageList.new(img1)# {self.size = "128x128"}.first
      img2 = Magick::ImageList.new(img2)

      result = img1.compare_channel(img2, Magick::MetricType.values[1])
      result[0].write(tmp_path('snapshot'))
      puts "Snapshot: #{result[1]} diff"# if result[1] > 0
      return result
    end
    
    def self.exists_reference? name
      puts "checking existence of #{ref_path(name)}"
      File.exists? ref_path(name)
    end

    def self.exists? name
      puts "checking existence of #{path(name)}"
      File.exists? path(name)
    end
  end
end