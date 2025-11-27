Return-Path: <linux-fsdevel+bounces-70069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C744C8FBBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A904E336E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DB2EF65B;
	Thu, 27 Nov 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qVMjurj6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vGEKkMK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841C2EA756;
	Thu, 27 Nov 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265354; cv=fail; b=ddaPDG1+FITJigU3ZcD3AeNE2wWoK3y7LmffXPn65NFiA9PGSKFXnzqZTzWZBgbne2YHFiPCID6tuCZYzl6CxxAsOyq2ZGIJf/edtV9Gggz5jD4dT6mCrXHzdGQsEBLkNH3FsAkDMxRCejWOCmA6C9VLeEgVdMvWnlIdWhOnHjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265354; c=relaxed/simple;
	bh=6fl2uBTieblfK+JN3YyAao3jNksqUFvqrN0AaOfKONI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lfgaKuxKYapd4LFmnSvFqA+JBPVWhXS6VBEA0zeTRvcKGRyw7oTMNc4r1cyUDDp6Wuk/rKXVY5aosRGWlK4bfzm0WwEU09PZJ/IOCOZczHSVF8XBBY0DxXnD/Ssm3pncfyHocr1NlNEgBvb/etM1oVG0JTUhb6qlqyth4ud+1k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qVMjurj6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vGEKkMK6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9fv5f298971;
	Thu, 27 Nov 2025 17:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RKNgsynLcW8P1cZ7hQ
	X4im33DyL/C2i96Ejm5F8qI1k=; b=qVMjurj67GuCNTlGuvTSc6f+qsyPGpZlIl
	xyBU/FV7PDcWMC6I+wUv7hze5bHvhruy4uormx4xYD257J/325wh7gmzS/as0PA4
	A9IveJXvmku7xoE6sT1TnO4Tx2nvsrb6axFJZBlQNSd0Ta6qWSfQ3QJ/zlgn0DR+
	1H3VH2g0rb+7fhnIxaDjdD0aQVPilOG6Tgbs3DSE1E++ah6xUHMU66qyUiUgzVuv
	aa4sYA/02zheiv/gT5+PY9rHTwDDWGAyicTZ0dUJjUXMsAxWW1JowqMl2nCJQvKd
	PN5gSgY4wmhyzdtRDwihCc+RDtAf57ldV+uoPfO9W0NwwFQY4djA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4apm7vgns6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 17:41:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARHHeYW032704;
	Thu, 27 Nov 2025 17:41:20 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mcgyae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 17:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQp6gpmYv+9UUjD0rsj16e7bBSHJlhF6U5md7B8EXJSjPkPTmmjcf4feEpo2tXX1XLW8k9pUD6dJxH+MyDXzvpBLJ5ffeykmO5VzE9+sUkCTTIifEyJKYD/ENRo07CWnHV/g7DDhN1tgwnAlt/yBdhYG7Pzf3Am88iV/NRjwNB2Wkf3O9zmykToT5SZCrJUn/hfgdT1re6Q8yUaP/tt7MFsgTEJwdgUpl8hI6GltBt4sLLFNvKDKZWa80ji8OlOa8mo7r1mq1vd1wbFPnI7pI/fVYd/VxFwdiorSTJ8BYG2upw8Crkf8Z3jbaJgqw6z5J5jEm1NWo3bBPduR7FqUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKNgsynLcW8P1cZ7hQX4im33DyL/C2i96Ejm5F8qI1k=;
 b=nNulPPyCDulydAxmx/1dKkS2yNRShSNYY7NGGUEoMcs/XytMmEKhYMUh2DHm5++9WV8TbVKoLl8l2y51+RBEYqfGT15hDoplnuZjGfiOgbultshZUf7RlhX4aU97H4ClK4OVNhTlR5u05XkBZwJuzrU61dRaNFUHjMf2irixQd6iEJXeRCIUz7ottVKvjqauvH0K3ZtWK/o0zGCu5Q7JzrjfVydYVbDCKQCwnYU/4ES0LSsB8IopimI2q1eFeY1Rvz7uPbz09LGyf8VckPEnEpdBzJ0gca/oPfez5B3+WHdk0rbBnXhVx1LwLw7HqYLn0VCO2PYChBWy0MhsT9Qx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKNgsynLcW8P1cZ7hQX4im33DyL/C2i96Ejm5F8qI1k=;
 b=vGEKkMK6FwjEHKfJ1TvbEjHIqinD4AbbZID8dFJ9SIJstQLZZG+BcoX8XxNOm5C1K6AdwPmY7kBlGk8AiH6cAa+Sx3FsJW15aAPYWlitrbYNqrruTlYk08fD5bY4ukeJTtiemgUytwttxQwrW4aOgKHmkoPiVxDNjUCMGX8TljE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6109.namprd10.prod.outlook.com (2603:10b6:8:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 17:41:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 17:41:16 +0000
Date: Thu, 27 Nov 2025 17:41:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3 14/16] mm: remove is_hugetlb_entry_[migration,
 hwpoisoned]()
