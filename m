Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F87BBC12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 21:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbfIWTLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 15:11:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46280 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfIWTLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:11:52 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so23031664ioo.13;
        Mon, 23 Sep 2019 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jKyGI9e287sSfmwM6P8WTqlHE84EYLKkllC2PmZ9rCQ=;
        b=RUAq02OpVl0lahcyjkE3CbmgMMIH1LPP2FV0mJdw7BJnN2HoHzrw0Zr+19v57WSPTL
         oE0ry+t7v63KDlfSBlgTNPTex3Y0h8B/KL8wVwBC++aBtJ0KDxgp1pKPjXTVQszMXvdW
         WTCwG6cPHqOo/1XSexGuQw+8RtySIeurxtdakgrjWYys5C93r7RgXj9kn+5hdo1aVM23
         s4nCJDj7qPVEzHBsbS9LK5sdKBsRRdRRDy3FSHJ30fQt/iKnb4irF7Qq3eP9307cef24
         CO1TLeTPJqM+dh67hTK/0TQYS86MVzJ/X/NTqbioIjysuux+3tmvNYff8J6KplPhZZoM
         +y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jKyGI9e287sSfmwM6P8WTqlHE84EYLKkllC2PmZ9rCQ=;
        b=aLeNgpeyfvcLjrQY0QhDvHUhhfm0n3uPaiQQD31KVwbnLpaSTQtc+gV8BsUjfglEYD
         4tlyArcBZewE9EX9yHUg/6hTITpluEiozWBFQWC68U5qHesrgbGcOLXHzpQmICFNCVMY
         QWMXvLlttDY7joFONjizivzy2KxjTrEuUF+bzfrCqoBLpZFrUbXQgrAPuu9TILP8JSJT
         g1DH+iPUHPt86A5b5CEErDTUp9l5mr4yYYvQ+s225shs7XDOrPhac0pP2I8tuJxWXoO8
         KrHokP73/Mb3ArFwka0Bofp/jzKaRmgR5VoClaLIUe88bF0W+CpF1Hn/zCkTi36mYxQY
         KLyw==
X-Gm-Message-State: APjAAAVExOEgzemuTS01761hksrYhXxt7AGhHRC83egav54Ic5ChuysW
        1HmuU6xy2vHn+pijeY+iMFEP9y7NBtA64C3wgRU=
X-Google-Smtp-Source: APXvYqzLdsoaw2wtXlLNMC+oOP7na7ovD+cvxwnSsI+PQrkTGvj8pHePdY+wPlgx73/cwlmArpinxdtSnYZdlXW4rmE=
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr981617iol.73.1569265909503;
 Mon, 23 Sep 2019 12:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz> <20190923003658.GA15734@shao2-debian>
In-Reply-To: <20190923003658.GA15734@shao2-debian>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Mon, 23 Sep 2019 22:11:40 +0300
Message-ID: <CALYGNiPQGX4=dgbXVtAsULDhCanGec3kHXMijkjvFwkhVu4AyQ@mail.gmail.com>
Subject: Re: [mm] e0e7df8d5b: will-it-scale.per_process_ops -7.3% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:37 AM kernel test robot <rong.a.chen@intel.com> w=
rote:
>
> Greeting,
>
> FYI, we noticed a -7.3% regression of will-it-scale.per_process_ops due t=
o commit:

Most likely this caused by changing struct file layout after adding new fie=
ld.

