Return-Path: <linux-fsdevel+bounces-66688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9AFC29047
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF04E6794
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5E23E25B;
	Sun,  2 Nov 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PI5UTDse";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UEpzDTzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BBC6F2F2;
	Sun,  2 Nov 2025 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093737; cv=fail; b=sWk5VvgDfENSpvokQnowLtfrqO0jCV1Q9bFeipeLZUYp2fCjRk4yrIHjRfgZ7+4h++hiCxlTPRnjyaZynYrEi07i9QWhxiUvH2kXOG3kd+NFCVKAXdAHZv+z6GCxUjNkL0lCquunzlXak4Upr4YI0ckEEeOip7vHGTh7zI+I/jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093737; c=relaxed/simple;
	bh=ua0dpUoZL0mr1SmoeRNgcDcSWJ22+ZNfAgt+SwNd+6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rS2NoRJylvZXW1kzXtpjc6MDDGmrQU31PrbAe0uxV8TgUU0kQfttQMrfsFnafB67qCX/cjBEj2hfeHMXQ0XXOY9RijqGedMaXufjFg6yOiRKqS8DWjt814IAi+vci1hsUQgtYCJGoWLpdRrQZTXN9QYIz07OlQqUcOMAZvpnisw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PI5UTDse; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UEpzDTzi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2EP2U0031905;
	Sun, 2 Nov 2025 14:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ua0dpUoZL0mr1SmoeR
	NgcDcSWJ22+ZNfAgt+SwNd+6s=; b=PI5UTDselsCB1iRkwyvsD8Q5dh5b/N2zIZ
	fBxcdAhsK0rwhoB6IGh86vlLLstBMfJjieWMLCkCmhzKQSmCNnqhnAElFTushFy8
	Ix68jU1L641nxCM4B/vRqeSQUHC69CGOyMeBx4woU0s7Jlx4S1GtpJ4ktd0/Vpgm
	og61B/m05I7mTYLlfQPsQx8LUzsWarWi22WouzZlUqhcpKb8wm+HX7JWXqj9tJCm
	ft1VJmE5ULHS619B+nf/Fsm6DPeKZhErSSwnVSHxyaCq90lyGkya6TeaM1mNPkMt
	0GtrB2pU2oafSa5eDMGXvE5QRHShoZfO/zaIHr+vBj/Mnputoqkw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a691k003t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Nov 2025 14:27:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2A8R4C007967;
	Sun, 2 Nov 2025 14:27:13 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58narma7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Nov 2025 14:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwj6ZL0Ik5kXT3nBJHnui7ttSZbkz0o/bnodKZXi7XJdkkKikD8FNxf8R2w4ONXFEQZpJPkys3ThffU8C0HxECUY/Nqm/5XYZ62Rs9pfnOE4MJp2IcMSTH5WY8Snt4qfBMDoEkQL+mUOPECpXJ153544nzp80+VgVSiWAV21avGYegunexlqJmqZIq4J166C/hjmA14wEb7rsctXH2w1Ye6p2/gWRXdMr/bo/L0zAjjgtfFMDtSPKY78/M2Ir8RAjX2Bn+WW5j+zep/NYCbzuyvxrGbbLz12Jo4WpbkYJYXRvrkvzqEBiWFJhcJfVCTRULF6o3NYmkcq8aNkWVvrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua0dpUoZL0mr1SmoeRNgcDcSWJ22+ZNfAgt+SwNd+6s=;
 b=pKhF+c2OyOMSs6/Xq9qqVhvF+SsNY7S+Dmkalz0yhT+JpGSCS5Joq3iGtrLDaTAdX6D/wIdnW9Lzi+mm2VPhF144mjPKjSmsdccinQrr4RfaRcS0Ziv9Zzy/b+d8XXU39YLPGoRHr7+lzcdk4j5DfeLa+Wt0FNsVv/Aa7xdZY3kSY0QoKUGVeXQFby6zIYxppVNLeJBlp0CjgIL5ZqZiwryrFG2u5bNIK5af1BoJjkTpmAPu7H8277WbJQ8uSev0orgtuTMDkU9uRfltffCWGoqPzCyNoDOJSb6uGJtwe/eInN4AQXp29PkdHbSJvr/JY3le0xiHHxIkU9aX9sIRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua0dpUoZL0mr1SmoeRNgcDcSWJ22+ZNfAgt+SwNd+6s=;
 b=UEpzDTziGp46EyxRkL42imtBTb72AYDZ9U1Rklu6KBiH0BF3HMw2CYVVtNCxwJEDUBSStmuusXbFP33W6V4WcuavFei3WUaVFtmYJwXrHwKv0zTwypwd+h0fiyinbnQV9ee15n/BL7mqxVyunXHCAQue/at5jSP4jfmVAjtUqU8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4907.namprd10.prod.outlook.com (2603:10b6:610:db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 14:27:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Sun, 2 Nov 2025
 14:27:08 +0000
Date: Sun, 2 Nov 2025 14:27:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <40cd8c17-fe83-4b13-8782-12d63ed77d6a@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
 <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
 <20251028124817.GH760669@ziepe.ca>
 <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>
 <20251029141048.GN760669@ziepe.ca>
 <4fd565b5-1540-40bc-9cbb-29724f93a4d2@lucifer.local>
 <aQKF2y7YI9SUBLKo@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKF2y7YI9SUBLKo@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 956ea06e-6606-4bf7-4509-08de1a1be7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvVh4O1MtmBXEG2W5JV0mHkweV3qGfK+yfaRaJ/qj0ht7kfo498A3Z2lZ+zU?=
 =?us-ascii?Q?t4rr5p1dlpkt6eNPhA0N6Ha563xITntIVdiGGDt+U7A4HmbX0r1UT4BxYFa4?=
 =?us-ascii?Q?6pcbq96vcx72V2Gf6qAeWskQ1ZGGNIqU1l2DK5zQJ/gS7nPWTmJhWqsaOEKL?=
 =?us-ascii?Q?n7qM8bP1YXNqavQJl2f7XrhUFz7iVYWn2LaVBWJYw5dfsbtLcWrLqzl6GV0R?=
 =?us-ascii?Q?GcKH7qHI5kDP47L4awEmmYaIpmfAQ1UIQqGvm4zQnEjPoM6ROvgNzHE82zFr?=
 =?us-ascii?Q?Q2QaPHZr3h2z4dcu/2/0xzixNueREVIie50VwLuvLrrVaKuH8BMmPJkx03Ne?=
 =?us-ascii?Q?+wtrQW0RSu1moEz9cCy6j7vSxacX4y+18UmD7kxEe9G1QRMD5zQHd3ZCEk8W?=
 =?us-ascii?Q?mMGNM1BqRbQWIiVQllkRRx0ayeRJsNJYK/fQD0Sc6qiPVBjG0/gwFWAHvJH/?=
 =?us-ascii?Q?N8ComaUgZuaJ6lQFSMewBtLSkOOQVe1xFTdcHElQzQZhNjH40LhKTZU+t//6?=
 =?us-ascii?Q?VkudTUWhpmDBdAryNEBG2URzkyYRl830D9OfU3Xn5ORF1mvgKPShDucMXiT/?=
 =?us-ascii?Q?+rsoOHH39palkEvomyhJhOo2DzGpJkb9bqKTXVYL46TG28rapRuNlM8Dgh26?=
 =?us-ascii?Q?+WqKoD1EgfdntI7fwKoaAS2Dq3R6yY/h0Ju6gJxQcu2HA23Y9FUO8rs1T9cU?=
 =?us-ascii?Q?jS4bVp5GQ5eyxmvQGE1nLdheAp4X9QvIp8xU1ChgzzTbWUOup7jySHhZkBco?=
 =?us-ascii?Q?s7dJbZeu8IagkNZo0wuImmwP9x8EkFZoHeSZ9wyeMotXtgrnxY3G2ECRghIJ?=
 =?us-ascii?Q?EYbBEDscUbiHnJfj7eonwkz45PPcLT2utW3MpMJ3Ifzv/570Un4AbJtSS0CL?=
 =?us-ascii?Q?T7CYdyUPRvaCyUzC/d+uva0Q74tupIdOiRsRThvqDqA604OjCnuuBz+g+a0I?=
 =?us-ascii?Q?4ndls1ZsPSQMC5US+BtwfVdA1vBFzd17Ux5wmp+OigygphoM/KrqafawFcDJ?=
 =?us-ascii?Q?GWXKISrjYnEEIUm23UYBYMHIuWCMKzCK9jEgowWOZZSil1R2lMzae6hibz7K?=
 =?us-ascii?Q?lKnmFv4w99D6ScqpY5rIYvxCKFYOlne6HP0anvTUDAtoaMAX6VK9TaZJw071?=
 =?us-ascii?Q?qzWXlQbWuDq1CMG4IjXyMFtKtAGL/KOKoIjWAvOpEnZstVUde7TtKUpTQzdi?=
 =?us-ascii?Q?SGznHxuNRB7kt9hEnVF+Y56LlEVTB6Erec2I8p1Jv1Eo10TI1IIoXm88+qlh?=
 =?us-ascii?Q?gj0NIbPB3IFNXnQrUjhXCXLGgECEx5Yewmu6XVwAJCg/SznOikTEBfK/X3Mt?=
 =?us-ascii?Q?+Q31sX0zcAiWb51p87BZyy6zb0axOW+Q9PrpFmU2quV0XOPR2sbJz4SwtTwB?=
 =?us-ascii?Q?Ud9ScX2plgiYG+mp+YTFhG3COMEnfPG1Ogb2uWlLGoGis8QqdU4cmKN9Kkmi?=
 =?us-ascii?Q?NVnNfELP259S4FBjxuf5hj6UaqzCICug?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2LVGg4HlSUemfq69ijJSazCl95UtSvn0EjiGfXxE48KJYZoBCJFlARvTlkkT?=
 =?us-ascii?Q?svyBm3UDXqNQnpbsBBH4CBdRO9C1yLdFHH3dJzqh4fyDCPqgDwkifA28zfhP?=
 =?us-ascii?Q?Ss8WU3ct84/SyTRyqPw3YSiDJRq2BwJ9z5xJOLMAAEmslNAUkS//+XiGb6LD?=
 =?us-ascii?Q?0LQvD22lrrm3pnf+K1r74LnqfE3Nlq8PkEwt/JE0Jg2PFL0pbd7hV2JX0lpF?=
 =?us-ascii?Q?OqAhYUYqw/mtRDrX9zYsG9v0gBtY3XMHJyztkbP85GJbhKpkNNiwCrjRPxYt?=
 =?us-ascii?Q?X/rZ0TQVId8A5Lw8rjvx/Z6r6MdE9CVvaXlj3rBLkpHjpmDpRxxEa0ZUKS8Y?=
 =?us-ascii?Q?EBu6asrd2OFh/uFqQVveIUh8Plv2YBFpVZKUdjbya1lj5+nZHxQ79CYQQdtw?=
 =?us-ascii?Q?o54/dmGecCDRPSMUhNWj6gLtTbnxUe7NdXXaKuZPg0p/BKKA/mnvWa7b1Ucc?=
 =?us-ascii?Q?AhheqsYGl3Vv8uaTuRGC7WbSZiWrQHbw4KjHfRpia1KIQHUS/GMEDvEpGMlA?=
 =?us-ascii?Q?4zFfIzDXMNic2nEivrJULzs4N+b3+/otiwpmr1EsRo5KnOeXhDB/r+r7pVRA?=
 =?us-ascii?Q?mGnRbvOylH2J2pS7pfkGUCvCl4rOWOpoFZoNwwtmHIMRAt+uHjJCA9qZhra6?=
 =?us-ascii?Q?NuUKyrYhEvgeyQ6sg8Um6mz+75CU99VEOf3uPmCIBRHoJ7Wryg+Z6IrVQDLH?=
 =?us-ascii?Q?aHv0yoXIdHvvXTQBme6f8b/Ko6nFhnCcqXeqqbBxetxuxFduFC9T4gWI4/yv?=
 =?us-ascii?Q?p4+6d3Vyjw76d7aJuOtH2rPrm3yioKzquHuq7fHpgOgJaAQQeZizezX8moEA?=
 =?us-ascii?Q?VcfkxIf4vzbL+8zCP1wIAinZsoLB0Bke/VDHdlZgLZGfLxNR1yL7/AYGWQKe?=
 =?us-ascii?Q?k14E9g1hCVOXgo4DaIfA6ez/ZT3acPvxXpwgyQN925YPENiy91mLbq6QTwiY?=
 =?us-ascii?Q?12Aoi2If41yGEbcun8b0A2qysjgHYFK6udJ8lFEympB++pSV4Zlkqeby3Zho?=
 =?us-ascii?Q?pViwuvsi5ONaHmeEiD3KnHrG7Eqv5JU1DBVZSdthX9N6JZ4MT+qKfztL5H8e?=
 =?us-ascii?Q?squlyIzFft2WWkjQuzmdVRvSsSgSgqrp6gPEWKYwfX3HywQWDhseACi4ibwL?=
 =?us-ascii?Q?FxvBO1pMKqwBnWxWh8hh0sFRYeuaUd7FzWBOsL1z2Mu6Ej3krpxfsA2D3vcV?=
 =?us-ascii?Q?r9svrGsf95f3I/2UwHF0a7i7wWHmW1LLHHMePZ5TReaGLQzemPpS2nCj0pDu?=
 =?us-ascii?Q?8LGX6JXN8WjEPTFHpjd+VE1Avka+SIVNogOHV1CnA4fqXEVzCETqQGdeRBQ3?=
 =?us-ascii?Q?JFVLIFv+4YXeqnzdPt//7SLHJB4YMJ48h3JLt88y4CMQcDTEOv+pmZwi3w8R?=
 =?us-ascii?Q?6LDKZLZr8PtOGz1bbHzC74u1LE8NCPbGb+4r7EfzuuzQBSYj7jitaCEZqqEh?=
 =?us-ascii?Q?V+V6AE0HzPbjKe1ZpfKZr/LAj+rd8JNkUxMTRX76HioPguQXbFMqQL45lzFH?=
 =?us-ascii?Q?er7E9L1STq4bD3wy7uSqtyqr6LJ0aYA43regXPSvLXuD3hnYX1zmVHapkd0b?=
 =?us-ascii?Q?UKKduQIPnUqynKCBoW5z6VIBtw8W12i7SguLu7Q/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z5T4/gKA2A+NYtmOnr6bkt5Yg1hZdTWG2cIrLzjFpM6dA4prOdIXBwjIQopGqQ0OSpd76KVQoDv5BPS53H543ONmNDoKBkLjkDXjM0jX3YGt2RLDPJswu7Se4TbAOnwTKk6gAMIQu1rnN3nrKHX5VvD2exFbEBFIBRF4S6+z5ogvbnER/7znIsMoWJYX6dtxdmPaCMLxxZ/Z9PKyCtPbxCp7sYLyL3Og2g33px7kSjF8mWqxCcx74ZwitTYacA+tgv3eNo2kbecxHdzwSlR0GpJ+O7fIS/CE8I5Up9vg/DepOg3B6mNPbsfes/mvFzcphsl22c00lkvBgrggW+Aep1LLPBJKVbXTsHh1DC4RPZBwjptwwfp8kabQs42keOiHE+Wrvfy7ZivbuBm/WDbqyNVjqMBlTtSUIwZYxUoo5iVKjjyhrKMTeYUgTjMqJhulAQmyQQDb+y5a69xC5IS3AqUxwMP7WZjXf/PpFzm8YNAa4gsxtA1zWwXGGdsktFfLrb8nMEeHLBUVF9qZCb7Qm1ZDAgCQJnFdZ2oZjkoFb54DuZxK5MfQCEXthmlEpmxwaTJFUd1x+0y0WUov38dVlF7J+vUNXQr9+aE47TUkkHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956ea06e-6606-4bf7-4509-08de1a1be7b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 14:27:08.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cioIKj5ZEoqupjyIhXMoGplh99e0Sy+hNMiCJ1yQ1jt0FbOzgiccNNk0rm1J/9vqVUTu7rcvDXgLkPwFD1x39atOdDwtZhdYTNbMLPn28es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4907
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511020133
X-Proofpoint-GUID: grxTbBDdgAP5hZmohVm2R_-Ecku2Wgae
X-Proofpoint-ORIG-GUID: grxTbBDdgAP5hZmohVm2R_-Ecku2Wgae
X-Authority-Analysis: v=2.4 cv=OfOVzxTY c=1 sm=1 tr=0 ts=69076a42 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6iYNzCaUjdNj9gwTP0YA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDEzNCBTYWx0ZWRfXwtk+XKsbrLo1
 xyAR8h8LSDwg0y2iVp9zAx4op+2/9+Halxacdiw3dFzp91/hAT03CbOpznz1Hg6EGtUeXzX0Oz9
 qAG86S00dE4HJqc6T2M79AX+XweoCPf3+8BVBbKAjZzfNB0WS8MREySuIo0qD/EL79uDbM+OsEC
 AfiHoZ1miYoqMt8GiIEaOFWbzC748ekdvdT7QxDWPCQqQ6SBsWc/KY6yc5S4b0ecvhTsXy0gDvj
 Y44QrIAJPLka0VD798yV3UAt0DPFLLcgPtJzp63BB53rImV2ZwjHDECRRg9MXbRgIhopfONGe3N
 OTWhOy05QoU3B+nb8v6ZFjhjxn1B5dH0nydCWBRCSsE9mFuTz66rWyWbEJwU/AZJZGFFlIX/VTc
 xGQgz31joIa2SrrHdZmO8w1p/uTaCoglidC5lDk6CD1p7ipX1Q0=

On Wed, Oct 29, 2025 at 05:23:39PM -0400, Gregory Price wrote:
> On Wed, Oct 29, 2025 at 07:09:59PM +0000, Lorenzo Stoakes wrote:
> > >
> > > pmd_is_leaf_or_leafent()
> > >
> > > In the PTE API we are calling present entries that are address, not
> > > tables, leafs.
> >
> > Hmm I think pmd_is_present_or_leafent() is clearer actually on second
> > thoughts :)
> >
>
> apologies if misunderstanding, but I like short names :]
>
> #define pmd_exists(entry) (pmd_is_present() || pmd_is_leafent())
>
> If you care about what that entry is, you'll have to spell out these
> checks in your code anyway, so no need to explode the naming to include
> everything that might be there.

Ah actually one issue we have here is that huge_mm.h is _super_ early in
header import order so we can't use any leafent stuff here at all, which
sucks.

Will have to compromise a bit here unfortunately!

>
> ~Gregory

Cheers, Lorenzo

