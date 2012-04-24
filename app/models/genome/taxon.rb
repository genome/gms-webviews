class Genome::Taxon < Genome::Subject
  default_scope where(subclass_name: "Genome::Taxon")
end
