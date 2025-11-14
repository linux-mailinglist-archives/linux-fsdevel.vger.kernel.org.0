Return-Path: <linux-fsdevel+bounces-68493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C2C5D5E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD72B35D4F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD96315D5D;
	Fri, 14 Nov 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ieaEAocJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R5VHFZJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA81EA65;
	Fri, 14 Nov 2025 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126948; cv=fail; b=io8e42P3dSf7J3R/448JdGd8/7C0i0jxdfIA+OdA53hcV4GC1x3JaZnXhUmAFQb1MTLbbALSew+gmT88ylykDIFZQJiBEVkCRewyuX3o2A3PGOOOSX9bViAlIGMYGC+lBeg3StFRSMC3Yh2/pIsnzgXgnWia9plSLv6TTF0AMyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126948; c=relaxed/simple;
	bh=x6o0L6UFKVg5rBW1HLz0KjhaEd5Gdvv8fS1URJbBPXw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LH0aCVrVaYmuA9b5EvNKbGXag/4Vw1MzDgwMnhXrKgvIFzD7Z864f6M3ItmWgfEyAViVI0aAYCG3lCyFLZWGqkmWN6PeLNxpXg47LFbYSdM7OsHWmJbn+tTafvKsgZECb/tIv0VsigJdtRQvIlsWXgDdEcREvTI0y+OfcJ/iFq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ieaEAocJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R5VHFZJO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuUv3009534;
	Fri, 14 Nov 2025 13:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=3/qxW8sKrWfvAti3
	VwBy5McXCuoNrlyMPic+s5HmBlU=; b=ieaEAocJpsem9lH/WBD5V6elVZPpGus6
	Hm8apmnY9U8Zsoh3dW5AyPd/4E5tWzz8qu6na47UTo6HS7INnfgd+BO23tyqNx62
	uFM5yJcg2bDHm1BtghVORKtwX6Q3wTfHmSzLgu4lRYNq1/JLPxpRIV602J6Yx4Vd
	ycLIfBqMBOMPQPyiQwV1M2uKob+zE8drSfzFoxZQkKVnYAZYZhMIHEgf5pvsXMum
	fnabS8lfA/0OTgFXYBeeISQEmFJjB9KVTuWEMgG2rtcd3QWwBmilrnhovDlyhv5E
	/qF3m34PVR4GAjm5AhqIuODpxR4FaU1c7gOJT00htnc+9hhYRGhJgw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8v15rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECAllt003193;
	Fri, 14 Nov 2025 13:26:36 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vae2m4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf/PEZhOaRaSSCQLA0c7DmLeJUSzIMiGF1NPeLA/xwF3wxQB6PYT4EAdAx2aCFJ2VvL+rdzR0IMBAv4aNRJlzvCDM9vSgDpO73+5GER/qQ2WdvVnlY+3ePlQhoEiOhxgvDUmTWjG6zfo8CQBghz7AYdeCDF6b0kUXDHv39tXBr/NEpewcP0xI7bnQezrk1F5au6lHZVVb+ac09aMEXtP3pXh/crHqVWjJhszszR548cXHNBCtbxZppjDHBNF2Nyazf3QySK9ym4tbRyUOJrsJ/CqIB8KlTa8AzCarJDSxKoRGVjmYOBHkQelz3vvMOnDGDSx77Q+nHCXmkRHIyfP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/qxW8sKrWfvAti3VwBy5McXCuoNrlyMPic+s5HmBlU=;
 b=Xs6d9TnNAICRcXFuANfbNIOMjGlYZUjRq6tDt+itD4VfwtxkaXPUpwC9RCYV8ky6WfeMqaTLxgZfcV4fuNU0AavqiuRfggwa/ow7LP1nRhQHPTb/ug5MlKJPD3kCLwgI265naS0KwIH6M2zBf6J+xGw9WFNkkZxuP9uCn2BspMKbqK/BhKeFmNdx+QZrgxP2snLgZy1ppyUj5ZPaxSZWpytQZVg3+/TyZGyTXdjuJPmZYFpGWI5uIdlvx7yM3Ry+CcyHbwf+LOZXFm4QG/c4GN4paOwV6qdE9pN3Fh/zAVBEW0eUEB2wR/osNdN74vWrMQyv1bMJSJr/H1Ndf4+Dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/qxW8sKrWfvAti3VwBy5McXCuoNrlyMPic+s5HmBlU=;
 b=R5VHFZJOL9eJa7431gMKtsq5KdND5RNVWJnQ0xd7cHqQLHI+mpJLwCcdWQVfkkbC7uzXAAAXn9WikoJTe4DcaNk5AQx+gy8aFDvMlsopu0hpfjmx5cEeh8nQVcUqWEh+Yugv3kEiQQAYPFTfc+3FhQWgbPPQFzJ7GhbsJ1TVJvU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF2BB505D96.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 13:26:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 13:26:29 +0000
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/4] initial work on making VMA flags a bitmap
Date: Fri, 14 Nov 2025 13:26:07 +0000
Message-ID: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF2BB505D96:EE_
X-MS-Office365-Filtering-Correlation-Id: 41293b2c-4f18-4004-d104-08de23816bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLKg88HDj4aRgwlCKnLUoPBxCNtZS0lJ6KUV6i8h6Dbx8a79Isg0DYzuymi7?=
 =?us-ascii?Q?wxZyzw9JNv5+lSUsJJCKKN9f9eS4R8D69jZ7OzkZpVDiYXS0kduVX2E/Rm4B?=
 =?us-ascii?Q?AfnaP2qUyDSj4MgdPTCMcf6D0zCHu5vYruXkwxrocEWvnRV7gajxlvaYJyJa?=
 =?us-ascii?Q?mDzxlThCTNmVgD/JhQIdbpieHkW5g3i9KPDCTm33U+eibTfA0TRe+ikPsHfD?=
 =?us-ascii?Q?kEdVr9kk246G7fv3iYuISzmYlUSXHjI0qydIVy2yhUoZXYiSU4gfs5SZ9JwB?=
 =?us-ascii?Q?cswuvMuVPb/IRI1lEOxkSZUa/TWm3tcO7H7qMhwR4J0HZ9tuGH5HplcU7orm?=
 =?us-ascii?Q?BieRclCLlZ21ts3YXPxrAySxXb6LT00qmO7zH76kPmLsCBwki2oKy+Bwwy6M?=
 =?us-ascii?Q?yXEYPqRbK4Lv6/mol/SpfIUYN3FQVR92Js0gzs/Z/KMmo1BPRqZ/+ETeBzkj?=
 =?us-ascii?Q?nYupMvShR7UMPGOK0hae7cWenef8dqR41iYVVYmPpm11YZJvlJuyyrIn7LTN?=
 =?us-ascii?Q?GfyMAk4h8p6eQC3Ze2Gm3YcM8uZwMBKoptDU5ORsjqm9ceLNOd7Msc05VBig?=
 =?us-ascii?Q?Qbm56FMlu+YozokrzkY+3hnA/zcOv6xeBmdeegwu91GVg9FX89lzYIUktT/s?=
 =?us-ascii?Q?Et1qZF/48RFBS6CzCaPuXcHQQcQkjSvpFitLJCoB8NxXJWiFWHbv2smugcJR?=
 =?us-ascii?Q?5wBjOdLX2j8PpKdaY1BZSGwGFCgU2ICeqcRxZKPOhlrpafA8VSLJr9l1t2tx?=
 =?us-ascii?Q?oQ/cTUDm5hCyrCfUUo5wYZ8WTYgUF4w+bW688R+96OhyMvdp/+nr4mbihXet?=
 =?us-ascii?Q?wdzC/p2gZbYvgibQetZaLVrRzUYo5/rCEL6U6JQWpnpXN8PKKQqQBVPcJtNj?=
 =?us-ascii?Q?B7Z6G2VD7hwweKfVVUMq4a8bVoHZ26sBrEcxels0gT5USJkgadfpEbyI90tu?=
 =?us-ascii?Q?i4pBud1lE0Wz2YG1kmxYcg4EqGiLvWj9BMDbEJzKpA9Y4BedM3SLmfC5fMXR?=
 =?us-ascii?Q?CG26xRnd1FRAvmuNwbZr8slQcIjzN1tg0kb9V/oxw24gs4IJpTfCzvL56qqG?=
 =?us-ascii?Q?JZ9hPUjmAJica2NwJ9pxnIfGZfiSxsX+ape9T/0Q4x7ivrDVyQOdMbpPwG/i?=
 =?us-ascii?Q?kb3AIdUVBD9HzfKrsbnEHd1tGVWuflnC08q2IaCpBynKDpuFtMdh7dc7LLDe?=
 =?us-ascii?Q?OSbfX9pZRgp/H4KdPOSf4uNk5JlN2Uh3kNTelMB9zmuZm5HcMPnaDQXVMbZd?=
 =?us-ascii?Q?JyenfHz00qZ0rhziA9JEZ9BOU/BaDJVg5p0H10yq7Ex3OPNJtswayzCUIupv?=
 =?us-ascii?Q?fBugsa/wbTn3PUmF2vwe5tdgDAAnblgrUYMeqHBdK+c9EF/JTjsLUf4Kos6A?=
 =?us-ascii?Q?a4aTmENFbJA9KkcFzecs99gdzgjcWBS1XK/pPAvUMeX8e0OTx72gbND/SbQC?=
 =?us-ascii?Q?VvZQXgfpjCRS/8pEgzFupvaSSW2ATMKo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hfiqx29b26n0cnRaqRTIrUlu58gXJxZabXib+6FL9dhh1R0+GLgHRuPacJy/?=
 =?us-ascii?Q?6kS0zzlVMd5MUzzmoYoBmKeSrLhTUW9bjLN40QqR6R4ykn7RXaLm28Vfyc2w?=
 =?us-ascii?Q?+pcD9JMOgPsNTwVoGH3ONwGHK2QNzgkXDUexIRVPCuvEKPE54as4dcxyUaYe?=
 =?us-ascii?Q?0jeXbayoZfx32q3GAQ6ZMhy5xbt2PmQssE1/574bDtL4Pz5+oUWK7kJL2pGi?=
 =?us-ascii?Q?QbbV/3y4nzZ7Sxrw8mGXy9ppPAqvIVh8OiQPVHhLh1uY87G3WF925RuIrcOC?=
 =?us-ascii?Q?g+KGcdBcQNbGEc5p2/ZgFtuW//I4STaRi/dD/SQr4YLga3W9f+k3ZoH/lorq?=
 =?us-ascii?Q?fDLTc9CldOFGhNdSRrgwmim5qwS/NrvGZC8OSQ2Kwp41xX5wM58hB11N+s1P?=
 =?us-ascii?Q?JhCyCsfUr6HoG2UVjI1ic8kniSAJ0K32ESvqqYQHKJnIR2TDoK6s/Ae7qZ3b?=
 =?us-ascii?Q?iBCfgmj4xs4kImSFrx2LJtJiz9C+tUGIA4xedN++arnPjyiZ4TEIlzegkzcn?=
 =?us-ascii?Q?rwLp1mH9ULXLnf4eOS1j9DZksetZD/z1wn4qcaXughEFyKvFChB3N7yuchFn?=
 =?us-ascii?Q?RZXjbURF/+728VBzZSpW/6i5G666eWE9FOH4sncs9GpxqME02qWzlEnv91Ej?=
 =?us-ascii?Q?kfwLyMOxfes8LFPdXq5AV1HojxYwl0cOfxFjMfbjd5gWL/GX69ff84YghgiL?=
 =?us-ascii?Q?sLf01FYVEzWE+o+MNIHLSBLsMvawLdYUigWuo+sP9WcNqnWrURM3uumsmYbK?=
 =?us-ascii?Q?dhNMFhROcX3k38Ha5U/s2P/McXrIrgSXdq5iYcNS1kiaNbo7taLPesXE/e6a?=
 =?us-ascii?Q?IGPdjOKUbXHVLo9g7p1oh9vFLfFDXQcWMrwAwL9sn4s425HMMJ/3R6e/rwtQ?=
 =?us-ascii?Q?B7eXJI37Abt0jnOMCxyFbF4qmf0sKi55ui+5aKxfsHtb6w0kLmf+mpnDF/N1?=
 =?us-ascii?Q?74LWMgfNZkH3ytVaVHXx3gjcY3aZULzcylxEdofHsxeVW4rcr/vS7Xny526f?=
 =?us-ascii?Q?f7v4SXiNSYyvOPenh0Nn3y/r72Y7qf5EbigaHlG0QXYYE2RYjhDlAfYRUqHi?=
 =?us-ascii?Q?n8Mt8YLpv5sBJI8ZAIYIKrXfVVmzzBra5v1Q78wrOdbwKslVrDT+A78rSPzB?=
 =?us-ascii?Q?S0OiRnttWfidlG8uPCZxOGAbmNGjihwAaq/ZKPFUJhaEG2mTM0YxJAsYm2Lz?=
 =?us-ascii?Q?fcX0lpdFl/EryT3ZlTsDM9wk5dsC23AGc4UiIvhagSTncl8i21PuBCw+FmBl?=
 =?us-ascii?Q?rK/LEW7b9lRu6+px5oeb6GLnFxOGzFIDojY4Lw+giZKYeFPFdoyb7+Nviu9q?=
 =?us-ascii?Q?TBoTHxAEL+S04gu/azmscARDaAt3iI97hLaPCnFslFn2zP0ELMLe0dus+Z0Y?=
 =?us-ascii?Q?IC5Ht7+rzefbz2TzMWH+fNGholMkjOBWKHs5RPC+Z6xOSRPlseRAJgpfYI3s?=
 =?us-ascii?Q?mKsmUYtrUu0BHEVHmJgMfvow7ONmpbU6l9vdyXCvt3NkrsLsqiQQO/A15n1n?=
 =?us-ascii?Q?UGq1e9Gy8Ud2rBcvqU/wlK8CjoP6X5+sEc89XrR2/4+8wbDbVX2nTvwrMmYY?=
 =?us-ascii?Q?2sGe5iOKo0SLdj/WLzUSWJALmINoJ64iQmvDnqrZVEx1a2Qw91+34VRk0Uz0?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZiZkWEEnWMuP+TUVuOhahA38hd9Ikmq0hv9ESK5KD3VeWwJ2zoQQvU848cinHWzaUy/Rrj7+ks7u4x9d2GIuReYiZvM+96QHSXIPuR1xEdZlsAQUsSqsbwPVKmEI9tP7SxPcqauMBBS2UECtFuizsNfianSAXjP8pkQ4pqqOQZRRTo2BClhwbsncbKarFOukMgX3dYSOKKKMQYqf08TnAA2bfHCLC02mJCRXKzh6i6n4LyqKYeW2mtxofcC1f7PcHBNEK6gVbbeUzTOL7iSgRJNzhhFYfk6k19JIM6giIzrnb75MAV3lOdZy9jLWDSCq0fM9pfSVb07Qm2RnvUgL+kpbgM7DNQei7XSkIqAOMdiazcEwzo92xtwhpTKR+YsBPSvKtFSHwDpoa9RrLV418sbTHr10G/dkf/3Xjoo+qC30aTl/BqboFzqmgaKjLx0m5BZZu9fBXby7vvQvxLn1B+6a9S0ufgK6exTy9JamqO8bfZ0LTtio4nAponCKwnyRyKAaiHw7gGZnLFJ1+2qjopqFYb6+6f5Kj6SogWXeR+ZDoru2suCgUBjJJU/X68Q6W5f9YX/r51lk0iGdGSHxNqfKWWNeqLqB1mawGOidMXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41293b2c-4f18-4004-d104-08de23816bb4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:26:29.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weAC3n/K25UHBzQz2UocWRNMqYw6aTDY3D8/xIEBDLDfwW6EwS0zDyo2aZUg5W+TixJ4gA2IOAKbfFyvKsIAFJDk0gCmTkghZli3E3i59P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BB505D96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511140107
