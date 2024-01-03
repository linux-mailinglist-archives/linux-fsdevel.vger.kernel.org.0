Return-Path: <linux-fsdevel+bounces-7308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079782384E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF2B2433F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3A1EB22;
	Wed,  3 Jan 2024 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl+vX4Oe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959B1DA47;
	Wed,  3 Jan 2024 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d3e416f303so29946645ad.0;
        Wed, 03 Jan 2024 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321743; x=1704926543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2o79Clmrb9FkIJudFBFfSbAxebiLPm5T17yigE3miZs=;
        b=Cl+vX4OeCkw1sX6E8IuL1gmLNvcfNClyXnfRbmCEmbGhuevM8w1B/EcFeYWehEZWkX
         I2R2rtNdV3uD09YJffceqiTtLq4qLlPcNLErxmQHxy4tr91DVKijjOVEL8yTG6oKsUWK
         VbnFdgASaV5jiF/egJuZCJwk/tF+DQZ747ZmuvbpnWZtA+Hh9bmNNAnKE/CyHrxRUtQ7
         n5I/A3DpwskU78SVsm9MsNk73YvBwYXAPC4GP63nDzica+E9SSzFWl+VbTG+0bVZ9a5Z
         ntKQXcisYrkiwT77I8PXhKD87XWC03td3hB05mbwuCwyl35k6Y+6Tp/1pbLoK6q+szWH
         N2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321743; x=1704926543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o79Clmrb9FkIJudFBFfSbAxebiLPm5T17yigE3miZs=;
        b=quB6nD1j0TqhObsPRtwMGl8iZ5iKyIk5vdtfYvY5QmVIt063qMr9Lj6MCoMhZMeDua
         JTOu7Hqgp+RKWj/hf5erwNdIZYiYx4Fm8ltPUX5P9fkMTV9pS7FGKX0o/e7AExGmWnHS
         +jvorq3jV1hF3F2tid/HF3EvesahBfm82+nGgHp5VEjOur9ek3HGoTebWsGqgDZ2afRM
         MxZOkGWaUuzE5MMSFT3VrtaOS0hOrP2pBOOW9Y8VzKDyxfrC/mHUKTMjm1KxusJLaayO
         zUG5/TcvnuWTT20WfB/i62v1QHKKPlII2TcTEu0R7smlaW3sspws3wUsvMZfeJoCVEOI
         DcxA==
X-Gm-Message-State: AOJu0Ywhawps5tMbJg0HN+PZj5hF4gGKYATFTLzAsUK7jfcp3pfINgYn
	lMlr8g1eWUWaFA+l006TlQ==
X-Google-Smtp-Source: AGHT+IEXJq0iP8cp/+HMzRFy5uzU31n/vWofcAaF+sV6qi26eBn0PRfWoNfeWKB0DcR+AjQDUZCQYA==
X-Received: by 2002:a17:902:6a8c:b0:1d0:6ffe:1ea7 with SMTP id n12-20020a1709026a8c00b001d06ffe1ea7mr6887780plk.138.1704321742700;
        Wed, 03 Jan 2024 14:42:22 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:42:22 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>,
	Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v6 00/12] mempolicy2, mbind2, and weighted interleave
Date: Wed,  3 Jan 2024 17:41:57 -0500
Message-Id: <20240103224209.2541-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Weighted interleave is a new interleave policy intended to make
use of heterogeneous memory environments appearing with CXL.

To implement weighted interleave with task-local weights, we
need new syscalls capable of passing a weight array. This is
the justification for mempolicy2/mbind2 - which are designed
to be extensible to capture future policies as well.


