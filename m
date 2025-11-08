Return-Path: <linux-fsdevel+bounces-67547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48FC43139
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A75A3B5F16
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F6285C88;
	Sat,  8 Nov 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8kJnPZ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BrXHiydO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B52765C3;
	Sat,  8 Nov 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621887; cv=fail; b=YYyf1C5j48qSK7GODc9R4FU9IPXTgvMc17yB3lk+WDpcyKY014+tvBUZZRFb59YUUzWITEOR6czRksEwKjB586pGEpzPPljSAuslxCn+dfUXh9oko9982jXfUooUwvlzQNDgc9MDGx+dMq5OIhc0xVOONFHR+x//S6eh2Jhgjgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621887; c=relaxed/simple;
	bh=dJwfRNiI3WXPCdC9hAF5POoUcmBmxlnAw611TSol11U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cr+wx+JXeBMF4fk/t3vQ5RaVsqHQGcOi9y/gmUUz0oWg0x8mNEZO04P39bPGMr8FiYDCGCetH08WmhJfTR+75PBR47rI1cPCdv/k/zp4NTMkx51hoZ0OvlpyDsbgeOJD01auxUrdEwzTRSQAtn/fqTBbITxXZvKUpe7WIwVuEzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M8kJnPZ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BrXHiydO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Gj7fC004131;
	Sat, 8 Nov 2025 17:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3biM3jPk/T84wrFDEkrtg6nQEHWQ6QNNYccvVkfwbPk=; b=
	M8kJnPZ/BWkbS3fjW78BxI1er1G2KYM2SGUFKQHy2aCCmjjxrVPF6SnV6lL/47yb
	a+j1lVD80x5VLz1P17Y6MyoBYvvLNM+hCmbmDrNBb6Iy+6El99zP/Y7Ix+EfSu05
	L2gpA2ch4OPnKgyIZt1HDNqGY7gCWu2j82U8rbrNjM/wn6SRbt3hSO6AIX/vJhln
	mK7tNjzfIIDChndX2DByIdNQABd0jExIHdgX4q6dIb8PE6OB8aIHvuEbiKvvY2CK
	WxJuNejOLsa7VGamXZkcMXVLwVfQaGM7wIm18Z3Qpju8e1EdlpZ3Dnc6y21qIypy
	7uxzHsCkQgS7Ri4WZLfgcA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa0jy8etf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8BijdH007604;
	Sat, 8 Nov 2025 17:09:33 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOTfIvSvy7VEfVoDezXP+3qrV245+KgJ1iqNvUlbzA0VNOeCr22MBY10g3twKg2ImViFBBc0wThF2QwaIj8cLU7s2xtjldsN3y+P3UOng7QTZf2kVhe9MI9wihTco8JwavRkWJklUbk9F/s0pGjC8QL0liYHU3TRPh/VXVcjVDLJvGMgFELm0C3n3N2lpB6uE4Glo0l+115psK7OxtT2fbPFEX/4v4AzdV3yleAsDKVCcRV1cThQG2EnMDUvJTEHIY1p6P9RHUByFQBLBuieluxJ0YKdV7Bv121e2vnXYT8f47Np88cLpe+02aN8t8nEc4f/ZmTJy4rIi2IPdt0dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3biM3jPk/T84wrFDEkrtg6nQEHWQ6QNNYccvVkfwbPk=;
 b=NTF0fWHlRWkz/p3weoYYEy2ppQlrem+6OMDWeQlLWOhw3Tzi6LdzLGFhRKTW7D5i7jvVAymiJ7yIct94r/6AcSb2LfwvI/4/Jm9zmHoupqmQkDusfIo8isIBChqSVuq1x5pYJVpYl4aXa+VvM6sFzj7kvCg2kpSQRSi1/MQo1pGA+4cEUiFC7NecSiL4uo49sikuiQ5d/eN5kV0CI71V4526/KyvImdVL5RATQjY5G7dHCd0TxIEpZwZXRUshB+AqaHPOa5JJf9Ylkm1g2QKRYanAGM+vXOp/IDyJ3/2rdES1hfy/P99BwK0ppcD/DyyY5lRIqkqGZhYpQcMwT2Nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3biM3jPk/T84wrFDEkrtg6nQEHWQ6QNNYccvVkfwbPk=;
 b=BrXHiydOmNnv1Muz8aK2rSznTDnZxsE8wduq9tFfYZre8ajmwAid+xDa0zNlI5W4kr2UrZODuwa2WtaFrzzaLcyBGnEVrcqS42XzJ5laUNqP4ezLomEW133VEXvjfGG2YVm2Iwhxp5ObhLSwKT0VhQXlAf/6sLTp8wrxqyNYWtw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:24 +0000
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
Subject: [PATCH v2 12/16] mm: remove remaining is_swap_pmd() users and is_swap_pmd()
Date: Sat,  8 Nov 2025 17:08:26 +0000
Message-ID: <37c1c28bb6e159e9ad9c52955580971b2462dbfa.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: f3129fff-693d-4185-a3a5-08de1ee990f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H74mDRNhz2yI+4XbHgHwH3wKRQ+Qk1I0t6JnkWJWvrxXm63SMUD9k/wz5KWl?=
 =?us-ascii?Q?7pOKtv5OKW2BiBrZq+AogSiAYdlj3n8Z6w5Iw0IXREVTktyUrHweDvQGeaN1?=
 =?us-ascii?Q?93ZzrTK4x5WhyplFyOIYlEXm5m98GuJ+M2VZE9Tmb2GYwBiyZ6hExZSHMbEf?=
 =?us-ascii?Q?J3a3qXRpddrICdrgwUrLJ6P5SxOZu2Py96DdQZ2y6aV49+vyyDCVIHJE6Yw+?=
 =?us-ascii?Q?vXAGElJHLktazZ5WrzetQ+ei2+LFlF+nk1a9h5lipYwYUyVgtZCz0Bx2LieT?=
 =?us-ascii?Q?Iva6MkiKpBg+ITqw1HphlQ5ts052oQU3i34Cfa6YJALENRRQaozzpF85R3cv?=
 =?us-ascii?Q?iNuVL9O9fMWFwQqk+UhoJirniY2hiNx1MHm+4qmB+xr+8MnZy87C25+pZcQi?=
 =?us-ascii?Q?XSBGm8hJyrzHCvfSFfiYiTOnQF3IR7k6lr1osnG/qE9Hzu3Pb1X7BdMMT7If?=
 =?us-ascii?Q?UDMI61eCf6o/xjFgeMUgBsIfzAEubQchbFihPR40kPnCvjHTySfTRSrBg51H?=
 =?us-ascii?Q?9pN0+WwYOXXRzP+wCyPaYeMsxzBFzAm11aLw6qYjDZAfqZAYT1I3caMQ2kQp?=
 =?us-ascii?Q?QcJCbNp3SfpGJjJqLyhY8oE4m5vs3N1EOYC/zxUs1zZt03brfVqn8Tqddjsp?=
 =?us-ascii?Q?doxGsWD6RnK/UXmdLrkc50NVmEmoqam6tsEju5RZ92fJBIlryPxSp6wCE/mg?=
 =?us-ascii?Q?/YwWUFl1qgiaZx1Mr/MPwOh0RkbT2naSBqouTlGTHp/9ti7ShbZF1Ai7IWGD?=
 =?us-ascii?Q?jT+1LMxr4LP2euvpdobru5p71fWka4BXXlKf+Qq4AOKJi/bZqEoBNhzKFeyW?=
 =?us-ascii?Q?/EfJAuj4kQ2tVmVHsTxwa1XndYfFEsqBTuNf9MjP+JlZv2ihDp/fH/kJQip1?=
 =?us-ascii?Q?9noqZgjbtfnX/yHTamConLMP0HNM4optoVKFlw5bvx0CEWApcL8o1/42lmYP?=
 =?us-ascii?Q?VJjBKsMY1kC2TSR9nR1PNgCTygkGwtNIqdaEqTAbzYnU+QuYvhsXDyT+YP9Q?=
 =?us-ascii?Q?nA3hbZzRZ865mbdlIKnRDm2h9koIgMubImHKyCC+PCwyN2o2Ih4W5KoI+i15?=
 =?us-ascii?Q?p1jt382WR7EX4mZXHWS3d3IN/wnGr06WLkJuR0fuBpwmrInKcU7qJI/Vqltl?=
 =?us-ascii?Q?mOyAW20XKjPgSvKHxbXx1EwwhFsqbnnCHYHNI54jLSjBmNBqn8zT00Qn1wGN?=
 =?us-ascii?Q?J65iJ958BUFgxTbV7P8kEVWVHkCb7jByfFzJgmSOdhYuNNofQuVUrLJPbLv0?=
 =?us-ascii?Q?UbhHP0z6BygkJKZsLrkMTwuQQ2w4vwlHxcue8De6SS1SDFv2qMrUsxsrSnSR?=
 =?us-ascii?Q?kIMtbNZlJxqrYEu7UF1SUbO842cv//85F593Bt76YpEYhgjX17I7zK9q800x?=
 =?us-ascii?Q?hdzT/pmaCfx4KzWmFhgeJkDO/O9m4j8w3PJkxPImgAzDUWRUQsRXQhyfgEkw?=
 =?us-ascii?Q?chkr/j4fIcUMEsA/wnlxe6hx3sfdvp9S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odXf4rtQ70W0QzCFdSFbmObmBCcm6gM45K5WIdJz8fIg6N5kq4SIsZWY9uwn?=
 =?us-ascii?Q?8cw8SzA6JvB2D3DvxnT9qLT8n3NADffUXN/CVgZ62pNrwkjdbYT/rP5+RBZE?=
 =?us-ascii?Q?VfFd8H4zD8j7cfyMDcq+0naXyqMWDNE9yGvN60mgZf6i4+6iN77UCyuwwPh6?=
 =?us-ascii?Q?vLb/6yKpTnLVqMh/3uSSlEjFN06vJPjsmkIihAvAvee1y/Cr+NjzDqtwGUCE?=
 =?us-ascii?Q?uaVtlgSI7cSj1jEqo6NMSzCXlTAweFjFPpb5P36ihetod76WDk9L6vcHMBKe?=
 =?us-ascii?Q?B/OTIie6GXw4DSIxUM/l+HlU+IbMoPVLn2d2kM9Rlgu1YHbvz2zScPP3yQlq?=
 =?us-ascii?Q?NfQs8iFSNXp5qbkJZUnxzCT7pRp2L4cI/Fi+y9bHzwjpkuqZeM1LF3BBAwnq?=
 =?us-ascii?Q?XOJxQO1K3y8zIo87OSzLyG4/t6Srxyqqlg/72C1xpZlFmYg18/DjB9pQhIyJ?=
 =?us-ascii?Q?96Zjg8YXQQ1Gk0IIiZIKI0ygoD3dikHpVcLPw5bbLQZQatjdeBVisxgMUFQx?=
 =?us-ascii?Q?g7/ZerCXKpdR5jm9J2hhkmjyyZ6jFUR64Sq7RAwpZ1wf8TukS0m76S/c2h0b?=
 =?us-ascii?Q?JJtxxK+03Yz+bKjRf3WDu2E7IyeOlU02DRVxoFC6smFrJAK31sZEp3tVCk+u?=
 =?us-ascii?Q?iNhNadY0jeZIpFeWnmkEVLz4PJHsKItcYAHK9LdJOeFZkcpDN0afHJtQfkNX?=
 =?us-ascii?Q?EpP1ILgjNtArmdNEYHi+iKUzz/XBdz8qeKCHUaNh3DllMHjDBl45pOLmX5/q?=
 =?us-ascii?Q?1M2lymx71Kdef12uzmMjlE/Yf4JDPjwEaWM007GimwpK1hdhimr7f1ar5ZmI?=
 =?us-ascii?Q?T43fG5uDLE3WDAF/3grN7nPeqYOQsVssc0n6/CEhyiLBhQ3NIsvqLNCsc+n4?=
 =?us-ascii?Q?PcI1/szQkXsHybWE7b726RFFF+PaVvtZzMpV7RCpjgbBickG5K3XpsgmZo0y?=
 =?us-ascii?Q?wKsvHzM2hgvvdPQmN34V0uhJ5JPMoMYfgu82A9NFjbMsZO41tZcDuJTLutD7?=
 =?us-ascii?Q?sBamMEJKhs52owH1axXerWDcWW1hUK+wlQMBaDlhbQJJY6Bqav9fY2QZ5oRG?=
 =?us-ascii?Q?DjQOaAgkl0BoF8Vg9CVg9OURa05dczbhXkfR8DxgoAPkHkFB6UOwhVY822M9?=
 =?us-ascii?Q?AIrOYz+8Fq8tFFmDewS4RK2n1L8hVLasJQx5CxSBw78uCS8Yf+eDUNFbBykT?=
 =?us-ascii?Q?oEUo3TAsV8nE/QOwGT9lozPYDkjxPlAoZjF8l9UCgo9wFokT2KQRQd5qtIlS?=
 =?us-ascii?Q?6KyuC7/7ahHyVJCQXIbqv8w8zYhx0Inw5f1nRjwa8jGpyhUP4eXdzCB2ED8y?=
 =?us-ascii?Q?XLZa9OY/eNxE+/KSU3qNCn32WCMZ7TBSkRXQXTjALFCbZfzqL/LkkYe0NmOb?=
 =?us-ascii?Q?fE0TCNiHvHbZk7+prw+87K/Xlaq2MTrjUOSdbYpEV83jmO3adCJxfjoVL4Jv?=
 =?us-ascii?Q?19CrqZdNyKB+OEUbHew7Z2IGMD2mWxo2vnhrUmicN8S8QUiWY2JADsQ3IbI2?=
 =?us-ascii?Q?u9zdGVJkFb2M5z/Z/LTpKvNtptOxE64GwgcCKkTyYDX3N5z2KmnsM7W3jSdE?=
 =?us-ascii?Q?HmA0awWrHwnSMItTQrt1OQT4DhBUI+QBG3OUfMtpfR8wJT1qklApeY0EAapL?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I4dcnvOX6jKLSwYUDBvbBPYgofnVL2RBh+afbU9m+zxxMIVuty1psTdvVYmeNUSWJaKdZlU/sfpYLgoHBwo5jklK0KiaxxBYWIUHxuPS/z4KzktTzLszA+lkyCTdgHRXwz6oMg1Vh5X/yZLnWFi/Tga99awbpfJDjcSjZV8xadvC8dI5bpVPWrgWuY61/Xe88bD1u3qYx3YAOE56jpoTfiOdggxIHjfoI8QJO+zLSvjQEVHlnIR5f8xhLRrzIbkyCVNI5qoz4Rfm8A9ekPOOBgIk805I3ghvmtM3orEj9tUYdylmWYkDBLCDw2iempXHaIlidk3kLqhUoLYquM2EGN2IQwZ2zIWNSyCecjZDwtw+6NnL9/Vek5/wNG6dhqcoFgLf8T5NhzuK8604GMQ0j6O1qOiQVNRvO0q4AuLFwLH2t5E7PQKUcma0NzQ67O/qreHtCuEKCdhy6A++qkS4gH269EPsHol6bY3JST25zb0OTM00Q9fFTtVge+z+iS2UGElqmXfcdDHXqFm7AIsMYW8b9SGYQ1zDXZvTCX0lFoMwT5WhAAunUaNXDDprf/a6Lw0f8it65cdmN0EU7Mels5hK37pDsPKhLGu6GAecGn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3129fff-693d-4185-a3a5-08de1ee990f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:24.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKE/Kd+tv4cyUohNPFieaJ3Nyib8EH7eW7C+F7KI0Xx3y/y/KuNFd2MbF9TWXv60pqJuSeff52wmUFG3OSI1mP9nwj0sDxA3ys/0gyOwB8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1MCBTYWx0ZWRfX/QdaXZo69Qd/
 hJ8TX+P4lkkZmCjNrwbfQjK0jCXf6xxdFlJJTjBC+23YWi1fp9UW3OLNx2DXRIEO+CPcqIKzwwp
 EhxTkLmFtB/j4DkNA61Mv8mE/Ftp1k3m1su3zAUhO1r4W9aZj8TpxZlP5AKXYIxDx0jOxo8pleE
 rT2e361270wiRrifmFl4by4IeOIpADq3Udh9sxeNX3X1lL3hP3OccTwtI7pc+kQFOF15GNlCxSm
 3sj8DqVSTcd0P1FVepqqb3F8/nad+RFy+ia5T6kfCUhggdUvq6/8/68km1b8ty7FsxbD+M9nUU5
 7i8yfrkDrjEeEcHn4oG7CVyg2OFgoW9DaKVlz664uXwyE8C/27kK3nugrsVAez+3wRVkRTc5cNZ
 7n2JTP8QyzMWBwtjD1wYOFRXtYnJZA==
