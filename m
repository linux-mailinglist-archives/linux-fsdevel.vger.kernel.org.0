Return-Path: <linux-fsdevel+bounces-69389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2FEC7B0DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7CC3A24E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7B2F25E0;
	Fri, 21 Nov 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j3ThH+qD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gpxBNOvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE702F0C69;
	Fri, 21 Nov 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745736; cv=fail; b=kVhZNBiAAdXLNlwkpqH+pcoGfnp4S3YxxWBZOxWqxO7nEIDigQGDfsMXNyfqqdYOZfofIK0kalYHbvOSTQZiW+fk2G/s4eByRPct9X+Y/Gi7DoQ3Xdwad6TMSzhWyyHPVuawFlQrgNXcnBnHZU+no5RtD2u6l/Cai8WFo0KRC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745736; c=relaxed/simple;
	bh=OZizz8WRxpjElhbVzayDnY74l8qM1xgHfMXKfW/1K2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rjBLn7E7OIINmkJ9bsd75lpNKOc2Z1uVg6UBgLyh1z6ibtpLSaAoZORZzaLN76VWAQVqLYxugh4VFFsyGg4ceN6QGsjDm1Cc7hU5mitQ6LAkJhUs890BYOeJe3SshP862ByM3NNdYao+VaYhtga+ueUItbY61V8CFOSwEGU2U74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j3ThH+qD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gpxBNOvi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgmCR027975;
	Fri, 21 Nov 2025 17:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RDYgYuVd48ZCA4SqPA
	yrRQy7KN4Y1nPnbtaqjdGDoEs=; b=j3ThH+qDZYnWB03e1UctLIXmpvzgcXj8yN
	r4uXZ+5BS5sxj6jAfRF7RQ+S9Tcy4E+1Z/qk5mEcgbdGD6VcFbo6nvRfFTEy6oph
	Vjxp4cPVwutgDDL+EjNoP1Cw0B7hzhdhR6VaPdfIGrCl4pkUBYr4DMMwjgUBGLmY
	VRUL5arm5LmbWTYXwlF7qGpOLI5hroOaK2jQTYoy5+Mhwk2F6BS45DABUetE71Ex
	fEZ26wjasiRqjrYLw5uT8Nu06mHIp/ZBEeNetcLgyWGmNlKdC2RLpm4Ug9wTE2HN
	2lcstTPLdoSmCGccDuTqjUiyBFY/HGeC6neZLIINkv+Jo8HZNPCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej96bxd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 17:20:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALH7fxC004349;
	Fri, 21 Nov 2025 17:20:55 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefydn0kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 17:20:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR9dP/ehN5RQFjA7E5ynyYzhFCX1hQYGBXWwxrqpL8AI8/p/l2UknRbzzFc8ayHV+GrNOJeWa5pgHqlilEa3bkyu34LaGvhSxdbKk4HwplOwMStKvZzi7LIo00DqhsZZDSJUhrIG/gC3ANtj0BaKzvKGEurlZGuY8GvW681PApIFbc+Wmb2CztHxIjlc81Anu7G8dpU/Q2grS4gGJWNqyiUdykOxrzDincsdGMGKizxzsLxP3zyZfzxBj6F/F2sNmpErWl2Vc9sHFgLV3nfhi2wgx9F0irkzoDSJXdCwzD34NnvqR1upTcbW+/NBaLL3Kg0CpyU4xO10fq03yLhqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDYgYuVd48ZCA4SqPAyrRQy7KN4Y1nPnbtaqjdGDoEs=;
 b=AgZdRornpkoyBXwIrZjq5RQzZPIcxtcA4p2RS0GnuHC5C6E1WKW9tf7peBjCqu1Cw2ZxIVF5O4HFWXrRZ2K9YtfcSgGdo7Gjp56geg/VqhuaHSBx1WMh59krUdWMZU+QSiaZtSoHrTz2/xEbtp9wmnPuLxUYriXAkJpnVU87w9urIyL7gLWdIQUN5i/XBEWIYxDhgB8C0mHt2Z7Y8RNopQiRW1BCzVrk+BQt5nA613As7CvfaSJzR1eFK/U+SB52Q7fNTtgYj3z93m6zBJG0LWdTztiMg3U2hXJj/JDFGzkYvlNfHk0uHbBkWSl9lEud+QK6Yz7pvucGCJCZe7JN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDYgYuVd48ZCA4SqPAyrRQy7KN4Y1nPnbtaqjdGDoEs=;
 b=gpxBNOvi/3Pj86IVGDMlvNq/WE/vqW7aaQn4nwyAHUPfr4gP6zZjxsgjfAFUOQwdhPpkLxmkbVr07TzOkZlj5Q3sNVXR6J00rrGs+07YiPZRQ90MZAjF8Kwh42Cut3zjCmFZFs3M2jOrcl7HD7NTNTrMu8y14cF+4S6uOFVhi3s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 17:20:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:20:50 +0000
