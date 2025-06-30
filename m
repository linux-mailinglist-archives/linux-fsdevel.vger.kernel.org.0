Return-Path: <linux-fsdevel+bounces-53394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F56AEE55A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D474B3BD1CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC329346E;
	Mon, 30 Jun 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9qzPL3V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sMNL1R+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF128DB58;
	Mon, 30 Jun 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303242; cv=fail; b=u3HDr7gaPprgDIuqCT3IBOEITWRgtP2rySRhru2rDtHam5S3UANMaVVyVBOXq6rcb7+Fne2X+ix2msoq8JwlxUUqPHVZbe3Mi0kzvUDGmMLdNcOiWFGP/sFbMtZvNwl5xKG7GlenhoWsQSCVtMw+RkGMcp25BBSH61QL1k209Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303242; c=relaxed/simple;
	bh=vvZU6/72nzC9N2quDbHLoZty08D1hjd6FbOOZxhN3y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBPnTDkeQ3L46Fe8RoX+8DQn6gjws7XwADNfn4976TpxUE4ig/bPtu8rpjWVqzcf/rShTOD5I/+V3rXhnY1R3IlIvRGwGOFvVDcXJ22S+LjOBbJ/0suRPA3EvGm8XVl6Sye8u4qw1YTxlQfxpcnI05xSRGo33X2onVpRgODtTY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9qzPL3V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sMNL1R+A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEktm9017264;
	Mon, 30 Jun 2025 17:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8+buwwMdLFNX8YL0RM
	H/ZZEYvn1T5mnYtRC89CTOmzQ=; b=i9qzPL3VgDmm+SCsNg2jg+rgNBOGM/IZbc
	4YWaveK7ur/ecf+asKFkSY3Yl7KNfeSeigTApzN/cakigGSoM7PpGYJAVRE+tggn
	+HEMVgck5XGFOC9vfs4+ry3W/gk4DlAoSoO3u/a7jeCl9IOiX6z9rZsOFihW1Yjs
	tW4bBp9dX97ihbQJO79aiF3mXY1adT16gdY1jx2go6zLS/8ftFucFW+DuRDoToZ4
	jY52JcSiHXd9VXmu8OiJVrcM5o8IAH0Hn/yfQl1YYvhjobzLr4Su/Q1vI8BlvaeE
	SpMLzL91WDcfOB/zOb5+alf9UvxPVeHrTs7j48QqKJKzoHAZ7AgA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w2ydb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:05:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFZ9EI017418;
	Mon, 30 Jun 2025 17:05:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1dby76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 17:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XELJlYSXxuOroP1Tktsj7DtFypMLqe1Zx/vnmFPV47wn1lZ0b0KIDNWRiozZrxVlUslCJ9NfyVlx9dUKn+1U14aE94rI4Jco60H6xWawY/7TBEAFYhsZbFoDXoiZXQfi67pYlwKh9upEVURDRtrM7XWBr9/o1RRt9ZiEaWyrgsGdxZtYizzuWJNJekKB467OloLqiEUSem/Qwe/u2EsMXNi8DIsBTk7UAuSE5hawtIyzU6NY61Xll8eSpT/012icJR3oOYBNZLhlpOvhrP8kC9enjW5GescqkvWyr2BaNqVrI27CrMqtMDWq4MkiKaPpKLQybFKYcvXr4mt1JAu3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+buwwMdLFNX8YL0RMH/ZZEYvn1T5mnYtRC89CTOmzQ=;
 b=Oky5wUNsE7+xsPQZXF+P9AlLywM4TfLXuh0AMBZRGhNZl+mkMpkR4JxfEq/bOaOn24NE6NveRB9CxJOwGVuQXoh5mBdqWRscFhulIBb/J0/mSSgbmHpK+Az29+0l3Di7NW/Xt2FYTPKiAWlL8C5Ei/l/V15BhoqhMcGnt923PpBjMDmpEprRgPIfwVfjmRR2VehDqZAWhWj5pGhHHSfVvFqB9FZc64XDedOWHHbWgnjTuRtddJtuv9RF6V7qwDwyDz4ghaMKW8RuM7zYdZi5MsjeY121F/LtTQWv2RHBpJvIZbZNPiG7hSzYT+DBcPxcN1YyIGMxf1IPEw19w2B5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+buwwMdLFNX8YL0RMH/ZZEYvn1T5mnYtRC89CTOmzQ=;
 b=sMNL1R+AnSFMW49+RahFAIqNdac/EWS2hbQDiKVTrpdfOKKHnI/FwGwOpX5gsloYgsN+m3KCaibTrItuVPIpVNabIbRYC2ieLUXmeUx7QXW+Jxg6PdlSuEV/g80Y1+KWNLlCOPUIJs79Mwero7pMngaxo5Fary6jpzCR5fSK9h4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 17:05:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 17:05:42 +0000
