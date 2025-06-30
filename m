Return-Path: <linux-fsdevel+bounces-53376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC1AEE339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC127AB352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F428DEE5;
	Mon, 30 Jun 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJ1Vvldh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uKUeO2WA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A617BED0;
	Mon, 30 Jun 2025 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299505; cv=fail; b=CtEV7r7PNPtrbrSrgiAsSijLD9hdNU4qy6W8a2kCezS5SVA0uLNEZR/0cEkgLyCZ26EqrCdIBIEDjm0OvpYkWcB94vgYbVNf6wL/nWUF2BhNjbv34h+KILXbZgLA13pruF3KT/gk5zwjBKJLU9d/Q/zSr1yIVXSc4xFmuJ5KA80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299505; c=relaxed/simple;
	bh=FKnJQiNF0QqWmS6iMWZK9NR6XFbCemXkQbEnPc80bns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7CSyrdWCi/U5hBTnI3w7Y7ArefjxcQlbrrW2Ny7sNqIMDPYkoLEFl1ACSuJC1aAfBBrRtrduPs45JLLKBX9kKxOQk5hzCc0U+nBWaJDNPU5NZqOAcxJM/lrZYuZrt2Kres0187mbIrSxDU/+x4AyDV2lLp/BKlTweWrjCWfwCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aJ1Vvldh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uKUeO2WA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEkrKb029481;
	Mon, 30 Jun 2025 16:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sD4PgGZ4cUyYlZ5pfG
	mAwnHmucM+GscMi6zYWN9ngpE=; b=aJ1VvldhZWyY1x3emnhQWj+ra7U6hKXCFc
	cUZIapAtGrAGyPMENoOh724V2pinU8j2ZW6SY9UleKUDxryV1WYRDV8ZHi2gg610
	7tdlYX3LL2Tj/fDQoerNgIc4314A2ONMb/vi9Z3MO4/neLryBc2xpvOsaqzqPfcM
	FCOsJWpbvLS0Tgo+koBHP9QofpKCgB3aNzJMwkeVzNtQnnRva9Ie5/u6A0o02d2G
	ng2mzGwORadfnxxDcgq2tNHEjmSGibBmfUpdb6BKm9BCp2CM4pTuJ7N8bPiT3fx4
	zjtDElgeZo4CrzU0g2dA+3hgAAzivL4remzUdq3tDzVrXVaX9VQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef2vrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:01:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFaAUY029899;
	Mon, 30 Jun 2025 16:01:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8he4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPLJCs8qB6WEf5JfThWCBs1jVEG4Blj35UuEMYcoKOGcommfnHHb51WHvYr5dCG2aGfNrpJ3tL3pVME65rD23F2Vd5gKZ9MepZ0iS4O4k4+1tKdFCtpdlorOzcmGBFXs3D5a1vjJx5R+uyTZhsUGr2UYNZywI7M3ovTKpzPTf+X3bYiQTB1g7ENaKeeNOXPwp7NaKfeo1sdAX0fR+0DDMMhw0MNR5UAOpcJ+hk6stJcWdvVMeIZWMmzAgVXD+yQhE3JlLDHU0BgagcoIqXdtJOzNadH4CEFeGYX3TMFhAdJGg6I6MyvspBUR/oKKJ1x8mUU6d759k/AmvFJXnpFjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD4PgGZ4cUyYlZ5pfGmAwnHmucM+GscMi6zYWN9ngpE=;
 b=rJN0Joc7AJ1pwu8grqgUYSqAvRpMOJu0Rqp4EF6JdQ47Nq+UJ9u1B1ycj8IF7AdcKkoBXeDhYPKjKGhIHLsoomoyM09e39ZNqTFCIHwtcblT/QAaw7Ify3hNk1Qq24XowfnTS+xe8kvrvyanSFHTk3OU2hC1CjavyOmuGI2U+H27TCA/K5/j8DgUAomhXR4I0Ph1+S0FRpVh9yjI27YMUyt7E0rfKEra0fuF/rsKmjBZ0Q6FaC5mY0NcPkMjaz3kNuBNf8GJrLVPqJqww3oJQOcqvuFBMKI5Z8FSsdRmPeA2o1pjtcMjN26ezbPTVdlKYzTva4HwQi5BPlO21HVwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD4PgGZ4cUyYlZ5pfGmAwnHmucM+GscMi6zYWN9ngpE=;
 b=uKUeO2WA0sd9xdQoZ6OdCNh0YCISFwmnaagARK2Qli9jt1MLKHJbDUFgy/kXNW3s+19DqHmzO9E1kOKo6MOf0No4NlYMPWUSUFoLSDjRJYKHyrWA4wOa9HnJ1pzBAFZ5qHxBMwFMmrlCVH59k3k2GwOOGvqRHzwrdboSz9ndXBg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 30 Jun
 2025 16:01:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:01:52 +0000
