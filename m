Return-Path: <linux-fsdevel+bounces-53420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26110AEEECF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387251893806
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF72594AA;
	Tue,  1 Jul 2025 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kbT74BLq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MkZCuDt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D12190477;
	Tue,  1 Jul 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351595; cv=fail; b=P/8GJleZq7ImZJ2Yn4lPMQuMU9/YhEyQLnUKh/DVQVmvU1hqEYHfg5TWIu19raWGnainO3unI94nyF5xD2finVI4WykfOjqo1gfjKNgIFaA6cJ2WXuIfTuvhW3uGBFwHjBd6h1agf0HJXHMx+cVZPe7OevZ48PbpFozV15FprUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351595; c=relaxed/simple;
	bh=FMUAyXbhZhYTS0yQTvCl4mx3vdjnym28HF8TAt32KSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnML6kSRD99oTYce7zsBI9VDDmx8URz0tzOjnGYQ0aFuJQclIVxSGf3CQ5x0OpQE6Qgn25aDFF4aFI+k5RbksrTNjUge6ftfuM/vPASeVskUf7V2Ro3nW9P0MPNyE74nr7OldBo2zyEvbYlfFz/y+obYHjImb19bzkYypwSA6xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kbT74BLq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MkZCuDt6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Nxvs006430;
	Tue, 1 Jul 2025 06:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pYENt+oy8gSkdDp6gf
	dRvbIHoP9MdPJHD/FzrkK+MZk=; b=kbT74BLqR5hnBiT1astVxAN+9bGbfEvpYK
	E0TZsIOmwDcdrAuHISKe1B5wZUy+uroGmHlqqGWEwr7Ut53XaU1l6i9TVKMsw1Rr
	mknZX5yRXWyaGoquLbGCVNbxiI+HI3Dv9NVPZM6NN5YwdL7ENZSWmk6NpBimkgdp
	15YYB8pJ2Sb7q04Q780X83fACFwCKLIS7c8L8Iiptszc3dA/7DbdAjTjQlXJ/mqk
	UPOVIwOe1SWy6C85bnjwWWN/bIDzDIUz66nlTlLjvrThmtSKKPAhgpanzNcyP07T
	g7w6plHcSoeyy2w7leeqyPVCzXFHrBJ3O5NbF6y0k6ohvNvYYb8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704c0st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 06:31:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5614l1BX009039;
	Tue, 1 Jul 2025 06:31:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9bnbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 06:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OohLBjZGR7VBO49kMSlVL9cECwgSrJe70Qz3caP4RPmmJsTEl3eNjU25RQWAD1xSBfgN4g77ljpmRN2tGU3/XUlboDHeIfn5mDu6ozE5pL4bxZncVxm/g1vYKmOg92N/V/HEZ8FG6nXChya7I+yD1gFqr2Iipi2cXCZPM/3WyVB+4WJriuVtaCM/82LXWOB0Lj375eH7u1sCJ5+fQn5wI+werGY53BeygTbtUz109OR3ohm1EYlwV2ct/KW2gs8sjCJ/pyJM1qz1dlp1Lk/yFYnsag2yw9I3MxYX92ejbCOhLadWTPunqEMWCASttJvWfiQ+2cOSTrlgrkt/LDyTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYENt+oy8gSkdDp6gfdRvbIHoP9MdPJHD/FzrkK+MZk=;
 b=T9ZbuaGdEdxbi8H7nkoP313Uzbh1p6Z8HC1ZynsxDO36IGKqWOqwgJhVA0mnl879yScTCxX7IeaT5ZxpFouxnA7CD/NxzRTRagN3NWF3U0oX/CdyUjThjC/Cxc9vnJXhMv6oCUuEdYeDWkMa0veObhg0DnbhanTRh7VVfwgoCgMNHFRPH03JmtkduZVD/jsFSuBZpI4fZ84mmIbgZJZWvx01RfIvcDm6yngjFZQM/FAIRFDKO+WvDIG/0u0sdg5QXAdVp7t36fE2TFGYMcJYyJDqySvme9G5h3f84iovuZXUUdWOKn4t7hPeAT0KZfj0zFRMmPvD1NMasUqJMsnVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYENt+oy8gSkdDp6gfdRvbIHoP9MdPJHD/FzrkK+MZk=;
 b=MkZCuDt6lLLils4O1DciRUbervFlX0mHQHq93vK+8DJ9P7TTIvzwdKOZ86ayupwTmqXS0H+pLzoosxTojoqDahsZiaFcBNGWJECuI0nzj2d7DU/h60ja/990sgkTXLLxN7FVi0T4b6r9VVHJtH/r+jy5qLdOf6S6nnton59Thgk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7231.namprd10.prod.outlook.com (2603:10b6:208:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 06:31:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 06:31:35 +0000
Date: Tue, 1 Jul 2025 15:31:15 +0900
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
Subject: Re: [PATCH v1 10/29] mm/migrate: remove folio_test_movable() and
 folio_movable_ops()
Message-ID: <aGOAs1dM7TdS1yXM@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-11-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-11-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0074.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::7)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd25442-85a9-445f-7c44-08ddb868ecc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsJVVJmqoOXJQD6Zx+HMmbTuiMnIS2lxX/vboGd29j7FLWhdwu8D2QxTNJE1?=
 =?us-ascii?Q?jdYRqCOzZ2m73tTkvGF8AmkJhLjNKLXW4/dIsXyQEg2gtIrpcqT3r+kMnRuU?=
 =?us-ascii?Q?lZbdFj3BK0SYA/kS+K3Tdv2SSPb584GaZC515WV1KyLZv6eUAqcpXHhx3ycB?=
 =?us-ascii?Q?+8kJr7nvZApXDtx+BfzWQc35rT/S/i8w2pruB3XRyDbpMoYTXe0dNFf2W8XD?=
 =?us-ascii?Q?NKQWdOt6zqrhc2J1VrQlRQ42KVZgdqHtC627KqMJbC/vTxKNkzKSj/c9EfWQ?=
 =?us-ascii?Q?PuXJN3WJuy1zntQNsfQpxLJjJuw9byZLWAEIVAD65k2tRrTLI8mlHUuG6z0y?=
 =?us-ascii?Q?RJk4MJLeAkR+HZxbdh1kKP2wH7KX+dlpWEgD0KMgQc8VzgCavjuLqCc96Bou?=
 =?us-ascii?Q?6+AM0QyCV8w67Lk/ooap4+39IFeIq2EiFgUegsbZcNgaIBqKnsPBsI9ZWmvX?=
 =?us-ascii?Q?qT1SLfKcLwHjVgrFD68wd0M5NXf9OQ62ONCaFDnr8BJNeGzjzb795ucAnO3f?=
 =?us-ascii?Q?sMNYU88b9qWPeVeOBYsRiZD+SU+SAfpXPskK0B6BCviUtRysZSewOCEb3s7A?=
 =?us-ascii?Q?5dePXiNerTCwpqSHmSukQenEbfZqmT93Mrt7DD+0kK0LgnL5bHK4afhMAeyH?=
 =?us-ascii?Q?J/7Y1p7XhtHlfQBbax26BW7L/lZj4vNfOu4h4+fJgofPU5ervIKV0XaKAcFL?=
 =?us-ascii?Q?ixI+ynBwzL+LLiZKTW4mkKk8nqbKLQAaFG3oEnR4nhmRFv4GGPwPU40HtE2R?=
 =?us-ascii?Q?b5YCozSH4+O6u9kkF4wM7udt6sbOCvvnQJdNxY40Wgqu3QEKjl4cjvmiH5mw?=
 =?us-ascii?Q?GrsYBxtdPsyY8gM6n5b8/QrcvYEgI8VrXFWyj4jY3FxhlHbDu8lnr0QIa5Cq?=
 =?us-ascii?Q?Yc5Sdfmhr42kieEv2W5UDM1FNDQx4qQ0eOUaR+x5D4itgRB0i0Xu5lwFCw0u?=
 =?us-ascii?Q?649fsz48dgm5srkoKbTpjKKukzHOHB9y8q9hRqAJymn4KoFAsdVvnNMx3XGX?=
 =?us-ascii?Q?jnQtU3IUeoDX4BvN8beVEOlwKeXMZxdJcIPu2fKT7IPK9Ljc7vm/53kngbId?=
 =?us-ascii?Q?a4SBUmUfnz0k9r76sNgb6uqTcZS1wVX5yIZoI044f1nteAPGzWme67m0bKhu?=
 =?us-ascii?Q?il/5GpdWjUMBkYVbsv73plV9P3ktzkhEwi+L27YT7s4obN2e0ccoDKOi1SyN?=
 =?us-ascii?Q?hPS1ALpd/pCaDzBVomNDlp8UocRz4BlLqPyL7BoflQnEdEDqX4kXcjUYFr16?=
 =?us-ascii?Q?aVA6G9+BCej8xlnHV6MMjKkeZ/eSnQiDVSm8AhNGnW4OHlygjL0EATYfSogW?=
 =?us-ascii?Q?9s1yhTiqsiYdwdPQ57Gp2fx5omH0PxVfpohGRG/EydxX0dgBMWf9G4jOIVZ0?=
 =?us-ascii?Q?LiXHHQhs476gkg88m4mCk22Ja6gWUayYc/DrCaJAQ9BNDmooXJW4lEzDQy3X?=
 =?us-ascii?Q?DioHQ7VlE/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tL65EIdeGZ9gFRCc1gUYcjLDmybclSYIxC6+h66XY88PVzW41oh/rJilfTHL?=
 =?us-ascii?Q?pynSwwhajFFr3fuMHsq9FomyKAzYQVNtrhwa/KFbWirX1sEOnaIXagM7opO5?=
 =?us-ascii?Q?SDD4gI/9wYBpqVhgxG76r/0gBE0ibVkmoDTC57tW4BRAXErLZPG/HE3Ovq4A?=
 =?us-ascii?Q?QnFexgP1oVPeEWtRfOR8i4aJP76kf065tj2ds5noH5cFXTW5h70wYcNwNVCC?=
 =?us-ascii?Q?VThOvI9iF2q7YAJEkzsy35eqRPttsFuM+kWaK0u7CRVeQ1NeHnmVB3EmyNHs?=
 =?us-ascii?Q?iv7Rpo3RbTYqQ2YMsgI5ueCjvjingv0agyAi4PJQ/BngpyVVOLav+iQkV94g?=
 =?us-ascii?Q?cAUaJBVwwjee1U8yyEghygSV/Fcp37Zh87jgkTq7wwW1efDkeruWB0FUc741?=
 =?us-ascii?Q?tHt+f0hwJnWiszzit610dqQcC/rTeAhH9SjamF8VrFWXjwsUwXf+PNEZPAk5?=
 =?us-ascii?Q?6EXp02J32Pb3sUbJHFArQp/1iiChFl+DpiIgZJ7nWYeG/4tVBCFSCz8HBWI0?=
 =?us-ascii?Q?gCleGxnPLAg4ugTG9jFT1/yjOenXNDIsMhwVR3Lx6OS25zbfLfO3k8J3eAYu?=
 =?us-ascii?Q?y3AcID35hBIlJ7OCHeuicVYO0iqNxaamok7JoC4UytOVexe5nFkNdr9ndSTQ?=
 =?us-ascii?Q?AFAZ7AfR6S+XLy/ny9AfkVxjJjCxrQUqyRC1eBx4Kf/68XUZ4ePQji/LOAKr?=
 =?us-ascii?Q?ivO2ZTPDzprWaGp2FUHfHFBlGru7y96QAfXpan76MpqjfV4h0Jme4sxocuqI?=
 =?us-ascii?Q?hFG0Ju71H7dPwdVX9ST4VKOOb35FZ/pc4hiX7dnEEDtbmrs29vOFyTTNFuNO?=
 =?us-ascii?Q?Yqs7yM9ocHU360XUF5NekSNZcfaXdV/opXK0vCbWbBUBqFnegkvnTAVvGiw2?=
 =?us-ascii?Q?8IlSijUiQ3kRJvUIqve9rLBOZFvkqeD3qUD4SQGj+DoCt7aikSE9UDnb7V2D?=
 =?us-ascii?Q?JlJEbQCLLFN1rYmUXZpBTpGpXn0569PF705lSlRMTdmsCOxgqn04gjowLnkP?=
 =?us-ascii?Q?m7mxcsARxcQHCan5mECipcBgpY/EDH39UmTiofPL0EVYB94gH/exjAx02ZdE?=
 =?us-ascii?Q?EdGQvAvEpGxv+cuyJ+wzAU1TdrXzGnkBOQiz5sNcsRk1pY+E2d/D0tBHfnEO?=
 =?us-ascii?Q?jvggVJgK9CxIRuztm5Z9NBsBm+xO2iDvemPS23zSULt8hmy69woLllX1e6zA?=
 =?us-ascii?Q?F8ffPAvXtuvtsMDhBz4AoAsDYsnNHqK7jxFnuXbRKN8gyNThydedwMkkTLqd?=
 =?us-ascii?Q?wNeBMH3795/C/1VERqBTKjSqL2TLbU0jG03oo4fPwH9FmlGOLwylKcVHRjhE?=
 =?us-ascii?Q?ApxUaaokfZjfU0X4dPr+mJeEMu+G044grW9QcJYly9isfeH3/bkdyh7i6yOS?=
 =?us-ascii?Q?aAIe1FXBWNpRh8uRmCwiXYB2E8GV4sVEgA9oxo/D6bWJmrTwhsd1e8aLuIY9?=
 =?us-ascii?Q?BeIvn635/p4T14oBzRb+iSxLzIeFAjeKjaI09Bt7XxUbUto3BtB0waWx9F5B?=
 =?us-ascii?Q?UC2DwYup5VtGXHRqf9JePkn7r+hIhllkV3oSE2Nd7GbYp1Px/n3e/TZPyh8E?=
 =?us-ascii?Q?MZ0iuinWJ4bjyZlCwhZi31XRNgpfyyQm1i2UcE2l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XAXhNkTFVjlVkummc2SFKI6zoku+Tj7Ws1q3dhGr5JiMTe+PoR1tZ6ceTTjmCKfz3mlahfYDyhI+nCSoEnxjA2zKk6hlyICVzDOSTUG4iP7PeSrsQROuupZTJJw0jn2jdpZytDDcSTMmmNrGjqckDpkvT16428XgIlvWXJZXSL0n4V1He0YWF6Ua/40nCCrtxqQ5HINuRqy2dX3lBB/JWdG45p2Ip09TfUy5bDgSDBaeuGi7GIL+m8NjSJjBxUB13ZQxZKOBv5+j4C90JYqnOKXs5q0niNYVspFf3s+IAMi0zLkbUf8aKKVeMC1hco26YNZNuzhOkSjfe2wBhfPIWl1o2xPLu63UPaYW/fwDJK/uwnxxPtRG6eQBdvndKygSTIMbGL1VLqTBacuT10yuwLm8ITji8MoY4I+S5HUS+b72DgHeL8U/bUA6MgDvawO0bWawCo9J6KR4ta+quse/jvk1aUhjqz+cYgE1wKZQetpuEilseZWbbw08KIVa5YrSKCMG4Ikx9+SPrlOliZv22rHT3csnY+ijB4Gb7oEUYUWqjnqwqQSLWBHCh5sUxhdIrS9yKJg7dhMy3BS7ziacA2TWhuCCD4meTsr2UnD2CN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd25442-85a9-445f-7c44-08ddb868ecc9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:31:34.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HoM1AOpCFYD0dajPdtP2ChUpSSR92A0cCyUgPnazamJRko5wxF1hnFlD1GYfKOfgVxCFqqpcQgYkiK+6dKFnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzMyBTYWx0ZWRfX7PKlP+w4szZG 17nImCoBA8Hw2muaDW2YeQz3o8fEnkMNBlqvQVS1P9aorhxVBKeZTZ9NKEs6vfPzu23fopOk5aI O3dkMWj5eyrzVvEXcnJBxZ7VOcj9qaOxyjS9sWrESfF5mprEQjMPhcoA0iCja6q/UMe/0vZ5+Qk
 xW08hsQC3SXpHlMmM8xrM2yt35lB3QqrsU9cT9SckTqSvtO2eZnMyaKGQsrLnLD91vLKYc9PnVd aA8BVd8OZPAIGeb6qOczioYJNKDP+dm2nrgdBtxLCXbg4XxtUoICOk2n2/Nzo/njbTh6zyQtjS4 7Dm78/ojUY5TWsLxybePHtlg0VPSmylK2/enfG09aatn85jMos3TnMRuM8nAidFcCj33klkZtC1
 oEfGNN1dA4lNmrQVfoBAda/guWmfmn6qDZsEX78mQjA5Bk1UXGz2/ik/S3RxAtpU+kuk97uQ
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=686380cb b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=vyfK6gt1ynGGz4I6LKsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723
X-Proofpoint-GUID: Dd8g7jPzQicRzxYZvnR_G5NE1tNtpZa5
X-Proofpoint-ORIG-GUID: Dd8g7jPzQicRzxYZvnR_G5NE1tNtpZa5

On Mon, Jun 30, 2025 at 02:59:51PM +0200, David Hildenbrand wrote:
> Folios will have nothing to do with movable_ops page migration. These
> functions are now unused, so let's remove them.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

