import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioOutput out;
SlideInstrument slider;

void setup()
{
  size(512, 200, P2D);
  
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO, 2048);
  slider = new SlideInstrument(115, 234, 0.2, out);
  out.playNote(0.25, 2.8, slider);
  
}

void draw()
{
  background(0);
  stroke(255);
  // draw the waveforms
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }  
}

void mousePressed()
{
  slider.noteOn();
}

void mouseReleased()
{
  slider.noteOff();
}

void stop()
{
  out.close();
  minim.stop();

  super.stop();
}
