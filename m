Return-Path: <linux-fsdevel+bounces-68492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77892C5D58A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9C3B84B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE2315D51;
	Fri, 14 Nov 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pw+BsQVx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vtu8fIKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F23161A6;
	Fri, 14 Nov 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126921; cv=fail; b=VeN0zwj4i1LA8TziKMCb4l6z1vmmdMTLxJUOJN/6g/mWSBtgSDVuavj2Q8D9lv1gw+y0KjZrtekPFckW2vPhGzrhug8xTaf+my+yfVZzTm5W/LKNcrBTZk03r1gbwWkQkqBbxD5eXIBse5LujQ/heP1nxf4fRSPoFC8BJAWuwjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126921; c=relaxed/simple;
	bh=yEKFlypvoQcqqG1ZakRePe1XuLoKrAEOSeaY88nZaRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XovCDzaGHNN4Xl7zrvTqHNJYnVYYD/Vq9nJr6xRcN5TWAR2RlrlqLl2qvMzQa5r8ReoZodQP4pR4rZh5cFsDEq0KCx7dZQQUmH7jc5OAeHuIIFHK3512whlOAWD5d2I/gbYq5Vldld9wt7vcPg4UazbszjKEDAd96vcWDh+7NmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pw+BsQVx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vtu8fIKn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECuToq018316;
	Fri, 14 Nov 2025 13:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wB29KaJy2FKfkzh+2uMoWhOKQSXUv/mB68Jk/zrucak=; b=
	Pw+BsQVxQP0CVqq4z0lPlah98S2A1x5z3J7qal1zaKtpR8qOUpV3ovNWsYq6DxN4
	ZlAdC0rDV43aZouSdNX/4aovsNPFYMd8cMomK+uftszWVp6k+pdt7+IfhpvPX2yP
	PgmaA9HtLnPQULnd14uZqCZhAcrw4zpqhS7DNVy5ZqU/xBTQXeTkRU+KXx408orU
	I21Jk4810JJ0Om32PnIHWmbqg4JmfwT/P0w448MiYDQ7jJunF/MDDby29tBqblvx
	JNzmcd174RsAlFw67EVtFEiVYh0LaRWkkeZ7Ks8zOJD/wAyw0MlMI2F+Lt+Art/I
	4Tp2HsV+BZl/Neo1JqO+Ww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8ss56m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AECPACf038491;
	Fri, 14 Nov 2025 13:26:38 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vadgv4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 13:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yrn89PE6KU3f9LNsXmCtN+kt4FFuJ+ez1EhWkOb7zVLKy6MspHDX7TH1eeqoVP39CAfPLezE84buzarH/VEkDV3xRWtUgnpeW9YmK3JVoRnfx0Ox4tKrLwCVSilg1IZPcF+ocUh+xoq25tEL9yHNpJ6TAna/UbYSJF/owb9FayoGGw0daRIMiSsNcZrHkisbzXZA0agREQ6SnfRZMD+GDESLVs/06ImmKJ85umh3DSlmh2+OGcSolNhgvRqt05x63w9jBN8fhxHql09KrZ276PsB89ibReWxDl63iIA1CmvUc4q5Aqk9xcZ0+fkq8sDb1nKqkFT4n2E7Km61GiCMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB29KaJy2FKfkzh+2uMoWhOKQSXUv/mB68Jk/zrucak=;
 b=UB7XcdmruodgEDh9cNC9Gx4FAtW57vN4XzsI4jTE/vnYgxDlM5WNx3VjhkFkB8SUup1Lfh1g8XlFbcEqoFaHj2Wlyc8Q6YJyZCWS/H1OUGOTqMsaW7F1B4zYQstcUrNXgJWtjNctpD3wKMKBT1OqRmakkV4Hf990ky/IcPIGn8BMx3WcUCQRf8GVTDfpuyFJs8t9gjt1srBABcgWzwJ0DEsKQ2mkxHnUM3nxxZdvw+1ejJqAr6grPzQSdg9wsqgRMmG2g0aPJgcepaYlKcGwAfnYOtg3/7VKbAJmwdZfdiEonAzu4XSwO86BlHyO7cb8xgEsJZ1kOzBPziEbip92FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wB29KaJy2FKfkzh+2uMoWhOKQSXUv/mB68Jk/zrucak=;
 b=Vtu8fIKnMy+TyP7A0jVvid/8wbs3ZVeuSnO89NWBDiu0YisWbsQa3xyIypPrg/Okx5I1ueluJGmpT10HPOl3656GxVAI1kWe7ONJZsT+yGX++c0FuTC+/HI90hsQvj23rV3vD2BUgafh/WfVDFQv0OYYtZ/GPoZyW8ULPWSRR5s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA6PR10MB8061.namprd10.prod.outlook.com (2603:10b6:806:43a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 13:26:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 13:26:32 +0000
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
Subject: [PATCH v2 1/4] mm: declare VMA flags by bit
Date: Fri, 14 Nov 2025 13:26:08 +0000
Message-ID: <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA6PR10MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 939a8012-d536-45ae-c057-08de23816cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mP9xZYjOTp9HeDQhccFGuMfuIjFo+y4zvzPVdsHi6kcdVUVmX6Z4YvYmpUj2?=
 =?us-ascii?Q?WtHjWhwUfh0ZoaUamwSEPpQ/9byQRwSIEeuoz1J2e5Bk2ryVGNpQTZab0GAS?=
 =?us-ascii?Q?BUHyn2bOJ4n2M8gbx3H0vhwVmEtBy6cyh7ZvP0UhH6N2KQIfZx5j/YwbFgm5?=
 =?us-ascii?Q?PaGGi4qhMtq4aK7yKYy1IYvqox/jlbTJDB4ydh+yC8akH0Luzd+ic4a7XppY?=
 =?us-ascii?Q?2A75LXAfZsk+++Dd4WBzn4Rdkx4Ggrn2ny24AZvGZPhcZgWxVAmXfEB5AfIB?=
 =?us-ascii?Q?DFMfvEJRGTnS4mLmJeTnCVBc8Z1+k9abtdOXWtOg370ZTOdkROw3cc+i17wJ?=
 =?us-ascii?Q?Vv8mG9dDgaTAAesMuVQ6JnbnNjnpV+EkZiZ/VcKp+58bR2MBaVdYy0wVSHYP?=
 =?us-ascii?Q?WVe0HIuz+LuJ0ZnSfqHZONmCFVu3CeXnUbbSvIW/J3q2guMnd+orvRTjheUc?=
 =?us-ascii?Q?DGfse+aqtJjjRWRbbM+40q9Gjo56csJ4DG+ppI/vVenmDKp70arYdz1GQNqv?=
 =?us-ascii?Q?1ZDQTl6NWRbZluKtXxfqPAF3vXby5YBy9AthBEsJoT+dxbiYr63IpNCUGfN8?=
 =?us-ascii?Q?DQWiZfIJqWnaKkRfAUFBqDzyQcJj63k/NXPKIKcO5/r6YVmYT2ws+43AmW3Z?=
 =?us-ascii?Q?HIgpuqkTUAFhf8PRwNmiODqcT9jJjXSFddoWmkdQjDeAqpN1QcjH38ozHmgd?=
 =?us-ascii?Q?BZvRSnwDY27l2uOon2smwpzyo9HaHBMig6cLWMR5G3EHWbyYyZZ54fvtZ8sw?=
 =?us-ascii?Q?tJ3o1eya82wrtvIIjxLG5OG2H/RxmOfLc5EKFLzt3T/RByf7UoSat/ITUj3P?=
 =?us-ascii?Q?f2OU8dzzhCkWIZFXLlLitp/aSmTKhrH69B50EtloTter+uVySPVn15v9rKTw?=
 =?us-ascii?Q?9RbF4vCKlJRTPk0UEU8h10B1xIwnAFbn9WJe89RD8cUHN+2PGOqo8qS75Ox6?=
 =?us-ascii?Q?F3xQZ3l3OkaW1UQi/taKHnGLb4yv7D3ootwEchlNYBdcm1zvytp8qEP8zgNJ?=
 =?us-ascii?Q?a59p/z3eIZjZzmqaW3iWlq1H5q44kZ2RjTlX9f/cCtdfxr8vzIQpckxNSJFo?=
 =?us-ascii?Q?/L0qiEsBuJWLgZKMbSuwOXKmDTjxwFGNIp35OFUmE8kpEzV1enCPbGhlBbuf?=
 =?us-ascii?Q?DZrW5yszpo+ANZ1bxI78VMQNiCtC76IxfIrfg3SwdNImcDocBaO1KpYYIlfw?=
 =?us-ascii?Q?jhttgW4fJu3I2nQOM8aBwaEtHLrzPeYpnbUHpD1GaajRoT73PxIIjZHWgnnV?=
 =?us-ascii?Q?5o9ciXeuiHCC5Y2abwePSLqT8tURsxDgcVGfQGh9jTpL+KJXeHkZLYYmnVU/?=
 =?us-ascii?Q?XbSoAxYy9BLsbGuw0eanaK2RWsZYUt7MrPu/k6ux+P3Mbj4Mcdyu5J3a7DlB?=
 =?us-ascii?Q?XLaAYILGPVk21kH6cEgDTj4FY2nTbPOygg101qxAAHKLQlpuciXxJ1r9pqYf?=
 =?us-ascii?Q?jbeXGN2FkW4u3t5mlz3yDheDocFrSyFY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUtYFL4tDqST5be7qf0yQlu6kzowtuDTo1uqplZlKjvtxfFwQwuSkAFlYXav?=
 =?us-ascii?Q?ZCgF0Mhl4S8xpMCYNrvlmjwnrq4kqgxDwKaM897sh5zsm7xUp/f1sH3mHQ+k?=
 =?us-ascii?Q?Pv2bAX6QnsHvEf7ywOiVCwMeSar8DHW7HsI7rJvnIJy6jEdW+QH+96jAOfBA?=
 =?us-ascii?Q?+fgwr1duAXSDdaxMo7R2Gm1DWWbkJTDYM2Hx7NAbbt+vnnkT+GV4wCM6OMsR?=
 =?us-ascii?Q?UM5bwxseBQk6NZPVNqfGRuEPzdOQfobPK36QhYOZzm6V+7VZNhFpSnbEnFKF?=
 =?us-ascii?Q?bkFJvEL5BptfFVB1P1M3n65dUXB28jx9IElDzhfObcClMiSdhPH3kFG7UuwS?=
 =?us-ascii?Q?G+Hn+DdV+nIqy1bcQpSZxXupiRLlsJ6905LkKta3VjwXLSIfO9jun9ZO/JKd?=
 =?us-ascii?Q?IZWATVqP6bTtrfE4mzS1xCjTHNGX3g2cPyTc/uhOt7szIcTtu2e7FRSqOb/R?=
 =?us-ascii?Q?tEoZ2kI+NgKN/5ntjAtTYM7CXPaqmCg0mFmNtURZZg0ZtiY7sS92WHIXoFZx?=
 =?us-ascii?Q?Aus/enjB9IFeMSBfErIuWTr/HLW6938F26I+qUrR04IySRqQ55EhMM+JfEv9?=
 =?us-ascii?Q?aAD8y4/2pmA1oHhdkavhCidz6oRA4Xe1BQsTQbjg40ebeXHFhzmD42ZNsa4g?=
 =?us-ascii?Q?JllfgZZCopypJvIWS2JULoTg5LtNy01U+UTcbqKqO3GF2pkGPslOkAI1ifS0?=
 =?us-ascii?Q?oGfzzMhvHEYFG9/DTNYPDQCcl5dw/eYt2f723ta9BLSBLjoIDQW+R4704Os9?=
 =?us-ascii?Q?X+E50KFRR7GfL259GIsyvYn+QDXZvjyNRPZ6k9XUSyWv+U6pWESNBzmBAjIy?=
 =?us-ascii?Q?xg+84oeb1qxEsZumkabTWhH+imz1EWkwk27YanGRVA8lBgCQ/7Ob9fCAxSyr?=
 =?us-ascii?Q?oS3HRF9cydy4BD2HJE6h3E6tHC89S6+9Y8SDEtqdMsqyEVq3qXXQnKkV/h8e?=
 =?us-ascii?Q?vklnXl+Tj/0PdsfR+MBFLkaEAyRdrpTFi8LQliI7rLsDva5/7qxJURt4cd7Y?=
 =?us-ascii?Q?+0RS6L/SMT57Yz8Goe1/vsIC87Uf0+QGMTjpfDFbLuZN3pS6yKnI4Pp8tCGT?=
 =?us-ascii?Q?0lBn99uvwDYkPRveuNR1urYmQgKJGI4tej4NPBucDcPZastQl6HDP1XvMHhp?=
 =?us-ascii?Q?ptpNwzv2aT0gihK+IFW0FaoWMBnp4lOrUjpMV5ODj71+vTZJysWOEsu3SdD3?=
 =?us-ascii?Q?TawTxMzlNswF9JokiMhlRM1mYaHvtRZ+zsZZYiAQTLENbAdsPH7O7PJqJn00?=
 =?us-ascii?Q?OhIsci3h/nsCj+7jWH6ARGRDpodjJcLUX3tOBRxouuerUn5o14ejpXL1ZF4R?=
 =?us-ascii?Q?A1VJxIJpWd14UYO8G9PqJh+Jpmgm/ObFFeCKHTO1uXwcsNxa+gMMlPLR1Wpz?=
 =?us-ascii?Q?sd33JiiuYpI9N0/Ce9g09BuORpsC6TExUj8i7gxh57pee2DYPkC9S7S5wiIs?=
 =?us-ascii?Q?Pub/C7+yfPhMyVP61XqhVCv0gqP9i6IXVSY4rNxIGGW8UoQOupcVqFYOFyDA?=
 =?us-ascii?Q?mXdSTj9EfQcSEyqYwqCsDebJBpwHGs1rOPUA8uvulACl92Q73u8/Tg69zJmG?=
 =?us-ascii?Q?k6gbP9XWy65kl/Zbyp60Ep6i39Z37dSBVOfcgt68ry5zDNlp8ka8BWxLF3yI?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ppGpDTPLlLrIS4oFibP/7K0zzU5YGPEUtUb7wI1wkImXoa532ymNy2eLDpvHxM4vlWNT5sN3ER/zZwx6Cq5WN+RdnXBzFL5kFNH2gSFPQ1VEovHwDSiBxRcrE3tRwWUKx9B6VBtk/FpZX32JmDZBs4509lKp3faOsuflotYAZOB3ah++NP04SZk5ZYmYr1zS0LPsd6XEKpRc17s1TLyQW6OKZULsmfynjQmwlM20Mvv1GCFkwBDMrOx6nW6fExi87MPi3Rp/n2R+ICpjQCycgRPjLW9mt5/mWfy1n/rlJwonjNi33pMPU5+wx15WRRRdzF6b4Ar8M/yp6UMCSfZ8ErKkT+9Bf+49miTd4DpXk+29WMIytf5JmhYGJnG9Wv4pOfz7U86uIqllCnrXbYRE2ZmPLu+MQ+rB5SgMdE/hj5zN74j3LdXZAuMdKoyrqTCYMJIedCOO5Dd4fwcuV9Wjh/WXq/tX2Ot0Hmcb+i6QYNQ5ZUk5CDy7tHxb3nwRAr/XV96eF7+T1SXQYT3htSrOc5LrssbblVRXlL02ZbVAT6zjZiug27Z3BjhS1/hHAgk6M/KMcMyxjIR2imnvTNBrzS8Wr2ZyODroMrD/qYRrofw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939a8012-d536-45ae-c057-08de23816cef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:26:32.0425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCyR50x4dJOtby1io0H8aY5JknAsSMDXOqrxJgz4Dh5baegcFKCP1Aoi7tuqUpA/An6sF1utZ21Frg5LeS9ybL9wwT86XF1jRUowTHSbg64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511140107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX86lfUZsScoWP
 ZGjSHRdEoT98EkrgNu7/Tx8fKEng1TP9Wt0bLlvXwNwKlJscTdktwB13zTu7cAh0wK1rTg5xb4G
 ij937W5woKrP93o7Jn0aVVxENvBrFsBhK+hyL2/5V+lXLCnCW/U0gOZnL3iYtg0ebL/8S2Ztddb
 ogkfKxwlS5Jg9uTtzWBxqHcLtR4Kno5DVIyafTFMjRUb0biH4u9bh/StLITj1TKwkKzqplMv7T+
 L7kdxVwtGjh9NeBD8d6Hf3R5aYUuqfnpZSsfrUBSCwaMN/TgiJS7qcS4eJ0nNXVgKK7WHjlUV+i
 P8wbBTSMtq0FFgf57DXxFxRuvsbZZ7e+3NQ3o1gUc4JCUCV5DXCrNqSjKOZd5MQDqy/zXA1Cp0F
 OHRFQelrHi4uvPA5c1OLbCJsj7iN+Q==
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=69172e0f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=38wcqte6sxkpbDQlIZQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: uTWeAfTVsM0ItZXtQcnM2_dznmCDV6PY
X-Proofpoint-ORIG-GUID: uTWeAfTVsM0ItZXtQcnM2_dznmCDV6PY

In order to lay the groundwork for VMA flags being a bitmap rather than a
system word in size, we need to be able to consistently refer to VMA flags
by bit number rather than value.

Take this opportunity to do so in an enum which we which is additionally
useful for tooling to extract metadata from.

This additionally makes it very clear which bits are being used for what at
a glance.

We use the VMA_ prefix for the bit values as it is logical to do so since
these reference VMAs. We consistently suffix with _BIT to make it clear
what the values refer to.

We declare bit values even when the flags that use them would not be enabled by
config options as this is simply clearer and clearly defines what bit
numbers are used for what, at no additional cost.

We declare a sparse-bitwise type vma_flag_t which ensures that users can't
pass around invalid VMA flags by accident and prepares for future work
towards VMA flags being a bitmap where we want to ensure bit values are
type safe.

To make life easier, we declare some macro helpers - DECLARE_VMA_BIT()
allows us to avoid duplication in the enum bit number declarations (and
maintaining the sparse __bitwise attribute), and INIT_VM_FLAG() is used to
assist with declaration of flags.

Unfortunately we can't declare both in the enum, as we run into issue with
logic in the kernel requiring that flags are preprocessor definitions, and
additionally we cannot have a macro which declares another macro so we must
define each flag macro directly.

Additionally, update the VMA userland testing vma_internal.h header to
include these changes.

We also have to fix the parameters to the vma_flag_*_atomic() functions
since VMA_MAYBE_GUARD_BIT is now of type vma_flag_t and sparse will
complain otherwise.

We have to update some rather silly if-deffery found in mm/task_mmu.c which
would otherwise break.

Finally, we update the rust binding helper as now it cannot auto-detect the
flags at all.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c               |   4 +-
 include/linux/mm.h               | 384 +++++++++++++++++--------------
 mm/khugepaged.c                  |   2 +-
 mm/madvise.c                     |   2 +-
 rust/bindings/bindings_helper.h  |  25 ++
 tools/testing/vma/vma_internal.h | 303 ++++++++++++++++++++----
 6 files changed, 504 insertions(+), 216 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 41b062ce6ad8..720d70623209 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1183,10 +1183,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
-#if VM_PKEY_BIT3
+#if CONFIG_ARCH_PKEY_BITS > 3
 		[ilog2(VM_PKEY_BIT3)]	= "",
 #endif
-#if VM_PKEY_BIT4
+#if CONFIG_ARCH_PKEY_BITS > 4
 		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 43eec43da66a..ad000c472bd5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -271,185 +271,238 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
-#define VM_MAYBE_GUARD_BIT 11
-
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
-#define VM_NONE		0x00000000
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+#define VM_NONE		0x00000000
 
-/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
+/**
+ * typedef vma_flag_t - specifies an individual VMA flag by bit number.
+ *
+ * This value is made type safe by sparse to avoid passing invalid flag values
+ * around.
+ */
+typedef int __bitwise vma_flag_t;
 
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
+#define DECLARE_VMA_BIT(name, bitnum) \
+	VMA_ ## name ## _BIT = ((__force vma_flag_t)bitnum)
+#define DECLARE_VMA_BIT_ALIAS(name, aliased) \
+	VMA_ ## name ## _BIT = (VMA_ ## aliased ## _BIT)
+enum {
+	DECLARE_VMA_BIT(READ, 0),
+	DECLARE_VMA_BIT(WRITE, 1),
+	DECLARE_VMA_BIT(EXEC, 2),
+	DECLARE_VMA_BIT(SHARED, 3),
+	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
+	DECLARE_VMA_BIT(MAYREAD, 4),	/* limits for mprotect() etc. */
+	DECLARE_VMA_BIT(MAYWRITE, 5),
+	DECLARE_VMA_BIT(MAYEXEC, 6),
+	DECLARE_VMA_BIT(MAYSHARE, 7),
+	DECLARE_VMA_BIT(GROWSDOWN, 8),	/* general info on the segment */
 #ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
-#else /* CONFIG_MMU */
-#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
-#define VM_UFFD_MISSING	0
+	DECLARE_VMA_BIT(UFFD_MISSING, 9),/* missing pages tracking */
+#else
+	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	DECLARE_VMA_BIT(MAYOVERLAY, 9),
 #endif /* CONFIG_MMU */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
-
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_SYNC		0x00800000	/* Synchronous page faults */
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
-
+	/* Page-ranges managed without "struct page", just pure PFN */
+	DECLARE_VMA_BIT(PFNMAP, 10),
+	DECLARE_VMA_BIT(MAYBE_GUARD, 11),
+	DECLARE_VMA_BIT(UFFD_WP, 12),	/* wrprotect pages tracking */
+	DECLARE_VMA_BIT(LOCKED, 13),
+	DECLARE_VMA_BIT(IO, 14),	/* Memory mapped I/O or similar */
+	DECLARE_VMA_BIT(SEQ_READ, 15),	/* App will access data sequentially */
+	DECLARE_VMA_BIT(RAND_READ, 16),	/* App will not benefit from clustered reads */
+	DECLARE_VMA_BIT(DONTCOPY, 17),	/* Do not copy this vma on fork */
+	DECLARE_VMA_BIT(DONTEXPAND, 18),/* Cannot expand with mremap() */
+	DECLARE_VMA_BIT(LOCKONFAULT, 19),/* Lock pages covered when faulted in */
+	DECLARE_VMA_BIT(ACCOUNT, 20),	/* Is a VM accounted object */
+	DECLARE_VMA_BIT(NORESERVE, 21),	/* should the VM suppress accounting */
+	DECLARE_VMA_BIT(HUGETLB, 22),	/* Huge TLB Page VM */
+	DECLARE_VMA_BIT(SYNC, 23),	/* Synchronous page faults */
+	DECLARE_VMA_BIT(ARCH_1, 24),	/* Architecture-specific flag */
+	DECLARE_VMA_BIT(WIPEONFORK, 25),/* Wipe VMA contents in child. */
+	DECLARE_VMA_BIT(DONTDUMP, 26),	/* Do not include in the core dump */
+	DECLARE_VMA_BIT(SOFTDIRTY, 27),	/* NOT soft dirty clean area */
+	DECLARE_VMA_BIT(MIXEDMAP, 28),	/* Can contain struct page and pure PFN pages */
+	DECLARE_VMA_BIT(HUGEPAGE, 29),	/* MADV_HUGEPAGE marked this vma */
+	DECLARE_VMA_BIT(NOHUGEPAGE, 30),/* MADV_NOHUGEPAGE marked this vma */
+	DECLARE_VMA_BIT(MERGEABLE, 31),	/* KSM may merge identical pages */
+	/* These bits are reused, we define specific uses below. */
+	DECLARE_VMA_BIT(HIGH_ARCH_0, 32),
+	DECLARE_VMA_BIT(HIGH_ARCH_1, 33),
+	DECLARE_VMA_BIT(HIGH_ARCH_2, 34),
+	DECLARE_VMA_BIT(HIGH_ARCH_3, 35),
+	DECLARE_VMA_BIT(HIGH_ARCH_4, 36),
+	DECLARE_VMA_BIT(HIGH_ARCH_5, 37),
+	DECLARE_VMA_BIT(HIGH_ARCH_6, 38),
+	/*
+	 * This flag is used to connect VFIO to arch specific KVM code. It
+	 * indicates that the memory under this VMA is safe for use with any
+	 * non-cachable memory type inside KVM. Some VFIO devices, on some
+	 * platforms, are thought to be unsafe and can cause machine crashes
+	 * if KVM does not lock down the memory type.
+	 */
+	DECLARE_VMA_BIT(ALLOW_ANY_UNCACHED, 39),
+#ifdef CONFIG_PPC32
+	DECLARE_VMA_BIT_ALIAS(DROPPABLE, ARCH_1),
+#else
+	DECLARE_VMA_BIT(DROPPABLE, 40),
+#endif
+	DECLARE_VMA_BIT(UFFD_MINOR, 41),
+	DECLARE_VMA_BIT(SEALED, 42),
+	/* Flags that reuse flags above. */
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT0, HIGH_ARCH_0),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT1, HIGH_ARCH_1),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT2, HIGH_ARCH_2),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT3, HIGH_ARCH_3),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT4, HIGH_ARCH_4),
+#if defined(CONFIG_X86_USER_SHADOW_STACK)
+	/*
+	 * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
+	 * support core mm.
+	 *
+	 * These VMAs will get a single end guard page. This helps userspace
+	 * protect itself from attacks. A single page is enough for current
+	 * shadow stack archs (x86). See the comments near alloc_shstk() in
+	 * arch/x86/kernel/shstk.c for more details on the guard size.
+	 */
+	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_5),
+#elif defined(CONFIG_ARM64_GCS)
+	/*
+	 * arm64's Guarded Control Stack implements similar functionality and
+	 * has similar constraints to shadow stacks.
+	 */
+	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_6),
+#endif
+	DECLARE_VMA_BIT_ALIAS(SAO, ARCH_1),		/* Strong Access Ordering (powerpc) */
+	DECLARE_VMA_BIT_ALIAS(GROWSUP, ARCH_1),		/* parisc */
+	DECLARE_VMA_BIT_ALIAS(SPARC_ADI, ARCH_1),	/* sparc64 */
+	DECLARE_VMA_BIT_ALIAS(ARM64_BTI, ARCH_1),	/* arm64 */
+	DECLARE_VMA_BIT_ALIAS(ARCH_CLEAR, ARCH_1),	/* sparc64, arm64 */
+	DECLARE_VMA_BIT_ALIAS(MAPPED_COPY, ARCH_1),	/* !CONFIG_MMU */
+	DECLARE_VMA_BIT_ALIAS(MTE, HIGH_ARCH_4),	/* arm64 */
+	DECLARE_VMA_BIT_ALIAS(MTE_ALLOWED, HIGH_ARCH_5),/* arm64 */
+#ifdef CONFIG_STACK_GROWSUP
+	DECLARE_VMA_BIT_ALIAS(STACK, GROWSUP),
+	DECLARE_VMA_BIT_ALIAS(STACK_EARLY, GROWSDOWN),
+#else
+	DECLARE_VMA_BIT_ALIAS(STACK, GROWSDOWN),
+#endif
+};
+#undef DECLARE_VMA_BIT
+#undef DECLARE_VMA_BIT_ALIAS
+
+#define INIT_VM_FLAG(name) BIT((__force int) VMA_ ## name ## _BIT)
+#define VM_READ		INIT_VM_FLAG(READ)
+#define VM_WRITE	INIT_VM_FLAG(WRITE)
+#define VM_EXEC		INIT_VM_FLAG(EXEC)
+#define VM_SHARED	INIT_VM_FLAG(SHARED)
+#define VM_MAYREAD	INIT_VM_FLAG(MAYREAD)
+#define VM_MAYWRITE	INIT_VM_FLAG(MAYWRITE)
+#define VM_MAYEXEC	INIT_VM_FLAG(MAYEXEC)
+#define VM_MAYSHARE	INIT_VM_FLAG(MAYSHARE)
+#define VM_GROWSDOWN	INIT_VM_FLAG(GROWSDOWN)
+#ifdef CONFIG_MMU
+#define VM_UFFD_MISSING	INIT_VM_FLAG(UFFD_MISSING)
+#else
+#define VM_UFFD_MISSING	VM_NONE
+#endif
+#define VM_PFNMAP	INIT_VM_FLAG(PFNMAP)
+#define VM_MAYBE_GUARD	INIT_VM_FLAG(MAYBE_GUARD)
+#define VM_UFFD_WP	INIT_VM_FLAG(UFFD_WP)
+#define VM_LOCKED	INIT_VM_FLAG(LOCKED)
+#define VM_IO		INIT_VM_FLAG(IO)
+#define VM_SEQ_READ	INIT_VM_FLAG(SEQ_READ)
+#define VM_RAND_READ	INIT_VM_FLAG(RAND_READ)
+#define VM_DONTCOPY	INIT_VM_FLAG(DONTCOPY)
+#define VM_DONTEXPAND	INIT_VM_FLAG(DONTEXPAND)
+#define VM_LOCKONFAULT	INIT_VM_FLAG(LOCKONFAULT)
+#define VM_ACCOUNT	INIT_VM_FLAG(ACCOUNT)
+#define VM_NORESERVE	INIT_VM_FLAG(NORESERVE)
+#define VM_HUGETLB	INIT_VM_FLAG(HUGETLB)
+#define VM_SYNC		INIT_VM_FLAG(SYNC)
+#define VM_ARCH_1	INIT_VM_FLAG(ARCH_1)
+#define VM_WIPEONFORK	INIT_VM_FLAG(WIPEONFORK)
+#define VM_DONTDUMP	INIT_VM_FLAG(DONTDUMP)
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+#define VM_SOFTDIRTY	INIT_VM_FLAG(SOFTDIRTY)
 #else