Message-ID: <aae888f2-e826-42ad-a35f-dbcb15fd4126@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <0e92d6924d3de88cd014ce1c53e20edc08fc152e.1762812360.git.lorenzo.stoakes@oracle.com>
 <dc483db3-be4d-45f7-8b40-a28f5d8f5738@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc483db3-be4d-45f7-8b40-a28f5d8f5738@suse.cz>
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: eec26c05-8a31-4768-9146-08de2ddc2ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N5PFHYB7KQmgxmqp+OIP2RAdrr+nsePayl/AmywKrDPsStK8/WaZT5XpJ2L8?=
 =?us-ascii?Q?H+22j2dDtEJ26PkbiyPnPT3GgXhXEMdORQwnIjT/Dy6mg6jJt/VhfJkcUmT5?=
 =?us-ascii?Q?DrpwRor2zy54nGD1+lTWDqaHvo1PquHrK0y9n3NddwdaeAzOSZtlI8fYa3xI?=
 =?us-ascii?Q?sH19V10rhQQ2SUP+Bg3X+hz7RwlQ0DNL01+tZA1WNwVd5HWXToJ6Fy+K8J7D?=
 =?us-ascii?Q?CO/hk6FlJL2RNtXLWb4JXgP1CZdVqsLrNGUoUHN/+701egCsDwyGpd8Yndb2?=
 =?us-ascii?Q?O9NOnVKw7Yv5mhxOCQRRVH/7SxVxgJOjZcmPiA9xWbPvavAZHll6gHMlRFxp?=
 =?us-ascii?Q?4iXM+qO+Szvytcin6nKKEUwfyRGcM5/eEUJEicrx6KK5zsuz17VGO6Ng5Phs?=
 =?us-ascii?Q?qlS/NAVi6Y7F0PiVGneEodhX2355uLwZPuWXUoHYGWBkq7Q25+0kMXNZgX4K?=
 =?us-ascii?Q?oTSy1SN3hBnMXBfs2ZsraxVqLr+wywrb2TrhVLLqJQhhyD2GHNMdyI80Zqoa?=
 =?us-ascii?Q?/f9aFpgeGVZOHssbnrUGnlLBj64l9ZVLxWQEB1dxp02j4UNzjRnZWwR6xVFT?=
 =?us-ascii?Q?dJoLmyCLoBltkHjQchniY/KHj+LGDOWwn/lGZQ2WLhTxq2V+1WBd0q2egiSN?=
 =?us-ascii?Q?5nvpZKPfN4tghcuTXcaS9FAXyn9cYGp4uHzDuk+Bq73ol01jXoOIf5YkX/Vd?=
 =?us-ascii?Q?TZw5QO606G52kLUvHruMUyo2boioRnmNZF7aAxuhmW+eN0ossMLFdBTdfiOv?=
 =?us-ascii?Q?RcRnsQhjAo153lF2caqLFRWQcSDsKUeyvvEUdEGiOXrFUY1OmsRBz7nxSTmu?=
 =?us-ascii?Q?LnENLQCpC9mNyjES/CWYqqb/oF8l3r5z+hqt9SKj60Y64tz6csB0sMio+xZK?=
 =?us-ascii?Q?K4qrQOPfeBc0X6HG0Ct3CsJNCay5RpN17CGO98Zvl2cyR0HYrtc6xh3qUFi/?=
 =?us-ascii?Q?dctpunv5APJHGpLrQylRjTkof4oY49gXa0SPf5n2SRlCwJelHG3g0jhlqNVX?=
 =?us-ascii?Q?+qYYzHg7YkIljN5vGuPEXeSmCqdjpW7lnEMExcHtqHxVLr8YS/PqfgVcji7P?=
 =?us-ascii?Q?Q775ULPGcaPadKkcjAi2wCX5ucI+ErXCd/vV2TpmWsl3qjTjte5fC6H8Eq4I?=
 =?us-ascii?Q?z8ndNeR8/EJQn5uiwVLriVPt6E/eHYE+lJdawLi3Q5HVf3l5gszaCiYG4Vko?=
 =?us-ascii?Q?/qWKDMiOntQetYXHLnSeVScoJfTi3CDndGlvjmqeuT9DaawlASkW8TUjF8kg?=
 =?us-ascii?Q?WYTwpkji3KWJdmQSmtr8PBXF0MQUk2iDAUOaH0Y43TULJkrGAOietKc8HydH?=
 =?us-ascii?Q?UiLeJldeIV1hujyi3kACNKG1KD/BLjA7sKIOGr65/Zpn9XbAow7paa4wZv7V?=
 =?us-ascii?Q?pWQACOkcwoW7i4pzAogwp1llmTvm8pvcofaXcjclwzeQITK052I1OfUNxcW5?=
 =?us-ascii?Q?pXCTrUwuiLWAhz8SCXO1ObL8If18LKpD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zvaUbJBPa6hj0oLTBWLOMMXoVFz9m+Q34WEn4iO/dFKKF8LNPQA+c5wNpbmd?=
 =?us-ascii?Q?8oOfC1AABNbXKpN/dTDuOerbKU29kNA2vllNyuIA2oWo/5ewf3RAfuWLlF4F?=
 =?us-ascii?Q?+zxdKvqDyga8TFZ3wJK3+aqGskwmODhyxwv2pXMvT8Ab43DRqi1w+Vn+goLB?=
 =?us-ascii?Q?fRJGNoYRh8esTVDMsx6ZtxnLAB3zpISp4stHBC3638uo3tII8NGHa7HyaTFs?=
 =?us-ascii?Q?zbeYmJkjkH56o1wNujiQWGCbQ/hSJxN8lXqYVOfNduN8YerONSppApcA8lTr?=
 =?us-ascii?Q?AzM3R6uHaFgyG5lCPm5I6Skn41V968hhY6+6Mf+n3y0/BZtWJWPCbLa0CMa2?=
 =?us-ascii?Q?os3e+xGCDX8Z+/VTwTgO7brF0v7DSDmMij5XorB+3/mzSwvJsQQHG94+lBwg?=
 =?us-ascii?Q?7oOkKF9d/DkKdCuyYOCI2WhLL082DTLn500nAFF1jFGpBwaCdjkF4R6nrLU1?=
 =?us-ascii?Q?7G0dAabXB8iIwuwS0FQN/CN/Cw39P84jQFPyQoxrWS3Dp9msZ34H1XVz3LAB?=
 =?us-ascii?Q?0rI6b5WLxC7vkx96/O2AOLNRfMciLm1knrOoF/n3nH8sT5m73njzArTIhGNY?=
 =?us-ascii?Q?HF3yVvzLI12eKgld35pMBMDnBZvwe4z4OyyYhQy1UA6xnRcySoofCf2f1SsK?=
 =?us-ascii?Q?suo4ac+nifDX4wWaHVICc5cVLnZg2MqS39m8tKb0yx1NVRxk0J7K/iTp5LbA?=
 =?us-ascii?Q?Cg+htedkKgnnsEy06xdSWFEp3jtRKXooIR5TUxnkVFv5dUQV09jzSPCLH1ca?=
 =?us-ascii?Q?EG7RbZdfYN+KvDgB7h4zfgyN9CYYzln1fJjnvkIVXzDkZmQKZFQBJBO+QaaY?=
 =?us-ascii?Q?SN3gGFzZ62pwlEcfFNE/24D8GQQDwZ5KmI9zmsT4JjIXu/2f8lpcrKyCXa0F?=
 =?us-ascii?Q?d9vPMEdQIRRSJUu2tYF0bMP2LfSgH7Qk+3hE2HLS/nIcetroTniGIMKdkCGI?=
 =?us-ascii?Q?JisfxywLDUkps2n+kVkuDLUxOxTyZ28eTxhhKGZZOhb8pb663Sxr3dkzi0SH?=
 =?us-ascii?Q?wN2fcIuA5xx/Ifem1BHW2ivrONr2Bt4xNr7sXvAXtCX6tWIebGPcledK7gMb?=
 =?us-ascii?Q?XcJT4Duxl2IdY64WcYsiar1EqhKNq4XIHRRteHtz67ZGdppa1mt1PlOBcmo7?=
 =?us-ascii?Q?oRq6zg3YlUCruz3hDSobIWhlX6tM1FdI6CRasJFIwpwaspjul6TvEjj1hQjR?=
 =?us-ascii?Q?qdFAyiSDElpeocnvmWLdAoqwfCSuXqyN9GByoeIz6Fe+R1Pu5n5ra0kGlWLS?=
 =?us-ascii?Q?mRxjRCZ313R16dzU31AMmYqQAAanbphn9llPBAITDncp8qf5SW8O/9C++ws0?=
 =?us-ascii?Q?UQRDFdbN8XoVJuMZd4fcyP2FoCSWqgGu1cSPSC+ZHiw4PSxHr7YcpgIZAzBW?=
 =?us-ascii?Q?p7sqejRblL1gXYnTjp09Lsyvjy9GS28GfpSbS6od8s12dApGbmn2+oBrqXLa?=
 =?us-ascii?Q?FuA6tesV76QLkByecomD6N/jARA411I/g480k2ZysU/drJaANbq+EFBhkAzi?=
 =?us-ascii?Q?CPYNAuKHshg7QJqOGcuq8usGh6gh8sH0Mxrf6ISrSNBRC+Lqh0TsNDmcx3oq?=
 =?us-ascii?Q?nuAbxyKRk+g3B/36JRsml0PXyCZl2rzd3AmP2X5lvswwOLLggQQfQJuJrlNy?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tl7InHpRvjo7S4voLW8YN0o/wqaLGapaCaqpxXzLHWGUoTO1+k8pn0etrrJpMrnNU//MHfuRcZu1QP7aUuoIImMQ0/jqSqB5x9niK4ZafAT27GEdeTUrjdvMcEJQ+ElsY1h0DEtLjaDzJyf52zyu+WIGXDAfdJUZtEV3sCcn8izH24Q23WYAfgtNkJyLuc+r6Q0WsMeOXAEDQt/YA4b9Sl3L6qZdhtLc9p0k+KO+v9YOp3o/Hw1KbJpK2n337XHEKqGfvQngJtXTxHXcQ3S20k5jq5nOXPjxABD6IpYClWzO85g5iKTpWmhKWFJaEHN7I4nuHUfmIIqm84j5zy9yAzw01H3YcUbaFu590Av5TqhxuNDVyzm2Y9bjdNdvNcC5o+VtikbwS+M0Wxk+gmURL1DPPc9FbCIRd1e5s9BEwweP5BQLltT95zYVF8pWDAcluoZkHd3gmG08N2kOeFNn8OrMdTl60NhLxRC+xFoWySVvN1HYhyHbPqhJwHqQfU3ULki7QMorCdKgqYEDn0z2KSsvwgLZEavbhE19IeS+iXjvVTpK5c5A3VYOIHazCBwvR7t5Youaq8wbWcxS0zliUp/diBp3rcUEIYDk7NHn2ww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec26c05-8a31-4768-9146-08de2ddc2ad8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 17:41:16.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y8jwt4T3YONd5KeBCN57LPolariO8s8vkKPhUTTtb4sg+JrylAAlkMJ8VFD/MoatPmKArIIRaR1ebuvcftkHaWjJNkI0tu0/4ikq8WcSvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511270132
