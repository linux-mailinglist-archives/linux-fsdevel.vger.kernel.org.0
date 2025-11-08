Return-Path: <linux-fsdevel+bounces-67548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1EC43136
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA993B5EE0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D2285CA8;
	Sat,  8 Nov 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GzjJd8PZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bp5nz1dk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B80275B1A;
	Sat,  8 Nov 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621887; cv=fail; b=Hq/45iyvZt8QmSR8uEj8wB73LC82Q3UygvwK1LDQH13EcL76ytCp8v0LQyOw9tYTZQdgDFw4Ji+N03OKkBC7fkcUmkWm44T62huAsQK7+Y6tvqmJEb5r2O2wIbsx/DGseQK8pqX5Pm9lRPZOaVS97XP1S65UKuXpxSZJvMubOPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621887; c=relaxed/simple;
	bh=udHzDGOHZEOC4G9rQvtfjp+gPD4docKcXGTCD83HiVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fk8JU3AQsW4pbkjX6DG9adHcLt8a90Qbf3hPCavgJXw2Hof2lK92Dr1uazYKedOWUxwRyDXHw3+tNOAppzXcIykMjSHuB4tWnEkZwPhXRtBddpu+IhO7x/slTuVB9jB6N5qLZEKj4MaL9H0RsXrz0QUWAR91HBhUorBEv+/n5ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GzjJd8PZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bp5nz1dk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GYAUZ020534;
	Sat, 8 Nov 2025 17:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QatDEgNLAi109GS5YaZpw6b//HS/5gq8cfLzJsx21Gk=; b=
	GzjJd8PZRlvubnwARtxQerq7cLZSyKk21VuMpbnMtjSAC6uD6RfCjgfl/TqQrMAk
	Q16UhWe2Me5kprr/qK6FGQm9P9LSQgTiax9C2JHsq/BWwyRbYA6lyfbPcTjlp15P
	fmRC2TWCGSz+CpBRZN/pD8Z2m7CZIUVMNNWhcMl/GTLTHxZFpaJX2hkdUOO8Ib3P
	HgGgNwYcjfeDNdn/sUskI95mqHPBd1vC99UBjTcRmDJfo7IZJhBQokIiF4bai473
	paRB+ffQJVgw6ZeA3x6c7oXE9MmvjQA//MTy8um+JgiSyi/MTuOGY+8wLBDvg24i
	/IjNeGlvFQPXcmMeS55ugw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa0jy8etj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8BijdN007604;
	Sat, 8 Nov 2025 17:09:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n3y-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1KFk3dJkBpRXBahWzlNAi/LhgPcCa07u0UoJ9RANPm4UcBSEQ7ZZwwdWTx9qavGXtHoDBPjb3c2vKj1ApVoiNM/nIFwEB88wAwL6cYaKMCTJhUbRDiVqheO0yrUjpxmoiQkopMLK8QAyK44vQbf0ByFMoL3INjU8urLXFuhir8Yjs/mkXMw4Bs9hDieZvHsaeMtcwIK5hqh/0FiCUFoxZX/OkY65JIeuH3K0EqwwSJ/+FS8C3zYI9z40unK0MUSyjsuc/oFYFA1E34sLFE55v1/Y4FoDrlqN83Hqn5urDgtwM6tB5A2ZrcTq7yoFKbDaPkRM/T9QD1Mo++UpG+0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QatDEgNLAi109GS5YaZpw6b//HS/5gq8cfLzJsx21Gk=;
 b=eZe7NiZxHSBbOXIcDkPzRd/fzvEyF8jFuVKj9mflngSbWwk11IzpHyYj6qlxCYpQemulNkUom6GL7LKkzTzTmJGNPezth1by5WZKx2MaV9XS4Uka60nT7tXXPj0EZX0NE0++ffWCXi6yvBd4G0qg0SIH8ZQrF4YJHNCf722qyWe7z+b/lKi5w1NPmKwdVSO1enn9DazV7vfR6MAkqJSePtTfqGnQr2dltsqh4XpVcxxL6YHRBiGlnjyXPKWXGrLa4ZbufiTq9M72ExD0u65C/+SYBJLMyFsDEudyB69PfM7kuNAVo4N9f4DTItdBqaCx9ssJ3BoxxS0//pscawBhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QatDEgNLAi109GS5YaZpw6b//HS/5gq8cfLzJsx21Gk=;
 b=Bp5nz1dkdqk+/yk8ZWEMug1B9N0AJubImh/wyHmYyKZU8zD0TrYkx4070mYziOwT/UBGiJ3j+WXPyGRCAaRkBIgHNRdIC4bDwHRdBEph8LW7Ps9cRiUb3g9Opd0brjwfXKqhzwIN70H15/G81sXPQy3hklu2zRr87cYWP0zRn3A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Subject: [PATCH v2 15/16] mm: eliminate further swapops predicates
