Return-Path: <linux-fsdevel+bounces-74544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF4D3B9B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CF830DDD15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30A301460;
	Mon, 19 Jan 2026 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mxXwIZ+m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kprVNZkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD662DF6F6;
	Mon, 19 Jan 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857639; cv=fail; b=LuZumwgW2NR4v/bXgRRNA+rInbXmHrHMiCBspnR+6MgDVJNL2DPJhDJIhuQCNZ+ZTzJoMxv3QxrQuM7TrreL8jd/4ti5hNMufq8RAfvaOHJqXuHL/4Ofqd9+Fc7wypoggEeE+x7yPhd/kdKTFriFp9cntvtBcbFTl91XTuF80DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857639; c=relaxed/simple;
	bh=dYlT4JRWexaN89E6vbIo11oJIPnTNxGrP2SfzpuI8yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oroy1Ub0sHP4K1+XjMXUhBY+0EFoC3tOQp/Q5qwsSe77kXNYLFlZ3krgxGio4kauqDIyoKoUqVcb7mclB6Df2yXsFqDKc7JgAAMIrZDrxySuvhXtTJ/OiaG7xR89zg103vdZ2yxRIjgQ5kqx8QlM3ztToQ1ThycSIFIfBXSzVZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mxXwIZ+m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kprVNZkO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDS3l1037515;
	Mon, 19 Jan 2026 21:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0rz/poM4Ry5z1Rx82gEMt5PG+OooQA+pTWrkzByLCJA=; b=
	mxXwIZ+m3aMtIYIsVCPMFod7DOLMYOnIWUZg0JmoD2xaAn+ZjeHEQb2hJT5CxfKC
	4EgicSLnhGw0PlKN28gqD0WlscT0nlT/PmOCJZVTknu70/H0p2tweBOA6wfAzDqX
	XROalsWIfog57uUZJIuzv9ayHaaTO7BZzapgkCjfMwz+SbsQLoOU1cCdHhAUCaCy
	Wfyr4mUV1341ba69ZCbntmfO8Ws9oI2bOb+VmpuH4m5gXuey8VK1V0dYekANBjuY
	53Z8XT2XSjw9y8Gb5iDo/v1qpTU3FWf7oLi3UhVLwAEGxlhxOIJi2n+CYD6jaKr5
	Oow3aPZUj67fuGR7msV4Qw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yptnn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JKV84I022439;
	Mon, 19 Jan 2026 21:19:41 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcht17-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJ5vwC4NgljvZ0R4uNgJsoThpAtbAVwqImgwPLIJbHtsAKLvWCRBm5FCqAt7X7OOJzgxHGU66Okc9tYJUPnFUQMrZMgyIE5+oZb5M9phyM1gBzpPUAbp+JKe+nYonmLk0qXdLOWqYwjN+hRcqadL99dWTSOkrTJWokWxeUX5PjrKx3Ne2md7D1xtDuOW/4FEUC9T8ssfC+Do2tLWNX74E+bQCsEHfX9DCOgQUPQa+hYiELaqy6Ik+N8utuWSWJPWiavEiO0NDc/URYtqCUJ44HQldqbXyQ2Cny7CJKjNKNTbHx67Br92Tnyh7ylRDWpwoBfwKSlSixzqjpFX5DXFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rz/poM4Ry5z1Rx82gEMt5PG+OooQA+pTWrkzByLCJA=;
 b=SDPHqVkknMBUcFFZdvMWlFJmF4wVHTjqrrV33Dhdrd3aKkO57EtgB7uhgW7/KCYURQCMAHcRRn1R6y5hCb4ZZ0oJH6rZgsN7gtvCTYTAs7JRasE8GkpEENea78eGOKMAm5P6pXdLTnJ3kOE75xhCt4Jjxx6hB7/LtjCiSzHe9R9d3hQS2B/5mSI8NdsOfChzZwvSMcc9b3HQX3xVqcWwA83tuh6+wLienTcV6mRxQe/F5e46qKyfPJY0NnVd4I+SME5iUfqT8Dc/RK8GMh74e8lYWMzwMiasSYkPXt6oRAY9m44ZxWcnCzs9n0/5lpx4QPGYX8mZXYmJWU+5pG5i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rz/poM4Ry5z1Rx82gEMt5PG+OooQA+pTWrkzByLCJA=;
 b=kprVNZkOoBXXhjw7E+OYpI7c8axwPG3na+0WjcEdxtPfXXwx4Kl3mBgp7/q1a7Bd5Jy3QPw99CxbdwVH6PnF/YoN6ir/muYDE7nrVE6eo3ECVNrhDOVcvtkNoTbeL2okbcORj0VCQVSTP5JH8D8UCbCfCf6YX+D73sL5Cwy4SRA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:37 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:37 +0000
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
Subject: [PATCH RESEND 07/12] mm: update shmem_[kernel]_file_*() functions to use vma_flags_t
Date: Mon, 19 Jan 2026 21:19:09 +0000
Message-ID: <08d9ba15d6dd6b564fb8cd11f88bec896adc4eb9.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0400.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::28) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: 404afee6-7c7a-44e5-0116-08de57a07335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+Lv96Z8XRJAVs2HD+bFnRUyO2RvDJMxxuIyMBTbQRFVCHibeudCY89/QHKw?=
 =?us-ascii?Q?Aw1+qxJBcihdTUMK1yHVYUOvS5y2cl+JjsTZnU1c0eG/98vjsX/uQfCwU2Lv?=
 =?us-ascii?Q?U0dTNuNkzuSqGkumEDDmOmficPwpYKBQQ5xWqEBWpT1JglCYMiTDlS58opNM?=
 =?us-ascii?Q?X90LrieziL49bmeemy9qsbykrMLI+r8xosC6QuZPbUgScN3KbU9eRCYwg9q+?=
 =?us-ascii?Q?HemvTa22E7GtwXE134d3AxWR4tfWOQqG8mp+HiN/9Iz3cKPtxWKcRURRbbc9?=
 =?us-ascii?Q?i5fFBOqBUFmKLtriLhFZR3npTgTbnNXZZd8svLXqbnKbDE5l3vWiOqq9v+yM?=
 =?us-ascii?Q?Ah3Phe/Z02CKKCGJ7/TAm2snGIc3NvzIUyXtkRq7Zg7f9e7XXvl3YEmO7hgc?=
 =?us-ascii?Q?GTUfGek8rmQNdvyutrQio/nuCRZNSNfJu8AlYuAELN6FoxQN/Z4FEDEAfh/S?=
 =?us-ascii?Q?OZO9AANZgLYEOs6iKhJu7ZEKw4+8ik6zpGR/+MnSZUwBULkxJIH7sn9vJ2gt?=
 =?us-ascii?Q?/WlgDn2DmKtQjopPpF4puGUj8zih/Jj8MFByxa9Zem5dKkHU27v/TBhIR6iy?=
 =?us-ascii?Q?V3j9M79vCe3tg+3KVGjOMfn/lYCuIgt6yqj5bJ6y74O+E53CKRpnSb2btApa?=
 =?us-ascii?Q?wRYUYm+afZ0X71CRBqqppd4fyozf8zWe+s0rqjK8FHNDou8tGJs/om0Y/qHd?=
 =?us-ascii?Q?ZKWwBc9hdM0IM94mqkrwfIZN36VmOMZwJkWiPSBxISH5evQBX1wznnQAK0ik?=
 =?us-ascii?Q?GEtrvZDm6EhIZe5GMbvF3koqI2AX1/Wl1epswDbt6tCMdKaKrtjj4KMprdy4?=
 =?us-ascii?Q?3UJnW652N2aaqvsqjgiiHLPazFrG8AY3tmsa7zGBM08KQKJ8XXsHWjhsTJ/J?=
 =?us-ascii?Q?9TcMpprEOzVDi4PHZ2C8JVdNYTvL4XaTKa38Du9JQojRhn6cO1x0WXi++cwJ?=
 =?us-ascii?Q?SBjcdtn7YQWFPvJ/tdXkGbuSHYHy429Rpi0S9UwHtbpL0XAkcRN62eH7XkMH?=
 =?us-ascii?Q?ejL7St2Y2t7z6tKdXEeMoJZYQwF1N2vajSAJg1KTk6fZRSywujmNej/Y2wi9?=
 =?us-ascii?Q?8kUtOXBU78ghmPrEGYquKYBchCbdbL5ca8PF7BtphDUpjuLrVycyK6SCSv/T?=
 =?us-ascii?Q?SSnohhvQJVlZDQM8QEQF1Fvv/EnBJnMHvCCRTNn4lOMFq6KAdVt5p3JVhsdT?=
 =?us-ascii?Q?vT94p1/06SZivbCtd08mJpHO6DwVPSg4ic07pfApqr6kO1Va2iU9gYxFC7u0?=
 =?us-ascii?Q?Eug/a7BKGxjJaadJW4hsIrSjPmXrx5ueF0En1eXGyjMjSQcx+1m0jkWyWjXf?=
 =?us-ascii?Q?UuMhwWugzPcnSYvslU4AleU7Ykjxu0fUbxegaI5jdF3mN9IvQIBOthpnaNlG?=
 =?us-ascii?Q?hWkYTSY2oaOHYgAUVvfX8OSoOyhkWCOkBiB3o1dAlW2ifVjcEkuG1Bj+LfI7?=
 =?us-ascii?Q?WOwzi5qpjgUZbqBXi7jHdEllSLhDVF7x2P2YdBWM6Tq2NvsULqHSdUt2J+Uk?=
 =?us-ascii?Q?J+mDi/dvTsyUR0JeF4Jhtz9Vu0st309KAoGs8wope3D5HpSQAgPmeIDQfNx1?=
 =?us-ascii?Q?c3uUOhe7NkzW0CEvyeo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8dXLD1aiAJVMfjzLOhkAtxHhnUcb1sJL6UhWtfj9MAcDgb/xMg/74BjZoHxe?=
 =?us-ascii?Q?oWwuALMaA0zynY5PAKLTf4BChwsgNnt7vg5Axl3PBcRfDf9APkn1kGmjsjv3?=
 =?us-ascii?Q?8SddWFNoxro2V3I3QZ1NnBWuU+qr+IPIybhnv02GEJfW7gTCSU6wrkRJvJNS?=
 =?us-ascii?Q?AeKI190k2Knoeuk0BpOVdIAnHXZIjWtJU4wCibypJZTs5QvplPeabdefSWAA?=
 =?us-ascii?Q?mQvnzPn8/rJF1mOTnj1FsGPfG4D29z78SPUH4FDJaK/ZCBOujDCFCCqgQqIR?=
 =?us-ascii?Q?k5Fo6GTkmii9i7/oSzSShJRzGbyB0loBsSnayMBXfMkQXUoMUSTPsAPpqBVQ?=
 =?us-ascii?Q?16xJG7oifLDpaHx4423u+Fz8ZPePVeo3CEFWdYcGrH2ij0TWDRJ9YHsS6WhY?=
 =?us-ascii?Q?OYR//+SplDO69Ualz2zQHLww2q7DYgIBbPmIh0mGm8TkiNSf4lMaKwXNHERO?=
 =?us-ascii?Q?q5rjdQ2vFGMQwvQF45DdHKVBIuzJaOWBbp9t1NHdiQVvZQwXbZE0R0F0Tar9?=
 =?us-ascii?Q?in2ys3Cf5V09NRtFV8cLOMsDOZ3pwriIiyHl1eik2GuzLc/ZL7t4cufEqVZk?=
 =?us-ascii?Q?cvKps6am+ReYtjbQtQt4sX3WdOi+2+wBbRCJZUYQiDLJKsaDwD38kPcAVG4b?=
 =?us-ascii?Q?EENszMa+R1jO8ipyGzLoZ828vvuaBumFeQSpUlTF27zDSat7kj2YHKc/y+Ov?=
 =?us-ascii?Q?/FyXvghIOv7cPHPLXirSsg9tobp3tLBbyE8p+EbRwAxJkk7Er8ZpTSE635Kl?=
 =?us-ascii?Q?e1Q9C7Ng7veR64C+16DsmZOZbtSVUFIWoEh3Y3ZybmLdncbp7K4NGkG4Tgnt?=
 =?us-ascii?Q?62xRQw/ngekPldgY1sey7K/xZnNJ5RtPw12c6gHNqrnSBEXL7UtDehTdBUcw?=
 =?us-ascii?Q?4hm4nXiV77joTmHHWuixHN4x9LVM/EtbeEaoGV7cvRmyotoI+E3C6xrqGZ5q?=
 =?us-ascii?Q?22hPUJ9aA7XpUzU7uKdMAnqrEmE692KgfYtV4uaGva+GWXPOS7sI7Kck5aVK?=
 =?us-ascii?Q?4Be4rghqQtHUXaPEXzC5Cc0gP8pJju/X4I5FKJbPaXDSatCpl0sawZmAc3BE?=
 =?us-ascii?Q?GtrnZ7RP+lgbXNGB3tIUG/RymKq+4KuFK5LMPvj2n3M/x5vDh8K+0pjUED04?=
 =?us-ascii?Q?fR2ufdoGdNHGFBsVsDRNHGBjg2ZztrkuM0LlkOqcJ+URaUn533jzSo7cFqnS?=
 =?us-ascii?Q?xF5BfrO3a11Eu/+s2q4lamWJa77VKgQrg1Bd7a6rzwT1GU2Ov6uixR7a55vO?=
 =?us-ascii?Q?3NMEBCVsYAo/fJxww5VLJCuyAgHf4tBn32dWy+b/zQYCswBnrmVw+ksFFg+w?=
 =?us-ascii?Q?DC1dC02D2Ty2qT+sNF8sAo8dNU47weVZDop+zBxw25Q944XT3+l/wnFpZ/Sk?=
 =?us-ascii?Q?WblLQW5sv7AGBncyJdoQeGw+eO04GhKUCCv0KjrMv72PGjDtsfsmTCiE88cm?=
 =?us-ascii?Q?zRbxtMd5uR7K1JnAOJA9PUOsKp9r9LwwIFm2bMladqQrtqR4ds1E8fbx2ZcF?=
 =?us-ascii?Q?GVqz/G4XLm+LpVxlBsTkGJuCUJp6LbgBB+5maXAl9wNWRZ2XFQ/UHp51pY2M?=
 =?us-ascii?Q?QVF0zuSL2L7yceUGf8uEJpF5Wbu7Q3TtZPWqMaCZYIp1IMxywAl/l+TZbyBC?=
 =?us-ascii?Q?9GkuGyHC4zN8CqOl+1il+Wjdz6wrjzAjZYu8Dtw1zdSfYLxh+VHQYBpqLcdV?=
 =?us-ascii?Q?rSYwO14KMUJnqpHfY0SCGB93287hReXltKeE1pm9IejBPTG0MOC/pdp7c/9c?=
 =?us-ascii?Q?7BI2Y46n7wzQARgGC7YWDISBz9WLfwY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8R94Ri1uEmvER52FnJZofyl6kq7O3wqDrIhpvvg9iB5ZpbZIYeOxcSqZKH2lmtvMfUCS2smKaqwS8MZlSm/eUy1ZpDTnTgkimytHhE28A6NpBlGLmpijKbyLzpFuMga5OkdDLEPAwIk4ww3EqPB4l5YQYXNASqpZWXVV7uUaMyiZwnRihMb3Thgw0kpOBA0bCDFGlZgmxxLuhYtbk6GUh74Hutmu0yKBpIdk/WQ3bCIifbz7tzRAUo2eziVKmPQNVqMbClHRcJHikypcFeq5Ohyf4K/4v2X1J3MZULJa3QZykqSVBhflvC18aJKY0UuDvz3MzZMLzdQx5YrNfpwSWj9TwCurVZYPHVGsG3BTMlcdN3zwl7jlu67BqPVG9vfZ7G52ZIKWqYiIakM9kLVtuLYW9VLntFbx9eKbuO3VAmVTtTAOg/Sl1SUsJArsuPimezb6ptaj6Q7ZaOFLaEIfHceUHIwOQtpYG8X64CkH3cUUeUoFw2FuXabBJ7P8kCTNricz6jZFpGX/iu0SuAVjclpx0++1B6hSmUDO5ojTEM4tJ3c/DQpzJjuTuhXjZ+fELqengGZUHsrbZve7NhGGQqhG0ldxgj8P0oco99w3Ulc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404afee6-7c7a-44e5-0116-08de57a07335
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:37.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eROuaSXjAmzvsoxP1nAQHlb60EzEyDr9vBmczMrG+bGJK+ctKcEGO7G880Eqi90C6ODs/stsd/uDHpkXxO6yPCKgxrAFpnuYeSm7XI/7kjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX31SqYEhuQU5i
 UH4jXGvzXEOvHAgGHDmeeVmvYMaDwYZsu65XxAOckWFzMjT/1O4jd3wt1iC9rJDwc+Q1wUmNqip
 tOvj5O9QdkkgKux0J71bQT4Hwq1HoOZ10v9UmvLUWsYyNxii31ZmT4kF6sWY3pPu+Xyx6hUqnfJ
 P1aUIMPBUJ2JHWtug/RMWpRQI4y2Me2JueG8laNgVmpNJQ9arefopw4NdK1JJXwN/amDgZZ7cIh
 smz29HFQF3TN5YEuSm8HlTTymW8VLPzfDkkCN9uEn3fxVDZJIve6QO0AtwsDXATe7aTPDw/N9e7
 3zIIfhawhiqg9F5XRIukQ2gdbjlwxXXSH7vQ+C8OEhTfy4267rMyTBcolSF4pwx4glARlgnFNj3
 q1qBu/WSb6Ah7hL8M9oZ/sc7FDxpWeITvRCiUihCbuwroLJKeHB8k9bGZhsL8b+bNo4fu88crCl
 CYbo0eJxlnyB+f/k6JxH7jplb8wUP36NbDbZ3Cq0=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696e9fee b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=18AzNVR9LDyMyYviCPoA:9 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: DWV9OaVJsu9e4NUMorst5J7mN7mmUaot
