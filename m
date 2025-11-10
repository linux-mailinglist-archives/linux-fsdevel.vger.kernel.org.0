Return-Path: <linux-fsdevel+bounces-67751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF6C497B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 576524ED9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9081F2FD697;
	Mon, 10 Nov 2025 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="obygojP0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yrw4RAYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D42F5A3C;
	Mon, 10 Nov 2025 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812302; cv=fail; b=CtXcFb60rjlBMRpv+TIKtPTU+P/G8pE7DgdX6xGVOAfDTUeyC/9dmgTZJy5LToLi4GStDdK75dE8wavHKsHHcw7j2DBDriL1EVN2KS9MDHNBbZjM9a86/7LzdHPkCVskzJylYQ+o1wWctsXX64VNcQNW2cX810XoGDenzS0isf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812302; c=relaxed/simple;
	bh=E9vt3/RQSq/eZbv35Y3Of1exxG//i/zxYnU69aFFVSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sA2I+zC7mnd1UR9iEjmhK/beyqyh5q9oUCKGTtaVu0TMxhA1I38yGEEYj9SrUF5PVi91iIe7p1/nyYMTHt+ZISI26R9qxKcuMbI+D4C3vBmrNUGDN6JLIBPTwS9DExAh4xaLIx9Y9LWM66WB2k4iODDprvoBTaejHdhrEcqHaLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=obygojP0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yrw4RAYF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAKZ1bT003051;
	Mon, 10 Nov 2025 22:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KgoqjyycvGKN1rRucq
	q3tnui1hVl9+83z3uP7aQkeS8=; b=obygojP0/7of9X0o0vGV8tOWFRyGlOww5F
	th5yjNLQTqrwKIfgjm8E06OKRDMYB3abCqRTYi8ycQw9/VigaGbh7LbE8HPxf89R
	r1ot/6Ly3rEh0KHzwSWQOo9dF0bQw/UTGQBEYiFufYyWPycHioq2wJRKoEbnAW/X
	39UuEtoJfjERphm3dHE5CMu0O5evv+CiepEN0KGEx8l6kLG17RHhWNzi8qTNhX2o
	dbM37+Xm93fAs0EV+eOCJeeiF/0n/uyS3XySwPF9NbBCzIHQPS2L0ORMkGlplO/O
	+Dkn5q8Ct10FWk65lGSDlnYUbn8ZA14tYkhH+XtPL2tHh6V92BJA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abq7cg6bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:04:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAK4sk5040113;
	Mon, 10 Nov 2025 22:04:01 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8re8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttAT3A6Z/W3d7SHp4ONFrkO/mwOyfU47dgsMiS4lfWSKketT0moGqfNmF04VRUwTF6ehJdF9XEWTqode5lDCpvnRRER2Op9BSUouwGQnbULtD/SuFlxXXNgBD4huirY4yejxNPairGgYfzZXn9CgP7axeTXZ2TJyAmqvq8lvoNd4499bpixv4AmZEoAMzjBuSRrpyThCKEEVXEVvknOqEkLT16qrI1CJhLzpm2B58fzGYg/Rah/WNtWSbQKDqn0PHoF679RZrwMsQcTvwDGtGNIu0cELhxtWzVqQCcLCDlbNkwR2VFhp/qBYjPAyfhoTQEP3bPM4MfvehMIiXK+zvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgoqjyycvGKN1rRucqq3tnui1hVl9+83z3uP7aQkeS8=;
 b=M6b4IuWXCTjDiS9NLw9NEMC8eMMdJoboZ9wlz+4JKh9IQO8YpHHTsOkmt+8/J99Uhj3GZZniWNg43rr7cUd+Q4Er8lpUTT2gBVV2BMcpMBnm6DERxOD2RVa+fn/FmkQmKXz7qDZB3E3F2d7Ums4DrYWxBrE0JICYfqX21sU+yLJwoEBXWiGq4y2i8fEEgRgK5uIFrBwfYsRTj0Yn+WKTEpPpe7WqMhxJroeCq7ghG9xMjZjp7ryXZmRlTP4TNe/uvI9CkJ+SZf0GBDVovuVUA87IxVComIt/MEpn2vUx/1WrrepDLmDZmQ9VDLCuHL4v2wjX7OGUachXFogUumvJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgoqjyycvGKN1rRucqq3tnui1hVl9+83z3uP7aQkeS8=;
 b=yrw4RAYFKCsKA36tj0c1YSt5ctJwCw1o+l1+4O8745SpmjWtWkAIHSZzpg7r3u2nVgfRmF5gWx5v8qsYHPkhKRjdDLQl8gcw1QXaY7o+EU5Pj9X46k+kwNZ393xSM6wwsrRtMjkBLqyUUnobx8TTSCNpA8mMmTp/snYce+6j6h4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB7461.namprd10.prod.outlook.com (2603:10b6:610:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:03:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:03:57 +0000
Date: Mon, 10 Nov 2025 22:03:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 10/16] mm: replace pmd_to_swp_entry() with
 softleaf_from_pmd()
