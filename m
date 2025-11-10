Return-Path: <linux-fsdevel+bounces-67753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10FC49809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936213A94BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B030216F;
	Mon, 10 Nov 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qqdCpTOg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fq5xOYe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947F2F25F6;
	Mon, 10 Nov 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813356; cv=fail; b=Dq414011094uRt2CzfR/n3dZM12/+PHXpWPlgiS4X+XrSz6GZ89GM292WOcMwuJ2KNGOudJXL6OzK5Gaz9jJcPv+lpdUO6UJSUlCfXtM9wX4vvYBRFPloSxJNahdah887ow5eJu35bIZKT+cCLH1CPfwic1mjxL+HndBVs0/PUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813356; c=relaxed/simple;
	bh=Dv6KydGXVUcET9ogzuaZYe0biQcH5kJa9fRBq6bgL44=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RMo5LgGyK4TmK1gzF8LMGcb7OiG6wSSLFL/vCYLJ3dsXCI6K8QRe9IxeYDFuetMhmK0USNKJHYYyVIPENjkudgGicpKMmEC9mauOas22lpHEYNi5Mt6G4/pA6ED4Ko4aMzmcsC9+caCf6hWq0agOf4ID8I1JpVH8vQXmM1j2yoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qqdCpTOg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fq5xOYe+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMIL20025961;
	Mon, 10 Nov 2025 22:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=3e/ktl/KVyqj1fmq
	6AfrgIfqhE9VaQulrRNlf49evjU=; b=qqdCpTOgIhW+TZoM4l2G+SZ/3z5M3TnX
	MzipYtd3sX/1HHPcgaf1zoKg7HJdYdI7VonoFY81cRXzHRgSSXx9T4XvwIZXo774
	1t1kKcM7GYG31LKsAdO+QEasEI7pb0FD8WZC6Rn4mW7tqSPxYbHB5eKuLDGW3/4g
	z4KiEr9egSJQvlDtEgB3KO15UT7nVr++fQAUZQQHQWmZKVxQIkaq3plwdXV9FHi4
	SYqHiDC/cJmL3JsiRzMBlnNiiuvhKfcoAw51/uDejeZL1WsIUKHR2ozoBzF76uS3
	1MP1mWukqTGOSBIuP8dmjQT6SlXGx9yagcHhm24mc4U4GJ0WzWoEcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abr5vr29s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMBBYb020907;
	Mon, 10 Nov 2025 22:21:41 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8rhn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3BBmhIby9efzoVZb2jgZ6T5Y9UEhDyy8jDCqsRH1rUPhGzliDV4HKc0/USsI6g9ExPLSQg7wtzR3T8EWl/MoIleSjg8CF1LHAA/lev4SgH+L0UnRozNk7vDRZ83peDZP5WcqVZA+0Cc4v88qO5e0CNn9BHX4fEVPiHCBJxSs43kzDoV8dm08W9mQJyH4hwbdrzdPfFCi07LCi1lyjeTk19V0+e1KRoCxSOP5/JlXzmgp5BdajFWYpVYtPmPeHT1A5d048+iW/+Y/UJSMpyFDa1RwCQY84T/ggBlZHLg3Xuu3MVboKlZLJt33ARWwSGV1mW1GfCPCyP0kFJe3+Z7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e/ktl/KVyqj1fmq6AfrgIfqhE9VaQulrRNlf49evjU=;
 b=ux057z8MFFsTx0/VPr10E1P4fKdkiVuo+4sTZEFZoaAi9T1wFnrwCEbJsuCmu+hKYFYz+AEeNqZ3H4WOBbgUxRx9nYvDon+auZuSTLwuWEp61MVgmqYg3AXwfW+UGdzkAGy7b4bPTkCP/YIMgD2yHFTaygWPurlxk8drGScrqhW4ycjyvTHWHeXVjeBDl6KJ8CB5E0inqWcEhsh8H6sAHGugjmxpYgH8Y4ZWR8/euKNhqRefr1oCleDI3Xpyd4aYpqd0TO4R5xG4oy+i1xGTXTzRMZvjCiMyj1uVpQbaL0zope7uA15VpNgnGDGOCl1vFV4nzPIYSRRGtl9uOWJnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e/ktl/KVyqj1fmq6AfrgIfqhE9VaQulrRNlf49evjU=;
 b=Fq5xOYe+QMnxrimkXU6AsoTNVJsat8kAOdRf0NsS7OUnO8XDZzBNEllyc5A2bnzMPaJrPK0UeAOrawwv5mbYP19RkYCT92QbsBm2SckATIQp4JVCaqLiNOKrKEsjoRmzIeos0dH1YLqd6JbvjDb1zyRsc7HFIBk9pqBaH1yQHQE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap entries, introduce leaf entries
