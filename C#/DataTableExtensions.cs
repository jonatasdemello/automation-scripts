using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;

namespace CC.Common.Extensions
{
    /// <summary>
    /// Extension methods for turning objects into datatables
    /// </summary>
    public static class DataTableExtensions
    {

        /// <summary>
        /// Convert IEnumerable to a DataTable
        /// </summary>
        /// <typeparam name="T">collection Type</typeparam>
        /// <param name="collection">the collection</param>
        /// <param name="tableName">name of DataTable</param>
        /// <returns></returns>
        public static DataTable ToDataTable<T>(this IEnumerable<T> collection, string tableName)
        {
            var dt = ToDataTable<T>(collection);
            dt.TableName = tableName;
            return dt;
        }

        /// <summary>
        /// Convert IEnumerable to a DataTable
        /// </summary>
        /// <typeparam name="T">collection Type</typeparam>
        /// <param name="collection">the collection</param>
        /// <returns></returns>
        public static DataTable ToDataTable<T>(this IEnumerable<T> collection)
        {
            Type t = typeof(T);
            if (t == typeof(object))
            {
                return DynamicDataTable(collection.ToList());
            }

            var dt = new DataTable();
            PropertyInfo[] properties = t.GetProperties();
            //Create the columns in the DataTable
            foreach (PropertyInfo pi in properties)
            {
                Type type = pi.PropertyType;
                if (pi.PropertyType.IsGenericType && pi.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>))
                {
                    type = pi.PropertyType.GetGenericArguments()[0];
                }
                dt.Columns.Add(pi.Name, type);
            }
            //Populate the table
            foreach (T item in collection)
            {
                DataRow dr = dt.NewRow();
                dr.BeginEdit();
                foreach (PropertyInfo pi in properties)
                {
                    var val = pi.GetValue(item, null) ?? DBNull.Value;
                    dr[pi.Name] = val;
                }
                dr.EndEdit();
                dt.Rows.Add(dr);
            }
            return dt;
        }

        /// <summary>
        /// Create a DataTable from a list of dynamic objects
        /// </summary>
        /// <typeparam name="T">list Type</typeparam>
        /// <param name="list">the list</param>
        /// <returns></returns>
        private static DataTable DynamicDataTable<T>(List<T> list)
        {
            var dt = new DataTable();
            string[] itemsInPair = new string[2];
            string val = string.Empty;
            DataRow row;

            if (!list.Any()) return dt;

            var arPairs = ParseDapperRowString(list[0].ToString());
            foreach (var pair in arPairs)
            {
                itemsInPair = pair.Trim().Split('=');
                dt.Columns.Add(itemsInPair[0].Trim(), typeof(string));
            }

            foreach (T t in list)
            {
                row = dt.NewRow();
                arPairs = ParseDapperRowString(t.ToString());
                foreach (var pair in arPairs)
                {
                    itemsInPair = pair.Trim().Split('=');
                    val = itemsInPair[1].Trim();
                    row[itemsInPair[0].Trim()] = val.Substring(1, val.Length - 2);
                }
                dt.Rows.Add(row);
            }
            return dt;
        }

        private static string[] ParseDapperRowString(string str)
        {
            var sRemovedCurlys = str.Substring(12, str.Length - 13);
            return sRemovedCurlys.Split(',');
        }
    }
}