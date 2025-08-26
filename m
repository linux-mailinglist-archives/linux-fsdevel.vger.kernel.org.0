Return-Path: <linux-fsdevel+bounces-59224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66ACB36B07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F85583F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD31350D5F;
	Tue, 26 Aug 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qn5XS3dX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i8IjGcxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48508350855;
	Tue, 26 Aug 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218779; cv=fail; b=X3O7PafY+T1ZFjtOnhXZogu9x9xRspVdGKp1ywdVYvd/t0w/leiwLUqOLwlsRiisXDiW/vHKi0o5irmAudvSEXXVDqJUNceNgA0HoVJBExDUd7+EuP4KoSz/+i1l7WDPe2MQmYUcFK1ikx/af6CPtT/LPu0Zi8yecWdhLAuO79w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218779; c=relaxed/simple;
	bh=EMQuY5yBpBk1STfazWq8MmhqoKfcYO8Kqh/FHHGBBFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mxKKAxJGJ9o3n8UzWyQY4jKeyaoGyzHay0Ccdhrj5HYSsURWgGeI3tpY+O/S38xijhG1ujrkJh/+uarUQYHsQwouhMTRZk4+n8bZiRNFUUiGlzFrtApSfbIootYKEJ+E1xiHygB1G8CGliexBu+1MDkmfeyQFuwhWZIt4/1iw4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qn5XS3dX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i8IjGcxw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCIMAE002893;
	Tue, 26 Aug 2025 14:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=11Nu0gPa6FmjlzwI06
	ncrifPe4H8Au8DKav+9sZiKIs=; b=Qn5XS3dXib0GLVgnSz8dgyNNrXkG98JRa2
	IhKmUsz1usg9kWcxvn0Ut82+dbQA6PSkPjt43wacqiQJ4W6M8kJpLTuX3QgMWC4y
	5vLYxKCaYfxv7I6Jvh5pLcIuxeYd8an2K/PVmS8ATNpbllcCdH85F0XZrqXX6y7a
	wvCedCXAJuzfHlSed6Nk/u0My4/kn2oF3vF3IZlH85DvC1XbOoMDMU5DMP3mv+ij
	uAo1wYALnSDTjE2Rh/OaFk533CPGyyx/vKZ97IIp/WIc1qxAJ7nMvKZwIl6Tq1yY
	v71D34iM0xPLB4rKYqGKqDTpPdyjLqx6eGkOrj7hzfG84G/9GsbA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e24ngu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 14:32:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCtkaT014639;
	Tue, 26 Aug 2025 14:32:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439kqq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 14:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ3Ci4YVQzCNXrfR55/L8hw4nI48N911jzFGfWt6C7zt2sSU15+zgP+/0iqRgybIOV/E9HqxFBErHCCnmp5qF1sLbM/ARLCNXAlStUsn7l8b458U6mZzoNX6MAzdPCTvUsKoJg6UaIxMai4sTYryBkEc8qvfatkERXdXIyogqat5ohZ0CGeZI33gvna3BftperqbnbQfEGvccdrSuEfy3HvYMWmfEf2N/Uv+7BKjkH/g2rN4TVOB5K2h/cjgjd+KAFq4+ZC0/3GjgMw2wb3P0PMzNP4yWhcoI6swu0+NoOZyyb1+45iFE9eRhZtXwLYI5ciNYTDoNAojeI5W2RJiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11Nu0gPa6FmjlzwI06ncrifPe4H8Au8DKav+9sZiKIs=;
 b=avNKZngZmXgmtxvw7+lqUs2t7Kt+xvoWXE6Ca9sMtUv3+MYB2ktc9iKEgK82r2vlSgQ1IdlFnFC4pBq/VOe8DSJ5FmKle6cSKDkoPhh1Ew+fqKE5w1mNPxbK6rN477xycvJBrIedwaNsyIyI7RAudWlIH+UNuZVKK5suohldvRFubFyeEfzCgFmrIXEMH25LJ04ceuyaGxFNg0fAWxOBUkaJQiUEMV0yy0QGV3Xdl1wj+YsAXERtHzmgnvTMBxs65P0GIh7Kd58wWBS9jafjVuPK/UITagpeJLvSk+W6XP3CghKkRQ1P9G8A96x9PfasFxpMGGB4WDhb3hIMmroR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11Nu0gPa6FmjlzwI06ncrifPe4H8Au8DKav+9sZiKIs=;
 b=i8IjGcxws2UbRTJtamFaK1FjQUyCzAdkHXXyEMyZehRxvs+HjGOJuTV1oiZtd0eDrZowppRYp0oIHqK79PUlRyZX4HFd7F6oBfGAaISW2GMcRDLy9NQ37Aswp8Vpw7S27QBvZOJZ8LcSZx3SMqaGOWzpHrPmCoxmja4XmYyEkQI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7655.namprd10.prod.outlook.com (2603:10b6:a03:547::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:32:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:32:09 +0000
Date: Tue, 26 Aug 2025 15:32:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 08/10] mm: update fork mm->flags initialisation to use
 bitmap
