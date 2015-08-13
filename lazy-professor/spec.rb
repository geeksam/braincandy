require 'rspec'
require_relative 'code'

describe LazyProfessor::Consensus do
  subject { described_class.new(corpus) }

  context "when given sample data" do
    let(:corpus) {
      <<-EOF
ABCCADCB
DDDCAACB
ABDDABCB
AADCAACC
BBDDAACB
ABDCCABB
ABDDCACB
EOF
    }

    it "knows that there are seven tests" do
      expect(subject.tests.length).to eq(7)
    end

    it "knows what answers were given for the first test" do
      expect(subject.tests.first).to eq("ABCCADCB")
    end

    it "knows that there are eight questions" do
      expect(subject.questions.length).to eq(8)
    end

    it "knows what answers were given for the first question" do
      expect(subject.questions.first).to eq( %w[ A D A A B A A ] )
    end

    it "knows the counts of the answers for the first question" do
      first_counts = { "A" => 5, "B" => 1, "D" => 1 }
      expect(subject.counts_per_question.first).to eq(first_counts)
    end

    it "knows the most popular answer for the first question" do
      expect(subject.most_popular_answers.first).to eq("A")
    end

    it "builds the answer key from most_popular_answers" do
      expect(subject.answer_key).to eq("ABDCAACB")
    end

    it "can format the answer key" do
      expect(subject.ciphertext_formatted_answer_key).to eq("ABDCA ACB")
    end
  end

  context "when given a larger corpus" do
    let(:corpus) { File.read("test.txt") }

    it "gets an answer, which I totally just copy/pasted from the output back into the test :D" do
      expect(subject.answer_key).to eq("BACBCAAACBCAAABDABBBBDBCBDAABDADDACBAACADDBAABABCB")
      expect(subject.ciphertext_formatted_answer_key).to eq("BACBC AAACB CAAAB DABBB BDBCB DAABD ADDAC BAACA DDBAA BABCB")
    end
  end
end

