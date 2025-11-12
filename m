Return-Path: <linux-fsdevel+bounces-68062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C700FC52B2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 15:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB2024FCADD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DE27F747;
	Wed, 12 Nov 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r6VFvwJz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G7WC/q14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EC25D53B;
	Wed, 12 Nov 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956496; cv=fail; b=oCgm4eITlMNM3gyHmfRWJD0AICiUTXmr6123Oh7HbwCxW6JLaTM7q7pGlkWUJRWYA7g9bcEObzWmCoIlb/LeAfMA0LMfPTLwmkhiDWdFFm+Q6/RkO/hMrdyuihrFwkt8D62OXIyhyna2zMbKbg5/rHdojXdJNTTnNnemVZMvlu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956496; c=relaxed/simple;
	bh=oYbzOje3swIBf7fi0YBzpacqlsW1mo2KgKj4V8mGKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWw/9sUoWWlFEGKqF5tP/4YxZ3d6YMZCj8+L2vJjhawoN9WkaLjkyqOUkzjAs6yDtMIKCv0owh6laCJngbQNN8fFaGjFdk6PwwiKaKwTEbE5w5a/v8M5OuX0VI1jweB3BZuv/0BNTpX7thArjvDYL/8gy1HdN6u3WnUSDXTwJNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r6VFvwJz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G7WC/q14; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDPQrL026419;
	Wed, 12 Nov 2025 14:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RhwXGqEq8FpQ6WF+milwU51xot2V70hpSvLDdkXs+rY=; b=
	r6VFvwJzfrgZcO2UUKpa/Myj8g7BA/DoH4WkPdLG7DJZEqn+2eH2qADjS+DuKAG+
	gkMNdLnXEHEpvovyHVe+Ew+4hvPE9Z6fXxH81PmeaDz8fK4Ic8y/t7pvcwz9K+Sl
	F+GJ6dCBY6dO141HKaaM04lkBn1FSfFgcryHqy1PYcqZhUjQ2k1zswm5VZuZ84OS
	rEAMX8DCbOJxQ5u4i587qwUyWFucUlUuRZOWNjs6fGcSSnaL5oegGU4ISk+XqGmU
	1lci5ZWv8/vsSKwdq/7+Ki9CbcuOiNvD/six/UpPWlKRDNBJpJuo1pu9zFv52157
	RbZFbC+GrTLQ1K+e1ksrGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acu3tg3ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:06:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACE6cNe000764;
	Wed, 12 Nov 2025 14:06:58 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaesfu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcO68vZ+FyT5FcDmcHXDuToxTKD1+U4ndlyRsleycf1p3B0TbtnlQdtGRXUi4GIMktIBfad52CgFDpyVmzu6nV7RSg8WEzAAKog0vp4aGeJS3ExXbGbLiiP2XmH5mzTHozA7nE+mBDfO7qJ+/96Gl2z3kAgZ0o8Kw801hghMcpZU6UaVsfJfng5nNEhwrpIDmdVGtnCtPXIFKklf7W3HgQgS7XPlR13cwJc0w/t+jJbSVWS5LeEZwMOWewAgR/qkPstTcWaTqjEwlGI9b2Y79tiZ8SkShbraiTJrN0u7CLojVMhh4qBnD18rMg7fjB6Fy9Z67VcrbfmGmh1aY8PR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhwXGqEq8FpQ6WF+milwU51xot2V70hpSvLDdkXs+rY=;
 b=nkyH00i5820LOSWuWDe0TFuQkt2sEWobfyLToqcpAKti+CHufhXY55ZRhbBC20GWbN15W9BS84HZAaM3zIH9SFfqSx6cWQhuk6MRGvbf7tybnnPmeqM943EgenWJamb0UN/NyFqYHovAegPPRc8wmx2S6J9c4/TnCzXj2Kos0Uf804wDDCjejly5wgYNA7DI3VupUIKmfMdOwSxxkjbx2GC02r7wPvdLWyY3kjzeQb8BOkEV52C+t3riO89VCnrkiOohmiGIKZRk63j5U5nOHskbZ96n2jHgX+vF7v6h2XX1kiLsejdkwvDGBN8RogLERApT/xNdxLNlxN0XCk2K3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhwXGqEq8FpQ6WF+milwU51xot2V70hpSvLDdkXs+rY=;
 b=G7WC/q14+K31DIAM1+igEPnL3OKBo5Ro6kiyEodEYD8Z2IAL8YdqvMzFEPKxQMsawmJz0xSeNArfCijYanX2KHm3AaU7VxuecapQa72Up5Iu8ASrtWNfh4thSuy+qcWeOfJT6VVsJMBbrc+yXpg5cGWc306M2a/tu30hpdHxIEE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:06:54 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 14:06:54 +0000