Date: Sat,  8 Nov 2025 17:08:29 +0000
Message-ID: <6bcfda48cf63eefee73671798a43e4b9aed23cc0.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd7fc15-db32-43b8-b60d-08de1ee996a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XOM1YFhi/I9unxaBV8C3TeOX8gq/9FM+pbiXR18Zfj/qK/Ao8eR/B6vRCbcu?=
 =?us-ascii?Q?psp3Hw2f6v8ZxGcrL4NCzjhNJXvGgDZ+BwPSXGnbVpZkv9dNWhuF5UJptL2S?=
 =?us-ascii?Q?cKLJKaTFdxUrYOHPj4LFMe8p1qFTSgQSsQhJ4hRwy/ayXGsAqK1+hUV9lFOk?=
 =?us-ascii?Q?N6ToNMqk6sHPZeY5yVxr8WYFM7ABjppl28J+2CC4AwysoWZybPW8TfKbnKg+?=
 =?us-ascii?Q?kKqkCVTmOtAJPZf2yVO/qEYqfDx7MLtTZQG/bBt/2CnImfBoPQlOBdXJZ8ZX?=
 =?us-ascii?Q?r3vOaWwy2CW3m6V/DGzg4an09COKmVI6uChSUYJ0AZb0Np5tld397/htHaQa?=
 =?us-ascii?Q?XNhHFaURgJbBG6pqnm/ft70/Tj25Uw3f7XJPCBY0hGFsvvlUqWS2qrUilqi8?=
 =?us-ascii?Q?8iJSAgEXg6KmRU5ADp4rPpT/ou4CX3XKx1MWocNt8nWT+89XnoW5DnYvhmZS?=
 =?us-ascii?Q?p1iOQEcWhqR+sh3USoYKeDKxzxSv3hM8SAMpBtTJND2WAeArJGORGaSrGdqG?=
 =?us-ascii?Q?URNzX2+8XRs6pHDVQky1d459c6TMPN6NE/pWo2HkEaqqGPTEo/zN2oIfe80k?=
 =?us-ascii?Q?ZWTp1QAS5kmO4lnc6iV7hfJ52gAtz1+bmTiWCA5w/bqMjOGnAeEt2OUWyN4B?=
 =?us-ascii?Q?vP/tVTcPbZgf6uyTJ3lFRKPBYTVv9hZNbHcYRg+R+Cy2h6g4NX9A06PZCxly?=
 =?us-ascii?Q?ExMttLu8ov7Kp7Gr6RydjQ3BDnJP6gnsZd+rLHURvmDccIMLbPpQAWbp9Dtp?=
 =?us-ascii?Q?8h6imzdJmxfoa2NI71w/2979xq63nckeDuzaj19QfNFVWEgxn0dCxv2XHHBa?=
 =?us-ascii?Q?3Fv3UGzrUwYYnYcw0BnutQ86Y9WfRz23nWS81h9LghZ7yADiQtabsOL5Got+?=
 =?us-ascii?Q?/kt8k44JfOOPLr6t9ZLL5HpLlFKZERVhJ1LjOCha2F2I76t0rfTux9lTH39h?=
 =?us-ascii?Q?kV/tPc+6abGnKDzereFfg7do2BP9lXyjH//7rTXyoEzuIFTlBMKndmCWj4D6?=
 =?us-ascii?Q?J6hjsOyWwx7NfsKu05NrV3/r2Y52npwdgArbmCVcBn13zLt2le8e5PcGZkSO?=
 =?us-ascii?Q?70Okv6yCy/DaOCtuxOZXn2E+6ZiCTLbuCgACTEfPGH28ZeZSKuH5mMRDIg1s?=
 =?us-ascii?Q?ovCNl2R9QsupKURtxJImc4r4RnrGDvkOs+38LaKJhwJQScaprtRmCWkLeqLX?=
 =?us-ascii?Q?Z2tX2QA56YPr84nNITMFyUANSgDPOi9rsP9ifOpIerp6li70QI7Zcf7C7oJF?=
 =?us-ascii?Q?GtdpqWnuArENpdFGnc+XxWC1J0GDSfwdA+NGNS+aTLy2pdV0ShsXYgk5yBb+?=
 =?us-ascii?Q?czkjDl7uam9p1Zyq73Vt/TMm8EjD5DdKauaCjzbzBdtexSupl9KSBjsvAg9X?=
 =?us-ascii?Q?moU7ZOdYABKgwcVLIv0S11MhFS2ELA2OEV7vCRbNQcU7d4GNCgSFNbXn7g99?=
 =?us-ascii?Q?/BLMANCRV6fBJG2CVHg/SegmbFsutguH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZODy6E8eICFymg3wGs4PaoktVs/ChTjYJR01mppYXCN4txEAPbgClBlymc9T?=
 =?us-ascii?Q?DLdez1aY+UGDS2ruBiltwl6YxOXfcB95KHadTtjv16HLRbTErXunx6sYp0Eb?=
 =?us-ascii?Q?J0CwqnEAfQFKras7lHeR7DbQz7y4RZg5KJlWTCrUwAvqQnNgCNQ2GxqOpK3H?=
 =?us-ascii?Q?rU1dc0oqZA66B9JB+Zo5ArlPmMEDSaayLEQVXdf0c/Vx9sLwoIzLR2dr9wYs?=
 =?us-ascii?Q?K+sNC6hripny9zAvk5ZcBPwmN/FGHKpKX3NhSvfYNEH4fr5n1hQozKz3GMtL?=
 =?us-ascii?Q?N3TH5e5/0uLimPymVK8ySOT/ncSzKN3ZKUzjnmis7RBDQTs/yHOFtplcDfB1?=
 =?us-ascii?Q?cwiXrr8j8t5MycQYYrsrFNe50uQz5/9IVbPBCB/X+5gzU8mJrC8e529KODaB?=
 =?us-ascii?Q?hmWQSsp69o+/7TGpresjjJEZ61JpovnnWmQu7vFC9WVPCdFADZ1RB6TEs09a?=
 =?us-ascii?Q?UqSU0dq559FH7hg7Bgq52zm2y/SSm/u5xh8Dsu5Ixdi0PEYSRcRz5X8iv+hR?=
 =?us-ascii?Q?Hdvk41MLlENzdhmTAIqH1LtgWpP8SCo1spawbZOezGxb/Y9BawICy6+NzBKi?=
 =?us-ascii?Q?zyNU8SKhoXt6tAJE1755+k3C2/V4H9iI94sjwDFC+ayQXgy540h4bM/X2VYk?=
 =?us-ascii?Q?ly0CGXi/3KIus6cJ/RmF1jjPnqebYw2EysJaunF7pbsU2lwR44GWLy40w3qP?=
 =?us-ascii?Q?uq/pNwY2Bbf2hDjnvK0qC/1+AZdt+ZafkgmTuMmJngbKqj1DBQTvwW4P/BIj?=
 =?us-ascii?Q?NkTlVl6WubfHCYeB9NfimyH+guDoe/EmNSCdmf6qebt//RFTQ/z3H9Va/wXg?=
 =?us-ascii?Q?zsC5khG/DiSTrEMDUzcSs41uXaEuyahD5u7QcU5VeTPUD7+ZGwuTnDwhzV+v?=
 =?us-ascii?Q?BFKxpsQVLb0xcBdfBkY/rUi2+Byo6Hfw0XBv15dbumEjL1zj/mN8alBBHkH2?=
 =?us-ascii?Q?u9DmClAFQ2OtUR2GVtUutYOMvrZsBTx6EDJqQ19/QzJQdJCEaZSQBqNhTvET?=
 =?us-ascii?Q?BZBlPwve9oiK3NTTRfT95D1b9cT28QxkiErBEQrLrwOr8M3tT5fdjkIeMnve?=
 =?us-ascii?Q?bFg1fniHAKTMywN+T1xxJCVtvZJnq/eYkTQHvk+azh7ZXgy7F3dXXWIQGEhF?=
 =?us-ascii?Q?ZUIaISE4p3+MrgSy+XzpSJDjKfaw6fmYnsf8H0lMJeaAagY0e6yPDy/b6u6y?=
 =?us-ascii?Q?YRv87Qkk+13A6BGM4N+MWGtukd81WHAEF8K8XfXo5mzdCmQbnIDfwoO3ha9P?=
 =?us-ascii?Q?z6YxrzpXYxVUZRPWEw1AwwjvJVCneafL1xnjSDcxoNnHHr/VVzgyp8+8HVuM?=
 =?us-ascii?Q?F/B41uuzVkdGgSdaFo8Gna251Tz2iuGhYLolJiPVw8/L8UKFi3Ha7bNkoqBE?=
 =?us-ascii?Q?iWvXRdcjbWHdICsC0H5OgNcejhJXKaTbvSSzHwC8eerYOgkwnJk4/6PQ3OvS?=
 =?us-ascii?Q?xejiIYNnqWshokp2LfZvEyIa7RwzbFgj8ghl6Vp7NTlLKzIG35c+Jnl9XUQe?=
 =?us-ascii?Q?Ak7qCif2x/+qeIPIdSUAU6Qg6wkTqwbllBFaaV8eKsSV0tJ6W3bFK5wOU1PR?=
 =?us-ascii?Q?uL12ulnT6fBZWR7s3+qQivsF/xh17HKv/2JiLIjHKU41RiYk/Eeawjc2pMBS?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Wv+tQGg+r5kYevN7NhhgrXHIvN+oCcPB2ov9WNf5L7ZRx8x4tX+ygYbUw8Pej0FfAgDmoYAnzWuHK/d6NVNx3rSGo6HG7I2fmciktku2/hBh1DLM8gsJwf5zQSvhku5fF1q3wTRNnB6R6PsSh+6QtoZmYKyR+lvAYfSNiJ63LOrYQhgNfu9e0M78EFDzknfKA7sWLTNFWkrZE/WzmmKug0rfo96dx7bpC9VnkLXLGT/HPojCheVRY6mOeWroeU9CAIZkvdQE62GyKm6dtiEgJaIJFG3yoQGEE6t156BXurKhm3S23ubSA/G9IukKfQcBORs8/3JlNysvrR7PHkUtMkJZmbHUmQ8oceCgVbApCVM6g7ISVBW6gx3dwQWTB/zrq78tC9iBssDjDgvLMPL4YyrJ3xkC8THeFgdNwQ2yRMZgI00d1L3oLdvaCwuwjBQZxJ6dkqOAwOACm/8x426DzRP92flR+CeBWLCMIb4QVyDbkAhjSScNahp/a9MBU+WJA6gkn33la5RmbAxseP593uS0bs/dChLRaIIKe8eHJMDMs8beB1qSHaPqHmnWzCCqZiZl+WIGCSl/UM7jSfJynXiNaUU9QEAfK1brUdr2BM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd7fc15-db32-43b8-b60d-08de1ee996a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:33.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmyf3kj+NDHUGRv1TtSOoo6SdkYvX/oWm/C4ayp/614s2h9XQN1ru3WSPOXXkNcYiFaz0Yx11QuXLHR4tZeEnqKvEqar54cgDtHsVbCcilw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1MCBTYWx0ZWRfX6ougYj9ECSWl
 lBros9yDBF2waFmCaUKGpHD4xepoLncgOzfvXeP50rpfntzaKbrv3T+he6p+an3psrESswws0tj
 ZB2IcyHhUL++1mjeyi+0ulmqRrQZ8II508J8z53dLxTJ8q9Be0F4wjQuWRsKJsPIChCwDXH7mGM
 EsCx4LS/vlfWeropV5yrE+BV+avadY341v7AbBh8iCaVGWq/5Wx0r+iu8QGebuzdoPneb0kZoAr
 lP4A3ucGM6llvjN4jTI2wqosy6OpeuTWt4rwhFu4zi4Ckv5qjI/M9LtRkI72p7jaUlRqrJiZ19B
 U5ipfnfEBXMC5hoXJCEw3omicd4zBlhLzjGnAFzp1ude3owsjYtKrCIl9KETUhDMuQP2gB25qlK
 6zTIsLr7bvnR6VoJh3AaW3C4C2ftDw==
