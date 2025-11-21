Return-Path: <linux-fsdevel+bounces-69460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E4C7B832
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5AD435103F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61C2FFDE4;
	Fri, 21 Nov 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RlKftCtI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H9bbMEDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038728C00C;
	Fri, 21 Nov 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753207; cv=fail; b=I9P6INpmMMbJSMnUprbjxyUglRjD61yEIJ0O2uf8mtohDfmnQRaY5NRZJFt1IEe8pncQSUkNlmX+kLeP+c5Rrdxc69qqndehlxnDTUg+y5ty/1qCQVbvH9dHpUSv9RakjPwF3GHfUum5vhynXkMe7WdZbhSnJAsS7N8JKyokNnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753207; c=relaxed/simple;
	bh=IALDm2Sv0md263/T8jQPMnLgAPSjr9ORfwZE2OhK/Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gqxzid0uqjbJte+LyQnJN0vCOtc8xg2RIY4EeLFuM/fmWv/qhWT390lbevNs5eW7cdLdZFex4jSrTMLsYlL1gzUQEh/fa/bqB6XMMzSO8sCS0n71HjZfigocwB4vU8FtjshFPS2aVimCGBL2Fqi8HHyMGVCJLcdnUXPsxnOTZ60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RlKftCtI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H9bbMEDK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgvlP018808;
	Fri, 21 Nov 2025 19:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XZxFfwZ40V5VdzEyu9
	egPXQWGqEmXorDXTs9GPGGL4Y=; b=RlKftCtIo64uSvS/+vawXIGcI0abIJrQOU
	tNeJQOi9cA/PTRfJ9/WdMwhnkGIX2VksA8r+VJ36AuG/2vbHV6gtXaeUaB8InU5U
	ovtgu/6osH1FCE7+jSCtO/vnU6/bjKBUkB3qh213NOHpmHqANBJsCdx3aErQXwWT
	KJJ2FsdzsKkDzMNgAKSihpl5uOtoyy1kIZEROQRH1k7Im9Tiy7yVLGlScqIuWvPl
	AQFw4E6WihaXFtjn+rRRKH2H/OpDzbv8h76F8A49hdnu5tCLivckfPXhUePpN4wf
	9VZ7XWe00CHrL0HKsE3b0//2VMOFgaz84bo2A9kTSyTRfmpJmTbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbq4b2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:25:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALI9rnd007884;
	Fri, 21 Nov 2025 19:25:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefye1dt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEAtzL4NPeL170iYwMCrrMiyVvCwxGc60JmMl8NBiib3cQdMhYJ63zJTD6mgRp/8wnK8aFv0i1p0G9Is8l4aN7XvsBUBet9wfZmN04EwEc82+2FhxgdN6S6G4yN4jg15GBxbMASZq+L3oKdUelnm9DlCIzsOYrNV90gQHiGOgf8YJrQ5mjXpN2eOEKJuIXTmRycxO/nYXzynScjusBWYNHEQ7RzHe4eaJTCe2ccIyuoZi9tbgXfCZ5v2XztPoPxaLlihym6laT1abnzgThh73GqUHNIdFutMP9jl0ib7wedYKLxLOqye7zCw2Ysgv4o0+qPd5Ohf7B9Qv0zu+hyZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZxFfwZ40V5VdzEyu9egPXQWGqEmXorDXTs9GPGGL4Y=;
 b=Q6iXLOopZkVGgmXLqb1zAIb4DTLUeDhfabTevFGJlAITQk+7Zy8cKMoaeT/SqAbkQ6CfkMKsUMCKXwlzv2+aeLDb+wHW+pw7gdwL55woEywJIDnKr+USlWJFu6kImM4ZmRiGWO7XqMdl6mGoDPozm68RvWMO/DIu/1IOYzBOwZywglM5tD+/C4eKPYldNqEnhGOIqgUxP8oXZh5ON9K4W7xBRMwzM9H2ba+bZbBlmUteZXtRNxpY5jcUneywrZEqCwAF576aG3xtIAqJtqHIpeEvg7TbnxZoeVQnQm7270dSpffD6+CA3yZylLP1QFPkJcmSqNY55XajpPVbzcl/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZxFfwZ40V5VdzEyu9egPXQWGqEmXorDXTs9GPGGL4Y=;
 b=H9bbMEDKbGgD/wewKTLe1v85/WykoEBugXXBeXyXQhM4TCfMOeaK8fjIF2xMXU8fn4RikIk2D/vhcajhxKcvIYMD8cAHP4b4MnXsTFomA9yPlraXIDBXBYCnKPvyQI0Xfv95KJcvvxX0eeK99tS2zEciWZYdu0w9Hw6YIAducoo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 19:25:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 19:25:49 +0000
