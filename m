Return-Path: <linux-fsdevel+bounces-53485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9EAEF80B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2BE188503D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBF273803;
	Tue,  1 Jul 2025 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rmND/0Cn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J4af7GT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B52737E2;
	Tue,  1 Jul 2025 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372032; cv=fail; b=j1pa2DqsZgPPkgSpmjS565RX7JXes7/Ew1PZhmkaM7RCRrYQfItNiyFcWwrdJWM1i4qORhAQFOgDEb7qtbp5h1bKFeMlMHR+42FtQQARbfeeoWVB+ToONcCXFHZjci02KV//Uj4IVFIPHMY2lwIlogKTo14Jk6VHrJNk84Axy7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372032; c=relaxed/simple;
	bh=KoEh4dLd1hVvdFWnRysMTTz4Q2SijdgsBwH2HW98MHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccYPzOeXBeESRjDrG8RGGb8mcGE7gnO9aU7bd/PdzE9UcaNLQuTmKMGNxnOtaawAUdnLRrQP8hXQL9aQLYw8TuclbmLYA/eKHdttBdximY2vN6nzFYEQEHkzS3RnI5A4O9hBmtdAjero3IAPwjAyX3FuGE72dZ6wsGPDcTuF77s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rmND/0Cn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J4af7GT3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561CCBjY007808;
	Tue, 1 Jul 2025 12:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=74hBpB+fcjx4dMmOuz
	rDsKPpGplPIew8xOvB8lD6kx8=; b=rmND/0CnyaOPlsCq6T13+yBIsWUhCe9Nrb
	PiJ+rd6EqWQ7KvR+WvUYHOoFyYLED8n93F5H61eCXPNclOZBeeiAU/W19cIg7Xz5
	E5t1heYX7tU70lnAuxI01xR70Soms933PkRhwmiDj8CbrZe78K/1O2LcZBDV39XH
	9EzzBEp/8/tzHm2zjFRUa0FGAOCVllrZa3Eph0hFamCsnjmBgXh9xSHUs4T8uqsJ
	bxHjcXk/jWxxNvDpbXRgjqhfaIr059WLJ1x02a2M37L7rosN96uu3RXgTYQXUb8E
	M22hICUzWqpMKw9gzfLGxBNpCr8PBj5LJ8Yvhai9csO7CXR8afBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7uwyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561AuX6o009179;
	Tue, 1 Jul 2025 12:12:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9pvss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 12:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r40BexvWqbV0LMO5zU+iz91b7Q2zmy98nTlxARFQ5lWacMNnooG9fBardAwQGx3GK5GEAoSygLCDwzdHc+rP4lWuJoldaJ57ieaZ9BH+8ZQDQSPWPSFb40iQC30xm8p+OXewN7f2KQKAhDpop3JQjRq6k7vUPAGLk0DEUY38n6yhJ62Un1cH3uQ5fijzP50S9FrfkkSN26AmjO/J0oQSreSf3x0GTzqeU83OMl5UFFtHxkf03jwBCRgeeI/Nr0U17/VLBr7oPVq6RFaDXsudg6KUvr23C5E7q6Jh7VXsh6Eawhpp1QRoqd1Xqktn2dh3esXryOqJaP/FzylYfwZb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74hBpB+fcjx4dMmOuzrDsKPpGplPIew8xOvB8lD6kx8=;
 b=NQWHH3FLyRrYPT1WHLjVmq0kaKqyW2L1VsUSlaXItK5dw9v/iUl5FcE9s1iWoQo0F2xG8Ck9EdTl9hXcb4qXuxm9o3FAnNkiZLGyMVIqD7h7rZvcQxZD6FVCo6sxNpc4w7o7C9qhaU+A210OdI41mYyuosWNudi9IHfOVZRIXPr3ugOQ5sX57GbQUICAIYymzO2IHbBzZfro0AIKBVQOpFD5zbC861hrGvu4MPC02W8Mu9x0lUVcAyjnKydyP86i8CQSBxliDXkGPd6yyIbDiVDhtV/zWD334mOLFUKtyDqXAsbjSAnpdfGWCHb2QFPFoKcr2FektSQczdUqNuDneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74hBpB+fcjx4dMmOuzrDsKPpGplPIew8xOvB8lD6kx8=;
 b=J4af7GT3CNklT8GWCDFYJ6BPHcA8OmJT+FULkTpjSx/ub23tRH6/bo/CD1VIahHZ7//YJN3qggSEsWNNCYezqOp4zrOIwj907rdq+ju3B1adpRON1EeCJK0PF6Cn9x16Zt88az6qmCapGwZfREa7vkqwqPM9reHsOOyznWLIiVk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 12:12:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 12:12:07 +0000
