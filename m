Return-Path: <linux-fsdevel+bounces-68528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E452C5E306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DA4F4F6FC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10882652B6;
	Fri, 14 Nov 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mToCs70B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RsT6lFUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECEF23B604;
	Fri, 14 Nov 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134597; cv=fail; b=EpN9pdiCoJPZ577Vcs3pa4Me/A7LaEaTZNyKfPLDJsRrZRpgUADSU8TfniAXD40lqwUz1wAK7FilJ9N3dQ4rEVX9YKuG1fSv4lYiD4W+BD7pHC6K+dh80sOjkH9iQ88d+Gu+QM69vMTmm2JKLR7Ggbtdo2vQ4zUAaCclEwxHKys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134597; c=relaxed/simple;
	bh=HCDt5sogxjz8ZVO7ZYyauIQB9soouOS8EE5zGbg17XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lcXTd1wJdD3jKHCseIOyKyFWT+gQ6gkUCB/F1jkMmPMbALoLz9/nhvgUbYrvNT6NPJofdT1OKzLy0bjU9EBYwks0SmHibscbNDht65O14KRuyAT5/M/cqXbqBj7DPGFsl2oGQNdDy4HQR2qILZ6Y9N8fqZaertkDV0+a8opWMjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mToCs70B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RsT6lFUy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuTD5018333;
	Fri, 14 Nov 2025 15:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C89lwECO0QcjA4xhXX
	OTqGPU2IWVdXZZgqkerz54/iA=; b=mToCs70BC2wCcHEA47D+0o3Q0o4K4XKcDC
	7+L5B/4Z6owsHh+XseDn7s+lNgVN9F66rAAPtCkNE02+hGaokjUU7V0Ra90MtOBD
	+upBciQoyk01FErZXcfnn3yed1uHuwUjIXmfawBwqHTMLRKorMe+utXLxsn2SBIG
	N8Ao/AdGM8n++/z3nXYboAFWzpK3lJ18dMzqLE7ycBxQIrpsZ63ezcKtxknbZ7nU
	Am5lytvsiue02UgY/AEjpIi+KTPWVL508IIl44OxTua9FwMTrnpFdP3gsfTA23zr
	xwHP4RJMnm/o6i7U14bHXKHRfDhzPF46HvvXhqOAV5kXpuz7MzRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8ssdc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:35:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEDsGnI027622;
	Fri, 14 Nov 2025 15:35:17 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vahrnfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryYg8wIoXYSNimySa8Mv2hcT9iX4zMKKWBJJGWFW6TqUWQDAwGQiijjodgMZEKouujcRi34ghD3pVHKdZ9eNo2S3GpBNRorw38qSTREv5O+KTwM2qTSDPn+Vp7ys0FhMqE22rus7t6g0LfT5IgCtFGUKyxnCj8+iU4Sa7NKicCltyT2AvOlqLOgIBo1gjQb07OIWA9gHMaxYYd3cW4JRjoUPK8/kQgDxsX9ZsK/hIJo0eds9voIu1Eyi4V4m4fW6iCPAJQUholI5PGhQrDRig5JR3AWZk+jypj3qbjsb9+2gRhJjlmQMhEDy+eMUb8jNZAIRxzWm/07kuR+kDTxfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C89lwECO0QcjA4xhXXOTqGPU2IWVdXZZgqkerz54/iA=;
 b=R4ZFrpPcD1mUaQHdQaAX1HZfLuvT01+XgI0uRv8+MVJmk4PNOItnDtlEP/VUAHub58yi9vMsegU7TtMeEY8CnnmtHxZM/VVqnHkWAlfVy0NthayrBKfewb3RLGqsIZySCqLk2BY4EWCWrx9r/lX08foX7j+D/6M2T2bj5PxXvWML3BP9DpkEAED4NuVCN4CeeWBxsla5NXU+fXCKXkP2V32cLkhCh8yQuLC1g9hDVbQfZd4s1nbv4bl5c64Iuz++ipmycLiNA7Ujx2v48zSsZxwClTAONxWUc1DoxPG4oPflA2hkUD7huFSDuQd9dURwrGDIcU1lUkyI4gVOfRyiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C89lwECO0QcjA4xhXXOTqGPU2IWVdXZZgqkerz54/iA=;
 b=RsT6lFUyXZsX1stLVs8/IYeUKodU/rlzkxbTMO7qsuEdxy/thrq0BNvjEdSu0qW0OTdv4FFsLwkQCRmRSnAvgu/yrlrpNNbARGxCGNnFsGkIblZz0vUo0EnErJUG377EtcAe+8FLJtZfH7ro0Sdci0FYMV2QHeRMHwME68YHu3Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 15:35:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 15:35:13 +0000