-# define VM_SOFTDIRTY	0
+#define VM_SOFTDIRTY	VM_NONE
+#endif
+#define VM_MIXEDMAP	INIT_VM_FLAG(MIXEDMAP)
+#define VM_HUGEPAGE	INIT_VM_FLAG(HUGEPAGE)
+#define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
+#define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
+#define VM_STACK	INIT_VM_FLAG(STACK)
+#ifdef CONFIG_STACK_GROWS_UP
+#define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
+#else
+#define VM_STACK_EARLY	VM_NONE
 #endif
-
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
-
-#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
-#define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
-#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
-#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
-#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
-#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
-#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
-#endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
-
 #ifdef CONFIG_ARCH_HAS_PKEYS
-# define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
-# define VM_PKEY_BIT0  VM_HIGH_ARCH_0
-# define VM_PKEY_BIT1  VM_HIGH_ARCH_1
-# define VM_PKEY_BIT2  VM_HIGH_ARCH_2
+#define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
+/* Despite the naming, these are FLAGS not bits. */
+#define VM_PKEY_BIT0 INIT_VM_FLAG(PKEY_BIT0)
+#define VM_PKEY_BIT1 INIT_VM_FLAG(PKEY_BIT1)
+#define VM_PKEY_BIT2 INIT_VM_FLAG(PKEY_BIT2)
 #if CONFIG_ARCH_PKEY_BITS > 3