Date: Fri, 21 Nov 2025 19:25:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
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
        Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>,
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
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH v3 07/16] mm: avoid unnecessary use of is_swap_pmd()
Message-ID: <67c63cce-f1b8-48d3-83a6-6de1f2d86dda@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <8a1704b36a009c18032d5bea4cb68e71448fbbe5.1762812360.git.lorenzo.stoakes@oracle.com>
 <a623f785-6928-4037-b4be-5d42b46aa603@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a623f785-6928-4037-b4be-5d42b46aa603@suse.cz>
X-ClientProxiedBy: LO4P123CA0444.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c69889-0b12-4d47-4651-08de2933c6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o929xUlKrQzHHLTWN/9lZ/9f4gYvnMD1XXCsT/g1Lz08p5Cb027dj0fOIgfR?=
 =?us-ascii?Q?500LpzZiGoZSFs5h+0LKQqqFu/0IMSdqfxJq+Ki25DEoZFxCCDopvKcMVFmq?=
 =?us-ascii?Q?p1orSM8c6O9BmFIj6L5mw67IAHavT+TPG8dUNwvhSdzI7NG6KTdMoDF4Pbdr?=
 =?us-ascii?Q?GoibNy6Jv8smxp/JMMtekcI7T5mdvxvpB1hGTGGfj/xslmz66jYoLaB9ogfc?=
 =?us-ascii?Q?kVgD43YvTJAwa3Lp60uVehzZ8mrplNOR/Mj8gFyMfv1Ir3yMF79H2ykzEj1j?=
 =?us-ascii?Q?N5NntqACfsJHnzQ41ZY6ONsuytinQ2w5bCLlgVq8KkW6gNfCGgS/v/bvGCHZ?=
 =?us-ascii?Q?p30C21WIJZse/z7O+/i1m+2vTeF1FUwADbqNClNowx2XkKq/ubRpBk4mgfBy?=
 =?us-ascii?Q?6MvfD8AfgZkg7wrH9IqvONsQGSn/ox4fCwp9cfndT6siOLThNmrMrQOWCbPo?=
 =?us-ascii?Q?qbg2/IAfKn2Qn9QRRci/vp7RKmfQRfJpFRyI+A0Fyt7FuEJ+QR/Av5KvVl8h?=
 =?us-ascii?Q?jtiDFILUnzK7ltdQS6V3V0xkzzNyqkM6x9mOCLepfUORiXtXx3nm/MakQu3T?=
 =?us-ascii?Q?bPlJQPQ/nXMyOqXgweRhgYE/kJXmPK78qI3XN5TDNHGOljl9RaCywGq4cM5G?=
 =?us-ascii?Q?cOI4iyisauiGlKIfnSjbG2Cy+TEOf/EicvASiyHldDSaWzMvCpmDDLQl0BCd?=
 =?us-ascii?Q?LNziVPmAVMerxA3CsaXwsYQcScJ/Z3t2g68NK773DYS31zCDgUjiErklUYnv?=
 =?us-ascii?Q?2BM8DkVHRQY+zrSEZySqDgrw25lM6idCxCRv1rFTvscSMMccngYK+jcCi+zb?=
 =?us-ascii?Q?O8lLJY8AiichSTrC25tgHTBpJs1l8LYsZTTV+8MHydHtYQ/8NdL1dHkJcv4E?=
 =?us-ascii?Q?4SztFuk/fCU9LESENBe20TUJ/fM54a2TC6FTF5LCQFvish+T8BfM1pUjnzDK?=
 =?us-ascii?Q?dKmYVu6dZRXtLAXcOjjB6YUuoqTJ3FvjnT3P2Va+MCzIaPSKD147nVRXH1NP?=
 =?us-ascii?Q?2NgoxHq6rlAsbXzNhI9emf2j8B4RQSgqQCJoX/NPO+QDT6GpHFjDal66jC2R?=
 =?us-ascii?Q?o8XN+ogJ1qkVTiSJYD42xShLN+Ls4gJfrS6tiZQs9cdqLCwzxA8LZLJpO8qX?=
 =?us-ascii?Q?ao0qNg0+UWQCNaAkIU6Y5uI2xukPBC2b5S+vdoPRDxu5g+kryIXjSDRZA/jC?=
 =?us-ascii?Q?CbA6S+XO4Vc8Gvhb0/n7e2BWQXBAJ4/OixBVGt4r6ygkfewlyCFlTsrhEJbS?=
 =?us-ascii?Q?KOpmLl73V8JNJra35HrULB750mGB0hRPksQE1s3eSySKsKYNyd7ylb0WRgao?=
 =?us-ascii?Q?ZaGek8IygNuuqafdXDpLjQ3yY0g5RgerDNf4kvMW0f3iyMxo7hG0h7lyv/rj?=
 =?us-ascii?Q?oTir3TUhVOtB4a8jPtqII3COXS8aEDjxf96/F+q9RE1BFTETXrGBA4Tw2IPk?=
 =?us-ascii?Q?hXeClJvi8Gya7sEVY1O6FFELRyuP9UCs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAvAARgoxp00EsVmXVgPOFQSfgrxuXLnQjfL5T06q0SNqI/70WMuZKtv1ELZ?=
 =?us-ascii?Q?nDiz6hNl5qqrXaNbbxn244YmcVzTSqgU0znuo4pB2yKQahgE6p9uuG5HNxyH?=
 =?us-ascii?Q?z5cc5jUvex7pMIqz+zWXg6aShHtjcXjGpXKS8LvdO9IrBvJedgc5RwNkj/9N?=
 =?us-ascii?Q?1rnti+EeKnd5YeuUGEy778im57sVGaf8yQswqO0kz4Cy95iYIYDcXLMyh8hL?=
 =?us-ascii?Q?FmQFz7lInenpqbvAwFR1eoBrEJFtN0du6MGR83if/X5AgGAtpjrU7Fpl8/pP?=
 =?us-ascii?Q?gqMZMcwvQEjP57toDVJi0WTm1WfmqcuDrP2PhSoCXdyVzZVEynTTIT/fH9qo?=
 =?us-ascii?Q?HhPhuIXADGcymY61O+xhjsSYEU6RPTBtyTTJ7MGhywtlDaJ9h2oZwevzQbvT?=
 =?us-ascii?Q?YCLmTPdgcHq3Swro60/+59Qg7Ru88cKqEvhHEDGDrYw9D7lQxkZSIxfqn1aH?=
 =?us-ascii?Q?J1luRe+tjZPoLdvmTzcMM0qoqQiU8OLCCYDTbfYCtByvwiXT1FI6Z3jRbFkG?=
 =?us-ascii?Q?anAesjB5G2vzXzQ0kGBsFg2/NfftO8wn5qw2ywUOxGO5jSJl3aX5KjF1iszP?=
 =?us-ascii?Q?e5+2XhuNjC00lqsSxIkklKApXisn7N/e8OD4Flrkx3TIuwZp+XQfN5g7rgL+?=
 =?us-ascii?Q?rN58QgHaOy+xNzYunhiTfO2ZDkoay4cp3KclCtao/1GpDyco4lTUSQNVODP+?=
 =?us-ascii?Q?Aly6+REnKBkSIdWkmQkWja9sIzlx+f9MDmrAjUNSpGiEZHKx0R4a75WM4jqt?=
 =?us-ascii?Q?LtIbzkYvS7TKdChhTMwd3wZoWQ1/W+fMmH/qo03iDJaWHM4gMTMbLusJ0Qd/?=
 =?us-ascii?Q?l7zII3hO114DJp6z+xQY3zyE3uTBvnbJMyq9x0PVqjyJU00wFaICG1Lh/3wr?=
 =?us-ascii?Q?z68/PWS9D+MCjXFfJaT2HnLVp9e2FQQynG+ghGf5CotIq5MdWSq+XlAOFDim?=
 =?us-ascii?Q?IbV8IBvbTTE/Pp/Xu/ngb2XoyC24R0OJ3Z0TVIPc650oiuH32r5fbdND/v/7?=
 =?us-ascii?Q?jAA6hrLiehS/W4eVy0ocdtcmG6o1M3/hNnh3vSDKREpKtrKpVrE7odL8beb9?=
 =?us-ascii?Q?H094N6dXJR+oVAiTCXWckUCxwrg25oOGFxTP3hM39mRGAQQZTemL7EWO3nnB?=
 =?us-ascii?Q?F9NtuUNSKpl9Xb9kEXc0PrsNuAPEjGyhNOb09Jf+5UGPsaw0O8ycGbjYIP08?=
 =?us-ascii?Q?kTkN4iYJSndN8l7K/91hJZLGB0vDptctXyynpxBlE0htVxoZ1IDLJALct1f3?=
 =?us-ascii?Q?lGXvETStFtmuPjmt+x9m3hI1Za00bleflhjKiTrhDjA+LVBSCD9Q7EpF3UYO?=
 =?us-ascii?Q?tbwFa49jBlMF8mSiwREAtGMBoyv6QdMQ6DaCSxRrLKSmwa864XFYX4/X28t3?=
 =?us-ascii?Q?gA47ppx9IxT8Si8rjoLPR5FggOzu0bHX3Ft9vhTqxqiAbYDINLE3XRCf9ILv?=
 =?us-ascii?Q?MMKD0q3xl8x9c3HauM1wH7NEZxfZ/Zd9hdjbli9I+QDNQKEcKN+KAsAxdKPX?=
 =?us-ascii?Q?N+CRunIOSdhHJ2ubD782+1x9vrAM3yWTcIYv0EXr36oE/OoMmhQOsGclYjYM?=
 =?us-ascii?Q?U3gjKQCq41R8ipjaMjAOXtUFi//SRDdDZhm89TS8TC1hRwu49U74KjpNxmBf?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DqhzZzaZilb6T/mESmYPRTxOE6kzCQqovBYLbNYtbfDZ8R/bHa1OdIIjVUrwsVOxZzraLt5z3lj1VjqbiPP/eBx4C7bR0j+fCRMJferwGGhZlBdRfdDcrqHj1vzRxIR0dYSD27BEH+3+mogmULxVUGEsZ++1yF5SBK1D2XpLAjz7SjQhW9oalaRsOFenw0Ir0qdNn7x2amgErdFZzC2wni/HnWv6A6YShEoVrgs7D4HAO8qRmZvUuzDyoh1n9xNxu28/fr1OFDKQff2yyoRVAiTMpXbkfJagUGZXUOygevlVUjtqFn1kECEiVxhAz6j4ugisrrg/BO8N10BUo+D/2tkLizaEjGLR+QVv3YIVm5UFyMJHNcl4OHHRcquvo/w9ytKySoOqSVmdRQEcGIqOaxwdBUr2+X1W/ZChfhVunFa/wtmeUw0e4D40zyQcKpo4aKD8Gau2khbTp6J4CjBBlzuKlqOO9kxtTpV3bh/SE/VXOzdpCfzoZ+0y4elJCdButg1M7sQTwWjlEBUXm2dQrbnrQLc/1ZZjj8nFb1YpayWdmn4V4eiaAGnMr8o/10F6TWRm3TtPLABsnqTML6RCv9GfOJYoxECYDCSHKtCAnN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c69889-0b12-4d47-4651-08de2933c6d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 19:25:48.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yov6pICumBcW32JaRJuHJCXoPJFSd6Oh4kqKgAK91LUR0b+hVIbmQoFMpplgnydlFrUCdXxLC2UpJxtvb29/ZDTKgBlVPo8kdeA9VNba+8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX5/BFlOb2KV+a
 98Mn1zvriKO1xofVyLmwFyyhtEEsl4JSOjEs7jDt9rgZ3IBxfndcPETJ64uL03zDnT3w3vaUhcy
 pttZec8cL2eL/F/zQdGVvxOgjzO5CtOTF3IU8hNoqnl8u5cQj+hNTuk3Jd+Du4zZ6J98omJoqFA
 bc/rN1CXDhHOiuadwm1LK6CQa4070VKcjxphUly32qS3JceoKEkL72jI/gpgKUWtglWs1cYdIp0
 v2/k6huTDx38RCvHXLQB67pqH3mQpt8Tz97lcf/K8OHUN8yeAWZW3MYtKXeocw6puuOUdUwDLZS
 Oqq/ckJxempCo871dFJpqlw4nT1iW0e/zUVS/WwfU2E7vWMd2Ba9we1ATZRNZXufJWkyutJeU5T
 zfuciD+8KyKoQCXtAm5Fnmp1vVfeFA==
X-Proofpoint-ORIG-GUID: M0SzDo3ejQGftGJdcIaObrd_gOhlfCob
X-Proofpoint-GUID: M0SzDo3ejQGftGJdcIaObrd_gOhlfCob
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=6920bcc4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=j9SL7sMRcDHPlrZQHbEA:9 a=CjuIK1q_8ugA:10

On Fri, Nov 21, 2025 at 06:42:05PM +0100, Vlastimil Babka wrote:
> On 11/10/25 23:21, Lorenzo Stoakes wrote:
> > PMD 'non-swap' swap entries are currently used for PMD-level migration
> > entries and device private entries.
> >
> > To add to the confusion in this terminology we use is_swap_pmd() in an
> > inconsistent way similar to how is_swap_pte() was being used - sometimes
> > adopting the convention that pmd_none(), !pmd_present() implies PMD 'swap'
>
> 			       !pmd_none()
>
> ?

Yeah sorry this is a typo.

Andrew, if it's easy to fix could you? If too late then never mind :)

>
> > entry, sometimes not.
> >
> > This patch handles the low-hanging fruit of cases where we can simply
> > substitute other predicates for is_swap_pmd().
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Cheers, Lorenzo

