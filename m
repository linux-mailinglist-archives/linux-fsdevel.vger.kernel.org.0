Return-Path: <linux-fsdevel+bounces-69394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DFC7B1EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C094E36605A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B622302179;
	Fri, 21 Nov 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VsjP47Jo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X1tG6UhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068B350A27;
	Fri, 21 Nov 2025 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747199; cv=fail; b=JKMGrIHhgZK3wznFM9aXBJVns4JIycsxQpgFj6F1mevPyXDhXYPORJNFgsn9JWEvzlO0pRsscctOzsK5nc+XzvOcCwLPlhvTIWcvR1ytrcS9qwotNOM/06zg05OUMrFoYMC29kBJ/nZnXAzJBfNE1rPNGf8LSWE+t6hpc7E176U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747199; c=relaxed/simple;
	bh=0p71uWVuleY2H3qxTFHzNTC34iQPttiDxbRM9JIcfj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n0PhQYuYyNhXdBAH/yHIeXu9FhWq5G62OX4ShxafRiHSKyJpKdDjNzb53DwZX9VYhc+msIksKnhjzjZdgtRNG7yvBNqkEszk3j02b89qvnn6A9oWb4PhiJoAS2zGi8RI7JGLUhpDt9gQrj9vWdcn3mBOHe7jVSVZe6W8mkd2/sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VsjP47Jo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X1tG6UhQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEhEpS015309;
	Fri, 21 Nov 2025 17:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=O8DN+hmdoxvpg/rt3S
	Du5F40muuq/G8b1+kX3kil0bw=; b=VsjP47Jo3cbq4VDikgzzhmvlslSx7QZBG+
	kqKxeIpK23D96x3gjg0PvN0hQWpqtX/3/qgxWUjE+0K6P31CRpCQcK8zZTvVX9O8
	qxgOUO3BIJhhNRYqdFHKBWFqep7BYsOUWY3P4ZKkVsuybtFo6FkCI6dI263XKCWr
	ygOSF2Nqh9H6PhcrDFl36EE7XvwbCRnfuy2GjAohx+asSI5TqJ/eOWZzOzxDMSe1
	PBm5YMTi1YMZbJXBmxJVyMfenqHquoP8pUO85rw0tx1UzLXPbnD8Xtn4F971ntJm
	GkQNFl8GXP20R4PDCpuy6Y2TFbsVChUZyAZ6HDxEQt3DX/YYZKKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuute6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 17:44:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALGAR2G002613;
	Fri, 21 Nov 2025 17:44:55 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefydw8ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 17:44:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0g0gKnZg+fBgz50h4jPgVgmfnAc5MeVGrePeRv6tJnn03bXZ+mCv6tvI0cNBYrQwdI6ejbYrK++5k6cUfZfvSo9HQeHLVcwI7zHNa9GVamZFXomRtZUNP9UcYOIGHEzsTEoKiaEh1cOejwtvvavk6Km4IfzwsD1bEA5m/kMypx6p8S6KNxCjehmNOyFDwaZ/w0B5O/cGlrhejVbJYyhZfN7Z/WYcY6PtO3V89aLO1NasCAKr3/P1G6hg23uvvvLhF4CcjjQ4LJzms+3Csn6POWNy12D9StNssYfpaKm+Tes9mTj41Qy//ehMXIN8stdb25ZDY/jV8Xi1RgkLYDb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8DN+hmdoxvpg/rt3SDu5F40muuq/G8b1+kX3kil0bw=;
 b=oQP5ROrLkDOdLkCDFJyPJv6raSmOvymDUu9TVj1GfpeQsuUzfgIbvD2ZyUNw104j5GeaWGwQEcXVw8Sm8Mo/0Fa5ZxMnVr16BA3/eYv8MMuEPD5z+3+vZg4tIO6arZypZImRO8GWzw4DYTcJhE0Ig9Q2xGZ8wLNswmmRxVscINRo75z8BA+gkyWfOgFnUeujDp2HI1BEK5XD8lwHRiENBAEOBSl373ZjxESli6XRObohR9mzrxzpC2DLcCy0ke6EonhwJr+tXf7k1geq3bNvbk9K+Gp+wIZHZnlPrlDeJ0DwDaxVDDRMx/7bDaFkFYR1Xn+Knu+Ea7c6jRKH9ewUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8DN+hmdoxvpg/rt3SDu5F40muuq/G8b1+kX3kil0bw=;
 b=X1tG6UhQbOoDK4XfmTZxO+SycNdTEvw3zg9nsR5RMHsTVh0GrMqiIY8m5dcHSCGEooT1VF9GfHFrPG3q7CrsY+tZD4wgdNJyMgFYgGj9lL+7HvTSaHUeBUH+/UgjZDJjtmnfMuwG8QQBRa6AzWnDxAkvHHncaIAopHuVpJh/3qc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 17:44:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:44:45 +0000
