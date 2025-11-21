Return-Path: <linux-fsdevel+bounces-69391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B4C7B13A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E29084E5FDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4734DB4D;
	Fri, 21 Nov 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CifrfoIB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DXmAdX2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B92F0C66;
	Fri, 21 Nov 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746212; cv=fail; b=f+dvnAHbkKK+sKjxWYWxfBra27pCf6AzPKKdDjYbQJsvcTz14q0kAYKyL/VD7g47bRbLZL1v8KdlpoEfPN/akrq4NelwBHOObbA+NHDCeFGb44NAcsd0IBrTuzfgCOuRWsIfe9Rn35CgZ5pCfz/BjMmP0F1Q8k+V43JxrIcNhWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746212; c=relaxed/simple;
	bh=d/LQB7ZPWlWBOE/O3hNy/vrj2JqwYHnH1HSXgshQSUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tHf7OXleuVRWSEzL1BhTbsah5BuILXFe/TwsVqFrdz+rzT/1JpAbNX+1PtcZLrzcwWLtyICcNAX5eCdzGFqs4I5Ra2STrXi1RXI3jT6cMUmqJM9ipvZJwnsrbxW4sVNDbiSoh3QlKVAI0tWopzGDvnGzBLqmxnPIwCrlWWGRs28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CifrfoIB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DXmAdX2Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEglrr022342;
	Fri, 21 Nov 2025 17:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Du3icCL7iEJaqZCeva
	bnRoenSLAvUlp/tI2lKF00qTo=; b=CifrfoIBcNe0DCF0bue1Pu73KDkGW19Ifv
	KOlBF6ezGRPxwqGErRmb7SF3J+pcX1X/ac1HV0OgimJ2N1sgvu+MnOdeNsJrTjTh
	rqZviPoQjwjWq/0yzRyNQo8Eb8/Sp4GsgackbiSBkgn4w265H7D80F1EYC/VsCgY
	Tvyugvvld0mJ/h70tINneOfpr7/4LmxfRNnwK+HcWeKPL3T/eFe4JSFKQiXH+bYy
	XyRuLtsRBBzaVH9UuZxlsu0UkONuNiF8MLlK6TFywoqC1UzoTdCRH/9YLyqKY6VT
	J4XIbNrNA84dZ/qXkFIpEiSgFpSaKyKCUXH85cdrZnzwUqvne9bQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbmayq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 17:28:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALG0ngm039923;
	Fri, 21 Nov 2025 17:28:39 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyr7rw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 17:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j72Itv9GnkLFbFt+hNSbiI7Ln6DANLQ/Fy0+MWNZaeEQ08brUcX0PFk1ag2qQmL2dn+uLSL52jd8VOBhMET4G9Tx+rFvROKudkgq/7meDVjbxL/MCl/oiQDBRu2oUb4Ona7rzk0a4hrjt46qAQ4+kzNM923rSEjK3XxYGI0T2vpyySCiBwxSo1fB5+l7pSBwVXDxm0ZwcsoYvSOxuvhY21oZmwDBbUzyK+xNKjmyGPUsIwdDCjntzIz2wIIED5tQVevzTh25WTAOrP7kbPW7zJU0Y72K6zWG43N/E0RdmE4+B53ugrmNWknzCGhBtzNYF7NGhnfpRz4wxpXZjBREeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du3icCL7iEJaqZCevabnRoenSLAvUlp/tI2lKF00qTo=;
 b=b3fmMzvZnbBc7DY7pTemkKT6YdVUvb7kb1TbxKBl1RNLD41H9BHUWD/kaZSsdXY812TI79a7L4pQ4hVF8QYnNBQYNeMxfWzx+gj02d61gMo21mE/sinMGdvZWhZr81mHSooBYS+N6VIHSFAmuM+4aP189mb65Qtwl2Np8vmlqvL4JbG+yWatUnZFtg9M7O+ave+XFl1sEpbnOErpztoVLwQ15m8BbQ3KvfZxsrGGUA+3tjB3ZuJTMv7ROE75T61FFs1G9vSrTYgy3SgiOzywUNE7pqezMqxQpOg/FOevPDnFKuqkJTuH2vnm0eAkeYtZmwEKT/2jU299sH9nvHYA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du3icCL7iEJaqZCevabnRoenSLAvUlp/tI2lKF00qTo=;
 b=DXmAdX2QcVzkqDwDgStA8maPldT1ORIJ10Bw8rbjEj1jtiRUNBUVzELnIparrMgiJImmqpLpa6YF20NKh5KaAJQyOvwRY3H0YH+uvI05p32FSfz97F0ytF92lpq2ePieR5x+N/Hy7hg5Vp4fqIjxxVfqLMqmKIbF4xreuuoIVLE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4921.namprd10.prod.outlook.com (2603:10b6:610:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 17:28:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:28:17 +0000
Date: Fri, 21 Nov 2025 17:28:15 +0000
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
Subject: Re: [PATCH v2 3/4] tools/testing/vma: eliminate dependency on
 vma->__vm_flags
Message-ID: <4aff8bf7-d367-4ba3-90ad-13eef7a063fa@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <fb709773edcaf13d7a2c4cede046e454b4e88b1e.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb709773edcaf13d7a2c4cede046e454b4e88b1e.1763126447.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 91579c1c-95f0-4835-b709-08de29235bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/MMY64P2rdzl/VgQQzfyk1N3meNoTwVQ8gF9EGlAyGw3M5lsSY2AQQj11Xx6?=
 =?us-ascii?Q?HgHPJUNYsNODuA8p2IBdq+08o3OjzySE9dsNHMkH/iwsb0talBb4MRRWW4im?=
 =?us-ascii?Q?ZzqgzAJyr39qi63cya14mF4YRH2mxwpscyGJAs3+c0Uojf579RM7E968y9qu?=
 =?us-ascii?Q?Zmbmq5HwftJ4DKnXEbQNMC1llF7m/clZ3/F4f5vd+nqTDoe2dQtVCQGNfhtB?=
 =?us-ascii?Q?RLtvb+1uoTojkmavcLGklvwCIUh8VzXtrdEcj7dUzxoJ8Og+OgqN4XLclSdx?=
 =?us-ascii?Q?xx+LJM13BeozJW23ECV98cPQqNiD1zUjvgPeVpzWOS1NmKD2syuiaZNsK9+3?=
 =?us-ascii?Q?oTjg8r3aBxuIizBxZRzWdd4WEpDBGmbTbjzcxpwxS0ztrjwjFyPKYv4Z19uQ?=
 =?us-ascii?Q?bSWvz8yoOR2Tc3Kh/FfNMGKYLS3dwW5IT5IjOyfL6dJmwhHhM26Iq66tOkmE?=
 =?us-ascii?Q?5yb9JrfZG6zQ17dGoCvIBbZTBJ6i+Vv5mJYVvr28tg3oBqOeRINlFPsMpDTy?=
 =?us-ascii?Q?TDb06o7AdbHTpiuxEWax1Oyqdr0YER++ZsiQ+/A4NlZAAbDsg8D9TxvKcvIK?=
 =?us-ascii?Q?P1YTiKWWxTcZLG65CADIHVkexYxHbzNILgOmkkmbrBuZK0KtJ8Vmyg3jCJOp?=
 =?us-ascii?Q?qglxm64CTmMINQ/m+zM0S5mgtDMmztGEz8N9skkb7/+w6TliDaZaHloB0w4M?=
 =?us-ascii?Q?AmJm8TpWhSZ6/nhWY/5dMJp/N4EBKZy1+/w5RU/1ovL1mxo1LIYMMv43cF2G?=
 =?us-ascii?Q?oUi+GuBkNPbiN/dl+hUonWlX4uX9mUKyTzL+BUJqviJA62pBBEIummuwMaGD?=
 =?us-ascii?Q?Gar3za5xsNLOhqsc5okv1YrlWG+7+z4wJj4vTE1EDYcjHeLtxK2z9MKf1xYy?=
 =?us-ascii?Q?gk3KOhObXGSqFvBdPYQVBWHgsKUpUq1S8xSYF4fM4uc5PtkvZTfTuc0hkrnS?=
 =?us-ascii?Q?SZho3CLVN8I5qSelHsgdvrnWqB4zAhZcoUXEd+9fXwLDlWiGdMrjltVO9zBK?=
 =?us-ascii?Q?bXZSSWCDu3n6qjEvxYPXG5+JI7oinOmJow07Tx7emzwo1ZumaIlAIr/wzKYZ?=
 =?us-ascii?Q?ruDOy243/LCZaM/7yKW7pmYQXCQpAiSdGOAQul3oSToj8D6XyzM/2RJdHsFm?=
 =?us-ascii?Q?flAiktjJDldOWZw9e7a+Z8box3FDrhSzIeD3Mu/14TQJxDED9tHt902N3EaX?=
 =?us-ascii?Q?2Fyg/A5vXN5CBS9ZG6JAJgPfZrs7j/Qs8+pYJG9cL+w3ItRFMHjBRVAGRd6v?=
 =?us-ascii?Q?jerGOoCHA3BowBSRRgdMj1T9KB0rd8+1acfzhC47BFWSCaBce9Iejne3J68X?=
 =?us-ascii?Q?fHu7TsYor5pfYj2w/DGIVUm0JtR+knVAqu3UV723K/OLuZUWzUpoId9gJkFg?=
 =?us-ascii?Q?qrNk+V/hXoHYKor0ElIcdR7Ags5y3FeKum9RgkQWW9sQAhJqShc6luVpVO88?=
 =?us-ascii?Q?0OhGFnm0ESg2JWSG6mj7XOl06uuNumjJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8GY3ifWQbzqIj7y1bH/NYc6J1RIxDM4sxZTeJ7oRAFoqLsqydmzMPNcJ+m4E?=
 =?us-ascii?Q?4UFeRKt4PwzoAqjhJuZgYMH0OYq38Y61Zbgp4ni+Zyrv9DfvOUY/8Xh9hPGs?=
 =?us-ascii?Q?e+SFVziqFVKOdVZ4ciOsN/NAsusdNwpeIQXSlVau/m0Prlh2ef7uAJ/yBl3P?=
 =?us-ascii?Q?Cj4zEacvY5uOaFtRuto9mHKlfWm2pMnCiPi6Ff+8+FNQIi8cPgx36gV9bFIW?=
 =?us-ascii?Q?FFdozF5Mlf3lJDV7qJyf7aWHEZ3A99NSQh7MxsuA5lAd8mq07/sMZt+JMgvk?=
 =?us-ascii?Q?phgrIfai4Bqq+PtLMhjbjak4Txd1iJZKoH0euObMh7JbXT1GRPDO5riJ92Rv?=
 =?us-ascii?Q?oDgYpYcPYnjWJExVugSqaC/fmYt5+3L9zOyKzqf1V2mzqu5k49mGy7UloXvZ?=
 =?us-ascii?Q?fkEaXghUcc2jJTDaTX4JBJaN1g3TogbsDKP94HTh7g3QWX528jqMy8nXi82s?=
 =?us-ascii?Q?Jl/XDeTO9c5xXtOqUbt+qIGlnG8AnnFRJUy6Ia85XueoJoD2gpySbLDfJUcP?=
 =?us-ascii?Q?ll4AM2cht1J2xB0vOEnNGB1X7VbSuXXKhfGyctCBX7XXe5jixEEfVkux2ZMU?=
 =?us-ascii?Q?uCUMxAJhKeDBJ/izFf+BrgZ/WvGoOg+93fA5e41zEyFOJZYWuvFj88Gz+SKH?=
 =?us-ascii?Q?gVyZzXzljQEhzTbhuo6jWpcCSY2Wyhf0WadQeRL22MTmZjx12VKIVNWwUnYB?=
 =?us-ascii?Q?YGQrYgFqldaRRKg/5tHmgydodLcnQ4RkHFzWaAu9Du0yQplfcAvVMIVDUXhI?=
 =?us-ascii?Q?+9AUijQbgENModaLRJ8gRuDOJFP2b4F6qpBEapAkW6i6cjCbSIq3fj8QNUyv?=
 =?us-ascii?Q?4tjzeimYwNNJS4U8BHg/JmqYT4WsZbc9bnojt0cOSbzCH5Y8j6XYUJ/7uk83?=
 =?us-ascii?Q?YtEWB1C4CmrFGP/2DN8665lrfxyEw4uET2318p7KclFZ2VS+vGCB6+IaDgdp?=
 =?us-ascii?Q?qhlVEJWA9hvLpj1l6oBggT21dT6ZkVulUI/HyP7VL3L9pKM/D5CXJJcxJEyj?=
 =?us-ascii?Q?dSeo4sSR3RCJiLumFryn6Sp8d84bcTXSul0R/qaC61FPl+3VETdck+Q8Nbn9?=
 =?us-ascii?Q?0nzXlIAj30l0u7ZCC3nBSZy22M54MzGljViqzRmUrbV2428+AAB5GS+nqybD?=
 =?us-ascii?Q?SYS8kbvyvzVapST0eVbYzsiH6jCSMEsgmMTTSvG99WLqTtY+b48Y7oqO35bp?=
 =?us-ascii?Q?wa3IiLzsH+pfltaVoAOjHRaE6WI7SqszcdPuEYIt7X/BnNysNQjqijL5Dl3H?=
 =?us-ascii?Q?dkfvsSP/P0Z8aVE4FffnSY3aYSNcv+Lx2M32bTYBbrpooe3c/3AEC1YuTpFv?=
 =?us-ascii?Q?RFHuketoYk0HFcVPlshPhYkET0a2IqV4FiXJnZM0u6UeJI1d23+RfA+v7u8y?=
 =?us-ascii?Q?Ff0bxdp7GAJGW1V7CLPFHXDRSoqo7J3e/hkVf9+SOvNJTZVTtmPK2rGL74Wo?=
 =?us-ascii?Q?wfwwsuQKqgGbohklaq8dXD1LrZJ3IjNLs7srI9AA6nag7fTcob4JP0464gTd?=
 =?us-ascii?Q?4joioaLfuev5x+o7Qrbzhf33jNIlYnsFhJDjpznYcG94pia2ppwcd3v1AVx3?=
 =?us-ascii?Q?1ncDP49F8lldS0mnAM0QA69sFDka5NOygeyv8IErq1o/lw8FICXeplTNgmO9?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yi//XiyoHGi9Y3qvzN0dKcUUh0qnj7txp7oDUpZTjKSx3AWb7c0yKYQcJLbgBDf7jCAqnbreeRSFjjoRzGfHeULbNYTRYb0rOlBLP4ZQvO/UPaZfsomaxOg8EQCOFoZOKzbAr+YujGACWRgpeC5D+Woo0+Liu1wffWEOXL68XHuDaR1qa4IIGQwf/Tokx18aOeIJIc8xMYPENrHzoZ+IPf3qtqtDRYWaSG5syhEVjD/3iXf+q/SeWxgBLDiqtFSwxq7CravD5sx6XuYqt2ssrVbjQYOxSpqp8jMKgWNgOrD0trvIKb2wU/5ENGmcksKJbFHTLTmFK74pDf+rvDIFdef5qmP5XV43q/AA+rlIG4XJcdgZD3d8C0ZfR7T9vE4YUdV4FPhNhnNrUHNfhzmJQHoW/2C/WvSwRfmQJx2s3aVU1Vyqqd0nqBiRDyyX5hOYzJOP3DtdvKSYfRB0jPzvohbPRLYD6hhcPgiWscatlabd3i1a/uQflctfEBBx+3k5EzjHCABcJiY/mBsPegDFJsO5Vz6RPB8Nr6nPPgA8wBuu2B/zeSnhUO+BFzrATR1DcVfqXszp3/5X8nePItwunTW3Ab3zqG193BtkAVvtldQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91579c1c-95f0-4835-b709-08de29235bf1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:28:17.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldQtffEMvVhQm1pcUC5Sqor7njZ9zfrd6e4Jeoj7IOirN7cjb4vZYQ/Gw39NkHc1H8I945fmXAVLa304lDE6c+J+zmQicGdrlbcmDs/gE2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210130
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=6920a148 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1AWvfZUCizywWEugc4YA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: HN8pMVDde9bNduW6TtOyn5FZhYBAK81S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX5DTOq3kBUWj6
 jjGEgvyrICdd/23jztkO3aqNEyREKzIo5AJ/X/t7hpCYz4dxXs5nPAuG/zdqdMQR5z1l0HryaO8
 pnc368SqiSmfCgoj6w+F/Sx1rKamZWdtIrtn8aPsTGeCVsfQrVsH00yPaNwe1lf3PM8srrh6Iuo
 pX1iSnmIJdptBwArwxCQG6RBdXY4m8VZ0ZLwL1/FmJa2+Iy9H/fp/fw/ObqTLP1qLoFG8hpnSw3
 lFdHW5CPbiB8CnP0Xf+jwdFfZuOsvxr7idxGyFGhhLc8VPR/h0BUJ0OH4l0JY3SLJMLq0KkjVCq
 I2OyKir/mWxCdVwHSjO7UrlGVTf1Z3AHKXBx612f3B055mCq/HEFlDA5M3BEFCzcz5LgwylEzQC
 +mQKLYHbUfoKNeXxMzXoIhAdQpls15TFDInYYJDrx7RF3Uc1SMs=
X-Proofpoint-GUID: HN8pMVDde9bNduW6TtOyn5FZhYBAK81S

Hi Andrew,

Some small silly issue here, for some reason I seemed to have vm_flags_reset()
available from the VMA tests when I tested but err, that doesn't seem to be the
case at all.

Again I realise this is in mm-stable so this might be fiddly so we might have to
live with minor bisect pain :(

Cheers, Lorenzo

----8<----
From afe5af105e7d64e39a4280c7fc8b34ad67cf0db0 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 21 Nov 2025 17:25:18 +0000
Subject: [PATCH] tools/testing/vma: add missing stub

The vm_flags_reset() function is not available in the userland VMA tests,
so add a stub which const-casts vma->vm_flags and avoids the upcoming
removal of the vma->__vm_flags field.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma_internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 37fd479d49ce..f90a9b3c1880 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1760,4 +1760,11 @@ static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
 	return 0;
 }

+static inline void vm_flags_reset(struct vm_area_struct *vma, vm_flags_t flags)
+{
+	vm_flags_t *dst = (vm_flags_t *)(&vma->vm_flags);
+
+	*dst = flags;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
--
2.51.2

