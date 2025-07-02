Return-Path: <linux-fsdevel+bounces-53608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC5AF0F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47163B5D08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438A23D2A4;
	Wed,  2 Jul 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfKgeLOQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N6h25Hsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C722FE0A;
	Wed,  2 Jul 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447512; cv=fail; b=c2V9w4BhWyYTHUUCZswui6LCIUd/H2NC6hvJJhiZTZnEeA2ImX214BK0s/Yc77zsWa8e2YrrKcHWpugOaxadK+KRgr6EzXMzJPKCRYH8KKWd8mUdj8A3W4SOebUgjZkDRSTXvUZlqA7FyScdeISr8QycTMMY1wfg3rxfRE7WlK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447512; c=relaxed/simple;
	bh=nrp2vhZr5Rf1cUTEGMCJyo82Sl6pc/uke/NPeZt3If0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0DcwA5i2YmKm0FDyMu6hqH1RXOHVU+7UVUmm1xULN80TpmUc7FSg+5REg8+S4yWMe285BfqEueIshxNszwdFPLLIUUV7s52bltMQ/RF5+4tn5xI7fyvf8YWvNazRXUw4tict4vTNmAksQhiar2mr/+pgnceP/pJsTWvXF2vZ/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DfKgeLOQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N6h25Hsy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627Mc1C005786;
	Wed, 2 Jul 2025 09:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nrp2vhZr5Rf1cUTEGM
	CJyo82Sl6pc/uke/NPeZt3If0=; b=DfKgeLOQRhFReIlYLP5HrycnQkKHyz0Lju
	zehU1ETordEwQXWWcqUICPhlJkepgjPhLYEuu4buqCNSUS1XCYLXqfdbcZp9aNb/
	1GXGVKnxgEEwZHnKAkhcc0Qle9A4h+8v/a0q+oNjpIu9fTpoDaK8naUhitv9ChVS
	6ZS2Ch7FF1IgzvFiA1PoxokGMBm8pfDa1dlqrmxdXE5JU/p+rsBj8lG9W01UjR9O
	lbNjB75b1roTX5U2JrcgfV+UmKynC2EQ41fP03EXYR4KSvHTVmSXukQHlHlNRxGR
	BOSlyBBH9jOKUNhGPl74V8lS/oGt5O/dlc73upMfqER+sEo4Jd0g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6g40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:10:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56285EUZ030161;
	Wed, 2 Jul 2025 09:10:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ub05kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCisaFr1K0vJN5SQsbbKMBdyDygwI68FiQDe6z06xgeoqlu4i6wlnxxXWB8E7bpk26oAvSh9VC55pfa2OnAtaLc/Qxyf7jCvkpUKxMgBFnWIabm0o6znb/44CZL3HqLoJtuKXxx39HSzXUEl7NcgCw2u+nFXft+WYmRPj1A+UT5NLi84XnkiOBU9t89zm8UxT9OzQObfHdTSFAN9kj0U6SqHurqG37azDDKMpxumh4EGRu6ZHDA+j8oa4Q/867hb3t+zrHWObRFOFuBS3QYRrUtFRymnqZdFLzkOzyHiwg71vipbcnPfX6/tpFY8d6DFnboZiYKylXdTbOQ4NEe2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrp2vhZr5Rf1cUTEGMCJyo82Sl6pc/uke/NPeZt3If0=;
 b=wV5pT1g5gityUIJzEOmtUtcOreLoehCcCM8B+hYR5AYDVzbsxG+8iWGJg7rfNU0VrTgWEMupBwa58Sp/oCu4IERlXnC0hEOjtT5iZqQQwDIHQGdciXpxVQnMBcn6QTEDXzIUpyOkrkEclg0fgTae2312EeVEcpDva30Y+pvSKd7LF963war3bHFCe02V2JkAVePpOhMnfMjOtIGgE5htD9lInYmOCreE+aQOKnEqUXEn2Jd4XSwOm5n7xJIQDfeEHHHezD6Ru5JuH62rIkX83uL1GgBBdKH6XwLwBEbFymhukmD4rx2EHMlEDDiIaJ9ZSmonRxo1IQcenkq2Qn3r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrp2vhZr5Rf1cUTEGMCJyo82Sl6pc/uke/NPeZt3If0=;
 b=N6h25Hsy+Z3VODMw7mUJjCw3cIp+DugKl/p0SyuRrTCmjh6cn4skMQiifChuSWdMiABOEDCwPWORRdC4549oovnPOh3/42TkPrhFe1TsGtzcm//iGPIr1pukYi/MMfOu1PC6KakqxNqdOCKB/N46zBcKEqtzVKf/cVTiXmFyNRk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 09:09:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 09:09:58 +0000
