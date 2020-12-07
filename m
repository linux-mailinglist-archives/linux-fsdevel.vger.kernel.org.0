Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50B02D1133
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgLGM5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:57:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:53415 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgLGM5X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:57:23 -0500
IronPort-SDR: T1h82tRU7cQwP7DyJoUykmOol8qkb307YfwzG+FrI0t/tiB8JMukPOiipjYuotLcd7iV/LvE2b
 pVSZa8PwwLHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="235293555"
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="235293555"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 04:56:41 -0800
IronPort-SDR: UJy1QcPQxrXib8ppKUoGx6IhWrY+lHLZZ7Qlprk+9cwHqzJsAMPZSTQsbyqG566OV92jbAO606
 DOVmta60G0mQ==
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="363130665"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 04:56:38 -0800
Date:   Mon, 7 Dec 2020 21:10:37 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8%
 regression
Message-ID: <20201207131037.GA3826@xsang-OptiPlex-9020>
References: <20201203064536.GE27350@xsang-OptiPlex-9020>
 <98294.1607082708@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98294.1607082708@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Fri, Dec 04, 2020 at 11:51:48AM +0000, David Howells wrote:
> kernel test robot <oliver.sang@intel.com> wrote:
> 
> > FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops due to commit:
> > 
> > 
> > commit: 9bd0e337c633aed3e8ec3c7397b7ae0b8436f163 ("[PATCH 01/29] iov_iter: Switch to using a table of operations")
> 
> Out of interest, would it be possible for you to run this on the tail of the
> series on the same hardware?

sorry for late. below is the result adding the tail of the series:
* ded69a6991fe0 (linux-review/David-Howells/RFC-iov_iter-Switch-to-using-an-ops-table/20201121-222344) iov_iter: Remove iterate_all_kinds() and iterate_and_advance()

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/process/50%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/pwrite1/will-it-scale/0x42e

commit: 
  27bba9c532a8d21050b94224ffd310ad0058c353
  9bd0e337c633aed3e8ec3c7397b7ae0b8436f163
  ded69a6991fe0094f36d96bf1ace2a9636428676