X-Authority-Analysis: v=2.4 cv=YP6SCBGx c=1 sm=1 tr=0 ts=69172e0e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=nbsiaTxyJr5HvUk3ITQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 1dktvS7OFiDa3uLFIiPrb_mY44aTXrsb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX0lAFoe97IXvc
 GQe0QrBW24Y33zyrWg1Lovn6C7SQ16QeCJhUcLgYfRjKPNZqFXbWu1WpIWuhjk8wZeK/fvn0vr+
 r+r6VRwpKWwKbE0Vtldia6hgcvQeOqoZs6aEcfE0YF9NFzGoqfaiOxPgmvx0Q5VzYq4VR3XCG66
 PqNjX+fFRSAA2vI/AeGfzwiuT1PnbVbJNOqhNPWT/4r4iTVFvrsC1xWyYjQsYKx3EvGbap1smU2
 JkRWgXrjI3aLZQsdeR/A5CDj0hFzIL7cxQIcvufuTnWmx1sXfuJmP5LkJS8uqkrRfsWozFpr+8s
 HLTBW6ioPy1PpbSL3eUH4n4X0NwnGW6wmCffL9LCwglLeeFK7qVWPZgSTKZJlcerZUGZ5ER89ZB
 Mnpgs6TK81Gpb3k2A9/FYM+i0y4pNg==
