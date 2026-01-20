Return-Path: <linux-fsdevel+bounces-74695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B0hNvq+b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:44:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E7748C49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6F90A25515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FEB34A3BF;
	Tue, 20 Jan 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mCYYA8AA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zT8Pq+Lq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A434107A;
	Tue, 20 Jan 2026 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927678; cv=fail; b=cYQNsWuRWiV3t1S2EImFrB1iMx2Lnz0BbD0HDwJj6sAfF06TapQpEg1mevqJ8MqApBcVChdJPKP66g7vHfNcPkC7/uVoU36xgy8hXMxgUoFT7Rm16pD1sSZTjnqT6sfxNPeoAaJ5DqSjUheI2To9g4t7qOXufmHa6pYkAPvLfts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927678; c=relaxed/simple;
	bh=KK7Vlt1EVolyETPJBDsZtYF1gD/8DdXPOSbocliQqP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uVtCRhpSuQ/IVBn6p/1u1WPQhivSrFQLWw8T7IDu20PC9czoBwTS3dUSJ2+P9VEENKez71BQXV/IHqLiVrml7pAupAqwrfWxrrWepfVwX1u+m2hfXNGU1Ui1dwYA+Qds0YcTr+7Di1rxM8OLLO0ozrblHQsKbhIaU91TcK1qpzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mCYYA8AA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zT8Pq+Lq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KDJrH1420584;
	Tue, 20 Jan 2026 16:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eGY1hYVeD/S79TBkjn
	pOa0/X/ktOALIvnIrmSug35Uw=; b=mCYYA8AAGYQwh/KuI9b3h3lnFb/9lJLTIT
	+4nVOEiEX8usdSebAJsye6l32UKLs0qFtp862AVZVjy0+Gs2gS7Th/0PlvNTdk5S
	RBnn2sW/ObFR+yc23/AGBqdZR6GKmSKdPDKxxnGWf7ViEcvGumEU4oDxAfjif1H8
	B3huQ8JZoT/ApBKzDUie8hiGpmgGnNVvQAPCg09TG7H3jQk1gaaQytGoqbe5Drxx
	rn+SDqBqvnV/q7tqZo+ObwIFgJyvic2fzxzrE7GFIzm2BLpEmL7XIF3UZOtC6Tn1
	4XRo/OIkiDDDG4m8lAy6+A4C9UljXls8qc+mmhWH4+W8m1H+a8NA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcrcns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 16:46:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KGLPSN038833;
	Tue, 20 Jan 2026 16:46:33 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v9wgj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 16:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRh4J9PeuWMadl+TWi9azYktvrcVYDsVUUC/BYoE8z+kO8Iy8H96II3Ix/4gPjsxEr0O7nuNQlsG1rchjx4Qv0LqoWSUYNJsU7PmCtNcvtJ4XbgsuyQFJUxeoEY4/dGA0+DTuVrK5oSUtfnBVWUimEjsJVK8400SWVz9ThRaMEGJ26JI/eVuJoTAvil0BTRQr5yNJaPToKSQmRWCMUujG4pnq2DsNqisKCq/pDZjuWUJsvGdZibZ7FZ5YkagDhBCX1uUcOf+kHADj6yLr31xlWNkYVkDTOiHshq9iF9QuR0OoAvW95ACUlXJ6ETOp3kjaugo3KfJghjVJjozFJNm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGY1hYVeD/S79TBkjnpOa0/X/ktOALIvnIrmSug35Uw=;
 b=UulEgUR1PiwM2bKhgp67RGS5lwTS7wBVSw9G7kF+Dvw6GWPrY8Oukmikk8v7P9mRr5Z/IIHz7mHHebtie9c6BKs/vO7e9YDJh4A1ezquP8b2elds0An1okbPtoRLUyO+b0fnXFJc1c7Ohi4fyPpDtA71Fv/tuf/MzuC4EIS1zZbpqqdmXEeCpocKwsqYb3FBvGlXU3CoRTHrr0UV01rOJplNodpU0TXvqiztS0QcsdhMVAiUVC078tojHChp7cPLhAjl5+1IWK0Zix0J/Zg8O6tGnkngvdStTce+FvmcFFPbd1kuNarMKrVZimMqPJtKsLP3pkVOI0skfBfYGZWuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGY1hYVeD/S79TBkjnpOa0/X/ktOALIvnIrmSug35Uw=;
 b=zT8Pq+LqN2djNNHTz33ggvoB8CWLZS+ojQ7OAl6LuwP90IwFNbJcGrE6iAufIWG1uP/5T9IcH2ZtvMsmyypZDS/iqsBDAGopH3ey1hvZLAECbAUEsymAxmoIAlLbV9xk/51XhtAOJauzn5c6Kbc/vNG+olF7JAydeeUmRUOYJj8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CO1PR10MB4660.namprd10.prod.outlook.com (2603:10b6:303:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 16:46:28 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 16:46:27 +0000
Date: Tue, 20 Jan 2026 16:46:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <22e9e910-630a-41c9-bf6d-aacf7c5183f5@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
 <20260120152245.GC1134360@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120152245.GC1134360@nvidia.com>
X-ClientProxiedBy: LO4P265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CO1PR10MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: e49f908d-659c-481d-a314-08de58437435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH6kzI0jGg7zfkQ+P/XYR1FdNH425J8qPsHIYDz2AKT0AbpeIKbNIh/hpZpW?=
 =?us-ascii?Q?84fhRWA8BocgMBkQL7UIct5VemRXhHgpw+PLmFcW6Uq45PjAJfw8P0t5POHr?=
 =?us-ascii?Q?rzJJuHWQyou0onUPCkGvztJaIQnI3yvAExvANACRoBp2/7kTsPmenOyGDukx?=
 =?us-ascii?Q?z4etnExk7x2u5naf+o0yOonINA/5cRg//TJTqA+8V6bj8v3Mx/gIGBTnby75?=
 =?us-ascii?Q?XvEXtVg1VSjg1TkR4w4tUVeK92OJfLUTSXvrRbXfAlpA5jXhluOcF1RdYIDy?=
 =?us-ascii?Q?KWh8cjgAwAr+geVHQdCHCDWOVDB1XGnDfr82fOI0CZYRvtq+eBkNFZlYM2nn?=
 =?us-ascii?Q?3fFnGdae6o0uw73aEGZRxvIho0wjdEAjbNKQ1+ba/is6rgpuXCei9L0FZDfv?=
 =?us-ascii?Q?HFUG3TbQmyYn1O/d9t+3sErPrFkauFQiXLZkjVTJ/hJGgi1Hm9Ljk5xV4l7L?=
 =?us-ascii?Q?407tl5YwLToWQwjGgHoxoViRRlOF53CQlhTXnmXcwz/lP4uhx+djYDjjt/Uf?=
 =?us-ascii?Q?daKiwXhKgXApG+ndT4MEwwQRueI2Rm64aqn++lnaZKqmTe+lxsOwIoyeeUns?=
 =?us-ascii?Q?k8hEwPm8ZhcTDDpZJ/dXeD8Lm2rPsniUN595FK7WeuRDuMf1Tno024Vs94cl?=
 =?us-ascii?Q?4IkKl5NRCStzAFmNNBnYpssbO7950mNXGGXBuuFS1xLX/NwlBuzvm04a1Im8?=
 =?us-ascii?Q?yze0lkzSnz7Id63g/OFE27impxQ6H/YQ/9+hdrwAtNd74AsfV3XBsgWtOHt5?=
 =?us-ascii?Q?Lc8GWiTM32jT23PqedBkcO6hUUPel3pxuY6bWdhnwObo+Dfimq1KvGuiwbHh?=
 =?us-ascii?Q?kBcJRcX4Vp6ekzTAKcHE6/vRdFBBossWTcyko28V4tP/8OdJ6INEFMik+KoJ?=
 =?us-ascii?Q?w3UZOQ3/VPYpZqkr95df++ZeY9uwF1fXVsqMgm88wT8dnpFy/koNvn7+CGZU?=
 =?us-ascii?Q?5uMZQwOEzsUE2x7n4Bz6+lJn2xgGqvoM6S8ePm7P+QkC8qMVBuHFkHx2iXEO?=
 =?us-ascii?Q?bQwQKEN01WYnLMs+yHY6hGuqHMN7pK4JrRMvryx+PSFNUe92vVC9hu5unX6w?=
 =?us-ascii?Q?RRYGUFZp3aw9huzEmiq23fPLBkIKtiNID638TrFth1ToZMZaWvHqer8NclC4?=
 =?us-ascii?Q?d0l74zijpuoxB2Fbdi7NO8exMdRRB+nOIrIy5Nzg88SVGIZcECuOnt+MObu1?=
 =?us-ascii?Q?iXsvi5eWIFOxJGIedPZ7Emn4k1MMwHwi7oBD2Q/vxLO5OIioa6An/gloLHNw?=
 =?us-ascii?Q?ACLuifR24tZ+2a9bBV3g6eyaaA6ZW4Waed5PJKctphXTOk2D5qUjk/Z/qp/B?=
 =?us-ascii?Q?lAxVvfcJgYLxuvCTEwzz3FtD09MwkcuzsD4q20iv/fOo6eoTSwG6xlLAJuJX?=
 =?us-ascii?Q?p8jj8jwVMhvR7Nx/QhTx5mFuspCpf+MrLgsIXzE1wMO/2K3rAar0OF+Bd15x?=
 =?us-ascii?Q?1W3vIXnsX3085Jfto1Mgi/AJ0Ybe3HFAg1GHX/jHq+fVBs7QnKodeGT1GoCO?=
 =?us-ascii?Q?QSdC2ohREjmP5513hcxMEXBr3+RKlXvxDEilmQKOyqsqS/gvUt3mVUWobY0U?=
 =?us-ascii?Q?5gWTEztoVxpPrkRoqDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y6GhHzODzUWTn2oCFSXATmQF2dhVxLBeaCbmH75bzGJnYsU1IL/HuE0c/z4W?=
 =?us-ascii?Q?828V8uQYE5Jve2YIvWq8u2fSDuG7IaCPS0kuaPlXp0FmeZsaTaXKMUGdy5ol?=
 =?us-ascii?Q?2HrwcY1ZONfFYx9Z5UVZr1G4XACzoRM3dgIakV5L4sGJ54x1KBcAyWgYk6hj?=
 =?us-ascii?Q?bkNnfDgmYd04qKXukEXESTaXJZQtIbyGeDsKATj0X9f58/ss5Ca0QdT5pV3W?=
 =?us-ascii?Q?1lmNkaU4F8ijhh7xWwT7jdiQCUO9A1nfzvXoWoweP3zO/A3zElhjDjHHpPpP?=
 =?us-ascii?Q?HBrqPebzo9fhu6/BJd76YE5JdZ54uj09o9At3JqGhTReXx4AyHkPt05+cQOO?=
 =?us-ascii?Q?BLLZu26rMFngI3UQXI9ntdl9eb31WyHsQt0KHGmqT2gldCGRMI3p1tff+ZJ2?=
 =?us-ascii?Q?Azroh+BpIiK70Dtv6PBEITGEyFBtTXDpVTu6RRRwlKrOfRv8vX3YBl+0UGTu?=
 =?us-ascii?Q?ZrBO6wYKDcFXY9BPYf2b9f4+TngjrKT6pgTrCN1kvOu6yhuTpNdn5YCpzYB7?=
 =?us-ascii?Q?xyEx8cg1Fr/CYJIwsAlotKF5m7w/d4lY6yOePEGOAIG4wAKRPrk3lnuLMyHV?=
 =?us-ascii?Q?cLIOhyntMxaWstl40v1bR2XPYXWiCsp7RgyCPFAJ2aIna88FblBR9p5ysN+M?=
 =?us-ascii?Q?y8asntbZ1CjbsESv8vE59v4p+FB1wz8Xq2nSb+nc0/CtB+TEwgHPv7Z2JdpC?=
 =?us-ascii?Q?qA/HoJlri2dWsinMD/wXPjkbm7xAmQVkeGcF60hLmuNXjS0qqy3bYbvtkgoR?=
 =?us-ascii?Q?fdHjYTrD234WYX5vz8P5zbZ0xP+G6xSp2Bwa45FGVBkfzu+uqaYaD8eWg32x?=
 =?us-ascii?Q?h2+aacsT/rLnm8i9YRNi2rNzuNZjmm9ShQYVhbM3EyPjpKzlTyYgAA8K8655?=
 =?us-ascii?Q?OUhBFWmZ/n1bBLTlt5lC6w/B3d+tUB+iVqFm4kdS6JxHUj9XDYgo3QrPdJC2?=
 =?us-ascii?Q?Z/jKvPZgqKhFP2q5mDOyjzHA5StAnMppN9FWjaB2fAw4oTSq2bQZUPYiVOPB?=
 =?us-ascii?Q?GVchkErb+2NobV/Th+PpV6H5tkMlK1Ezk/q6JTSS0zKBldm1Rypagvd9wdeD?=
 =?us-ascii?Q?5W4UuCM3HRyKe16H3yjzcEwD0y350fSJ538gKLFGRdRHMg8yeRcdWJrKjrwu?=
 =?us-ascii?Q?b7KIOS3731wXohMxNwlD7g4y4llmmmh4EC5x8YNHUJY/aDsn/KH6g5xutu3C?=
 =?us-ascii?Q?jGICtRJ0NWZakTpS+doKRTOGo3gorogaCJS3QV2YsroLqJ4ipZ6Suhuf51Cw?=
 =?us-ascii?Q?2R5qQ9yhGxYPyNaotCURX9fM0/UOUyPiW2c9V9sI1E3N+X9wKK+9XNSjjCtC?=
 =?us-ascii?Q?xjfrADs/TOIcWy9BAWr5fDi8SV2bIvhQu27ZtX7DOHJsbL7PdxJmTrAK3YDK?=
 =?us-ascii?Q?FS+X75MCn6fXQDnxnOgUaoQ23m++CYzFofP0Lrf2CZROynDzJpdSq+WztdbQ?=
 =?us-ascii?Q?XXUUkwgStjP2/+q/TLITI0s9dJoSQRa4I2Se2vIKpaJhrktBKmk7R1Qwup5h?=
 =?us-ascii?Q?haN7jYR0QXOjgSdZ3pjCnbrcFdZTf4NkG2TNrxJYs7dZWKIyN8cHDrwQyAKq?=
 =?us-ascii?Q?3CdYSmsR+shZBF435Td+9F7CN/nzrhvzz20MPRtgkP/kGpd4XiYOTKq3UKfl?=
 =?us-ascii?Q?tNZ6C4b3wXVBC5Wmuq4+fVhvXFL14zGFydJLXSJe/6rM1nsXDu8SeZQi/pkX?=
 =?us-ascii?Q?zphxPKWqpIZRxtuNFsCpVlANxbCt2gwUWXfHyi9ui/HM59Wf9kBTct7KTyoI?=
 =?us-ascii?Q?Fr/BebY7aX/UBv7fOARm4sro9yf7yRI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0AayZ1dXX0VMwnCDRSQHA6hZ71qyIekZnkMo8Alf3rkLjlQHUfpDHqFNEzgBS6orA9KTmbPcVOIQkRCFWL0wutsQ3T875ZGZOxWA1z7bssZuWGn6NBFqXAyby9OB4A4w7DMVPRxuzi+xsFghYzfPxcCW/NTQl3Gzmd86ZSKmmqtCl1Ht25geYZvRl8jerTH4w0MixxuFCKNIZ/MURAPTrAeRy08Z9zs/sWLR26BeyzYhLKaKyGaPCo0Gn3o75SVqquq3LjrIvCBcQi5W/0WWdyIsjhNd+hxNIUn81Qx6TBED1YLIkkqW/RacwGJm+UZVEsDQuf3Q7cYpJk5ziPqxVge/Kc0Rt5AMZEl0qE6JRXmRbl0OI7H0g7SwXxHm6Oihixg2PnCxVaNugdbQGKNKlhD3jIOLSqa7r46t34J6Qjv0stHxg5u03Ifiez4J5o2hqPRGWX3JEiF5jKMxGz9c+6FTZSiLUcyxRuLy7k0ofaYGf7B6T97LjCPM1Zrps3MznId2S/haLwXR2psvp8u1kXEWbK3CRJXPv0KC6zhVJIVAKsYXdc/Yc9Yi/l/YKXYHV+rOQEpQWtntSTURz+b3iE5q/oja0JQOHV8URuP48QY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49f908d-659c-481d-a314-08de58437435
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:46:26.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1DZKA4bXn614aXhldLbLE3qO47kGRL9MmNxN5R54j+xaFWx90/ziG1lf4aEmEQOubsHZ/td/c4zeRRtwRNhJh23pKOgeFlUDZDZA7ciDpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200139
X-Proofpoint-ORIG-GUID: 1v2IvSyU5yQ3dH4jViMxc73Vm_o5R_pG
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=696fb16b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bdRzGO9cJ-n8fyrXVSIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE0MCBTYWx0ZWRfXwYjXMyERzY4h
 nYPpy666y/4loO/Q+ZQz3uI7OIztSokImscKja9lFwWYu7KYJgwYO6d/RIrG3nYHUyAbJOUCB2W
 Bh0kx/Jxtf8HtJUfC1ZA5bXgImu0AxklqrSB/61bsSuvZXJ79VYfhc53/nvqrl9ZMeYP64dF1Hg
 LY8edAAo63CbNpNQVaF2kbOLhHqhQBLYeEEIhg1xXau8D6K9jPkb/+KEAmcVzbdUqKuDeJtBl2q
 uBtz3TXydqLJR3tmIK6v1acGuKRz/Cxqc4/5fL/K0f/pDMsW0zml/OOusFoP/VhmAMOfjMjo6Xk
 g1Xo/ZhhgKSIwWx4WMRno5U5PcQThocYqE4/INTM9gKXktACV+PaHRD9EL0EggI82dgkp6rjuSp
 YR4CmXHqrg+8dlQeueUKrwEOM8XeMTwi7UrWcJVYlfUVrOfx/KO1//Hr0VXROis+9nM7spFT45O
 S8Hqb9EtmEgCIcktHyA==
X-Proofpoint-GUID: 1v2IvSyU5yQ3dH4jViMxc73Vm_o5R_pG
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	TAGGED_FROM(0.00)[bounces-74695-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,oracle.onmicrosoft.com:dkim,oracle.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 50E7748C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:22:45AM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 20, 2026 at 03:10:54PM +0000, Lorenzo Stoakes wrote:
> > The natural implication of what you're saying is that we can no longer use this
> > from _anywhere_ because - hey - passing this by value is bad so now _everything_
> > has to be re-written as:
>
> No, I'm not saying that, I'm saying this specific case where you are
> making an accessor to reach an unknown value located on the heap

OK it would have been helpful for you to say that! Sometimes reviews feel
like a ratcheting series of 'what do you actually mean?'s... :)

> should be using a pointer as both a matter of style and to simplify
> life for the compiler.

OK fine.

>
> > 	vma_flags_t flags_to_set = mk_vma_flags(<flags>);
> >
> > 	if (vma_flags_test(&flags, &flags_to_set)) { ... }
>
> This is quite a different situation, it is a known const at compile
> time value located on the stack.

Well as a const time thing it'll be optimised to just a value assuming
nothing changes flags_to_set in the mean time. You'd hope.

Note that we have xxx_mask() variants, such that you can do, e.g.:

	vma_flags_t flags1 = mk_vma_flags(...);
	vma_flags_t flags2 = mk_vma_flags(...);

	if (vma_flags_test_mask(flags1, flags2)) {
		...
	}

ASIDE ->
	NOTE: A likely use of this, and one I already added is so we can do
	e.g.:

	#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT, \
		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)

	...

	if (vma_flagss_test_mask(flags, VMA_REMAP_FLAGS)) { ... }

	Which would be effectively a const input anyway.