The existing interleave mechanism does an even round-robin
distribution of memory across all nodes in a nodemask, while
weighted interleave distributes memory across nodes according
to a provided weight. (Weight = # of page allocations per round)

Weighted interleave is intended to reduce average latency when
bandwidth is pressured - therefore increasing total throughput.
In other words: It allows greater use of the total available
bandwidth in a heterogeneous hardware environment (different
hardware provides different bandwidth capacity).

As bandwidth is pressured, latency increases - first linearly
and then exponentially. By keeping bandwidth usage distributed
according to available bandwidth, we therefore can reduce the
average latency of a cacheline fetch.

A good explanation of the bandwidth vs latency response curve:
https://mahmoudhatem.wordpress.com/2017/11/07/memory-bandwidth-vs-latency-response-curve/

From the article:
```
Constant region:
    The latency response is fairly constant for the first 40%
    of the sustained bandwidth.
Linear region:
    In between 40% to 80% of the sustained bandwidth, the
    latency response increases almost linearly with the bandwidth
    demand of the system due to contention overhead by numerous
    memory requests.
Exponential region:
    Between 80% to 100% of the sustained bandwidth, the memory
    latency is dominated by the contention latency which can be
    as much as twice the idle latency or more.
Maximum sustained bandwidth :
    Is 65% to 75% of the theoretical maximum bandwidth.
```

As a general rule of thumb:
  * If bandwidth usage is low, latency does not increase. It is
    optimal to place data in the nearest (lowest latency) device.
  * If bandwidth usage is high, latency increases. It is optimal
    to place data such that bandwidth use is optimized per-device.

This is the top line goal: Provide a user a mechanism to target using
the "maximum sustained bandwidth" of each hardware component in a
heterogenous memory system.


For example, the stream benchmark demonstrates that default interleave
is actively harmful, where weighted interleave is beneficial. Default
interleave distributes data such that too much pressure is placed on
devices with lower available bandwidth.

Stream Benchmark (High level results, 1 Socket + 1 CXL Device)
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
Targeted weights   : +2.5% to +4% (consistently better than DRAM)

Global means the task-policy was set (set_mempolicy2), while targeted
means VMA policies were set (mbind2). We can see weighted interleave
is not always beneficial when applied globally, but is always
beneficial when applied to bandwidth-driving data areas. This is a
good reason to provide both mechanisms (Simplicity vs Control).


We implement sysfs entries for "system global" weights which can be
set by a daemon or administrator, and new extensible syscalls
(mempolicy2, mbind2) for task-local weights to be set by either
numactl or user-software.

We chose to implement an extensible mempolicy interface so that
future extensions can be captured, rather than adding additional
syscalls for every new mempolicy which requires new data.

MPOL_WEIGHTED_INTERLEAVE is included as an example extension.

There are 3 "phases" in the patch set that could be considered
for separate merge candidates, but are presented here as a single
line as the goal is a fully functional MPOL_WEIGHTED_INTERLEAVE.

1) Implement MPOL_WEIGHTED_INTERLEAVE with a sysfs extension for
   setting system-global weights via sysfs.
   (Patches 1-3)

2) Refactor mempolicy creation mechanism to use an extensible arg
   struct `struct mempolicy_param` to promote code re-use between
   the original mempolicy/mbind interfaces and the new interfaces.
   (Patches 4-7)

3) Implementation of set_mempolicy2, get_mempolicy2, and mbind2,
   along with the addition of task-local weights so that per-task
   weights can be registered for MPOL_WEIGHTED_INTERLEAVE.
   (Patches 8-12)

Included below is LTP test information, performance test information,
and some software / numactl branch which can be used for testing.

= Performance summary =
(tests may have different configurations, see extended info below)
1) MLC (W2) : +38% over DRAM. +264% over default interleave.
   MLC (W5) : +40% over DRAM. +226% over default interleave.
2) Stream   : -6% to +4% over DRAM, +430% over default interleave.
3) XSBench  : +19% over DRAM. +47% over default interleave.

= LTP Testing Summary =
existing mempolicy & mbind tests: pass
mempolicy & mbind + weighted interleave (global weights): pass
mempolicy2 & mbind2 + weighted interleave (global weights): pass
mempolicy2 & mbind2 + weighted interleave (local weights): pass

= v6 notes =
- bug: resolved excessive stack usage w/ scratch area
- bug: bulk allocator uninitialized value (prev_node = NUMA_NO_NODE)
- bug: global weights should be unsigned (char -> u8)
- bug: return value in get_mempolicy (thanks dan.carpenter@linaro.org)
- refactor: refactor read_once operations into functions
- change: reduce mpol_params->pol_maxnodes size from u64 to u16
- change: add weight scratch space in mempolicy used during allocation
- change: kill MPOL_F_GWEIGHT flag
- change: 0-weight now implies "use global/default"
- change: simplify bulk allocator logic
- change: weights are now all u8 for consistency
- change: add default_iw_table (system default separate from sysfs)
- change: _args to _param in struct names
- change: sanitize_flags simplification
- documentation updates

=====================================================================
Performance tests - MLC
From - Ravi Jonnalagadda <ravis.opensrc@micron.com>

Hardware: Single-socket, multiple CXL memory expanders.

Workload:                               W2
Data Signature:                         2:1 read:write
DRAM only bandwidth (GBps):             298.8
DRAM + CXL (default interleave) (GBps): 113.04
DRAM + CXL (weighted interleave)(GBps): 412.5
Gain over DRAM only:                    1.38x
Gain over default interleave:           2.64x

