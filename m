Return-Path: <linux-fsdevel+bounces-77870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AiCDvjVmmm8kgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 11:10:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0816ED28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 11:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9155E3017274
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Feb 2026 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E422B594;
	Sun, 22 Feb 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lX43CNHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810881E5714;
	Sun, 22 Feb 2026 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771754985; cv=none; b=ltYzd0Uo99Q6f1vk9aGCinX6rIwtj403fxAXto/6UBHsv+JrLwtKdEineGQZB9z7ecMaJE1IsIbe+ikoVvxF1o0Yj2IXDrg6ayXYkRNS/Lym5EJQWUYHzGcPyg7G4dI41jYEQlv1eRngTYC7j7xzAtZW36ZpvsJ74+i4LtJ5s7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771754985; c=relaxed/simple;
	bh=n82bi+/D/5o5ECKAx9AEf1f29u44JWXcS2tCPyvIu9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LebLmgJ/fADUtnSveepqJyP1KLUq46c3Gg1jV8cbLdit4juX0vtHxogsJg6f6ZS2efb5f+y2pR4TZNX4lE2/+m/bKZyFdZtYNtIWT5lzma6IfGS4TPDIiSSYvcPyUxcOBUhYwmhGoPSyEMpWGulIznPCkwyf3ahXx5k0wa6gkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lX43CNHd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61M7vVL31029142;
	Sun, 22 Feb 2026 10:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jvyFh3
	fcdvjGgk18UyQ1MU000vE1uKuZS4r6U0uNv1I=; b=lX43CNHddrW/VfSJNQ8J5g
	1z2zA7Zy3X5gJGlmBiorHsPibhR0Cg620+Qzi46SLW+DAhNcEhV/tBn0nvOJx4ni
	/PgFDPhS/DxiTRqsiLNDLVR49dVO/xAGECbmjaZK1be9ISJ8DEIWOWasBV2wmT7N
	h69BFzw0a8ZWwjeVpYIo4KWcZJGK9a0WQXKKD76Yo0Do1dS9QALw88C4xYU8R5GK
	J0JkNhaXi1JRqO2doRvRZ9GmqZNJ1SnEUarhQi5ap3QkhrgXDUtEvX7PuBXq3vRZ
	y6bOid0TdNETPhuFGNNZXbqCWgCQ3zehanqC/XvHS76ZbXjiruMyATfP5E2RogWA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqkn94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 10:09:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61M9FSqu030298;
	Sun, 22 Feb 2026 10:09:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhk0ysn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 10:09:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61MA95ZH23855866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Feb 2026 10:09:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E50058056;
	Sun, 22 Feb 2026 10:09:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93E4258052;
	Sun, 22 Feb 2026 10:08:59 +0000 (GMT)
Received: from [9.61.255.192] (unknown [9.61.255.192])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Feb 2026 10:08:59 +0000 (GMT)
Message-ID: <ccdcd672-b5e1-45bc-86f3-791af553f0d8@linux.ibm.com>
Date: Sun, 22 Feb 2026 15:38:57 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock() (RCU
 free path)
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, Carlos Maiolino <cem@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com,
        Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
 <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
 <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PJfnONGGYvz7ihDX65H0diVu2P0Qq-Wo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDA5NiBTYWx0ZWRfX/qj/c89S+wb0
 KN5T/f/7pwQAS4il00wsxtCDHDEPVcrNOi64mPFIdQhPUURuh76RJuv/5zU/8+B/Cpp6KXojNAh
 uPjIys8g2ky1EkEwerDXTMedHfXkDSIUrv88bzJnWaMMJbhy22/qDXwX1U74uI1Mo4B3AY72xGy
 E1xFwwq89tqa8jnnBWWryB6tKhda3uax0f1uS4LsmEIQNLSsOQFRfRC3qA5msiSpFQUOiuEk0vK
 2gKZcb4Drg3rQ0DpQ7xpRUbXbYk3DdfXs5xdmNdE9sLKli01iy4I5DkzH+3ZBoPH/CDE+dQ8t05
 jya4/T/E5ZHjQzJXddR50IVL2MVUmfhHK1U3aG0jhEcU911FXp9ftsTRoagLzABihTMOQ7B6T+O
 zdhWNaxVfx9SdxaCAFhotrLb977XnloYdVWphVQxZCIko8DkUcPWa+lFiPVVBqLCwk5YfAsVOFR
 AEqP1mEdNbRSH+0kKJw==
X-Proofpoint-GUID: PJfnONGGYvz7ihDX65H0diVu2P0Qq-Wo
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699ad5c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=--xM2mIrrnG3GcqvwuwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602220096
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-77870-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D1E0816ED28
X-Rspamd-Action: no action