Date: Wed, 12 Nov 2025 14:06:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
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
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Message-ID: <5a1281bc-f423-4558-8052-009458f1390d@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
 <3E8190A4-5B17-4A36-9025-F7E4FF1127AB@nvidia.com>
 <a2063bd3-8030-4c80-a361-c84274b5db99@lucifer.local>
 <3A90DCF0-88BF-4117-8349-82141C7357FB@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A90DCF0-88BF-4117-8349-82141C7357FB@nvidia.com>
X-ClientProxiedBy: LO6P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MW6PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: bb848f21-f0a9-4d90-7a55-08de21f4bbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDJTZGM2TVNka0FGTXZURzc1c3JodHNEWHlUSmhmdUpTNUpuS1F4Q3J0T0F3?=
 =?utf-8?B?VFg5V2twWmhxTDUrMjRRbzduRm9mUGMxcmNTMVNxaUI3dEFvSGUvbnFaTWhh?=
 =?utf-8?B?M1JGamZGdzRINVRKZUo5SldsTlZjSVp3SUlPMlhJdVdmNUxnQTNhanNmckxj?=
 =?utf-8?B?cVZXYitlWDdpayttcUhrYW5JcGVWNXdwajc4VzZGTGZlZjJldTVpMTZBUGJ3?=
 =?utf-8?B?TVlpT0p3dkhoc05YaEg4NHZVcDlqNC9XMU05QzVCVGRoN3A0ZStkKzlVbnkw?=
 =?utf-8?B?RkxpZWNOZ1FZOFdGV3BRNVoxOEZUWTVYUmpxaFd2MnNLTC9ocUd2VzJ6SXJB?=
 =?utf-8?B?ekNBdk1BZ2ZJSitVZ2pHUmo0RjBnZUZVcjhjdGVXeGlrZ29uOVdNdGJ2aHVQ?=
 =?utf-8?B?WU9qM0E4RDlEM2x6N2h3aE0vWkNiWU1Zd1NsaG9TekFGTnBSVjh2VG1zMHJj?=
 =?utf-8?B?dDZjdGErKzFpZWRaMGJWRlhMVjhHaDh6QXBNTS94dG9HRTNRY2NDRmF2OFI1?=
 =?utf-8?B?cnJzN1QxcFVLMWhwWENDUGZ4U3cralhQSlBXNVFlM2tITmt0WXhaV0J2L0pB?=
 =?utf-8?B?b1dTN0VDR04wb2R2cjhEenJMQWNkSjVDZis0OWdUc2p6WVZIbUFjWEdqaW0r?=
 =?utf-8?B?YzV6T0JTUFpDS1pBNytVNWNsMXNMcDJjdnRDazVFbUQ0S1VNVTVaYjQxYkZT?=
 =?utf-8?B?V3I4cVRLMHdVWGJMY0JqTCtldVVZSWNNMmp3aldNWlFaWkJ1Z0lzS0txYWlv?=
 =?utf-8?B?ODhtK081VG9wVVpTdExIWDkzL2pIN0ZBeXhWOTJBUnFpUVVTTHNwNWlQSERU?=
 =?utf-8?B?QVp4Y29GVEZQcXFpc3YzU2tibVRROFRZL2xHSlVGTXhtaWxtQ0lFa2d6RlYv?=
 =?utf-8?B?ZTJCSkJDcGFIeFZsSTJOWXE4Y2hXRUkwb2F5a1Y4aDNiTVZPcDJ6T2xkUHRQ?=
 =?utf-8?B?d25LM2V6cUJmVnNPTy9xQzdNZFhpaGxXemdyc2kzdWl3M01GNFZ2VzZSWlZh?=
 =?utf-8?B?bHNMWTVqWTg1MUNhWTdRSzROTlZRUUtDS1JFVmJYaVdJVDZWaU51QSs0bDA0?=
 =?utf-8?B?QzdqUXNRUzNZVms5Ny9QRjRZcmlLbEMxdkhUdm9UMDBIYUV1MWJoS3pBWENU?=
 =?utf-8?B?VE5SNHloTlhQLzBJcE50T2NONWZ0Z1lWSWZ5aHNVcWNTNGV4SWgzRjhSTEk2?=
 =?utf-8?B?Sy8vUE1TQjhFU3VmZlNycmVKUFJjQVhsdU9LSU96THMyR0tSb2VjQXN0cC9z?=
 =?utf-8?B?Q1o2cG1sM1NLVmJnS0tTYkErbkY2UGFlVEM4TUtHVk9GelhoSU10YXFlM092?=
 =?utf-8?B?MzNWVFp3V3k4L2k2V2JBNUZDbDA3Yzlla28vSXJhOTZKVVNJYnNmQi9BUWwv?=
 =?utf-8?B?T25ONk9KOTNrTzN1VUw2Q2lCcWE5cmZDUUNabEtpZmppczIycmFteUdxRjI0?=
 =?utf-8?B?cEFreUl2M01aNFNLeWlWaXBlTzB6bnltdnF6MDI5Sm5rWUYzbFp3aXh4ZG5t?=
 =?utf-8?B?UEJ3cE1ZbFYvSVZ0SGZ2UTFqQk5vc2lFblN4eW1Ib3JMR3hGb0M1eEZCMWN3?=
 =?utf-8?B?VVRsZGdGM0wrTEhLdjdtNTU4THRXS0FqNjhtRVBOLzFORmVHYWxVWVRTQ05Q?=
 =?utf-8?B?a3JpY0tHOXR5V2swWDdNay9vV0pMN2o2cUtBaXFYdFBtYmNRaGVkRWJCNlNz?=
 =?utf-8?B?YUJBcjJhc00zVkFPclE0RDc1cjZYMzJPbkpZWCsvT1gzUkswTVhzM3ZBejBo?=
 =?utf-8?B?N1YyVkNqanRWNDJHY3VqS2lxaDlhcmRzSzZwODhMVjBXMjZlVDFHV01PT2lJ?=
 =?utf-8?B?alpnTG42K0ZkbXJiOVYwdGpqU0M4MnBKdGtaNklxUHVFZUpQWXFVeEZpZkJC?=
 =?utf-8?B?ZkR4SkNuOFg2V1JTV01COWUyU2NSUWU4NE1LSXY1Sm0xMitpUGZLWE5BQjMz?=
 =?utf-8?Q?/xq9+dXl+pl/XkUMY1XKgqyOaLg+w7u7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjJLMGp2cXhBQ05yZ3B3U2NUcCtQQTFXUzA2NUpCdU1JaWg5QUorK3RQTzZR?=
 =?utf-8?B?Sk54TlJZZGFrZWI2ZHZqR3lyS2dYb2hwRzh2QStrejF5b1IyZUxRckl2c0po?=
 =?utf-8?B?K2YvaEg5QkpkNTVqSDk5UlJBZWhFZkswK1JTRitYUTF5a016Y2RGV0pKZ3BS?=
 =?utf-8?B?T0dSK3dhZE9TbFBDbk5kak82R1IrSjZFR2J5WCtKWXo5TzJDM0ZXZTNRT1pz?=
 =?utf-8?B?M1dadnE2YWVHMERqdkFLMjJKTzVIOXBiRDd4d0dxdzZuM3RwYmovUnRHQnRv?=
 =?utf-8?B?ZXRKZTl4WVhpdkRqbSt3c29pbC96NHpVU0hYQ3MxZm1kY1JGMlBFUUw4U3pv?=
 =?utf-8?B?RHVYRlJWOWhiSWM2R0NNMDJVS0xxZ2JlSnR4dTJHd09NQ0QyakloN1ZManc0?=
 =?utf-8?B?bmZMVTB3Y0hYM2NJNFpjM2N0SENrcEQ5SCtCSW9UNVRtQ1J1dzkrWnBJQitV?=
 =?utf-8?B?eEJQZXNMSXgreVZYYlhENnVyZ0pqYVcxQjZraCtWUVRoVU1XWTFZQmxQdFlX?=
 =?utf-8?B?Rmt3bkNjU0xraGxTSGtBeWREV1E0VGk0WkJMQUw3K2E0K1N0WDVSOTBDdEtC?=
 =?utf-8?B?djA3M3Q5eGRycXRsMEdrekh5eUgzak80STdBbkYvQ3ZXczdpWW1sbzRPSFVs?=
 =?utf-8?B?NzdrSWJsN21RWkllNlBkUEZYR2hHRWhuN2JuWllnRldQR3N1UXZFcXd1cVcx?=
 =?utf-8?B?WGVwV1IvN2NiaFZPZHJtaG1XRFJYeXZaR1Rzbm9LSnBwQlZmdGlGKytOK2Mz?=
 =?utf-8?B?aUEvb0d4UGhRUWRvTXZsTDBBd1I1Zjd1V0tSZFVyVk50a3FPYTNQdkpwOTdX?=
 =?utf-8?B?NXpVdkVvb0ZIempCbkZoRCtYaTJvTkZwQjFCbU5INFplSERzWnQ5R3hOUW5T?=
 =?utf-8?B?clQrampWbmswazd2NURob05mdmliVzJOTEVjMVcyK1JKSVRpd1B1djR2aytS?=
 =?utf-8?B?OW53S2JUYWdmbmVCSkdJNHZQcjFoRE52Z3krcGdZS3JOdHdZYnhIL2M2OVp2?=
 =?utf-8?B?dVRFYjdDaFBHZk1GTmZJQ0JwNVNqNk1qbVkzakNDUDYyUGRTZ3VNU3BBVjdR?=
 =?utf-8?B?TlBiZ2FSUU9YVVRwZDVLSEwyNTU1cGRGcTkvam9nRDFuZUFMdVl5OCtiQkxR?=
 =?utf-8?B?REtWdm41a0RQNTVCT1lPN1hUeXpibGhFMXBZcFc5MERXWG4zWmRHZGtpdDMw?=
 =?utf-8?B?K0xBL0tleThZV1Zkcmp4WjFwelU4ZjVTaG03K0djVTA2UDB3MW1UU2ZOTzVB?=
 =?utf-8?B?bFdWeC9hTWg0RFNhMktjY1doQVBlYlpmemQ4b211RVlMMXJ3bVZjM3h1cDk2?=
 =?utf-8?B?cnRoWWZOdEhLLzRoQXV5VDFoYnM0MUJPWDNpNzVqL3Z2alg5Z3Bkb2J4UkFr?=
 =?utf-8?B?YlEwZkgwTlVGRVdLM3lOUnJuOERpTEYveUpPZjVZMUJXemFKdGRtNUFaeDk5?=
 =?utf-8?B?VUxsSE1GN3E2Uno5di9wdEJOZmRJRVR0Yk5UeHpuY3RKQk9pdUwwQUxWU0k2?=
 =?utf-8?B?K1ZxMjhSNWVkVHNhTlExOWlHNDRCY2lWTWpaQXdlYU5nVzFhdGMzT25kajN4?=
 =?utf-8?B?bHlaWkxHc2gwRzVrd2hyd283aXBoeEFNa2habVdlT1hvMUl6ZWVZWStXSW1E?=
 =?utf-8?B?L2hUamdtOXZTRjJHT2FjcVNzcWtjQmswcFlqTVp5ZHV5YmRhT0FqMFR4TkJF?=
 =?utf-8?B?ZkI0cjVWeHk2bll4blcyd3BGMXFLOFlIelp2ejZCakRsckJvbG93OUtXUTdz?=
 =?utf-8?B?RitnN0ZDQnBEVE5GRjRXbFFwdmYzM3RUN0VxN05iVmhZejJ3YncrdUw2amVi?=
 =?utf-8?B?QWQ2cGNHcXZqQVRNUkZ5OUxZalpEMFVaRVBzMmpCZFd6dGxZejRwamtNampF?=
 =?utf-8?B?aWVKUTZIT2Z1Vi9nRVBpdHhDYVd6N1l4QXJpb0VRODhUeVJCS2xDME9iYjN4?=
 =?utf-8?B?SjJlVmlteUNRVTZzTFpqVXNNNTdwcElGR1RXNUYzWFNmRjlhMmlvUjdPcDlE?=
 =?utf-8?B?alkzRmMwT0xUQU1lWHBxbTZPSzNaL0NoQlA5VG8zVHh0eGNJbTBlNnBuZjV2?=
 =?utf-8?B?c1U3TndQRCtLVVJxbjdMYytUakRNWUNkYjd6NG0wT2I1eGVYbmpPTkNUUTVJ?=
 =?utf-8?B?OWszNTI2aHQvM2h1b2grMW9MZVVrUkY5TE5PdSt3bDhrVEdDeG1FVitXWXJK?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eNLsk7rKQcPz8pZroGHsPU2+78e9OsoDG7OUvO6Df2mi3eKg1O65nACwFdEYvRlxrwCsY1fy3QlzesafydqMK3RrC3hnCMbsOqeu/BTfQ7DFf2TvklGcFKXvgHH9xmJGOaimB59yZ/c8blWynQDrwq/9nLMg88sWXDmmhxHPnCBjiYo/PsxK+75EQYGKUt23giQk4xH7h24QVZvLsLwNAEs+Cq6KGyLUcRw/ewJE2/B0sWoElLQSVykWz697Dkh6108EAaBMjZDCVylfYX8JLyck9cRWL07+NuPyMnzWHSDcuOCg3+iYCiTS1WRqRX+24/+HvDL1opnL7FW0ATmIPyrdBqS0pDB0XmiJmQUX0ZexpXYxUCxmUtmVDB5UiH37sIG6NZ6quqyJlwaX2dUJTl3X+PA0dFHGoXv9EXc89mm/KwIZM9rqy09XtMUMzYLcC8IPJl+82kGUaEGg1Ana9SRbfaEtFKW4B9EEmDP0NVMsikE+xluw83BOx9dIPMs3wMFnugvE4kTEM2CLyIEjVJfH9hLFNcdLy4adCHVt2ZIprNAC7QZvNSLKLiosIkGp1TMb9hMxHR34fbvRz4edxSmtP+wkVpO6//AUwSWOE6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb848f21-f0a9-4d90-7a55-08de21f4bbb6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:06:53.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xp0eRdLOn8mna8WI9LAoP/PMuiRkDVbcsYcxLrsYmFvuk2cFEUNXZDkz7yzfY2vbFHV6wqkrTh+LnoR1ohg+RtwvhvDobHxYrw6MdhXDCxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511120114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwOCBTYWx0ZWRfXyU9EDLbwAq+I
 SvGefrF77tazejWmcH2G2k0l9KBNGeWTgbyt6FoCwMOeRPrq0a2zOkeQVd6x8AcbzVlqh2eHJCz
 wm1dgkruPpCXAtsbhT8coiHy75su6/La0UfMSGZA+JSOx2ba/QrM8RHe30HOe7/NwYVa/UO4jxJ
 3YLAqe27rOzbT4N9VWQt4YS/YL4jgYqf4wqOaFdgbZXMXGBitww7l33qpxZMVZyCgK53txNWzAP
 wd7aQbErepl2caQo3/qoYs6kDrV0ld2aWOqdROsy04c/hfLvA3pxMNbRtoYTIaRUDknOOQE5aZI
 0pGfCuLLuGlZ6ZPWINEc0/kA2URtzQluRXBsrkGfqpsbNkfTmJaIPffsqVTC1XZaYhYRfzVpRB6
 j/b+etPDOJM2RYxlLJ4T822qMd6ZLS+aiNxBwfmpEv1F9OdtNhg=