Date: Wed, 2 Jul 2025 10:09:55 +0100
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
Subject: Re: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
Message-ID: <f080fd36-8587-42d9-a411-59128bcce195@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-24-david@redhat.com>
 <8ff24777-988a-4d1d-be97-e7184abfa998@lucifer.local>
 <ac8f80bb-3aec-491c-a39c-3aecb6e219b2@redhat.com>
 <d7e29c51-6826-49da-ab63-5d71a3db414f@lucifer.local>
 <a6326fca-3263-418a-be3a-f60376ed5be0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6326fca-3263-418a-be3a-f60376ed5be0@redhat.com>
X-ClientProxiedBy: LO4P123CA0655.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e49a36-5b5b-4609-b20f-08ddb948382a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkCpV6wWYLkzaZnFE8adYDqNJ+XjE6KUvuJrFaiYOJ1DxXrX0kSb5UVrFy60?=
 =?us-ascii?Q?aZ95dt2V7qV5FxPNa+bOLE9gKsAM1vhkwalgA5Vug937b9d/VNJ2tFn4X7Aj?=
 =?us-ascii?Q?oG2t2sZrjzXzjfkea7wtpFYlgz3UYjjWm4YauNqlIufFoYJZLMepw1zDyrZZ?=
 =?us-ascii?Q?xH1HPxKISs6ueQCUTC9+PJJwym1kfM4Ydb06EPtKmLtU47M6vZ5tYj0rmc3D?=
 =?us-ascii?Q?+XKwJhnxNsSIX45KB8WLsBrYqdn8TV6KW7xJR96QXSLj7eOkDIq8h+OR7bHA?=
 =?us-ascii?Q?Ak6mXuuWltlKDGo6wfudg4bTZjMsACWKMc1StoEV39GNKhWyn9PxlKdf8pLn?=
 =?us-ascii?Q?oi5I5U7yvuSdlHHtvc0NdAGj/qlNn+BLhrcy0iznWFYJD2sSGgDQPh7H1I+p?=
 =?us-ascii?Q?c0fzzKKtjJGS4FLMLLxCANnluPmky1pYzFHHnJoyiWR7zj5jcq2fx3s20bX3?=
 =?us-ascii?Q?w4THPg2KJ2Yl7X4NopMrBdiOxs9hfFdLu2rLiUK/NTp2Ryt7085aIZzWhxNv?=
 =?us-ascii?Q?NgXQJiF5GqJSot0gghU8G1S2/Z5cNcCiM8UrZIaiNu6qdHM+B7DHqWOb5Oq3?=
 =?us-ascii?Q?/dUylvTa33WPSeeJdnYFV9CknsGpPkg+IG5YUzBHdaGYklXhpJNU8EwSZjD2?=
 =?us-ascii?Q?HUYJy4KTwdveHuBkjvpuaVOLE7fZlbbcUAITDyjjOj1h1Nj9Zqvki/F++9u1?=
 =?us-ascii?Q?RxlEszR4Iuy5QKiMQWHDOIgIkO/lE96jw7PJr/BVU7GvP7agtB19CQNtfWeX?=
 =?us-ascii?Q?o8vz4oLylke0CYvAZlQstA1TVZlMLipjbN2vL40Sp+kxwLv50hR3LCnitWd9?=
 =?us-ascii?Q?ZG/9FPzW892Ba/EzDcI99jaTjoixTDM4qCwOHkOhjKxVVu5Rlqks5QF+phbl?=
 =?us-ascii?Q?QVVogEmICqr1cSTO6eVm+YrBTEcwCyKrRHj+K/poslnDtpMIY4aQ3wx8EHyh?=
 =?us-ascii?Q?aHc5UfzykM0J/cxU92V4I2RUgQ6TnKBL1mrvFIFdyI2sECeTYKBOnno4anEW?=
 =?us-ascii?Q?MQOcoug18vEGy096EXKEIshpnO4qS0D0XvxVt3rVnJeZUkOtANFmRVCaqFCZ?=
 =?us-ascii?Q?x1rYU6n0oxPDjgPzAyrmGThcjdDUv3CYQld6l2Th+9VUbdCVQf6X1gnHrLe0?=
 =?us-ascii?Q?fdd5uOmSxYXf1J3lkSDBIw6Lq/PYBFnky6Lcxz3QQELJeOn+1oCfgt82fyhP?=
 =?us-ascii?Q?Ov4+n5+EVRix2n3fHCR8+T1VA4TjBN4gqqe2nYhBG4zVyk+FaGjTvXTCGL5z?=
 =?us-ascii?Q?iSmTYQs0vhoS1v706v5HFCNn4ONRx7w1XEKXQl1pK04Nq92Ar7ppKlCxidup?=
 =?us-ascii?Q?Az6ExivsV8227kGmn9cGSY2nUmXcbXcLkJRVg5WUN1tV8BMBCPFVB/Zqb28C?=
 =?us-ascii?Q?etxgSkK7umJkwWc4R4PCs6qbKqn7tYoIXDUsEJLAcPaLXYjPT59dv0uE7KBG?=
 =?us-ascii?Q?jbGVNw7+4QY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uvHbOharLkW7gIk2XZ7GijXPX/L07uxe4OvNu5Dqm7WBcIlkK4hvnKIbDIs9?=
 =?us-ascii?Q?baLwNX/PRd385e3NkHFWAtwYiOz3BwhOanz/EZ2XayHT/L2eVLGtNLDJVyka?=
 =?us-ascii?Q?SIJIUoxEIftuDVusSCmHUyJ7zZvWB5JwHzwTnn0G9GA5ebpOloJbA3LGQTaB?=
 =?us-ascii?Q?NMXGx1wHFDizWWzu/7nxX6bm7Np5fAm73X/kg0FMEGoVt8+rHFtqjWzmS8Ks?=
 =?us-ascii?Q?AKuKm5TEsye2lfawgnLGJu47jkZq8ZQtDe7LVDkWVLWdwZZnrO0XVMd8vkz1?=
 =?us-ascii?Q?lV0bXcdKOllSn6bE7MnoApEPwdeEkOyZ+nPi+yvQ/Yk7ZZy9AaQLk/GMWN4A?=
 =?us-ascii?Q?XkEQWdEzHMA9oBAyMSfpFYVFpH/9DswO0pdXfvP1oV6zo753ApIZPyPnfXqy?=
 =?us-ascii?Q?YTUChn2ZV277QE7bguDRupNMty4MhUF3H+Rvs5BDSY1BEOJLoNfKOlM9HJoT?=
 =?us-ascii?Q?kclQnMTaZl8Sv8d+yT2XDiYVW28V6V9l44uXUwbSXKIzc6VMsAHAlRK6MGM8?=
 =?us-ascii?Q?Yk0NXVniqajiDG42twgje5WoGcpEjib2v9b1PxImYqAo3tRJoPNh8GuCGdLt?=
 =?us-ascii?Q?5gU2jEfdcIVxnxmudFOntVORyhCqD9TevSLHHtnPfF6dTGoDYsweLjKx2xTx?=
 =?us-ascii?Q?WlccdCY0nkkpw7xq/fcnWPz5MIBHhYdHOPWZBY7q9BqE1u2WCuqHK7U/tMLz?=
 =?us-ascii?Q?0YHV2OWtGdPA65FGc/UBM7V61WWmmGsIL9FZJ1pYK+1koRgQ/X34OGSwwFL7?=
 =?us-ascii?Q?E4EoQjnu9iHG3+zmzxI32EfQ0snV2PHIzUs/Xb1XCPFjj7ug5TFL85C7mGKr?=
 =?us-ascii?Q?8tW5QCuBEwPjphrsRAqsfWn75bkCk7LZknxbbqZcUxfrYb5AzRiQcgufQLT+?=
 =?us-ascii?Q?R66OQUB2DL2DAg/ds2wswoAgC78L9/qWI2AaVXHoN5tOeKZRPcq1lbh5D5au?=
 =?us-ascii?Q?bN7drgP+jxW8nE2ZSIwZhVp2IeYEFa4ghHa1Kc3MysTRZujtB4ykQyh3raQt?=
 =?us-ascii?Q?4hvaEyEidXebHqHLh94DhJuvJQeea7LDnxNp8AGRBscA4JSX4SpGLjIPRU9N?=
 =?us-ascii?Q?fm92quUnNdFS/0fj+2/85nXRDPZ6F/Mz6pONZvSAhpS2zhmxjD6+p8zB4C8C?=
 =?us-ascii?Q?AHL9CcCZUbQfwb9+U8H2y30v7THfvMniaTPFlv4bs2Zj8xZByTasUXQrEnUJ?=
 =?us-ascii?Q?/gTFsnjmqHl8QEQ7t/ghtxyRE0zkmUwgLWFCAL0fN9duOd2o0dkAMA54892z?=
 =?us-ascii?Q?U0iKDThNBBiDaVFW6FSEh0ltS4QiTurxi2qaG2u/U4ok8Kktq5o/PDG1Qtlx?=
 =?us-ascii?Q?MnEyDyge+4TdEDZ/u9jCB/8lDGG0iBocz1ryJvg/7HJNUt4mA8SE/7qLcIcQ?=
 =?us-ascii?Q?0sV3eJgKE0Y6tEtrbQnGvyPUAq8MR77rhNpylf1NmHnx/KLqGDu9J4qum7jY?=
 =?us-ascii?Q?cqZZE8E+RJnsenOOvvmwt2ilbVj6ioWVl8g/7wPrzSi2sBSOnhBm9Ef3t/xx?=
 =?us-ascii?Q?0PpCivOAmAW8B8T8QWPQEmlZITzOvVEW77nKUYRJKM0AfuMbWATWHWUpj2DT?=
 =?us-ascii?Q?Y5KHOeW8Q18boc2KeYZ09N+Ohxh3uj0skiILVwaMGk9YWWEShyTO5fs63JYS?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	63TKSoS9qspKmku2Mym/MMPy/aExqcTg7N3WHn/SEU5fhuiCgNMfM4ed3nFsbSXLOo5T9uWDlSjJazspbpV3YnZsDGpE+1UNN1Hjw7uTHYVs4YOi3B/Ixd6tZgvxKp3OuPuoDXCwhGJ0DY9oUM531iDtd5vu296XdJ57DWYCrEQNa1UdpdaSvTXofvTK+W52HeMcwDNUepG1p34pJFuI7OlnNCIeE+F/ZpivIfOn3wyNUVKmbRZaeMeXZQjxDAF5dNcqsJKVLFKW8/08pKHNduzgW/h5J+0xOipgHjbNWRRPUGRcPLPkuudx5XQ3ON24xMfSxNlNhe2RMCPTEKWWcUbF86bOsp9dtAQcTkO3Gy3BhowVXzuuQ2WrKlf09e6fAawsC6x73DJ+QMQten3ui/4mn09DRHUjOa0RvwNPbbJa5sb9ZNNvrfD9QWenhKqFDN7PBGBy8/m27vr8n7VfMlB2YBC4Af8JJEI9HituUKdj+UpngH5QuM9ONAO/zjLfXBpkng7UT79i29ImDeGkNeBFgEIzdMolPsyGkoriTySV4vtlEPQPgxII9rcxD6JRVw0SDtKuYRFsro7U5AoF8h9nEDR72e7Yfr4iwQcn2ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e49a36-5b5b-4609-b20f-08ddb948382a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:09:58.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3gY5pRVr1lVC6pTkg1r1bexkugdIl+JwOhdGzrM8yw5FlJdRfXEwbqmnb0izAl3TJQTw2u04a9efYdJUG3v7YQ4bL0L/kgu7dj4RqjqDqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020073