Date: Fri, 21 Nov 2025 17:44:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v2 4/4] mm: introduce VMA flags bitmap type
Message-ID: <c82d75d1-5795-4401-92f8-58df6ac8dbd3@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
 <195625e7d1a8ff9156cb9bb294eb128b6a4e9294.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195625e7d1a8ff9156cb9bb294eb128b6a4e9294.1763126447.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO2P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1cc3f0-2eeb-4042-d611-08de2925a893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?teal0lUUrT7PZNF3OiXt0nAOyrJmYGhEaCUhMhorgQIBeCf46MWU0X85uRlB?=
 =?us-ascii?Q?SvGweUB9tb6RVr9apSHDsWhWYP9r0dK5AQ8GOlUcFwjvjaSagrjzU0pEIHEU?=
 =?us-ascii?Q?1rxzVewzOApa5+hVwAfAUvv/41j+05Tq3QjW4se7IqV0b70ozkQDYu/5mRF+?=
 =?us-ascii?Q?ihZuccV5RB3F29gYbkFIMlu/GDhjrIImRRqT5sNj0+aEPOk1Rdtve6kwWE/f?=
 =?us-ascii?Q?15+l1ChPKV6RwO1lsq4hrV/ZkoUWa6zl/AdWur8uAR3QjQhx1ajW0sQDpHA1?=
 =?us-ascii?Q?79bv9W/THpm8oVtI+pqYoxoZGyGFE5aik0iPav1N+v6pjA7rX3U5tkQtCeoX?=
 =?us-ascii?Q?lyrCGCEpZ/WhnshUfbzQivVCUdMzyG19WSVbHN4eQyId2HBtcxQWa4PBpsCa?=
 =?us-ascii?Q?Vx6/WZAe4cZlI89Ov/lPL+l2SzxckTcajS1ZHj3vpLCQwbsyvQxpFF8liFt3?=
 =?us-ascii?Q?3m74Kyw5SyBsUgqaWT7aqEUX+t2F6DS7EYHbLBufw5VkOHjSXRRBxQVnTUHM?=
 =?us-ascii?Q?oySLmB2qcvb+D5nbuWjH0K08eNrofuvSqULLBzRQif4Dcu8jNgYcCWAwp4oq?=
 =?us-ascii?Q?7WifRBUtHburq4iNbrsgiMa2H9y5iZPTWDqZtU4bdEkBKE1drmYOw2jfavf3?=
 =?us-ascii?Q?S2Fuq9PPGyvr5r3iHG8QUTPmjWrOZEd7wOPCLeUpprIFLuKnjBvR1CXBtZV4?=
 =?us-ascii?Q?C62TmcZFuso/BZYPs462PWi+iFBoaO/EiWXmkVQGHYnXtJ9m8+tBVZxzJ5Hx?=
 =?us-ascii?Q?v0yk9Dv5JojPJPXxewMV6MxAjXiP186RZ+igEMhLtgX3/i1tu534t6PIOUC6?=
 =?us-ascii?Q?EyLxDa+KBFi64/faGC7rvHXlWv7B6TeOuF8zzDXxH0Lt5/C4rS5PO2tYJ7K5?=
 =?us-ascii?Q?5oAjdfTZJ/yppDiZfpOb118xjOdjiCRIT/itmnILY6WXhmVfBKgEKrmaug/R?=
 =?us-ascii?Q?D5Zsm+fCVQ1I814GJIJyeMS3UN3xNmTfEMzxWtKzEdTcG4gmg8MhvyRINsCG?=
 =?us-ascii?Q?FgFER6SEfx5lhgrjYmQQj3ez/jklA/Y56diVIOK0BQztOI7K6j53vwgjFhB0?=
 =?us-ascii?Q?TTXcIXMGe1DLVMdams8BZ/w6XtmIoGybgJ5tMpspplrHBI8j6iF+Vjv50uP+?=
 =?us-ascii?Q?WLg5JtvhxkTl90Dz73RtA9J0JB30dP7KM/wnI9M17e/2qSuRDIsmYORXhGTW?=
 =?us-ascii?Q?AOLTRxe3vaJRo/TAZmliRR/lY59pXM8VrRAH8KegFk/ZLO4kU4+RRnK8Khb2?=
 =?us-ascii?Q?wZ52qy4F5R2/A2eeuMMixuzXZxEj/CWq11epiJ+rs9wDBsAxDjgcDNjUVmt0?=
 =?us-ascii?Q?TpTazW/pwhLJ2d6fUoApaPWvv4Km/58LBUryczigLKOavJlS6xO1yE++H+zE?=
 =?us-ascii?Q?f3i6hOCfc0uh0In+NbW7fr2iD6N4Ac6UN+ldPbWESZKXzbUlwC1L3IJoV9WA?=
 =?us-ascii?Q?rSAvN50abMXhYdNPRrKCvWPXsWduS/OroPpaXGVcTviQFUXokmtBVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bWEYQmRSItXf+R4GamYGiIces5gC4ydhZk1dS+nMlY0GktRpWrjbVzL846OS?=
 =?us-ascii?Q?8qEG0US17WwLOaxKg06O5sR5ZvyJx4wfG4jqARi8YOe/STjFqZ/HvBZPCvZo?=
 =?us-ascii?Q?uSPt0Al7VldbzC0SiN+QnnyS5Xy2OcV/+OMPfU+u4e2x/tEUl3eTRBSFdMtT?=
 =?us-ascii?Q?q29iZGbXqRsw7PJa6ZXB9uB0luHmPK9W2FhzAPXo+/Cb5SdRfyhwsrt4fJRF?=
 =?us-ascii?Q?0pKA+F4EiAoavkixorR3kowHe3l94JX7KKK4IAn8T4vzNRTYBCPy/GR542Yg?=
 =?us-ascii?Q?YOlbqomc2y3qTRWwzN6mvr4ZnTEl7VPjitVcJcve88ddE6Cxg7bofJ0Dc/Z7?=
 =?us-ascii?Q?FNkQ7mcjoJNzRkbeW3xcPHyFKhIYWmHsva1jdLpNkg3WVt1DWXvfdZ0hNOKn?=
 =?us-ascii?Q?sV3tPoXEM4AGBqMDq8ZX0++A0ICDm1G1uWpwMUC+FJYAwRWOXWrCyrmDotsA?=
 =?us-ascii?Q?cXfxDdcwed7jISl3mByKHK3UYgZYVgbh8ghPx+hNwBkw1pAPg5gknJ+OWRwa?=
 =?us-ascii?Q?OpGKXBtuFHracheOdqcY/wfUHn5wHwV7zU29vTYAuSJ9tRIY4ra5IdEoyWrN?=
 =?us-ascii?Q?+8mVIsTwrNFJ/endfFpkTAqwQJqD3+qmy6cCa5kUVmJgoMdAPzV9mrTT5VGH?=
 =?us-ascii?Q?m7EqAZ9pC4RI5AMAyvCPsjICPWXCT+/FwHaiKlsc2gDMkiCBKERiwTYd4ilQ?=
 =?us-ascii?Q?PEEq9GF3s5YnLLZ0BMqrUT9J4wr/P92voBFki35gzkDqvuX/b14GtXxFGO/L?=
 =?us-ascii?Q?0yol1ikDc2i1HTn77M32o5hSbQtW5FCsiiSVk1eX8rs/E2lF1I9BZEpbj47z?=
 =?us-ascii?Q?AwYvJiATK2lP4T+XGt62BzpZtakXFgCUOozdv5RS2ZM1nXZH5RQ/wzsVPATU?=
 =?us-ascii?Q?hPS9pz+eqYP27Vgz53MsZ+9KZTLzYTZbhoMGn2SWK4TPUfrVRItcXIMKxSxD?=
 =?us-ascii?Q?3AhHcIhuxhiXP04LqHOKchmE5H/5bX6WH+f2zm50IMW7RJ5u2gfyTnXdmyAs?=
 =?us-ascii?Q?8Nwftxfa+erzjW+OPPnPd5m3Y7R88TSmpwLGSeKqSDkb9yW/b1F3zqsa82Pb?=
 =?us-ascii?Q?MkaRp07qszQVgyTWHYmns2X8OcyBlux5ZX+Pl3Vnp5SMCwAayFPwfq04C5ca?=
 =?us-ascii?Q?sGcKthj6PZhn2zWvw2frW8MS5xT9jG/jbS1hVr3u6Z5XwATWF4/9q+C8gvdq?=
 =?us-ascii?Q?1eRuqwN0HstsPPAn67HU+Y+zvT7wbSTFLJ1GwV2hPTg98cetjGJUd34YA2X8?=
 =?us-ascii?Q?rIpG0UplktYGd+7SpfEJhMv6y9j4PCvZPOx0CckkZw0jYnQTf/a87dUcdGQp?=
 =?us-ascii?Q?bA1/7ACBNB8huGufVIakCJH6KWmoH0033PNLPjzLtb+e+8zpTznNsWo66HKQ?=
 =?us-ascii?Q?9pvHu9OX6tPnb9BltJ9mzmrpiQo2tD0c/coEIvyyY1+zhkMEJJFpNpy9CzJh?=
 =?us-ascii?Q?y1K0YwRIC1pYflSgy2Iciet+sHWNjK2sgaMWPv9ztONk4RkQ4A0rSR/19KHx?=
 =?us-ascii?Q?nKIky7VOZsPe5mBRu825Fq9v3HjT6On4ZHaXMv3+sQ1wc60MekbCD29TIv5v?=
 =?us-ascii?Q?ayY3oSGD9vzEXsyKap9xniTDWKnCWIFrv811PmCuaVU9y/Yy7gVQyZeQZQHh?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yajqWlq/+jaNx/F0foxpdGTsKpADQ1I3tuwVgo4wn3rJy527BF7fHZaews+KDHsTOMNbxorT13gzFbCtYw/xV3hLRzYZ+cc72+5aFGvZg5B02r/vjQESx68A5LlT+OeJ1oIxZgZAiigf0NRatotr7tb9L6bHVHnTgpNs5n6gQ4OBODiNF1eTVNUgDwOKKNHgl42kOGqK15k3L3hzz+bfo+bmtpJj/cCsh5jvKNpMrVTCMvPC1FzfuGrJZHkJZjGfQsBJBqQyIIZ209rniY73+Rkb/WqtbfFjRsEVQv23B7OWIQbi9zJURkvrNr7v6yJKOuT/S5D/KvR3G4HceGkvGZvjTsIJm/daxvhDY9aMoJRdRFdGSbYriTaM1hpmLx6ELhc59vN02aJ2he6buGzefMKy/iCqVQdIFNGfiusvAJBC+VolU6kVgrERqD59jVWVkzE8WLIdbWGOmTgG1Jx7MhTY7eqAcf6gkGyTXKUSI0uTPaHK+UG9i9D31SxbMKWhctdUXvrfRlI8auASPciyAPb7gzgfYBFst55T4gu36KWRshq3GvTGESMHTcs98mFGunhG0iO8yr4qv4T4wzFEtrlAEICu8BmdUDWZeShUbvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1cc3f0-2eeb-4042-d611-08de2925a893
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:44:45.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wy4O/uIL5IK7GtYh2K/kmga5WpA6ygH+MN6sLnh8BORhA67MtDNlLjCO6dch55XqzuLxNj30QbZtfV1XtSL5vIhjZiBKc7df2dAuW6/8Ags=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511210132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3lB+fNe38z5L
 hVRWB+U0QcIjfF2n5MwED3dKuJIQTi/5AKTSr8KhfRDkDzV0jUEKTmZFvl4Td0pTyUEjdlx20T/
 kKPZfb3WjA1IPM08lIk3hvFjFEloM7E/QBD9GA2rafI6H+Zu6A83me4o2eWm9aUGpl34zww2juC
 9zCgCVZHoYC1J6IaTaHDwTqU1O+1Qu1OGbyoGB2BUDhBzYPfwRPGnas2s6QI9IKrrccOW7HPyCy
 NHPwwOhqz7TrR04+XAD1QMOFawd4ORq/OcmCKi+JwWKXXhVKeUbdH5b8QrVrclkLVMIzhgZe13T
 nknm/feNxoVAz5EnAptgnaxBlxznB2bK6LUi3zhzokODA3rmKUx3p0sJE9GfWFY+hTRVv90X2qI
 NQ4zrMGLIVFoj0nvNG7pdsKoDIoZDw==
