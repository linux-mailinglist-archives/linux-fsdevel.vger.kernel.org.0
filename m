Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0F9304C2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbhAZWcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:32:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:27471 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbhAZFgK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:36:10 -0500
IronPort-SDR: oOQ/Uea3jR9yABxNkFk6jV1gl9LlQ6gIPTVqyfGlYKPgNO4x2MDVA7mw+cpIXoSy1K8zuI692V
 9RY5chHEBG+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177283203"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="xz'?yaml'?scan'208";a="177283203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:35:19 -0800
IronPort-SDR: nuKixCIWIeNPgr9KroeXUcZhKb6iYM5CHrxzQHBPyYBjnZf8DCG5q+d7JeGjXhT95tVtC0JkI9
 zBlL7HvdkSbA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="xz'?yaml'?scan'208";a="387690790"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:35:15 -0800
Date:   Tue, 26 Jan 2021 13:51:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ltp@lists.linux.it,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [binfmt_elf]  d97e11e25d: ltp.DS000.fail
Message-ID: <20210126055112.GA19582@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20210106075112.1593084-1-geert@linux-m68k.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: d97e11e25dd226c44257284f95494bb06d1ebf5a ("[PATCH v2] binfmt_elf: F=
ix fill_prstatus() call in fill_note_info()")
url: https://github.com/0day-ci/linux/commits/Geert-Uytterhoeven/binfmt_elf=
-Fix-fill_prstatus-call-in-fill_note_info/20210106-155236
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e71ba=
9452f0b5b2e8dc8aa5445198cd9214a6a62

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20210101
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: ltp-aiodio.part4
	ucode: 0xde

test-description: The LTP testsuite contains a collection of tools for test=
ing the Linux kernel and related features.
test-url: http://linux-test-project.github.io/


on test machine: 8 threads Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

2021-01-25 08:38:20 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-01-25 08:38:20 ./runltp -f ltp-aiodio.part4 -d /fs/sdb1/tmpdir
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-kbl-d01 5.11.0-rc2-00001-gd97e11e25dd2 #4 SMP Wed Jan 6 18:09:47 =
CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-kbl-d01::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=3D0xde-debian-10.4-x=
86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-39067-=
1v5388x-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-revie=
w/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20=
210106-155236 commit=3Dd97e11e25dd226c44257284f95494bb06d1ebf5a BOOT_IMAGE=
=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5=
a/vmlinuz-5.11.0-rc2-00001-gd97e11e25dd2 max_uptime=3D2100 RESULT_ROOT=3D/r=
esult/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=3D0xde/lkp-kbl-d01/debian-10.4-x=
86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d=
1ebf5a/3 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3D=
debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sy=
stemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,11=
5200 console=3DttyS0,115200 vga=3Dnormal rw

Gnu C                  gcc (Debian 8.3.0-6) 8.3.0
Clang                =20
Gnu make               4.2.1
util-linux             2.33.1
mount                  linux 2.33.1 (libmount 2.33.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               26
e2fsprogs              1.44.5
Linux C Library        > libc.2.28
Dynamic linker (ldd)   2.28
Procps                 3.3.15
Net-tools              2.10-alpha
iproute2               iproute2-ss190107
iputils                iputils-s20180629
ethtool                4.19
Kbd                    119:
Sh-utils               8.30
Modules Loaded         dm_mod f2fs xfs libcrc32c sd_mod t10_pi sg ipmi_devi=
ntf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal i=
ntel_powerclamp coretemp kvm_intel i915 kvm intel_gtt irqbypass drm_kms_hel=
per crct10dif_pclmul crc32_pclmul crc32c_intel syscopyarea ghash_clmulni_in=
tel ahci sysfillrect dell_wmi rapl mei_wdt libahci sysimgblt dell_smbios fb=
_sys_fops intel_cstate dell_wmi_aio dell_wmi_descriptor sparse_keymap wmi_b=
mof i2c_designware_platform drm dcdbas libata i2c_designware_core idma64 me=
i_me intel_uncore wmi mei video pinctrl_sunrisepoint intel_pmc_core acpi_pa=
d ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32761580      371336    29897528       13808     2492716    2967=
3260
Swap:             0           0           0

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  2
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               158
Model name:          Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz
Stepping:            9
CPU MHz:             3600.000
CPU max MHz:         4200.0000
CPU min MHz:         800.0000
BogoMIPS:            7200.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            8192K
NUMA node0 CPU(s):   0-7
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vm=
x smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe=
 popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefe=
tch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi=
 flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 e=
rms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d

AppArmor enabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 4406     -n 4406 -=
p -f /fs/sdb1/tmpdir/ltp-3ndUcdcdaR/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_01_25-08h_38m_20s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_01_25-08h_38m_20s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_01_25-08h_38m_20s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_01_25-08h_38m_20s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_01_25-08h_3=
8m_20s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_01_25-08h_38=
m_20s.tconf
Running tests.......
<<<test_start>>>
tag=3DDI000 stime=3D1611563900
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS000 stime=3D1611563900
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x62,6c,2d,64
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI001 stime=3D1611563901
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3DDS001 stime=3D1611563901
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D10 cstime=3D22
<<<test_end>>>
<<<test_start>>>
tag=3DDI002 stime=3D1611563904
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS002 stime=3D1611563904
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x1a,1a,1a,1a
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI003 stime=3D1611563905
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS003 stime=3D1611563905
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D24
<<<test_end>>>
<<<test_start>>>
tag=3DDI004 stime=3D1611563908
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS004 stime=3D1611563908
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3DDI005 stime=3D1611563910
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS005 stime=3D1611563910
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffd1,ffffffc4,06,fffffffa
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D14
<<<test_end>>>
<<<test_start>>>
tag=3DDI006 stime=3D1611563912
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS006 stime=3D1611563912
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x18,ffffffab,ffffffe5,ffffffae
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI007 stime=3D1611563913
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS007 stime=3D1611563913
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x52,ffffffaf,78,fffffff6
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D2 cstime=3D14
<<<test_end>>>
<<<test_start>>>
tag=3DDI008 stime=3D1611563914
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS008 stime=3D1611563914
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x24,69,ffffffe1,4e
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI009 stime=3D1611563915
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS009 stime=3D1611563915
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x21,ffffffbc,ffffffc2,5c
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D2 cstime=3D15
<<<test_end>>>
<<<test_start>>>
tag=3DDIO00 stime=3D1611563917
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffde,ffffff95,ffffffb5,2c
non-zero read at offset 12288
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO01 stime=3D1611563918
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffff9c,ffffffd2,2a,ffffffdf
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO02 stime=3D1611563919
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3DDIO03 stime=3D1611563922
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x7f,55,69,67
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO04 stime=3D1611563923
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3DDIO05 stime=3D1611563926
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x7b,ffffff86,ffffffb8,ffffffd4
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO06 stime=3D1611563927
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x43,ffffffd4,ffffffd3,4f
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO07 stime=3D1611563928
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffd2,5a,ffffff9a,ffffffa0
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO08 stime=3D1611563930
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffed,ffffff81,7f,ffffffa4
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO09 stime=3D1611563931
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffd9,59,72,fffffff0
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D15
<<<test_end>>>
<<<test_start>>>
tag=3DAD000 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3DAD001 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD002 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD003 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD004 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD005 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD006 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD007 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD008 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD009 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI000 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI001 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3DADI002 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI003 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI004 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI005 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI006 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI007 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI008 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI009 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDIT000 stime=3D1611563932
cmdline=3D"dio_truncate"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDIT001 stime=3D1611563932
cmdline=3D"dio_truncate"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDIT002 stime=3D1611563932
cmdline=3D"dio_truncate"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR000 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR001 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file3"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR002 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file4"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR003 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file5"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200930-258-g35cb4055d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200930-258-g35cb4055d
       ###############################################################




To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Oliver Sang


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc2-00001-gd97e11e25dd2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='ltp'
	export testcase='ltp'
	export category='functional'
	export need_modules=true
	export need_memory='4G'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-kbl-d01/ltp-part4.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-kbl-d01'
	export tbox_group='lkp-kbl-d01'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='600e82e530c85c989b7d2513'
	export job_file='/lkp/jobs/scheduled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=0xde-debian-10.4-x86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-39067-1v5388x-5.yaml'
	export id='6b9096d1759d71ee81d8a2e32c0a69d68129c9b5'
	export queuer_version='/lkp-src'
	export model='Kaby Lake'
	export nr_node=1
	export nr_cpu=8
	export memory='32G'
	export nr_sdd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part1'
	export brand='Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_BLK_DEV_LOOP
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_VCAN=m
CONFIG_IPV6_VTI=m
CONFIG_MINIX_FS=m
CONFIG_F2FS_FS'
	export commit='d97e11e25dd226c44257284f95494bb06d1ebf5a'
	export ucode='0xde'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export enqueue_time='2021-01-25 16:35:49 +0800'
	export _id='600e82ed30c85c989b7d2517'
	export _rt='/result/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='405405a0ca9585e0c65a2e0fd5f4969266d5cd63'
	export base_commit='7c53f6b671f4aba70ff15e1b05148b10d58c2837'
	export branch='linux-review/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20210106-155236'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/3'
	export scheduler_version='/lkp/lkp/.src-20210122-145149'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=0xde-debian-10.4-x86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-39067-1v5388x-5.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20210106-155236
commit=d97e11e25dd226c44257284f95494bb06d1ebf5a
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/vmlinuz-5.11.0-rc2-00001-gd97e11e25dd2
max_uptime=2100
RESULT_ROOT=/result/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.11.0-rc3-wt-ath-g405405a0ca95'
	export repeat_to=8
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/vmlinuz-5.11.0-rc2-00001-gd97e11e25dd2'
	export dequeue_time='2021-01-25 16:43:22 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=0xde-debian-10.4-x86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-39067-1v5388x-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='ltp-aiodio.part4' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper ltp
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time ltp.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--LQksG6bCIzRHxTLp
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
usMCzLEQ915kBLHEZ/sCAAAAAARZWg==

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ltp
Content-Transfer-Encoding: quoted-printable

2021-01-25 08:38:20 ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
2021-01-25 08:38:20 ./runltp -f ltp-aiodio.part4 -d /fs/sdb1/tmpdir
INFO: creating /lkp/benchmarks/ltp/output directory
INFO: creating /lkp/benchmarks/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux 10 (buster)"
NAME=3D"Debian GNU/Linux"
VERSION_ID=3D"10"
VERSION=3D"10 (buster)"
VERSION_CODENAME=3Dbuster
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"

uname:
Linux lkp-kbl-d01 5.11.0-rc2-00001-gd97e11e25dd2 #4 SMP Wed Jan 6 18:09:47 =
CST 2021 x86_64 GNU/Linux

/proc/cmdline
ip=3D::::lkp-kbl-d01::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/lkp/jobs/sche=
duled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=3D0xde-debian-10.4-x=
86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-39067-=
1v5388x-5.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Dlinux-revie=
w/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20=
210106-155236 commit=3Dd97e11e25dd226c44257284f95494bb06d1ebf5a BOOT_IMAGE=
=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5=
a/vmlinuz-5.11.0-rc2-00001-gd97e11e25dd2 max_uptime=3D2100 RESULT_ROOT=3D/r=
esult/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=3D0xde/lkp-kbl-d01/debian-10.4-x=
86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d=
1ebf5a/3 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3D=
debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sy=
stemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,11=
5200 console=3DttyS0,115200 vga=3Dnormal rw

Gnu C                  gcc (Debian 8.3.0-6) 8.3.0
Clang                =20
Gnu make               4.2.1
util-linux             2.33.1
mount                  linux 2.33.1 (libmount 2.33.1: selinux, smack, btrfs=
, namespaces, assert, debug)
modutils               26
e2fsprogs              1.44.5
Linux C Library        > libc.2.28
Dynamic linker (ldd)   2.28
Procps                 3.3.15
Net-tools              2.10-alpha
iproute2               iproute2-ss190107
iputils                iputils-s20180629
ethtool                4.19
Kbd                    119:
Sh-utils               8.30
Modules Loaded         dm_mod f2fs xfs libcrc32c sd_mod t10_pi sg ipmi_devi=
ntf ipmi_msghandler intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal i=
ntel_powerclamp coretemp kvm_intel i915 kvm intel_gtt irqbypass drm_kms_hel=
per crct10dif_pclmul crc32_pclmul crc32c_intel syscopyarea ghash_clmulni_in=
tel ahci sysfillrect dell_wmi rapl mei_wdt libahci sysimgblt dell_smbios fb=
_sys_fops intel_cstate dell_wmi_aio dell_wmi_descriptor sparse_keymap wmi_b=
mof i2c_designware_platform drm dcdbas libata i2c_designware_core idma64 me=
i_me intel_uncore wmi mei video pinctrl_sunrisepoint intel_pmc_core acpi_pa=
d ip_tables

free reports:
              total        used        free      shared  buff/cache   avail=
able
Mem:       32761580      371336    29897528       13808     2492716    2967=
3260
Swap:             0           0           0

cpuinfo:
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
Address sizes:       39 bits physical, 48 bits virtual
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  2
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               158
Model name:          Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz
Stepping:            9
CPU MHz:             3600.000
CPU max MHz:         4200.0000
CPU min MHz:         800.0000
BogoMIPS:            7200.00
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            8192K
NUMA node0 CPU(s):   0-7
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xt=
opology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vm=
x smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe=
 popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefe=
tch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi=
 flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 e=
rms invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xge=
tbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp m=
d_clear flush_l1d

AppArmor enabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /lkp/benchmarks/ltp/bin/ltp-pan   -e -S   -a 4406     -n 4406 -=
p -f /fs/sdb1/tmpdir/ltp-3ndUcdcdaR/alltests -l /lkp/benchmarks/ltp/results=
/LTP_RUN_ON-2021_01_25-08h_38m_20s.log  -C /lkp/benchmarks/ltp/output/LTP_R=
UN_ON-2021_01_25-08h_38m_20s.failed -T /lkp/benchmarks/ltp/output/LTP_RUN_O=
N-2021_01_25-08h_38m_20s.tconf
LOG File: /lkp/benchmarks/ltp/results/LTP_RUN_ON-2021_01_25-08h_38m_20s.log
FAILED COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_01_25-08h_3=
8m_20s.failed
TCONF COMMAND File: /lkp/benchmarks/ltp/output/LTP_RUN_ON-2021_01_25-08h_38=
m_20s.tconf
Running tests.......
<<<test_start>>>
tag=3DDI000 stime=3D1611563900
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS000 stime=3D1611563900
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x62,6c,2d,64
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI001 stime=3D1611563901
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3DDS001 stime=3D1611563901
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D10 cstime=3D22
<<<test_end>>>
<<<test_start>>>
tag=3DDI002 stime=3D1611563904
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS002 stime=3D1611563904
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x1a,1a,1a,1a
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI003 stime=3D1611563905
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS003 stime=3D1611563905
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D8 cstime=3D24
<<<test_end>>>
<<<test_start>>>
tag=3DDI004 stime=3D1611563908
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS004 stime=3D1611563908
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3DDI005 stime=3D1611563910
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS005 stime=3D1611563910
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffd1,ffffffc4,06,fffffffa
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D14
<<<test_end>>>
<<<test_start>>>
tag=3DDI006 stime=3D1611563912
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS006 stime=3D1611563912
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x18,ffffffab,ffffffe5,ffffffae
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI007 stime=3D1611563913
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS007 stime=3D1611563913
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x52,ffffffaf,78,fffffff6
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D2 cstime=3D14
<<<test_end>>>
<<<test_start>>>
tag=3DDI008 stime=3D1611563914
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS008 stime=3D1611563914
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x24,69,ffffffe1,4e
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDI009 stime=3D1611563915
cmdline=3D"dirty"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
Starting dirty tests...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDS009 stime=3D1611563915
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x21,ffffffbc,ffffffc2,5c
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D2 cstime=3D15
<<<test_end>>>
<<<test_start>>>
tag=3DDIO00 stime=3D1611563917
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffde,ffffff95,ffffffb5,2c
non-zero read at offset 12288
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO01 stime=3D1611563918
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffff9c,ffffffd2,2a,ffffffdf
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO02 stime=3D1611563919
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D7 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3DDIO03 stime=3D1611563922
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x7f,55,69,67
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO04 stime=3D1611563923
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TPASS  :  Test passed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D3 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D9 cstime=3D23
<<<test_end>>>
<<<test_start>>>
tag=3DDIO05 stime=3D1611563926
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x7b,ffffff86,ffffffb8,ffffffd4
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO06 stime=3D1611563927
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0x43,ffffffd4,ffffffd3,4f
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO07 stime=3D1611563928
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffd2,5a,ffffff9a,ffffffa0
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D2 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO08 stime=3D1611563930
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffed,ffffff81,7f,ffffffa4
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D16
<<<test_end>>>
<<<test_start>>>
tag=3DDIO09 stime=3D1611563931
cmdline=3D"dio_sparse"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
non zero buffer at buf[0] =3D> 0xffffffd9,59,72,fffffff0
non-zero read at offset 4096
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Dirtying free blocks
dio_sparse    0  TINFO  :  Starting I/O tests
dio_sparse    0  TINFO  :  Killing childrens(s)
dio_sparse    1  TFAIL  :  dio_sparse.c:190: 1 children(s) exited abnormally
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D15
<<<test_end>>>
<<<test_start>>>
tag=3DAD000 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3DAD001 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD002 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD003 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD004 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD005 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD006 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD007 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD008 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D1 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DAD009 stime=3D1611563932
cmdline=3D"aiodio_append $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Starting aio/dio append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI000 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI001 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3DADI002 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI003 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI004 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI005 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI006 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI007 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI008 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DADI009 stime=3D1611563932
cmdline=3D"dio_append"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
Begin dio_append test...
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDIT000 stime=3D1611563932
cmdline=3D"dio_truncate"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDIT001 stime=3D1611563932
cmdline=3D"dio_truncate"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDIT002 stime=3D1611563932
cmdline=3D"dio_truncate"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
cannot create file: No such file or directory
cannot create file: Invalid argument
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR000 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file2"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR001 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file3"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR002 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file4"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3DDOR003 stime=3D1611563932
cmdline=3D"ltp-diorh $TMPDIR/aiodio.$$/file5"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
open: No such file or directory
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200930-258-g35cb4055d

       ###############################################################

            Done executing testcases.
            LTP Version:  20200930-258-g35cb4055d
       ###############################################################


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/ltp-part4.yaml
suite: ltp
testcase: ltp
category: functional
need_modules: true
need_memory: 4G
disk: 1HDD
fs: f2fs
ltp:
  test: ltp-aiodio.part4
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-kbl-d01/ltp-part4.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-kbl-d01
tbox_group: lkp-kbl-d01
kconfig: x86_64-rhel-8.3
submit_id: 600e80a130c85c96ec82c827
job_file: "/lkp/jobs/scheduled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=0xde-debian-10.4-x86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-38636-5699tn-0.yaml"
id: a3fba73e9054f4fbcc0121388f4cb7424ff56c19
queuer_version: "/lkp-src"

#! hosts/lkp-kbl-d01
model: Kaby Lake
nr_node: 1
nr_cpu: 8
memory: 32G
nr_sdd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part1"
brand: Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_BLK_DEV_LOOP
- CONFIG_CAN=m
- CONFIG_CAN_RAW=m
- CONFIG_CAN_VCAN=m
- CONFIG_IPV6_VTI=m
- CONFIG_MINIX_FS=m
- CONFIG_F2FS_FS

#! include/ltp

#! include/queue/cyclic
commit: d97e11e25dd226c44257284f95494bb06d1ebf5a

#! include/testbox/lkp-kbl-d01
ucode: '0xde'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI

#! include/fs/OTHERS
enqueue_time: 2021-01-25 16:26:10.034489054 +08:00
_id: 600e80a130c85c96ec82c827
_rt: "/result/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 405405a0ca9585e0c65a2e0fd5f4969266d5cd63
base_commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
branch: linux-devel/devel-hourly-2021011623
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/0"
scheduler_version: "/lkp/lkp/.src-20210122-145149"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-kbl-d01/ltp-1HDD-f2fs-ltp-aiodio.part4-ucode=0xde-debian-10.4-x86_64-20200603.cgz-d97e11e25dd226c44257284f95494bb06d1ebf5a-20210125-38636-5699tn-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2021011623
- commit=d97e11e25dd226c44257284f95494bb06d1ebf5a
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/vmlinuz-5.11.0-rc2-00001-gd97e11e25dd2
- max_uptime=2100
- RESULT_ROOT=/result/ltp/1HDD-f2fs-ltp-aiodio.part4-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/ltp_20210101.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/ltp-x86_64-14c1f76-1_20210101.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210122-145149/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0-rc4-01137-g42141aa1002b

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/d97e11e25dd226c44257284f95494bb06d1ebf5a/vmlinuz-5.11.0-rc2-00001-gd97e11e25dd2"
dequeue_time: 2021-01-25 16:32:41.813221102 +08:00
job_state: finished
loadavg: 1.46 0.45 0.16 2/241 4789
start_time: '1611563274'
end_time: '1611563300'
version: "/lkp/lkp/.src-20210122-145222:3688982a:ec0226840"

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sdb1
mkfs -t f2fs /dev/sdb1
mkdir -p /fs/sdb1
mount -t f2fs /dev/sdb1 /fs/sdb1
ln -sf /usr/bin/genisoimage /usr/bin/mkisofs
./runltp -f ltp-aiodio.part4 -d /fs/sdb1/tmpdir

--LQksG6bCIzRHxTLp--