X-Proofpoint-GUID: DWV9OaVJsu9e4NUMorst5J7mN7mmUaot

In order to be able to use only vma_flags_t in vm_area_desc we must adjust
shmem file setup functions to operate in terms of vma_flags_t rather than
vm_flags_t.

This patch makes this change and updates all callers to use the new
functions.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
 drivers/gpu/drm/drm_gem.c                 |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
 drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
 drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
 fs/xfs/scrub/xfile.c                      |  3 +-
 fs/xfs/xfs_buf_mem.c                      |  2 +-
 include/linux/shmem_fs.h                  |  8 ++-
 ipc/shm.c                                 |  6 +--
 mm/memfd.c                                |  2 +-
 mm/shmem.c                                | 59 +++++++++++++----------
 security/keys/big_key.c                   |  2 +-
 15 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 9322a9287dc7..0bc36957979d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl_size = secs->size + PAGE_SIZE;

 	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
-				   VM_NORESERVE);
+				   mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(backing)) {
 		ret = PTR_ERR(backing);
 		goto err_out_shrink;
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e4df43427394..be4dca2bc34e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -130,14 +130,15 @@ int drm_gem_object_init_with_mnt(struct drm_device *dev,
 				 struct vfsmount *gemfs)
 {
 	struct file *filp;
+	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);

 	drm_gem_private_object_init(dev, obj, size);

 	if (gemfs)
 		filp = shmem_file_setup_with_mnt(gemfs, "drm mm object", size,
-						 VM_NORESERVE);
+						 flags);
 	else