Message-ID: <1743164d-c2d2-44a1-a2a9-aeeed8c13bc8@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
 <73a39f45-e10c-42f8-819b-7289733eae03@redhat.com>
 <d4f8346d-42eb-48db-962d-6bc0fc348510@lucifer.local>
 <d39e029a-8c12-42fb-8046-8e4a568134dc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39e029a-8c12-42fb-8046-8e4a568134dc@redhat.com>
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd19d50-365d-40c7-5b6c-08dde4ad56cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Kef7l7FLGTMWAOBDQGnvdRBPaEYWuJH3wFstlBxjLLaqPEi4PRTHs6P/QV9?=
 =?us-ascii?Q?SkGk+ySCkDc00KR9rsSy6u2KxJBRZqjuNX+a6TkiVPiQnijkrCanwhDvhuYy?=
 =?us-ascii?Q?L694be8eXsJTSL3nX7PyLB6uVg9p306maPYDkOh51i8U3baRmk8hWQ6HM+zm?=
 =?us-ascii?Q?BvKwLEWvsMsBFL2U4UEz3L//oEXJFo81qs37F4DfhISmReMVmG47Mk9YUV6u?=
 =?us-ascii?Q?xZPdiBPfGk4GzRW/DWxt4uCvtp64HDSziVQUaH1yLEJYDMsdLX5LdINDrn0g?=
 =?us-ascii?Q?XiCsfSkStzxp9Jgu8NpbFZgbDu41kQ9zeD85DNGIBJ1/vPCTD5YNkhKSnZ3X?=
 =?us-ascii?Q?QwFsEli1JeEiTSqiN5GRA021lt5UmyVQ2KfgeVX7D8MzM6rso5T+W8eZbMeg?=
 =?us-ascii?Q?/R4tOhAXgiU0YRakJJlsbqWDDUs4FmcTsnxxtJHVi2dmRnD0qQGT/GpBB6aa?=
 =?us-ascii?Q?iBXmk9OKHBKLqoheJhRveyQK1V83+GhQsronmjdpFwvn+rZleD+1v1rOJkjo?=
 =?us-ascii?Q?Um+dTvaeqc8YomiNVtcNxFht0W6ISdrehesP7UoTfmYEu5KBi+a40MfnbzhA?=
 =?us-ascii?Q?n6BM/IU6OBwt02EFAuTgLeTPD6JhEiM+9XxYhw+UijJROIX4Bhi9AsVG5rIg?=
 =?us-ascii?Q?LB1gZD+0fog9+ojEIl8f75AXZDQp/GxU1pHmGeH3+LUmyTkfOHW7sLzp7xXa?=
 =?us-ascii?Q?v0jzU5Yuy5ccTkMhYu9LiSs6wU8L+ITCO/Udr6SSid1GUm6ajRP6bE6ciWCJ?=
 =?us-ascii?Q?wkdaYAjA9nEeIoF+cT29bS4WbPgNL8um+SVNvW4IJGWv7y25b68f9PlENIHW?=
 =?us-ascii?Q?J+ogG+/YJvNa03MBOJlJTgCeTpEcBH8hZDu4BAlgW7Ii/+6zg/zfHz6Xep/U?=
 =?us-ascii?Q?Tc/VxXR4mfnOE3xwNezn+4AQFifl6lU5ZcENX+ejXBNNnE2gGxNC5/NtaVXR?=
 =?us-ascii?Q?HQd6t3BO1OPsOOcWjHom/CfjxpQRx5dtVe4FFp3rPhAJKIU1rPt9kPOANEf1?=
 =?us-ascii?Q?mpy4VC83NX9PA0wTtzBliGPGW/EDh3FHNgieEkU2IJdooKCxdWb3F3iAdgNK?=
 =?us-ascii?Q?7TTd4h1GputY6kudfKZusG0mznSCgG0fFIeZ0XWCmOidlXkJph3N+EWgVVvl?=
 =?us-ascii?Q?BjMxl9DZ+7EDi1Mrx8X0i6X1D224/+glGHp/uqUGC6/OWuon27yl8Kqyh/NL?=
 =?us-ascii?Q?Rqvy2rmRCOZVAqxFfsRxzsJK3GvDzTHtbV50lIS3lkvTl/Hx6Mn1tmwQWJ7D?=
 =?us-ascii?Q?KgZ3sYzSYKhji8njMyNrir0lznu/C+I8JaFF7ogc1ETJvoeC8h4y8VkYbwhL?=
 =?us-ascii?Q?TqR2ttl3ixo0cNR2fDvbVT1wdBKJlZBdw7i0lrYGKtv1kSde+HmTcQP77r9/?=
 =?us-ascii?Q?PQO29a3tGoo1IVfTwVYnGmj/ZqN0kA8JXR8X3k1lG74iWBwKwKaCGFczdy1r?=
 =?us-ascii?Q?NAaunTyFHKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u08utB5Ku7sJWLe1ZQPK7dT9hO97maySk2xZsI0t25kOUQsH4ivMl+6PIO3z?=
 =?us-ascii?Q?3XHL7xcgra6B0FSchPhqBytGFM+UbUFvlPQB5HSK76pT4YuRH/eUFRKFoUaF?=
 =?us-ascii?Q?tsCvDvL/P4Tgv6Nt57maQ9H7UaRjhl4bM5dB0QZEdKAVXvjfmI941j9GPBRp?=
 =?us-ascii?Q?V0av3BVgUSsj1cQxCZwU6xGp8Jksjr2De+8zWzuTMeb8wnkcVp9BJ8h96OD4?=
 =?us-ascii?Q?OtmbtwG/FGDWwy9EYwNXrBqqbp8AOJHGnaySyyoza4Qoi705TaZ1uu4DGzH3?=
 =?us-ascii?Q?PHKIGm6ZhMreBvKPQPU8p2XXu822y7Z7CfLGsn4MQpzSMSE+By+qLmVFHdo9?=
 =?us-ascii?Q?boTICKTOYQ6tqtITnEmYe9CvVb9uWZEby6DmdCDBYSnDshQ9mMHr7ATSTH9I?=
 =?us-ascii?Q?BKz0hO3TgsgScDzKuRoo6o7J+fpvSJRKqueP2lEhp12yWD9JvCWKWeuh9jx2?=
 =?us-ascii?Q?6uuzIF08JptOeFuXj0ipv5oh5LU8GxDYB/f6hJ2eHotabcQt1JBLGhR221Ii?=
 =?us-ascii?Q?L3YOMuQ2DLth0GQcSJefR2OcN3bLHR54SckbZyeaHlwUhHicZtNv5E5oUty2?=
 =?us-ascii?Q?w8Z9XbzUYDCECY63kqpYzXEhQEGvP+AZ5+KX8MYqce88So+Z2yhAF2wA42rk?=
 =?us-ascii?Q?XNedNsCIzCXnnLqygXmgeasMc7O79+stlJOYjMR5usNg5/2ESjKRGtPzrcF/?=
 =?us-ascii?Q?ueGgojb7bAUlMcXaaIOB0a6+Nql8i9blvryOXA6+FbwfzzQIN2eQxg6T5FtA?=
 =?us-ascii?Q?a3ozoDRKIRmxgwwrc7RIi/jSC6sFuFu/lrz+rtXVfuYl3LWByooxMLpMKON2?=
 =?us-ascii?Q?tooY9yqJPJ7B43vgM3scpSqcOGOZU4cdaYX+y2UM9UvVT/hnH8sytBUso3A6?=
 =?us-ascii?Q?MFG6GRNhjzfSTVdm7jelbt2fwv0Rwm7/JEJGJHQ9NJwiq4+M+bFq1HY/P9k/?=
 =?us-ascii?Q?KmjrwA+VQDVA0pVRWLHKu24ihxKbKmED4tJYZSoxbun5orLaEtIx/Id+XUFS?=
 =?us-ascii?Q?K9HujW7JAzkP6au9KO/dqaukG2fxDDWRZvlEJIUQp93QjsSRO46YWnGn+Ihm?=
 =?us-ascii?Q?I0SMaxErd8MJu+Ch6WXeRmvUkDFH9MVkKlsbTrFhT4K3bTax4+Hu52GuMOgc?=
 =?us-ascii?Q?Gc6K1F6qAauuq/wPpraAFkoRn6HckZI9xI2nEUBp3E/+joqYiN7H0Or7wpS9?=
 =?us-ascii?Q?99PmlsObpRooj2r021fjCp3ltHqHu8qqqbuCXracpATyM8UBDPXIOoh4HVAb?=
 =?us-ascii?Q?cegQQrS5juoCTZIghOilZVyumcAnuDhzqZHdax1MMKPAyZkStIHlK91Lr+h9?=
 =?us-ascii?Q?k8xbitpGmGUFRPYx5EZY854OYyd5GRQXcAjnJ8NJt2YVkk3VrnWvmm+P/ZMX?=
 =?us-ascii?Q?P6jG6bQ6CFZqMdREdksbpWZm1eQ+scLllWnPylQ6muOwY9aSkuCUTbur0Efs?=
 =?us-ascii?Q?33OigiD8fQ6PapJIWjl4c4Ay8a5no3v/zusml/Kg4m+fbKMo7myHnvt6D+hZ?=
 =?us-ascii?Q?DFxaZAWpJP7L7lWM+HHlNcv9VgBTtH4o3soTNC76R7LPpxU/uO7/WpBQm8v1?=
 =?us-ascii?Q?Ry3YAcxXoTFntQCemWREWoBfvahGTVXFHOMDL5PshxwMP+eAC6pWCSD4ju3C?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c1JFYWPcFIdFSSGOZYXfzRnrTAl/pLQDYLtvkFyC3tY65BlUWr+BC+aRRq24fT4TG4cebueDBxMXzDuBX9J25swXNjZkvh4RTgSlkU946cGFTib4YeQrItn3CKp5k84TLkIOnzBpZvdRjdF3YfZ8sUd4YBG8rP54bEpBn2YU2fZSNTCN0fdCcS8HvI4F2vbhQsM59WuQA8k1jtjadpoINsuzrcpkxdcmae49BinsdQ2e7ZGOZc7nmnT8YfQr+oTrCGOf4TMvtN7Sa1RXOgiPDBdl+gGsv1DNUhrNt7l8HBAZBdyJzzdmBya+xz8CtTWHVLys/bw7p041rS5zgY11kygCGpalmAAwmXbhIuKdw8+zvqNm7sD9ayrC+hhpxZRlIRENnlMnLASZtp+tB0wD9upIcSy5NvWjbxkLDKiQMILiYpeHqBpoXUTDb6kBNyweM3DOipLai8GF/51RmMr84lbsx8lo3hf0Us4Ndb46yfmY5+JdcoIpSF3gTv1nY4ekn/ImS/22gHEZICjycdGRGOcscHkjGb8E6gHOQXeBZfMikcbEG1zS4sMK+8SO6tm7RH2hZ3NkfKVt4i9LH7gvIl4uWoP9a5wX6+xCvK414y4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd19d50-365d-40c7-5b6c-08dde4ad56cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:32:09.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj4m6Y6IMwbmJqKzlX+KndSmmmMThk/PC0D9iD+hJKxTTjPBocMx8i1sghY9xQ2hl/CeioPJXo0Az8oAzbSaBqkFJrXJp5kWUvkOWjTi7nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX0v+3IaGRWDVv
 0hqRiqovGC7FaYQdmTwpPG5447gOsHjMmvq0K7ufwHaNTj8Wh1iRDPiCyqMmLtEc1YBn0nuv+jF
 HVJXpPvV5xmS3bAPlEH6XE/TjBGoIwWtPvUWHuhkPJypdnaO9ay4n64I002vEavuQOm8hxrgIAd
 LwQWbonkmYTz0onGdMc4SdQ0V1LEDMCkRBgHrRQiyw+XXc1mzxHukg7CB3asD4qK+fbJKfOA8aQ
 CiftljzmCdc7ClT4xZM8/lrvOB8KAI7D6oqW36B1ENZJrjEYdJ3vTFn4/szm+S/k3RtVoaVn7Lm
 IyRSzvkzR70xnI7EmrVqb/sWRUu3uTgY6UOKMV2jvKNyFFMTR83kFVaPJeaqOJy9fD7JRM3TwO1
 zmFS8xzTMXBjMB/hQTR5mDo2rR77ZQ==
