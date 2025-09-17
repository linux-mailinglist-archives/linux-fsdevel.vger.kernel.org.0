Return-Path: <linux-fsdevel+bounces-61996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85DB81847
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4404A1D20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AD33C76F;
	Wed, 17 Sep 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Emrtb9+y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qKKNdh+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282633AEB1;
	Wed, 17 Sep 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136349; cv=fail; b=n4Ti8FzcOmZMUn4WJDRpwaYtAk4S36KQqI8jhAFSeIKaa3/51eKnzvFR/S2qYHmuexhVM3+dfIbzoeJbi9sorV8eK95cvqqD4byYBxVR0l4nH5kJLobJiFfAU1G3+mvEa4QL+wtBNJHcRMJT1REYFWcmqhws9Bjvw/P/U6Qarjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136349; c=relaxed/simple;
	bh=zyWx9CHiAOIEBPfncjCl5KM8TnytCZFh48lzn9ulZyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bG8K+rpczBdigRNs69igNHKcFpx+748HmAyhxjnwO5oVqn+yhPHtdJP8dCpklqyxJ9f10cPTfQjxwEJezdBNdmh2Gnzyw0D1YE6MVbnHVY0Nr96tZQ2idTQ1aFN1GioKt11/ep5ORkf3T/F2lDwLLiUK77LgC/IfuKn0Z4AY7C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Emrtb9+y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qKKNdh+Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIStO001868;
	Wed, 17 Sep 2025 19:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mLt6Iw8NNsjDpMDEGiSX6emtwWW6f8/pFdcoNzwwJeE=; b=
	Emrtb9+yJmO2boZ4hI6+jcd+smaPCM2BhDlOKDZccuX7nwrtgZrdk5DEbPS6V65k
	qlujLNp432yD3Y0Tfie8RC4hWA5wJXk3lme78aQpICgrEvSsyqav33nM/Pe48j1c
	pewK1fia04DgSPlJBOv0YJyXr2BvnP7eU4ePRt9oyvHaZOikDTdFFIpLbjqg2To/
	oiBVFIOZpAShA/IJgUHFOZjw7W/X2GCba9UyBdA7qD+ENoBZXQz4mEjhmQPaUZdh
	sKvrOORby/uFz3Jl1IhFaRqwNSOA5Tb0Hz6fWeIZLDFa54LFS455cCjSrD5Nf25B
	DVD3lH4y0g9h4kDuXcEHBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd207n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHEIed033687;
	Wed, 17 Sep 2025 19:11:45 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e5fqw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXEVswrWqbd3Qehi5bRZBYtirKKRPvwtbe6UjQO1isDx1wYLgYhu7a1AF+mlZUW76WwZGS5q3QswedW2ctKislZzQewa3ZJjHeoQQMAA/K4+Fr/tzGXf5neRQszc6jKm1h8i6TdFgMxtCy+BGtg6jQWG3Kyu5U3mN6uGOgbAV7tSgSzwXv2eS5lUuf8jpHH+k5xZ6Sdi2TKQQgqaDp2sPqHt/4EJkW6MwW4QusPj0zWuChVIfb9g1v7mZ+DX4iropUiUfapuW0VmXryLONwDL16VqL5ID11QjVbdfbN0p7x7EgOW/xGa2l03msmNogKjh3JymTFOoluXk/8kMD5GaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLt6Iw8NNsjDpMDEGiSX6emtwWW6f8/pFdcoNzwwJeE=;
 b=U4f+rj9R/sYJ7mb9OyKlR0ns+Yh1NqX/Ggd+AgTUCKX8zYfQY66WJeX2LjjqG4aMphlLzl0CnCWBUAq8MVoeDI2BhR1pAsT7AQbNJzwOTTiPzQnsPCrYn7JJC/f1hFsI6Vqmex1Vd+ewcVfBBaQv4FujXyK8w0qJMchPn+89HRlWib1wtpPrf46dc/HouNIWYb717D/dI0RUBjQVW2HBL8uQAMxSmGOOGNv6IBYT3SEdHjN7AUrVFgxNgEJt7HqqLUpO3MJnZ65DpzLQdqJiTwbKDM7TFJOr6cGRafh6GsG01pfOxxvZgpeO5zUOkccojEHYDPKXIHh3zt4O4wG/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLt6Iw8NNsjDpMDEGiSX6emtwWW6f8/pFdcoNzwwJeE=;
 b=qKKNdh+ZGlSDIwchiVU80xL8fekOtYUtGsecEtD+2dKIUcu0F4SZor20/s27uusgELhV5DWN7SPxKkM5F5zB6BgY01aYT79CVUY7hiDv1+Omgrv8txS0/7xDYogsQ4sQJnsCn4pry2O5JIuus7TfbQr1oyVOySHIuaax6kOVH1o=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 19:11:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 10/14] doc: update porting, vfs documentation for mmap_prepare actions
