Return-Path: <linux-fsdevel+bounces-73501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F0D1AF8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F11763002141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916AE2F25F8;
	Tue, 13 Jan 2026 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GEN9ZK4S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TwPKQB4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337B35EDBD;
	Tue, 13 Jan 2026 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331554; cv=fail; b=fLiHkVRtDR4IiSgwsLcz6ZR7fs/MKqJQ3EEr50JWFKZpuRpXIak3S4yVk6IFYR37F+9di4Zp2DTYK3Oq33eTlxBzxUI/j7+Y4WHWo6emQshWCORPiptYOhYo8MC6Xz6EpP0ToC+Ilq7v0k9pMfZ2BfloGHU42Yqbn8e0mjHc0H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331554; c=relaxed/simple;
	bh=E2E8hrZ6nFhY/R0fa3Y4RFGK8yS6X5FDJRaHuSj1ZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PBuiNoDdJQcRi6oXzDAKqg8rsKdBKDlxgPjdSELV7vG/PDawq0TJEndInHhJOkLCdlnYr3op2KVg57IT9CHrenzXVTz9GFA97pGE0oHfEhdlZU6wqerr7lvpQjorLhqAQRNMCsZ/6QJfG/Zrl2nf/s8+26A2YxwSSB2TnpJgVaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GEN9ZK4S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TwPKQB4+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DFhfvi3330416;
	Tue, 13 Jan 2026 19:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vEpLvOKPblBU4bvvoW
	zTKwVV1YbV217UAjrZjySCPck=; b=GEN9ZK4SFPVrHD95SpOnlA4UncDQx3velZ
	SsgJY1HGu3P/XcZBeLGbBTSxflx3dK/0rBTq8ZiK5KSj9APDNOgopCSYkUroyeVr
	IsaSMKQoHUlTJGEXnGTSCPfZzS/QtzOL9FesHXYGEXX2ahl9+vkhrTF12+oRS94O
	DwhbGopo8OY+jyaCk2G+9S9mZtajV+aj0VLmYzwhLn9KvQrhV0pPdflD5LB/AoRk
	MnsUKqRGlkKEbSR2/jM8ST+s8yO/Lt6dzY8sWrAimvgbFc/4MgqeHEccBUAcgLtj
	D0Tb/rq2NP1+pHaajwKbd7lJAFbT9bH9QeSyv7JEGHqp2XzvZaXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrp8m2nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 19:09:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DHvW5h033952;
	Tue, 13 Jan 2026 19:09:04 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd794f1g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 19:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LObs4borHMcbPZo/OluknuhUnvQbehaCa3AO0vIVUOHjKQzXLUqEd2a0cBQX48avpnzH4e1pWUZitus9wxReVj3YZV9CKsw7vmbDXBvA8vDQAMjgfXVhnnoGtj+m7Ihll2Z1XyjrIzv9sqtY7Ely0+8tHKVkbbV8yPO9rz7urRa9zu/DYjx4ttYbOwN94yRgaDyJdriigNHDsVpyELWtnIefNeAq2vnP6KtmMk7tJN5ACsUWkQABhYAFX5ubFF3vHgqEA6rWSDePmkGpuUU4xWdQWHDL+yH18aur7ZgbeXYrkvziYwBBES/dSEpCbi+rdDxePAaN7DD0f6zGVqciRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEpLvOKPblBU4bvvoWzTKwVV1YbV217UAjrZjySCPck=;
 b=gNtSLI8tXC8AbaA8x2YVpIKjDfHHrEVAj5Z40nvTiZPxTkNxLI3o6hH+IlTR+zq6RPJ2LZie0Vf6xzzSJmraU0LRqbXjsziWhpmcQGYcMsrl90/yGRcdgMtSm/uikIq2RcXsPFyinJZRq0fsjvPDtrKGpP91A9z0Y0GHjJEMcx1Lrj5Pnfpx7cLCt06zrB811TpU3mI9L32Y63Zu8iBb5+So0Fe9D8KE8TkXzwelXvIfYYGPZ/Als9U/CZ+C/wFvqFa5Q2d87OT+CoCME0x2AgKQHDJGKaZU/VIyhBAtAiwXZW598y5Yfj2OsjtoMMTQQuFwpSgM00dOTWDRyPZnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEpLvOKPblBU4bvvoWzTKwVV1YbV217UAjrZjySCPck=;
 b=TwPKQB4+eUT+6PwXe0o4wkm4wjlriXDL+u++pKrnGPQY4qTuVwtYUBc/URJp39nj+aaxkS7cbcYyvK24PR7hic4U1+UVxhwgsT4V07QTrAPO6c7FDsQDpqMtyfjUpJi42KyjfaCip9dDxG3EzcjIjuzgrLNYMJ3JVSonYqAt+Io=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 19:08:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 19:08:59 +0000
