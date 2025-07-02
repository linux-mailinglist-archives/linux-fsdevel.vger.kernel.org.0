Return-Path: <linux-fsdevel+bounces-53632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163DFAF14C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663201BC5956
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311226D4EA;
	Wed,  2 Jul 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UP4B0+tk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hs/4mjrb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD3269D17;
	Wed,  2 Jul 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457527; cv=fail; b=k16OlP1ujgBAF46MzytBCbO9Plwx/qteSwYtXdNhXmTBjTy3v/9OBev0uu5/i72ogZ8TfIGIGEB/YBC+qv4K0w4pmg1hIFHyvWHDWYGJ8iAyUkXUX9vleg3FilzbP2uU7ikDby4P/muokuJSr+EyO7fK3F3hL68Gcld74frRODc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457527; c=relaxed/simple;
	bh=EPm/bCSykppp61Mi2l9GEmdXHz4OdrpGiyruxFtA25c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TfHrybhGtS4DXCFGLb7XSQqyH+dJ3zqm3kLtgaSrQAeGz6ZrQmZVq3cegL3lg1+TQkLO3dWXTeS45oRyvZ3cpEykwyeIml4OfVuTeOUn3+qBRWCzlUJ29ILmyjzG+5qZyQIOY1VClWDERip+JpQotJgq9Bu0fmBWhBwXLHWZPG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UP4B0+tk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hs/4mjrb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BjAk4021594;
	Wed, 2 Jul 2025 11:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/bVOOtHPPJs9mUJ6eZ
	EIhHMUA/ujG9hcW1nkWFHOWe0=; b=UP4B0+tkmfq66oSYA2jLM4hcGQksTWPh8x
	eTPChNCn6ZVm5HDUQfcurF0dNfD6QdvQTclOtDx52gmFgbRGVnPpXaV5EdhywcXU
	liNY3UjAzDdYwL6fKfP/1fSZ5klZZckG+3vLV4UwpfyxvWKSIe3r7vnzNXym/ehq
	SsPgRIggIB/kwb7yNYBSpebyc2AYLEthoHTfdCjlV7pF9zdFqrQzZAlR4jSty5EC
	BC0/1H7GaiQ5wSMGKT7NqtTuISys+gtCS9og6ujZR64Q6WF3GPxtO+na8nduh93Z
	8pg3kdPcZ7+cavE73bSN/cItVycE9CuGYBZEi7u9pc9EGMHfE/bw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7x1qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 11:57:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5629tDMO030342;
	Wed, 2 Jul 2025 11:57:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ub59t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 11:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u82SavNTPdpt3Yw06rj6k8xbawWCXDh/7YS0GpfTIt18TBEW7iYZEZqGsfN3qMfFuGlehyx3CrxcZWaWDd0NLYO+lHsByas7SayJ2/shHu9gA/nBDJgKcL1KQH6swPHYopDxo2gwSwZx21HDP4Qv1vDw3+yvuk+i1RSObvtTBrhVVyVeFtW17UeqoBvQ8433WaEMkYxpz/eB4Z60uDVv3PMBlxqY9EeleM5R1AIWmbNzsx9IQqPfZfX+Rejbxes9NHrIzpJe+RfkxEO637unCVNY8+mItLB2EMR9GrGvwF2TcUopR2YV92IgH4i81qguOxeD8EnRgOzp7BIloHB8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bVOOtHPPJs9mUJ6eZEIhHMUA/ujG9hcW1nkWFHOWe0=;
 b=u8YnlcelBE+fHRBF6/zJBXJgYpFhFc2Ulqwb7Jau9zyVlRkTIlcdYarYtKD3VvfUhacwPYfnklaw7W3z8qoVMh0FMM+uxPyzYBSgURtxgS4CfK6ngVr0n3Nd3gBK6tjZpXFRNcVue+WTyNl0+PcQWapDdaH9oarVtxynO+uQuh+LeKHvYgePLd95QTf6AOaeesuim0zdHOO2QqaAsO0gSquyWuWV/k7UOpDqOTeagqbypbIG7O4Mfx/nvgOOIkIIPXEKzvRH70yPOnNgi2HMIYxb2HKgPeu3EsSGuTs3VvKdUFgqaxsIkDgFWJB7wS72PU40SoQJdbXeBVzXSaKCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bVOOtHPPJs9mUJ6eZEIhHMUA/ujG9hcW1nkWFHOWe0=;
 b=hs/4mjrb1Q597PmG298dHOj8szIC3pxqIcqsKsx4+naE3bhBM8SteCC4ikyKYWAJmMlhefEpcghS6apiKs8iaG5TUjl1NjL0DrsokI+q2QECJm8MILhlQOHlAbnJP81B6vbk14b5iUq40t3GDcCCQkn68gi6NgJnuGGtW8dPChw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 2 Jul
 2025 11:57:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 11:57:16 +0000
