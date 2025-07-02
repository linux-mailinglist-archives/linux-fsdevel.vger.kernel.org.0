Return-Path: <linux-fsdevel+bounces-53664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6BFAF5B12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D93B189E5E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820A2F5323;
	Wed,  2 Jul 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XVFFF+le";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cQtA+WSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D3139D;
	Wed,  2 Jul 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466314; cv=fail; b=cPzTGeM6z7wLSAQ4j4lVK+dupykm5lLYNiORkpigGtxNl1eZ1iLPHbc3Gl/qkry9/PgQBmVKgGY/3ERWuCJu2NNr5wJlyRGznvdNaZIfwtQSMgeAzRGlhoppLAMVae8a6UvZMLLZGI3TiaMAYjgmOjW3iMjE98dGQ+eKFarHCIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466314; c=relaxed/simple;
	bh=ai4tR3ksCizcZf2uFK0TfAKrx6wUXBe3i68mhtTivDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OfrmlCJC1SnwAsTbWonY5spuIZFY6rh+p8tI4jg3tw4S5tx6A/TuWLX4HPKlXE0wFVJRoe4kQ7rhipQtiwAmtbpDylEUm4vRrSE4NTEn9YTIPu806nglkgPpU5b1DawkQ8j2+bnTqAj6oLtcvGZQGc6KDNyEEOa08m3qvcg8BXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XVFFF+le; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cQtA+WSw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BiSs1027326;
	Wed, 2 Jul 2025 14:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=V40uP1JeR5vrr8sza+
	B5qF7ID3hdxqfawZlwFYuA5NE=; b=XVFFF+legpUhuDPQXFVknxBApP/lz8exD2
	F6wB+C63yKiHvSzZoGj1SMyIgnOLCiSQjXPhM7Myqxkb71jN+yrr8iIVdDo4UGOk
	T0HgGIlJ4udrW8nB+4XbCngV+k2Fl7YTEt4LWWq6dAwplpGsSlyCoes5buMy9gQK
	61nLq9wpVc5QjqKJBW2W+l0uaQLg/mhF2rNs9kWawoaZQ0zEUg+vWd8zm3Y5+ziQ
	LJK2iZ0xFirbFHbF1tbvPDIIWhthau9BymyRXJFTbu11oJHW9g/oYPpHtaxpWcBO
	wcqzt6fnTWtUoAn04tMirnfkoF1R0ZklSYO9EKROrF0NsqGTiF8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766f3rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 14:23:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562D0ttv019579;
	Wed, 2 Jul 2025 14:23:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ub1hrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 14:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQev7pMuRn0eBOiZEqu9R7xblLstgUIlUpyvdoLOX9gMuIZ5SRy1jTAu5YvpVVNwb1/qOd8hym2Vo+kYA0vDnKTRyCSReiIi34gftkdi780aIdxt1ZjWzHV2BJTKORFoEuIaCrZBbaizfWi6ArrhI10/PdMkDAkoGR1/AAmfFhxrWG4daPYm03A83PFpHgM8fA5zS06I9yXTyxiQsWDINj9jduQ//24i4uOpAILC7C7Uocy1crV7OvmN9U/aOlx7YUeyC2edyQTYeUnEeOqQ+DFjfJEh/F6lk7iqI/kOjjlbKIWk6KmkVeYFSs1pDMOaqUtYJ9jkn5TobY5uXMXihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V40uP1JeR5vrr8sza+B5qF7ID3hdxqfawZlwFYuA5NE=;
 b=qMOqFN2kMCh/a4X6x5jnJfGPiO3RlH09tK1l8hm4BmdL/JFW0+TW5v3oUanA0lYD2L5JYZ5b7sHLItDAmRpxivgXlWFHeTcQb1wpbwYY82CoyIqB8jKMsrTGkpPPekoF9AkLfKH7lQgKHNbfMbFb4U6Z8E36rUHo9zqG61Gq3NYARTqUTEsGXR041ajKwg+RxjF+fAL2qIPluq3GTI/OM1kXGyQf+Vt7o4dDD63yj82/3CKRbpMZcbzCS50eZaLzHX8WsGvr739PsMwBtveW1OXIZKx0KCOOwXXoOTRkzxUSVXoaHaaGDBh8U7kpmiVCQGuEY+M5RMBnF+AVSnN65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V40uP1JeR5vrr8sza+B5qF7ID3hdxqfawZlwFYuA5NE=;
 b=cQtA+WSwrnXIP5/tNVc73NZdiUf+XKel6uo4askZHYfrkXZkalOZ0XJrvE3uQfs6yqjNrGMj+UV44qBFzrZTNGYSt9VhwflKj5XXtbY7O+qg1mSRvCDOPLkILCe58wj8mb4UbNR7CkWu2BHRE7hqC/rVFSZ7zFx8mxWyzVwEKEM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF83BEC1808.namprd10.prod.outlook.com (2603:10b6:f:fc00::c33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 14:23:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 14:23:41 +0000
Date: Wed, 2 Jul 2025 23:23:22 +0900
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
Subject: Re: [PATCH v1 27/29] docs/mm: convert from "Non-LRU page migration"
 to "movable_ops page migration"
Message-ID: <aGVA2p5mUWoBDVKJ@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-28-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-28-david@redhat.com>
X-ClientProxiedBy: SE2P216CA0064.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF83BEC1808:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f6d7a5-ed22-478b-fc30-08ddb9740ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVR6H9G2ymTe3Nb3g3OaebDlJkhwwFQ9cvNY0KsXm37cfETk1dhw78FyNEIG?=
 =?us-ascii?Q?kFW9TpPTaC3xPgP2PAu/paz2ZuK4FBQ7/n9IF21L92OV/PkG2EPvsUkb/eZC?=
 =?us-ascii?Q?1ALTZ88ZE+NxXxZzBHXqfG0CZB23/JuiK2O+BXbGpl1tBxKX1XEWds3CQ/ZT?=
 =?us-ascii?Q?ogMvT5BhQ9pel9YMNB76SqvjhTm0ukB7JbfTjnztEUBfGQ9Y4kzkdx3bA/ze?=
 =?us-ascii?Q?IHkfVr7nV2BbZf/iGh7MIvKAu2f0/rwVEbNd4VvVIImKqDeNYtXn+4+FvEPC?=
 =?us-ascii?Q?uFW3H7SZ1QgFmLEhA0OqlPfOoYFDR/fGiQZOQ/U0ZpQLpwKAW7aJBT/QgOQo?=
 =?us-ascii?Q?Y8S3WdK/JYFTYjhM2yWRS6YnN0abw6mJuoplACtugLNVC3/ZBTN7qHxpxIv/?=
 =?us-ascii?Q?CeoHDrvj9fflRMfkCTclxIY5TVrzIaQ94seZ0W4T+5Wj2BkTz3IzOgHnFx9z?=
 =?us-ascii?Q?eq+jbfZIUwZSppgzkusHDFABb8Wi5z0UNG+Qb9tbiZ2FwvXpDf99wBg/I5RP?=
 =?us-ascii?Q?x0Ehps4v+9SijBwktefB/IVcVeZ5xzVa531sA8/9mzMbDtHvTxxoDMoe1Wm+?=
 =?us-ascii?Q?d22YDVde2EV7aM8Ha7qIsKBryiDz4Lz7FnYQylOlfwyNvbIfVystO4n9DF+8?=
 =?us-ascii?Q?+Ug1rKecNT2vyQ8VUTEbqWN+2CvoIigxPqDxFQgd+SXrrOgZk7gacUu6Cf0H?=
 =?us-ascii?Q?5zzMzYHTwogCkTvuF8yfgiud2SPuuqFPBu+BgxDQ5/AbGCCXU/7jSmn6MmA0?=
 =?us-ascii?Q?S6+YK26DdEZCFWq+mVRDfNsacMngpG/X60vOl2X1XYzh0BXJeQ3E/k0OKhq2?=
 =?us-ascii?Q?/FPrS14e2qapoaGstNAkEMNGAz0ArrgvpwwUV+Tdxk2Lgd4l1lC4QHyj1W0Y?=
 =?us-ascii?Q?ZqvYe9Xda9ukg+3YxxeNX9eezF9tCzwXdVOpYmIM52O+eSxTBYo1LjF0+mn0?=
 =?us-ascii?Q?TZxO47SkBT/H3rYadE2/YYjNZrEXtavEiLVzoq4pYt94FLn2H/Jg2m0+OHBP?=
 =?us-ascii?Q?3P1UkA9TbHWHiEpC1WArGX8cIvj6HwSOs6ySbo7lp9vlp0gtWcWGClQAvYWo?=
 =?us-ascii?Q?Rf2997hmtgbMP/QFr7VwUpd0UMRjpCRPXzu5QiJ/W6YsMJo77eiH5D+o14ko?=
 =?us-ascii?Q?RliEXdgXHpQ3cjT90z8+kSbFT7vCla0sbg2xA7jY4Sb7QRU0Ih5ZmiEFjgGx?=
 =?us-ascii?Q?g97HUp8Y7So/9ZYbE10GqIpImIyxiwIsxuLcAQMSYlEGFEOIbEVOIIGHr6xS?=
 =?us-ascii?Q?B5N4jPmX++fb66JQ9e90zvDAtgJhR+NJ965ojCwj4IrnjvdK0nu42Bnx/uGx?=
 =?us-ascii?Q?mowVPRGpHIfpCNZanNjWLj92wPlHQ349slb0Wpdt7Cg5lpnB5aeZZaUgnOLK?=
 =?us-ascii?Q?tjFxpDjUo8jjXikvIMo8M0yA85I5EG7jHKjsvIS1WekgxZtaE0a7YAegAMfD?=
 =?us-ascii?Q?EWUSI7U7nkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjOkVOeXR9eDyk32zhdmFk0kJU72LgvJkuPlq3/gga+KohuyPJumQZ0XrxET?=
 =?us-ascii?Q?LK7PH02f0ovELGRrR7+x1OWn9PmJnCh0NAEJ8peLC7XdGuVa+5amwgRBjzAx?=
 =?us-ascii?Q?RfdFT2w8ci4EPeLa7tQheJpbSoxw6/ul/FfeFw4b9t/WRL2qAnZ1aFZ/vgRd?=
 =?us-ascii?Q?HhnK6kvr7Opji+nnLREUBfRf+OcsGL7Mkc6XicwxywBDmvvPKYTU5Eu1f9EG?=
 =?us-ascii?Q?3a9MlH9kxJQPojWRn0XK0FybqmIFl3NBma2EFrl0XuqFPODtKtdAiyYx5SJS?=
 =?us-ascii?Q?PMJ7C/ihK7HQg3mhmCMqRf0QfXpUaTpqxOPs4kooyl+kgZ6egj5zB8KooKb5?=
 =?us-ascii?Q?ZgOSDbTxX87e8IEPSLo/taCcSY8798i2sJJUDSrMJ5KyeGnPYpmFSVTFY/hn?=
 =?us-ascii?Q?Ih/fpZKdEdp6hhu9JLrR1z8Re5Xkld+ryoOoxCbH6RWdryo78ltRMU490gXY?=
 =?us-ascii?Q?Jy3ttELUZS4Yq3U5MlNDJ7R/mQWANgZOL0vYRbV+HbzZNNKs5S0XlT+o/W0S?=
 =?us-ascii?Q?T1Zbb+fTJcwEMVpryMtw9+wLsLo6IvrrobLw/DLWiLJXTNAX3ljtocLyMBjK?=
 =?us-ascii?Q?Vs+gchZwy2v7ebMXCdoAiYBcv3WTJSsAxfGSDy9SWTyhBVfalcbswv7azo3n?=
 =?us-ascii?Q?mnTQUBf1TOghXvWknGQ9D0dk1ytlW8nUrmbGr+tdJSqPvsC3xmT4ssMdQ4t3?=
 =?us-ascii?Q?aOmFOQoEbtfZd/b+2dYn/XIyG/8NaRW8zmgFg+HGWpjPGxnmwKUEmJxeOQQx?=
 =?us-ascii?Q?axVkiZnJQcrJHV+ZCV8eX4UOUQ/JfsV9+IYK2mo35XRnVkdXRvDwy3xcKAx1?=
 =?us-ascii?Q?YZAbwJPOIp0v9f0viDUGDM5mCnry7yGnX1v2ozJJMaqDbIH1DqKoH0jQHQyb?=
 =?us-ascii?Q?ucbkXy1SjKlpzjyPTT88Ii3Yt8TycdKkuF28nX97nXdV+4VS13Tr7JsDW9BY?=
 =?us-ascii?Q?MsZzYRLJVAyOUz5KrrWfvWkNzezj50wYNsofIPuaP+lPoGkrvceWF6fAT3VG?=
 =?us-ascii?Q?FLIu3EoBkynvtQIYvMA96wMnpI7IqBF0QkMwpZnek/6dlPhcenxBfx4FSGpw?=
 =?us-ascii?Q?yFjTDpLVMWgg8BV6tktGF9DvPcC/oNRA9NDdop2iYQNMRCNgDrPnjZbgFkWw?=
 =?us-ascii?Q?DqzOqETlZjlWJZ+FWYjhap/q168Jf0vb+C0JSCx8B0SnsS4Z5lmD7NUBoeEO?=
 =?us-ascii?Q?xcW26onCtmiBdjxds/B1FWPQSfyFTMkigEZBnDAizMAlYFGI6+mP0gtQ6S6k?=
 =?us-ascii?Q?YCZwN4nCFzciAK6VAlGLC1pg9DRyADg+CP7wFXZZg7oA5JvGYFL2sGs1iGwH?=
 =?us-ascii?Q?LuDVeLnfMMDJ/JYwEk9W8/sQpgx3Apz+ImQCgKz4z0nZewl+pHqiywUwmwDw?=
 =?us-ascii?Q?8oOGr/QdB/NsJo6uGiHvoU/RtVCk920SOerLOzpHJgXL5+zQdykIbTFld1tw?=
 =?us-ascii?Q?c3QeoZeiUcNOH1eEZsffJXVERyi0fIICQWvpmLNznAtEywZ7kSiOSL41TCbU?=
 =?us-ascii?Q?6qCSsvlTSeUyuurshLPemEa7ohPozESB0jsSiIojzznsgIbZeV72c/8VNoWD?=
 =?us-ascii?Q?EQykNfpUPOIUSWlvbxy3eRq5mpLol0bFErFeGhXm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WMzD94Yd9GoIgfwN/bhzcPmGBg3wNz/L/mIWv4NSMlIP1zsn5t5F+dNnKoMB8mQ1VwzZuOaZqG3BH0iWUMOVq6iv1L0bKe3LxfSldiwUdh5Tf9uC5YUHTcb6p87HWyRkzB1CqU8eAjkB8+2hx7ItRbULzE8eZnexjSj3NBT92xQbvtDJZdMlQC5qjvz8gFGSaEuMS/00cbZ3FFS+Ks7YNGBUuvtT/d0acbppNPsPL5xAbvwqKZtG7V13JfpEOBLpgQfKF3BNHmzKthVfpft0nHPB1q75l8eNPhiaAkIwcPjqraOO9n9Lm7U2QX5Sgs4BhHbTo9mdRzaQe8NW+od3Mn1/1W+Nh699bS5G8mn+tHPRYf4Xu2IMytvLNUNtzjSmsE03LqvTyj300I3XdIMAZFZIgcRyaxy4VEXl/NJU/HbYosnVfqknM+/sxUd+SH0d6g6948KWFkIQspZYCFCsBjx9NS1G5JUjJOk/Cg9wZwy3Go6dn8S0IGNNUzfJFuJKnL9OK9D7FFmZ64l2yDUcwxGErMDGLb7CqsLkAJyrGgkOvKJdp0PmRbLxJKLuwxDZRqkg4wzDyfQcYUHR9isOOQB+9RBF3dmhc4ZU/ERkWdc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f6d7a5-ed22-478b-fc30-08ddb9740ad3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:23:40.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39gB/jIt0gO4AUUJSNA0ROw22A08x+/zYHsjAj8VJeB0//KioTwWcMFEU2NungZeI3F7GH6l53iiC5A80mjLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF83BEC1808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020118
X-Proofpoint-GUID: KXUNQ6WlIqDPMqA6XX7SUv_ftC3N4u8w
X-Proofpoint-ORIG-GUID: KXUNQ6WlIqDPMqA6XX7SUv_ftC3N4u8w
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=686540f2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=SkZFB6aTyI1deJJJTvsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExNyBTYWx0ZWRfX0viCwo7bJXGU j4cr/xCDcpstvPiozA28I8mu/ofN3OcFAfd8VOWgK6YcA6NoRY6BkMYX/dJxDRX1Bme5HIjhJXz sTAc5PR5XYGIzG94kCyiFjtt0Y0Hj7Sw/JkMJ8RneWN4bZZIgUjaKgpRPReZKXyfxAWPxXOJ8Pq
 VHwIqgtVBCJqHNpVvoXeXkAkodelo5D5AKO5ATQ6G+Sc6KfABxqFFYZ8zlYt6kSypqIMrDLhDz4 yr8UzmXSjWoOCaS1DuaZLc97QtxDscNn54D9v1Mre+tTeZFrECGWvUiSt2wS7GKu7kaRapxnMiQ 2v1Pe9SbBUhrPRdTOsokwswxYtIRHhdC0aApFqxmphvBRtYSzjJkEc/2jXKxZ7l009tZBGa6sn2
 sggjcmnzbYwDQq6Wg+iKmOt80cWbb/PB1qdC5JZgXUhiqnUblGcFwdWQjB0kUGgrDVUTJ2rM

On Mon, Jun 30, 2025 at 03:00:08PM +0200, David Hildenbrand wrote:
> Let's bring the docs up-to-date.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> +movable_ops page migration
> +==========================
> +
> +Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
> +zsmalloc pages) can be migrated using the movable_ops migration framework.
> +
> +The "struct movable_operations" provide callbacks specific to a page type
> +for isolating, migrating and un-isolating (putback) these pages.
> +
> +Once a page is indicated as having movable_ops, that condition must not
> +change until the page was freed back to the buddy. This includes not
> +changing/clearing the page type and not changing/clearing the
> +PG_movable_ops page flag.
> +
> +Arbitrary drivers cannot currently make use of this framework, as it
> +requires:
> +
> +(a) a page type
> +(b) indicating them as possibly having movable_ops in page_has_movable_ops()
> +    based on the page type

> +(c) returning the movable_ops from page_has_movable_ops() based on the page
> +    type

I think you meant page_movable_ops()?

Otherwise LGTM :)
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

> +(d) not reusing the PG_movable_ops and PG_movable_ops_isolated page flags
> +    for other purposes
> +
> +For example, balloon drivers can make use of this framework through the
> +balloon-compaction infrastructure residing in the core kernel.

-- 
Cheers,
Harry / Hyeonggon