X-Proofpoint-ORIG-GUID: y_qpIcAycy9smOsiMNEkz9i4RGTkBURl
X-Proofpoint-GUID: y_qpIcAycy9smOsiMNEkz9i4RGTkBURl
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68adc56f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=5lQMtCN190GymnniloMA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13602

On Tue, Aug 26, 2025 at 04:28:20PM +0200, David Hildenbrand wrote:
> On 26.08.25 16:21, Lorenzo Stoakes wrote:
> > On Tue, Aug 26, 2025 at 03:12:08PM +0200, David Hildenbrand wrote:
> > > On 12.08.25 17:44, Lorenzo Stoakes wrote:
> > > > We now need to account for flag initialisation on fork. We retain the
> > > > existing logic as much as we can, but dub the existing flag mask legacy.
> > > >
> > > > These flags are therefore required to fit in the first 32-bits of the flags
> > > > field.
> > > >
> > > > However, further flag propagation upon fork can be implemented in mm_init()
> > > > on a per-flag basis.
> > > >
> > > > We ensure we clear the entire bitmap prior to setting it, and use
> > > > __mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
> > > > fields efficiently.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    include/linux/mm_types.h | 13 ++++++++++---
> > > >    kernel/fork.c            |  7 +++++--
> > > >    2 files changed, 15 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > index 38b3fa927997..25577ab39094 100644
> > > > --- a/include/linux/mm_types.h
> > > > +++ b/include/linux/mm_types.h
> > > > @@ -1820,16 +1820,23 @@ enum {
> > > >    #define MMF_TOPDOWN		31	/* mm searches top down by default */
> > > >    #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
> > > > -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > > > +#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > > >    				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
> > > >    				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> > > > -static inline unsigned long mmf_init_flags(unsigned long flags)
> > > > +/* Legacy flags must fit within 32 bits. */
> > > > +static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
> > >
> > > Why not use the magic number 32 you are mentioning in the comment? :)
> >
> > Meh I mean UINT_MAX works as a good 'any bit' mask and this will work on
> > both 32-bit and 64-bit systems.
> >
> > >
> > > static_assert((u32)MMF_INIT_LEGACY_MASK != MMF_INIT_LEGACY_MASK);
> >
> > On 32-bit that'd not work would it?
>
> On 32bit, BIT(32) would exceed the shift width of unsigned long -> undefined
> behavior.
>
> The compiler should naturally complain.

Yeah, I don't love that sorry. Firstly it's a warning, so you may well miss it
(I just tried), and secondly you're making the static assert not have any
meaning except that you expect to trigger a compiler warning, it's a bit
bizarre.

My solution works (unless you can see a reason it shouldn't) and I don't find
this approach any simpler.

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