27bba9c532a8d210 9bd0e337c633aed3e8ec3c7397b ded69a6991fe0094f36d96bf1ac 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
  28443113            -4.8%   27064036            -4.8%   27084904        will-it-scale.24.processes
   1185129            -4.8%    1127667            -4.8%    1128537        will-it-scale.per_process_ops
  28443113            -4.8%   27064036            -4.8%   27084904        will-it-scale.workload
     13.84            +1.0%      13.98            +0.3%      13.89        boot-time.dhcp
      1251 ±  9%     -17.2%       1035 ± 10%      -9.1%       1137 ±  5%  slabinfo.dmaengine-unmap-16.active_objs
      1251 ±  9%     -17.2%       1035 ± 10%      -9.1%       1137 ±  5%  slabinfo.dmaengine-unmap-16.num_objs
      1052 ±  6%      -1.1%       1041 ±  5%     -13.4%     911.75 ± 10%  slabinfo.task_group.active_objs
      1052 ±  6%      -1.1%       1041 ±  5%     -13.4%     911.75 ± 10%  slabinfo.task_group.num_objs
     31902 ±  5%      -5.6%      30124 ±  7%      -8.3%      29265 ±  4%  slabinfo.vm_area_struct.active_objs
     32163 ±  5%      -5.4%      30441 ±  6%      -8.0%      29602 ±  4%  slabinfo.vm_area_struct.num_objs
     73.46 ± 48%     -59.7%      29.59 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.avg
      2386 ± 23%     -40.5%       1420 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.max
    393.92 ± 33%     -48.5%     202.85 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.stddev
     73.46 ± 48%     -59.7%      29.60 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.avg
      2386 ± 23%     -40.5%       1420 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.max
    393.92 ± 33%     -48.5%     202.94 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.stddev
      0.00 ±  9%     -13.5%       0.00 ±  3%      -2.9%       0.00 ± 13%  sched_debug.cpu.next_balance.stddev
    -18.50           +33.5%     -24.70           -41.9%     -10.75        sched_debug.cpu.nr_uninterruptible.min
    411.75 ± 58%     +76.8%     728.00 ± 32%     +59.2%     655.50 ± 50%  numa-vmstat.node0.nr_active_anon
     34304 ±  2%     -35.6%      22103 ± 48%      +8.6%      37243 ± 26%  numa-vmstat.node0.nr_anon_pages
     36087 ±  2%     -31.0%      24915 ± 43%      +7.0%      38606 ± 27%  numa-vmstat.node0.nr_inactive_anon
      2233 ± 51%     +60.4%       3582 ±  7%      -7.7%       2062 ± 51%  numa-vmstat.node0.nr_shmem
    411.75 ± 58%     +76.8%     728.00 ± 32%     +59.2%     655.50 ± 50%  numa-vmstat.node0.nr_zone_active_anon
     36087 ±  2%     -31.0%      24915 ± 43%      +7.0%      38606 ± 27%  numa-vmstat.node0.nr_zone_inactive_anon
     24265 ±  3%     +51.3%      36707 ± 29%     -12.2%      21315 ± 47%  numa-vmstat.node1.nr_anon_pages
     25441 ±  2%     +44.9%      36858 ± 29%      -9.9%      22912 ± 47%  numa-vmstat.node1.nr_inactive_anon
    537.25 ± 20%     +22.8%     659.50 ± 10%     +14.5%     615.00 ± 21%  numa-vmstat.node1.nr_page_table_pages
     25441 ±  2%     +44.9%      36858 ± 29%      -9.9%      22912 ± 47%  numa-vmstat.node1.nr_zone_inactive_anon
      1649 ± 58%     +76.7%       2913 ± 32%     +59.0%       2621 ± 50%  numa-meminfo.node0.Active
      1649 ± 58%     +76.7%       2913 ± 32%     +59.0%       2621 ± 50%  numa-meminfo.node0.Active(anon)
    137223 ±  2%     -35.6%      88410 ± 48%      +8.6%     148973 ± 26%  numa-meminfo.node0.AnonPages
    164997 ±  9%     -28.4%     118095 ± 42%      +6.9%     176340 ± 23%  numa-meminfo.node0.AnonPages.max
    144353 ±  2%     -31.0%      99656 ± 43%      +7.0%     154424 ± 27%  numa-meminfo.node0.Inactive
    144353 ±  2%     -31.0%      99656 ± 43%      +7.0%     154424 ± 27%  numa-meminfo.node0.Inactive(anon)
      8937 ± 51%     +60.3%      14328 ±  7%      -7.7%       8251 ± 51%  numa-meminfo.node0.Shmem
     97072 ±  3%     +51.3%     146858 ± 29%     -12.2%      85274 ± 47%  numa-meminfo.node1.AnonPages
    127410 ±  5%     +43.2%     182468 ± 16%      -1.9%     124986 ± 42%  numa-meminfo.node1.AnonPages.max
    101822 ±  2%     +44.9%     147521 ± 29%      -9.9%      91738 ± 47%  numa-meminfo.node1.Inactive
    101822 ±  2%     +44.9%     147521 ± 29%      -9.9%      91738 ± 47%  numa-meminfo.node1.Inactive(anon)
      2148 ± 20%     +22.9%       2639 ± 10%     +14.5%       2460 ± 21%  numa-meminfo.node1.PageTables
     24623 ±  5%     -18.0%      20184 ± 15%      -6.9%      22929 ± 15%  softirqs.CPU0.RCU
     15977 ±  9%     +34.4%      21477 ± 22%     +54.7%      24711 ± 15%  softirqs.CPU13.RCU
     30680 ± 40%     -56.2%      13431 ± 60%     -70.8%       8966 ± 44%  softirqs.CPU13.SCHED
     28877 ± 10%     -30.6%      20051 ± 15%     -24.2%      21887 ± 13%  softirqs.CPU19.RCU
      5693 ± 31%    +402.3%      28595 ± 22%    +154.6%      14496 ± 46%  softirqs.CPU19.SCHED
      5753 ± 14%    +141.4%      13886 ± 87%    +172.2%      15657 ± 51%  softirqs.CPU2.SCHED
      7252 ± 79%    +239.9%      24653 ± 48%    +189.1%      20968 ± 44%  softirqs.CPU23.SCHED
     42479           -24.7%      31999 ± 39%     -25.9%      31488 ± 27%  softirqs.CPU26.SCHED
     21142 ± 15%     -26.5%      15533 ± 11%      +5.6%      22317 ± 17%  softirqs.CPU27.RCU
     20776 ± 38%     -50.5%      10290 ± 58%      +4.7%      21748 ± 35%  softirqs.CPU3.SCHED
     26618 ± 11%     -35.3%      17214 ±  6%     -33.5%      17689 ±  5%  softirqs.CPU37.RCU
     10894 ± 48%    +175.5%      30012 ± 34%    +237.2%      36734 ± 10%  softirqs.CPU37.SCHED
     17015 ±  4%     +39.2%      23681 ±  7%      +9.9%      18707 ± 21%  softirqs.CPU43.RCU
     29682 ± 10%     -17.6%      24446 ± 23%     -18.9%      24062 ±  9%  softirqs.CPU6.RCU
     21953 ± 20%      +9.7%      24079 ± 24%     -18.3%      17943 ± 23%  softirqs.CPU7.RCU
      3431 ± 89%     -85.1%     512.25 ±109%     -93.6%     220.75 ± 32%  interrupts.38:PCI-MSI.2621444-edge.eth0-TxRx-3
    348.50 ± 62%    +152.7%     880.75 ± 27%     -30.1%     243.50 ± 44%  interrupts.40:PCI-MSI.2621446-edge.eth0-TxRx-5
     50948            -0.6%      50655            +7.1%      54590 ±  6%  interrupts.CAL:Function_call_interrupts
      2579 ± 26%     +32.3%       3412 ± 43%     +58.3%       4082 ± 27%  interrupts.CPU0.NMI:Non-maskable_interrupts
      2579 ± 26%     +32.3%       3412 ± 43%     +58.3%       4082 ± 27%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    296.75            -3.4%     286.75 ±  7%     -38.2%     183.50 ± 40%  interrupts.CPU1.RES:Rescheduling_interrupts
    737.25            +8.7%     801.75 ± 13%     +92.5%       1419 ± 73%  interrupts.CPU11.CAL:Function_call_interrupts
      1697 ± 63%     -53.1%     796.75 ± 13%     -55.7%     751.50        interrupts.CPU13.CAL:Function_call_interrupts
     89.75 ± 36%    +220.3%     287.50 ± 20%    +195.3%     265.00 ± 10%  interrupts.CPU13.RES:Rescheduling_interrupts
    745.75 ±  3%    +104.6%       1526 ± 69%     +52.7%       1138 ± 61%  interrupts.CPU19.CAL:Function_call_interrupts
    293.00 ±  5%     -60.0%     117.25 ± 47%     -24.1%     222.25 ± 22%  interrupts.CPU19.RES:Rescheduling_interrupts
    778.50 ±  9%    +123.7%       1741 ± 64%      +3.3%     804.50 ± 10%  interrupts.CPU22.CAL:Function_call_interrupts
    670.00 ± 22%     +40.2%     939.50 ± 49%     +84.6%       1236 ± 63%  interrupts.CPU23.CAL:Function_call_interrupts
    283.50 ±  7%     -47.7%     148.25 ± 64%     -38.9%     173.25 ± 38%  interrupts.CPU23.RES:Rescheduling_interrupts
      6450 ± 29%     -38.0%       4000 ±  4%      +8.2%       6977 ± 29%  interrupts.CPU24.NMI:Non-maskable_interrupts
      6450 ± 29%     -38.0%       4000 ±  4%      +8.2%       6977 ± 29%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      2505 ± 24%    +100.2%       5015 ± 45%    +166.6%       6679 ± 26%  interrupts.CPU25.NMI:Non-maskable_interrupts
      2505 ± 24%    +100.2%       5015 ± 45%    +166.6%       6679 ± 26%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      2012 ± 56%     -57.6%     852.75 ±  6%     -48.0%       1047 ± 35%  interrupts.CPU26.CAL:Function_call_interrupts
     71.50 ± 12%     +73.4%     124.00 ± 72%    +106.3%     147.50 ± 49%  interrupts.CPU26.RES:Rescheduling_interrupts
      4198 ± 54%      +5.7%       4438 ± 51%     +41.8%       5952 ± 40%  interrupts.CPU27.NMI:Non-maskable_interrupts
      4198 ± 54%      +5.7%       4438 ± 51%     +41.8%       5952 ± 40%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    184.25 ± 37%     -47.9%      96.00 ± 49%      -6.5%     172.25 ± 27%  interrupts.CPU27.RES:Rescheduling_interrupts
      0.50 ±100%  +64250.0%     321.75 ±170%    +500.0%       3.00 ±115%  interrupts.CPU28.TLB:TLB_shootdowns
      3431 ± 89%     -85.1%     512.25 ±109%     -93.6%     220.75 ± 32%  interrupts.CPU29.38:PCI-MSI.2621444-edge.eth0-TxRx-3
      5982 ± 40%     -21.5%       4695 ± 46%     -35.1%       3881 ± 64%  interrupts.CPU3.NMI:Non-maskable_interrupts
      5982 ± 40%     -21.5%       4695 ± 46%     -35.1%       3881 ± 64%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    348.50 ± 62%    +152.7%     880.75 ± 27%     -30.1%     243.50 ± 44%  interrupts.CPU31.40:PCI-MSI.2621446-edge.eth0-TxRx-5
    156.50 ± 51%     -51.3%      76.25 ± 59%      +9.1%     170.75 ± 48%  interrupts.CPU33.RES:Rescheduling_interrupts
    883.50 ± 18%     -23.8%     673.25 ± 22%      -2.2%     863.75 ± 12%  interrupts.CPU36.CAL:Function_call_interrupts
      7492 ± 13%     -45.6%       4073 ± 63%     -40.2%       4483 ± 27%  interrupts.CPU37.NMI:Non-maskable_interrupts
      7492 ± 13%     -45.6%       4073 ± 63%     -40.2%       4483 ± 27%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    250.50 ± 19%     -52.5%     119.00 ± 50%     -76.0%      60.00 ± 49%  interrupts.CPU37.RES:Rescheduling_interrupts
    772.50 ±  2%      +2.0%     787.75 ± 10%    +346.2%       3447 ±127%  interrupts.CPU40.CAL:Function_call_interrupts
      4688 ± 27%     +63.5%       7667 ± 15%     +14.0%       5345 ± 38%  interrupts.CPU40.NMI:Non-maskable_interrupts
      4688 ± 27%     +63.5%       7667 ± 15%     +14.0%       5345 ± 38%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
     96.75 ± 92%    +135.1%     227.50 ± 22%     +29.5%     125.25 ± 46%  interrupts.CPU43.RES:Rescheduling_interrupts
      2932 ± 36%     +73.4%       5084 ± 21%     +24.7%       3656 ± 55%  interrupts.CPU47.NMI:Non-maskable_interrupts
      2932 ± 36%     +73.4%       5084 ± 21%     +24.7%       3656 ± 55%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     57.50 ± 78%    +250.4%     201.50 ± 42%    +251.7%     202.25 ± 17%  interrupts.CPU47.RES:Rescheduling_interrupts
      4207 ± 61%     +86.0%       7827 ± 11%     +48.7%       6258 ± 33%  interrupts.CPU8.NMI:Non-maskable_interrupts
      4207 ± 61%     +86.0%       7827 ± 11%     +48.7%       6258 ± 33%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      0.18 ± 60%     -36.2%       0.11 ±  9%     -39.0%       0.11 ±  4%  perf-stat.i.MPKI
 1.089e+10            -2.3%  1.064e+10            -4.8%  1.036e+10        perf-stat.i.branch-instructions
      1.62            +0.7        2.34            +0.8        2.40        perf-stat.i.branch-miss-rate%
 1.741e+08           +42.3%  2.476e+08           +42.2%  2.475e+08        perf-stat.i.branch-misses
      2.70            -0.1        2.65 ±  6%      +0.2        2.95 ±  3%  perf-stat.i.cache-miss-rate%
   5228328            +4.0%    5436325 ±  8%      -4.5%    4992245 ±  2%  perf-stat.i.cache-references
      1.36            +3.3%       1.41            +5.5%       1.44        perf-stat.i.cpi
     52.10            +0.9%      52.55            +1.8%      53.04        perf-stat.i.cpu-migrations
 1.233e+08 ±  3%      -7.1%  1.146e+08            +1.6%  1.253e+08 ± 11%  perf-stat.i.dTLB-load-misses
  2.38e+10            -3.3%  2.302e+10            -4.5%  2.273e+10        perf-stat.i.dTLB-loads
  57501510            -4.9%   54711717            -4.6%   54852849        perf-stat.i.dTLB-store-misses
 1.828e+10            -3.7%  1.761e+10            -4.3%   1.75e+10        perf-stat.i.dTLB-stores
     98.97            -2.9       96.02 ±  2%     -29.3       69.69        perf-stat.i.iTLB-load-miss-rate%
  29795797 ±  4%      -5.0%   28320171            -5.2%   28254639        perf-stat.i.iTLB-load-misses
    299268 ±  2%    +298.1%    1191476 ± 50%   +4062.6%   12457396 ±  4%  perf-stat.i.iTLB-loads
 5.335e+10            -3.7%  5.138e+10            -5.7%  5.029e+10        perf-stat.i.instructions
      0.74            -3.7%       0.71            -5.7%       0.70        perf-stat.i.ipc
      0.20 ±  8%     +12.1%       0.23            +2.7%       0.21 ±  9%  perf-stat.i.major-faults
      1104            -3.2%       1069            -4.5%       1055        perf-stat.i.metric.M/sec
     66981            +4.3%      69845 ±  6%     +10.1%      73725 ±  4%  perf-stat.i.node-load-misses
     84278 ±  2%      +7.2%      90313 ±  6%      +9.8%      92543 ±  5%  perf-stat.i.node-loads
     72308            +2.3%      73975 ±  2%      +1.5%      73361        perf-stat.i.node-stores
      0.10            +7.9%       0.11 ±  8%      +1.3%       0.10 ±  3%  perf-stat.overall.MPKI
      1.60            +0.7        2.33            +0.8        2.39        perf-stat.overall.branch-miss-rate%
      3.60 ±  6%      -0.1        3.45 ±  7%      +0.3        3.88 ±  2%  perf-stat.overall.cache-miss-rate%
      1.35            +4.1%       1.41            +6.2%       1.44        perf-stat.overall.cpi
     99.00            -3.0       95.98 ±  2%     -29.6       69.42        perf-stat.overall.iTLB-load-miss-rate%
      0.74            -3.9%       0.71            -5.9%       0.70        perf-stat.overall.ipc
    567203            +1.0%     572789            -1.2%     560464        perf-stat.overall.path-length
 1.085e+10            -2.3%   1.06e+10            -4.8%  1.033e+10        perf-stat.ps.branch-instructions
 1.735e+08           +42.3%  2.468e+08           +42.2%  2.467e+08        perf-stat.ps.branch-misses
   5216268            +4.0%    5422673 ±  8%      -4.5%    4979211 ±  2%  perf-stat.ps.cache-references
     51.99            +0.8%      52.43            +1.8%      52.92        perf-stat.ps.cpu-migrations
 1.229e+08 ±  3%      -7.1%  1.142e+08            +1.6%  1.249e+08 ± 12%  perf-stat.ps.dTLB-load-misses
 2.372e+10            -3.3%  2.294e+10            -4.5%  2.266e+10        perf-stat.ps.dTLB-loads
  57306258            -4.9%   54525679            -4.6%   54668669        perf-stat.ps.dTLB-store-misses
 1.822e+10            -3.7%  1.755e+10            -4.3%  1.744e+10        perf-stat.ps.dTLB-stores
  29695158 ±  4%      -5.0%   28224049            -5.2%   28159995        perf-stat.ps.iTLB-load-misses
    298257 ±  2%    +298.1%    1187498 ± 50%   +4061.6%   12412241 ±  4%  perf-stat.ps.iTLB-loads
 5.317e+10            -3.7%   5.12e+10            -5.7%  5.012e+10        perf-stat.ps.instructions
      0.20 ±  7%     +12.0%       0.23 ±  2%      +3.0%       0.21 ±  8%  perf-stat.ps.major-faults
     66882            +4.3%      69726 ±  6%     +10.1%      73651 ±  4%  perf-stat.ps.node-load-misses
     84325 ±  2%      +7.1%      90306 ±  6%      +9.7%      92489 ±  5%  perf-stat.ps.node-loads
 1.613e+13            -3.9%   1.55e+13            -5.9%  1.518e+13        perf-stat.total.instructions
      8.00 ± 14%      -8.0        0.00            -8.0        0.00        perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      7.38 ± 14%      -7.4        0.00            -7.4        0.00        perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      7.27 ± 14%      -7.3        0.00            -7.3        0.00        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter
      6.71 ± 12%      -0.7        5.98 ± 13%      -0.7        6.03 ± 10%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_pwrite
      4.93 ± 12%      -0.6        4.29 ± 14%      -0.5        4.40 ± 11%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      5.81 ± 13%      -0.6        5.22 ± 14%      -0.6        5.17 ± 11%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      3.50 ± 14%      -0.5        3.03 ± 13%      -0.4        3.13 ± 11%  perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.69 ± 14%      -0.4        0.29 ±100%      -0.5        0.14 ±173%  perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.new_sync_write.vfs_write.ksys_pwrite64
      3.44 ± 12%      -0.4        3.06 ± 14%      -0.4        3.05 ± 12%  perf-profile.calltrace.cycles-pp.find_lock_entry.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.62 ± 15%      -0.3        0.30 ±101%      -0.2        0.43 ± 59%  perf-profile.calltrace.cycles-pp.unlock_page.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.85 ±  8%      -0.2        0.66 ± 15%      -0.1        0.71 ± 10%  perf-profile.calltrace.cycles-pp.__fget_light.ksys_pwrite64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pwrite
      0.84 ± 14%      -0.1        0.71 ± 14%      -0.1        0.72 ±  8%  perf-profile.calltrace.cycles-pp.set_page_dirty.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.91 ± 11%      -0.1        0.79 ± 12%      -0.1        0.82 ± 10%  perf-profile.calltrace.cycles-pp.file_update_time.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
      0.68 ± 15%      -0.1        0.58 ± 13%      -0.1        0.57 ±  9%  perf-profile.calltrace.cycles-pp.page_mapping.set_page_dirty.shmem_write_end.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00            +1.0        1.02 ± 11%  perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.iovec_fault_in_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +0.0        0.00            +1.2        1.17 ±  9%  perf-profile.calltrace.cycles-pp.iovec_advance.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +0.0        0.00            +2.1        2.13 ± 11%  perf-profile.calltrace.cycles-pp.iovec_fault_in_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +0.0        0.00            +6.8        6.85 ± 10%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iovec_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00            +6.9        6.95 ± 10%  perf-profile.calltrace.cycles-pp.copyin.iovec_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +0.0        0.00            +8.2        8.17 ± 10%  perf-profile.calltrace.cycles-pp.iovec_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +1.0        1.01 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.xxx_fault_in_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +1.4        1.42 ± 12%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xxx_advance.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +2.1        2.15 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xxx_fault_in_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +6.8        6.82 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.xxx_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter
      0.00            +6.9        6.92 ± 13%      +0.0        0.00        perf-profile.calltrace.cycles-pp.copyin.xxx_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +8.1        8.09 ± 14%      +0.0        0.00        perf-profile.calltrace.cycles-pp.xxx_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      8.03 ± 14%      -8.0        0.00            -8.0        0.00        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      7.55 ± 12%      -0.8        6.75 ± 13%      -0.8        6.79 ± 10%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.99 ± 12%      -0.6        4.34 ± 14%      -0.5        4.45 ± 11%  perf-profile.children.cycles-pp.shmem_getpage_gfp
      5.84 ± 13%      -0.6        5.22 ± 14%      -0.6        5.20 ± 11%  perf-profile.children.cycles-pp.shmem_write_begin
      3.53 ± 13%      -0.5        3.07 ± 13%      -0.4        3.17 ± 11%  perf-profile.children.cycles-pp.shmem_write_end
      3.48 ± 12%      -0.4        3.09 ± 14%      -0.4        3.09 ± 12%  perf-profile.children.cycles-pp.find_lock_entry
      0.85 ±  8%      -0.2        0.66 ± 15%      -0.1        0.71 ± 10%  perf-profile.children.cycles-pp.__fget_light
      0.69 ± 14%      -0.2        0.52 ± 15%      -0.2        0.48 ±  9%  perf-profile.children.cycles-pp.up_write
      0.62 ± 13%      -0.2        0.46 ± 14%      -0.2        0.47 ± 12%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.86 ± 14%      -0.1        0.74 ± 14%      -0.1        0.74 ±  8%  perf-profile.children.cycles-pp.set_page_dirty
      0.94 ± 11%      -0.1        0.82 ± 13%      -0.1        0.85 ± 10%  perf-profile.children.cycles-pp.file_update_time
      0.51 ± 12%      -0.1        0.40 ± 14%      +0.0        0.52 ± 11%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.71 ± 15%      -0.1        0.60 ± 13%      -0.1        0.60 ±  9%  perf-profile.children.cycles-pp.page_mapping
      0.55 ± 12%      -0.1        0.47 ± 12%      -0.0        0.50 ±  9%  perf-profile.children.cycles-pp.current_time
      0.62 ± 14%      -0.1        0.55 ± 13%      -0.1        0.56 ± 13%  perf-profile.children.cycles-pp.unlock_page
      0.24 ± 13%      -0.0        0.20 ± 16%      -0.0        0.22 ± 12%  perf-profile.children.cycles-pp.timestamp_truncate
      0.18 ± 11%      -0.0        0.14 ± 15%      -0.0        0.18 ± 12%  perf-profile.children.cycles-pp.file_remove_privs
      0.42 ± 13%      -0.0        0.39 ± 14%      -0.1        0.36 ± 13%  perf-profile.children.cycles-pp.testcase
      0.00            +0.0        0.00            +1.2        1.18 ±  9%  perf-profile.children.cycles-pp.iovec_advance
      0.00            +0.0        0.00            +2.2        2.21 ± 11%  perf-profile.children.cycles-pp.iovec_fault_in_readable
      0.00            +0.0        0.00            +8.2        8.20 ± 10%  perf-profile.children.cycles-pp.iovec_copy_from_user_atomic
      0.21 ± 17%      +0.1        0.28 ± 16%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.55 ± 14%      +0.3        0.87 ± 15%      +0.3        0.89 ± 13%  perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.00            +1.4        1.42 ± 12%      +0.0        0.00        perf-profile.children.cycles-pp.xxx_advance
      0.00            +2.2        2.22 ± 13%      +0.0        0.00        perf-profile.children.cycles-pp.xxx_fault_in_readable
      0.00            +8.1        8.12 ± 14%      +0.0        0.00        perf-profile.children.cycles-pp.xxx_copy_from_user_atomic
      7.52 ± 12%      -0.8        6.72 ± 13%      -0.8        6.77 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.02 ± 16%      -0.2        0.82 ± 12%      -0.1        0.92 ± 10%  perf-profile.self.cycles-pp.shmem_getpage_gfp
      0.82 ±  8%      -0.2        0.63 ± 15%      -0.1        0.68 ± 10%  perf-profile.self.cycles-pp.__fget_light
      0.66 ± 14%      -0.2        0.49 ± 15%      -0.2        0.46 ±  8%  perf-profile.self.cycles-pp.up_write
      0.54 ± 15%      -0.2        0.39 ± 14%      -0.1        0.40 ± 12%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.59 ± 13%      -0.1        0.46 ± 13%      -0.1        0.45 ±  9%  perf-profile.self.cycles-pp.ksys_pwrite64
      0.50 ± 12%      -0.1        0.40 ± 13%      -0.0        0.47 ± 12%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.67 ± 15%      -0.1        0.57 ± 12%      -0.1        0.57 ±  9%  perf-profile.self.cycles-pp.page_mapping
      0.71 ± 17%      -0.1        0.63 ± 13%      -0.1        0.60 ± 14%  perf-profile.self.cycles-pp.security_file_permission
      0.24 ± 15%      -0.0        0.19 ± 15%      -0.0        0.22 ± 12%  perf-profile.self.cycles-pp.timestamp_truncate
      0.20 ± 13%      -0.0        0.17 ± 12%      -0.0        0.18 ± 10%  perf-profile.self.cycles-pp.current_time
      0.00            +0.0        0.00            +1.1        1.05 ±  9%  perf-profile.self.cycles-pp.iovec_advance
      0.00            +0.0        0.00            +1.2        1.17 ± 12%  perf-profile.self.cycles-pp.iovec_fault_in_readable
      0.00            +0.0        0.00            +1.2        1.19 ± 10%  perf-profile.self.cycles-pp.iovec_copy_from_user_atomic
      0.82 ± 15%      +0.0        0.83 ± 12%      -0.1        0.71 ± 10%  perf-profile.self.cycles-pp.shmem_write_begin
      0.12 ± 14%      +0.1        0.19 ± 14%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.43 ± 14%      +0.3        0.68 ± 15%      +0.3        0.69 ± 15%  perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.00            +1.1        1.14 ± 15%      +0.0        0.00        perf-profile.self.cycles-pp.xxx_copy_from_user_atomic
      0.00            +1.2        1.21 ± 12%      +0.0        0.00        perf-profile.self.cycles-pp.xxx_fault_in_readable
      0.00            +1.3        1.28 ± 12%      +0.0        0.00        perf-profile.self.cycles-pp.xxx_advance

> 
> Thanks,
> David
> 
