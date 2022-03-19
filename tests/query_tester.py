import os
import unittest

from connectors.duck import DuckDBConnector
from connectors.rai import RaiConnector
from connectors.snow import SnowflakeConnector
from connectors.sqlite import SQLiteConnector


class SqlTester(unittest.TestCase):

    def setUp(self):
        self.duckdb = DuckDBConnector('data/chinook/duckdb/chinook.db')
        self.sqlite = SQLiteConnector('data/chinook/sqlite/chinook.db')
        self.snowflake = SnowflakeConnector()

        self.duckdb_directory = 'queries/chinook/sql/duckdb'
        self.sqlite_directory = 'queries/chinook/sql/sqlite'
        self.snowflake_directory = 'queries/chinook/sql/snowflake'

        self.a = self.sqlite
        self.a_dir = self.sqlite_directory
        self.b = self.snowflake
        self.b_dir = self.snowflake_directory

    def test_select_nary_tuples(self):
        a = self.a.execute(os.path.join(self.a_dir, '4a.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '4a.sql'))
        self.assertEqual(a, b)

    def test_select_binary_tuples(self):
        a = self.a.execute(os.path.join(self.a_dir, '4b.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '4b.sql'))
        self.assertEqual(a, b)

    def test_select_new_relation(self):
        a = self.a.execute(os.path.join(self.a_dir, '5a.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '5a.sql'))
        self.assertEqual(a, b)

    def test_filter_with_sql_like(self):
        a = self.a.execute(os.path.join(self.a_dir, '5b.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '5b.sql'))
        self.assertEqual(a, b)

    def test_select_dates_between(self):
        a = self.a.execute(os.path.join(self.a_dir, '5c.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '5c.sql'))
        self.assertEqual(a, b)

    def test_select_specific_date(self):
        a = self.a.execute(os.path.join(self.a_dir, '5d.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '5d.sql'))
        self.assertEqual(a, b)

    def test_tuple_element_by_case(self):
        a = self.a.execute(os.path.join(self.a_dir, '5e.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '5e.sql'))
        self.assertEqual(a, b)

    def test_inner_join_a(self):
        a = self.a.execute(os.path.join(self.a_dir, '6a.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '6a.sql'))
        self.assertEqual(a, b)

    def test_inner_join_b(self):
        a = self.a.execute(os.path.join(self.a_dir, '6b.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '6b.sql'))
        self.assertEqual(a, b)

    def test_left_join(self):
        a = self.a.execute(os.path.join(self.a_dir, '6c.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '6c.sql'))
        self.assertEqual(a, b)

    def test_select_tuples_with_null(self):
        a = self.a.execute(os.path.join(self.a_dir, '6d.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '6d.sql'))
        self.assertEqual(a, b)

    def test_multiple_join(self):
        a = self.a.execute(os.path.join(self.a_dir, '6e.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '6e.sql'))
        self.assertEqual(a, b)

    def test_basic_aggregations(self):
        a = self.a.execute(os.path.join(self.a_dir, '7a.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7a.sql'))
        self.assertEqual(a, b)

    def test_tuple_concatenation(self):
        a = self.a.execute(os.path.join(self.a_dir, '7b.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7b.sql'))
        self.assertEqual(a, b)

    def test_tuple_truncation(self):
        a = self.a.execute(os.path.join(self.a_dir, '7c.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7c.sql'))
        self.assertEqual(a, b)

    def test_subtract_dates(self):
        a = self.a.execute(os.path.join(self.a_dir, '7d.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7d.sql'))
        self.assertEqual(a, b)

    def test_basic_groupby(self):
        a = self.a.execute(os.path.join(self.a_dir, '7e.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7e.sql'))
        self.assertEqual(a, b)

    def test_filter_aggregate_tuples_with_having(self):
        a = self.a.execute(os.path.join(self.a_dir, '7f.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7f.sql'))
        self.assertEqual(a, b)

    def test_yearly_averages(self):
        a = self.a.execute(os.path.join(self.a_dir, '7g.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7g.sql'))
        self.assertEqual(a, b)

    def test_averages_by_day_and_country(self):
        a = self.a.execute(os.path.join(self.a_dir, '7h.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '7h.sql'))
        self.assertEqual(a, b)

    def test_subquery_as_a_filter(self):
        a = self.a.execute(os.path.join(self.a_dir, '8a.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '8a.sql'))
        self.assertEqual(a, b)

    def test_subquery_as_a_new_element(self):
        a = self.a.execute(os.path.join(self.a_dir, '8b.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '8b.sql'))
        self.assertEqual(a, b)

    def test_subquery_with_nested_where_clauses(self):
        a = self.a.execute(os.path.join(self.a_dir, '8c.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '8c.sql'))
        self.assertEqual(a, b)

    def test_subquery_with_nested_where_clauses_and_with_in(self):
        a = self.a.execute(os.path.join(self.a_dir, '8d.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '8d.sql'))
        self.assertEqual(a, b)

    def test_subquery_select_distinct(self):
        a = self.a.execute(os.path.join(self.a_dir, '8e.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '8e.sql'))
        self.assertEqual(a, b)

    def test_with_clause(self):
        a = self.a.execute(os.path.join(self.a_dir, '9a.sql'))
        b = self.b.execute(os.path.join(self.b_dir, '9a.sql'))
        self.assertEqual(a, b)


class RelTester(unittest.TestCase):

    def setUp(self):
        self.rai = RaiConnector()
        self.snowflake = SnowflakeConnector()

        self.rai_directory = 'queries/chinook/rel'
        self.snowflake_directory = 'queries/chinook/sql/snowflake'

        self.a = self.rai
        self.a_dir = self.rai_directory
        self.b = self.snowflake
        self.b_dir = self.snowflake_directory

    def test_select_nary_tuples(self):
        a = self.a.execute(os.path.join(self.a_dir, '4a.rel'))
        b = self.b.execute(os.path.join(self.b_dir, '4a.sql'))
        self.assertEqual(a, b)

    def test_select_binary_tuples(self):
        a = self.a.execute(os.path.join(self.a_dir, '4b.rel'))
        b = self.b.execute(os.path.join(self.b_dir, '4b.sql'))
        self.assertEqual(a, b)

    def test_select_new_relation(self):
        a = self.a.execute(os.path.join(self.a_dir, '5a.rel'))
        b = self.b.execute(os.path.join(self.b_dir, '5a.sql'))
        self.assertEqual(a, b)

    def test_filter_with_sql_like(self):
        a = self.a.execute(os.path.join(self.a_dir, '5b.rel'))
        b = self.b.execute(os.path.join(self.b_dir, '5b.sql'))
        self.assertEqual(a, b)


if __name__ == '__main__':
    unittest.main()