X-Proofpoint-ORIG-GUID: 5CGraHQEwX8nSyFr-oS6vMT1kFi2g6nz
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=69149483 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=IfMhf6H8sAfkcza4MUcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13634
X-Proofpoint-GUID: 5CGraHQEwX8nSyFr-oS6vMT1kFi2g6nz

On Tue, Nov 11, 2025 at 11:40:32AM -0500, Zi Yan wrote:
> On 11 Nov 2025, at 2:31, Lorenzo Stoakes wrote:
>
> > On Mon, Nov 10, 2025 at 10:56:33PM -0500, Zi Yan wrote:
> >> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
> >>
> >>> The kernel maintains leaf page table entries which contain either:
> >>>
> >>> - Nothing ('none' entries)
> >>> - Present entries (that is stuff the hardware can navigate without fault)
> >>> - Everything else that will cause a fault which the kernel handles
> >>>
> >>> In the 'everything else' group we include swap entries, but we also include
> >>> a number of other things such as migration entries, device private entries
> >>> and marker entries.
> >>>
> >>> Unfortunately this 'everything else' group expresses everything through
> >>> a swp_entry_t type, and these entries are referred to swap entries even
> >>> though they may well not contain a... swap entry.
> >>>
> >>> This is compounded by the rather mind-boggling concept of a non-swap swap
> >>> entry (checked via non_swap_entry()) and the means by which we twist and
> >>> turn to satisfy this.
> >>>
> >>> This patch lays the foundation for reducing this confusion.
> >>>
> >>> We refer to 'everything else' as a 'software-define leaf entry' or
> >>> 'softleaf'. for short And in fact we scoop up the 'none' entries into this
> >>> concept also so we are left with:
> >>>
> >>> - Present entries.
> >>> - Softleaf entries (which may be empty).
> >>>
> >>> This allows for radical simplification across the board - one can simply
> >>> convert any leaf page table entry to a leaf entry via softleaf_from_pte().
> >>>
> >>> If the entry is present, we return an empty leaf entry, so it is assumed
> >>> the caller is aware that they must differentiate between the two categories
> >>> of page table entries, checking for the former via pte_present().
> >>>
> >>> As a result, we can eliminate a number of places where we would otherwise
> >>> need to use predicates to see if we can proceed with leaf page table entry
> >>> conversion and instead just go ahead and do it unconditionally.
> >>>
> >>> We do so where we can, adjusting surrounding logic as necessary to
> >>> integrate the new softleaf_t logic as far as seems reasonable at this
> >>> stage.
> >>>
> >>> We typedef swp_entry_t to softleaf_t for the time being until the
> >>> conversion can be complete, meaning everything remains compatible
> >>> regardless of which type is used. We will eventually remove swp_entry_t
> >>> when the conversion is complete.
> >>>
> >>> We introduce a new header file to keep things clear - leafops.h - this
> >>> imports swapops.h so can direct replace swapops imports without issue, and
> >>> we do so in all the files that require it.
> >>>
> >>> Additionally, add new leafops.h file to core mm maintainers entry.
> >>>
> >>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> ---
> >>>  MAINTAINERS                   |   1 +
> >>>  fs/proc/task_mmu.c            |  26 +--
> >>>  fs/userfaultfd.c              |   6 +-
> >>>  include/linux/leafops.h       | 387 ++++++++++++++++++++++++++++++++++
> >>>  include/linux/mm_inline.h     |   6 +-
> >>>  include/linux/mm_types.h      |  25 +++
> >>>  include/linux/swapops.h       |  28 ---
> >>>  include/linux/userfaultfd_k.h |  51 +----
> >>>  mm/hmm.c                      |   2 +-
> >>>  mm/hugetlb.c                  |  37 ++--
> >>>  mm/madvise.c                  |  16 +-
> >>>  mm/memory.c                   |  41 ++--
> >>>  mm/mincore.c                  |   6 +-
> >>>  mm/mprotect.c                 |   6 +-
> >>>  mm/mremap.c                   |   4 +-
> >>>  mm/page_vma_mapped.c          |  11 +-
> >>>  mm/shmem.c                    |   7 +-
> >>>  mm/userfaultfd.c              |   6 +-
> >>>  18 files changed, 502 insertions(+), 164 deletions(-)
> >>>  create mode 100644 include/linux/leafops.h
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 2628431dcdfe..314910a70bbf 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -16257,6 +16257,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >>>  F:	include/linux/gfp.h
> >>>  F:	include/linux/gfp_types.h
> >>>  F:	include/linux/highmem.h
> >>> +F:	include/linux/leafops.h
> >>>  F:	include/linux/memory.h
> >>>  F:	include/linux/mm.h
> >>>  F:	include/linux/mm_*.h
> >>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>> index fc35a0543f01..24d26b49d870 100644
> >>> --- a/fs/proc/task_mmu.c
> >>> +++ b/fs/proc/task_mmu.c
> >>> @@ -14,7 +14,7 @@
> >>>  #include <linux/rmap.h>
> >>>  #include <linux/swap.h>
> >>>  #include <linux/sched/mm.h>
> >>> -#include <linux/swapops.h>
> >>> +#include <linux/leafops.h>
> >>>  #include <linux/mmu_notifier.h>
> >>>  #include <linux/page_idle.h>
> >>>  #include <linux/shmem_fs.h>
> >>> @@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> >>>  	if (pte_present(ptent)) {
> >>>  		folio = page_folio(pte_page(ptent));
> >>>  		present = true;
> >>> -	} else if (is_swap_pte(ptent)) {
> >>> -		swp_entry_t swpent = pte_to_swp_entry(ptent);
> >>> +	} else {
> >>> +		const softleaf_t entry = softleaf_from_pte(ptent);
> >>>
> >>> -		if (is_pfn_swap_entry(swpent))
> >>> -			folio = pfn_swap_entry_folio(swpent);
> >>> +		if (softleaf_has_pfn(entry))
> >>> +			folio = softleaf_to_folio(entry);
> >>>  	}
> >>>
> >>>  	if (folio) {
> >>
> >> <snip>
> >>
> >>>
> >>> @@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
> >>>  		if (pte_soft_dirty(pte))
> >>>  			categories |= PAGE_IS_SOFT_DIRTY;
> >>>  	} else if (is_swap_pte(pte)) {
> >>
> >> This should be just “else” like smaps_hugetlb_range()’s change, right?
> >
> > This is code this patch doesn't touch? :) It's not my fault...
> >
> > Actually in a follow-up patch I do exactly this, taking advantage of the fact
> > that we handle none entries automatically in softleaf_from_pte().
> >
> > But it's onne step at a time here to make it easier to review/life easier on
> > bisect in case there's any mistakes.
>
> OK.

Yeah you're ahead of the game :)

>
> >
> >>
> >>> -		swp_entry_t swp;
> >>> +		softleaf_t entry;
> >>>
> >>>  		categories |= PAGE_IS_SWAPPED;
> >>>  		if (!pte_swp_uffd_wp_any(pte))
> >>>  			categories |= PAGE_IS_WRITTEN;
> >>>
> >>> -		swp = pte_to_swp_entry(pte);
> >>> -		if (is_guard_swp_entry(swp))
> >>> +		entry = softleaf_from_pte(pte);
> >>> +		if (softleaf_is_guard_marker(entry))
> >>>  			categories |= PAGE_IS_GUARD;
> >>>  		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
> >>> -			 is_pfn_swap_entry(swp) &&
> >>> -			 !folio_test_anon(pfn_swap_entry_folio(swp)))
> >>> +			 softleaf_has_pfn(entry) &&
> >>> +			 !folio_test_anon(softleaf_to_folio(entry)))
> >>>  			categories |= PAGE_IS_FILE;
> >>>
> >>>  		if (pte_swp_soft_dirty(pte))
> >>
> >> <snip>
> >>
> >>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >>> index 137ce27ff68c..be20468fb5a9 100644
> >>> --- a/mm/page_vma_mapped.c
> >>> +++ b/mm/page_vma_mapped.c
> >>> @@ -3,7 +3,7 @@
> >>>  #include <linux/rmap.h>
> >>>  #include <linux/hugetlb.h>
> >>>  #include <linux/swap.h>
> >>> -#include <linux/swapops.h>
> >>> +#include <linux/leafops.h>
> >>>
> >>>  #include "internal.h"
> >>>
> >>> @@ -107,15 +107,12 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
> >>>  	pte_t ptent = ptep_get(pvmw->pte);
> >>>
> >>>  	if (pvmw->flags & PVMW_MIGRATION) {
> >>> -		swp_entry_t entry;
> >>> -		if (!is_swap_pte(ptent))
> >>> -			return false;
> >>> -		entry = pte_to_swp_entry(ptent);
> >>> +		const softleaf_t entry = softleaf_from_pte(ptent);
> >>
> >> We do not need is_swap_pte() check here because softleaf_from_pte()
> >> does the check. Just trying to reason the code with myself here.
> >
> > Right, see the next patch :) I'm laying the groundwork for us to be able to do
> > that.
> >
> >>
> >>>
> >>> -		if (!is_migration_entry(entry))
> >>> +		if (!softleaf_is_migration(entry))
> >>>  			return false;
> >>>
> >>> -		pfn = swp_offset_pfn(entry);
> >>> +		pfn = softleaf_to_pfn(entry);
> >>>  	} else if (is_swap_pte(ptent)) {
> >>>  		swp_entry_t entry;
> >>>
> >>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>> index 6580f3cd24bb..395ca58ac4a5 100644
> >>> --- a/mm/shmem.c
> >>> +++ b/mm/shmem.c
> >>> @@ -66,7 +66,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
> >>>  #include <linux/falloc.h>
> >>>  #include <linux/splice.h>
> >>>  #include <linux/security.h>
> >>> -#include <linux/swapops.h>
> >>> +#include <linux/leafops.h>
> >>>  #include <linux/mempolicy.h>
> >>>  #include <linux/namei.h>
> >>>  #include <linux/ctype.h>
> >>> @@ -2286,7 +2286,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >>>  	struct address_space *mapping = inode->i_mapping;
> >>>  	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
> >>>  	struct shmem_inode_info *info = SHMEM_I(inode);
> >>> -	swp_entry_t swap, index_entry;
> >>> +	swp_entry_t swap;
> >>> +	softleaf_t index_entry;
> >>>  	struct swap_info_struct *si;
> >>>  	struct folio *folio = NULL;
> >>>  	bool skip_swapcache = false;
> >>> @@ -2298,7 +2299,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >>>  	swap = index_entry;
> >>>  	*foliop = NULL;
> >>>
> >>> -	if (is_poisoned_swp_entry(index_entry))
> >>> +	if (softleaf_is_poison_marker(index_entry))
> >>>  		return -EIO;
> >>>
> >>>  	si = get_swap_device(index_entry);
> >>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >>> index cc4ce205bbec..055ec1050776 100644
> >>> --- a/mm/userfaultfd.c
> >>> +++ b/mm/userfaultfd.c
> >>> @@ -10,7 +10,7 @@
> >>>  #include <linux/pagemap.h>
> >>>  #include <linux/rmap.h>
> >>>  #include <linux/swap.h>
> >>> -#include <linux/swapops.h>
> >>> +#include <linux/leafops.h>
> >>>  #include <linux/userfaultfd_k.h>
> >>>  #include <linux/mmu_notifier.h>
> >>>  #include <linux/hugetlb.h>
> >>> @@ -208,7 +208,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
> >>>  	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
> >>>  	 * page cache page backing it, then access the page.
> >>>  	 */
> >>> -	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
> >>> +	if (!pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
> >>>  		goto out_unlock;
> >>>
> >>>  	if (page_in_cache) {
> >>> @@ -590,7 +590,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
> >>>  		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
> >>>  			const pte_t ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
> >>>
> >>> -			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
> >>> +			if (!huge_pte_none(ptep) && !pte_is_uffd_marker(ptep)) {
> >>>  				err = -EEXIST;
> >>>  				hugetlb_vma_unlock_read(dst_vma);
> >>>  				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >>
> >> The rest of the code looks good to me. I will check it again once
> >> you fix the commit log and comments. Thank you for working on this.
> >
> > As I said before I'm not respinning this entire series to change every single
> > reference to present/none to include one or several paragraphs about how we
> > hacked in protnone and other such things.
>
> No, I do not want you to do that.

Good! :)

>
> >
> > If I have to respin the series, I'll add a reference in the commit log.
> >
> > I beleive the only pertinent comment is:
> >
> > + * If referencing another page table or a data page then the page table entry is
> > + * pertinent to hardware - that is it tells the hardware how to decode the page
> > + * table entry.
>
> I would just remove “(that is stuff the hardware can navigate without fault)”.
> People can look at the definition of present entries to get the categorization.
> Basically, you just need to only talk about present entries without mentioning
> whether it is HW accessible or not, since that is another can of worms.

OK I'll ask Andrew to update.

>
> >
> > From the softleaf_t kdoc.
> >
> > I think this is fine as-is - protnone entries or _PAGE_PSE-only PMD entries
> > _are_ pertinent to the hardware fault handler, literally every bit except for
> > the present bit are set ready for the hardware to decode, telling it how to
> > decode the leaf entry.
>
> After reading it again, I agree the kdoc looks good.

Thanks!

>
> >
> > Rather than adding additional confusion by citing this stuff and probably
> > whatever awful architecture-specific stuff lurks in the arch/ directory I think
> > we are fine as-is.
> >
> > Again we decided as a community to hack this stuff in so we as a community have
> > to live with it like a guy who puts a chimney on his car :)
> >
> > (mm has many such chimneys on a car that only Homer Simpson would be proud of)
>
> Yeah, it is not pretty, but that is how people get their work done. ;)

Well, it's also how people mess things up :)

I wish we'd done it differently, ideally by separating hardware and sofware page
table state.

pte_sw_present() vs. pte_hw_present() would have cleared this up immediately.

Maybe one I should do at some point...

>
> Anyway, feel free to add Acked-by: Zi Yan <ziy@nvidia.com>

Thanks!

>
> Best Regards,
> Yan, Zi

Your review is much appreciated :)

Cheers, Lorenzo

