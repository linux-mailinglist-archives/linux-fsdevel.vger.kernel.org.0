Return-Path: <linux-fsdevel+bounces-66763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4348C2BB67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52CB3BCAAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935B30FF3A;
	Mon,  3 Nov 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o+Rea1EQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A60B6A3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096F30DD10;
	Mon,  3 Nov 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173254; cv=fail; b=oAW5mhg0T8g5GOztkUa0pqnz8oTX/nEOKf5PqTi9vP0yks2FLe6sEnVctaNVQqGFRoNU1FxapgDn2Otm2a2BNYUBILG1y3zqXJ58oTQsgOqfHXJDCy0wUiYa2SWOLhEWwbExMlEk2IcOh574kb9mRENESbeUoXIFiOG3fPoKQi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173254; c=relaxed/simple;
	bh=sboUBQ9sciNw2B2GbAhmGC7i+jR0TEQkIu1UlnvxzyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlpmE/EVKVQkNM9l8tcy2D2ae8MeZDmLr9rt/Wl2yn3MMB1wJOxDmJNbgCg6qVj1FXjocKVuMKJACqKORrzWeL9vSTkT4m7VxHZn7z68toKeKFPTGUtFNrAsFwSfXkxOL9OtWTc9gvvRM9Y74T7G+Z67+aGoXGA5Z9ZfvHqARqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o+Rea1EQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A60B6A3R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CP2F0011016;
	Mon, 3 Nov 2025 12:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E0whp4gfpwladQozAl95xCPKz4HIiPD0+Gt7POR0uIU=; b=
	o+Rea1EQvhnuJDtBPSf6KZcAgqRvOYvPcmCJI9gRMx7h5qLVAdxSK+UzCT3fIbvC
	us2dRCpjboIy2XSIQzXY7oaKqH8ADGeL3OsQAbOAF5K98Cq6Q0ewXTel4AAerF7F
	SsFlmFiQuuinpT7amCaUtj9txTXfuXv6002Q4hPtci8z9Y0WpnAZiShcNG8svwdb
	w843qfwmQFJ58Mfu8zvVvudsVnRnNyKA46DyMImRuLGcEIPoFs3aq7998Md5JBhO
	cRod/AZJKJTZ7QYPxZBrPKXqS65bxqHbCSMvGSrtF+eaKCFVlk/wLygzZOqvYC1N
	duIMWC5D3JoTwtJEsZfKXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vca00ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BSiuD009599;
	Mon, 3 Nov 2025 12:32:20 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbksty-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNGttSffBpV5cQv0ufLGkPa91RWzMhxqoaTcMhrDTt7JlsEQrsAI52pv6q4KgQBp4wbWJYqoe4lV/j5jS/RrvEb6KPokO+DO51Il7qRYEedAvKc4KjYQY8vJMtJWedLcn7dEn0wuqv+956FdBgh1v0z6uLHX8UNafSWa6ArQNjuOsZuoRWuUzxYDp3EI7n9+4ki65K1dt4nBRDgjy7mauAEGvtBjUSiQuVGYVA3uU55GbybMysLDy2ILoDErN41WxkJWtQu3p/B395Hnv0+xnjErux9AyBELjSMcfnwX+dUZwkyYjaC3OsjmtNvmMNiqp0KMeTc9A0zm04YfAILHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0whp4gfpwladQozAl95xCPKz4HIiPD0+Gt7POR0uIU=;
 b=CXhIRmEV/DPGjarMBJcC8kkHxD/LwEMDeCfHHA022X1xACDOA4I40h+iL4tALMHBT6yliBRu6JXMSUzmkx7BMGfBPUJonCbGmKIypODfZ9Y83zPgq7t8R9mB2l97x3THyjFI2al8IrtuTLDGpHTPAW13aGiwMCU2hZnYVIAMjRFgtAiLFjJb1hs7JKBlqe9ZiPc5WERBOkVmoA80hQUeQxE+/PIQ3LWUHaTCU443nYjArwPut9+hrP7aWnEOn6X8dGhnYL5YV52mCJ3B62IbjRa93pj1Lq866nKp36DNQDTtBmcT8Gvrmw6jKZNFkAbJtWEdoPP6Cn8brJIIjDthNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0whp4gfpwladQozAl95xCPKz4HIiPD0+Gt7POR0uIU=;
 b=A60B6A3RLBfxZVj9ScwIhZO6nyR7ODXUhbd3kYhO/HHlFdC18EZSGQ9Qe+R+vRy1ogpREYPHj0Is5eISV3bwnVqK91x4ARUtvbZHu8IcXXS83HRz7fp0YXUFKRVKbnb8Zi6v/l7dfIa+1dO9Ci2bLOTnwksCnnhDoVXpswjNK54=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:17 +0000
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
Subject: [PATCH 03/16] mm: avoid unnecessary uses of is_swap_pte()
Date: Mon,  3 Nov 2025 12:31:44 +0000
Message-ID: <8d93c62760e501cb7badd8cceb597a5af49d700c.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 5932bb4b-9275-41ac-49a7-08de1ad50670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lYROkUco8yFxRtFssXGN5wOcdKYJRDq719oI9lcCcWe7dexUkIzeIH16ajz?=
 =?us-ascii?Q?ARlWVI+e0Uryty23f/KhyacW8wnOcF6AFPfikydW7sp7jDWptjdv35GLCxWz?=
 =?us-ascii?Q?erhF94RMtDQUHejoESZ7Ld95lqPyUfEKwyZ1dxMj3575sww+kg4DYz7HwDft?=
 =?us-ascii?Q?+g+p8jWJjrXTUnsZGxeE70vDsSRAQa3HOnByiFskPCkIymm6nGTXBly+2wHh?=
 =?us-ascii?Q?+02+viDVAaW43WEDKpnFfoyAQO+pONPgtBwdshvKW1SJvGQtKrZMX4fJLvrw?=
 =?us-ascii?Q?4WzOjd+ENSeqYbQX1iUUOAbOmshldSJB3aGGS9ewYs+gtvrLtBz6BOAB1l4h?=
 =?us-ascii?Q?Bq8CTJ5fcXDumH7p5S13Wwp9HxxvNV2wt6Qmz7GO8BNV7OW+I9BmcH5n9J5Z?=
 =?us-ascii?Q?neyBInJ4WUsiJWyq2nHIgwNgOyIVZ7gmyRFsxCmTsS6xSdQOjxR8cPbiItOL?=
 =?us-ascii?Q?WImEXN0YJRYJNIyGgzypZygykVg24Gl8e1iob9kg4H1xGhRaQ2vuviS9ICmf?=
 =?us-ascii?Q?pkpfh52hdgLZ6WXxbFy69L99XUvfAcEwmkGOuZbbgCBvyCPiTIWT+6vInp0D?=
 =?us-ascii?Q?58uVvFVJndyWTFbHcirE7ciZsrRB2JALrqWILA6eWW7Dm2pkCEQ0GxJVU/+I?=
 =?us-ascii?Q?yUdGqm+soiP0T722diRo/KwsAa5qA/Ai0UoGOuSwGL0HW/TfwUfbav8MNXn4?=
 =?us-ascii?Q?KTg9pK78140ShMCvkXRiRw+pSgX+XjfFgnNM8MyhEPBXHbiSqX8YZG4Cb0qB?=
 =?us-ascii?Q?wG7AUTmz6oqaCnFL36QsJgOSYxhCtQQclRtRlurcwfz48jNk9gkl9BfasFgm?=
 =?us-ascii?Q?GwapuN8FxnfBdnJhjIxduW6Gh47b029ItjEMuStxEwIY3tjRrEfgHzx0TQ7f?=
 =?us-ascii?Q?S0S5Wa6yVcq8PYVWPpjVm+gVktITif3OBPkHjh3copua/9pvloKN1HLL5QqR?=
 =?us-ascii?Q?bGvv7D0CNbpHF6lgf5BPDOzhvdHOlPRUf09Cw5TbTywVaoi562gSUQs7X7ZG?=
 =?us-ascii?Q?Kn2iAA4CQ6DzSTwq+zgQcZnEYaU/f38jwSMidktj6q+f4341cLUm1rsyr+SJ?=
 =?us-ascii?Q?RDFHFDXWIx2Z7qhvg56wqyOg3sO1hdlhA+SkBJmeYCcCWiiK4ScWvnRi0mzr?=
 =?us-ascii?Q?BpRoTaOIJPWqYS6mBzbBZkKeVy2TsYqozVEUfKmxJDus9mPo2CsLscn2vWX2?=
 =?us-ascii?Q?T+Jss4QtlQCE9fq4uuE1TdfuyTZ9G3echIBfxbHcL/8XYCT11iKU/Li5oC6w?=
 =?us-ascii?Q?bsMfdJKCMjwB4r3Vtq6HT5fpX1FFpsITGxlv5IixF+nW+r9y/C4E1MoPV0GO?=
 =?us-ascii?Q?5PlPRf36WZs98HRn0QgaC/ZI53ugcyNHgCfdLFV4WF+aVlTlZw9XUV7P4Rnp?=
 =?us-ascii?Q?30ectoSifdcED1doVhVl4i5eQL21RxBVhdw4h+STWmdo7XU+JxmLU2nsK6Nl?=
 =?us-ascii?Q?8x99PZ1KCHRkWf8g1d5tbdx3ChLS1FrF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNPsTvD8LyyIw3YQDsJAudbwaQoF3W2aoiypJGikT3fd82ehj+du3Ruk5iL8?=
 =?us-ascii?Q?cEFOewi6ha0lxjRUzXDelgAueZhd5HvtRHhRpHim7+n0YeKGET3MSM/IAEa6?=
 =?us-ascii?Q?ZFcVIYYPyGPZZco6EUt9rQMtiNHmP68CSwyMFhYlgswFT9yHWyRAnDf2/T2i?=
 =?us-ascii?Q?qEGJk+h+Os8HIp4QHNo4aQp29p7EkIUiZ5Uy8IyyOLOR21AY+Xkk2Fvur0k4?=
 =?us-ascii?Q?YaN34UvpfYas2fKsZdXEF00d3CvX65mAVO0hlEbd5N+MCBMbKJ0xuTJ5AJPQ?=
 =?us-ascii?Q?Mw34sy/9yJu0/PCD/AzainvzlHYUQMrMnAf6NoEv//JFjfaC/lT6YAc0GVfX?=
 =?us-ascii?Q?OMbPNwYzvhAOcFP5xGwoPFLaZIjnaDqclMxzi071VJCpJjxQTeXQWvbJwqHu?=
 =?us-ascii?Q?X2lsDffXC2nrP2FDcx87E5rSVC9gyRXMe5K7PFKenZYGelCO+CI9jfafGhGq?=
 =?us-ascii?Q?JrQXH9E1xTs3iyF1wfAqhKxk1y6XtQZN6aMG03OzfSr7R4lNiDkx9IjOS/Nn?=
 =?us-ascii?Q?T9IZrC1qWRHAtpJvhcQgpCHaRLKUlyUhyHgZ9arG9jrUHuPyiia1K4hM1CYF?=
 =?us-ascii?Q?ahh69tdqhzN2twffieIuK/dpW/mU5pnLeJs/H0mY+UU82xfy2q7pEPlxjy7s?=
 =?us-ascii?Q?1o09OzlPDZ3iU6Wjs3VAQtbtK2ocM5gH7dSpIwa7Jes3Q6gKiAlymIb7OzeE?=
 =?us-ascii?Q?6UiTj9hs8ctq42VUqL3NJGKpopLYDQDJX68AVArmEo04G67RfqZWYrtWMeI+?=
 =?us-ascii?Q?o/4HE6vZJRaZqDZ76DiimEjJikoRKUn+tcaIQG9t/5JzoCvCIPXzYsKfig3a?=
 =?us-ascii?Q?HI3pBlCQbFi1gs2RVIPTrP1OKnST0xpUhbTaGJjztAd2GL3Vu0A6CwcRPCl0?=
 =?us-ascii?Q?buBBkN2v5oVmFXUxSHnLavqj0DIkK0bYYsn8m2C6NmPLhL5KhAag2G8EbXJ2?=
 =?us-ascii?Q?tvMFuPReigENUXE54YHVJm3Nu5/CEap77S/Cw1F4bfqqYs/puXfqaD/q3rYB?=
 =?us-ascii?Q?ftFGI1rudZi03SWEVfStKkBYUFpoI06lc7+Zr3hwfOtG7CFaT/vFdNfFGmYy?=
 =?us-ascii?Q?HxsFpT8GcE8YItLIINwIJmzPIJew3BI0tADHzlhf8Zhn91LHE7Pumhv6DMH0?=
 =?us-ascii?Q?tWXieVIXlFHi3oQ96YcLUyjovk9Vo7PwuvaA7Ax9vRt3zC+NpIF3P410QeCg?=
 =?us-ascii?Q?wNdZrVaxClINsdAwLyE6iAROLmjR9KKl4TatRyHH3Yb7qFxD/iOFeS2WIyfe?=
 =?us-ascii?Q?iAqfP4h0JrFZDr1BoXhujpPJX1uVWPGyhNG6sPJvkGvUO5AgaIgSLkKpkGSm?=
 =?us-ascii?Q?kk25wlzDKiAfur7a/Cc+8R8SahGXjn/4ocBNNQpE92Yi3sWrlPxCjS8/ys12?=
 =?us-ascii?Q?I+TJBM15WN2p6zbSDaSxRCmmjKN0H+I/ncGW37zFhJJ14yCH5UrmhnR+yxrn?=
 =?us-ascii?Q?jrN1KzDRci8+3mvQuOc2cWpWyHEeFT96IpUg1dS04GjyOB+Um/hJ8VH4ruB1?=
 =?us-ascii?Q?C7qFt/mTA3TrhCLQ1ZA8lO9Q3OzgpHJRAo0GFZMP3wvJF1aQkrYF72dr0d9V?=
 =?us-ascii?Q?wuCpsao3MPFp3tK3Eo3mO5m5DzsURybtGyVfeO+ZiWg+fadnpAUh9iSgW7w1?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/V2hB3dEkr9Is/B1+o/da7G3pf+ZpguWcNhU1BxqviotP5tiW4qIOOl/pStIBiCy4g/QJaJnFr5/noqpHxSHf/vnv8EdjHPg/CPnXXnF65BUOrfb8u4IbeKTDYA1c4ShlhSfdRvSUnPDn4sNsz4HlXVbrqnmSBhbjKnIwWfVRMhnvhg34skaH1pmEy5dg7NDB6fd4iEWlfXpL3wrGWiSmJawBHNJ5HT9/TeQer5lqDjilnUDpukDNYbJCJb7CBkluzhLHXVPl4nyBohkzYa/NT2c/Un8u71zHLBlunaDZN1MFi4RhOkYRbs6e0GlF5nGhyy7H9Eio05JuTBgfrsG86G/gWkQXgpZ9N3SfMoa9kMKvHpN/A+oMkV+YdcQ50cP+2IYwXveua+rr0S8YRXEvScjy13MkI312WeofUsDCZWI+5njK5t9n49hAn1jn8AxWFmEMaFsB/QPcUIq2hvVg5sotZpoy2sPTC6Ii3aKGJTSwEB9jbmWD9chCmBl9mUzkbQwSKQNnbalmzlovFyAAzx5TBgN9Fd498KV2H4zcfxt0qLurrPJLsRaq8gxKFTqPc6jJ0BDDLsTFM43xy0eD9428LX5809w5WhfRvkAb1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5932bb4b-9275-41ac-49a7-08de1ad50670
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:17.3305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usINuvg4WC69rK3qLBEixbhYAdPwqbW/WRH7CLgdqg9F29vbD7W2FIaDvkwGHOSm77KoxFUQ9BLAMuAdajJZw3rJMeqm/X+Xsije0Bj0VqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-GUID: 2Rw1G7RpxDI7BJ45vy9BJ3zFUqIDdHQF
X-Authority-Analysis: v=2.4 cv=PPsCOPqC c=1 sm=1 tr=0 ts=6908a0d4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=360PBzQsUBXz8B3xgqMA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: 2Rw1G7RpxDI7BJ45vy9BJ3zFUqIDdHQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMyBTYWx0ZWRfXzZcIZVRhmXM7
 rPLtBaAn+6g2Kpjmhb1IiqXps42WH8epS5HOY1j0bST79uewqrDY27eulNg1hHcsA8WKEmlKcnT
 l9MHTzyGD7J0e1dIk2I8tH/9DOfDHPsLK0wTgEqCJMZLIqaeToa3HyiQPBMy2SF0qZLzQ7G6NJ2
 JXH6GPb8FO+QzK+DI6R5aF1FeXxlrcquzXclsP2GwWNGz6mPMbz++zcubOd5dg6ohxDGbp9oznm
 I67a3PAQFV6sS746niMqr3RRGb3QXXhFw6lvoYuRyATTXp01arfV0B7tSwrUl79S6BzGIqA6ito
 KhqBxa4D8MMB4Fvb89vlUMgssbnGmubiMLtne+YPUz3L1vccRxsASs3Vgv2tDwHB09AfMhhHajt
 h/6ar0Am97b5bsXoiGgEjdYZygaRT85+B7NlEY5mmP9nntM9ATc=

