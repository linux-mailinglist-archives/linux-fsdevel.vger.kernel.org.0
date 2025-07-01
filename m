Return-Path: <linux-fsdevel+bounces-53454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E82AEF257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB37443F04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7561265CD8;
	Tue,  1 Jul 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsHfsXkw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDxShrz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E925E822;
	Tue,  1 Jul 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360361; cv=fail; b=e8+fFO7OSoTqgEOwIQ3fz2LY+jxzHB3juZpd6UNthqRDW3avF+y7Gkge/cNj+p1KQiuCMPuGprax2s2ILIUekpyuUp8S2lvAyH5zfDMYfnqB35nOuvS3k1GxesI1d95CshJPufybKQjpUDs1ucrzBJ3Nlocynu9KDjXszMTZNU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360361; c=relaxed/simple;
	bh=/hrMg0EDqNylLLfNyMghnrlRrQ41UNv6TP7MRuVtfSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a9I7Y4nU117Oyx2koDV3on6KISAQdcxabt+7Bhq1waHxcRvQHnzdVqMBrwV3nIssGeKDqaiWnhOGjYAa9vB0CQt93UUqEA2Yp/SqNgb52KDHyQmB7k9WQfS5toNG6T8J7ykGKHXKjXQqp/n4IyQxwwDveMSUELZMbG9ffc7eoPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LsHfsXkw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDxShrz6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611NY3I006000;
	Tue, 1 Jul 2025 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UGnQtI2REDnQdxACuQ
	XVX3vSg5bq5U61Wkk0oT8Xhi8=; b=LsHfsXkwqOqzkvkinAqKjvpY+JUZVx23Tr
	Z7rOOPq6heL84Woy8YS/n5vltE5PhncvoFoIk8INF9RWxfH2atXKmFk23DyOgZ8r
	6nF7WIJE9n3XHql1CKjBt7wHtWISADzhXx0pJGbIiK+LMIhxjRHaGfrsaeef1UEY
	Gf7qmatXfVazBuc2+ocNM5nQfZi/21TbPzCY9MuQtGJ4NQco+oEZBFfOZY8v6l07
	cIQcUADX4ku62jxXIvTI+PQ8Hlep338UKbJuynW28/C3GNzxu4/VMIMMhnlgxGIX
	s9Z+RI9hT0C6f2yTErFs0keoRG4iktD2mSnUbJv+qiCNkL0CQEkg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af49cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:57:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617aSeh029824;
	Tue, 1 Jul 2025 08:57:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9fdbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE8XUgTkAsZLE3Nw4+sS9eKk6yW8YzRqjSRBsSYm+A+J6m4cGHkjcnyP3WHOWB4jw1sa0DwH0gnTivSgMr4nFB9WpdIw9N4DFNTaBdtVprOD2GJfq1rzhPNKADKkB5iJ7N5yRRfesgfdDb3YXTkj6+QdqJ7JB/kUCvYMYUCkMyFzn36mwEzYaIQgMuAeV/R2k6wnrg566hSJGif8MN4uKb0GwDwYH/iFpf8zaoSkuhMBw3M3kF+QHTwq5BuUg/dZhyj0Iz3cMtar1hoMgA3Yafk7KSNAOLL8FYEBAUGkP+oe62S74dLBmdu9Npr4UbvcMJLUGMjeZjaMe+HYqbAoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGnQtI2REDnQdxACuQXVX3vSg5bq5U61Wkk0oT8Xhi8=;
 b=UHFfAZGFrjcV76lCclQiYTrHLg1kiVelv9bHb9g12o+86PMe6BsqwSQAIr1dHdvWIPGWIZW4/JUYqt/8Z0v+BvaSsslxKx0eR3RmFn2I5AgCYI5fDHx0kSdD6O6nnNrBud+fyJsIfIdo0JKkwKSJpIs5m3DR8JmTkpwIcOswZQ0PLVrr4nEme5QP3/X5Z0GjPgnwx3v8VDqZViaVTKXjWC3DbPWSLPGgtFx0VkeOuqtDqoDvq+lnHNhG/ZPZ95Lr+QqEXNMIDT2s7qIsGPRuJtxiyQgi68nD5++4k5mOM5GCTZ8wiN469A6gdfnxadFDP6594n7lJyT63PjxRVUOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGnQtI2REDnQdxACuQXVX3vSg5bq5U61Wkk0oT8Xhi8=;
 b=KDxShrz6izgmeWX1btjhAT5XVtQx4JxByxVDVnbJknUMUYQ9O6nTqWNkGzQxm60v36qiyJ9xwLvF3EtgTUnjZ9OJvl9j5HMGeBY6mCgzI1dHIcakxZxZBCJ6/w50vjQrerYmgH/AZgpu963BnA5lP3TdJjycDxixlFj1Lk+FaC4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 1 Jul
 2025 08:57:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 08:57:29 +0000