X-Proofpoint-ORIG-GUID: Qfcj6eZpxEyc6Ki3WjqPZJb0KMHOM3qb
X-Proofpoint-GUID: Qfcj6eZpxEyc6Ki3WjqPZJb0KMHOM3qb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3MiBTYWx0ZWRfXwz9z79DRDYaS 4gC43IzHNID4GWJI68jSVFWntAPzbLi7By4hhDiU0EFF+YgUkbY7m67BzmF6P5Xu8eYeetr6mpy 8Kh+eDG7WB4quFKrN4T/47LC6PA5c2lMJrdRMygVAb/Hz/J7mleuEKpvtXTz5NZNvDZCAlnF5+L
 SMdo5FCAyYGP/hYVrktNAIJF41SV8oMrCvNGlwXUzS5BnRQU4mzPAichFu2vzf08j1bRfqtHoQy 9/8Rzfpj/v/k8cOJkmhRC/WIUJTsOoC5NKwB2DOQ2Zla7PEVr2aByhMDF1DNRkxuq8UYVbUDd8C vwHEQxZIlRDE5TX7jkQg6+aHsDr6HYZvEbsVDhEA48VOIl9uB8MVeDXXaEryEJEylzVZhudFriK
 YfiRlbQTslcfjNuQJneqH98AL0QZSHrBYGkmhu4+yUEZiAP98fE4GMoR6Dqoj/Qwzt34AFLM
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6864f76b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=LXE4EMrVoc0P1RCEbt0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723