-# define VM_PKEY_BIT3  VM_HIGH_ARCH_3
+#define VM_PKEY_BIT3 INIT_VM_FLAG(PKEY_BIT3)
 #else
-# define VM_PKEY_BIT3  0
-#endif
+#define VM_PKEY_BIT3  VM_NONE
+#endif /* CONFIG_ARCH_PKEY_BITS > 3 */
 #if CONFIG_ARCH_PKEY_BITS > 4
-# define VM_PKEY_BIT4  VM_HIGH_ARCH_4
+#define VM_PKEY_BIT4 INIT_VM_FLAG(PKEY_BIT4)
 #else
-# define VM_PKEY_BIT4  0
-#endif
+#define VM_PKEY_BIT4  VM_NONE
+#endif /* CONFIG_ARCH_PKEY_BITS > 4 */
 #endif /* CONFIG_ARCH_HAS_PKEYS */
-
-#ifdef CONFIG_X86_USER_SHADOW_STACK
-/*
- * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
- * support core mm.
- *
- * These VMAs will get a single end guard page. This helps userspace protect
- * itself from attacks. A single page is enough for current shadow stack archs
- * (x86). See the comments near alloc_shstk() in arch/x86/kernel/shstk.c
- * for more details on the guard size.
- */
-# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
-#endif
-
-#if defined(CONFIG_ARM64_GCS)
-/*
- * arm64's Guarded Control Stack implements similar functionality and
- * has similar constraints to shadow stacks.
- */
-# define VM_SHADOW_STACK	VM_HIGH_ARCH_6
-#endif
-
-#ifndef VM_SHADOW_STACK
-# define VM_SHADOW_STACK	VM_NONE
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
+#define VM_SHADOW_STACK	INIT_VM_FLAG(SHADOW_STACK)
+#else
+#define VM_SHADOW_STACK	VM_NONE
 #endif