X-Proofpoint-ORIG-GUID: 4IelBXJEfTWxYuPPu7HJD_H_pvGBWRAK
X-Authority-Analysis: v=2.4 cv=IpkTsb/g c=1 sm=1 tr=0 ts=690f7953 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=12TsxHtCQ5kFwp23Kd0A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: 4IelBXJEfTWxYuPPu7HJD_H_pvGBWRAK

Having converted so much of the code base to software leaf entries, we can
mop up some remaining cases.

We replace is_pfn_swap_entry(), pfn_swap_entry_to_page(),
is_writable_device_private_entry(), is_device_exclusive_entry(),
is_migration_entry(), is_writable_migration_entry(),
is_readable_migration_entry(), swp_offset_pfn() and pfn_swap_entry_folio()
with softleaf equivalents.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      |  14 ++---
 include/linux/leafops.h |  25 +++++++--
 include/linux/swapops.h | 121 +---------------------------------------
 mm/debug_vm_pgtable.c   |  20 +++----
 mm/hmm.c                |   2 +-
 mm/hugetlb.c            |   2 +-
 mm/ksm.c                |   6 +-
 mm/memory-failure.c     |   6 +-
 mm/memory.c             |   3 +-
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |   6 +-
 mm/migrate_device.c     |  10 ++--
 mm/mprotect.c           |   8 +--
 mm/page_vma_mapped.c    |   8 +--
 mm/pagewalk.c           |   7 +--
 mm/rmap.c               |   9 ++-
 16 files changed, 75 insertions(+), 176 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cdefa7546db..4deded872c46 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1940,13 +1940,13 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
 	} else {
-		swp_entry_t entry;
+		softleaf_t entry;
 
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-		entry = pte_to_swp_entry(pte);
+		entry = softleaf_from_pte(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
 
@@ -1954,16 +1954,16 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
 			 */
-			if (is_pfn_swap_entry(entry))
-				offset = swp_offset_pfn(entry);
+			if (softleaf_has_pfn(entry))
+				offset = softleaf_to_pfn(entry);
 			else
 				offset = swp_offset(entry);
 			frame = swp_type(entry) |
 			    (offset << MAX_SWAPFILES_SHIFT);
 		}
 		flags |= PM_SWAP;
-		if (is_pfn_swap_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+		if (softleaf_has_pfn(entry))
+			page = softleaf_to_page(entry);
 		if (softleaf_is_uffd_wp_marker(entry))
 			flags |= PM_UFFD_WP;
 		if (softleaf_is_guard_marker(entry))
@@ -2032,7 +2032,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
 		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
-		page = pfn_swap_entry_to_page(entry);
+		page = softleaf_to_page(entry);
 	}
 
 	if (page) {
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 9be9a4e8ada4..d593093ba70c 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -355,7 +355,7 @@ static inline unsigned long softleaf_to_pfn(softleaf_t entry)
 	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
 
 	/* Temporary until swp_entry_t eliminated. */
-	return swp_offset_pfn(entry);
+	return swp_offset(entry) & SWP_PFN_MASK;
 }
 
 /**
@@ -366,10 +366,16 @@ static inline unsigned long softleaf_to_pfn(softleaf_t entry)
  */
 static inline struct page *softleaf_to_page(softleaf_t entry)
 {
+	struct page *page = pfn_to_page(softleaf_to_pfn(entry));
+
 	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding page is locked
+	 */
+	VM_WARN_ON_ONCE(softleaf_is_migration(entry) && !PageLocked(page));
 
-	/* Temporary until swp_entry_t eliminated. */
-	return pfn_swap_entry_to_page(entry);
+	return page;
 }
 
 /**
@@ -381,10 +387,17 @@ static inline struct page *softleaf_to_page(softleaf_t entry)
  */
 static inline struct folio *softleaf_to_folio(softleaf_t entry)
 {
-	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+	struct folio *folio = pfn_folio(softleaf_to_pfn(entry));
 
-	/* Temporary until swp_entry_t eliminated. */
-	return pfn_swap_entry_folio(entry);
+	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding folio is locked.
+	 */
+	VM_WARN_ON_ONCE(softleaf_is_migration(entry) &&
+			!folio_test_locked(folio));
+
+	return folio;
 }
 
 /**
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index c8e6f927da48..3d02b288c15e 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -28,7 +28,7 @@
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
 /*
- * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
+ * Definitions only for PFN swap entries (see leafeant_has_pfn()).  To
  * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
  * can use the extra bits to store other information besides PFN.
  */
@@ -66,8 +66,6 @@
 #define SWP_MIG_YOUNG			BIT(SWP_MIG_YOUNG_BIT)
 #define SWP_MIG_DIRTY			BIT(SWP_MIG_DIRTY_BIT)
 
-static inline bool is_pfn_swap_entry(swp_entry_t entry);
-
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -109,17 +107,6 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/*
- * This should only be called upon a pfn swap entry to get the PFN stored
- * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
- * of pfn swap entry.
- */
-static inline unsigned long swp_offset_pfn(swp_entry_t entry)
-{
-	VM_BUG_ON(!is_pfn_swap_entry(entry));
-	return swp_offset(entry) & SWP_PFN_MASK;
-}
-
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
@@ -169,27 +156,11 @@ static inline swp_entry_t make_writable_device_private_entry(pgoff_t offset)
 	return swp_entry(SWP_DEVICE_WRITE, offset);
 }
 