Date: Mon, 10 Nov 2025 22:21:18 +0000
Message-ID: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0d8d67-a826-44ee-f6e2-08de20a783a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vy/bCOynMA8+wNc49eIHU83gNeoWZVU+gKTWWdumuU/5uWw+cwnR5hvrRcIy?=
 =?us-ascii?Q?RF7LgnVYh/udB0DxLGP2g35qRA/PsiWGQULzA+ZBDl0IZBcv96R3FIr5WGBz?=
 =?us-ascii?Q?JzZfkNtKdM8Q2M+SbPIfZzHtAKiGqscGgxKiRqXw1CWbqs/DckhphJVPPaYB?=
 =?us-ascii?Q?DuFrwF93xIDFaWa0AzUlRnQPSGXubT9/vhr4yQaQvwbh9U9dAV+Bm0Fvsf9k?=
 =?us-ascii?Q?D0MuMGFSMrqNmnosz+gTrlp6dwUSuelMbsjh8gP3ksIaPRRMGuWvAgcLA3Oz?=
 =?us-ascii?Q?SVWDXg4pL1K15RKgkqqHIWuJeDS1L/fnWsK1vCj197C3C4Pa3WXujKU1IDBs?=
 =?us-ascii?Q?3CtKbc4MmdeHd9rxuIV842SaIGS4zcAIZkyy872N5Va4Qp0+kFpuOFDmROFA?=
 =?us-ascii?Q?DijJvamoYnuzuG2l7dvNFwYp1jQrVy/W8qYnzPRcgIJY39BS0B0xbdPEO3Ma?=
 =?us-ascii?Q?3CiOvC2TEkwOtMn780OrrGa+MUW77wdo3uWnqDxJwGq/295aSje7Yki0H0Wo?=
 =?us-ascii?Q?QggKLfeIqMiZzD78FoQlGJgjMIlqSwMw+Gxq7wQ6opYmD5onWYqtuHRh82mT?=
 =?us-ascii?Q?Gyp/qQJCvHrt3PLYFa8cZNO4uChRLPT9MwsSMBI2Nm/xafhbJeTx8PgR7V8v?=
 =?us-ascii?Q?tYJcIweeTrCtlD64A5SNa91meXqxpVzGhsOxpkv1Dlqs/e1DW6gb8v6LvOhQ?=
 =?us-ascii?Q?H8BCqPpyCLybrn0bOxEVwkIblczRwi0wuLoFgA5eIgWhdDAOIjt+KsiQhYUB?=
 =?us-ascii?Q?sQz2cPHXK2xg2ZFW9myJCNcQtBVnIq6tFfDWGWvrcx/Is7aevItnHCTZ5Nqr?=
 =?us-ascii?Q?uALKm2Hvyao0FzfYobfiyAFbaZa4moCJhr9jbX2WwKjasf1QorryQPCSx8Zo?=
 =?us-ascii?Q?/OYl4VCPczRwzOX4OzuYPYULx8/6LkhQmh+mWLcSF1Xl4WzryByEyFdmbC1d?=
 =?us-ascii?Q?jMH2C3saL89a46HcGc44PWBGlsDrFCDZ/Qf07RfPyqzFdrxK+IQXbZakI3kd?=
 =?us-ascii?Q?vTXJjd9kett+adnwNB7kaZtvpPSTt0EKDNhAnysa5paTnSOqcs+8ZWPzAEDA?=
 =?us-ascii?Q?jxX9myy0aYLWZq89+UATjCVQjoaVGBAQKRtt6rD/TIHKhaOHYmhu+qmBA2o3?=
 =?us-ascii?Q?HjtPlbaiC/9RWP5PisGqC5Nl62c1PLFIspRAZ8JMLcV+Vdb/I1a4+/uIdDLU?=
 =?us-ascii?Q?zzgql/AYIsZU4CmH0Wf6H8sJFS/3oFLwKKi8HmxDAFnOCAa4gga5+yT7+t43?=
 =?us-ascii?Q?loCafqXm1RRJyg8WSaUqWsODfZ3+AY22CGdzbkhu8rgpmaFAWdTbV54yWfpG?=
 =?us-ascii?Q?p//n7YNkCRMTfyNjR2axx6fJ5VoCprwVjbfxDRSqtN7qNTItRton+BzLiO0h?=
 =?us-ascii?Q?GDAgOs7NwoEot7yOXl6pJcspavoOpyeMJe4z9v8D7k4LFNe8zYjirxbxHrb3?=
 =?us-ascii?Q?FPBjWn3mkp9iuRLJtK4f4ZfIbZjPXpCTVeakkcWo3+Lm8FHOP780lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?03uVX+y86U+9UCcWt2CWF3zDTWHFxo5T6U9idzdQ6K6KJElLHKZ8vpDEyERj?=
 =?us-ascii?Q?0eJFCiiY19EW9aWDsbTcRhYpin1I0kNZWvWcqH9QF+frxHtFTTILLzABZeJF?=
 =?us-ascii?Q?hqA32bzJSInZ0m8PTksLHMM7hThhgx8qyoTNq/bhjJ6Zq2vCIqElADnOZZ/g?=
 =?us-ascii?Q?/Yd6XhPWcsJhXZQt96a3RcHnKUjY9u6TplyHBSGxML1o/gGGZftoMtFKUosZ?=
 =?us-ascii?Q?PfVaLigxQnHNUrAYCj/HmiotVbVTA3N64qMuik5Oze9rx2E1HtJvjIjcyPlL?=
 =?us-ascii?Q?J2Z+nQlmMJ4XR/kqTCPTtlnKH9Lyr1bmgHqCCVyeWHwV4htMOucLIkf88+Y8?=
 =?us-ascii?Q?Fkxo/0kRpK0eE8Snhkmcmc2TrerEeNcaBVndpI58K6sGQCiJ30mg9CB0Impu?=
 =?us-ascii?Q?reMlz8FE7XaPw5x+vi9b1ImjZ/05cP3CS0gG3Wzv/sf1Jjj20FAUAWzCJqlr?=
 =?us-ascii?Q?qXNtJ4FNqNE89K2R5hi20dAKQGbz1NWKsTopnQHDwXpnoCFGX7HOdnk+hWKg?=
 =?us-ascii?Q?jWT5bcSFsHfHRw1N3GGaBouDYpmERolGGSZr1FHNI85gfOFjxIxPRk12UUdo?=
 =?us-ascii?Q?1/DgHsxPR3brn/e+pp4KyM/yEiPEJcWAv4ZuuGEbtuPzpCJZp0I/h6AveGmf?=
 =?us-ascii?Q?hZyZWlQwaG5m6ZUdbZItVvAgc6ifoCRqErFYWGgXsaxXOwrHgm8ExixHLEsG?=
 =?us-ascii?Q?pbRKskeESh6HKnJUJW3clvvj9cDl51565bunqnpXBgDCFilOCdXWAKBTa10N?=
 =?us-ascii?Q?6lsU7lSd0O/rIGhGSXJ2cdX8Vc5TN4A15mN5zCC10JEQEVz1PXLmmAoMrh/H?=
 =?us-ascii?Q?QDcRNJ+9OXExCDccUgiSIHX/nDtPdw1qAM7T5hbhLSr90puNMpxkBrvZqNyk?=
 =?us-ascii?Q?LXm393ukoT/Dj2fOD42XPgYW423HwloUSTJKQb5NTASzhWFbEZA5wL5LsCIX?=
 =?us-ascii?Q?yXxqKT8iTiFmAfRpWmjfBCgdV99OnTc4Mlu7D1hv13fXmHZ1wHSYb7rO8xD3?=
 =?us-ascii?Q?Twd72AhEW4sqXS+knuA50Y1fotXPwwDWs4plZZcoR+KSG+a1C8kwt8msThIP?=
 =?us-ascii?Q?BT0SU8+YTmwa/JPW2EoH1s3SgmPGe8rhRcehgt0PdB8FQ8JUHfn2g0lWTMIz?=
 =?us-ascii?Q?4F9f0nS7HUEW82GktOHRJ8n19m9UKBUgLLd8mu1qtIsg44O7n4425ESHU3rM?=
 =?us-ascii?Q?3hOrP860Jf/rILwdP8yejK22uB/hrQOGuJOA0/oEg9u3uyK85Nu8f7+QuL6A?=
 =?us-ascii?Q?KlkaAN+1O1bwLVOC3w8FiSSN9nFc31Zu8fS52EJ4Zx7znKWl5uJm5H4Ku8IP?=
 =?us-ascii?Q?n/GveKeiRIaDzUJr3Yafm3u+Un8rbHKSz8urCr+OkLFPKPgiJ0GoRYkzvn94?=
 =?us-ascii?Q?Kp7ZlW6HqxX7pS9840cJw8KS95yMu08ZGp0XjRgoh0XxTbnmWkEKcQXmSJVn?=
 =?us-ascii?Q?MTmlJXXw1yO5tri72Z9z2e7zKuHCxO9JSyF5zzhlLSSTSQxK+ArDpqAXdtY0?=
 =?us-ascii?Q?WkZJcW+VB8wQ6Z8WLRREiTBTFMsdOSCm5v4U+czM8bUcgvTZO2hGrrlS4Qbh?=
 =?us-ascii?Q?LPTuuEE7Ak/tuLawE4aq5llThP2so+wVFfIBZc/vKA+B8tWuc7erLZUGXkj8?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QLb/T60rlq3c00nbUxH0gS2YSA9torgsns2LbyQbhQBXvtplIksEiINo+jTn0S1clxlord96/h5pDoB2+tDGTHIPCok0NgbkWGPxP+qXeAVefBnwdi2DRSzbt03lOeEzmZaoZCrh087VkEiO8O5WyYMFRcAymaGlDvQXoiCLrYB2dNzcKXZCdh1vSR9gQJdNjfkDEl5jJRodWSOJI4QastIHVs6FMzci25nXdiRCMQ1Goi35JT5nT+/udBuXm55Pwtcfp0vNw2NcAuHpsjTy+EAmepyuY6BasuUopQwkIQ/KUMAv+zUU76ywwBGmPjVOkQUPOCj+/oWGLERp/gWDBwxkTMSE9H5SULD/3YKQpflKoAhziVllBmO0Ab1rlFn7zahC+jCt/aokF0KwQaa8zebzSfKdenuFLPG4zvtJbqF1YUHcXRNc7LQ1Wy7js39YhCOFuqEpfNo0d38vyDOX3FdzGXLsrpvb+QE6TFshyWo1C5LnwZqinMksECuvSKsr3zh3c1w42Km5+x/CzhDxslatZ7u8BkCD/AatvNa2ZDdciV5kdRufjII2W7Iy8Giv6xTvUdhcSiPWcRkdLWelPA849MDOLuy3cPjAha3MQhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0d8d67-a826-44ee-f6e2-08de20a783a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:37.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwejZl9Hc977NbDKEiUrWaTy1pUlxEKp5Gwm38NxnbuymwBWQpPOR0hbNFGo/U9tlbgcM1+dsXuBMGPW9Jf9gcElJLgnop2LoDWV3iJgRWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100190