Date: Mon, 30 Jun 2025 17:01:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
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
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
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
Message-ID: <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-6-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-6-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: d3530070-09af-4fa9-5847-08ddb7ef6def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JJ9AA4UuqLh2kdqDhJm12nUlvRAbCamK0WVuvHxLNMaV9Zvgy99JkUf0PH3t?=
 =?us-ascii?Q?OK+UwByPV/3zdLPKNd3J7bgbK7b+BNjuGGpql2BAdZvzFheWoGgG/DCqttgK?=
 =?us-ascii?Q?PZCR9/eSqHqMEDe8W8pYcD4phR/RMYW9OZfgP7OkiFko2bhOuevi1huNuaP0?=
 =?us-ascii?Q?auAL+eG/RZ5EfXahTIAr6F08UgJoy1xqSQYVVct+/auXKxrLBz5OTUDF+x83?=
 =?us-ascii?Q?VTh+gs+V/vS9hqxXx34nrX3yDec8sv4Lq9skziqmh5u0snUt4QePqTcme09T?=
 =?us-ascii?Q?mjkmhpv5BdZmg4OYrnmfoEjn6kMFHgNEyOx7Db1hTy/CF1XVjOlGK6RqctGH?=
 =?us-ascii?Q?iXBtUUFmwvjy78egq0c4hAFa7K7F7DAaeb/0xcDBUGoKqyu9Muora9G+1TB4?=
 =?us-ascii?Q?clHAbMZWHSS6E6jqGRlTPpjlL/9CYRzbjcxFt75YTkmxo+v2gha31WhilIY6?=
 =?us-ascii?Q?M/gn3ybeSXBslLbAi7ZxQ+5jbX7deDnVnOqnTXJr3LYGIQarWMNSNFSxZXNU?=
 =?us-ascii?Q?N3k34kJocImL72sHz6OtI3NpyReq1Gf5jO+VQKXODDgxZyTXSEIsg/o2j0gg?=
 =?us-ascii?Q?NQXSwIm8E5nxX5Bcf0izGo0Ocb/n3OonDcZD9tRE+HO90Q65LXkjoU4QM9y1?=
 =?us-ascii?Q?/NKEUFl2R45WsFWddnMnMTyT3vAEtLr69Y1WXj1s5bpnejIsfoSEPrWPso5Y?=
 =?us-ascii?Q?MVxKSSrWTk2wSp8OaCTsl0oO7mVERNeao/C6kGPE3RH5i7PMiAuejB04wAQo?=
 =?us-ascii?Q?exnZra0IbEtcdk2EitCbc+KUOjFdlUzXsOmLNjiUp3CfC5wxJzMfVgq1fMeS?=
 =?us-ascii?Q?FnMU/Vw9yz0CrCVoUXpjyHW19Y0fiK230bCdmmbOaSIRBgrbS+fhTZjE3/lz?=
 =?us-ascii?Q?HGxvjxaxrYSSUkZ3k4F97rqM/gs2Ew5WRSNA3WWJ/Y+DF0E80sTmQltLUMOq?=
 =?us-ascii?Q?jDYRGGcpvcYVCNzTdcvcB9rbD7qBtiGBHibz4fiUBmcn1pqBTJeiqE2X9Ohu?=
 =?us-ascii?Q?KRA/axEGVM5+EPWF2n1UMLch/f5VAYhDAMtKnstZuEa8CApTowmCoW2mzaAg?=
 =?us-ascii?Q?h8UeJTOZ/VfgYQBgvlGuf2iG+XXUmrrxRAUxAcNU0DGb/EEUz2TztQeKcOvA?=
 =?us-ascii?Q?wpMFFlSRInpvFevYbFfCOLM1X0jehd0Ptb+Qcw4/p+Py6LvQDwS2qxOYRtws?=
 =?us-ascii?Q?kJHtGJiRznS/av5nuDc9ms0eT5L1iINvAqEKVgp6rR6VqNJvM7L1zYGEjGgf?=
 =?us-ascii?Q?TZcgHmfZTylWZVQgdJN/Bb/ASuHOkYig9IZDEGccEiDFUat0GH8t17TvD+6/?=
 =?us-ascii?Q?AxhMeoksWUjS4F+/ppMgmWlq6udWrIjSyqQI9xNQCCOYvuyDOtrg9+0jXA9R?=
 =?us-ascii?Q?TyQ43OpwfWGvsTCSi80Nvlq7G1brRnYja9jrLLB6C5DleZqnwrtMcj3pnwiU?=
 =?us-ascii?Q?lwsj4m4VqqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LuyD4p5FIbnLzaTRG8Bi0OzTnkUtdmKeSfjOX4/fw8GbsZJUf3DlGHg3/6vf?=
 =?us-ascii?Q?0z+NyvcYFoy44TJ3RcLcnowhL0u8/VHGGgDe8qMfhoklKWKUjNceTF7U1Veo?=
 =?us-ascii?Q?nm9uH98fkOA6Jv+loV5YbM6wgsIodfWNwwF3g6IiDK4BKpcuGzvzV8nZ/1mq?=
 =?us-ascii?Q?prOykpHDU7wz15Ln9q4g02OTGXzkqW9SBnEPXMWX89RpowDCJ+H0byRpuksP?=
 =?us-ascii?Q?XQuo6kWsj00AIVrLEr26tifgCK1Q/XgQxPt64+Ro0Xy6f4wsy8h+e63Re/Yl?=
 =?us-ascii?Q?O10EY1ItGPHtAYtfuPrCtwkTMPtlOKT/1RRKjCasRPZEhWG9sylPIgtArAEC?=
 =?us-ascii?Q?h86HshRTT4fQ5HBKjztriajShUt825AKb1iBvtTcvYHJF/2iZ0Xky0plLxFv?=
 =?us-ascii?Q?c4JYfhW/brGxksHRK1i6OAVSBwjizefeUHoS2ID4mQzRqP169PzeTppnsjEp?=
 =?us-ascii?Q?j4X0ulqtjj2CYxRbH4d9KSNk7IGTAB2U+DYDQlWCfjK9kAgvHIUemB5YA7Fa?=
 =?us-ascii?Q?f8jgtpUGeGZUK3t24jGHQGfkYbO0uK720RrANBydO7ahA+3iFUbhbOSslnR5?=
 =?us-ascii?Q?5Y5hTp7jtwtT813evx4t+H4GextB2KwuFoFFLj4xOTKg/dOxiGBjDCVnm/Aw?=
 =?us-ascii?Q?fGVmxJQpyYWDtfWgOOQ8/FdNla+ft70mtlxfHRoXHgUJLOJ6YMNL8J8XpL7P?=
 =?us-ascii?Q?twx/Y8aaE9mgJAd5FWsfADxGOpCelgWeTqQHS4Fuvp0JZbOMI7LDlIYrlxcw?=
 =?us-ascii?Q?O0icySsNQ24UZR0htPgd643GXH/F3e0uHHGLk/UczPptJRnMjiZxzweVExGC?=
 =?us-ascii?Q?01wpb8zln4e8fd0qNlgHIgV6yCU75F4Cr+xnIUese9NPgZok0yw0h51YuQuW?=
 =?us-ascii?Q?KVN6q9uqNMVpheNG+F2FDSanUxlCh44Elk045TKPlFfeJ8M6EL6OhVwoK7Oi?=
 =?us-ascii?Q?jeKGlb8T++os+2B+wgEM1ofHtSeqkg7MswrrVyHag5yoreZtCfir0eEyvZoI?=
 =?us-ascii?Q?Jc1JuSoCszfUgA9WEOgDE9jklaCzhhPmVZXK7mTuT8KJkaMyxS6WHgjkGoee?=
 =?us-ascii?Q?TetR3EruL6elOPFigOWeAmqWgFsMWFYIIditaUZhai2OAQv+2mdxDBvFbYqb?=
 =?us-ascii?Q?2G+FtSNArbtJzZFOtyxA6Xl+zl2T6lUdRtmCdK4bdhiyur9e8BUw6VJ15cVG?=
 =?us-ascii?Q?m5vfutsK8GEUlLHuwStoUPwt6fWKiV7z5VO/PyagsLaN1r344NScrX8lFeKj?=
 =?us-ascii?Q?Z5x8K3pM3CL5bO+voYHstqNyX5CjyMKMR9rNw2WEsjMt68QL4pOqE7rDtKUd?=
 =?us-ascii?Q?we1iStcc385hDfeKoCtn46P3XmhACRKSM+CF7XZ4BqDQtmdBOJjbXNy2V30I?=
 =?us-ascii?Q?I0GSIq1lM6Sas8mOeb6STzLYUHNC970vS286nQbcjKww5kJEwn8NQiyl7zNV?=
 =?us-ascii?Q?xCf5eFstgnJnmIAv1bU3x4i+SCZg36eCzOA4+O5JgtuV3dS34tK8eI06tON8?=
 =?us-ascii?Q?s6a/MxXJfkQANWDBe5zOMleYpe0sdUe7UIfwa9fI8p1ImE4VH+oQsduZHuhF?=
 =?us-ascii?Q?Kvw+yS3pb7b2Fk8qhv24CKmguotY1/v2rg5L78V9aqUpxwVoEPWAtpqkt1O2?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qn9JrUdlTVtPD8WIWRGNETJC+986iEfCR4sn/LE9gjxV9suPbPXv3Q3ZBXcNiL3RTxZ7Ec2giEtSkpoLJz1vx5YSiC2jp29E+2F3N/i73DSTfwez0Bj6rcUk+Mc6+/TrJqFqJ6QTGtqXiy2JSG0qYzwmmev2IqBAwDPonoyT5ue0N9ve+KQxIJdm57wQvum72waHpon7NLpHEJB9YM9FlfBjTSfPX6idTfzbJm1zErQwV9b2SjAeFUkF/Gzdx61dgZAacUGNJQbV9IKYl55gRBolUOue6K7rJdrmLVYt6GhoFL3mRDGxpkg4ChGX1uKjbv1ICTpbPoyM5Jz3gDAscRdNdyvLgBzKEAoEegdaKKZn2EJrDnIsZDzUifApk9jPXyGlNzuXZHViDBsns5WXEwzXvDxR8i5/jRpyZCTyLB4zMAnOJxSgrIdjFjp9qt7+OWNMWGVcvEfcRRsN8hG8GVL8IhKHjsd8UCqQv5nN3oQp8k2bKXvNpCAD+mq6evhnQc5fgRimwD1tTiYDHqgTH9M6va1iAM98P3HcWXjRYWwA3kcW5ph1fyRm2XRdR2xA0ZdDqe4Ii7P0K2ALtRD48qHDZ211RgDFfkeOBlWjy00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3530070-09af-4fa9-5847-08ddb7ef6def
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:01:52.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifj+iA75CaAaV6cOAzt6z9nNYBc1Q03WqDVcxeWvmy+adTTOCS8pusPirSpYjHmD3ovvElz6aILEmsTblBjO9Dyezevz5abZ5YCUAPFnV0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300131
X-Proofpoint-GUID: FsF976-2d22BmnCWGlCM_EoS8A1Nn-KN
X-Proofpoint-ORIG-GUID: FsF976-2d22BmnCWGlCM_EoS8A1Nn-KN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzMSBTYWx0ZWRfXwHljNg4mryep vhWs4dnkFujU1dByEeZbgYZtZPOPPpJCtWATkpZwL2j0nQ3BqaisgazcpFcNklAYFdeoFQ1rLnJ 8GDcmhEFbtDrzEpYsyQY+qOBe6g1E+SB9F/Kt4leeAfeOGKe0IR4HTTA3nwNtcTtGlC5lM43PUW
 qGkf5c8zhccmIVkNOdHymX5xZTgVzYa7KJ8IeTA+cP76ndZ0MU+ap2UpNNNFn1s2LixVQch6m4B wmzHyLojF3E8F8yZFc8PuP99M6rVMNvyltL5iuQKXm4p3z4SnUOO7szcyYkOSE8lWCMUjFe9Yeu SAqRkIti9idU5Kt74daIcrnQFOIxWuWuDkjeba8QeXo4HsuLFCUk5P/FwogpwQgB9vlQS9hdojh
 hLR9ne4b8KiRDUNKbKYBG8S8fbNiVJTbyjQYmTf1sXl2kiKcQ5cIYLhtIClTqp3z7QpXPttw
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6862b4f6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=UuG0OjAURIhy3ilcZjgA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
> Let the page freeing code handle clearing the page type.

Why is this advantageous? We want to keep the page marked offline for longer?

>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

On assumption this UINT_MAX stuff is sane :)) I mean this is straightforward I
guess:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/balloon_compaction.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index b9f19da37b089..bfc6e50bd004b 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
>  		__ClearPageMovable(page);
>  		set_page_private(page, 0);
>  	}
> -	__ClearPageOffline(page);
> +	/* PageOffline is sticky until the page is freed to the buddy. */

OK so we are relying on this UINT_MAX thing in free_pages_prepare() to handle this.

>  }
>
>  /*
> --
> 2.49.0
>