-
 #if defined(CONFIG_PPC64)
-# define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
+#define VM_SAO		INIT_VM_FLAG(SAO)
 #elif defined(CONFIG_PARISC)
-# define VM_GROWSUP	VM_ARCH_1
+#define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
 #elif defined(CONFIG_SPARC64)
-# define VM_SPARC_ADI	VM_ARCH_1	/* Uses ADI tag for access control */
-# define VM_ARCH_CLEAR	VM_SPARC_ADI
+#define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
+#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
 #elif defined(CONFIG_ARM64)
-# define VM_ARM64_BTI	VM_ARCH_1	/* BTI guarded page, a.k.a. GP bit */
-# define VM_ARCH_CLEAR	VM_ARM64_BTI
+#define VM_ARM64_BTI	INIT_VM_FLAG(ARM64_BTI)
+#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
 #elif !defined(CONFIG_MMU)
-# define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
+#define VM_MAPPED_COPY	INIT_VM_FLAG(MAPPED_COPY)
 #endif
-
-#if defined(CONFIG_ARM64_MTE)
-# define VM_MTE		VM_HIGH_ARCH_4	/* Use Tagged memory for access control */
-# define VM_MTE_ALLOWED	VM_HIGH_ARCH_5	/* Tagged memory permitted */
-#else
-# define VM_MTE		VM_NONE
-# define VM_MTE_ALLOWED	VM_NONE
-#endif
-
 #ifndef VM_GROWSUP