-static inline bool is_device_private_entry(swp_entry_t entry)
-{
-	int type = swp_type(entry);
-	return type == SWP_DEVICE_READ || type == SWP_DEVICE_WRITE;
-}
-
-static inline bool is_writable_device_private_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_DEVICE_WRITE);
-}
-
 static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(SWP_DEVICE_EXCLUSIVE, offset);
 }
 
-static inline bool is_device_exclusive_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE;
-}
-
 #else /* CONFIG_DEVICE_PRIVATE */
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
@@ -201,50 +172,14 @@ static inline swp_entry_t make_writable_device_private_entry(pgoff_t offset)
 	return swp_entry(0, 0);
 }
 
-static inline bool is_device_private_entry(swp_entry_t entry)
-{
-	return false;
-}
-
-static inline bool is_writable_device_private_entry(swp_entry_t entry)
-{
-	return false;
-}
-
 static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(0, 0);
 }
 
-static inline bool is_device_exclusive_entry(swp_entry_t entry)
-{
-	return false;
-}
-
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 #ifdef CONFIG_MIGRATION
-static inline int is_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ ||
-			swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE ||
-			swp_type(entry) == SWP_MIGRATION_WRITE);
-}
-
-static inline int is_writable_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
-}
-
-static inline int is_readable_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ);
-}
-
-static inline int is_readable_exclusive_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE);
-}
 
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -310,23 +245,10 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 	return swp_entry(0, 0);
 }
 