X-Proofpoint-GUID: flJWBB3yzAbLDEja1JPXhqlucgXzB25v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NCBTYWx0ZWRfXzs4F8LxndeUR
 b4DX+m/bJlTUz/TRWKmUKv/KVnHCDM2obxqg/bJqC6lY5HtovYNwXhkyGnbXWf3s1xv76UcDOkC
 7yrHAY6KA9qPep1YawLPLuVREuxwhfYzVabikjD/Z6eNMTu2xYozufppJXesAd+YS7y7aSkb7Id
 FrikQuonGj0LNB+DyjOKVMslM2x8Hud9ZCtQO51qvIRnl2bRw4e9u0AFyS2AIQ78BX0CtEykDTG
 tLIKwDR7jwFLgTe+kX6Z20uZ8cvjz9SdBUrLnvy/YXUwIiKl7t2N3/84uuWIunJMkNGvefR0I3I
 fggANbpWrCpDYnQl1B2O47gLtmf3Xq3ktGJ5WuMDintGojJT6SigGH/RbjXtwmB0a7hrh7aQ78l
 2VaqufOFRy54TGqEZbERfLWh44/PWA==
X-Proofpoint-ORIG-GUID: flJWBB3yzAbLDEja1JPXhqlucgXzB25v
X-Authority-Analysis: v=2.4 cv=YN+SCBGx c=1 sm=1 tr=0 ts=69126576 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=G2-HCQ5rFf2ZBQrTsY8A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

