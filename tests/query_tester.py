import os
import unittest
from pathlib import Path

from connectors.duck import DuckDBConnector
from connectors.snow import SnowflakeConnector
from connectors.sqlite import SQLiteConnector


class QueryTester(unittest.TestCase):

    def setUp(self):
        self.duckdb = DuckDBConnector('data/chinook/duckdb/chinook.db')
        self.sqlite = SQLiteConnector('data/chinook/sqlite/chinook.db')
        self.snowflake = SnowflakeConnector(os.path.join(str(Path.home()),
                                                         '.snowflake/config'))

        self.suffix = '.sql'
        self.duckdb_directory = 'queries/chinook/sql/duckdb'
        self.sqlite_directory = 'queries/chinook/sql/sqlite'
        self.snowflake_directory = 'queries/chinook/sql/snowflake'

        self.a = self.snowflake
        self.a_dir = self.snowflake_directory
        self.b = self.sqlite
        self.b_dir = self.sqlite_directory

    def test_select_nary_tuples(self):
        a = self.a.execute(os.path.join(self.a_dir, '4a' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '4a' + self.suffix))
        self.assertEqual(a, b)

    def test_select_binary_tuples(self):
        a = self.a.execute(os.path.join(self.a_dir, '4b' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '4b' + self.suffix))
        self.assertEqual(a, b)

    def test_select_new_relation(self):
        a = self.a.execute(os.path.join(self.a_dir, '5a' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '5a' + self.suffix))
        self.assertEqual(a, b)

    def test_filter_with_sql_like(self):
        a = self.a.execute(os.path.join(self.a_dir, '5b' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '5b' + self.suffix))
        self.assertEqual(a, b)

    def test_select_dates_between(self):
        a = self.a.execute(os.path.join(self.a_dir, '5c' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '5c' + self.suffix))
        self.assertEqual(a, b)

    def test_select_specific_date(self):
        a = self.a.execute(os.path.join(self.a_dir, '5d' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '5d' + self.suffix))
        self.assertEqual(a, b)

    def test_tuple_element_by_case(self):
        a = self.a.execute(os.path.join(self.a_dir, '5e' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '5e' + self.suffix))
        self.assertEqual(a, b)

    def test_inner_join_a(self):
        a = self.a.execute(os.path.join(self.a_dir, '6a' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '6a' + self.suffix))
        self.assertEqual(a, b)

    def test_inner_join_b(self):
        a = self.a.execute(os.path.join(self.a_dir, '6b' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '6b' + self.suffix))
        self.assertEqual(a, b)

    def test_left_join(self):
        a = self.a.execute(os.path.join(self.a_dir, '6c' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '6c' + self.suffix))
        self.assertEqual(a, b)

    def test_select_tuples_with_null(self):
        a = self.a.execute(os.path.join(self.a_dir, '6d' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '6d' + self.suffix))
        self.assertEqual(a, b)

    def test_multiple_join(self):
        a = self.a.execute(os.path.join(self.a_dir, '6e' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '6e' + self.suffix))
        self.assertEqual(a, b)

    def test_basic_aggregations(self):
        a = self.a.execute(os.path.join(self.a_dir, '7a' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7a' + self.suffix))
        self.assertEqual(a, b)

    def test_tuple_concatenation(self):
        a = self.a.execute(os.path.join(self.a_dir, '7b' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7b' + self.suffix))
        self.assertEqual(a, b)

    def test_tuple_truncation(self):
        a = self.a.execute(os.path.join(self.a_dir, '7c' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7c' + self.suffix))
        self.assertEqual(a, b)

    def test_subtract_dates(self):
        a = self.a.execute(os.path.join(self.a_dir, '7d' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7d' + self.suffix))
        self.assertEqual(a, b)

    def test_basic_groupby(self):
        a = self.a.execute(os.path.join(self.a_dir, '7e' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7e' + self.suffix))
        self.assertEqual(a, b)

    def test_filter_aggregate_tuples_with_having(self):
        a = self.a.execute(os.path.join(self.a_dir, '7f' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7f' + self.suffix))
        self.assertEqual(a, b)

    def test_yearly_averages(self):
        a = self.a.execute(os.path.join(self.a_dir, '7g' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7g' + self.suffix))
        self.assertEqual(a, b)

    def test_averages_by_day_and_country(self):
        a = self.a.execute(os.path.join(self.a_dir, '7h' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '7h' + self.suffix))
        self.assertEqual(a, b)

    def test_subquery_as_a_filter(self):
        a = self.a.execute(os.path.join(self.a_dir, '8a' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '8a' + self.suffix))
        self.assertEqual(a, b)

    def test_subquery_as_a_new_element(self):
        a = self.a.execute(os.path.join(self.a_dir, '8b' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '8b' + self.suffix))
        self.assertEqual(a, b)

    def test_subquery_with_nested_where_clauses(self):
        a = self.a.execute(os.path.join(self.a_dir, '8c' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '8c' + self.suffix))
        self.assertEqual(a, b)

    def test_subquery_with_nested_where_clauses_and_with_in(self):
        a = self.a.execute(os.path.join(self.a_dir, '8d' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '8d' + self.suffix))
        self.assertEqual(a, b)

    def test_subquery_select_distinct(self):
        a = self.a.execute(os.path.join(self.a_dir, '8e' + self.suffix))
        b = self.b.execute(os.path.join(self.b_dir, '8e' + self.suffix))
        self.assertEqual(a, b)


if __name__ == '__main__':
    unittest.main()
