Return-Path: <linux-fsdevel+bounces-68491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2333C5D5C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD5343D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE11315D47;
	Fri, 14 Nov 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h8uHVv67";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cXwAkhP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6902E54A3;
	Fri, 14 Nov 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126889; cv=fail; b=tLcqhPdWdjaLMFEaxuZJuSOND2Y6QD+ylTbzVmLWl3L4hE9dZ1XhDRt2IPnNlDRd50S/pk4YwhnTuiXghMX4ZfirU7gnGDPshx5p4itRtI0UxqmtB555inD74SdF5r9OvMcLpvCQ+XwCr9xvYC3yZZh9HCf210QMa6vfEJWPj2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126889; c=relaxed/simple;
	bh=EwYTfx1+/mVJYo+mFV0pI2ZfmpuKsnV8RrpyoPnjWKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QvDEomvjVDAZK1gVlqY3oUqOIXHzBIoaTbMLVrjjzjtUPz6GHZ+U+khin/dRPSkxvE8W4kqvN1EDzGv4CamJ+O1xS90hWdTcbkNfStGv0/K78iufdMBOBmbCgUo5RKSnrXi+pGZMjCAEc9Auw66pyZw2YyvWsRr6rRESeeIJJFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h8uHVv67; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cXwAkhP+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuCR2004811;
	Fri, 14 Nov 2025 13:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mjoYBwRTzr7gbRBWkpaXxVun8ef+oZu8dzhfbP1N6wg=; b=
	h8uHVv67907ve/4AsQ48EWPWAtuYA3q6aijzK+kQphO9kgq9sayn4JmchpPzKw6Y
	jOBkce6LFnmdu1SQP+LnIu/HUMpEJRZ+V0oDvmJ2mUdKukhP0z0ltshc7aJJVfBg
	K/3HR4SIBe01lxKy30z2HAJLkZt42uWRmW00lynEq8uD4LT9P2T/CQRaDj6hB8/9
	DAZj9v7Na+WSeCnxJxGQbLTbjXGMfJi+zbhCzXO7o8chnFeoG2FPVtrlh27HY0vS
	rVoZrQ35Qwp2FpkNqRQpridp54A/FHmgGDn5j7znhB2OdYVg97x4OJo4KXWQHJ/Y
	+/JUGanX6+ZOp9jtCoyUJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8vh4nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECPACm038491;
	Fri, 14 Nov 2025 13:26:49 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadgv4s-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGgJ0OsbBhrmhYOiNyQhjSioP3ZsZs3Fd8bm5lGec9Ef/e5cizPgXl2XJaPAYeQBPhX+ZDNUCBxQkiaF1l1EKMXePokMd4TrAzmgcHbRqaQJQ9Kw8giJJhGcVfF/Qu/fkSHmkDZeFYfbnEl20EKevUcfe9kf0kc2aw/lP0srVBG78GrVnBlE5yr9WY7FTrlw4LsohYsfYlaKnG1YXVMlaoQfG9Uxc0WJcP00CH+bMp9EmKHBeoEcLNgh6dVPbNVlnwNElLsdtW+tPP+eO24MUbUWM9sfjVbawhMDDJSvgDJh72ncxVgb0pl7SWqjnFgKvrdTxOW3UEPgY/T/XRKhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjoYBwRTzr7gbRBWkpaXxVun8ef+oZu8dzhfbP1N6wg=;
 b=Gfdx/gCxd3uKDif6DOhhYAqBx8Lv1ee8cnSxW746VuBT9JLFmWKqOmSdB7fFLNnqcTAu7CZmh6QjhG3elRfuoEvZIegWaThzKYjc0yjnDcKDJGucy8tGuVchi2U8cTfi6Kouc+KupwKC5TDlcfmsHeMn5ISRp5mTZxnuCSq1HyDjpu8M6SeO15g0MyKUtmSgpuLetGU9EtwN5kb3u/YKHacA1bCU95Mfde9mR8EZBEQDqyq5ATfqNxyyOsh/Qxve3JyuUubWnwF5N7jqErjIK3hP4UVQXXLrYSPlxs+e18KY53zxPjA++9i+ZBI2TqAy+jygjn5RMhp/u32CCw0FLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjoYBwRTzr7gbRBWkpaXxVun8ef+oZu8dzhfbP1N6wg=;
 b=cXwAkhP+QImethXpd/5+H+kIYZKwXM6ioXrWxzlnPYjZlqBnJi3eixkZgFzqOHzPMX5Eq7MfFkMrkC23A+W6IcWfNSB6OUjyf7Vre3c9pIvhugL+sYUdCiJE5oupP61FFXDVHnwUjGzhxDSDt60yKOfJIzxVoWjyOW4UICeYlak=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8061.namprd10.prod.outlook.com (2603:10b6:806:43a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 13:26:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 13:26:38 +0000
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
Subject: [PATCH v2 4/4] mm: introduce VMA flags bitmap type
Date: Fri, 14 Nov 2025 13:26:11 +0000
Message-ID: <195625e7d1a8ff9156cb9bb294eb128b6a4e9294.1763126447.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 971f8615-2403-489f-3c3f-08de238170bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqlUiN+PT/I6kmXdIa/QWrS9yC1f+ClE3kaq2gNC0IThvOIxYEznZX9Mg2uQ?=
 =?us-ascii?Q?NGXa1Pr8ScaLPwvfGqTdBtM8CE4eTsiMAqhTuJDgADRiVnPI/ZFVru7mJFCn?=
 =?us-ascii?Q?SFyLiFwUm479+fykoTzZg7OY17QuserK7Xz1rWuL1r0wI/ZzhJ1JEFuZ9nWl?=
 =?us-ascii?Q?A80aJjCze4jezAoGNUO3HFYdwqCg9IcLIc9+eIra8rxj6duTLI6p8JcW7UvN?=
 =?us-ascii?Q?6vBCi/DBdK5vGDrKxbzhA8pspY1rl0HH4cVGbwBiEN3LWWGjRedWzGMnTUyR?=
 =?us-ascii?Q?9R1+e/LznIaqxGKXiRY03ZkBjH/clidElqEHUethEAuTI9ZuQ7lHKdWbQXSg?=
 =?us-ascii?Q?P+0vbpzClhh+O/LK1njvhcxc6qjL/3B0ihP+LyPOCKBl4RMeP6AvXm1LWAxB?=
 =?us-ascii?Q?mGMmCMwWbSH4anMdn036L3T9hzQJRg0mcSC1QNf31iVHWcunzJKNJGKoHvSI?=
 =?us-ascii?Q?cfJ+AgMBn5UM24RljxFEw5F5jWRoCZcU/Fe1Bnk99lGbZ7TWmhWROjGkuqcC?=
 =?us-ascii?Q?YYN0G05ezwzsOmcaGGJt+OfnSPPafzWoW+HIzER3Q2Dy7+wmOz5VJwATzdS3?=
 =?us-ascii?Q?Bdfum4jSekL7nJpwtTMTZUax9FOOEDvaA3rmoWTnGHl+6/Pg6k6pQfVJ+ILn?=
 =?us-ascii?Q?HOj3Nn6vcm1NKPvpQW+QlWwd1ZFSnWZKgaXTcCshlHswx6J5ZKye3axngL55?=
 =?us-ascii?Q?v4oJ7valEdLsN9D7y3w8iLPz/Fjk4DDwD4jLoL/6rRCHf+/wRDj8HlBf+XWp?=
 =?us-ascii?Q?RhOOp89fdC0NVhHOb0zk8SwLwLiLMOHKqwmtgDTkz05Pox/nUvbTmhiQc29Z?=
 =?us-ascii?Q?aHvv3OeLwteIVznXfZQK7pERSfrM9+veKUMXp4R9DH3bpUfxQPHW1PDPbvvW?=
 =?us-ascii?Q?gJXBt3o3uP+EQNGbtWKum2GAtOl9uBpxhTocXJjabVt2FOXf6eHG39G4QIkf?=
 =?us-ascii?Q?pOB/lJiBDkNXaAzi2/AIjMtsZKc84XdQz3mQgIUr5/LUG9WsqWFgy1VEBO0z?=
 =?us-ascii?Q?zJ4lYKsXGc6TYHrjJxa8XJth6On3nnuU2gLyiH3eTenvzivORlqGz087Hjyy?=
 =?us-ascii?Q?KFESoTUwNiI2tLQipN89UgmpZ3m9wOet1Y6ip4UidenH49DGN1ghOooyn7Cx?=
 =?us-ascii?Q?KVWutKcSy1fxkIiLyWm4hI/P3FqvR2MXrA4R1KLVM2yNZQm3an5GsNGaXRbU?=
 =?us-ascii?Q?QfjbQmb/A81eC8gmruY9PzeiEZz26Go/HjZGISbFYx8rFbmmTOBBNoQMeVik?=
 =?us-ascii?Q?rKIgKpGsKuh5dptBUtJ/d3RQG+9xIRFjOK1hPmFe7ie9mp6j1Ycms9TEo2pK?=
 =?us-ascii?Q?b8AzCxIY7kRHPvQ1fpQl0dT8jE6KMcM29XNU0jD8ss2ufKjpAeu6rjnlNi8f?=
 =?us-ascii?Q?RGds+iF65LBbF0Oa1H7n61BW7ae5zga2E8AFPBnP/1AUyfzy6t/LZLbyOX/b?=
 =?us-ascii?Q?bPxcn79skuz8vYwHk5Dye+C/h4SwizL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TMU/uke5kwYK3OH1i74E9SQ+WVerXKlMjjzlE6/e6sN9KFGFY12pAshp8dC?=
 =?us-ascii?Q?ORNE/YN8JTeRlTXyNuKA4dkQMFCcP4hdHmFQ26QXLrMszPkprgRIyRJGr8VE?=
 =?us-ascii?Q?ekUHDa0VBVmBQPl9nN25UT4vUiWCT7vBOTmOQy5W61gXUkaOa6Kb/eGDkuPI?=
 =?us-ascii?Q?88Bci4/xotvDyTNW0d66zJuyYjx2qHu43VikkfU4ifaRRT4/1wZxe8o3Uv2X?=
 =?us-ascii?Q?IE8CsaaXT+No7gLLeZW4zKk0DZUsCGVH5kIfLIyk/Cu5+QzbLg+zXj3Y//MW?=
 =?us-ascii?Q?VjiTVk1ZyclRnRqdJknOL8Tsm4gkXsW7Y8GsCw6k7b8tIuL9pOO6yDPbpE0b?=
 =?us-ascii?Q?mdqIe7CvTxRyFaWWKHL/N5XQkQ64SbKo782SZZUf6UovK36Flm73U7mxv9Oe?=
 =?us-ascii?Q?dOjjYYwgjs2gVCUeYt+/p0d6aHBxPhLgARmdWd2IZYhCNv3iTgnHVJlbMsHQ?=
 =?us-ascii?Q?DqlTS/65br0rHNDxZMhRjPnnP4HSS74uRYuzQZnIoimFd2g22i25gBbTX2sP?=
 =?us-ascii?Q?0UrmjFDBsoAVY3kFus4KeyNBRZe60WIQLWYYagTtbe2Hsn+E9BIVpXXuFYrK?=
 =?us-ascii?Q?w0aVAhn6l6hkdqP+MQtqXHOSQGIWD3LiKKNDkPiTMLX6r3W25FyHdhvy2Wbj?=
 =?us-ascii?Q?8Uj6Ea56BKRK3AfYw1QgNrqkwJbvDFmWH6caJZF9kzfF5HccT+4r7yV1dekd?=
 =?us-ascii?Q?sscRFtxiQWfIhZ9iVuKn91x80mbOrfB11cXMUt5fYsxZQm3yONehEi9Pwy1C?=
 =?us-ascii?Q?Y2qO33Ub4IqFYfBZma/eqTxIJnDtLTKAnzicrJuVrEZBCBqJ9F8KB6rq98OJ?=
 =?us-ascii?Q?nYNjojcyrsb2ug/Dn7WzYpPhi1bFoRDtL4PQiWYWH1NZCYX/OJKVHRjFQd8j?=
 =?us-ascii?Q?Ru+1WdYjNq/BMezPmGLsZPzvqUzhFnV/0grcFbNfSwJQtsBNhWRK7yTiqMrg?=
 =?us-ascii?Q?/NfovuhCmn9WCLfZRLLxfyOpeOHcn6I/h+ht3OCh5k/PBOYJfYF1bsJAZHrj?=
 =?us-ascii?Q?YV+kn/KYxhyglU58h+8CDgEPoQEfpx5H//pg7wXQwyM+xv1v3b7kRn053VZw?=
 =?us-ascii?Q?xfOOFqw3hLVvddjwWD6BLAJtQ/TQyLUshtcPwnx+Ob1bs5Co0zlJQ1KP17ee?=
 =?us-ascii?Q?+kAshbV9xiYezWMkpmHcmXA2QDJbO+2KawUYSoWyle41BvF8C7a51diqC32C?=
 =?us-ascii?Q?L1uTsj/0s6Pos1sLs6s8K3d3k9OeeFgzuefhhg97YR03hCM+o0tnYLW5liSH?=
 =?us-ascii?Q?XKwLxmI0PlW3scd/p99BR0YWpUQxtEQOksHRIuhNO6G2cEm3fqScpHs7Gwfb?=
 =?us-ascii?Q?zi1j5HKQhmew64SUfDa+4zMkM2hq950Y5ZDFxlguBLoM2QzGvUWGmqLOcc3u?=
 =?us-ascii?Q?0yzvpn98duki7WH6bXdyB8xB22WKJNv9AkvNfLPrvB9cR0MmqK5vfTY15aKQ?=
 =?us-ascii?Q?PoeomyiEZ6fMarZVTG1+OIQTcc2mPevJ+GFbXjaCZBLPQQdu/vk9REheON87?=
 =?us-ascii?Q?QQXhrS2PD0W15E0u73UU5el86b2356IZLCzTi0ixf+LhnEKwSYlOnqxLCG68?=
 =?us-ascii?Q?VXuPpio5cOpe0ZftZLO66FRKjfzPJ6GzvPKZ2rB15Hv3ZJjlVGv0eBlvPH7y?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BFjoptieGhD4Dbf9z+NoGc+WYTg01oeXqPU5UOEhFQ3Iy4HYvgi0eeWY6+Be6qjzmfKTf9Q+TD+RH84V0qlH2InU55njVP9SPP4+xXOhm21bNQHpitIx7V1MrDChnB/FWGb2tK95nU76WLhj+Xj4AgcPIELVNqtGlEPxOoh33rQThBlds5AyMwD6XgaJCV6LHo7evVPQAXCWnS0zvotUpRmt9a5VCHWDDH0vpPJZhzUjw/XLE+0fCVyZ7nvZUpRf0bQwlVNm8Ff5qGZaa+I3ZMtWKn0mEaYMN5B6T2uRFXLSdEu77nZeExEFWKhpg2tiqPAjuXdPAuZ/MkavIvDz82+wuStvqPp2qR6TEyNcp1MV8fgyVVjgRjpJ30YoVnD9zzNpIJIfVnnBm9YmXoeGmoSdrDR7jLLcQU5XynJup2VYJsiJxR9xUc98d8TqchGZSvsoHc3+Beyg5sXzSShXX6nW4CsWluAGW+8BmEjaa9VuRfN2urLumMkpvByvrM4KHvozmdTswcBpGKQsSC2wO0+Sh/M7AqmzWnhPGUYRlsznIjGN61nXj/yQI+LxChurJ7Kq2g2MuH6cKv2IqaS+Jrflo/piEf3BJ6sbdIXsnEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971f8615-2403-489f-3c3f-08de238170bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:26:38.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RfgFcQ5tzL1y1XEPSfKN2fhCj0WvP0CSj+ZoET2pX2aqRxJvDvDukI9RuuKi+ig2xEbAoSUS07A1HCoQNCqObzI6ufx2uSgLkeG0ELS7sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140107
X-Proofpoint-GUID: j0Gq7Qs_rx-FP2UhR9nnEP7GQDmIgk3Q
X-Authority-Analysis: v=2.4 cv=EPoLElZC c=1 sm=1 tr=0 ts=69172e1a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=We_X2NwUB42jDMGAftQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: j0Gq7Qs_rx-FP2UhR9nnEP7GQDmIgk3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX2ubCfsU2c4o2
 v7OwKBlitdZXl3jaJ8eqvj1tWH9MgXR0kRGKRxisG42QTm5SFtgWoceedIPHdHSmSd75IpzhCIl
 OfrgbT1EIduelSREhLE3txu/VieLA0CK+51R2b0aFdDQeOH4R+u5pIjLelV3uPIPBsIBubyRJxh
 e++aOfNudQ0Qvg0yr/09xcigfWpMsDfIhcze6ubtYRSezojZmliUkD4OBrRcTlhMKuj8t3zNsGy
 +He47+wHQ7oePG2m0eBOFaTHaKGqkYDjt50pnhzSVxQsxidv0Ru3/MSNvkQgijZeHtNWBiwY1rj
 W+/eGMMlNkDi6tpl9u6X56O2753C0UfV+91IqS9NaF47kVh0paJQTYqTyTKWzNS9m1O/SU4VCwY
 hWg5YLsJY1/4glxuLUBaxORKbRhPJQ==

It is useful to transition to using a bitmap for VMA flags so we can avoid
running out of flags, especially for 32-bit kernels which are constrained
to 32 flags, necessitating some features to be limited to 64-bit kernels
only.

By doing so, we remove any constraint on the number of VMA flags moving
forwards no matter the platform and can decide in future to extend beyond
64 if required.

We start by declaring an opaque types, vma_flags_t (which resembles
mm_struct flags of type mm_flags_t), setting it to precisely the same size
as vm_flags_t, and place it in union with vm_flags in the VMA declaration.

We additionally update struct vm_area_desc equivalently placing the new
opaque type in union with vm_flags.

This change therefore does not impact the size of struct vm_area_struct or
struct vm_area_desc.

In order for the change to be iterative and to avoid impacting performance,
we designate VM_xxx declared bitmap flag values as those which must exist
in the first system word of the VMA flags bitmap.

We therefore declare vma_flags_clear_all(), vma_flags_overwrite_word(),
vma_flags_overwrite_word(), vma_flags_overwrite_word_once(),
vma_flags_set_word() and vma_flags_clear_word() in order to allow us to
update the existing vm_flags_*() functions to utilise these helpers.

This is a stepping stone towards converting users to the VMA flags bitmap
and behaves precisely as before.

By doing this, we can eliminate the existing private vma->__vm_flags field
in the vma->vm_flags union and replace it with the newly introduced opaque
type vma_flags, which we call flags so we refer to the new bitmap field as
vma->flags.

We update vma_flag_[test, set]_atomic() to account for the change also.

We additionally update the VMA userland test declarations to implement the
same changes there.

Finally, we update the rust code to reference vma->vm_flags on update
rather than vma->__vm_flags which has been removed. This is safe for now,
albeit it is implicitly performing a const cast.

Once we introduce flag helpers we can improve this more.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               |  18 ++--
 include/linux/mm_types.h         |  64 +++++++++++++-
 rust/kernel/mm/virt.rs           |   2 +-
 tools/testing/vma/vma_internal.h | 143 ++++++++++++++++++++++++++-----
 4 files changed, 196 insertions(+), 31 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad000c472bd5..79345c44a350 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -919,7 +919,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 static inline void vm_flags_init(struct vm_area_struct *vma,
 				 vm_flags_t flags)
 {
-	ACCESS_PRIVATE(vma, __vm_flags) = flags;
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
 }
 
 /*
@@ -938,21 +939,26 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
 	vma_assert_write_locked(vma);
-	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
+	/*
+	 * The user should only be interested in avoiding reordering of
+	 * assignment to the first word.
+	 */
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word_once(&vma->flags, flags);
 }
 
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
 	vma_start_write(vma);
