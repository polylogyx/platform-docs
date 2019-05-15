Using Recon Data
=================

As the name suggests, recon refers to preliminary research or analysis. After
the PolyLogyx client is provisioned and the connection to the PolyLogyx server
is established, seeded recon queries are run to pull relevant information for
each node. 

Understanding reported data
---------------------------

For each configured node, these pre-populated queries fetch detailed data. The
fetched data provides insight and visibility on these aspects.

| Parameter                       | Description |                                                                                                                                                                                                                                                                                          |
|----------------------|-----------------------|
| Application compatibility shims | Application compatibility shims enable you to fake aspects of the environment for a given application and allow fixing of issues that an application might encounter on a new version of Windows. Malwares leverage shim data bases (SDBs) as a persistence mechanism. Lists the SDBs on your system. |
| Application hashes              | Lists the hash information for applications on your system.                                                                                                                                                                                                                                        |
| Certificates                    | Digital certificates are used to establish the identity and trust level of software programs. Lists the various digital certificates installed on your system.                                                                                                                                        |
| Chrome extensions               | Lists the Chrome extensions installed on your system.                                                                                                                                                                                                                                                 |
| Drivers                         | Lists the various device drivers installed on your system.                                                                                                                                                                                                                                             |
| etc hosts                       | The hosts file is used by an operating system to resolve a computer (or an internet domain) to an address. Lists the entries in the hosts file of your system.                                                                                                                                        |
| Internet Explorer extensions    | Lists the Internet Explorer extensions installed on your system.                                                                                                                                                                                                                                       |
| Kernel info                     | Lists the kernel details for your system.                                                                                                                                                                                                                                                              |
| Kva speculative info            | Provides the presence (or absence) of mitigations for Spectre and Meltdown vulnerabilities.                                                                                                                                                                                                            |
| Patches                         | Lists the updates or patches installed on your system.                                                                                                                                                                                                                                                 |
| Scheduled tasks                 | scheduled_tasks (or cron jobs) are programs run by the task scheduler component of an operating system to run specified jobs at regular intervals. Malware can sometimes abuse this feature of an operating system. Provides the various scheduled tasks configured on your system.                   |
| Startup items                   | Lists applications are automatically started with the launch of your system. Malwares can install themselves as a start_up item on a system to gain persistence.                                                                                                                                       |
| Time                            | Provides the system time stamp in Unix and UTC formats. The timestamp represents the time at which the agent starts after installation or reboot.                                                                                                                                                     |
| Windows epp table               | Lists the status of the Anti-Virus solutions on your system.                                                                                                                                                                                                                                          |
| Windows programs                | Lists the Windows programs installed or running on your system.                                                                                                                                                                                                                                       |
| Windows services                | A Windows service, or a daemon on Unix, is a program that operates in the background and is often loaded automatically on start-up. Lists the services running on your system.                                                                                                                        |

Accessing data
--------------

To access or view the fetched data, use the getextendednode info API. Here is
the syntax to invoke the API.

```<server address:port\>/servces/api/v0/nodes/TBA```