-		filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
+		filp = shmem_file_setup("drm mm object", size, flags);

 	if (IS_ERR(filp))
 		return PTR_ERR(filp);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 26dda55a07ff..fe1843497b27 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -496,7 +496,7 @@ static int __create_shmem(struct drm_i915_private *i915,
 			  struct drm_gem_object *obj,
 			  resource_size_t size)
 {
-	unsigned long flags = VM_NORESERVE;
+	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
 	struct file *filp;

 	drm_gem_private_object_init(&i915->drm, obj, size);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index f65fe86c02b5..7b1a7d01db2b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -200,7 +200,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
 		struct address_space *mapping;
 		gfp_t mask;

-		filp = shmem_file_setup("i915-shmem-tt", size, VM_NORESERVE);
+		filp = shmem_file_setup("i915-shmem-tt", size,
+					mk_vma_flags(VMA_NORESERVE_BIT));
 		if (IS_ERR(filp))
 			return PTR_ERR(filp);

diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 365c4b8b04f4..5f37c699a320 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -19,7 +19,8 @@ struct file *shmem_create_from_data(const char *name, void *data, size_t len)
 	struct file *file;
 	int err;

-	file = shmem_file_setup(name, PAGE_ALIGN(len), VM_NORESERVE);
+	file = shmem_file_setup(name, PAGE_ALIGN(len),
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(file))
 		return file;

diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
index 61ec6f580b62..bd5f7d0b9b62 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
@@ -143,7 +143,7 @@ static void ttm_tt_fini_shmem(struct kunit *test)
 	err = ttm_tt_init(tt, bo, 0, caching, 0);
 	KUNIT_ASSERT_EQ(test, err, 0);

-	shmem = shmem_file_setup("ttm swap", BO_SIZE, 0);
+	shmem = shmem_file_setup("ttm swap", BO_SIZE, EMPTY_VMA_FLAGS);
 	tt->swap_storage = shmem;

 	ttm_tt_fini(tt);
diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 32530c75f038..6bd4c123d94c 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -178,5 +178,6 @@ EXPORT_SYMBOL_GPL(ttm_backup_bytes_avail);
  */
 struct file *ttm_backup_shmem_create(loff_t size)
 {
-	return shmem_file_setup("ttm shmem backup", size, 0);
+	return shmem_file_setup("ttm shmem backup", size,
+				EMPTY_VMA_FLAGS);
 }
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 611d20ab966d..f73a5ce87645 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -330,7 +330,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
 	struct page *to_page;
 	int i, ret;

-	swap_storage = shmem_file_setup("ttm swap", size, 0);
+	swap_storage = shmem_file_setup("ttm swap", size, EMPTY_VMA_FLAGS);
 	if (IS_ERR(swap_storage)) {
 		pr_err("Failed allocating swap storage\n");
 		return PTR_ERR(swap_storage);
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index c753c79df203..fe0584a39f16 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -61,7 +61,8 @@ xfile_create(
 	if (!xf)
 		return -ENOMEM;

-	xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
+	xf->file = shmem_kernel_file_setup(description, isize,
+					   mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(xf->file)) {
 		error = PTR_ERR(xf->file);
 		goto out_xfile;
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index dcbfa274e06d..fd6f0a5bc0ea 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -62,7 +62,7 @@ xmbuf_alloc(
 	if (!btp)
 		return -ENOMEM;

-	file = shmem_kernel_file_setup(descr, 0, 0);
+	file = shmem_kernel_file_setup(descr, 0, EMPTY_VMA_FLAGS);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto out_free_btp;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e2069b3179c4..a8273b32e041 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -102,12 +102,10 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 extern const struct fs_parameter_spec shmem_fs_parameters[];
 extern void shmem_init(void);
 extern int shmem_init_fs_context(struct fs_context *fc);
-extern struct file *shmem_file_setup(const char *name,
-					loff_t size, unsigned long flags);
-extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
-					    unsigned long flags);
+struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags);
+struct file *shmem_kernel_file_setup(const char *name, loff_t size, vma_flags_t vma_flags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
-		const char *name, loff_t size, unsigned long flags);
+		const char *name, loff_t size, vma_flags_t flags);
 int shmem_zero_setup(struct vm_area_struct *vma);
 int shmem_zero_setup_desc(struct vm_area_desc *desc);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
diff --git a/ipc/shm.c b/ipc/shm.c
index 2c7379c4c647..e8c7d1924c50 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -708,6 +708,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	struct shmid_kernel *shp;
 	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	const bool has_no_reserve = shmflg & SHM_NORESERVE;
+	vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 	struct file *file;
 	char name[13];

@@ -738,7 +739,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)

 	sprintf(name, "SYSV%08x", key);
 	if (shmflg & SHM_HUGETLB) {
-		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 		struct hstate *hs;
 		size_t hugesize;

@@ -755,14 +755,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
-		vm_flags_t acctflag = 0;
-
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
 		 * if it's asked for.
 		 */
 		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
-			acctflag = VM_NORESERVE;
+			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
 		file = shmem_kernel_file_setup(name, size, acctflag);
 	}
 	error = PTR_ERR(file);
diff --git a/mm/memfd.c b/mm/memfd.c
index 5f95f639550c..f3a8950850a2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -469,7 +469,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
 	} else {
-		file = shmem_file_setup(name, 0, VM_NORESERVE);
+		file = shmem_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT));
 	}
 	if (IS_ERR(file))
 		return file;