There's an established convention in the kernel that we treat leaf page
tables (so far at the PTE, PMD level) as containing 'swap entries' should
they be neither empty (i.e. p**_none() evaluating true) nor present
(i.e. p**_present() evaluating true).

However, at the same time we also have helper predicates - is_swap_pte(),
is_swap_pmd() - which are inconsistently used.

This is problematic, as it is logical to assume that should somebody wish
to operate upon a page table swap entry they should first check to see if
it is in fact one.

It also implies that perhaps, in future, we might introduce a non-present,
none page table entry that is not a swap entry.

This series resolves this issue by systematically eliminating all use of
the is_swap_pte() and is swap_pmd() predicates so we retain only the
convention that should a leaf page table entry be neither none nor present
it is a swap entry.

We also have the further issue that 'swap entry' is unfortunately a really
rather overloaded term and in fact refers to both entries for swap and for
other information such as migration entries, page table markers, and device
private entries.

We therefore have the rather 'unique' concept of a 'non-swap' swap entry.

This series therefore introduces the concept of 'software leaf entries', of
type softleaf_t, to eliminate this confusion.

A software leaf entry in this sense is any page table entry which is
non-present, and represented by the softleaf_t type. That is - page table
leaf entries which are software-controlled by the kernel.

This includes 'none' or empty entries, which are simply represented by an
zero leaf entry value.

