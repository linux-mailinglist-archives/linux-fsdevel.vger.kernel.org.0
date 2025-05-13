Return-Path: <linux-fsdevel+bounces-48897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0552AB55FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3B71747D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D028FA89;
	Tue, 13 May 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aW/52O7q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1SRq0VY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59328DB70;
	Tue, 13 May 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142764; cv=fail; b=PsjIsRYm4mAT+hLdthjWdJUIEqYWUvF9vVlmjtRQUzBf/l3NpuD9zkS0oVCVkVIQAo/2+a4PpghQHJQ6xSuInTGRJZ1V4A7knHFaQQqlSTI3S0MkAWSOHtqvVYOBzdzBMQoepyPrUXuSj39c7yOBtL6X5tNB3WKxF1cypGXs6JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142764; c=relaxed/simple;
	bh=01rMDAfEnU4VmxBvx04Cnen++FlXKOafpuatTEeWxGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kjNUiYNtAWg22TlX18wid9DyVC3+HgQEp8Oj5IjE4FtcF39CpI7KOvgz0qFeJ07ZoI+FzauiJTM5f92HpMMDKWbKxV+yA1+cttwomq8QSkKA33HMh9jsNtBJPY4hCZipqHC/++xCl8aLpLEsVyweIfiJyfGAm8drjObR4cqLA7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aW/52O7q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O1SRq0VY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHanM026805;
	Tue, 13 May 2025 13:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3IOJUnE0tsYD/uBuea
	gzx+BkbcXoumKHBuZeMvcNng8=; b=aW/52O7qgZXjCuSl8Vp/sV16y4hvQr2/pJ
	YnW7t2ok0UnhJXCUc5H34rDAGBoaQbFciaNv8wqd9y05lFEeFwIAhCmsLcrKSg7n
	AVYxSbJDbY3zOG2+QTQq/iLfUo5VdtaG5nk7U7E10sNcDl3HpdnBRrznrRBydAc4
	9eJoTMLxpLdkfVv+ap/76/98PQrHun+32k/Ax48Dzxldu6hOwKJ5xFghCWpkW++U
	N3UrBkYj9Ga2nmR+3zEAGb5uVX+URJqa7Mjw6GS/DjmNE7uxZhPGfxMNRlsO5kSz
	8Zeqb/J5NZ2B4lIWiRb+wq/oYMf0ZiFCEBs3nnDldBYyynuyJw+w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1664tsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:25:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCCHjw002066;
	Tue, 13 May 2025 13:25:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8f5rdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR3MtbJlkRxYbrKApYL9FNAg53fGWx88Y8TFUmYgET7ai283mfJAOq1C0YlYYKzcYVVRqgHuljYCVe7rMHwWhumbRuslNDES1iRbr9fM8HnFiALFAlSqM3s6Xoe1hdTEexGsKIhRCdPUEjgVR52irz2tlQHPftAVbKmlPzpnnE4mojLjE9IVIUWmWUruVQk7GY8/Jy2LRT+KWWLTndMxVuCk1TQpeRLK7xwVozb+WAHOQqH2CXNxgWxqKpeV5856rl0DiyUPZxeNix2QBs1Pd3Z2bI0XixgMvgL+h3lHu+Nq61ulWS9Zw7K2nPd3CQRjz5Y9vATD31SmvDn1QfVLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IOJUnE0tsYD/uBueagzx+BkbcXoumKHBuZeMvcNng8=;
 b=KqCSOCw+qum1uN4xizjExfSAxhBrdGSaGHPTfATC7AnBF9KNhiE4TTzEHhKlWBNJkuCrHfuOWPb3uYVD5KwxJuzp82KS0nis+tDQOynmudqmKME2MPDVFrihKQs6c71hM6paRcLR5UtZjJgEXZ5oqBkHKIy7FOEb6fS7yE0KrmcwykR7S2S2UhJRPbzR2MzijvxVomARrFIjUft/pbXFLJxNKWsg4NuldSeoFHyrQteS5ETbCAajjYr2x3vwfa89P906MtoAeLQdfQnu1sL5/mnwPqUNMSPcz0qgS5vsiJI3NRONd2iEfXDKr7Wtg7ziowo4zFuZmbIEWcp8bRN69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IOJUnE0tsYD/uBueagzx+BkbcXoumKHBuZeMvcNng8=;
 b=O1SRq0VYznvdH4/SNC6x37gizQI1Ce3OC11pZxcReWy9ePqKJvhx9jKQf0+7Zz6TvlnD0EJd799/yg3b8dDwiiyBORUZ+eCq99Rj3AoK+8rXOuJWU95JZpVqtuWTFvfKAiiDwMrmBMExU7mxAXwLNl/AXU83I86gN2QIxBEZFzs=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 13:25:40 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:25:40 +0000
