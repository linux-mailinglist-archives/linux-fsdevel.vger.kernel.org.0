Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF46378B60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhEJMGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 08:06:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2617 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbhEJMEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 08:04:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ff05B6SGdzmVF5;
        Mon, 10 May 2021 20:01:18 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Mon, 10 May 2021
 20:03:21 +0800
Subject: Re: [fs] aec499039e: unixbench.score 19.2% improvement
To:     kernel test robot <oliver.sang@intel.com>
CC:     0day robot <lkp@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@intel.com>, <linux-fsdevel@vger.kernel.org>,
        Yuqi Jin <jinyuqi@huawei.com>
References: <20210420061014.GC31773@xsang-OptiPlex-9020>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <ee1535e9-0a74-a6b5-416c-e04dc691db0c@hisilicon.com>
Date:   Mon, 10 May 2021 20:03:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420061014.GC31773@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi maintainers,

A gentle ping.

Thanks,
Shaokun

On 2021/4/20 14:10, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a 19.2% improvement of unixbench.score due to commit:
> 
> 
> commit: aec499039e7b21224ef29e5a2daba328aec14442 ("[PATCH] fs: Optimized file struct to improve performance")
> url: https://github.com/0day-ci/linux/commits/Shaokun-Zhang/fs-Optimized-file-struct-to-improve-performance/20210409-114859
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 5e46d1b78a03d52306f21f77a4e4a144b6d31486
> 
> in testcase: unixbench
> on test machine: 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 30%
> 	test: syscall
> 	cpufreq_governor: performance
> 	ucode: 0x4003006
> 
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
> 
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2sp4/syscall/unixbench/0x4003006
> 
> commit: 
>   5e46d1b78a ("reiserfs: update reiserfs_xattrs_initialized() condition")
>   aec499039e ("fs: Optimized file struct to improve performance")
> 
> 5e46d1b78a03d523 aec499039e7b21224ef29e5a2da 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       2768           +19.2%       3298        unixbench.score
>     176.43           +19.8%     211.43        unixbench.time.user_time
>  1.622e+09           +19.2%  1.933e+09        unixbench.workload
>     348.17 ± 48%     -25.2%     260.57 ± 68%  proc-vmstat.nr_mlock
>    4081405 ±133%     -99.2%      33639 ± 15%  turbostat.C1
>  1.348e+10 ± 89%     -76.6%  3.151e+09 ±190%  cpuidle.C6.time
>    1360129 ±137%     -86.4%     184629 ±  2%  cpuidle.POLL.time
>       1.00 ± 10%      -0.2        0.81 ±  3%  mpstat.cpu.all.irq%
>       0.49            +0.1        0.59        mpstat.cpu.all.usr%
>       0.01 ± 23%     -36.4%       0.00 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>       0.06 ± 43%     -48.4%       0.03 ± 42%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.05 ± 49%     -55.1%       0.02 ± 47%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>     765.20 ± 20%     -34.3%     502.83 ± 29%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
>       1930 ± 13%     -31.8%       1316 ± 30%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
>     765.19 ± 20%     -34.3%     502.82 ± 29%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
>       1930 ± 13%     -31.8%       1316 ± 30%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.wait_for_completion_io.blk_execute_rq
>       2787 ±215%    -100.0%       0.71 ±162%  interrupts.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
>     385.17 ±128%     -99.9%       0.29 ±158%  interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
>       4052 ± 49%     -57.3%       1732 ±102%  interrupts.CPU27.NMI:Non-maskable_interrupts
>       4052 ± 49%     -57.3%       1732 ±102%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
>     438.67 ±122%    +697.3%       3497 ± 37%  interrupts.CPU3.NMI:Non-maskable_interrupts
>     438.67 ±122%    +697.3%       3497 ± 37%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
>     289.00 ± 84%   +1542.3%       4746 ± 24%  interrupts.CPU51.NMI:Non-maskable_interrupts
>     289.00 ± 84%   +1542.3%       4746 ± 24%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
>     135.17 ± 18%     -29.9%      94.71 ± 26%  interrupts.CPU59.RES:Rescheduling_interrupts
>       4872 ± 27%     -48.9%       2490 ± 90%  interrupts.CPU74.NMI:Non-maskable_interrupts
>       4872 ± 27%     -48.9%       2490 ± 90%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
>       2786 ±215%    -100.0%       0.43 ±169%  interrupts.CPU88.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
>      13.38 ±  7%     -13.4        0.00        perf-profile.calltrace.cycles-pp.dnotify_flush.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      30.66 ±  9%      -6.4       24.27 ± 10%  perf-profile.calltrace.cycles-pp.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      30.82 ±  9%      -6.4       24.46 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       7.10 ±  8%      -1.3        5.85 ± 11%  perf-profile.calltrace.cycles-pp.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       7.14 ±  8%      -1.2        5.89 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       7.18 ±  8%      -1.2        5.93 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
>       7.15 ±  8%      -1.2        5.91 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
>       7.27 ±  8%      -1.2        6.04 ± 11%  perf-profile.calltrace.cycles-pp.__close
>       5.29 ±  8%      +5.4       10.68 ± 10%  perf-profile.calltrace.cycles-pp.fput_many.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      13.39 ±  7%     -13.3        0.07 ± 12%  perf-profile.children.cycles-pp.dnotify_flush
>      37.79 ±  8%      -7.6       30.16 ± 10%  perf-profile.children.cycles-pp.filp_close
>      37.97 ±  8%      -7.6       30.36 ± 10%  perf-profile.children.cycles-pp.__x64_sys_close
>       7.30 ±  8%      -1.2        6.07 ± 11%  perf-profile.children.cycles-pp.__close
>       0.70 ± 10%      -0.1        0.56 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.71 ± 11%      -0.1        0.57 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.39 ± 16%      -0.1        0.29 ±  9%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.27 ± 13%      -0.1        0.22 ± 10%  perf-profile.children.cycles-pp.tick_sched_timer
>       5.29 ±  8%      +5.4       10.69 ± 10%  perf-profile.children.cycles-pp.fput_many
>      13.33 ±  7%     -13.3        0.06 ± 11%  perf-profile.self.cycles-pp.dnotify_flush
>       5.27 ±  8%      +5.4       10.64 ± 10%  perf-profile.self.cycles-pp.fput_many
>      17.97 ± 46%     -58.2%       7.51 ± 16%  perf-stat.i.MPKI
>  1.073e+09           +16.2%  1.247e+09        perf-stat.i.branch-instructions
>       2.60 ± 34%      -1.0        1.62 ±  2%  perf-stat.i.branch-miss-rate%
>   56435130 ± 26%     -31.6%   38588360 ± 21%  perf-stat.i.cache-references
>      12.06 ±  3%     -15.8%      10.16        perf-stat.i.cpi
>       0.10 ±100%      -0.1        0.02 ±202%  perf-stat.i.dTLB-load-miss-rate%
>  1.682e+09           +16.9%  1.965e+09        perf-stat.i.dTLB-loads
>       0.03 ± 93%      -0.0        0.01 ±142%  perf-stat.i.dTLB-store-miss-rate%
>   1.11e+09           +17.5%  1.304e+09        perf-stat.i.dTLB-stores
>  5.314e+09           +16.2%  6.176e+09        perf-stat.i.instructions
>       0.10 ± 11%     +18.1%       0.12 ±  2%  perf-stat.i.ipc
>      40.93           +16.1%      47.51        perf-stat.i.metric.M/sec
>      89.63 ±  2%      +6.5       96.16        perf-stat.i.node-load-miss-rate%
>    3653512 ±  3%     -57.3%    1561506        perf-stat.i.node-load-misses
>     371566 ± 19%     -90.8%      34031 ±  8%  perf-stat.i.node-loads
>      10.59 ± 25%     -40.8%       6.27 ± 23%  perf-stat.overall.MPKI
>       1.92 ±  8%      -0.3        1.61        perf-stat.overall.branch-miss-rate%
>      13.04           -14.2%      11.19        perf-stat.overall.cpi
>       0.02 ± 89%      -0.0        0.00 ±148%  perf-stat.overall.dTLB-load-miss-rate%
>       0.00 ± 72%      -0.0        0.00 ± 69%  perf-stat.overall.dTLB-store-miss-rate%
>     318.50           +13.2%     360.58        perf-stat.overall.instructions-per-iTLB-miss
>       0.08           +16.6%       0.09        perf-stat.overall.ipc
>      90.76 ±  2%      +7.1       97.87        perf-stat.overall.node-load-miss-rate%
>       1286            -2.7%       1251        perf-stat.overall.path-length
>  1.072e+09           +16.2%  1.246e+09        perf-stat.ps.branch-instructions
>   1.68e+09           +16.9%  1.964e+09        perf-stat.ps.dTLB-loads
>  1.109e+09           +17.6%  1.303e+09        perf-stat.ps.dTLB-stores
>  5.307e+09           +16.3%  6.171e+09        perf-stat.ps.instructions
>    3649615 ±  3%     -57.2%    1560409        perf-stat.ps.node-load-misses
>     371135 ± 19%     -90.9%      33946 ±  8%  perf-stat.ps.node-loads
>  2.086e+12           +16.0%  2.419e+12        perf-stat.total.instructions
>      10629 ± 12%     -17.7%       8746 ±  8%  softirqs.CPU10.RCU
>       9891 ±  7%     -14.6%       8447 ±  9%  softirqs.CPU13.RCU
>      43153 ±  3%      -7.4%      39975 ±  4%  softirqs.CPU30.SCHED
>       9938 ±  6%     -12.9%       8660 ±  2%  softirqs.CPU33.RCU
>       9900 ±  9%     -14.1%       8500 ±  5%  softirqs.CPU38.RCU
>       9730 ±  6%     -10.3%       8731 ±  7%  softirqs.CPU40.RCU
>      10238 ±  8%     -15.0%       8703 ±  9%  softirqs.CPU44.RCU
>      10045 ± 10%     -15.7%       8471 ±  6%  softirqs.CPU45.RCU
>      10074 ±  7%     -15.4%       8524 ±  6%  softirqs.CPU46.RCU
>       9793 ±  6%     -12.0%       8617 ±  8%  softirqs.CPU49.RCU
>      10809 ± 18%     -19.0%       8750 ±  8%  softirqs.CPU50.RCU
>      10484 ±  7%     -13.3%       9088 ± 10%  softirqs.CPU53.RCU
>      10059 ±  7%     -13.2%       8732 ±  7%  softirqs.CPU54.RCU
>      10298 ±  4%     -13.5%       8912 ±  7%  softirqs.CPU55.RCU
>       9932 ±  8%     -12.4%       8699 ±  5%  softirqs.CPU60.RCU
>      10268 ±  9%     -17.1%       8514 ±  7%  softirqs.CPU61.RCU
>       9895 ±  5%      -9.0%       9008 ±  5%  softirqs.CPU67.RCU
>      10294 ±  8%     -12.0%       9060 ±  5%  softirqs.CPU68.RCU
>      11048 ± 14%     -17.2%       9152 ±  6%  softirqs.CPU69.RCU
>       9586 ±  7%      -9.1%       8715 ±  5%  softirqs.CPU74.RCU
>       9555 ±  7%     -10.1%       8587 ±  5%  softirqs.CPU76.RCU
>       9892 ± 10%     -14.8%       8425 ±  5%  softirqs.CPU80.RCU
>       9722 ±  6%     -13.5%       8407 ±  6%  softirqs.CPU82.RCU
>       9883 ±  6%     -12.7%       8624 ±  4%  softirqs.CPU83.RCU
>       9507 ±  5%      -9.9%       8567 ±  4%  softirqs.CPU84.RCU
>       9878 ±  8%     -14.1%       8485 ±  3%  softirqs.CPU85.RCU
>      37959 ±  4%     -12.9%      33055 ±  6%  softirqs.CPU85.SCHED
>      10338 ± 12%     -16.6%       8623 ±  4%  softirqs.CPU86.RCU
>       9885 ±  8%     -14.8%       8423 ±  4%  softirqs.CPU87.RCU
>       9934 ±  7%     -12.9%       8649 ±  5%  softirqs.CPU88.RCU
>      10119 ±  8%     -16.0%       8502 ±  5%  softirqs.CPU89.RCU
>       9958 ±  7%     -13.5%       8612 ±  4%  softirqs.CPU92.RCU
>       9917 ±  8%     -14.3%       8498 ±  5%  softirqs.CPU93.RCU
>      10070 ±  8%     -14.3%       8625 ±  6%  softirqs.CPU94.RCU
>      10157 ± 11%     -11.7%       8967 ±  7%  softirqs.CPU95.RCU
>      19377 ± 60%     -69.7%       5871 ± 82%  softirqs.NET_RX
>     944995 ±  4%     -10.5%     845954 ±  6%  softirqs.RCU
> 
> 
>                                                                                 
>                                   unixbench.score                               
>                                                                                 
>   3400 +--------------------------------------------------------------------+   
>   3300 |-+O  O      O    OO OO     OO OO                                    |   
>        |O     O OO O            O         O                                 |   
>   3200 |-+ O          O       O          O                                  |   
>   3100 |-+                                                                  |   
>        |                                                                    |   
>   3000 |-+                                                                  |   
>   2900 |-+                                                                  |   
>   2800 |-+                                                          .+  ++. |   
>        |                               +.     .++  +.+++.++.++.++.++  :+   +|   
>   2700 |+.++.     .+   +.     +.+ .++.+  + .++   + :                  +     |   
>   2600 |-+   ++  +  :.+  +  ++   +        +       +                         |   
>        |       + :  +     :+                                                |   
>   2500 |-+      +         +                                                 |   
>   2400 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                   unixbench.workload                            
>                                                                                 
>     2e+09 +-----------------------------------------------------------------+   
>           |  O  O      O   OO OO     OOO O                                  |   
>   1.9e+09 |O+     O OO            O         O                               |   
>           |   O  O      O       O         O                                 |   
>           |                                                                 |   
>   1.8e+09 |-+                                                               |   
>           |                                                                 |   
>   1.7e+09 |-+                                                               |   
>           |                                                          +  ++. |   
>   1.6e+09 |-+ +          +              .+      ++  +.+++.++.+++.++.+ :+   +|   
>           |+.+ +     +   :+     +.+ .+++  +. +.+  + :                 +     |   
>           |     ++ .+ + +  +  ++   +        +      +                        |   
>   1.5e+09 |-+     +    +    :+                                              |   
>           |                 +                                               |   
>   1.4e+09 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