In order to maintain compatibility as we transition the kernel to this new
type, we simply typedef swp_entry_t to softleaf_t.

We introduce a number of predicates and helpers to interact with software
leaf entries in include/linux/leafops.h which, as it imports swapops.h, can
be treated as a drop-in replacement for swapops.h wherever leaf entry
helpers are used.

Since softleaf_from_[pte, pmd]() treats present entries as they were
empty/none leaf entries, this allows for a great deal of simplification of
code throughout the code base, which this series utilises a great deal.

We additionally change from swap entry to software leaf entry handling
where it makes sense to and eliminate functions from swapops.h where
software leaf entries obviate the need for the functions.

v3:
* Propagated tag (thanks SJ! :)
* Fixed up comments as per Mike.
* Fixed is_marker issue as per Lance.
* Fixed issue with softleaf_from_pte() as per Kairiu.
* Fixed comments as per Lance.
* Fixed comments as per Kairiu.
* Fixed missing softleaf_is_device_exclusive() kdoc in patch 2.
* Updated softleaf_from_pmd() to correct the none case like the PTE case.
* Fixed the rather unusual generic_max_swapfile_size() function which, at
  least on x86-64, generates an entirely invalid PTE entry (an empty one)
  then treats it as if it were a swap entry. We resolve this by generating
  this value manually.

v2:
* Folded all fixpatches into patches they fix.
* Added Vlasta's tag to patch 1 (thanks!)
* Renamed leaf_entry_t to softleaf_t and leafent_xxx() to softleaf_xxx() as
  a result of discussion between Matthew, Jason, David, Gregory & myself to
  make clearer that we abstract the concept of a software page table leaf
  entry.
* Updated all commit messages to reference softleaves.
* Updated the kdoc comment describing softleaf_t to provide more detail.
* Added a description of softleaves to the top of leafops.h.
https://lore.kernel.org/all/cover.1762621567.git.lorenzo.stoakes@oracle.com/

non-RFC v1:
* As part of efforts to eliminate swp_entry_t usage, remove
  pte_none_mostly() and correct UFFD PTE marker handling.
* Introduce leaf_entry_t - credit to Gregory for naming, and to Jason for
  the concept of simply using a leafent_*() set of functions to interact
  with these entities.
* Replace pte_to_swp_entry_or_zero() with leafent_from_pte() and simply
  categorise pte_none() cases as an empty leaf entry, as per Jason.
* Eliminate get_pte_swap_entry() - as we can simply do this with
  leafent_from_pte() also, as discussed with Jason.
* Put pmd_trans_huge_lock() acquisition/release in pagemap_pmd_range()
  rather than pmd_trans_huge_lock_thp() as per Gregory.