>
>
> commit: e0e7df8d5b71bf59ad93fe75e662c929b580d805 ("[PATCH v2] mm: impleme=
nt write-behind policy for sequential file writes")
> url: https://github.com/0day-ci/linux/commits/Konstantin-Khlebnikov/mm-im=
plement-write-behind-policy-for-sequential-file-writes/20190920-155606
>
>
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz=
 with 192G memory
> with following parameters:
>
>         nr_task: 100%
>         mode: process
>         test: open1
>         cpufreq_governor: performance
>
> test-description: Will It Scale takes a testcase and runs it from 1 throu=
gh to n parallel copies to see if the testcase will scale. It builds both a=
 process and threads based test in order to see any differences between the=
 two.
> test-url: https://github.com/antonblanchard/will-it-scale
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-7/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-2019-05-14=
.cgz/lkp-csl-2ap4/open1/will-it-scale
>
> commit:
>   574cc45397 (" drm main pull for 5.4-rc1")
>   e0e7df8d5b ("mm: implement write-behind policy for sequential file writ=
es")
>
> 574cc4539762561d e0e7df8d5b71bf59ad93fe75e66
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     370456            -7.3%     343238        will-it-scale.per_process_o=
ps
>   71127653            -7.3%   65901758        will-it-scale.workload
>     828565 =C2=B1 23%     +66.8%    1381984 =C2=B1 23%  cpuidle.C1.time
>       1499            +1.1%       1515        turbostat.Avg_MHz
>     163498 =C2=B1  5%     +26.4%     206691 =C2=B1  4%  slabinfo.filp.act=
ive_slabs
>     163498 =C2=B1  5%     +26.4%     206691 =C2=B1  4%  slabinfo.filp.num=
_slabs
>      39055 =C2=B1  2%     +17.1%      45720 =C2=B1  5%  meminfo.Inactive
>      38615 =C2=B1  2%     +17.3%      45291 =C2=B1  5%  meminfo.Inactive(=
anon)
>      51382 =C2=B1  3%     +19.6%      61469 =C2=B1  7%  meminfo.Mapped
>    5163010 =C2=B1  2%     +12.7%    5819765 =C2=B1  3%  meminfo.Memused
>    2840181 =C2=B1  3%     +22.5%    3478003 =C2=B1  5%  meminfo.SUnreclai=
m
>    2941874 =C2=B1  3%     +21.7%    3579791 =C2=B1  5%  meminfo.Slab
>      67755 =C2=B1  5%     +23.8%      83884 =C2=B1  3%  meminfo.max_used_=
kB
>   79719901           +17.3%   93512842        numa-numastat.node0.local_n=
ode
>   79738690           +17.3%   93533079        numa-numastat.node0.numa_hi=
t
>   81987497           +16.6%   95625946        numa-numastat.node1.local_n=
ode
>   82018695           +16.6%   95652480        numa-numastat.node1.numa_hi=
t
>   82693483           +15.8%   95762465        numa-numastat.node2.local_n=
ode
>   82705924           +15.8%   95789007        numa-numastat.node2.numa_hi=
t
>   80329941           +17.1%   94048289        numa-numastat.node3.local_n=
ode
>   80361116           +17.1%   94068512        numa-numastat.node3.numa_hi=
t
>       9678 =C2=B1  2%     +17.1%      11334 =C2=B1  5%  proc-vmstat.nr_in=
active_anon
>      13001 =C2=B1  3%     +19.2%      15503 =C2=B1  7%  proc-vmstat.nr_ma=
pped
>     738232 =C2=B1  4%     +18.5%     875062 =C2=B1  2%  proc-vmstat.nr_sl=
ab_unreclaimable
>       9678 =C2=B1  2%     +17.1%      11334 =C2=B1  5%  proc-vmstat.nr_zo=
ne_inactive_anon
>       2391 =C2=B1 92%     -84.5%     369.50 =C2=B1 46%  proc-vmstat.numa_=
hint_faults
>  3.243e+08           +16.8%  3.789e+08        proc-vmstat.numa_hit
>  3.242e+08           +16.8%  3.788e+08        proc-vmstat.numa_local
>  1.296e+09           +16.8%  1.514e+09        proc-vmstat.pgalloc_normal
>  1.296e+09           +16.8%  1.514e+09        proc-vmstat.pgfree
>     862.61 =C2=B1  5%     +37.7%       1188 =C2=B1  5%  sched_debug.cfs_r=
q:/.exec_clock.stddev
>     229663 =C2=B1 62%    +113.3%     489907 =C2=B1 29%  sched_debug.cfs_r=
q:/.load.max
>     491.04 =C2=B1  4%      -9.5%     444.29 =C2=B1  7%  sched_debug.cfs_r=
q:/.nr_spread_over.min
>     229429 =C2=B1 62%    +113.4%     489618 =C2=B1 29%  sched_debug.cfs_r=
q:/.runnable_weight.max
>   -1959962           +36.2%   -2669681        sched_debug.cfs_rq:/.spread=
0.min
>    1416008 =C2=B1  2%     -13.3%    1227494 =C2=B1  5%  sched_debug.cpu.a=
vg_idle.avg
>    1240763 =C2=B1  8%     -28.2%     891028 =C2=B1 18%  sched_debug.cpu.a=
vg_idle.stddev
>     352361 =C2=B1  6%     -29.6%     248105 =C2=B1 25%  sched_debug.cpu.m=
ax_idle_balance_cost.stddev
>     -20.00           +51.0%     -30.21        sched_debug.cpu.nr_uninterr=
uptible.min
>       6618 =C2=B1 10%     -20.8%       5240 =C2=B1  8%  sched_debug.cpu.t=
twu_count.max
>    1452719 =C2=B1  4%      +7.2%    1557262 =C2=B1  3%  numa-meminfo.node=
0.MemUsed
>     797565 =C2=B1  2%     +20.8%     963538 =C2=B1  2%  numa-meminfo.node=
0.SUnreclaim
>     835343 =C2=B1  3%     +19.6%     998867 =C2=B1  2%  numa-meminfo.node=
0.Slab
>     831114 =C2=B1  2%     +20.1%     998248 =C2=B1  2%  numa-meminfo.node=
1.SUnreclaim
>     848052           +19.8%    1016069 =C2=B1  2%  numa-meminfo.node1.Sla=
b
>    1441558 =C2=B1  6%     +15.7%    1668466 =C2=B1  3%  numa-meminfo.node=
2.MemUsed
>     879835 =C2=B1  2%     +20.4%    1059441        numa-meminfo.node2.SUn=
reclaim
>     901359 =C2=B1  3%     +20.3%    1084727 =C2=B1  2%  numa-meminfo.node=
2.Slab
>    1446041 =C2=B1  5%     +15.5%    1669477 =C2=B1  3%  numa-meminfo.node=
3.MemUsed
>     899442 =C2=B1  5%     +23.0%    1106354        numa-meminfo.node3.SUn=
reclaim
>     924903 =C2=B1  5%     +22.1%    1129709        numa-meminfo.node3.Sla=
b
>     198945           +19.8%     238298 =C2=B1  2%  numa-vmstat.node0.nr_s=
lab_unreclaimable
>   40181885           +17.3%   47129598        numa-vmstat.node0.numa_hit
>   40163521           +17.3%   47110122        numa-vmstat.node0.numa_loca=
l
>     208512           +20.9%     252000 =C2=B1  2%  numa-vmstat.node1.nr_s=
lab_unreclaimable
>   41144466           +16.7%   48021716        numa-vmstat.node1.numa_hit
>   41027051           +16.8%   47908675        numa-vmstat.node1.numa_loca=
l
>     220763 =C2=B1  2%     +21.9%     269115 =C2=B1  2%  numa-vmstat.node2=
.nr_slab_unreclaimable
>   41437805           +16.2%   48167791        numa-vmstat.node2.numa_hit
>   41338581           +16.2%   48054485        numa-vmstat.node2.numa_loca=
l
>     225216 =C2=B1  2%     +24.7%     280851 =C2=B1  2%  numa-vmstat.node3=
.nr_slab_unreclaimable
>   40385721           +16.9%   47195289        numa-vmstat.node3.numa_hit
>   40268228           +16.9%   47088405        numa-vmstat.node3.numa_loca=
l
>      77.00 =C2=B1 29%    +494.8%     458.00 =C2=B1110%  interrupts.CPU10.=
RES:Rescheduling_interrupts
>     167.25 =C2=B1 65%    +347.8%     749.00 =C2=B1 85%  interrupts.CPU103=
.RES:Rescheduling_interrupts
>     136.50 =C2=B1 42%    +309.2%     558.50 =C2=B1 85%  interrupts.CPU107=
.RES:Rescheduling_interrupts
>     132.50 =C2=B1 26%    +637.5%     977.25 =C2=B1 50%  interrupts.CPU109=
.RES:Rescheduling_interrupts
>     212.50 =C2=B1 51%     -65.2%      74.00 =C2=B1  9%  interrupts.CPU115=
.RES:Rescheduling_interrupts
>     270.25 =C2=B1 20%     -77.2%      61.50 =C2=B1 10%  interrupts.CPU121=
.RES:Rescheduling_interrupts
>     184.00 =C2=B1 50%     -57.5%      78.25 =C2=B1 51%  interrupts.CPU128=
.RES:Rescheduling_interrupts
>      85.25 =C2=B1 38%    +911.4%     862.25 =C2=B1135%  interrupts.CPU137=
.RES:Rescheduling_interrupts
>      72.25 =C2=B1  6%    +114.2%     154.75 =C2=B1 25%  interrupts.CPU147=
.RES:Rescheduling_interrupts
>     415.00 =C2=B1 75%     -69.8%     125.25 =C2=B1 59%  interrupts.CPU15.=
RES:Rescheduling_interrupts
>     928.25 =C2=B1 93%     -89.8%      94.50 =C2=B1 50%  interrupts.CPU182=
.RES:Rescheduling_interrupts
>     359.75 =C2=B1 76%     -58.8%     148.25 =C2=B1 85%  interrupts.CPU19.=
RES:Rescheduling_interrupts
>      95.75 =C2=B1 30%    +103.9%     195.25 =C2=B1 48%  interrupts.CPU45.=
RES:Rescheduling_interrupts
>      60.25 =C2=B1  9%    +270.5%     223.25 =C2=B1 93%  interrupts.CPU83.=
RES:Rescheduling_interrupts
>     906.75 =C2=B1136%     -90.5%      85.75 =C2=B1 36%  interrupts.CPU85.=
RES:Rescheduling_interrupts
>     199.25 =C2=B1 25%     -52.1%      95.50 =C2=B1 43%  interrupts.CPU90.=
RES:Rescheduling_interrupts
>       5192 =C2=B1 34%     +41.5%       7347 =C2=B1 24%  interrupts.CPU95.=
NMI:Non-maskable_interrupts
>       5192 =C2=B1 34%     +41.5%       7347 =C2=B1 24%  interrupts.CPU95.=
PMI:Performance_monitoring_interrupts
>       1.75           +26.1%       2.20        perf-stat.i.MPKI
>  7.975e+10            -6.8%  7.435e+10        perf-stat.i.branch-instruct=
ions
>  3.782e+08            -5.9%  3.558e+08        perf-stat.i.branch-misses
>      75.36            +0.9       76.29        perf-stat.i.cache-miss-rate=
%
>  5.484e+08           +18.8%  6.515e+08        perf-stat.i.cache-misses
>  7.276e+08           +17.3%  8.539e+08        perf-stat.i.cache-reference=
s
>       1.37            +8.2%       1.48        perf-stat.i.cpi
>  5.701e+11            +0.7%  5.744e+11        perf-stat.i.cpu-cycles
>       1040           -15.2%     882.10        perf-stat.i.cycles-between-=
cache-misses
>  1.253e+11            -7.2%  1.163e+11        perf-stat.i.dTLB-loads
>  7.443e+10            -7.2%  6.904e+10        perf-stat.i.dTLB-stores
>  3.336e+08           +12.6%  3.755e+08        perf-stat.i.iTLB-load-misse=
s
>    5004598 =C2=B1  7%     -60.9%    1954451 =C2=B1  6%  perf-stat.i.iTLB-=
loads
>  4.175e+11            -6.9%  3.887e+11        perf-stat.i.instructions
>       1251           -17.3%       1035        perf-stat.i.instructions-pe=
r-iTLB-miss
>       0.73            -7.6%       0.68        perf-stat.i.ipc
>      19.77            -1.5       18.31        perf-stat.i.node-load-miss-=
rate%
>    5003202 =C2=B1  2%     +16.5%    5829006        perf-stat.i.node-load-=
misses
>   20521507           +28.1%   26283838        perf-stat.i.node-loads
>       1.84            +0.4        2.28        perf-stat.i.node-store-miss=
-rate%
>    1469703           +29.0%    1895783        perf-stat.i.node-store-miss=
es
>   78304054            +4.0%   81463725        perf-stat.i.node-stores
>       1.74           +26.1%       2.20        perf-stat.overall.MPKI
>      75.37            +0.9       76.30        perf-stat.overall.cache-mis=
s-rate%
>       1.37            +8.2%       1.48        perf-stat.overall.cpi
>       1039           -15.2%     881.41        perf-stat.overall.cycles-be=
tween-cache-misses
>       1251           -17.3%       1035        perf-stat.overall.instructi=
ons-per-iTLB-miss
>       0.73            -7.6%       0.68        perf-stat.overall.ipc
>      19.59            -1.5       18.14        perf-stat.overall.node-load=
-miss-rate%
>       1.84            +0.4        2.27        perf-stat.overall.node-stor=
e-miss-rate%
>  7.943e+10            -6.8%  7.404e+10        perf-stat.ps.branch-instruc=
tions
>  3.767e+08            -5.9%  3.543e+08        perf-stat.ps.branch-misses
>  5.465e+08           +18.8%  6.492e+08        perf-stat.ps.cache-misses
>   7.25e+08           +17.4%  8.508e+08        perf-stat.ps.cache-referenc=
es
>   5.68e+11            +0.7%  5.722e+11        perf-stat.ps.cpu-cycles
>  1.248e+11            -7.2%  1.158e+11        perf-stat.ps.dTLB-loads
>  7.413e+10            -7.3%  6.874e+10        perf-stat.ps.dTLB-stores
>  3.322e+08           +12.5%  3.739e+08        perf-stat.ps.iTLB-load-miss=
es
>    4986239 =C2=B1  7%     -61.0%    1946378 =C2=B1  6%  perf-stat.ps.iTLB=
-loads
>  4.158e+11            -6.9%   3.87e+11        perf-stat.ps.instructions
>    4982520 =C2=B1  2%     +16.5%    5803884        perf-stat.ps.node-load=
-misses
>   20448588           +28.1%   26201547        perf-stat.ps.node-loads
>    1463675           +29.0%    1887791        perf-stat.ps.node-store-mis=
ses
>   77979119            +4.0%   81107191        perf-stat.ps.node-stores
>   1.25e+14            -6.8%  1.165e+14        perf-stat.total.instruction=
s
>      10.11            -1.9        8.21        perf-profile.calltrace.cycl=
es-pp.file_free_rcu.rcu_do_batch.rcu_core.__softirqentry_text_start.run_kso=
ftirqd
>      17.28            -0.8       16.48        perf-profile.calltrace.cycl=
es-pp.close
>       9.41            -0.7        8.69        perf-profile.calltrace.cycl=
es-pp.link_path_walk.path_openat.do_filp_open.do_sys_open.do_syscall_64
>       6.32            -0.7        5.64        perf-profile.calltrace.cycl=
es-pp.do_dentry_open.path_openat.do_filp_open.do_sys_open.do_syscall_64
>       5.27            -0.5        4.72        perf-profile.calltrace.cycl=
es-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>      13.96            -0.5       13.49        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.close
>      13.58            -0.4       13.14        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
>       0.92            -0.3        0.64        perf-profile.calltrace.cycl=
es-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.close
>       3.10            -0.2        2.86        perf-profile.calltrace.cycl=
es-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
>       2.44            -0.2        2.21        perf-profile.calltrace.cycl=
es-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_open
>       4.02            -0.2        3.80        perf-profile.calltrace.cycl=
es-pp.selinux_inode_permission.security_inode_permission.link_path_walk.pat=
h_openat.do_filp_open
>       1.82            -0.2        1.60        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.open64
>       9.26            -0.2        9.04        perf-profile.calltrace.cycl=
es-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.close
>       2.12 =C2=B1  2%      -0.2        1.90        perf-profile.calltrace=
.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_op=
en
>       1.03 =C2=B1 10%      -0.2        0.82        perf-profile.calltrace=
.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_=
open
>       2.55 =C2=B1  2%      -0.2        2.36 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.security_inode_permission.may_open.path_openat.do_filp_open=
.do_sys_open
>       1.37            -0.2        1.18        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc.getname_flags.do_sys_open.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe
>       1.15            -0.2        0.95        perf-profile.calltrace.cycl=
es-pp.ima_file_check.path_openat.do_filp_open.do_sys_open.do_syscall_64
>       1.79            -0.2        1.60        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.close
>       2.41 =C2=B1  3%      -0.2        2.22 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.selinux_inode_permission.security_inode_permission.may_open=
.path_openat.do_filp_open
>       2.88            -0.2        2.71        perf-profile.calltrace.cycl=
es-pp.security_file_open.do_dentry_open.path_openat.do_filp_open.do_sys_ope=
n
>       2.38            -0.2        2.22        perf-profile.calltrace.cycl=
es-pp.security_file_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp=
_open
>       4.31            -0.2        4.16        perf-profile.calltrace.cycl=
es-pp.security_inode_permission.link_path_walk.path_openat.do_filp_open.do_=
sys_open
>       9.93            -0.1        9.80        perf-profile.calltrace.cycl=
es-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.cl=
ose
>       1.63            -0.1        1.50        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file.pa=
th_openat
>       1.38            -0.1        1.26        perf-profile.calltrace.cycl=
es-pp.__alloc_fd.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.o=
pen64
>       5.16            -0.1        5.04        perf-profile.calltrace.cycl=
es-pp.getname_flags.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.open64
>       1.13            -0.1        1.02        perf-profile.calltrace.cycl=
es-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_open
>       2.26            -0.1        2.15        perf-profile.calltrace.cycl=
es-pp.selinux_file_open.security_file_open.do_dentry_open.path_openat.do_fi=
lp_open
>       0.63            -0.1        0.52 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.__check_heap_object.__check_object_size.strncpy_from_user.getnam=
e_flags.do_sys_open
>       1.29            -0.1        1.18        perf-profile.calltrace.cycl=
es-pp.lookup_fast.path_openat.do_filp_open.do_sys_open.do_syscall_64
>       1.75            -0.1        1.65        perf-profile.calltrace.cycl=
es-pp.terminate_walk.path_openat.do_filp_open.do_sys_open.do_syscall_64
>       0.67            -0.1        0.58        perf-profile.calltrace.cycl=
es-pp.kmem_cache_free.__fput.task_work_run.exit_to_usermode_loop.do_syscall=
_64
>       1.22 =C2=B1  2%      -0.1        1.12        perf-profile.calltrace=
.cycles-pp.avc_has_perm_noaudit.selinux_inode_permission.security_inode_per=
mission.link_path_walk.path_openat
>       1.21            -0.1        1.12        perf-profile.calltrace.cycl=
es-pp.fput_many.filp_close.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe
>       0.74            -0.1        0.66        perf-profile.calltrace.cycl=
es-pp.__inode_security_revalidate.selinux_file_open.security_file_open.do_d=
entry_open.path_openat
>       0.89            -0.1        0.81        perf-profile.calltrace.cycl=
es-pp.inode_security_rcu.selinux_inode_permission.security_inode_permission=
.may_open.path_openat
>       0.79 =C2=B1  4%      -0.1        0.72        perf-profile.calltrace=
.cycles-pp._raw_spin_lock_irq.task_work_run.exit_to_usermode_loop.do_syscal=
l_64.entry_SYSCALL_64_after_hwframe
>       0.76            -0.1        0.70        perf-profile.calltrace.cycl=
es-pp.__inode_security_revalidate.inode_security_rcu.selinux_inode_permissi=
on.security_inode_permission.may_open
>       0.67 =C2=B1  3%      -0.1        0.61        perf-profile.calltrace=
.cycles-pp.__d_lookup_rcu.lookup_fast.path_openat.do_filp_open.do_sys_open
>       0.66 =C2=B1  3%      -0.1        0.60        perf-profile.calltrace=
.cycles-pp.inode_permission.may_open.path_openat.do_filp_open.do_sys_open
>       1.02            -0.1        0.96        perf-profile.calltrace.cycl=
es-pp.path_init.path_openat.do_filp_open.do_sys_open.do_syscall_64
>       0.81            -0.1        0.75        perf-profile.calltrace.cycl=
es-pp.task_work_add.fput_many.filp_close.__x64_sys_close.do_syscall_64
>       0.67            -0.0        0.63        perf-profile.calltrace.cycl=
es-pp.rcu_segcblist_enqueue.__call_rcu.task_work_run.exit_to_usermode_loop.=
do_syscall_64
>       0.78            -0.0        0.74        perf-profile.calltrace.cycl=
es-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text=
_start
>       0.55            -0.0        0.53        perf-profile.calltrace.cycl=
es-pp.selinux_file_alloc_security.security_file_alloc.__alloc_file.alloc_em=
pty_file.path_openat
>       0.71            +0.1        0.82        perf-profile.calltrace.cycl=
es-pp.memset_erms.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_opena=
t
>       3.38            +0.1        3.50        perf-profile.calltrace.cycl=
es-pp.strncpy_from_user.getname_flags.do_sys_open.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
>       1.66            +0.1        1.78        perf-profile.calltrace.cycl=
es-pp.__call_rcu.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
>       0.70            +0.1        0.84        perf-profile.calltrace.cycl=
es-pp.__virt_addr_valid.__check_object_size.strncpy_from_user.getname_flags=
.do_sys_open
>       1.81            +0.4        2.23        perf-profile.calltrace.cycl=
es-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_open.do_sy=
scall_64
>      39.47            +0.7       40.17        perf-profile.calltrace.cycl=
es-pp.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe=
.open64
>       0.00            +0.8        0.75        perf-profile.calltrace.cycl=
es-pp.get_page_from_freelist.__alloc_pages_nodemask.new_slab.___slab_alloc.=
__slab_alloc
>      38.69            +0.8       39.45        perf-profile.calltrace.cycl=
es-pp.path_openat.do_filp_open.do_sys_open.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe
>       0.00            +0.8        0.84        perf-profile.calltrace.cycl=
es-pp.__alloc_pages_nodemask.new_slab.___slab_alloc.__slab_alloc.kmem_cache=
_alloc
>      29.90            +0.9       30.79        perf-profile.calltrace.cycl=
es-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret=
_from_fork
>      29.90            +0.9       30.79        perf-profile.calltrace.cycl=
es-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>      29.87            +0.9       30.76        perf-profile.calltrace.cycl=
es-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot=
_thread_fn
>      29.88            +0.9       30.78        perf-profile.calltrace.cycl=
es-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kt=
hread
>      29.93            +0.9       30.84        perf-profile.calltrace.cycl=
es-pp.smpboot_thread_fn.kthread.ret_from_fork
>      29.94            +0.9       30.85        perf-profile.calltrace.cycl=
es-pp.ret_from_fork
>      29.94            +0.9       30.85        perf-profile.calltrace.cycl=
es-pp.kthread.ret_from_fork
>       0.89 =C2=B1 29%      +0.9        1.81        perf-profile.calltrace=
.cycles-pp.setup_object_debug.new_slab.___slab_alloc.__slab_alloc.kmem_cach=
e_alloc
>       7.25 =C2=B1  3%      +1.1        8.36        perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__=
free_pages_ok.unfreeze_partials
>       7.75 =C2=B1  3%      +1.1        8.87        perf-profile.calltrace=
.cycles-pp.__free_pages_ok.unfreeze_partials.put_cpu_partial.kmem_cache_fre=
e.rcu_do_batch
>       7.72 =C2=B1  3%      +1.1        8.85        perf-profile.calltrace=
.cycles-pp.free_one_page.__free_pages_ok.unfreeze_partials.put_cpu_partial.=
kmem_cache_free
>       7.29 =C2=B1  3%      +1.1        8.41        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.unfreeze_partials.p=
ut_cpu_partial
>       9.12 =C2=B1  3%      +1.1       10.25        perf-profile.calltrace=
.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.=
run_ksoftirqd
>       7.96 =C2=B1  3%      +1.1        9.10        perf-profile.calltrace=
.cycles-pp.put_cpu_partial.kmem_cache_free.rcu_do_batch.rcu_core.__softirqe=
ntry_text_start
>       7.92 =C2=B1  3%      +1.1        9.07        perf-profile.calltrace=
.cycles-pp.unfreeze_partials.put_cpu_partial.kmem_cache_free.rcu_do_batch.r=
cu_core
>       2.38            +1.5        3.83        perf-profile.calltrace.cycl=
es-pp.new_slab.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file
>      10.53            +1.7       12.19        perf-profile.calltrace.cycl=
es-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.__softirqentry_text_start.ru=
n_ksoftirqd
>       5.47            +2.2        7.64        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_op=
en
>       3.34            +2.2        5.56        perf-profile.calltrace.cycl=
es-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_=
file
>       3.39            +2.3        5.65        perf-profile.calltrace.cycl=
es-pp.__slab_alloc.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_open=
at
>      11.39            +2.7       14.08        perf-profile.calltrace.cycl=
es-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_open.do_syscall_64
>      10.91            +2.7       13.63        perf-profile.calltrace.cycl=
es-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_open
>      10.62            -2.1        8.54        perf-profile.children.cycle=
s-pp.file_free_rcu
>      17.31            -0.8       16.51        perf-profile.children.cycle=
s-pp.close
>       9.47            -0.7        8.74        perf-profile.children.cycle=
s-pp.link_path_walk
>       6.37            -0.7        5.68        perf-profile.children.cycle=
s-pp.do_dentry_open
>       5.48            -0.6        4.90        perf-profile.children.cycle=
s-pp.__fput
>       6.49            -0.4        6.08        perf-profile.children.cycle=
s-pp.selinux_inode_permission
>       6.95            -0.3        6.60        perf-profile.children.cycle=
s-pp.security_inode_permission
>       3.48            -0.3        3.15        perf-profile.children.cycle=
s-pp.lookup_fast
>       2.38            -0.3        2.09        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>       1.74 =C2=B1  5%      -0.3        1.46        perf-profile.children.=
cycles-pp.inode_permission
>       0.94            -0.3        0.66        perf-profile.children.cycle=
s-pp.__close_fd
>       3.10            -0.2        2.86        perf-profile.children.cycle=
s-pp.__x64_sys_close
>       2.27 =C2=B1  2%      -0.2        2.04 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.dput
>       2.47            -0.2        2.24        perf-profile.children.cycle=
s-pp.walk_component
>       2.21 =C2=B1  2%      -0.2        1.98        perf-profile.children.=
cycles-pp.___might_sleep
>       2.24            -0.2        2.02        perf-profile.children.cycle=
s-pp.syscall_return_via_sysret
>       9.32            -0.2        9.12        perf-profile.children.cycle=
s-pp.task_work_run
>       1.17            -0.2        0.97        perf-profile.children.cycle=
s-pp.ima_file_check
>       1.99            -0.2        1.80        perf-profile.children.cycle=
s-pp.__inode_security_revalidate
>       2.92            -0.2        2.73        perf-profile.children.cycle=
s-pp.security_file_open
>       0.56            -0.2        0.38        perf-profile.children.cycle=
s-pp.selinux_task_getsecid
>       0.69            -0.2        0.51        perf-profile.children.cycle=
s-pp.security_task_getsecid
>       2.40            -0.2        2.24        perf-profile.children.cycle=
s-pp.security_file_alloc
>       0.20 =C2=B1  4%      -0.1        0.06 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.try_module_get
>       1.44            -0.1        1.31        perf-profile.children.cycle=
s-pp.__might_sleep
>      10.01            -0.1        9.88        perf-profile.children.cycle=
s-pp.exit_to_usermode_loop
>       1.46            -0.1        1.33        perf-profile.children.cycle=
s-pp.inode_security_rcu
>       1.00            -0.1        0.87        perf-profile.children.cycle=
s-pp._cond_resched
>       5.20            -0.1        5.08        perf-profile.children.cycle=
s-pp.getname_flags
>       1.05            -0.1        0.93        perf-profile.children.cycle=
s-pp.__fsnotify_parent
>       1.42            -0.1        1.30        perf-profile.children.cycle=
s-pp.fsnotify
>       1.41            -0.1        1.29        perf-profile.children.cycle=
s-pp.__alloc_fd
>       2.29            -0.1        2.18        perf-profile.children.cycle=
s-pp.selinux_file_open
>       0.64            -0.1        0.53        perf-profile.children.cycle=
s-pp.__check_heap_object
>       1.42 =C2=B1  2%      -0.1        1.31 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.irq_exit
>       1.80            -0.1        1.69        perf-profile.children.cycle=
s-pp.terminate_walk
>       0.33            -0.1        0.23        perf-profile.children.cycle=
s-pp.file_ra_state_init
>       0.65 =C2=B1  3%      -0.1        0.56        perf-profile.children.=
cycles-pp.generic_permission
>       1.23            -0.1        1.15        perf-profile.children.cycle=
s-pp.fput_many
>       0.83 =C2=B1  3%      -0.1        0.74        perf-profile.children.=
cycles-pp._raw_spin_lock_irq
>       0.53            -0.1        0.45 =C2=B1  2%  perf-profile.children.=
cycles-pp.rcu_all_qs
>       0.58 =C2=B1  5%      -0.1        0.51 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.mntput_no_expire
>       0.75            -0.1        0.69        perf-profile.children.cycle=
s-pp.lockref_put_or_lock
>       1.03            -0.1        0.97        perf-profile.children.cycle=
s-pp.path_init
>       0.84            -0.1        0.78        perf-profile.children.cycle=
s-pp.task_work_add
>       0.14 =C2=B1  3%      -0.1        0.08 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.ima_file_free
>       0.26 =C2=B1  7%      -0.1        0.21 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.path_get
>       0.83            -0.0        0.78        perf-profile.children.cycle=
s-pp.__slab_free
>       0.62            -0.0        0.58        perf-profile.children.cycle=
s-pp.percpu_counter_add_batch
>       0.67            -0.0        0.63        perf-profile.children.cycle=
s-pp.rcu_segcblist_enqueue
>       0.20 =C2=B1 11%      -0.0        0.16 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.mntget
>       0.22 =C2=B1  4%      -0.0        0.19 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.get_unused_fd_flags
>       0.10 =C2=B1 14%      -0.0        0.07 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.close@plt
>       0.34 =C2=B1  2%      -0.0        0.31        perf-profile.children.=
cycles-pp.lockref_get
>       0.24            -0.0        0.21 =C2=B1  2%  perf-profile.children.=
cycles-pp.__x64_sys_open
>       0.11 =C2=B1  8%      -0.0        0.08 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.putname
>       0.18 =C2=B1  2%      -0.0        0.16        perf-profile.children.=
cycles-pp.should_failslab
>       0.55            -0.0        0.53        perf-profile.children.cycle=
s-pp.selinux_file_alloc_security
>       0.21 =C2=B1  3%      -0.0        0.19 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.expand_files
>       0.07 =C2=B1  6%      -0.0        0.05        perf-profile.children.=
cycles-pp.module_put
>       0.12            -0.0        0.10 =C2=B1  4%  perf-profile.children.=
cycles-pp.security_file_free
>       0.17            -0.0        0.15 =C2=B1  3%  perf-profile.children.=
cycles-pp.find_next_zero_bit
>       0.07 =C2=B1  5%      -0.0        0.06        perf-profile.children.=
cycles-pp.memset
>       0.07 =C2=B1  5%      -0.0        0.06        perf-profile.children.=
cycles-pp.__mutex_init
>       0.10            -0.0        0.09        perf-profile.children.cycle=
s-pp.mntput
>       0.12            +0.0        0.13 =C2=B1  3%  perf-profile.children.=
cycles-pp.__list_del_entry_valid
>       0.12 =C2=B1  3%      +0.0        0.14 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.discard_slab
>       0.08            +0.0        0.10 =C2=B1  4%  perf-profile.children.=
cycles-pp.kick_process
>       0.04 =C2=B1 57%      +0.0        0.07 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp.native_irq_return_iret
>       0.12 =C2=B1  4%      +0.0        0.15 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.blkcg_maybe_throttle_current
>       1.31            +0.0        1.34        perf-profile.children.cycle=
s-pp.memset_erms
>       0.40            +0.0        0.44        perf-profile.children.cycle=
s-pp.lockref_get_not_dead
>       0.07 =C2=B1  6%      +0.0        0.11 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.rcu_segcblist_pend_cbs
>       0.01 =C2=B1173%      +0.0        0.06 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.native_write_msr
>       0.27 =C2=B1  6%      +0.1        0.33 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.ktime_get
>       0.16 =C2=B1  5%      +0.1        0.22 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.get_partial_node
>       0.01 =C2=B1173%      +0.1        0.07 =C2=B1 30%  perf-profile.chil=
dren.cycles-pp.perf_mux_hrtimer_handler
>       0.00            +0.1        0.07 =C2=B1  5%  perf-profile.children.=
cycles-pp.____fput
>       0.05            +0.1        0.15 =C2=B1  3%  perf-profile.children.=
cycles-pp.__mod_zone_page_state
>       0.12 =C2=B1 16%      +0.1        0.23 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.ktime_get_update_offsets_now
>       0.05 =C2=B1  8%      +0.1        0.16 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.legitimize_links
>       1.71            +0.1        1.83        perf-profile.children.cycle=
s-pp.__call_rcu
>       3.40            +0.1        3.52        perf-profile.children.cycle=
s-pp.strncpy_from_user
>       0.30 =C2=B1  2%      +0.1        0.43 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.locks_remove_posix
>       0.72            +0.1        0.86        perf-profile.children.cycle=
s-pp.__virt_addr_valid
>       0.08            +0.1        0.23 =C2=B1  3%  perf-profile.children.=
cycles-pp._raw_spin_lock_irqsave
>       0.84 =C2=B1  9%      +0.2        1.02 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.hrtimer_interrupt
>       0.15 =C2=B1  3%      +0.2        0.38        perf-profile.children.=
cycles-pp.check_stack_object
>       0.65            +0.4        1.05        perf-profile.children.cycle=
s-pp.setup_object_debug
>       0.36            +0.4        0.76        perf-profile.children.cycle=
s-pp.get_page_from_freelist
>       1.90            +0.4        2.31        perf-profile.children.cycle=
s-pp.__check_object_size
>       0.39            +0.4        0.84        perf-profile.children.cycle=
s-pp.__alloc_pages_nodemask
>      39.52            +0.7       40.22        perf-profile.children.cycle=
s-pp.do_filp_open
>      38.84            +0.8       39.59        perf-profile.children.cycle=
s-pp.path_openat
>      31.27            +0.8       32.05        perf-profile.children.cycle=
s-pp.rcu_core
>      31.26            +0.8       32.03        perf-profile.children.cycle=
s-pp.rcu_do_batch
>      31.31            +0.8       32.09        perf-profile.children.cycle=
s-pp.__softirqentry_text_start
>      29.90            +0.9       30.79        perf-profile.children.cycle=
s-pp.run_ksoftirqd
>      29.93            +0.9       30.84        perf-profile.children.cycle=
s-pp.smpboot_thread_fn
>      29.94            +0.9       30.85        perf-profile.children.cycle=
s-pp.kthread
>      29.94            +0.9       30.85        perf-profile.children.cycle=
s-pp.ret_from_fork
>      10.63 =C2=B1  2%      +1.0       11.61        perf-profile.children.=
cycles-pp.kmem_cache_free
>       8.45 =C2=B1  3%      +1.1        9.57        perf-profile.children.=
cycles-pp._raw_spin_lock
>       7.96 =C2=B1  3%      +1.1        9.11        perf-profile.children.=
cycles-pp.__free_pages_ok
>       7.93 =C2=B1  3%      +1.2        9.08        perf-profile.children.=
cycles-pp.free_one_page
>       8.19 =C2=B1  3%      +1.2        9.36        perf-profile.children.=
cycles-pp.put_cpu_partial
>       8.15 =C2=B1  3%      +1.2        9.32        perf-profile.children.=
cycles-pp.unfreeze_partials
>       7.59 =C2=B1  3%      +1.3        8.89        perf-profile.children.=
cycles-pp.native_queued_spin_lock_slowpath
>      11.12            +1.7       12.83        perf-profile.children.cycle=
s-pp.rcu_cblist_dequeue
>       2.88            +1.7        4.61        perf-profile.children.cycle=
s-pp.new_slab
>       8.73            +1.8       10.54        perf-profile.children.cycle=
s-pp.kmem_cache_alloc
>       3.34            +2.2        5.56        perf-profile.children.cycle=
s-pp.___slab_alloc
>       3.39            +2.3        5.65        perf-profile.children.cycle=
s-pp.__slab_alloc
>      11.45            +2.7       14.12        perf-profile.children.cycle=
s-pp.alloc_empty_file
>      10.98            +2.7       13.70        perf-profile.children.cycle=
s-pp.__alloc_file
>      10.53            -2.1        8.47        perf-profile.self.cycles-pp=
.file_free_rcu
>       2.37            -0.3        2.05        perf-profile.self.cycles-pp=
.kmem_cache_alloc
>       1.43            -0.3        1.17        perf-profile.self.cycles-pp=
.strncpy_from_user
>       0.50            -0.2        0.26 =C2=B1  2%  perf-profile.self.cycl=
es-pp.__close_fd
>       2.22            -0.2        2.00        perf-profile.self.cycles-pp=
.syscall_return_via_sysret
>       2.07 =C2=B1  2%      -0.2        1.86        perf-profile.self.cycl=
es-pp.___might_sleep
>       1.01 =C2=B1  7%      -0.2        0.82        perf-profile.self.cycl=
es-pp.inode_permission
>       1.13            -0.2        0.96 =C2=B1  2%  perf-profile.self.cycl=
es-pp.entry_SYSCALL_64
>       3.10            -0.2        2.93        perf-profile.self.cycles-pp=
.selinux_inode_permission
>       0.52            -0.2        0.35        perf-profile.self.cycles-pp=
.selinux_task_getsecid
>       1.33            -0.1        1.18 =C2=B1  2%  perf-profile.self.cycl=
es-pp.do_dentry_open
>       1.55            -0.1        1.42        perf-profile.self.cycles-pp=
.kmem_cache_free
>       1.55            -0.1        1.43        perf-profile.self.cycles-pp=
.link_path_walk
>       0.17 =C2=B1  4%      -0.1        0.04 =C2=B1 57%  perf-profile.self=
.cycles-pp.try_module_get
>       1.35            -0.1        1.24        perf-profile.self.cycles-pp=
.fsnotify
>       0.96            -0.1        0.85        perf-profile.self.cycles-pp=
.__fsnotify_parent
>       1.25 =C2=B1  2%      -0.1        1.14        perf-profile.self.cycl=
es-pp.__might_sleep
>       0.87 =C2=B1  2%      -0.1        0.78 =C2=B1  2%  perf-profile.self=
.cycles-pp.lookup_fast
>       0.79 =C2=B1  2%      -0.1        0.70 =C2=B1  2%  perf-profile.self=
.cycles-pp.do_syscall_64
>       1.02            -0.1        0.93        perf-profile.self.cycles-pp=
.do_sys_open
>       0.30            -0.1        0.22        perf-profile.self.cycles-pp=
.file_ra_state_init
>       0.58            -0.1        0.50        perf-profile.self.cycles-pp=
.__check_heap_object
>       0.80 =C2=B1  3%      -0.1        0.72        perf-profile.self.cycl=
es-pp._raw_spin_lock_irq
>       0.59 =C2=B1  2%      -0.1        0.52 =C2=B1  2%  perf-profile.self=
.cycles-pp.generic_permission
>       1.17            -0.1        1.09        perf-profile.self.cycles-pp=
.__fput
>       0.68            -0.1        0.60        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       0.84            -0.1        0.77        perf-profile.self.cycles-pp=
.__inode_security_revalidate
>       0.73            -0.1        0.66        perf-profile.self.cycles-pp=
.task_work_add
>       0.39            -0.1        0.32 =C2=B1  2%  perf-profile.self.cycl=
es-pp.rcu_all_qs
>       0.54 =C2=B1  5%      -0.1        0.47 =C2=B1  2%  perf-profile.self=
.cycles-pp.mntput_no_expire
>       0.50 =C2=B1  6%      -0.1        0.44 =C2=B1  4%  perf-profile.self=
.cycles-pp.dput
>       0.46            -0.1        0.40        perf-profile.self.cycles-pp=
._cond_resched
>       0.93            -0.1        0.88 =C2=B1  2%  perf-profile.self.cycl=
es-pp.close
>       0.11 =C2=B1  4%      -0.1        0.06 =C2=B1 11%  perf-profile.self=
.cycles-pp.ima_file_free
>       0.83            -0.1        0.77        perf-profile.self.cycles-pp=
.__slab_free
>       0.61            -0.1        0.56        perf-profile.self.cycles-pp=
.__alloc_fd
>       0.87            -0.1        0.82        perf-profile.self.cycles-pp=
._raw_spin_lock
>       0.69            -0.0        0.64        perf-profile.self.cycles-pp=
.lockref_put_or_lock
>       0.67            -0.0        0.62        perf-profile.self.cycles-pp=
.rcu_segcblist_enqueue
>       0.46            -0.0        0.41        perf-profile.self.cycles-pp=
.do_filp_open
>       0.56            -0.0        0.51        perf-profile.self.cycles-pp=
.percpu_counter_add_batch
>       1.05 =C2=B1  2%      -0.0        1.01        perf-profile.self.cycl=
es-pp.path_openat
>       0.28 =C2=B1  2%      -0.0        0.24 =C2=B1  4%  perf-profile.self=
.cycles-pp.security_file_open
>       0.94 =C2=B1  2%      -0.0        0.90        perf-profile.self.cycl=
es-pp.open64
>       0.21 =C2=B1  6%      -0.0        0.17 =C2=B1  4%  perf-profile.self=
.cycles-pp.get_unused_fd_flags
>       0.17 =C2=B1 13%      -0.0        0.14 =C2=B1  3%  perf-profile.self=
.cycles-pp.mntget
>       0.39            -0.0        0.35        perf-profile.self.cycles-pp=
.fput_many
>       0.37            -0.0        0.34        perf-profile.self.cycles-pp=
.getname_flags
>       0.43            -0.0        0.41        perf-profile.self.cycles-pp=
.path_init
>       0.33            -0.0        0.30 =C2=B1  2%  perf-profile.self.cycl=
es-pp.lockref_get
>       0.20 =C2=B1  2%      -0.0        0.17        perf-profile.self.cycl=
es-pp.filp_close
>       0.52            -0.0        0.50        perf-profile.self.cycles-pp=
.selinux_file_alloc_security
>       0.22            -0.0        0.20 =C2=B1  2%  perf-profile.self.cycl=
es-pp.__x64_sys_open
>       0.28 =C2=B1  2%      -0.0        0.26        perf-profile.self.cycl=
es-pp.inode_security_rcu
>       0.19 =C2=B1  4%      -0.0        0.17 =C2=B1  2%  perf-profile.self=
.cycles-pp.expand_files
>       0.09 =C2=B1  9%      -0.0        0.07 =C2=B1  6%  perf-profile.self=
.cycles-pp.putname
>       0.10            -0.0        0.08 =C2=B1  5%  perf-profile.self.cycl=
es-pp.security_file_free
>       0.15 =C2=B1  3%      -0.0        0.14 =C2=B1  3%  perf-profile.self=
.cycles-pp.find_next_zero_bit
>       0.12 =C2=B1  3%      -0.0        0.11 =C2=B1  4%  perf-profile.self=
.cycles-pp.nd_jump_root
>       0.08            -0.0        0.07        perf-profile.self.cycles-pp=
.fd_install
>       0.06            -0.0        0.05        perf-profile.self.cycles-pp=
.path_get
>       0.12            +0.0        0.13 =C2=B1  3%  perf-profile.self.cycl=
es-pp.__list_del_entry_valid
>       0.07 =C2=B1  5%      +0.0        0.09        perf-profile.self.cycl=
es-pp.get_partial_node
>       0.12 =C2=B1  3%      +0.0        0.14 =C2=B1  3%  perf-profile.self=
.cycles-pp.discard_slab
>       0.11            +0.0        0.13 =C2=B1  3%  perf-profile.self.cycl=
es-pp.blkcg_maybe_throttle_current
>       0.06            +0.0        0.08 =C2=B1  5%  perf-profile.self.cycl=
es-pp.kick_process
>       0.28 =C2=B1  2%      +0.0        0.30        perf-profile.self.cycl=
es-pp.__x64_sys_close
>       0.04 =C2=B1 57%      +0.0        0.07 =C2=B1  7%  perf-profile.self=
.cycles-pp.native_irq_return_iret
>       0.39            +0.0        0.42        perf-profile.self.cycles-pp=
.lockref_get_not_dead
>       0.53            +0.0        0.57        perf-profile.self.cycles-pp=
.exit_to_usermode_loop
>       0.06 =C2=B1  7%      +0.0        0.10 =C2=B1  4%  perf-profile.self=
.cycles-pp.rcu_segcblist_pend_cbs
>       0.01 =C2=B1173%      +0.0        0.06 =C2=B1 11%  perf-profile.self=
.cycles-pp.native_write_msr
>       0.28            +0.0        0.33        perf-profile.self.cycles-pp=
.terminate_walk
>       0.27 =C2=B1  5%      +0.1        0.32 =C2=B1 11%  perf-profile.self=
.cycles-pp.ktime_get
>       0.00            +0.1        0.05 =C2=B1  9%  perf-profile.self.cycl=
es-pp._raw_spin_lock_irqsave
>       0.43 =C2=B1  5%      +0.1        0.49 =C2=B1  3%  perf-profile.self=
.cycles-pp.security_inode_permission
>       0.00            +0.1        0.06 =C2=B1  6%  perf-profile.self.cycl=
es-pp.____fput
>       0.00            +0.1        0.08        perf-profile.self.cycles-pp=
.__alloc_pages_nodemask
>       0.05            +0.1        0.15 =C2=B1  3%  perf-profile.self.cycl=
es-pp.__mod_zone_page_state
>       0.25 =C2=B1  3%      +0.1        0.35 =C2=B1  2%  perf-profile.self=
.cycles-pp.locks_remove_posix
>       0.12 =C2=B1 17%      +0.1        0.23 =C2=B1 11%  perf-profile.self=
.cycles-pp.ktime_get_update_offsets_now
>       0.14            +0.1        0.25        perf-profile.self.cycles-pp=
.setup_object_debug
>       0.93            +0.1        1.04        perf-profile.self.cycles-pp=
.__call_rcu
>       0.46            +0.1        0.58        perf-profile.self.cycles-pp=
.__check_object_size
>       0.13 =C2=B1  3%      +0.1        0.26 =C2=B1  3%  perf-profile.self=
.cycles-pp.get_page_from_freelist
>       0.00            +0.1        0.13 =C2=B1  3%  perf-profile.self.cycl=
es-pp.legitimize_links
>       0.68            +0.1        0.81        perf-profile.self.cycles-pp=
.__virt_addr_valid
>       0.40 =C2=B1 11%      +0.2        0.58        perf-profile.self.cycl=
es-pp.may_open
>       0.12            +0.2        0.31        perf-profile.self.cycles-pp=
.check_stack_object
>       0.90            +0.3        1.22        perf-profile.self.cycles-pp=
.task_work_run
>       0.30            +0.4        0.73        perf-profile.self.cycles-pp=
.___slab_alloc
>       2.88            +0.7        3.59        perf-profile.self.cycles-pp=
.__alloc_file
>       2.27            +1.1        3.38        perf-profile.self.cycles-pp=
.new_slab
>       7.59 =C2=B1  3%      +1.3        8.89        perf-profile.self.cycl=
es-pp.native_queued_spin_lock_slowpath
>      11.04            +1.7       12.73        perf-profile.self.cycles-pp=
.rcu_cblist_dequeue
>
>
>
>                             will-it-scale.per_process_ops
>
>   385000 +-+-------------------------------------------------------------=
---+
>          |     .+                     .+.      .+                        =
   |
>   380000 +-+.++  :              +.++.+   +.++.+  :                       =
   |
>   375000 +-+     :             +                 :                       =
   |
>          |        +.+   .+.++.+                   ++.      .+.+.+ .+.+.+ =
.+.|
>   370000 +-+         +.+                             +.+.++      +      +=
   |
>   365000 +-+                                                             =
   |
>          |                                                               =
   |
>   360000 +-+                                                             =
   |
>   355000 +-+                                                             =
   |
>          |                                                               =
   |
>   350000 +-+                                                             =
   |
>   345000 O-+ OO O O OO O O OO O O O                                      =
   |
>          | O                       O O O O OO O O                        =
   |
>   340000 +-+-------------------------------------------------------------=
---+
>
>
>                                 will-it-scale.workload
>
>   7.4e+07 +-+------------------------------------------------------------=
---+
>           |     .+                     .+      .+                        =
   |
>   7.3e+07 +-++.+  :              ++.+.+  +.+.++  :                       =
   |
>   7.2e+07 +-+     :             +                :                       =
   |
>           |        ++.   .++.+.+                  +.+       +.+.+.++.+.+.=
 +.|
>   7.1e+07 +-+         +.+                            +.+.+.+             =
+  |
>     7e+07 +-+                                                            =
   |
>           |                                                              =
   |
>   6.9e+07 +-+                                                            =
   |
>   6.8e+07 +-+                                                            =
   |
>           |                                                              =
   |
>   6.7e+07 +-+           O        O                                       =
   |
>   6.6e+07 O-OO O O OO O   OO O O  O O   O  O  O                          =
   |
>           |                           O  O   O  O                        =
   |
>   6.5e+07 +-+------------------------------------------------------------=
---+
>
>
> [*] bisect-good sample
> [O] bisect-bad  sample
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> Thanks,
> Rong Chen
>
