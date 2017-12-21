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
        private static extern void DeleteStudent([In]char[] id, int id_size);

        [DllImport("MiniDatabase.dll")]
        private static extern void UpdateGrade([In]char[] id, [In]char[] grade, int id_size, [In] int size);
    

        public Form1()
        {
            InitializeComponent();
        }

        char[] filename;
        byte filekey ;
        private void Form1_Load(object sender, EventArgs e)
        {
            OpenDataBase OPEN_FORM = new OpenDataBase();
            OPEN_FORM.ShowDialog();
            filekey = OpenDataBase.file_key;
            filename = OpenDataBase.file_name; 
            OpenDatabase(filename,filekey);

        }

        private void OK_button_Click(object sender, EventArgs e)
        {

            if (Enroll_rb.Checked)
            {
                EnrollStudent(ID_tb.Text.ToCharArray(), Name_tb.Text.ToCharArray(), ID_tb.Text.Length, Name_tb.Text.Length);
            }
            else if (Delete_rb.Checked)
            {
                char[] d = ID_tb.Text.ToCharArray();
                DeleteStudent(d, ID_tb.Text.Length);
            }
            else if (Update_rb.Checked)
            {
                string s = Grade_tb.Text.PadLeft(3, ' ');
                UpdateGrade(ID_tb.Text.ToCharArray(), s.ToCharArray(), ID_tb.Text.Length, s.Length);
            }
            else if (Display_rb.Checked)
            { }
        }


        private void Save_changes_bn_Click(object sender, EventArgs e)
        {
            SaveDatabase(filename, filekey);
        }

        private void Generate_report_bn_Click(object sender, EventArgs e)
        {
            if (SB_ID.Checked)
            { }
            else
            { }
            System.Diagnostics.Process.Start("Mini_DataBase.txt");
        }
    }
}