X-Proofpoint-ORIG-GUID: xtiElJ8EMNdNF0Vec-YgXysHGtG-tJhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEzMiBTYWx0ZWRfX+JvIbFsUE/qW
 wINS16yorcikEKHQzEA3L3EQKtAGlaM7Mkz1XKazGjgXFPy4pcrCDm1fgaAtiGJ8sVsDFxfzSCx
 on4JrX0zR5w83oS/kzUI6NUEvkwTBWK+98hCtiT7jeb/X4LwF6YBXqqpRKrKpGNGq7tQwWhtNzt
 WQDp9LTtG4T118UsnU49QUERcST5p+S/PRs6yWHjil/8QEu4bEKBWyaQk9ZXBqLTzi/IfJrr+6D
 A5/6PL8Kfd+LbXwMzlz6u8X8zDz9dlPZzLXgaVla2ETTq4gPX3rm8Kr9UqmUugEpbLkyceSa4bm
 2pj6GTuI4y7WyrIXImKmOf4z9SG3xovThsguT+OtNnC4LpRn8cBaqpTU8ZMBaBVhOhBAfbTcAje
 qb8nNZOKgeyHEWEmg7HWzGwPhDtg0Q==
X-Authority-Analysis: v=2.4 cv=A9Rh/qWG c=1 sm=1 tr=0 ts=69288d41 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=SdnQnRXblhh1GgZf_fQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xtiElJ8EMNdNF0Vec-YgXysHGtG-tJhF