Date: Mon, 30 Jun 2025 18:05:40 +0100
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
Subject: Re: [PATCH v1 09/29] mm/migrate: factor out movable_ops page
 handling into migrate_movable_ops_page()
Message-ID: <6aba66e6-0bc5-4afb-a42c-a85756716e1c@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-10-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-10-david@redhat.com>
X-ClientProxiedBy: LO4P302CA0011.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5b3b6d-d6db-404a-2689-08ddb7f8586a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tMmA5EejqR4gwzb6sXUVkbX0CEuNVJ+YRTIyO1QI44ArwR31efvXsEwI5nk?=
 =?us-ascii?Q?Lmujc9xzSyE4XJJYileAm/bWR3AgImpwf+h0J0cD/ubcrffiutN3zs8k0Dox?=
 =?us-ascii?Q?PpvrWYQhZhVoym/iVkWsTWxr2d9pDSCAjcv+bOLK21bR52NUBVyy5nksDeN1?=
 =?us-ascii?Q?tor0H3DMKOlldYUTrYLGEgTEepE3H8Zxb/5xuk3yiwD6SZ07ALhEyFGQfRmM?=
 =?us-ascii?Q?f9qIGucHQQREltkrRgLz8Vidgj1ObbVBfWAs3yuxxlXAOj1XepugZXtGv0C0?=
 =?us-ascii?Q?HOF3G87hcHOp1ilgcaZVzBZdXA8dyUIYIfRlZvxN8XJENr19W4N4m3kD0kCg?=
 =?us-ascii?Q?7ajpRR87kONiaBPoJQpMPgNyS6OmBjRzEC0VbAoOEpoGkZDqk4KYh2f1V3hJ?=
 =?us-ascii?Q?Gz/2hK5KFHYPslqkadsIuhqfaZB3ETdsRVhoULNMPQ7TaHLXBfnkliXcb57c?=
 =?us-ascii?Q?yi31q0WxNaw9MXbX0ebMgEcoP25bP7IFLxeqP7wpiW3Hkf506x5Z3dwXkC38?=
 =?us-ascii?Q?hHAkLW//V/jqdcS5UV7ND0MtqOA96x1zt9gwNKzBgu5G8FlSINcf0n0lWBWp?=
 =?us-ascii?Q?pS7y6HZX/0BPR0+IYWftxEd4dGkK5/G7fT7XJCPuaN5NO6+V1FGD130/cTDO?=
 =?us-ascii?Q?ZCrDHxTx8Bf21RuiN6sRA2w9s9Gp7j/LCjFBECMducJGrP8/mFbZlyNNnN+e?=
 =?us-ascii?Q?fG+1mh694dDsAqaJALQfqrrVlnPJfrEnssBq8/wXBdv7QANPNoIHpT4F1kfA?=
 =?us-ascii?Q?VLYZjvTcul5SkO8HIEALG3enfYvIotJbYyDUUNrMdAeEI9AFpzWM5ECpjfHE?=
 =?us-ascii?Q?iP4ViRKpCd9eJAGIGqAuPLMs/9Inp5meH4RWN/OrSZce53va9i6LFOrpPVjV?=
 =?us-ascii?Q?kFw06UsWpjZuBqkmv14KxRqWUOf+cM2Nhy5jD3kzrzZjB1vZdHRUcIrHg1Fn?=
 =?us-ascii?Q?FnTTeZmzKI0y/u4L5TtAFsj1CGMWLyJg1B/RwV2Dp05DEhnQiARqamdSIS5W?=
 =?us-ascii?Q?duVit8iJMiQ6wi88+jWWjLHwI/qyp4jcjm9f6sGCQwPpb2wUpfQW/TBeGoiW?=
 =?us-ascii?Q?+QE57GGbljR8GXS7FTZC0CaT2VXhaBd8nlT/YJgqBi4QEIAG7FIrKynPuVIn?=
 =?us-ascii?Q?OGlps0j1G7Ce2I6JkLwxnVr6em9HoLCAym6T+3FyV/KPb3SuTH64oI7WWB4W?=
 =?us-ascii?Q?n3t9c07VltF20MyjwkDt/Vk20q1NIXJ8ph4A2fN7D9cZraodD8qOQlqYGoXD?=
 =?us-ascii?Q?1H9sQ5Rl5u0FUo1GC04R0VFZw48slSaPJyzei7yyOT8CSj3Bz13AAVwT2xX7?=
 =?us-ascii?Q?v3GzJwe9v1Q2qoLahSjpLiyvWgC0z4jvPpL6V7+CL2XIG7ye/zTv+7E3nAhJ?=
 =?us-ascii?Q?kUXwA1cGT27E+pqyzjy/V1D8lEAk13yqgGxalPE7Ne30hRjVURviUIRgIWKN?=
 =?us-ascii?Q?6aWKGDhf6fU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t91jtCueHF8/PAbak2oB0GzIo+abuKBleEkFtLAZ3qg3nTqSZzoPAKGhorFQ?=
 =?us-ascii?Q?KYomP7ZFEpUeahNkcyP7/du4UYJruHQC2J0kEeK/ALlbbVsnBlgnoBRq9WLw?=
 =?us-ascii?Q?McmoA45q81QJMjJVgMvvJ0fubRMhRVN0G7iPNqtrVpkr9gI4xP8mTRgNhGjx?=
 =?us-ascii?Q?CcvkNLnjlmGiss7oRjXxcVJXFvQamiM3LWqQDeBq2ItCsDFSk37jHi5V2Zn/?=
 =?us-ascii?Q?5wamoANsUOoYAz8XeDgrjHCgwFJkVY7V6T9+grOB17dIKl/wqUfTakM8b60n?=
 =?us-ascii?Q?T5nnu8Yntp9bz1PgjBEd6vCqp0jBX0G6YVpLN0GN9w3lPw8vWr0BkVFk8sql?=
 =?us-ascii?Q?9zULh0RfsXYjtAwssJJepW/SX5xjaSj5rVVBdXsbsYUvQuYY6wnJm5ecy/Xq?=
 =?us-ascii?Q?nEqdPgEwV06URSi6jmOXB9Hvj/XkI4hrxV+xgykHvb3CGoI/m9CjbNovHj4S?=
 =?us-ascii?Q?oglJ01y1bxQW+D0EnVXVhZbsw01oPj1cukitbBUbqEM2Wsu23aDAhbgmnmgK?=
 =?us-ascii?Q?JMjpGV2dSOPbdpxj/JmJiQBkfUKCoZAgbyBwZ1L6r9thlA8FlGbZD9wvksiI?=
 =?us-ascii?Q?aedHqR7scLmlwiyVxZpLDqleq+sqGWaVWFGOquRZqgIlUOR68OtTKoQFATnb?=
 =?us-ascii?Q?AuK9PBT/FmDiVNz/4kifY3P6EINYEC5MAb4SRS1zz4ZF/DoXqK98T0qzy3mX?=
 =?us-ascii?Q?Iy4ogKw50A2bbHXhf+Chyba8FdkyP9ht9ZKJiDcXAi69ejHLNlmb735Q2J1p?=
 =?us-ascii?Q?YDyBJIX3gipO4ZGqXEycP7jIkXJV+cXu9lZ14WmvjnFAr8lsqTqcPmsaLXJe?=
 =?us-ascii?Q?nELMTx3BYVxPPU0QO/exkfmBWDnckLqY/EPHiUXzGCWKtE7Pr66TSCPEeAUJ?=
 =?us-ascii?Q?gEHl5MDFcfll+iwpiK7C6VfyJXuywVbmoITekbx/3tbJuvShDxvmrODYCzWA?=
 =?us-ascii?Q?OqCeU084usxaIuDbW3vLdkXJkPBTiGwU3AGtOIbLpBok+s3lobiMd/svy8Af?=
 =?us-ascii?Q?vCQxDx3HelCMwvmgF73Z4boT/UM8SG6RaNkDfgdkLgkwuGCjq3Dh9paU+n49?=
 =?us-ascii?Q?xz2MImOrao5M2GfQPUGDM+9D2vhe0JY/eXkabi8pWlEMoxmir5gGDPE1GY6a?=
 =?us-ascii?Q?Vgife8NIdN/Z/WFtEu7lLWLYTQHDiB+Ax913tHqy2yLBt7yhB4+6RI3Tl/Tn?=
 =?us-ascii?Q?CUzrIiO1wx9ov5QAFGlLxut4u2p9Rz+ffqSc8wgn4KooWWdh4s9IAVoHsHm4?=
 =?us-ascii?Q?wH8/1PN8yneEBrTtX3Th/185H5i4NCmhVXoEwakZdhjJm+KwCS4xBrfB6/Ot?=
 =?us-ascii?Q?03CNCVGLYg1sn2ZVv4lE4hzehIeMQcqv4gZ0+luvElp8zS+XtyiFFLvZre8u?=
 =?us-ascii?Q?NMdrqlaf/VZdIVaaQ5E7JGy45s8ZFXmPfwK9mFh0nrAavbxBwZSW2JoKusuh?=
 =?us-ascii?Q?khtp2xOCy3G7Eqwr4fL19lrAu/I2Zx7YnZ2mUI9rZEBkSdPR32bR0H6s6XFd?=
 =?us-ascii?Q?4cuyqFQz9BuiV6UwLVyADgNO8pfxa2EQQyDK72rqyxKs4ZjEeYSNk/7R/Sre?=
 =?us-ascii?Q?+C4fUeSwFoaRFJau5BkgVMQMIO+mX9w+JpaNhK9F+e/FRoROgBogIm7lWyRo?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4nRIdCLsXvoHPLNqaKLkCmP9ZFdXDoey+iHGtUv8okQ0Ii7WajC5ilLRR/DLc7Ne/Byy18lHq/318X0oPlxi6u3VlPDSwfQ+kAfyzTPUWYFgQPqHmoq6D1ESN5AFQJoHIuq+uvlqYZgE9cXPNjku+EQoolpQglZVeLit4SQZ36uSq/0xyE/gTN7Z7o53LGoE7wtLXZ4qmG6EW91ZfFUZSL2FpEGo0DJaYJgc2Fleybo2nHZ4B4yMtXxULnMIo45iHCWkb7CyZ5ET3jsZthlgCeUHJ3ALRdr6JKvsrgxt9DqxbpvT48y7m/Qsuhhzj9to8j97ALIWiWu3rMN1NYqTNu8rP0FWX9ZYPsQgDRVCaHljbOixtqLgpjjKV05GTk2BFFIYIK7rniFC1+sCORb1lyDRgT65Blwori+O7nhZmoubodPzZxCcmrrAVkAiOoUIHUrWr/MpvZF0isoLqzOxWWvn0GEbbc0zD5NzLum48Q5wvSHFkhZsGzCOY0ZdMNRq+L8crBkR1oHjiET1p6BDqxWMOQ12pw0ETbq68Pr81J/AVKdRecuBxnsjIPPALOpcqGU8VtWIDt/7jyaPTR7UDhYuN6sLEupAIM5yVTLwaWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5b3b6d-d6db-404a-2689-08ddb7f8586a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:05:42.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNwBtV43vAn6QK5siydCQgYxW7evRePErPbmoKv5K76NN6ms62oXLevTn9HMt6hpOx8B/nuWaoQns1R1x8Ux2nzK9kZ5UweHFkktBSa4jJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506300140
