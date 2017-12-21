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
    public partial class OpenDataBase : Form
    {
        public static byte file_key;
        public static char[] file_name;
        bool flag = true;
        public OpenDataBase()
        {
            InitializeComponent();
        }

        private void open_database_btn_Click(object sender, EventArgs e)
        {
            file_key = Convert.ToByte(open_database_key.Text);
            file_name = (open_database_filename.Text + ".txt").ToCharArray();
            flag = false;
            this.Close();
        }

        private void OpenDataBase_FormClosed(object sender, FormClosedEventArgs e)
        {
            if(flag) Application.Exit();
        }
    }
}