On Thu, Nov 27, 2025 at 06:29:39PM +0100, Vlastimil Babka wrote:
> On 11/10/25 23:21, Lorenzo Stoakes wrote:
> > We do not need to have explicit helper functions for these, it adds a level
> > of confusion and indirection when we can simply use software leaf entry
> > logic here instead and spell out the special huge_pte_none() case we must
> > consider.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> But seems to me a fixup is needed:
>
> > ---
> >  fs/proc/task_mmu.c      | 19 +++++----
> >  include/linux/hugetlb.h |  2 -
> >  mm/hugetlb.c            | 91 +++++++++++++++++------------------------
> >  mm/mempolicy.c          | 17 +++++---
> >  mm/migrate.c            | 15 +++++--
> >  5 files changed, 69 insertions(+), 75 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 6cb9e1691e18..3cdefa7546db 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -2499,22 +2499,23 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> >  				  unsigned long addr, pte_t *ptep,
> >  				  pte_t ptent)
> >  {
> > -	unsigned long psize;
> > +	const unsigned long psize = huge_page_size(hstate_vma(vma));
> > +	softleaf_t entry;
> >
> > -	if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
> > -		return;
> > +	if (huge_pte_none(ptent))
> > +		set_huge_pte_at(vma->vm_mm, addr, ptep,
> > +				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
>
> Shouldn't we return here? Otherwise AFAICS we'll also reach the
> huge_ptep_modify_prot_commit() below and that wasn't happening before.

Yup, will reply with fix-patch, thanks.

>
> >
> > -	psize = huge_page_size(hstate_vma(vma));
> > +	entry = softleaf_from_pte(ptent);
> > +	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
> > +		return;
> >
> > -	if (is_hugetlb_entry_migration(ptent))
> > +	if (softleaf_is_migration(entry))
> >  		set_huge_pte_at(vma->vm_mm, addr, ptep,
> >  				pte_swp_mkuffd_wp(ptent), psize);
> > -	else if (!huge_pte_none(ptent))
> > +	else
> >  		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
> >  					     huge_pte_mkuffd_wp(ptent));
> > -	else
> > -		set_huge_pte_at(vma->vm_mm, addr, ptep,
> > -				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
> >  }
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >

