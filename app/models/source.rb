class Source < ApplicationRecord
  has_many :endpoints, :autosave => true
  belongs_to :tenant

  delegate :scheme, :scheme=, :host, :host=, :port, :port=, :path, :path=,
           :to => :default_endpoint, :allow_nil => true

  acts_as_taggable

  def default_endpoint
    default = endpoints.detect(&:default)
    default || endpoints.build(:default => true, :tenant => tenant)
  end


  # Container Inventory Objects
  has_many :container_groups
  has_many :container_templates
  has_many :container_projects
  has_many :container_nodes

  # Service Catalog Inventory Objects
  has_many :service_offerings
  has_many :service_instances
  has_many :service_plans
end
