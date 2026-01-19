Return-Path: <linux-fsdevel+bounces-74552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 887B1D3B9ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DE631372E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127330149F;
	Mon, 19 Jan 2026 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLxQF1Td";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nUc1JA++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F92FC007;
	Mon, 19 Jan 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857696; cv=fail; b=k/Np+ohUTvhM0K7PeYtucf3tPkNEVlT01JB3WkvanHyYmlVQPi38TqPZstQpJITukxr6gU/0PM2WSdkSGS0QMCGCDf5QcaI1G689BUgThbD9r8ey/BTfS6dXhcjEg7MPaYgsLchD+T1fqbHsxZKNumvs7kuQ/lnrWVFyIwYHSrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857696; c=relaxed/simple;
	bh=XufUbT+FH1sWijK9GAXGXvXs6kPNh87UHysFg8e66uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rkv8bQMt+9PahmNvujFR7Qyt1rydPsjUID4nrDE6VNwGoPYxVYOr+ejAY3ABDS+JMbKgBJWzXBCrQe65+KtKgw5aFuUxUU7+XlHDT584+Aun0GS7fTXA0WDyeeIyUuE4KmZxuQF3j+gM6a3KGlbkiqxfXiB1pj790xXhRfyonHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HLxQF1Td; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nUc1JA++; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBD7WI2082947;
	Mon, 19 Jan 2026 21:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=N4cQnFLQTAhydXdZcYa0du+ch0OMVStry8z7ijuKaxY=; b=
	HLxQF1TdO7qPy2YEQ0zsbqazFItS02NX/X7SNxkdZIffRcsAdhWfV4JbR93+L1kH
	4EOQc3mZMik8xCDq+xfsaVeV/v7/Og74ARow9J+ENm8BztmmpQH83YTdpV2nXcnJ
	3bpOL3/TYc8ze5sxQ0w6oqu91aX26qY5H8e7OqHabvZfAhqoUUtzs8JokP8MpiCQ
	b6CLiC9G0s4/dlT9LhZGWH6892b5WL+nmF/Upd/9KCQy3LYSL4l6OLik+id95/mR
	gq7po9V218lJzIe1fAVWz0ia+oDRqiX8RSwnowgpfVUEEMOJruG5XVeeGU1A/WX2
	GMC98gFjGjJqsPKVkDVJLg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa2sxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JKV84G022439;
	Mon, 19 Jan 2026 21:19:39 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcht17-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8m8d/pbNV34SI9+w39D/5AjLstUbr+045zsxziPqs/rzTubsKOeK1ptvw+rXpZ9AG+GRMWmDIYzZ32ONflw00xHZImTeBTwfB35vB1PsoE0OFtAMfu2nNBMnAb7OUvm0we7LJziGQhUMoI2i8nn4PbiTk8sx2n/aufM2lCFoYDwfwptPTYfE5GzKtcGhhLDFePCXzo84B1qtfEVf4YWvfPpBTZbDPOT/SA+xh0O0/V4IT/ZbyrNiKxj4byFnqzoD/NzkWuBQpWXpNIFeTN2Y6xGFEedFTx/g2iqmSPDqVsAiiuq3vL59ztfqy+cJaOUBJWhAw36wFfaMPx6JaL4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4cQnFLQTAhydXdZcYa0du+ch0OMVStry8z7ijuKaxY=;
 b=yl/SX3j2JN8Dx7p0SOvkk6uKn7vJ0qtXydCr7zE+VeKPdIw3GY3O+jyT7kT8vo63MaG/B3Ct+mL7SlRMZ+Qn/l8VLAwmH3XbsQhwZA+RWzGYoTPWYJtgb2kMWbew9E6Sjy8APrACZgSm6Nj39+5m2p6aefx+TPcbhjUOJikvNdBCdSq/al5Phy6kuX1xn/fnGj/Obx87ODWM1aWHT0W3XFKZvljWqPCNgRxl9ttSkMlnOSFTAOd7fcS0ccOaopoOjlwPm6sgIqbGTYYFzYGlwK9Cp3Nsf4Iq9V0UHcqYMP798sxNysnrUsR69qITcGDEXOHhF69O9Xgx1FFyaH5ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4cQnFLQTAhydXdZcYa0du+ch0OMVStry8z7ijuKaxY=;
 b=nUc1JA++Dm+95BdDPihlzVEzf/myP/m/km3qgG+JHKopSgjogoAr1Nm6LeKF69DHXLhyMARJiKFa2dvYtud1pQhl53I2nh0LpKdmd2z9sUXjbxqZ29327PNdczToBqeIOfM4G976mpOgqe6LtLp6TC/ZDfQFtdg1pfp1EmmsUIE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:35 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:35 +0000
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
Subject: [PATCH RESEND 06/12] mm: update secretmem to use VMA flags on mmap_prepare
Date: Mon, 19 Jan 2026 21:19:08 +0000
Message-ID: <cd20679ad5618fff3f8bd1b2f28601f9107e91d5.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0591.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ccf21a-49cf-44e3-dddf-08de57a0720a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QOB05Il8uiKsLrcWtMZpmRaoTGOq15IrwPxntwCgScsbHMNw6YS/4Ilv7TYR?=
 =?us-ascii?Q?el1zJrWL4xsWTffQNwtr6tCYXl/+TUqrtncpsKbcTGlH8aEDbivfXwDH2f54?=
 =?us-ascii?Q?Ld9XfnY1x48rlNC0fGueAT/ugegaPIgZi2/ZkVv+N/JJaI4NZtJEnS96OwvB?=
 =?us-ascii?Q?W0679dn1F7XDRNjawD5jFsEYhGDFgoYKWglipkvnwfhJTjhXCB8ch4A/2Yhm?=
 =?us-ascii?Q?2FJ9r7pm8yz85FEvzomQC+BRaLdD9qNgmH1Om9ZWvTiZ3fBtmDS8rfb9GkF7?=
 =?us-ascii?Q?1VXuMrayY27pMQgzT6NlrdIZdW2IKSMhx+pSuOozQqoOCXVm7sQu/yjJsfdp?=
 =?us-ascii?Q?EaZgOfRiGryKayKnTa6giIxGU+dCkRK2zV1Jezl1dyx0TyaR3UdvofRBxCiu?=
 =?us-ascii?Q?FOBmi9ZrWsWzdIC9oPOJqUtv+4ZVlOdN4Dnr9viRuojoPM/wZWhnnuGh9A+I?=
 =?us-ascii?Q?eSrqzAVOdmTfXlMt99VXAnG8oiqfk7Uayconezh95p3CvXuyQzDalr9m5BCw?=
 =?us-ascii?Q?9Nm6pGpIeamEwnBvh0uc2yeNDAsN2x36HRGm6XY/wCXEZvtR05j/+zQ1CEDY?=
 =?us-ascii?Q?6V60MSFqsZK13rO5noUWhKSbtJMtIPXw7oi0JDXlHERmlYSoe2X0EXIvwlN3?=
 =?us-ascii?Q?RzLf4FD4fLwYIlpxlz5joZh/s4BwW7mpMGwzF5bwdkD5lxPJdYrpm2b8n4Gg?=
 =?us-ascii?Q?p4lRgE4EIGWzjb6YVCvrirNBxF6ZL9rHe5S5WSLNfKafdt+KUtVJWTgs6xpN?=
 =?us-ascii?Q?Q06O9uvk7REh0x1G0vHDIXvbxaimri/Eowm8ZIZHvJBxUrki7VNjYKvcgDUv?=
 =?us-ascii?Q?3a0OSKQaXbvGPOXeaMgXBEBn+XOqc8Wg+kvtO0J64Fz7c0KmuAVJ7xHCQLuo?=
 =?us-ascii?Q?kof9RuiB9/QGQcuDSvg//ma7AtMksQ7hwCHQtN2Y+VesUpUIcE8E9TpOO9gQ?=
 =?us-ascii?Q?YGN91ekQXd2jM0wPobzaxblJn0I7VRm16Oz1GzS2/gLlZUmYyQGS3ddX4Tmq?=
 =?us-ascii?Q?YceGGGrBsc3TcKRzjAmpcwRkYYF1H4O0DIGMPOivc+rOP14LsvHO84cfnsd7?=
 =?us-ascii?Q?aZWnj22sVliCk9hB4Ex6WIqm5r/Ej+VO9y05G9WwmzZYEnd8/ZNbXh7M4dxi?=
 =?us-ascii?Q?SwaTRrPJAOY4zVWa8aBJU5Wj8LjsTaYVIuwLaOUOj2LIhPwry4mdQE2m1AXM?=
 =?us-ascii?Q?sbOWzw+ZJJu76vlNtMeFfRY3DHRLNtKZuhtNit9I8YoxFgaKq5oWxRdnRzSH?=
 =?us-ascii?Q?KupY4HaEcBd1Iviu/w2K+owMCFlkiq9eH1dLoQEViQ7x1scSyoWSvOY7XJxD?=
 =?us-ascii?Q?ikLYo/zwaPs2nd9CRGn5/c2YNhEpiSd+FKCaGQTYA5DkhAKJvP94QQNt1E7P?=
 =?us-ascii?Q?IChLyaNgGivARB2UmkXVh/2Rec0lR+Vr1ikPzUB8x/qK6K9LySeOrgSs446L?=
 =?us-ascii?Q?F1vpre3l93kEllJCcM2MHBXHmpxNtoWhSWnafMK7yvz0nXMF5wf4WfTb1yVf?=
 =?us-ascii?Q?DLS12x7pSWTrVlODmLs/QmbRu3k35I4mO54Xt5aiPdsVivoiWbw/unlFqBWR?=
 =?us-ascii?Q?Lbvs0ogngBx9KosuZEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWbFrsUqSUz1ML1DmKdx8ZFUnO1d4x2OIaxRBFDDQxoBguyKYDKktVh+7YR6?=
 =?us-ascii?Q?DpSLC+m7/R5Z3tip1JFyiCniXUoaHlSbhzCxpWjAw/EJLCxJbEzXf3MXYm/T?=
 =?us-ascii?Q?xBz7oU7t4eQ0rbdh5QqCk+PIILIZl3ePJcJI67F8EPxlNOjdvTZ536seGWoh?=
 =?us-ascii?Q?UIGte3IzOVgSveBlYDol4lu7CjM78a5vlaz8geq8dndNM5r/AKbij9GaAv+4?=
 =?us-ascii?Q?Jnv5s/AC67MKs/Vcitw9+n6HwU8V52rck/bvZoR7vkMIe3r85Z0Wt4wSa5wI?=
 =?us-ascii?Q?4ZvOlV00GpNf4eQcgeQKNUT0BZTZi4WJudR/xunN+ytZ4H9Km2E7jD3OhQly?=
 =?us-ascii?Q?Fx9nv2SHnyiyfarqLpTqUCNc7GEYWVwUc+E+mSXBdtCGWaV4VeRJJp90tqG0?=
 =?us-ascii?Q?x7jbIRj/KOyHSJA5tDR3jd9OjzdXX4sQuGrl9Pqn+sxWDArb8iGUCG6E8t/5?=
 =?us-ascii?Q?d1B6i3dkI1q74W2gIv8oMFSOOfLiMkLMKJpP/A5CEyPt/0O/mgOEZ2SMZHFA?=
 =?us-ascii?Q?1HsG0bIwd90qJZ9jutgQ7ZWJ4LQDU72gQA7klc6hJ5pzBDaBbvmHxcVueuJy?=
 =?us-ascii?Q?UUoYYxjmkGGdYzkXxZRF5e/GLFex8ePoMsZexX6Vs7Zr4+tt9cUnuNlEkBLp?=
 =?us-ascii?Q?n+HDCx2c67d00BsjZS0MxumtqDTvtcPUBvGheElpinoQGSl7NCsCR/ck2fXR?=
 =?us-ascii?Q?UaBl1h4jsYDW84R14sGsKq3dUgt8julApBtczOb7avzfqQrA2S42+zYHc/XV?=
 =?us-ascii?Q?EdAYkyDTc2lVxzQW4Cy/8BFFLpWSImhDSA+BmV/crIRQX1W0N1aNZ36xodhF?=
 =?us-ascii?Q?ZapkmTiubTvWncPsBH2/IPLcnqf6RO49sk6v4G1Mi4t+zgz+s6v90Ed5q2DA?=
 =?us-ascii?Q?MMmNezH1yVT2pkdxq4G0jyN/O06E1Bc5DaJQ0nyiknJ3UitU/uKUpG8TDVOV?=
 =?us-ascii?Q?PcAUiJte6vAU+29eMTqiC+j/iKbkbgMpwKVw/2nWwSJAKuTNo9by/oWuJpVt?=
 =?us-ascii?Q?ZdapUFoMrhARHAc1n6k2B1Xh1RB3jua8oH0BqmwIMBEDamvkxbey23c4tMEi?=
 =?us-ascii?Q?TDESFHo8dzE3r3eXADoUC6n415s6SkRTcPncl8V+QHjVgq7F55Ux2xT5Hbnw?=
 =?us-ascii?Q?8fmnj0WKkJJV+KTVeWDanCBRnW/2PxYP1uhqNOQt2avAbG4XcdjzbqC3sOIK?=
 =?us-ascii?Q?O8NxcIJrx1QJnN1OQ+C5fTjeS7BAWlfsdvRNxP4dDcMseHV+9G+G8wAyn0g9?=
 =?us-ascii?Q?5Bd1Nm60t8X4vU0NtdP9mjUtJGqEBR6nRed5SKIcs+RGmobXmwoZ7o6G+tAY?=
 =?us-ascii?Q?rsIAjCZaGDKxAk9PXnZeEnn7MBLyGkn+OfdankuHbi/Ln4TDryYTfJ/6p5pc?=
 =?us-ascii?Q?dHE2rajNSFHUm4HGd6xuUA8sBgWLziwuq9oqg2P9Nd7pqIk0LLREinj0mxXP?=
 =?us-ascii?Q?Nv/vEeWcRFuQyxaOFkYlgygcVGp8s6BDdotwPvEMHa9ce+TfYspqlxtnJiNu?=
 =?us-ascii?Q?tJf6HVZVGT7DhV+xE73cqj3CBohIufvNSjh7mIrDURLI1iFRtIHjYY5+7seW?=
 =?us-ascii?Q?UBdaEoh8c70Mjs42QVNz9D0fQDsTFMMYRsKw+NTyM2GTirpLSu0UROcQBJVy?=
 =?us-ascii?Q?MOdt93Jbme70j5nCikSBDbco1xBEScEEMCALL5kfvUS62cv/+XUzVWiueBT5?=
 =?us-ascii?Q?dK+6CdV1BoNTdZi15TexczGtSQTdU/Z5eLU5CP5hKOTpVSoj+cmW7dwU4chp?=
 =?us-ascii?Q?nVL93LL3S3zoJFsjx8SF40y00CTLHok=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RTLCWjVhbiJ/HtapdBsfFMBgyJtnQ13Jm/Qf2NWgnm+JKHUNJA5t6BK1Pvdc+HEADweoJwWlWwGYNgDLdq0t0Jg4iUQf1ziPRP9gC4m4k2tPOaa87S8PoDVRVeeZbgDfX2dZAGBPVmq9B4cKXncFvBsoNjm8RKCUlM7d3effDS5/9v8Wgljeaw5I9TgdoVJcy4meR9pMTrrNxWJx3zjG0LtR6XAtkpfIlB5zAlPLZPPlBXP8Qa7r7yneJ5YQmmtED6NMxzGpSak5/YWY/KCtxVSH8ytcWzi1cj3C5lYszXhrsukzUCDJir02hUgEzP6k3xybjzidJrdtdzTVO+PausYtk9tXJanfZRp/XyHFtZHyeogL+gsAr6rcR9sjITZusavaj8hBSVE4ThVYssTLV0fQG/7W/9JwzfIX19U3rhRN+wPJkq9V7Y7HySJ6RymmqP6BMOMzPg4WFUTZdMlkCekvfBTvtXYFEJTEOXRtizRNAk77H86I0o95oEiZQF09NR3768a1u5VGZWz0Z1FK64z2ZlVnAEF2QRlnwcA0S3PzY6NnMTa1fU3B9IyDzcqlIi0ZnXUiN6lwjGJteN5QeKH8zWGQqsQ7epV12x0wKf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ccf21a-49cf-44e3-dddf-08de57a0720a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:35.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL2ezAmANipdrKtVwVeU9Vd7tZJrLFGv5SceDg3VyCTK4N1ny7H3cRiGo3XmBWL8gylERArwdO3QDqw1S5TBoqaaEbLgB0xulM5WA2+rgwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX7dWMowqckBx7
 Q/42dVHGy+NNvwWlF4L+ij+gvmq0eeuQg832JEi8Daw2qTaiP8gDl55cQc6X+Ct8f1pQtPX4jLy
 3eQkcqO+Z4aLyWx6e1kv0merR9Oh0OnJt+ppRCH/fzhHHVs8pcOh1K52OkPwPytlUlxtUhwA5yH
 R9E6uyHtGrYaAaRSRgmnnJ+qwN0ue5KTQVVceAis7dp9RmnyTnCIxVAct/5f1BVWSP1jO9DSlA/
 Lz/BWWHC/J0Yw7NTcCrFYuanvqUbv5DFBon+fiI2GXF7/V+/flFkR1LxTa7yozCaYWQ1mzt0wfI
 WMp8A1yW52BU4U3oJ97o2LBWrFC7u1z9oxI335c7G7Q5Nh1Iyye+qgx/xlIkU+Y2PuuJACLxzQh
 r1DO2YzkzATrj/q+PMWVJBdXOL+ycr1O9wYlxg6k3DcdK8N6CqSypdGWiYS07I7eNyLEuIs6tHv
 NaWHJrbQekJzWcam43qH9hRpmkLZPazS9rCG4Yjw=
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696e9fec b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1EN7IFrRoGoyj_JuQOoA:9 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: RvBeNGmJe1BwuPPiZui3viq5D8Xdlzmr
X-Proofpoint-GUID: RvBeNGmJe1BwuPPiZui3viq5D8Xdlzmr

