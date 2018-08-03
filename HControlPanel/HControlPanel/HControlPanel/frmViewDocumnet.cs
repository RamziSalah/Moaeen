using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HControlPanel
{
    public partial class frmViewDocumnet : Form
    {
        public frmViewDocumnet()
        {
            InitializeComponent();
        }
        
        public void displaydoc(string i)
        {
            try
            {
                pictureBox1.Image = Image.FromFile(Environment.CurrentDirectory + "\\identity" + i + ".png");
            }
            catch { }
        }
    }
}
