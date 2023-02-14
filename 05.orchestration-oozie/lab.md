# Big Data Ecosystem

## Lab: Oozie

### Goals

Chain the Hive actions done in [lab4](../lab4) using Oozie.

### Resources

The Oozie workflow is composed of:

- The `workflow.xml` that contains the DAG of actions to be run (you will have to complete this file)
- The `job.properties` file that contains the job properties, you will have to modify some of them
- The `scripts` folder that will contain our Hive scripts

### Useful links

- [Oozie documentation](https://oozie.apache.org/docs/4.3.1/)
- [Oozie Hive2 Action](https://oozie.apache.org/docs/4.3.1/DG_Hive2ActionExtension.html)

### How to run a workflow

**Tip:** To edit the workflow, the easiest setup is: 

- `git clone` the repo to your PC,

- Create/edit files using an IDE (e.g. VSCode)

- Push the updated workflow to the edge server (Windows users read [here](https://stackoverflow.com/questions/8975798/copying-a-local-file-from-windows-to-a-remote-server-using-scp)):

  ```bash
  clusterUsername=<your-hadoop-username>
  scp -r oozie_wf $clusterUsername@edge-1.au.adaltas.cloud:/home/$clusterUsername
  ```

- And put the workflow in HDFS:

  ```bash
  hdfs dfs -put -f oozie_wf/ /education/$GROUP/$USER
  ```

1. Adapt the `job.properties` to your username and group. Read other parameters and try to understand what they mean.

2. Put the workflow folder in HDFS (in your user directory for example)

   ```bash
   hdfs dfs -put -f oozie_wf/ /education/$GROUP/$USER
   ```

3. Submit the job using the `oozie` CLI and make sure there are no errors:

   ```bash
   oozie job -run -config oozie_wf/job.properties -oozie http://oozie-1.au.adaltas.cloud:11000/oozie
   ```

4. Get the status of the job from the `oozie` CLI:

   ```sh
   oozie job -info 0000040-201011090406050-oozie-oozi-W -oozie http://oozie-1.au.adaltas.cloud:11000/oozie
   ...
   Actions
   ------------------------------------------------------------------------------------------------------------------------------------
   ID                                                                            Status    Ext ID                 Ext Status Err Code
   ------------------------------------------------------------------------------------------------------------------------------------
   0000003-210916172301405-oozie-oozi-W@:start:                                  OK        -                      OK         -
   ------------------------------------------------------------------------------------------------------------------------------------
   0000003-210916172301405-oozie-oozi-W@create-csv-table                         OK        job_1631812995637_0402 SUCCEEDED  -
   ```

5. Get the logs of one action from the `yarn` CLI:
   - Get the job ID from the oozie command of step 3. (e.g. `job_1631812995637_0402`)
   - Replace `job` by `application` (e.g. `application_1631812995637_0402`)
   -  Use `yarn logs` to get the logs from `stderr`:

      ```sh
      yarn logs -applicationId application_1631812995637_0402 -log_files 'stderr'
      Container: container_e54_1631812995637_0402_01_000002 on wrk-1.au.adaltas.cloud_45454_1634646632767
      LogAggregationType: AGGREGATED
      ===================================================================================================
      LogType:stderr
      LogLastModifiedTime:Tue Oct 19 12:30:32 +0000 2021
      LogLength:3279
      LogContents:
      SLF4J: Class path contains multiple SLF4J bindings.
      ...
      ```
      
6. Add actions to the workflow (edit on your computer and transfer the files as before):
   - Create the ORC drivers table
   - Insert data from the CSV table to the ORC table

7. Run the new workflow.

8. Check in Hive if the tables were created (with `beeline`).


