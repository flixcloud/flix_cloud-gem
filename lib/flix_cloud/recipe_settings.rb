class FlixCloud::RecipeSettings < FlixCloud::Record

  def self.recipe_attributes
    @recipe_attributes ||= [:audio_bit_rate, :audio_channels,
                            :audio_sample_rate, :blur_mask_size, :blur_type,
                            :brightness, :contrast, :crf, :crop_bottom,
                            :crop_left, :crop_right, :crop_top, :custom_fps,
                            :cut_end, :cut_start, :decimation_rate,
                            :deinterlace, :denoise, :fps, :height, :hue,
                            :keyframe_frequency, :keyframe_interval_type,
                            :mirror, :pngex_auto_count, :pngex_auto_end_time,
                            :pngex_auto_random_period, :pngex_auto_start_time,
                            :pngex_compression_level, :pngex_enable_alpha,
                            :pngex_export_cue_points,
                            :pngex_export_first_frame, :pngex_export_interval,
                            :pngex_export_time_string, :pngex_filename_prefix,
                            :pngex_filename_suffix, :pngex_height,
                            :pngex_width, :rate_control, :resolution, :rotate,
                            :saturation, :sharpen, :video_bit_rate,
                            :video_compression_mode, :video_profile,
                            :video_rate_control_mode, :watermark_usage,
                            :watermark_x_position, :watermark_y_position,
                            :width]
  end

  attr_accessor *recipe_attributes

end
