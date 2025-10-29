Return-Path: <linux-fsdevel+bounces-66352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0BC1CB21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45054563D82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F15354AD7;
	Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PEJNOWbD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LAN+HMkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153802F8BEE;
	Wed, 29 Oct 2025 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760328; cv=fail; b=gkCabexGkrYYCruG5uzlsZD55UoE0NbhWKoKCkpSdSXj7NX0Oi96exciNnZZU24jZRJ5sXx+XPfRHyUvSenF0pNMu5+WnoE2Dx5zgLR2xHLO94bEz7cu0B4DlRavQlQfGypBtGx21Jbn/5jjJKEIkYoGZcxQMaBrXEudmNOPZqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760328; c=relaxed/simple;
	bh=DwmgL4RP68v077QgOthDyzHzZ/NPY7hKuzUpS31NBIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BpxVh/X0disWA8jYkqhsaNwAs+MkzWLcxCrzkoX9LyFgVDqKivsJxXC5vdFDsc2T0OE+IMkS6SyarBhKfLjuuw0Y3Jz3DOGrLZIr9hXoC2+bGhc0OvqABb2KunmklL+gHrK7D20TlxHogM51Vv5N0n83TpuxbqZYJ690EEU9QI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PEJNOWbD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LAN+HMkj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfuN2006721;
	Wed, 29 Oct 2025 17:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j2qAk1cytts2bD+t4x10jLhzh4N7fs4lXwOf4/99aQs=; b=
	PEJNOWbD+l7Z+jRrKYqZ0civg/cYTc6yrtFHPs76iffQFZ3XYCdnr7U0vh2uYOK6
	4GUNUCt4eOajAYaeqIca/WQjDK2yrDAO4+zLy9c+ZLzTNGUnevQipZe1wqosuTGk
	NRrLpBmv6vOC8xhQ0h/pCwY3t9yVV5N6VzqjvYpLjzz0goo49ojZWeX/5/caUxS6
	yH7KfsOqs2NAm4shyolPFhP58+L5GJa5qBY9xln7Kp/yqkQwrBoijtXt+nmEmao1
	EFA+5QOER59PsnDuhbidAAHgkGZc3wP7XxsnyicC7inbGxkcOvpVK6loyg3M4Y1s
	7K7hJwr6bRMFpcjbXbCvHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cbthr7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:50:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TH1KdM031648;
	Wed, 29 Oct 2025 17:50:07 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34ec96s7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 17:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzwzEfQLNevDPlHny10TXfwSWXYWwsLMxynDZGTwTElktp5K2QQZdyvx/4dnWWRUAj4qnFseKBWG2PaUXgeONu5kGuFVHc8Fizq/WaMVMYHI3T8q8GkyG2lV0etHlFPqkFhUIy8pg5uw16EijghexJuwryAiXvJk4uSESq65cBemE7Z6JM5iDtcEmOLzn9r9aGZSxoNdrNsQj0VzTkv/8hctsy4idFl3K2x4MEX+HkayWsS1bWgNlcxHF7cVLtNqFDYsmULFutkmAXaPQqVCkxSTqJWYqgXzpe7Hbtp8QdTidlVvhnmnTBP3d2e7q6eSiDqxeYx+nQ3JaGbG8/H4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2qAk1cytts2bD+t4x10jLhzh4N7fs4lXwOf4/99aQs=;
 b=nV1DKZzYMvzquABdFdp/FQl/uZSLTJriXobSAughIA2g6VGuVxfM8Xy/zjH8oJ+jWrRyA4OFfk49M4dfm4ic58axzBLNYRYhlfA/g/ZPyllgh/DHGQOeO1r15PmisOYb1wvivJajzhzyC3LLWlOh0M/2qCkRfBdGfRsB8CvNN1UbFcHunuu0PuzIvU2oZ4xW2+mfrMmv6ao9nnDOsUZbAsXovfCsNBJb1iDJYSzuPGMNTXxVDZcSSklLf5LwmAObR5rwtM/NqPA70kKSZnkJvUJsN6jOk4514g0zfkVWbyen336717kOoLAL+Z/HNmoQ/M+VeuzCpgZ4DZID6LCsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2qAk1cytts2bD+t4x10jLhzh4N7fs4lXwOf4/99aQs=;
 b=LAN+HMkj1ATtIh0X7SJupkBv9+iDcalKT7ZYITSLSLppDFUXaoeJq93Z9qAjgbbjir6S5cV9tzWv/kCzDxUayB0Dnk0P//VdEOq+qPhNNR5Kcfr400useIdNCrdxE6fsCp3ITFw788nolW9dcewy6Hh8HOysk8d+o5If2UJYcDw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:49:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 17:49:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Date: Wed, 29 Oct 2025 17:49:38 +0000
Message-ID: <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: f79db81c-d4c2-44ce-7ff6-08de17138e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tUq4oS05h6m85P35rGL5KiNLEsuos0wrIUSKelgjpUErtx1j865Q+87gABpe?=
 =?us-ascii?Q?d7yM/4MEP0o+wnYMsSzqI0ExcLTJZedUSxl/KtmvJD6CzmGFtUVSmTwJGBBA?=
 =?us-ascii?Q?WIOLoa79/W0TRT3duKY3O7JTiVwpdFi1roos+VAFrx/BzQTclw+sqsiUB3Xd?=
 =?us-ascii?Q?n7zxQcMf8mjS1LZAW97yTvgNe/gtAh/A21DPFqdrHh+QcNbkucfL3fNqrHMe?=
 =?us-ascii?Q?fdPEeJ/oA50a0lYKtgI4/ze5s+dIngpPGep+JCs033Vo91DB/qwH2QVBRY2q?=
 =?us-ascii?Q?5VJB0IXKxKcIhoy+TcFmoIYaEDXpvTzKHZJctpay1EopoJ48gpRkshGlo6wW?=
 =?us-ascii?Q?kvsJIHs5h1aD8//uI9nkHUEsNvZ5ehFTkMfy3IEOYbAJIvI3xae+8iWolrlW?=
 =?us-ascii?Q?PiDqoeze95jGyHEtEAbRZVuN91vRhk7kYeqM0/caEPC6a1FiHeNR4E6mWpQh?=
 =?us-ascii?Q?yte4GfVHKkgCtmFArbB+KAm1L2rpQegPc+Y8Df/litc2Ao6tLQqHSx+8cOLZ?=
 =?us-ascii?Q?ulAmnzH5vPoQT7QUqHEEjzTEN7s5Iz0nn2XkC6Iffak+TWI9RZ8TczcupDBF?=
 =?us-ascii?Q?cp3a+ypPxkK/MxhyXXgz+CpWi8WUE9Hmf6fOXtmqWxYIF8wSTVWr2TbRsD0u?=
 =?us-ascii?Q?LBEAvyz6KNrRyIEmk9Y5xrDU9xvjdFRcaizSXRMz4ZNLTFN+LdDRfZL+BbL4?=
 =?us-ascii?Q?59XgZBqLq6iouX7j0tNgcBRMZbmLupYcTHFWwuTMC1dDhnyOh5UtwXOHYA9q?=
 =?us-ascii?Q?eHCysRMF6sLUP2z07Uifs8SnPKRny1XCG4A06+CctradAeR/DGUR1DuxnFtY?=
 =?us-ascii?Q?jo2abJi2NIVASLn+gaZgZGNjXrK3py8LEAJMiWlrCf8+FoFXvHB4fmCiNwca?=
 =?us-ascii?Q?Ss9Mzp3ebc1Z3cRZpUEVpiv09g1KMFxow7b4GLdqmHQfW46QwoKv3mCgZJd2?=
 =?us-ascii?Q?7JNOMm4uz1Bka9P6ZDZFQoft/W5p84tdQgrjCI0af4opPD+4NY2tMjBUPRfG?=
 =?us-ascii?Q?DICWY8eFA3WxcdVu1O10GGDYZHFH58ni3cxiF8Oa06N6eYBv0q96VV78xuOk?=
 =?us-ascii?Q?uccYmlt3hqHDC2d+8wqfv/6YBqlcbvg04DhAo9YJiZ4Vh5dT6k2TvN3uiNVV?=
 =?us-ascii?Q?O9X3tXB6zp/Yif/l8trP4XT2CLltKFBNyJ5xdH4gM3AUhb+xljl27sNS9Gwo?=
 =?us-ascii?Q?uUPn/QSOJopvsMscwp2k3XB8Q8zdhSS+bpJsuUWLVw3XllgZuV/8PaE3jswb?=
 =?us-ascii?Q?b8xUBWWMMYIjDRXCpUN7+3FiPUy67/p/kDOiYjcPDCCN/13JSg3ik4NYoKhe?=
 =?us-ascii?Q?StkiWmQxC86ALfFy1JN5MkCNBB0KqQUFhiYopNWoPHiuqBi2ZI2wnLelFft/?=
 =?us-ascii?Q?hV05Jl0J9RYRIImFbf8jmJwrxRAt4bXwOfdD2vaEl66TiV4ojLMm1lm3e5Rt?=
 =?us-ascii?Q?xM4/V7uDhNel2smujOYAaOybOkP0GlJc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aeNsIgOH2scVdSbqXK6TLppnJPoi4RAJ6DOn6dw9uISOudPiFlviRreoZBES?=
 =?us-ascii?Q?0vFV3aqvj05FlZSj52sunxGMATSH/uSs7nI0g2BAPs7m7FBoDS62tYqnzu3l?=
 =?us-ascii?Q?b2+zn5bRpstTXmsi7XHQwJHORNm8Z/ucGECD5xRv7+2YpWY2P/jjjaqFkAVJ?=
 =?us-ascii?Q?hJO89RqZQhE+jU1anJB7TXMXP9Yx9Q0WyOTD7dMQR5Y9BHSISZWPX+GKsjfq?=
 =?us-ascii?Q?cOOnKXcYvfKxaT0VuGlWUKAhxJJjDeQg616bxFFPZJVaz+CIl87OoKJoWqtt?=
 =?us-ascii?Q?x6HDc3uxgDsz8ec5Ls/88wmdBax1fA1NL/oDbib8+jMS3ocG7dOnvLBTFjdN?=
 =?us-ascii?Q?0GhRUbGQGYfXCULxOS/nEN4x97LGhssPe8EgW8a1DTVXudPH294pDBFefMop?=
 =?us-ascii?Q?BoxyrVpjI+0/OuWw61RtbnJ42XA4Ie83POHa0l3YRjkq4IAlnSS14FVxBuMd?=
 =?us-ascii?Q?AFmW5cacRDxdwHfnC2K6jeYcatwAnSRmIZtJZuhSJJgsePHGIydOsfLf/1cQ?=
 =?us-ascii?Q?Zt6cLFy7w0JfXBJFvIrir+3nGqrZWJG7iSAzhq0QxD5UwbXTclknLs2ZVWnq?=
 =?us-ascii?Q?BeWa6MYQ+bMKp9ly3Pl8VDtRCFFNV3dyHghFvtPt6aQYguBbdwl5XtkwHIgE?=
 =?us-ascii?Q?gDyPh0qs+Pln/xIiOCuu2OkWPiwH6vEckLeMBmI7t4XzTeonIf+iuuw1bKf5?=
 =?us-ascii?Q?zxkBdfiSzjXo3dj7IcFsEic5iXpHBiJpt+xLZoJzliOiWFY36mRstd3WDirI?=
 =?us-ascii?Q?hBOJBQOq+tjzo+qKZwrTGI0spoNofqBjlwEwz1/XJn83rxbooZQdt1KpcZ8L?=
 =?us-ascii?Q?FP2slOPs6lbYElGF89gSIXofc3+xkS/KzBa6Mfz0RnyX0Bf4nEClziAfU8mK?=
 =?us-ascii?Q?z+eVXvifKiwWlev09GKSDYChP3D4772NtOS70P7yv629F9JcZEXDO8KKF7oW?=
 =?us-ascii?Q?Jvov3utt2LDba54A9kq2jIQ3Qg/DgHUGuCqOVutevPR8hUNREh1PCM0CC5NG?=
 =?us-ascii?Q?TTPwq503kMeey4CILdAlWHrK/xVcNNo9zjQF30jW2KZ8pPOJHUXRzpOVEyYd?=
 =?us-ascii?Q?MNdoaMtjJQ3btGBsldiU2wMVO5DwQZQfm3XE/7wMjKq8AEzAtebklT71PLyw?=
 =?us-ascii?Q?R0pT5nOpluzBr6dbPZtMf5r0lNRZNSdob9rzesO8xnxMAg6iPutovA09GZv0?=
 =?us-ascii?Q?PaZeLJ4TF/jBMZdnDdyD9n0WMpSwK5yygUJOfydGJewmfw7spjhacoJ2gWUp?=
 =?us-ascii?Q?Wu5D26T0sDnOFtQlFuVhfL5XkxoXrpULhNU1W42qgmdlQotjhhPSQLMnm9jm?=
 =?us-ascii?Q?r+6Ii1sMC+Aqqfn/noXEpGNVzqXBBwvR96RQlvK1AsTKHwcz3nia7iNyZrgf?=
 =?us-ascii?Q?R1ocSX7YXYr41SEnK/Eikh/xvZPUu6q+gMC55PpS42FYx7FZ2Cu/XMcwHmiV?=
 =?us-ascii?Q?GqDYiuKXqu9/dbwzXEhdATXX1w5tmHvl59i8ENova7waE6RPrgQCn/A12ZYf?=
 =?us-ascii?Q?lYV0jXoFe0CvvpEsvWFz2fXDBjQd2T6PA7u2jj3Tp5Lk0SN/+EHO/4IF5ors?=
 =?us-ascii?Q?BIS86xlciACPNFe4kN2osL1qO7mRM8syvv+eeUb+pphZa6VyI1oGA1h5+7W3?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2+mB9wa9wDVJQs9d1CKWJosiXGIrNRfCqWkkq1myBndQ4hXfrBr3yUS75K6SfgLRCP+dFWSiwwVr/Uqcsxmb7dNNAcST0YNpFWXgEuepxlhcoQ9HOEQKVTXKR7fdHUQt8VAvjpr55l0u5MYhs8Zbe/7CrSgpJzRbH8i7LDnG6KrYpvRQ9+uZ4mY/3UgxV3ioaybvLuNPDi4akTD1QGhoy5vC9BxFHyZFpczQOq7gyd0ZUzMWomTVBxpTNnFz6+1gk4viU84xUb3FDO6cYAm/c7TuuFoaWrsXLZ4026O7vjiP4dRUgTEjO8FUuTqc03adIgKB2CaYc56tJjrgzCBV3Wi34TXojkh3pky65zJuL1VFif+5dBJLYY/9ru9efOjhAdgZkvljIXqCdXG6++0WUkiyWGP2Yqgww9voR73M4hQ2gVf058EZm7rKrT+C9Eg5m4Zkql0Zhja29rXnSXrusx2+AOHQz8Uyxs6t9jP+J7tmqgVXtOX9AajwGY4rqwsczRPrM2acbS1ttyxMU+3g6mvi7hq4dobRU5w8KVviR+mJVQPvSup/iYtB8LpeH5uDgejPXX9ya0y7VAkSvKW/oIfWHhW1tnlrAEYhDju+9Z4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79db81c-d4c2-44ce-7ff6-08de17138e6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:49:49.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upO7Bm/uDqMKzGhT1Qs7QGqU+yehwxHxtdVJBmAgg9j4d/0iLT+sYz+z9mZK7g2wf10zDDWEV3UnP/L5nytDzcu5w6AFU9YO/1Svj7m/7vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290142