Workload:                               W5
Data Signature:                         1:1 read:write
DRAM only bandwidth (GBps):             273.2
DRAM + CXL (default interleave) (GBps): 117.23
DRAM + CXL (weighted interleave)(GBps): 382.7
Gain over DRAM only:                    1.4x
Gain over default interleave:           2.26x

=====================================================================
Performance test - Stream
From - Gregory Price <gregory.price@memverge.com>

Hardware: Single socket, single CXL expander
numactl extension: https://github.com/gmprice/numactl/tree/weighted_interleave_master

Summary: 64 threads, ~18GB workload, 3GB per array, executed 100 times
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
mbind2 weights     : +2.5% to +4% (consistently better than DRAM)

dram only:
numactl --cpunodebind=1 --membind=1 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Function     Direction    BestRateMBs     AvgTime      MinTime      MaxTime
Copy:        0->0            200923.2     0.032662     0.031853     0.033301
Scale:       0->0            202123.0     0.032526     0.031664     0.032970
Add:         0->0            208873.2     0.047322     0.045961     0.047884
Triad:       0->0            208523.8     0.047262     0.046038     0.048414

CXL-only:
numactl --cpunodebind=1 -w --membind=2 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Copy:        0->0             22209.7     0.288661     0.288162     0.289342
Scale:       0->0             22288.2     0.287549     0.287147     0.288291
Add:         0->0             24419.1     0.393372     0.393135     0.393735
Triad:       0->0             24484.6     0.392337     0.392083     0.394331

Based on the above, the optimal weights are ~9:1
echo 9 > /sys/kernel/mm/mempolicy/weighted_interleave/node1
echo 1 > /sys/kernel/mm/mempolicy/weighted_interleave/node2

default interleave:
numactl --cpunodebind=1 --interleave=1,2 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Copy:        0->0             44666.2     0.143671     0.143285     0.144174
Scale:       0->0             44781.6     0.143256     0.142916     0.143713
Add:         0->0             48600.7     0.197719     0.197528     0.197858
Triad:       0->0             48727.5     0.197204     0.197014     0.197439

global weighted interleave:
numactl --cpunodebind=1 -w --interleave=1,2 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Copy:        0->0            190085.9     0.034289     0.033669     0.034645
Scale:       0->0            207677.4     0.031909     0.030817     0.033061
Add:         0->0            202036.8     0.048737     0.047516     0.053409
Triad:       0->0            217671.5     0.045819     0.044103     0.046755

