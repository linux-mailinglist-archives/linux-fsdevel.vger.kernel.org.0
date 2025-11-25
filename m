Return-Path: <linux-fsdevel+bounces-69752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B356C84581
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E21213436DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97D52857FC;
	Tue, 25 Nov 2025 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S8ZXah+O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uHiHMBqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BDCA4E;
	Tue, 25 Nov 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064955; cv=fail; b=OymsrrKZUZF2h4rrFNC5XwsqF+wxc0OGewIhjHGokNdHGOty/uvja9LPj4Hn/1LMt1igd/EyyoVrtMQEOxlvb3NDUS6lKXfPDxK57qh4SyULagSmdwjgL2xUu1y29r2wgoDqA0hodmKWWPSxuSm1YbH8mqQMkFIPSuC4Vkbq63Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064955; c=relaxed/simple;
	bh=S8xYOi5Zqi0RJlfNtEMrt4QU60S1pX3je0uojUkVHW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSJMzSKJsgYt5CGSEfOTiGr+JntB4Hh+3KYDNXjv0sM8kpmelpJ6s+7rvAvaa0k+NCFAb5G9tngqjpQSJKjU48I18VpbUTrAHkiUNaaEDqj/9bIl4LX9GcaiFpD5K0Cuv+Aiox5sV32YEV9HWujVxbTGEBDQZGD6Fy/W7zPeOWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S8ZXah+O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uHiHMBqg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9UmkX2396302;
	Tue, 25 Nov 2025 10:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gO1c/23zC0LHtrgdy2RCgyv1LL6NGMKA/ozIcvwM0G8=; b=
	S8ZXah+OJAdLybINJV6huLcz2V5oT21jXY5kgJtPV3uMwvMbtRfCWuwGx5L7LgEl
	a4lv9dHCE+yY8jcJmfuKgc1MVbf/F1A6JlfjkzwWId1CGUuXbzn7IaA0b13PdrPf
	8VyDdwh7HKFTJbVzeysrVPb6erYtTL+4C2LX42gpWiVPwB3G4H9do9I/kG8DYVc3
	Dhq3WFewzyE6x2UmE/XSr4TdjoSfmjDAUIoe667SJZ0NZ5PVhB1S9YWc9F0foh5A
	3v4DQvIFwVkPvC4gSLAbJ3RVoJbojN0Kb5CCVA2CagRzCyGJRgZUxJ4QI4PTNVUK
	ZPMWxQrmTErNk5xiyLknKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak7xd4bew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP9tKNN022443;
	Tue, 25 Nov 2025 10:01:20 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mk9r4r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxwSZCsicKMSduucrn1I7ZG3xDA8PDQOlFDUkqUC/34l7ZrMnQKw1a2tw/op1h3qetwX7FbYcaBsxJSKS/bYshn0+tlYzX43iBvM0OHhQE2Bxld8Z+YiylX86yPP/AZxNeflVeoQ3zw6og+QJgJM71hfVET2e78R65dXjm/2AurfO7NgU2eGd4Ggog00Efk12XOjSnRnqsHk+epUsXzSp5oIVb1vwhh0iJIiyA5/4Rn/5sly73HCpqxtSzSaOfsg5OX/dPGSNfTxKQvO6IkTOD02BLUGacQMHCaTf86aiSeP5a77HthDSEklUar62clORu7MxolSpbfQQOBs3XQy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO1c/23zC0LHtrgdy2RCgyv1LL6NGMKA/ozIcvwM0G8=;
 b=o4wlr6wTF8lXfh14+1EJWOBA47AZnDh6dzA0lyyluq3UDIfLRrVtVADuPF3LFjyQesniMFRIkVeUB2i0hVgHWGWWxPTfRdj7Lk1RtIMQu041y4QBcT2nVAPEyuqAKBi38pSTqEXKCfJBdraAHszYWZAmKbCyzrAXzMBC+CIuiKWfBnK6yE6UL4ivftD0O+hvWycqDASdJTW0XPag603hlClgaMWVU+q+ofmjYew0sQcanV2mgOKMN/8Q80+AshthCIwXWiTcrUTEhNjskzCd+6DXK09Lq9enet4PL9s/DMq+ELubKZ+MqREMj3nAlqrkFxOn7KroeEDnoyhJbnvQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO1c/23zC0LHtrgdy2RCgyv1LL6NGMKA/ozIcvwM0G8=;
 b=uHiHMBqgfVOs0wYy8G0ZbefvyKYV1RjR87TGLGl8awg3KtcvsmQnnY7v5XmIk0ZeJdv526lvJXQsd9cX/xaugkFvMwix2slAqye/5Gyq/UjMO/kUXTfQFs0woWn4c0hAuJmo7pHhKH2FSlQKdWkcrfIED/ymljpSD5GNUOiOE6E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:01:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:01:14 +0000
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
Subject: [PATCH v3 3/4] tools/testing/vma: eliminate dependency on vma->__vm_flags
Date: Tue, 25 Nov 2025 10:01:01 +0000
Message-ID: <6275c53a6bb20743edcbe92d3e130183b47d18d0.1764064557.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0692.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: a0aed148-2a2b-471b-b5cf-08de2c0991b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/nPsWutSQGDtMvYD80Nyb18TWt4XaVodzvsC5JcLnnwaYw8hwpXwu5JJ/BT?=
 =?us-ascii?Q?vrs5IX8g6QCh3QjhV4gf/KpOZ8V9GcWWK1PqIkmmdNcMG4VoNSq2gDLRTudx?=
 =?us-ascii?Q?H3+VVM5cdLBKOiABDjSFdF5TLJfQQLNgXZx4QuutE9ydyWk3d3DeLSRJpg31?=
 =?us-ascii?Q?iBOwTlIITf56HBpb2EmqUgoJu0swcJ4N1iACNSXHjgES48pDwJSf4F3XOnPW?=
 =?us-ascii?Q?N9f1W28NrPqYTPzRrXmfCBl/ICObBYQ+Hht8Ab7/EfjtlyuQ3PlZpJbww+JV?=
 =?us-ascii?Q?mhb6VBhik/eEHvtkHCjXbgXgFRoGy5o40Ga/3Yyu7Hj/DU8VVN9+DLow0Y6y?=
 =?us-ascii?Q?f9Epb1wKjGzGz+eBxMSGJPKlZlxPtLAqkFHh7LTWyoR92dhE6buyD7MluZqQ?=
 =?us-ascii?Q?t7kuGdWWsOgaOEofKHWqDyLoYnWnnat2OOPLfHga1y+kCUjXzQo4b9tC2pem?=
 =?us-ascii?Q?XVPC09jN5obUkY3cU05t1fA9Q3a5swrwapTNUxcXiNLcolks82GU58IzzmPm?=
 =?us-ascii?Q?taXZ26WC/bQmB0M1cGlAOEel1eR5Z4Fm32nBLEJ5HQ6g0k38iwdAduna7lNp?=
 =?us-ascii?Q?d1O1UafeTPEiOwhsNd3Vnkw7pKGC/ZjyRkkGfXuBfy193pGgOyLK3JOjVsoN?=
 =?us-ascii?Q?hX5eBkJD/wBxBhIdnw1XpPWu0VGKwZNjux3NNLrROrxvomtlHVEhi+WQaM3c?=
 =?us-ascii?Q?rpb+NPN+3zzhatvPJPh7I0Nky+a1RjI+zbF74Mzpk7a6uy6ZoHwNWKz2jN2P?=
 =?us-ascii?Q?xjnC4n4N3LUFRnmwOIeAWY8XeYT6CPtPWXOfPC86d6kchEB+XTMXuwT+AlFR?=
 =?us-ascii?Q?wFKfOcu+ukWz9S8tGOZjyb7a2NzMIMnS6djYXd2pQ8BqKeVxXn4l2MOLqpgk?=
 =?us-ascii?Q?E3fyYzKiT21luGyKtb7LdICcAZYXuyMMyBwIej/BPqwPhKWad+l8dh2h6WUW?=
 =?us-ascii?Q?aZskNoCwJFUT2k3LS5ct3Rlz1PR3WNoAMF+Jy1MjUW2h3l79ayiqULLlvkpZ?=
 =?us-ascii?Q?Hqn2xtXIcntUwYjOUImI/kUBnXPM5K1A23Ikwq1ZV39v7HbC5RZQlasUwVqu?=
 =?us-ascii?Q?TeS6lpH+2YPstGgXWYnIlsPT0e/JE5NSEDixxvwbspoNS+yRbQ0DCUw40n1c?=
 =?us-ascii?Q?m8u2CLirPcrZIUKjo66srJpRUYGme41+QkqbtmsRyn4sDpkWdzq6cvfHBCRY?=
 =?us-ascii?Q?ygT/YedKoZDzCFo53of94sVxsErRFVxurDdvmot9egH7rSBTtSw7ghZBXY6U?=
 =?us-ascii?Q?DRzNtabWYr+QS7N2q9OxChlSrPol6WUlo40Dk7L5hNkrpB7o3L/xQ0EDnFJ6?=
 =?us-ascii?Q?62BgppN0fiVC6ty6bffETTDaXebZlED4vSXgYr2hOILDT34M/x+F6dsMgs9X?=
 =?us-ascii?Q?OzcKxO+TCDGdqAyjRWAVUnvSOJQDre4txsb8nG+fx+GnAqxa7v4wdgVV/Fcv?=
 =?us-ascii?Q?jRZeKj/T0+zuzq7E/rKgvmE/cy6aZ/t5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPuiQnQmLNgS3SQr6kfLBo+jCNfkeCoZjbDsvOn7Tx/FWsoHk/ErBlTmMJcp?=
 =?us-ascii?Q?egaC4i7yoaFpNLjYJN3oFg0YYHEE2vjkR5nAndzTwD3u8QYvNvw/vA3+nz1R?=
 =?us-ascii?Q?+G6bld9rX08JZMFhvDjqipB1IzCk9XX3hS9pFfCmzOlhmfcjtRRfbpBowGr8?=
 =?us-ascii?Q?4M7L0fMne4VOfSn41AhXxxIfPskjWhOcqx0Ie5PEuqHpQa1YxAqUnn9WVLsX?=
 =?us-ascii?Q?WSNommdyRmwiLB/6RRHuOkclfSB8YWPkOExMpzwTA9wTraIe7Lui1pDmNoK2?=
 =?us-ascii?Q?FeUrmATifHn9XmDIhfoJXYNnAT9kN0fUqLhipyBAURiyhlSOWKZpeQo3d/rh?=
 =?us-ascii?Q?Kpk9MPvEmjeqVdpH4PgLyATrNuJxKWgw8pHKNXeCHuI6xdffJaaPvauuoADX?=
 =?us-ascii?Q?lreSLtlL297t0DLey95NEouDFMfGk3sjtXohUxQwnuGbxiPjb3JlcfdVINpj?=
 =?us-ascii?Q?VBuYU4ZVe76vHLPYBU1QgwQEuC/AX16KQhDqXV04R2NTCikjwy20Z4bRPPTG?=
 =?us-ascii?Q?TYB+bYtoQr9xZDY7q2fwyQ/I5zc9bJIq4VuFteu0CQeDEXFJvPVycxzWl50g?=
 =?us-ascii?Q?DsmypJb2N+d+HRQEPMX+r/E6zMEu1rbgSj6kG3dPZT+JzMlwl964uTUUg3iD?=
 =?us-ascii?Q?Rmu11jUihcfZaX+TqFXYaaSxj9sOysIxQhPdFt/8CVHB7PfOxu3PxW5MeR/c?=
 =?us-ascii?Q?gIuZpK7kZwN5JfYXJWeJG7yFiha7+JnnfcGaCrJ5Wy9jGvh15j9qRITCNiLV?=
 =?us-ascii?Q?G2uHNWu/9WAJd9mDyomWK2sk6CZc3GkAhIJiOzIRkEsVpYYLxRiVH7X72FZY?=
 =?us-ascii?Q?mgpvQ5YkoF8SVlN4KqY08JJIO0pnQNfXjB2/mnyR0iBNHGlOZKi7OK9jYv2b?=
 =?us-ascii?Q?Eszkwrr6pHHzo7hhbLY3AG7iYdOMPieARIsLyOldUxBt4wsP6K51Ssr+ogTp?=
 =?us-ascii?Q?1XoAn3GozePIznLAOs5C0+5kyqcy0QucEr7jzuP7i7v8fQwRvxu6Yl+axRnh?=
 =?us-ascii?Q?EtW1OXN7zuiDzrtLkkM2mPQUp7HrJxqte+CmudX4Qr/Xkf3PLiccndPFkCDy?=
 =?us-ascii?Q?PxH8lg6o/8GbTNQffkbzQl3oT0f+8zXmPQhRX00wBy9P31iWfDE/yRLn6icc?=
 =?us-ascii?Q?v9Ac3C1zvzC+M/wtAQzDxHRIE73GIDJU1buRTBBf1VzDFhMUROjlXnO7G9gh?=
 =?us-ascii?Q?WdQH04l+Lo4tO48+ZgzXn3nFnePHvKHZOtaTnbrooZbtgubWGXi+tsnkRR8P?=
 =?us-ascii?Q?ZKJGnzca+NKQUTk7Yzf4mcZ0mZv8nT9OOeoycXfiidSadFtUyv/0VIEnq6DM?=
 =?us-ascii?Q?aTmi0NLsX3+VCM0jRrt6QdEntxAWeZWEZpMtXejRhHRDlPvM3M3iJjIxyQ1w?=
 =?us-ascii?Q?pzaEyxuTR+6YZQZcX86HLl+ukAjdocWzyH+ANsiJ2QzeZwOk9uK/JqA84N6i?=
 =?us-ascii?Q?qi3rsyCZxu5JS2l5nkEFb48YHl25nxxfcnrGIqoxpeeqbCJzmkSKzNL3dFxH?=
 =?us-ascii?Q?3jk1o0TXhO8xjP4DfLDrlLP8LdgaHfYxI8uthbPeUBZZABRNTHJgjAewwxeq?=
 =?us-ascii?Q?p0i56lnTodeWWCXoqffmcLVU5j5ZXn4ImfaAmICwAAbun73P2gWmPCztI10S?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UePkpyE5+dpfNoymFrr3alp+1fNJhBOqGYL6kGgDZ4couN/GXoOLYpU8RsgDkUBwYhBci0tUPCs0wIa71LO+Q9LbCjje2E/oMuLGSYbSYD/9VvlayTMv0+7sPruufsH/LwQ2omZWoo2A5YbLIfrXJlrJmrQZQt6TNmB4Mg8ieNBG3zPvqEN09agN50g5Jxs5lrURM25CnelqwTQrpikmX0Q+32ob8oKLKIRydi163+Td5cRxfP+9KAnKc+3q5hJ+EIqszZ8Uk6btvwjZ7sWUnQ1hqxbobHQaM31xJ2eUMroRWemsa3YAQ2Ax+ljJYsMf2MqlrFHwgyy0KzJY2uKaw/Ny0kReCZQzNVFpqz0QdcrxL/7bpH2nCOjC5yteEvOOS/wpoy+9rIUgoEAAm4YZOTB2EsES5kut294S6OgV25OYsOnk0ZCcGjxieyvkOmzxYa1oiq0Gi4Eljb5DTkm50wjd0l1zgFDjk+mSxIARxbFRgZk5loS/wEHHaDIKLhVHbh2T+aNRgxc896X/oR7//py5fMXkUuNR6ZaunHvICy7Fsaif3NmPBHV5vdhsK19tjShcQYssSzfkDl05sYttxZEQbdtDNijRx1ETtifkDcI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0aed148-2a2b-471b-b5cf-08de2c0991b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:01:14.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRUuaz48fzBPoRaSJYP9kZb/PBd9H1f8nnaHf45Ijxp9rg7VwUwDrfkB1NVnqWUNg9N1NXjI5g7Jxfpit/SJhyzwCPyobuokecnJM3H6uOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4MSBTYWx0ZWRfXx+2gXd9nzXnR
 U90byYmBzzBq/7puScWMaHI67opajEVwuGNUDn0uuysD9pG7/59GnaKDr7FUZKuaZoJDsyupTmz
 hG3j2a6yoxHC/ujOPqyNssiSX7hzvX/ADaGgARd9GnwDMbMlu6qJoUm9PigYg4azuT49WR2z9sF
 ZOg8EcXj5ctkVg1lhK3vCUZpQzBBhi8BydDRzz3us3+wSBAPTvJs1BCvng0PIIgRLzXCPa+xgId
 V485/ZBzeQ4ludoURTIaJBYdBRHzo7s1yCv3Hqk2EsI3O5m9mpx/os1CL22Iic+e9SCokNBtKuC
 4XM7eWohDyWpdWARcPMqOEqerh7di9gAg2DxCZCXk74iWgASozRq5j7gEy8a61kE6JkxGZHYRKn
 mfsNpDE2sDIZAsPKlA+lXGrXmyh8i3/cvpxapi787nuZmrJX/Ns=