X-Proofpoint-GUID: mqtILnYzuFCDomIcBGRYtBTN9UKe-l7O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE0MCBTYWx0ZWRfXwjwS0QZFalXo fPyE0oUmuJDJs+191zNEqzfQB8bj2p89dBYWes4YPNuiRSEerhq5mxOejmKDh3YPp5JNpUb+v9i KBE9XlFkleXqghqfo0SKDtD48zF2jvqjMfMA4GM64xDYg73xHuKm3vfIBZVizGZBIhg3+z9h6mo
 lARBpbDStHxBFtmbqXqpntHEuQduX8N/O2yzcJ9c1TQW1WLmKI66DCmDGt+UU35NDWZiRDYOCpk xyetbb1ZINIcHUUwm/obHATXaPZORU0fZ7f1msVEcEuhCElseI2WYCLJ2QJtI7N0y5e+ziKtd3C X55iRb2oyWA1pWwis2NQIScRc65eGtArkCMj07y6MAN+YpuFTWsGCWi63LNLQqrqUT2WI11/heR
 d6ksXr7+QSh14yTQQ3vBp+tPkTAAmneIrqQ0QVvWO83ecXc69HUCuWYAUJqBfAy4c1mJYeFI
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6862c3ea b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=I_m2BDi1HNbIkEHEblEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: mqtILnYzuFCDomIcBGRYtBTN9UKe-l7O