Date: Tue, 1 Jul 2025 13:12:05 +0100
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
Subject: Re: [PATCH v1 19/29] mm: stop storing migration_ops in page->mapping
Message-ID: <cf92e5be-d9ef-4998-8cfe-023221bb9d5f@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-20-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-20-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1a3561-b742-491a-bca5-08ddb8987f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLmLE2CnOhubMwg9O3tC6h8fhZ4ifX9zmtTx2Hn9qpC2cQJVxo6nNyWcDGWV?=
 =?us-ascii?Q?KEZ2a9q+hT7xiH3UQVBDhB2wk5e5mQa5zbdwsjcnepFANkse6H+f88O65bBA?=
 =?us-ascii?Q?5qy26YKTT25oOqSwU5RnNtcirEAV+d4tTlGTfCxjASg4oCR72uxp11eAzCah?=
 =?us-ascii?Q?5U6GllcrSlVSjPlolt8W/vXgcrAFSCawr+WcB/ZW8qbvHpVwSGV0TgPCUpGF?=
 =?us-ascii?Q?gR0wQtee+hcGq1M1elNy+KfLIqr7B2aqNbLavW7DakwnZAUYHWn7aimwL8MU?=
 =?us-ascii?Q?MMqUJXFTaqq6AhKi3j7DdHC/EG9BHcwBvntl/EY5vUpjQMsTg0XAy/qjSfng?=
 =?us-ascii?Q?IFqrpwl48wMUAVGCTyjwiLAopPJj4UblPGiIDicJfdSXd0lIOcq4eRTxqa0R?=
 =?us-ascii?Q?WoV0QeNg4fEcmC9Em3ek4eQ4jZ0FAUMstD7FI8AtniUpVlYlqdO9UnZ6CU0M?=
 =?us-ascii?Q?23ROlXRl0O4V3qYbsFm/0dpW83nYJlzAajeXD4vqIIRUP/TEQviLL93rv+EC?=
 =?us-ascii?Q?eonqIB/4FgCJPEjbKQn/0IO93DZUypEmPukyuj5tKCf10CATxukPifZcBMMY?=
 =?us-ascii?Q?bKUJYQm3lGpZsfsAFBdT33qTtQoLMFxgIB/wyHNQkTPSTavmXkEeMPGoTO4p?=
 =?us-ascii?Q?TEwH8xAf+G/UpUdz+1IQEBztCmF+PF++lO52I1JeXEM9IexTtht61aSvfm1D?=
 =?us-ascii?Q?vhGp4Os7j+UE+xowkx8yOFOD42m2o0VRJefLqW0XdDMDjF2beH/Ou7NgxGUe?=
 =?us-ascii?Q?If+a7yFHo7iBJqPB6sk3Qg1eePY6f8qzOkafljdaCLx6QAGi8H0PQ/ZDf7X+?=
 =?us-ascii?Q?LKSCqbp9v1IduUUV/t/Mzn7ay7XqxUmOFE6MAJCaMWH1TNqcY1fS4h8QFRzq?=
 =?us-ascii?Q?s0+k7vR9rNTDOUswThp/AE4RbuOd/+m9TtB9QZ31ghgM0MNp+rdQXGAO573K?=
 =?us-ascii?Q?rS5MpElRTb9ZVDF0i5WgwE283GNsrml8Lqcpykvru7ImhtobBXyPYgAqLnR8?=
 =?us-ascii?Q?JU2bDt4F3dZMOD3Q62bR4/E052hxwAKyHdFz3i0npyfbx4U8eJDg6HE4QnVg?=
 =?us-ascii?Q?bIj3qd4nF3uuKrHlXy5eq3sq5mpjOzLzxn+lLNzGzUksdhbGl/q3W/0ceZEQ?=
 =?us-ascii?Q?CZrtbZPdZh5xJjutZgOoKVBRC/QQk3nO2u/+3XwTNpK7qW3LXEiq0fmBIdc5?=
 =?us-ascii?Q?LqaxX32zFnSuLK9s2+p9qkeYmg6Sg7xtJuf6/yFSt92Os75/GFf4IyXPtgAK?=
 =?us-ascii?Q?1MO3hAc1HMDxVMuVlk2/XHX485KzpEzs5I9TxqMBMUps/oPt7wu0OmsbJ03O?=
 =?us-ascii?Q?+F8iBS5qhmVoIQjkrExcQWHrhixYjpC8yG6K5eIjojHPNomaKaupFe5bV5g7?=
 =?us-ascii?Q?4R2H5dsSgrJ1ONO1wp7NqVi1j1x33m7vCJxS2d51tv3kxAUh8jr9dSmM8wpx?=
 =?us-ascii?Q?/H/vDhvTe54=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLQOxpvfqhruiG1lc6ILadzALHAXF6EcG7Az5BOhGUU/1HKcTkGwDp6mhY+q?=
 =?us-ascii?Q?xDOLzV8lxds7ho9xyz9dHdu4JYy4AHOJG2ub/BwFLe4nc9vrkj2jOwylmOt8?=
 =?us-ascii?Q?06UyxbFYJaDjbQ38/5wXRJrCMjE+KYspo8OWzKFNQohsBx4Qo7YMZJTft9F5?=
 =?us-ascii?Q?HbE7ze6VACbO3NJUS9xfLsxrvccPTnq5uWCcqFAyBkiWSECp9/9kzZeont8I?=
 =?us-ascii?Q?5BuDZXcYfO6QsFYv2volXMRBblfNsFC1lsGahk0JH9dxG3tni3PJtaR3wxSP?=
 =?us-ascii?Q?CS1oF09a+4dO+W08FtR6N63uwNLiXNiCA+/40spGCMaAWi1IGs9DbMCYQSyn?=
 =?us-ascii?Q?DvyIixH95Yp7cr6ZCQilVyE6C18U1YxVcpgiL5ZbNnyZl5VR4+ZLJWjDevDx?=
 =?us-ascii?Q?4YnqchRIZiwLfqnkFxhVYzk/oNgdaxFTd900HXeqLPu0KH5Z/a7ZAawcDmeA?=
 =?us-ascii?Q?rV+v8+tcs9M96EZWzJE0HYzCB/4gzwoj+QmsDo/8nSUCwTxnrAKIOu5VMU49?=
 =?us-ascii?Q?jjUWwqCEAQL+afdb56XOIeGwfTTjyt2T/arX6H8lv8pM7U1OJcwWNtFQ/VEH?=
 =?us-ascii?Q?mdN+8fuUsPntGAtWzIP4G+ABgWVKcN7DCq6hzl+7xh+hp/tqevrWwnQDcOR1?=
 =?us-ascii?Q?s3m22ipb+XRB0JzdTN8v6YfV1m8ezFk3MdtQuXd5UWFn7TUq9gWTZNYUQ7Na?=
 =?us-ascii?Q?6bbNHvvB8F6XeLBDtlnlfzP/6E9TfgO1tpP0o/3iUMfuOteDwU4wI24R46bH?=
 =?us-ascii?Q?YCz09lQeNLiyF8Rk+M1VAZHKySFQacB4fp0ClF0s0w+ALIMJXgxkSTYtUwjk?=
 =?us-ascii?Q?S2hdmE8ohPqsPfYW5pX/EOj2+q2Jk9UP0EECuoH/3uthW2qLNBa2dqLuPrNB?=
 =?us-ascii?Q?QmgD1wyEu9As/8SKB0/Lc6iVrinPjr0BvsEM9Kmem7qZgmTAXH21ruqJaGyR?=
 =?us-ascii?Q?6LPYZUqBwuZxVuJ/EI/bZsD5XHD9BxYKsb/DpZ9l3ifI2VGSO7tX40zNLEYb?=
 =?us-ascii?Q?0+itg3jREmCZAan4Ki+tP1tCvjQjvCK2JKABsCvScbHnQs8KcAl2+Ro77l8k?=
 =?us-ascii?Q?tqpUgmCaqCj07ajxCQg/ccwrBh+Qd+h9Tf2h0F1Sn/8e83tHJ9nXZ5nArAOs?=
 =?us-ascii?Q?yzdsNCu0lezjL/4y6AU34fkgJ9QrNsfDgujucBgBv2z5LABdmeqCc2/qpD55?=
 =?us-ascii?Q?QV3psSDnjWjJ54KN95rxejFKmQiNGazn8XzjsfSk4ifmK3qXRXwR7jnzYfFb?=
 =?us-ascii?Q?mFTR6HWaM/dgbxthY+Hsm1LASKfI+MFEeQfprLJqDLRyVgIx7yYF8TZYYMT6?=
 =?us-ascii?Q?L5+o94gZpD4ChD0CFV1rY4qWJ4sXJZPcPKukWvpy4DpMP4Szk8VqLL0UAwKZ?=
 =?us-ascii?Q?PzODQX5QYxD8RrgEe9TEu86uhsBLVPP0SRxkP6CjHOIR4kucff5srnLFV1FK?=
 =?us-ascii?Q?EjrZapW4ZGM/SB46ayamlWCX2kA4cHlT4561FbfNWolaMFqDhlWRHJzvX92O?=
 =?us-ascii?Q?us0RseEKV+bAvXsBFtPW5Fi3KOF0RTytmAXVh17gq0regWgUHx7UQRFa3d8c?=
 =?us-ascii?Q?EIOpg6bwVh7taqJiViHj5bNTl+7DoJiTVN5Us8T2wJazVJQfvzxHXjc/vTYk?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y/MYXocqAX2h4qxM3sW7vheklENKY6YE1x1CQdEmxWjie8TBxtdjBJ/5xc7PzFQXCoLaVuOeDoOrg0ihqf+rT8/fKm3uc0wDoMNbbsI357k3dI7wdNoxTU65rETQoA+T0IcVqNwkuq5HmyRkbQHpR16DzMG6uu9E397AKenJP9hqqARjP4aOPolhfPywti9RjhtURw7a1YHX0mGYrdFstT0qMQX32PChLnWrQMMx13OGiA3IU1yKIlasqeBlJGEb/BOyiDLJ2v2LhwTf4TgZ+KrlNxju+EjabpmVOSJbBhNVby5wwWNBF0NigepN7gEUmfEohOS9YLcGDKd6qFsV9vaPRGHeCTYfE2/W57LXNRPuydnDdiEnvr+gdAKTrkT/ECduemwrfH8TnS+zxhsGSV2hUPMbRid/oKXWedFsZadl2oXn1CK/Ii+wGBpka+Nxr+Tv3kDvhqN1NlaOd7pPoYpqbx5PM/ItpWhMIaxd5mW+7irAi8lIjYFUMzqWUudTcVBmhlWs9Rk7/yRgLus9Qbl5evSoq4gsPTHzAh5kcTH+X+nZEnkgdV0/9UNRB3wJuyWwS1lArEeHQ6wY4j2rqDomo7p+ofDjq1Wq99GWji0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1a3561-b742-491a-bca5-08ddb8987f91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:12:07.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhkuyF/4KcA+l550NLET6qw+s/6B1SC3UDrfccinXvtrLjHP0lF+Esh0fYMl28+L0wWZ/mGNpeylf8RH6RtN76soERazw5KgX0h7MwHHbYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3NiBTYWx0ZWRfX+AKnQRxYMAWH onN/3T6/Yo1PPMj2/5WLVCCbAkyxMAbRzbDhaCOcvPI3RmElRi7MSBTxwn6iJW7KfTKJkCqRhRn Yy3qME6iI7LwXloarruIWLGzTUGlGCeFlL5iu8w1P9UKq2ia02k62Vws0VyqH7EbsCV8Mas+dVa
 l9Z9POvt5W4992CxTkjMxrXYwwSywBTXQB2btJWCMPEh15FLLJWDbCo554Acevc6dm5a65JYcJ4 qpNqtX5+PN79xrEm1G2su9d+v0Go6/SeoHE4bQW/VMyLQt3KKzE03XS6WCWdVpHLYpjyXwmwwDG EGaNpSeYtP9VyWr04Wsb95CtETPgYBFe69kNGLlnb5u8q791/omp+nn09W+gBqzzRD6b+os7DGM
 VGUAcuJ2oPI6hwDOAWSgGvuy8PpZvLiS7678hf8+/W+spCFDGOM2zcCE33GzVRclRtKEyqU8
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6863d09c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=6WE9RTV3KioGeVBgTrMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723
X-Proofpoint-ORIG-GUID: keQke0HzFQ3GyagpLDVZolqYsusttKp_
X-Proofpoint-GUID: keQke0HzFQ3GyagpLDVZolqYsusttKp_

