Return-Path: <linux-fsdevel+bounces-53366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58566AEE158
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084967A6515
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335B28C037;
	Mon, 30 Jun 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sRuvPg+b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QRDCYo+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8825A32C;
	Mon, 30 Jun 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294846; cv=fail; b=T85Vo8oqovPvHnfc2pEpYe1TBigO+3/UgQ5qOSD5bFWnwzvatXOp0ztE0rpkZ7OuYh29mBdcak0uTiQygzexOcKQ8F9CiCbd1dXCoWJHUD2oPIBTwQQdYVkL2J8OWPAEdYMq4HJtyblWxPo+0K71f58S3qbLvzRlI099e79HU1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294846; c=relaxed/simple;
	bh=S+m92H7kfarfnNr/xyeavMepZvP5twru4O12KrweJcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BHVqOYjI8pyiObsuTM1GEw/GJccOyotA84+f+aib+abvWQrBNm0XXuxGKbPPU+MBNsO24rt4JO1UnPzZXC4h3yeizY3eqHBhzoUQezCrTWNiNWeolaSi1T3drvbz3fOyvRY214wRIGOLApOjMydg4QIP1oUu/X1eA/fPZT1rjns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sRuvPg+b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QRDCYo+W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDfpDs016562;
	Mon, 30 Jun 2025 14:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Xdc+IXxvLI6ToVOz5a
	gFpPWe67q+8+pexPXnyXAPV1Q=; b=sRuvPg+br/V6WTlnjmYphQvh19ypbxqbHA
	vxoNOFdf9wgOM0WttfZuSpmwvVa8QKZZ3k1YYFQk6e7RauJLclhFyNDdfIbHMXX3
	MZkqgI2iDa+JEiZfJowbKNXAu04PHdBj22ZfxBwThL6ibkV9LjTyl79fcOwFZYUQ
	OegkGROJ8o/YFb9Z6avFk5skbbQ4oiLk4JexIRmlwNc968Kqexc/Hx+pcbyX1nY0
	GsKjQk9q2r4exa0u7LqrHTfpCtRzFCFIgv0e/vVfDCQkMTEbqAghjScPWrkFScGN
	3FXEqboKZl3c3Ah8pGYRiFR111y7ufbZp++Sr7K4lQDygu2+ZPOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7t0e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 14:45:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE5Pmu025799;
	Mon, 30 Jun 2025 14:45:52 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8e5qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 14:45:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BidFKzdKxG0C0fLrxHlH3VdXXX2I51TiGiUvlkJP+/6LnixVd3UAKxfqNkTL0JOD3YwUPJQ/2T5BwrZI0j5YfOSzf6DW3PuJLq+wlJT7PhUPSkSwiqmSbskbWQz3KiXtXyQ99q91F0i8u9jr36fKuPSPRmdTgTakFqDpUSPtD8gyz9E/HTaMJsJJOUpiTnhTDxD22Jl4hDFDKYaptTbCnqZ9qTqr+qCCnF8LdMtzm0P59sG65Q0rnsV0dmPrT5vPx1ipyoCYEUIPswNfo7dp//q32qoee+ZQceRUIXZf0i8pSGcOf957eyRZ4oMaL7Y0TirWEmKRvNWuP6J86Oc1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdc+IXxvLI6ToVOz5agFpPWe67q+8+pexPXnyXAPV1Q=;
 b=ZG6/tSaoeBKAjijWREoPMSn+TXq6wKpoRsp2h6yFMGillhGhAySVHnnhAFZFYoyRC5E6nijl1880iJVfSkw5TByJAEjJIN2qDvASDPDCXlbqs8dPq6GkQlrlCdK0rvOMbjlPNJakuhdnHHFM4OpEA/3squR3YLa8xOBwpzPeVTIver4C1w309fTcqEfuH3SO+93Lnq+GFX//cJ3EGM8xKSMnDummE6jA8FzZX01GY8MLBNvXJG94gEMD+ir38gYb30rXU3kyQKbJ0ewc5v9UBKfSYyRhN2a4glBs7TNjkE9/pY5uceUBHUKbB14yIGamxB6UR4u2/ERqs4vIz+BOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdc+IXxvLI6ToVOz5agFpPWe67q+8+pexPXnyXAPV1Q=;
 b=QRDCYo+WgsYnlFXq4csMkBtb4S9RVTD1kKq4RwlwdOeT/y2Sh4ZQla/+DKKxtWKQ6AheMV/E8w3RKHKro+JbZBHl4QLyV2zYyvZpJjAmnhYiUwZB0gdPc/x3Jk+1QcYhWk/9E/7+ALUVPVd0Xtjlem11IJeRPwRWtNhcGAxsiKI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6847.namprd10.prod.outlook.com (2603:10b6:8:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 14:45:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 14:45:47 +0000
Date: Mon, 30 Jun 2025 15:45:45 +0100
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
Subject: Re: [PATCH v1 01/29] mm/balloon_compaction: we cannot have isolated
 pages in the balloon list
Message-ID: <542cdfda-b90b-4a1a-8001-ae028b9a039a@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-2-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-2-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: dd11a721-35d0-48f3-fc27-08ddb7e4ccc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6XoHvJYf2QzyGXB+tY4njQe8l2o6+2nPtS0P8uj9ZzGDCub8RmKGJzw/RRYT?=
 =?us-ascii?Q?Sgf3P+gRw/HlGDIBdyCDo+x2UXkR679G/ua5FMFl0aZjy+g4VleCZcyCX6hK?=
 =?us-ascii?Q?CI+8PDygvUyojdq5evPmn/RjOVnlLYIbDvwIYIfKbeqC76oTSqcNzHToT4K6?=
 =?us-ascii?Q?zESqwUI2N0D6CyKhNrIPiLJfMBaVOkzF4z/vv/zUmi+Hzb9bkzPLv1eSwr/4?=
 =?us-ascii?Q?qaRZ3IbwBtjL88jHLJH5EqiZIIJNZ4rnhzU272mxb5p2i4CO1JHNywE86R5s?=
 =?us-ascii?Q?tRrBxJBzOmvXnACf2/e0QoEzLr3mn/IVJcxU7FtIP9bz6tSh8iMU5Y/CIqAU?=
 =?us-ascii?Q?9C3zHUnZORqcvbeT+dR3Xfc8RFpdV9V9aZnogUi64kZSx5Zrq+TCS42iXKPB?=
 =?us-ascii?Q?LJrA1h9hjWzmI8WE4DAMIUtU2Br6IA2LKWCt/t2o2UYkhC5hI1GFUm22e3FO?=
 =?us-ascii?Q?DvD9q12k0QCyelOBdpgeXm+NTaXl0xxiZaIITsBKQYm7epj0oGCqrXU+Znhx?=
 =?us-ascii?Q?xNWZwohgntoDtqJXYjAg2NBOPoSEN9YgdPRehiUi4C4eueHEOVn8GEBl/rk/?=
 =?us-ascii?Q?j8Vt8ee3bpfICPaklxSQO4DgWjvp6vrgdGLaOJFW8DTlQeOuykJ4jRypus2u?=
 =?us-ascii?Q?jJsXPoxbHmQ067ucPXyvcbZH7ru38yTNRmTuwnknJzoJyjT6/z7qBq+ayEL3?=
 =?us-ascii?Q?DBMJ38NKRn1ieMyxPflGJq5SmKnlNxbGffufc8t+wIc52Jsx0Q40VDWp0W4s?=
 =?us-ascii?Q?hz1Yrj8CXa1DPx5EIhwBqxoEMuAIgjr+uJdPs46p/s8BYqs3qv60XEjP6l+M?=
 =?us-ascii?Q?lCOMmBWKhBABVnO8u2kZRwkxhNllAl6sPkO2+5+SgqYf9pNDURBuY6HceIlO?=
 =?us-ascii?Q?W791NrbfVr1chFB1w9uKFxAbBhcy6ANU+Ehfyj8bB77VM3EHBlym3pqwnZ6R?=
 =?us-ascii?Q?DdtrrqxSVKaxAu+7eVi1SEfwYej+yL0XiHLgdpFNHJA9mmpcwmSOKz/qWHvu?=
 =?us-ascii?Q?51O0SsWzWammCLaRIl2l6QvYYhwmkT8vFjm7PauBcJ7IjIvoa3t01ReNAgOe?=
 =?us-ascii?Q?4JvynRbVSiFZBCRy1emlyu0g25MKaQrHcSONkmdshSJcCIKKJdAnCmxsvSZc?=
 =?us-ascii?Q?LqmZKGW/lBppDJvsaEZ1qi6iZ2Sem2ay8fN9BhDFNi+tDI3WWMDVQc3gA0jn?=
 =?us-ascii?Q?2dGpcsT8Irk1ED799VYhxKI2Di/01gCAk2Qj/B87f4+T+3pjTkJ8Yn18nE+q?=
 =?us-ascii?Q?6JaHTnWjrKvfoyu3J4CGRLsNUGqb1OjCs7WjbYzt7eQxNFcosloj4frNQJfG?=
 =?us-ascii?Q?/Fdl+H1PmF6OMS120ZoYswGkH/HtQk02NrNLfriknwgDGbuHhnawffHisliQ?=
 =?us-ascii?Q?E8FcCfqZJAx44HyWeV3D4iuDuVsArwkUYTbUR1Ahc1JQ5fXWm0ezKJxj4F0X?=
 =?us-ascii?Q?iGxTrSiq4BQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERu1BTlbvGbNdcqPQtry9LzuDyYWX6Eneaztdd4ZLaNJf704nocGQfYAioUj?=
 =?us-ascii?Q?z5NyQM4g/7B/ZOvAYyPWP1TDNdEWYY+bftpSoEOnxSG4ar8v8kqopZI01hm8?=
 =?us-ascii?Q?N75jQryd/CW4Pkm2bWlACMLxBLK3oxxTpyBI1eCcoSzkxKgMlDIBLTeAQdgP?=
 =?us-ascii?Q?C0BoYX6QxQzGBqlsGcEtUmBOVm5IKVJDKDYICn1NQnviib81MR3baZoPlPFG?=
 =?us-ascii?Q?EnRhAs2Y3jXgoIK0NTM1XZsrhFZb/o08kwI4jlb/RcON7aG0F8eMrGLKek25?=
 =?us-ascii?Q?yHBJe0YF9RbaPsNDlXJh+qaBH5xVkeI1YgTJJmWEcYiOvinKiVS2V2uvU60R?=
 =?us-ascii?Q?1OjZABntcr7hOfGJ90D/gSaPxQbKJiXx98qNOMU4yoDO8GGcCspLH3xGwRp0?=
 =?us-ascii?Q?ex2bBi8DohSM5tSfeNSlyFMOWW/btgbaanMPZp/iDjoH021CBlrQg+tYnRjh?=
 =?us-ascii?Q?09L86jmBQ+6XPXg9d6gUvo2oKeWH1KnYXItriSScHvXyNENr4EjsXepsYNU6?=
 =?us-ascii?Q?NQsJNjHlIu7zotcLLX24iuS1pVZz1cC3QRAXoJmOb7wKULuxXZqpxSZGfzms?=
 =?us-ascii?Q?pYn6AXBN/U1FWZ9eUTLPMVd3fCYc9V6VsOqonIPwa7EWxUA9rNi11MaMHL3q?=
 =?us-ascii?Q?vItTsqfbrnX+f221jBUgV6UL0cmGFEYcbpexweHPuC1Ad6ynURV0xSUATylJ?=
 =?us-ascii?Q?NeCMrt1TlFrfgqFvDdGNiXwWgS4pJsz38MAjFc3UwwY95E2yPJVwhrHFCdMu?=
 =?us-ascii?Q?vADlFJC85tTe9KJsS/ncHc/w6Qrfk6wYkFsonehNY2rMEDWBzmEzIYOukPDr?=
 =?us-ascii?Q?dwe3b5BPF5TyHHgwiZJDluzqSaA8kRiXKa9CgxMvTjZppACo2CuQvJaeyZrk?=
 =?us-ascii?Q?AbW4loenUmrKu8+lowzXAuqruqbqOjEsefrVZy+YPJdhuoT0+fFanER1MMXB?=
 =?us-ascii?Q?XD/bgHCT/idjfRFpjOhH6LuqdtNVnFt7z2ZA8pfQ7i/tVTqc0cTi97vgTTgI?=
 =?us-ascii?Q?csr5Jovpq++CBgW2Lx3tcaVyndUq74SKbLFiPMhdZ6g1PPb/fTjF383ZDCJ5?=
 =?us-ascii?Q?ZFBMqw7Eso3qnLCmrlsGgZLENGaejpX4rLYYV+nk2OD2yy6eKVCXKx4QtLk4?=
 =?us-ascii?Q?1PK+SPm5BQoEpGFNdnDjCRBrtwrIsCHUh62tJgmnDoxRvxcRO8bHVBRynRKm?=
 =?us-ascii?Q?JMBVnix9ZF+KdY22n4TSwQ0EOywLS75rggSfIdEUSrkkf1Hawm1HlJBaGzpC?=
 =?us-ascii?Q?mJ/nwMqixROERv4lBuH1FKyfPYW/ebWlIJRQ2qgrLCc1GZ1r6H/1G3jn1azZ?=
 =?us-ascii?Q?T/vUlcr7BZpnDOwvwJRsTpYrnEgPUrdYUuHSHDY80OjNMyUT4q+U670KlvTs?=
 =?us-ascii?Q?sGTqVhTjrVSlxC0SIvrgIm/kyXfB++ud08vG32mMzWWi0G04PtjOLK82pY2n?=
 =?us-ascii?Q?EddiuoUYopM4E0ao+fbxaTE5FD80tdJNacL9mQyBwVrScCCwFAPqOSCrmpPm?=
 =?us-ascii?Q?il5HO+GxT7YePwg4wnbuy4jF2VRzgGeuqnMToNEM4cCDyNBojY3KxH3kTvXU?=
 =?us-ascii?Q?PZD7VVDg37yFhqWvEm5BhlV2LCBvuROeRV3wPJjJ3klo59oSWk9P3Dj3Fntn?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	704uvI3Kzwp8o0UAiFu6ZDt7Z7QM74JKEpScgdFRa+SMy2gZZEGfAqkicZh+23ZLJMDyToUFHZop3MEUrEf9X382UG59qTOe8anmEeXE2LbCAt3ptZtgovwrRAfRIznafP0PQNxfYsYl8DfiXJ04K+CSiIHU4IkolffC7WEF6+uspnAfRhCpS+2ViziU2S6ZLv0zOD/jji6Z7GVczp9AuhhMe25rS3MEgmhH4wuEPt6GDyKCGeQATz94qVcZvHga0WjLMo/cd42KIRefFovhThZ4EfgRSf6J6I5awGbKLPqaWvXioRDDtThhJTB/gJXsG9Kro6wBYyPwrR7+2WZXFg+ziay8h9zIhKRNVzuvshKGka+M/DfhRL/Us12k6+Z5rwjV9G4oR5kWTPCMsT4rDlmKERRe9iAr12Vbu+VRjHTgv25LMlMIG01t5PR6k3z11hlRgKeb3r9h6P3006BOfxCjl6dR04tnXA+HvgbArovbM+7StFnXg7lOwDQuTGS1K133CfyLXzG4MMFNIVAUafkWDcNHbMwbaUavh0+4HE+mr7SO1Y0rRZ/i1yVtV3aeKvhJtX49tdYMwSxH696IV9Qem8l90Bp0XEJG75HTJ6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd11a721-35d0-48f3-fc27-08ddb7e4ccc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:45:47.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be97Ef47eb9hEzpfvX8b7ffZmXCavKn9+eZCALpjFGiQK132i2fNZ7mvUchKK4bTlKbiKeX8EK/QsXj/pRNVtfcz6UkIivyYgBxoRcfDGGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyMCBTYWx0ZWRfXwiiQThnAMbgi QjzkBraZ21TKdP7aW/39dyyQssWDr5LuwUbr6ZFMcUBt++YgLB5ezUY4GzNl8lnEiWgnzXEM2do WcNq7TPmDUGVVEF2a25YOYQpXcWF4QETI+n0xPrWYwgnPN4u/VuCWMCOKC/FWBCz6cGf+pI8Wi6
 x6nbNKPS9vgWEzPlsHUPB/pK2CQIUCzWPrbmEiMkMGIG0PfxZCAgF/zvWn8e7qPeG+THLG6u3CW 2iNI7UPR8BxN8M6axTkN7n1LTfPj6e/0LlnnXwEwLSNyu9LzzXWyUC7gyGsx0YuoxYOhSYt7HAl yolxYcvR87PgSu2FaHpHDxk7zrvFxGQ04/PcaI9MxhRcp6UiGyg/f7XJnuQZQUqFCByQDMmurDp
 rxRHbM6seqMTvHMf8mVpJhdzht1jV/8FtZFi/eJWfZctAWuss6mvcWkhEFvt8HXsYUPMUVxZ
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6862a321 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=vOsVve_mUe_iLA8v7Y0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PxQo8GLwaa_SNvG6cPyhNKmFpDqqA7S4
X-Proofpoint-GUID: PxQo8GLwaa_SNvG6cPyhNKmFpDqqA7S4

On Mon, Jun 30, 2025 at 02:59:42PM +0200, David Hildenbrand wrote:
> The core will set PG_isolated only after mops->isolate_page() was
> called. In case of the balloon, that is where we will remove it from
> the balloon list. So we cannot have isolated pages in the balloon list.

Indeed, I see isolate_movable_ops_page() is the only place the beautiful +
consistent macro SetPageMovableOpsIsolated() is invoked, and
balloon_page_isolate() invokes list_del(&page->lru).

The only case it doesn't do that is one where it returns false so the flag
wouldn't be set.

>
> Let's drop this unnecessary check.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

So,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/balloon_compaction.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index d3e00731e2628..fcb60233aa35d 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -94,12 +94,6 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  		if (!trylock_page(page))
>  			continue;
>
> -		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
> -		    PageIsolated(page)) {
> -			/* raced with isolation */
> -			unlock_page(page);
> -			continue;
> -		}
>  		balloon_page_delete(page);
>  		__count_vm_event(BALLOON_DEFLATE);
>  		list_add(&page->lru, pages);
> --
> 2.49.0
>