diff --git a/mm/shmem.c b/mm/shmem.c
index 0adde3f4df27..6208cbab8c2f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3057,9 +3057,9 @@ static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
 }

 static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
-					     struct super_block *sb,
-					     struct inode *dir, umode_t mode,
-					     dev_t dev, unsigned long flags)
+				       struct super_block *sb,
+				       struct inode *dir, umode_t mode,
+				       dev_t dev, vma_flags_t flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -3087,7 +3087,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
+	info->flags = vma_flags_test(flags, VMA_NORESERVE_BIT)
+		? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
@@ -3140,7 +3141,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 #ifdef CONFIG_TMPFS_QUOTA
 static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				     struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	int err;
 	struct inode *inode;
@@ -3166,9 +3167,9 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 	return ERR_PTR(err);
 }
 #else
-static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
+static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				     struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
 }
@@ -3875,7 +3876,8 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
 		return -EINVAL;

-	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);

@@ -3910,7 +3912,8 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	int error;

-	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto err_out;
@@ -4107,7 +4110,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return -ENAMETOOLONG;

 	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
-				VM_NORESERVE);
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);

@@ -5108,7 +5111,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif /* CONFIG_TMPFS_QUOTA */

 	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL,
-				S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
+				S_IFDIR | sbinfo->mode, 0,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto failed;
@@ -5808,7 +5812,7 @@ static inline void shmem_unacct_size(unsigned long flags, loff_t size)

 static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				struct super_block *sb, struct inode *dir,