<- ASIDE

Or in a world where flags1 is a const pointer now:

	if (vma_flags_test_mask(&flags1, flags2)) { ... }

Which makes the form... kinda weird. Then again it's consistent with other
forms which update flags1, ofc we name this separately, e.g. flags, to_test
or flags, to_set so I guess not such a problme.

Now, nobody is _likely_ to do e.g.:

	if (vma_flags_test_mask(&vma1->flags, vma2->flags)) { ... }

In this situation, but they could.

However perhaps having one value pass-by-const-pointer and the other
by-value essentially documents the fact you're being dumb.

And if somebody really needs something like this (not sure why) we could
add something.

But yeah ok, I'll change this. It's more than this case it's also all the
test stuff but shouldn't be a really huge change.

>
> > If it was just changing this one function I'd still object as it makes it differ
> > from _every other test predicate_ using vma_flags_t but maybe to humour you I'd
> > change it, but surely by this argument you're essentially objecting to the whole
> > series?
>
> I only think that if you are taking a heap input that is not of known
> value you should continue to pass by pointer as is generally expected
> in the C style we use.

Ack.

>
> And it isn't saying anything about the overall technique in the
> series, just a minor note about style.

OK good, though Arnd's reply feels more like a comment on the latter,
though only really doing pass-by-value for const values (in nearly all sane
cases) should hopefully mitigate.

>
> > I am not sure about this 'idiomatic kernel style' thing either, it feels rather
> > conjured. Yes you wouldn't ordinarily pass something larger than a register size
> > by-value, but here the intent is for it to be inlined anyway right?
>
> Well, exactly, we don't normally pass things larger than an interger
> by value, that isn't the style, so I don't think it is such a great
> thing to introduce here kind of unnecessarily.
>
> The troubles I recently had were linked to odd things like gcov and
> very old still supported versions of gcc. Also I saw a power compiler
> make a very strange choice to not inline something that evaluated to a
> constant.

Right ok.

>
> Jason

Thanks, Lorenzo

