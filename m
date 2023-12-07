Return-Path: <linux-fsdevel+bounces-5141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822D8087C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F632282859
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D42D786
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="acsBDU74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5DBD4B;
	Thu,  7 Dec 2023 02:44:04 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231207104400euoutp01727275761e93f8749fd8e1c5ebf15eae~ehrlvWbNy1164011640euoutp01T;
	Thu,  7 Dec 2023 10:44:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231207104400euoutp01727275761e93f8749fd8e1c5ebf15eae~ehrlvWbNy1164011640euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701945840;
	bh=zNERQmKVM3J0wJDaJhwXBxSpaX0PETpZi4lQDqCU9SY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=acsBDU74aBdYeDXY6ngky3hI4T5gVuGXxxcIGmVFMJGJmjm97Y5yMQYlCVW8uifM8
	 AcDpz5E26Zn/MR+NouYh3FkW1es7WKi7xWKtTWrmMePyJJ9gPnGoembpsyH4aChyjS
	 DXySnxm3JQRzP/MLTBrpyaFGrDMJkIicityiyQU0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231207104359eucas1p14f136aa02ca2b1b5bf125cc88be58157~ehrlZNgNr2918229182eucas1p1g;
	Thu,  7 Dec 2023 10:43:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id ED.CE.09552.FE1A1756; Thu,  7
	Dec 2023 10:43:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231207104359eucas1p1f79f29d05b60116469be45492bf11643~ehrk6_xi01594315943eucas1p1B;
	Thu,  7 Dec 2023 10:43:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207104359eusmtrp190e2f95c9151072cb749876723af6530~ehrk6OK4O3019030190eusmtrp1Y;
	Thu,  7 Dec 2023 10:43:59 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-d3-6571a1efeb9c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.FE.09146.FE1A1756; Thu,  7
	Dec 2023 10:43:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231207104359eusmtip17e9120b4fcfd007493086e25c8a7eae7~ehrkqgZop1635216352eusmtip1p;
	Thu,  7 Dec 2023 10:43:59 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 10:43:58 +0000