Date: Tue, 13 Jan 2026 19:09:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
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
Subject: Re: [PATCH v3 1/4] mm: declare VMA flags by bit
Message-ID: <0cda6c54-2ab0-4349-8633-e3eea1306e7f@lucifer.local>
References: <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
 <20260113185142.254821-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113185142.254821-1-clm@meta.com>
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0dc253-65a8-4001-57f6-08de52d73521
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?m8YlMby5LOoA4RbtOEUZdG6mnuoj3neiL7Tm6iIQ1FkcQG/F3wRC/KTGSJa5?=
 =?us-ascii?Q?CU1jU9fRh8D/bTcPx11In8Ao8/viwO4vmb6NGWc06F2Eb2uikEOn9wnjgDUp?=
 =?us-ascii?Q?TSSf6yhw+6/Mtkb2IKI2SV2rpRlXkxEE6vk7SMD+BUvPKOOWnYA38bhJ/hKH?=
 =?us-ascii?Q?DcIOHdR3UOHjWEuU7C9LDOIe9xC86Lii7AqCX6saj7HFWJjB0Pp64ki9J2ES?=
 =?us-ascii?Q?mSrfrmWIm9nXViRUR8/Q0pXMCniFuP216LOvifOoVjIJ1VGcaUMCrXj3rrGG?=
 =?us-ascii?Q?ihFYaLkxcMoz8Gly9veNZc0/1CkcM7MG5/L5PnLG9omH3a6Uxg7OmqSKBw1+?=
 =?us-ascii?Q?apegSZs7WCe81/AqXDwntfAAJHYcbdVfNigyYRgHDbY3E9LlnOmS0+jVijkP?=
 =?us-ascii?Q?m+SNurbVVWXcbTG/pJF2eFbchwxY+lqEduhjTQQk+3t/XCCVhsRMP+mbkdGL?=
 =?us-ascii?Q?FZAGdLQ/z2o/508NUhnUYZisxup7VGjsPE6RyGNg3b9OfLOSeK9S0fVb90nY?=
 =?us-ascii?Q?zNKP8fDeoPme6ANutIh76EO7gVPRlts3SICfiQq1CoEqYbk7y3pi1wRmZLU3?=
 =?us-ascii?Q?hPTQhycWfXtnNYx5L1JorIiqn9j1sO9ZwqZ5SxdUfs7VoLWOBKCtvp7eyU4P?=
 =?us-ascii?Q?kzfjncplSnSrm0csU8YTIu9XlCXMjQRRPOTM3JcYHJTmci4O12avPsHvN+2Y?=
 =?us-ascii?Q?O+/fEQFiP2clSLpyWaBPhB0ExytGDJpudNiVOkbnpGZXJ/OkNvcZDlR8tePZ?=
 =?us-ascii?Q?dibBXJR91xjqnBs7Gva8HWZnoWDK/VUakBYFU/xjVR00X//4dzTypfvKxFbv?=
 =?us-ascii?Q?8WStALMUYl7wIHSfCrtUTZ94sa9ezADel9xDsJNZUjhVYGWuKvDkKTmgs07n?=
 =?us-ascii?Q?B7SSWTPp6RJ/aJ9k6P6iPLgEOC9ylhDxiH7EoeCGEL2YRkLFd8w4fRvFjyDj?=
 =?us-ascii?Q?Hn9WIR2u1b/YNIX88jzzJPT5iQZv6G6hY4CwbXCkRDvQLCmcwFb+MamWZcHG?=
 =?us-ascii?Q?YEgWwf8YyBlRQyz/YAsNv8uWqF6gVpUdR1xYXafkmVsUsjLy4V8wxHyoFsue?=
 =?us-ascii?Q?jGRpeuk1aqqFcSrG/+pcasv96sHsDceiXg1EhAg9d1FB819lPvSNSyTAq2eQ?=
 =?us-ascii?Q?wEdMaeTGbgI39s6K9yabOWZnC9CMIfWgDshjmBPcC4HeCXwhTuONGjvK4W+g?=
 =?us-ascii?Q?6TkqgSxrvczIlFNlAN7SsrFQSdpj7phgfNlNxJO2S3cYkTs1hoKHsg6Nj6F4?=
 =?us-ascii?Q?MMo76rygi2cpYqWUo0LKcFOfE6VfeeAGhf7aOokEvmG144hRJEEmOaz3f4y6?=
 =?us-ascii?Q?Tb8lxV89OtEo9pOtPPrC5gfa5aLnLv+wLc2yjdF1zpEgBklKtNwdimqxsXYN?=
 =?us-ascii?Q?NYZKIXw0g1H7kR2GaUSR7hPEvVA+TVfq7T2G7rXyK/KsxU+MQwl564tSggjA?=
 =?us-ascii?Q?eCXvm8ILQMCRy6OyvF4zPEVPMkLAK/a1?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?7wreCJfuKA1uOEus5D6T0W3LYhhlv389t36ZgtoG66+aITX+OVavepRlGIJ6?=
 =?us-ascii?Q?VAK3CuGMjLVXbTd2VGzGmDXIbY5ehmMu6Z3nLByZU22qrIm/E8UGiRZrmjAq?=
 =?us-ascii?Q?1EinLNpsp0zs6yEzSF5btbqwhbt5sMUGWA8CIG4v0I72FYq6SZ/80HH9CBT/?=
 =?us-ascii?Q?l4a0XSp+CR5Oa/54CbY/4GPqwB9lzmTPcITO0bRp2tt7a3KPZL+FDscLNBHJ?=
 =?us-ascii?Q?+wNNXAcTB65en8ArUq6N1T4ZZHftXYWdQ6BXdONPrmNDWAsR1iSwcXiy+Lbz?=
 =?us-ascii?Q?c+dACwixM+Ah92nwfsEfC5vBokpEQm/fPyADHSOS1wS/VeWgaJ/UlPlR/aXj?=
 =?us-ascii?Q?PU72Kd4JE7QoPKkSX85uS+ePMNIXEuObAVWlnFMVMHH11md3OJIL8JGBNknF?=
 =?us-ascii?Q?iy2WBvh6gVUbz3+XZx2HxHgJ96urdxgxoD76BVvMcEIpsysatYcQWkE2LcOV?=
 =?us-ascii?Q?ADIGz2CBZQLDoI3Diw+qb7MTcjZQlOQQfoaSzwKmXRFfmBjjq3us97RKGAw9?=
 =?us-ascii?Q?q5ZVz+ZbqbL+XHjcNJG8KeY9TtJh6adh97LIIuqJ+WNZAXQwpXVFrbG8VdD1?=
 =?us-ascii?Q?S6gvYzzXoqltYAu/Rnul8egsKjGXUgANIgb3w5pqRnXC43dzh0BrIpINkpI/?=
 =?us-ascii?Q?rPoW8a3QHQv+Qt36smV0HjPYzcmJ5gm/lf3peLBkKZ+48ypuVdtp0Zy1NZl/?=
 =?us-ascii?Q?N0YD7yv89b688kfoJmawGAlOFc9FNOioCaJj6EiOAVvzm82QSTg4coPV5fMM?=
 =?us-ascii?Q?+H0jyQmLT6GWFGaMVK5SgVbm4miFrrYOEclYvtoFeq3Nih2Gk4o+ZzI7dI1g?=
 =?us-ascii?Q?qNJoMxkl4xRWMw0yertIllTtgoEiMbsfoprcVGyAI4w0OQQ1kVXl2EQEEsa0?=
 =?us-ascii?Q?TifACB/ypSQsEdA4OBPi87Ns5jWct9iTo6eFjs08ThoreN3bLOvtj9s1KzqY?=
 =?us-ascii?Q?8C8O4dz9Z1CVAEL4r6ROCi6h8159L5l3K4GylAUGxtAgiaCas8uCPKV/vDtv?=
 =?us-ascii?Q?kswaVlCDgD2DOS1YVcgkDtNmhqK6FFikkCSP9rrML3a3rvTIMtNe+HyQvTDS?=
 =?us-ascii?Q?Qjwl+XbkpdMk+f+UGEWmJF70M0xDWyl4/bqw85b25VeFUO6z7QOuviubkiSK?=
 =?us-ascii?Q?Q5qr5aGNsA6pIk3JUXZq6BmoftxtJP3WCn/MWj9/X0KPMoIa9/kFEZFX2l24?=
 =?us-ascii?Q?WlfQVpvgCN2fvIQfzk5UDtvLcds79djbJMM3ptmUTGpE3D5K7jDZX6Rk5XCt?=
 =?us-ascii?Q?L4fLRTFv441o0bOzPBpS07Yedo+OftbvwaKZ743tF40L+2rYTZnvj4bdvZUA?=
 =?us-ascii?Q?rfMJxqGG0XMnjqMEct2Hsc31XmvI1RUAkGTgpv77Dg0T0VbzU98lEfZowUQd?=
 =?us-ascii?Q?5CVJVDPobxtuv1wqgDfO2Ie3qdkMnz5ovnB386Xk9zHinYL4l8p8AJFXgcDT?=
 =?us-ascii?Q?54INx5tvy5hAGDPnI7uYeVuJabt5hFnI1/x6QOU4BElpZ8rZIFOSH1asEcQM?=
 =?us-ascii?Q?gw16D6GrGpZbyZNld2bKncnuuUECShPJT/LRVA4WVj5ECvj0nviiv6y+gNon?=
 =?us-ascii?Q?0k2eyJf6KOEqwO2TQXFP8i5YxWQ2GTivfHUi4/8gQP3bgDnf0jt1mm59EzAy?=
 =?us-ascii?Q?dDhBpcQ5wDilbT0+y4CNZ1dR9o3xUWNbAuGI/Pv1XVbvnav/0l9NvX5Cdvhl?=
 =?us-ascii?Q?/qDNqYo1F8HCyByrLnnfmaZoaBEKYGlki3SIkG7aOstKYY2vGV1j8ByBMb9Q?=
 =?us-ascii?Q?0UnyNSn+YnN1z1FpacgLeujBlZMcfDQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9kqVGaO0O6r7VwpNy/rTxJmZQjNl6T3nYvQ6s/P525ECC0NCnYOwjbHYCWprnS06GDWpCdy7a6K/Dl3dyv5Clr9M5FXDFiq02PDBzjgjH7Y83z6p6oxr5WdfFhPf1TNqJqeKj7vXJcZ2ml+FQ5QfsBSprvgvKDKQLdaW/Dnsufr4o6VDkQzIE58VU4iUPAYzAb0QvtA75ebBHnmBzZa+iAzqh3KX7Losp60BMm1/aXunadGA5uHIh6KtgkKHu9/TLFnQya2I6gmXHmuN+lhzdQMJQlVEjvrzuKSQyvLY0LsEXk+Xo8LsZ4B5PcVKMLpNAw8xcJZnhH1e1UUVz19N8Zak+Sbgq5I22iGnXafboOBYQAXOQrzaGDIivzurdoD2SdA5bx/MD8YZfgnd8X7jDrtp1zicmHAHZ9HgsB/GyMRlnsN74FCFYmEgB8v/MY/RH0FTjTCUheX+aTCgaQvd7EXZuQjcpQFeG7U2TWIG8WB9JXSf/AFlR5eybtYL3M57KtVnB47fsfVOjsSYPtIdEhiCAVtJQ5vr3U4I3ZOnCbBd6lXBYqtVEoYPHRGyp3m7Bqky34orbVLHZjrZp3sRt9KncRfTnkKXp4uV8uLiVIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0dc253-65a8-4001-57f6-08de52d73521
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 19:08:59.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmYEljFVPKBcgwoBfy2Y/GbY1B04d87dezZ2MMVjr13oQAedvf7fVw+H1x2cvh9zjw6dh4UdbL85QIofdxk5o89Ynt6ah/DiHj2Bzit55/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE1OSBTYWx0ZWRfX/7TGaTzCl5ln
 y+URblDOWlXOInjDLnFylU4+QRACvEoemMD+8hUM2cYv4BT/VhCPKxHzc8/TcPiwmSsuOVYrRv2
 XVeP8/0W42P2Ha2ay48qImV3REE8LolvHSN1XAdw+NLTWqlIr1qpSnxmhhAEI/brdsl5gm5lmSU
 +fsakRefKWcxMWPEjuUZYltC10DXZ/w8+8unS9ZbH4WfGHhb/3+MOZOljbTjczEIqqN89VyBPQq
 5PIEqEHT2VWTyZdav3Tjd272d0wDc+SGVNVRmOhT4yMKgGEAyQLYtx/3FoNWor9BA8PydYfOPsN
 DYM++8uX2CFIMs1QYQhTJUpi2isDUPT4pap9p3M704XHopu+TlD+2G0RJgJBTKCh6L6w3ZQ4wkU
 iCitF+ZLCIMRzesI7gQCpqjWRIoq7v69tRLjhcDP1wJ2KwQPLQ9ErtOetPaO3RM1oQekSETu4u3
 2KxilKyztkql3EgeqMg==