-# define VM_GROWSUP	VM_NONE
+#define VM_GROWSUP	VM_NONE
+#endif
+#ifdef CONFIG_ARM64_MTE
+#define VM_MTE		INIT_VM_FLAG(MTE)
+#define VM_MTE_ALLOWED	INIT_VM_FLAG(MTE_ALLOWED)
+#else
+#define VM_MTE		VM_NONE
+#define VM_MTE_ALLOWED	VM_NONE
 #endif
-
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-# define VM_UFFD_MINOR_BIT	41
-# define VM_UFFD_MINOR		BIT(VM_UFFD_MINOR_BIT)	/* UFFD minor faults */
-#else /* !CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-# define VM_UFFD_MINOR		VM_NONE
-#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-
-/*
- * This flag is used to connect VFIO to arch specific KVM code. It
- * indicates that the memory under this VMA is safe for use with any
- * non-cachable memory type inside KVM. Some VFIO devices, on some
- * platforms, are thought to be unsafe and can cause machine crashes
- * if KVM does not lock down the memory type.
- */
-#ifdef CONFIG_64BIT
-#define VM_ALLOW_ANY_UNCACHED_BIT	39
-#define VM_ALLOW_ANY_UNCACHED		BIT(VM_ALLOW_ANY_UNCACHED_BIT)
+#define VM_UFFD_MINOR	INIT_VM_FLAG(UFFD_MINOR)
 #else
-#define VM_ALLOW_ANY_UNCACHED		VM_NONE
+#define VM_UFFD_MINOR	VM_NONE
 #endif
-
 #ifdef CONFIG_64BIT
-#define VM_DROPPABLE_BIT	40
-#define VM_DROPPABLE		BIT(VM_DROPPABLE_BIT)
-#elif defined(CONFIG_PPC32)
-#define VM_DROPPABLE		VM_ARCH_1
+#define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
+#define VM_SEALED		INIT_VM_FLAG(SEALED)
 #else
-#define VM_DROPPABLE		VM_NONE
+#define VM_ALLOW_ANY_UNCACHED	VM_NONE
+#define VM_SEALED		VM_NONE
 #endif