Date: Wed, 17 Sep 2025 20:11:12 +0100
Message-ID: <269f7675d0924fff58c427bc8f4e37487e985539.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 961c355e-fd3b-4be3-ad0a-08ddf61e081f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9I0Mqifa/72QVUok0F3aDTnIo3OIxYxRpvhJQmiXGUdjsrH9Oa9Kgr8q8B8+?=
 =?us-ascii?Q?Bzk7Wm8UsUqEtL/Bb7laSkywuFdnvZ2laf/d85NvAncNvuB+SY5wdrBkzCHE?=
 =?us-ascii?Q?me6o2q0CFitrJHgjBTuv5VI6i8iTCReNMWYksGhTo6s5XOybiR0lv3aqDahM?=
 =?us-ascii?Q?0nojYyeERx5wr8fYdhOusndkzlIrQUVAHsBKmG4RV6KxXLGD0if/9DiTyk6D?=
 =?us-ascii?Q?7YGcz7ZzKwEdUac/KHcusLL7kmVNilFK2o3wJEtmc3T6/3IT0rAaf/Talsm2?=
 =?us-ascii?Q?IeroV1mH4eZHsXup8wE/Vx8GgffLNzF9rKx6l1WywRQhQgZjjQrz9FOTqZt6?=
 =?us-ascii?Q?oMq5QlGYVW8E2YC5DcWsUW24rx9AhnUE2INMfdEFxv9md0B1PzibdDdRPoGT?=
 =?us-ascii?Q?Lc7LZDROOTP6wwUHbO3sXjMFbBuBBarf5Q2vMfjg1/77IKCZwjwrNyeiMmFj?=
 =?us-ascii?Q?7n3yxiYfOtq820Oc2ilB3anBSy1P+VtgOY0jssBUhcvMh2ELMR7+vwksOfQU?=
 =?us-ascii?Q?tLM50sSrmgda7GSIAxyHPZYsuksXhBoRR6JS05fRTRxHY9iFqrFCLkKxe4Fo?=
 =?us-ascii?Q?ZWPNsVGVoRAt8umdbg1o8QQSTZfLbiv29nM5Gml3YnV6k9FNTgV/KrM+GOnG?=
 =?us-ascii?Q?moTnX3yTyZFn/HU67TX4K2ns0j2M8Z127950vnpxXQvlCtPpaHDXPyIvkqPJ?=
 =?us-ascii?Q?ppp/6oGsu3qRqAM7gtx8LdsJuloQiY5PYKvZBH74yxwBvdr27R6je3LtsbNi?=
 =?us-ascii?Q?9kvc5AVSZiqgnUqf9UQqwaJSTocONCh+D8BRh9ncE2q7iE/thCxmfjp+tPRT?=
 =?us-ascii?Q?+s5vXCqVEpcrLp8C8ctyzxiUatUju9joMuOh2EsFerCf7cgLH+osZfZWJfii?=
 =?us-ascii?Q?QF25rIKL4ZhpLEvSYUC1fu6wAvzXEGbV/zxLWcf2CDvuK+8kCfsXJhvGmdVb?=
 =?us-ascii?Q?mDiV4wR8nvxmMpHiBviWnZEjHnq0ZsnnefjaV/efPCPFHUZSTDv9+YMFGjmv?=
 =?us-ascii?Q?+RBqPjIYXosuv6X79O9YLowhWbifZeZccvmbAj9t+qnWj7vJLoEyojfkp33y?=
 =?us-ascii?Q?fcgI3i3GnOvPxe8rldCui7rEa8fAB7+qzyxwgb9ZlxVft7WKl8SKLXMmseEl?=
 =?us-ascii?Q?/qIvAikYhXJ5l5FzoBTlsg3YQhSuLMrlih1IBRjuEET/fi5rw3Qlg519coRh?=
 =?us-ascii?Q?GDErFr4T0AAVnJe36zx0tpU5rLekgxxDV+D6GighM7n4lyae+PeZOo9tgepS?=
 =?us-ascii?Q?Tx91bqabB4pZxB+nU1FoYcHTYNM9WL6OLLZW/Uy9aEEgrYvqwHf8lGnJl0tl?=
 =?us-ascii?Q?BKmOvppzkKi/Z2prv2CS+gbdLWqsMIppQE6Kvv+TP1C1P2njOXiQSn9JcvY+?=
 =?us-ascii?Q?aglG3YVdOli/+etZ2R+u0dAsbfzhEy+HxV9m71GKm/McMGlqCqt6s+J3QGBJ?=
 =?us-ascii?Q?aKMtknRkCMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+2AYuIACUTsPC/uvnULkS5FV1CYCKlRgQUPUH80urylxVECIqPakeedyLFs?=
 =?us-ascii?Q?b/0UGIwNLng7/NcCzWnT/V4szZNxYXoE2wZJXwTbCTmvm0JgFWOmAL43HRE+?=
 =?us-ascii?Q?Br33CnJhyhmY+rUtg3h0MfrQHTocAjbB5s7v8L/j8JQNDVWQSQhUML2y9HWM?=
 =?us-ascii?Q?ypLelpLW6uSQaS52+OWL2KFnr68IlxgvT7gE+aU3ZipM86zuvRsPRAECp8ay?=
 =?us-ascii?Q?fIdJUos/TroTCHI5JlJNdB6rEoEeTkJCTWHe9wEIS34+3zlovvf28k6kmbGJ?=
 =?us-ascii?Q?S4RLIzBMgIMI4+hAb1B33KjXXjbcE51lpwpK+JPSea9Q3y610awtT6siEVrx?=
 =?us-ascii?Q?6AIpNw1AvtyfFIMp+Xlayg0nWdDjJNMd2hz2WCFJNB5i+1fwcY1muGKTEqM5?=
 =?us-ascii?Q?p9YZZJ5ajCLTd81CspWxblLVjpGgteD5OxCa1NSGoilpjeZonCOvxAlngctE?=
 =?us-ascii?Q?eyuEUuJNGRPcYtf7WpJswpTTuzFkInKozZmkQIbzkENoQsKKk+u7jpNxfc+3?=
 =?us-ascii?Q?cSG+jVglqdQLBBcGL1gVL7Nocx16UFhSjhZmb6MyeTrPKxOsWE9n+Vk+kr66?=
 =?us-ascii?Q?uHtVioBafvTMU5Q3jods913+yxuiD67Nyo/i3EzlQwtpq3ZNMDh45dkjQJI1?=
 =?us-ascii?Q?3gs4/t2GcxHgdCBg9RGgTF5GHh0c3mhilm9jdBKDZV4T0LsKDDbZ5/iavZO/?=
 =?us-ascii?Q?DD4W8JzElY8QOcc48qUCN8DYo458MSnN9qi8WNHjJXcJxVPXTLdr5S7VNRcX?=
 =?us-ascii?Q?9y5gjplcOFT6cJg69FSlcUMh56VhtELusLnemfaQkAm6NEe/lkRaOZpQUkoE?=
 =?us-ascii?Q?De94ch2/H5KIHpHhqFckTgAPCYwNnZXtJUV/5SzsN0u2fevEiYdoz3KcZe7J?=
 =?us-ascii?Q?9KKr1RLOhcBxqh/FQCDUEdDYZb5AF7EwtyZva6uQPuv5K+l13U529SIRkYkr?=
 =?us-ascii?Q?Rr9vlUEH6tJ7R6V1qTgRtddmVGF+ww0DGz83ItLwkvbDqLPQG9keUZmiIHFk?=
 =?us-ascii?Q?aGxadEvj1ktHCUyK+Afm3iZz1cEKLd35NsniLCfFLWYjlJGH/4+Fk+rKJHM+?=
 =?us-ascii?Q?bfZiBoIf8OQqD2wBjJLly6URBT5aROGjzSqKFOSiOmWQ6lUSnZgD4boEmoVU?=
 =?us-ascii?Q?+3+wEKwk6b0zl5AIfwrQ/aCoOoXrcDj/mOlbfqXWFFhBFxWU+HqXrcZrhG52?=
 =?us-ascii?Q?UxOz1qe9j5qz2qcV8WOWPzyvH72mYmRpvcpYnR9HmSZKrvm98AjS24Gd17UQ?=
 =?us-ascii?Q?tmdp6u0UiShOKp2b7pezIJ4/yQIUgCJ5ojGem4q2KLg6P7RJ/8D9lGrLRAwk?=
 =?us-ascii?Q?l7r3mVcCRJKdGepPvRlkh+WcbAmwiHmt/5FGqO4pZOdXNw6XLPLnxBeL+HBq?=
 =?us-ascii?Q?7jrNChYg4i8RfTiWwMfCW6R0Oau3xyixVGBVoD7tH+ZgKT1CvJw6BDuYPPKM?=
 =?us-ascii?Q?krxqziBt0jRuHbBh5dZFJ4nC+55ioINsUWsPpU/up7TFQSI/AEnWPgl8eHTK?=
 =?us-ascii?Q?mog/EASnQbm8PpX6w13GlgWrj4CbbUtoHo8ifsUP+XyvzSRXSupaKEKndBPs?=
 =?us-ascii?Q?HJX8sdAAnubbfhfucQaUNz/+oyyt8fVZfwKUViW8DiUohVXxf4WD80mE8MXS?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ENtYV4CKfeavDGNOSGwmsmaEPhUwdhcuN4aCe13XZkOnAqMRGuq6lUwf5Ibe97h7jjnPGyWAulBkwZwdBZZscNsW0hcCLU3ZVZDr0JLOp2BEv57CsA1zAcJLo6hD2rQCJfIgOISTQYVUGOm9cSf8dTsUZnjpwqcrfsqhHnsCb6Kch3StsF6aTGH+0RwW1+XrQG2wKREDDimGizk5s5KUnBhTttcSqYkYSY/dEhm5ROhSNtaxFRGCVkrc5VpJxzJJqeypTMbE3kZ5X2L9VQCP6RiEv40WbzWrFZyFROisBJGFQAmcsgJfNs0lYZHqAFA0tPrL8oBK0twXLguY7Qrk1V98mW4ENFfVYB017MNNSvl+vXpoKD4DWKggQ5BKCQ4l+bp3skJ2zsqYEAGpzEMOsSKbUT/p5ViiTd6Eh6L4R0UVbgadZ1uRovvgMn8QJ8v2lgSmtN4SzNpf0JUKOdZSHe8BNKIcKaGcrzU2nC3asjiN81ssCceFMv8ATJ/wfZNNxD+Nyv+YTM+eHCt4nRqkddQeAPkCJ4c8LvqSIc3fC7uvJSXv7aGNS1IEm7HIJt3fRj/XORGnMr6FbIp5gw37ldvyegOlT1GMudAbIYVNGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961c355e-fd3b-4be3-ad0a-08ddf61e081f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:40.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jj7s+bpP0ciOzealvO1eGfzUPwQqNIUiWZyBBnDuOqyNVHnQvIumRKGEhWN6PsNy1RmhLTOiJwZI2SSLQ2GaN5JmiTdypEaI0yEeQqXjIF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Proofpoint-GUID: KTTnpgrI421CcI7gatKIDumiEB0nNiyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzbe1WAuA6RMo
 jTXhzaipWhRQGuFRKVbgwcjCm2/uG4Avlzbf+N3sGtGTNiIumWMcr1v2RUvHQmQ7MceNm8O5dCV
 0bACRw+3jHAFd1lqBxz0hBWIMSiu4kO1w0jX/amuAh3HDZG6/EPJ88PSUNHsQe980sfwvj85epA
 AGi4zDJBfSyPLly9+q/rr7qWACG1Q68v4s0C0BDAR5IKavvb/p7nZvzvGtGF8BACyAb4OVEaISj
 MgItyY+JrgJNTjSlhKE5NO763MjfsoedTd7WeVGw616blERkDmO+w8CbudK09MBWKL3m/EvYy1q
 pDNk+vCN+wYxU091UuNYiIXCVCFSrdNuvvzBlA5XO0V5ezUBqm2wjIHI0wEPEMTtXySDuyg+3NJ
 MlBsu7ci
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cb07f3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CxsoVSIMbwK9moDqu60A:9
X-Proofpoint-ORIG-GUID: KTTnpgrI421CcI7gatKIDumiEB0nNiyz

Now we have introduced the ability to specify that actions should be taken
after a VMA is established via the vm_area_desc->action field as specified
in mmap_prepare, update both the VFS documentation and the porting guide
to describe this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/porting.rst | 5 +++++
 Documentation/filesystems/vfs.rst     | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..6743ed0b9112 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,8 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+In nearly all cases, this is all that is required for a filesystem. However, if
+a filesystem needs to perform an operation such a pre-population of page tables,
+then that action can be specified in the vm_area_desc->action field, which can
+be configured using the mmap_action_*() helpers.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..9e96c46ee10e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1236,6 +1236,10 @@ otherwise noted.
 	file-backed memory mapping, most notably establishing relevant
 	private state and VMA callbacks.
 
+	If further action such as pre-population of page tables is required,
+	this can be specified by the vm_area_desc->action field and related
+	parameters.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.51.0


