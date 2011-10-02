require 'aruba/cucumber'

module Aruba
  module Api
    # def cd(dir)
    #   puts "cd to #{dir}"
    #   dirs << dir
    #   raise "#{current_dir} is not a directory." unless File.directory?(current_dir)
    # end

    # def current_dir
    #   puts "dirs"+dirs.to_s
    #   File.join(*dirs)
    # end

    def run(cmd)
      @commands ||= []
      @commands << cmd

      cmd = detect_ruby(cmd)

      announce_or_puts("$ cd #{Dir.pwd}") if @announce_dir
      announce_or_puts("$ #{cmd}") if @announce_cmd

      process = Process.new(cmd, exit_timeout, io_wait)
      register_process(cmd, process)
      process.run!

      block_given? ? yield(process) : process
    end

  end
end