-	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
+	vma_flags_set_word(&vma->flags, flags);
 }
 
 static inline void vm_flags_clear(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
 	vma_start_write(vma);
-	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
+	vma_flags_clear_word(&vma->flags, flags);
 }
 
 /*
@@ -995,12 +1001,14 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
 static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
 				       vma_flag_t bit)
 {
+	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
+
 	/* mmap read lock/VMA read lock must be held. */
 	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
 		vma_assert_locked(vma);
 
 	if (__vma_flag_atomic_valid(vma, bit))
-		set_bit((__force int)bit, &ACCESS_PRIVATE(vma, __vm_flags));
+		set_bit((__force int)bit, bitmap);
 }
 
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3550672e0f9e..b71625378ce3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -848,6 +848,15 @@ struct mmap_action {
 	bool hide_from_rmap_until_complete :1;
 };
 
+/*
+ * Opaque type representing current VMA (vm_area_struct) flag state. Must be
+ * accessed via vma_flags_xxx() helper functions.
+ */
+#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+typedef struct {
+	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
+} __private vma_flags_t;
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -865,7 +874,10 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
@@ -910,10 +922,12 @@ struct vm_area_struct {
 	/*
 	 * Flags, see mm.h.
 	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 * Preferably, use vma_flags_xxx() functions.
 	 */
 	union {
+		/* Temporary while VMA flags are being converted. */
 		const vm_flags_t vm_flags;
-		vm_flags_t __private __vm_flags;
+		vma_flags_t flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
@@ -994,6 +1008,52 @@ struct vm_area_struct {
 #endif
 } __randomize_layout;
 
+/* Clears all bits in the VMA flags bitmap, non-atomically. */
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
 #ifdef CONFIG_NUMA
 #define vma_policy(vma) ((vma)->vm_policy)
 #else
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index a1bfa4e19293..da21d65ccd20 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -250,7 +250,7 @@ unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
         // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
         // shared. Additionally, `VmaNew` is `!Sync`, so it cannot be used to write in parallel.
         // The caller promises that this does not set the flags to an invalid value.
-        unsafe { (*self.as_ptr()).__bindgen_anon_2.__vm_flags = flags };
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags };
     }
 
     /// Set the `VM_MIXEDMAP` flag on this vma.
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 18659214e262..13ee825bdfcf 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -528,6 +528,15 @@ typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
 
