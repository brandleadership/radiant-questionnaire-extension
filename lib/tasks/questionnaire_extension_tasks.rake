namespace :radiant do
  namespace :extensions do
    namespace :questionnaire do
      
      desc "Runs the migration of the Questionnaire extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          QuestionnaireExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          QuestionnaireExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Questionnaire to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from QuestionnaireExtension"
        Dir[QuestionnaireExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(QuestionnaireExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