Here is sample of the API response. Note that data is reported for each of the
parameters listed in this [table](#Table_list_recon).

```{
    "data": {
        "enrolled_on": "2018-09-11 20:36:01",
        "host_identifier": "A5B128CC-2A08-11B2-A85C-CFFDFBDACCA7",
        "last_checkin": "2018-09-18 20:02:06",
        "network_info": {
            "mac_address": "8c:16:45:a3:9f:61"
        },
        "node_info": {
            "computer_name": "janedoe-laptop",
            "cpu_physical_cores": "4",
            "hardware_model": "20KG0022US",
            "hardware_serial": "PF19A9DK",
            "hardware_vendor": "LENOVO",
            "physical_memory": "17026711552"
        },
        "node_key": "5c4a23e6-bfee-4445-ac98-5d2484d64fcb",
        "system_data": [
            {
                "data": [
                    {
                        "description": "Create and edit presentations ",
                        "identifier": "aapocclcgogkmnckokdopfmhonfmgoek",
                        "path": "C:\\Users\\JaneDoe\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\Extensions\\aaposwadwrtgogkmnthdopfmhonfwemgoe\\0.10_0\\",
                        "version": "0.10"
                    }

                       ],
                "name": "chrome_extensions",
                "updated_at": "2018-09-18 20:01:35"
            },
            {
                "data": [
                    {
                        "name": "DEL_ST_CPL",
                        "path": "CMD",
                        "status": "enabled"
                    }

                ],
                "name": "startup_items",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "name": "Notepad++ (64-bit x64)",
                        "version": "7.5.8"
                    }
                ],
                "name": "win_programs",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "hidden": "1",
                        "last_run_message": "The operation completed successfully.",
                        "next_run_time": "1537302250",
                        "path": "\\GoogleUpdateTaskMachineCore"
                    }
                ],
                "name": "scheduled_tasks",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "module_path": "",
                        "path": "C:\\WINDOWS\\System32\\DriverStore\\FileRepository\\sgx_psw.inf_amd64_67efe445e1ece117\\aesm_service.exe",
                        "sha1": "f447c55f91a941d866ff5cb6227a64d2b0015b1e"
                    }

                ],
                "name": "win_services",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "bp_microcode_disabled": "0",
                        "bp_mitigations": "1",
                        "bp_system_pol_disabled": "",
                        "cpu_pred_cmd_supported": "1",
                        "cpu_spec_ctrl_supported": "1",
                        "ibrs_support_enabled": "1",
                        "kva_shadow_enabled": "1",
                        "kva_shadow_inv_pcid": "1",
                        "kva_shadow_pcid": "1",
                        "kva_shadow_user_global": "0",
                        "stibp_support_enabled": "1"
                    }
                ],
                "name": "kva_speculative_info",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "product_name": "Windows Defender Antivirus",
                        "product_signatures": "Up-to-date",
                        "product_state": "On",
                        "product_type": "Anti-Virus"

                    }
                ],
                "name": "win_epp_table",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "arguments": " NOEXECUTE=OPTIN  FVEBOOT=2125824  NOVGA",
                        "path": "C:\\WINDOWS\\System32\\ntoskrnl.exe",
                        "version": "10.0.17134.285"
                    }
                ],
                "name": "kernel_info",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "image": "C:\\WINDOWS\\system32\\drivers\\wudfrd.sys",
                        "provider": "Lenovo",
                        "sha1": "ccc9bd5f9e4d88ccac5881a62639bfde898502cc",
                        "signed": "1"
                    }
                ],
                "name": "drivers",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [],
                "name": "etc_hosts",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [],
                "name": "appcompat_shims",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "common_name": "Microsoft Root Certificate Authority",
                        "issuer": "com, microsoft, Microsoft Root Certificate Authority",
                        "not_valid_after": "1620602893",
                        "path": "CurrentUser\\Trusted Root Certification Authorities",
                        "self_signed": "1"
                    }
                ],
                "name": "certificates",
                "updated_at": "2018-09-18 20:01:35"
            },
            {
                "data": [
                    {
                        "timestamp": "Tue Sep 18 19:59:54 2018 UTC",
                        "unix_time": "1537300794"
                    }
                ],
                "name": "time",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "directory": "c:\\windows\\system32\\WindowsPowerShell\\v1.0",
                        "path": "c:\\windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe",
                        "sha1": "1b3b40fbc889fd4c645cc12c85d0805ac36ba254"
   	            }
                ],
                "name": "app_hashes",
                "updated_at": "2018-09-18 20:01:34"
            },
            {
                "data": [
                    {
                        "description": "Update",
                        "hotfix_id": "KB4230204",
                        "installed_on": "7/14/2018"
  		     }
              	      ],
                "name": "patches",
                "updated_at": "2018-09-18 20:01:35"
            },
            {
                "data": [
{
                        "name": "Microsoft Url Search Hook",
                        "path": "C:\\Windows\\System32\\ieframe.dll",
                        "sha1": "fde1cbd1e1009833285a479b6d88d69bcdd7f266",
                        "version": "11.0.17134.254"
                    }
                ],
                "name": "ie_extensions",
                "updated_at": "2018-09-18 20:01:35"
            }
        ],
        "tags": []
    },
    "message": "Successfully fetched the node info",
    "status": "success"
}
 ``` 