Date: Thu, 7 Dec 2023 11:43:57 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231207104357.kndqvzkhxqkwkkjo@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qyay55f3fbjgslmy"
Content-Disposition: inline
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7rvFxamGvx5oGHRvHg9m8Wvi9NY
	Lc5051rs2XuSxWLe+p+MFpd3zWGz+P3jGZPFjQlPGS2W7fRz4PSY3XCRxWPBplKPTas62Tz2
	z13D7vF5k5xHf/cx9gC2KC6blNSczLLUIn27BK6MOZ8jC37GVhz//4CpgfGRTRcjJ4eEgInE
	lad7mLoYuTiEBFYwShzuusIG4XxhlNj77QojhPOZUeL3gRWMMC3nNs9jhkgsZ5S4NnMeG1xV
	690+VghnM6PEpc/72EFaWARUJK6umMQEYrMJ6Eicf3OHGcQWEbCRWPntMztIA7PALiaJxw/n
	AhVxcAgLOEhsa5IEqeEVMJe4uGoSC4QtKHFy5hMwm1mgQmJjRyMbSDmzgLTE8n8cIGFOAVeJ
	t4+72SEuVZI4PPkzM4RdK3Fqyy2wRyUE1nNKvL83EeodF4nX625C2cISr45vgWqWkTg9uYcF
	omEyo8T+fx/YIZzVjBLLGr8yQVRZS7RceQLV4Sixbu5SVpCLJAT4JG68FYQ4lE9i0rbpzBBh
	XomONiGIajWJ1ffesExgVJ6F5LVZSF6bhfAaRFhP4sbUKZjC2hLLFr5mhrBtJdate8+ygJF9
	FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmCSO/3v+NcdjCtefdQ7xMjEwXiIUQWo+dGG
	1RcYpVjy8vNSlUR4c87npwrxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1I
	LYLJMnFwSjUwddlw32mZsDDw8RVJjdoO1aUJCUm5jE2O3x4Eys1RdH4Ydu2gc5FJ/rqi+jKD
	rFVez4QfT8kV1uzt+fV7hvLESHWzBp6aby/tAwxvLPlkHP/Ya11Y3ewLMb1HA1bqWDUw18VM
	nBJqUXFDpsnR/u3XWPMHfNJ/bV+/Tj3guG1Bmfay7d1/997+fZo/LZbjdmxUjJzxDpOD80PS
	i87K/eR8t8/iz5WuzY8j254Ynl/QUF4TvSBSS7J968x64c+sP2+IX0xKUPfZV5qTm/Jjt7ih
	tb3XsYbONb6213WFXSV6NZTnH9yS5fUt5+6n0s59yl4/Pj453d75fqXp5Ehp1t+vmC88PLZ6
	9YVjKn5nTc8osRRnJBpqMRcVJwIAapkEX+0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsVy+t/xu7rvFxamGqy7x2nRvHg9m8Wvi9NY
	Lc5051rs2XuSxWLe+p+MFpd3zWGz+P3jGZPFjQlPGS2W7fRz4PSY3XCRxWPBplKPTas62Tz2
	z13D7vF5k5xHf/cx9gC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
	lNSczLLUIn27BL2MFYu9Cr7HVnTumcPewPjApouRk0NCwETi3OZ5zF2MXBxCAksZJV7fvc4K
	kZCR2PjlKpQtLPHnWhcbiC0k8JFR4teueIiGzYwSizcdYQRJsAioSFxdMYkJxGYT0JE4/+YO
	M4gtImAjsfLbZ3aQBmaBXUwSjx/OBSri4BAWcJDY1iQJUsMrYC5xcdUkFoihMxglZl69zgiR
	EJQ4OfMJC4jNLFAmMWfHejaQXmYBaYnl/zhAwpwCrhJvH3ezQxyqJHF48mdmCLtW4vPfZ4wT
	GIVnIZk0C8mkWQiTIMI6Eju33sEU1pZYtvA1M4RtK7Fu3XuWBYzsqxhFUkuLc9Nziw31ihNz
	i0vz0vWS83M3MQLjfNuxn5t3MM579VHvECMTB+MhRhWgzkcbVl9glGLJy89LVRLhzTmfnyrE
	m5JYWZValB9fVJqTWnyI0RQYihOZpUST84EJKK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9
	sSQ1OzW1ILUIpo+Jg1Oqganh2rfyPOdOw/WtQQs0tKY9aHD6sGj+gw+CpXnTb85aP8W0IXtJ
	zS1Dxfm/u55zbTts/+9/ivslfVNlB415CRumlHEGTZ35rkd6ZbD/juiqvyYrPGTjpr7pKzlR
	nmvobCSWl1Ri8EGkUXY97x4G/cLlZWrTr/mk9peYNHko2l8x/riErd3yu9qtlNMmirc/hmu6
	1f//d9o1/tzTlq1ccbcSdW5dvjjhlPyTk+8LdszW/Gase+O0tuMXNS+hPpu5j15c5IyoubPl
	qOBlV5apQerX7vl/lM71dJ5SP1Pf9rG0gemdmbfqv1rWSJfmPLqmPNv0fVNnVcvZ0L+Gr15X
	Lr55yKN9ru9cL4aLs396rVBiKc5INNRiLipOBABFpJgWiAMAAA==
X-CMS-MailID: 20231207104359eucas1p1f79f29d05b60116469be45492bf11643
X-Msg-Generator: CA
X-RootMTR: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
	<20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>

--qyay55f3fbjgslmy
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

You have a couple of test bot issues for your 12/18 patch. Can you
please address those for your next version.

On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Wei=DFschuh wrote:
> Problem description:
>=20
> The kernel contains a lot of struct ctl_table throught the tree.
> These are very often 'static' definitions.
> It would be good to make the tables unmodifiable by marking them "const"
Here I would remove "It would be good to". Just state it: "Make the
tables unmodifiable...."