Date: Fri, 14 Nov 2025 15:35:11 +0000
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
Subject: Re: [PATCH v2 1/4] mm: declare VMA flags by bit
Message-ID: <b0418f22-5d35-400d-9285-eeea9e34d3ae@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0402.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: cb58f1e3-27a0-40eb-705a-08de2393674e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwBVLIP4owGyDobrIt2SuYi0MeAxOVZo9MaAQTU9qFOm9Bm5yg25/s3bbr4D?=
 =?us-ascii?Q?IpU7gy7Tqjsz190pZvETpUloUcUcwZhYTeNBa//9waXVSJKWjtJGWl8PLi4b?=
 =?us-ascii?Q?9WKAkKN1czHFh21UiVgBPFHxdORbUlYmpinipdiAO7dX2v+0fE02pv3MFi3W?=
 =?us-ascii?Q?/Ga3NDiXR2a53v9gMnfdCBhnM5119KzgIQ2Es3FnGIgmOP0YvhMR7k+dQVHf?=
 =?us-ascii?Q?s/G12boT3Z9Kx1U47P23fbie0IHq6cfNVRvsVcGB5ukJ/0NHVfO6RbJGV9+2?=
 =?us-ascii?Q?o/TcHY1P2/FXoJKKyFo5XmByQFzMvAS6u56ZMFryHuUhDkT3VRm72+UPz/Rw?=
 =?us-ascii?Q?y4LFTh4UZkIDxOYuPACKagCoKX00qPfTBh6uAoY0Aeho15doHUCpG1DbbSu8?=
 =?us-ascii?Q?4VpKwtC2d27BT3ptSLLM1KxCL0mN7Ar62KjOkkcf2YIlpRXjxqCcjmXrsLka?=
 =?us-ascii?Q?QqBVNrz1ws3AWVgvjb8goSusbZLM7UKDNDxa5mg+9FLSaYXUPI82qxu7GQyV?=
 =?us-ascii?Q?C/X5suoZ00rsRhjXHG6zeCkw+gGKNSJTmVYYzXjTzx3xL/vATS+Qk410YmeH?=
 =?us-ascii?Q?3jkv24x6hfpo9x1MW11/objvRJTK6wtpncugSSQNRmBI2/6/UYI57J4SHrJC?=
 =?us-ascii?Q?pjUG7xwPPIh4lwJp+upcXa6Wbl3PUc2f3ePPLZ1SJ8yAJHhZMjw4pPJrDBhn?=
 =?us-ascii?Q?V1RHVaytmVMQeFAAlWV/mvHIB0qTGfm1Uw07maPAOYCGf4vc5KP4X21QQ6uK?=
 =?us-ascii?Q?FZP92LysdbaUEC5J+6BpSRoaeu/d9E+f0FDq1UNmxX67/l/5kDDUacZqpiru?=
 =?us-ascii?Q?3ACVqaodU9FDfhiKL/Wvyb5GSaqMTbpQwBWQ+uCZb/3+NAfjOmEsUsiZDCJw?=
 =?us-ascii?Q?PX8c1XrXMTaCTdINmg3bolDvpk7GB4olkgmGJIDJSkMPNLc9OQgid3/To6g+?=
 =?us-ascii?Q?1JNsvMKD+uFCs+2EMcNF28CI3gJa9Z8rFiK5cW23DA4kSkj+4B8PMvT8xfI8?=
 =?us-ascii?Q?ZTCVrLi8dnOghaIDIDIUEXguqzu1yt49M1Yk0nBPbwlxT5qCUE3Th8zKxP4J?=
 =?us-ascii?Q?0rCdX/6n+vh4avYkOf0D/wxDP7f9Crw6FhOlL+tCLl1dlfeOZ1EqIkGk933C?=
 =?us-ascii?Q?DCUl5HPwRHyNPxqIEEaM+pn/ZKHM0V9Fc6DnmWyF0LZ7ufY1iOK6HRgp5pvO?=
 =?us-ascii?Q?fIby7t1wDECxVnqnBOMdtWzDCgakTw9Qtx9W/CJ4tSLjqblGR379clOHjDGF?=
 =?us-ascii?Q?/D3xTjotJpzX8mrD141wwYnPBotJkzYxMHYKCMKteQN4qHJTMclarVfty0DM?=
 =?us-ascii?Q?L0Gj4NWtyk5Xl8YulcQU1V2DO/I9LZOXvR5bVs52FQbBBK4fpB0Lh0mUgKrK?=
 =?us-ascii?Q?Bgp79pNjUeZMtzYYOGwWIwffQ5/769Q6IfYqYQ1ijZTzOkHSy3avYQ5EZa4K?=
 =?us-ascii?Q?4MeLE6bAMlQgQTyR2AoKrD3p+RxP1eUb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFaoyssfAmfQIRKWNHrrz+Z7JjIiIY65riJQgnCUk6+MwujpJRcnFR/FKs+h?=
 =?us-ascii?Q?KZ03w7TPGPWSC5Zt4h38NyTwk4SY+rlmujhLq9iaklAs+h2/bMyDA3BclVn0?=
 =?us-ascii?Q?5qTT2h8OidGuEXmrsA1Esx1vmQCvDjzWUUvhPF/apaCCQ9hmaJhto8vzxzzV?=
 =?us-ascii?Q?inV+KICL07YiBwM0Q2tFywve+tHbCGaktmNjM/I7Vzbv17W1EPTNjVpJcAmm?=
 =?us-ascii?Q?+XsNDdjnBunOv89IER9EabsNlC661FGC8vqCmBm1Tj6ILbnCz88i/9aeLu/7?=
 =?us-ascii?Q?nL3EILINxwJ/ml4ge7WMfB7V+YNj4+uJQZQaL+KqYkuTKjhswSd8H5/uhwnl?=
 =?us-ascii?Q?5HRznoEYRIEXXV09DLHTtVeuOQMZ2Ng6g02KhxV4YWOfwObZjTkgm8RtLp4u?=
 =?us-ascii?Q?9FdOiEcMLL4JVAZIUqr1G/5dK4bGUd0oJR/aDYqjzEMaAgczQzb9QdwDrSjG?=
 =?us-ascii?Q?itB5CW/RLbsUEbSYkynzzgRO/D2O5+D0AcV1B+5pbAGYakZpTo2H+Xy5i+YJ?=
 =?us-ascii?Q?ms3nz8l/yqXeeyCSd1kT0GWBgSIpVP1H4C0C4V3NGC9JElggkAYhAMplpple?=
 =?us-ascii?Q?lk1gKOjTSm/3AKMrm3QzswUbMId6FdywOE1OKOffnzjLViBANszSm9+Z3sS6?=
 =?us-ascii?Q?cAq5lub2zU6QseIkuqn5uNRWWQotESGC1y1F5I/g4LT4VbOHtPXjYGvNLPaq?=
 =?us-ascii?Q?sIAAktDu3Sno7/qqHWRuTzGcHDGHniR8fxj/lMT6QcgOpi7XSFDuS+beIeJX?=
 =?us-ascii?Q?HKDry3ydHyZeee+PVfhTmeKKRpbm9YDWdXO5bImk64q+MPzYLriCsYywJpeG?=
 =?us-ascii?Q?tgz1fXK0x87wYQzaa3TcQ+6328usG1gdVKPTqpr/A6v9PrfbajVupFZfGSVW?=
 =?us-ascii?Q?LAJ7Xm0vXLHXLGp7AoqzTEUGPY3ojBJ6dGj/+NM5Mh9iIaw6Mcl6r2RO8IxZ?=
 =?us-ascii?Q?iiRRp6Uy8tmh7g+fmao6QebkOHXyrH7756K8g5sYglFp+dkcSXQI/FiIVgcT?=
 =?us-ascii?Q?bCHBYjVQwZnCZ0n0EV4Fs+9o31HYUucGewTCvE3c1q6qVj/TOHUoBwBk42f7?=
 =?us-ascii?Q?pjGVW5yZBOosqZr9bpJ76cO8SV+bJV9PL+qzmg23+vqJ7Ub61oaZdxwVB4h8?=
 =?us-ascii?Q?0uhZKg69DXsAVtUcTIvS/BzUPX1Db1fQwGQd+EB8+5tIi2PB0MP1Hjmr6aJs?=
 =?us-ascii?Q?oCabKORXKPj7+A6tfhxgvzMwV5udiLDMSmy2JQUSABsPLluDxvISR+avzFHH?=
 =?us-ascii?Q?gSz5hFwD66aDf06aPWlNBm05HI62vmLwtz+Cj+ZszRHFqyjzDCORSYlBL4tc?=
 =?us-ascii?Q?Tw5HqpWqDD0mopLNgdCS5iO6pjElClCg70L8UzMldEphSYHvbEEiY6ylC79N?=
 =?us-ascii?Q?Zzq/v+F2UvPtxgDxjGlgEoHq8fykVTYdhnPl0GQmHiPojx0pXgvLk6Gs9Qqz?=
 =?us-ascii?Q?qMp2RzT0nKcybJKLiS6xT6nH8/KhDKlccH7COAKyKdNYzCN15ISm4Fzlbkoh?=
 =?us-ascii?Q?goHSQ2+OM/UE5ebMyH6cDfuAyBuIQdEh2TYn7slQQixK5OAjprA9HaQ/X/Uq?=
 =?us-ascii?Q?G8P5tV/g3ZHjCs115tq7o6dRMmhKPnfbD84TSMrQbgAaNrQNj2NfAKnhsK06?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A0vsFLS5kRO/6xqNH+TFqpxRoKlrC6xLdiEDK5W5Z0M0z9klb/Xgw4lL3QhSVGdggNbBB/J+SR+RNvQD2mFnt3BMDsKcRKcXwvhDymXy4wwKxOGEkCjlYo0Lq2SO1Ah/c1iKNkDMZmkJNt68JCNb7a94U/s4qHN3JWqA1/qoqnUAKQW43FIn1CR1O85gCmTx+V5mSYXzoq5vGDKmt244fq1ZxOH8j8FDL8GolACtUdEE1h4j3vplSdZ6yoboeXrmad61H0bs4No47GB5FYwLy6WJavlGyX02ZQ9tPuP6KfL9cHqqA3qjJvS2dQFujx1Rg7hP+DxiSLfOxkI4Ud+8yJKLxmev3ZZXo7t7eKyG1TxaoKy/0eVk8PJWPpgRcXGkWLkk02UHw95Sr9IzA8Q6E4qBhQfoKM4CEUFS42jnRh5F99LsWq+qPqoOdKHFo4iMa+AULdN12vr3eNZOw0TTZR6p42gli0N7/IJsXTbD7XmRgPaSZWAVnJlRDSjQobFVpX+kftJ+XnDv+RTHzT+Ji0Xapmj15mfnBna3IERNbEGX+fUIF7h6S3FAbm4qAQkvuyQULQRIduO/2IfbVdjPcc+KrYpmKkS+BiF0K4FrpH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb58f1e3-27a0-40eb-705a-08de2393674e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:35:13.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZwpWWSNkxs9Zd+5KznwVXIpN4B/VgqG6RwkAoqWd4SyWL6Xw5OJMG0p3vi1qBoZuAHMsYfRncdj/hN0OwEftyM+epsgnlsthZy+B8VjODo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX5jQaBJowVPEt
 Ly8EbAJibxK/fJ4plY7VcchlQ2GWqNIE93O10BiOSyRQC5GY8XgbJhanlJ3rm6NReeiFEbdTRXo
 /2brjd/siQTxFbSHXGB8Iq+FzhMD6OJ/0BKOYZUbtaO6IqSeBgdon2z+CaEPoILTJJeTxh0INgI
 GvkfcHsXOipvsoeJ3WDeOHvVpkTOzBYbSgwcoUrIqNQ+5OVI4wt3mpi7heDuLSuDhDbSQbzttxl
 S3cqoc7WD8bUI9VUd0PM2tUulbh+6LAzwXDCec4F/aE5dCRaFf3X7KUKc3evMKRz3rzlTZmE+0y
 L3WWkE3tt1XysfvZNjJDYHDESHq1nKBKNLhOhABES1R8qIoGIxVu+RkXCR9rvhRVmaz7aVf+37P
 cIK3vRSxTbf5cZrQoaLQFEPDGFDHxyGJRJ+ColrIBm1YDh/9p/s=
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=69174c36 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Xy_cMxhiCzFTsaENbH4A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13643
X-Proofpoint-GUID: lC7eMI7dD_VTt3mrK2huTRCA4EXidk1f
X-Proofpoint-ORIG-GUID: lC7eMI7dD_VTt3mrK2huTRCA4EXidk1f

Hi Andrew,

In typical fashion nommu has caused a problem. Sorry to send a couple in
quick succession here, but nommu will nommu... :)

Thanks, Lorenzo

----8<----
From b14b98a2e78a06c6a3ff790bc2c188be94202e30 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 14 Nov 2025 15:32:14 +0000
Subject: [PATCH] nommu fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad000c472bd5..9824211d3d8e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -409,6 +409,7 @@ enum {
 #define VM_UFFD_MISSING	INIT_VM_FLAG(UFFD_MISSING)
 #else
 #define VM_UFFD_MISSING	VM_NONE
+#define VM_MAYOVERLAY	INIT_VM_FLAG(MAYOVERLAY)
 #endif
 #define VM_PFNMAP	INIT_VM_FLAG(PFNMAP)
 #define VM_MAYBE_GUARD	INIT_VM_FLAG(MAYBE_GUARD)
--
2.51.0

