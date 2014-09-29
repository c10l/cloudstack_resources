class VM
  def initialize(conn, *args)
    @conn = conn

  end

  def self.all
    vms = @conn.list_virtual_machines
    vms.each do |vm|
      #
    end
  end

  def self.where(*args)

  end
end
