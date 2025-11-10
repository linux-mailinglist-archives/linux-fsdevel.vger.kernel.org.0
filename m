Return-Path: <linux-fsdevel+bounces-67676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63103C46474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 450CF4ED1EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C9309EE7;
	Mon, 10 Nov 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ocahkxWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wSD0TC2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83F22538F;
	Mon, 10 Nov 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774131; cv=fail; b=gdmrKGP7y1sW3Jtu40TGJKecguTxaChzYaGzGrs1BqDPza4uCn5ZVmnj6B+wZcXiS9mGOG5Ersr1kk/h6r6+/6mtKpH0kDkbtmdyqhsu/yERY2yUYvXC1aXtAFn7yBmTPB03v5Z05Zl/F3avA3iDrHmzdCfmdIyy8yOkel51dyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774131; c=relaxed/simple;
	bh=766NDH5E3A9mxIDVN5S34mk6lEdByI9VlX2Gadf/BRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+QIYI2Q4O6vEJTDu6pDNTzPSJ5R3QGJRphC11wK/7BKduA6pVb6ccKmzo0w3zCzxeWsLhZC54MSoizlLecAd/r2BELSaLovbEtOdQlTYM/iz+LQsu2y4VQlOJ62W0QXLZjCL8RRXtgjAVhoKd5z4mKlf0uVQco+2YhFKSlyx5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ocahkxWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wSD0TC2F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AABMGRB026238;
	Mon, 10 Nov 2025 11:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=766NDH5E3A9mxIDVN5S34mk6lEdByI9VlX2Gadf/BRM=; b=
	ocahkxWc+DfFHs21hSdifJRbRY1iiZz6AOj0KLo1RvcgYAkMdpUxJlG7Qgn1aXyt
	sMMLBYqx+lkUB8gyXV6JpfQwn4/s7ohSAB9Jqdll78pS3In3yIijK0lbOzLSf6Bq
	RvYTSrael0GB4AX7YXRntD4RDdU10XjHrFqSvAr23/xkccybEIos9KOw7t5A8Vkq
	MxLGkOh5R8u8jnhrYoP3y3IVB+MVYslrloQMmBRmsqUz1+B4rakQusOdlbQBAZAu
	rOw7VHhawv4VGkPy59bCQYOWS53swpd0iuxF3bVLz72rtzlcl3ufofXW7C93X4e4
	DLZNjwGQbVJdnBv4gYNVwA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abepk028p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:27:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAR7YN020909;
	Mon, 10 Nov 2025 11:27:41 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va80tpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC/kTjUswtlNaHtGSxIXA1TL0/GPjkjluIskZ7Y4Bnah15DSFfp2F2P/E9JJZflymfFmmBFUWdrgWhBfLs8Gvji3MZeFWvaY/yn2EeaevFzU91/Nj6EANEoFDnhvpwoasoaNK3aHl/ubMwB/E7RT8WmVEVRyQJb6rRLQWorIChw5fzuMfnkQ1nNxdqWUyCb1feBUWPBVPSbSznJIXs8TCgiWDVd2RZwHOJa/gNDmznmo/Bn9YPOKBRila5OIHwOArhLXNdBju4oNSpuAFG9IHUzA6JqmkjOuE9ADxoJksZ3CDp8I9fSbNAjhcAcPqHpZQlvIqYq4zMoUp3ZzKKYtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=766NDH5E3A9mxIDVN5S34mk6lEdByI9VlX2Gadf/BRM=;
 b=jkT0kv5qFqgOBi2OzpiWAyYenQmiz3Wn39c9EY0Tbve3Qqb6pciq8NigDGRfzkMp+i4pXihsDSDpbLkZ3rilYnf0OI4mYufi6rbcNjhjYSUra1q6KyeRWyDpGljPTumPqrarUljC4QQj7hyjez6CCMsZCHUV7Q7A8Inq7njJDy40c5TfTNz0SDJRSnfN19p4AUdIesssSvxYAgMMdo9+fbBp/Kh3eG7g8zDiyYplDcBrWba1Nz1O+ZNMrfNiCXxKhnJZRUOnVocWPktoR8+LPHQDMF3JXQkgCD1VjesmnsxSVOmNxe9mL6HK6/PjRGFcfyHT59BevZzFF+u78Oh5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=766NDH5E3A9mxIDVN5S34mk6lEdByI9VlX2Gadf/BRM=;
 b=wSD0TC2FOaj3jHfIxSry0eH+a/qtYOoLHZSbohJIE10G9/nyTB2b6vndh9ACr7IRDXskdJfJIFwaySE8InP2gEtGTz9rjboExWLUjaoswJxdpYP1Hz4ocHFmTXAWpGBMxgybMqSTuau/f2O4zk5agC/ajCMcTTiFEpvusjrPtYw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6108.namprd10.prod.outlook.com (2603:10b6:510:1f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:27:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 11:27:36 +0000
Date: Mon, 10 Nov 2025 11:27:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Baoquan He <bhe@redhat.com>, SeongJae Park <sj@kernel.org>,
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
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
 <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local>
 <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 433e5722-5f8b-48d4-8529-08de204c264f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmkyQktCWkxTMWRPWUUwVVJvSFR5elRUYUp4VnhNM2hWaitHQUdUd01mK3ZX?=
 =?utf-8?B?SkZNYklES1NIaDNwczhscnFVeVJhODVkYklGWEVuMEZUcklVcGI2aWszMGJP?=
 =?utf-8?B?MDFvRzd0Wld3bVE4VHUrL2dXTFpkT2dkNjB4dnE2SWJMUWh4RHdXSTF2M1FR?=
 =?utf-8?B?eTI3UWQvYUs4b2FrencydVZ4b1VvbmMvb1p6YUVCMTIwQVJpNHhXbkV2enFJ?=
 =?utf-8?B?aTJqODh5VG00Nmswc3VwYy9TR3JiQjA0anRUYXZYMjFrS0ZDeVZrSXBBTGN2?=
 =?utf-8?B?OXZTZWpRK1R2YUlKTVVwQXdzY3didVpuM2NkYkd2ZUZyc1l2OG9XVzdIZG9Z?=
 =?utf-8?B?KzFSVC9uMDl3dEM2V0VZOW5hT1Z1RnlNLytpbkNlczQ2amVpejY3N0hlQ1ZM?=
 =?utf-8?B?NmdrZnpmbHM2WkRzUURiajBnMEJCaFlveFMzRzhxNktBMUNCMTZVcWxJcDZL?=
 =?utf-8?B?QWh3R2xTcWNoZTFONmVMejE1VXhMYUs3a1E0dlZlOHhVS3VCVGJXK0NQdzBp?=
 =?utf-8?B?dHdZL2RqemtyRmZ1T3NNei9uWGNhbm1veXArTTlpRkkrQ1VkSkR0ZlNjb0lN?=
 =?utf-8?B?VGpiRGd6MENSbC9rdzFuaFpqQkhnMVpnV0s5Zk9LTmp0UktlZG1vMG1yYy9V?=
 =?utf-8?B?WVkva05PRFYvV1F2UmhPdFdhRVY2LzJqTUQ2dVJBQmY1NTFET082R1Q5RWdE?=
 =?utf-8?B?ZDF3R21RQks5c29BOThScXpIcG13L2dDNlVSNEJGdHhjd2trTWMweFFKVlBV?=
 =?utf-8?B?cDN4aXJyNHo5SEN4UEE4WjFIOHlwYlE4dU9kYlpNR25kTkwrOTNUdDIwbU9X?=
 =?utf-8?B?SzEzM1RlOGVsSUp6dkpYaTNHbUZ4V21jSmNjUXdQOG15UXVkaUpBTG13R21j?=
 =?utf-8?B?c3A4RTBmZ0hnL0UyTUNKTVEydUZodnZYVWxqemx4SS9vdmJVT01HQWNPZUhn?=
 =?utf-8?B?ZUY0QTBrUC9TNklsRFBKREhhUWxxdW94SnI3Q0pweks0UExFaWFnQTZpMTFh?=
 =?utf-8?B?eGc2VE9aL0dlWWJnK0NlZndTTytIRXZWNmxaNGw1RTRtWUVVZnVJcFZMYXBz?=
 =?utf-8?B?TWJrQ3lRZ0owZU83dUIzWGlwMnEwUUkrVWlWNUcwcnVreEhtS2xhNkZrNHZB?=
 =?utf-8?B?M2pFSml3M2FSU1pVcThsYUt4OVN4NUlKT2xaa09CblVhc3ByQUdEaXAwR0xS?=
 =?utf-8?B?NzNWQnVmS0FzR3lmSENCR2JpWVphcTllWDNsektuRFdnZzZrUW9WQkhpSFZI?=
 =?utf-8?B?S0JRL0txSmlnSXBaNkZTUFVKM081NUNkMXo3NEVhUkNtMzVpMW10TnV5RlFn?=
 =?utf-8?B?T3dMNWEyTXNWdVA1aDJ6K2RXYm9yclN1bXJIeEE4andIUWRUbjlZdERDanBn?=
 =?utf-8?B?TDdSeXFBcWk5b3NnSXVDbWJjRU1oOUxrbzdlKzNWR3A4S1ptb1RYUURRZnhE?=
 =?utf-8?B?MnJEUE02VldoNFZmTXVIQjRjLzZ3ZDBORUhqQmRBRjl4bzBZOGErcHA3ZmY0?=
 =?utf-8?B?UXh2UlBBeXBwRW9GZkM5dEtNSkFyZGVJRmpaZDAvREJobStJekZCMlUwZUR1?=
 =?utf-8?B?RnVxVWM2UDl4S01OMTRqSERzY1poZ3BKcjZFODQ1K1FZYThDQjBXVHM1WGhQ?=
 =?utf-8?B?MGZlb3VCMTBTT0pjdzgrVFJwMVdLQnNBdEdBNlMvWFA5YTFqSDRTSnRMZU9m?=
 =?utf-8?B?MkVjNHkxcTZLYjQ0djVGakFudW1MMWlmMnJQTG5lcjNEZk5rd3FNYWNPZkVu?=
 =?utf-8?B?d0dZbjNkVUlVVG8wN3U1ZVpwWXc4SGU1TEpFaFMvRU1kZTY3dUVFQmJybjU0?=
 =?utf-8?B?d3RIRkIrWDlRb2tXYmwxdFNJSDYyY3NWTjczS3cwZ2ZWMCthdFRjVHF2SCt1?=
 =?utf-8?B?VHoxVi9Mam1RWk9wcnB3a1VtNENHNytDcUZUc25kZEtPUXNXZU9aeTJvb3lH?=
 =?utf-8?Q?nMBdkAbjYyfMBdedu1tRZEsDpRIlo4H3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzhnVmJnTFV4NWN3VWhKdEF5UlVENXhFdDZ3WnFGSTkwckxUQ0I5bGZuTDdI?=
 =?utf-8?B?UDNkTXRGTTczWDdUZXNERnhxRFM0dHI4NFhVRkpkaDFFVDN2VEg4SThvY3d3?=
 =?utf-8?B?ZWpNM1RTbmVZTzd6SFRPVnFWUlAybHZ0dGxQQytQREdlL3N3ekZMb2Fta1FH?=
 =?utf-8?B?cDkxaFkyaU9ta01aVFpyR29XV1pLam4xRlJUUGI5Sk55L2RrM3pLNXVNeG1k?=
 =?utf-8?B?aytVd1VwSWw4ZUR0UDUyVkY1Tk9TUExKUlNjMFFtU2ZzK0ZVMFFTcVRlUmFJ?=
 =?utf-8?B?M0cvMXg5TUNGdDBWWDdWM1E1bFBjZG5PL0JzM2tiQzdDR3NETnN4SUlKbDZT?=
 =?utf-8?B?a2piSTNhVUZPT2RIeGNmRGFoNVNrR21IUjBzSXNhY0JMT1htZHhaNlBQMTk3?=
 =?utf-8?B?ZG85T1UzaDZrVEZ2d3dQNFQxZTdMUHhSWENtQXFQeW1hQzhqaE01NXhBVzFF?=
 =?utf-8?B?ckFuTk9kZkFzdTB0dFdFbWNRSWgzOXFHTUd1NGVMT0R3WTdxeWY4NXVBNkdj?=
 =?utf-8?B?cGVoUEY3UUVFdkZRT21CcHF2aTNVaEI0cGRWVmNmcDJpT1VDVVVvRzNxblNK?=
 =?utf-8?B?SUxncFpCYlRHWHZiNzVCVWVGanZaOHZaazlpdFRIRGsyT0U5WjA2OFdQMGpN?=
 =?utf-8?B?ajk1Qy8rZklIZkZrSFEvMmJvSjBiOWNSK05iM0ZPT3dZaEpsWkVEa3RKL3pL?=
 =?utf-8?B?QXFxczN5UW5mZGsvQzdSK1l5aDNIVkMrZHR5T0pTZThtV3IvZVVUdEZPOU04?=
 =?utf-8?B?OSt3TTU1dWpvMThsdkJROGZNQTVpRzhrbkpVZ24rc3RZb2FWUDIybmtBKzA1?=
 =?utf-8?B?N1FueUJwd21oWkRTcHRhQnZCQTAvK2xFWVBmOVIzSmFFeXRqbGtZY3pZdmJv?=
 =?utf-8?B?NndHT3ZCZ2d5eDRjQlJIa0d4Q0VpRXM3am9TMTd2eWpDaGxFKzN2MW01eE5M?=
 =?utf-8?B?ZnFwdkFCdi9tZVFPQlg4ejhDYW96NS9HS1FudmsyYnl6QjdBZm5tNzdpd2dV?=
 =?utf-8?B?S0FXOFovNDIxSWVXYVNZY3ZMQXUyVnlkaTNNL1RjODhoSmE0WVdTV2xZUHlE?=
 =?utf-8?B?SzA0RWUrUmxsb2htR2orTmhSUHljWjY1SWFJKzh5YktuUkhVVWNja3NxM0Vq?=
 =?utf-8?B?TDZLRVVMRk9MR0s2RkwxaENzZG5xN0srL1RUWTMyOWFNNEl0MkVjUUdpRllP?=
 =?utf-8?B?d0REOXlXdXAxUEVrSWZoMVNZdEtjL0FxUDM1aTBiVEI5U25La0tCbGtiN1lh?=
 =?utf-8?B?TkZ3THo3dDBTNlNJR2VzN0JhMGdSc0ErQjVMSjNTbkdpZTdMTDlrV2MwL0Jr?=
 =?utf-8?B?ZXlIZ29sNmNBVUZJY0NtdnlpdFhTWlZMNEo5Y1pxR1ZOaXhjbHgrMnRsY2xm?=
 =?utf-8?B?NVhzQTA5T3BoSXZ3ZXp0OVpWUU5FWmR6NUx4dmJsQm1QSzFJajlrRW5PVUZL?=
 =?utf-8?B?Mjhsc3pBRkNJOUVVLzRjY1dZdkhESWtyU1JoRG53QlFYQ0F1SnlRWkdXb09O?=
 =?utf-8?B?c05ieE5xUGRkaTdlWmpmdUZVTE5uOWt5UHloKzB4U0N1ZHBoS21mc3Bpblgr?=
 =?utf-8?B?THBUQ0pZSGdwZ0R5b2VkUXdZMitXQ3JyVW10WS95dkt2SDViTUxrQ3k2Vm04?=
 =?utf-8?B?Q214Vy9YYm00c1p4QnlwcVdWQmJUL0JEc3pCY0FrZUxpd0lhdmg2S2FDL2tK?=
 =?utf-8?B?a2MzRkJxYmJFZ2NNVWhuWGFtWEpSVVRleVJxVy9OYnRhY3A4b0J1WnFtNldJ?=
 =?utf-8?B?aFZic0FBTTF5U2hmNW5ETm5zcVovbWx3aEs4Z2crZyt2eGVvUDgrSGk0RCsr?=
 =?utf-8?B?SitpT2VJK2UrZmhEaHNyamVxcVVhZGd0QXNtRWtaK0pOSTJoNzBXeGhjZmlw?=
 =?utf-8?B?TnFDaFVyNkpXMUlGK253VkxneEExaWJ5alJCS1ovNTRHRDdCZjBIVzY2NStw?=
 =?utf-8?B?Y0ZQMFNQS0p3c25HNzFjRDhScEcxWVVpTlo0WDJ1dVhIZW5PM0Q2a1lUR3o0?=
 =?utf-8?B?RjA1N0pEVUlZRHJXc0ptRTBnVUc3NHhwUFpVbC8vbWx1eVFXbDJQMTBZeE1F?=
 =?utf-8?B?ZFNqWUtsbUxGbGNXYVM1c3dNQzJRWEY5NGxwTHU5TzNBNGRZMnFoUWtFQUh0?=
 =?utf-8?B?VXdWOWF3Y1BXK2tSNktKTHpuZ3dqTDhZc1A3R3BDbWtjWXNoOFZVMjNVZzd1?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KoSzAQHi58QEM+CfssoJRU6sk2DKJW7XkSc7AytTYkpzgfJ965bi4zMtXTxXH9XMvJErCLT2mryHBnb30pllh7SVrIqwjRx402kghRTsNWv8uFn24bPGS45HeolDHXaUvTmrbZOf6QlsTIMjHyo4hzORwuVVwdPNc6PVfuTbkMzlvkvqaUrFSODbVe8SfeUAFCYwSb2kWqatnNNfapqWH/U/v7nzwbb9gzGrX9JIVpB3a0+c2YiGrxo7mHriBcbdWlIsBJBo34a0/0Om2gjzwz8NoYwkg1zsmowKdVC9O6GpoDBlpwa6jGHGZBn2zx2qklzco/tLJOQ756sgJh0Kk1Uj0l5xySNpW1RSg7WeGkYeVahFnrtrUuieOqGpXCLhdDks3KL026xv+Ddt9EOrzGeeyWlTqFYi339xMNAr9dAiy7dHHlY1lUbZsmVz2YxG2ueb1ogBIE8yCM7ur+//u9lpO6Sod/oDKp6obWFWTCsW16l39LRtRDkiAqxukcqs+6GiPPnb0lgB5vls7VMx+rFAGMszabMu03VhYxwMiHkQf/w2u1P9fLemgn8OPEVzbfmmNlBizwzysYgYdwA181iiHCxvyuNxfo95A0BekXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433e5722-5f8b-48d4-8529-08de204c264f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:27:36.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/EfxKsbBD0EfpT+PmzPZr0CCyvneiMYPL8sBMP48uN4K1IL860TsXYUTAzZdeH+1h9sNvyh7QOqfk0ZIc07XTNrAqLePd3VoYTvVpel6nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NSBTYWx0ZWRfX3GMxI7Xtdyqb
 BwaNyDEDVZLnhE2etjL6QIrWnwyqLWPvHtlOxdNIZNGpn/kYOQNf4dzxKrR1L9mcWZvld6lA4jI
 HqCl8ZTRK5nRqzbk7S7lB5AdNJJ5nJKqYsfTjS+vJXpnlG5G70Ut3sQbvJur7cgdKB6j8HkCexb
 Qe/DhnRINPYHDHwVbCUX6o0iBUHH8vyD6QrADvVUx+fPPwZkUqlBsmRecIyc97iQ/trDkxtcOMJ
 +JPIeIxqjVn09FNlxCdjL2vq4VmXlOiqPDsxWWs2J1siimIPxzapK2oNT9hSidG68t4CZQPXK3O
 hIcVEy6B124JxAYyefDVyr2RfjHdAn9bw31LqEbIlev6xhU3MgmOp+I9FgVoHkfc+lZmbF7P2D1
 EuqU+ve0NPTGwGY2aAwPtUJHHmlUIA==
X-Authority-Analysis: v=2.4 cv=R+cO2NRX c=1 sm=1 tr=0 ts=6911cc2f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=JbhfmLy_ouI4b4Zs1lgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: vqeCPBxCad4VtA1XLMmhU7ZzktqR8hLi
X-Proofpoint-GUID: vqeCPBxCad4VtA1XLMmhU7ZzktqR8hLi

On Mon, Nov 10, 2025 at 03:04:48AM -0800, Chris Li wrote:
> On Mon, Nov 10, 2025 at 2:18 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Sun, Nov 09, 2025 at 11:32:09PM -0800, Chris Li wrote:
> > > Hi Lorenzo,
> > >
> > > Sorry I was late to the party. Can you clarify that you intend to
> > > remove swp_entry_t completely to softleaf_t?
> > > I think for the traditional usage of the swp_entry_t, which is made up
> > > of swap device type and swap device offset. Can we please keep the
> > > swp_entry_t for the traditional swap system usage? The mix type can
> > > stay in softleaf_t in the pte level.
> >
> > Ultimately it doesn't really matter - if we do entirely eliminate
> > swp_entry_t, the type that we are left with for genuine swap entries will
> > be _identical_ to swp_entry_t. As in bit-by-bit identical.
>
> In that case you might just as well leave it as swp_entry_t for the
> _actual_ swap code.
>
> >
> > But I did think perhaps we could maintain this type explicitly for the
> > _actual_ swap code.
>
> Exactly. Please do consider impact the actual swap
>
> > > I kind of wish the swap system could still use swp_entry_t. At least I
> > > don't see any complete reason to massively rename all the swap system
> > > code if we already know the entry is the limited meaning of swap entry
> > > (device + offset).
> >
> > Well the reason would be because we are trying to keep things consistent
> > and viewing a swap entry as merely being one of the modes of a softleaf.
>
> Your reason applies to the multi-personality non-present pte entries.
> I am fine with those as softleaf. However the reasoning does not apply
> to the swap entry where we already know it is for actual swap. The
> multi-personality does not apply there. I see no conflict with the
> swp_entry type there. I argue that it is even cleaner that the swap
> codes only refer to those as swp_entry rather than softleaf because
> there is no possibility that the swap entry has multi-personality.

Swap is one of the 'personalities', very explicitly. Having it this way hugely
cleans up the code.

I'm not sure I really understand your objection given the type will be
bit-by-bit compatible.

I'll deal with this when I come to this follow-up series.

As I said before I'm empathetic to conflicts, but also - this is something we
all have to live with. I have had to deal with numerous conflict fixups. They're
really not all that bad to fix up.

And again I'm happy to do it for you if it's too egregious.

BUT I'm pretty sure we can just keep using swp_entry_t. In fact unless there's
an absolutely compelling reason not to - this is exactly what I"ll do :)

>
> > However I am empathetic to not wanting to create _entirely_ unnecessary
> > churn here.
> >
> > I will actively keep you in the loop on follow up series and obviously will
> > absolutely take your opinion seriously on this.
>
> Thank you for your consideration.

Of course.

>
> >
> > I think this series overall hugely improves clarity and additionally avoids
> > a bunch of unnecessary, duplicative logic that previously was required, so
> > is well worth the slightly-annoying-churn cost here.
> >
> > But when it comes to the swap code itself I will try to avoid any
> > unnecessary noise.
>
> Ack.
>
> > One thing we were considering (discussions on previous iteration of series)
> > was to have a union of different softleaf types - one of which could simply
> > be swp_entry_t, meaning we get the best of both worlds, or at least
> > absolutely minimal changes.
>
> If you have a patch I would take a look and comment on it.

This will be in a follow-up series, will make sure you're cc'd on these. There
is more work to do :)