Date: Tue, 1 Jul 2025 09:57:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 03/29] mm/zsmalloc: drop PageIsolated() related
 VM_BUG_ONs
Message-ID: <8b64f02a-8afb-40e6-bcfc-3eb90cd58e0a@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-4-david@redhat.com>
 <ccc333aa-46c2-49ae-8d0f-ffbde95cb22d@lucifer.local>
 <411b94bb-4662-4357-86a3-05478f2f8c8f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411b94bb-4662-4357-86a3-05478f2f8c8f@redhat.com>
X-ClientProxiedBy: LO2P123CA0044.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::32)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 58371935-e4c7-47f7-c4ee-08ddb87d4ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BU6RT4QoKrsNdQSQ4NbWUtxeTrfiS+x5rAUSByUa9hG8KNyXLd3iKkPpRF3l?=
 =?us-ascii?Q?Rrjp3e0a7bfGKIxZziju4bYgteZOoqWCNpshIT2KmCUFNB5YxYmth/vfoNwv?=
 =?us-ascii?Q?4+VQ/jxeQJGrxxy8n/0maM1ac3zfUIHoNQwjrQZDIxi2Fk63wS5oDmSci0lq?=
 =?us-ascii?Q?Y40EwXB77n9FtDWMj/izfkYlZ1EBHDW3v6H2E+E4VKGQfXdhbRxqFWkfAajk?=
 =?us-ascii?Q?aPpS0OFXAp7EkiUiRwLfoFOtUCxNNMAZfnbF4woHxt4tQcQlxS+gEd1vxJhl?=
 =?us-ascii?Q?e8gml4Erzi6k/NHS9lY2Dkvt4jEYY1cgeZZuhBhwaQYQg0ncqaUp9lgj2geP?=
 =?us-ascii?Q?6YZhG4H5w2v17BlskMHsYBTX46Q4PLf3D25S28EN5Lpl/lN2+sIhqYnb3tg8?=
 =?us-ascii?Q?b7jpQh8bGJn/krU/1KPfnzzzNJVGObFbcbGSeEIQQnt0BcG0BA7a04wult+l?=
 =?us-ascii?Q?9pcuUwy4VkoHGeKgkJhaCzYQ1U2tN43OFHmcFO2k6g8wycbHjtq4etPrn8GR?=
 =?us-ascii?Q?wt0KrEDmR4m0FwnHcdXqevj5K8W16GgKep8X6CDP7hwUnZOO/OUx4IzQQqsS?=
 =?us-ascii?Q?9zzFvY+TQLN4RifBxJSlmCRHa637ibrEDCEzNneUB2MNbshQXYSkh+iIfLVh?=
 =?us-ascii?Q?SBki9/1SQQPOX5iTzgInKf0F7hAXsdRlBNW26tWKRowDOlsmVt9m3vQtSMRD?=
 =?us-ascii?Q?x1N+KwlzyrehTXK4AuGACvdDJEKo9kd01YtRQmY2V/6oGJD1rSAUm6xhaWGU?=
 =?us-ascii?Q?8w4qToXoznRQuEgHs/KtlJ5Bz2kXGQ6GlDpYREhBw2NyHrmEcutUR+cGWJRg?=
 =?us-ascii?Q?z/bwXoCAEqfVOy0F/Br+1NPNLppCgBdWDS4tZiyV90+3ZZk03a6jLJFhZLJu?=
 =?us-ascii?Q?RRrS4MMcTXy4zOOtwU//G4r+FHiqO7+ER0daZ7PIMzXja3L1ZbDE+0umfywE?=
 =?us-ascii?Q?vKPjFxn89jCfROTLux9wZT1ehQ4nnp5hbRzT3PnUYmh0Q4Jf0ME89ktJtBXD?=
 =?us-ascii?Q?Eh3fjBPvjnTFwnpg0BTh2kL9UF9eeGukMvw3nIKR2VB687hBlCUi4Fy8axMe?=
 =?us-ascii?Q?Uu+KZB3crA/MAjdZrFStuOOJCiF+kbK3EbHqZqDHfrPZTEAvnaalGyD+dopR?=
 =?us-ascii?Q?iRAg2h6li78f02JwzPZnDgLFsgoIP69ziF8Ult5XJcctsKzC476tLAiazY1v?=
 =?us-ascii?Q?MKZOOGt5NoZMjIR143Sv573qMg0Ygz3BPFenLffF5lKXWw+0ROijUuGb8uSt?=
 =?us-ascii?Q?kirzSNcfyE3UqjN6LYKKubM5TpAjk8W+DHZqHifOEgc1vT5zvnVzg9x9hfZT?=
 =?us-ascii?Q?Q4ndtcV8KnEgeKi/3SlOyqq2Mb0Og2ON4Drkz/ZtkRaFDlULV8GkMIBNxolV?=
 =?us-ascii?Q?zuitBNZ4n61q/Y85v8ATcM4P2kxRhzD8rK5q/ZJRUQDsj9ebIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8p5lY9xelwtYBQFwCWxAKv4iM+scXzSEvU3GmCipgX55imM1mSrj90+AerX?=
 =?us-ascii?Q?j2EgyL4PDqPAJkuETSEBAc+VWTNFNUcXjYivmGEwRoAUhBxav92fsMPTPsmP?=
 =?us-ascii?Q?phLUUhaSe3FXtne07VbObhChibkh9cNTqtUfjVjknFa84ZoMM5k+d/A+qfqC?=
 =?us-ascii?Q?g8gTNV26P3dazK5vkq43dsGOSY68WmVtW4tZrcklbczTc6w4EGh1qUdR4JAA?=
 =?us-ascii?Q?t2CUdYHRUtPQcNbvll7VwbwT/nbUcw0BZWK2qF5DHPDIxXZTcyinCed/h+mL?=
 =?us-ascii?Q?06HKdutl958HSB3nO6Ckt+dmAJon5SXuBFUgFgNsglGIGdToTH3LyFD7Rm5F?=
 =?us-ascii?Q?k4qCL0Yu6dtBPSMq4T0papqgOttbzLPwtD1Ysoi+x+JWe0pEkVq1bj/Ii0GD?=
 =?us-ascii?Q?JK/CglFbipvhAhWle+kAJ+ZVKfW7YtOzkd5FjR/c/iYa3kzvwHjc45KeYdRq?=
 =?us-ascii?Q?bXruorltyvYmKR349d8h2iBcbqtGjFh2EgZx2yvRzO+VVJlopY4EyVgJLHQT?=
 =?us-ascii?Q?srwugQgZzAdI7kHl4EIJRIEQ5oW6rF7zXHS3MLzdQZTiJYftN+A9cYiCnzTU?=
 =?us-ascii?Q?65B960A3nfUenbo3Ce6XY4+HjYdFBnguTVBaXjzWtZsb3jlyX6ZrrLi4iKId?=
 =?us-ascii?Q?zGHl1nuyLD4db9WJT5F4RFO1aa0ltOYpDQ6h1YdNRukfNkzSypVpVNpK/SJI?=
 =?us-ascii?Q?DRc0ByKsaV/Z9wlo09IkFjl5oyEpJBtzlhvSrL/jJF03jpvBQK9eZusd173P?=
 =?us-ascii?Q?1nIh8YPE9i9wP9jo58R8GCd68GZ46MiTdPe4rAEe7Sr6hMOLViN/yy1XK+Hp?=
 =?us-ascii?Q?o8NeNzKQXGMpOILs/bPYKMmx5Uzk1zYIa7lm+WtojynvdsezlbRLIC0rKOp0?=
 =?us-ascii?Q?ipEY1YfwPNnSR9bDkdbziKgbGzam3YiU05iOyncRNn2qQEhABOEv+mN0j1H7?=
 =?us-ascii?Q?oKBzQOCdsDHZTi2/5FCADb7y1amhH6hQRPYmWoXrUWWf4beq7CKJ5RNMr0s9?=
 =?us-ascii?Q?zGP6At3494LNDdtFFesHJ6o7VJacPnQUYFEUvCB50zuXR8WifCFRSQaDsFff?=
 =?us-ascii?Q?KYWtN1FM47Rh43L+tv18f8r2gCWgmBBcZ9/ON1vlE+VIerOLRZhhNrDVxsGV?=
 =?us-ascii?Q?CjuY0g5wiEAN15PDKuFyvDV4VQadojxBMf4o9T1tWkg90p5zmhn30DMcX1HO?=
 =?us-ascii?Q?kH8Md3Xx0d/angwFMe29N+eQsdUvyITcYN0oSxZRr9fe8vH0Mr01aJn8Nrnm?=
 =?us-ascii?Q?XiJs4jTmeNw6QW7F6PwOIDRooukP3GlMWimMymNGddE1gCDkmOiKm0nV87cy?=
 =?us-ascii?Q?RrCUGooiUkGO7I4Mc1jGpPOsqDu46baclX9kr0PcHfudnbYMU0RmK6bqSn0M?=
 =?us-ascii?Q?CLqSEE1ZyU5tQSQzTF/1mEh2cfQ5aNsSc1xJ7qGeC37txLstjXZH7iPTclRk?=
 =?us-ascii?Q?guL7H3M7enX7VQtsmMoFTXh0yeK3ouITu6E13WzgInYQUzEU8vEEJwo5NENt?=
 =?us-ascii?Q?+2PtS1/Wb9nAP/igIuXxgsKTsor1o4bcSFfbLQptjxdEiAiuLQyZ+9vfc4K8?=
 =?us-ascii?Q?JQlHu4E0qsHaaEliUqdnqL0p4Dp4ZOiFjAH1usTKiIlLr24ugtq+gm7vrxye?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eq6Ujgu4xfIhkh92pALsYKkafNabVBJb/CQaG9Q96cf4+zxgH7FkFzu1V7FUJWcVTJ8+K9xxZ1XuE0ftp6hmY4N78kgGaiEVOYMCARDtxZ8YV5e4pddgbR46NzRh9C5dlKx5boM6+Q64cRSwRE22g/+WSUX86F2p5bDARzOKdy2PS88N57sUnjkg4amlkyuykskWT9aiekLtjMX5zY/RoU7kPjVOMcZnMvlSF/yjJvQNUcrkpinVLa764n7fl2Wg6lkzW+5xNBrz1Lw7snKWaN4oj5TtiZdbAMu79u89EI8HDGPTPDel/PL54G1Jw4l/5W2afxNqUITv0nMumoo7fC47vvByjeh65ckWHko9LWNzVr2byU7mfYScgmhVBLh2DL4fcPDymUcOZyQf4ZBk4L84PONjLXTyUdU1JzGg2qNGS5uoZO0z4K2TrdH1b81NmcLAFR+Q0asNh5CPz/3WKnsovCJX9EpT0bOOYquVJSGF8sw87LsR0+GFTfmDllZCqA88hSGSXC4eycdPp/g1SODEqasDOgfJOFY2JHBk/QJMbjYuD8qbXTQmygEMKR/dPUPf7s+FE0nVJmr+jecSckGFvsj+mlaMUUgkyQuZMhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58371935-e4c7-47f7-c4ee-08ddb87d4ee8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:57:29.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDksKhQc9vWeCcrWaz2FZTr25LlkqS3P2AHtLk6sSLy5/ayaBuLQ4d7SXLcjguIYjG2156RYcore+AoOtFTfv9uNmbA0h1Tnow9ossMsQyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=881 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010051