On Mon, Jun 30, 2025 at 02:59:50PM +0200, David Hildenbrand wrote:
> Let's factor it out, simplifying the calling code.
>
> The assumption is that flush_dcache_page() is not required for
> movable_ops pages: as documented for flush_dcache_folio(), it really
> only applies when the kernel wrote to pagecache pages / pages in
> highmem. movable_ops callbacks should be handling flushing
> caches if ever required.

But we've enot changed this have we? The flush_dcache_folio() invocation seems
to happen the same way now as before? Did I miss something?

>
> Note that we can now change folio_mapping_flags() to folio_test_anon()
> to make it clearer, because movable_ops pages will never take that path.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Have scrutinised this a lot and it seems correct to me, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 45 insertions(+), 37 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d97f7cd137e63..0898ddd2f661f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -159,6 +159,45 @@ static void putback_movable_ops_page(struct page *page)
>  	folio_put(folio);
>  }
>
> +/**
> + * migrate_movable_ops_page - migrate an isolated movable_ops page
> + * @page: The isolated page.
> + *
> + * Migrate an isolated movable_ops page.
> + *
> + * If the src page was already released by its owner, the src page is
> + * un-isolated (putback) and migration succeeds; the migration core will be the
> + * owner of both pages.
> + *
> + * If the src page was not released by its owner and the migration was
> + * successful, the owner of the src page and the dst page are swapped and
> + * the src page is un-isolated.
> + *
> + * If migration fails, the ownership stays unmodified and the src page
> + * remains isolated: migration may be retried later or the page can be putback.
> + *
> + * TODO: migration core will treat both pages as folios and lock them before
> + * this call to unlock them after this call. Further, the folio refcounts on
> + * src and dst are also released by migration core. These pages will not be
> + * folios in the future, so that must be reworked.
> + *
> + * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
> + * code.
> + */

