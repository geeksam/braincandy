module LazyProfessor
  class Consensus
    attr_reader :tests
    def initialize(corpus)
      @tests = corpus.lines.map(&:strip).reject {|line| line =~ /^\s*$/ }
    end

    def answers
      tests.map {|test| test.scan(/./) }
    end

    def questions
      answers.transpose
    end

    def counts_per_question
      questions.map {|question|
        Hash[
          question \
          .group_by(&:to_s) \
          .map {|value, answers| [value, answers.length] }
        ]
      }
    end

    def most_popular_answers
      counts_per_question.map {|counts|
        counts \
          .sort_by {|(value, count)| count } \
          .last \
          .first
      }
    end

    def answer_key
      most_popular_answers.join
    end

    def ciphertext_formatted_answer_key
      answer_key.scan(/./).each_slice(5).map(&:join).join(" ")
    end
  end
end