> to avoid accidental or malicious modifications.
> This is in line with a general effort to move as much data as possible
> into .rodata. (See for example[0] and [1])
If you could find more examples, it would make a better case.

>=20
> Unfortunately the tables can not be made const right now because the
> core registration functions expect mutable tables.
>=20
> This is for two main reasons:
>=20
> 1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
>    the table.
> 2) The table is passed to the handler function as a non-const pointer.
>=20
> This series migrates the core and all handlers.
awesome!

>=20
> Structure of the series:
>=20
> Patch 1-3:   Cleanup patches
> Patch 4-7:   Non-logic preparation patches
> Patch 8:     Preparation patch changing a bit of logic
> Patch 9-12:  Treewide changes to handler function signature
> Patch 13-14: Adaption of the sysctl core implementation
> Patch 15:    Adaption of the sysctl core interface
> Patch 16:    New entry for checkpatch
> Patch 17-18: Constification of existing "struct ctl_table"s
>=20
> Tested by booting and with the sysctl selftests on x86.
>=20
> Note:
>=20
> This is intentionally sent only to a small number of people as I'd like
> to get some more sysctl core-maintainer feedback before sending this to
> essentially everybody.
When you do send it to the broader audience, you should chunk up your big
patches (12/18 and 11/18) and this is why:
1. To avoid mail rejections from lists:
   You have to tell a lot of people about the changes in one mail. That
   will make mail header too big for some lists and it will be rejected.
   This happened to me with [3]
2. Avoid being rejected for the wrong reasons :)
   Maintainers are busy ppl and sending them a set with so many files
   may elicit a rejection on the grounds that it involves too many
   subsystems at the same time.