Date: Wed, 2 Jul 2025 20:57:03 +0900
From: Harry Yoo <harry.yoo@oracle.com>
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 19/29] mm: stop storing migration_ops in page->mapping
Message-ID: <aGUejyDVKGBFLp1b@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-20-david@redhat.com>
 <aGULHOwAfVItRNr6@hyeyoo>
 <819b61fb-ebb0-4ded-a104-01ab133b6a41@redhat.com>
 <aGUbIB34G7pLWKbX@hyeyoo>
 <edb588a4-41c1-4108-9d86-fa69e1db5237@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb588a4-41c1-4108-9d86-fa69e1db5237@redhat.com>
X-ClientProxiedBy: SEWP216CA0062.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4604a645-7131-41ba-bfb6-08ddb95f96c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPwCuax2q33pEjJLvXIAAAv++4L6S0lJ7zu8Esh790JO9d5oT+OGXczG/6+n?=
 =?us-ascii?Q?CX7oYUqQug8cho3TymqFoqNVjs5qzpT60u8oYknc64L1Qf5AGR88F76Z41g3?=
 =?us-ascii?Q?yStkxyUCeI0vRcXQKupWLzsezrsxFEClEQMIGy3EkQWFhG9+oMJYVsaJcPY5?=
 =?us-ascii?Q?zRsdjlg+jZ8U1vA9okrWhLk35Y3RWiOYXe6j+isT3V4JJbMWpnPtRsUKQ+No?=
 =?us-ascii?Q?bb78wlse1wy7sJAkLt453TTn1Z8ZlzZh6xdOt9rrtSs8Wv9RkoQbgXPQLb/z?=
 =?us-ascii?Q?8iSwKTncA1W9DbMP0EN6X4L0mwP1rgoHQwelay7vYU6zQ86suEWEmVETh1LC?=
 =?us-ascii?Q?ay6U/P2TE2obpPpyniGUrImTcTGnrzeKGCEK803p1REd1MWe4QlLvvqqh1Kc?=
 =?us-ascii?Q?e1Gwo5EOhmF0UoCN+C/2/NsU4z4EgjYAPMR2dyWhDQTUjcj2HWv0XEpSAKTf?=
 =?us-ascii?Q?GLWS9Hwzj5S4zQiqOPt73207s9TSIOhiG4GnKy7/rvRplmD5Af+rMDsBG9+Z?=
 =?us-ascii?Q?or1u/gfDNHyBV252fxNKekJXpiQU+Uwkinr+/XKKqyuFOKSNX8b/LZJz1b4P?=
 =?us-ascii?Q?A29RNKEqFkbtllw5TA7hnRy2Q5bbB8WrXOVgDd4MktxhG+OJT/Fi/LIMY/Sh?=
 =?us-ascii?Q?UByYkK9MvYtElosZYofMnFNSEJdD9GeKou9q5Lg6UqAiAVIwwlrFM+tmkafd?=
 =?us-ascii?Q?TH7iceC1bDudXSUZys3BP713pmsSWBtCCmrdooo4FEVKKzLCywi+Y2ugAm9f?=
 =?us-ascii?Q?+ODIY5tAP8YdE18OB4j307mzEGE4TjS7i/IBVD/ZzRanv7GwPG73U4aANTZ3?=
 =?us-ascii?Q?/iFOnzx9+UoUB3fjLnkbFBogfjtok6oQsIuv2O8ll8XutOeCjQXtBYKz8me3?=
 =?us-ascii?Q?/aGGBZKthRQX38LORQM6HnSgw4MaFjoGBZyp9PsbIfWDq/80mh3tzncz1hb3?=
 =?us-ascii?Q?kOJZCuMsTpOWae0Z+qeWWUzS0Hv9vsHXJnzVnrxYF/33FG2kwkXKmtN65wqZ?=
 =?us-ascii?Q?cnSVor71XiLfbyCC2i27OizP3KV5/EENJK+E7j6AdyMnrrnL9uOJM5I0+ury?=
 =?us-ascii?Q?vUTkV9usLI8DX7mZhptwAA+TB6cas/smYZvGZ4UbJCop0lWyq2+Tl12fBgZj?=
 =?us-ascii?Q?79JYd//WWEbkX+uSZZ89/VbXVkfuZIPE2bSGGOgkVbX6TDD1j9vHnMBXAIKi?=
 =?us-ascii?Q?0eRrLUQyVL6tTqqKvD7+vvHypcFNfFJ2oC6stLsDv6IfUqOPa18xmu/vcf9C?=
 =?us-ascii?Q?lnwSEAzQXZQrhrIUzxxBvDJzKyQ5QshxtP6lrop/zq810g2h4cw1aiZTWw4J?=
 =?us-ascii?Q?ShWcTRm7RCPDsfTcSVekU1ebEJGJL6piOyu++Kxya5QhT+lHwK4cO+GIbcG5?=
 =?us-ascii?Q?ePHn+vMc92KVXDQorlhIKdUTaNN0kRrn2P5a/C3nhxruBQiS9LZqiNpp721S?=
 =?us-ascii?Q?L54GLogt3u8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6yAukfR4jT8u5uvUkECvtD28C9YvBnHRqfIVhzwgGxy86L7nTo9BFpeZMeso?=
 =?us-ascii?Q?8eG40lAocEss4jDX8xj/ffqxMo1LXCkIOOiHhOYw6xLDSiJ6rgSiTSgI463u?=
 =?us-ascii?Q?TxCme3EhsjqfnvDE9qM/mZeKEOnWpDBjzYqNj1ZM4qH0gd86vXb7P4wbqQ6o?=
 =?us-ascii?Q?RrrXPV1m/x5ZFmsxsXFm7DxL6MdWGSocerEirNcukYoc3+tlRjKOL5EVax4r?=
 =?us-ascii?Q?GNSXgsAY0NytkElyh/9nZH7kGUvfeCfWVr/P5jg3+NhnAmvuJ2KZhwX5s/69?=
 =?us-ascii?Q?llANDw6rrQU20g8oVv8ot4ecqk2qRkrzAf+QsqSc6Srl/UnmOupKJ9EcW5jo?=
 =?us-ascii?Q?BCMl/YyphANDLGY9k94lZgB9hZyR9oXaPH2yRyjK8Req4HyxqNGjIrnGJP8h?=
 =?us-ascii?Q?VAFVxHQHebVIvlHDY2h9FqsXm/Ou5OFhC+SCoVwYT9BPI3niFpwtFdtykxyW?=
 =?us-ascii?Q?PycVPLT3aSCt2TBcYoanRfvWZQQXJKYiqi32V5ywY7DOJ6zdxhNRGeaUpu+v?=
 =?us-ascii?Q?5eGJRyouMS7qWxJBGrxlRgvG3p8w738gWkGu+aezCD60VMwwkZqdEUQ9OZMK?=
 =?us-ascii?Q?XDlQCwwlerVgq+9HH+XakITaEp0p3NeCiR8sRUer0QLjm1y4YxCAvvhTtCAL?=
 =?us-ascii?Q?5bvC6el0EPOMV3i8aBgSoREIs06ZV5LIl9P8d4xl5MP3AnkPJloBPHQeoDUG?=
 =?us-ascii?Q?7vSQdp2bB79u7yXExIRP3xG7k0cf3QCsLlgaPGnvHhddPmjJDMjyd2ah9Lvx?=
 =?us-ascii?Q?lazbiVUkHoOsFet3PmtTpOXdSqEsaOeOetBGIqV33rV3LvHoCUy3hPxQ1lLk?=
 =?us-ascii?Q?TrdVxhlTldlaFzt70I+aV9pjqgXJMK82fH5Ueo03bKoyBC9M4UowbOQX1KQU?=
 =?us-ascii?Q?8l5IzivII8dJITlJlN3J6X3BumNDw4yuRLcBd5yupob8WJ7KmbL/CjKA9Wty?=
 =?us-ascii?Q?IO6WfuLYTT4n0qQwu1gqbk+05hJleR1lP6bfNgiiGX7aohJ+BW8sMMt6iUNC?=
 =?us-ascii?Q?ew5SSDpQlI+nw1sfJAcKb+xiRRtma9i6eC7nEtgoTkGLXA6gDsZ7BwgI9x98?=
 =?us-ascii?Q?0O7+5iueRF9tkkGxBu6zBOO8KH+zQ/ktePPCn1mYzmF1lzmXBNaIWj7arRw9?=
 =?us-ascii?Q?Pjkt+6K/rg6vqTpebB0lpOIFhwimS9Fea1osfPsOSdMMWne+k3i3Cd5P9Wr7?=
 =?us-ascii?Q?m3kni3E+0HWiApIWpr4WNMUX2KPVa16554iaY0oY/oNXArnzdOZ5TvU7+mop?=
 =?us-ascii?Q?m9Rcv7rzXb+YMsZ71eeBR00lmM+8zAjuoKfRb4Jfo98Ts+/+Fe3G24Ok3uqF?=
 =?us-ascii?Q?rZVUW/F8qFc/QmIzk0U/uwbOQ2nj1hdUohKqLl0wlgwDTyLjnaKhmfkzC7WI?=
 =?us-ascii?Q?p2JGw8mnmPYG0THB8DVVjBFGkz8KQUuQCT4n3jZQUqKX2xXkdFjlUNzLUgiZ?=
 =?us-ascii?Q?Y52ngoqllCSf+RmFlDp8KMIa0llS6G+EPsMr5RPYMEOA/NOT/hPMWNf+TFTY?=
 =?us-ascii?Q?NOXrfniDgx7y0QBWuoFYrJ2yLpJUNIoGBCsyJimquYn1t2cjSi0GvxC1V3Cn?=
 =?us-ascii?Q?5Bad4AYjClW5sdYsZWBtxcDNmQ4RVcpWCs3Mk0JM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eTmIbqyyk5w9XvR6gC9dXJVDGT+cekmEv1UqMaNDJQZGn8zpxqPmecKwoHds1zP8/Duhw7FnZOFd17SvR1WUnmTMKtuHzKBJ1ysI0Yxs5Ev1OrgrlGPly0PzEaBxAkk/yFkKX3xiULF6SiL37qo2ryZpDaFP4Xtgi+R2tb3O9RfX2d1htDD8YrqKHXe50aF2j85shnVBpO9x8wGJKU/QLm26lFRmHH7jvzrSwQNKshb18yitRLidFFZNJhkkTga8lQdXilIgtmz0vihuVWYWVgiJxS1Hgx79U4DoTV24vx2rRC98dChOR4U9WiwBo80pfbZrCAJSVEtqJYI2WMmoGsr7iaBN58hsJ/rwnvbTyvXheU86pfDri7WisGw6tYg0eJjxU9bkLZdC7bjm4nFCtZzk9wGnO3yr6h7AeAY96U2jNh+VgRCnMqW93nIYnRMdU7xxC1rOA5el1AxV5LFLloB3bQyBk9QjvdhzO7gEKlmegHjGQF92b6kD6D4E1y+WkIhurQt8F1EHz9DcL0D3ewzuMIbcgJ/Bb7y+meDsp6E2K5+Im4C+LRdb17TdbkkPhH20dVSu50AHY5XrLFfeuzHtwut0lVYnUN/0BHNaWQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4604a645-7131-41ba-bfb6-08ddb95f96c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 11:57:16.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYAzg/lF5g58akbp/VucO4/UV6SkQG3W09B6rm7pUNcfNpmBFLvH0JBiXgCoknf08rv4Pfr6o8tu827nj/Ix5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5NyBTYWx0ZWRfX9A4I6mHpoiaA U2emza/08a+MXY4WYIPmxNPjKWFDaEhuja0M8ZRh6UUAn1tjt4cNy5vIl1d9stuprWbdH1ZHXl8 wOU5z9pNSMj9L8r02YGZVdcSGqtVFGz6yV8E8PfqPrhJ698mDRU5q70ke7oPYsQq08Svl31HuSK
 7x1ZqdwOAxTVkFtVDpiDo/ho5sht9LKrE7HKfqaV8MlIxFa7s+Ud0qvOGN/cu4y2pF3jMsvpd5+ weK19T+/YyO61cQKq1M1GY1mWhzTWBbb7Yip0+9khaZ2xD2hM3gi8xU2FnGyTJCkaOPwfIPtEWy dLmP7aDfCt22Iix90u8Qq1bEEgLJhal3E//xaA6cwoOndsyetnDL5ZDSYO+nHrUCWNE4uUIhOaq
 ylk33WjPKVykk1RwRxotIN3U+lNoIMA6J3tkJb1Aq9Q+Elb+BfwfObai1D9GwqHX1h5KuwHq
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68651ea1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=qijfBcOE5NdOuzqw85cA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723
X-Proofpoint-ORIG-GUID: 70aEA4Lfcb19cXT-MDWHB59-mKqDsk1S
X-Proofpoint-GUID: 70aEA4Lfcb19cXT-MDWHB59-mKqDsk1S