-				umode_t mode, dev_t dev, unsigned long flags)
+				umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
 	return inode ? inode : ERR_PTR(-ENOSPC);
@@ -5819,10 +5823,11 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */

 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-				       loff_t size, unsigned long vm_flags,
+				       loff_t size, vma_flags_t flags,
 				       unsigned int i_flags)
 {
-	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
+	const unsigned long shmem_flags =
+		vma_flags_test(flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;

@@ -5835,13 +5840,13 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 	if (is_idmapped_mnt(mnt))
 		return ERR_PTR(-EINVAL);

-	if (shmem_acct_size(flags, size))
+	if (shmem_acct_size(shmem_flags, size))
 		return ERR_PTR(-ENOMEM);

 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, vm_flags);
+				S_IFREG | S_IRWXUGO, 0, flags);
 	if (IS_ERR(inode)) {
-		shmem_unacct_size(flags, size);
+		shmem_unacct_size(shmem_flags, size);
 		return ERR_CAST(inode);
 	}
 	inode->i_flags |= i_flags;
@@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
  *	checks are provided at the key or shm level rather than the inode.
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
-struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
+struct file *shmem_kernel_file_setup(const char *name, loff_t size,
+				     vma_flags_t flags)
 {
 	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
 }
@@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  */
-struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
+struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
 {
 	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
 }
