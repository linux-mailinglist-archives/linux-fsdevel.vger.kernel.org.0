Return-Path: <linux-fsdevel+bounces-53614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEBAF0FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F844A4C04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF2245023;
	Wed,  2 Jul 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HoPBEtK2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NhvCsXWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AE182D0;
	Wed,  2 Jul 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448651; cv=fail; b=t6cu/XS7wcT8SSYoey1Pk/hONbLkJozkjuEhuyLOVW4imGmLwi737xeDFZik9lSNSryaNdMcjRVGZBkDwFna75w1kiSuoCt1bwx3uascz3D45GLeZ7q5nDvWuwXjQk43P4AU5wKh6A4LhNUMTFqwabvEy7nav4Dw1GCMJUWGj8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448651; c=relaxed/simple;
	bh=QSp+2wMsw4udSpiDsnB8BtNjd47qBjdQgjPmYXk5dwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WGldIjjERdLCKAjV+nDoMBecw+o1v+mdXoHSnU4NnLVVL18hMIgSHSIqwQ4PTSe3We7JsFGDh8vG5nVR899IaEnzOyITsBra+bFU63CwSfUI0DXczLgRT4IS3sYWnwyb/5Dpij2kLcgtFKh/bLErhEKPm96OG4hJCafj4PV4ULk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HoPBEtK2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NhvCsXWB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MdFf026091;
	Wed, 2 Jul 2025 09:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CGi5SCbkCgI6PQXmcY
	J/eWt2RQUDS72ExdHZAk91kh4=; b=HoPBEtK28RIf8qaKEUhr90mDMJCJdkJBVf
	NbQU41952J6sbLnH3ndQi6TjU3DnwmOfEx1qKI5KuH5ywWmZFLhiCv8LqTnIoYXg
	z8Iv84FEdkWooxx5zo4wVaINUFgvUFz30CCXY/weC9syDm1/ap4qhLX6FP58iBtJ
	qJyKgagUzcv0bpybnDNDWznmFZ1UQdEgRsdQy8zh8d5tYm6bDGVRhIvNqzkdS2+3
	tcfUnw/ojxY0jCU0j1O3GmwWXevys0bup1Mp+sFHgcf8LIvZAHt4e90BMN47x01e
	tr5NlLYlrUOdgWfqCVC57jY7vW+xjD8ZbOCwxJ4RPTKiuplvylVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7wt93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:29:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5628baJQ027466;
	Wed, 2 Jul 2025 09:29:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uay6y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:29:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVnG4cOnItI9uXVjHWXnSnxafJXC7K/4e5OJ9X6vX1ElyaZkC0cgux+7DdwnwuhajWAbAArrD5pB4aVnE3Apnsli5a0LfjJYgMipr/0FiD4mTsEX4KmE3XHXkUscPiBlQzXgBF20+6s8UvLzIyp7H2v3f9OfQdiZYqv96Zpb7G07eVgLRo0Vl5lYCXK4AUN4wVObaqW+p+24I4U5zFzZPdZKH537C5bWwYKhZ2G1prGEpZ1p4/xOMLki/pY+EuWAVTgAXWJIzDM2hAmAcCz9M2TxkmmZEJ9flVJfq7Ot89wOv/MB7SV5Puzj7z6lIenq6ErMMZDb84PFOCL50NCPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGi5SCbkCgI6PQXmcYJ/eWt2RQUDS72ExdHZAk91kh4=;
 b=NJjFQApYAl0hd60eIWUzVp2VIumLDjl8TUxjoTVlD3OA0aAyFsjY0ZSO3iuvX+PbiXXw71i4uxSrbTDj39zvjoyxw0wiqknLiJAts78gqOZ5qiOQ5pfFsyhsgg59W7IT1++v9QkzGBveVIzKO8Snl45UmtDEDQ/HdIQM2Nn8vRlQW65J9Podkhb189vqDGrFw5Wt232bhLmWpBV1op9Gz263+9rc4c96D9qoifqOLqBoiX9GfBkbBgxki/u8eGQcsyloUjXEiuMYFYmhHnoRjI2J01Fu2vIWHlXbw3sGpUy2KsRMEUxra3YKtG0JrpQOpsn3Mnsv636O2y4vOdEOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGi5SCbkCgI6PQXmcYJ/eWt2RQUDS72ExdHZAk91kh4=;
 b=NhvCsXWBjInTeR7wjGm0m0rI4lQd2jpb6JgWRRcpbbwU7CYd6Qb8IcK3ZWsLGXlI99MjT3FEr1+po9UsB1NahaRb1uQTa2jUAWgLLsXmrM0rl6vPw9pT/rfYj+NGgXsYnqoKQ4+g83Pzd8hiGkyMwGkoZDMIym4ZD7VdyTgSb7c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 09:29:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:29:17 +0000
