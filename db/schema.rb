# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "allocation", :id => false, :force => true do |t|
    t.string    "id",                           :limit => 64,                                  :null => false
    t.string    "allocation_path",              :limit => 4000,                                :null => false
    t.string    "disk_group_name",              :limit => 40,                                  :null => false
    t.string    "group_subdirectory",                                                          :null => false
    t.string    "mount_path",                                                                  :null => false
    t.decimal   "kilobytes_requested",                          :precision => 20, :scale => 0, :null => false
    t.decimal   "kilobytes_used",                               :precision => 20, :scale => 0
    t.string    "owner_class_name"
    t.string    "owner_id"
    t.timestamp "creation_time",                :limit => 6
    t.timestamp "reallocation_time",            :limit => 6
    t.decimal   "original_kilobytes_requested",                 :precision => 20, :scale => 0
    t.boolean   "archivable"
    t.boolean   "preserved"
  end

  add_index "allocation", ["allocation_path"], :name => "allocation_allocation_path_index"
  add_index "allocation", ["creation_time", "reallocation_time"], :name => "allocation_creation_reallocation_time_index"
  add_index "allocation", ["mount_path", "group_subdirectory", "allocation_path"], :name => "allocation_absolute_path_index"
  add_index "allocation", ["owner_class_name", "owner_id"], :name => "allocation_owner_class_id_index"

  create_table "build", :id => false, :force => true do |t|
    t.string "build_id",          :limit => 32,   :null => false
    t.string "data_directory",    :limit => 1000
    t.string "model_id",          :limit => 32,   :null => false
    t.string "software_revision", :limit => 1000
    t.string "subclass_name"
  end

  add_index "build", ["data_directory"], :name => "build_directory_index"
  add_index "build", ["model_id"], :name => "build_model_index"

  create_table "build_input", :id => false, :force => true do |t|
    t.string "build_id",         :limit => 32,   :null => false
    t.string "value_class_name",                 :null => false
    t.string "value_id",         :limit => 1000, :null => false
    t.string "name",                             :null => false
    t.string "filter_desc",      :limit => 100
  end

  create_table "build_link", :id => false, :force => true do |t|
    t.string "to_build_id",   :limit => 32, :null => false
    t.string "from_build_id", :limit => 32, :null => false
    t.string "role",          :limit => 56, :null => false
  end

  create_table "build_metric", :id => false, :force => true do |t|
    t.string "build_id",     :limit => 32,   :null => false
    t.string "metric_name",  :limit => 100,  :null => false
    t.string "metric_value", :limit => 1000, :null => false
  end

  add_index "build_metric", ["build_id", "metric_name"], :name => "metric_build_id_metric_name_index"

  create_table "build_variant", :id => false, :force => true do |t|
    t.string  "variant_id",      :limit => 32, :null => false
    t.string  "build_id",        :limit => 32, :null => false
    t.integer "mapping_quality", :limit => 8
    t.integer "somatic_quality", :limit => 8
  end

  create_table "data", :id => false, :force => true do |t|
    t.string "id",                  :limit => 64, :null => false
    t.string "subclass_name",       :limit => 64, :null => false
    t.string "sequencing_platform", :limit => 64, :null => false
    t.string "library_id",          :limit => 16, :null => false
    t.string "source_name",         :limit => 64
    t.string "subset_name",         :limit => 64
    t.string "run_name",            :limit => 64
  end

  add_index "data", ["library_id"], :name => "instrument_data_library_id_index"

  create_table "data_attribute", :id => false, :force => true do |t|
    t.string "instrument_data_id", :limit => 64,  :null => false
    t.string "attribute_label",    :limit => 64,  :null => false
    t.string "attribute_value",    :limit => 512, :null => false
    t.string "nomenclature",       :limit => 64,  :null => false
  end

  add_index "data_attribute", ["attribute_label"], :name => "instrument_data_attribute_label_index"
  add_index "data_attribute", ["instrument_data_id"], :name => "instrument_data_id_index"

  create_table "event", :id => false, :force => true do |t|
    t.string    "genome_model_event_id", :limit => 32,  :null => false
    t.string    "model_id",              :limit => 32
    t.string    "run_id",                :limit => 32
    t.string    "event_type",                           :null => false
    t.string    "event_status"
    t.string    "lsf_job_id",            :limit => 64
    t.timestamp "date_scheduled",        :limit => 6
    t.timestamp "date_completed",        :limit => 6
    t.string    "user_name",             :limit => 64
    t.string    "ref_seq_id",            :limit => 64
    t.integer   "retry_count"
    t.string    "parent_event_id",       :limit => 32
    t.string    "prior_event_id",        :limit => 32
    t.string    "status_detail",         :limit => 200
    t.string    "build_id",              :limit => 32
    t.string    "instrument_data_id",    :limit => 64
    t.integer   "workflow_instance_id"
  end

  add_index "event", ["build_id"], :name => "event_build_id_index"
  add_index "event", ["event_status"], :name => "event_status_index"
  add_index "event", ["event_type", "model_id"], :name => "event_type_model_id_index"
  add_index "event", ["instrument_data_id"], :name => "event_inst_data_index"
  add_index "event", ["model_id"], :name => "event_model_id_index"
  add_index "event", ["parent_event_id"], :name => "event_parent_event_index"
  add_index "event", ["prior_event_id"], :name => "event_prior_event_index"
  add_index "event", ["ref_seq_id"], :name => "event_ref_seq_index"
  add_index "event", ["run_id"], :name => "event_run_id_index"
  add_index "event", ["user_name"], :name => "event_user_name_index"

  create_table "event_input", :id => false, :force => true do |t|
    t.string "event_id",    :limit => 32,   :null => false
    t.string "param_name",  :limit => 100,  :null => false
    t.string "param_value", :limit => 1000, :null => false
  end

  create_table "event_metric", :id => false, :force => true do |t|
    t.string "event_id",     :limit => 32,   :null => false
    t.string "metric_name",  :limit => 100,  :null => false
    t.string "metric_value", :limit => 1000
  end

  create_table "event_output", :id => false, :force => true do |t|
    t.string "event_id",    :limit => 32,   :null => false
    t.string "param_name",  :limit => 100,  :null => false
    t.string "param_value", :limit => 1000, :null => false
  end

  create_table "execution_metric", :id => false, :force => true do |t|
    t.string "workflow_execution_id",                 :null => false
    t.string "name",                                  :null => false
    t.string "value",                 :limit => 1000
  end

  add_index "execution_metric", ["workflow_execution_id", "name"], :name => "execution_metric_workflow_execution_id_name_idx"
  add_index "execution_metric", ["workflow_execution_id"], :name => "execution_metric_workflow_execution_id_idx"

  create_table "feature_list", :id => false, :force => true do |t|
    t.string  "id",                :limit => 64,  :null => false
    t.string  "name",              :limit => 200, :null => false
    t.string  "source",            :limit => 64
    t.string  "format",            :limit => 64,  :null => false
    t.string  "reference_id",      :limit => 32
    t.string  "subject_id",        :limit => 32
    t.integer "file_id",           :limit => 8
    t.string  "file_content_hash", :limit => 32,  :null => false
    t.string  "content_type"
    t.string  "description"
  end

  add_index "feature_list", ["name"], :name => "feature_list_name_index"
  add_index "feature_list", ["name"], :name => "feature_list_name_key", :unique => true

  create_table "fragment_library", :id => false, :force => true do |t|
    t.string "library_id",           :limit => 16, :null => false
    t.string "full_name",            :limit => 64, :null => false
    t.string "sample_id",            :limit => 16, :null => false
    t.string "library_insert_size",  :limit => 64
    t.string "original_insert_size", :limit => 64
  end

  add_index "fragment_library", ["library_id"], :name => "fragment_library_library_id_index"
  add_index "fragment_library", ["sample_id"], :name => "fragment_library_sample_id_index"

  create_table "group", :id => false, :force => true do |t|
    t.string  "id",           :limit => 32, :null => false
    t.string  "name",         :limit => 40, :null => false
    t.integer "permissions",                :null => false
    t.boolean "sticky",                     :null => false
    t.string  "subdirectory",               :null => false
    t.integer "unix_uid",                   :null => false
    t.integer "unix_gid",                   :null => false
  end

  add_index "group", ["name"], :name => "group_name_index"

  create_table "input", :id => false, :force => true do |t|
    t.string "software_result_id", :limit => 32,   :null => false
    t.string "input_name",         :limit => 100,  :null => false
    t.string "input_value",        :limit => 1000, :null => false
    t.string "name"
    t.string "value_class_name"
    t.string "value_id",           :limit => 1000
  end

  add_index "input", ["name"], :name => "result_input_name_index"
  add_index "input", ["software_result_id", "name"], :name => "result_input_id_name"
  add_index "input", ["value_class_name", "value_id"], :name => "result_input_value_class_id_index"
  add_index "input", ["value_id"], :name => "result_input_value_id_index"

  create_table "instance", :id => false, :force => true do |t|
    t.string "workflow_instance_id",               :null => false
    t.string "parent_instance_id"
    t.string "peer_instance_id"
    t.string "current_execution_id"
    t.string "workflow_plan_id"
    t.string "name",                               :null => false
    t.binary "input_stored"
    t.binary "output_stored"
    t.string "parallel_index"
    t.string "parent_execution_id"
    t.string "intention",            :limit => 15
  end

  add_index "instance", ["current_execution_id"], :name => "instance_current_execution_id_idx"
  add_index "instance", ["name", "workflow_instance_id"], :name => "instance_name_workflow_instance_id_idx"
  add_index "instance", ["name", "workflow_instance_id"], :name => "instance_name_workflow_instance_id_idx1"
  add_index "instance", ["name"], :name => "instance_name_idx"
  add_index "instance", ["parent_execution_id"], :name => "instance_parent_execution_id_idx"
  add_index "instance", ["parent_instance_id"], :name => "instance_parent_instance_id_idx"
  add_index "instance", ["peer_instance_id"], :name => "instance_peer_instance_id_idx"
  add_index "instance", ["workflow_instance_id"], :name => "instance_workflow_instance_id_idx", :unique => true
  add_index "instance", ["workflow_plan_id"], :name => "instance_workflow_plan_id_idx"

  create_table "instance_execution", :id => false, :force => true do |t|
    t.string   "workflow_execution_id",                                               :null => false
    t.string   "workflow_instance_id",                                                :null => false
    t.string   "status",                :limit => 15
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "exit_code",                            :precision => 5,  :scale => 0
    t.string   "stdout",                :limit => 512
    t.string   "stderr",                :limit => 512
    t.decimal  "is_done",                              :precision => 2,  :scale => 0
    t.decimal  "is_running",                           :precision => 2,  :scale => 0
    t.string   "dispatch_id",           :limit => 10
    t.decimal  "cpu_time",                             :precision => 15, :scale => 0
    t.decimal  "max_memory",                           :precision => 10, :scale => 0
    t.decimal  "max_swap",                             :precision => 10, :scale => 0
    t.decimal  "max_processes",                        :precision => 4,  :scale => 0
    t.decimal  "max_threads",                          :precision => 4,  :scale => 0
    t.string   "user_name",             :limit => 20
  end

  add_index "instance_execution", ["workflow_execution_id"], :name => "instance_execution_workflow_execution_id_idx", :unique => true
  add_index "instance_execution", ["workflow_instance_id"], :name => "instance_execution_workflow_instance_id_idx"

  create_table "metric", :id => false, :force => true do |t|
    t.string "software_result_id", :limit => 32,   :null => false
    t.string "metric_name",        :limit => 100,  :null => false
    t.string "metric_value",       :limit => 1000, :null => false
  end

  create_table "misc_attribute", :id => false, :force => true do |t|
    t.string "entity_class_name",                 :null => false
    t.string "entity_id",         :limit => 1000, :null => false
    t.string "property_name",                     :null => false
    t.string "value",             :limit => 4000
  end

  add_index "misc_attribute", ["entity_class_name", "property_name", "value"], :name => "misc_attribute_entity_class_property_value_index"

  create_table "misc_note", :id => false, :force => true do |t|
    t.string    "editor_id",          :limit => 200,  :null => false
    t.timestamp "entry_date",         :limit => 6,    :null => false
    t.string    "subject_class_name",                 :null => false
    t.string    "subject_id",                         :null => false
    t.string    "header_text",                        :null => false
    t.string    "body_text",          :limit => 4000
    t.string    "id",                 :limit => 32,   :null => false
  end

  add_index "misc_note", ["body_text"], :name => "misc_note_body_index"
  add_index "misc_note", ["editor_id", "entry_date"], :name => "misc_note_editor_index"
  add_index "misc_note", ["entry_date", "subject_class_name", "subject_id"], :name => "misc_note_subject_date_index"
  add_index "misc_note", ["subject_class_name", "subject_id", "header_text"], :name => "misc_note_subject_index"
  add_index "misc_note", ["subject_id"], :name => "misc_note_subject_id"

  create_table "model", :id => false, :force => true do |t|
    t.string    "genome_model_id",            :limit => 32,                      :null => false
    t.string    "id",                         :limit => 32
    t.string    "name",                                                          :null => false
    t.string    "sample_name"
    t.string    "processing_profile_id",      :limit => 32,                      :null => false
    t.string    "data_directory",             :limit => 1000
    t.string    "comparable_normal_model_id", :limit => 32
    t.string    "current_running_build_id",   :limit => 32
    t.string    "last_complete_build_id",     :limit => 32
    t.string    "user_name",                  :limit => 64
    t.timestamp "creation_date",              :limit => 6
    t.boolean   "auto_assign_inst_data"
    t.boolean   "auto_build_alignments"
    t.string    "subject_id",                 :limit => 32,                      :null => false
    t.string    "subject_class_name",         :limit => 500,                     :null => false
    t.boolean   "keep",                                       :default => false
    t.string    "build_granularity_unit",     :limit => 20
    t.integer   "build_granularity_value"
    t.string    "limit_inputs_to_id",         :limit => 1000
    t.boolean   "is_default"
    t.string    "subclass_name"
    t.boolean   "auto_build"
    t.boolean   "build_requested"
  end

  add_index "model", ["name"], :name => "model_name_index"
  add_index "model", ["processing_profile_id"], :name => "model_processing_profile_index"
  add_index "model", ["subclass_name"], :name => "model_subclass_index"
  add_index "model", ["subject_class_name", "subject_id"], :name => "model_subject_index"
  add_index "model", ["subject_id"], :name => "model_subject_id_index"

  create_table "model_group", :id => false, :force => true do |t|
    t.string "id",        :limit => 64, :null => false
    t.string "name",                    :null => false
    t.string "user_name", :limit => 64
    t.string "uuid",      :limit => 64
  end

  add_index "model_group", ["name"], :name => "model_group_name_index"

  create_table "model_group_bridge", :id => false, :force => true do |t|
    t.string "model_group_id", :limit => 32, :null => false
    t.string "model_id",       :limit => 32, :null => false
  end

  create_table "model_input", :id => false, :force => true do |t|
    t.string "model_id",         :limit => 32,   :null => false
    t.string "value_class_name",                 :null => false
    t.string "value_id",         :limit => 1000, :null => false
    t.string "name",                             :null => false
    t.string "filter_desc",      :limit => 100
  end

  add_index "model_input", ["model_id"], :name => "model_input_model_id_index"
  add_index "model_input", ["value_class_name"], :name => "model_input_value_class_index"
  add_index "model_input", ["value_id", "name"], :name => "model_input_value_id_name_index"

  create_table "model_link", :id => false, :force => true do |t|
    t.string "to_model_id",   :limit => 32,                       :null => false
    t.string "from_model_id", :limit => 32,                       :null => false
    t.string "role",          :limit => 56, :default => "member", :null => false
  end

  create_table "nomenclature", :id => false, :force => true do |t|
    t.string  "id",                :null => false
    t.string  "name",              :null => false
    t.string  "default_value"
    t.boolean "accepts_any_field"
  end

  add_index "nomenclature", ["name"], :name => "nomenclature_name_index"

  create_table "nomenclature_enum_value", :id => false, :force => true do |t|
    t.string "id",                    :null => false
    t.string "value",                 :null => false
    t.string "nomenclature_field_id", :null => false
  end

  add_index "nomenclature_enum_value", ["nomenclature_field_id"], :name => "nomenclature_enum_field_index"

  create_table "nomenclature_field", :id => false, :force => true do |t|
    t.string "id",              :null => false
    t.string "name",            :null => false
    t.string "type",            :null => false
    t.string "nomenclature_id", :null => false
  end

  add_index "nomenclature_field", ["nomenclature_id"], :name => "nomenclature_field_nomenclature_id_index"

  create_table "param", :id => false, :force => true do |t|
    t.string "software_result_id", :limit => 32,   :null => false
    t.string "param_name",         :limit => 100,  :null => false
    t.string "param_value",        :limit => 1000, :null => false
    t.string "name"
    t.string "value_class_name"
    t.string "value_id",           :limit => 1000
  end

  add_index "param", ["name"], :name => "result_param_name_index"
  add_index "param", ["software_result_id", "name"], :name => "result_param_id_name"
  add_index "param", ["value_class_name", "value_id"], :name => "result_param_value_class_id_index"
  add_index "param", ["value_id"], :name => "result_param_value_id_index"

  create_table "plan", :id => false, :force => true do |t|
    t.string "workflow_plan_id", :null => false
    t.xml    "xml"
  end

  add_index "plan", ["workflow_plan_id"], :name => "plan_workflow_plan_id_idx", :unique => true

  create_table "processing_profile", :id => false, :force => true do |t|
    t.string "id",            :limit => 32, :null => false
    t.string "type_name"
    t.string "name"
    t.string "subclass_name"
  end

  add_index "processing_profile", ["name"], :name => "processing_profile_name_index"
  add_index "processing_profile", ["subclass_name"], :name => "processing_profile_subclass_index"

  create_table "processing_profile_param", :id => false, :force => true do |t|
    t.string "processing_profile_id", :limit => 32,   :null => false
    t.string "param_name",            :limit => 100,  :null => false
    t.string "param_value",           :limit => 1000, :null => false
    t.string "name"
    t.string "value_class_name"
    t.string "value_id",              :limit => 1000
  end

  add_index "processing_profile_param", ["name"], :name => "processing_profile_param_name_index"
  add_index "processing_profile_param", ["processing_profile_id", "name"], :name => "processing_profile_param_id_name_index"
  add_index "processing_profile_param", ["value_class_name", "value_id"], :name => "processing_profile_param_name_value_class_id_index"
  add_index "processing_profile_param", ["value_id"], :name => "processing_profile_param_value_id_index"

  create_table "project", :id => false, :force => true do |t|
    t.string "id",   :limit => 64,  :null => false
    t.string "name", :limit => 200, :null => false
  end

  add_index "project", ["name"], :name => "project_name_index"

  create_table "project_part", :id => false, :force => true do |t|
    t.string "id",              :limit => 64,  :null => false
    t.string "project_id",      :limit => 64,  :null => false
    t.string "part_class_name", :limit => 256, :null => false
    t.string "part_id",         :limit => 64,  :null => false
    t.string "label",           :limit => 100
    t.string "role",            :limit => 100
  end

  add_index "project_part", ["part_class_name", "part_id", "role"], :name => "project_part_part_role_index"
  add_index "project_part", ["project_id", "label"], :name => "project_part_project_label_index"
  add_index "project_part", ["project_id", "part_class_name", "part_id"], :name => "project_part_project_id_part_class_name_part_id_key", :unique => true
  add_index "project_part", ["project_id", "role"], :name => "project_part_project_role_index"

  create_table "role", :id => false, :force => true do |t|
    t.string "id",   :limit => 32, :null => false
    t.string "name", :limit => 64
  end

  add_index "role", ["name"], :name => "role_name_key", :unique => true
  add_index "role", ["name"], :name => "subject_role_name_index"

  create_table "role_member", :id => false, :force => true do |t|
    t.string "user_email",               :null => false
    t.string "role_id",    :limit => 32, :null => false
  end

  create_table "search_index_queue", :id => false, :force => true do |t|
    t.string   "id",            :limit => 32,  :null => false
    t.string   "subject_id",    :limit => 256, :null => false
    t.string   "subject_class",                :null => false
    t.datetime "timestamp",                    :null => false
    t.integer  "priority"
  end

  create_table "service", :id => false, :force => true do |t|
    t.string   "hostname",                                                :null => false
    t.decimal  "port",                     :precision => 7,  :scale => 0, :null => false
    t.datetime "start_time",                                              :null => false
    t.decimal  "process_id",               :precision => 10, :scale => 0, :null => false
    t.string   "username",   :limit => 20,                                :null => false
  end

  add_index "service", ["hostname", "port", "start_time", "process_id", "username"], :name => "service_hostname_port_start_time_process_id_username_idx", :unique => true

  create_table "software_result", :id => false, :force => true do |t|
    t.string "id",           :limit => 32,   :null => false
    t.string "class_name",                   :null => false
    t.string "version",      :limit => 64
    t.string "inputs_id",    :limit => 4000
    t.string "params_id",    :limit => 4000
    t.string "outputs_path", :limit => 1000
  end

  create_table "subject", :id => false, :force => true do |t|
    t.string "subject_id",    :limit => 32, :null => false
    t.string "subclass_name",               :null => false
    t.string "name"
  end

  add_index "subject", ["name"], :name => "subject_name_index"

  create_table "subject_attribute", :id => false, :force => true do |t|
    t.string "subject_id",      :limit => 32,  :null => false
    t.string "attribute_label", :limit => 64,  :null => false
    t.string "attribute_value", :limit => 512, :null => false
    t.string "nomenclature",    :limit => 64,  :null => false
  end

  add_index "subject_attribute", ["attribute_label"], :name => "subject_attribute_label_index"

  create_table "task", :id => false, :force => true do |t|
    t.string    "id",                              :null => false
    t.string    "user_id",                         :null => false
    t.string    "command_class",                   :null => false
    t.string    "stdout_pathname", :limit => 4096
    t.string    "stderr_pathname", :limit => 4096
    t.string    "status",          :limit => 50,   :null => false
    t.timestamp "time_submitted",  :limit => 6,    :null => false
    t.timestamp "time_started",    :limit => 6
    t.timestamp "time_finished",   :limit => 6
  end

  create_table "task_params", :id => false, :force => true do |t|
    t.string "genome_task_id", :null => false
    t.text   "params",         :null => false
  end

  create_table "user", :id => false, :force => true do |t|
    t.string "id",                 :limit => 32,  :null => false
    t.string "software_result_id", :limit => 32,  :null => false
    t.string "user_id",                           :null => false
    t.string "user_class_name"
    t.string "label",              :limit => 100
  end

  add_index "user", ["email"], :name => "subject_user_email_index"
  add_index "user", ["software_result_id", "label"], :name => "user_result_label_index"
  add_index "user", ["software_result_id", "user_id"], :name => "user_result_id_user_id_index"
  add_index "user", ["user_id", "user_class_name", "label"], :name => "user_id_name_label_index"
  add_index "user", ["username"], :name => "subject_user_username_index"

  create_table "user", :id => false, :force => true do |t|
    t.string "id",                 :limit => 32,  :null => false
    t.string "software_result_id", :limit => 32,  :null => false
    t.string "user_id",                           :null => false
    t.string "user_class_name"
    t.string "label",              :limit => 100
  end

  add_index "user", ["email"], :name => "subject_user_email_index"
  add_index "user", ["software_result_id", "label"], :name => "user_result_label_index"
  add_index "user", ["software_result_id", "user_id"], :name => "user_result_id_user_id_index"
  add_index "user", ["user_id", "user_class_name", "label"], :name => "user_id_name_label_index"
  add_index "user", ["username"], :name => "subject_user_username_index"

  create_table "variant", :id => false, :force => true do |t|
    t.string  "variant_id",         :limit => 32, :null => false
    t.string  "chromosome",                       :null => false
    t.integer "start_pos",          :limit => 8,  :null => false
    t.integer "stop_pos",           :limit => 8,  :null => false
    t.string  "reference_allele"
    t.string  "variant_allele"
    t.string  "gene_name"
    t.string  "transcript_name"
    t.string  "transcript_source"
    t.string  "transcript_version"
    t.string  "strand"
    t.string  "trv_type"
    t.string  "c_position"
    t.string  "amino_acid_change"
    t.string  "ucsc_cons"
    t.string  "domain"
  end

  create_table "volume", :id => false, :force => true do |t|
    t.string  "id",             :limit => 32,                    :null => false
    t.string  "hostname",                                        :null => false
    t.string  "physical_path",                                   :null => false
    t.string  "mount_path",                                      :null => false
    t.integer "total_kb",       :limit => 8,                     :null => false
    t.integer "unallocated_kb", :limit => 8,                     :null => false
    t.string  "disk_status",    :limit => 15,                    :null => false
    t.boolean "can_allocate",                 :default => true,  :null => false
    t.boolean "doubles_space",                :default => false, :null => false
  end

  add_index "volume", ["mount_path"], :name => "volume_mount_path_index"

  create_table "volume_group_bridge", :id => false, :force => true do |t|
    t.string "volume_id", :limit => 32, :null => false
    t.string "group_id",  :limit => 32, :null => false
  end

end
