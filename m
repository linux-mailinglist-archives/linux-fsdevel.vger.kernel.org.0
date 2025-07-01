Return-Path: <linux-fsdevel+bounces-53443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3C8AEF15D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3414D1BC6765
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0955265298;
	Tue,  1 Jul 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WzneBO1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qr2/ctbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABC1E515;
	Tue,  1 Jul 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359121; cv=fail; b=Pu3XsxqVFiwjwRw5moTjlCrVsQyrC/EuLJ69lELjNKhSGE9+hLOtU77unm/93P0nMfYmudDD+YgKAWiAfqyoriKYl4s3nhHDqqhGZOu79ynucq3B9x03Jj5PWzEly9FF14GZ1qnqTJww+G5BkLOZ1Njj04gwJ6g3/+MQczHzmLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359121; c=relaxed/simple;
	bh=LMAOo/HKOouat8QCK9DGxauR4ZLcmoOrSrWuR6gB+AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r12z2mor3dEYpcP+dCOxpNdwjL+UO3KnwVLOfcYeiCGYorU5wATqRtb7xw1TE9lfesuTtvt4PDaxWAJPv3d8YyrJnqv3Wf0gw/hYXLagGGmg0L1qss92O7m8YnApWNJEvosdek5hSIuIcaCPEiCz96awKiSC3to5eBxzh/EFUAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WzneBO1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qr2/ctbR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MrQV005833;
	Tue, 1 Jul 2025 08:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eumwdj3P4i6IrR6UaL
	0/Yjpie7qVHUpjjPeNVkWdqVo=; b=WzneBO1M5peSq0b0LU86fVZ1NFB+PceYjW
	Vwo4BgIo4V9rkQh2lqh5TPDBFvp5kDmLOnFnBd+zZQt/eVdT5S+xMJN5qr8OaTod
	Iy37JEA67cLSbtET885P+TQ7ES/wHR5Tq34eb1m82bE65T31JJoVKbj7AyI7uidG
	7wxJYsB6bhNUWh4ir7tTyTAJtw0xWN4DK6uFbtRklRMu6RYiiH+qWNsEKJhOTLk5
	RUlRt/MC8iKzt/5QCGlAoKQlwojo7T9ucPxTh4oTQNWOZw8qGtLIXcs24bpp5nkp
	gWmEcfEAaxiIS0VDWdhJkZ2VmgbkfNICgJ2494z+bEY8UD2YEqLw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7uh3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:37:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617nsHa029848;
	Tue, 1 Jul 2025 08:37:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9es4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN3qkwqPOPQnwgIuOOTSroIjbbyJlLu5IiJo+pRPqpmYvkNvTdJp0s+NzRms52Fd1CJNoUePYDIm62Eq8XOVFFzMvJVo/O1VAGFblAzziUSwuLMVth2uTP4j2/aU9bpsxOBt2a+RXgWgZ20fLkZn9RDUazgl1H0baybVfAwwEAQ7TbZJ0xIk1S+84hM6yasqXqQ03R8gnlFnUh1LI85twQhjzycFblbF1PsDcXK2iZpfseJvelOvqWQb7gxbExt+VO/VrdFd6GjlQ4hU9r8TEN2myuRiU6fiiPDgZt094+cfKe9YFhyzV2fefn8VY+SUQnrYS5skt0OsvXGLrMfoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eumwdj3P4i6IrR6UaL0/Yjpie7qVHUpjjPeNVkWdqVo=;
 b=SVw1eAJ3zcDogmIo09UXlDikmKtsNNlaAt1B34I/9Xn4ZUcCFgE2KzyfFohDaYLS7Bv6ND21O25gXF2f/4UWE+6Z+Wp6eVMzlWrcTL4Il06Qq+ewZBJRQ9AhPdcd10v9yKzT8ddde5gfeQyHK1COU7nmchSMpyBD24PjcVjHOQkajI8i9KQvzfv7qikvPc5zcnFFgyAzGXu8+6q13DGruiac8HWy6QDNJTn3yX9rPKw2OQfCzWpkmola1Z+PraFl4C1+7P16PikaOmmZxzYr/hLYJtaH5eNH1n3q34DNhIsk3VCg70J4uLtHWLvsWpnl4Yuq/jRiIV6sXDASVb5eSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eumwdj3P4i6IrR6UaL0/Yjpie7qVHUpjjPeNVkWdqVo=;
 b=qr2/ctbR15CzsVw4NWE8d9NAQIIeRikj4tKXSwEt2Klzv7Ipj7kCL1iMPugmsmfWpPsLYQzx6H4ovppKV+3PiUP2lLN5/2xq16Nfn3DfJ6orX2gbp6xhplCEOAIAUI3ns2gwsGlr6ojl1k9NIPznJfxOz6P7kcTCkUr5Ja71Bxw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFE06E70EA4.namprd10.prod.outlook.com (2603:10b6:518:1::7d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 08:37:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 08:37:06 +0000
Date: Tue, 1 Jul 2025 17:36:46 +0900
From: Harry Yoo <harry.yoo@oracle.com>
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 14/29] mm/migrate: remove __ClearPageMovable()
Message-ID: <aGOeHvlvBkJwK2P5@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-15-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-15-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0140.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFE06E70EA4:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f6f52e-610f-413a-091a-08ddb87a75e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73g02FpsGvK4W7Hf/13JnAah2L6cY5XZWRJa0MxlfDvOGnjOy/ldec5HmNhU?=
 =?us-ascii?Q?wStpMpHn/aMmlBq5Lv+/xF5NwWc6YPUfdGY7CwYsGrZL7LzV6YQtQL8FBfkS?=
 =?us-ascii?Q?LlfLx4bsX+w1Awt/bMtt6J79CfXE7DbgLGlOGdBS8aP68qDa+MJYe6nxze2g?=
 =?us-ascii?Q?wjMzWfuV9IOHrVQiZ8x/6T3pqk/dxdzLgJ3p7YAG50MGfcZFx39eArI9BBZW?=
 =?us-ascii?Q?2IEzQBsk5hTBzPc3qAKVyJGpGAg1vtxkQSoJDEdOo0QeZBAkjgnbz0+v9l36?=
 =?us-ascii?Q?gU02PS4udRc456Q3jLNelpuSSgHib4SKf4omwsVP+uBKpe6vcvIR8lHvvv84?=
 =?us-ascii?Q?qjck6djEtdkLSgyaZ8xkq2vXf9CfQjBv/5HpMe4IzQy1WYSNNt4MmPvdOfiq?=
 =?us-ascii?Q?MeQ5nAWT3fVUm8PSdsJNbLmUAuqAg2J3hYrpvccENJyyev+kAJO0e8y2cVmZ?=
 =?us-ascii?Q?plR+/eJAjlBLfqIp9xU1LW/eVdOSIbMuzI4FMwrCwMcnMHNJZO74bIp0VSid?=
 =?us-ascii?Q?qFowgFC+thD4OALFrkIJxtBML3K3gKgbHPZF5GCisJmpOR+3xYbbIznvnQ09?=
 =?us-ascii?Q?BsCiqNloHynB7ySSulDfbsT5JFcbE1242EWx4+iWNGbYBMiv11rniET70Ssa?=
 =?us-ascii?Q?gdOd01gKszykoeZBPdtAz/hVdJgKRwLsZbLTBZWyCLg+HrPwckRVi4a2TCOD?=
 =?us-ascii?Q?Dm4NgDxATcEz/1C8GiQqDVMnnvblPC9dp/+GfRCUV18Su0KDlwQhfRvDrJY1?=
 =?us-ascii?Q?MaBU4xjh9sAV9T30wIao6lNXDvF4fJjJDDTc3a3OGo3ikH2ng6ig6qzVZbhb?=
 =?us-ascii?Q?V2BfFoIEIECicI3V7VLrJKhGrpBpEYPZch1U1lP7HQbzUosH6NVAVrcyDvmp?=
 =?us-ascii?Q?YKJq6l1e0bj6RRKQhb5FsCRMgWylUx76DZL5bbomadurfIGY/5Wp0SeUJhbK?=
 =?us-ascii?Q?sUeQPDDyi4ZXPSuzqbiuISy6wy+pZNK+6QzgjjWbOz7pv22/q6O4/XDCylhT?=
 =?us-ascii?Q?p7pneuR3iyaR+lghU/q0ncyIiJDupY6fI2KephZhjO10HAY0EiZa1P0r4sFv?=
 =?us-ascii?Q?7vb/mMHnIQuJG9ZVq3cfSNBjU/ySb2T8dUXvHt5BU2kEl5CGo3RocNBIZ+4h?=
 =?us-ascii?Q?uv01J09dvkPH26VRID8sAZsGICI5Z/qZNI8sXa5MOPbrge6WpsihO5+rzXlj?=
 =?us-ascii?Q?oZkoVFhf7krzwqwLDUw9g29ARni91xJVd0iXyn1QNJNidgiARLhmHCfH9X4X?=
 =?us-ascii?Q?pKpYewJfICmvkYFnpbKAtuN+tiwlACr5r7Wesgo7m1aPlGv9TCmZGqxnAxq2?=
 =?us-ascii?Q?wDGQCOcJ2iMLqE5d4kHAREdbW/Z7fQi2MG1cW0s7bCdqyKHxr4YT+CAKu9wR?=
 =?us-ascii?Q?V15hNAiENV0SHZmytbY4UxieSXQws7h88Y0MAK9plixJcNPLoniuZX1eZGtz?=
 =?us-ascii?Q?GxGAZahGOHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhCtMx7TFWa70uKv+M6jeE42Je9r2aZSqeyZ5BFVcvzN5cbpUj/JKcFBY16d?=
 =?us-ascii?Q?Y5FQXwPhg2lNpyACKnfHLJDbeP3EUiJV8ie1vmEoUslevcf6CDuYTXmS3Xio?=
 =?us-ascii?Q?UIgKRh0PsNkOcs88e1idniMqZh/Zr1FOc7BI2hhxyT9pPjvV6UJFHRcmPNZt?=
 =?us-ascii?Q?fQ0zSnvZQYHD9AuOV847+EzrxwIM3VpsTGs4ug4Kr84BMwnk4WHtxmVPPIFO?=
 =?us-ascii?Q?7ZIvuTVGYn/mga2PBWWubLQnbXXiteeXC3Hm3mAWt4XbC5UJrOAANMsMG5A6?=
 =?us-ascii?Q?tTZGsdrLYXHqk9L3WHTK+A0zPZe0Pk8w6c3zhFUuWX8+Gh8vSTWaAtTXWLLL?=
 =?us-ascii?Q?PBl6KRtxsRs1xRCTK7TsIWfiZFsq4gWwMKIf2erZZtKnr7G3MJuDz4Tls4y4?=
 =?us-ascii?Q?oQpoRe4NG8sI/lR7nnnCn15DL5ca79eT/2PtPJCUyxqgPjCoJoc9cVoMcmDw?=
 =?us-ascii?Q?NDpVgS2lbd1Vc3192eyYBi231YyIQ0C97dibDuLYxmG5YY9HGmuxd+NeEytu?=
 =?us-ascii?Q?FHaETYwRi75TnmrEBNcu2+JN1CrAZkRSpSU+XeROiQNPHD6hkrb3QqVx5JLh?=
 =?us-ascii?Q?e18cFhekbsViFeha+Empnv4fDsaHs+5at49tHMiAHpNZvfHE7aF5b97YDKM4?=
 =?us-ascii?Q?ixHpePp3IhsIrJd4AFCQxcqsRtjtuEybveXr8vlTxo7iQqDQc7/w+/w8AwtA?=
 =?us-ascii?Q?nR2VHHv29E6ZTPbFAF3259ytVUOOJhxlVMoPTQpWh5yzx1GYPJkC1Xldmild?=
 =?us-ascii?Q?5d7MWsG/mLRRHad9a0Q3B5m29qVhl7umKxKaT8NraM1ZtrgNohMu10w/FhhW?=
 =?us-ascii?Q?7rXhzD6MKlZ7ZPaNIzAPC4aqp2RHbIRwAplW2J4zvAFamtR694xEZnyS9+Cj?=
 =?us-ascii?Q?R1yKnaTDCH9rvxv/uxOzQVyF07gOASjwvBnGfUmblXHB3mN71caMEBy/kvCM?=
 =?us-ascii?Q?l2Yp/Dph7chYUyuHqtq4tRzOVkCll9uXr+mLCfSNkqhQKm/Nh23R5XGYQm7L?=
 =?us-ascii?Q?mtBwpfqAS6A9i7zJML97f6CeLGN9BpJlOXU5lcfYdi7TnrBRTHxDVFzYELE4?=
 =?us-ascii?Q?ZFBWH8gzpRrtnR+ZS/q45ywHhZT2+DQYdGpY0/0So38mi85dxOisacMCxhIU?=
 =?us-ascii?Q?vzXb4VV7QcYFF89uGUJZRE+kij3aSxIYUI9bQHE4ni8YUPdWimyPLjONhcCz?=
 =?us-ascii?Q?lmHN+CBKiS0+VOp71GhnopDhSSHTWp+OuUKRoogzJPh+IA3K4B7aBgUwBfhe?=
 =?us-ascii?Q?2ew8QgANrfAgPRb7tUtHHNDXMYcfVjV1dJ/bHIYm1/VYqxkkE2VEGJOyO1KE?=
 =?us-ascii?Q?LagrCQ0fFsuevKPuUaQgKXEGuKer3dr22A7rr4YAuvohufGOzZv+r7pNYcNH?=
 =?us-ascii?Q?QGJ2BR6KJ6FCt/uQ8sDxsvIhPtPVS7/VxCKQv+aqG47fO/kk71Q4DhtvRRxf?=
 =?us-ascii?Q?TR4lJNnm1bkLsoGIFHj1IDT5bh1NKMIASX3xnS1c7MlAVgOsF7SKqzV/ZVFz?=
 =?us-ascii?Q?n/0sy5+sAigLR7tn7XjQZAVogcXBKLaTcAp16Bv4ms/02IqtXBd4llLXljkN?=
 =?us-ascii?Q?+KZsXU/j7TiSb+o29Fi3YeAkTfTV9UA1JkUEEAS0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lbr6SVe/3UMHcq4FqETJkIBnZhbZZV8eUNBer16quDx8sps8Qk8+h+z6Bo8P+wBWr7sem1Ko8PDZPbFkJRD+UsVBjxYvIiqIjyFJRDHMMVw3yEaBHB5kG8BuddMiaqRGZxE31a/z7hT1KgIx0PENqxEfbYBWTom4fdcOpBT4gFlYLIcVS1H0hRZDktieWJSRhgbS8DmxT6VnNiTTBhRUDXMFUUJlcFE8j8qx62B+8Sf1Yc1Gyd+gom75MrW+BmZ+5pSWxqwTh8GV8oocSgEZJXn7qJX1EdInS62B3+xFVGYTsnTJmOF/B55kTBuDFjO7JChf5hwo5fbw1R3yJRQzhV9oCmD8+XRlzHFv8tdQlRer701gJUKOr3XzCykRpXBIEknr+5OaFdzz0GLi3EZU3mslwxxHwC9zezX+YtU5tZNmGYRtnND4ZDxxARdqiHDWTof/RcF9pdR1n2JsZZrglCvGUKvu65FZOPwp+Z6SomuAHiqw9wVPstjNmSewaiIjWy6ePz8QTX+nMDZeRgV0B2PahpApzFxexkTPlp59bhv7Q3m5XzONMbmqpg6eqJN2NfTCA4mUE8sxH41ioTNNDIWzVMT/LXPc18t2P0GivfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f6f52e-610f-413a-091a-08ddb87a75e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:37:06.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkKdTmzJ8gh6RIfpqW2FsFWGo6hQCzYWapdwuBZRTz5h4tc6UfGhJj954dQn9cVarGqN/z5uqWIpMTrYvcz3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE06E70EA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010049
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0OSBTYWx0ZWRfXzbyEc1BMjzKb odrOCiRCPV+BD05sFLyqFwMUVtmQMYFvYtESpDpVhTjtUbhc3hDxHnq+H4iOJCULAkoc1j4wALf 6voY7nup+l2egQG77+VYpOcAQJwe6htPl3pYOqUvmFsRXZCLz5knHcR8ci+2uKzcdH4Jjy8hrVG
 /1UfCdZqX96BkrKPG5EZ/9KCcoDp/2vVO6j9II2eNJftChLI+y3mbxG5TVy1fmib/HLj1SnH79J GaZybumz4Itnby7V/u12bv8spyXFG4mvUvn5B38sBxG1C5PUoHmdYIQv9jTR5H3y6q1nwEcDUso A85/ja4c/v2ZK5zNdwSlDJPf8y/ZBVgL9zQhJ2sXdUkfZS2q7fvL6VZ6YWaVgoaMdxmnrnPKAE2
 mRUanp7w/0xgMGthSKxh5ld4H1fz4TXT4CUXM0rOQtXf83ovLqYe0Mq7kAQLcHE2Z4eVogsK
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68639e37 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=NNP-Pm35n98AWGlTw60A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RfShdDbWqF7jrWG4kChfLok4HhO4JNfH
X-Proofpoint-GUID: RfShdDbWqF7jrWG4kChfLok4HhO4JNfH

On Mon, Jun 30, 2025 at 02:59:55PM +0200, David Hildenbrand wrote:
> Unused, let's remove it.
> 
> The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
> still mention it, but that whole docs is destined to get outdated and
> updated by somebody that actually speaks that language.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

