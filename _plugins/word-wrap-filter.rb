#!/usr/bin/env ruby
#
# Greedy word-wrap used by _includes/post-cover.svg to lay out a post
# title as multiple <tspan> lines without needing a per-post image.

module Jekyll
  module WordWrapFilter
    def wrap_lines(input, width = 20)
      width = width.to_i
      lines = []
      current = ""

      input.to_s.split(" ").each do |word|
        candidate = current.empty? ? word : "#{current} #{word}"
        if candidate.length > width && !current.empty?
          lines << current
          current = word
        else
          current = candidate
        end
      end

      lines << current unless current.empty?
      lines
    end
  end
end

Liquid::Template.register_filter(Jekyll::WordWrapFilter)