On Wed, Jul 02, 2025 at 11:02:21AM +0200, David Hildenbrand wrote:
> On 02.07.25 10:49, Lorenzo Stoakes wrote:
> > On Tue, Jul 01, 2025 at 09:34:41PM +0200, David Hildenbrand wrote:
> > > On 01.07.25 15:02, Lorenzo Stoakes wrote:
> > > > On Mon, Jun 30, 2025 at 03:00:04PM +0200, David Hildenbrand wrote:
> > > > > We can now simply check for PageAnon() and remove PageMappingFlags().
> > > > >
> > > > > ... and while at it, use the folio instead and operate on
> > > > > folio->mapping.
> > > >
> > > > Probably worth mentioning to be super crystal clear that this is because
> > > > now it's either an anon folio or a KSM folio, both of which set the
> > > > FOLIO_MAPPING_ANON flag.
> > >
> > > "As PageMappingFlags() now only indicates anon (incl. ksm) folios, we can
> > > now simply check for PageAnon() and remove PageMappingFlags()."
> >
> > Sounds good! Though the extremely nitty part of me says 'capitalise KSM' :P
>
> Like we do so consistently with vma, pte and all the other acronyms ;)

Don't forget pae which now means something different depending on whether you're
talking about x86-64 page tables or anon exclusive flags... :>)

Yeah, I mean it's throwing teaspoons of water out of a reservoir but might as
well :P

>
> Can do!
>
> --
> Cheers,
>
> David / dhildenb
>

