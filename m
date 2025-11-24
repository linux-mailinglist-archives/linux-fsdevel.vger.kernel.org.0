Return-Path: <linux-fsdevel+bounces-69654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F64C80779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642B23A4BF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1F2FFDD9;
	Mon, 24 Nov 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AWdttRVL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BInFa8x+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC8CA5A;
	Mon, 24 Nov 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987436; cv=fail; b=qc321ywCMebnP4yPW5fhCBznCJunJkDmKWiqfOfopKQf8eiiF5bOlgs++Ov7jMkpgOt+/+e6mLAZHaGiqdijaHDXQCWqZ5DuG8Lp21QI5X+7EGxPeKdaHdZNYV/1JWjfVDHA2VVMq4ALeSHP8Ucw6QCG2XzCh4AlgpthDojmCag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987436; c=relaxed/simple;
	bh=QfugBctv4lR1grGJ+H35qE6gjhYZkS3ROeZN1w8CHvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHnntXoS23GopoeD6rWrfUH1BXTOt7WFVCVTNCEIoU8BZG0f5/SszLLNSdINe4GF8YT5Fc435muma/XAbZ1Ph08lhUkt3MtznZ1jHVNP5ZW4Pt253JD83tAVvO7l/sCUVcdU9Os9M/azaG5pQbFrbJmuuUMWqzO2HH1QDYLMMrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AWdttRVL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BInFa8x+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO8vZCa724102;
	Mon, 24 Nov 2025 12:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hjL5gxuiWikdpC0lHM
	NG+jkb6uottgMBf29Y9snbYr4=; b=AWdttRVLyHqv2HUjvMgIZrdj0slvooStN9
	1FZeBxdj0rjfh9wYrmdiZU6MWJLpP7Jap8LqDWpNjeyNAAt2gnQFk351PMqFnzBm
	/fIclsttIIGXSF6W+7E4/T6qf7UiwwECB3u4zYeIHpTbDSi+yNaKMlDaDuHWo/8c
	brsgdnXgKXx++nfn0KEDhH/mdv3NCv8E2V87HJixuJrf/MHpy1NaE6iAG2vJkzJN
	E970rShtrxcsG1jxQ+KBO9Wwvt4bcZ2TzJ3nplF4GKYYQi5mylnBXiJ2HVpOnjZ2
	dRscoUsTDkzusyor+4SB6Q67/xCcDRSwv2a4/34ur1ZoaEKGlD1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7yhhx9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:28:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOBH4wp022243;
	Mon, 24 Nov 2025 12:28:19 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mbt1px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGsfhbKcuD2DRTF+KIRhVmZg3kTySIIU3A2PQ4IOYYKVm1vpbd2Nssvp4tcKTBCQYgbLk7HYz3iwL0spZe6J028aatp4dlvSritCjW8wZOBAoS6J8JJGMHP6sBtgcCJJi3zLlQlluC8EFYxIVF6ywW63k+YclXB+ZxlzDqjXXPH9gvi8qp04f7Ld2V5euDPYxiPig1D63Mj1hfTPVV2/K0C1CDYponVSzibw/bhbFxO5uoFpLEhtIy5aRkgnPdj6lI2ilZzRb1INUJI3R9492lons4YKSi97Sfh2/QpLIevu9Yb7pqPJ/GJxFhRx07y1qrJ7R1xA3IMHHyoKYyvAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjL5gxuiWikdpC0lHMNG+jkb6uottgMBf29Y9snbYr4=;
 b=cHm3Pi8ziQyX5R9jpDNucWG3X9C8KsJ24RDFXhcV+VhACJuxdJV+gfexDwG+9rChprAtXtZBmqMfgysHMByQD1KQYDx21EbqjKHl/GPwXezSMC75GqgkdmGKAhoZSIHHjfZTxl9FTJLbZK5+N9+6FWKD+JDj0ujJsn6FpNHm2cTyfO8nHKhj3ONuj3S6TD2c0SCNpoIZgG6MWQONQdr6EbrObm7VrwON2GFwUh3mdb2r3InqFpnR+dYgaotBjPSXKkSKJnw5mih9xa2zz6O0R6w0oY6o2c6cSY+BklXUWT2m8VWOIRfnrQCvvF6AGiBkyS3s9MxFn0+H4iIT+hLe4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjL5gxuiWikdpC0lHMNG+jkb6uottgMBf29Y9snbYr4=;
 b=BInFa8x+oRlQONlux+VkQ/xCdwurA6qklZM5hNYo6SYa9iSC0XaffTOmGblR4t/oXoxSU+5Xa3hHoHBNUun8mqxXlBAWiyni87MPqHkNoX4oWecrXeMK0BkxwYrqSzKIpBiSTkHTZZVbwZ9jMd1V5RUgfvNsn2XbsdFFfwqWhx0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:28:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:28:01 +0000