On Mon, Jun 30, 2025 at 03:00:00PM +0200, David Hildenbrand wrote:
> ... instead, look them up statically based on the page type. Maybe in the
> future we want a registration interface? At least for now, it can be
> easily handled using the two page types that actually support page
> migration.
>
> The remaining usage of page->mapping is to flag such pages as actually
> being movable (having movable_ops), which we will change next.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

See comment below, this feels iffy in the long run but ok as an interim measure.

So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/balloon_compaction.h |  2 +-
>  include/linux/migrate.h            | 14 ++------------
>  include/linux/zsmalloc.h           |  2 ++
>  mm/balloon_compaction.c            |  1 -
>  mm/compaction.c                    |  5 ++---
>  mm/migrate.c                       | 23 +++++++++++++++++++++++
>  mm/zpdesc.h                        |  5 ++---
>  mm/zsmalloc.c                      |  8 +++-----
>  8 files changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 9bce8e9f5018c..a8a1706cc56f3 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  				       struct page *page)
>  {
>  	__SetPageOffline(page);
> -	__SetPageMovable(page, &balloon_mops);
> +	__SetPageMovable(page);
>  	set_page_private(page, (unsigned long)balloon);
>  	list_add(&page->lru, &balloon->pages);
>  }
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index e04035f70e36f..6aece3f3c8be8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -104,23 +104,13 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>  #endif /* CONFIG_MIGRATION */
>
>  #ifdef CONFIG_COMPACTION
> -void __SetPageMovable(struct page *page, const struct movable_operations *ops);
> +void __SetPageMovable(struct page *page);
>  #else
> -static inline void __SetPageMovable(struct page *page,
> -		const struct movable_operations *ops)
> +static inline void __SetPageMovable(struct page *page)
>  {
>  }
>  #endif
>
> -static inline
> -const struct movable_operations *page_movable_ops(struct page *page)
> -{
> -	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> -
> -	return (const struct movable_operations *)
> -		((unsigned long)page->mapping - PAGE_MAPPING_MOVABLE);
> -}
> -
>  #ifdef CONFIG_NUMA_BALANCING
>  int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node);
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index 13e9cc5490f71..f3ccff2d966cd 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -46,4 +46,6 @@ void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
>  void zs_obj_write(struct zs_pool *pool, unsigned long handle,
>  		  void *handle_mem, size_t mem_len);
>
> +extern const struct movable_operations zsmalloc_mops;
> +
>  #endif
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index e4f1a122d786b..2a4a649805c11 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -253,6 +253,5 @@ const struct movable_operations balloon_mops = {
>  	.isolate_page = balloon_page_isolate,
>  	.putback_page = balloon_page_putback,
>  };
> -EXPORT_SYMBOL_GPL(balloon_mops);
>
>  #endif /* CONFIG_BALLOON_COMPACTION */
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 41fd6a1fe9a33..348eb754cb227 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -114,11 +114,10 @@ static unsigned long release_free_list(struct list_head *freepages)
>  }
>
>  #ifdef CONFIG_COMPACTION
> -void __SetPageMovable(struct page *page, const struct movable_operations *mops)
> +void __SetPageMovable(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE((unsigned long)mops & PAGE_MAPPING_MOVABLE, page);
> -	page->mapping = (void *)((unsigned long)mops | PAGE_MAPPING_MOVABLE);
> +	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
>  }
>  EXPORT_SYMBOL(__SetPageMovable);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 15d3c1031530c..c6c9998014ec8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -43,6 +43,8 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/pagewalk.h>
> +#include <linux/balloon_compaction.h>
> +#include <linux/zsmalloc.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -51,6 +53,27 @@
>  #include "internal.h"
>  #include "swap.h"
>
> +static const struct movable_operations *page_movable_ops(struct page *page)
> +{
> +	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(page), page);
> +
> +	/*
> +	 * If we enable page migration for a page of a certain type by marking
> +	 * it as movable, the page type must be sticky until the page gets freed
> +	 * back to the buddy.
> +	 */