>
> > > Timing is not great either. We have the swap table phase II on review
> > > now. There is also phase III and phase IV on the backlog pipeline. All
> > > this renaming can create unnecessary conflicts. I am pleading please
> > > reduce the renaming in the swap system code for now until we can
> > > figure out what is the impact to the rest of the swap table series,
> > > which is the heavy lifting for swap right now. I want to draw a line
> > > in the sand that, on the PTE entry side, having multiple meanings, we
> > > can call it softleaft_t whatever. If we know it is the traditional
> > > swap entry meaning. Keep it swp_entry_t for now until we figure out
> > > the real impact.
> >
> > I really do empathise, having dealt with multiple conflicts and races in
> > series, however I don't think it's really sensible to delay one series
> > based on unmerged follow ups.
>
> If you leave the actual swap entry (single personality) alone, I think
> we can deal with the merge conflicts.

I'm not going to be changing this series other than for review feedback so you
don't need to worry.

>
> > So this series will proceed as it is.
>
> Please clarify the "proceed as it is" regarding the actual swap code.
> I hope you mean you are continuing your series, maybe with
> modifications also consider my feedback. After all, you just say " But
> I did think perhaps we could maintain this type explicitly for the
> _actual_ swap code."

I mean keeping this series as-is, of course modulo changes in response to review
feedback.

