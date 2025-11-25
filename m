Return-Path: <linux-fsdevel+bounces-69753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55B3C8458A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BE93B01D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF82DAFBB;
	Tue, 25 Nov 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPYwIOTL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HdaEJBcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960DCA4E;
	Tue, 25 Nov 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064977; cv=fail; b=itRQCpbS0McS01N7XzNETvI+IRqkxUgMjKrksE7mxTKSoxiFHQvEdfykxyXcy6c2XImuwNdM2YMGINXkn8JnDwZMupogE8zBaUIUv4GbKA1MEkq6zBEayhB9FV1Cwf8XsQ1Zn4c7ifcBRpOw/i2adYT+q7q3i/v2yhRaFYMj/zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064977; c=relaxed/simple;
	bh=oLpzqtxw7ElCwDjvWDElh7F/S8pWaPWAZ8CPo4OpHrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h4pNlzu7WdFgRvebJK/Fd0JoPEsVpxtkjBpqLV8Xcb0Dt8eFo+wXc4pa8gwHyh8JKZb0Xz9pfbpkepkkU8GXVKunllnAItOtiv3tXLoGnYQuufTzAHu9evoa4L3fHpQ0KZv8FZQII/3llr2EwIWOUsLO6wKs/WeCNNk6Uan5WaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YPYwIOTL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HdaEJBcT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9ebq32433211;
	Tue, 25 Nov 2025 10:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=CUeMbYvqm//w+UZq
	gXSUftUXZQrMr8NfRNjaY9olmys=; b=YPYwIOTL+lwujrLKEEnYN1WNzSWL4jiw
	JZSYShXaFftIW1JYxVOroHgC431uts7dP/+2hQPr7sGX/YPgXT5dONsmhd9fXHbW
	OqJdmkbzkkkgALKWhfz+4LC+GOKqT3oA6hgTQRamSgFz9sI5VUep2XEmF/kvrfa3
	bDYcaMS7XoR3nY1L9+BGuQPN6yoJwENFo7NFaGwYp4Zz8bKSZJBPcV9eh01bpNVs
	0vWml8FRjbrpisXq8HI+pc9fJV2HdADuiax5AxthOBg7k4Wu6Vh8Wb5BvfEXUG2W
	+Fk053dI1ss9lkqH8kAlC+TSLS43DESIRhMI693xQ2Ce51SkU2KgFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7ycc8m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP9rL5V032814;
	Tue, 25 Nov 2025 10:01:12 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m98bf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hce2790uYlkOyMf+t/ptj+A56i/BBPCWydeiUzDLmGAsr0qI90AaQfGBkaWf6dfdlLpPHz3OZn9Dkc71UFAhBiklHx/lyNbOc1+XrjbqARWkuobPKagkj2+F9tU3x4do7TWkET3bX4aCiodBs9aA112tJ54RGv5uDr8VYCWoYyazmtRjaiaTOTuBpEIHwoRPgB1z/VvmKHy1UigBV63xMG3cZ4uysiLtTi0Cod78V24XfUnA01wtWifapz02kXBG/3+lWgEumxtZzTUcH4swPmA4i9Lu0pUn5gBY90o38YI4xNtNsqFhbQEPAY2TsYU4emBhLc0MxlAt03AGmwtDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUeMbYvqm//w+UZqgXSUftUXZQrMr8NfRNjaY9olmys=;
 b=ba5SHwXqef3JNmzevXq3aOKb1RKr4O4dBv1v9jxP2AsCIrG16HdtqMp2H+XG05WDlA9vlcqWTAGGdZf3DT6OuM1UV3i4iYUOzNeQl1KAdzwZUwqiGVXVlgnIYXmC4slidcswfjFFmnvkulev8cV3iq8DXnd2Rn/GbBMYBhQzj3kmNQvyViqJA8sxZFVvR/I/JlP70nPgyDfa2R0e8JJ0UGgqVONzSiN56g9nyR8zM322stE8I/alBFivzIgipZEZXg5VpsHJU82klKcl3ZS8w9JYBbO6UuUNvwHiaN6wrlFkBVmhOKN5KgPfjgq6+z1NuGNsVuByZ0YNtKKiVslQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUeMbYvqm//w+UZqgXSUftUXZQrMr8NfRNjaY9olmys=;
 b=HdaEJBcTGIDRHcx6WuGzl4ArWrCmVzN9XZ60T/ZoiyEeB9I+J4dM0BYH2/dQQjhZt73B115Z+3R6OQClavMyMqZiKbSfLV/f1xrsEEVrIz4UrHLB/5DoGHDuUW8GaxILJzRoWCKX+WsVulQDvgr5G7qaNPSOns2ejoIvCy8A+kI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:01:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:01:07 +0000
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
Subject: [PATCH v3 0/4] initial work on making VMA flags a bitmap
Date: Tue, 25 Nov 2025 10:00:58 +0000
Message-ID: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 50039618-dfd2-40b2-361a-08de2c098dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k8/yEofihDpfYsV6Ul1Cp4J6g7FGwVDm0y4LEcxkNwNBLHbqgqC23Qa0Fgld?=
 =?us-ascii?Q?xYmqeFDFVEsUd3SRi47yDNLJKuEoMtI5cs6yIxwCqXxFYgI2Tr99IibRz2Wd?=
 =?us-ascii?Q?1KcKREwPeH8hD5q2S2cVM9K6xqagS23qdsneAbEnnhLQAwWgGsYKFyGiHVkE?=
 =?us-ascii?Q?XIlEm32HIHmAhmp70AsstRQRAgOS2+/Mg6gYcC27rt4cBmXGvSe6YIBcGsj4?=
 =?us-ascii?Q?CLBJ536p0i+krno12/BNJFDgo3ctIxQLBBOQDoyJdVfB4y3cLAJSzzXFyjTP?=
 =?us-ascii?Q?dIwLcmv/b/Q0vZzbkcQ/DHMyNYA0sMvPTOXnEdZNAWECnSvlnEztUpD6YIhr?=
 =?us-ascii?Q?pwSgzI/f255ExNLpVKyuk2p5oQcCjfqoWsrWTdeCRNVxF43XF7QtSQZ378Zp?=
 =?us-ascii?Q?r5HyHCdXKiTM8uh8knkGSZRlXpSJu9/TKzqw2wwlw0VpW9HRveC3VeH9Mx98?=
 =?us-ascii?Q?USPdRpi0osezeRL/NfLU823lUZezdF6EQQ+P4mb7key27drehp+oZhSWcLDt?=
 =?us-ascii?Q?shueEdVnDaRi1mOlbxKCOvMBEgg/sEg57iNQhtM4qpRdrtttEYzPCcRwDpLn?=
 =?us-ascii?Q?4G/GGO5cnO9DhBYKEAkf76ZDq8uiZ/1el3j7LWySWik3VPBDjTLmDgn2cYPd?=
 =?us-ascii?Q?kZayUryU8/4ZLRIi+P9cWQQRA1xRiwOVmenuoFnv0OjlpiBJLw6wPC6veX2S?=
 =?us-ascii?Q?WIA50oh70NDqhFMRTSVpenFVKhO5I4lNKOlCky7hSmTnnBzq9x2xyyqqBbf0?=
 =?us-ascii?Q?2cgtLCoflKllMuUXqARBAS+5yS9o+K0VD6KoAnAp+3kKVMTgyQhlTT2egor0?=
 =?us-ascii?Q?y1gUC0fGLoHqlLF2LiVpeKuPVfpTYAAg2BtdEeMu4HNxLidSgyBo9WHzw90j?=
 =?us-ascii?Q?p0C1v5oOiXUmU8ZPMC3Qat145gXDjuXXbgY/hdfuM3NKU5WXVPYq9QrCA2l2?=
 =?us-ascii?Q?KGQyi27pmY3cLbPbprmFvS/GL5+Ed0MGARE/GWDC04Df+O1Dn1Xtyeq2NQvS?=
 =?us-ascii?Q?GoJYVrfcCakXsOUR05MDTXpegth1PNEJCQb9o+3L4wuBn+s4Qw97ruSrtZQL?=
 =?us-ascii?Q?f3ngTbELuk7UQ3ZExlc+LLFsAZSSHIn+fFaAuR/a91df4dtH1VM/tCPT3s9g?=
 =?us-ascii?Q?dkQ+p+xhygZkALiYCHh77vFjgF99URxvVv+DFt14cwZ/7Tz0z/VKsa0UiAK3?=
 =?us-ascii?Q?5Me84sVwIgScJUAWZVPCGsN/nUyXP0xCawqoJy58a5foYfJdRutun5CCxmfu?=
 =?us-ascii?Q?XqbjF1cmOth9CcPds7LpBniHfunZptiBWfe4Ti5X7olPotZkF93odWnn7Dta?=
 =?us-ascii?Q?UTEv9IXWx9NU2HaTCwtnS3kMmXQwcxe1swQ2/k+rJUzgCb3lcRU/z8nBIlQQ?=
 =?us-ascii?Q?OF8FUfXDIgACIpPp0bNBkFAdwZxF7agZUzo8DAZ9OCi9eH7iwPP+C50uWmK0?=
 =?us-ascii?Q?zwkCDlhp6H2AAngW6DCdg+TJemttvuu6GCA6ps+LMKLM3ZXIuPfuwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0vfvaS7gRTvBhHmreBY6TYZWpNDed3KaBSTxn2JlP2ycexTU4d19WiHQr4V?=
 =?us-ascii?Q?JbUocAoiYrJPeM++cGKvy6be57ECAXBLbVSPSjHAiStL+iJmTKAb8M6rNSPm?=
 =?us-ascii?Q?MPZuTmnrzwMGjJWyy+XW8uPq5A5Bmz5blX1KGfiHGefUjnipMVoiX7rRZb1f?=
 =?us-ascii?Q?+rEkQyw5POaUsiZAC7iCvACMzKfZRSScrinN4X/ifQSTslD8BkdC2QqmKXCr?=
 =?us-ascii?Q?HbAaSyutWOu6Kfq03gET+eGhcHpthmyW/Nxay8zLwsstGs6CsxbMDoGjXCqb?=
 =?us-ascii?Q?nAGv0JgrFEYG65q30vJ9yB4HwbWO7q9I5NkfqK7BiJaihLYvjEojnMQLoElg?=
 =?us-ascii?Q?vRQph6hWdRVYXK0ESq/RWH/MVNxiSo3kqHkXmZd4n6Lv6C09Riil+9+MwPnJ?=
 =?us-ascii?Q?TIW8ODfXpUw1/DVb6ulfvlb4cvSQDbH7KLf1fgY84SD+QA0Fv6fpX+C+rxHU?=
 =?us-ascii?Q?92VUHy5CS5qgk+WapR4IuYtnaueqdcBaog03E+lsxna0OlLNAzqnOiUae1vi?=
 =?us-ascii?Q?E1gcmzQF7lStbDx4PSjn74WQwHxMfkpNldpuT+G4VkNIMXWk02q/IyYx1O3p?=
 =?us-ascii?Q?bUSwen6oaN25UPPlf3Bd6cfCu2aoCv8gMUMiUyNjlUuHcHRivtQztE37dVS8?=
 =?us-ascii?Q?11kePrefZFwrs6BIKFSEhNcTrVTapQsGQLZaKbhLKZCCy9YegduOIW9yYjdY?=
 =?us-ascii?Q?HcfJ/Uby6aJj6IXUKzXbGPacffajAZfUNOkpkakIM4mVS2mO4kQhToZJQETY?=
 =?us-ascii?Q?xvTiQZhFDgweIMzOPaVcMeycQR4Rln0t97x2YrcviKJZDDTW5WeY7VXg93Ci?=
 =?us-ascii?Q?2PEgtpr/LEpf3tkieIlcT9GStKjGESb+SCBMG8b93oZzPlsX8QCE9stQV8YM?=
 =?us-ascii?Q?sAeTnMrPgc59jwBfu25bvJTDBS553GdEhTnjsQMjOcafkcxUNKbc5fs49jMC?=
 =?us-ascii?Q?6veZazVAQz/Rt+ZqrpOrVNhz895kZEpmipdcsh959C2Yy5zXqY8LHEXzzFo/?=
 =?us-ascii?Q?aQE2XWWy/Fo3hhTIw83WfneGal4Iii7bqi6TAewuwAREReoVJQFZroKvDN3H?=
 =?us-ascii?Q?TVXVURYG/N1244vF0i9P32FD/3U4m30sRD2aZ4psj4wrIIZygWpu/ump9pNZ?=
 =?us-ascii?Q?Zbnnd2+rF7Db8AvCohNoMHxn84Elyh2QIY8LHZ4MW8tw3A9uq35srCitk08U?=
 =?us-ascii?Q?cavEWH0WxwnsCoN5oCrbtdssXjc0Ys7DWrZiqfabZ8DBtoDBMXNhQXZfwdS1?=
 =?us-ascii?Q?Wmu+zsJeNxC/pdm4kwjTzKfjdDYIm1iZujZzKdE+NGA96BXXyFyLlZyjCYhT?=
 =?us-ascii?Q?DDjYirIPYul3lBME5B1v3Bl6kUlzDQNnbWnQu1VLQvfgk01a6krSiz33x03f?=
 =?us-ascii?Q?Usq5Zm8vJnFddvKeEqXbvvEU3eLDxlSLZFuOiywIRBqOr/byrsH9uTtBRDBb?=
 =?us-ascii?Q?OfFNJrBM6wg1TJ+QEG2Oh9tIyBfMjckr2lBtRvQPoavWdP327pv4UUkk07gH?=
 =?us-ascii?Q?pCCSAnmljx0yVZW6CyFQPij1c+glk1G2gZ6kOLzYNwmfKpE77rocvjJ0OVkA?=
 =?us-ascii?Q?JfVk2V0DgyqCyhlWAPPdYtwQJmxl/+2lU/YRmk4LgQvljk1Gc8UsfId3XwKZ?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n7s3d6UmQjikJR6JvRQWCO/YlXvMpdw2fYX5vcnzgWqJ796y4tn4e+KZG6Cwz7eBY8Sah8SqPInNSRAcxxxyDBFIf7MlCO5EQJPz/8CYEv48RV99XD1RNWAwOB9MPTqe1xmkckreVDlhnnpZU9XqehLPjB8axPdRGEaUBcn9ac8GnTEnszgE4/wSd1eTr66BuedouduC0kqybNioDMte+Dmg5O+eROx1Q5wyNBdJRfagNHF9hUEVxY3IWvmTfAuBU6UjZf+GL0qT0YBk6muhN0jpzCKQ2nKdeOzQDPAghkKvNmzVgweBws/gafsJdVGdB4Elkxe/9O1c0hvxKw+2Xiw4xO32N4y2YhbJyFKho+yjH3Am3WYGCCIrpJz0hklOP8Gekr3X08ONreZSVB3rXQtvMB5lxKNf1CFCENsWqz/jyOed1F+IJFE1iBO+YbzirPYEmi5mNRXvMikPmtiRkLcmnoOLePeIYvwiSGp2UhtaUYUKbm+XeWFW8bMACoQ96sk+4e5qc7FVzDjVvOd1xGcxPCunGcyQayS38No/XNct8yW53CxqffHRfIXmgMwDMyLx2anzQreMgbpFc5TiynGUaIYh4QonKdohm1J2/BU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50039618-dfd2-40b2-361a-08de2c098dac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:01:07.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPyjTn+Q9whJKyZMDR3gvKwCtX27lU/0CJiLW60TX5l4Wnan1RCO4XLaSvqX8Nn3cOEW9fFo2juJr9iCiajbe2J8QM01xpUCCXF+EtcJDrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=890
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250081
X-Proofpoint-GUID: HpmP2Ps9xRWgh5LQOL0qe4h9dlJa3BEx
X-Proofpoint-ORIG-GUID: HpmP2Ps9xRWgh5LQOL0qe4h9dlJa3BEx
X-Authority-Analysis: v=2.4 cv=RofI7SmK c=1 sm=1 tr=0 ts=69257e69 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=nbsiaTxyJr5HvUk3ITQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4MSBTYWx0ZWRfX1sgUyGu29QZk
 QALB+NX0tfu5EdYx+hySPqM35qlgP4JRHOiXze+yJYUIwGKN/rfXoitw4uhsn6KsJoIywUj/dm5
 iufbEH4cMgIpqWUrpdngBGuV74xY2IniTXO+dScdekm/17wsjwkBBbP+otBbijSscowZC9wAkRU
 V0NHTUH1Cu17BSTg8c+3i4hgnx93crqBvRAfNV1PP2K77g4w+TP0BSEfL6Z0oHAFaNsrhXELkJ2
 gXhDhSV8Y/kQfk4EzxQd9ZY9epZPn6ONHGXHjc53eOeP/y+4i7MSIcxA8jbvEg9at7LEDVUVMa1
 QcNEjCbKepBlLEHdYWFUCBFXrpBg4KNjgl4KaEvZo3J2b8TtQrrtyUR5ZmunlJdD1CntMXLZBAQ
 ozYJUE5kNLvitY6RqjsVFCOQUGysmA==

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