Message-ID: <5961d473-d797-44b3-9182-06d8229387da@lucifer.local>
References: <093e438c240272d081548222900a5c3b205e9a5d.1762621568.git.lorenzo.stoakes@oracle.com>
 <20251108171808.77373-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108171808.77373-1-sj@kernel.org>
X-ClientProxiedBy: PR3P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ae502b-4260-423d-c4b7-08de20a50c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/eDC0rZdDxetf35dG5pPq5XlAmfWmtp6bX5l8Js1NT1G9+Gh+sjExXNRr5wW?=
 =?us-ascii?Q?In1+uwYndx7T0CU8GExeDbSZWU6dtMkenpZUVsruqCJVG/EhbUHJTUTMF0K2?=
 =?us-ascii?Q?XWFJ3cY0cawzIl9ZqIQ6qucyUkE8+hBF8KGf/C09QkttQDvfx5aLBwI95eqB?=
 =?us-ascii?Q?r6gMqQi8ezvomkyuXG0uoktmhFQdzmlZ9wsIsze3LMi/0pBHm4oHP+6EhwAo?=
 =?us-ascii?Q?dDUSnRdG6hYDPoFexu+lV9p6UE2K/r9ED959PqrZIbSzVzkhB2y4k9qPqsJ2?=
 =?us-ascii?Q?WdLdwYxMHuV26nJ7ctSApeeOWRUBIf+5G9wm2+WDgBn7Tw2fdum0ODZEPTgQ?=
 =?us-ascii?Q?XiEu43l8P+qyrwxHgtz+z9hdhtkVzgAMcnronTsdsEOpo0p6hJBmxggAZwv1?=
 =?us-ascii?Q?6WGn3fh13L8QrACoTvisjTWKvO77TZSaYrJ1ms3Y9RmAkHMh4b7cJsaTch9F?=
 =?us-ascii?Q?apooyizS2c/HpHSgzicLiwHw0nzV3bb6fLzLegeKB+yi52DSiHMNjgIV8dgo?=
 =?us-ascii?Q?kT1ei7YwazazNc/HTua0+SBKjmppOj2MGMHTiW/bH5fRv2tmtlhoW642ovmF?=
 =?us-ascii?Q?A+XcsFnPfp/kC0DYOBYP/NuFhci7hUelRUHzsUmSLBKHUwMuxmvg9zzIxs0Y?=
 =?us-ascii?Q?+BAiqarQCUgp07ugWw0jbSa8GFFh18DdzKgwcg35immT4+aXENq81uIb1sJB?=
 =?us-ascii?Q?4id2K/gU/Eyxlh+UsRhLXH04bZF+iSk6b740z7cYeC8bEj84D1DW6w76Lqo1?=
 =?us-ascii?Q?85McwJVwSPjxx9kunKpRYOWefbJ7oVn3lZEZtq/HQJUh8sydFqfD8HzFzl6M?=
 =?us-ascii?Q?8A0VLlEFdF+OFoZG0Z/XxzG9vRatSeR4juT9Cc/0BLBOH4MpEpTmEaMT1+6J?=
 =?us-ascii?Q?9xorQNiPOXXmN/9LF9NVhWygFZkshJwlIqguHup/35kmSMx7dbe8KLmWB4x0?=
 =?us-ascii?Q?8Y/ocOpLPE1CQfRuLBJPiv+SdMMOB1wN106MB+/r6lrnFjJ9Z9H/vVTmdrPW?=
 =?us-ascii?Q?pjNOIcj3eysfMjYEYepB7zFn4YxEIEDN6VaHC6ue6G6Eozh3HbOH9RkUk807?=
 =?us-ascii?Q?YUqkAyvjxCwsjeCCHv/IBK2MHXkL34PDA4DNntldkmnDLHl9V5XmSM6ah7h7?=
 =?us-ascii?Q?AX2gCJ+s4cXBHx7PACzikia8xEzGx3cR1+qVICYa44bFF4UYQ297h5Z45gKe?=
 =?us-ascii?Q?f20YfRYlMHLrDrtxApaGeEHdy2XJoDk7mc1/xEi2YLF/AGcvT/+vn3YxjbtL?=
 =?us-ascii?Q?Hq6pZvaLLn/1JaKW8uFyrk6A3zR4CZNfx4+Oc1bvCH68K1ebVdJZ5ox8VOO6?=
 =?us-ascii?Q?yBFMi2QSi1hzlwDi5a2mOXWY8ZiMP9pfxMRWsKtDHq0rwlLJBnc5NOGgdUsZ?=
 =?us-ascii?Q?HQiuB2OOdY6Ak5/t2wM4bMQSyuj4pO17OzklT5sPjb73ZuNmOufPgQA2UmHb?=
 =?us-ascii?Q?Qv2dLHJRRvb3LuKiSSvIFosUNcAWVhij?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZdjPOCOcQW0WOTY2QDINdqdiGQHdA3EbukvPC1DcWa2qrl1adr9JQad36bU+?=
 =?us-ascii?Q?Ja0zjk8qCx6zD33QQlqivjgFUg7gGn/IPmIom7raqahA+eGrJaNdOHxq9lxi?=
 =?us-ascii?Q?XEAaJH7rwRmlLgDOvZ1lh5cxqrIKr8VY8l7rKTUOZfZhcouxmrqV3rvsjGpI?=
 =?us-ascii?Q?QhrI7C9kSzwNO3+cvuuA6ztkUbvgztPXYziHXUENTGUI5sNx+WNC3ZE+XTBV?=
 =?us-ascii?Q?et2lAA5QfWXH1c7Q9H0H9/57Do5ACiisK/eYcCEgobEYfFDZC1ne18MPTxtT?=
 =?us-ascii?Q?rHcQNuklf+epO6epVRnzWdWRYIri2x69b/OeKQFgUlJlH6Dqjhp83rVpl3CA?=
 =?us-ascii?Q?zY3/45f0Ip6JTFxTQwUXaNLrOCQ8DMo0aKxVBuG9Eifm3tYWAS4I8tSVSu1F?=
 =?us-ascii?Q?JsKarfcdtrSljiSP+Y7e76Uh2YAdJvc1H09kI1fibsDcNFzx0QjZXqK6jY1m?=
 =?us-ascii?Q?XbXmRBtne2YF33c0EIn7TzYxfDlpBLFiMHH60+O5KWZ7HNwShuXdOjHAE0pf?=
 =?us-ascii?Q?biAMR1zfp1xj/vLHNGcVnPT6hYDF1vIPL+gP6geFwkXTrWc7DZBm0mMvr4WZ?=
 =?us-ascii?Q?Z46cqOorGmPuprA0F49gKFvHWFaQa0zL4Gq4ERLnYOVatkmiHrrMc2VI7PvR?=
 =?us-ascii?Q?/r1heTGvSO59KyJhfX1dmblQezxnDw15hG5aMhsbfjTIPuoWwV8lquuFCSfK?=
 =?us-ascii?Q?OMqa9GF4k7oHTll2b2bhsTjuIomG6NVAFmcQmwB86SQypwHmI1dOepNobXaH?=
 =?us-ascii?Q?9SVrLxDlpml1EtRSNlQxzhvqPp/NBaaeHRxdUEr78BU6X/W3dKUK/GkQrIYB?=
 =?us-ascii?Q?w6gh9CjUwz2aaP13Uc62MIpQ0h/F8xAAZYZb2beXrZVeER0yHCijxXTsFbUx?=
 =?us-ascii?Q?5Fr3tMEXkole2rLi1wVIKwITkY82sPN2hiMsG0+EDENjrLA98y2Idd2tWbdA?=
 =?us-ascii?Q?YS9OcR0oG8nauLhEUR25x6ktCcMOgQk6Qb09aLD3G5atvZLloSoVT4n0zLXl?=
 =?us-ascii?Q?RUSI+0wHTU4vJRZVJQk4hA58xIfy/CVeGxjC/TsQ2e7Z8g41TNMH7J6Wkp/8?=
 =?us-ascii?Q?K7PhgsXBFmYZ2VCgIKJqu+jxg2rGiZKU4DncHVxQOqzs9tZlVkudgkdxGCkJ?=
 =?us-ascii?Q?YbeFO/KZqQHPBV995A/9mXod6g4v2stvinq5ZXRDf5gYWrQz2SM43YLRx+2f?=
 =?us-ascii?Q?CsHRUCxaDO2Er6yL1eNuGrGwitfGMhAnYep01ptqKTd74wy3NOxZXPNxq37H?=
 =?us-ascii?Q?oMaMvl1SJQHC43Gt/C9KdeRF97VuiGVFXJZpUJi3KBpEJiM0esQZWGOh6DP+?=
 =?us-ascii?Q?qmHGfn3euu2MXWrWwBnFnKkbSOXeylFIJ2uSYIGJCEVxJRRoD2KbVJnuKFmn?=
 =?us-ascii?Q?FrDPzmKECS19FjJASxci7MqZlMmlugmZjen0PhRv8ahVl08f9f9EIld6Hy7N?=
 =?us-ascii?Q?dQDPe8j6KxWChPDAJAheoeadiayR8Vl55q4fMPK6m58JwTf7QJpbj9uFwHRf?=
 =?us-ascii?Q?66ddTyy3u721a+BokzatK+fUvfwKvI23AMws3cRLbzQfnJ7E/ZlMSY1wjlcK?=
 =?us-ascii?Q?LqfZU+UnFCTK56/HXtYy+lbCdAuxkIfeDAk3P8o/rgMv9eEJwgd+ou5uI0CF?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zOxb7GKtsajeW3+uWp/g8ng4GiHh14LRoNJaU9TNP48xoxzG0zWRMYVFSA3Xe+ytWyaBcTgR0WDxyTp7PL5Xpxe8BZPJXCdAWIAeMxuI5a1qX4EsvxIBcq9lLy0H0sGXQP1qPe49EhIPeigXB3VSTNOyhzz0uXDDH5inqocwD8DEYS0VqwIu0WhITB+4nPUx20t+nKbjwfNZ3m2sZfKec1f1d67PLPk84JpKlkX13TVjLpS8Tnma9Vz0uoAitHTxYc/Nn0SBZ8PEmwTTVmy5gwpY3AsmkE2zrc75QIGm5pMBDJz4gablz9Gw1yGn5KASvxid0XNl7Y1OchyC9G/b212CgtimebR6tEDTU3nhHfUyzbAFRO+ocHsYJhA5Wvi7OP/j83GXuyikxr5fVc7yfBayvfyctxc2rMwRvpVYcdqaJFS3nGE53JKjdsDRNdH9L1I+25lYXV8ZWDje29PXOZK4XyN23ED0eYldpUHwV+nHl7HhjOXicWHGbPfs+bFbOWvKvAbM7accFSHqd2rMQ9RZ/sL5/ybv7mGI0ak6PSLkiYb1Y/Rhk0l7VAnI5PdDupFlCbF764FyKN3Uh4Ji3uJMYY5a0VGwyPwQWLoWG5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae502b-4260-423d-c4b7-08de20a50c19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:03:57.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBlhGr2rUTVFUoI+r0+AgltNGJXY3zE1MXGLT4b6KFzcojpaIQVd1LAur6VBmXJQjixQQQHacgzzZS5vagPp/trSVP8bsfJXjbNyvbjmUXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100188
