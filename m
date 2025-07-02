Return-Path: <linux-fsdevel+bounces-53645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF021AF5840
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D238F16F95B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866DE26658A;
	Wed,  2 Jul 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeYGpT9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="anZ8c/38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9223AE62;
	Wed,  2 Jul 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462037; cv=fail; b=LVJCWJX/1wKUV64RexFEI7iJ1itXz6ocJImZ9GrkQ8/Qz7gyOmiFug5oSU9UuXdY6pQtnLAqPnA6BbOWtETo3rbYDxM9TSpMNVQ2xTFz6hP/58QdoTWBGyTudz+n8bteUvK9vlD0ntRFbYuuT9o5HaEn7kGB6erLhBZQLzF86oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462037; c=relaxed/simple;
	bh=rWTGJJeU6yHciTu80nDfD8T61MarAMgdxZevq9aDkx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gjUefn9/nXSm1ul0fh1Uvuene83F20fKZn+cZpBXf+CxKZGrbig2eYKWY0Oi15qQcAp6j4vy3sBgZMGk+VHubR2bXxQsZj3Y+17Z/eaYq9me+q9rRmKUogElbnEbYonVgtCzNgYcRYW+35OlwFUPoTt5nJAg5dy3FAX13lqiZoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeYGpT9U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=anZ8c/38; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Bitbi003679;
	Wed, 2 Jul 2025 13:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kNpVdSq4DOlzLEWT8b
	mIENVOjWl5cacy6X4a0AhayMg=; b=aeYGpT9UrdrQ/7UFyLdmP857Be7S6nHI4N
	E9Pj0C3bcbhv/f65swOxKnpr7hpr7KVShMazA9PzqcjyfGusq0ZGeuf3US88tKBW
	EvBm2vWbUrfUOlUex2Hi4XNuUnww21Xb5/QGVzA9TFC3HDQcqr6EEkym3rMJgNQ0
	mBU0xvU4yza8d0yCkK38CHkJe6UajBsEY/B+WGNZdxXfQpyud7LZhu5cj3frIbeO
	cy+2iOfdyDV5bznZqrhnV8/ZgR+C8rsFE/CsWL6ZXYVWR2qOGKBCC7wBrzc7aGxF
	7lWQsnsbWLhgJ2G3N/3vpkknHlD9mrr1b22c1h+S8bZpeTFHdMxQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6vtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:12:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562CJQnv025018;
	Wed, 2 Jul 2025 13:12:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ujeujh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulr7q29/+qdam+HwQBIFWxKbCDlxMHHOn5kMVmPpXj34SxSngGYzx9+EBMG10Owu+ziMnRLl3vLpTiVKx/hdQiNnwIMow1vo/Y2dokdgpS1vi255tTLKZJsZ4TlKG4jOVTrPlG02y4HqZA0sg2DdX8Hcr/yq355DR0jgmrRNsmOpWCsMhNTzc3upLIyWi1EuT5HbFr7t27K/YzyDm3okyuLrUYp+i+hK2gaXNeL/uC2TJFF1YisGQ1adB3toPhSyruLcjA4v4v8zEDeO3pnOF8zM35nYoGvR8Sg6Lu6ORUmui8wRwwfhh1MiR/aLyHJuNPojkh1Kyjg83dOPbavY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNpVdSq4DOlzLEWT8bmIENVOjWl5cacy6X4a0AhayMg=;
 b=THMust7SqAo1yAz9dIQtmGJgOg1r/BMh44pLqhdsPSaajBQ+ENEilWYB6E3zTg48onxfR4eWJs4wB9Z3vcEcncoM4BDwZvoLgKUrfU+wuIgBAzddUU/498l01d/2/n3NdcJ7fNuVvl3pVqv77xM9oHKHcIVWCJLhLytfbzgD+U5UnMbATZ9xy/MjjL4pQAlZ/3IQZDDZYTDq62MkXY4QSBFSYf90THPLSaD+mK9A8j6YiYsDu5Ce4GGLyaQK0tpAqyUL4X+1jczxZDr8X4RubFSEyVQQCKhu0cFtMqqQKkuvxyEhFSKriplTh0tNUEjRm0UpZLr67bYxh5OCziyDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNpVdSq4DOlzLEWT8bmIENVOjWl5cacy6X4a0AhayMg=;
 b=anZ8c/38qMbM+BNSYbo5Bw8cldvbkEvdjH5NQilOu7+b0In3WW7xnIA5kqBf9YWfknUVWTu208T6t/M8HYqAsZV5LxPfgvLfPVGMz16/cxGlLbvGW8E66kgsLZkiNe24bJ6v7WQ0fWOepo5V8iC8Wj9b2VL6KcfG+2QQTNbjmB0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 13:12:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 13:12:08 +0000
