Return-Path: <linux-fsdevel+bounces-53380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92778AEE42A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417D11625DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1228DF41;
	Mon, 30 Jun 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qeLiQp4m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mZedUXuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88CEADC;
	Mon, 30 Jun 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300374; cv=fail; b=NW/FLrD38fviHmBsTkJRCuOW/2hMzI3bHh3hP9p+xfdbd2QCByYgLIrq1Wm3EPibgOjRd1Ra79+qOwLfiINzfaOgS3DcICF2wDfxGO24BIBIArnmfWgk/K2EwRzZFNd/Ju2GV1t9fszkefe5rDUceX2sBruLiknt31xhnyI+HIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300374; c=relaxed/simple;
	bh=wB0SSrFPatVXENwqIzETy40+UDobQp12tOtNY60ZyIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rUi+3ggD2WGNxfs8xlfL6XSehI+0WJOCHezVTDglzSM0X8/fxKVP4g3mIyWT6i+B7aNRS+4qVRESsGYOIY8HoQSIehsxmnKOjDtQur+g3jRCQL/sHJnsbEOptzdbI7iN154/jzFk31v9zeeoQeo8mxdmaLJ/ltZb0qfkJExnwcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qeLiQp4m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mZedUXuN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEkspf026535;
	Mon, 30 Jun 2025 16:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wB0SSrFPatVXENwqIz
	ETy40+UDobQp12tOtNY60ZyIU=; b=qeLiQp4mk+5gRBWqpO9ow2Jh2GkIsVxZKG
	cBEdCuZubkaJL9SsuoM1PZ718AcTe1vfIPprk8RmPM738tG4m8kDUaXWf35NjxmZ
	Av8eqK08s3uf2UdHIqKBSrCByJZqS107YeXwVcEd0P1PZB1KIij5Qah7z7PcbWxz
	tBoqnm5iWepYtTD0znJcMoK3n4320FcaPsReWacmrpkhivm94UWMebxxOJc4g2h5
	UDHFze1kX1C/nWbRajJN/iIJTcuwJX5LYfj/t/SnX9uayAYQ8/tCOdam+ei0KRP7
	CKSGTSVB1tlRCUn8oJzHTnWJOyTY4SKY/7T1HpfgS23Gijth6a4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfawhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:17:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFZvim029875;
	Mon, 30 Jun 2025 16:17:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8j630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKy9Yp6BBdG7v4CWJW9v9b23XU1QWbK6dqKE+fGxd+gSnyb3aQb4fjVZOa+p+5Im+E1N19mcWN5T8OzsyaZVHNIo0DrDgLyi/TL4s14Vpbw+23fg96rZpXZmXy2576SK3LZw76TqjvIV2W/1er6qJ47jYxphypKv8T9b4c9SA1iAlxAyfjh1y6M1reR0yPGEeVWPKMXeUa0Sgsrj0AwnGYzNjweZFsHTVhWf2mmPUWa1N/q1xRKQ5lFHOgxfo26s6s5o2pjwvb7RSahv1c7hjWqmIUMNbhBdvHphIlXzQ6j6f9snvnUmYwUH/s5OtHJfq1AHOWS+/8vbyCD7VTAQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB0SSrFPatVXENwqIzETy40+UDobQp12tOtNY60ZyIU=;
 b=n6xTKp2swf0VtRVMJSjPPvUXkP1lwzw6mW95HDQUlp2qqTjQg5aH6ueqHmeMIgFKomYwM8bkzfdMOUp+La+N5gGdqYNFKUJeKBzHltshaIHONWjq9OOSOLZE/YZjulJSJRMBlTjlXk1SPHastIYhR+SwaIawEmET0TQK4wCtCpIWVxumoQpKGk4AiiyHb6GFye8EwDuE0UwQTObnZNgmCDUtfGPC38Bg4/PbHhRI6be8Id1ioslNjoH2RCja1V4o8x2PcN6Yn5yNpQNJZIzF6OG9lgN7rHoUuAs3KO7pDIYI3nWgEENTl2C4o5mWgT+luJDIUU/RkVAD7lPGdpG4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB0SSrFPatVXENwqIzETy40+UDobQp12tOtNY60ZyIU=;
 b=mZedUXuNa/TPi85TjDsm7cHcQzijRpw5yzlZ1Eybom9cwBwm2QepMs3pyOPVlUW8R2a0uUXWmnCtOCc08FYanN9Wlin1qhd9cFF777grgnxU4PTEgaK1uB1sx227OLltc81loX/Qo+3ngV8cT+beQR/yLAOBmsSGna3MpH/YSM4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5126.namprd10.prod.outlook.com (2603:10b6:408:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 16:17:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:17:42 +0000
Date: Mon, 30 Jun 2025 17:17:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky
 until the page is freed
Message-ID: <471ebd13-dbc1-43ff-ac13-6084876f13d3@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-6-david@redhat.com>
 <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
 <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
X-ClientProxiedBy: LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0bfa5d-1629-4891-67a1-08ddb7f1a3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJKD5EBy/UjS/CUGI4maFUg7Ri4fdvNlPRVCeAikS6oxMW7N32YrOLWZh5it?=
 =?us-ascii?Q?AnJ8YCL1tgIpukYKfG6ANVHllImkSTeEjd4B9Z/y1LIX5rb71Glb99BQTkWu?=
 =?us-ascii?Q?jy64iIb+H8nl2gaRSZNGKS/7KasmEs6/x/IhXX3jQyWgT1xw3oDkXJCq4n7y?=
 =?us-ascii?Q?QdNzrtVCne07063lY5WoO0EWJHQR56P29da3c4fZM4Uv9qHdeHL3sq+zyN+F?=
 =?us-ascii?Q?tYdrcjsQu8zT9AHcQligOfX4zd2ggi9Yvo0Wdm/bQJV3tKB/olWaamEOdbyx?=
 =?us-ascii?Q?/WUmbNazauoWM1KunqFkZPcBAxyZDATxxvJn0Sqmn3P/AxoyTqAdseYxws1e?=
 =?us-ascii?Q?PW+sWG1u65ElQ6xquL0A4woElKUyYKpTc1la4ABPrURoTS4zd77GxIKwirkm?=
 =?us-ascii?Q?JCIwR3shcnIUg/49QmYggY9f3bagZchqhGcaYldcecYSQvEdz2bXdGiz02ZW?=
 =?us-ascii?Q?McrDBJSTjcNMmXH2vmPG5I8kK2EDb7nJ5N2UmfUvwQZyqVM5SExFKJ+o8AUJ?=
 =?us-ascii?Q?DQmneKyqnv0XMV1UPFbP3Wu9suwzdgdRs8RyX3GeoXSgc30DprbQadZB9G2c?=
 =?us-ascii?Q?4p7YTgv2fZHlm1RdfAPPV01kXnCeL/+hHdPjtgoyqdB7A6YCYa6Q/bMbWuvR?=
 =?us-ascii?Q?WLr0Ebso28wtXOa6Ppx367uZm8JbdeLEiXnPGNe/RuNJSojj5zjkfUHG7rMC?=
 =?us-ascii?Q?CsvhdLjddm9RwnbAX3X22+FP0aZerQjQCZFE2cpEFbx2YNauiaC9yfTXlcaD?=
 =?us-ascii?Q?r8Bh28wbo0stRAoH87cx7ZWgEYjzBpSZ1i8qBrZptbMbx7//XzKtDGAIkOft?=
 =?us-ascii?Q?bNiq5JyWhmw98r8UiCE6Abg7Tljeyon7Bnw0AC32oBDBH5iXNSAwVVdDROYJ?=
 =?us-ascii?Q?vuB1rvu9bYgyyO3/cTOzVx2s2MvonZYXxO+hLWoh8OlmZxE5fCF+VES6S37S?=
 =?us-ascii?Q?q6qAjinTBQ12zKDhI5wv5Pq/erziK/qbNiyv7CqgjEq6rqrDsjn10LS7codC?=
 =?us-ascii?Q?xTathOA0jq5mVZVexanpnhilY04Qnr6ydRlxihorb2eEvAYvtgWV/VCy3tPn?=
 =?us-ascii?Q?nSQRNZQB0y0LlBhdioQM4geGqBCfScxfwnRs5YijB1fQspfJpIDu1U4Y7FB8?=
 =?us-ascii?Q?zsUATzSttDkPtnpQah7pM8DQA4BCkuezEj8mP0dTzmV4GrQ4MKfVV/KgrhX7?=
 =?us-ascii?Q?4PkEASjUDCUm6wME85kGalce9LonNRf4jS1iIumSj2Q+IGkhiWzQpMqAq6XZ?=
 =?us-ascii?Q?BEj5IUuqOMo7pbBJJ9KWZDlpG/XRGG5zM8/MZUVHZ9vPTO267tSiD6rGP2m+?=
 =?us-ascii?Q?zG4x3bNBKi/CHPVwAjwbtyUgK/iCOJEcvvJh8COiB0/3EExadPVZZ3fBEbUG?=
 =?us-ascii?Q?8Yz4Up0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?haNrOVvX3EJ0et5qKTykwMojb2I+R+SG7bTTIEslM7cfIYCOU69KEY/e4ZKY?=
 =?us-ascii?Q?0Z8mjw313ybsMvSfiwiia7hO3Bfr77tBoqGGCxpr+IgstxfJXfgdreXJCfoI?=
 =?us-ascii?Q?7UJ2bYWKzFfiB5G/ZSi824bdS//BoR0yiD1nzxnIXU3Li5yM9CmtwKxj4fX8?=
 =?us-ascii?Q?ztLDBgcyXOtuRtZ1I8A2oitNpj4qov3qpJoufRzfZrHhdvXAAruRhmJEgV9g?=
 =?us-ascii?Q?jOmwC0GKqd+p7Zx76rVOOArr8SDvXcE0OyVPGHVJus7wHxi9/3jNO68EhcVi?=
 =?us-ascii?Q?TzzwF5sdyd/2D05SVMHuJ9Ng0JyxMEW0tuVrII1PgzVx9uSa8vCyov2XjTtg?=
 =?us-ascii?Q?aeGJafD0tEGmRrwTh6Qwnm5G69LEVVWGFRkU/2jcO9r8LDn/JcQiFg2mXviY?=
 =?us-ascii?Q?HnNQand/Q2P/biPXU8XP7KpgxvltyS23ZAr6fhAsKVyzFXnczOIRfdaIbb4F?=
 =?us-ascii?Q?PaSkBUt5k67FYCZltZSpjNFhz2/eOg1P9reOOoarS8gUs1DFmCVlyQCNGTld?=
 =?us-ascii?Q?gYv4JazuXcu8EH3a/X2sqhpyrjx/+GsK48OQbWpJZf6Ex/9RFMZhNQcW8Taj?=
 =?us-ascii?Q?RwcJbJwcNKkmkKFuoWoFbn0ya2KvyLU3YkJW1iG0z5q543cJbYoCGxE4RsYF?=
 =?us-ascii?Q?k28mtfz2YUcYgR2dqecznB2cODQgTyX/zqXC3XlFzrB54jmvwQ9Q86kfR2Ce?=
 =?us-ascii?Q?fnp8BPITawyyzzz4lJVsQo5wfuELI/HVZlH3MTf224tcmMx5lihXakMxT+Dp?=
 =?us-ascii?Q?FNo+0rJKJXuGKWXWjz72CPN78wz5e+BYSQN23btwWgBea9ddlpV641ldqTB9?=
 =?us-ascii?Q?MAcQnvExlJKb1HZZjugSo9WSsjI3gtEJT3+xsPuEEYIk/7YLRYzFKuQjjPer?=
 =?us-ascii?Q?n8Sp6ff1zyPgaim8v8CRGFDdrSq4nqC451WyuegqCceMvT59o51p0+gEH527?=
 =?us-ascii?Q?4Tr5JwSdttIPgTwkvyuA4Dhu9RjL6PyXHA/53cIxWh/NYWWXL1J+P4LYo8fo?=
 =?us-ascii?Q?R/+EtfUbPCWLlQfsjEGp6XpKLLJrzfoJH+xN74zNhaWSM6VYEed2AGdDY9oq?=
 =?us-ascii?Q?dD5j36ewMWJNLzR35vOSmfAwULS3vpkGX7iScen35zIh912YwWGWpt9KqFJQ?=
 =?us-ascii?Q?n5JllZyJhCPtar6miCpIaEMxBS6wt0O6zv6iftMmB5dpDBb/k1Eqw9uK7uJx?=
 =?us-ascii?Q?GPg/cxDZyNOdj/KgNrgWqLazJvvW4iYWyRapPOoB1FeFtBQsJmCoZQ+2m+qQ?=
 =?us-ascii?Q?iFmEBEf0qEYn3Ck9MFSDf0abevEPmV18xVhnVErX4wnATsLXLhQGg/UIm+5G?=
 =?us-ascii?Q?x4FHk68OyUVnibJ0LwTVKgQzV8ZKrYXuMJLyiRoIX1dfh7oCssSkqRpJU4FG?=
 =?us-ascii?Q?T/jBEREv8zb0geF3brU2e+0EA+vDY9ZdejRZbOziXwLlIy3Qz3LZVogNufbk?=
 =?us-ascii?Q?3kwHoNINa0FvjZzAScL11rhbN6UbMkgoVzJ1J6imsOhlMN7Zsx6h98CiKGxN?=
 =?us-ascii?Q?aM/Lc10XnhS7A3HKxeaWXmlSrNqrN7pkc1LVD4HgLz7ky0+SRQJjIIXQExlV?=
 =?us-ascii?Q?Es+s/Ac1xK9XMAJjizuiG0GGhTHq5VRbkhtWfLtBh7Sp/+CZ5UwVoJmssNBI?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+ZEgCMGUG56ZFmbYT1lhI5z+kJmMCUtPVv13nKHajQni9kqIEssW85zJHgsuIDWaJTH+TdRygYYooCcnSRChqCMOPArSRsmo7xwBXkyWmNbHITf05fU+hnYtab5oOo8OuXpEL0ALDIh6OhFbGNN5axIEHsR5gDHkkNvwzlkMrz5tKdxlLAaw0hq0mZmnzRnpvwNpsNJM9g6SBNYw0bxWqEYOAIxJNrn0ZtOea4PRGtDmC34cBefkW8i248SpmmJ7+hC2bW/wcI8e+izeG8JoYe75idQEJGreB9DcXtBy18nSFHjjy8aXrAO0C3JsK8NGuYoapJCk6msqCYY/jq30monov9c+H/qMKXj01PaQXP4knp1LKF1/R8MqGlGQHKMLzsFcDtJ8tF5m60ygXnYV99D/WTUn+yHh3rsfmxVAbxmfHsOX/3ztLjVa+Ll66EFko3vtJX2PoIIDynvtPtvajeW220CXIdB5dttR/XHKHLijoW1h/+rfPbApoKayVMyY0A+bDeC1d5CfWmRhw8qBDDj4Yz/34WlkBudyp/DRaTBsyxBZp5Orte7sUv+yfjRjfYIc0XlUr7y8okJC4cL9vPwgWQoX0LfgFsVZL7VZRfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0bfa5d-1629-4891-67a1-08ddb7f1a3ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:17:42.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb1dUkl+sT41lMg+KNhs0ZnK+cOI5dTCd7GGzDlz9HWNZZWmu45ql7Y0s/uGNepiQkAnfhNH6LxrFFlNVkiI5Go2hyuuLtPd26ksBPGDTso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300133
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6862b8ac cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Bn3zVO4FMZJmmyU4TyAA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: GFdkEB3rUWKhRNtaK5TnCRHxzQYY-abq
X-Proofpoint-ORIG-GUID: GFdkEB3rUWKhRNtaK5TnCRHxzQYY-abq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzNCBTYWx0ZWRfX+fW+a3J+IC2k oCkw/fLEoNfSS3y/YeIpZPTpUogOH6ajsShvBTAWu8JLD2ftu0MQQsZ5KuuzyPP4NbgidkqTkRB Uu1eSXZddDPfTzcp3ew2EFnwwNMdRemj+4hk5Rh6HSsatKbo+Ybhe8V5hV+FrQxAxvdUezFHcy9
 X/pblvr/Fg1toLEnmNDpaCew2VXSGrHjId5fOJORwGnm7iXXBgq6FnKZRcDi/imo+O7A3EPzkiu qD0BztHIetvuCxG/33Np/GmkbQem8CnmzVBdWRRdkRLpp11lZU8lqi61oqPKQcCZA/BNitqKLH4 5FjxcnuzfSrtK2UtZZb+hALSIluNidRpSr5RXr7dGmjpXqGnkXcLpr1yoaSOFyew9oSwpldM0if
 PsxoyuMxOleL88mEBbLFWfTfr2KtD2zFOx7RxZ+HkzH5qVJJN4hRzvrVtBNg2il15kSdHlcj

On Mon, Jun 30, 2025 at 12:14:01PM -0400, Zi Yan wrote:
> On 30 Jun 2025, at 12:01, Lorenzo Stoakes wrote:
>
> > On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
> >> Let the page freeing code handle clearing the page type.
> >
> > Why is this advantageous? We want to keep the page marked offline for longer?
> >
> >>
> >> Acked-by: Zi Yan <ziy@nvidia.com>
> >> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > On assumption this UINT_MAX stuff is sane :)) I mean this is straightforward I
> > guess:
>
> This is how page type is cleared.
> See: https://elixir.bootlin.com/linux/v6.15.4/source/include/linux/page-flags.h#L1013.

Doh did go looking there but missed this!

I hate these macros so much. Almost designed to obfuscate.

>
> I agree with you that patch 4 should have a comment in free_pages_prepare()
> about what the code is for and why UINT_MAX is used.

Thx!

>
>
> Best Regards,
> Yan, Zi

