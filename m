Return-Path: <linux-fsdevel+bounces-53506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C4AEF9E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6E54A2BD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23D2749CB;
	Tue,  1 Jul 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDK9jbEt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DHKgoeTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5B72618;
	Tue,  1 Jul 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375380; cv=fail; b=ddPoqA4nDCLD/sBMN5ueB/7GLG0Omfg0Q2aWKcHjPGOsUQUdEvQ4j9vN9v3W20FoofUN+r3NLGQF9iPp1Yf/ApT8CymF9gLbQeGACxIwrASwmXqjsQG7aEHhdB0JKm0EMI+VIUtc46qEuF5qDXl+q5QqdMAhD4fZK0Z8HopzjmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375380; c=relaxed/simple;
	bh=x+GpfHL8OizGSjd0jyVF/gPfFV23Yqn7UWej3PL+zGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l5LO+ef4Dr5LATc47pv/aNe90fB2wFYWhmZpZGCyfiO38uDAcbIH3RYKjVC+W2tBknxYiRMmE7OXJldOxjRvRN5gBKIX1XcknDGP0jg/CQLjzBqDRN8jYCYebJOB8wI+ocmvogC3PrOZXwkxU6grLKm2BZvSVyV/g1Mp6hxnAew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDK9jbEt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DHKgoeTj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561CSVtN012595;
	Tue, 1 Jul 2025 13:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/jvvYX0yfBWR2FmDZw
	nd9I8HucP+isADjV69LDr8N9Y=; b=aDK9jbEtFlIqGdg1Bdg9PFBrKosP7+/RUA
	rX7Hb4LcrzYacPQJQZWSQMwNPfg5GvdOg8OB7ks4FyN011mu2elhjTkm3nZBzjBp
	/aV9SnUl0HspMvFGpT3iaJ70bdUaprbV2opKDH3r4bjo7VS7X+4roAM/pO2nkgnF
	AU7k+NBtPrE7ojwAlL9kz1lS8OZqvoqyZWqvnHRmPC4Vz+cMfzZ79mAzvgpuTle7
	GoM6uY8lRpDxsPqp3+2ncd9P2/VrAXMh+uimReRWQuhYk7GOuG7BUa3LChEmXNTS
	tl/+Q8lXy8Dhq459xBy3XscEIRB0R7uurZvN31cto8CzR+MllJuA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfcpe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:02:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561D0qvf029851;
	Tue, 1 Jul 2025 13:02:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9qpmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meCQQQrPCM9oMEhkn4br7Xly8iu9Z3Y1CSvs/2kDEZ4BzXQ2U/2k3Wtq8oJlKYabjgmmkyFlnFn3LATQ3BMhfsTRFAooanJ/hOIyKB+UQgymun7HweQ87XeAd5JIM4qTunNRG13ySc10DFqrsOX7ynH2Zyq+tgq6T1LVuNxaM4Wo5v4J8i/nVIm92rf3PN5PTTUDZ1xggIy9/2rLMv86naXPWAgRvfNbEMfAqTYoQCrcTZnVr2isb1XF5zumR3+QJXerSBuORrtCJTJYKdEXpOZNkzQznIfBOCZ5brHaGpEJQ2zcM8SVaum8OEr8v1Uir8RCaZxlW3EmZ1KgZGq7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jvvYX0yfBWR2FmDZwnd9I8HucP+isADjV69LDr8N9Y=;
 b=jc256KBOkbIjG6vpDgJkfmAbiuYxh1L0U6fRdJZdUTa60o1Jt6Ql4ysXcLLSbyZWGwowCRkk2RxaEbU/XKo6lWCMkG3KBZpuhOMCve3gXd0ynU1mNHmxyjasIL0tBmvWxu1E1sr1Su/t8a23TYAzSVVnfyyWQMveSj3ykqk57iVPADyU409LlN+Z+iQn4Uno7vFSwhd/iwwMjBHFvtVjc80lDwiMf+awT/+5fwU7bDXtyir9RZXLWxHwUZLEMRqEDB5Ukl0AQkUQB7C45lYbskNxZ7+t+kjjb5pM0m+xH0jiqPzng/uLZ7oyQGwdoGZZQUghkjZuw0gaWJh94MGLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jvvYX0yfBWR2FmDZwnd9I8HucP+isADjV69LDr8N9Y=;
 b=DHKgoeTjKQSeLL7PbO8+m15QxFe2gJKbrk+3LeJw5NfrGNVZmwSL6FIKdtEG8JUy64MO0+X0ZY0RMajul4ltqvOP/hy1Jh8GYNvtC8NrvKHPARwHywk3NtE5HDAUVY5e7B3eApDtXZSGNUONRDsutxH92GbgBA+CPcDe1uQSwXw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Tue, 1 Jul
 2025 13:02:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:02:45 +0000