X-Proofpoint-ORIG-GUID: mSAgnLZYe7heWpljkH54qLe1jiy7jz-K
X-Proofpoint-GUID: mSAgnLZYe7heWpljkH54qLe1jiy7jz-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MiBTYWx0ZWRfX+K8yXnGueiqP FXO2YdX9mxiO7hM+rKWHInhFOYNiV4c8GJJxAczcnAp0/rlZ7LhOKzU3CQh93whkT4GhJztDhgU JFTTz3KzNqEuthwNqe20+P7JZQIKk1ZsaglMsD1GwbnQMa4/910951SjzvmsElyIbz2WQzFru96
 uWN2cihJxjDSwJPzKa1wqO8b0oe/zJFJnWm9F09J1IDPCqJll9+oBzMiBzmtjHDct9CbJXfCE5V zPJWuR+Mz/XX258LbW6jFOe+c5cQ6rpELw+I7S5so8BwiG7NNo4ySRunly4O7kV9WH9w1zTFxq7 xNHvdUD1E/QKM/WH6mFpYE1Wlg2jMpincFEcbt0TsXiIh98qNoOPF37mL2inG5qIjMl8yO8kHzO
 bQJap4n8Naf1HM01dnCh8JJjlCQai0bxqI9GpClz+XpM9aUuPShbryd3tP0q79xbfGpCjU6F
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6863a2fe cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=UeyzcAoknnwNz_YXJhAA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 01, 2025 at 10:03:57AM +0200, David Hildenbrand wrote:
> > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > index 999b513c7fdff..7f1431f2be98f 100644
> > > --- a/mm/zsmalloc.c
> > > +++ b/mm/zsmalloc.c
> > > @@ -1719,8 +1719,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
> > >   	 * Page is locked so zspage couldn't be destroyed. For detail, look at
> > >   	 * lock_zspage in free_zspage.
> > >   	 */
> > > -	VM_BUG_ON_PAGE(PageIsolated(page), page);
> > > -
> > >   	return true;
> > >   }
> > >
> > > @@ -1739,8 +1737,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > >   	unsigned long old_obj, new_obj;
> > >   	unsigned int obj_idx;
> > >
> > > -	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
> > > -
> > >   	/* The page is locked, so this pointer must remain valid */
> > >   	zspage = get_zspage(zpdesc);
> > >   	pool = zspage->pool;
> > > @@ -1811,7 +1807,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
> > >
> > >   static void zs_page_putback(struct page *page)
> > >   {
> > > -	VM_BUG_ON_PAGE(!PageIsolated(page), page);
> > >   }
> >
> > Can we just drop zs_page_putback from movable_operations() now this is empty?
>
> Common code expects there to be a callback, and I don't want to change that.
> Long-term I assume it will rather indicate a BUG if there is no putback
> handler, not something we want to encourage.
>
> Likely, once we rework that isolated pages cannot get freed here, we'd have
> to handle stuff on the putback path (realize that the page can be freed and
> free it) -- TODO for that is added in #12.

Ack thanks!