v3:
* Rebased against mm-new.
* Squashed fixups in to series.
* Propagated tags (thanks Vlasta!).
* After off-list discussion with Pedro Falcato, added defensive code in
  vm_flags_reset_once() to only clear bits higher than the first sytem word,
  retaining write-once semantics for the first system word, which is what
  callers are relying upon.

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
https://lore.kernel.org/all/cover.1763126447.git.lorenzo.stoakes@oracle.com>/

v1:
https://lore.kernel.org/all/cover.1761757731.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: declare VMA flags by bit
  mm: simplify and rename mm flags function for clarity
  tools/testing/vma: eliminate dependency on vma->__vm_flags
  mm: introduce VMA flags bitmap type

 fs/proc/task_mmu.c               |   4 +-
 include/linux/mm.h               | 401 +++++++++++++++------------
 include/linux/mm_types.h         |  78 +++++-
 kernel/fork.c                    |   4 +-
 mm/khugepaged.c                  |   2 +-
 mm/madvise.c                     |   2 +-
 rust/bindgen_parameters          |  25 ++
 rust/bindings/bindings_helper.h  |  25 ++
 rust/kernel/mm/virt.rs           |   2 +-
 tools/testing/vma/vma.c          |  20 +-
 tools/testing/vma/vma_internal.h | 454 ++++++++++++++++++++++++++-----
 11 files changed, 742 insertions(+), 275 deletions(-)

--
2.51.2