Date: Tue, 1 Jul 2025 14:02:43 +0100
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
Subject: Re: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
Message-ID: <8ff24777-988a-4d1d-be97-e7184abfa998@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-24-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-24-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: ce13e27c-1841-46a6-371c-08ddb89f929a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JOf0srUSuvgqXaf2rw4r48Ea64RMEEpLkAsK+uOQ71++NkWbluHc3oQYwR4R?=
 =?us-ascii?Q?fJEZb1KQ1cQRkHkMR1Vb16k8AFLnTHBN6/yG6ZrYLA0ruMqszH2YmvxMMaV0?=
 =?us-ascii?Q?lFlWwbRFmuwtNXwziglm8nD4t1B99A2S7D6eIneYg/ahBrlabkqh197ypJuB?=
 =?us-ascii?Q?eHVZi/YPZfRva6FMTAuBOvqXWR9ZWyV3r5VfKVo+fc1FDVlORtqAeVZp8O6F?=
 =?us-ascii?Q?ZULGASIZ4VzbV8nQp/bFlxXTTlG/VfQHce0sFPYUU3E7zOeIkiGP4167WCYr?=
 =?us-ascii?Q?xjONQMWJ883oU9+W+f6aoWAr6WytFobw5sn7o6kQMQTSjJzY5IBcXJ7+Bcc1?=
 =?us-ascii?Q?lqNQB0SEKtAO5qgtLxbRQx+MVnWeQEC9aGIy8TgwUMKxO1t0wavcHSNDnplR?=
 =?us-ascii?Q?N9gPfBlqvteGJVxzhzGt6DdGadEyFv+5lPHSFfWHt4DvtKxMjKBFgJaX1RRc?=
 =?us-ascii?Q?6ZxdzJXsPKQR7uRE43D6EOqkJVamDBgRCT5NLqlyVJ+aRfTdVXmP4gdVRlzM?=
 =?us-ascii?Q?yAprV5jo7RCiefq8HSxm5fuEFikGFFy5/zSEyZDMY5JDZDL/m+zOxtuqoFcG?=
 =?us-ascii?Q?GLBh4VJYMvEMUAuY9AFtehCnkcmxs07fBXsXCngbptxWSwUIxvK/PvWsnqEI?=
 =?us-ascii?Q?ZWV8GARq9hlqbJN+bBqMPqZP1GFhkVxFspN4q9/k0RZ4OYsnpCRw7gWTZapo?=
 =?us-ascii?Q?PsJhiDLTgcVVad+lpvDFL38WBCPbOQeuyiN5RqyeqWRp8bWwj2ynulHox+wD?=
 =?us-ascii?Q?tmr5bm87FSMKY96tZNbEU/0OPAQqIFw860L55H7KyTXNyVi0MxNb6JsjuD52?=
 =?us-ascii?Q?sajgcrrlNzbd3H0DRSQAsynW5LKzKogsB/FQozSz6CQGZdA7vtE7hrKgR6Lf?=
 =?us-ascii?Q?R40+wlB15ZiJo0Dbw9SnEDX+ZFsSKzGfl0JveidPb7LGo9P+nE/RFOtFFq0z?=
 =?us-ascii?Q?5C9HypYEb7CW9v/Nwc5JGxGLGMH3MNs8CAuRXfe9XXAtkvKmyK3zfVj7PwX+?=
 =?us-ascii?Q?C9QorwsNqh0q8SBg4zQ62HWh/Hxy8cAqFThSzSsdCiXbXtQ5rv43GDFqEnVG?=
 =?us-ascii?Q?IrkYIwbV5XDIO7GATWVG5emriR/xPUG0BySEw5zbgjjOPI8rk7oVz1/I66Qp?=
 =?us-ascii?Q?L+ggBvWzOvG1jgiGd0swdEYCu2cSjeBKHqT9Cbk7Pvh0O5yfZD2GiFyGIXWl?=
 =?us-ascii?Q?vOtVSghBCWe4UzF+Gxh7JUY2wPi9dm06lEOx0o6B85KKy7bifeDEsM/kqp4/?=
 =?us-ascii?Q?oErrgUFxzXDQGGQnWNA3ZrEFfgJbmN7QnJ5zqrqkq9ti/61ehtQ0odq3GvGN?=
 =?us-ascii?Q?KjVrjD2NopGqE7o0AOLhOKt93XjICi79hJ4WWpJWtTcUhwMufO/WEJ+SFWNb?=
 =?us-ascii?Q?Vx929dQzOfuxsR8Jj5XRXz0kLrvu2npjIS2f25IAm9+IUfsuwsAl5OnvgVuH?=
 =?us-ascii?Q?feQBU08TkOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37laApCkE3zB2B73OxIagWZvYlHGzD3sNSdPUFDbFDGhpx5wlu/pa8lwTaF1?=
 =?us-ascii?Q?K6C8BbcbyGklWQnISsYbB32Yaydn52I2W898EbZWlC3At/uWTy4c4JSpi47Y?=
 =?us-ascii?Q?uY3ed7IG9pzy2w6Crr0NZp4xpTdilI2duEPY6CU/CO6nvYUVwzaohZzijh9P?=
 =?us-ascii?Q?BUpgwqJaiUIoSSZEX6WgF8aH7u5gQIMVfbaEJ9O6b1ZAsoXyn1eltzl4UW8X?=
 =?us-ascii?Q?XW0tbo/2lrGweDA5PEw/Clwl9fuJoYUdKpM6NQEcnrFHnuKQotraf2/V9liZ?=
 =?us-ascii?Q?76PL4NAO/Wi/UZmU4sY6HMrjbQGHWCsfsdhCyi0mawwRtKd70AdCu4ekbgRT?=
 =?us-ascii?Q?s0Wb1gSL8HFykQGn9OJbenVvyVMRxptdqBqw6TXMRCdsZB90c1enZif8Rdaw?=
 =?us-ascii?Q?FQMC3IXmbFlbMi6vS/Qe09+a3y9JcxFErAS0ZbpzdLnAbl/ofw36yaFEBo+g?=
 =?us-ascii?Q?fvF66DZlNqmKDLd6ICS6bZAmyJsNV0gWcdOUHy7URP6jD3iS5KKTYmgIVCqV?=
 =?us-ascii?Q?L8FCqeC/t+BXeQAwUEflPToAxy2c6Stdcw11sKoouGosD5XFDKKEdegDQksc?=
 =?us-ascii?Q?tmqfTONm168oRqpuA6r4/1tXhoHrEgVbs6zALZDbMqSVRElVvRBZIKyu5cNk?=
 =?us-ascii?Q?xrX4nnGb4cb7yJf3BejDhXu/vbKLgO7KhcWuTDJf+rLD8WerDW8AQokhbjvJ?=
 =?us-ascii?Q?0SG8HT0OyMA2cxXQU3l+05MYUWP3s32vuX5ZVSaPaNB9bTFVC0U6e+F3xIZK?=
 =?us-ascii?Q?ZquGNP8DRcQeWLAk1nkhoQpgkNu4zbbrKxlMgriBt/5U8gF/tag6fmhpRhAe?=
 =?us-ascii?Q?BlOlq0laxxeNV5RPurG7ugi/79c9hUpOXeH3GBX6PyLmvRwSjYMaTvN4XKE+?=
 =?us-ascii?Q?Splk3/0U/XVtTdyxXoW2X2EneS0Cw6aCirLZypFBUnM+0qHkoVDcuB153/0D?=
 =?us-ascii?Q?fZkb9ICn8bkhUiJSOM1LsKa7LF0elkuQCzUveOBLiWWk1N7d7ty6dzh+KGBO?=
 =?us-ascii?Q?Xsd50N3DEjsARBi6mVhWuQNwNLj0lSY54N0Sb/oNGPijpoK8y57P/GsVOH6k?=
 =?us-ascii?Q?Kg3ozXj5LKQnJ4Z+BZV/AGQGKBtzljie074aaCdGMRUqSk/Ofof8Sk/Jk6GK?=
 =?us-ascii?Q?dTtQQGtXFx7fJQ/ht4NWJ+9ys7EBjKP3+swhsJBexWQXtpyLsvYVk5LEqYXj?=
 =?us-ascii?Q?5DoUvQxd5E+UEjBjkO3mwljaaFIqszDc/nWaTzgBI1VWMcifKr6dyb74VN7o?=
 =?us-ascii?Q?l+2I6rVkMjQ/bGVqT2Q1FL6vhnLyQ50B/1qUjNrflKmOTO4FDv9k7b//m3M1?=
 =?us-ascii?Q?CNIcu2swheShXcBmTokLuG3LIIDUj2kiAFZU9/sB3UdE4peWUB0R2faHSTO0?=
 =?us-ascii?Q?LxuTNfm3bHlYjQkmlLZ+K82zGno1vZIOmNVOK+j1Lv55bLyKhveeR/4SolP/?=
 =?us-ascii?Q?oIFdiEO4gJ0Bu8BHtZJOQD2bSlywteGrUr5U6ExFAj8d47CXHO67MSass5uU?=
 =?us-ascii?Q?NwQ+QGY66vtl2v+6EGzMRGyxzPYW6Ci2aoFJZo2p9b4208eVmWD6SC9z6c+4?=
 =?us-ascii?Q?/vN1hAl7HTDVMQLbQ2dhbcjPsRWGNgpPSpY0YsgfaTUsJcJ5b1hglFo58m7x?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wlXLJf71p6Cb9pNJuh4G0vgvgDk7/RJ4Nqx04CkCcrin5uZwcDPdHBY9WJB8IINP4SL4LwEXlLudIAVLsvX+zWTu1F9Xzx1Vwjd4TvanBLezLIhs+Rl9anmd59L4molPDq2wI5Xi4VDJNptZtZHj4CybXh9mlxVlQs4YnTooyPevKQi5EYmm2RvxbXInjF95O2nBQ4MFunSjgT0RqLDVPkhd8bhiBXa6Nq12xBPgRf4Foerv5aTKa/6rmgGEo/xDJQg+xrrZTyNFxTE58TIiG/ZJrqe4eiqPLp/5kQwmClQg7gwL8yBL6EyEz3KyU7tE8E6S88PikeacmmroME2DSMApIq9umyD49AxOvk88X9y4RKcRKsRIMDoxR8v3+Zaoo05xYySEMmoRxrUf2rfqnMEQjqY1RQxIWd0oPtM1RFSyBSRTCEX6zczqEEaP9kFC0W8DEinAani44Rmu5VnIQhTM1nWuqtsijp1Gu191YqbUDI/hUwQNFjVB3x7tuxL/pLbeLk7RwRREWMu0DGn5C4aj8mUl8dV2YfOgeX7tIlnIe8DMtlFF2U6+IcFBddQZKlysAX/IQ4Zb/QKV3uUCV1p9XNiHYlFOVymT8p/anrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce13e27c-1841-46a6-371c-08ddb89f929a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:02:45.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dknKvvON3tBxqr0//abNTqMSPQnFiOD7yCsnq1GlVnNDODR/kF7Q+MoRMK4c+hTT6Hjw8cLB5kZWS+GZSM8g8sCTRFeNYFXtLbDijnu0FUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010082
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6863dc7a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=2uYtEvTHmWmR_0hr5ygA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 3CWKfytkXTal-6XDCRbbiVvNUONlbTY0
X-Proofpoint-ORIG-GUID: 3CWKfytkXTal-6XDCRbbiVvNUONlbTY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4MyBTYWx0ZWRfXzlVjSr6WIwsI 18KoQN8Ruh2JFfZaUJUPjaQJLY61Hrqh6/+EbEkQ7cp1LQH+jHPeIHIoxDcpUIgwjjm377UaOFh hQ5juga4J7Up3EAfLGfsWAcuOsY4mHss/qo9wEljJ6W1DY4UhQCTS1Is9B89/9PLcb/S69G8wVN
 zmHIHnm08uiNtYI1fyzSirrW+1r2ZdbQtlagi0u7dQhid+QT8u5Fs2H9IWQaoDZN+scDIZ7iZar JsFq4/JDyLHKBBTrDh47CG/7PS3sCcfg90Mb3soeat5cBbxCfNOn4jIM8uJIjD5VAsVQLVEXVAt i27qLbE2ymN90FIIdtqXWsSOyK8LBhIORperblAcmBeGeSrgUUMulR5XalefHkcV0iNG+ZPtmP5
 sVmip3F3ZRztLuaqodlzjimLNEoaNRrGJq2XQiwwwj+mxQOzL4hIOoljYs75cmrF+3XknMbN