X-Proofpoint-GUID: gF5Y1PhTYDddZVLgcPeavW_WBvgKEOgk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNSBTYWx0ZWRfX1VAZwdOsvIpz
 Kmn/BY06iHtITo7OriSh05/bqaWjlXlY9U4ojtS5i4WTLB7ALdW7lHr36iv4y1FebetR4R9xMLk
 NnS5T2qAh6b2C+BZaxHT3zJLVZ52z7IJxrAMdONCAY+ckTHr0Yokp+EUSUgPIcA+2BXDUf6X+Dx
 mqa1VsmUQ/qmtTZV5AXr4sztFh7fGeI/ylCtfJZyQb3v/oZK5DaVi8eYDTlrZA2Zx0GpDvfWcTi
 CCenldsxwGw7e+Ps9U9sChASwMQbjNAFnbUqmXxBzIXJdDRED/FDyRu9PB5+O4v5vcM/OTdThXC
 UvwiufwBxAGmAoYsp9D6STdaEyBbZwrfNfrw2Tf6QRl6NMIWp+PgIMAcbP3G+xXxygNNVqF1lu2
 zjdhKYh7bb/y2b8VeNyfQ5T3eZ55iVMRB4kQmvJumEr3zPwm/9s=
X-Authority-Analysis: v=2.4 cv=A8Nh/qWG c=1 sm=1 tr=0 ts=690253d0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=FV82qsRD3BYVcrOOTa8A:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: gF5Y1PhTYDddZVLgcPeavW_WBvgKEOgk

We introduce vma_flags_test() and vma_test() (the latter operating on a
VMA, the former on a pointer to a vma_flags_t value).

It's useful to have both, as many functions modify a local VMA flags
variable before setting the VMA flags to this value.

Since it would be inefficient to force every single VMA flag users to
reference flags by bit number, we must have some operations that continue
to work against bitmap values.

Therefore, all flags which are specified as VM_xxx flags are designated to
be ones which fit within a system word.

In future, when we remove the limitation on some flags being 64-bit only,
we will remove all VM_xxx flags at bit 32 or higher and use these bitwise
only.

To work with these flags, we provide vma_flags_get_word() and
vma_flags_word_[and, any, all]() which behave identically to the existing
bitwise logic.

We then utilise all the new helpers throughout the memory management
subsystem as a starting point for the refactoring required to move to use
of the new VMA flags across the kernel code base.

For cases where we either define VM_xxx to a certain value if certain
config settings are enabled (or other conditions met) or 0 otherwise, we
must use vma_flags_word_any() as there is no efficient way to specify this
with a bit value.

Once all VMA flags are converted to a bitmap we no longer have to worry
about this as flags will be plentiful and we can simply assign one bit per
setting and eliminate this.

Additionally update the VMA userland test code to accommodate these
changes.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/hugetlb.h          |  2 +-
 include/linux/mm.h               | 41 ++++++++++-------
 include/linux/mm_inline.h        |  2 +-
 include/linux/mm_types.h         | 42 +++++++++++++++++
 include/linux/userfaultfd_k.h    | 12 ++---
 mm/filemap.c                     |  4 +-
 mm/gup.c                         | 16 +++----
 mm/hmm.c                         |  6 +--
 mm/huge_memory.c                 | 34 +++++++-------
 mm/hugetlb.c                     | 48 ++++++++++----------
 mm/internal.h                    |  8 ++--
 mm/khugepaged.c                  |  2 +-
 mm/ksm.c                         | 12 ++---
 mm/madvise.c                     |  8 ++--
 mm/memory.c                      | 77 ++++++++++++++++----------------
 mm/mempolicy.c                   |  4 +-
 mm/migrate.c                     |  4 +-
 mm/migrate_device.c              | 10 ++---
 mm/mlock.c                       |  8 ++--
 mm/mmap.c                        | 16 +++----
 mm/mmap_lock.c                   |  4 +-
 mm/mprotect.c                    | 12 ++---
 mm/mremap.c                      | 18 ++++----
 mm/mseal.c                       |  2 +-
 mm/msync.c                       |  4 +-
 mm/nommu.c                       | 16 +++----
 mm/oom_kill.c                    |  4 +-
 mm/pagewalk.c                    |  2 +-
 mm/rmap.c                        | 16 ++++---
 mm/swap.c                        |  3 +-
 mm/userfaultfd.c                 | 33 +++++++-------
 mm/vma.c                         | 37 ++++++++-------
 mm/vma.h                         |  6 +--
 mm/vmscan.c                      |  4 +-
 tools/testing/vma/vma_internal.h | 52 +++++++++++++++++++++
 35 files changed, 340 insertions(+), 229 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2387513d6ae5..f31b01769f32 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1349,7 +1349,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr);
 
 static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
 {
-	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
+	return vma_test(vma, VMA_MAYSHARE_BIT) && vma->vm_private_data;
 }
 
 bool __vma_private_lock(struct vm_area_struct *vma);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d4853b4f1c7b..8420c5c040eb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -984,6 +984,18 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 	__vm_flags_mod(vma, set, clear);
 }
 
+/* Test if bit 'flag' is set in VMA flags. */
+static inline bool vma_flags_test(const vma_flags_t *flags, vma_flag_t flag)
+{
+	return test_bit((__force int)flag, ACCESS_PRIVATE(flags, __vma_flags));
+}
+
+/* Test if bit 'flag' is set in the VMA's flags. */
+static inline bool vma_test(const struct vm_area_struct *vma, vma_flag_t flag)
+{
+	return vma_flags_test(&vma->flags, flag);
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
@@ -1021,16 +1033,10 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
 
 static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
 {
-	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
-
-	if (!maybe_stack)
+	if (!vma_flags_word_any(&vma->flags, VM_GROWSDOWN | VM_GROWSUP))
 		return false;
 
-	if ((vma->vm_flags & VM_STACK_INCOMPLETE_SETUP) ==
-						VM_STACK_INCOMPLETE_SETUP)
-		return true;
-
-	return false;
+	return vma_flags_word_all(&vma->flags, VM_STACK_INCOMPLETE_SETUP);
 }
 
 static inline bool vma_is_foreign(const struct vm_area_struct *vma)
@@ -1046,7 +1052,7 @@ static inline bool vma_is_foreign(const struct vm_area_struct *vma)
 
 static inline bool vma_is_accessible(const struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_ACCESS_FLAGS;
+	return vma_flags_word_any(&vma->flags, VM_ACCESS_FLAGS);
 }
 
 static inline bool is_shared_maywrite(vm_flags_t vm_flags)
@@ -1441,7 +1447,7 @@ static inline unsigned long thp_size(struct page *page)
  */
 static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (likely(vma_test(vma, VMA_WRITE_BIT)))
 		pte = pte_mkwrite(pte, vma);
 	return pte;
 }
@@ -3741,11 +3747,11 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 
 static inline unsigned long stack_guard_start_gap(const struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & VM_GROWSDOWN)
