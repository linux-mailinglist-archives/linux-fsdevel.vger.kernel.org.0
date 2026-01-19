Return-Path: <linux-fsdevel+bounces-74453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216BD3AE59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FBE4317240A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556A3933FD;
	Mon, 19 Jan 2026 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I8qnO3Pt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HzNmhxzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837D38B9A3;
	Mon, 19 Jan 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834436; cv=fail; b=ViQfXCFTFXyLKJvg7unJ+hnx32kTMiiyLU+4DYSldvvp1Yql4IDZNlMqKlww1+Ne2WY4v2kLed/ZuoA7AyIv7z+JrT54+QDEvI0JwdXoRNpOcT/3CCtEfofQMXtNe+5BjFASbVZtGM46Pdz/PPxOKQnqcHKKcUUoXPDwfK4TEGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834436; c=relaxed/simple;
	bh=i+1OIHjHYHYP2xCqJtcwprAtAv/0DF2ybAUtslNlMLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euQ8en392miMDj4C28967gRVl8VPsz8uuoKZE+KtS7Vy8wLOxChhI0ss4QFfWvOVFiylEJ+BVIeFLQbJa34/2BFxZHd3YhS01xuJl0KafZ6p4kBVxQSMHs8WztuzNelB6AjDi0wzacxR8lbaf6R2iVEQYQu2iHoucGonhDmO6RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I8qnO3Pt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HzNmhxzM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDQMg1269395;
	Mon, 19 Jan 2026 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G0Ed+CmGiK+xS47vCU8yKMPhVcDzm/k76MjEK9Jo+GM=; b=
	I8qnO3Ptxq9D880ywM4Ce9dWr8x7ffryIYZCP1yH6Kkbi81Y3K/PerPRi2MEVPaA
	YxcRg5uSVDXX2OVCnwUvusxy1b2ONGidcF6yJnjMdF1YbLj+E7GLn53l+5Y+2den
	d7CDySCrahaQ6cqNJ6pfisSj3vUp/ZU0u2n+Te3lRatr7i9YBEFL4NxtvYDySFfS
	8WvsSA3Er6aoF/Btaw0Ns+ROQyJf0kayFjj1tKW7rjZyfMVMKqcn+/TuLB5/KW8A
	6K4WbpLy73wLUjj1dYRAXtPqPQJs/2VyQgRl3pMj8fer670nNX9euSCzDqD7SbiO
	NJIc65vJp2z/x8Prg8WqeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8ad3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDoPlT022610;
	Mon, 19 Jan 2026 14:51:55 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vc7wj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvzj1NEPk4MTP0T+s/xYjMyeNcGXia+wbvJa5Mhmbo9BGxMpnlfyjxAmsZI8il4xwWwl2NJa9rQ6UYIDy3lgnbhoKNMdya1+/1l9Nj7QCQywBp6m8ojl84M7D6LSzc/JStTztw0bMr5DXnUKUEGhgx8xXlvtNK7ZI/2slbro93gly/OOvirFUVFqxH9YbEs7CXGdo5KULQUFN9OD636M1iMzkX7wD6QztxHFcZAn1ue2KK3mBx9ca/fG6sDkyyg+cX8UdrlSuVU/3FTA6PBiRfYGBamTZ8hAa3RfhyUkn4Q46E4lPXaV05PXOWlVCbfJZEV3dIvb/BZLhodP5b7H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0Ed+CmGiK+xS47vCU8yKMPhVcDzm/k76MjEK9Jo+GM=;
 b=HMPf7Cp8a+MdAfro9NgoyUixTMrWVHLS29IxGynksco/i2PBK1RVdGdTxYwoPrMne7yv5l4Nno++DWjSJ93cClu0hSKzGDRqlgkzUzw/1V5q6g+8aTkqUxG26gfd2rPaSOFkf13q0xC3IwoGkizudTVVcypbvKPhxc37C/ULt12oveHrFyA7suYQfxbqSmJb3OJPSnDZt9m1YDY47z2IUeteBJbYR8Ve8JvUTVFMcSuTog6NbkBqN5LB7Ijb9RIjC8+WKlNWqj14SZAE1eNW3A5Wiocf9NqiSY4Kl0Q7/ouuf7RquHeuzW+JdtNwvNLwkDZqjMdnxRPo4Ud7xn1rsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0Ed+CmGiK+xS47vCU8yKMPhVcDzm/k76MjEK9Jo+GM=;
 b=HzNmhxzM42yB2v4ksW74D1LgG0ezY0A/KkNZiPUSwVERxSSsunooG6AXxHD5eee6xWW+iNbxh7TgWg48EjmbIRGr0Z4ogIFsR+Acf8apMYlmqjknWQDzvdeaQpj9zuAR8OaOTviC53gulkPp2BBUYaSTRXJ5I5bi4wBo5O0IPC8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:51:50 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 08/12] mm: update all remaining mmap_prepare users to use vma_flags_t