targted regions w/ global weights (modified stream to mbind2 malloc'd regions))
numactl --cpunodebind=1 --membind=1 ./stream_c.exe -b --ntimes 100 --array-size 400M --malloc
Copy:        0->0            205827.0     0.031445     0.031094     0.031984
Scale:       0->0            208171.8     0.031320     0.030744     0.032505
Add:         0->0            217352.0     0.045087     0.044168     0.046515
Triad:       0->0            216884.8     0.045062     0.044263     0.046982

=====================================================================
Performance tests - XSBench
From - Hyeongtak Ji <hyeongtak.ji@sk.com>

Hardware: Single socket, Single CXL memory Expander

NUMA node 0: 56 logical cores, 128 GB memory
NUMA node 2: 96 GB CXL memory
Threads:     56
Lookups:     170,000,000

Summary: +19% over DRAM. +47% over default interleave.

Performance tests - XSBench
1. dram only
$ numactl -m 0 ./XSBench -s XL –p 5000000
Runtime:     36.235 seconds
Lookups/s:   4,691,618

2. default interleave
$ numactl –i 0,2 ./XSBench –s XL –p 5000000
Runtime:     55.243 seconds
Lookups/s:   3,077,293

3. weighted interleave
numactl –w –i 0,2 ./XSBench –s XL –p 5000000
Runtime:     29.262 seconds
Lookups/s:   5,809,513

=====================================================================
LTP Tests: https://github.com/gmprice/ltp/tree/mempolicy2

= Existing tests
set_mempolicy, get_mempolicy, mbind

MPOL_WEIGHTED_INTERLEAVE added manually to test basic functionality
but did not adjust tests for weighting.  Basically the weights were
set to 1, which is the default, and it should behavior like standard
MPOL_INTERLEAVE if logic is correct.

== set_mempolicy01 : passed   18, failed   0
== set_mempolicy02 : passed   10, failed   0
== set_mempolicy03 : passed   64, failed   0
== set_mempolicy04 : passed   32, failed   0
== set_mempolicy05 - n/a on non-x86
== set_mempolicy06 : passed   10, failed   0
   this is set_mempolicy02 + MPOL_WEIGHTED_INTERLEAVE
== set_mempolicy07 : passed   32, failed   0
   set_mempolicy04 + MPOL_WEIGHTED_INTERLEAVE
== get_mempolicy01 : passed   12, failed   0
   change: added MPOL_WEIGHTED_INTERLEAVE
== get_mempolicy02 : passed   2, failed   0
== mbind01 : passed   15, failed   0
   added MPOL_WEIGHTED_INTERLEAVE
== mbind02 : passed   4, failed   0
   added MPOL_WEIGHTED_INTERLEAVE
== mbind03 : passed   16, failed   0
   added MPOL_WEIGHTED_INTERLEAVE
== mbind04 : passed   48, failed   0
   added MPOL_WEIGHTED_INTERLEAVE

= New Tests
set_mempolicy2, get_mempolicy2, mbind2

Took the original set_mempolicy and get_mempolicy tests, and updated
them to utilize the new mempolicy2 interfaces.  Added additional tests
for setting task-local weights to validate behavior.

== set_mempolicy201  : passed   18, failed   0
== set_mempolicy202  : passed   10, failed   0
== set_mempolicy203  : passed   64, failed   0
== set_mempolicy204  : passed   32, failed   0
== set_mempolicy205  : passed   10, failed   0
== set_mempolicy206  : passed   32, failed   0
== set_mempolicy207  : passed   6, failed   0
   new: MPOL_WEIGHTED_INTERLEAVE with task-local weights
== get_mempolicy201  : passed   12, failed   0
== get_mempolicy202  : passed   2, failed   0
== get_mempolicy203  : passed   6, failed   0
   new: fetch global and local weights
== mbind201  : passed   15, failed   0
== mbind202  : passed   4, failed   0
== mbind203  : passed   16, failed   0
== mbind204  : passed   48, failed   0

=====================================================================
Basic set_mempolicy2 test

set_mempolicy2 w/ weighted interleave, task-local weights and uses
pthread_create to demonstrate the mempolicy is overwritten by child.

Manually validating the distribution via numa_maps

007c0000 weighted interleave:0-1 heap anon=65794 dirty=65794 active=0 N0=54829 N1=10965 kernelpagesize_kB=4
7f3f2c000000 weighted interleave:0-1 anon=32768 dirty=32768 active=0 N0=5461 N1=27307 kernelpagesize_kB=4
7f3f34000000 weighted interleave:0-1 anon=16384 dirty=16384 active=0 N0=2731 N1=13653 kernelpagesize_kB=4
7f3f3bffe000 weighted interleave:0-1 anon=65538 dirty=65538 active=0 N0=10924 N1=54614 kernelpagesize_kB=4
7f3f5c000000 weighted interleave:0-1 anon=16384 dirty=16384 active=0 N0=2731 N1=13653 kernelpagesize_kB=4
7f3f60dfe000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=54615 N1=10922 kernelpagesize_kB=4

Expected distribution is 5:1 or 1:5 (less node should be ~16.666%)
1) 10965/65794 : 16.6656...
2) 5461/32768  : 16.6656...
3) 2731/16384  : 16.6687...
4) 10924/65538 : 16.6682...
5) 2731/16384  : 16.6687...
6) 10922/65537 : 16.6653...


#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <numa.h>
#include <errno.h>
#include <numaif.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/uio.h>
#include <sys/types.h>
#include <stdint.h>

#define MPOL_WEIGHTED_INTERLEAVE 6
#define SET_MEMPOLICY2(a, b) syscall(457, a, b, 0)

#define M256 (1024*1024*256)
#define PAGE_SIZE (4096)

struct mpol_param {
        /* Basic mempolicy settings */
        uint16_t mode;
        uint16_t mode_flags;
        int32_t home_node;
        uint16_t pol_maxnodes;
        uint8_t  resv[6];
        uint64_t pol_nodes;
        uint64_t il_weights;
};

struct mpol_param wil_param;
struct bitmask *wil_nodes;
unsigned char *weights;
int total_nodes = -1;
pthread_t tid;

void set_mempolicy_call(int which)
{
        weights = (unsigned char *)calloc(total_nodes, sizeof(unsigned char));
        wil_nodes = numa_allocate_nodemask();

        numa_bitmask_setbit(wil_nodes, 0); weights[0] = which ? 1 : 5;
        numa_bitmask_setbit(wil_nodes, 1); weights[1] = which ? 5 : 1;

        memset(&wil_param, 0, sizeof(wil_param));
        wil_param.mode = MPOL_WEIGHTED_INTERLEAVE;
        wil_param.mode_flags = 0;
        wil_param.pol_nodes = wil_nodes->maskp;
        wil_param.pol_maxnodes = total_nodes;
        wil_param.il_weights = weights;

        int ret = SET_MEMPOLICY2(&wil_param, sizeof(wil_param));
        fprintf(stderr, "set_mempolicy2 result: %d(%s)\n", ret, strerror(errno));
}