X-Proofpoint-GUID: 1dktvS7OFiDa3uLFIiPrb_mY44aTXrsb

We are in the rather silly situation that we are running out of VMA flags
as they are currently limited to a system word in size.

This leads to absurd situations where we limit features to 64-bit
architectures only because we simply do not have the ability to add a flag
for 32-bit ones.

This is very constraining and leads to hacks or, in the worst case, simply
an inability to implement features we want for entirely arbitrary reasons.

This also of course gives us something of a Y2K type situation in mm where
we might eventually exhaust all of the VMA flags even on 64-bit systems.

This series lays the groundwork for getting away from this limitation by
establishing VMA flags as a bitmap whose size we can increase in future
beyond 64 bits if required.

This is necessarily a highly iterative process given the extensive use of
VMA flags throughout the kernel, so we start by performing basic steps.

Firstly, we declare VMA flags by bit number rather than by value, retaining
the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
fields.

While we are here, we use sparse annotations to ensure that, when dealing
with VMA bit number parameters, we cannot be passed values which are not
declared as such - providing some useful type safety.

We then introduce an opaque VMA flag type, much like the opaque mm_struct
flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
field"), which we establish in union with vma->vm_flags (but still set at
system word size meaning there is no functional or data type size change).

We update the vm_flags_xxx() helpers to use this new bitmap, introducing
sensible helpers to do so.