X-Proofpoint-GUID: FXMgIJqI6weUcOizITc4SHaHEH-0TSbL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3NSBTYWx0ZWRfX6lD1q323Fsrg
 qX7BMzYCleLOp7p5DGKJC4qmHA1O+mOJzVq3aWl7Ai14skIDpBIQmTMRJx5Guv6XIrkPkC7np6F
 bKIamtpLl66hLBKzYPs4nImvjR3GiQMnGrgGwmw0n6w/XPI/x7Sr8uvVLQJk1l+ToNYLswxnM0+
 4GWPdyQVQfcxDkfT+9ZH5KKh8duisfnD8DHYwoyyH8oJGT046Cw/RKYruVCaBCb8uvW4hod2Pw2
 fk5fLO4RfOx4oogug5DTakjQpiLA2PqOvEo8TdFTAe8+8GfrDdpv6bveWvU6wtg13bNL8CGlsKw
 kjfANfeZ4UHjHnknoM9er2/WKdYQ06plIERhPJvsShYvdOET0fe6mDIDUY8yZipAxF6r/tS4CS1
 zNqQG31n4nUEoWYuimzE67B8pDjlkw==
X-Authority-Analysis: v=2.4 cv=HOvO14tv c=1 sm=1 tr=0 ts=69126152 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=XRkx6vdKjniS7mNOnQ8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FXMgIJqI6weUcOizITc4SHaHEH-0TSbL