X-Proofpoint-ORIG-GUID: rNwLXU3ZElVPKduMOgyiyv--k3gIkyfo
X-Authority-Analysis: v=2.4 cv=IpkTsb/g c=1 sm=1 tr=0 ts=690f794e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=xbP9_UvFYPnkkC6NLJ8A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: rNwLXU3ZElVPKduMOgyiyv--k3gIkyfo

Update copy_huge_pmd() and change_huge_pmd() to use pmd_is_valid_softleaf()
- as this checks for the only valid non-present huge PMD states.

Also update mm/debug_vm_pgtable.c to explicitly test for a valid leaf PMD
entry (which it was not before, which was incorrect), and have it test
against pmd_is_huge() and pmd_is_valid_softleaf() rather than
is_swap_pmd().

With these changes done there are no further users of is_swap_pmd(), so
remove it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h |  9 ---------
 mm/debug_vm_pgtable.c   | 25 +++++++++++++++----------
 mm/huge_memory.c        |  5 +++--
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 403e13009631..79f16b5aa5f0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -486,11 +486,6 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
 spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma);
 
-static inline int is_swap_pmd(pmd_t pmd)
-{
-	return !pmd_none(pmd) && !pmd_present(pmd);
-}
-
 /* mmap_lock must be held on entry */
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
@@ -693,10 +688,6 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 					 struct vm_area_struct *next)
 {
 }
