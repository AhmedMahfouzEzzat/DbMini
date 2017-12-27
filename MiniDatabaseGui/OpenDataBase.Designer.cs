namespace MiniDatabaseGui
{
    partial class OpenDataBase
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(OpenDataBase));
            this.open_database_filename = new System.Windows.Forms.TextBox();
            this.l = new System.Windows.Forms.Label();
            this.open_database_key = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.open_database_btn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // open_database_filename
            // 
            this.open_database_filename.Location = new System.Drawing.Point(158, 62);
            this.open_database_filename.Name = "open_database_filename";
            this.open_database_filename.Size = new System.Drawing.Size(128, 20);
            this.open_database_filename.TabIndex = 14;
            this.open_database_filename.Text = "Mini_DataBase";
            // 
            // l
            // 
            this.l.AutoSize = true;
            this.l.BackColor = System.Drawing.Color.Transparent;
            this.l.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.l.ForeColor = System.Drawing.Color.Blue;
            this.l.Location = new System.Drawing.Point(23, 63);
            this.l.Name = "l";
            this.l.Size = new System.Drawing.Size(121, 16);
            this.l.TabIndex = 13;
            this.l.Text = "Enter File Name :-";
            // 
            // open_database_key
            // 
            this.open_database_key.Location = new System.Drawing.Point(158, 22);
            this.open_database_key.Name = "open_database_key";
            this.open_database_key.Size = new System.Drawing.Size(128, 20);
            this.open_database_key.TabIndex = 12;
            this.open_database_key.Text = "170";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.Transparent;
            this.label1.Font = new System.Drawing.Font("Tahoma", 9.75F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.Blue;
            this.label1.Location = new System.Drawing.Point(23, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(86, 16);
            this.label1.TabIndex = 11;
            this.label1.Text = "Enter Key :-";
            // 
            // open_database_btn
            // 
            this.open_database_btn.BackColor = System.Drawing.Color.MintCream;
            this.open_database_btn.Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.open_database_btn.ForeColor = System.Drawing.Color.Blue;
            this.open_database_btn.Location = new System.Drawing.Point(94, 106);
            this.open_database_btn.Name = "open_database_btn";
            this.open_database_btn.Size = new System.Drawing.Size(106, 25);
            this.open_database_btn.TabIndex = 10;
            this.open_database_btn.Text = "Open";
            this.open_database_btn.UseVisualStyleBackColor = false;
            this.open_database_btn.Click += new System.EventHandler(this.open_database_btn_Click);
            // 
            // OpenDataBase
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackgroundImage = global::MiniDatabaseGui.Properties.Resources.abstract_blue_abstract_wallpaper_background_for_smart_phones_apple_download_wallpaper_amazing_cool_wallpaper_of_abstract_drawing_2560x1600_736x459;
            this.ClientSize = new System.Drawing.Size(298, 143);
            this.Controls.Add(this.open_database_filename);
            this.Controls.Add(this.l);
            this.Controls.Add(this.open_database_key);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.open_database_btn);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "OpenDataBase";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "OpenDataBase";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.OpenDataBase_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox open_database_filename;
        private System.Windows.Forms.Label l;
        private System.Windows.Forms.TextBox open_database_key;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button open_database_btn;
    }
}