@@ -5889,16 +5895,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
  * @mnt: the tmpfs mount where the file will be created
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
 struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
-				       loff_t size, unsigned long flags)
+				       loff_t size, vma_flags_t flags)
 {
 	return __shmem_file_setup(mnt, name, size, flags, 0);
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);

-static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
+static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
+		vma_flags_t flags)
 {
 	loff_t size = end - start;

@@ -5908,7 +5915,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
 	 * accessible to the user through its mapping, use S_PRIVATE flag to
 	 * bypass file security, in the same way as shmem_kernel_file_setup().
 	 */
-	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
+	return shmem_kernel_file_setup("dev/zero", size, flags);
 }

 /**
@@ -5918,7 +5925,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
  */
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
-	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
+	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);

 	if (IS_ERR(file))
 		return PTR_ERR(file);
@@ -5939,7 +5946,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  */
 int shmem_zero_setup_desc(struct vm_area_desc *desc)
 {
-	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
+	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);

 	if (IS_ERR(file))
 		return PTR_ERR(file);
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index d46862ab90d6..268f702df380 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 					 0, enckey);

 		/* save aligned data to file */
-		file = shmem_kernel_file_setup("", enclen, 0);
+		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
 		if (IS_ERR(file)) {
 			ret = PTR_ERR(file);
 			goto err_enckey;
--
2.52.0

