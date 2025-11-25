Return-Path: <linux-fsdevel+bounces-69741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558AC8427E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C6224E3DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F62E7198;
	Tue, 25 Nov 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="beAyShyV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iYUtXusG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724D217736;
	Tue, 25 Nov 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061888; cv=fail; b=gAi2Mk9rsJp8tSaaqJJUC1fvb6JK1QsnnTR8cfmmzZTgzhjJqw9uf1qhCvpiH8brn7AAHf7i21GY+3fyQsJysZpJBsYk04hNXBBCaF75uCvtYrv8Gz2SQxaVbpINo7IXFL4aVVkAiJu7IAoDYIdzqqgN3ENGdN1fcNoRKsrB7dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061888; c=relaxed/simple;
	bh=nOMQPxbEMUndSV57XP2alvBiO8UnBKhH5Txt/YwT1qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gm2qWKsRtwwRlZs+OWhNKhg7g9098ajooNxgoaotUINt8bepyM4/CUS4gsCNgj7ddmHkloF3cb96dmFEuUdUqxWOJ/q4x39F2gTMN5n/iSDnsSy78e9PBWGZK+pU6TH6rwPabxQMXOlNDvAe3L3zrVrUqPGRIO72lnLcCin7zis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=beAyShyV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iYUtXusG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1CkK02432594;
	Tue, 25 Nov 2025 09:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=p91ksKNGWtmtN76z5/
	IorFyc/Qx0sotNzAb4ysX4xWE=; b=beAyShyVqVLgqT4E/KlkJTNCQy0oA5zBis
	NydOXHqJOvW5cgeBMEDqAfDPIGjWtzgNsyqb8TYnrmbu7WWyJJe7iXWDuedYLv/v
	ZDWE0UJGM+ET9/T+/Yl2TC2Wvx5gbkyxZSlCOOqOxuDPxRR/xroxWR0aT5S6y3H1
	4jbNike5VjV89bIgVx8cudoMvT1u/2s+WpQCGRIPBKQ2PYnuPUQ/KOQQeph0r6DG
	kfDlqDZNi00r1PMOzo7oJv9t0E++ZXusBSDatEORyL92nIKfVf5ByP7YYwmrkmfS
	uU09P67PqlWtfwsZwDJuIaSR58MuQbFC6NEzyoUbjxaww6vSfPOw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycc3as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:09:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP8oAU4032791;
	Tue, 25 Nov 2025 09:09:55 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m96gf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 09:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywc5MPCNToMKB1DMRlPuRYn/WvuGINCFF2RvRlSBm3Fwj7Oo3gzpj/3LAm1zi2wO1i2NjLJqSiqpeZzU4ADB1QKS8Kl8fV0zHhDqDMC+5fuFUOzFwTdweM4xpCAuRpOslLBkhnYaSDnEGYrdUKwEK3Y1Qo+5jorfr3rfCHoTP69Z6Zr2skBvBArf+OKQXyCsd38CCJrWCgcURbNQ1NBFJ/lP++DhTSY7/oejs3g+0TlGR9tbYXlZzYWNIRRBJYlG5xMu8YfnPai85czevwH/czxlDuWGHvV0A+s7ocGOkA5i7fV8gUsGgZnFFAio18BhwtLAARHXtpwTQuV0tzFnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p91ksKNGWtmtN76z5/IorFyc/Qx0sotNzAb4ysX4xWE=;
 b=oZrRotC2XrdkNea+8qSyiZy2ihB2+NG+VaAI6UksIzHgSZboPzoSxVQicts9oNbu2y4JnGSONw+OYo9w8+iahRUbhoIPvOGC3Zm5CGRd08BULuMXPjMTZpba/sNvP1JYsbDMCC7rPdDe6hNHnUmZNqCHHC29Vo1oH1TO8RwRypaziVq7XGO2ki2eNeejUfv2mR1TnUuVOFABZJnef+fSJYKxVsWASgnBBzWZK8yTztDQBMfdBcmu3l7+4PxOi9aIzOgd4E7/nElNDDTT8j3hl0vWAZ70J7blx33ZMvwmS9mD7sH5+moFD7zJqS3RB28EHxAqFR22uqY2dnqcjPMI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p91ksKNGWtmtN76z5/IorFyc/Qx0sotNzAb4ysX4xWE=;
 b=iYUtXusGmL0DbEDZLOu3TNknkEFtCaezgVnxqzfrJ7cFO8HZ4yjlQs+FDiFbqVATV9DcpqyoTneJJ2jIVAIEgjoRHmI2NwwDsijA2e8jAlfDaKGmiHTMMMZa9B2rdqEh+S+uRHtif+kBZZG9hsCZW8WMWOJvXngx9Um2q085PRs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4519.namprd10.prod.outlook.com (2603:10b6:510:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 09:09:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 09:09:51 +0000
Date: Tue, 25 Nov 2025 09:09:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tools/testing/vma: eliminate dependency on
 vma->__vm_flags
Message-ID: <16667d5e-99e0-4440-8057-34f1e473e5cd@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <fb709773edcaf13d7a2c4cede046e454b4e88b1e.1763126447.git.lorenzo.stoakes@oracle.com>
 <4aff8bf7-d367-4ba3-90ad-13eef7a063fa@lucifer.local>
 <09c2d927-6d34-4e72-a593-4a3f2b739a60@lucifer.local>
 <20251124100436.cad9c3ecd7fc592e8ff23e3a@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124100436.cad9c3ecd7fc592e8ff23e3a@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4519:EE_
X-MS-Office365-Filtering-Correlation-Id: 51619492-8ca2-4d1c-9187-08de2c026414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npQNqr1o7vSvASnsl/EfPVRwbVd7jbNGnBqxMRKHnauBJUp88kVvFgnq12nM?=
 =?us-ascii?Q?lnNYXOkmYOTIKcTEyelTeiB9fxLiDHK4H5UfvAiofT++vxtMpQU9s8rS0Lzf?=
 =?us-ascii?Q?zuNsAtyZ0LrD+iJ5rEIZxf1rqDzaI5vnGMxS4B0WRvHRp/2Cjud+PVKUbGsq?=
 =?us-ascii?Q?MyBPGzUd5H4Dnin2j8xSdjR3ykUhT/06wKREMZdsQQj8c8dlH0eZP9VsjNFG?=
 =?us-ascii?Q?43I30sLBYQ7X1DupVu9CZBeEvj8+aYsYzb7so+vMilHpBojq5WexFdmsjlLC?=
 =?us-ascii?Q?8nlJWlNspQsVGDGEoGIqKLeYYNs6LFRnoqjXf9dFaIZ2QJH4/Alhr6iurv0f?=
 =?us-ascii?Q?48vPWdnAo4hSx1toUTlK/jFo1Q+cxQezEKmWSXSLhHnxUat/ZN3FC/dzV+x6?=
 =?us-ascii?Q?+Ic4pLyqxnym5rFnr9/BbunKVQVeOLzt9M44QrTjt93tvB0eENQq2I8Xrr27?=
 =?us-ascii?Q?ANFIp6lxcvu8ftR3h0fG2msRkKt/iMieaHGV6DucARY3VI7JMP0E1BTkhcA+?=
 =?us-ascii?Q?aKcEpdih2YwB45FFUM1MqcjIOR+FtACaIX8+8w46zAcTxH3kHlAnlMlug60J?=
 =?us-ascii?Q?4E6bjbmSYutnCeRuBrpcCuml/xRYYkz/hNyJEx/Jg/QoT7LGxASo2xRURhcD?=
 =?us-ascii?Q?kTIldWO6+AvnQbSEnGC5d3uAlU4KyMWjXGOhxZV0ONRH4rfELN4xy5UnT9Ye?=
 =?us-ascii?Q?KQHsY26STzDTXzDkdPURWzUG+JVN7Z1tRtOSpuDIkcbMm5yyOPaipfQM8UKq?=
 =?us-ascii?Q?kcPGowQ1DMXZwWXkfb1Gh0gB5L9drXIB+2Jnurm1TD90vHrfbXW6i7gvVdw2?=
 =?us-ascii?Q?3hb9tuYm1wL7Dau9FDwenNvWryF8ELiMGWhRUcNG6jkCXH3utc5MU99UVe/X?=
 =?us-ascii?Q?VFwKWgQPoBQejRogFjit8vQp18gT1qAIkUk+2+U6N28SG0Tw9GCCTTv/dk4T?=
 =?us-ascii?Q?VUYyi8mFOHQB/NHsHP2NZuCN8vAH3EbTY2FYrYf9yLnh+o53uE+7K7xNBc0q?=
 =?us-ascii?Q?hIJVEZPCDiJ47u0wU61fsrKyH+ATmLNk3yNX0bS6e5Udhw0/i3S0kR5r4QKd?=
 =?us-ascii?Q?1eHJORA4dJDz0+JvMadQSr9rjWnrgIcpBJi4y1USJlD3TnsAKdT0m5/oN6Sx?=
 =?us-ascii?Q?4KWuhQibdKRy3SsIOwKf6M+dMdLe+lULYpj/o+nSKLjyUl4n8+4TdAtjoZT3?=
 =?us-ascii?Q?xf/UPFGNWuvGn3OUsbM8T9g9+TyE6I+ynt5Lw3105zjpavucPaBCbnxicGwM?=
 =?us-ascii?Q?ddd4jUTqxDRk4XRWQ4sfb+K8kIwS/9horipgrnBqkC3vB7shdAiGwqESs8JO?=
 =?us-ascii?Q?vWa/bmddbA4mO5K8euqZkqaBwjKT0mafl31fwLWDgJlWkg7KYirg1HkE6GvH?=
 =?us-ascii?Q?w81hbTdiB5tKUVTxDbmzjrxDABgezkkrvNy6d4LyKC7p5GvLWAb4NaJh6KWn?=
 =?us-ascii?Q?pJRQzcU8bjw7zdcHaoxQHhS3+2WM70oJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5iAO1Ir5ro+tvKYzpI2xlEv8Jhe8yBRWn1NXlopdrISqbT9xdyCFhtzQg3e?=
 =?us-ascii?Q?SSdct/Vsrpymiz5t7wrqgqqipTijL5H/eZFd++J1kGvFqcuwB7gepJKw3XuH?=
 =?us-ascii?Q?JUo9pSAYNkpNPXLSlP8kgS7Xzk/gaDgtVMzyYa5m5H1pOkx4F9Cqi7ZQ1Lqq?=
 =?us-ascii?Q?CLjqOEdST+2z6sNjfGbsoN3ZiN//GAuhmYXZoaRmDO828JRBOK6teqpHN0ZD?=
 =?us-ascii?Q?AOfPdnEZmuy8rAUqH2vOarLBg7YZjipGC9Apz+bq0gEFdS71fezx3ofy/Lea?=
 =?us-ascii?Q?lINOjMGbhEgxFEHXuG7JKJE/TyvAyPFLMpbGaQlHDcSxuI6GjsVJvhxTN7WU?=
 =?us-ascii?Q?6cYm0LdJpVjtR4JNPoUBoaYOx/OB3El3C34DfjdGgE7iciUTo5caZap2vkNG?=
 =?us-ascii?Q?sgOzXWKuv55y0Q5+r+xI4RwT23+STqbbjiQ1Swb5gK/VGrvRNLB8PZ/rcBZL?=
 =?us-ascii?Q?VJV67EhKtB99E+OpX6GBirvnvnlYxRhvpQR3WMuTSZV8CZeIYD4k5Hq3XhqG?=
 =?us-ascii?Q?6DH+GIxF7aShThW8sli0HQBPUW0itRoxi7cLVoKqsmbCoOkIkxJPtQN2L5n1?=
 =?us-ascii?Q?0gUtH0n5Fyi1IMTlQhLOA41nMFioJEW/jK3hCzwnqw8YVJlyG116ZdgFyMlo?=
 =?us-ascii?Q?d4HR6jNlbA77LNfW/QztKhqPDlJ1TicUhzJ1MjXeOelZDA1l2PPtsUvCtJGC?=
 =?us-ascii?Q?FlwUKB7mj7fhA/RUae5aNcxsfgvCjXNdmrVhMg553oCrzoAQVVwAT1UQyIwx?=
 =?us-ascii?Q?UpQmVTxyCzfpfGeZDgooj6gOLvZw9/XWEhxR2qmVeB8sOdU9AZlBLGua/T8P?=
 =?us-ascii?Q?1XbtfcrQrSqyhiIOaZgcpVhD2g+C8/+TpuvXE0CsuyCHX5hZtSMmoTd6SsmV?=
 =?us-ascii?Q?B2wI2DZRtjVGhob4+r8S/oRh+psqcKWIfVeSbANTE6SFf+PubMSfuf4cRlAr?=
 =?us-ascii?Q?gm8zHwFy4mdQTsEk/CyPakOBlsLJCrBGLdRiCuobOIzZTEZJ7iFRd0FzHgxk?=
 =?us-ascii?Q?IqaOM2Bhh6/b/9OOi/zKd2XTItew7R/NJ6onJWibYEFkx9YspvGOZ3HpE7bb?=
 =?us-ascii?Q?epl1pTca9UvDjOuRxcNxtjq+a7tv/BisJ7gntNV6mfALffQjByxuWMa72MZ1?=
 =?us-ascii?Q?qApSXXMrF0pWXODxLQfk0uleTXeZeCjStuP8r6GkIY8wM3fqHs9GdYfD3KNo?=
 =?us-ascii?Q?MPDnqxsBeZ+/DGczFY9EDr0Lp5pUJXJtcbqhDnTOuX+7dA2K0OGP4wAHW4NZ?=
 =?us-ascii?Q?BLlU8mEc4/sVVm/yez0s2T9uWxqGraOIO20uN2RlL9g4DXXRL15KE+XGZm1y?=
 =?us-ascii?Q?B/yi2M7AugsMzPOntOM6l7HFbbb4N5vVweAA/KLg5QbkWkjAI+Lj3eVVY7Sm?=
 =?us-ascii?Q?y5QkgREAd17tqYukF9fSDuAmlY3JOGPOIhB/5xkGZdwVTpBhiYnRcv1UNi2a?=
 =?us-ascii?Q?ZLcyYUQzGlNJrEOCZpVdQmIUGMdNaOW54ulrneB/1shjzwqaQulIaTkFjhVh?=
 =?us-ascii?Q?H0R2Ohdx47IfWezo0nQf8myR2lce8ch65y4jiVLUt+oVI1WJ/ZQ2u34Cccgh?=
 =?us-ascii?Q?0c0kNN2VYsvyZgYe6fOCqiadz9SF7LTeT3BbmGOf7OzQdrtwuwKDohSCAbFJ?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K+lYmTy6dNPMnLx+WXC+SFomjlvKGfQPmCVOiOIB0vgdZhg8ZOfPKjubBA1rvczhqUYjlD9IC+j++LDKy34FF4VzPfZS5j/yWNfG50OlsaL2Obzwtl8EuziwyHzmaBY5XzfcfGms1Y/0ZEV+sg0HKRV1qWcT7c7DM4AyC2lsvXuYB/j7/OdJA4tQz/hvfo53Z3XA8HY8jCBKUY3J4rFfF+49wS6dmT2KSi1jL8suh1n+JJmnc76oZA2klPNTcW5PE51Tdh1Ds1nSf2c/VKHns7PwBnEPkMi7AA4teDwyTllZ+N38Sx3H67e9xGGwNQxRpA3zK6r7xt3AHiAixffvb3Tiv4d+tgm8vqdHDMemFYHAElpMb7y++xBBdfQg6ZYRBEBBVomx04MXnC3+znMG7Rdh0Dd0TBvXCs3WnXawxZd/DkMbUkwpHtKeQe8kMZ4q+Ukm7b+93FJ85CjPI8iR3vsNbRWu87RwNmNQYo7GV7kOgRQu2zeba63nVxThrfYby5H2Z8UkstGDKEZkekkFC1hFqN157avo0qWTBPGozEfRHHEnhDTiYNxLbcLCeDx5Rf5wTa6enDC5WvO5Zr38FkWFkzl4VaO+MboabtiJ17k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51619492-8ca2-4d1c-9187-08de2c026414
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:09:51.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iewMOj2CnfLAKG2RMWgNVFxx0PgKaUYoNsQSngHoELjgRKycl58kC1tBGmy/yu7iEapnz29gzLLHve8Xs0HYcBoPLTCRrTdqq2mQtka9T4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=992
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250073
X-Proofpoint-GUID: jbwvSaVfyrZ2xg8HCcouDuVcKOFlWZbj
X-Proofpoint-ORIG-GUID: jbwvSaVfyrZ2xg8HCcouDuVcKOFlWZbj
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=69257264 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=WiZgUSYhaYhTsNMrsfgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MyBTYWx0ZWRfX6zlk/CRF+VJD
 a2jQYgwcK2t1Sc7PmWoF3HT4PADReowsPcvkAqGP6YuAEVMPWa3iBhH6rvNGrrlrW0T1nsOoLjm
 tu/paf1jha5Mrk8Is1rG7m7t9wGpFiwr9fB14VeinKXju+0HkwNXyjLcoFaiiZUW4eNSS/xzjov
 g0mikhiM55LHJjMw9oxNsQf2Tm+NDvPv016xMr2EWeoHkIRIvEA2g8nOA+7kpoGx+8LJmfs1pAJ
 kMdEt7cCcaN0wMxOTcs2X0gmqseeyfcfGfEZUp/LJ0oC+S26B7l0iWyOZ8rVq6Z+B4y8fZKBtmU
 dPGC2uv8WAVFHSPAD44iOJnnXmk12CVlieYQ+eph485WslwXG2/JOVLnbRUJSdRADveI8QKLsPc
 dLkq7r20fU8JfIgMPLt2IvHUwTNwhA==

On Mon, Nov 24, 2025 at 10:04:36AM -0800, Andrew Morton wrote:
> On Mon, 24 Nov 2025 12:43:18 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > It seems that the ordering of things has messed us up a bit here!
> >
> > So this patch (3/4) currently introduces an issue where vm_flags_reset() is
> > missing from the VMA userland tests.
> >
> > Then 4/4, now with the vma_internal.h fixes in place, puts vm_flags_reset()
> > back in place (this was my mistake in the series originally!).
> >
> > But then this fix-patch, now applied as the latest patch from me in mm-new,
> > breaks the tests again by duplicating this function :)
> >
> > So, I'm not sure if too late for rebases - if not, then just squash this
> > into 3/4.
> >
> > If it is - then just drop this patch altogether and we'll live with this
> > being broken for a single commit!
>
> All confused.  I dropped the whole series - please resend?

Ack will do shortly.

