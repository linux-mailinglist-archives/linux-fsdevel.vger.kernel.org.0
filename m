Return-Path: <linux-fsdevel+bounces-53628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D995DAF1459
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1ED1C2290D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240392673B0;
	Wed,  2 Jul 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pDLCKQ5u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RQxVCE3M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4826562A;
	Wed,  2 Jul 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456710; cv=fail; b=bguCd3yRuFwkOdKyk/uOY+0M1gA+UVjQzQAqd/IF5CmXSSnow3+TixAo0Wcp+/buku6EHInWDpabNmId4HZUwl5VUgrOAv2Z/GbFVRUkD3D0eNXa6xxHaKrd7AvVayHM21sj9irMYMUosZvrrEscR6e6sCtSWYyrfzZxyn9sKaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456710; c=relaxed/simple;
	bh=a/72zccoYgGDJdjPQUhXn2tYCL3K8dQY8WBjiH7GSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=udQU47uh+hYpl0o1u656z0hfBrcPvVTACEFesLtgyGmp557YSmJXtN8XMayk7mKcjQCmLBNPQQ+bEyxFqbBEgL5kVm7kh3akK3sUfW0t9g4qpyPm4q5G/Wq/mgkWAAmivO8yp7HBk1fumoJjm9AXDDj+gYssT6TIVVa3qyb2y/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pDLCKQ5u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RQxVCE3M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MeZN021797;
	Wed, 2 Jul 2025 11:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xpVGnI1cn5NTq7zOYk
	2QId3NYMtBz0oXD55l5FuhgXc=; b=pDLCKQ5uCnBKkTDldWpVKg6qvi+zgJzak3
	pNZnh3yv4W60VUmiUbpVhb6B9yFUWmk15oyAaW6NoH5sputIrhYS5cSePvVISG6d
	vIlFAQ2iwfagqpnL4GtsCh4P5aCmRpqqYhofnB76YhVJFkXzSxBy2kArHkGIBO+6
	vOZrek30BVfZclHkaCWyDjbvnCkg60677lCZERbFSXxmSCheGk+S33YyX/1+/kkm
	he8NTsc0qVc5LeYQppWcFfTiRPNUhCEHbqbksTOvi1mO66RRwFyKtW2JV4EiCybO
	wSjP4WnUmw20KiQCwo2O+yIFONAro3MlacsAGdVCqobv3HbkbYFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704esmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 11:43:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562A9Ptm025044;
	Wed, 2 Jul 2025 11:43:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ujbut0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 11:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPZe6xk80Kj7zMijnXVdYxvmUzjfKtFHlU1Evx1jBYrtWvFQWdZKvxeSHu5Pv7IRmk31vOGGfrMSNEJiARfD70Xy1T1VKmKNEyMqoldW7JjSStHKzmtsl5VvnIrwQqbNf6AZPsAXis/6Rdu/XkWbXx4y11zRhXJ7gXxy6b+MD++P2FTpDwyGRCDVy58lGtNwtRusa8Xt//5mpN19misX8ZrIa+PY1JZmR0plyuy4zAF+ttlCTr6lcDsLBong5Amb11nS7pLe3ZzVMxYJDtuJow54HjjRl6JcAK7sNhUPqs9hM+Jf/uA8TN9rZhO0/G1w28402F4kqZvmdexY6fARxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpVGnI1cn5NTq7zOYk2QId3NYMtBz0oXD55l5FuhgXc=;
 b=cPEEEJFBqLYpvdZWuUurFIvSM19dKp2dQuaxhy83NfI7/EKUBp4QcQNEzpINDgHbBdTYVsOv23YF7ZKmRSZ9yqfyDgcMUrijOGaon2Dy3WMJKWPHSPc/s7xO8gsqes+K3dtHpvRnFWQU+G3uFrVEFouEAnkFKbUeNBu9QoEKNDH3MFhOJu+QPA4TtAnFjRUAnJFxeWz/Mz5NsdN70R5CFytaZCPfGKOyoOFLGZSwRix8q6kDHfYvsbbkzmoU2+vmmIltbMQ+Rn8ZTbhh6kgIBib4bdryxzeH5NJE3Z51vmCF+uk2ZO3iVlwC+9B3Xn0LuKW2HscYW3yEuK1zUrTGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpVGnI1cn5NTq7zOYk2QId3NYMtBz0oXD55l5FuhgXc=;
 b=RQxVCE3M9TZxgHs5D8ELGSqeEo6Ha/VSSBPsRdxOU8jLl+b06lkhSrsFHEOwwY6sXCIiwxjTwcEvJJbsLqHZr8cJNw05nLJCON9f7pbJsmOU04buBpLzFo9GFjd2bxkqPqikefYrB1Lr9mH9QBiPgxt04PT7o5hi2B5SPczEzN4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV8PR10MB7968.namprd10.prod.outlook.com (2603:10b6:408:200::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 2 Jul
 2025 11:43:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 11:43:29 +0000
Date: Wed, 2 Jul 2025 20:43:11 +0900
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
Message-ID: <aGUbIB34G7pLWKbX@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-20-david@redhat.com>
 <aGULHOwAfVItRNr6@hyeyoo>
 <819b61fb-ebb0-4ded-a104-01ab133b6a41@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <819b61fb-ebb0-4ded-a104-01ab133b6a41@redhat.com>
X-ClientProxiedBy: SE2P216CA0189.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV8PR10MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 2345c685-3298-43ae-93ed-08ddb95daa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/q02dWw3LeVssfSJsnnDWbNv2fFbVgTAoabYIH52Ao2oQZ/ZbzRpFKdgPUr4?=
 =?us-ascii?Q?QB4KlTP8nxJVPBrJ/A/Y3YMqHa7fjZCQXea8FjSwQ3VKfduOtzRoOHEw/XoE?=
 =?us-ascii?Q?qGR34DiE6g4y38+qTegEcr7W5aFTssXga3BotqqhwMdJ0IlvB/sNEPX0FcU0?=
 =?us-ascii?Q?2LNEykPPBYDth0LPGK22HvjrkL34VXMvW6+uhwhFwnayru3qKsGAToCh0e5J?=
 =?us-ascii?Q?/36upaOiGFDOsABa8r74ujautHIiNXf3u0cVmWT2nnVUujL9U07nu1IV9F1O?=
 =?us-ascii?Q?rOR73c6rkJXqbjoizjkbFgtIHBz0LuystUU/enPho5OiJr1sfhzr182qz5d2?=
 =?us-ascii?Q?s99sNArqfjY4gC5BjwbgS+eZdYwRMv53ULMuSqVB0CGQVU4phJDW8DESzHll?=
 =?us-ascii?Q?y31Hnd3m2A0Bc750c1T/2KcJ+o3IjDXWePueFDXH623yJ4CZcCdLNoLZHwSz?=
 =?us-ascii?Q?Ld1TA0t0mkzsV0uPwVMZoXAXRTGzJT7lkQn0NRe+SaYIigmUdncBmU9p8tB/?=
 =?us-ascii?Q?+hqBlbpUhBrVfexhgnq1pW9XHFgRsIOSyWaqzhAfUnv0oYl/oJt33qIsQ84g?=
 =?us-ascii?Q?U2ZbRLAfDP2/lx3Wt9Au8Ei2BsAPDKWVwqvX2nsvO+DvaqGJVTyadmbuScYU?=
 =?us-ascii?Q?wPjj/Op/ztPXTxP2hMXNN3EMsw5khh2EDqdUi8tbqMtd6tjsAuE4zn9uGHqT?=
 =?us-ascii?Q?+rZX/bCabcx2IS1gb7JioQHKJMXU2CIAWO5P33/Z5/VVNnxDlaQApt8VCVav?=
 =?us-ascii?Q?iD/qCuRJZil+VkGIELkgyHToSmM7PBeJRAzGqo8YwtndiUIV9c8FM4Cxsl0Z?=
 =?us-ascii?Q?N7/y5Jj48lNdtUZImyH1ME7JXh7NkWonCOi9YyU1TVIVCO6qlIaDMYUeKOLN?=
 =?us-ascii?Q?mviQTZ5lAhdNTgVl/4lLUfRHyRAH3RE/oVwYJVqt2h+y9yTXYWXuHX8P8KjZ?=
 =?us-ascii?Q?BB3V237V0Y9hWhocLJ3uodvgI9V7n44cMFgzdfE4rn/q5+Ioex0wKWOVio8e?=
 =?us-ascii?Q?i+SyUyz7ts8XAmGjqmaXSLdJvbBMZmfk2LDwiX91StwxB+BXwq/MlSazoiaK?=
 =?us-ascii?Q?XCQFGC1+PjKYYp8aQdZ0MNjE8YA5gMnK0kRamQ9U/GYHXUZydGC0B2GxwBje?=
 =?us-ascii?Q?245pSVh8YJoXaa6d6MyyqNir/TjtT/V+o5zJB9eVHG80KPPOwEy0X2HaqMrs?=
 =?us-ascii?Q?71B2F2QXm3n5leeQT0pKgUx4eoXSmRuqhEDEpsvr8Hh/EAxj9jUuIRB6bFob?=
 =?us-ascii?Q?RUqSXlb48kDCwEayO8kNAJcFVkxp70o51AHUe/DOm1jIqnETeJwTGdP08M1Q?=
 =?us-ascii?Q?mbBEw3NOMBDOTOgl27ot8icSICJVTK25ssDXk4GQrlJMSsa5LPSBgwH4LNOQ?=
 =?us-ascii?Q?T2lBXlqScOUTCoiscO/fJjTFhoK+brB8NOO5vt86utCmC708eG2M4M0s+2g1?=
 =?us-ascii?Q?H5NTS1cG87c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Kv5ZJtTgwa1ELJ0DB/pFCDmQM2gPLeF4AveSSIINGVJh4jI87+IGurYquRD?=
 =?us-ascii?Q?ZRh3B1joH9/6geeSe7GSJLCarww5UUJ8B/gTsQYkgvPieB+nTPrzGP113Ooa?=
 =?us-ascii?Q?KR+9gGrEGXRrJ2CoC9hH0bbXGGIIHXkBaNQOGx0ahk1Xeb3zEYecYesWJkgc?=
 =?us-ascii?Q?Os2twnxw15BDE8IAgsb1u+GHDuu78I5ocN7jtqAq4BjrKRtWj3/HZF93pMqB?=
 =?us-ascii?Q?bhbHvkGZd4yk+tseHMXOvoRTXxQ3V+nTRiLMyKeL7rqoo13+4syBUdFntglP?=
 =?us-ascii?Q?7ywDDAvjkJyN3iGTodlC9gbztfJSpMOSYiOgbvr1VO7NL13LsXkDz7PCmaSq?=
 =?us-ascii?Q?Zzs681u5dD7bPgiJ3hWThH+jidU98AERiU8pXYQnFD5lTufYIi6OMP5O+dD0?=
 =?us-ascii?Q?cAagvTeIVC01a966VU0C9w4Gt84DeM3vaBEnHWazea/fItB6mnUMwGVtbLRe?=
 =?us-ascii?Q?kHO3f1pdOo5cLpkXb1KRu3D6KdEcjG7domJYusV9Ixfify4Vz39xUOC4p1ns?=
 =?us-ascii?Q?mNB+wj+/3tNwiE/Tqk6OY75m6IspSboueUbjLlM4nVHZrXiI+szvzu+JL6NR?=
 =?us-ascii?Q?XqybaAKhPyXfS+6SnhTfOy7enut+ZWt9FRmbIBXapcni2QO6fB5F/iguWqo4?=
 =?us-ascii?Q?YjTTIPQOCjwq7Te9SipHxo3q4ELsT3SLU+kQF/WG9U+q2gFbnwLCatlgzChW?=
 =?us-ascii?Q?zlQkU7UNZgk3ZQCj4YrC6t7ppsd+HeXyBfO+hOrJLtJkJ9hmQ20hoBjaHISA?=
 =?us-ascii?Q?Ebt2SDo+Nr/We3CXYm3quCLPAXVnnafRSLllpaXWxgPpzwgcqMtArOOB3fds?=
 =?us-ascii?Q?wedsdVAwrvrd4QeKjzXJcxdGKs00T0ZlBqOdEMjDKw0JfeLnBZ74+nGaQy8E?=
 =?us-ascii?Q?dOTUIyaFPvmHZSUi6fR/8krlRcuc3ubvP4nVStUF5Sht27spr5LkOG+ZUsxJ?=
 =?us-ascii?Q?z68wwYn6wntnQmcpDvrNgKtNtC3s9Xo+Qle5vTTumzRTgvdOYqA/OS0igacm?=
 =?us-ascii?Q?jFW1Horv+FPNn67MxKme+YCYdFoYLiiPf857VPLV6e9YbZGI9AyRtSMrK8Ig?=
 =?us-ascii?Q?9aCUT1JSQyp0uz+7Rh/9CqMGs6dbrV5D9gqm4k3rHxKtkx5OLNZin4Ps3iqJ?=
 =?us-ascii?Q?zkICpa37LAgqSjUykTVsVrF00S8/HGaqP3CtvFB/bm++Yu2RyvHX5lFf1v27?=
 =?us-ascii?Q?GJO2pRqpTbfUgBkJOznjqmQe5TnBNsFfsX9778+mtwWQggk0VB1sl8QHbTer?=
 =?us-ascii?Q?q2hcBom8aHgI7G0OP7jFC7xs/hE/cIWegh7dUENKlj8I3+phi3w1dvhSa9IV?=
 =?us-ascii?Q?wrAZFLWKQy6eucNcdWhDVPiJ7SZDWLTTLfUsyou18dks0/e8xg/HQtM1ljSf?=
 =?us-ascii?Q?nn0VB1gOvGLlw+40v965AEC/uQHjflX6R/bvs4b4kWAkWMlofuVfiPQ8GvX4?=
 =?us-ascii?Q?VH6X9FXeZc6qKNmKGj5EukyaG6o3R8kun8FnXjq8Jr8tDaHOlp6xmAh1a7as?=
 =?us-ascii?Q?hOacXwQYVwWAl8AjpjUBQoLs2prw9bfQz+SzgLcFhoOuTILRKi7qL5FD1tzl?=
 =?us-ascii?Q?1cAYDaxVmmP1fDQWk+hTeM/6KK0M/a9o3ZwcKeRj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qa7GNYCx1kz5e4n1l2+DV7LhJqzEAue9orp56vJgciaQdM06BJIwhDkV/aZoNO/QuhTYVpCnNr+XtNJ/S2qj8IpyU6Mp3/NW3RL4Zv2rfg8isVS/292uY769t+yUyAGnO0mt6JPVHowYnHye4UaooTt5sDFBDFxqTp/OIu19Z2uPZrJ2uBv1UKsXsP8qpvcy4uHmP76jebQjB0HnNQ5wcCoB0+WJbbkDMGkNQe+XRMUohyzYP5qEEmFjjjXUXdhcQO7xe1StGRs3kG3m7RasVIoQNY0sXri/XvtuR3YHctxi1dprVzWnQoiwaAO56J2UwTilSIr74FUHgLXuZHb4QZn+3Cb8j7R6fuBlQftOdFjSKIgf1tXNVP2jzwFF9oJOC07Xm4/Rg9EqOCUPuxRE0/V3pEx9szmXZ6a799wK7EiOdZmKdqH7XgP4O97/hS/7jZiP7iDEslOFwF7PRa32nWzLRGZ9NyudJkGxpETBx448CXiZvH7gxFpCspkwJbHL1UbMUjoathywjA3PgVoKBqOX3g9EIJRCHPYfd3q0XAkKXGk7hvyrMNsvCGOuya5ZWadCxv6dvrmTDtbv9CaCQkwe7SUct+QRvkQCOpIP6tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2345c685-3298-43ae-93ed-08ddb95daa21
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 11:43:29.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oQe8kZVDQtMF6dtG4+oVCDj8yz9PARA4sxVsNep2Iv2SsSN7dWj2fu3JRjfR1WMVs2eDrys+HwHNm8lK1g2tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5NSBTYWx0ZWRfXy4s2r5HAIYPd 6dUTvJbuqiMIZapXYFWkiF+nVAWmnjp3NrlNJ2wJkhmmxUHjVA9ZMYXZgTL/dyW4v+5U8YZgAZU ir00lBP/O8VCODfWhrXB8OuhYVKJrpKpTOjqPj+qv43Te9fXpjKNYHbNv6fBltGNHa5kcHRP8Qe
 JzISYCRP7omxQGIlfkwL4/kay3OQKoyuRdWTHhHkSeTtjVWwxlbsQBUCbD24ono+XehsC/s4chZ jHDezvuvYOHWmeShZCR2Z2mEY9XWP9jIX0masFPDoRErfmhbXaM3KtlgRHTPVtcf5+61XP6G0gJ 6pif7r6AsQFw5vzEwiyTGGA2aTy8GtTkF1hdq8COqrZwwG62v5sHqcWvjN5czI5DqviB0HwOa19
 /ALHSM/0shCl8MpHnjMQWwYAOR+U8Eb2Q2G4pBvrn6EA98Z5/tCHa+G0WLghBCqOpEWyX2J8
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68651b67 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=GFP-k6jHgeBuU4vpYHoA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-GUID: ffaf_ML0qi7eiq-spMTL6LudEpcLd_v9
X-Proofpoint-ORIG-GUID: ffaf_ML0qi7eiq-spMTL6LudEpcLd_v9

On Wed, Jul 02, 2025 at 01:04:05PM +0200, David Hildenbrand wrote:
> On 02.07.25 12:34, Harry Yoo wrote:
> > On Mon, Jun 30, 2025 at 03:00:00PM +0200, David Hildenbrand wrote:
> > > ... instead, look them up statically based on the page type. Maybe in the
> > > future we want a registration interface? At least for now, it can be
> > > easily handled using the two page types that actually support page
> > > migration.
> > > 
> > > The remaining usage of page->mapping is to flag such pages as actually
> > > being movable (having movable_ops), which we will change next.
> > > 
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > 
> > > +static const struct movable_operations *page_movable_ops(struct page *page)
> > > +{
> > > +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> > > +
> > > +	/*
> > > +	 * If we enable page migration for a page of a certain type by marking
> > > +	 * it as movable, the page type must be sticky until the page gets freed
> > > +	 * back to the buddy.
> > > +	 */
> > > +#ifdef CONFIG_BALLOON_COMPACTION
> > > +	if (PageOffline(page))
> > > +		/* Only balloon compaction sets PageOffline pages movable. */
> > > +		return &balloon_mops;
> > > +#endif /* CONFIG_BALLOON_COMPACTION */
> > > +#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
> > > +	if (PageZsmalloc(page))
> > > +		return &zsmalloc_mops;
> > > +#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */
> > 
> > What happens if:
> >    CONFIG_ZSMALLOC=y
> >    CONFIG_TRANSPARENT_HUGEPAGE=n
> >    CONFIG_COMPACTION=n
> >    CONFIG_MIGRATION=y
> 
> Pages are never allocated from ZONE_MOVABLE/CMA and

I don't understand how that's true, neither zram nor zsmalloc clears
__GFP_MOVABLE when CONFIG_COMPACTION=n?

...Or perhaps I'm still missing some pieces ;)
 
> are not marked as having movable_ops, so we never end up in this function.

Right.

> See how zsmalloc.c deals with CONFIG_COMPACTION, especially how
> SetZsPageMovable() is a NOP without it.

Right.

Now I see what I was missing in the previous reply.
Thanks!

Please feel free to add:

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

