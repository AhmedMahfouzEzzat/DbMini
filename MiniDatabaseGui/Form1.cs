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

        [DllImport("MiniDatabase.dll")]
        private static extern void DisStudentData([In, Out]char[] id, int id_size, [In, Out]char[] name, [In, Out]char[] grade, [In, Out]char[] Alpha_grade);

        [DllImport("MiniDatabase.dll")]
        private static extern void GenerateReport();

        public Form1()
        {
            InitializeComponent();
        }

        char[] filename;
        byte filekey;
        private void Form1_Load(object sender, EventArgs e)
        {
            OpenDataBase OPEN_FORM = new OpenDataBase();
            OPEN_FORM.ShowDialog();
            filekey = OpenDataBase.file_key;
            filename = OpenDataBase.file_name;
            OpenDatabase(filename, filekey);

        }

        private void OK_button_Click(object sender, EventArgs e)
        {

            if (Enroll_rb.Checked)
            {
                EnrollStudent(ID_tb.Text.ToCharArray(), Name_tb.Text.ToCharArray(), ID_tb.Text.Length, Name_tb.Text.Length);
            }
            else if (Delete_rb.Checked)
            {
                DeleteStudent(ID_tb.Text.ToCharArray(), ID_tb.Text.Length);
            }
            else if (Update_rb.Checked)
            {
                UpdateGrade(ID_tb.Text.ToCharArray(), Grade_tb.Text.ToCharArray(), ID_tb.Text.Length, Grade_tb.Text.Length);
            }
            else if (Display_rb.Checked)
            {
                char[] name = new char[20];
                char[] grade = new char[3];
                char[] A_grade = new char[1];
                DisStudentData(ID_tb.Text.ToCharArray(), ID_tb.Text.Length, name, grade, A_grade);
                string s_name = new string(name);
                string s_grade = new string(grade);
                string s_Agrade = new string(A_grade);
                Name_tb.Text = s_name;
                Grade_tb.Text = s_grade;
                A_Grade_tb.Text = s_Agrade;
            }
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

        private void when_rb_checked(object sender, EventArgs e)
        {
            RadioButton RB = (RadioButton)sender;
            if (RB.Name == Enroll_rb.Name)
            {
                Name_tb.Enabled = true;
                Grade_tb.Enabled = A_Grade_tb.Enabled = false;
            }
            else if (RB.Name == Update_rb.Name)
            {
                Grade_tb.Enabled = true;
                Name_tb.Enabled = A_Grade_tb.Enabled = false;
            }
            else if (RB.Name == Display_rb.Name)
            { Grade_tb.Enabled = Name_tb.Enabled = A_Grade_tb.Enabled = true; }
            else
            { Grade_tb.Enabled = Name_tb.Enabled = A_Grade_tb.Enabled = false; }
        }

        private void when_Click(object sender, EventArgs e)
        {
            ID_tb.Text = Name_tb.Text = Grade_tb.Text = A_Grade_tb.Text = "";
        }
    }
}