Date: Fri, 21 Nov 2025 17:20:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] initial work on making VMA flags a bitmap
Message-ID: <39922fb9-d9e7-458d-9ebe-149ebbbcf1ef@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <d01001a5-03b5-4662-8955-bbade1e2f023@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01001a5-03b5-4662-8955-bbade1e2f023@suse.cz>
X-ClientProxiedBy: LO3P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da09175-08df-4cf1-0e1d-08de2922514c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2US1iCnXlnFJZpjRqwHoVoYcpu4UuWrFltTM/BBbvytP02tuEr8vlNPDrzu?=
 =?us-ascii?Q?BOi1/Aw2DgnI+coSVWSrse/VL3+/TT9VYiTrhlOGw71KaYnFpwSzX7yT/OFS?=
 =?us-ascii?Q?xaOGByzT8KvyYNDGleju0++vN+3ZjiKlKbpsxxs239vCiGHa13Y6MszEFMT3?=
 =?us-ascii?Q?XlB3zermOC9dKwEbHC6e/LOD8sKW/cSb9XQLXQIaHw4/yI6QVuEAzkEM5P6o?=
 =?us-ascii?Q?2F+R8FRw3/qVfew9TV72t/F8Rkw2ehiZxRHuG9nc6bWGb+d6VrlXPP/xpF5V?=
 =?us-ascii?Q?JFDzUJl3YbEbDvtRJdf/Bil4KlSY52MuLeIjereHicToqshLoaBQXPE25PGz?=
 =?us-ascii?Q?LNL6MKf+TXnWbOZk0rqDz5nIGU4KRrRPW89luY46I5SPCfGrkPJe6EQLDNM2?=
 =?us-ascii?Q?ZZO2NUKw0QkDYrseuR50yXWQQ2Sd0iCgkxzmUO2s5pTE41bQ9d1EXl3sZt5V?=
 =?us-ascii?Q?beOvI2h0SxrXdv8jFuWXEiw8KmXl6e/z8Dt/PwxM4RD4n9oFXZSwtqLF+Lf+?=
 =?us-ascii?Q?MIdJg6+L2VIYU7LS2PztZ90V4YdX72DxMGhzctfomNeAv6NS8R0ij6RIPch6?=
 =?us-ascii?Q?n2xMEyvOPlayWv+jux4kdkmB5R9ZqnE4i4NvH5NLeO8GPalFYoJqT5gLC17/?=
 =?us-ascii?Q?PfiIJPjo0A/HO/CJ0rQNZM8QUTaxwWSXAIieEq6a+ZNEkmVkSN0rvUtYz82p?=
 =?us-ascii?Q?vamTvw5f/KOJBPqFbkZ2ECaPgPXv7uZib0KTyKIwvHkFedBgTa4nnMdYdMNt?=
 =?us-ascii?Q?jCOwsnWwOECVi0DX9wE1hSMqZRz4F/wvnFxnjU3bZubDW0NhE8KYw3I5TL1A?=
 =?us-ascii?Q?l9WcvSh5tvDVXbM3rCMyA791utsd8ugk37arbR7SDqP/gQp1KUeWwsR/yEO0?=
 =?us-ascii?Q?n6ZpGFpybPMtIFdA7ie+VfIsrTuFlA0gkQyznjJMpJQxVXU6btB2d3gGZ5zG?=
 =?us-ascii?Q?8MIoJKDSgG4amm75PIjvB6Zenuxsj1qI+HrwK91pZ18k4w0Rm1ogvTL+VYTp?=
 =?us-ascii?Q?AtB9+t02ps3AmRQDt/0+c+2Uphwjrtu65o7ltsIwj0DSU1AYalKSaaaI0YCP?=
 =?us-ascii?Q?jac9oA1ebzk46nwZoXGZZOTCcWN2DaWm7DonxmBUSgzDQaUlG9VI4PHLsPPG?=
 =?us-ascii?Q?0gDfs9Cskjoi/h9Y7APdheJcSfpW7Uj4PjIB/laAzI/ZW+17J8VUk52rAM2D?=
 =?us-ascii?Q?di1K1fL3S73tqO1F9sJjJZgiBFAwYEk6gaDhSUARa1l94X/zrLlTiIOQG+5V?=
 =?us-ascii?Q?RAsvOKqznVyWYICMBzSL+jDFwMlovx/IFUTsafXR/WoVk/lQqhTTc7KDLFQ3?=
 =?us-ascii?Q?v4ddsG4/YcGDsAIqMKnHiV47hL/OlNleYMMeLoX1kc/EpjEHe4rQ54zMD6MT?=
 =?us-ascii?Q?AAianxeFJKTxZimVuKhQvRtzR9nNhkb66RLCkbdjyDvk3VYRsY4rnUaNM0yI?=
 =?us-ascii?Q?EMjihCUBsU8zgxc2NfDQAToWqivKn7csP6K5kS6I14A6+UgcLYQtww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aEcYUVrTj22Qy+STKClf3sWfGlfe8bxeMeffD6i+V4CTDuR+scXyi+k6StiG?=
 =?us-ascii?Q?MeFjh0SRbVBVgiOIYi8DQuXcPZuCHcFzMS3L43VrGkExRzW62/GK61Th06FZ?=
 =?us-ascii?Q?ti6+6B5w9n9MWoiSbIT0r5l9KTaj5HkHQQKgHr37pnlGfJjFrfUbbHLAHjqw?=
 =?us-ascii?Q?nkMVv7wkcAXj0rLOzpHvWxvTCTFdTTZ2aht9KwJpKrs6q1304OsN+dRoDM4d?=
 =?us-ascii?Q?ud9GGsIUCKuElFsILF95IUMZlVHUOLD/1yb3EOlz0iA91nu9WSZO4KcE2Vx7?=
 =?us-ascii?Q?l1bl5r9JYBdh9feBb8CvOjLZJl4KQXLc+QNNU6LejOFqrGQbDxGi51N7DJ8U?=
 =?us-ascii?Q?RFqqxfy3W6PnEF0ugUy6POLDc1XaXNvLuMf88mTUO1iTxvdSITKi7tbSbnHT?=
 =?us-ascii?Q?oBuqDcv16yLKSu/6b6ma8nNb8h7H/ZJowJIoKKq2vF326J0En41cx4erqZw4?=
 =?us-ascii?Q?fpX4Do9C9zLS+FgleXUv57VQvXVVIFr6UBHWqyFwGBEjgT2TeZZo+bYx2Hne?=
 =?us-ascii?Q?O/Gg6OUzHtBq3+zmHo679wHraDTIvFkF/PrKc8e9XQEi1sQrE16sEvJflnuX?=
 =?us-ascii?Q?bkOcj3QO+thh2mgHc3F6b0vI2xFWocZxhAxy1IV3f6ZJ1GTVVlDVt8xDdVHP?=
 =?us-ascii?Q?VhyNvbi68xUybxuv0sRXQLqoJHDf1IsspXi+5pDRxQD5zB+x4llKrgctgu9g?=
 =?us-ascii?Q?XLyOChyGAPXrM/n+jA2jzjEumFoFqiiwku1PltoOxcq55LX7IBKHDzACx5y/?=
 =?us-ascii?Q?gg5/5wEhXVwgi9dO3+lkU/biz3cq4G5g+AxeBBpo2qDZrOglzXh9E4y/jrZ4?=
 =?us-ascii?Q?LJZcuUZ111rN7dRSC5UjbbjvCa8sgfUy3y8pGlKHMI1sPmnhQLCp+zrGPOCs?=
 =?us-ascii?Q?AihHtbWFTnAEVbx9KFpVVtSVhePXWz9nA/fiSbFWG7iobMQHP2xO8EsTutI2?=
 =?us-ascii?Q?3HABZappKWf51XDZ4rji5XXc/djJ5HvXLzqfbVU8qVN0Hir2AYRkVbzuYTiV?=
 =?us-ascii?Q?SYt/UKmgcg3Z0ckISSEOHiKIdQopKw18cyhrY1lZfHTL1BjCcHiAL9jYiCuk?=
 =?us-ascii?Q?/MFXG5eZ5YPu/SkRxgFBa09mt4fPI36tjbXBz6LLf8dSdrbCoiUDske2m7nu?=
 =?us-ascii?Q?poXKX0HD777kfZx+WaxS+Q+/Z100Bk783EqZxy53St1AGJAab1KXYx16raNz?=
 =?us-ascii?Q?NqBfgUl+uWA5gBsS2lwny2mpmLDSYpc5prhbef1Rzh0f8jOnNINWCKkBj2hU?=
 =?us-ascii?Q?XqIqEwfJc4Z33HW9gH/pP5fLxkWp+DOVflaUikVvVrhmhD8SwOzq2HuauN7t?=
 =?us-ascii?Q?+rlsCoLaRkftxq5kNmDoqaDHy3EhOZuZrm2qJIVAFSLju46wyjlGN4qa2Cu1?=
 =?us-ascii?Q?jMtKqgN6kJQoQzbeNHUx4/OI/w1BTCVmfUmlZ/xhxZoQvVMl+9R8iYwfjqxo?=
 =?us-ascii?Q?fnrT6vZtGILfbidkpRCS/lNZ80rqPW8/7RdDoWeV3ro/OaDgv9Up0gUhvkG9?=
 =?us-ascii?Q?9RtreCM+tliJ5OixvHCACNF49K4ptSrf1OvoOkWnp14vDBnpyNMpxK00wlOP?=
 =?us-ascii?Q?eBVASB1KSikH6n8oEv5Czes+Ga/jn2iOw/Kb7lu58fMcOCw5tfW/4WxPPT8q?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5f7pqL9J0mHlFxiStLl811P3ncKOJJvF4kUfQFnhTaRMZTpKTLTp0sxgHdH3uSfex9BtQ+MrLgML1L9FtKa/drD1c0z43y3KSGUBqwsK7s4kc8jCdbnlNjkUw6gENJfUPq4sbL8iZWJdQV+x3JhsY4jZ43+zcQs3dc5Js+nFvERpl0EG0R0vGDMwfs9Q4MlW4w1sflGTIpv7CDu9l7poyYAuDvECStz7VdM3SaWKsTzNqd1osAZh/aZbvWnnQOdYJu6HUXc8O5nqwsjsqrsPMFoOSrzDNacW2Ql2XVEYc29yv7F+yk5a+RzOsVfDk+Te2l3eERdb0jycPXogNVPAFVvA/CxaifcJleQw8YTe/BK+NeRD7rrY+x2gvJ+kfFu1IpcyGOP0VK6NxlgNn7fKxg+R3cGN0Wl8ECp266VbSfmEelOe5dM3Z39jfDUUMLPeDiY8VFkJgc6wXLzz1X+qEABXLdt6WCKMgZRRNkhLCxE2GDsmERD5DdTK9MaM8QI23P2V0mDwfg9RWF77Je6HjJtStpLpupWHCUbBTKdpl+T9R0t0VClMSHrUR/4Gh8OvkjbdI5l6YkbwZLVWl6HTtPU7KLawGV4ENhYgTmOjx0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da09175-08df-4cf1-0e1d-08de2922514c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:20:50.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXtH6FEPoDe2n90+kvwOK1x1NLQQOGfVKg7limZJkArxgcI/fQOWluYEyMgm/A0Fd7xIIXB5oLSAOOQtBPv5zwHVx0r9/Obrn62p6gGlXOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511210129
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=69209f78 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Xc1DFJrU0qiX0N8GFw0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gS4Thl7q4on5Gmd1x9aShVhN5OtKt6SZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX0EqZoAlCJyUy
 qSelVErXP2RQW+/IL+fSVU82GRG0u77I7QPLQnw1n/CvI5EfPQX2R1zyV0yK9NyqvXvVVZFq+Av
 OJmxUEGxl0B7jNbKPywDbJz9q3xeCFXDfrDMYvowlz6UOrAEX9XrVqeNOPxvSGTU4N+QFuv6rlY
 0cHcGDGkyeAsLxP+43GqdO7FV94qsivusFV0tgfK2W0l/iXU9H2FZiMqMoefmErJvxiombDtOtw
 fk5TEYRM/KNrwlO1hmCFQPKAwbTgE3za/54Ox5d1/HhUtpugtuvgSnCmtlGJsCflUDfq6RiPswy
 48g4mx5lf+BHGYVEgfM+1ACCGhjxe9hVG8AHgz0oIKruR2KmmtXg6MnKkNV/mE19dudU7FhhzR/
 ilSQgOrd2NopsbVe0YKM65FjBFgwAg==