Date: Tue, 13 May 2025 09:25:36 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/3] mm/vma: remove mmap() retry merge
Message-ID: <bfd5b4co3ha32m7z7fo7rm2uhaqcunn7zqgywonm54wi2iakpb@zogdqwo4722c>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <d5d8fc74f02b89d6bec5ae8bc0e36d7853b65cda.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d8fc74f02b89d6bec5ae8bc0e36d7853b65cda.1746792520.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecb9f50-c8cb-4efe-5558-08dd9221a7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uf0pCREr4xgdP1m3F6Nb1ot3ZWQL7SV127KqhICBAOTPMG9O+gARuSIGrUdS?=
 =?us-ascii?Q?T+mDqt4h2/GuwTmSJ+SUyCeU0LQahxmth/J5dap/DRGCg/OINWb+C5/vkz60?=
 =?us-ascii?Q?/QXUfCnCG8rsF/GPKQzYi1CMfx+i2FGnfVAbC74Pp+/n9CxaLFMvi86I4ym8?=
 =?us-ascii?Q?nTf5ffuGjl6NTxzd8BksLD6PuJ+KCP3uxA5ZLuZB0JfLPyJV7dYUlUQA7WoH?=
 =?us-ascii?Q?bN6s36nudZi8u3P50xK69xbnkT0WUg6vxDYmAL7YuOqrA0t15fppoPE9jsHf?=
 =?us-ascii?Q?y2DBAZH2Y5lnboCkbvyziNzLiJSQfkt57v6yTUMUCeFzy4BEk3JAMFAUgjwS?=
 =?us-ascii?Q?GcHbYVW3II93+Zn6al0s/vqbosWiNDuQCsW2DxizFgXcUsqxO60tqWYu1O8F?=
 =?us-ascii?Q?t9GzrUW6lFtcg0ETmLJREbn25c3Vr7fERZNfiTxmmr32mv22bm9n3chPYxc2?=
 =?us-ascii?Q?OHn7wHqYw19cWCufHncV+wTSXxJOUdwk+0H95zn9+Sk3hfwJQCO+pg3DL4D4?=
 =?us-ascii?Q?AMrB3oeR+N4hQG6lC6h8NUOIRtXUvdHc3L51F0S3F0KLA2SWhQ472OfDoRX4?=
 =?us-ascii?Q?BuILTIkbBdi7RIhh+/4Cl/jcY/dbQe1tN5vwNSxOwyRS1qvPL30+L4+rM6dU?=
 =?us-ascii?Q?BTYYSDDJkYcTYOqN0RgXNjUgqHfHwd+ELjZczBrDXRaEHAfIUklAHsvqPVU/?=
 =?us-ascii?Q?MdBxbvluC98gwbYESgtatDuTCwUP8N2vRMkAhB6H4bokvRMVU+OItjEF/yuZ?=
 =?us-ascii?Q?ZtiVSjuyY8pDhq5tMV5mQjBOnvhGl7KttCdIV6Au5OwtU9po5HPFCKOpUej8?=
 =?us-ascii?Q?arel5fha5UaJHZT82ViuexYuiTK3y6ire3ghvzHokf4Va4afRX2rrEpFfmfk?=
 =?us-ascii?Q?eu8XQEYjIL61byALFXEMVDdiZ6hT44w7/aL5oMi2dpC03cVBvMw+kQAeaK2Z?=
 =?us-ascii?Q?DVh8Y4iSZXsUquATE/x2jlxuSkOVSHi/POOheIcAQrq73BpbXpr9iUflEKOD?=
 =?us-ascii?Q?cGkY3lF1GNjE6BqlSqV8JeedWUqGU7mIma+lUyfQ10bIjaM8OYa8cNOrXDYd?=
 =?us-ascii?Q?AxY6u3DSuur7a1SS9a3wsMJQB8YQ5JEgIkbgDQCeqqsCjtD33KDQmUuJnWl4?=
 =?us-ascii?Q?Og28iCinTY3CRm0P/r7+nInCmmIqwbP1ctY2b4orHDUiLnUQSGm/W13aXCau?=
 =?us-ascii?Q?iuYXiRuM29BBdVjsPAsaGkoQtJqWDBYV9LJqKQ/V6sTyEP4XT09Mv8Q0VcP2?=
 =?us-ascii?Q?MlsuAoAVngZTo5pjeIGoQrwKUBJwL1jT0RGAn6ewrSvSa8qhEywa0oaJcxOw?=
 =?us-ascii?Q?c2no3QZdzySvGdsKSGm6jm02FVBFsJa4Pn62W4OnxC1qJH+w1kkILP/QpkB9?=
 =?us-ascii?Q?bo0lNRSeKSCShg3nb+2YA8F2sZwmu7uPawHrTsJ9jPWZYjU4Sk1K5C9/eLvw?=
 =?us-ascii?Q?H8PGE6Rt6mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DsJxbtGbR3VVtNfFarWc62yGJfC9iGn9vmksgCQSl25OEgYH4RJCDuWGVJWC?=
 =?us-ascii?Q?KV3jJZxgWFa56G8j6kU9Bf7hrUw2eqz02nd4JiHwwcboEpNn83drmFErGyRz?=
 =?us-ascii?Q?wqDyBOmaQP8wPuetoAdF/HqT0me/TKN9jh5hygZ0We2y3W3BHdnYU1Y4lE7L?=
 =?us-ascii?Q?USFC9JiiQipq3l0Wf1k5zyTEDpBOzXHQT02uQdkogId6EPvRTpLe97CrTk9X?=
 =?us-ascii?Q?LfltdGawPfmxaxmmynPPfdsNa3UM3MKeNd5efIlDjvtM9yuBCTqF0mDUFnjY?=
 =?us-ascii?Q?f/z1EQttJipu5c3bSU1gaT1hFjD+vVpRQxX0uh+Gk7GDOPgPGbw//IdaWRpX?=
 =?us-ascii?Q?fZvfOqEYdLwFqN4KF6dxiln684o/zJg8DtBwyuDlEuvk99y1PRCbmuHEkpnP?=
 =?us-ascii?Q?vbP2dF3YVZhXISJVJsWbpYqm/bgqo8kdSq3tLSbpjkvj6xXFPWtq6Zoap1zG?=
 =?us-ascii?Q?XQgXEtBM0woAv/b7OAdP0ph6srwm/gkwo7nMdNqejCCe/zSoyNXWAjp4B17b?=
 =?us-ascii?Q?dd6dAkNXlivDl6pYnaFoqWyPbUkDTpniVtV5GEkDl75Zj7iYxzibPSFRaLxx?=
 =?us-ascii?Q?3tYoNOIPqDkKaXyTwvgShTq2xkJUsph11q/jFX5IOb7Z2s8E+vEgFSWwERTu?=
 =?us-ascii?Q?KPkgeciOkj6W+jPToM8922Qw5q6JIbXMVJoZsGMXgf3G2PQOpu4UQ9BAwttQ?=
 =?us-ascii?Q?8T9oJlCVsJn7X8R886YLFfMJilfztRRvf/w27WTVsRtOFZJce7XyC1h9XHAY?=
 =?us-ascii?Q?YxQldx+l4wOA7b3tMbOOP7Zmg380hTWz9zEOhCzXUBdZkkhcYOVnFpi5Cg7R?=
 =?us-ascii?Q?0bnG4QsD0Zj/rMcSOGj4loVOZBkNndiB6pwf9CIiUjgdloqZsaw1LvJBPHC3?=
 =?us-ascii?Q?Oc2/rK3dQ+NQAECIwl626LIBiYrR2D94Ngzbnw8gwRmgomVIV5RHmrTOmVPd?=
 =?us-ascii?Q?1n3GMsVNy+0xWYXKWFm9t7UbUW/SexqO/1u5YaSTSIUtbhl10KaZ31hHTjx/?=
 =?us-ascii?Q?9PPIH7O2Kn5VJ2Y6eK/z3kCCOqYIAt0MaUsP0DUjVKEuawT5011ThY8GiUzF?=
 =?us-ascii?Q?wuY0MfJ753LtizrnPLnytJFnIVGIQqrRMMmIwJypJ9TQiFD4WnNtz+Ll8Zpq?=
 =?us-ascii?Q?mdDgThfmNmtBXvu6c7j3I/BXtd7BLosFcfjHuS83EB/wBv0LPpdedRzuZwyL?=
 =?us-ascii?Q?b+Ull6wScvvE/jWSaNyIdBgoajZUdfZwFbRmBmvI5Nb/3l4yDmTfSST+uQ6D?=
 =?us-ascii?Q?rGsd56qnFZV6lPb7jfWbLyclpOWG/wL8gXqnq/2hLMGE9fLfmRV9+i8GW33s?=
 =?us-ascii?Q?ZpM/JobSL2R4npl/h3CSzkyh9R1zH6njpAlF+/IzwII71XCsO7b8H/IJkPj4?=
 =?us-ascii?Q?SgC18cD5mTgcRVC/7HXBE68lEJIy9dJUA2f0yyTPJ1MK48aIetAy/rbnwrXL?=
 =?us-ascii?Q?L2nxCXljDbClXKwnjitPlUkv3eM/7138+CIOMNukxWUF9oIiSgmh2WPTaWVg?=
 =?us-ascii?Q?n3P2bHOTO61cH55yKkxkWppBdU+qC2NeP5tAfIPxBw8BuKxS69O3F5c02JZm?=
 =?us-ascii?Q?A+KBmJC/ELj52SRZbwTtTmCQefk/fR+eMQOa1/8+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6dBI+u1CQVrBhV84G06qCCFp3FNdEyRyXcolmiH5CXBLkIDNZ7S/Sg+lfBf4/JSk6impM6VJP/uNVe0TNo3NdAjMuvIyUrQ6HYPdeHestforJjVQ+fPyvFEvKfT2v2FaSBJj2kcJHZFUKhspGm1hB2l057IdkuaovIPwjpd9YI+WwDo2XCEETl9YyL5qRphBdPizf3R8j/5hSNwsn+nBMNpxNg8xhPmSbrteY1oNif25TO8D3nnkN07zzKUPEF9kiOsffWmNACpMVbomcC+nwHMscOo93EvEi7JgzHq8g2C1OeSlBbMjKPlS6mVywzb5LCKzdXyBxYkYJL9LJ+cTKc8OPAOiGdf8tMyevsxWLyB3XcCKdj+2hkVL9lZd6VDByFKaBmpdqLp2gjQ4m6whtbk4Ce5V9QZHaFnn6m2dOBO3atX1TpF+QJ9OIMYWtkxGEWSDglf/3ryBS38av9ZaxyHRfxuCHPKdLlFubRt5X0UfGdUDh5sZH3tZMfoNbcjeCs4u/4DB7SjZy9QV32ZnmK/faLLOfeDkamxAa0BLXBSFeVoajCw1Llti2Vnzuqke17a8FFRsL92otuFdyJ61E/NuhIfjGsr+qHHyIvBs4DQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecb9f50-c8cb-4efe-5558-08dd9221a7a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:25:40.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRljhiF005jF81+VdzGvvoiXlFjgWgbq7Dq0OTXkCkWUbJ7IBVFIeoL/LVVWRFHlBJXABBuYwWQg4STe/cJAEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyNyBTYWx0ZWRfX/Lm2KkTQhHFa wJ7+th5EllWkq5yX+kJNIhXawMV69zUR0DCyBlWFfS9QNs1mEZ1bGslsLExKNBLmwrHcvV0JEsh 6hy/85s1z3M1ewPqvcqu6JU52bmxUvX3LD6R0pZKHKIhKKfkAV85gfACh2ZtrwP4x9e8v0YCdhu
 NODiL/aajMRhm4kngFW+qYfnOiPeTxUSqnlL17YqR0nGlFjthKzuFGS6owIMRyhuh8MnyjYckAh WLijTJeKcntttpAT6s7YOhLTm0e1AGHeJeVC3rHzzxHrdRacg7Nlo7fAahA/3+9/VzFhPBhYpyy 1wdu+1ZJ2uZchojYdytvQmnEmSX1CUqFNBwZwc2iBC/28PHNB1Zf8fQpeopcWMGwASOoXjOQmWv
 C26xia+nbgvqhcYavqd92OYT1ULf+f8yFG7bFlCJciFAsejup/x04GbyEiCDKmLM4WXf5o/V
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=68234858 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=YWPPGXjhO1gMhsn4HRgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: r7wVEMw4-Sh9wtY9T6UmvqBPzSG5nHiH
X-Proofpoint-GUID: r7wVEMw4-Sh9wtY9T6UmvqBPzSG5nHiH

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250509 08:14]:
> We have now introduced a mechanism that obviates the need for a reattempted
> merge via the mmap_prepare() file hook, so eliminate this functionality
> altogether.
> 
> The retry merge logic has been the cause of a great deal of complexity in
> the past and required a great deal of careful manoeuvring of code to ensure
> its continued and correct functionality.
> 
> It has also recently been involved in an issue surrounding maple tree
> state, which again points to its problematic nature.
> 
> We make it much easier to reason about mmap() logic by eliminating this and
> simply writing a VMA once. This also opens the doors to future optimisation
> and improvement in the mmap() logic.
> 
> For any device or file system which encounters unwanted VMA fragmentation
> as a result of this change (that is, having not implemented .mmap_prepare
> hooks), the issue is easily resolvable by doing so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