void *func(void *arg)
{
        char *mainmem = malloc(M256);
        int i;

        set_mempolicy_call(1); /* weight 1 heavier */

        mainmem = malloc(M256);
        memset(mainmem, 1, M256);
        for (i = 0; i < (M256/PAGE_SIZE); i++) {
                mainmem = malloc(PAGE_SIZE);
                mainmem[0] = 1;
        }
        printf("thread done %d\n", getpid());
        getchar();
        return arg;
}

int main()
{
        char * mainmem;
        int i;

        total_nodes = numa_max_node() + 1;

        set_mempolicy_call(0); /* weight 0 heavier */
        pthread_create(&tid, NULL, func, NULL);

        mainmem = malloc(M256);
        memset(mainmem, 1, M256);
        for (i = 0; i < (M256/PAGE_SIZE); i++) {
                mainmem = malloc(PAGE_SIZE);
                mainmem[0] = 1;
        }
        printf("main done %d\n", getpid());
        getchar();

        return 0;
}

=====================================================================
numactl (set_mempolicy) w/ global weighting test
numactl fork: https://github.com/gmprice/numactl/tree/weighted_interleave_master

command: numactl -w --interleave=0,1 ./eatmem

result (weights 1:1):
0176a000 weighted interleave:0-1 heap anon=65793 dirty=65793 active=0 N0=32897 N1=32896 kernelpagesize_kB=4
7fceeb9ff000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=32768 N1=32769 kernelpagesize_kB=4
50% distribution is correct

result (weights 5:1):
01b14000 weighted interleave:0-1 heap anon=65793 dirty=65793 active=0 N0=54828 N1=10965 kernelpagesize_kB=4
7f47a1dff000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=54614 N1=10923 kernelpagesize_kB=4
16.666% distribution is correct

result (weights 1:5):
01f07000 weighted interleave:0-1 heap anon=65793 dirty=65793 active=0 N0=10966 N1=54827 kernelpagesize_kB=4
7f17b1dff000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=10923 N1=54614 kernelpagesize_kB=4
16.666% distribution is correct

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main (void)
{
        char* mem = malloc(1024*1024*256);
        memset(mem, 1, 1024*1024*256);
        for (int i = 0; i  < ((1024*1024*256)/4096); i++)
        {
                mem = malloc(4096);
                mem[0] = 1;
        }
        printf("done\n");
        getchar();
        return 0;
}

=====================================================================

Suggested-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Hasan Al Maruf <hasanalmaruf@fb.com>
Suggested-by: Hao Wang <haowang3@fb.com>
Suggested-by: Ying Huang <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: tj <tj@kernel.org>
Suggested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: John Groves <john@jagalactic.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Suggested-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>


Gregory Price (11):
  mm/mempolicy: refactor a read-once mechanism into a function for
    re-use
  mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted
    interleaving
  mm/mempolicy: refactor sanitize_mpol_flags for reuse
  mm/mempolicy: create struct mempolicy_param for creating new
    mempolicies
  mm/mempolicy: refactor kernel_get_mempolicy for code re-use
  mm/mempolicy: allow home_node to be set by mpol_new
  mm/mempolicy: add userland mempolicy arg structure
  mm/mempolicy: add set_mempolicy2 syscall
  mm/mempolicy: add get_mempolicy2 syscall
  mm/mempolicy: add the mbind2 syscall
  mm/mempolicy: extend mempolicy2 and mbind2 to support weighted
    interleave

Rakie Kim (1):
  mm/mempolicy: implement the sysfs-based weighted_interleave interface

 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  26 +
 .../admin-guide/mm/numa_memory_policy.rst     |  67 ++
 arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
 arch/arm/tools/syscall.tbl                    |   3 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   6 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   3 +
 arch/s390/kernel/syscalls/syscall.tbl         |   3 +
 arch/sh/kernel/syscalls/syscall.tbl           |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   3 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   3 +
 include/linux/mempolicy.h                     |  19 +
 include/linux/syscalls.h                      |   8 +
 include/uapi/asm-generic/unistd.h             |   8 +-
 include/uapi/linux/mempolicy.h                |  16 +-
 kernel/sys_ni.c                               |   3 +
 mm/mempolicy.c                                | 976 +++++++++++++++---
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
 29 files changed, 1062 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

-- 
2.39.1


