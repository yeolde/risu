# Copyright (c) 2010-2012 Arxopia LLC.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the Arxopia LLC nor the names of its contributors
#     	may be used to endorse or promote products derived from this software
#     	without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL ARXOPIA LLC BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
#OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
#OF THE POSSIBILITY OF SUCH DAMAGE.

require 'test_helper'

class TechnicalFindingsTemplateTest < ActiveSupport::TestCase

	def setup
		@file_name = "/tmp/tech_find.pdf"
		@template_manager = Risu::Base::TemplateManager.new "risu/templates"

		@report = Report
		@report.title = "Function Test"
		@report.author = "hammackj"
		@report.company = "None"
		@report.classification = "None"

		@templater = Risu::Base::Templater.new("technical_findings", Report, @file_name, @template_manager)
		@templater.generate
	end

	def teardown
		File.delete(@file_name) if File.exist?(@file_name)
	end

	test "should create #{@filename} on template creation" do
		assert File.exist?(@file_name) == true
	end

	test "should have an MD5 of '7a059b3203fb6db8c1031518a651a6ff' after creation" do
		require 'digest/md5'

		digest = Digest::MD5.new
		File.open(@file_name) do |f|
			digest.update(f.read(1024))
		end

		assert digest.hexdigest == "7a059b3203fb6db8c1031518a651a6ff", "GOT #{digest.hexdigest}"
	end
end