X-Proofpoint-GUID: tFu-sk1glznVmrhXSEogp3TFjhZrIlNm
X-Proofpoint-ORIG-GUID: tFu-sk1glznVmrhXSEogp3TFjhZrIlNm
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=6920a518 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6io7pepS11fV4-GKOfUA:9 a=CjuIK1q_8ugA:10

As Vlastimil noticed, something has gone fairly horribly wrong here in the
actual commit [0] vs. the patch here for tools/testing/vma/vma_internal.h.

We should only have the delta shown here, let me know if I need to help with a
conflict resolution! :)

Thanks, Lorenzo

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=c3f7c506e8f122a31b9cc01d234e7fcda46b0eca

On Fri, Nov 14, 2025 at 01:26:11PM +0000, Lorenzo Stoakes wrote:
> It is useful to transition to using a bitmap for VMA flags so we can avoid
> running out of flags, especially for 32-bit kernels which are constrained
> to 32 flags, necessitating some features to be limited to 64-bit kernels
> only.
>
> By doing so, we remove any constraint on the number of VMA flags moving
> forwards no matter the platform and can decide in future to extend beyond
> 64 if required.
>
> We start by declaring an opaque types, vma_flags_t (which resembles
> mm_struct flags of type mm_flags_t), setting it to precisely the same size
> as vm_flags_t, and place it in union with vm_flags in the VMA declaration.
>
> We additionally update struct vm_area_desc equivalently placing the new
> opaque type in union with vm_flags.
>
> This change therefore does not impact the size of struct vm_area_struct or
> struct vm_area_desc.
>
> In order for the change to be iterative and to avoid impacting performance,
> we designate VM_xxx declared bitmap flag values as those which must exist
> in the first system word of the VMA flags bitmap.
>
> We therefore declare vma_flags_clear_all(), vma_flags_overwrite_word(),
> vma_flags_overwrite_word(), vma_flags_overwrite_word_once(),
> vma_flags_set_word() and vma_flags_clear_word() in order to allow us to
> update the existing vm_flags_*() functions to utilise these helpers.
>
> This is a stepping stone towards converting users to the VMA flags bitmap
> and behaves precisely as before.
>
> By doing this, we can eliminate the existing private vma->__vm_flags field
> in the vma->vm_flags union and replace it with the newly introduced opaque
> type vma_flags, which we call flags so we refer to the new bitmap field as
> vma->flags.
>
> We update vma_flag_[test, set]_atomic() to account for the change also.
>
> We additionally update the VMA userland test declarations to implement the
> same changes there.
>
> Finally, we update the rust code to reference vma->vm_flags on update
> rather than vma->__vm_flags which has been removed. This is safe for now,
> albeit it is implicitly performing a const cast.
>
> Once we introduce flag helpers we can improve this more.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h               |  18 ++--
>  include/linux/mm_types.h         |  64 +++++++++++++-
>  rust/kernel/mm/virt.rs           |   2 +-
>  tools/testing/vma/vma_internal.h | 143 ++++++++++++++++++++++++++-----
>  4 files changed, 196 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad000c472bd5..79345c44a350 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -919,7 +919,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  static inline void vm_flags_init(struct vm_area_struct *vma,
>  				 vm_flags_t flags)
>  {
> -	ACCESS_PRIVATE(vma, __vm_flags) = flags;
> +	vma_flags_clear_all(&vma->flags);
> +	vma_flags_overwrite_word(&vma->flags, flags);
>  }
>
>  /*
> @@ -938,21 +939,26 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>  				       vm_flags_t flags)
>  {
>  	vma_assert_write_locked(vma);
> -	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
> +	/*
> +	 * The user should only be interested in avoiding reordering of
> +	 * assignment to the first word.
> +	 */
> +	vma_flags_clear_all(&vma->flags);
> +	vma_flags_overwrite_word_once(&vma->flags, flags);
>  }
>
>  static inline void vm_flags_set(struct vm_area_struct *vma,
>  				vm_flags_t flags)
>  {
>  	vma_start_write(vma);
> -	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
> +	vma_flags_set_word(&vma->flags, flags);
>  }
>
>  static inline void vm_flags_clear(struct vm_area_struct *vma,
>  				  vm_flags_t flags)
>  {
>  	vma_start_write(vma);
> -	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
> +	vma_flags_clear_word(&vma->flags, flags);
>  }
>
>  /*
> @@ -995,12 +1001,14 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
>  static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
>  				       vma_flag_t bit)
>  {
> +	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
> +
>  	/* mmap read lock/VMA read lock must be held. */
>  	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
>  		vma_assert_locked(vma);
>
>  	if (__vma_flag_atomic_valid(vma, bit))
> -		set_bit((__force int)bit, &ACCESS_PRIVATE(vma, __vm_flags));
> +		set_bit((__force int)bit, bitmap);
>  }
>
>  /*
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3550672e0f9e..b71625378ce3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -848,6 +848,15 @@ struct mmap_action {
>  	bool hide_from_rmap_until_complete :1;
>  };
>
> +/*
> + * Opaque type representing current VMA (vm_area_struct) flag state. Must be
> + * accessed via vma_flags_xxx() helper functions.
> + */
> +#define NUM_VMA_FLAG_BITS BITS_PER_LONG
> +typedef struct {
> +	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
> +} __private vma_flags_t;
> +
>  /*
>   * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
>   * manipulate mutable fields which will cause those fields to be updated in the
> @@ -865,7 +874,10 @@ struct vm_area_desc {
>  	/* Mutable fields. Populated with initial state. */
>  	pgoff_t pgoff;
>  	struct file *vm_file;
> -	vm_flags_t vm_flags;
> +	union {
> +		vm_flags_t vm_flags;
> +		vma_flags_t vma_flags;
> +	};
>  	pgprot_t page_prot;
>
>  	/* Write-only fields. */
> @@ -910,10 +922,12 @@ struct vm_area_struct {
>  	/*
>  	 * Flags, see mm.h.
>  	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
> +	 * Preferably, use vma_flags_xxx() functions.
>  	 */
>  	union {
> +		/* Temporary while VMA flags are being converted. */
>  		const vm_flags_t vm_flags;
> -		vm_flags_t __private __vm_flags;
> +		vma_flags_t flags;
>  	};
>
>  #ifdef CONFIG_PER_VMA_LOCK
> @@ -994,6 +1008,52 @@ struct vm_area_struct {
>  #endif
>  } __randomize_layout;
>
> +/* Clears all bits in the VMA flags bitmap, non-atomically. */
> +static inline void vma_flags_clear_all(vma_flags_t *flags)
> +{
> +	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
> +}
> +
> +/*
> + * Copy value to the first system word of VMA flags, non-atomically.
> + *
> + * IMPORTANT: This does not overwrite bytes past the first system word. The
> + * caller must account for this.
> + */
> +static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
> +{
> +	*ACCESS_PRIVATE(flags, __vma_flags) = value;
> +}
> +
> +/*
> + * Copy value to the first system word of VMA flags ONCE, non-atomically.
> + *
> + * IMPORTANT: This does not overwrite bytes past the first system word. The
> + * caller must account for this.
> + */
> +static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +
> +	WRITE_ONCE(*bitmap, value);
> +}
> +
> +/* Update the first system word of VMA flags setting bits, non-atomically. */
> +static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +
> +	*bitmap |= value;
> +}
> +
> +/* Update the first system word of VMA flags clearing bits, non-atomically. */
> +static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +
> +	*bitmap &= ~value;
> +}
> +
>  #ifdef CONFIG_NUMA
>  #define vma_policy(vma) ((vma)->vm_policy)
>  #else
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index a1bfa4e19293..da21d65ccd20 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -250,7 +250,7 @@ unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
>          // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
>          // shared. Additionally, `VmaNew` is `!Sync`, so it cannot be used to write in parallel.
>          // The caller promises that this does not set the flags to an invalid value.
> -        unsafe { (*self.as_ptr()).__bindgen_anon_2.__vm_flags = flags };
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags };
>      }
>
>      /// Set the `VM_MIXEDMAP` flag on this vma.
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 18659214e262..13ee825bdfcf 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -528,6 +528,15 @@ typedef struct {
>  	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
>  } mm_flags_t;
>
> +/*
> + * Opaque type representing current VMA (vm_area_struct) flag state. Must be
> + * accessed via vma_flags_xxx() helper functions.
> + */
> +#define NUM_VMA_FLAG_BITS BITS_PER_LONG
> +typedef struct {
> +	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
> +} __private vma_flags_t;
> +
>  struct mm_struct {
>  	struct maple_tree mm_mt;
>  	int map_count;			/* number of VMAs */
> @@ -612,7 +621,10 @@ struct vm_area_desc {
>  	/* Mutable fields. Populated with initial state. */
>  	pgoff_t pgoff;
>  	struct file *vm_file;
> -	vm_flags_t vm_flags;
> +	union {
> +		vm_flags_t vm_flags;
> +		vma_flags_t vma_flags;
> +	};
>  	pgprot_t page_prot;
>
>  	/* Write-only fields. */
> @@ -658,7 +670,7 @@ struct vm_area_struct {
>  	 */
>  	union {
>  		const vm_flags_t vm_flags;
> -		vm_flags_t __private __vm_flags;
> +		vma_flags_t flags;
>  	};
>
>  #ifdef CONFIG_PER_VMA_LOCK
> @@ -1372,26 +1384,6 @@ static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
>  	return true;
>  }
>
> -static inline void vm_flags_init(struct vm_area_struct *vma,
> -				 vm_flags_t flags)
> -{
> -	vma->__vm_flags = flags;
> -}
> -
> -static inline void vm_flags_set(struct vm_area_struct *vma,
> -				vm_flags_t flags)
> -{
> -	vma_start_write(vma);
> -	vma->__vm_flags |= flags;
> -}
> -
> -static inline void vm_flags_clear(struct vm_area_struct *vma,
> -				  vm_flags_t flags)
> -{
> -	vma_start_write(vma);
> -	vma->__vm_flags &= ~flags;
> -}
> -
>  static inline int shmem_zero_setup(struct vm_area_struct *vma)
>  {
>  	return 0;
> @@ -1548,13 +1540,118 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  {
>  }
>
> -# define ACCESS_PRIVATE(p, member) ((p)->member)
> +#define ACCESS_PRIVATE(p, member) ((p)->member)
> +
> +#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
> +
> +static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
> +{
> +	unsigned int len = bitmap_size(nbits);
> +
> +	if (small_const_nbits(nbits))
> +		*dst = 0;
> +	else
> +		memset(dst, 0, len);
> +}
>
>  static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
>  {
>  	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>
> +/* Clears all bits in the VMA flags bitmap, non-atomically. */
> +static inline void vma_flags_clear_all(vma_flags_t *flags)
> +{
> +	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
> +}
> +
> +/*
> + * Copy value to the first system word of VMA flags, non-atomically.
> + *
> + * IMPORTANT: This does not overwrite bytes past the first system word. The
> + * caller must account for this.
> + */
> +static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
> +{
> +	*ACCESS_PRIVATE(flags, __vma_flags) = value;
> +}
> +
> +/*
> + * Copy value to the first system word of VMA flags ONCE, non-atomically.
> + *
> + * IMPORTANT: This does not overwrite bytes past the first system word. The
> + * caller must account for this.
> + */
> +static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +
> +	WRITE_ONCE(*bitmap, value);
> +}
> +
> +/* Update the first system word of VMA flags setting bits, non-atomically. */
> +static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +
> +	*bitmap |= value;
> +}
> +
> +/* Update the first system word of VMA flags clearing bits, non-atomically. */
> +static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
> +
> +	*bitmap &= ~value;
> +}
> +
> +
> +/* Use when VMA is not part of the VMA tree and needs no locking */
> +static inline void vm_flags_init(struct vm_area_struct *vma,
> +				 vm_flags_t flags)
> +{
> +	vma_flags_clear_all(&vma->flags);
> +	vma_flags_overwrite_word(&vma->flags, flags);
> +}
> +
> +/*
> + * Use when VMA is part of the VMA tree and modifications need coordination
> + * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
> + * it should be locked explicitly beforehand.
> + */
> +static inline void vm_flags_reset(struct vm_area_struct *vma,
> +				  vm_flags_t flags)
> +{
> +	vma_assert_write_locked(vma);
> +	vm_flags_init(vma, flags);
> +}
> +
> +static inline void vm_flags_reset_once(struct vm_area_struct *vma,
> +				       vm_flags_t flags)
> +{
> +	vma_assert_write_locked(vma);
> +	/*
> +	 * The user should only be interested in avoiding reordering of
> +	 * assignment to the first word.
> +	 */
> +	vma_flags_clear_all(&vma->flags);
> +	vma_flags_overwrite_word_once(&vma->flags, flags);
> +}
> +
> +static inline void vm_flags_set(struct vm_area_struct *vma,
> +				vm_flags_t flags)
> +{
> +	vma_start_write(vma);
> +	vma_flags_set_word(&vma->flags, flags);
> +}
> +
> +static inline void vm_flags_clear(struct vm_area_struct *vma,
> +				  vm_flags_t flags)
> +{
> +	vma_start_write(vma);
> +	vma_flags_clear_word(&vma->flags, flags);
> +}
> +
>  /*
>   * Denies creating a writable executable mapping or gaining executable permissions.
>   *
> --
> 2.51.0
>