On 18/02/26 5:06 pm, Vlastimil Babka wrote:
> On 2/17/26 13:40, Carlos Maiolino wrote:
>> On Tue, Feb 17, 2026 at 04:59:12PM +0530, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>> I am observing below OOPs, while running xfstests generic/428 test case. But
>>> I am not able to reproduce this consistently.
>>>
>>>
>>> Platform: IBM Power11 (pSeries LPAR), Radix MMU, LE, 64K pages
>>> Kernel: 6.19.0-next-20260216
>>> Tests: generic/428
>>>
>>> local.config >>>
>>> [xfs_4k]
>>> export RECREATE_TEST_DEV=true
>>> export TEST_DEV=/dev/loop0
>>> export TEST_DIR=/mnt/test
>>> export SCRATCH_DEV=/dev/loop1
>>> export SCRATCH_MNT=/mnt/scratch
>>> export MKFS_OPTIONS="-b size=4096"
>>> export FSTYP=xfs
>>> export MOUNT_OPTIONS=""-
>>>
>>>
>>>
>>> Attached is .config file used.
>>>
>>>
>>> Traces:
>>>
>> /me fixing trace's indentation
> CCing memcg and slab folks.
> Would be nice to figure out where in drain_obj_stock things got wrong. Any
> change for e.g. ./scripts/faddr2line ?
>
> I wonder if we have either some bogus objext pointer, or maybe the
> rcu_free_sheaf() context is new (or previously rare) for memcg and we have
> some locking issues being exposed in refill/drain.


This issue also got reproduced on mainline repo.


Traces:


[ 8058.036083] Kernel attempted to read user page (0) - exploit attempt? 
(uid: 0)
[ 8058.036116] BUG: Kernel NULL pointer dereference on read at 0x00000000
[ 8058.036127] Faulting instruction address: 0xc0000000008b018c
[ 8058.036137] Oops: Kernel access of bad area, sig: 11 [#1]
[ 8058.036147] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[ 8058.036159] Modules linked in: overlay dm_zero dm_thin_pool 
dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs loop 
dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set bonding nf_tables tls 
rfkill sunrpc nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 
mbcache jbd2 nd_pmem papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth 
scsi_transport_srp pseries_wdt [last unloaded: scsi_debug]
[ 8058.036339] CPU: 19 UID: 0 PID: 115 Comm: ksoftirqd/19 Kdump: loaded 
Not tainted 6.19.0+ #1 PREEMPTLAZY
[ 8058.036361] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[ 8058.036379] NIP:  c0000000008b018c LR: c0000000008b0180 CTR: 
c00000000036d680
[ 8058.036395] REGS: c00000000b5976c0 TRAP: 0300   Not tainted (6.19.0+)
[ 8058.036411] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 84042002  XER: 20040000
[ 8058.036482] CFAR: c000000000862cf4 DAR: 0000000000000000 DSISR: 
40000000 IRQMASK: 0
[ 8058.036482] GPR00: c0000000008b0180 c00000000b597960 c00000000243a500 
0000000000000001
[ 8058.036482] GPR04: 0000000000000008 0000000000000001 c0000000008b0180 
0000000000000001
[ 8058.036482] GPR08: a80e000000000000 0000000000000001 0000000000000007 
a80e000000000000
[ 8058.036482] GPR12: c00e00000120f8d5 c000000d0ddf0b00 c000000073567780 
0000000000000006
[ 8058.036482] GPR16: c000000007012fa0 c000000007012fa4 c000000005160980 
c000000007012f88
[ 8058.036482] GPR20: c00c000001c3daac c000000d0d10f008 0000000000000001 
ffffffffffffff78
[ 8058.036482] GPR24: 0000000000000005 c000000d0d58f180 c00000000cd6f580 
c000000d0d10f01c
[ 8058.036482] GPR28: c000000d0d10f008 c000000d0d10f010 c00000000cd6f588 
0000000000000000
[ 8058.036628] NIP [c0000000008b018c] drain_obj_stock+0x620/0xa48
[ 8058.036646] LR [c0000000008b0180] drain_obj_stock+0x614/0xa48
[ 8058.036659] Call Trace:
[ 8058.036665] [c00000000b597960] [c0000000008b0180] 
drain_obj_stock+0x614/0xa48 (unreliable)
[ 8058.036688] [c00000000b597a10] [c0000000008b2a64] 
refill_obj_stock+0x104/0x680
[ 8058.036715] [c00000000b597a90] [c0000000008b94b8] 
__memcg_slab_free_hook+0x238/0x3ec
[ 8058.036738] [c00000000b597b60] [c0000000007f3c10] 
__rcu_free_sheaf_prepare+0x314/0x3e8
[ 8058.036763] [c00000000b597c10] [c0000000007fbf70] 
rcu_free_sheaf_nobarn+0x38/0x78
[ 8058.036788] [c00000000b597c40] [c000000000334550] 
rcu_do_batch+0x2ec/0xfa8
[ 8058.036812] [c00000000b597d40] [c0000000003399e8] rcu_core+0x22c/0x48c
[ 8058.036835] [c00000000b597db0] [c0000000001cfe6c] 
handle_softirqs+0x1f4/0x74c
[ 8058.036862] [c00000000b597ed0] [c0000000001d0458] run_ksoftirqd+0x94/0xb8
[ 8058.036885] [c00000000b597f00] [c00000000022a130] 
smpboot_thread_fn+0x450/0x648
[ 8058.036912] [c00000000b597f80] [c000000000218408] kthread+0x244/0x28c
[ 8058.036927] [c00000000b597fe0] [c00000000000ded8] 
start_kernel_thread+0x14/0x18
[ 8058.036943] Code: 60000000 3bda0008 7fc3f378 4bfb148d 60000000 
ebfa0008 38800008 7fe3fb78 4bfb2b51 60000000 7c0004ac 39200001 
<7d40f8a8> 7d495050 7d40f9ad 40c2fff4
[ 8058.037000] ---[ end trace 0000000000000000 ]---


And below is the corresponding o/p from faddr2line.


drain_obj_stock+0x620/0xa48:
arch_atomic64_sub_return_relaxed at arch/powerpc/include/asm/atomic.h:272
(inlined by) raw_atomic64_sub_return at 
include/linux/atomic/atomic-arch-fallback.h:2917
(inlined by) raw_atomic64_sub_and_test at 
include/linux/atomic/atomic-arch-fallback.h:4386
(inlined by) raw_atomic_long_sub_and_test at 
include/linux/atomic/atomic-long.h:1551
(inlined by) atomic_long_sub_and_test at 
include/linux/atomic/atomic-instrumented.h:4522
(inlined by) percpu_ref_put_many at include/linux/percpu-refcount.h:334
(inlined by) percpu_ref_put at include/linux/percpu-refcount.h:351
(inlined by) obj_cgroup_put at include/linux/memcontrol.h:794
(inlined by) drain_obj_stock at mm/memcontrol.c:3059
drain_obj_stock+0x614/0xa48:
instrument_atomic_read_write at include/linux/instrumented.h:112
(inlined by) atomic_long_sub_and_test at 
include/linux/atomic/atomic-instrumented.h:4521
(inlined by) percpu_ref_put_many at include/linux/percpu-refcount.h:334
(inlined by) percpu_ref_put at include/linux/percpu-refcount.h:351
(inlined by) obj_cgroup_put at include/linux/memcontrol.h:794
(inlined by) drain_obj_stock at mm/memcontrol.c:3059
refill_obj_stock+0x104/0x680:
__preempt_count_add at include/asm-generic/preempt.h:54
(inlined by) __rcu_read_lock at include/linux/rcupdate.h:103
(inlined by) rcu_read_lock at include/linux/rcupdate.h:848
(inlined by) percpu_ref_get_many at include/linux/percpu-refcount.h:202
(inlined by) percpu_ref_get at include/linux/percpu-refcount.h:222
(inlined by) obj_cgroup_get at include/linux/memcontrol.h:782
(inlined by) refill_obj_stock at mm/memcontrol.c:3099
__memcg_slab_free_hook+0x238/0x3ec:
__preempt_count_add at include/asm-generic/preempt.h:54
(inlined by) __rcu_read_lock at include/linux/rcupdate.h:103
(inlined by) rcu_read_lock at include/linux/rcupdate.h:848
(inlined by) percpu_ref_put_many at include/linux/percpu-refcount.h:330
(inlined by) percpu_ref_put at include/linux/percpu-refcount.h:351
(inlined by) obj_cgroup_put at include/linux/memcontrol.h:794
(inlined by) __memcg_slab_free_hook at mm/memcontrol.c:3284
__rcu_free_sheaf_prepare+0x314/0x3e8:
memcg_slab_free_hook at mm/slub.c:2486
(inlined by) __rcu_free_sheaf_prepare at mm/slub.c:2914
rcu_free_sheaf_nobarn+0x38/0x78:
sheaf_flush_unused at mm/slub.c:2893
(inlined by) rcu_free_sheaf_nobarn at mm/slub.c:2941
rcu_do_batch+0x2ec/0xfa8:
rcu_do_batch at kernel/rcu/tree.c:2617
rcu_core+0x22c/0x48c:
rcu_core at kernel/rcu/tree.c:2871
handle_softirqs+0x1f4/0x74c:
handle_softirqs at kernel/softirq.c:622
run_ksoftirqd+0x94/0xb8:
arch_local_irq_enable at arch/powerpc/include/asm/hw_irq.h:201
(inlined by) ksoftirqd_run_end at kernel/softirq.c:479
(inlined by) run_ksoftirqd at kernel/softirq.c:1064
(inlined by) run_ksoftirqd at kernel/softirq.c:1055
smpboot_thread_fn+0x450/0x648:
smpboot_thread_fn at kernel/smpboot.c:160 (discriminator 3)
kthread+0x244/0x28c:
kthread at kernel/kthread.c:467
start_kernel_thread+0x14/0x18:
start_kernel_thread at arch/powerpc/kernel/interrupt_64.S:771


Regards,

Venkat.

>
>>> [ 6054.957411] run fstests generic/428 at 2026-02-16 22:25:57
>>> [ 6055.136443] Kernel attempted to read user page (0) - exploit attempt?
>>> (uid: 0)
>>> [ 6055.136474] BUG: Kernel NULL pointer dereference on read at 0x00000000
>>> [ 6055.136485] Faulting instruction address: 0xc0000000008aff0c
>>> [ 6055.136495] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [ 6055.136505] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
>>> [ 6055.136517] Modules linked in: dm_thin_pool dm_persistent_data
>>> dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs loop dm_mod nft_fib_inet
>>> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
>>> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
>>> nf_defrag_ipv6 nf_defrag_ipv4 bonding ip_set tls nf_tables rfkill sunrpc
>>> nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2
>>> nd_pmem papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth scsi_transport_srp
>>> pseries_wdt [last unloaded: scsi_debug]
>>> [ 6055.136684] CPU: 19 UID: 0 PID: 0 Comm: swapper/19 Kdump: loaded Tainted:
>>> G        W           6.19.0-next-20260216 #1 PREEMPTLAZY
>>> [ 6055.136701] Tainted: [W]=WARN
>>> [ 6055.136708] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
>>> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>>> [ 6055.136719] NIP:  c0000000008aff0c LR: c0000000008aff00 CTR:
>>> c00000000036d5e0
>>> [ 6055.136730] REGS: c000000d0dc877c0 TRAP: 0300   Tainted: G   W
>>> (6.19.0-next-20260216)
>>> [ 6055.136742] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 84042802 XER: 20040037
>>> [ 6055.136777] CFAR: c000000000862a74 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
>>> [ 6055.136777] GPR00: c0000000008aff00 c000000d0dc87a60 c00000000243a500 0000000000000001
>>> [ 6055.136777] GPR04: 0000000000000008 0000000000000001 c0000000008aff00 0000000000000001
>>> [ 6055.136777] GPR08: a80e000000000000 0000000000000001 0000000000000007
>>> a80e000000000000
>>> [ 6055.136777] GPR12: c00e00000c46e6d5 c000000d0ddf0b00 c000000019069a00
>>> 0000000000000006
>>> [ 6055.136777] GPR16: c000000007012fa0 c000000007012fa4 c000000005160980
>>> c000000007012f88
>>> [ 6055.136777] GPR20: c00c0000004d7cec c000000d0d10f008 0000000000000001
>>> ffffffffffffff78
>>> [ 6055.136777] GPR24: 0000000000000005 c000000d0d58f180 c0000001d0795e00
>>> c000000d0d10f01c
>>> [ 6055.136777] GPR28: c000000d0d10f008 c000000d0d10f010 c0000001d0795e08
>>> 0000000000000000
>>> [ 6055.136891] NIP [c0000000008aff0c] drain_obj_stock+0x620/0xa48
>>> [ 6055.136905] LR [c0000000008aff00] drain_obj_stock+0x614/0xa48
>>> [ 6055.136915] Call Trace:
>>> [ 6055.136919] [c000000d0dc87a60] [c0000000008aff00] drain_obj_stock+0x614/0xa48 (unreliable)
>>> [ 6055.136933] [c000000d0dc87b10] [c0000000008b27e4] refill_obj_stock+0x104/0x680
>>> [ 6055.136945] [c000000d0dc87b90] [c0000000008b9238] __memcg_slab_free_hook+0x238/0x3ec
>>> [ 6055.136956] [c000000d0dc87c60] [c0000000007f39a0] __rcu_free_sheaf_prepare+0x314/0x3e8
>>> [ 6055.136968] [c000000d0dc87d10] [c0000000007fbf0c] rcu_free_sheaf+0x38/0x170
>>> [ 6055.136980] [c000000d0dc87d50] [c0000000003344b0] rcu_do_batch+0x2ec/0xfa8
>>> [ 6055.136992] [c000000d0dc87e50] [c000000000339948] rcu_core+0x22c/0x48c
>>> [ 6055.137002] [c000000d0dc87ec0] [c0000000001cfe6c] handle_softirqs+0x1f4/0x74c
>>> [ 6055.137013] [c000000d0dc87fe0] [c00000000001b0cc] do_softirq_own_stack+0x60/0x7c
>>> [ 6055.137025] [c000000009717930] [c00000000001b0b8] do_softirq_own_stack+0x4c/0x7c
>>> [ 6055.137036] [c000000009717960] [c0000000001cf128] __irq_exit_rcu+0x268/0x308
>>> [ 6055.137046] [c0000000097179a0] [c0000000001d0ba4] irq_exit+0x20/0x38
>>> [ 6055.137056] [c0000000097179c0] [c0000000000315f4] interrupt_async_exit_prepare.constprop.0+0x18/0x2c
>>> [ 6055.137069] [c0000000097179e0] [c000000000009ffc] decrementer_common_virt+0x28c/0x290
>>> [ 6055.137080] ---- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x2c
>>> [ 6055.137090] NIP:  c00000000012d8f0 LR: c00000000135c3fc CTR: 0000000000000000
>>> [ 6055.137097] REGS: c000000009717a10 TRAP: 0900   Tainted: G   W            (6.19.0-next-20260216)
>>> [ 6055.137105] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000804  XER: 00000037
>>> [ 6055.137134] CFAR: 0000000000000000 IRQMASK: 0
>>> [ 6055.137134] GPR00: 0000000000000000 c000000009717cb0 c00000000243a500 0000000000000000
>>> [ 6055.137134] GPR04: 0000000000000000 800400002fe6fc10 0000000000000000 0000000000000001
>>> [ 6055.137134] GPR08: 0000000000000033 0000000000000000 0000000000000090 0000000000000001
>>> [ 6055.137134] GPR12: 800400002fe6fc00 c000000d0ddf0b00 0000000000000000 000000002ef01a60
>>> [ 6055.137134] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> [ 6055.137134] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
>>> [ 6055.137134] GPR24: 0000000000000000 c000000004d7a778 00000581d1a507b8 0000000000000000
>>> [ 6055.137134] GPR28: 0000000000000000 0000000000000001 c0000000032b18d8 c0000000032b18e0
>>> [ 6055.137229] NIP [c00000000012d8f0] plpar_hcall_norets_notrace+0x18/0x2c
>>> [ 6055.137238] LR [c00000000135c3fc] cede_processor.isra.0+0x1c/0x30
>>> [ 6055.137248] ---- interrupt: 900
>>> [ 6055.137253] [c000000009717cb0] [c000000009717cf0] 0xc000000009717cf0 (unreliable)
>>> [ 6055.137265] [c000000009717d10] [c0000000019af160] dedicated_cede_loop+0x90/0x170
>>> [ 6055.137277] [c000000009717d60] [c0000000019aeb10] cpuidle_enter_state+0x394/0x480
>>> [ 6055.137288] [c000000009717e00] [c0000000013589ec] cpuidle_enter+0x64/0x9c
>>> [ 6055.137298] [c000000009717e50] [c000000000284a8c] call_cpuidle+0x7c/0xf8
>>> [ 6055.137310] [c000000009717e90] [c000000000290398] cpuidle_idle_call+0x1c4/0x2b4
>>> [ 6055.137321] [c000000009717f00] [c0000000002905bc] do_idle+0x134/0x208
>>> [ 6055.137330] [c000000009717f50] [c000000000290a0c] cpu_startup_entry+0x60/0x64
>>> [ 6055.137341] [c000000009717f80] [c0000000000744b8] start_secondary+0x3fc/0x400
>>> [ 6055.137352] [c000000009717fe0] [c00000000000e258] start_secondary_prolog+0x10/0x14
>>> [ 6055.137363] Code: 60000000 3bda0008 7fc3f378 4bfb148d 60000000 ebfa0008 38800008 7fe3fb78 4bfb2b51 60000000 7c0004ac 39200001 <7d40f8a8> 7d495050 7d40f9ad 40c2fff4
>>> [ 6055.137400] ---[ end trace 0000000000000000 ]---
>> Again, nothing here seems to point to a xfs problem.
>>
>

