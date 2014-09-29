class Project
  attr_accessor :args

  def initialize(conn, args = {})
    @conn = conn
    @args = args
  end

  def self.all(conn)
    projects = conn.list_projects
    projects.each do |p|
      Project.new(conn, p)
    end
  end

  def self.where(*args)

  end

end
