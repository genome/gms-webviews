module SearchHelper
  @@TYPES_TO_PARTIALS = {
    'model - alignment' => 'model_alignment',
    'model - somatic' => 'model_somatic',
    'model - other' => 'model_other',
    'model - rna' => 'model_rna',
    'user' => 'user',
    'wiki-page' => 'wiki_page',
    'build' => 'build',
    'gene-name' => 'gene_name',
    'gene-name-group' => 'gene_name_group',
    'illumina_run' => 'illumina_run',
    'imported_instrument_data' => 'imported_instrument_data',
    'individual' => 'individual',
    'instrument data' => 'instrument_data',
    'library' => 'library',
    'mail' => 'mail',
    'model' => 'model',
    'model - lane_qc' => 'model_lane_qc',
    'model - microarray' => 'model_microarray',
    'modelgroup' => 'modelgroup',
    'population_group' => 'population_group',
    'processing_profile' => 'processing_profile',
    'project' => 'project',
    'sample' => 'sample',
    'solexa_instrument_data' => 'solexa_instrument_data',
    'taxon' => 'taxon',
    'work-order' => 'work_order'}

  def partial_type_for_facet(facet_type)

  end
end