Date: Wed, 2 Jul 2025 22:11:55 +0900
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
Subject: Re: [PATCH v1 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to
 PAGE_MAPPING_ANON_KSM
Message-ID: <aGUwG7TLLZzTA1IV@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-23-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-23-david@redhat.com>
X-ClientProxiedBy: SE2P216CA0156.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 136738ff-f96a-4afd-bf1c-08ddb96a0c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmjzzHu/4CBm33YpbHXBzQv5Xg1ULiLDaxgz5Lu1hE2rFuEQkt2Kt6YueA5y?=
 =?us-ascii?Q?Sy63pentmh5cUAdK2NIm1Nds8x+C+gvKR/4XHQ+S+XzVZlo9dmBoDlu/72bK?=
 =?us-ascii?Q?XyD8gM3GlSelUHXhuu+glS5xV1Qkq4BSDWG2H584Lep+y5mwKt7yWNbn/2AF?=
 =?us-ascii?Q?Y0NL6XLLEom8mxrhVznwEmBced/C/7qMiLT+G40WyOVpMaYUOxQWz+mWA84V?=
 =?us-ascii?Q?OqNZVFjWfAezwyR1Br8PAlGt0Rrq3/l0SiRODQuUu16UcKraDXrL6yv4yE5P?=
 =?us-ascii?Q?W6TuURuF605UAu5ero4ZX0qMi1rgH++CM+rTS6O8fD+0m0U7NFzcbe4o0Of/?=
 =?us-ascii?Q?HftlmBjXtGrX6vMKvAnDxGvzWSIfoo3dkeLvha9/Ld6NZhfuOKOOr9UxyAlA?=
 =?us-ascii?Q?eEx0Twf8ujppa9oiYBr+Drp6o5zLx+eWsINXjfO64Xw+U8klUfePwufY7zJM?=
 =?us-ascii?Q?EUvkbywXO82TQ9zNxsUAbnga71RJ3uq9rtXcUUmzOATWBGJ+Cv1A/9kIx0kT?=
 =?us-ascii?Q?omThjhjf4R1o2nT6xEKEZ43FzjQLTDs3PD/WNAdeYBP6nxVzzcJnpaR8Mwh+?=
 =?us-ascii?Q?Uq1iGX4sQ6rC7hkOB3iD37qejFeCE/B9OdJtAeptO1s6VCc1fAWyyzlml3Rk?=
 =?us-ascii?Q?+Y7Bev8CAYdxdJVUXrHpQjE8qctaH7YsrcW0WDf+JRrMpbYZe4DnrIOKiB4E?=
 =?us-ascii?Q?36auUW8uBKMc88hqD/h2JaMNA/JSPKzmdRyMbe5/mGEL3CktUWuLuaSQ1+pg?=
 =?us-ascii?Q?Aqgb3Ae8jasI3x5i7QeDaxPU0An0PmH0Z/zp3YirdjRGgHrHTLRyFVKOHGg0?=
 =?us-ascii?Q?aJ/pyfisMotDqiamHOL+nk5gaKoV/cAp0/DO8lvFKzYUSleDef1S7S1i0bUx?=
 =?us-ascii?Q?q639E3nrD1Z79nXyu5FSFgwRdmF2RWlDkrRuVHP6Khy4YNOpjwTTVZ4JiusP?=
 =?us-ascii?Q?7fmAPl9LHkPQfJLWEHC5dMgrI7pRJQ6w5q+358F35bNY4XlPBH2SAQT4++l8?=
 =?us-ascii?Q?q9eAVqJUs21ONWOZkWohLoOCtG8yHu+hYMmELBfjlQpMV+ecSj9rcIsi3ZWL?=
 =?us-ascii?Q?xYIvpHgKZA8B8Nqc/RcvbKae165OYPjLoQ7Lvbi3JSBd8S8aov9WT6LeAZ9I?=
 =?us-ascii?Q?SAFsjdNgZp1fhrKaAeZG9kpoRKbXb2asB0IFPQ3dAKeln7QhomQJR11k0vz5?=
 =?us-ascii?Q?kDehPOn/8YbUNerVZjbMi1275jA7vA+IxDA66kBDdSKmQuUd7upDiTG8z7ju?=
 =?us-ascii?Q?mnoYaMMFp8i3CXXcQbYZF2QRVlVVOQZMwVg3O1q1yX/YfZgHP0KxDh6NdN+8?=
 =?us-ascii?Q?UQEYsJccgHyIRUR/arLYObEuZ12/rgP31rAthKRa1JRCmgrTjhfA6mZt0JIf?=
 =?us-ascii?Q?rz0uVA94TAt4zzqOEGLrK0nLH3Qeifs48+BTutOntQDVcNY2yrHkKoLcVvDm?=
 =?us-ascii?Q?7ABizLg3OFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OI0SzKNA6yz3pCeu5d8hM12ESR1iOeUjdpDBM0LvIros7nt2mfguvzsq8YgG?=
 =?us-ascii?Q?mYlXykdh0KQZTFakyqfsChjCxWE2CPopyxnoS6l83AiYtN147wtvGA842F89?=
 =?us-ascii?Q?negogaLsKPxa/UwlepZ8cQWGxH+TriPebFEC+BwEpla8YKkxTwLQHAO40Lx6?=
 =?us-ascii?Q?/0uswhEc9iirhH3jfIqKopEdwZopkPa5QSBKrNHD7OIp+CqUEwfyoQ+etcE0?=
 =?us-ascii?Q?KHBJ+ySm6C2cK78TGjeXLjThoEvN8jBAGWgeb0/cgs3287LlJZe9D2EOYBaA?=
 =?us-ascii?Q?ELlHJMnmCMCdUr2vQgmBP3EUXHJPtJS9VwBAIJtfYj44o1fjzmMDLI1H5vgP?=
 =?us-ascii?Q?tfxa6CZcEpM9njsODqdPtWmvSHq7Q9Jb2wlMQ088PRKJeAHv2caGhiXbL522?=
 =?us-ascii?Q?XG6X1cKpntkCA+KeIQ1pe/PfiQMr3tSXgeuU0x2qy0kIT9dK7jCXNJDdR6kc?=
 =?us-ascii?Q?arRloGFtiAiCIgRc2Dlg1KQayhfNqdwfDBE/v0Tpwbg2KOnYRbW8QFb5FN40?=
 =?us-ascii?Q?ZUPovZMs3gHnl3JVaZuIiBGwS4AFuE65YxiOnay+CvdazY6y+MxBFVrzZBrH?=
 =?us-ascii?Q?5FcBVN9PjJ6Upbujx5MzkjVWOLe6MpRruGDY3Epe2V0VZ+dNvQ6LCSzv0RAz?=
 =?us-ascii?Q?LedPfJUEX2J6AG0XK1z0VKDEp2gnmDtVbss9jkMEeR0MGtblKkhXL1zQzbHr?=
 =?us-ascii?Q?ZweZOVbMnNILaFEj2JWIXRFnNtt4h5Tz/jW2XwW1IbCpg6HMjcdOUPKYFMDV?=
 =?us-ascii?Q?x+yD2TFiMCjmt3vJUIbHo0/ASQbDd+0dU0ZtrlcTkwQSt7TsoUY+mnZvXvoQ?=
 =?us-ascii?Q?4cCt5/IW/aTAoeFIDLxEdNQSDOZRXaB4wqrxJK8H+8AAZDaAR8dmzrrBJGgv?=
 =?us-ascii?Q?2c3sdJFAvmegqN1WE2vrSFEEslwwLex1g7buPJ63m7OeQ8acBJ282qJhobCB?=
 =?us-ascii?Q?T2kQ9F+mtE7lEcbsmt4TSRIVHcTpRWAdQEdV4Le9S4eiZPJ6bBEiyLQinzoD?=
 =?us-ascii?Q?HkE02PL27enevYqsyNplN2YBBnFcStpBMS62qpjouckaRFPa1qt24WuEQyJR?=
 =?us-ascii?Q?glqBUy0Qvrq2BObPFq8npQu/TtAWk98/k16SRypwPyvWoRvWWgNpTEDMRAbI?=
 =?us-ascii?Q?nfewB4SJ4IcBzEf5jVIwQrcZoXMVLkPsxbkP7XyhrWyIrj0ucgcIXtcVwFZt?=
 =?us-ascii?Q?Z2AlFelfjjQlLeQ2hkVbHqnkkbyA+q6t4l9mWdBiTkY3TVD5WIUBlR064xru?=
 =?us-ascii?Q?Y3s0qcgO9JJfYdotf3rIxz/LKQpkVtppSAptRyux5+BqC3cO2Q87ilbcVfX6?=
 =?us-ascii?Q?r+jQSo04uiJIyBZDLtRtvSTd89HPobRkw1KQEk3mcIIqyZMhivLzFf3mF5Vo?=
 =?us-ascii?Q?Ul0AjfT4NqsLanTU5cUGEQh0furQWzvrsZ1cBgVz61QMnAmv4ML8cVM5gEcT?=
 =?us-ascii?Q?UIMa7DP4JlkPgkPMf7fC6ITjEyzTEqCLVc7R3Z3Vy8ZiEWr+z6Vh25SX9Hon?=
 =?us-ascii?Q?6p4F1BAWltQJjGzfxrL0ab4bAO5SW0JJzr3xv+RndIWpdHHieWxgBMJwGIYt?=
 =?us-ascii?Q?aqmWcb1TLGblNOpIW2hNYyPyXS+fErEenfkTZvFh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2imKneyndvf222CDQvz6vznKt9mLbtsd//e6LAb6OcPUkXZ+f+64lBPL0wwh0/wPPp1uzmieNztSL5OIja1uO0likFwx3rwmDil+DVrghlyuLKI5cNEjO9yC248G8bSG3BHnSu6GoIEQIQg56D7+eywhL3nMls6HjLy/+Ev4BnJBbKySPBTlfgSbuNAZ3TzXBLfT4jw0G50vkdL/t2NmcvAB/QbBJN4H5WxBGo0aeDVIId/IJdasZNpDMuofSob8hZxhg/kp0wlwu8m1r374I0/k87JTZrk8Tt7t7Cio+p9kxV4KHqsjcdyysxoPp28341edZVNDZ16fFuR+PInfdddPwqD36hnJBRlvAZIx1kdYuBJ1HCS7AekpP6Sp+gML7LNrDNu4yDo45iORddj7ftOQPAhP2CYTgpkbWIs9hk/MLnCgoUX/K5qCFTbTbTdkJko7Hi50e7D9O7a75COEOhf9m0qZhOX6JsX5F13Yj7F8bqItVEokHJdE4d80aKb2M7E0XQOv2k9egbVuAuf/n+1HN7hTHIRrmwHuDOOM0Up9EgSRMCqEsQQZN/kH+nG78jUau4oR+/09hqpF0zbaE+DYInQGGQmhxOXvHz+udDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136738ff-f96a-4afd-bf1c-08ddb96a0c92
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:12:08.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj4QVAs6GSeeU1h+Rz/dwNdb0RPyCrMcprp9uTbLYWZNDMvQPbOae2lb+y026DJMrYzysKWCTT84P9BBaenqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020106
X-Proofpoint-ORIG-GUID: YHHYa5dCiNVhDVZbfA1OXMCaC7fcEC4r
X-Proofpoint-GUID: YHHYa5dCiNVhDVZbfA1OXMCaC7fcEC4r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwNyBTYWx0ZWRfXyKvLCuHQ7LEG qs4a9oa4cbkYngTE7ZsMjytbZEk/NUO1a98Q2JYpRkbX1j5p7UG459eWN/Uh/oxiq1nsiIABAeQ 5wI9lBVmlei+5AIGWYiA/2odlGnRqdGTZ+9rhfOvJhtz39DK9Ea4/82QsgmF/dI9nO9Bl/ANJTW
 5Sn2GJpGxW9YvyUXtvV73v74HfI07BQLrvyLSt58+wXLJqRHrXz87kNENULhbxTzPos340x8o2c 7tSwQNPw7HVcSasRjoBQNNp0fy0oYf1NPn1qthxs8g2QhQIOZesAyRBwXLT0JH9cb0yvEGF51WP daA1ySb9XUa105oL5ikXUn2wMbWqjoJz97hkNS4b8zDYJwGUQsw5oAWhGkXVy/ebmgyBlja8r7B
 hhaUDRXmwiZd3eiqJufT86HJ7pVmQjf0Wa0Kp97FebPg1GCxQ0WTuwJyEGNU+SmH6uVgCm8d
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6865302d b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=1hFzgxfT4tvf0KiIMrUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215

On Mon, Jun 30, 2025 at 03:00:03PM +0200, David Hildenbrand wrote:
> KSM is the only remaining user, let's rename the flag. While at it,
> adjust to remaining page -> folio in the doc.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

So now PAGE_MAPPING_ANON_KSM without PAGE_MAPPING_ANON is invalid!


-- 
Cheers,
Harry / Hyeonggon

