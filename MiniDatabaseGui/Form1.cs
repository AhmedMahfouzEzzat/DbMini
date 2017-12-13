using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MiniDatabaseGui
{
    public partial class Form1 : Form
    {
        [DllImport("Project.dll")]
        private static extern void makeFile();

        [DllImport("Project.dll")]
        private static extern void readFile2([In, Out]char[] arr);
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //makeFile();
            char[] c = new char[101];
            readFile2(c);
            label1.Text = new string(c);
            MessageBox.Show(new string(c));
        }
    }
}