* Eliminate pmd_to_swp_entry() and related and introduce leafent_from_pmd()
  to replace it and further propagate leaf entry usage.
* Remove the confusing and unnecessary is_hugetlb_entry_[migration,
  hwpoison]() functions.
* Replace is_pfn_swap_entry(), pfn_swap_entry_to_page(),
  is_writable_device_private_entry(), is_device_exclusive_entry(),
  is_migration_entry(), is_writable_migration_entry(),
  is_readable_migration_entry(), is_readable_exclusive_migration_entry()
  and pfn_swap_entry_folio() with leafent equivalents.
* Wrapped up the 'safe' behaviour discussed with Jason in
  leafent_from_[pte, pmd]() so these can be used unconditionally which
  simplifies things a lot.
* Further changes that are a consequence of the introduction of leaf
  entries.
https://lore.kernel.org/all/cover.1762171281.git.lorenzo.stoakes@oracle.com/

RFC:
https://lore.kernel.org/all/cover.1761288179.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (16):
  mm: correctly handle UFFD PTE markers
  mm: introduce leaf entry type and use to simplify leaf entry logic
  mm: avoid unnecessary uses of is_swap_pte()
  mm: eliminate is_swap_pte() when softleaf_from_pte() suffices
  mm: use leaf entries in debug pgtable + remove is_swap_pte()
  fs/proc/task_mmu: refactor pagemap_pmd_range()
  mm: avoid unnecessary use of is_swap_pmd()
  mm/huge_memory: refactor copy_huge_pmd() non-present logic
  mm/huge_memory: refactor change_huge_pmd() non-present logic
  mm: replace pmd_to_swp_entry() with softleaf_from_pmd()
  mm: introduce pmd_is_huge() and use where appropriate
  mm: remove remaining is_swap_pmd() users and is_swap_pmd()
  mm: remove non_swap_entry() and use softleaf helpers instead
  mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
  mm: eliminate further swapops predicates
  mm: replace remaining pte_to_swp_entry() with softleaf_from_pte()

 MAINTAINERS                   |   1 +
 arch/s390/mm/gmap_helpers.c   |  20 +-
 arch/s390/mm/pgtable.c        |  12 +-
 fs/proc/task_mmu.c            | 294 +++++++++-------
 fs/userfaultfd.c              |  95 +++---
 include/asm-generic/hugetlb.h |   8 -
 include/linux/huge_mm.h       |  48 ++-
 include/linux/hugetlb.h       |   2 -
 include/linux/leafops.h       | 619 ++++++++++++++++++++++++++++++++++
 include/linux/migrate.h       |   2 +-
 include/linux/mm_inline.h     |   6 +-
 include/linux/mm_types.h      |  25 ++
 include/linux/swapops.h       | 273 +--------------
 include/linux/userfaultfd_k.h |  33 +-
 mm/damon/ops-common.c         |   6 +-
 mm/debug_vm_pgtable.c         |  86 +++--
 mm/filemap.c                  |   8 +-
 mm/hmm.c                      |  41 ++-
 mm/huge_memory.c              | 263 ++++++++-------
 mm/hugetlb.c                  | 165 ++++-----
 mm/internal.h                 |  20 +-
 mm/khugepaged.c               |  33 +-
 mm/ksm.c                      |   6 +-
 mm/madvise.c                  |  28 +-
 mm/memory-failure.c           |   8 +-
 mm/memory.c                   | 150 ++++----
 mm/mempolicy.c                |  25 +-
 mm/migrate.c                  |  45 +--
 mm/migrate_device.c           |  24 +-
 mm/mincore.c                  |  25 +-
 mm/mprotect.c                 |  59 ++--
 mm/mremap.c                   |  13 +-
 mm/page_table_check.c         |  33 +-
 mm/page_vma_mapped.c          |  65 ++--
 mm/pagewalk.c                 |  15 +-
 mm/rmap.c                     |  17 +-
 mm/shmem.c                    |   7 +-
 mm/swap_state.c               |  12 +-
 mm/swapfile.c                 |  22 +-
 mm/userfaultfd.c              |  53 +--
 40 files changed, 1582 insertions(+), 1085 deletions(-)
 create mode 100644 include/linux/leafops.h

--
2.51.0