-static inline int is_migration_entry(swp_entry_t swp)
-{
-	return 0;
-}
-
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *pte) { }
-static inline int is_writable_migration_entry(swp_entry_t entry)
-{
-	return 0;
-}
-static inline int is_readable_migration_entry(swp_entry_t entry)
-{
-	return 0;
-}
 
 static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 {
@@ -410,47 +332,6 @@ static inline swp_entry_t make_guard_swp_entry(void)
 	return make_pte_marker_entry(PTE_MARKER_GUARD);
 }
 
-static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
-{
-	struct page *p = pfn_to_page(swp_offset_pfn(entry));
-
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding page is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
-
-	return p;
-}
-
-static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
-{
-	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
-
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding folio is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
-
-	return folio;
-}
-
-/*
- * A pfn swap entry is a special type of swap entry that always has a pfn stored
- * in the swap offset. They can either be used to represent unaddressable device
- * memory, to restrict access to a page undergoing migration or to represent a
- * pfn which has been hwpoisoned and unmapped.
- */
-static inline bool is_pfn_swap_entry(swp_entry_t entry)
-{
-	/* Make sure the swp offset can always store the needed fields */
-	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
-
-	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
-}
-
 struct page_vma_mapped_walk;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 608d1011ce03..64db85a80558 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -844,7 +844,7 @@ static void __init pmd_softleaf_tests(struct pgtable_debug_args *args) { }
 static void __init swap_migration_tests(struct pgtable_debug_args *args)
 {
 	struct page *page;
-	swp_entry_t swp;
+	softleaf_t entry;
 
 	if (!IS_ENABLED(CONFIG_MIGRATION))
 		return;
@@ -867,17 +867,17 @@ static void __init swap_migration_tests(struct pgtable_debug_args *args)
 	 * be locked, otherwise it stumbles upon a BUG_ON().
 	 */
 	__SetPageLocked(page);
-	swp = make_writable_migration_entry(page_to_pfn(page));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(!is_writable_migration_entry(swp));
+	entry = make_writable_migration_entry(page_to_pfn(page));
+	WARN_ON(!softleaf_is_migration(entry));
+	WARN_ON(!softleaf_is_migration_write(entry));
 
-	swp = make_readable_migration_entry(swp_offset(swp));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(is_writable_migration_entry(swp));
+	entry = make_readable_migration_entry(swp_offset(entry));
+	WARN_ON(!softleaf_is_migration(entry));
+	WARN_ON(softleaf_is_migration_write(entry));
 
-	swp = make_readable_migration_entry(page_to_pfn(page));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(is_writable_migration_entry(swp));
+	entry = make_readable_migration_entry(page_to_pfn(page));
+	WARN_ON(!softleaf_is_migration(entry));
+	WARN_ON(softleaf_is_migration_write(entry));
 	__ClearPageLocked(page);
 }
 