Love these comments you're adding!!

> +static int migrate_movable_ops_page(struct page *dst, struct page *src,
> +		enum migrate_mode mode)
> +{
> +	int rc = MIGRATEPAGE_SUCCESS;

Maybe worth asserting src, dst locking?

> +
> +	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
> +	/* If the page was released by it's owner, there is nothing to do. */
> +	if (PageMovable(src))
> +		rc = page_movable_ops(src)->migrate_page(dst, src, mode);
> +	if (rc == MIGRATEPAGE_SUCCESS)
> +		ClearPageIsolated(src);
> +	return rc;
> +}
> +
>  /*
>   * Put previously isolated pages back onto the appropriate lists
>   * from where they were once taken off for compaction/migration.
> @@ -1023,51 +1062,20 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  								mode);
>  		else
>  			rc = fallback_migrate_folio(mapping, dst, src, mode);
> -	} else {
> -		const struct movable_operations *mops;
>
> -		/*
> -		 * In case of non-lru page, it could be released after
> -		 * isolation step. In that case, we shouldn't try migration.
> -		 */
> -		VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
> -		if (!folio_test_movable(src)) {
> -			rc = MIGRATEPAGE_SUCCESS;
> -			folio_clear_isolated(src);
> +		if (rc != MIGRATEPAGE_SUCCESS)
>  			goto out;
> -		}
> -
> -		mops = folio_movable_ops(src);
> -		rc = mops->migrate_page(&dst->page, &src->page, mode);
> -		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
> -				!folio_test_isolated(src));
> -	}
> -
> -	/*
> -	 * When successful, old pagecache src->mapping must be cleared before
> -	 * src is freed; but stats require that PageAnon be left as PageAnon.
> -	 */
> -	if (rc == MIGRATEPAGE_SUCCESS) {
> -		if (__folio_test_movable(src)) {
> -			VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
> -
> -			/*
> -			 * We clear PG_movable under page_lock so any compactor
> -			 * cannot try to migrate this page.
> -			 */
> -			folio_clear_isolated(src);
> -		}
> -
>  		/*
> -		 * Anonymous and movable src->mapping will be cleared by
> -		 * free_pages_prepare so don't reset it here for keeping
> -		 * the type to work PageAnon, for example.
> +		 * For pagecache folios, src->mapping must be cleared before src
> +		 * is freed. Anonymous folios must stay anonymous until freed.
>  		 */
> -		if (!folio_mapping_flags(src))
> +		if (!folio_test_anon(src))
>  			src->mapping = NULL;
>
>  		if (likely(!folio_is_zone_device(dst)))
>  			flush_dcache_folio(dst);
> +	} else {
> +		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
>  	}
>  out:
>  	return rc;
> --
> 2.49.0
>

