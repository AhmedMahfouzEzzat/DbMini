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
        [DllImport("MiniDatabase.dll")]
        private static extern void OpenDatabase([In]char[] filename, byte key);

        [DllImport("MiniDatabase.dll")]
        private static extern void SaveDatabase([In]char[] filename, byte key);

        [DllImport("MiniDatabase.dll")]
        private static extern void EnrollStudent([In]char[] id, [In]char[] name, int id_size, int name_size);

        [DllImport("MiniDatabase.dll")]
        private static extern void DeleteStudent([In]char id);

        [DllImport("MiniDatabase.dll")]
        private static extern void UpdateGrade([In]char id,[In]char[] grade,[In] int size);
    

        public Form1()
        {
            InitializeComponent();
        }

        char[] name = "Mini_DataBase.txt".ToCharArray();
        private void Form1_Load(object sender, EventArgs e)
        {
            OpenDatabase(name,170);
        }

        private void button1_Click(object sender, EventArgs e)
        {       foreach (RadioButton control in this.groupBox1.Controls)
                {
                        if (control.Checked)
                        {
                    if (control.Name == Enroll_rb.Name)
                    {
                        EnrollStudent(ID_tb.Text.ToCharArray(), Name_tb.Text.ToCharArray(), ID_tb.Text.Length, Name_tb.Text.Length);
                        MessageBox.Show("Enroll");
                    }
                    else if (control.Name == Delete_rb.Name)
                    {
                        char[] d = ID_tb.Text.ToCharArray();
                        DeleteStudent(d[0]);
                        MessageBox.Show("Delete");
                    }
                    else if (control.Name == Update_rb.Name) {
                        char[] d = ID_tb.Text.ToCharArray();
                        UpdateGrade(d[0],Grade_tb.Text.ToCharArray(),Grade_tb.Text.ToCharArray().Length);

                    }
                    else if (control.Name == Display_rb.Name) { }


                    break;


                    }
                }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            SaveDatabase(name, 170);
        }
    }
}