I suggest you chunk it up with directories in mind. Something similar to
what I did for [4] where I divided stuff that when for fs/*, kernel/*,
net/*, arch/* and drivers/*. That will complicate your patch a tad
because you have to ensure that the tree can be compiled/run for every
commit. But it will pay off once you push it to the broader public.

[3] https://lore.kernel.org/all/20230621091000.424843-1-j.granados@samsung.=
com
[4] https://lore.kernel.org/all/20230726140635.2059334-1-j.granados@samsung=
=2Ecom
>=20
> [0] 43a7206b0963 ("driver core: class: make class_register() take a const=
 *")
> [1] https://lore.kernel.org/lkml/20230930050033.41174-1-wedsonaf@gmail.co=
m/
>=20
> ---
> Changes in v2:
> - Migrate all handlers.
> - Remove intermediate "proc_handler_new" step (Thanks Joel).
> - Drop RFC status.
> - Prepare other parts of the tree.
> - Link to v1: https://lore.kernel.org/r/20231125-const-sysctl-v1-0-5e881b=
0e0290@weissschuh.net
>=20
> ---
> Thomas Wei=DFschuh (18):
>       watchdog/core: remove sysctl handlers from public header
>       sysctl: delete unused define SYSCTL_PERM_EMPTY_DIR
>       sysctl: drop sysctl_is_perm_empty_ctl_table
>       cgroup: bpf: constify ctl_table arguments and fields
>       seccomp: constify ctl_table arguments of utility functions
>       hugetlb: constify ctl_table arguments of utility functions
>       utsname: constify ctl_table arguments of utility function
>       stackleak: don't modify ctl_table argument
>       sysctl: treewide: constify ctl_table_root::set_ownership
>       sysctl: treewide: constify ctl_table_root::permissions
>       sysctl: treewide: constify ctl_table_header::ctl_table_arg
>       sysctl: treewide: constify the ctl_table argument of handlers
>       sysctl: move sysctl type to ctl_table_header
>       sysctl: move internal interfaces to const struct ctl_table
>       sysctl: allow registration of const struct ctl_table
>       const_structs.checkpatch: add ctl_table
>       sysctl: make ctl_table sysctl_mount_point const
>       sysctl: constify standard sysctl tables
>=20
>  arch/arm64/kernel/armv8_deprecated.c      |   2 +-
>  arch/arm64/kernel/fpsimd.c                |   2 +-
>  arch/s390/appldata/appldata_base.c        |   8 +--
>  arch/s390/kernel/debug.c                  |   2 +-
>  arch/s390/kernel/topology.c               |   2 +-
>  arch/s390/mm/cmm.c                        |   6 +-
>  arch/x86/kernel/itmt.c                    |   2 +-
>  drivers/cdrom/cdrom.c                     |   4 +-
>  drivers/char/random.c                     |   4 +-
>  drivers/macintosh/mac_hid.c               |   2 +-
>  drivers/net/vrf.c                         |   4 +-
>  drivers/parport/procfs.c                  |  12 ++--
>  fs/coredump.c                             |   2 +-
>  fs/dcache.c                               |   4 +-
>  fs/drop_caches.c                          |   2 +-
>  fs/exec.c                                 |   4 +-
>  fs/file_table.c                           |   2 +-
>  fs/fs-writeback.c                         |   2 +-
>  fs/inode.c                                |   4 +-
>  fs/pipe.c                                 |   2 +-
>  fs/proc/internal.h                        |   2 +-
>  fs/proc/proc_sysctl.c                     | 102 +++++++++++++++---------=
------
>  fs/quota/dquot.c                          |   2 +-
>  fs/xfs/xfs_sysctl.c                       |   6 +-
>  include/linux/bpf-cgroup.h                |   2 +-
>  include/linux/filter.h                    |   2 +-
>  include/linux/ftrace.h                    |   4 +-
>  include/linux/mm.h                        |   8 +--
>  include/linux/nmi.h                       |   7 --
>  include/linux/perf_event.h                |   6 +-
>  include/linux/security.h                  |   2 +-
>  include/linux/sysctl.h                    |  78 +++++++++++------------
>  include/linux/vmstat.h                    |   6 +-
>  include/linux/writeback.h                 |   2 +-
>  include/net/ndisc.h                       |   2 +-
>  include/net/neighbour.h                   |   6 +-
>  include/net/netfilter/nf_hooks_lwtunnel.h |   2 +-
>  ipc/ipc_sysctl.c                          |  12 ++--
>  ipc/mq_sysctl.c                           |   2 +-
>  kernel/bpf/cgroup.c                       |   2 +-
>  kernel/bpf/syscall.c                      |   4 +-
>  kernel/delayacct.c                        |   4 +-
>  kernel/events/callchain.c                 |   2 +-
>  kernel/events/core.c                      |   4 +-
>  kernel/fork.c                             |   2 +-
>  kernel/hung_task.c                        |   4 +-
>  kernel/kexec_core.c                       |   2 +-
>  kernel/kprobes.c                          |   2 +-
>  kernel/latencytop.c                       |   4 +-
>  kernel/pid_namespace.c                    |   2 +-
>  kernel/pid_sysctl.h                       |   2 +-
>  kernel/printk/internal.h                  |   2 +-
>  kernel/printk/printk.c                    |   2 +-
>  kernel/printk/sysctl.c                    |   5 +-
>  kernel/sched/core.c                       |   8 +--
>  kernel/sched/rt.c                         |  12 ++--
>  kernel/sched/topology.c                   |   2 +-
>  kernel/seccomp.c                          |   8 +--
>  kernel/stackleak.c                        |   9 +--
>  kernel/sysctl.c                           |  84 ++++++++++++------------
>  kernel/time/timer.c                       |   2 +-
>  kernel/trace/ftrace.c                     |   2 +-
>  kernel/trace/trace.c                      |   2 +-
>  kernel/trace/trace_events_user.c          |   2 +-
>  kernel/trace/trace_stack.c                |   2 +-
>  kernel/ucount.c                           |   4 +-
>  kernel/umh.c                              |   2 +-
>  kernel/utsname_sysctl.c                   |   4 +-
>  kernel/watchdog.c                         |  15 +++--
>  mm/compaction.c                           |   8 +--
>  mm/hugetlb.c                              |  10 +--
>  mm/page-writeback.c                       |  18 +++---
>  mm/page_alloc.c                           |  22 +++----
>  mm/util.c                                 |  12 ++--
>  mm/vmstat.c                               |   4 +-
>  net/ax25/sysctl_net_ax25.c                |   2 +-
>  net/bridge/br_netfilter_hooks.c           |   6 +-
>  net/core/neighbour.c                      |  24 +++----
>  net/core/sysctl_net_core.c                |  22 +++----
>  net/ieee802154/6lowpan/reassembly.c       |   2 +-
>  net/ipv4/devinet.c                        |   8 +--
>  net/ipv4/ip_fragment.c                    |   2 +-
>  net/ipv4/route.c                          |   4 +-
>  net/ipv4/sysctl_net_ipv4.c                |  35 +++++-----
>  net/ipv4/xfrm4_policy.c                   |   2 +-
>  net/ipv6/addrconf.c                       |  29 +++++----
>  net/ipv6/ndisc.c                          |   4 +-
>  net/ipv6/netfilter/nf_conntrack_reasm.c   |   2 +-
>  net/ipv6/reassembly.c                     |   2 +-
>  net/ipv6/route.c                          |   2 +-
>  net/ipv6/sysctl_net_ipv6.c                |  10 +--
>  net/ipv6/xfrm6_policy.c                   |   2 +-
>  net/mpls/af_mpls.c                        |   8 +--
>  net/mptcp/ctrl.c                          |   2 +-
>  net/netfilter/ipvs/ip_vs_ctl.c            |  16 ++---
>  net/netfilter/nf_conntrack_standalone.c   |   4 +-
>  net/netfilter/nf_hooks_lwtunnel.c         |   2 +-
>  net/netfilter/nf_log.c                    |   4 +-
>  net/phonet/sysctl.c                       |   2 +-
>  net/rds/tcp.c                             |   4 +-
>  net/sctp/sysctl.c                         |  30 ++++-----
>  net/smc/smc_sysctl.c                      |   2 +-
>  net/sunrpc/sysctl.c                       |   6 +-
>  net/sunrpc/xprtrdma/svc_rdma.c            |   2 +-
>  net/sysctl_net.c                          |   4 +-
>  net/unix/sysctl_net_unix.c                |   2 +-
>  net/xfrm/xfrm_sysctl.c                    |   2 +-
>  scripts/const_structs.checkpatch          |   1 +
>  security/apparmor/lsm.c                   |   2 +-
>  security/min_addr.c                       |   2 +-
>  security/yama/yama_lsm.c                  |   2 +-
>  111 files changed, 427 insertions(+), 428 deletions(-)
> ---
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
> change-id: 20231116-const-sysctl-e14624f1295c
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--qyay55f3fbjgslmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxoesACgkQupfNUreW
QU9jdQv/fuoqjk7HVhxO4PfN7Nx9mFcuXiE0BBcfQvX2sddH6652M+xHymNCZ98o
e7aWeM/8qRsd2eYbSdskcNK8ojAVULzMDi1QfO3UDoNm1Qn3lsZ2zDxnv4BN1Xft
c94jv5ZMJsIjf1ANwvWH2+GAVav5/vd3KarnDlp0AFJsxVbMIISfReTwzPWzKPFu
gy8OZQHI4WW3Xx78dPU1RLnvFu5PVYiuSpJpyKqTzpfm9W96q5SCdIMF1DvnynpK
U8u636u9L4sVVs7GVzPwQG7kF43rl25vuNuYLDTU2gAbhsgfTw6DBpcQvc2wAeqP
fztmyPXg/Vyo9pA00FZ+1sbmkp0EvxzF+nrjW/5aitKFVDSnvPUXlTift60I6ysL
wKCe3skKOyD0JVv4pQSbCmSBp49SVw8S+cJ7FCQrZQRvbgUMsKOLHQ8kDBPaP18t
tLt9lUyZFBpnYGM2wZ8uNmvqbsiAcanEIe3mKWaiIXqV36WShyV9Jl4gYXYYVBrR
m02mbYq9
=5y2l
-----END PGP SIGNATURE-----

--qyay55f3fbjgslmy--

