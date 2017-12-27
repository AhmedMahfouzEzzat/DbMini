using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MiniDatabaseGui
{
    public partial class Generate_report : Form
    {
        public static string Rep_name;
        public static char Sort_type;
        public static bool ok_clicked = false;
        public Generate_report()
        {
            InitializeComponent();
        }

        private void OK_button_Click(object sender, EventArgs e)
        {
            Rep_name = (Report_name_tb.Text + ".txt\0");
            if (SB_A.Checked)
                Sort_type = 'A';
            else
                Sort_type = 'D';

            ok_clicked = true;
            this.Close();
        }
    }
}
