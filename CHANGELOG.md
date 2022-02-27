# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).



## [0.3.1] - 2022-02-27
### Changed
- Update the readme.



## [0.3.0] - 2022-02-27
### Added
- Add Rake task `schemagic:install` so users don't have to use the generator directly.
- Added `YardHelpers` so we don't have to go through Rake to call YARD.
### Changed
- Remove minimum version for Rails.
- Update minimum Ruby version to `2.7.0`.
- Update minimum YARD version.
- Update the readme.
- Updated Rake tasks.
- Reverted `pry` to a development dependency.



## [0.2.0] - 2022-02-26
### Notes
- First working version



## [0.1.0] - 2022-02-26
### Added
- Added generator for config file.



## [0.0.1] - 2022-02-26
### Notes
- Initial setup.
### Added
- Added code straight from existing Rails repositories.
- Added single model (`User`) to dummy app.
- Added `test_helper.rb` to dummy app.