-static inline int is_swap_pmd(pmd_t pmd)
-{
-	return 0;
-}
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index fff311830959..608d1011ce03 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -74,6 +74,7 @@ struct pgtable_debug_args {
 	unsigned long		fixed_pte_pfn;
 
 	swp_entry_t		swp_entry;
+	swp_entry_t		leaf_entry;
 };
 
 static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
@@ -745,7 +746,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
 
-static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
+static void __init pmd_leaf_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -757,15 +758,16 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
-	pmd = swp_entry_to_pmd(args->swp_entry);
-	WARN_ON(!is_swap_pmd(pmd));
+	pmd = swp_entry_to_pmd(args->leaf_entry);
+	WARN_ON(!pmd_is_huge(pmd));
+	WARN_ON(!pmd_is_valid_softleaf(pmd));
 
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_leaf_soft_dirty_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
@@ -818,7 +820,7 @@ static void __init pte_swap_tests(struct pgtable_debug_args *args)
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-static void __init pmd_swap_tests(struct pgtable_debug_args *args)
+static void __init pmd_softleaf_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t arch_entry;
 	pmd_t pmd1, pmd2;
@@ -827,15 +829,16 @@ static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap\n");
-	pmd1 = swp_entry_to_pmd(args->swp_entry);
-	WARN_ON(!is_swap_pmd(pmd1));
+	pmd1 = swp_entry_to_pmd(args->leaf_entry);
+	WARN_ON(!pmd_is_huge(pmd1));
+	WARN_ON(!pmd_is_valid_softleaf(pmd1));
 
 	arch_entry = __pmd_to_swp_entry(pmd1);
 	pmd2 = __swp_entry_to_pmd(arch_entry);
 	WARN_ON(memcmp(&pmd1, &pmd2, sizeof(pmd1)));
 }
 #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_softleaf_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
 static void __init swap_migration_tests(struct pgtable_debug_args *args)