X-Proofpoint-ORIG-GUID: 6L8yeRvyxtV-ECdsRgbxoxbcfQBiWnX1
X-Proofpoint-GUID: 6L8yeRvyxtV-ECdsRgbxoxbcfQBiWnX1
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=69257e70 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=P_b51HnBFZLct5vy70cA:9 cc=ntf awl=host:13642

The userland VMA test code relied on an internal implementation detail -
the existence of vma->__vm_flags to directly access VMA flags. There is no
need to do so when we have the vm_flags_*() helper functions available.

This is ugly, but also a subsequent commit will eliminate this field
altogether so this will shortly become broken.

This patch has us utilise the helper functions instead.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/vma/vma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index be79ab2ea44b..93d21bc7e112 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -69,18 +69,18 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					pgoff_t pgoff,
 					vm_flags_t vm_flags)
 {
-	struct vm_area_struct *ret = vm_area_alloc(mm);
+	struct vm_area_struct *vma = vm_area_alloc(mm);
 
-	if (ret == NULL)
+	if (vma == NULL)
 		return NULL;
 
-	ret->vm_start = start;
-	ret->vm_end = end;
-	ret->vm_pgoff = pgoff;
-	ret->__vm_flags = vm_flags;
-	vma_assert_detached(ret);
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+	vm_flags_reset(vma, vm_flags);
+	vma_assert_detached(vma);
 
-	return ret;
+	return vma;
 }
 
 /* Helper function to allocate a VMA and link it to the tree. */
@@ -714,7 +714,7 @@ static bool test_vma_merge_special_flags(void)
 	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
 		vm_flags_t special_flag = special_flags[i];
 
-		vma_left->__vm_flags = vm_flags | special_flag;
+		vm_flags_reset(vma_left, vm_flags | special_flag);
 		vmg.vm_flags = vm_flags | special_flag;
 		vma = merge_new(&vmg);
 		ASSERT_EQ(vma, NULL);
@@ -736,7 +736,7 @@ static bool test_vma_merge_special_flags(void)
 	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
 		vm_flags_t special_flag = special_flags[i];
 
-		vma_left->__vm_flags = vm_flags | special_flag;
+		vm_flags_reset(vma_left, vm_flags | special_flag);
 		vmg.vm_flags = vm_flags | special_flag;
 		vma = merge_existing(&vmg);
 		ASSERT_EQ(vma, NULL);
-- 
2.51.2


