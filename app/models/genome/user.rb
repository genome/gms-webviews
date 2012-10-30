class Genome::User < ActiveRecord::Base
  self.table_name = 'subject.user'

  def created_projects
    get_project_by_role( 'creator' )
  end
  def watched_projects
    get_project_by_role( 'watcher' )
  end


  private
    def get_project_by_role( role )
      Genome::Project.joins( :project_parts ).where( project_part: { part_id: email, role: role } )
    end
end