There's an established convention in the kernel that we treat PTEs as
containing swap entries (and the unfortunately named non-swap swap entries)
should they be neither empty (i.e. pte_none() evaluating true) nor present
(i.e. pte_present() evaluating true).

However, there is some inconsistency in how this is applied, as we also
have the is_swap_pte() helper which explicitly performs this check:

	/* check whether a pte points to a swap entry */
	static inline int is_swap_pte(pte_t pte)
	{
		return !pte_none(pte) && !pte_present(pte);
	}

As this represents a predicate, and it's logical to assume that in order to
establish that a PTE entry can correctly be manipulated as a swap/non-swap
entry, this predicate seems as if it must first be checked.

But we instead, we far more often utilise the established convention of
checking pte_none() / pte_present() before operating on entries as if they
were swap/non-swap.

This patch works towards correcting this inconsistency by removing all uses
of is_swap_pte() where we are already in a position where we perform
pte_none()/pte_present() checks anyway or otherwise it is clearly logical
to do so.

We also take advantage of the fact that pte_swp_uffd_wp() is only set on
swap entries.

Additionally, update comments referencing to is_swap_pte() and
non_swap_entry().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  3 +--
 mm/hugetlb.c                  |  6 ++---
 mm/internal.h                 |  6 ++---
 mm/khugepaged.c               | 29 +++++++++++----------
 mm/migrate.c                  |  2 +-
 mm/mprotect.c                 | 43 ++++++++++++++----------------
 mm/mremap.c                   |  7 +++--
 mm/page_table_check.c         | 13 ++++++----
 mm/page_vma_mapped.c          | 31 +++++++++++-----------
 10 files changed, 104 insertions(+), 85 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index adac6c42749d..9914febdb60b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1017,7 +1017,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
 		present = true;
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_none(ptent)) {
+		smaps_pte_hole_lookup(addr, walk);
+	} else {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (!non_swap_entry(swpent)) {
@@ -1038,9 +1040,6 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 				present = true;
 			page = pfn_swap_entry_to_page(swpent);
 		}
-	} else {
-		smaps_pte_hole_lookup(addr, walk);
-		return;
 	}
 
 	if (!page)