On Wed, Jul 02, 2025 at 01:51:52PM +0200, David Hildenbrand wrote:
> On 02.07.25 13:43, Harry Yoo wrote:
> > On Wed, Jul 02, 2025 at 01:04:05PM +0200, David Hildenbrand wrote:
> > > On 02.07.25 12:34, Harry Yoo wrote:
> > > > On Mon, Jun 30, 2025 at 03:00:00PM +0200, David Hildenbrand wrote:
> > > > > ... instead, look them up statically based on the page type. Maybe in the
> > > > > future we want a registration interface? At least for now, it can be
> > > > > easily handled using the two page types that actually support page
> > > > > migration.
> > > > > 
> > > > > The remaining usage of page->mapping is to flag such pages as actually
> > > > > being movable (having movable_ops), which we will change next.
> > > > > 
> > > > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > > > ---
> > > > 
> > > > > +static const struct movable_operations *page_movable_ops(struct page *page)
> > > > > +{
> > > > > +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> > > > > +
> > > > > +	/*
> > > > > +	 * If we enable page migration for a page of a certain type by marking
> > > > > +	 * it as movable, the page type must be sticky until the page gets freed
> > > > > +	 * back to the buddy.
> > > > > +	 */
> > > > > +#ifdef CONFIG_BALLOON_COMPACTION
> > > > > +	if (PageOffline(page))
> > > > > +		/* Only balloon compaction sets PageOffline pages movable. */
> > > > > +		return &balloon_mops;
> > > > > +#endif /* CONFIG_BALLOON_COMPACTION */
> > > > > +#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
> > > > > +	if (PageZsmalloc(page))
> > > > > +		return &zsmalloc_mops;
> > > > > +#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */
> > > > 
> > > > What happens if:
> > > >     CONFIG_ZSMALLOC=y
> > > >     CONFIG_TRANSPARENT_HUGEPAGE=n
> > > >     CONFIG_COMPACTION=n
> > > >     CONFIG_MIGRATION=y
> > > 
> > > Pages are never allocated from ZONE_MOVABLE/CMA and
> > 
> > I don't understand how that's true, neither zram nor zsmalloc clears
> > __GFP_MOVABLE when CONFIG_COMPACTION=n?
> > 
> > ...Or perhaps I'm still missing some pieces ;)
> 
> You might have found a bug in zsmalloc then :) Without support for compaction, we
> must clear __GFP_MOVABLE in alloc_zpdesc() I assume.
> 
> Do you have the capacity to look into that and send a fix if really broken?

I'll add that to somehwere in my TODO list :)

1) confirming if it's really broken and
2) fixing it if so.
 
> In balloon compaction code we properly handle that.

-- 
Cheers,
Harry / Hyeonggon