On Sat, Nov 08, 2025 at 09:18:08AM -0800, SeongJae Park wrote:
> On Sat,  8 Nov 2025 17:08:24 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Introduce softleaf_from_pmd() to do the equivalent operation for PMDs that
> > softleaf_from_pte() fulfils, and cascade changes through code base
> > accordingly, introducing helpers as necessary.
> >
> > We are then able to eliminate pmd_to_swp_entry(), is_pmd_migration_entry(),
> > is_pmd_device_private_entry() and is_pmd_non_present_folio_entry().
> >
> > This further establishes the use of leaf operations throughout the code
> > base and further establishes the foundations for eliminating is_swap_pmd().
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  fs/proc/task_mmu.c      |  27 +++--
> >  include/linux/leafops.h | 220 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/migrate.h |   2 +-
> >  include/linux/swapops.h | 100 ------------------
> >  mm/damon/ops-common.c   |   6 +-
> >  mm/filemap.c            |   6 +-
> >  mm/hmm.c                |  16 +--
> >  mm/huge_memory.c        |  98 +++++++++---------
> >  mm/khugepaged.c         |   4 +-
> >  mm/madvise.c            |   2 +-
> >  mm/memory.c             |   4 +-
> >  mm/mempolicy.c          |   4 +-
> >  mm/migrate.c            |  20 ++--
> >  mm/migrate_device.c     |  14 +--
> >  mm/page_table_check.c   |  16 +--
> >  mm/page_vma_mapped.c    |  15 +--
> >  mm/pagewalk.c           |   8 +-
> >  mm/rmap.c               |   4 +-
> >  18 files changed, 343 insertions(+), 223 deletions(-)
> [...]
>
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 971df8a16ba4..a218d9922234 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -11,7 +11,7 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >
> >  #include "../internal.h"
> >  #include "ops-common.h"
> > @@ -51,7 +51,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
> >  	if (likely(pte_present(pteval)))
> >  		pfn = pte_pfn(pteval);
> >  	else
> > -		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
> > +		pfn = softleaf_to_pfn(softleaf_from_pte(pteval));
> >
> >  	folio = damon_get_folio(pfn);
> >  	if (!folio)
> > @@ -83,7 +83,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
> >  	if (likely(pmd_present(pmdval)))
> >  		pfn = pmd_pfn(pmdval);
> >  	else
> > -		pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
> > +		pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
> >
> >  	folio = damon_get_folio(pfn);
> >  	if (!folio)
>
> I'll try to take a time to review the whole series.  But, for now, for this
> DAMON part change,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks :)

>
>
> Thanks,
> SJ
>
> [...]

Cheers, Lorenzo