-
-#ifdef CONFIG_64BIT
-#define VM_SEALED_BIT	42
-#define VM_SEALED	BIT(VM_SEALED_BIT)
+#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
+#define VM_DROPPABLE		INIT_VM_FLAG(DROPPABLE)
 #else
-#define VM_SEALED	VM_NONE
+#define VM_DROPPABLE		VM_NONE
 #endif
 
 /* Bits set in the VMA until the stack is in its final location */
@@ -475,12 +528,18 @@ extern unsigned int kobjsize(const void *objp);
 
 #define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
 
+
+
 #ifdef CONFIG_STACK_GROWSUP
-#define VM_STACK	VM_GROWSUP
-#define VM_STACK_EARLY	VM_GROWSDOWN
+#define VM_STACK_EARLY	VMA_BIT(VMA_STACK_EARLY_BIT)
+#else
+#define VM_STACK_EARLY	VM_NONE
+#endif
+
+#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
+#define VM_SEALED_SYSMAP	VM_SEALED
 #else
-#define VM_STACK	VM_GROWSDOWN
-#define VM_STACK_EARLY	0
+#define VM_SEALED_SYSMAP	VM_NONE
 #endif
 
 #define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
@@ -488,7 +547,6 @@ extern unsigned int kobjsize(const void *objp);
 /* VMA basic access permission flags */
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 
-
 /*
  * Special vmas that are non-mergable, non-mlock()able.
  */
@@ -523,7 +581,7 @@ extern unsigned int kobjsize(const void *objp);
 
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
-# define VM_ARCH_CLEAR	VM_NONE
+#define VM_ARCH_CLEAR	VM_NONE
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
@@ -919,9 +977,9 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 }
 
 static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
-				       int bit)
+					   vma_flag_t bit)
 {
-	const vm_flags_t mask = BIT(bit);
+	const vm_flags_t mask = BIT((__force int)bit);
 
 	/* Only specific flags are permitted */
 	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
@@ -934,14 +992,15 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
  * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
  * valid flags are allowed to do this.
  */
-static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
+static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
+				       vma_flag_t bit)
 {
 	/* mmap read lock/VMA read lock must be held. */
 	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
 		vma_assert_locked(vma);
 
 	if (__vma_flag_atomic_valid(vma, bit))
-		set_bit(bit, &ACCESS_PRIVATE(vma, __vm_flags));
+		set_bit((__force int)bit, &ACCESS_PRIVATE(vma, __vm_flags));
 }
 
 /*
@@ -951,10 +1010,11 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
  * This is necessarily racey, so callers must ensure that serialisation is
  * achieved through some other means, or that races are permissible.
  */
-static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
+static inline bool vma_flag_test_atomic(struct vm_area_struct *vma,
+					vma_flag_t bit)
 {
 	if (__vma_flag_atomic_valid(vma, bit))
-		return test_bit(bit, &vma->vm_flags);
+		return test_bit((__force int)bit, &vma->vm_flags);
 
 	return false;
 }
@@ -4515,16 +4575,6 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
-
-/*
- * mseal of userspace process's system mappings.
- */
-#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
-#define VM_SEALED_SYSMAP	VM_SEALED
-#else
-#define VM_SEALED_SYSMAP	VM_NONE
-#endif
-
 /*
  * DMA mapping IDs for page_pool
  *
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7e8cb181d5bd..746cb16f6466 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1742,7 +1742,7 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
 	 * obtained on guard region installation after the flag is set, so this
 	 * check being performed under this lock excludes races.
 	 */
-	if (vma_flag_test_atomic(vma, VM_MAYBE_GUARD_BIT))
+	if (vma_flag_test_atomic(vma, VMA_MAYBE_GUARD_BIT))
 		return false;
 
 	return true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 52a10ed80c07..84fc0e63011f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1142,7 +1142,7 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 	 * acquire an mmap/VMA write lock to read it. All remaining readers may
 	 * or may not see the flag set, but we don't care.
 	 */
-	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
+	vma_flag_set_atomic(vma, VMA_MAYBE_GUARD_BIT);
 
 	/*
 	 * If anonymous and we are establishing page tables the VMA ought to
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2..4c327db01ca0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
 
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
+
 const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
+const vm_flags_t RUST_CONST_HELPER_VM_READ = VM_READ;
+const vm_flags_t RUST_CONST_HELPER_VM_WRITE = VM_WRITE;
+const vm_flags_t RUST_CONST_HELPER_VM_EXEC = VM_EXEC;
+const vm_flags_t RUST_CONST_HELPER_VM_SHARED = VM_SHARED;
+const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
+const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
+const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
+const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
+const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;
+const vm_flags_t RUST_CONST_HELPER_VM_IO = VM_IO;
+const vm_flags_t RUST_CONST_HELPER_VM_DONTCOPY = VM_DONTCOPY;
+const vm_flags_t RUST_CONST_HELPER_VM_DONTEXPAND = VM_DONTEXPAND;
+const vm_flags_t RUST_CONST_HELPER_VM_LOCKONFAULT = VM_LOCKONFAULT;
+const vm_flags_t RUST_CONST_HELPER_VM_ACCOUNT = VM_ACCOUNT;
+const vm_flags_t RUST_CONST_HELPER_VM_NORESERVE = VM_NORESERVE;
+const vm_flags_t RUST_CONST_HELPER_VM_HUGETLB = VM_HUGETLB;
+const vm_flags_t RUST_CONST_HELPER_VM_SYNC = VM_SYNC;
+const vm_flags_t RUST_CONST_HELPER_VM_ARCH_1 = VM_ARCH_1;
+const vm_flags_t RUST_CONST_HELPER_VM_WIPEONFORK = VM_WIPEONFORK;
+const vm_flags_t RUST_CONST_HELPER_VM_DONTDUMP = VM_DONTDUMP;
+const vm_flags_t RUST_CONST_HELPER_VM_SOFTDIRTY = VM_SOFTDIRTY;
+const vm_flags_t RUST_CONST_HELPER_VM_MIXEDMAP = VM_MIXEDMAP;
+const vm_flags_t RUST_CONST_HELPER_VM_HUGEPAGE = VM_HUGEPAGE;
+const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
 
 #if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
 #include "../../drivers/android/binder/rust_binder.h"
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index bd6352a5f24d..18659214e262 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -46,42 +46,270 @@ extern unsigned long dac_mmap_min_addr;
 
 #define MMF_HAS_MDWE	28
 
+/*
+ * vm_flags in vm_area_struct, see mm_types.h.
+ * When changing, update also include/trace/events/mmflags.h
+ */
+
 #define VM_NONE		0x00000000
-#define VM_READ		0x00000001
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
-#define VM_MAYREAD	0x00000010
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_GROWSDOWN	0x00000100
-#define VM_PFNMAP	0x00000400
-#define VM_MAYBE_GUARD	0x00000800
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-#define VM_DONTEXPAND	0x00040000
-#define VM_LOCKONFAULT	0x00080000
-#define VM_ACCOUNT	0x00100000
-#define VM_NORESERVE	0x00200000
-#define VM_MIXEDMAP	0x10000000
-#define VM_STACK	VM_GROWSDOWN
-#define VM_SHADOW_STACK	VM_NONE
-#define VM_SOFTDIRTY	0
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_GROWSUP	VM_NONE
 
