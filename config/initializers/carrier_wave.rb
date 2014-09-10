require 'carrierwave/orm/activerecord'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/