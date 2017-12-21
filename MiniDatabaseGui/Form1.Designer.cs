namespace MiniDatabaseGui
{
    partial class Form1
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.OK_button = new System.Windows.Forms.Button();
            this.Enroll_rb = new System.Windows.Forms.RadioButton();
            this.Delete_rb = new System.Windows.Forms.RadioButton();
            this.Display_rb = new System.Windows.Forms.RadioButton();
            this.Update_rb = new System.Windows.Forms.RadioButton();
            this.ID_tb = new System.Windows.Forms.TextBox();
            this.Grade_tb = new System.Windows.Forms.TextBox();
            this.Name_tb = new System.Windows.Forms.TextBox();
            this.A_Grade = new System.Windows.Forms.TextBox();
            this.Generate_report_bn = new System.Windows.Forms.Button();
            this.SB_ID = new System.Windows.Forms.RadioButton();
            this.SB_GRADE = new System.Windows.Forms.RadioButton();
            this.Save_changes_bn = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // OK_button
            // 
            this.OK_button.BackColor = System.Drawing.Color.MintCream;
            this.OK_button.Font = new System.Drawing.Font("Tahoma", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.OK_button.Location = new System.Drawing.Point(221, 161);
            this.OK_button.Name = "OK_button";
            this.OK_button.Size = new System.Drawing.Size(122, 29);
            this.OK_button.TabIndex = 0;
            this.OK_button.Text = "OK";
            this.OK_button.UseVisualStyleBackColor = false;
            this.OK_button.Click += new System.EventHandler(this.button1_Click);
            // 
            // Enroll_rb
            // 
            this.Enroll_rb.AutoSize = true;
            this.Enroll_rb.Checked = true;
            this.Enroll_rb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Enroll_rb.ForeColor = System.Drawing.Color.Black;
            this.Enroll_rb.Location = new System.Drawing.Point(23, 21);
            this.Enroll_rb.Name = "Enroll_rb";
            this.Enroll_rb.Size = new System.Drawing.Size(89, 17);
            this.Enroll_rb.TabIndex = 1;
            this.Enroll_rb.TabStop = true;
            this.Enroll_rb.Text = "EnrollStudent";
            this.Enroll_rb.UseVisualStyleBackColor = true;
            // 
            // Delete_rb
            // 
            this.Delete_rb.AutoSize = true;
            this.Delete_rb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Delete_rb.ForeColor = System.Drawing.Color.Black;
            this.Delete_rb.Location = new System.Drawing.Point(22, 44);
            this.Delete_rb.Name = "Delete_rb";
            this.Delete_rb.Size = new System.Drawing.Size(94, 17);
            this.Delete_rb.TabIndex = 2;
            this.Delete_rb.Text = "DeleteStudent";
            this.Delete_rb.UseVisualStyleBackColor = true;
            // 
            // Display_rb
            // 
            this.Display_rb.AutoSize = true;
            this.Display_rb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Display_rb.ForeColor = System.Drawing.Color.Black;
            this.Display_rb.Location = new System.Drawing.Point(324, 44);
            this.Display_rb.Name = "Display_rb";
            this.Display_rb.Size = new System.Drawing.Size(120, 17);
            this.Display_rb.TabIndex = 3;
            this.Display_rb.Text = "DisplayStudentData";
            this.Display_rb.UseVisualStyleBackColor = true;
            // 
            // Update_rb
            // 
            this.Update_rb.AutoSize = true;
            this.Update_rb.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Update_rb.ForeColor = System.Drawing.Color.Black;
            this.Update_rb.Location = new System.Drawing.Point(324, 21);
            this.Update_rb.Name = "Update_rb";
            this.Update_rb.Size = new System.Drawing.Size(89, 17);
            this.Update_rb.TabIndex = 4;
            this.Update_rb.Text = "UpdateGrade";
            this.Update_rb.UseVisualStyleBackColor = true;
            // 
            // ID_tb
            // 
            this.ID_tb.Location = new System.Drawing.Point(49, 123);
            this.ID_tb.MaxLength = 4;
            this.ID_tb.Name = "ID_tb";
            this.ID_tb.Size = new System.Drawing.Size(54, 21);
            this.ID_tb.TabIndex = 6;
            // 
            // Grade_tb
            // 
            this.Grade_tb.Location = new System.Drawing.Point(462, 124);
            this.Grade_tb.MaxLength = 3;
            this.Grade_tb.Name = "Grade_tb";
            this.Grade_tb.Size = new System.Drawing.Size(63, 21);
            this.Grade_tb.TabIndex = 7;
            // 
            // Name_tb
            // 
            this.Name_tb.Location = new System.Drawing.Point(173, 124);
            this.Name_tb.Name = "Name_tb";
            this.Name_tb.Size = new System.Drawing.Size(216, 21);
            this.Name_tb.TabIndex = 8;
            // 
            // A_Grade
            // 
            this.A_Grade.Location = new System.Drawing.Point(533, 124);
            this.A_Grade.Name = "A_Grade";
            this.A_Grade.Size = new System.Drawing.Size(35, 21);
            this.A_Grade.TabIndex = 9;
            // 
            // Generate_report_bn
            // 
            this.Generate_report_bn.BackColor = System.Drawing.Color.MintCream;
            this.Generate_report_bn.Location = new System.Drawing.Point(286, 216);
            this.Generate_report_bn.Name = "Generate_report_bn";
            this.Generate_report_bn.Size = new System.Drawing.Size(162, 58);
            this.Generate_report_bn.TabIndex = 10;
            this.Generate_report_bn.Text = "Generate\r\n Full Report";
            this.Generate_report_bn.UseVisualStyleBackColor = false;
            // 
            // SB_ID
            // 
            this.SB_ID.AutoSize = true;
            this.SB_ID.Checked = true;
            this.SB_ID.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SB_ID.ForeColor = System.Drawing.Color.Black;
            this.SB_ID.Location = new System.Drawing.Point(13, 16);
            this.SB_ID.Name = "SB_ID";
            this.SB_ID.Size = new System.Drawing.Size(33, 17);
            this.SB_ID.TabIndex = 11;
            this.SB_ID.TabStop = true;
            this.SB_ID.Text = "id";
            this.SB_ID.UseVisualStyleBackColor = true;
            // 
            // SB_GRADE
            // 
            this.SB_GRADE.AutoSize = true;
            this.SB_GRADE.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.SB_GRADE.ForeColor = System.Drawing.Color.Black;
            this.SB_GRADE.Location = new System.Drawing.Point(13, 35);
            this.SB_GRADE.Name = "SB_GRADE";
            this.SB_GRADE.Size = new System.Drawing.Size(53, 17);
            this.SB_GRADE.TabIndex = 12;
            this.SB_GRADE.Text = "grade";
            this.SB_GRADE.UseVisualStyleBackColor = true;
            // 
            // Save_changes_bn
            // 
            this.Save_changes_bn.BackColor = System.Drawing.Color.MintCream;
            this.Save_changes_bn.Location = new System.Drawing.Point(49, 216);
            this.Save_changes_bn.Name = "Save_changes_bn";
            this.Save_changes_bn.Size = new System.Drawing.Size(161, 58);
            this.Save_changes_bn.TabIndex = 13;
            this.Save_changes_bn.Text = "save \r\nchanges ";
            this.Save_changes_bn.UseVisualStyleBackColor = false;
            this.Save_changes_bn.Click += new System.EventHandler(this.button3_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.Blue;
            this.label1.Location = new System.Drawing.Point(9, 126);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(31, 16);
            this.label1.TabIndex = 14;
            this.label1.Text = "ID :";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.BackColor = System.Drawing.Color.Transparent;
            this.label2.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.Blue;
            this.label2.Location = new System.Drawing.Point(107, 126);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(52, 16);
            this.label2.TabIndex = 15;
            this.label2.Text = "Name :";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.BackColor = System.Drawing.Color.Transparent;
            this.label3.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.Blue;
            this.label3.Location = new System.Drawing.Point(392, 126);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(55, 16);
            this.label3.TabIndex = 16;
            this.label3.Text = "Grade :";
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.groupBox1.Controls.Add(this.Update_rb);
            this.groupBox1.Controls.Add(this.Display_rb);
            this.groupBox1.Controls.Add(this.Delete_rb);
            this.groupBox1.Controls.Add(this.Enroll_rb);
            this.groupBox1.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.ForeColor = System.Drawing.Color.Blue;
            this.groupBox1.Location = new System.Drawing.Point(14, 25);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(555, 73);
            this.groupBox1.TabIndex = 19;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Select your procces";
            // 
            // groupBox2
            // 
            this.groupBox2.BackColor = System.Drawing.Color.Transparent;
            this.groupBox2.Controls.Add(this.SB_GRADE);
            this.groupBox2.Controls.Add(this.SB_ID);
            this.groupBox2.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.ForeColor = System.Drawing.Color.Blue;
            this.groupBox2.Location = new System.Drawing.Point(462, 216);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(108, 58);
            this.groupBox2.TabIndex = 20;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Sorted By ";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = global::MiniDatabaseGui.Properties.Resources.abstract_blue_abstract_wallpaper_background_for_smart_phones_apple_download_wallpaper_amazing_cool_wallpaper_of_abstract_drawing_2560x1600_736x459;
            this.ClientSize = new System.Drawing.Size(584, 312);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Save_changes_bn);
            this.Controls.Add(this.Generate_report_bn);
            this.Controls.Add(this.A_Grade);
            this.Controls.Add(this.Name_tb);
            this.Controls.Add(this.Grade_tb);
            this.Controls.Add(this.ID_tb);
            this.Controls.Add(this.OK_button);
            this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = " ";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button OK_button;
        private System.Windows.Forms.RadioButton Enroll_rb;
        private System.Windows.Forms.RadioButton Delete_rb;
        private System.Windows.Forms.RadioButton Display_rb;
        private System.Windows.Forms.RadioButton Update_rb;
        private System.Windows.Forms.TextBox ID_tb;
        private System.Windows.Forms.TextBox Grade_tb;
        private System.Windows.Forms.TextBox Name_tb;
        private System.Windows.Forms.TextBox A_Grade;
        private System.Windows.Forms.Button Generate_report_bn;
        private System.Windows.Forms.RadioButton SB_ID;
        private System.Windows.Forms.RadioButton SB_GRADE;
        private System.Windows.Forms.Button Save_changes_bn;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;

    }
}

