Return-Path: <linux-fsdevel+bounces-75748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIXhOcY0eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:09:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3064A52EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6046630389F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE830F543;
	Wed, 28 Jan 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WKFkVpqj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="urAbJMJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C74B1E3DE5;
	Wed, 28 Jan 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616341; cv=fail; b=MYUZ2wN0I/AiJ2RXuDoXFxH3DNoObu4n1slMxpp9VHRslsIrcYHcqZACWzrYKtv9UXcmp3wHbwZdozIBLuULNBnsnPJ6CkxzSRNdyG/W9hI+5bjE5SduL5BnFlYN9Ykwl9I0cHr3H8TPvg5pUzMbHhB0ax0MgaJ1uAeYUFUdbLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616341; c=relaxed/simple;
	bh=TtEdxCkvy6VaDnKHzKUMTSTrBSJI4KFvuHcb/OcDygI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DdUGB96ttADfmCR9Sbj7dLzBRy4V0MURhi5DBMsCsvoxGtQ6hrWEzLmiipANQpUBzCBCmmX1aeGVIFCkgz9TfwFaXX84GJ/BWzHpEjfkS1pECpkWUrsSniqRN2HH3D45Wooi5BFeeKd4sMzDJvT8aP75aLAKFU6zUFLZ27llSlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WKFkVpqj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=urAbJMJD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4C6bv1337603;
	Wed, 28 Jan 2026 16:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=p8KP71cCfF3CusO9lA
	zU+eVyfNdqFS8cD+lbN2c2o0w=; b=WKFkVpqj/kLJdc2fakrSFNwxvATmbxuYpv
	cA2x4yLzxI9s0OTpTPr9ITgKess5XDPVzC/EYa6WPf1fzE4ZRq35KZhx+w0E6/e2
	xV1Q2CVUMTkgXA8APWXHQr/0uYsE5dnorD45V/UHP8l5IFxapy32kS1tBZvau+Qe
	2b5hH8icq8dLG0sSLf4xufCAajIOwtQ+LntNKyxGS56Ywwa8Bb/vjXGFhTT+MMfs
	qT9bhLdZ3HVGxJ2mshFl8qQQZ9jIpOMnDv++l2sJm1qvWZxgfY/i1qVbZjw29HKY
	jwW9Aau0p0TZbhTOmyTwwa3Do2pSa/5ESDfoH2zIe/JfUj393qfA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09j907-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 16:04:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SFW11L012456;
	Wed, 28 Jan 2026 16:04:46 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhb3tdb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 16:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvQjv+NnPi/xnMkFIPlPFEV+2yfv6baC7VEUW93/YosE4EFB52HLhKqy2E+vAqcK2D+ED2A1HYMxTYZSLn22N8PpX6F6SoGOL9R1714Y339pzX1JmdmQHig24RmZtbA/TA7dnK5fhoiHGPFsWnAMxiqTc7FcHlALtBbFGY+wxoiMVe7sCXJ3xuUlIUTPL4V1mKCRa3Ht2D7F4cirRtr1TwwPJO8j6S25JSV96sSVYZwkbIn6g1mT+2Rj7JdytYaGF8YYJaUHLyxut+1oR3/uJllMGQIunlC+ApDg7wu/IeEjKhWWP8c5sfcXXMpfWDq8USlAZj/pZ3a3rftYJmbUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8KP71cCfF3CusO9lAzU+eVyfNdqFS8cD+lbN2c2o0w=;
 b=k5Iy8/zJtqXDX08WqqE3IeRW1wIIi8AOY8zYLr3JE5qilcYFFdhy1k380sBdvGd/8pv4mDqA1JbXKv4LewgEb6vDkK1nld/ij8i4TzORPYQnS656+LWVeu+BL5h+YXaSpWEDA5BSSFgrvXN7VkF63M5h7NQXhevRP852LKQGJfeQ7GzkNa7U2VEJQXv1woF0A6TTCqo1IOvRR7hkZCkXyXur8QuoAbjLmd3Q2aORkkYOAttuQzMn/OOvwgSFtzGS5d0MaUlRob3MZC5HliYEfQVctlWN+UF912qiFPIRyDIW5GxWZdkET7fNoduDGmEJErVnKrXdrkW2oqKI93WVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8KP71cCfF3CusO9lAzU+eVyfNdqFS8cD+lbN2c2o0w=;
 b=urAbJMJDGQuynfxt82qntYodzhwDSIxtQTQh/kV/pmg98ehF6Ruv0SIpgxeATgK6GGtG+doGRzISCnxW6xjtMFfgMEZ4FGzEkEWxctHf58x1iYq59exE3hwzMxHnzFjGpvKI2jVW4D+1MmFliMtOZLP6tPvNADQBEYq299hfOSc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF26D9E501B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 16:04:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 16:04:38 +0000