-#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
-#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+/**
+ * typedef vma_flag_t - specifies an individual VMA flag by bit number.
+ *
+ * This value is made type safe by sparse to avoid passing invalid flag values
+ * around.
+ */
+typedef int __bitwise vma_flag_t;
 
+#define DECLARE_VMA_BIT(name, bitnum) \
+	VMA_ ## name ## _BIT = ((__force vma_flag_t)bitnum)
+#define DECLARE_VMA_BIT_ALIAS(name, aliased) \
+	VMA_ ## name ## _BIT = VMA_ ## aliased ## _BIT
+enum {
+	DECLARE_VMA_BIT(READ, 0),
+	DECLARE_VMA_BIT(WRITE, 1),
+	DECLARE_VMA_BIT(EXEC, 2),
+	DECLARE_VMA_BIT(SHARED, 3),
+	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
+	DECLARE_VMA_BIT(MAYREAD, 4),	/* limits for mprotect() etc. */
+	DECLARE_VMA_BIT(MAYWRITE, 5),
+	DECLARE_VMA_BIT(MAYEXEC, 6),
+	DECLARE_VMA_BIT(MAYSHARE, 7),
+	DECLARE_VMA_BIT(GROWSDOWN, 8),	/* general info on the segment */
+#ifdef CONFIG_MMU
+	DECLARE_VMA_BIT(UFFD_MISSING, 9),/* missing pages tracking */
+#else
+	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	DECLARE_VMA_BIT(MAYOVERLAY, 9),
+#endif /* CONFIG_MMU */
+	/* Page-ranges managed without "struct page", just pure PFN */
+	DECLARE_VMA_BIT(PFNMAP, 10),
+	DECLARE_VMA_BIT(MAYBE_GUARD, 11),
+	DECLARE_VMA_BIT(UFFD_WP, 12),	/* wrprotect pages tracking */
+	DECLARE_VMA_BIT(LOCKED, 13),
+	DECLARE_VMA_BIT(IO, 14),	/* Memory mapped I/O or similar */
+	DECLARE_VMA_BIT(SEQ_READ, 15),	/* App will access data sequentially */
+	DECLARE_VMA_BIT(RAND_READ, 16),	/* App will not benefit from clustered reads */
+	DECLARE_VMA_BIT(DONTCOPY, 17),	/* Do not copy this vma on fork */
+	DECLARE_VMA_BIT(DONTEXPAND, 18),/* Cannot expand with mremap() */
+	DECLARE_VMA_BIT(LOCKONFAULT, 19),/* Lock pages covered when faulted in */
+	DECLARE_VMA_BIT(ACCOUNT, 20),	/* Is a VM accounted object */
+	DECLARE_VMA_BIT(NORESERVE, 21),	/* should the VM suppress accounting */
+	DECLARE_VMA_BIT(HUGETLB, 22),	/* Huge TLB Page VM */
+	DECLARE_VMA_BIT(SYNC, 23),	/* Synchronous page faults */
+	DECLARE_VMA_BIT(ARCH_1, 24),	/* Architecture-specific flag */
+	DECLARE_VMA_BIT(WIPEONFORK, 25),/* Wipe VMA contents in child. */
+	DECLARE_VMA_BIT(DONTDUMP, 26),	/* Do not include in the core dump */
+	DECLARE_VMA_BIT(SOFTDIRTY, 27),	/* NOT soft dirty clean area */
+	DECLARE_VMA_BIT(MIXEDMAP, 28),	/* Can contain struct page and pure PFN pages */
+	DECLARE_VMA_BIT(HUGEPAGE, 29),	/* MADV_HUGEPAGE marked this vma */
+	DECLARE_VMA_BIT(NOHUGEPAGE, 30),/* MADV_NOHUGEPAGE marked this vma */
+	DECLARE_VMA_BIT(MERGEABLE, 31),	/* KSM may merge identical pages */
+	/* These bits are reused, we define specific uses below. */
+	DECLARE_VMA_BIT(HIGH_ARCH_0, 32),
+	DECLARE_VMA_BIT(HIGH_ARCH_1, 33),
+	DECLARE_VMA_BIT(HIGH_ARCH_2, 34),
+	DECLARE_VMA_BIT(HIGH_ARCH_3, 35),
+	DECLARE_VMA_BIT(HIGH_ARCH_4, 36),
+	DECLARE_VMA_BIT(HIGH_ARCH_5, 37),
+	DECLARE_VMA_BIT(HIGH_ARCH_6, 38),
+	/*
+	 * This flag is used to connect VFIO to arch specific KVM code. It
+	 * indicates that the memory under this VMA is safe for use with any
+	 * non-cachable memory type inside KVM. Some VFIO devices, on some
+	 * platforms, are thought to be unsafe and can cause machine crashes
+	 * if KVM does not lock down the memory type.
+	 */
+	DECLARE_VMA_BIT(ALLOW_ANY_UNCACHED, 39),
+#ifdef CONFIG_PPC32
+	DECLARE_VMA_BIT_ALIAS(DROPPABLE, ARCH_1),
+#else
+	DECLARE_VMA_BIT(DROPPABLE, 40),
+#endif
+	DECLARE_VMA_BIT(UFFD_MINOR, 41),
+	DECLARE_VMA_BIT(SEALED, 42),
+	/* Flags that reuse flags above. */
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT0, HIGH_ARCH_0),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT1, HIGH_ARCH_1),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT2, HIGH_ARCH_2),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT3, HIGH_ARCH_3),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT4, HIGH_ARCH_4),
+#if defined(CONFIG_X86_USER_SHADOW_STACK)
+	/*
+	 * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
+	 * support core mm.
+	 *
+	 * These VMAs will get a single end guard page. This helps userspace
+	 * protect itself from attacks. A single page is enough for current
+	 * shadow stack archs (x86). See the comments near alloc_shstk() in
+	 * arch/x86/kernel/shstk.c for more details on the guard size.
+	 */
+	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_5),
+#elif defined(CONFIG_ARM64_GCS)
+	/*
+	 * arm64's Guarded Control Stack implements similar functionality and
+	 * has similar constraints to shadow stacks.
+	 */
+	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_6),
+#endif
+	DECLARE_VMA_BIT_ALIAS(SAO, ARCH_1),		/* Strong Access Ordering (powerpc) */
+	DECLARE_VMA_BIT_ALIAS(GROWSUP, ARCH_1),		/* parisc */
+	DECLARE_VMA_BIT_ALIAS(SPARC_ADI, ARCH_1),	/* sparc64 */
+	DECLARE_VMA_BIT_ALIAS(ARM64_BTI, ARCH_1),	/* arm64 */
+	DECLARE_VMA_BIT_ALIAS(ARCH_CLEAR, ARCH_1),	/* sparc64, arm64 */
+	DECLARE_VMA_BIT_ALIAS(MAPPED_COPY, ARCH_1),	/* !CONFIG_MMU */
+	DECLARE_VMA_BIT_ALIAS(MTE, HIGH_ARCH_4),	/* arm64 */
+	DECLARE_VMA_BIT_ALIAS(MTE_ALLOWED, HIGH_ARCH_5),/* arm64 */
 #ifdef CONFIG_STACK_GROWSUP
-#define VM_STACK	VM_GROWSUP
-#define VM_STACK_EARLY	VM_GROWSDOWN
+	DECLARE_VMA_BIT_ALIAS(STACK, GROWSUP),
+	DECLARE_VMA_BIT_ALIAS(STACK_EARLY, GROWSDOWN),
 #else