To be clear - I have no plans whatsoever to change the actual swap code _in this
series_ beyond what is already here.

And in the follow-up that will do more on this - I will most likely keep the
swp_entry_t as-is in core swap code or at least absolutely minimal changes
there.

And that series you will be cc'd on and welcome of course to push back on
anything you have an issue with :)

>
> > However I'm more than happy to help resolve conflicts - if you want to send
> > me any of these series off list etc. I can rebase to mm-new myself if
> > that'd be helpful?
>
> As I said above, leaving the actual swap code alone is more helpful
> and I consider it cleaner as well. We can also look into incremental
> change on your V2 to crave out the swap code.

Well I welcome review feedback.

I don't think I really touched anything particularly swap-specific that is
problematic, but obviously feel free to review and will absolutely try to
accommodate any reasonable requests!

>
> >
> > >
> > > Does this renaming have any behavior change in the produced machine code?
> >
> > It shouldn't result in any meaningful change no.
>
> That is actually the reason to give the swap table change more
> priority. Just saying.

I'm sorry but this is not a reasonable request. I am being as empathetic and
kind as I can be here, but this series is proceeding without arbitrary delay.

I will do everything I can to accommodate any concerns or issues you may have
here _within reason_ :)

>
> Chris

Cheers, Lorenzo

