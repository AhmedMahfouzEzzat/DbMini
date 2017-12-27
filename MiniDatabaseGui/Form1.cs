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
        private static extern int EnrollStudent([In]char[] id, [In]char[] name, int id_size, int name_size);

        [DllImport("MiniDatabase.dll")]
        private static extern int DeleteStudent([In]char[] id, int id_size);

        [DllImport("MiniDatabase.dll")]
        private static extern int UpdateGrade([In]char[] id, [In]char[] grade, int id_size, [In] int size);

        [DllImport("MiniDatabase.dll")]
        private static extern int DisStudentData([In, Out]char[] id, int id_size, [In, Out]char[] name, [In, Out]char[] grade, [In, Out]char[] Alpha_grade);

        [DllImport("MiniDatabase.dll")]
        private static extern int GenerateReport([In]char[] fileName, char sortBy);

        public Form1()
        {
            InitializeComponent();
        }

        char[] filename;
        byte filekey;
        bool DATA_CHANGED = false;
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
            int Exist = 0;
            if (Enroll_rb.Checked )
            {
                Exist = EnrollStudent(ID_tb.Text.ToCharArray(), Name_tb.Text.ToCharArray(), ID_tb.Text.Length, Name_tb.Text.Length);
                if (Exist != -1)                
                    MessageBox.Show(" ID is exist !! ");             
                else
                    DATA_CHANGED = true;
            }

            else if (Update_rb.Checked )
            {
                Exist = UpdateGrade(ID_tb.Text.ToCharArray(), Grade_tb.Text.ToCharArray(), ID_tb.Text.Length, Grade_tb.Text.Length);
                if (Exist == -1)               
                    MessageBox.Show(" ID is not exist !! ");                              
                else
                    DATA_CHANGED = true;
            }

            else if (Delete_rb.Checked )
            {
                Exist = DeleteStudent(ID_tb.Text.ToCharArray(), ID_tb.Text.Length);
                if (Exist == -1)  
                    MessageBox.Show(" ID is not exist !! ");            
                else
                    DATA_CHANGED = true;
            }

            else if (Display_rb.Checked )
            {
                char[] name = new char[20];
                char[] grade = new char[3];
                char[] A_grade = new char[1];
                Exist = DisStudentData(ID_tb.Text.ToCharArray(), ID_tb.Text.Length, name, grade, A_grade);
                if (Exist == -1)
                    MessageBox.Show(" ID is not exist !! ");
                else
                {
                    string s_name = new string(name);
                    string s_grade = new string(grade);
                    string s_Agrade = new string(A_grade);
                    Name_tb.Text = s_name;
                    Grade_tb.Text = s_grade;
                    A_Grade_tb.Text = s_Agrade;
                }
     
            }
            
        }

        private void Save_changes_bn_Click(object sender, EventArgs e)
        {
            if (DATA_CHANGED)
            {
                SaveDatabase(filename, filekey);
                DATA_CHANGED = false;
            }
            else
                MessageBox.Show("There is no change");
        }

        private void Generate_report_bn_Click(object sender, EventArgs e)
        {
            char sortBy;
            string reprt_name;
            int data ;
            Generate_report REPORT = new Generate_report();
            DialogResult ret = REPORT.ShowDialog();
            if (Generate_report.ok_clicked)
            {
                sortBy = Generate_report.Sort_type;
                reprt_name = Generate_report.Rep_name;
                data=GenerateReport(reprt_name.ToCharArray(), sortBy);
                if(data != 0)
                    System.Diagnostics.Process.Start(reprt_name);
                else
                    MessageBox.Show(" There is no data to show !! ");

                Generate_report.ok_clicked = false;
            }
        }

        private void when_rb_checked(object sender, EventArgs e)
        {
            Name_tb.Text = Grade_tb.Text = A_Grade_tb.Text = "";
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
            else
            { Grade_tb.Enabled = Name_tb.Enabled = A_Grade_tb.Enabled = false; }
        }

        private void when_Click(object sender, EventArgs e)
        {
            ID_tb.Text = Name_tb.Text = Grade_tb.Text = A_Grade_tb.Text = "";
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (DATA_CHANGED)
            {
                DialogResult dialogResult = MessageBox.Show("Do you want to save changes", "Save", MessageBoxButtons.YesNoCancel);
                if (dialogResult == DialogResult.Yes){ Save_changes_bn_Click(sender, e); }
            }
        }
    }
}