@@ -1229,6 +1232,8 @@ static int __init init_args(struct pgtable_debug_args *args)
 	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
 	/* Create a swp entry with all possible bits set while still being swap. */
 	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
+	/* Create a non-present migration entry. */
+	args->leaf_entry = make_writable_migration_entry(~0UL);
 
 	/*
 	 * Allocate (huge) pages because some of the tests need to access
@@ -1318,12 +1323,12 @@ static int __init debug_vm_pgtable(void)
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
-	pmd_swap_soft_dirty_tests(&args);
+	pmd_leaf_soft_dirty_tests(&args);
 
 	pte_swap_exclusive_tests(&args);
 
 	pte_swap_tests(&args);
-	pmd_swap_tests(&args);
+	pmd_softleaf_tests(&args);
 
 	swap_migration_tests(&args);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f0bdc987596..d1a5c5f01d94 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1875,7 +1875,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+	if (unlikely(thp_migration_supported() &&
+		     pmd_is_valid_softleaf(pmd))) {
 		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
 					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
@@ -2562,7 +2563,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (!ptl)
 		return 0;
 
-	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
+	if (thp_migration_supported() && pmd_is_valid_softleaf(*pmd)) {
 		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
 					    uffd_wp_resolve);
 		goto unlock;
-- 
2.51.0