Date: Wed, 28 Jan 2026 16:04:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: Re: [PATCH v2 07/13] mm: update secretmem to use VMA flags on
 mmap_prepare
Message-ID: <f25eead4-50fd-4141-9f9b-5a17b17d982f@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
 <20260128121200.283932-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128121200.283932-1-clm@meta.com>
X-ClientProxiedBy: LO6P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF26D9E501B:EE_
X-MS-Office365-Filtering-Correlation-Id: be94509f-0a5d-4c61-559c-08de5e86f08a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?G+RXqzy55yJATF20HJ0SPeS1Uw/NcEL6dWy3Dvi0ISXBSGJCn0f9o5H0UDw8?=
 =?us-ascii?Q?BC4a9Jnbd+d+nqbAgwGlOCTdIKiv4qMJS4ya9PL5NQ0NkNUpYv3wHO4JnHyd?=
 =?us-ascii?Q?6qx5N+ZNNyxzCeCVdNTYXYegXrdr05LqL0MAsvsx9mfoQyZZScREhTYCIA2X?=
 =?us-ascii?Q?tg1yQK43b8MxX4Z4DDpBklF8De+ONr0xBuHk4lXf39FgIMm0EskeNxIJeXlS?=
 =?us-ascii?Q?XwIYibrBAamE2S3Lva8eKDlnKUeNZtLzRUYqFYbzxhpSUp1fVCY7snoJpudh?=
 =?us-ascii?Q?rmz6uurb78aZ+K4G6ze1/FR11G9GTxFTdLBMnM0spSWuYKVS4QlelL+IPe9K?=
 =?us-ascii?Q?yeyu6Qb+yGj8U2LMBeDadse94yNLHscNzobWqLHFaKb7LvAO1GKtVfKJxphl?=
 =?us-ascii?Q?NI7K5wmWvjMGRJJXLxKGAEeOFqHI3r+5yhgaDdV5QzDZ/nGU/3LVdfCsOMfa?=
 =?us-ascii?Q?v7vDrENdRgRTx34bSTNCNJC2i8/3o3WPVy5b5Ys12daOeL5SqyJ6Ov4VsEdN?=
 =?us-ascii?Q?ovCB928RP1DZpitllzAH440lnpfkHruSIyxEUPA4dZ5NwROeFxWJdpi1QjOw?=
 =?us-ascii?Q?7AhlSD8GhVJmgDRZdy2P8EPxRzSEup8fSKZhoAO5YQLf889mJghF2vymIKp5?=
 =?us-ascii?Q?hS2IFWUNom4KZx6LV6ifZe/8Xi8C8/cGxn3u8A3jzmIcx6y8d1CS3Bu04SwJ?=
 =?us-ascii?Q?VoSLMCPVt2SKJFLh5Q4htFp2ywMQ3W61u5Xwl3of1x35qFRB3GK+ZGfykQmF?=
 =?us-ascii?Q?rxoEtOoqQ5NV/DExky45T7PWVWzKe7MwrlzIkc9C7Hzd3p4+xu7HAyKAgeEx?=
 =?us-ascii?Q?EFtAJVhfjUJnFXmQ+hGrc7GN3vD04d4IO0GEjKDp947TZ5LI89Rk6q6iYtAd?=
 =?us-ascii?Q?dtAtjlFWNOsanr8XylgHJAjYrKays34T0XjoEUgoUvOj1Aah73gIdJ7YQNlw?=
 =?us-ascii?Q?3jf0aZIeTHCSR1D+E0lfGQ2Sb0Jd5RG/xwuej2h7U+DmnR11ewAvdxL9Xg0v?=
 =?us-ascii?Q?uiQ+6U2Zbzq4/OvCOt+TWKzST1uEzuJi+PvucwgRocoS5yjWD0h1iHucbSxX?=
 =?us-ascii?Q?wZSCT+sKfw+8V77YkBl4/qGE+fhK8NZyDzdiwsXIkPMfqijywHbEe74oPfk+?=
 =?us-ascii?Q?naqAFrIOwrt8NHk1FAE5+tvUBs7V61w9LDsbtvz4fMjllaB2r85yH66A5+w4?=
 =?us-ascii?Q?CIu5GRGXF6mBBtzC3K80C1kqFD4RMf0EjwVtVkzVQ4QPJPYs5AoBoy8TP0qg?=
 =?us-ascii?Q?Js5mBqmKb/zU3WS2Rn1gKvAExUOPe2wHkaIkfM7kh0TXgDgrvhZu2a5lC+Qu?=
 =?us-ascii?Q?J2DpHw7ZbYQLWjaRLMEKNjfksY2kHsRRN9KRg5GHZp72kZAQKQQgmYr0/Ldh?=
 =?us-ascii?Q?VlC2xqrMsIWZYkingev9hYlECUb1RsTsl39nO6G5JNwtA+/5yAWbxe05Lmax?=
 =?us-ascii?Q?hXqS0Pg7bV6+vFoqQMv04lLFEDxuhzik9oEe80ajs4NQyZd/C5tp03iAjR3E?=
 =?us-ascii?Q?wiSym4pckVHpcfkVfOU5Jk4fMxCqKRiiGNdup8IIm4ys60APLIQscgSSOEHj?=
 =?us-ascii?Q?LPPKK4zijYM1tOLLT50=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?v/rdEZUiXtIwK+4wkADAZL9WT54iSxY4C3xJn90zQHkBMCKvOjPtylMWv1kL?=
 =?us-ascii?Q?WRu5mPAxPsiel+GRqgqQAwIYtQNf8wyIeIYpnQScNhjwcyLJJIWtwhlbQh4x?=
 =?us-ascii?Q?GMEOdGy2QHGm/XexUx851hsqobylni87bHoI7mice608DiKBoLJBlP5KioaJ?=
 =?us-ascii?Q?1WHwg8cTULEsYcj4CL9pOOhA/AS0hbqPHxlvQ0R9P6/+RrsVft1a9B+kNGMj?=
 =?us-ascii?Q?YSSRIU6pZfdc3xfWylrI1yg9+PmI9R/u7BfpFOZrxkJMqAxKdbf8G/Bd2k5V?=
 =?us-ascii?Q?iTgSWlgCwWZdcBQh2a3ipH0rWNQ+tjWZQj2TqP6bt8PLTskoutpYCcSqMxWT?=
 =?us-ascii?Q?B0hXrxXhygSYGsTaD+7AzNDcLPsu6wiQsqWInXb/W92UUm3Ol8I6h6Uq0Bou?=
 =?us-ascii?Q?TzWVx6MlhRKWt+Kgef17QGU92wry3X6yHiqHzz5y0oRF+Jj2OFz06CXIraBv?=
 =?us-ascii?Q?CFlfsRypTeuNe4/MNbBDVgVuiEtMw6XJmrVrpN6pRBpDg6MJKCrbDJwpeBG4?=
 =?us-ascii?Q?dU2PE1hHiKcKl+/exp3zlCjSnoAePEvdOCD33uAzwxMZ5Docxa0vvOKV72WG?=
 =?us-ascii?Q?Q161eVqimoyE5i73tUYq0hlC220Ikz+JPZUAitgONtswpnMADnkajhBGWtYL?=
 =?us-ascii?Q?Z5tmdlOOkMrbshGTpNFzExvJ9k2hGSziYhCdKjXqrT+YRFsbG9fSFrWvy6N0?=
 =?us-ascii?Q?hBCiLWsEaXNR2afmG3KNYqAVTe+B5EkmOYfoRbMYmDgVC8h5rL4doEei5GfC?=
 =?us-ascii?Q?AeQaFJLS2NCzAkMAMWXiaS5wbaZJsNxX4853tBGWmJiRcv7kQ4mY3IJvXAV2?=
 =?us-ascii?Q?nM0QS9HskBbFaR6Od9MKmhWU4Rg+62ih3avU2I0wUPq56FN3Txeybbux01VC?=
 =?us-ascii?Q?H6obSo8yzgWEztkqezRmvnDvvasM8PglvbKeJ03UW6Kqwi8i12e6mmdgoHZN?=
 =?us-ascii?Q?2OqloI9I6AIQv5eHc+CpiAYtl5g7c8rQmJvBpx9BAPf8RbWrmAiyE7uy9q0r?=
 =?us-ascii?Q?J1/PDpvgsdhzTU6QhL0StDpIyNIIVHWyDMNBzCw1n9+33gWQt9hi15/3mb+R?=
 =?us-ascii?Q?DNDI2BnanKClZa48Px6KqL1VC6MI+ly82mgSCuRjXxI9QrV1sYgkmN9CFu1T?=
 =?us-ascii?Q?FIth6Q+Vi4Q2YT1wwB7Gh58jy3FXHwNAzEHDwBL/0wqTb048fWQO90E1aas8?=
 =?us-ascii?Q?oFPHQXy/I0KCGStN4q/EtUVaR/G3+JZSXvI8tiA2KQVT4dlfSAlSudfOqga1?=
 =?us-ascii?Q?OGCDxEC2nZ5yvKus+dherJMvXHVog9xoJAFHbe4Ve20+g7ETuhTqhrXI4cS6?=
 =?us-ascii?Q?sVh1hILfDEZXkn+XZsUeuyGEvubbPJUrs30vTXCjnnP9pPKzT1ZYg42ZhpI4?=
 =?us-ascii?Q?pnUy0956pNZXKzzbLSuglayXi7UOvpRPVxD1YtDSFJTHNJhBtCFUZxVrjXAr?=
 =?us-ascii?Q?zbPW1uvkjxp3uqX0T4dk0R64946ysExVyRnCsHLHUVJ6ICCeBNMek3CLhrrJ?=
 =?us-ascii?Q?tFJpBU4HxGCGlBiZikHo0TArU/Cnr0Kew6pdQBCODvIbRjgKcDhHezd79dfg?=
 =?us-ascii?Q?4XGrTHnpc5TiQJJTllVrxY1HIhN0+3dyTxC3wmC/ZoBX5RE0aV0IkUoFX6E4?=
 =?us-ascii?Q?nNUlEnc1cEpiNAgAoQzG77mavg0wL4I5P+sFNCTJzDeo3hyEZ3+SZiZlwnTy?=
 =?us-ascii?Q?n8+9xQuoGPQ9Jeg6d/u37cZ8puExJsoyYXn1XgdTIHqB1XuHB8/gMfn78Diy?=
 =?us-ascii?Q?cmW8gEvh+kvEs3r7iYlgz3TcJwZiw9U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lYPQcD0CpcvDjqlbscS0HZZByRslpRx8X6TdRudIt32HW+joaW1+lM3R9XJsZgSW2YoLIsbrtLJcoBkKILCwMR0JaO8zXAHBpSgXphdye1pXm5AuW5nA2KJIT4hpaWwFBLcszLNfv9a3TGYqRYJkJFsE2Ns1wMfL3ZimYdCOH0VU3/zwdHCc0CxBOWw/ph4OFj6QAkMv85CZXc2ANbA0lunp90r/OUYBbDpyKzJy/KtZ5FAJQsyd3EZzSz4Wo14SQd9udo1WnYMsb/oTwZ/1NSkiGNJO2r5M8NFGESY/AGIhn+c8MHXn2g5uPKzz0xs6l13Pjhiky1HXfrxBjHrl0mOt4UraSxIShyW8o2pTN4x9glDErEiXQRu+PjHY5gZIbFb2E6hYcDmVydTJ1fNq+HYfKQwWItBEhlsLOniCpCWAQEZck6Z1lCHQR7IPQfXXUz6lMZE6uwJQR1IC+9tIXsZt5Sx8QIcmy3JgxbRN4+uLh/weYAV2YyASkCzMD4hl6qvIPB+Yk9oPkUwIPLZ4cfJHpRvph+dPpdf9vbJElCdPolRSdnh5mb9fipx2myZEoHim2BHY6EVpSHCDv+51UYlmozTgE5oHbx2DlrT/t+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be94509f-0a5d-4c61-559c-08de5e86f08a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:04:38.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyKFwT6kpMAsa4QhRYiguua1XNaUrIFpiNYVHw4UiH4lq3Z3Fxdvn7KsuP1ZNJnNafGuIILt2evGiy9GR0YBUymkPeSDlzj3bjCe/Hp3aJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF26D9E501B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280132
