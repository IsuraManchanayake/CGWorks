import java.util.Map;

class Spring {
    float k;
    float l;
    ArrayList<Mass> ends;

    Spring(float l, float k) {
        this.k = k;
        this.l = l;
        this.ends = new ArrayList<Mass>();
    }

    Mass otherEnd(Mass mass) {
        return (this.ends.get(0).idx == mass.idx) ? this.ends.get(1) : this.ends.get(0);
    }
}