Date: Mon, 19 Jan 2026 14:48:59 +0000
Message-ID: <f4f9bc314c27e8187cb83667b7fd88634f3c27ba.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce291d6-0a2e-4209-8f17-08de576a4709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4gGqHsLqJdfbWQGthL6xmrFv1MyKo4cRKaJRbnkEJjbAIBLPBKSGlVFRnKcF?=
 =?us-ascii?Q?A4Q+tlQUcNauD4FNKMmEKPFnKb5EtTkYz+l3XUt/4hjF/hC0b4nCdIvVACtB?=
 =?us-ascii?Q?1/iPLrmihMMItMkChhjQ3iZ26zM/PteNzhbg1oJ1s8WsyRIc05X8Q34XnyRJ?=
 =?us-ascii?Q?Ekx8kuERfDSGGa6yfqW9rJBx5TfcUXYLPcddbZMdGWFmtw20pO5nYY6Yl+of?=
 =?us-ascii?Q?Sne4kvzxjmHS1Sgt4UMjWrt0gB+uc6dTF9eufeW766pFoZUVqadZgWvlGn8/?=
 =?us-ascii?Q?mPWXR7NKHnBZekee2qG3dxYbUHIXsrX38VuJGxLyZRI1fI2853HPs51bYZjR?=
 =?us-ascii?Q?n+kWxzIqO+8TGLNG81M1cMZP+JQSThNpMkqrfAOoqtD4w8lOUJFIScDPlK6E?=
 =?us-ascii?Q?Yv0giMa/A9lu32PFD2uA9n0vGy1e/taLQcaikMIHNXewhghucPKXYlKKxcll?=
 =?us-ascii?Q?fvwiyWxjbhfdspcp3bOS7nOMitDCsAkc0ko2lRkRZSHG896QDfALgZNsYHW0?=
 =?us-ascii?Q?pul7ejN1qNcj+NGReHlmU/h72yhRfhcSW+SfGkviY3W9uxSLg9VyZm3fh1Bm?=
 =?us-ascii?Q?fAHtaak7x0Ygt5wHkuXcZ5q3cil6SGM30ZBQEEg058k0RmQuWak6ca1njM34?=
 =?us-ascii?Q?sAxkzpy9nbkFkb/a7UW0DAJqemFlI9Kj2uOPGEZk9UUp7aVPpmLy+xlICS9+?=
 =?us-ascii?Q?vCxbjLLuU6fCW6TkQAiOMHYohVKNRNREoUgJo6VqYGFaIkxkPsVm/QL+RZI+?=
 =?us-ascii?Q?883sXlxJ4/h15/00KwIAbEkDVhW0Q540fsfmsqid2qqfPg0fx6ruk3dMHqtO?=
 =?us-ascii?Q?rUppdjHSHo10ZmHEYJHuBFfmtcEoxGR0P/LO65237oLdBZjHcUE0RO31VMJ6?=
 =?us-ascii?Q?jxM7QlAkFIkP9pE3qn1/1JPgT1RlUgilHi9om9UAC1ZRJNBXjsf0+Rsw2Nnv?=
 =?us-ascii?Q?8+8F1qZPqcMF8HrjYIDm5UygZAn3lnmB648S3CThtGxKyp9LOTzxWtjfyA4N?=
 =?us-ascii?Q?KYYmsFZAto6JndKjXZbgFe3nUrxmJYOJ/bBYufXvRCOA+J0fE51RXq9amhgm?=
 =?us-ascii?Q?yHrMy3bgAw4OHe/klYAItR/Kx6bvYylG2zO18DlndTB+ub3lLleGAvfq5+US?=
 =?us-ascii?Q?Lv0lh/hS0Tc1jn36z8gDAWpHAwUwxi396r1CtaE/t0TriRg/X8Y7cohBcGr2?=
 =?us-ascii?Q?6KaYpdxIpbOU3IkaeoowyCakUh1OBGNDHlKFKcOdWoXc6Cz4WwoHswWmueBs?=
 =?us-ascii?Q?YYppxuy5h+Ucmdvjsuy6abEHjLujweNz33HoVAVNj/PV08tejGEWNPMs5FlW?=
 =?us-ascii?Q?lUjTvnrMKFarcirid5xGmwHmHNl7O959aZTmojzvLBxn9Qm5uGQ/x2yIlhyU?=
 =?us-ascii?Q?IlAjfErD+g73QlxWKdl0d8D977zNOpnf3iXHcClq7K8ohFnpnjjcvm75d3GT?=
 =?us-ascii?Q?FmfwFUv52SHcCUg8fG+0X/elY9ZPVNuuWTsvap/47j6TiW6ILQ9ceu24bFQx?=
 =?us-ascii?Q?+k8GLu4JOzoI3Z/LEic8D6+9tvrGI1nIS4g/KNALDcnnb6ZEM5XrwuonCQgH?=
 =?us-ascii?Q?roUmM09+hC2H+Jv3f94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YNwxy8yizeXVVWPhMvrw2Atv7LpXmS5IlNJhYxriJHalt53badkcittZ9Zn?=
 =?us-ascii?Q?b8f8Z9AxVPUQPV1Z5zP4eD9+CqmcM9g7nD0kqPrPtoTmfCjebqDJimdBeZdr?=
 =?us-ascii?Q?6pjnjd1R+tbnKAEP/AIn1Eqa9Tw4+La/qaHoq4HJBPiedCHttWo1vauLGNB8?=
 =?us-ascii?Q?x6HFQPU97iLmON9zWXNgEIli840LCcLZiINepHfCbtlKbMxExTP9F8FMBXA4?=
 =?us-ascii?Q?gEAFBsIpGfCSZIpoUUsAmXIx96u4et20wobxQiTypkieNNcBJRtXvI5Cgzfi?=
 =?us-ascii?Q?drUCmq0KomdN5c/khLXPWs798MAN2e8vi7rAhWi01Dpc+0itKAkdJj/y3SmF?=
 =?us-ascii?Q?V5XUemmprL9Xe3a8aFzCkBl/ebipJII2I3Shw0uuTczH9F54D5CgK8ul8cQK?=
 =?us-ascii?Q?PTcnLmx6wt2164I3AauoApFn/hNZvkEVXUAq2khEES0e/70jbE1QAsd3toNx?=
 =?us-ascii?Q?uXG1vbNYCC/SOnO5HbSKq5bX5Vv8Qhvz66qETylDeYd/lDjp7cCf0Nh11Itz?=
 =?us-ascii?Q?bh1kcIz5ZZDTEqV77LiuDdFnaxlb8s6TNujOtxOsq8O/+WYiYyKIeKLIzl4s?=
 =?us-ascii?Q?vkkbcDhP8kcGto7bPecBgvmM3dX7zzOaGxNUZeRi6xo9/1rcq/VPPRxiGZAd?=
 =?us-ascii?Q?EHgiPYeDpUtJsyQ65+KXNXNFo705c62AO/IsRc/DAwwuqAU1l4RejNbHGgzp?=
 =?us-ascii?Q?GWCVQKl9vwMaSF21AJ1fRTyAW7Y8FdPv1wY1B4r0EDf4WXPqvH3Ko1uaUL2a?=
 =?us-ascii?Q?ku8VFpuh3kc0KEWfv66gFsLTfElAi0G+qeC6qMTI0tggiU2V7p3LxpPY2dcT?=
 =?us-ascii?Q?uvqpluTKkCiH8bWwBDb+S/1CjyDd5oWKBVmwrmpUg5OxM2rqZN1zlKWXj53e?=
 =?us-ascii?Q?36eqlqjCrQp09yU8gNaA8TIRZF8WBzcw1UgUC7zuJpBJb2zF/6C26b7ekLcM?=
 =?us-ascii?Q?gB/RAy40BwVdIwyndSCQfQAO644tDWc8W1qk1tNb1skMyganIVLqzWJ81m8Y?=
 =?us-ascii?Q?vWD2Ux8jONDMhJ/jc348DHTeiMSi5jcfCAZ9W66PQ2jWnU/5nxE35J9CbGpw?=
 =?us-ascii?Q?50w0wStIZnEXMkr3tAEq7PQv8H8Fqf9RwFh61ov9lbhIWVJr5PnaXq/m6HVb?=
 =?us-ascii?Q?dyjqHZXZcVe4zxTCT/Uas9WKMj8yM9eJl6jE1zQQ34KeVFUEnR2Kv+hfob9d?=
 =?us-ascii?Q?tuulZTk4ge64D6f0YCmskkCwyHnp5MHBeayDTFBnCJW88UDPQ+Y49DSNt+hG?=
 =?us-ascii?Q?SaUCGIBi4v3ur2/XXEayAkaivjyvYeXFRysQPrA+U1x7h4fNEXjS9Ub9Lp68?=
 =?us-ascii?Q?ooY8GC+51SgY+7JrPIYFe8Nl7KehdCpWAJ/nzSS3RgkI8w4aTmmWHTQh8t0j?=
 =?us-ascii?Q?TRNSi5dfxwu9m4ZOxYVV0uswBa5M6Ht7VOiqOuJ5SdB6KElv/eOzkzCQNTQw?=
 =?us-ascii?Q?r9uIARhYvda4NCrHQ6pIRJV403p4O7x7iE4qUIurE5DV91Xr1Jqulmym2h2l?=
 =?us-ascii?Q?B6KS5sYCbqWm13fCs4NxKFkhXUDdqyZuR2p+JAHyFjce3JWrpxZD6VbjPg/t?=
 =?us-ascii?Q?R3nTThrM1UesVolI/RgeeW0mvRxwjhMe84YTZOriSMtsrPZB5GJf3yzH6U6J?=
 =?us-ascii?Q?q+GnI1hqRQp0WXdWpbs1rFpAGwFrjq5wk7kIFyiRKv9sByQ6e6etlBFz52eN?=
 =?us-ascii?Q?e72r0NqxEcBMQnE4GqSHM0+BTouIHgc7N+NDxMmELk3gQmCzFLyEODZ5a3nb?=
 =?us-ascii?Q?K7GkMUPAkBpwH4tKXSUwHix6Y/TgxjA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GXCRdFcVyptyovQvS/dXRpgpYOqQQD1yak8DhjzDYo4UuoK1KxLD2XKDHrQXHYsm+7OOcBopdKiAK0dbzMyEoNj81UZjk/aIEwA9Pk5J+GyDK439/tLhDTlRBqbGUMZjAVKXBtCkYG2DLNgdTmQ3nZ6mvVYmMEfxtB9LotRgOFq3pYjb3gSrS3353V7uP4fN+C9hfB+xwea2Jy3zd34Ep3kwfQMX76aQv7eonNhvGNQpIeikBSx8jofDTmX1hI575Rbwg+xVmAsxxYFDld/ehQxaR8ft8WayAY4MdByY8tSNya/sj5nlW+hG/Ka60GrIqGcsIKHcNsmmflKPWKSQAPvW530jOXYgbXxyRd12BUZcitHEF9/99f6nskuGHhHHab69eMedJYbQ6sQiJ8RCStbef5Xbbp88akEo1+N0KAJrLS1C94IS2SyjuatbEnjPswpnMjiLpXFpwX/RHE3IV5SQJzuK/mUFmwIJ/IfhcuWQQh5jBHemdffs1T1vnnaqqfFFjciponF5ofmC/13y5VEEENuhhpn9hu0cWP3hWUOkJoecYoF7Nw0EMeR51y5RnIhSJQH/G10MjMXDVWt3HVPxggEH6TNur4s+l1janos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce291d6-0a2e-4209-8f17-08de576a4709
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:50.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQu3iOtghfRHm4h/kzk3uIMV7cf+N37KSeuawQuxTXsamvQnopfaeuR1f40ojB77B4bWg6ERVZ35ccXtdZ6FWkiyb7L+4D/pZlrguyixN/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696e450c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=M5D02GMWgbgMPnxmookA:9 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX43VvEz8g/Ibw
 KJX6f7EmFaM5DKMg6B1dtgELgrBGoZLTzT867mg9tNWX0fZIU64urETl5rfVZLz1QiCaaKVM8XZ
 DKTa3lXxzDTtveB7VUsAVmju3X3n95AKrL/VDrPN4VDOzH0hhWxhB5hxXg9qWFdjPtZ948zYl6r
 QiRMYLfZJs9ikHUXcWMhgkSF/XAxVp2X6fjbfeVmL1AZTlpxHoKZSVqDVJFe+3ar6aNfxuHtQe9
 2fNNOiEwE3vy+oI0T+M2wnw1k5zReYge9ij1sOqyBEi9osH+7YmEAKbXgmNZgOyztJepUYOI/+t
 gv700SEv4YnMOKBak0Ds2GdR0R3SzVoc21LYVyuuNxfcVaKCFLk+0E3Srp+rCYZ8LEqWecBh3uf
 ZBo+WF7DMIkkABn68V2fe4IN2mBMxycX1pTQR1qBpGJlkS5vzQ+Z1XvUMmZPwCgm9JUPY7k49k6
 WxkTC0Yrdk7F8Lo6CAT2UYz+gBelyte605TE9B/M=