Ah now this makes more sense...

> +#ifdef CONFIG_BALLOON_COMPACTION
> +	if (PageOffline(page))
> +		/* Only balloon compaction sets PageOffline pages movable. */
> +		return &balloon_mops;

So it's certain that if we try to invoke movable ops, and it's the balloon
compaction case, the page will be offline?

> +#endif /* CONFIG_BALLOON_COMPACTION */
> +#if defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION)
> +	if (PageZsmalloc(page))

And same question only for ZS malloc.

> +		return &zsmalloc_mops;
> +#endif /* defined(CONFIG_ZSMALLOC) && defined(CONFIG_COMPACTION) */
> +	return NULL;
> +}

This is kind of sketchy as it's baking in assumptions implicitly, so I hope we
can find an improved way of doing this later, even if it's about providing
e.g. is_ballon_movable_ops_page() and is_zsmalloc_movable_ops_page() predicates
that abstract this code + placing them in the relevant code so it's at least
obvious to people working on this stuff that this needs to be considered.

But ok as a means of getting away from having to have the hook object encoded.

> +
>  /**
>   * isolate_movable_ops_page - isolate a movable_ops page for migration
>   * @page: The page.
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 5763f36039736..6855d9e2732d8 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -152,10 +152,9 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
>  	return page_zpdesc(pfn_to_page(pfn));
>  }
>
> -static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
> -					const struct movable_operations *mops)
> +static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
>  {
> -	__SetPageMovable(zpdesc_page(zpdesc), mops);
> +	__SetPageMovable(zpdesc_page(zpdesc));
>  }
>
>  static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 72c2b7562c511..7192196b9421d 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1684,8 +1684,6 @@ static void lock_zspage(struct zspage *zspage)
>
>  #ifdef CONFIG_COMPACTION
>
> -static const struct movable_operations zsmalloc_mops;
> -
>  static void replace_sub_page(struct size_class *class, struct zspage *zspage,
>  				struct zpdesc *newzpdesc, struct zpdesc *oldzpdesc)
>  {
> @@ -1708,7 +1706,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
>  	set_first_obj_offset(newzpdesc, first_obj_offset);
>  	if (unlikely(ZsHugePage(zspage)))
>  		newzpdesc->handle = oldzpdesc->handle;
> -	__zpdesc_set_movable(newzpdesc, &zsmalloc_mops);
> +	__zpdesc_set_movable(newzpdesc);
>  }
>
>  static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
> @@ -1815,7 +1813,7 @@ static void zs_page_putback(struct page *page)
>  {
>  }
>
> -static const struct movable_operations zsmalloc_mops = {
> +const struct movable_operations zsmalloc_mops = {
>  	.isolate_page = zs_page_isolate,
>  	.migrate_page = zs_page_migrate,
>  	.putback_page = zs_page_putback,
> @@ -1878,7 +1876,7 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage)
>
>  	do {
>  		WARN_ON(!zpdesc_trylock(zpdesc));
> -		__zpdesc_set_movable(zpdesc, &zsmalloc_mops);
> +		__zpdesc_set_movable(zpdesc);
>  		zpdesc_unlock(zpdesc);
>  	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
>  }
> --
> 2.49.0
>