diff --git a/mm/hmm.c b/mm/hmm.c
index d5c4e60fbfad..f91c38d4507a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -265,7 +265,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (softleaf_is_device_private_write(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
+			new_pfn_flags = softleaf_to_pfn(entry) | cpu_flags;
 			goto out;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b702b161ab35..f7f18a3ea495 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5640,7 +5640,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else if (unlikely(softleaf_is_migration(softleaf))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
-			if (!is_readable_migration_entry(softleaf) && cow) {
+			if (!softleaf_is_migration_read(softleaf) && cow) {
 				/*
 				 * COW mappings require pages in both
 				 * parent and child to be set to read.
diff --git a/mm/ksm.c b/mm/ksm.c
index 7cd19a6ce45f..b911df37f04e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -637,14 +637,14 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long en
 		if (pte_present(pte)) {
 			folio = vm_normal_folio(walk->vma, addr, pte);
 		} else if (!pte_none(pte)) {
-			swp_entry_t entry = pte_to_swp_entry(pte);
+			const softleaf_t entry = softleaf_from_pte(pte);
 
 			/*
 			 * As KSM pages remain KSM pages until freed, no need to wait
 			 * here for migration to end.
 			 */
-			if (is_migration_entry(entry))
-				folio = pfn_swap_entry_folio(entry);
+			if (softleaf_is_migration(entry))
+				folio = softleaf_to_folio(entry);
 		}
 		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
 		found = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(pte);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index acc35c881547..6e79da3de221 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -691,10 +691,10 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
 	} else {
-		swp_entry_t swp = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
-		if (is_hwpoison_entry(swp))
-			pfn = swp_offset_pfn(swp);
+		if (softleaf_is_hwpoison(entry))
+			pfn = softleaf_to_pfn(entry);
 	}
 
 	if (!pfn || pfn != poisoned_pfn)
diff --git a/mm/memory.c b/mm/memory.c
index ad336cbf1d88..accd275cd651 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -902,7 +902,8 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 static int try_restore_exclusive_pte(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, pte_t orig_pte)
 {
-	struct page *page = pfn_swap_entry_to_page(pte_to_swp_entry(orig_pte));
+	const softleaf_t entry = softleaf_from_pte(orig_pte);
+	struct page *page = softleaf_to_page(entry);
 	struct folio *folio = page_folio(page);
 
 	if (folio_trylock(folio)) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index dee95d5ecfd4..acb9bf89f619 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -705,7 +705,9 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		if (pte_none(ptent))
 			continue;
 		if (!pte_present(ptent)) {
-			if (is_migration_entry(pte_to_swp_entry(ptent)))
+			const softleaf_t entry = softleaf_from_pte(ptent);
+
+			if (softleaf_is_migration(entry))
 				qp->nr_failed++;
 			continue;
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index 48f98a6c1ad2..182a5b7b2ead 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -483,7 +483,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	spinlock_t *ptl;
 	pte_t *ptep;
 	pte_t pte;
-	swp_entry_t entry;
+	softleaf_t entry;
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!ptep)
@@ -495,8 +495,8 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
-	entry = pte_to_swp_entry(pte);
-	if (!is_migration_entry(entry))
+	entry = softleaf_from_pte(pte);
+	if (!softleaf_is_migration(entry))
 		goto out;
 
 	migration_entry_wait_on_locked(entry, ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 880f26a316f8..c50abbd32f21 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -282,7 +282,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
-		swp_entry_t entry;
+		softleaf_t entry;
 		pte_t pte;
 
 		pte = ptep_get(ptep);
@@ -301,11 +301,11 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			 * page table entry. Other special swap entries are not
 			 * migratable, and we ignore regular swapped page.
 			 */
-			entry = pte_to_swp_entry(pte);
-			if (!is_device_private_entry(entry))
+			entry = softleaf_from_pte(pte);
+			if (!softleaf_is_device_private(entry))
 				goto next;
 
-			page = pfn_swap_entry_to_page(entry);
+			page = softleaf_to_page(entry);
 			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
@@ -331,7 +331,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
 					MIGRATE_PFN_MIGRATE;
-			if (is_writable_device_private_entry(entry))
+			if (softleaf_is_device_private_write(entry))
 				mpfn |= MIGRATE_PFN_WRITE;
 		} else {
 			pfn = pte_pfn(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab014ce17f9c..476a29cc89bf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -317,11 +317,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 				pages++;
 			}
 		} else  {
-			swp_entry_t entry = pte_to_swp_entry(oldpte);
+			softleaf_t entry = softleaf_from_pte(oldpte);
 			pte_t newpte;
 
-			if (is_writable_migration_entry(entry)) {
-				struct folio *folio = pfn_swap_entry_folio(entry);
+			if (softleaf_is_migration_write(entry)) {
+				const struct folio *folio = softleaf_to_folio(entry);
 
 				/*
 				 * A protection check is difficult so
@@ -335,7 +335,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(oldpte))
 					newpte = pte_swp_mksoft_dirty(newpte);
-			} else if (is_writable_device_private_entry(entry)) {
+			} else if (softleaf_is_device_private_write(entry)) {
 				/*
 				 * We do not preserve soft-dirtiness. See
 				 * copy_nonpresent_pte() for explanation.
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 8137d2366722..b38a1d00c971 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -49,7 +49,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (is_migration)
 			return false;
 	} else if (!is_migration) {
-		swp_entry_t entry;
+		softleaf_t entry;
 
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
@@ -67,9 +67,9 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		 * For more details on device private memory see HMM
 		 * (include/linux/hmm.h or mm/hmm.c).
 		 */
-		entry = pte_to_swp_entry(ptent);
-		if (!is_device_private_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
+		entry = softleaf_from_pte(ptent);
+		if (!softleaf_is_device_private(entry) &&
+		    !softleaf_is_device_exclusive(entry))
 			return false;
 	}
 	spin_lock(*ptlp);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3067feb970d1..d6e29da60d09 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1000,11 +1000,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 			goto found;
 		}
 	} else if (!pte_none(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
-		if ((flags & FW_MIGRATION) &&
-		    is_migration_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
+		if ((flags & FW_MIGRATION) && softleaf_is_migration(entry)) {
+			page = softleaf_to_page(entry);
 			expose_page = false;
 			goto found;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 775710115a41..345466ad396b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1969,7 +1969,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			pfn = softleaf_to_pfn(pte_to_swp_entry(pteval));
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2368,7 +2368,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			pfn = softleaf_to_pfn(pte_to_swp_entry(pteval));
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2453,8 +2453,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				folio_mark_dirty(folio);
 			writable = pte_write(pteval);
 		} else {
+			const softleaf_t entry = softleaf_from_pte(pteval);
+
 			pte_clear(mm, address, pvmw.pte);
-			writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
+
+			writable = softleaf_is_device_private_write(entry);
 		}
 
 		VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
-- 
2.51.0


