using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace HControlPanel
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        static string connectionstring = "Data Source=37.224.30.93;" + "Initial Catalog=AYDBs;" + "persist Security info=true;user id=HacUS;password=12345";
        SqlConnection conn = new SqlConnection(connectionstring);

        private void button1_Click(object sender, EventArgs e)
        {
            string sql = "select * from tbhajj where major like N'" + comboBox1.Text +"'";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            if (conn.State == ConnectionState.Closed)
                conn.Open();

            DataTable dt = new DataTable();
            da.Fill(dt);

            //dataGridView1.DataSource = dt;
            DataGridViewCell cell = new DataGridViewTextBoxCell();

            DataTable dt2 = new DataTable();

            //dt2 = (DataTable)dataGridView1.DataSource;
            dataGridView1.Rows.Clear();
            for (int i = 0; i < dt.Rows.Count;i++)
            {
               
                dataGridView1.Rows.Add(dt.Rows[i]["id"].ToString(), dt.Rows[i]["name"].ToString(), dt.Rows[i]["phonenum"].ToString(),dt.Rows[i]["authperson"].ToString(), dt.Rows[i]["authpic"].ToString(),false);

                //DataGridViewRow row = dt2.Rows();
                //row["id"]= dt.Rows[i]["id"].ToString();
                //row["Phonenum"] = dt.Rows[i]["phonenum"].ToString();
                //row["name"]= dt.Rows[i]["name"].ToString();
                //row["major"] = dt.Rows[i]["authperson"].ToString();
                //row["authpic"] = dt.Rows[i]["authpic"].ToString();
                //dt.Rows.Add(row);
                //dataGridView1.Rows.Add();
                //dataGridView1.CurrentRow.Cells["id"].Value = dt.Rows[i]["id"].ToString();
                //dataGridView1.CurrentRow.Cells["Phonenum"].Value = dt.Rows[i]["phonenum"].ToString();
                //dataGridView1.CurrentRow.Cells["name"].Value = dt.Rows[i]["name"].ToString();
                //dataGridView1.CurrentRow.Cells["major"].Value = dt.Rows[i]["authperson"].ToString();
                //dataGridView1.CurrentRow.Cells["authpic"].Value = dt.Rows[i]["authpic"].ToString();

            }
            //dataGridView1.DataSource = dt2;
            //image

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

            if (dataGridView1.CurrentRow != null)
            {
                if (e.ColumnIndex == 3)
                {
                    string val = dataGridView1.CurrentRow.Cells[3].Value.ToString();
                    frmViewDocumnet frm = new frmViewDocumnet();
                    frm.displaydoc(val);
                    frm.ShowDialog();
                    //frm.ShowDialog(val);
                }
                else
            if (e.ColumnIndex == 4)
                {
                    string val2 = dataGridView1.CurrentRow.Cells[4].Value.ToString();

                }

                else
                    if (e.ColumnIndex == 5)
                {
                    int val =Convert.ToInt16(dataGridView1.CurrentRow.Cells[5].Value);
                    string val2 =dataGridView1.CurrentRow.Cells[2].Value.ToString();
                    string sql = "update tbhajj set accept=" + val+ " where phonenum="+val2;
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    if (conn.State == ConnectionState.Closed)
                        conn.Open();
                    cmd.ExecuteNonQuery();
                    //frm.ShowDialog(val);
                }
            }
        }
    }
}