-#define VM_STACK	VM_GROWSDOWN
-#define VM_STACK_EARLY	0
+	DECLARE_VMA_BIT_ALIAS(STACK, GROWSDOWN),
 #endif
+};
+
+#define INIT_VM_FLAG(name) BIT((__force int) VMA_ ## name ## _BIT)
+#define VM_READ		INIT_VM_FLAG(READ)
+#define VM_WRITE	INIT_VM_FLAG(WRITE)
+#define VM_EXEC		INIT_VM_FLAG(EXEC)
+#define VM_SHARED	INIT_VM_FLAG(SHARED)
+#define VM_MAYREAD	INIT_VM_FLAG(MAYREAD)
+#define VM_MAYWRITE	INIT_VM_FLAG(MAYWRITE)
+#define VM_MAYEXEC	INIT_VM_FLAG(MAYEXEC)
+#define VM_MAYSHARE	INIT_VM_FLAG(MAYSHARE)
+#define VM_GROWSDOWN	INIT_VM_FLAG(GROWSDOWN)
+#ifdef CONFIG_MMU
+#define VM_UFFD_MISSING	INIT_VM_FLAG(UFFD_MISSING)
+#else
+#define VM_UFFD_MISSING	VM_NONE
+#endif
+#define VM_PFNMAP	INIT_VM_FLAG(PFNMAP)
+#define VM_MAYBE_GUARD	INIT_VM_FLAG(MAYBE_GUARD)
+#define VM_UFFD_WP	INIT_VM_FLAG(UFFD_WP)
+#define VM_LOCKED	INIT_VM_FLAG(LOCKED)
+#define VM_IO		INIT_VM_FLAG(IO)
+#define VM_SEQ_READ	INIT_VM_FLAG(SEQ_READ)
+#define VM_RAND_READ	INIT_VM_FLAG(RAND_READ)
+#define VM_DONTCOPY	INIT_VM_FLAG(DONTCOPY)
+#define VM_DONTEXPAND	INIT_VM_FLAG(DONTEXPAND)
+#define VM_LOCKONFAULT	INIT_VM_FLAG(LOCKONFAULT)
+#define VM_ACCOUNT	INIT_VM_FLAG(ACCOUNT)
+#define VM_NORESERVE	INIT_VM_FLAG(NORESERVE)
+#define VM_HUGETLB	INIT_VM_FLAG(HUGETLB)
+#define VM_SYNC		INIT_VM_FLAG(SYNC)
+#define VM_ARCH_1	INIT_VM_FLAG(ARCH_1)
+#define VM_WIPEONFORK	INIT_VM_FLAG(WIPEONFORK)
+#define VM_DONTDUMP	INIT_VM_FLAG(DONTDUMP)
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define VM_SOFTDIRTY	INIT_VM_FLAG(SOFTDIRTY)
+#else
+#define VM_SOFTDIRTY	VM_NONE
+#endif
+#define VM_MIXEDMAP	INIT_VM_FLAG(MIXEDMAP)
+#define VM_HUGEPAGE	INIT_VM_FLAG(HUGEPAGE)
+#define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
+#define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
+#define VM_STACK	INIT_VM_FLAG(STACK)
+#ifdef CONFIG_STACK_GROWS_UP
+#define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
+#else
+#define VM_STACK_EARLY	VM_NONE
+#endif
+#ifdef CONFIG_ARCH_HAS_PKEYS
+#define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
+/* Despite the naming, these are FLAGS not bits. */
+#define VM_PKEY_BIT0 INIT_VM_FLAG(PKEY_BIT0)
+#define VM_PKEY_BIT1 INIT_VM_FLAG(PKEY_BIT1)
+#define VM_PKEY_BIT2 INIT_VM_FLAG(PKEY_BIT2)
+#if CONFIG_ARCH_PKEY_BITS > 3
+#define VM_PKEY_BIT3 INIT_VM_FLAG(PKEY_BIT3)
+#else
+#define VM_PKEY_BIT3  VM_NONE
+#endif /* CONFIG_ARCH_PKEY_BITS > 3 */
+#if CONFIG_ARCH_PKEY_BITS > 4
+#define VM_PKEY_BIT4 INIT_VM_FLAG(PKEY_BIT4)
+#else
+#define VM_PKEY_BIT4  VM_NONE
+#endif /* CONFIG_ARCH_PKEY_BITS > 4 */
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
+#define VM_SHADOW_STACK	INIT_VM_FLAG(SHADOW_STACK)
+#else
+#define VM_SHADOW_STACK	VM_NONE
+#endif
+#if defined(CONFIG_PPC64)
+#define VM_SAO		INIT_VM_FLAG(SAO)
+#elif defined(CONFIG_PARISC)
+#define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
+#elif defined(CONFIG_SPARC64)
+#define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
+#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
+#elif defined(CONFIG_ARM64)
+#define VM_ARM64_BTI	INIT_VM_FLAG(ARM64_BTI)
+#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
+#elif !defined(CONFIG_MMU)
+#define VM_MAPPED_COPY	INIT_VM_FLAG(MAPPED_COPY)
+#endif
+#ifndef VM_GROWSUP
+#define VM_GROWSUP	VM_NONE
+#endif
+#ifdef CONFIG_ARM64_MTE
+#define VM_MTE		INIT_VM_FLAG(MTE)
+#define VM_MTE_ALLOWED	INIT_VM_FLAG(MTE_ALLOWED)
+#else
+#define VM_MTE		VM_NONE
+#define VM_MTE_ALLOWED	VM_NONE
+#endif
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+#define VM_UFFD_MINOR	INIT_VM_FLAG(UFFD_MINOR)
+#else
+#define VM_UFFD_MINOR	VM_NONE
+#endif
+#ifdef CONFIG_64BIT
+#define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
+#define VM_SEALED		INIT_VM_FLAG(SEALED)
+#else
+#define VM_ALLOW_ANY_UNCACHED	VM_NONE
+#define VM_SEALED		VM_NONE
+#endif
+#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
+#define VM_DROPPABLE		INIT_VM_FLAG(DROPPABLE)
+#else
+#define VM_DROPPABLE		VM_NONE
+#endif
+
+/* Bits set in the VMA until the stack is in its final location */
+#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
+
+#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
+
+/* Common data flag combinations */
+#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_FLAGS_NON_EXEC	(VM_READ | VM_WRITE | VM_MAYREAD | \
+				 VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_FLAGS_EXEC	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#ifndef VM_DATA_DEFAULT_FLAGS		/* arch can override this */
+#define VM_DATA_DEFAULT_FLAGS  VM_DATA_FLAGS_EXEC
+#endif
+
+#ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
+#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#endif
+
+#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
+
+#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+
+/* VMA basic access permission flags */
+#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+
+/*
+ * Special vmas that are non-mergable, non-mlock()able.
+ */
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
 #define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
@@ -97,26 +325,11 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
-
-#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
-
-#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
-#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
-#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
-
 #define RLIMIT_STACK		3	/* max stack size */
 #define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
 
 #define CAP_IPC_LOCK         14
 
-#ifdef CONFIG_64BIT
-#define VM_SEALED_BIT	42
-#define VM_SEALED	BIT(VM_SEALED_BIT)
-#else
-#define VM_SEALED	VM_NONE
-#endif
-
 /*
  * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
  * possesses it but the other does not, the merged VMA should nonetheless have
-- 
2.51.0