X-Proofpoint-ORIG-GUID: gS4Thl7q4on5Gmd1x9aShVhN5OtKt6SZ

On Fri, Nov 21, 2025 at 03:50:53PM +0100, Vlastimil Babka wrote:
> On 11/14/25 14:26, Lorenzo Stoakes wrote:
> > We are in the rather silly situation that we are running out of VMA flags
> > as they are currently limited to a system word in size.
> >
> > This leads to absurd situations where we limit features to 64-bit
> > architectures only because we simply do not have the ability to add a flag
> > for 32-bit ones.
> >
> > This is very constraining and leads to hacks or, in the worst case, simply
> > an inability to implement features we want for entirely arbitrary reasons.
> >
> > This also of course gives us something of a Y2K type situation in mm where
> > we might eventually exhaust all of the VMA flags even on 64-bit systems.
> >
> > This series lays the groundwork for getting away from this limitation by
> > establishing VMA flags as a bitmap whose size we can increase in future
> > beyond 64 bits if required.
> >
> > This is necessarily a highly iterative process given the extensive use of
> > VMA flags throughout the kernel, so we start by performing basic steps.
> >
> > Firstly, we declare VMA flags by bit number rather than by value, retaining
> > the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
> > fields.
> >
> > While we are here, we use sparse annotations to ensure that, when dealing
> > with VMA bit number parameters, we cannot be passed values which are not
> > declared as such - providing some useful type safety.
> >
> > We then introduce an opaque VMA flag type, much like the opaque mm_struct
> > flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
> > field"), which we establish in union with vma->vm_flags (but still set at
> > system word size meaning there is no functional or data type size change).
> >
> > We update the vm_flags_xxx() helpers to use this new bitmap, introducing
> > sensible helpers to do so.
> >
> > This series lays the foundation for further work to expand the use of
> > bitmap VMA flags and eventually eliminate these arbitrary restrictions.
> >
> >
> > v2:
> > * Corrected kdoc for vma_flag_t.
> > * Introduced DECLARE_VMA_BIT() as per Jason. We can't also declare the VMA
> >   flags in the enum as this breaks assumptions in the kernel, resulting in
> >   errors like 'enum constant in boolean context
> >   [-Werror=int-in-bool-context]'.
> > * Dropped the conversion patch - To make life simpler this cycle, let's just
> >   fixup the flag declarations and introduce the new field type and introduce
> >   vm_flags_*() changes. We can do more later.
> > * Split out VMA testing vma->__vm_flags change.
> > * Fixed vma_flag_*_atomic() helper functions for sparse purposes to work
> >   with vma_flag_t.
> > * Fixed rust breakages as reported by Nico and help provided by Alice. For
> >   now we are doing a minimal fix, we can do a more substantial one once the
> >   VMA flag helper functions are introduced in an upcoming series.
> >
> > v1:
> > https://lore.kernel.org/all/cover.1761757731.git.lorenzo.stoakes@oracle.com/
> >
> > Lorenzo Stoakes (4):
> >   mm: declare VMA flags by bit
> >   mm: simplify and rename mm flags function for clarity
> >   tools/testing/vma: eliminate dependency on vma->__vm_flags
> >   mm: introduce VMA flags bitmap type
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> However something has happened to patch 4/4 in git, it has a very different
> tools/testing/vma/vma_internal.h:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=c3f7c506e8f122a31b9cc01d234e7fcda46b0eca

Yeah something has gone very wrong here :)

3/4 also has an issue annoyingly, I tested it locally with no issues but
now it seems to have issues... but also it seems like it should _always_
have.

Anyway let me address each at a time I guess... :)

>
> >
> >  fs/proc/task_mmu.c               |   4 +-
> >  include/linux/mm.h               | 400 +++++++++++++++------------
> >  include/linux/mm_types.h         |  78 +++++-
> >  kernel/fork.c                    |   4 +-
> >  mm/khugepaged.c                  |   2 +-
> >  mm/madvise.c                     |   2 +-
> >  rust/bindings/bindings_helper.h  |  25 ++
> >  rust/kernel/mm/virt.rs           |   2 +-
> >  tools/testing/vma/vma.c          |  20 +-
> >  tools/testing/vma/vma_internal.h | 446 ++++++++++++++++++++++++++-----
> >  10 files changed, 716 insertions(+), 267 deletions(-)
> >
> > --
> > 2.51.0
>