This patch updates secretmem to use the new vma_flags_t type which will
soon supersede vm_flags_t altogether.

In order to make this change we also have to update mlock_future_ok(), we
replace the vm_flags_t parameter with a simple boolean is_vma_locked one,
which also simplifies the invocation here.

This is laying the groundwork for eliminating the vm_flags_t in
vm_area_desc and more broadly throughout the kernel.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h  | 2 +-
 mm/mmap.c      | 8 ++++----
 mm/mremap.c    | 2 +-
 mm/secretmem.c | 7 +++----
 mm/vma.c       | 2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9508dbaf47cd..ce63224daddb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1046,7 +1046,7 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, bool write, int *locked);
-bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
+bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
 		unsigned long bytes);

 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 038ff5f09df0..354479c95896 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -225,12 +225,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }

-bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
-			unsigned long bytes)
+bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
+		     unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;

-	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+	if (!is_vma_locked || capable(CAP_IPC_LOCK))
 		return true;

 	locked_pages = bytes >> PAGE_SHIFT;
@@ -416,7 +416,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!can_do_mlock())
 			return -EPERM;

-	if (!mlock_future_ok(mm, vm_flags, len))
+	if (!mlock_future_ok(mm, vm_flags & VM_LOCKED, len))
 		return -EAGAIN;

 	if (file) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 8391ae17de64..2be876a70cc0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1740,7 +1740,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;

-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, vrm->delta))
 		return -EAGAIN;

 	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
diff --git a/mm/secretmem.c b/mm/secretmem.c
index edf111e0a1bb..11a779c812a7 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -122,13 +122,12 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
 	const unsigned long len = vma_desc_size(desc);

-	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
 		return -EINVAL;

-	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
+	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
+	if (!mlock_future_ok(desc->mm, /*is_vma_locked=*/ true, len))
 		return -EAGAIN;
-
-	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
 	desc->vm_ops = &secretmem_vm_ops;

 	return 0;
diff --git a/mm/vma.c b/mm/vma.c
index f352d5c72212..39dcd9ddd4ba 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3053,7 +3053,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 		return -ENOMEM;

 	/* mlock limit tests */
-	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
+	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, grow << PAGE_SHIFT))
 		return -ENOMEM;

 	/* Check to ensure the stack will not grow into a hugetlb-only region */
--
2.52.0