X-Proofpoint-ORIG-GUID: R0yPT06-mM7lZhmd8Kq5UpU3touBdlEe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzMiBTYWx0ZWRfX4wFhqg2trpVU
 GAgEI+XVil3DTAQYw/M+ydEssATve3MC6YY/CzIhwith0Ig4gPKc+cDgNw4cefAZEy9xRp0uBUB
 D17cSbDBziWEjK4xTNJQsQmszmQAnwrujUmRiUa7zB0FuHkQd1ZuaKS+w453OT73AzELssn81GP
 4s7Oz6IyJwsOlsCvTyjn87yLaGjxTt7YHm2LIhiJhH0IxXGY3WQ1vAGGK87llImgXOlz4/hets9
 WI6NfQ4rzjzu3bZ8fX85acgv7BAEsvB7eDJs0y+qO/euoXwn4/UH9N80749OoQXGs483UjlAHo7
 Uov7H7hu4jOTK5GpE4XxoSevHfNDxOig27Jr8X3KiMvk5+tDWQodV/dK4wGwGPzYJtDol6WoRPT
 RbWYsEKbtz5XgFTfUl2NhA7og20qQMMStl2GdfLhVCHBNvBwr7gTEs5ZYb9K7YyovDxAd8sWiEc
 o3cmlrbxQjck6/NpDwQ==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=697a339f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=YyBMxp4TV8mTImdZ7IcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: R0yPT06-mM7lZhmd8Kq5UpU3touBdlEe
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lucifer.local:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75748-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[94];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D3064A52EF
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:08:36AM -0800, Chris Mason wrote:
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > This patch updates secretmem to use the new vma_flags_t type which will
> > soon supersede vm_flags_t altogether.
> >
> > In order to make this change we also have to update mlock_future_ok(), we
> > replace the vm_flags_t parameter with a simple boolean is_vma_locked one,
> > which also simplifies the invocation here.
> >
> > This is laying the groundwork for eliminating the vm_flags_t in
> > vm_area_desc and more broadly throughout the kernel.
> >
>
> Hi everyone,
>
> Running mm-new through AI review flagged this one:
>
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -225,12 +225,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
> >  	return hint;
> >  }
> >
> > -bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
> > -			unsigned long bytes)
> > +bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
> > +		     unsigned long bytes)
> >  {
> >  	unsigned long locked_pages, limit_pages;
> >
> > -	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
> > +	if (!is_vma_locked || capable(CAP_IPC_LOCK))
> >  		return true;
>
> [ ... ]
>
> > @@ -416,7 +416,7 @@
> >  		if (!can_do_mlock())
> >  			return -EPERM;
> >
> > -	if (!mlock_future_ok(mm, vm_flags, len))
> > +	if (!mlock_future_ok(mm, vm_flags & VM_LOCKED, len))
> >  		return -EAGAIN;
>
> This looks correct - do_mmap() now extracts the VM_LOCKED bit from
> vm_flags and passes that to mlock_future_ok().
>
> However, it appears check_brk_limits() was not updated when
> mlock_future_ok() changed its signature. The function at mm/mmap.c:111
> still passes the raw def_flags value:
>
>     return mlock_future_ok(current->mm, current->mm->def_flags, len)
>         ? 0 : -EAGAIN;

Ack, the C 'type system' strikes again :) will send a fix-patch.

>
> When def_flags has any bit set, this converts to true, incorrectly
> triggering mlock limit checks even when VM_LOCKED is not set. Should
> this be passing (current->mm->def_flags & VM_LOCKED) instead?
>
> [ ... ]
>
> Additionally, the test stub at tools/testing/vma/vma_internal.h:1627
> still has the old signature (mm, vm_flags_t vm_flags, bytes) while the
> production code now uses (mm, bool is_vma_locked, bytes). This could
> cause compilation issues or mask bugs in the test suite.

Ack, I can fix that later. The VMA test headers have been split and it's too
much merge pain to address at this point given the tests aren't impacted by this
yet. Is on todo!

>
>

Cheers, Lorenzo