X-Proofpoint-ORIG-GUID: g-siaPHx9-GyDxrpHgJljSDTyjnwp_nq
X-Proofpoint-GUID: g-siaPHx9-GyDxrpHgJljSDTyjnwp_nq

We will be shortly removing the vm_flags_t field from vm_area_desc so we
need to update all mmap_prepare users to only use the dessc->vma_flags
field.

This patch achieves that and makes all ancillary changes required to make
this possible.

This lays the groundwork for future work to eliminate the use of vm_flags_t
in vm_area_desc altogether and more broadly throughout the kernel.

While we're here, we take the opportunity to replace VM_REMAP_FLAGS with
VMA_REMAP_FLAGS, the vma_flags_t equivalent.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/char/mem.c       |  6 +++---
 drivers/dax/device.c     | 10 +++++-----
 fs/aio.c                 |  2 +-
 fs/erofs/data.c          |  5 +++--
 fs/ext4/file.c           |  4 ++--
 fs/ntfs3/file.c          |  2 +-
 fs/orangefs/file.c       |  4 ++--
 fs/ramfs/file-nommu.c    |  2 +-
 fs/resctrl/pseudo_lock.c |  2 +-
 fs/romfs/mmap-nommu.c    |  2 +-
 fs/xfs/xfs_file.c        |  4 ++--
 fs/zonefs/file.c         |  3 ++-
 include/linux/dax.h      |  4 ++--
 include/linux/mm.h       | 24 +++++++++++++++++++-----
 kernel/relay.c           |  2 +-
 mm/memory.c              | 17 ++++++++---------
 16 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 52039fae1594..702d9595a563 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -306,7 +306,7 @@ static unsigned zero_mmap_capabilities(struct file *file)
 /* can't do an in-place private mapping if there's no MMU */
 static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(desc->vm_flags);