On Mon, Jun 30, 2025 at 03:00:04PM +0200, David Hildenbrand wrote:
> We can now simply check for PageAnon() and remove PageMappingFlags().
>
> ... and while at it, use the folio instead and operate on
> folio->mapping.

Probably worth mentioning to be super crystal clear that this is because
now it's either an anon folio or a KSM folio, both of which set the
FOLIO_MAPPING_ANON flag.

I wonder if there's other places that could be fixed up similarly that do
folio_test_anon() || folio_test_ksm() or equivalent?

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


> ---
>  include/linux/page-flags.h | 5 -----
>  mm/page_alloc.c            | 7 +++----
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index abed972e902e1..f539bd5e14200 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -723,11 +723,6 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
>  	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) != 0;
>  }
>
> -static __always_inline bool PageMappingFlags(const struct page *page)
> -{
> -	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
> -}
> -
>  static __always_inline bool folio_test_anon(const struct folio *folio)
>  {
>  	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a134b9fa9520e..a0ebcc5f54bb2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1375,10 +1375,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>  			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>  		}
>  	}
> -	if (PageMappingFlags(page)) {
> -		if (PageAnon(page))
> -			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> -		page->mapping = NULL;
> +	if (folio_test_anon(folio)) {
> +		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> +		folio->mapping = NULL;
>  	}
>  	if (unlikely(page_has_type(page)))
>  		page->page_type = UINT_MAX;
> --
> 2.49.0
>