This series lays the foundation for further work to expand the use of
bitmap VMA flags and eventually eliminate these arbitrary restrictions.


v2:
* Corrected kdoc for vma_flag_t.
* Introduced DECLARE_VMA_BIT() as per Jason. We can't also declare the VMA
  flags in the enum as this breaks assumptions in the kernel, resulting in
  errors like 'enum constant in boolean context
  [-Werror=int-in-bool-context]'.
* Dropped the conversion patch - To make life simpler this cycle, let's just
  fixup the flag declarations and introduce the new field type and introduce
  vm_flags_*() changes. We can do more later.
* Split out VMA testing vma->__vm_flags change.
* Fixed vma_flag_*_atomic() helper functions for sparse purposes to work
  with vma_flag_t.
* Fixed rust breakages as reported by Nico and help provided by Alice. For
  now we are doing a minimal fix, we can do a more substantial one once the
  VMA flag helper functions are introduced in an upcoming series.

v1:
https://lore.kernel.org/all/cover.1761757731.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: declare VMA flags by bit
  mm: simplify and rename mm flags function for clarity
  tools/testing/vma: eliminate dependency on vma->__vm_flags
  mm: introduce VMA flags bitmap type

 fs/proc/task_mmu.c               |   4 +-
 include/linux/mm.h               | 400 +++++++++++++++------------
 include/linux/mm_types.h         |  78 +++++-
 kernel/fork.c                    |   4 +-
 mm/khugepaged.c                  |   2 +-
 mm/madvise.c                     |   2 +-
 rust/bindings/bindings_helper.h  |  25 ++
 rust/kernel/mm/virt.rs           |   2 +-
 tools/testing/vma/vma.c          |  20 +-
 tools/testing/vma/vma_internal.h | 446 ++++++++++++++++++++++++++-----
 10 files changed, 716 insertions(+), 267 deletions(-)

--
2.51.0