+	if (vma_test(vma, VMA_GROWSDOWN_BIT))
 		return stack_guard_gap;
 
 	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
+	if (vma_flags_word_any(&vma->flags, VM_SHADOW_STACK))
 		return PAGE_SIZE;
 
 	return 0;
@@ -3766,7 +3772,7 @@ static inline unsigned long vm_end_gap(const struct vm_area_struct *vma)
 {
 	unsigned long vm_end = vma->vm_end;
 
-	if (vma->vm_flags & VM_GROWSUP) {
+	if (vma_test(vma, VM_GROWSUP)) {
 		vm_end += stack_guard_gap;
 		if (vm_end < vma->vm_end)
 			vm_end = -PAGE_SIZE;
@@ -4429,8 +4435,13 @@ long copy_folio_from_user(struct folio *dst_folio,
  */
 static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 {
-	return vma_is_dax(vma) || (vma->vm_file &&
-				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
+	if (vma_is_dax(vma))
+		return true;
+
+	if (!vma->vm_file)
+		return false;
+
+	return vma_flags_word_any(&vma->flags, VM_PFNMAP | VM_MIXEDMAP);
 }
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f6a2b2d20016..cbe7cb6dc9c7 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -608,7 +608,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 
 static inline bool vma_has_recency(const struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
+	if (vma_flags_word_any(&vma->flags, VM_SEQ_READ | VM_RAND_READ))
 		return false;
 
 	if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1106d012289f..e4a1481f7b11 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1029,6 +1029,48 @@ static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
 	*bitmap &= ~value;
 }
 
+/* Retrieve the first system of VMA flags, non-atomically. */
+static inline unsigned long vma_flags_get_word(const vma_flags_t *flags)
+{
+	return *ACCESS_PRIVATE(flags, __vma_flags);
+}
+
+/*
+ * Bitwise-and the first system word of VMA flags and return the result,
+ * non-atomically.
+ */
+static inline unsigned long vma_flags_word_and(const vma_flags_t *flags,
+					       unsigned long value)
+{
+	return vma_flags_get_word(flags) & value;
+}
+
+/*
+ * Check to detmrmine whether first system word of VMA flags contains ANY of the
+ * bits contained in value, non-atomically.
+ */
+static inline bool vma_flags_word_any(const vma_flags_t *flags,
+				      unsigned long value)
+{
+	if (vma_flags_word_and(flags, value))
+		return true;
+
+	return false;
+}
+
+/*
+ * Check to detmrmine whether first system word of VMA flags contains ALL of the
+ * bits contained in value, non-atomically.
+ */
+static inline bool vma_flags_word_all(const vma_flags_t *flags,
+				      unsigned long value)
+{
+	const unsigned long res = vma_flags_word_and(flags, value);
+
+	return res == value;
+}
+
+
 #ifdef CONFIG_NUMA
 #define vma_policy(vma) ((vma)->vm_policy)
 #else
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26a..80a1b56f76d3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -161,7 +161,7 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
  */
 static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+	return vma_flags_word_any(&vma->flags, VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 /*
@@ -173,22 +173,22 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
  */
 static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+	return vma_flags_word_any(&vma->flags, VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_MISSING;
+	return vma_flags_word_any(&vma->flags, VM_UFFD_MISSING);
 }
 
 static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_WP;
+	return vma_test(vma, VMA_UFFD_WP_BIT);
 }
 
 static inline bool userfaultfd_minor(struct vm_area_struct *vma)
 {
-	return vma->vm_flags & VM_UFFD_MINOR;
+	return vma_flags_word_any(&vma->flags, VM_UFFD_MINOR);
 }
 
 static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
@@ -214,7 +214,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 {
 	vm_flags &= __VM_UFFD_FLAGS;
 
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (vma_flags_word_any(&vma->flags, VM_DROPPABLE))
 		return false;
 
 	if ((vm_flags & VM_UFFD_MINOR) &&
diff --git a/mm/filemap.c b/mm/filemap.c
index ff75bd89b68c..901d9736ec77 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3365,7 +3365,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	unsigned short mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
+	if (vma_test(vmf->vma, VMA_RAND_READ_BIT) || !ra->ra_pages)
 		return fpin;
 
 	/*
@@ -3407,7 +3407,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	 * scenarios. Recheck the PTE without PT lock firstly, thereby reducing
 	 * the number of times we hold PT lock.
 	 */
-	if (!(vma->vm_flags & VM_LOCKED))
+	if (!vma_test(vma, VMA_LOCKED_BIT))
 		return 0;
 
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
diff --git a/mm/gup.c b/mm/gup.c
index 95d948c8e86c..edb49c97b948 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -590,15 +590,15 @@ static inline bool can_follow_write_common(struct page *page,
 		return false;
 
 	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
+	if (vma_flags_word_any(&vma->flags, VM_MAYSHARE | VM_SHARED))
 		return false;
 
 	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
+	if (!vma_test(vma, VMA_MAYWRITE_BIT))
 		return false;
 
 	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		return false;
 
 	/*
@@ -1277,7 +1277,7 @@ static struct vm_area_struct *gup_vma_lookup(struct mm_struct *mm,
 		return vma;
 
 	/* Only warn for half-way relevant accesses */
-	if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 		return NULL;
 	if (vma->vm_start - addr > 65536)
 		return NULL;
@@ -1829,7 +1829,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * Rightly or wrongly, the VM_LOCKONFAULT case has never used
 	 * faultin_page() to break COW, so it has no work to do here.
 	 */
-	if (vma->vm_flags & VM_LOCKONFAULT)
+	if (vma_test(vma, VMA_LOCKONFAULT_BIT))
 		return nr_pages;
 
 	/* ... similarly, we've never faulted in PROT_NONE pages */
@@ -1845,7 +1845,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * Otherwise, do a read fault, and use FOLL_FORCE in case it's not
 	 * readable (ie write-only or executable).
 	 */
-	if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE)
+	if (vma_flags_word_and(&vma->flags, VM_WRITE | VM_SHARED) == VM_WRITE)
 		gup_flags |= FOLL_WRITE;
 	else
 		gup_flags |= FOLL_FORCE;
@@ -1951,7 +1951,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * range with the first VMA. Also, skip undesirable VMA types.
 		 */
 		nend = min(end, vma->vm_end);
-		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+		if (vma_flags_word_any(&vma->flags, VM_IO | VM_PFNMAP))
 			continue;
 		if (nstart < vma->vm_start)
 			nstart = vma->vm_start;
@@ -2013,7 +2013,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 			break;
 
 		/* protect what we can, including chardevs */
-		if ((vma->vm_flags & (VM_IO | VM_PFNMAP)) ||
+		if (vma_flags_word_any(&vma->flags, VM_IO | VM_PFNMAP) ||
 		    !(vm_flags & vma->vm_flags))
 			break;
 
diff --git a/mm/hmm.c b/mm/hmm.c
index a56081d67ad6..6ba0687116e6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -81,7 +81,7 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 	hmm_vma_walk->last = addr;
 
 	if (required_fault & HMM_NEED_WRITE_FAULT) {
-		if (!(vma->vm_flags & VM_WRITE))
+		if (!vma_test(vma, VMA_WRITE_BIT))
 			return -EPERM;
 		fault_flags |= FAULT_FLAG_WRITE;
 	}
@@ -596,8 +596,8 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
 
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
-	    vma->vm_flags & VM_READ)
+	if (!vma_flags_word_any(&vma->flags, VM_IO | VM_PFNMAP) &&
+	    vma_test(vma, VMA_READ_BIT))
 		return 0;
 
 	/*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e24bb7e90d0..ba5b130e9416 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1071,7 +1071,7 @@ __setup("thp_anon=", setup_thp_anon);
 
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (likely(vma_test(vma, VMA_WRITE_BIT)))
 		pmd = pmd_mkwrite(pmd, vma);
 	return pmd;
 }
@@ -1417,7 +1417,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
  */
 gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
 {
-	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
+	const bool vma_madvised = vma && vma_test(vma, VMA_HUGEPAGE_BIT);
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
@@ -1615,10 +1615,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON(!vma_flags_word_any(&vma->flags, VM_PFNMAP|VM_MIXEDMAP));
+	BUG_ON(vma_flags_word_all(&vma->flags, VM_PFNMAP|VM_MIXEDMAP));
+	BUG_ON(vma_test(vma, VMA_PFNMAP_BIT) && is_cow_mapping(vma->vm_flags));
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
@@ -1646,7 +1645,7 @@ EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (likely(vma_test(vma, VMA_WRITE_BIT)))
 		pud = pud_mkwrite(pud);
 	return pud;
 }
@@ -1723,10 +1722,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON(!vma_flags_word_any(&vma->flags, VM_PFNMAP | VM_MIXEDMAP));
+	BUG_ON(vma_flags_word_all(&vma->flags, VM_PFNMAP | VM_MIXEDMAP));
+	BUG_ON(vma_test(vma, VMA_PFNMAP_BIT) && is_cow_mapping(vma->vm_flags));
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
@@ -2133,7 +2131,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+	if (WARN_ON_ONCE(!vma_test(vma, VMA_WRITE_BIT)))
 		return false;
 
 	/* Don't touch entries that are not even readable (NUMA hinting). */
@@ -2148,7 +2146,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	if (userfaultfd_huge_pmd_wp(vma, pmd))
 		return false;
 
-	if (!(vma->vm_flags & VM_SHARED)) {
+	if (!vma_test(vma, VMA_SHARED_BIT)) {
 		/* See can_change_pte_writable(). */
 		page = vm_normal_page_pmd(vma, addr, pmd);
 		return page && PageAnon(page) && PageAnonExclusive(page);
@@ -3328,7 +3326,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 
 	if (pmd_dirty(orig_pmd))
 		folio_set_dirty(folio);
-	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+	if (folio_test_dirty(folio) &&
+	    !vma_flags_word_any(&vma->flags, VM_DROPPABLE)) {
 		folio_set_swapbacked(folio);
 		return false;
 	}
@@ -3360,7 +3359,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	 */
 	if (pmd_dirty(orig_pmd))
 		folio_set_dirty(folio);
-	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+	if (folio_test_dirty(folio) &&
+	    !vma_flags_word_any(&vma->flags, VM_DROPPABLE)) {
 		folio_set_swapbacked(folio);
 		set_pmd_at(mm, addr, pmdp, orig_pmd);
 		return false;
@@ -3374,7 +3374,7 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
 	zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		mlock_drain_local();
 	folio_put(folio);
 
@@ -4481,7 +4481,7 @@ static void split_huge_pages_all(void)
 
 static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 {
-	return vma_is_special_huge(vma) || (vma->vm_flags & VM_IO) ||
+	return vma_is_special_huge(vma) || vma_test(vma, VMA_IO_BIT) ||
 		    is_vm_hugetlb_page(vma);
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1ea459723cce..c54f5f00f0d3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -446,7 +446,7 @@ int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 	struct hugetlb_vma_lock *vma_lock;
 
 	/* Only establish in (flags) sharable vmas */
-	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
+	if (!vma || !vma_test(vma, VMA_MAYSHARE_BIT))
 		return 0;
 
 	/* Should never get here with non-NULL vm_private_data */
@@ -1194,7 +1194,7 @@ static inline struct resv_map *inode_resv_map(struct inode *inode)
 static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 {
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-	if (vma->vm_flags & VM_MAYSHARE) {
+	if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 		struct address_space *mapping = vma->vm_file->f_mapping;
 		struct inode *inode = mapping->host;
 
@@ -1209,7 +1209,7 @@ static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 {
 	VM_WARN_ON_ONCE_VMA(!is_vm_hugetlb_page(vma), vma);
-	VM_WARN_ON_ONCE_VMA(vma->vm_flags & VM_MAYSHARE, vma);
+	VM_WARN_ON_ONCE_VMA(vma_test(vma, VMA_MAYSHARE_BIT), vma);
 
 	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
 }
@@ -1246,7 +1246,7 @@ static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
 
 bool __vma_private_lock(struct vm_area_struct *vma)
 {
-	return !(vma->vm_flags & VM_MAYSHARE) &&
+	return !vma_test(vma, VMA_MAYSHARE_BIT) &&
 		get_vma_private_data(vma) & ~HPAGE_RESV_MASK &&
 		is_vma_resv_set(vma, HPAGE_RESV_OWNER);
 }
@@ -1266,7 +1266,7 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 	 *   not apply to children.  Faults generated by the children are
 	 *   not guaranteed to succeed, even if read-only.
 	 */
-	if (vma->vm_flags & VM_MAYSHARE) {
+	if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		if (vma_lock && vma_lock->vma != vma)
@@ -2625,7 +2625,7 @@ static long __vma_reservation_common(struct hstate *h,
 		ret = 0;
 		break;
 	case VMA_ADD_RESV:
-		if (vma->vm_flags & VM_MAYSHARE) {
+		if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 			ret = region_add(resv, idx, idx + 1, 1, NULL, NULL);
 			/* region_add calls of range 1 should never fail. */
 			VM_BUG_ON(ret < 0);
@@ -2635,7 +2635,7 @@ static long __vma_reservation_common(struct hstate *h,
 		}
 		break;
 	case VMA_DEL_RESV:
-		if (vma->vm_flags & VM_MAYSHARE) {
+		if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 			region_abort(resv, idx, idx + 1, 1);
 			ret = region_del(resv, idx, idx + 1);
 		} else {
@@ -2648,7 +2648,7 @@ static long __vma_reservation_common(struct hstate *h,
 		BUG();
 	}
 
-	if (vma->vm_flags & VM_MAYSHARE || mode == VMA_DEL_RESV)
+	if (vma_test(vma, VMA_MAYSHARE_BIT) || mode == VMA_DEL_RESV)
 		return ret;
 	/*
 	 * We know private mapping must have HPAGE_RESV_OWNER set.
@@ -2777,7 +2777,7 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 			 * For shared mappings, no entry in the map indicates
 			 * no reservation.  We are done.
 			 */
-			if (!(vma->vm_flags & VM_MAYSHARE))
+			if (!vma_test(vma, VMA_MAYSHARE_BIT))
 				/*
 				 * For private mappings, no entry indicates
 				 * a reservation is present.  Since we can
@@ -5401,7 +5401,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	 * new structure.  Before clearing, make sure vma_lock is not
 	 * for this vma.
 	 */
-	if (vma->vm_flags & VM_MAYSHARE) {
+	if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		if (vma_lock) {
@@ -5524,7 +5524,7 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct folio *folio,
 	pte_t entry = folio_mk_pte(folio, vma->vm_page_prot);
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
+	if (try_mkwrite && vma_test(vma, VMA_WRITE_BIT)) {
 		entry = pte_mkwrite_novma(pte_mkdirty(entry));
 	} else {
 		entry = pte_wrprotect(entry);
@@ -5548,7 +5548,7 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
 					 unsigned long address, pte_t *ptep)
 {
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		set_huge_ptep_writable(vma, address, ptep);
 }
 
@@ -6150,7 +6150,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * MAP_PRIVATE accounting but it is possible that a shared
 		 * VMA is using the same page so check and skip such VMAs.
 		 */
-		if (iter_vma->vm_flags & VM_MAYSHARE)
+		if (vma_test(iter_vma, VMA_MAYSHARE_BIT))
 			continue;
 
 		/*
@@ -6199,7 +6199,7 @@ static vm_fault_t hugetlb_wp(struct vm_fault *vmf)
 		return 0;
 
 	/* Let's take out MAP_SHARED mappings first. */
-	if (vma->vm_flags & VM_MAYSHARE) {
+	if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
 		return 0;
 	}
@@ -6510,7 +6510,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 							VM_UFFD_MISSING);
 		}
 
-		if (!(vma->vm_flags & VM_MAYSHARE)) {
+		if (!vma_test(vma, VMA_MAYSHARE_BIT)) {
 			ret = __vmf_anon_prepare(vmf);
 			if (unlikely(ret))
 				goto out;
@@ -6540,7 +6540,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
-		if (vma->vm_flags & VM_MAYSHARE) {
+		if (vma_test(vma, VMA_MAYSHARE_BIT)) {
 			int err = hugetlb_add_to_page_cache(folio, mapping,
 							vmf->pgoff);
 			if (err) {
@@ -6593,7 +6593,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * any allocations necessary to record that reservation occur outside
 	 * the spinlock.
 	 */
-	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !vma_test(vma, VMA_SHARED_BIT)) {
 		if (vma_needs_reservation(h, vma, vmf->address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto backout_unlocked;
@@ -6612,7 +6612,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		hugetlb_add_new_anon_rmap(folio, vma, vmf->address);
 	else
 		hugetlb_add_file_rmap(folio);
-	new_pte = make_huge_pte(vma, folio, vma->vm_flags & VM_SHARED);
+	new_pte = make_huge_pte(vma, folio, vma_test(vma, VMA_SHARED_BIT));
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
@@ -6622,7 +6622,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
-	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) && !vma_test(vma, VMA_SHARED_BIT)) {
 		/*
 		 * No need to keep file folios locked. See comment in
 		 * hugetlb_fault().
@@ -6796,7 +6796,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * spinlock.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf.orig_pte)) {
+	    !vma_test(vma, VMA_MAYSHARE_BIT) && !huge_pte_write(vmf.orig_pte)) {
 		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
@@ -6928,7 +6928,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
 	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
 	unsigned long size = huge_page_size(h);
-	int vm_shared = dst_vma->vm_flags & VM_SHARED;
+	int vm_shared = vma_test(dst_vma, VMA_SHARED_BIT);
 	pte_t _dst_pte;
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
@@ -7532,7 +7532,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (!(vma->vm_flags & VM_MAYSHARE))
+	if (!vma_test(vma, VMA_MAYSHARE_BIT))
 		return false;
 	if (!vma->vm_private_data)	/* vma lock required for sharing */
 		return false;
@@ -7556,7 +7556,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 	 * vma needs to span at least one aligned PUD size, and the range
 	 * must be at least partially within in.
 	 */
-	if (!(vma->vm_flags & VM_MAYSHARE) || !(v_end > v_start) ||
+	if (!vma_test(vma, VMA_MAYSHARE_BIT) || !(v_end > v_start) ||
 		(*end <= v_start) || (*start >= v_end))
 		return;
 
@@ -7941,7 +7941,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	pte_t *ptep;
 
-	if (!(vma->vm_flags & VM_MAYSHARE))
+	if (!vma_test(vma, VMA_MAYSHARE_BIT))
 		return;
 
 	if (start >= end)
diff --git a/mm/internal.h b/mm/internal.h
index 116a1ba85e66..036c1c1bf78e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1042,7 +1042,7 @@ static inline void mlock_vma_folio(struct folio *folio,
 	 *    file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
 	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
 	 */
-	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED))
+	if (unlikely(vma_flags_word_and(&vma->flags, VM_LOCKED | VM_SPECIAL) == VM_LOCKED))
 		mlock_folio(folio);
 }
 
@@ -1059,7 +1059,7 @@ static inline void munlock_vma_folio(struct folio *folio,
 	 * always munlock the folio and page reclaim will correct it
 	 * if it's wrong.
 	 */
-	if (unlikely(vma->vm_flags & VM_LOCKED))
+	if (unlikely(vma_test(vma, VMA_LOCKED_BIT)))
 		munlock_folio(folio);
 }
 
@@ -1383,7 +1383,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
 static inline bool vma_is_single_threaded_private(struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_test(vma, VMA_SHARED_BIT))
 		return false;
 
 	return atomic_read(&vma->vm_mm->mm_users) == 1;
@@ -1564,7 +1564,7 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	 * Soft-dirty is kind of special: its tracking is enabled when the
 	 * vma flags not set.
 	 */
-	return !(vma->vm_flags & VM_SOFTDIRTY);
+	return !vma_flags_word_any(&vma->flags, VM_SOFTDIRTY);
 }
 
 static inline bool pmd_needs_soft_dirty_wp(struct vm_area_struct *vma, pmd_t pmd)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f6ed1072ed6e..3768b2d76311 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1600,7 +1600,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * So page lock of folio does not protect from it, so we must not drop
 	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
 	 */
-	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
+	if (userfaultfd_armed(vma) && !vma_test(vma, VMA_SHARED_BIT))
 		pml = pmd_lock(mm, pmd);
 
 	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
diff --git a/mm/ksm.c b/mm/ksm.c
index 18c9e3bda285..e4fd7a2c8b2e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -774,7 +774,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
@@ -1224,7 +1224,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			goto mm_exiting;
 
 		for_each_vma(vmi, vma) {
-			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+			if (!vma_test(vma, VMA_MERGEABLE_BIT) || !vma->anon_vma)
 				continue;
 			err = break_ksm(vma,
 						vma->vm_start, vma->vm_end, false);
@@ -2657,7 +2657,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		goto no_vmas;
 
 	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_test(vma, VMA_MERGEABLE_BIT))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
@@ -2850,7 +2850,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 {
 	int err;
 
-	if (!(vma->vm_flags & VM_MERGEABLE))
+	if (!vma_test(vma, VMA_MERGEABLE_BIT))
 		return 0;
 
 	if (vma->anon_vma) {
@@ -2987,7 +2987,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 	switch (advice) {
 	case MADV_MERGEABLE:
-		if (vma->vm_flags & VM_MERGEABLE)
+		if (vma_test(vma, VMA_MERGEABLE_BIT))
 			return 0;
 		if (!vma_ksm_compatible(vma))
 			return 0;
@@ -3438,7 +3438,7 @@ bool ksm_process_mergeable(struct mm_struct *mm)
 	mmap_assert_locked(mm);
 	VMA_ITERATOR(vmi, mm, 0);
 	for_each_vma(vmi, vma)
-		if (vma->vm_flags & VM_MERGEABLE)
+		if (vma_test(vma, VMA_MERGEABLE_BIT))
 			return true;
 
 	return false;
diff --git a/mm/madvise.c b/mm/madvise.c
index 216ae6ed344e..e2d484916ff8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -592,7 +592,7 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
-	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP|VM_HUGETLB));
+	return !vma_flags_word_any(&vma->flags, VM_LOCKED | VM_PFNMAP | VM_HUGETLB);
 }
 
 static long madvise_cold(struct madvise_behavior *madv_behavior)
@@ -641,7 +641,7 @@ static long madvise_pageout(struct madvise_behavior *madv_behavior)
 	 * further to pageout dirty anon pages.
 	 */
 	if (!vma_is_anonymous(vma) && (!can_do_file_pageout(vma) &&
-				(vma->vm_flags & VM_MAYSHARE)))
+				vma_test(vma, VMA_MAYSHARE_BIT)))
 		return 0;
 
 	lru_add_drain();
@@ -1020,7 +1020,7 @@ static long madvise_remove(struct madvise_behavior *madv_behavior)
 
 	mark_mmap_lock_dropped(madv_behavior);
 
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		return -EINVAL;
 
 	f = vma->vm_file;
@@ -1317,7 +1317,7 @@ static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
 		return true;
 
 	/* If the user could write to the mapping anyway, then this is fine. */
-	if ((vma->vm_flags & VM_WRITE) &&
+	if (vma_test(vma, VMA_WRITE_BIT) &&
 	    arch_vma_access_permitted(vma, /* write= */ true,
 			/* execute= */ false, /* foreign= */ false))
 		return true;
diff --git a/mm/memory.c b/mm/memory.c
index 9528133e5147..62eeaa700cec 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -690,7 +690,7 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
 			if (vma->vm_ops && vma->vm_ops->find_normal_page)
 				return vma->vm_ops->find_normal_page(vma, addr);
 #endif /* CONFIG_FIND_NORMAL_PAGE */
-			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+			if (vma_flags_word_any(&vma->flags, VM_PFNMAP | VM_MIXEDMAP))
 				return NULL;
 			if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
 				return NULL;
@@ -703,8 +703,8 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
 		 * mappings (incl. shared zero folios) are marked accordingly.
 		 */
 	} else {
-		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
-			if (vma->vm_flags & VM_MIXEDMAP) {
+		if (unlikely(vma_flags_word_any(&vma->flags, VM_PFNMAP | VM_MIXEDMAP))) {
+			if (vma_test(vma, VMA_MIXEDMAP_BIT)) {
 				/* If it has a "struct page", it's "normal". */
 				if (!pfn_valid(pfn))
 					return NULL;
@@ -880,7 +880,7 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	if (pte_swp_uffd_wp(orig_pte))
 		pte = pte_mkuffd_wp(pte);
 
-	if ((vma->vm_flags & VM_WRITE) &&
+	if (vma_test(vma, VMA_WRITE_BIT) &&
 	    can_change_pte_writable(vma, address, pte)) {
 		if (folio_test_dirty(folio))
 			pte = pte_mkdirty(pte);
@@ -1091,7 +1091,7 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 	}
 
 	/* If it's a shared mapping, mark it clean in the child. */
-	if (src_vma->vm_flags & VM_SHARED)
+	if (vma_test(src_vma, VMA_SHARED_BIT))
 		pte = pte_mkclean(pte);
 	pte = pte_mkold(pte);
 
@@ -1130,7 +1130,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * by keeping the batching logic separate.
 	 */
 	if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
-		if (!(src_vma->vm_flags & VM_SHARED))
+		if (!vma_test(src_vma, VMA_SHARED_BIT))
 			flags |= FPB_RESPECT_DIRTY;
 		if (vma_soft_dirty_enabled(src_vma))
 			flags |= FPB_RESPECT_SOFT_DIRTY;
@@ -1472,7 +1472,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (userfaultfd_wp(dst_vma))
 		return true;
 
-	if (src_vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+	if (vma_flags_word_any(&src_vma->flags, VM_PFNMAP | VM_MIXEDMAP))
 		return true;
 
 	if (src_vma->anon_vma)
@@ -2189,7 +2189,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size)
 {
 	if (!range_in_vma(vma, address, address + size) ||
-	    		!(vma->vm_flags & VM_PFNMAP))
+	    !vma_test(vma, VMA_PFNMAP_BIT))
 		return;
 
 	zap_page_range_single(vma, address, size, NULL);
@@ -2230,7 +2230,7 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
 
 static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
 {
-	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
+	VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT));
 	/*
 	 * Whoever wants to forbid the zeropage after some zeropages
 	 * might already have been mapped has to scan the page tables and
@@ -2243,7 +2243,7 @@ static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
 	if (is_cow_mapping(vma->vm_flags))
 		return true;
 	/* Mappings that do not allow for writable PTEs are unproblematic. */
-	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
+	if (!vma_flags_word_any(&vma->flags, VM_WRITE | VM_MAYWRITE))
 		return true;
 	/*
 	 * Why not allow any VMA that has vm_ops->pfn_mkwrite? GUP could
@@ -2255,7 +2255,7 @@ static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
 	 * check_vma_flags).
 	 */
 	return vma->vm_ops && vma->vm_ops->pfn_mkwrite &&
-	       (vma_is_fsdax(vma) || vma->vm_flags & VM_IO);
+	       (vma_is_fsdax(vma) || vma_test(vma, VMA_IO_BIT));
 }
 
 static int validate_page_before_insert(struct vm_area_struct *vma,
@@ -2432,9 +2432,9 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	if (addr < vma->vm_start || end_addr >= vma->vm_end)
 		return -EFAULT;
-	if (!(vma->vm_flags & VM_MIXEDMAP)) {
+	if (!vma_test(vma, VMA_MIXEDMAP_BIT)) {
 		BUG_ON(mmap_read_trylock(vma->vm_mm));
-		BUG_ON(vma->vm_flags & VM_PFNMAP);
+		BUG_ON(vma_test(vma, VMA_PFNMAP_BIT));
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
 	/* Defer page refcount checking till we're about to map that page. */
@@ -2477,9 +2477,9 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 {
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return -EFAULT;
-	if (!(vma->vm_flags & VM_MIXEDMAP)) {
+	if (!vma_test(vma, VMA_MIXEDMAP_BIT)) {
 		BUG_ON(mmap_read_trylock(vma->vm_mm));
-		BUG_ON(vma->vm_flags & VM_PFNMAP);
+		BUG_ON(vma_test(vma, VMA_PFNMAP_BIT));
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
 	return insert_page(vma, addr, page, vma->vm_page_prot, false);
@@ -2662,11 +2662,10 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	 * consistency in testing and feature parity among all, so we should
 	 * try to keep these invariants in place for everybody.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
-	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
+	BUG_ON(!vma_flags_word_any(&vma->flags, VM_PFNMAP | VM_MIXEDMAP));
+	BUG_ON(vma_flags_word_all(&vma->flags, VM_PFNMAP | VM_MIXEDMAP));
+	BUG_ON(vma_test(vma, VMA_PFNMAP_BIT) && is_cow_mapping(vma->vm_flags));
+	BUG_ON(vma_test(vma, VMA_MIXEDMAP_BIT) && pfn_valid(pfn));
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
@@ -2714,7 +2713,7 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
 	    (mkwrite || !vm_mixed_zeropage_allowed(vma)))
 		return false;
 	/* these checks mirror the abort conditions in vm_normal_page */
-	if (vma->vm_flags & VM_MIXEDMAP)
+	if (vma_test(vma, VMA_MIXEDMAP_BIT))
 		return true;
 	if (is_zero_pfn(pfn))
 		return true;
@@ -2934,7 +2933,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
+	VM_WARN_ON_ONCE(!vma_flags_word_all(&vma->flags, VM_REMAP_FLAGS));
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -3872,7 +3871,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  */
 static vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf, struct folio *folio)
 {
-	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
+	WARN_ON_ONCE(!vma_test(vmf->vma, VMA_SHARED_BIT));
 	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
 				       &vmf->ptl);
 	if (!vmf->pte)
@@ -4141,7 +4140,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
 	 */
-	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+	if (vma_flags_word_any(&vma->flags, VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
 		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
@@ -4368,7 +4367,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 {
 	if (!folio_test_swapcache(folio))
 		return false;
-	if (mem_cgroup_swap_full(folio) || (vma->vm_flags & VM_LOCKED) ||
+	if (mem_cgroup_swap_full(folio) || vma_test(vma, VMA_LOCKED_BIT) ||
 	    folio_test_mlocked(folio))
 		return true;
 	/*
@@ -4980,7 +4979,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	if (!folio_test_ksm(folio) &&
 	    (exclusive || folio_ref_count(folio) == 1)) {
-		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
+		if (vma_test(vma, VMA_WRITE_BIT) && !userfaultfd_pte_wp(vma, pte) &&
 		    !pte_needs_soft_dirty_wp(vma, pte)) {
 			pte = pte_mkwrite(pte, vma);
 			if (vmf->flags & FAULT_FLAG_WRITE) {
@@ -5188,7 +5187,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	pte_t entry;
 
 	/* File mapping without ->vm_ops ? */
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_test(vma, VMA_SHARED_BIT))
 		return VM_FAULT_SIGBUS;
 
 	/*
@@ -5245,7 +5244,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	entry = folio_mk_pte(folio, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		entry = pte_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
@@ -5481,7 +5480,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
-	if (write && !(vma->vm_flags & VM_SHARED)) {
+	if (write && !vma_test(vma, VMA_SHARED_BIT)) {
 		VM_BUG_ON_FOLIO(nr != 1, folio);
 		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
@@ -5524,7 +5523,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	struct folio *folio;
 	vm_fault_t ret;
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
-		      !(vma->vm_flags & VM_SHARED);
+		      !vma_test(vma, VMA_SHARED_BIT);
 	int type, nr_pages;
 	unsigned long addr;
 	bool needs_fallback = false;
@@ -5543,7 +5542,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * check even for read faults because we might have lost our CoWed
 	 * page
 	 */
-	if (!(vma->vm_flags & VM_SHARED)) {
+	if (!vma_test(vma, VMA_SHARED_BIT)) {
 		ret = check_stable_address_space(vma->vm_mm);
 		if (ret)
 			return ret;
@@ -5895,7 +5894,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		}
 	} else if (!(vmf->flags & FAULT_FLAG_WRITE))
 		ret = do_read_fault(vmf);
-	else if (!(vma->vm_flags & VM_SHARED))
+	else if (!vma_test(vma, VMA_SHARED_BIT))
 		ret = do_cow_fault(vmf);
 	else
 		ret = do_shared_fault(vmf);
@@ -5929,7 +5928,7 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	 * Flag if the folio is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
 	 */
-	if (folio_maybe_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+	if (folio_maybe_mapped_shared(folio) && vma_test(vma, VMA_SHARED_BIT))
 		*flags |= TNF_SHARED;
 	/*
 	 * For memory tiering mode, cpupid of slow memory page is used
@@ -6127,7 +6126,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 		return do_huge_pmd_wp_page(vmf);
 	}
 
-	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+	if (vma_flags_word_any(&vma->flags, VM_SHARED | VM_MAYSHARE)) {
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -6166,7 +6165,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		goto split;
-	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
+	if (vma_flags_word_any(&vma->flags, VM_SHARED | VM_MAYSHARE)) {
 		if (vma->vm_ops->huge_fault) {
 			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
@@ -6487,10 +6486,10 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 			*flags &= ~FAULT_FLAG_UNSHARE;
 	} else if (*flags & FAULT_FLAG_WRITE) {
 		/* Write faults on read-only mappings are impossible ... */
-		if (WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE)))
+		if (WARN_ON_ONCE(!vma_test(vma, VMA_MAYWRITE_BIT)))
 			return VM_FAULT_SIGSEGV;
 		/* ... and FOLL_FORCE only applies to COW mappings. */
-		if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE) &&
+		if (WARN_ON_ONCE(!vma_test(vma, VMA_WRITE_BIT) &&
 				 !is_cow_mapping(vma->vm_flags)))
 			return VM_FAULT_SIGSEGV;
 	}
@@ -6536,7 +6535,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 	}
 
-	is_droppable = !!(vma->vm_flags & VM_DROPPABLE);
+	is_droppable = vma_flags_word_any(&vma->flags, VM_DROPPABLE);
 
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
@@ -6730,7 +6729,7 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
 		goto out;
 
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+	if (!vma_flags_word_any(&vma->flags, VM_IO | VM_PFNMAP))
 		goto out;
 retry:
 	pgdp = pgd_offset(mm, address);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7ae3f5e2dee6..e86c5f95822e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1976,7 +1976,7 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 
 bool vma_migratable(struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+	if (vma_flags_word_any(&vma->flags, VM_IO | VM_PFNMAP))
 		return false;
 
 	/*
@@ -2524,7 +2524,7 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct
 	pgoff_t ilx;
 	struct folio *folio;
 
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (vma_flags_word_any(&vma->flags, VM_DROPPABLE))
 		gfp |= __GFP_NOWARN;
 
 	pol = get_vma_policy(vma, addr, order, &ilx);
diff --git a/mm/migrate.c b/mm/migrate.c
index ceee354ef215..6587f5ea5e6d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -309,7 +309,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 	VM_WARN_ON_ONCE_FOLIO(folio_is_device_private(folio), folio);
 
-	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
+	if (folio_test_mlocked(folio) || vma_test(pvmw->vma, VMA_LOCKED_BIT) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
 		return false;
 
@@ -2662,7 +2662,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma_test(vma, VMA_EXEC_BIT) && folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index c869b272e85a..51a119b9d31b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -739,7 +739,7 @@ int migrate_vma_setup(struct migrate_vma *args)
 	args->start &= PAGE_MASK;
 	args->end &= PAGE_MASK;
 	if (!args->vma || is_vm_hugetlb_page(args->vma) ||
-	    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
+	    vma_flags_word_any(&args->vma->flags, VM_SPECIAL) || vma_is_dax(args->vma))
 		return -EINVAL;
 	if (nr_pages <= 0)
 		return -EINVAL;
@@ -838,7 +838,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			swp_entry = make_writable_device_private_entry(
 						page_to_pfn(page));
 		else
@@ -851,7 +851,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 			goto abort;
 		}
 		entry = folio_mk_pmd(folio, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			entry = pmd_mkwrite(pmd_mkdirty(entry), vma);
 	}
 
@@ -1036,7 +1036,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			swp_entry = make_writable_device_private_entry(
 						page_to_pfn(page));
 		else
@@ -1050,7 +1050,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			goto abort;
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			entry = pte_mkwrite(pte_mkdirty(entry), vma);
 	}
 
diff --git a/mm/mlock.c b/mm/mlock.c
index bb0776f5ef7c..8e64d6bfffef 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -329,7 +329,7 @@ static inline bool allow_mlock_munlock(struct folio *folio,
 	 * be split. And the pages are not in VM_LOCKed VMA
 	 * can be reclaimed.
 	 */
-	if (!(vma->vm_flags & VM_LOCKED))
+	if (!vma_test(vma, VMA_LOCKED_BIT))
 		return true;
 
 	/* folio_within_range() cannot take KSM, but any small folio is OK */
@@ -368,7 +368,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		folio = pmd_folio(*pmd);
 		if (folio_is_zone_device(folio))
 			goto out;
-		if (vma->vm_flags & VM_LOCKED)
+		if (vma_test(vma, VMA_LOCKED_BIT))
 			mlock_folio(folio);
 		else
 			munlock_folio(folio);
@@ -393,7 +393,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!allow_mlock_munlock(folio, vma, start, end, step))
 			goto next_entry;
 
-		if (vma->vm_flags & VM_LOCKED)
+		if (vma_test(vma, VMA_LOCKED_BIT))
 			mlock_folio(folio);
 		else
 			munlock_folio(folio);
@@ -583,7 +583,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 		end = start + len;
 
 	for_each_vma_range(vmi, vma, end) {
-		if (vma->vm_flags & VM_LOCKED) {
+		if (vma_test(vma, VMA_LOCKED_BIT)) {
 			if (start > vma->vm_start)
 				count -= (start - vma->vm_start);
 			if (end < vma->vm_end) {
diff --git a/mm/mmap.c b/mm/mmap.c
index 644f02071a41..211c66f3277f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -992,7 +992,7 @@ struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned lon
 	start = vma->vm_start;
 	if (expand_stack_locked(vma, addr))
 		return NULL;
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		populate_vma_page_range(vma, addr, start, NULL);
 	return vma;
 }
@@ -1117,18 +1117,18 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	 */
 	vma = vma_lookup(mm, start);
 
-	if (!vma || !(vma->vm_flags & VM_SHARED)) {
+	if (!vma || !vma_test(vma, VMA_SHARED_BIT)) {
 		mmap_read_unlock(mm);
 		return -EINVAL;
 	}
 
-	prot |= vma->vm_flags & VM_READ ? PROT_READ : 0;
-	prot |= vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
-	prot |= vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
+	prot |= vma_test(vma, VMA_READ_BIT) ? PROT_READ : 0;
+	prot |= vma_test(vma, VMA_WRITE_BIT) ? PROT_WRITE : 0;
+	prot |= vma_test(vma, VMA_EXEC_BIT) ? PROT_EXEC : 0;
 
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		flags |= MAP_LOCKED;
 
 	/* Save vm_flags used to calculate prot and flags, and recheck later. */
@@ -1296,7 +1296,7 @@ void exit_mmap(struct mm_struct *mm)
 	 */
 	vma_iter_set(&vmi, vma->vm_end);
 	do {
-		if (vma->vm_flags & VM_ACCOUNT)
+		if (vma_test(vma, VMA_ACCOUNT_BIT))
 			nr_accounted += vma_pages(vma);
 		vma_mark_detached(vma);
 		remove_vma(vma);
@@ -1700,7 +1700,7 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 		return true;
 	}
 
-	if (!(new_vma->vm_flags & VM_GROWSDOWN))
+	if (!vma_test(new_vma, VMA_GROWSDOWN_BIT))
 		return false;
 
 	mmap_write_lock(mm);
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 0a0db5849b8e..69c2739f19c3 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -436,7 +436,7 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 	 * Well, dang. We might still be successful, but only
 	 * if we can extend a vma to do so.
 	 */
-	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
+	if (!vma || !vma_test(vma, VMA_GROWSDOWN_BIT)) {
 		mmap_read_unlock(mm);
 		return NULL;
 	}
@@ -459,7 +459,7 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 			goto fail;
 		if (vma->vm_start <= addr)
 			goto success;
-		if (!(vma->vm_flags & VM_GROWSDOWN))
+		if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 			goto fail;
 	}
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab4e06cd9a69..671692d730fb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -40,7 +40,7 @@
 
 static bool maybe_change_pte_writable(struct vm_area_struct *vma, pte_t pte)
 {
-	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+	if (WARN_ON_ONCE(!vma_test(vma, VMA_WRITE_BIT)))
 		return false;
 
 	/* Don't touch entries that are not even readable. */
@@ -97,7 +97,7 @@ static bool can_change_shared_pte_writable(struct vm_area_struct *vma,
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte)
 {
-	if (!(vma->vm_flags & VM_SHARED))
+	if (!vma_test(vma, VMA_SHARED_BIT))
 		return can_change_private_pte_writable(vma, addr, pte);
 
 	return can_change_shared_pte_writable(vma, pte);
@@ -194,7 +194,7 @@ static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
 {
 	bool set_write;
 
-	if (vma->vm_flags & VM_SHARED) {
+	if (vma_test(vma, VMA_SHARED_BIT)) {
 		set_write = can_change_shared_pte_writable(vma, ptent);
 		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
 				       /* idx = */ 0, set_write, tlb);
@@ -854,7 +854,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			goto out;
 		start = vma->vm_start;
 		error = -EINVAL;
-		if (!(vma->vm_flags & VM_GROWSDOWN))
+		if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 			goto out;
 	} else {
 		if (vma->vm_start > start)
@@ -862,7 +862,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		if (unlikely(grows & PROT_GROWSUP)) {
 			end = vma->vm_end;
 			error = -EINVAL;
-			if (!(vma->vm_flags & VM_GROWSUP))
+			if (!vma_flags_word_any(&vma->flags, VM_GROWSUP))
 				goto out;
 		}
 	}
@@ -885,7 +885,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 
 		/* Does the application expect PROT_READ to imply PROT_EXEC */
-		if (rier && (vma->vm_flags & VM_MAYEXEC))
+		if (rier && vma_test(vma, VMA_MAYEXEC_BIT))
 			prot |= PROT_EXEC;
 
 		/*
diff --git a/mm/mremap.c b/mm/mremap.c
index 8ad06cf50783..eddb1fa23159 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -951,7 +951,7 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
 
 	if (vrm->flags & MREMAP_FIXED)
 		map_flags |= MAP_FIXED;
-	if (vma->vm_flags & VM_MAYSHARE)
+	if (vma_test(vma, VMA_MAYSHARE_BIT))
 		map_flags |= MAP_SHARED;
 
 	res = get_unmapped_area(vma->vm_file, new_addr, vrm->new_len, pgoff,
@@ -973,7 +973,7 @@ static bool vrm_calc_charge(struct vma_remap_struct *vrm)
 {
 	unsigned long charged;
 
-	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
+	if (!vma_test(vrm->vma, VMA_ACCOUNT_BIT))
 		return true;
 
 	/*
@@ -1000,7 +1000,7 @@ static bool vrm_calc_charge(struct vma_remap_struct *vrm)
  */
 static void vrm_uncharge(struct vma_remap_struct *vrm)
 {
-	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
+	if (!vma_test(vrm->vma, VMA_ACCOUNT_BIT))
 		return;
 
 	vm_unacct_memory(vrm->charged);
@@ -1020,7 +1020,7 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 	struct vm_area_struct *vma = vrm->vma;
 
 	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		mm->locked_vm += pages;
 }
 
@@ -1094,7 +1094,7 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
 	 * arose, in which case we _do_ wish to unmap the _new_ VMA, which means
 	 * we actually _do_ want it be unaccounted.
 	 */
-	bool accountable_move = (vma->vm_flags & VM_ACCOUNT) &&
+	bool accountable_move = vma_test(vma, VMA_ACCOUNT_BIT) &&
 		!(vrm->flags & MREMAP_DONTUNMAP);
 
 	/*
@@ -1687,14 +1687,14 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	 * based on the original.  There are no known use cases for this
 	 * behavior.  As a result, fail such attempts.
 	 */
-	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
+	if (!old_len && !vma_flags_word_any(&vma->flags, VM_SHARED | VM_MAYSHARE)) {
 		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
 			     current->comm, current->pid);
 		return -EINVAL;
 	}
 
 	if ((vrm->flags & MREMAP_DONTUNMAP) &&
-			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
+	    vma_flags_word_any(&vma->flags, VM_DONTEXPAND | VM_PFNMAP))
 		return -EINVAL;
 
 	/*
@@ -1724,7 +1724,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 		return 0;
 
 	/* We are expanding and the VMA is mlock()'d so we need to populate. */
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		vrm->populate_expand = true;
 
 	/* Need to be careful about a growing mapping */
@@ -1733,7 +1733,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
 		return -EINVAL;
 
-	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
+	if (vma_flags_word_any(&vma->flags, VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;
 
 	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
diff --git a/mm/mseal.c b/mm/mseal.c
index e5b205562d2e..7308b399f4fd 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -68,7 +68,7 @@ static int mseal_apply(struct mm_struct *mm,
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long curr_end = MIN(vma->vm_end, end);
 
-		if (!(vma->vm_flags & VM_SEALED)) {
+		if (!vma_flags_word_any(&vma->flags, VM_SEALED)) {
 			vma = vma_modify_flags(&vmi, prev, vma,
 					curr_start, curr_end,
 					vma->vm_flags | VM_SEALED);
diff --git a/mm/msync.c b/mm/msync.c
index ac4c9bfea2e7..1126aa27d3c6 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -80,7 +80,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 		}
 		/* Here vma->vm_start <= start < vma->vm_end. */
 		if ((flags & MS_INVALIDATE) &&
-				(vma->vm_flags & VM_LOCKED)) {
+				vma_test(vma, VMA_LOCKED_BIT)) {
 			error = -EBUSY;
 			goto out_unlock;
 		}
@@ -90,7 +90,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 		fend = fstart + (min(end, vma->vm_end) - start) - 1;
 		start = vma->vm_end;
 		if ((flags & MS_SYNC) && file &&
-				(vma->vm_flags & VM_SHARED)) {
+				vma_test(vma, VMA_SHARED_BIT)) {
 			get_file(file);
 			mmap_read_unlock(mm);
 			error = vfs_fsync_range(file, fstart, fend, 1);
diff --git a/mm/nommu.c b/mm/nommu.c
index c3a23b082adb..4859b42a93b8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1172,7 +1172,7 @@ unsigned long do_mmap(struct file *file,
 	/* set up the mapping
 	 * - the region is filled in if NOMMU_MAP_DIRECT is still set
 	 */
-	if (file && vma->vm_flags & VM_SHARED)
+	if (file && vma_test(vma, VMA_SHARED_BIT))
 		ret = do_mmap_shared_file(vma);
 	else
 		ret = do_mmap_private(vma, region, len, capabilities);
@@ -1205,7 +1205,7 @@ unsigned long do_mmap(struct file *file,
 
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
-	if (vma->vm_flags & VM_EXEC && !region->vm_icache_flushed) {
+	if (vma_test(vma, VMA_EXEC_BIT) && !region->vm_icache_flushed) {
 		flush_icache_user_range(region->vm_start, region->vm_end);
 		region->vm_icache_flushed = true;
 	}
@@ -1613,7 +1613,7 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 {
 	unsigned int size = vma->vm_end - vma->vm_start;
 
-	if (!(vma->vm_flags & VM_USERMAP))
+	if (!vma_test(vma, VMA_USERMAP_BIT))
 		return -EINVAL;
 
 	vma->vm_start = (unsigned long)(addr + (pgoff << PAGE_SHIFT));
@@ -1655,10 +1655,10 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			len = vma->vm_end - addr;
 
 		/* only read or write mappings where it is permitted */
-		if (write && vma->vm_flags & VM_MAYWRITE)
+		if (write && vma_test(vma, VMA_MAYWRITE_BIT))
 			copy_to_user_page(vma, NULL, addr,
 					 (void *) addr, buf, len);
-		else if (!write && vma->vm_flags & VM_MAYREAD)
+		else if (!write && vma_test(vma, VMA_MAYREAD_BIT))
 			copy_from_user_page(vma, NULL, addr,
 					    buf, (void *) addr, len);
 		else
@@ -1741,7 +1741,7 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 		len = vma->vm_end - addr;
 
 	/* only read mappings where it is permitted */
-	if (vma->vm_flags & VM_MAYREAD) {
+	if (vma_test(vma, VMA_MAYREAD_BIT)) {
 		ret = strscpy(buf, (char *)addr, len);
 		if (ret < 0)
 			ret = len - 1;
@@ -1819,7 +1819,7 @@ int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
 	vma_interval_tree_foreach(vma, &inode->i_mapping->i_mmap, low, high) {
 		/* found one - only interested if it's shared out of the page
 		 * cache */
-		if (vma->vm_flags & VM_SHARED) {
+		if (vma_test(vma, VMA_SHARED_BIT)) {
 			i_mmap_unlock_read(inode->i_mapping);
 			up_write(&nommu_region_sem);
 			return -ETXTBSY; /* not quite true, but near enough */
@@ -1833,7 +1833,7 @@ int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
 	 * shouldn't be any
 	 */
 	vma_interval_tree_foreach(vma, &inode->i_mapping->i_mmap, 0, ULONG_MAX) {
-		if (!(vma->vm_flags & VM_SHARED))
+		if (!vma_test(vma, VMA_SHARED_BIT))
 			continue;
 
 		region = vma->vm_region;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c145b0feecc1..d1a88e333d31 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -533,7 +533,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 	 * of the address space.
 	 */
 	mas_for_each_rev(&mas, vma, 0) {
-		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
+		if (vma_flags_word_any(&vma->flags, VM_HUGETLB | VM_PFNMAP))
 			continue;
 
 		/*
@@ -546,7 +546,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 		 * we do not want to block exit_mmap by keeping mm ref
 		 * count elevated without a good reason.
 		 */
-		if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
+		if (vma_is_anonymous(vma) || !vma_test(vma, VMA_SHARED_BIT)) {
 			struct mmu_notifier_range range;
 			struct mmu_gather tlb;
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9f91cf85a5be..edd527c450dd 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -376,7 +376,7 @@ static int walk_page_test(unsigned long start, unsigned long end,
 	 * define their ->pte_hole() callbacks, so let's delegate them to handle
 	 * vma(VM_PFNMAP).
 	 */
-	if (vma->vm_flags & VM_PFNMAP) {
+	if (vma_test(vma, VMA_PFNMAP_BIT)) {
 		int err = 1;
 		if (ops->pte_hole)
 			err = ops->pte_hole(start, end, -1, walk);
diff --git a/mm/rmap.c b/mm/rmap.c
index 1954c538a991..e054a51583bc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -831,7 +831,7 @@ static bool folio_referenced_one(struct folio *folio,
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if (vma->vm_flags & VM_LOCKED) {
+		if (vma_test(vma, VMA_LOCKED_BIT)) {
 			ptes++;
 			pra->mapcount--;
 
@@ -1069,7 +1069,7 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 
 static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_test(vma, VMA_SHARED_BIT))
 		return false;
 
 	return true;
@@ -1531,7 +1531,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
 	 * under memory pressure.
 	 */
-	if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPABLE))
+	if (!folio_test_swapbacked(folio) &&
+	    !vma_flags_word_any(&vma->flags, VM_DROPPABLE))
 		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, exclusive);
 
@@ -1902,7 +1903,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
-		    (vma->vm_flags & VM_LOCKED)) {
+		    vma_test(vma, VMA_LOCKED_BIT)) {
 			ptes++;
 
 			/*
@@ -2121,7 +2122,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				smp_rmb();
 
-				if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+				if (folio_test_dirty(folio) &&
+				    !vma_flags_word_any(&vma->flags, VM_DROPPABLE)) {
 					/*
 					 * redirtied either using the page table or a previously
 					 * obtained GUP reference.
@@ -2212,7 +2214,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		} else {
 			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
 		}
-		if (vma->vm_flags & VM_LOCKED)
+		if (vma_test(vma, VMA_LOCKED_BIT))
 			mlock_drain_local();
 		folio_put_refs(folio, nr_pages);
 
@@ -2574,7 +2576,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
-		if (vma->vm_flags & VM_LOCKED)
+		if (vma_test(vma, VMA_LOCKED_BIT))
 			mlock_drain_local();
 		folio_put(folio);
 	}
diff --git a/mm/swap.c b/mm/swap.c
index 2260dcd2775e..54c67d8d8e53 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -524,7 +524,8 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
 {
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
-	if (unlikely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED))
+	if (unlikely(vma_flags_word_and(&vma->flags, VM_LOCKED | VM_SPECIAL) ==
+		     VM_LOCKED))
 		mlock_new_folio(folio);
 	else
 		folio_add_lru(folio);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 00122f42718c..99b31085efda 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -48,7 +48,7 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
 	vma = vma_lookup(mm, addr);
 	if (!vma)
 		vma = ERR_PTR(-ENOENT);
-	else if (!(vma->vm_flags & VM_SHARED) &&
+	else if (!vma_test(vma, VMA_SHARED_BIT) &&
 		 unlikely(anon_vma_prepare(vma)))
 		vma = ERR_PTR(-ENOMEM);
 
@@ -77,7 +77,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 		 * We know we're going to need to use anon_vma, so check
 		 * that early.
 		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
+		if (!vma_test(vma, VMA_SHARED_BIT) && unlikely(!vma->anon_vma))
 			vma_end_read(vma);
 		else
 			return vma;
@@ -173,8 +173,8 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	int ret;
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	pte_t _dst_pte, *dst_pte;
-	bool writable = dst_vma->vm_flags & VM_WRITE;
-	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
+	bool writable = vma_test(dst_vma, VMA_WRITE_BIT);
+	bool vm_shared = vma_test(dst_vma, VMA_SHARED_BIT);
 	spinlock_t *ptl;
 	struct folio *folio = page_folio(page);
 	bool page_in_cache = folio_mapping(folio);
@@ -677,7 +677,7 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	 * only happens in the pagetable (to verify it's still none)
 	 * and not in the radix tree.
 	 */
-	if (!(dst_vma->vm_flags & VM_SHARED)) {
+	if (!vma_test(dst_vma, VMA_SHARED_BIT)) {
 		if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
 			err = mfill_atomic_pte_copy(dst_pmd, dst_vma,
 						    dst_addr, src_addr,
@@ -749,14 +749,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	 * it will overwrite vm_ops, so vma_is_anonymous must return false.
 	 */
 	if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
-	    dst_vma->vm_flags & VM_SHARED))
+	    vma_test(dst_vma, VMA_SHARED_BIT)))
 		goto out_unlock;
 
 	/*
 	 * validate 'mode' now that we know the dst_vma: don't allow
 	 * a wrprotect copy if the userfaultfd didn't register as WP.
 	 */
-	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if ((flags & MFILL_ATOMIC_WP) && !vma_test(dst_vma, VMA_UFFD_WP_BIT))
 		goto out_unlock;
 
 	/*
@@ -1528,8 +1528,8 @@ static inline bool move_splits_huge_pmd(unsigned long dst_addr,
 
 static inline bool vma_move_compatible(struct vm_area_struct *vma)
 {
-	return !(vma->vm_flags & (VM_PFNMAP | VM_IO |  VM_HUGETLB |
-				  VM_MIXEDMAP | VM_SHADOW_STACK));
+	return !vma_flags_word_any(&vma->flags, VM_PFNMAP | VM_IO |  VM_HUGETLB |
+				   VM_MIXEDMAP | VM_SHADOW_STACK);
 }
 
 static int validate_move_areas(struct userfaultfd_ctx *ctx,
@@ -1537,19 +1537,20 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *dst_vma)
 {
 	/* Only allow moving if both have the same access and protection */
-	if ((src_vma->vm_flags & VM_ACCESS_FLAGS) != (dst_vma->vm_flags & VM_ACCESS_FLAGS) ||
+	if (vma_flags_word_and(&src_vma->flags, VM_ACCESS_FLAGS) !=
+	    vma_flags_word_and(&dst_vma->flags, VM_ACCESS_FLAGS) ||
 	    pgprot_val(src_vma->vm_page_prot) != pgprot_val(dst_vma->vm_page_prot))
 		return -EINVAL;
 
 	/* Only allow moving if both are mlocked or both aren't */
-	if ((src_vma->vm_flags & VM_LOCKED) != (dst_vma->vm_flags & VM_LOCKED))
+	if (vma_test(src_vma, VMA_LOCKED_BIT) != vma_test(dst_vma, VMA_LOCKED_BIT))
 		return -EINVAL;
 
 	/*
 	 * For now, we keep it simple and only move between writable VMAs.
 	 * Access flags are equal, therefore checking only the source is enough.
 	 */
-	if (!(src_vma->vm_flags & VM_WRITE))
+	if (!vma_test(src_vma, VMA_WRITE_BIT))
 		return -EINVAL;
 
 	/* Check if vma flags indicate content which can be moved */
@@ -1796,12 +1797,12 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	 * vma.
 	 */
 	err = -EINVAL;
-	if (src_vma->vm_flags & VM_SHARED)
+	if (vma_test(src_vma, VMA_SHARED_BIT))
 		goto out_unlock;
 	if (src_start + len > src_vma->vm_end)
 		goto out_unlock;
 
-	if (dst_vma->vm_flags & VM_SHARED)
+	if (vma_test(dst_vma, VMA_SHARED_BIT))
 		goto out_unlock;
 	if (dst_start + len > dst_vma->vm_end)
 		goto out_unlock;
@@ -1948,7 +1949,7 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
 	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
 	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
 	 */
-	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
+	if (vma_test(vma, VMA_SHARED_BIT) && uffd_wp_changed)
 		vma_set_page_prot(vma);
 }
 
@@ -2023,7 +2024,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
 		VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx &&
 				vma->vm_userfaultfd_ctx.ctx != ctx);
-		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MAYWRITE));
+		VM_WARN_ON_ONCE(!vma_test(vma, VMA_MAYWRITE_BIT));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
diff --git a/mm/vma.c b/mm/vma.c
index 50a6909c4be3..6c3ca44642cd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -89,7 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
-	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
+	if ((vma_flags_get_word(&vma->flags) ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -894,13 +894,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_right) {
 		vma_start_write(next);
 		vmg->target = next;
-		sticky_flags |= (next->vm_flags & VM_STICKY);
+		sticky_flags |= vma_flags_word_and(&next->flags, VM_STICKY);
 	}
 
 	if (merge_left) {
 		vma_start_write(prev);
 		vmg->target = prev;
-		sticky_flags |= (prev->vm_flags & VM_STICKY);
+		sticky_flags |= vma_flags_word_and(&prev->flags, VM_STICKY);
 	}
 
 	if (merge_both) {
@@ -1124,7 +1124,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vm_flags_t sticky_flags;
 
 	sticky_flags = vmg->vm_flags & VM_STICKY;
-	sticky_flags |= target->vm_flags & VM_STICKY;
+	sticky_flags |= vma_flags_word_and(&target->flags, VM_STICKY);
 
 	VM_WARN_ON_VMG(!target, vmg);
 
@@ -1134,7 +1134,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (next && (target != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
-		sticky_flags |= next->vm_flags & VM_STICKY;
+		sticky_flags |= vma_flags_word_and(&next->flags, VM_STICKY);
 		remove_next = true;
 		/* This should already have been checked by this point. */
 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
@@ -1993,14 +1993,13 @@ static bool vm_ops_needs_writenotify(const struct vm_operations_struct *vm_ops)
 
 static bool vma_is_shared_writable(struct vm_area_struct *vma)
 {
-	return (vma->vm_flags & (VM_WRITE | VM_SHARED)) ==
-		(VM_WRITE | VM_SHARED);
+	return vma_flags_word_all(&vma->flags, VM_WRITE | VM_SHARED);
 }
 
 static bool vma_fs_can_writeback(struct vm_area_struct *vma)
 {
 	/* No managed pages to writeback. */
-	if (vma->vm_flags & VM_PFNMAP)
+	if (vma_test(vma, VMA_PFNMAP_BIT))
 		return false;
 
 	return vma->vm_file && vma->vm_file->f_mapping &&
@@ -2435,7 +2434,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	 */
 	VM_WARN_ON_ONCE(map->vm_flags != vma->vm_flags &&
 			!(map->vm_flags & VM_MAYWRITE) &&
-			(vma->vm_flags & VM_MAYWRITE));
+			vma_test(vma, VMA_MAYWRITE_BIT));
 
 	map->file = vma->vm_file;
 	map->vm_flags = vma->vm_flags;
@@ -3004,8 +3003,12 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* Check to ensure the stack will not grow into a hugetlb-only region */
-	new_start = (vma->vm_flags & VM_GROWSUP) ? vma->vm_start :
-			vma->vm_end - size;
+
+	if (vma_flags_word_any(&vma->flags, VM_GROWSUP))
+		new_start = vma->vm_start;
+	else
+		new_start = vma->vm_end - size;
+
 	if (is_hugepage_only_range(vma->vm_mm, new_start, size))
 		return -EFAULT;
 
@@ -3032,7 +3035,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	int error = 0;
 	VMA_ITERATOR(vmi, mm, vma->vm_start);
 
-	if (!(vma->vm_flags & VM_GROWSUP))
+	if (!vma_test(vma, VMA_GROWSUP_BIT))
 		return -EFAULT;
 
 	mmap_assert_write_locked(mm);
@@ -3086,7 +3089,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
 			error = acct_stack_growth(vma, size, grow);
 			if (!error) {
-				if (vma->vm_flags & VM_LOCKED)
+				if (vma_test(vma, VMA_LOCKED_BIT))
 					mm->locked_vm += grow;
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
@@ -3117,7 +3120,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	int error = 0;
 	VMA_ITERATOR(vmi, mm, vma->vm_start);
 
-	if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 		return -EFAULT;
 
 	mmap_assert_write_locked(mm);
@@ -3165,7 +3168,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		if (grow <= vma->vm_pgoff) {
 			error = acct_stack_growth(vma, size, grow);
 			if (!error) {
-				if (vma->vm_flags & VM_LOCKED)
+				if (vma_test(vma, VMA_LOCKED_BIT))
 					mm->locked_vm += grow;
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
@@ -3215,7 +3218,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
 
-	if ((vma->vm_flags & VM_ACCOUNT) &&
+	if (vma_test(vma, VMA_ACCOUNT_BIT) &&
 	     security_vm_enough_memory_mm(mm, charged))
 		return -ENOMEM;
 
@@ -3237,7 +3240,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	}
 
 	if (vma_link(mm, vma)) {
-		if (vma->vm_flags & VM_ACCOUNT)
+		if (vma_test(vma, VMA_ACCOUNT_BIT))
 			vm_unacct_memory(charged);
 		return -ENOMEM;
 	}
diff --git a/mm/vma.h b/mm/vma.h
index e912d42c428a..4f96f16ddece 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -342,9 +342,9 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
 	 * private mappings, that's always the case when we have write
 	 * permissions as we properly have to handle COW.
 	 */
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_test(vma, VMA_SHARED_BIT))
 		return vma_wants_writenotify(vma, vma->vm_page_prot);
-	return !!(vma->vm_flags & VM_WRITE);
+	return vma_test(vma, VMA_WRITE_BIT);
 }
 
 #ifdef CONFIG_MMU
@@ -535,7 +535,7 @@ struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
 #ifdef CONFIG_64BIT
 static inline bool vma_is_sealed(struct vm_area_struct *vma)
 {
-	return (vma->vm_flags & VM_SEALED);
+	return vma_test(vma, VMA_SEALED_BIT);
 }
 #else
 static inline bool vma_is_sealed(struct vm_area_struct *vma)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5e74a2807930..d8a7e2b3b8f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3331,7 +3331,7 @@ static int should_skip_vma(unsigned long start, unsigned long end, struct mm_wal
 	if (!vma_has_recency(vma))
 		return true;
 
-	if (vma->vm_flags & (VM_LOCKED | VM_SPECIAL))
+	if (vma_flags_word_any(&vma->flags, VM_LOCKED | VM_SPECIAL))
 		return true;
 
 	if (vma == get_gate_vma(vma->vm_mm))
@@ -4221,7 +4221,7 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		return true;
 
 	/* exclude special VMAs containing anon pages from COW */
-	if (vma->vm_flags & VM_SPECIAL)
+	if (vma_flags_word_any(&vma->flags, VM_SPECIAL))
 		return true;
 
 	/* avoid taking the LRU lock under the PTL when possible */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c455c60f9caa..ab7f6c2f8f62 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1619,6 +1619,58 @@ static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
 	*bitmap &= ~value;
 }
 
+/* Retrieve the first system of VMA flags, non-atomically. */
+static inline unsigned long vma_flags_get_word(const vma_flags_t *flags)
+{
+	return *ACCESS_PRIVATE(flags, __vma_flags);
+}
+
+/*
+ * Bitwise-and the first system word of VMA flags and return the result,
+ * non-atomically.
+ */
+static inline unsigned long vma_flags_word_and(const vma_flags_t *flags,
+					       unsigned long value)
+{
+	return vma_flags_get_word(flags) & value;
+}
+
+/*
+ * Check to detmrmine whether first system word of VMA flags contains ANY of the
+ * bits contained in value, non-atomically.
+ */
+static inline bool vma_flags_word_any(const vma_flags_t *flags,
+				      unsigned long value)
+{
+	if (vma_flags_word_and(flags, value))
+		return true;
+
+	return false;
+}
+
+/*
+ * Check to detmrmine whether first system word of VMA flags contains ALL of the
+ * bits contained in value, non-atomically.
+ */
+static inline bool vma_flags_word_all(const vma_flags_t *flags,
+				      unsigned long value)
+{
+	const unsigned long res = vma_flags_word_and(flags, value);
+
+	return res == value;
+}
+
+/* Test if bit 'flag' is set in VMA flags. */
+static inline bool vma_flags_test(const vma_flags_t *flags, vma_flag_t flag)
+{
+	return test_bit((__force int)flag, ACCESS_PRIVATE(flags, __vma_flags));
+}
+
+/* Test if bit 'flag' is set in the VMA's flags. */
+static inline bool vma_test(const struct vm_area_struct *vma, vma_flag_t flag)
+{
+	return vma_flags_test(&vma->flags, flag);
+}
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
 static inline void vm_flags_init(struct vm_area_struct *vma,
-- 
2.51.0


