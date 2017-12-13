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

        [DllImport("Project.dll")]
        private static extern void enroll2([In, Out]char[] id, [In, Out]char[] name,int size, int size2, [In, Out]char[] buf);
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

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {   char[] txt1 = textBox1.Text.ToCharArray();
            char[] txt = textBox2.Text.ToCharArray();
            char[] txt2 = new char[100];
            enroll2(txt1, txt, txt1.Length, txt.Length, txt2);
            label1.Text = new string(txt2);

        }
    }
}
