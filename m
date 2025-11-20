Return-Path: <linux-fsdevel+bounces-69232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D78C748E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D46703449DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8159A349AF5;
	Thu, 20 Nov 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="grvDEy3a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0EIIB89N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A7349B1A;
	Thu, 20 Nov 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648938; cv=fail; b=jVBkg7ay8sRedEGdQT7ykCLi0dy/KEmT8kjw0PzO35+By892m29wBe/eEQvQ7t767LDfxwjn5qDrmgmoYapCyOHKssOzuf6zU9cD7CdcWmOP4VegTPsmvVfyD+xNtKd0vVoUUs+kHJ8jgeBiuQ0vijcl7PtiO+ZJJTITCJNZwlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648938; c=relaxed/simple;
	bh=BQAOkCCQMjc8mbxrWN25UZ2vAF0r6bo7emQTvGQHBMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FhyAycyb4Z4kOpjDuxr2ptm4eg5E94gYlyB3wWX4t+No4g5cwi2yEvTAUPc8HRPivWxvaP+YGddItmUU5PsWK7NWRh9hVS+VDgXdBL2/t3icvZ6ZOhQ9PjFwXXEspl5oRfW/Ty48JNYifzKiDaxF3/d0I/8SsbzDarc0I6M68Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=grvDEy3a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0EIIB89N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCsF1p016366;
	Thu, 20 Nov 2025 14:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Z3Uxu5Uk/gzzPNpiEM
	n84StYVNxZ6Xy5+Hq1t6/24lw=; b=grvDEy3a5wcEIxtK0Beq89Z0md8NYTgDXO
	vWVtoQ8dEv+BcKaGxjqf5cHJO5dlOiu4Zb2w3RYd1tTDl+ilQ9EQY+ynY5DS/470
	oOMPcg+xTsRBxniYZtwiyAq37XDNNi+5TAYmaPUo2W4ZOzov7nP4TbDGdpsFhioP
	USWy2ydwElZnQuJE6svGBGHHhIZZkV4TobN4F0SpaATEkKCtKf126CpUZTBqhPEc
	1iJHWRBognOicpg6mUfHeyRLpXQ2E0qTx3pCpzJNlVrn0fHuTq18eQ4XwjMe991x
	ML7/0dbyO6Kqii1mCwl7cxGIXmJu3k9rJhd+IY0lYr1eRm8P3eBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1h5k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 14:27:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKCoSmO007957;
	Thu, 20 Nov 2025 14:27:10 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyc5v63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 14:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJGyF/fZU9onSehHds9He3QLjRoHWIoaVv2QLR6yUQH53WHw4Po50Xll2rJnW+WeHMAeVLOmrVEKUviWGAmZJyhYxey/bS5raySX5OBQ8sauGVZALk3HgWHG8AaEdd66hN8mC8X8Iu2b8QGMILL/nM2+fNmX2QimymWmsmzfsQPch26m6339eUMfyELBnD+1rC5T9hXkCvQzfBtiel6jZMOwCMi9FoYOf5KgCojHoqn7Y6Sy4aJ/XPzHBh7jhqF18P/+q1W22SNVn3f8mdD9ImXKegxNj7xQp6Z48LBDKiBV2p3HlFcCl7E21H3hP/8T/bFoHNt2IGyrPcALCQNnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3Uxu5Uk/gzzPNpiEMn84StYVNxZ6Xy5+Hq1t6/24lw=;
 b=Su2o4Al+OsFwu6vS9+i9MrZOPJ03QrllWKfXi/2EjwmwP2+r8ADDex2w/cj0NlS7G4yD5QUyz8noTKRRD5E1JU4epqopbWSKkrmV/FqpLoyudbC8+i6sgkoeb5LdsDpzzXsJxh6e3Blf5GdVr9z9hk51q95LZU+T/Vw+ZSQQfCutAsX2HhdEBCkvWo81hvjKXElFXJrrhOndzy7LsTvFU7+WZ1BWlGjQyOJxakZylY4JqL5KAmeVkitiktcezKCICbhVZswsrQ5LvXCUzi4YVaie6dVHBNvQm0PdDywN7xNX0JoEQ1ox8XoPP5nNapwBE1mQkhxuC4KTvENucxmvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3Uxu5Uk/gzzPNpiEMn84StYVNxZ6Xy5+Hq1t6/24lw=;
 b=0EIIB89N0Mf6AwQxWMOwAiwD4U2F77qD73/YI7cgQ9bv61xvVEsmzN/gJVTY/8mTDKxXzMzYdQWWBN63SdJTwRzUau7KT8yPvTfQbVXEkwMh8HHwLi3BnlUAZxQC07mRW9qBabjA9urZ9Wzidh20+CAuMoOz1vjImryT28H/uzs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5878.namprd10.prod.outlook.com (2603:10b6:510:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Thu, 20 Nov
 2025 14:27:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 14:27:05 +0000
Date: Thu, 20 Nov 2025 14:27:02 +0000
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
Message-ID: <ad8ce21f-7be8-4d9b-be49-d71010e92055@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 741b0655-7bd3-4309-7483-08de2840e0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bSbR7YL8MO//DJcw0Xl/E3JGmVQLDKyKPJeTQSfV7KCNA+EB7mv+3UUSezZt?=
 =?us-ascii?Q?nNEwLtcVZFelfgNxSYmJdbPMexBjqfRYYI5IVpMJL1WqABRDswLdFde8RoLL?=
 =?us-ascii?Q?jmyv4BDdCkxqQz3IlDg+rbNawzPzDXM+cCEKuiBKTHv62ozPXgbGUKUDFE8V?=
 =?us-ascii?Q?VbngaNAKUR9kI7/Bw2Q4dp8QDV8936SeUc49XjxAwNKot58Qhh9AtcN9+8z1?=
 =?us-ascii?Q?QTzcXq31FdJNgTOsj2X+lNrB9qrf9E3bDspkl/hak+s54zeY8mUUM0ep+d+g?=
 =?us-ascii?Q?Xxw1hyb8DtiUWSIcVcv1YcWgzoN+7a2ih9sYBHVkAEyEU/t7ZosPnhaZCYDG?=
 =?us-ascii?Q?mhuBv0X6yqe1nSGQTLTvQRGOMi8MzI3VtXYAKk1SW8O2kusJZiMOQ6tE9V8A?=
 =?us-ascii?Q?iba3EMGk2guSlPYEmubkvnr7/cUhMygeezMrk1O0Zwa8P16T7bl+NPmQebC+?=
 =?us-ascii?Q?U/L6lJxVV7yNhLpxAU2BcnbfqjTKRqGzJl2HWhUyZJS0ETfFDEqmlr3cZd+/?=
 =?us-ascii?Q?9YvAC8kGyr6oCr8AwKBb/nb0S1CxJufOv0sNu6BJ13IsMTImtS4eXYKrF2gQ?=
 =?us-ascii?Q?VGQPhwIvB6WA6dQ2K1OVZ3OuBEWOCZ8+B7JSEHxdepyecfubFjxVJb+7qk7k?=
 =?us-ascii?Q?TrXTAVWReprbwYvv5cVLb+Ppj4NEii+XdMBBU1I3QntBNzk9mgIvUpBfHdZo?=
 =?us-ascii?Q?ZHkK7YKqEEFXzB0OFRY2rlwg3sHjdU/+1iN7/wGMq3tmzUB+r5vY6o+dLnuo?=
 =?us-ascii?Q?42ggR/XoN2nRzB0uyDlgMkc0xTMMDiKQJ0aLyiSNRpYLIH/jcn2d4+ldd9Gu?=
 =?us-ascii?Q?G5aww6/OjFBqhvPjwrOOlOB2Uf+vqKSxkcr6G6LU3oymemAag2+cW3nWr/0o?=
 =?us-ascii?Q?WEheLMQ7dkDxodUUWPpkI/qCMDImte6h4JeiefPO/VNEjpvEB35EnBrYeG7p?=
 =?us-ascii?Q?Wd+88ipiDLpthKaBQUAE+0tqMYmfy+WFjbpvllbQpwlhRnu3QXZBElq5yuDd?=
 =?us-ascii?Q?dgqrFb/oyJ2h4MFg2bRCYKhRlyvD5aVnB2cp3mLmuZFJem+hsLm4LIWM9oRB?=
 =?us-ascii?Q?+pjdyRkxM4vVvUdndmUFQWS3Ge368+D+glqsJWVETNGPCJvwbcxbQVzfO/ro?=
 =?us-ascii?Q?gry9VvUY7Z30crQmWtnM4TCBT97WwHZsUMAkgJ++riuHLFZCedMD7uZqoq62?=
 =?us-ascii?Q?uCFSzSV/k7QwE2q1jgWPw4Q/ybqIeebfO9nrxdjl9xLulipm6Mz4cWdwo1ye?=
 =?us-ascii?Q?NIuEW4FbBFDOo83tXOGjqhTvoPPNizdzln7+8wdKVGz9PIPX3DkSJNiylgrv?=
 =?us-ascii?Q?CP6Mg8qwIBo229UMWQI4I0ojib5sYquC5WjTESoEGKMPgtsoh81mESp3octK?=
 =?us-ascii?Q?UmQgOW4WimeDB6xOIPAD8fE3MrF+jJ7/fuh+HAiFqWjnVCVACHBh6BR9GfR8?=
 =?us-ascii?Q?Ip5YNyCDUxp586jh21LiEuLBZENj8XWp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpOcWcZKWbnQjaUyQSxDWaIPozEpXS/jqagT02cqCMPCPZ/OJQ1hwIkGb9q6?=
 =?us-ascii?Q?9Vp0hU3uq1bINCG8ehSJkg2LZX0Me30wXYGuNVvEr8mssSrxj17mOUNWKSQk?=
 =?us-ascii?Q?xfeRWGncxU9MBGEBfrFSUSbUNdX0jY84wLN6EUE/fvT+eowLSuanUoKY5X/T?=
 =?us-ascii?Q?9UaAPfQAxPsvaweVbZDiqFzUhIrZiJ9/jmjad9Td24LKYE6fZIKxmnF+KBEb?=
 =?us-ascii?Q?tHt2zJwmh2DpHrsPM45yXcVcSXuWHXhxtsEb9j2oxuVbckFW943CBnnEDzLn?=
 =?us-ascii?Q?JXu3ez7D62aizMXE+3nfrU/X5JheVtjXDhGkCT3v/Nx7ZNzyq6a6xxs1/IYo?=
 =?us-ascii?Q?aJK8pZrntcSjj08M24e+W38UbB5Xq1TFFK97uHnUvU2SzrLYajXaes5o+fae?=
 =?us-ascii?Q?6+tRGImI4pJrmsTZn+2ZT+dgplRGcDM5ZpxBqVSl+xfy3lIReQFmIiDoSdKI?=
 =?us-ascii?Q?EwIQLleVirFazEIdfEaDL8Boafks53ElYky9lG+wLWI9PUyTY0i6mUE7VahD?=
 =?us-ascii?Q?Y7oiTRag6r45Z47oACqxgYwAyaYFxp8rUUFB9Nc+quujJD8tk8QlOEmhzjsQ?=
 =?us-ascii?Q?xc+7p8PynAOjePwa98+cXI9BQF6KJhkPr3ZOAjxwL0Uq4kuFURjWgpa+yKs7?=
 =?us-ascii?Q?K2DpLj8RzMzQlXC2s2KlsMf0WXmXrb56xyA4thZ1CRg0CVvS0uZ6eDPzE8sa?=
 =?us-ascii?Q?+tZMdc0mG4NbsW4vejnQGRsWwCrtnYZVHt9s+Vlme9lkCyHr+zXqSJt3yrki?=
 =?us-ascii?Q?cRP1FNTpnboO4WBd0151d8E6i4wuSgBztzVr86JkOnj+h2WcMe0OdC21Obgy?=
 =?us-ascii?Q?g1tdyVLX+hv6HrvTXLWgK6ye00S+fKguCcztdWHcMelu6gewAgG+iEMNqWDp?=
 =?us-ascii?Q?cEK8d0eKJvv+QgTuUqVOilNuBVrL6wSEiXyEJYSCaTVuQNnVC1vC2NUfrEgq?=
 =?us-ascii?Q?HvFG1iTc8FCoUicE2Tou6SVsquY1FRia57AmEZmIcoQVrM01KKFiiyiSduiN?=
 =?us-ascii?Q?juq2JNRqppUCzYF+eC6tc7kFG2mBSrwyOfn2vXN3IyrqOrnYE1D3k7mcsOLJ?=
 =?us-ascii?Q?sVmsZWJgTS080eAGPaKiSoyXWq64r5+DuXMcTNzl9l3Ht9a5lzTguPKR4a0C?=
 =?us-ascii?Q?Xcu/6gTrSiramx1VRDpuDWKhhoySfpuKHNqMktrje7lSEkOjSY8+VvgiEMQ/?=
 =?us-ascii?Q?P7Vt6C1HOXJl70tdHe+eUDJISZYaxAFXKTmaj9XbBcaD0OorNgibL9D/hJE8?=
 =?us-ascii?Q?Y3+tdQRXQHh+Zi/6Tg0lsDx6zFrInDrk81Hy2eY6Nncrs0MZ+GCGOoH7eKIK?=
 =?us-ascii?Q?z1qh8hKvjC84yaX6C6h4FTmeEHn8K9Dv9wwckXCGypcdM9JH/gMIz/WtLOWR?=
 =?us-ascii?Q?p85NTn4mdwQocErnCONP5BHKE9UG90cO4+ZzIVmy7BNs33VRWiSC4c1RU1YZ?=
 =?us-ascii?Q?xTEYkcsQpDrSzRbYb4TtEvOsdjG72NOZgPaYCTpmjXt8qLqui3ULKLIOnKYk?=
 =?us-ascii?Q?ZWcvgDtn3ymel4vHy89+1nPEc9Nj/39rFf9dkx7YioXrqSgSl/aUHDrYRZ12?=
 =?us-ascii?Q?wGir7IHbeEmP/YWshhWPHJFYyDkWmcUUtnCv6rKGhlDQNayMu6W5biXZw9U4?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cAdVpXgYa7Hg7Bw8HJRIRHoxw90rs8X89Xv2mcsdFCCvR2uHJUpANDiMOCe4c26vZcqvc+spNhRD0hi0fUMYGKvMM2sQLmD4y1PY2ZB22tMpwK2ePsv+41We0nc/ciYRPAj1lhKOHqMyGnkKG/adg6vzFbPQi8nG2YV9yo1X6RKUesYC6/VhGAX1kPhVfqbfn9FlSCu6r73ITflzFmy5sWZM4v8AOTvojuESjWM0obA05SbN/a0Z8g3hZ/Rywe6DvUttCJEk6FxNKoP0B3w/sr8RGKQQ3Gxr8RWJicciA/dBmk7UrLDk5D1PBPCNyoCESeDc8yfvKl/LCLpSAcQ+XfgiIM887uN7QNqLqIWdGt0elALNcz0cqyn3/8FS+ZeRd6uSNPNbOMsYDKv3jT8f2FpAyUzfWNRckFKZMkkS2HG+9DJIvoJK/eTJubd+nJHurlLR6Fc6tuQ/c6Tyq2jZbscQCuprBP56gSZLPvFD6Xz6f+6fn7qvYXB37gZPBBHX+iJAeLu3yWCXt4e0HBB6dLAJJObmXPJ+8V2V/z0zbjkBZhS7PzmA/jF5A7fBOA0P//tKaLO6OYgYiockpOQz0Yb/Cs87+tnyXhSO1N2mjkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741b0655-7bd3-4309-7483-08de2840e0ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:27:05.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9OK+NkkMWlLJZy2ybQAapnck/TFrLZVBXPOBwCUtt9OZ75UdF7olmT0tGSMhbI0YYHsKWgVqstffW8VXEXppvv3/6tLFgQTxWsZ9EuZftw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_05,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200093
X-Proofpoint-GUID: jf2K2HN6xROOGaKf9EGi4iQlmd9rSNZs
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691f253f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=512u67_GNk9oqOA5OOEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX6SrKYf6pFFth
 PMXG4eRpLXitxzwWKn23NWxTGkPZ1QPs/88yWsMpSiqRuuhQIdtYzIqVP4LsTppYZq/StWwXsE2
 Eo4zAkJtaW6TTPYDpF24yToR/nS/J04HzGmZ0ZW+J3EILj9sRmfxoEJMGnPR1UYsraTo3sHhhjj
 dW7b++84tkUaIo7hlR9kTjtxn8SmJlSSTBUQQMS8BAlfwOk7YOpdzhY0VR5Jy6F0yl6CDLrLE1Y
 fjYvpJHjP68ZJbQB3CJEyEAPB5BGH1O8EThlffYES74vPTXcwGKhwEbyGwTD43fuNpYNUNyEuaA
 BdN/JkS6ETZP+4ZvXJ6b8BLeVkYhNYe1+2bO/ibUjhbO1KS1cTkU/Ya3dy6D3Q0AjdVVzFN+c8c
 QGqQMDWHIU/MUFtTidEsog+FWrOiOw==
X-Proofpoint-ORIG-GUID: jf2K2HN6xROOGaKf9EGi4iQlmd9rSNZs

Hi Andrew,

Sorry to be a pain, seems build bots are sleeping on parisc32/64 as there was
some accidental duplication of VM_STACK_EARLY when CONFIG_STACK_GROWSUP is
specified (currently only a parisc thing :).

The attached fix-patch fixes this and some broken whitespace.

Many thanks to David H. who noticed this and pinged me off-list!

Cheers, Lorenzo

----8<----
From d706def8a4511b42bc7c7da0a01a3f30cd054e6e Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 20 Nov 2025 14:23:13 +0000
Subject: [PATCH] fixup

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3148be546e11..5f7f4aad1d26 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -529,14 +529,6 @@ enum {

 #define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)

-
-
-#ifdef CONFIG_STACK_GROWSUP
-#define VM_STACK_EARLY	VMA_BIT(VMA_STACK_EARLY_BIT)
-#else
-#define VM_STACK_EARLY	VM_NONE
-#endif
-
 #ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
 #define VM_SEALED_SYSMAP	VM_SEALED
 #else
--
2.51.2

