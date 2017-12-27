namespace MiniDatabaseGui
{
    partial class Generate_report
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.OK_button = new System.Windows.Forms.Button();
            this.Report_name_tb = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.SB_D = new System.Windows.Forms.RadioButton();
            this.SB_A = new System.Windows.Forms.RadioButton();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // OK_button
            // 
            this.OK_button.BackColor = System.Drawing.Color.MintCream;
            this.OK_button.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.OK_button.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.OK_button.ForeColor = System.Drawing.Color.Blue;
            this.OK_button.Location = new System.Drawing.Point(89, 117);
            this.OK_button.Name = "OK_button";
            this.OK_button.Size = new System.Drawing.Size(117, 23);
            this.OK_button.TabIndex = 0;
            this.OK_button.Text = "OK";
            this.OK_button.UseVisualStyleBackColor = false;
            this.OK_button.Click += new System.EventHandler(this.OK_button_Click);
            // 
            // Report_name_tb
            // 
            this.Report_name_tb.Location = new System.Drawing.Point(119, 19);
            this.Report_name_tb.Name = "Report_name_tb";
            this.Report_name_tb.Size = new System.Drawing.Size(141, 20);
            this.Report_name_tb.TabIndex = 1;
            this.Report_name_tb.Text = "report";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.Blue;
            this.label1.Location = new System.Drawing.Point(12, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(101, 16);
            this.label1.TabIndex = 2;
            this.label1.Text = "Report Name :";
            // 
            // groupBox2
            // 
            this.groupBox2.BackColor = System.Drawing.Color.Transparent;
            this.groupBox2.Controls.Add(this.SB_D);
            this.groupBox2.Controls.Add(this.SB_A);
            this.groupBox2.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.ForeColor = System.Drawing.Color.Blue;
            this.groupBox2.Location = new System.Drawing.Point(15, 45);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(108, 58);
            this.groupBox2.TabIndex = 21;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Sort Type";
            // 
            // SB_D
            // 
            this.SB_D.AutoSize = true;
            this.SB_D.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SB_D.ForeColor = System.Drawing.Color.Black;
            this.SB_D.Location = new System.Drawing.Point(13, 35);
            this.SB_D.Name = "SB_D";
            this.SB_D.Size = new System.Drawing.Size(80, 17);
            this.SB_D.TabIndex = 12;
            this.SB_D.Text = "Descending";
            this.SB_D.UseVisualStyleBackColor = true;
            // 
            // SB_A
            // 
            this.SB_A.AutoSize = true;
            this.SB_A.Checked = true;
            this.SB_A.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SB_A.ForeColor = System.Drawing.Color.Black;
            this.SB_A.Location = new System.Drawing.Point(13, 16);
            this.SB_A.Name = "SB_A";
            this.SB_A.Size = new System.Drawing.Size(80, 17);
            this.SB_A.TabIndex = 11;
            this.SB_A.TabStop = true;
            this.SB_A.Text = "Aescending";
            this.SB_A.UseVisualStyleBackColor = true;
            // 
            // Generate_report
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = global::MiniDatabaseGui.Properties.Resources.abstract_blue_abstract_wallpaper_background_for_smart_phones_apple_download_wallpaper_amazing_cool_wallpaper_of_abstract_drawing_2560x1600_736x459;
            this.ClientSize = new System.Drawing.Size(284, 152);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Report_name_tb);
            this.Controls.Add(this.OK_button);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Generate_report";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Generate_report";
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button OK_button;
        private System.Windows.Forms.TextBox Report_name_tb;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.RadioButton SB_D;
        private System.Windows.Forms.RadioButton SB_A;
    }
}