X-Authority-Analysis: v=2.4 cv=YcGwJgRf c=1 sm=1 tr=0 ts=69669851 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=8tv4u5OgMDwXTllgVC0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: CK91t-cWek-KgprDOIwdIi6ZENzqOODZ
X-Proofpoint-ORIG-GUID: CK91t-cWek-KgprDOIwdIi6ZENzqOODZ

On Tue, Jan 13, 2026 at 10:51:37AM -0800, Chris Mason wrote:
> On Tue, 25 Nov 2025 10:00:59 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> [ ... ]
> >
> > Finally, we update the rust binding helper as now it cannot auto-detect the
> > flags at all.
> >
>
> I did a run of all the MM commits from 6.18 to today's linus, and this one
> had a copy/paste error.   I'd normally just send a patch for this, but in
> terms of showing the review output:
>
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 2e43c66635a2c..4c327db01ca03 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
>
> [ ... ]
>
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
> > +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
>                                                    ^^^^^^^^^^
>
> Should this be VM_MAYSHARE instead of VM_MAYEXEC? This appears to be a
> copy-paste error that would cause Rust code using VmFlags::MAYSHARE to
> get bit 6 (VM_MAYEXEC) instead of bit 7 (VM_MAYSHARE).
>
> The pattern of the preceding lines shows each constant should reference
> its matching flag:
>
>     RUST_CONST_HELPER_VM_MAYREAD  = VM_MAYREAD
>     RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE
>     RUST_CONST_HELPER_VM_MAYEXEC  = VM_MAYEXEC
>     RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYSHARE  <- expected
>
> > +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;
>
> [ ... ]
>
>

Oopsies!

I can send a patch unless you were planning to!

Cheers, Lorenzo