@@ -1611,6 +1610,9 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	 */
 	pte_t ptent = ptep_get(pte);
 
+	if (pte_none(ptent))
+		return;
+
 	if (pte_present(ptent)) {
 		pte_t old_pte;
 
@@ -1620,7 +1622,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1923,6 +1925,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	struct page *page = NULL;
 	struct folio *folio;
 
+	if (pte_none(pte))
+		goto out;
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1932,8 +1937,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		swp_entry_t entry;
+
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
@@ -1941,6 +1947,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		entry = pte_to_swp_entry(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
+
 			/*
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
@@ -1969,6 +1976,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
+
+out:
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
@@ -2310,12 +2319,16 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 					   struct vm_area_struct *vma,
 					   unsigned long addr, pte_t pte)
 {
-	unsigned long categories = 0;
+	unsigned long categories;
+
+	if (pte_none(pte))
+		return 0;
 
 	if (pte_present(pte)) {
 		struct page *page;
 
-		categories |= PAGE_IS_PRESENT;
+		categories = PAGE_IS_PRESENT;
+
 		if (!pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2329,10 +2342,11 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		leaf_entry_t entry;
 
-		categories |= PAGE_IS_SWAPPED;
+		categories = PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2360,12 +2374,12 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		old_pte = ptep_modify_prot_start(vma, addr, pte);
 		ptent = pte_mkuffd_wp(old_pte);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
-		ptent = pte_swp_mkuffd_wp(ptent);
-		set_pte_at(vma->vm_mm, addr, pte, ptent);
-	} else {
+	} else if (pte_none(ptent)) {
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
+	} else {
+		ptent = pte_swp_mkuffd_wp(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
 
@@ -2434,6 +2448,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pte_none(pte))
+		return categories;
+
 	/*
 	 * According to pagemap_hugetlb_range(), file-backed HugeTLB
 	 * page cannot be swapped. So PAGE_IS_FILE is not checked for
@@ -2441,6 +2458,7 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 	 */
 	if (pte_present(pte)) {
 		categories |= PAGE_IS_PRESENT;
+
 		if (!huge_pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (!PageAnon(pte_page(pte)))
@@ -2449,8 +2467,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		categories |= PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (pte_swp_soft_dirty(pte))
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 983c860a00f1..96b089dff4ef 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -441,9 +441,8 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 static inline bool pte_swp_uffd_wp_any(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	if (!is_swap_pte(pte))
+	if (pte_present(pte))
 		return false;
-
 	if (pte_swp_uffd_wp(pte))
 		return true;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cc7db8fd86db..2e797abdee04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5798,13 +5798,13 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
-	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
+	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte)) {
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
-	else {
+	} else {
 		if (need_clear_uffd_wp) {
 			if (pte_present(pte))
 				pte = huge_pte_clear_uffd_wp(pte);
-			else if (is_swap_pte(pte))
+			else
 				pte = pte_swp_clear_uffd_wp(pte);
 		}
 		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
diff --git a/mm/internal.h b/mm/internal.h
index 116a1ba85e66..9465129367a4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -325,8 +325,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry
  * @delta: The direction and the offset we are moving; forward if delta
  *	 is positive; backward if delta is negative
  *
@@ -352,8 +351,7 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 /**
  * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry.
  *
  * Increments the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f6ed1072ed6e..a97ff7bcb232 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,7 +1019,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		}
 
 		vmf.orig_pte = ptep_get_lockless(pte);
-		if (!is_swap_pte(vmf.orig_pte))
+		if (pte_none(vmf.orig_pte) ||
+		    pte_present(vmf.orig_pte))
 			continue;
 
 		vmf.pte = pte;
@@ -1276,7 +1277,19 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (is_swap_pte(pteval)) {
+		if (pte_none_or_zero(pteval)) {
+			++none_or_zero;
+			if (!userfaultfd_armed(vma) &&
+			    (!cc->is_khugepaged ||
+			     none_or_zero <= khugepaged_max_ptes_none)) {
+				continue;
+			} else {
+				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				goto out_unmap;
+			}
+		}
+		if (!pte_present(pteval)) {
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
@@ -1296,18 +1309,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none_or_zero(pteval)) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
diff --git a/mm/migrate.c b/mm/migrate.c
index ceee354ef215..862b2e261cf9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -492,7 +492,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	pte = ptep_get(ptep);
 	pte_unmap(ptep);
 
-	if (!is_swap_pte(pte))
+	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index d425be97db51..ac2cd613f76e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -297,7 +297,26 @@ static long change_pte_range(struct mmu_gather *tlb,
 				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
 					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
 			pages += nr_ptes;
-		} else if (is_swap_pte(oldpte)) {
+		} else if (pte_none(oldpte)) {
+			/*
+			 * Nobody plays with any none ptes besides
+			 * userfaultfd when applying the protections.
+			 */
+			if (likely(!uffd_wp))
+				continue;
+
+			if (userfaultfd_wp_use_markers(vma)) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect a none pte, because even if the
+				 * pte is none, the page/swap cache could
+				 * exist.  Doing that by install a marker.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   make_pte_marker(PTE_MARKER_UFFD_WP));
+				pages++;
+			}
+		} else  {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
 
@@ -358,28 +377,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
-		} else {
-			/* It must be an none page, or what else?.. */
-			WARN_ON_ONCE(!pte_none(oldpte));
-
-			/*
-			 * Nobody plays with any none ptes besides
-			 * userfaultfd when applying the protections.
-			 */
-			if (likely(!uffd_wp))
-				continue;
-
-			if (userfaultfd_wp_use_markers(vma)) {
-				/*
-				 * For file-backed mem, we need to be able to
-				 * wr-protect a none pte, because even if the
-				 * pte is none, the page/swap cache could
-				 * exist.  Doing that by install a marker.
-				 */
-				set_pte_at(vma->vm_mm, addr, pte,
-					   make_pte_marker(PTE_MARKER_UFFD_WP));
-				pages++;
-			}
 		}
 	} while (pte += nr_ptes, addr += nr_ptes * PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/mremap.c b/mm/mremap.c
index 7c21b2ad13f6..62b6827abacf 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -158,6 +158,9 @@ static void drop_rmap_locks(struct vm_area_struct *vma)
 
 static pte_t move_soft_dirty_pte(pte_t pte)
 {
+	if (pte_none(pte))
+		return pte;
+
 	/*
 	 * Set soft dirty bit so we can notice
 	 * in userspace the ptes were moved.
@@ -165,7 +168,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
@@ -294,7 +297,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			if (need_clear_uffd_wp) {
 				if (pte_present(pte))
 					pte = pte_clear_uffd_wp(pte);
-				else if (is_swap_pte(pte))
+				else
 					pte = pte_swp_clear_uffd_wp(pte);
 			}
 			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 4eeca782b888..43f75d2f7c36 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -185,12 +185,15 @@ static inline bool swap_cached_writable(swp_entry_t entry)
 	       is_writable_migration_entry(entry);
 }
 
-static inline void page_table_check_pte_flags(pte_t pte)
+static void page_table_check_pte_flags(pte_t pte)
 {
-	if (pte_present(pte) && pte_uffd_wp(pte))
-		WARN_ON_ONCE(pte_write(pte));
-	else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
-		WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
+	if (pte_present(pte)) {
+		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
+	} else if (pte_swp_uffd_wp(pte)) {
+		const swp_entry_t entry = pte_to_swp_entry(pte);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e0560cc1ce18..4597a281356d 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		    spinlock_t **ptlp)
 {
+	bool is_migration;
 	pte_t ptent;
 
 	if (pvmw->flags & PVMW_SYNC) {
@@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		return !!pvmw->pte;
 	}
 
+	is_migration = pvmw->flags & PVMW_MIGRATION;
 again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
@@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 
 	ptent = ptep_get(pvmw->pte);
 
-	if (pvmw->flags & PVMW_MIGRATION) {
-		if (!is_swap_pte(ptent))
+	if (pte_none(ptent)) {
+		return false;
+	} else if (pte_present(ptent)) {
+		if (is_migration)
 			return false;
-	} else if (is_swap_pte(ptent)) {
+	} else if (!is_migration) {
 		swp_entry_t entry;
+
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
 		 *
@@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
-	} else if (!pte_present(ptent)) {
-		return false;
 	}
 	spin_lock(*ptlp);
 	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
@@ -113,21 +116,17 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 			return false;
 
 		pfn = leafent_to_pfn(entry);
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t entry;
+	} else if (pte_present(ptent)) {
+		pfn = pte_pfn(ptent);
+	} else {
+		const leaf_entry_t entry = leafent_from_pte(ptent);
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(ptent);
-		if (!is_device_private_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
-			return false;
-
-		pfn = swp_offset_pfn(entry);
-	} else {
-		if (!pte_present(ptent))
+		if (!leafent_is_device_private(entry) &&
+		    !leafent_is_device_exclusive(entry))
 			return false;
 
-		pfn = pte_pfn(ptent);
+		pfn = leafent_to_pfn(entry);
 	}
 
 	if ((pfn + pte_nr - 1) < pvmw->pfn)
-- 
2.51.0