Date: Wed, 2 Jul 2025 18:29:03 +0900
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
Subject: Re: [PATCH v1 16/29] mm: rename __PageMovable() to
 page_has_movable_ops()
Message-ID: <aGT737Gnb1Q9qapK@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-17-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-17-david@redhat.com>
X-ClientProxiedBy: SEWP216CA0103.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c6bc49-b6ca-4aa2-1aab-08ddb94aeaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWQHes3AChGI2JRsceTTwGVjlWGeyLWH0GKCsubUAVHeeIIigxJ3JExxWHrV?=
 =?us-ascii?Q?8ugqhjm5kbX/gDQkjwiCyX6zntsrf+DU5r6VfXJ4+FiEcb3Lfmgx28TC4w0M?=
 =?us-ascii?Q?SCeoY6X3wmaRnwKoOVN2gDlA9gvs8zpmZjfgKkNoNZftl2mzGr/OL6HPs5Re?=
 =?us-ascii?Q?GnXSb7EjRAup6OE/X4zpr88syWJ38gfQjmRSB4NwKGODL84kPjjtMTSqtIjX?=
 =?us-ascii?Q?NMcEciANaGlNlWlrPeVjaGNESvi8U01+NuJvCQJppUR+FDKQWzdxMTuq5yL8?=
 =?us-ascii?Q?tpa5Kc1mNv+JXRK8CQrAgzFgZZlVeY5dOY9HOknsu60pylSElM82wKapOSCM?=
 =?us-ascii?Q?ye8Ih+JrchNlKOnXHR6/8DaCdeO6qWB6sCo36MUCzs0VG46QCU3F0S4jfkzm?=
 =?us-ascii?Q?IUMrbBsgyTerfWDLUntFnAMhkoXU3XE09W5ovqILala866uURNxng6OKvBwA?=
 =?us-ascii?Q?H60QE2NGqUCHazfyG9VHc8XLUJ0VQ8tALheibvaSywXXT+Yu4G6rrTWsoPJz?=
 =?us-ascii?Q?CXXwpLY+9q2X2AJMjwQ47FfYrunuFN47zsWwxK5KnAXO7+oGL4WgvvH+57Hc?=
 =?us-ascii?Q?Jlfzqjxp1aZ7uzMpY1l9emUK322xT2QA9K+iY7zx2/9bVumKrcBqpoiwUnbR?=
 =?us-ascii?Q?3b9+e5v6eqtQsC+vFZtbXxU/NSaPnCEualeQ8IH1gK4oGhTXxvAL55Wxilob?=
 =?us-ascii?Q?h9J1m4FXmncyBEx/fF1JGcoFRUp+PqO7BSF8wDS4pU7+0dEeYscjna8O2YMb?=
 =?us-ascii?Q?UeFGI/fWQMcap6MezEZ7Tq7+WEJLBI6JExKQr57MHRPl9i4aevLuY/+e64JQ?=
 =?us-ascii?Q?LlgtPklOgBpeXVYRaUPDtYjH4e6H5qdVFNsrPDWhq7EqWANznN1ZKQQvpp7I?=
 =?us-ascii?Q?jhveZQ/QHDxFha8nyZf3PaiUn9vRIjhsqh4tyOtlF+HLhPp+BBZ1fKI6T4A6?=
 =?us-ascii?Q?bqM6GJQKH2TfAFVYxWqRUKxR8DjYxRXcIkeDykANzXxCmuMY3l4ikXzdeQPB?=
 =?us-ascii?Q?x5JjUpSOWSGrGMGBNUX1EmSDNt9mxgk9CE8w8NlsiRN0S6sDiztM4ZnKNgmw?=
 =?us-ascii?Q?YM2M/UQBGjm+m9NVC13jS3z1xQgZrXROdt5FLetZwJnqZ/P24tszkjHhMAy9?=
 =?us-ascii?Q?3VuTEY/qnNnOh+N7124r6TcVC/S2julF3aY8tJ9uyicFP+/T6ssm5cbZB4bI?=
 =?us-ascii?Q?2gvtbq9gCHX2kbboyAkuHubDZkG1isXKpJjYgctQB7uXKJVF45poreC7rtFy?=
 =?us-ascii?Q?+RjsgEtECJ8nmUIHnaVpD2sDdgwr/uSfCpoxCCRP6knU1zXG+RHmeRJUhF+B?=
 =?us-ascii?Q?MZJUR15skwqU03vIh5OHdizyjQdxUWYmdgFH398PYKoCAvN7OG4VpreWVP2X?=
 =?us-ascii?Q?lvBPmhaoalS5odex4NEEv7DlQ4vti25U+ORimaA1b9YVvlYoF/m3761qvqBx?=
 =?us-ascii?Q?6dPLYUTzoG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mr6Ud7YR/xODiWItjMUdRMGmXonGMBfaRjjYFiaH6rY9eezM6ll47vnVOibM?=
 =?us-ascii?Q?eLC+nJAw2o86uOSS1xZ8TQ6LaWUbKng7ZwxzpaYCXVxQX19e065E4EzChPTc?=
 =?us-ascii?Q?8Y9HQUFsdllvTwvBvyLU9PZURUb7ysHZDyJvK3NBKUAr6hfVTiVJE5EHudks?=
 =?us-ascii?Q?vdJHSaraBGQDiDcVYPPp2PNAOkLi+IJEjVzCiSPwdDyEM+D2PVh1E0Mm8j0A?=
 =?us-ascii?Q?BunWHcOdOpzp9wI5rIiM02oa2f5jricgzKFqhr7arIygQvjOBay9y0jqpsdt?=
 =?us-ascii?Q?qGrhCmRbwK51HYk7Yv5OEeqSd6ePI7Vc1tFo/XSnjyZt288icyiT+KKmGPEV?=
 =?us-ascii?Q?nXys0lpzRpDEtKaoG/VFpXq85uHMZbEk+QgfP7wBhI5TrwKF1XqNNoxR9t/J?=
 =?us-ascii?Q?0fXc3+T48Af7ySzw3jJ9OitPuIOW1KU52/zestJxxbrEyTqDva+79Qa2HLDO?=
 =?us-ascii?Q?XOHWx0EDu9zhimEFEVo+lZkuFEA8/+78oy5DDD0IqODg4x/yC9Fp0jMmY/iG?=
 =?us-ascii?Q?v0a1dknlgLMosGjEvZ4514aQLV+iQ5+jIgwbQkUazG+Z/t3mdrYSRIYe1CFA?=
 =?us-ascii?Q?DQzWdKleo9ysHTtCIdDH8uenoQzMsAOV+QS3yaeEQiVg7xAp7hKR72bYnuz4?=
 =?us-ascii?Q?f+cm0nt9IXV6YpeAG3IRAjDM27Y2328QqGeW1FHGl1aOAeUeCpWXJmDRQ4IS?=
 =?us-ascii?Q?uHxUNi4nbr3Q26jGBUF4eVg26gANnqmisytYvWAtEJck2uZmK+G+enl0bdk6?=
 =?us-ascii?Q?m4knjPOSL/8ib20UrjRXECwKNtnJdnTttx98qDHgNLNXADR3JqJ6eUHFoCcd?=
 =?us-ascii?Q?aD4MsZbSuHc0M+jt2HJITZ+pD7xhi0/j1VdA1yXr2pC3C3nNw8eutMz0QU28?=
 =?us-ascii?Q?5g5eRvLHjAmrO6rdXSuJfIDoiGGeFBDm3paiFCT8zYdtkKCnOITy8n05KkE1?=
 =?us-ascii?Q?s5Up9wA0NMWA+zBoWrnyDSlyoBhN9xe0X2wnwV0Jzl+Cqa8y4I2xMlxT6H5e?=
 =?us-ascii?Q?xNAdbbdj77O39Ug61I906kAXZDXHHH79zNVQy0tGbm0I5M/f0/HuLjHPivDf?=
 =?us-ascii?Q?KLBpPvbuEjSzMMViO/8nI5/xs+QjbIEMfzaA3tRItTT8ppcET5x9j7PynPwM?=
 =?us-ascii?Q?/ouHMM2tK0UD2nXxcVCBmDx6e7lrvSxlN5RouQpGOIs0JGI9Q6OTmSdw1IpI?=
 =?us-ascii?Q?y9CH8lkuggdZU9ENWKfdOmVbLCrCAN56/Pfxs5tNo+h+YPHCH6Q8P5GhPWxP?=
 =?us-ascii?Q?2RSv/F38rlLU/N8eOZ7+2S4skB0O2tLfl95muanHrf/GXxri5BUSnsDO56E5?=
 =?us-ascii?Q?V7z5ndug+z4J02HEApbyq/57tFjFDjJcv/0S4ZgpB6I225cMmg+0qTioXyfV?=
 =?us-ascii?Q?TeNDEekG3Z6tJgl7GMZhVJ0+nZ1KmxqcyXZNYaxAYR3M8JxiGRi7firLIlx9?=
 =?us-ascii?Q?4XMv4J+eGkLhzPs7l6FsWWPA1C3IXde19xUxgpvwdFIVhmrsoqrbcLjHNo77?=
 =?us-ascii?Q?mROOcvvGMjtBJves9fmVf1+kcLDybLAiJzBKlvNsPJZTPa4BR+NDei4Ypl7j?=
 =?us-ascii?Q?W4L2Wzz628Es6ZeFs6uliiSkjs5o+A2TeU+VVXET?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7fLp90jzWfp9JqEju+4QwKoaIjlUFAv/LhBXjnPK9b+cWK2l2PE3EZ6bXT6AHni/fNFSkInWxXHb/fmrHpBKOgIACSiNQjP3uNRvmFqdVGpXbVPaI/qKwfNEJdNa5DxohfyIgb7mVHoB8Zu1cxNgYb4ALPw+62do7D0rO5Wh1GKdd7zqYMKaSzDkxuNSPfuoSkovFm0LUxOE8CTY5uQk8g+0yn8jN/HWoICXfBmaE9blKo9bPYhBxs+JUED06MTNdQFI1WUXCrzqML7yuBL551JLd/uf9KyPq8fPeWvIh5cowGZQwPX1m2fUWviwja4iqrMZSJnEzaAE/PdAz//ZiZn1FWJMdrvI57FOgYoqjznYFiGWfyk0hzt87RkWar1SRXZsOAY3rPjhkWfUO9F0FbWdlGe4qg36VbzbB3shSZwbBh9SpTLKqpe2DkzyMD95TciNZcTttPLKB3S0oeugrD6/qxsUBXyzStaykkptTSXYJAZAOxhqjF8S2KjfE4fOntZGpg/zBpg+Tkat5GHJqWOdomknRR04KQha6DoHDcW73NxzimqneL94LIwdzfZANY+ioDBADXva6YkAT9Lq24ZHy2tH40Nos7MYEi0DUcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c6bc49-b6ca-4aa2-1aab-08ddb94aeaa1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:29:17.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/HuGX0zoVpRSp3xk2fifxJXOjo20OS/qwzXBb+7IcnHHfr17Er41akCtCwVpyO95xjCc/2wBXvd4hYtDIliqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3NiBTYWx0ZWRfX1EWD4TBaI5ms CLJ+dyZTJ5E69JGQaZnlsUZBF5BDTEYZYQ/o4uRreoYlPWlwf6ebIKrqPg7Uvib3T9SXoBWRdTr mV7gFGzpm3UlXSH8zEFWROTpbfCHt4vN4cfbM+xaO0Sl27Of4BSzG49jD0Vv/rOCgr0nOQIXl3k
 NEFv8Cb+VzCPOxP96mu8I+Jx10EGmQum+f421EfEdu3Vh27Qqmx4hOhmp5ObBpkri+G8CWMEled rfEFvEb7q2azrMi84EjINSJYbDKo86RagrlVuQg4WZ+9nzaY91lWd/TCybnbjyJLIF04RXY9ZYw ExHobM5BNwy6GjthVKgFJI47ugH6WsNwEw+3d6G5ZwPDPnqhTFqghrdiwYup66vPpjnrQxxVTEu
 a+rCyz+KrGff2+rQN0OC4i/VysbSNqdCYcKJ/HyeBhg0uLs5rhXXKPzYk66YcpTLKKM5sXvg
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6864fbf2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=-CxMOg3bdxnx5erAjroA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: m09klTsX5nUwH2uJieO4fnZ2Ei4fieq1
X-Proofpoint-GUID: m09klTsX5nUwH2uJieO4fnZ2Ei4fieq1

On Mon, Jun 30, 2025 at 02:59:57PM +0200, David Hildenbrand wrote:
> Let's make it clearer that we are talking about movable_ops pages.
> 
> While at it, convert a VM_BUG_ON to a VM_WARN_ON_ONCE_PAGE.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

With the comment update mentioned in the other thread,

LGTM

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