+/*
+ * Opaque type representing current VMA (vm_area_struct) flag state. Must be
+ * accessed via vma_flags_xxx() helper functions.
+ */
+#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+typedef struct {
+	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
+} __private vma_flags_t;
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -612,7 +621,10 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
@@ -658,7 +670,7 @@ struct vm_area_struct {
 	 */
 	union {
 		const vm_flags_t vm_flags;
-		vm_flags_t __private __vm_flags;
+		vma_flags_t flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
@@ -1372,26 +1384,6 @@ static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
 	return true;
 }
 
-static inline void vm_flags_init(struct vm_area_struct *vma,
-				 vm_flags_t flags)
-{
-	vma->__vm_flags = flags;
-}
-
-static inline void vm_flags_set(struct vm_area_struct *vma,
-				vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma->__vm_flags |= flags;
-}
-
-static inline void vm_flags_clear(struct vm_area_struct *vma,
-				  vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma->__vm_flags &= ~flags;
-}
-
 static inline int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	return 0;
@@ -1548,13 +1540,118 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
-# define ACCESS_PRIVATE(p, member) ((p)->member)
+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
+static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
+{
+	unsigned int len = bitmap_size(nbits);
+
+	if (small_const_nbits(nbits))
+		*dst = 0;
+	else
+		memset(dst, 0, len);
+}
 
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
+/* Clears all bits in the VMA flags bitmap, non-atomically. */
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
+
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
+}
+
+/*
+ * Use when VMA is part of the VMA tree and modifications need coordination
+ * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
+ * it should be locked explicitly beforehand.
+ */
+static inline void vm_flags_reset(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	vm_flags_init(vma, flags);
+}
+
+static inline void vm_flags_reset_once(struct vm_area_struct *vma,
+				       vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	/*
+	 * The user should only be interested in avoiding reordering of
+	 * assignment to the first word.
+	 */
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word_once(&vma->flags, flags);
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_set_word(&vma->flags, flags);
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_clear_word(&vma->flags, flags);
+}
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
-- 
2.51.0