I have a few tests for the vma test suite that would test this path.
I'll just let them go.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/vma.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 3f32e04bb6cc..3ff6cfbe3338 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -24,7 +24,6 @@ struct mmap_state {
>  	void *vm_private_data;
>  
>  	unsigned long charged;
> -	bool retry_merge;
>  
>  	struct vm_area_struct *prev;
>  	struct vm_area_struct *next;
> @@ -2417,8 +2416,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>  			!(map->flags & VM_MAYWRITE) &&
>  			(vma->vm_flags & VM_MAYWRITE));
>  
> -	/* If the flags change (and are mergeable), let's retry later. */
> -	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
>  	map->flags = vma->vm_flags;
>  
>  	return 0;
> @@ -2622,17 +2619,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	if (have_mmap_prepare)
>  		set_vma_user_defined_fields(vma, &map);
>  
> -	/* If flags changed, we might be able to merge, so try again. */
> -	if (map.retry_merge) {
> -		struct vm_area_struct *merged;
> -		VMG_MMAP_STATE(vmg, &map, vma);
> -
> -		vma_iter_config(map.vmi, map.addr, map.end);
> -		merged = vma_merge_existing_range(&vmg);
> -		if (merged)
> -			vma = merged;
> -	}
> -
>  	__mmap_complete(&map, vma);
>  
>  	return addr;
> -- 
> 2.49.0
> 

