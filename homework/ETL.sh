
echo "step1 mapreduce etl"
process_date=20180717

hadoop jar /home/hadoop/lib/hadoop_etl-1.0.jar com.lesson.day1.driver.LogDriver /g6/hadoop/accesslog/$process_date /g6/hadoop/access/output/day=$process_date


echo "step2 move data to warehouse"
hadoop fs -mkdir -p /g6/hadoop/access/clear/day=$process_date
hadoop fs -rm /g6/hadoop/access/output/day=$process_date/_SUCCESS
hadoop fs -mv /g6/hadoop/access/output/day=$process_date/* /g6/hadoop/access/clear/day=$process_date/



echo "create table and flush data"
hive -f /home/hadoop/shell/ETL/ETL.sql