Date: Mon, 24 Nov 2025 12:27:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 07/16] mm: avoid unnecessary use of is_swap_pmd()
Message-ID: <163964d2-4da1-494a-b1b4-96d061ab84a3@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <8a1704b36a009c18032d5bea4cb68e71448fbbe5.1762812360.git.lorenzo.stoakes@oracle.com>
 <a623f785-6928-4037-b4be-5d42b46aa603@suse.cz>
 <67c63cce-f1b8-48d3-83a6-6de1f2d86dda@lucifer.local>
 <20251121115550.8a8f9b39189b215849ce165d@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121115550.8a8f9b39189b215849ce165d@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 855d9ad9-3481-4a99-e5c1-08de2b54e88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YqRtzBCoyxuoxO/6x37xsagnzaY4+8ZUZO1dVg6r98X8P1t0ZxtlV79gqHCE?=
 =?us-ascii?Q?tyIi7Ik8OjB3al3API4ivdMpDo3byktUmgjLylgy9QzvaYL0QgmFdQ901oZM?=
 =?us-ascii?Q?7+DpVRnjraD58o7Y45iD4hRgc7k++0vAeG8sRpEGFr04WEhf7syxoytprVRw?=
 =?us-ascii?Q?Fy9ia0S07vtwObSfh23P6iQm38m9badIkTXCSEr23ZA9+UAtxvxBhTpfj/iY?=
 =?us-ascii?Q?CcwUU6juuT8QCwu1qE8cpP67tw3cSkHHNLbJQn5qw7aT9v+oDvuAlKCbDslJ?=
 =?us-ascii?Q?aP+FXStF//ZLJQ4cR3LrVLFbTrdrWVmQ8E9+6F8lZsj5A+TTTClWqmpaM1iM?=
 =?us-ascii?Q?SZooDKtYjg3ocXTrM3ALssnW3Uxea7rdpARJkft0STnMIo1EMOYLHiKW2Dg9?=
 =?us-ascii?Q?xyZMWaCzpZhw6f3q2Z55AcVsfX78beL9P6vWWhq6zF5mmOnIDoNao75QjNly?=
 =?us-ascii?Q?lJ/s28hXKmFMTbTqm0KrHuenvucaV4tW7vJnEYTrearIsSDCmUXlSChV9c4w?=
 =?us-ascii?Q?xLjvqUFTd6y7XHpZjDnjvtLmpnBEa1XbKsGNQpMA9s22VLp/ZY0O30FVjFUH?=
 =?us-ascii?Q?owgq3fq5twduBGZ5qs3BbWw92ieLRE3KlsmYDIQmEzMWjp6oW5LepK6/XJQF?=
 =?us-ascii?Q?hzhI+se18TLMJ8036RPBRyHS9vxkalS570LEm1iDiyqOk7V8O7UeK4hqWeuJ?=
 =?us-ascii?Q?J1zkPa1Kxr0PZJHV9fc5zu3Gw+e2smabZhDQD1wpg2lIguyPUFe6PhfHj2WR?=
 =?us-ascii?Q?0QgQfKgq6L3qy6QexQSaYzJxek74zWGH9LutF7uD0LZ5f43uSpehvc/1iMgq?=
 =?us-ascii?Q?DfNsO3mizXHFliSDk712cUzoeNP+/BeqjgE3CV6ZZowZ6Jx/qxFsHIiYy/68?=
 =?us-ascii?Q?UaD1rvAWpDahKyRFjgqiH1MpM3X9sHZ3KQzQoYCA2brxzlxsP1zzYfMrHUQf?=
 =?us-ascii?Q?ZqquxhVkcWIMx72sndKkdr1r/uJl9wQZzVHN4n/etRVL9IDA6+ZLvH0jUSLd?=
 =?us-ascii?Q?B2ZW/8NIDYkGTXcgb75M+xiPgtLSYaCRtlUNQ5o/4ykcgu0HxHQvKyvvACDB?=
 =?us-ascii?Q?zKRXAmEhrxWVaL3k2doOk7a+1N35rOsfHQknFKJRBvdxVaNtMt8fOBQrNA+/?=
 =?us-ascii?Q?FjNeoVn8kvMj6Bk7bvPkulRa53R7I8hE5SCuSh/42iMnMoqtENbCa70j6HEz?=
 =?us-ascii?Q?FPfXiO8TBodppdrAnEmxW9cAIrOwGj0wHLeDXZSTI9JHY03GwS+l6uxkE+55?=
 =?us-ascii?Q?qhzrgyP6rv+WuUmZTJgOcq5ymmkeswVwjwYses2F+9N/Cx/y9s5G9j0AhEkI?=
 =?us-ascii?Q?EkUddtHQV8naet2u/TyiptlcWtQXxeokeIWkzYLZZLIFAT7wOKgZq23R5nI7?=
 =?us-ascii?Q?65idYZ4PAJVwH0hYRiI/TEArvOi3mnBWshwyn56YQiIzZ0puav4TE+/rCnLU?=
 =?us-ascii?Q?z1jba2swTTX+h1AgnPgGxkMNWUjvmTZw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0vFkBuVm/TJLs+2b4Z2F6Mz6gmTS1JZf6O4bZW890jo8x39qEtpaN/LrI5S?=
 =?us-ascii?Q?xukxMsgYGbXMfwLg/CaU5izb0asO/d5nVRecWhTQsHRvPT8Hn+GihGROcYOv?=
 =?us-ascii?Q?ec2GtO5syFjZxP/YuwaNllHNWCd/C9BG5/580cSYQi4AK6YPvrDqepLKSWJZ?=
 =?us-ascii?Q?uAE6qGaYTGZzyoRWNv2Yv+H0uN+nn/HKcr+aRt0nFXZRs9f7FazxHzeYQZJC?=
 =?us-ascii?Q?h5KXL00WC1sOJRhOGTVcp3LWZUbnvSJ1sa0O0NUicexBpfXYdBSdQdxyQUHg?=
 =?us-ascii?Q?BVOt30163uIXeB5icG+wBBpXew7QVOxBQOQTeg0NP7wgT+rrL7z0Z4a1RW/t?=
 =?us-ascii?Q?svPrq3863xbcez8Ygzq4wAsV7mVG2xAEkh9qYkRIAR98zgCsdq4d/7F1rVLX?=
 =?us-ascii?Q?+YkXoaqzE0LnnQr6kQCE8J8FqYylRrHINoIAqJb2I2iRdE3liT+lKlfCresP?=
 =?us-ascii?Q?VZuDHX7vmef3J9dPePgqNvHJAEpF29ZWkAr3KtEZ91i8pwu4nBaE9RhXz4Yt?=
 =?us-ascii?Q?fZ/x0Ng+DsxCPZq/I34os3Z6BRoLqX59ZocsxLzLttMfz/YipJ63av3rLgJf?=
 =?us-ascii?Q?qpzm6YXi4u3FyLeeiw5Sff7QD4vtHjBjVbeGmBP7zRBb2oingLb6j5aiTkXK?=
 =?us-ascii?Q?k8BczKnDQMUEJTPNtFXrwHQuRbqA0zd68WxGe8/RCGgZeOkm6RReNbXsi2Pl?=
 =?us-ascii?Q?TurgQNeRQwUDItNgbdM3oT9jIxo6FWZJ/rqyMAIw21yBsqGjozVgzGmBKlfP?=
 =?us-ascii?Q?AfTo4BlYHE7JiXdo7uddOM/H4ZDjc/NzevcLvRsevw/6etRKnIiaDhCHcphh?=
 =?us-ascii?Q?WV/soTa/tfBdB8pv1tvLOGS5cm5bJJxFyes555PJuBI7B4iXLQc5cWLDdDlb?=
 =?us-ascii?Q?zC7j74XB4S5uClWecM5xcTnol7RAhKY7X/0v3dcaZSRCU0PR4JKqLwew/0Ja?=
 =?us-ascii?Q?JNVcQ7b0UXBGgH+E1+NTfMQAx6zPLEJYbRm1cwQSz+LPMD2oOMx5zOXNHv0w?=
 =?us-ascii?Q?f5h+LNE3shvjN32gqc1s32bQheOFU7pSCE/UrXkDaNiTUleq/FdfOeEuIITA?=
 =?us-ascii?Q?TuzRqumGueocvFjGoedaCR0PUHshKc/sdC/gISWJXJJRBUJ0A4MZjq7Xuacb?=
 =?us-ascii?Q?gkhe5WK3zqTFBPUUtcvYXINJd3bLnfg1v4nyhsDGEXY7H4oHW212G3Y+w6qk?=
 =?us-ascii?Q?At9SAIjhhGJBoOfl6t+GBgt2F9m8dM6xOh6vS0gojy8kUdb/EoLvR7whbLlk?=
 =?us-ascii?Q?tnfwofRPc669eWKQAqwVk98NGEnN+GbblvnjJSuMbpcFB4IrK+fGAtYbmIik?=
 =?us-ascii?Q?7bwlyXztheNkTCKfdc/xj1y748o181gtgo9+OSpdgUsqPLJfnDDhpnxT0Dch?=
 =?us-ascii?Q?Yd/6M16fhcXjVAvpUYrhqpini03zVVRbhmg7O8Yma+tC+GYWCXfWhX9VNVhm?=
 =?us-ascii?Q?aKXPpsMlJcH4RLeMYPJ0w7GkTCM9WZ+TbXoHcVBva3StjBjDiFVPadoKIh0H?=
 =?us-ascii?Q?1X7Jx/vOLghEyqLVXAWLIvc7V5hT9fNMP/luDtFNEwQQlEEQ6vaopLqkiNT5?=
 =?us-ascii?Q?aqa+iPoD3usgJX6N4VnW00fkvyRNeQvudtoYU1ZGN67ESciFDwI0AsMhRjzK?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IWmamztUmeDiZz2KBIQLTHmg8LLw8TO4le8llmlBySx+0YWEtf6FbSDAikvXiOAwSDhjcNHprKBaxVD+tVjRbCHlrG6ZpbaDbZl3m0nVFdzVYsgaMwIm8wZIPjIAgJJb1Is361SW7G2AMBeaMyw44Ekorjxcgqvv0sU6QikZ3oBsCTzRRBAqL2Hi/Kwn0OsQl4Ij4vEJVoj2PhgqY8yQ0u+cUpGJf/vtqgBDtVyxd1v9KGt1uO9YpH3/ouBWIua/KbOgrPHZH4zH26xWa65vhohO//tJJ/3yWOUvLcjtBxrPSqYyKWpeEDq34MpJGTIS5a2t+ApM9OXmjmpCgxDEescK1i0XrvCAVS4Pxm8PCYH/0bVj4OvuR2x2mxofgB/hOmMwMdrACcSDK8S/E0uwsxM7c/xPA/Cc2LOHjOny3zzy3KkCuVYgsK4o0bSwUP6nDpGaWtCkOUTJ9XyQZ+dgTwnYiynJSGt9PYNRi4K5shvZxL6NNskqTyBKPiPj2YkWace1kMGGyxfAVyEuWBzReyjVAp4+AIOqVuRfrAATptqk/biwE1usX3drvuqiVkiRvINowDA5ui22azrlOt4rl5AowQnT2AOnPQQxAIwmhh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855d9ad9-3481-4a99-e5c1-08de2b54e88c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:28:01.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU/CMZwai7L2HFMkQBAhquiB8R4PioXUeAZxuEiSyFUd1SghqROfZuAJ8h3NO4lrOsh1SCCfbHFg38N+wE5pTf/PULwzB0r1eukgMn+zD5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240110
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69244f64 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=McFUy6yCqGY1UNSAc-cA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDExMCBTYWx0ZWRfX5Rd9rlKc7KE7
 Aq04DsFEZfny60PewFx0EwDhS5OMIzvYpQ1EloDfZ38LHfADtSvSEypog/YiAfsnZ1YzK4OT1cQ
 GQV2N7yz/T2MSUzxUvq232YdJqBE6NoXajirMQgbxpXhsS3FbwOfdaA8msq8y+wCQHWKjtN1fgK
 3wvD3WjOCVMIrD9ivC2jvT4LaFPym0kl8DFo6Q6b58AcfZRazbEp+tJ5WWtHNMs7MPN6P1Y+plu
 5JOx8o7y4YnUZKGCozRHzlNp/R56qEERvIyClfT4tGXr/hiMqO1KQFqkfeuZil+BNmFK57P49Mb
 HkQ/szr5OizKAqgIHsxH3vlY4HSvlTiRyrxyThOke5+6E/cM31gu0xp2tsJATDcweN5F36pnKem
 5d5i+/NTib9hwasEH0VxvPCT+2NlIcEYKeEUtG9Rp+ukwWRdtkc=
X-Proofpoint-ORIG-GUID: MtnuMBiHx--hauRocnrxu-K9RjbsEptG
X-Proofpoint-GUID: MtnuMBiHx--hauRocnrxu-K9RjbsEptG

On Fri, Nov 21, 2025 at 11:55:50AM -0800, Andrew Morton wrote:
> On Fri, 21 Nov 2025 19:25:46 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > > To add to the confusion in this terminology we use is_swap_pmd() in an
> > > > inconsistent way similar to how is_swap_pte() was being used - sometimes
> > > > adopting the convention that pmd_none(), !pmd_present() implies PMD 'swap'
> > >
> > > 			       !pmd_none()
> > >
> > > ?
> >
> > Yeah sorry this is a typo.
> >
> > Andrew, if it's easy to fix could you?
>
> a few hours ago ;)
>
> > If too late then never mind :)
>
> "too late" is a thing I try to avoid!

Thanks :)