+	return is_nommu_shared_vma_flags(desc->vma_flags);
 }
 #else
 
@@ -360,7 +360,7 @@ static int mmap_mem_prepare(struct vm_area_desc *desc)
 
 	desc->vm_ops = &mmap_mem_ops;
 
-	/* Remap-pfn-range will mark the range VM_IO. */
+	/* Remap-pfn-range will mark the range with the I/O flag. */
 	mmap_action_remap_full(desc, desc->pgoff);
 	/* We filter remap errors to -EAGAIN. */
 	desc->action.error_hook = mmap_filter_error;
@@ -520,7 +520,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (desc->vm_flags & VM_SHARED)
+	if (vma_desc_test_flags(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
 	desc->action.success_hook = mmap_zero_private_success;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 22999a402e02..4b2970d6bbee 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,7 +13,7 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+static int __check_vma(struct dev_dax *dev_dax, vma_flags_t flags,
 		       unsigned long start, unsigned long end, struct file *file,
 		       const char *func)
 {
@@ -24,7 +24,7 @@ static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if (!vma_flags_test(flags, VMA_MAYSHARE_BIT)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -53,7 +53,7 @@ static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		     const char *func)
 {
-	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+	return __check_vma(dev_dax, vma->flags, vma->vm_start, vma->vm_end,
 			   vma->vm_file, func);
 }
 
@@ -306,14 +306,14 @@ static int dax_mmap_prepare(struct vm_area_desc *desc)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+	rc = __check_vma(dev_dax, desc->vma_flags, desc->start, desc->end, filp,
 			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
 
 	desc->vm_ops = &dax_vm_ops;
-	desc->vm_flags |= VM_HUGEPAGE;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 
diff --git a/fs/aio.c b/fs/aio.c
index 0a23a8c0717f..59b67b8da1b2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -394,7 +394,7 @@ static const struct vm_operations_struct aio_ring_vm_ops = {
 
 static int aio_ring_mmap_prepare(struct vm_area_desc *desc)
 {
-	desc->vm_flags |= VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
 	desc->vm_ops = &aio_ring_vm_ops;
 	return 0;
 }
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb8455..e7bc29e764c6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -438,11 +438,12 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (!IS_DAX(file_inode(desc->file)))
 		return generic_file_readonly_mmap_prepare(desc);
 
-	if ((desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
+	if (vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	desc->vm_ops = &erofs_dax_vm_ops;
-	desc->vm_flags |= VM_HUGEPAGE;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 #else
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..da3c208e72d1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -822,13 +822,13 @@ static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file), dax_dev))
+	if (!daxdev_mapping_supported(desc->vma_flags, file_inode(file), dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		desc->vm_ops = &ext4_dax_vm_ops;
-		desc->vm_flags |= VM_HUGEPAGE;
+		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	} else {
 		desc->vm_ops = &ext4_file_vm_ops;
 	}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe..2902fc6d9a85 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -347,7 +347,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 from = ((u64)desc->pgoff << PAGE_SHIFT);
-	bool rw = desc->vm_flags & VM_WRITE;
+	const bool rw = vma_desc_test_flags(desc, VMA_WRITE_BIT);
 	int err;
 
 	/* Avoid any operation if inode is bad. */
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 919f99b16834..c75aa3f419b1 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -411,8 +411,8 @@ static int orangefs_file_mmap_prepare(struct vm_area_desc *desc)
 		     "orangefs_file_mmap: called on %pD\n", file);
 
 	/* set the sequential readahead hint */
-	desc->vm_flags |= VM_SEQ_READ;
-	desc->vm_flags &= ~VM_RAND_READ;
+	vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
+	vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
 
 	file_accessed(file);
 	desc->vm_ops = &orangefs_file_vm_ops;
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 77b8ca2757e0..9b955787456e 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -264,7 +264,7 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
  */
 static int ramfs_nommu_mmap_prepare(struct vm_area_desc *desc)
 {
-	if (!is_nommu_shared_mapping(desc->vm_flags))
+	if (!is_nommu_shared_vma_flags(desc->vma_flags))
 		return -ENOSYS;
 
 	file_accessed(desc->file);
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 0bfc13c5b96d..e81d71abfe54 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -1044,7 +1044,7 @@ static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!(desc->vm_flags & VM_SHARED)) {
+	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
diff --git a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
index 4b77c6dc4418..0271bd8bf676 100644
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -63,7 +63,7 @@ static unsigned long romfs_get_unmapped_area(struct file *file,
  */
 static int romfs_mmap_prepare(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(desc->vm_flags) ? 0 : -ENOSYS;
+	return is_nommu_shared_vma_flags(desc->vma_flags) ? 0 : -ENOSYS;
 }
 
 static unsigned romfs_mmap_capabilities(struct file *file)
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745af3..fabea264324a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1974,14 +1974,14 @@ xfs_file_mmap_prepare(
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file),
+	if (!daxdev_mapping_supported(desc->vma_flags, file_inode(file),
 				      target->bt_daxdev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
 	desc->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(inode))
-		desc->vm_flags |= VM_HUGEPAGE;
+		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c1e5e30e90a0..8a7161fc49e5 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -333,7 +333,8 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * ordering between msync() and page cache writeback.
 	 */
 	if (zonefs_inode_is_seq(file_inode(file)) &&
-	    (desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
+	    vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	file_accessed(file);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d624f4d9df6..162c19fe478c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -65,11 +65,11 @@ size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
-static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
+static inline bool daxdev_mapping_supported(vma_flags_t flags,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	if (!(vm_flags & VM_SYNC))
+	if (!vma_flags_test(flags, VMA_SYNC_BIT))
 		return true;
 	if (!IS_DAX(inode))
 		return false;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ea7c210dc684..09e8e3be9a17 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -550,17 +550,18 @@ enum {
 /*
  * Physically remapped pages are special. Tell the
  * rest of the world about it:
- *   VM_IO tells people not to look at these pages
+ *   IO tells people not to look at these pages
  *	(accesses can have side effects).
- *   VM_PFNMAP tells the core MM that the base pages are just
+ *   PFNMAP tells the core MM that the base pages are just
  *	raw PFN mappings, and do not have a "struct page" associated
  *	with them.
- *   VM_DONTEXPAND
+ *   DONTEXPAND
  *      Disable vma merging and expanding with mremap().
- *   VM_DONTDUMP
+ *   DONTDUMP
  *      Omit vma from core dump, even when VM_IO turned off.
  */
-#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
+#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,	\
+				     VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)
 
 /* This mask prevents VMA from being scanned with khugepaged */
 #define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
@@ -1928,6 +1929,14 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 }
 
+static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
+{
+	const vma_flags_t flags = desc->vma_flags;
+
+	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test(flags, VMA_SHARED_BIT);
+}
+
 #ifndef CONFIG_MMU
 static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 {
@@ -1941,6 +1950,11 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 	 */
 	return flags & (VM_MAYSHARE | VM_MAYOVERLAY);
 }
+
+static inline bool is_nommu_shared_vma_flags(vma_flags_t flags)
+{
+	return vma_flags_test(flags, VMA_MAYSHARE_BIT, VMA_MAYOVERLAY_BIT);
+}
 #endif
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
diff --git a/kernel/relay.c b/kernel/relay.c
index e36f6b926f7f..1c8e88259df0 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -92,7 +92,7 @@ static int relay_mmap_prepare_buf(struct rchan_buf *buf,
 		return -EINVAL;
 
 	desc->vm_ops = &relay_file_mmap_ops;
-	desc->vm_flags |= VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
 	desc->private_data = buf;
 
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 76e7ee96ddad..d803e0fcefe3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2886,7 +2886,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
+static int get_remap_pgoff(bool is_cow, unsigned long addr,
 		unsigned long end, unsigned long vm_start, unsigned long vm_end,
 		unsigned long pfn, pgoff_t *vm_pgoff_p)
 {
@@ -2896,7 +2896,7 @@ static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
 	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
 	 * See vm_normal_page() for details.
 	 */
-	if (is_cow_mapping(vm_flags)) {
+	if (is_cow) {
 		if (addr != vm_start || end != vm_end)
 			return -EINVAL;
 		*vm_pgoff_p = pfn;
@@ -2917,7 +2917,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
+	VM_WARN_ON_ONCE(!vma_test_all_flags_mask(vma, VMA_REMAP_FLAGS));
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -3041,9 +3041,9 @@ void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
 	 * check it again on complete and will fail there if specified addr is
 	 * invalid.
 	 */
-	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+	get_remap_pgoff(vma_desc_is_cow_mapping(desc), desc->start, desc->end,
 			desc->start, desc->end, pfn, &desc->pgoff);
-	desc->vm_flags |= VM_REMAP_FLAGS;
+	vma_desc_set_flags_mask(desc, VMA_REMAP_FLAGS);
 }
 
 static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long addr,
@@ -3052,13 +3052,12 @@ static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long
 	unsigned long end = addr + PAGE_ALIGN(size);
 	int err;
 
-	err = get_remap_pgoff(vma->vm_flags, addr, end,
-			      vma->vm_start, vma->vm_end,
-			      pfn, &vma->vm_pgoff);
+	err = get_remap_pgoff(is_cow_mapping(vma->vm_flags), addr, end,
+			      vma->vm_start, vma->vm_end, pfn, &vma->vm_pgoff);
 	if (err)
 		return err;
 
-	vm_flags_set(vma, VM_REMAP_FLAGS);
+	vma_set_flags_mask(vma, VMA_REMAP_FLAGS);
 	return 0;
 }
 
-- 
2.52.0


