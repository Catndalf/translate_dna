require_relative 'dna'

RSpec.describe 'DNA' do
  subject {translate_with_frame(dna,frames)}
  
  context "when one frame request" do 
    let(:dna){"AGGTGACACCGCAAGCCTTATATTAGC"}

    context "for frame 1" do 
      let(:frames){[1]}
      it "return frame 1" do      
      expect(subject).to eq(["R*HRKPYIS"])
      end
    end

    context "for frame 2" do 
      let(:frames){[2]}
      it "return frame 2" do        
        expect(subject).to eq(["GDTASLIL"])
      end
    end

    context "for frame 3" do
     let(:frames){[3]} 
     it "return frame 3" do        
      expect(subject).to eq(["VTPQALY*"])
      end
    end

    context "for frame -1" do
      let(:frames){[-1]}
      it "return frame -1" do        
        expect(subject).to eq(["ANIRLAVSP"])
      end
    end

    context "for frame -2" do
      let(:frames){[-2]}
      it "return frame -2" do
        expect(subject).to eq(["LI*GLRCH"])
      end
    end

    context "for frame -3" do
      let(:frames){[-3]}
      it "return frame -3" do
        expect(subject).to eq(["*YKACGVT"])
      end
    end

    context "for frame 1,-3" do
      let(:frames){[1,-3]}
      it "return frame 1, -3" do
        expect(subject).to eq(["R*HRKPYIS","*YKACGVT"])
      end
    end

    context "for frame -2,3" do
      let(:frames){[-2, 3]}
      it "return frame -2, 3" do
        expect(subject).to eq(["LI*GLRCH","VTPQALY*"])
      end
    end
  end

  context "when low size dna" do 
    subject {translate_with_frame(dna)}
    let(:dna){"AAA"}

    context "for all frames" do       
      it "return all frames"  do      
        expect(subject).to eq(["K", "", "", "F", "", ""])
      end
    end
  end  
end
