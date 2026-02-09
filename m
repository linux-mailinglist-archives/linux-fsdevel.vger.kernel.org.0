Return-Path: <linux-fsdevel+bounces-76754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIAGAI1CimmwIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:24:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A744F1146E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CB43300B9CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BD33B95E;
	Mon,  9 Feb 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="juaLs9vk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZNxaTlBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9A8462;
	Mon,  9 Feb 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668676; cv=fail; b=UVveHVK7+Ke69parlSHd/fdQ3/mXtlbEF6cPzhRg9WN3V9jAn0MZOW2aS3xabnDAcGL5SD+PEoCKTwV7PWAmKzwptz4zG2ZtXXmRjYcFyYPjcFUzlnOgvUIbfxecHGQt77yTh/pAvizRWGv1VX8BXaYVazEC0onMcRsxdQNBZPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668676; c=relaxed/simple;
	bh=0lwYQHwUkEkifQR/eh8voNTUnO9ddurbR5YyPby7v2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V+QFNHVhvureo+oykakH0jugAT18+f5pz0jR6W1XI0LhPEMP61SV1NQ+gPKni4ocAv2fdpLzC8ZafRhtSqFPP9cMyFp0RGVIXqVgSjoeYAlfLWm6NAaOabCpu0+UZln0K1zCEpwcZgWVwBSvwfIVYNzWnKef7aOhhnJxi7ZS6hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=juaLs9vk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZNxaTlBU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECtTv1229245;
	Mon, 9 Feb 2026 20:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Z8pYPBpZESFJnn6cw8
	YUsAC4m98ycBJB8g0kciC7mxE=; b=juaLs9vkyP0kTE7QoTDz2Qv4KSCHRX4evP
	mdTEzr8g7EoCAfYREQp74ALH8M1zo3PZt+my8sgBhOIHg/Ao3hsKNj9XfK5IMrM2
	rPxR1iVWdmi2UpsSgYnTVZ1XZWZcxsoYP2c8CNKkR0yRSKBTUCafFpmdOzbBFJgA
	trCx9EK8HodhaLvLIeD058RQqEjt6JDQePl6uJ77KTffWDW0s+ZT/WL9sUcbSkqY
	ZJNshQStpsQA8W8WFaECby6LmyTLZcjhTTm62sSyC0TPaItWEtEass200IhaFhrz
	EmOtsOW+S9KmRkCeBIcqh9Cm7P4IVzBt7IJgKSFYS4YHbXwTinCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xes2qty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 20:23:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619JbAlR033811;
	Mon, 9 Feb 2026 20:23:28 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7ctxxxvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 20:23:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL4JDSVq+uCgpORqojAcFd0ouMuHnAvD/Czm5Yyq6ow4dqjqOmdqDTX0o+Q2hMkYrGoKW1k58Mi0nt+k2brz0V7bPAfldDxzB4Nu7Y+UebChFxQ8mPrLVAcALhV130EBjYaG3Q7fqBNjhyO4Ta4rd5ln4PzhEWHTId1KKehGEDwFns9Rag3yoDc6Zo/2nFnrcBWkC7qI88Qb72DLMorGui3Suh9079zDxq1IEvQ9BZZb6WhJXXeIiXsUhTxI+QZOfwgreHaaw52zCeJ7XBdMeHMUV/IE51yhUEjGU67duSzQJl1GhgeUe4ALOgdK8dl5CVnObUNPa8DH99fZ30SaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8pYPBpZESFJnn6cw8YUsAC4m98ycBJB8g0kciC7mxE=;
 b=cWU+Ax5VO7Cgzp+6d7dh0O+BrZv1r/9HLCC2GJv2TE7+XnBB68Pavc5otXiLr8LoMrvEy0HhP9luIHzLAqtsR9Oix5xRHgs1Dw4FggVYLeYE29qjq/ZE6sEsZDbRztpGiAW0ulY0fdn7+tUPS2F4gtAaS41g4QW9STkjK3wMm+2B0p893ANfLEt3ctrxf3n9u+UiNIJ6BL2lkSYNhSwyG8vvTZuy0jYe0shMem4b/UxnGHq1OaYPACNoHA+wLQnnJ2hIY8WavbRyCkXrVRskZ9I/DDbKcWqlCvd+OtbiHrF4GxV4AlbpzltOlElZ3GHfl1evI3dJFgD5k6VzPuwkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8pYPBpZESFJnn6cw8YUsAC4m98ycBJB8g0kciC7mxE=;
 b=ZNxaTlBUT8ws1RKlRWmUgewLf3AX5aIcL7gJufcbeEYV0k19lE4j84ibGnnZ3sqF7Q49SXrQQd31w8IIHyQOntmGZfW1IPjnwnyXxX8czVl1mvlw+K+XwtDPPMQ8fbJHIM1iHpsYV6oyh8L6n+gdf8g/x1ZT2lgFXKFe6VJD+CM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7960.namprd10.prod.outlook.com (2603:10b6:610:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 20:23:18 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 20:23:17 +0000
Date: Mon, 9 Feb 2026 20:23:04 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v2 13/13] tools/testing/vma: add VMA userland tests for
 VMA flag functions
Message-ID: <gcnaaaub4elpm2iauij3pejsb6dlnyij3qmbwha6vp2k5rsm53@yatvcjchxhbi>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	devel@lists.orangefs.org, linux-xfs@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <7fe6afe9c8c61e4d3cfc9a2d50a5d24da8528e68.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe6afe9c8c61e4d3cfc9a2d50a5d24da8528e68.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: c3201b20-37a7-49af-9653-08de68190ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPz2pM/ME0/rmxFncv9Wgh8JmWR/vbt5gRYX0gMilpgjeZhrxlV5diTFmPR2?=
 =?us-ascii?Q?+gFI3VdTLc/Tq11yB14Sqxk+6I4oloq3Q1FcZq0ds77B2D3PXrm4A2C7JgMT?=
 =?us-ascii?Q?Y6gWgwrNUa0vwifemzkkSmKPBWW0yUTz4tE3TYprUh/rM5ylGh4L3vK6Dl2k?=
 =?us-ascii?Q?3TBvENzEL/d60E4e6X24sNiLcxIC4flafLHWFIoCSRWEmS8Xwx2waoL6OJD6?=
 =?us-ascii?Q?HO/6RxlLalTjx4eUPTPDg2PpOl3mdr3SA3I4Sml1hZ6vjjT+TGvC/iJIeYDJ?=
 =?us-ascii?Q?PiBOClIB2XmH/gCWSNHBs5piIYn6S+yGvB4EEaWHs53j7b7DAj+fC36Jyqvy?=
 =?us-ascii?Q?BBfryEWWL9GRKxkwSPWWcugU7kv0tw0087X3kFN30bWdpQrMP3oN6dkEfvlD?=
 =?us-ascii?Q?disIjrn2HWwO1NfrG4NrF9iIM+aY6GkLgHLCjpbQcgX6zREkNXBveCFu5t+T?=
 =?us-ascii?Q?Sgk80V9jmP+6AGOGDW24Kna5lVFSDWL9HYbY49SA3AkKEzrS38z3CD7WMp8I?=
 =?us-ascii?Q?G+ju74036wx5tYyAdsoCp/h9OMPAgTFx0BnYfPVMVnLkYtsUoNOUrvPrMAgS?=
 =?us-ascii?Q?cgvZdw6G37RzrqtO5RPMcn1q9355znrtx1uqpzSZS7E9DHd5p/E/3WP8LpHR?=
 =?us-ascii?Q?ykP/2aZp6lN2tTQH8heZ0qDAYv1DzdyVfcUovPwdCLvnYkEabXuIkWCNClAm?=
 =?us-ascii?Q?pAj5s7pStQRAciK7bBBJfeMbMQJvjr8Gjchj2Rfg6hqnKaL9N0K6QhNYSVnu?=
 =?us-ascii?Q?x09nfE+iEs7t5vIWrdvIUCdoy9B+32SOZe1tt1o+2g9Z/Kxcz1TQSthPTYwT?=
 =?us-ascii?Q?KAMhUCJFqMXImVdRHnBpSU5vJzR9ebiwe7+iNi56QgyFlsjGdoJWRbgANSYa?=
 =?us-ascii?Q?a1Op0PctTrXQPad+44HIEZjj2JvBqiwGMvECKKkdWSvru3dScY5DE5jZDpl+?=
 =?us-ascii?Q?d16IjVOkMpA3EREzg5D9W38z2ErTxSQ9r/PGRVtSvfehtnZMAbFYF/vZadge?=
 =?us-ascii?Q?Zh+kp6hJOQakrVHa1L6vCfq2C35tnYE4mac7QNCWH8JoQQd5Pp6UWF8hRKBy?=
 =?us-ascii?Q?YtxcmKgN3D85LqqIi/EAyMUQKgG/Hcs2wvvsGn+QMRpAK0TTgv3uMjZahl3f?=
 =?us-ascii?Q?FWVRGpCwkFnJjZsnbOMclMfFlVLqiWJZicywYRVBoiqzWbICFO1Zy1DqeN+g?=
 =?us-ascii?Q?DU0bT93Apm1dsIlaCajg07wWklQhhNC4B0TZOFw/BfZ3Um1FxNIy5uXGxUyt?=
 =?us-ascii?Q?/C7pTurjtm/J6l9TITzgwKNAaFOUzaZaJDuinClSr2+Sc/E/PKuebJ23CeBk?=
 =?us-ascii?Q?gQ+BqlXmip7RnCPUBuSIWDxFswXxPNZVILukiS2biVdUYQPRLZ1wqpZKMl4n?=
 =?us-ascii?Q?dbEJ8chAy6cnwDDsc5tvE0mM5vEbyg8YReruIhqL9Qld7zj7SSU+Hij97K6l?=
 =?us-ascii?Q?xYgwwVqRrga/eIFdBZDSZcpNliO44Zy8Ul7/YZvq9zkB3LhFRIp3yOKoMDim?=
 =?us-ascii?Q?Rk0TwXi+/h00Wq75rl1sjzzc/JJabNm2jH/7QIWPU991LqGtGMVnUjn/EQfI?=
 =?us-ascii?Q?Ne9I+ezz0WvdYo9zUuWzHPcguyZuyCQq1fgBhqMYV1zLxgaLNfNGOaSyqifB?=
 =?us-ascii?Q?eVLkGJeOYMAVtlNXVJi6tvY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeqbMu0yUF0fwxbKabUk9AfXUot/63QsvMe8RwJIjX33KbCwp6zamqtz0TEW?=
 =?us-ascii?Q?ih/P05vcyJsu7Hw52DMK6XAG7dalLWhkuC6Q4+fmtTG737SF5MeRrrRNJXXs?=
 =?us-ascii?Q?0aWrN5+I7ReVxEVo5honqM7UPOTV1mydW0gvcBpvtzT/M/6N0b9C98vZy6/M?=
 =?us-ascii?Q?8SKO95lFkmXAA4EQWIyf/RzKmZxzC7uQ6ZlKrGdVxTJObtbBPks/oz55u/54?=
 =?us-ascii?Q?PiALg2Hbuas4URNU4dORhSoQjCdU6Yv1iATA6iq+05s7O33GJrdseAsyIa8+?=
 =?us-ascii?Q?HXyCtSQYg9QyHinsrfQS1s8Qw2cvXv8C3I6ToEXDLgunbspP2VjLVEyFUGVB?=
 =?us-ascii?Q?sRgKxhcVCHNqpKJhDMp9Gyg6IMTjgsURDCaj1R1enE5q3ZoVu5EYC+Hae9QM?=
 =?us-ascii?Q?RF0X1293J1h86KEj2wqpmT7rCcY0aozMMZUs41FFnng7IaXf8GrDiil3m5/4?=
 =?us-ascii?Q?9YNwj6iCJBBDuD3C+iVAt2LvNWjc6XBOcBxkS4zXI/IT6dbk5+PMwSDXyJhp?=
 =?us-ascii?Q?/wp3I+jhA/O9VtnsZdkkSPu7l+DLHUOLfZemiTqjEtpObNZ0Gcx08dJAJtxp?=
 =?us-ascii?Q?kApzdOMiimn69WixunwClFOTHcGYQfwOkfFMVX5GKASXDdwc2ShcgQXTetu7?=
 =?us-ascii?Q?AV1RK2wjVEvkmvvrrTiSLI2k6IO91eHDmTcHsT7EJw/dsjl8gyvi45J06DeX?=
 =?us-ascii?Q?iQxOF4wvq2cZRx6PlCpmnqxbMqlq5G8HBF2jN5b4RDy2QV1vwrTSrbP/1OZc?=
 =?us-ascii?Q?c8i2xk8dEikdxiiapuxZJtptb/U9wv42FmE1I2Tt1znvW2bN1x7SaUPgNDrT?=
 =?us-ascii?Q?hnhBBOlrWmSpkEmMo7d0XY0AMsNEwJtb/H+VK8w3NdqVYLf6zd46Hq/MRxEn?=
 =?us-ascii?Q?rA4Q4+rAJNfsBEXfbG7X606I1dmwCEBGV0YxWNkmL1k0mWlg3nsxSMzuu2xZ?=
 =?us-ascii?Q?ad6cYOwMdP+4z3Qlb76kvarZchdbZ5MeHKWa6eJmut03N7OEV+9OoIc61cja?=
 =?us-ascii?Q?mPUBeRfJ9bSN2NZBpceiflN34yZmJuIX4ifmqLAJqdPZUXISqAeU2eIAS0Lm?=
 =?us-ascii?Q?CjH4t/OZ/k3BM4WLYLcDm86qb7DhYZCXLbffnDyV4R6vjh0MO6TqknqzgAb+?=
 =?us-ascii?Q?tnByFrpZG9cAqKmCVlWSsxITyuUCDSsJH7dMx+Tmr2LXKEfYP/My4aubXsFN?=
 =?us-ascii?Q?IJzBsrSYrhfCAkmE0WDnOdvGCJGaK57hI/wXRNRQEpi06Kn2ecf4YDdu/yzx?=
 =?us-ascii?Q?6fHBUA3qGLP7ZhxMv5usMPVtddy8Y1k99U78WbVL+Uaa95Ue/5qXzxAFQwcr?=
 =?us-ascii?Q?/dOLNwJ6OY/7Ig4LvgUQeS4RwZk2MKPzJ4BW2krVcLXCNhMjbl73lQ7DRXIx?=
 =?us-ascii?Q?fFnv0rh1b+XpZcE1pbx9mlGoLK2E7tlLXJvKcc/MaidzcM/Y79oLdyhwvP/f?=
 =?us-ascii?Q?c8mURCe7Sd9LU2cZPuN7ZERutwqzbYXCdqRZcwHuEfORcxl1l70qURWbR6Xx?=
 =?us-ascii?Q?5odW7iyDJc19KrDhllnYoB8tgPAK3RShmwEQ6dCwDoGXV7x2S1vrX91iT/pk?=
 =?us-ascii?Q?Ds+v3Iz5/l5b3pxxsGVAWvm6apBm5ctTpmnnxp9TBmghHCQwdoxoHMPETRj0?=
 =?us-ascii?Q?jWLUrb+WeTAzbL+G9CY4x05Hynv3sHHQGcUg7tJK5mgs3m/7adDd54cY2cj8?=
 =?us-ascii?Q?QOLgWkpMpIpoYKNJ+v/ZOu+S/mB7w7wFW8mFjYCOhDoFEXQJJCaXr7k9aYTc?=
 =?us-ascii?Q?1Q/9YjgWeg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+7tdtc6eLENrK90nZXZFqUH3WXUosGFpmzsKGiq/bUyzVvbbq6dd7uPIUox4bbJe6/itnmTTVQ8apiloA+vXxaBc8Kc/MAcuMJPimoLNj900tQx3ed3Rks7GyaZyvZnkVjNtusNtCaUCKSfe5J+rQ4nJzOe1qBthY4yM8Cl/SnY7Qt/ukvuwTWZH8B6g3VRxBNUXrl70hk5TvO+1VBl1bayly8Q6uc11qtNC2lI/6r+heLKJbOU5vWiVlzoru9vi8pxPtMmhyrKSmLbOVmIrQQSEjcTvT1CxTJ65Qj9TD3QW8JU2yqbfi/3iv7SLUkH/WJcF6czNo9ryE8DDmEuKWqYpshhwU3m37cGxt/dD0iUj0RBMFG35mcUxrC9bsKE1TwYUhz+pyDXe/MKazfFLX1U3KvFZU2dksS7/MYxC+iC/aXeTH8ru3e01EE0BYPXpY4mhKSB/mwXhbNKP1EV/uGhQFkd0ZDSzDrGgh+3r3hGTSrulcOjLFLhRU4NaWZpG5K6i2ytCVeaHiVqPNrHlryS/PtUHnJ+36WTOmQGjlYFJRcGKse8FC+QN8EFE7JnB86p9gSI04MOYPj7Zx7nzIfAWIWq04MvN3z08cx7ge2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3201b20-37a7-49af-9653-08de68190ea0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:23:17.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkbWUbMNC4ep1gMcu9iCtoiHRGVioU+FuzWfHlZN2Esb4eXVzNvq9C9WAs6iO39SwSUFqeXOIhto+x9IcU9C4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090172
X-Authority-Analysis: v=2.4 cv=KaTfcAYD c=1 sm=1 tr=0 ts=698a4240 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=F0Ts5zb_S4Wt9otMmD4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xouLzNzgvJBBiBHnXiSz7bP054H3qAFs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3MSBTYWx0ZWRfX96e5AEC48e95
 vaE/1bW5F2NbweFg/ZtrPp1xIKYGTY0p6RZV2I4h9vQXUGrOi7cTGHTCeAfDUv5rkjrPZ4znmMt
 nEHYYp8ett+6hGd3aBOt++m79dh4VPxytxnF1TTLvwMPqVywgPOlF8wVR1MhIiKwrfB5MmMr+fH
 54DLHlCIvIcOcDzSrdk1UOi2i7zOY44olqPdaiPt0qGHtDlzO6XYK2yvZjeWxfLCzIWLWWKy2oW
 A7RyktjkhvYpJmD+gg/DB2oGpkA0oAIDRYo3zpz90aXPQwJyzt8kBXJ9SXaGpRmG/6JasN8RPiF
 an7TBpUUQPniFjnygzjSDj9m3PXMV1yoqVMs1N+sF09YpBpy+BxQTshz9I/dwZVGbcZ8ixKMa69
 CJMEGuMP8cPCiPKjMJO8KIMBPkhuwmvMlM3Oaasfimw4pr2LFcv0+9WKhbihktfgezGD9swcyqB
 XuiKl30Mw3jJynVRW5Q==
X-Proofpoint-ORIG-GUID: xouLzNzgvJBBiBHnXiSz7bP054H3qAFs
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76754-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A744F1146E9
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> Now we have the capability to test the new helpers for the bitmap VMA flags
> in userland, do so.
> 
> We also update the Makefile such that both VMA (and while we're here)
> mm_struct flag sizes can be customised on build. We default to 128-bit to
> enable testing of flags above word size even on 64-bit systems.
> 
> We add userland tests to ensure that we do not regress VMA flag behaviour
> with the introduction when using bitmap VMA flags, nor accidentally
> introduce unexpected results due to for instance higher bit values not
> being correctly cleared/set.
> 
> As part of this change, make __mk_vma_flags() a custom function so we can
> handle specifying invalid VMA bits. This is purposeful so we can have the
> VMA tests work at lower and higher number of VMA flags without having to
> duplicate code too much.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/vma/Makefile         |   3 +
>  tools/testing/vma/include/custom.h |  16 ++
>  tools/testing/vma/include/dup.h    |  11 +-
>  tools/testing/vma/tests/vma.c      | 300 +++++++++++++++++++++++++++++
>  tools/testing/vma/vma_internal.h   |   4 +-
>  5 files changed, 322 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index 50aa4301b3a6..e72b45dedda5 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -9,6 +9,9 @@ include ../shared/shared.mk
>  OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
>  TARGETS = vma
>  
> +# These can be varied to test different sizes.
> +CFLAGS += -DNUM_VMA_FLAG_BITS=128 -DNUM_MM_FLAG_BITS=128
> +
>  main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h include/custom.h include/dup.h include/stubs.h
>  
>  vma:	$(OFILES)
> diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
> index f567127efba9..802a76317245 100644
> --- a/tools/testing/vma/include/custom.h
> +++ b/tools/testing/vma/include/custom.h
> @@ -101,3 +101,19 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
>  	if (reset_refcnt)
>  		refcount_set(&vma->vm_refcnt, 0);
>  }
> +
> +static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
> +{
> +	vma_flags_t flags;
> +	int i;
> +
> +	/*
> +	 * For testing purposes: allow invalid bit specification so we can
> +	 * easily test.
> +	 */
> +	vma_flags_clear_all(&flags);
> +	for (i = 0; i < count; i++)
> +		if (bits[i] < NUM_VMA_FLAG_BITS)
> +			vma_flag_set(&flags, bits[i]);
> +	return flags;
> +}
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> index ed8708afb7af..31ee02f709b2 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -838,16 +838,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
>  	vma_flags_clear_word(&vma->flags, flags);
>  }
>  
> -static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
> -{
> -	vma_flags_t flags;
> -	int i;
> -
> -	vma_flags_clear_all(&flags);
> -	for (i = 0; i < count; i++)
> -		vma_flag_set(&flags, bits[i]);
> -	return flags;
> -}
> +static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits);
>  
>  #define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
>  					 (const vma_flag_t []){__VA_ARGS__})
> diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
> index 6d9775aee243..c54ffc954f11 100644
> --- a/tools/testing/vma/tests/vma.c
> +++ b/tools/testing/vma/tests/vma.c
> @@ -1,5 +1,25 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> +static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
> +{
> +	const unsigned long legacy_val = legacy_flags;
> +	/* The lower word should contain the precise same value. */
> +	const unsigned long flags_lower = flags.__vma_flags[0];
> +#if NUM_VMA_FLAGS > BITS_PER_LONG
> +	int i;
> +
> +	/* All bits in higher flag values should be zero. */
> +	for (i = 1; i < NUM_VMA_FLAGS / BITS_PER_LONG; i++) {
> +		if (flags.__vma_flags[i] != 0)
> +			return false;
> +	}
> +#endif
> +
> +	static_assert(sizeof(legacy_flags) == sizeof(unsigned long));
> +
> +	return legacy_val == flags_lower;
> +}
> +
>  static bool test_copy_vma(void)
>  {
>  	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> @@ -33,7 +53,287 @@ static bool test_copy_vma(void)
>  	return true;
>  }
>  
> +static bool test_vma_flags_unchanged(void)
> +{
> +	vma_flags_t flags = EMPTY_VMA_FLAGS;
> +	vm_flags_t legacy_flags = 0;
> +	int bit;
> +	struct vm_area_struct vma;
> +	struct vm_area_desc desc;
> +
> +
> +	vma.flags = EMPTY_VMA_FLAGS;
> +	desc.vma_flags = EMPTY_VMA_FLAGS;
> +
> +	for (bit = 0; bit < BITS_PER_LONG; bit++) {
> +		vma_flags_t mask = mk_vma_flags(bit);
> +
> +		legacy_flags |= (1UL << bit);
> +
> +		/* Individual flags. */
> +		vma_flags_set(&flags, bit);
> +		ASSERT_TRUE(compare_legacy_flags(legacy_flags, flags));
> +
> +		/* Via mask. */
> +		vma_flags_set_mask(&flags, mask);
> +		ASSERT_TRUE(compare_legacy_flags(legacy_flags, flags));
> +
> +		/* Same for VMA. */
> +		vma_set_flags(&vma, bit);
> +		ASSERT_TRUE(compare_legacy_flags(legacy_flags, vma.flags));
> +		vma_set_flags_mask(&vma, mask);
> +		ASSERT_TRUE(compare_legacy_flags(legacy_flags, vma.flags));
> +
> +		/* Same for VMA descriptor. */
> +		vma_desc_set_flags(&desc, bit);
> +		ASSERT_TRUE(compare_legacy_flags(legacy_flags, desc.vma_flags));
> +		vma_desc_set_flags_mask(&desc, mask);
> +		ASSERT_TRUE(compare_legacy_flags(legacy_flags, desc.vma_flags));
> +	}
> +
> +	return true;
> +}
> +
> +static bool test_vma_flags_cleared(void)
> +{
> +	const vma_flags_t empty = EMPTY_VMA_FLAGS;
> +	vma_flags_t flags;
> +	int i;
> +
> +	/* Set all bits high. */
> +	memset(&flags, 1, sizeof(flags));
> +	/* Try to clear. */
> +	vma_flags_clear_all(&flags);
> +	/* Equal to EMPTY_VMA_FLAGS? */
> +	ASSERT_EQ(memcmp(&empty, &flags, sizeof(flags)), 0);
> +	/* Make sure every unsigned long entry in bitmap array zero. */
> +	for (i = 0; i < sizeof(flags) / BITS_PER_LONG; i++) {
> +		const unsigned long val = flags.__vma_flags[i];
> +
> +		ASSERT_EQ(val, 0);
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Assert that VMA flag functions that operate at the system word level function
> + * correctly.
> + */
> +static bool test_vma_flags_word(void)
> +{
> +	vma_flags_t flags = EMPTY_VMA_FLAGS;
> +	const vma_flags_t comparison =
> +		mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, 64, 65);
> +
> +	/* Set some custom high flags. */
> +	vma_flags_set(&flags, 64, 65);
> +	/* Now overwrite the first word. */
> +	vma_flags_overwrite_word(&flags, VM_READ | VM_WRITE);
> +	/* Ensure they are equal. */
> +	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
> +
> +	flags = EMPTY_VMA_FLAGS;
> +	vma_flags_set(&flags, 64, 65);
> +
> +	/* Do the same with the _once() equivalent. */
> +	vma_flags_overwrite_word_once(&flags, VM_READ | VM_WRITE);
> +	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
> +
> +	flags = EMPTY_VMA_FLAGS;
> +	vma_flags_set(&flags, 64, 65);
> +
> +	/* Make sure we can set a word without disturbing other bits. */
> +	vma_flags_set(&flags, VMA_WRITE_BIT);
> +	vma_flags_set_word(&flags, VM_READ);
> +	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
> +
> +	flags = EMPTY_VMA_FLAGS;
> +	vma_flags_set(&flags, 64, 65);
> +
> +	/* Make sure we can clear a word without disturbing other bits. */
> +	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> +	vma_flags_clear_word(&flags, VM_EXEC);
> +	ASSERT_EQ(memcmp(&flags, &comparison, sizeof(flags)), 0);
> +
> +	return true;
> +}
> +
> +/* Ensure that vma_flags_test() and friends works correctly. */
> +static bool test_vma_flags_test(void)
> +{
> +	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> +					       VMA_EXEC_BIT, 64, 65);
> +	struct vm_area_struct vma;
> +	struct vm_area_desc desc;
> +
> +	vma.flags = flags;
> +	desc.vma_flags = flags;
> +
> +#define do_test(...)						\
> +	ASSERT_TRUE(vma_flags_test(&flags, __VA_ARGS__));	\
> +	ASSERT_TRUE(vma_desc_test_flags(&desc, __VA_ARGS__))
> +
> +#define do_test_all_true(...)					\
> +	ASSERT_TRUE(vma_flags_test_all(&flags, __VA_ARGS__));	\
> +	ASSERT_TRUE(vma_test_all_flags(&vma, __VA_ARGS__))
> +
> +#define do_test_all_false(...)					\
> +	ASSERT_FALSE(vma_flags_test_all(&flags, __VA_ARGS__));	\
> +	ASSERT_FALSE(vma_test_all_flags(&vma, __VA_ARGS__))
> +
> +	/*
> +	 * Testing for some flags that are present, some that are not - should
> +	 * pass. ANY flags matching should work.
> +	 */
> +	do_test(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
> +	/* However, the ...test_all() variant should NOT pass. */
> +	do_test_all_false(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
> +	/* But should pass for flags present. */
> +	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
> +	/* Also subsets... */
> +	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
> +	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> +	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT);
> +	do_test_all_true(VMA_READ_BIT);
> +	/*
> +	 * Check _mask variant. We don't need to test extensively as macro
> +	 * helper is the equivalent.
> +	 */
> +	ASSERT_TRUE(vma_flags_test_mask(&flags, flags));
> +	ASSERT_TRUE(vma_flags_test_all_mask(&flags, flags));
> +
> +	/* Single bits. */
> +	do_test(VMA_READ_BIT);
> +	do_test(VMA_WRITE_BIT);
> +	do_test(VMA_EXEC_BIT);
> +#if NUM_VMA_FLAG_BITS > 64
> +	do_test(64);
> +	do_test(65);
> +#endif
> +
> +	/* Two bits. */
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT);
> +	do_test(VMA_READ_BIT, VMA_EXEC_BIT);
> +	do_test(VMA_WRITE_BIT, VMA_EXEC_BIT);
> +	/* Ordering shouldn't matter. */
> +	do_test(VMA_WRITE_BIT, VMA_READ_BIT);
> +	do_test(VMA_EXEC_BIT, VMA_READ_BIT);
> +	do_test(VMA_EXEC_BIT, VMA_WRITE_BIT);
> +#if NUM_VMA_FLAG_BITS > 64
> +	do_test(VMA_READ_BIT, 64);
> +	do_test(VMA_WRITE_BIT, 64);
> +	do_test(64, VMA_READ_BIT);
> +	do_test(64, VMA_WRITE_BIT);
> +	do_test(VMA_READ_BIT, 65);
> +	do_test(VMA_WRITE_BIT, 65);
> +	do_test(65, VMA_READ_BIT);
> +	do_test(65, VMA_WRITE_BIT);
> +#endif
> +	/* Three bits. */
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> +#if NUM_VMA_FLAG_BITS > 64
> +	/* No need to consider every single permutation. */
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT, 64);
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT, 65);
> +
> +	/* Four bits. */
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 65);
> +
> +	/* Five bits. */
> +	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
> +#endif
> +
> +#undef do_test
> +#undef do_test_all_true
> +#undef do_test_all_false
> +
> +	return true;
> +}
> +
> +/* Ensure that vma_flags_clear() and friends works correctly. */
> +static bool test_vma_flags_clear(void)
> +{
> +	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> +					 VMA_EXEC_BIT, 64, 65);
> +	vma_flags_t mask = mk_vma_flags(VMA_EXEC_BIT, 64);
> +	struct vm_area_struct vma;
> +	struct vm_area_desc desc;
> +
> +	vma.flags = flags;
> +	desc.vma_flags = flags;
> +
> +	/* Cursory check of _mask() variant, as the helper macros imply. */
> +	vma_flags_clear_mask(&flags, mask);
> +	vma_flags_clear_mask(&vma.flags, mask);
> +	vma_desc_clear_flags_mask(&desc, mask);
> +	ASSERT_FALSE(vma_flags_test(&flags, VMA_EXEC_BIT, 64));
> +	ASSERT_FALSE(vma_flags_test(&vma.flags, VMA_EXEC_BIT, 64));
> +	ASSERT_FALSE(vma_desc_test_flags(&desc, VMA_EXEC_BIT, 64));
> +	/* Reset. */
> +	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
> +	vma_set_flags(&vma, VMA_EXEC_BIT, 64);
> +	vma_desc_set_flags(&desc, VMA_EXEC_BIT, 64);
> +
> +	/*
> +	 * Clear the flags and assert clear worked, then reset flags back to
> +	 * include specified flags.
> +	 */
> +#define do_test_and_reset(...)					\
> +	vma_flags_clear(&flags, __VA_ARGS__);			\
> +	vma_flags_clear(&vma.flags, __VA_ARGS__);		\
> +	vma_desc_clear_flags(&desc, __VA_ARGS__);		\
> +	ASSERT_FALSE(vma_flags_test(&flags, __VA_ARGS__));	\
> +	ASSERT_FALSE(vma_flags_test(&vma.flags, __VA_ARGS__));	\
> +	ASSERT_FALSE(vma_desc_test_flags(&desc, __VA_ARGS__));	\
> +	vma_flags_set(&flags, __VA_ARGS__);			\
> +	vma_set_flags(&vma, __VA_ARGS__);			\
> +	vma_desc_set_flags(&desc, __VA_ARGS__)
> +
> +	/* Single flags. */
> +	do_test_and_reset(VMA_READ_BIT);
> +	do_test_and_reset(VMA_WRITE_BIT);
> +	do_test_and_reset(VMA_EXEC_BIT);
> +	do_test_and_reset(64);
> +	do_test_and_reset(65);
> +
> +	/* Two flags, in different orders. */
> +	do_test_and_reset(VMA_READ_BIT, VMA_WRITE_BIT);
> +	do_test_and_reset(VMA_READ_BIT, VMA_EXEC_BIT);
> +	do_test_and_reset(VMA_READ_BIT, 64);
> +	do_test_and_reset(VMA_READ_BIT, 65);
> +	do_test_and_reset(VMA_WRITE_BIT, VMA_READ_BIT);
> +	do_test_and_reset(VMA_WRITE_BIT, VMA_EXEC_BIT);
> +	do_test_and_reset(VMA_WRITE_BIT, 64);
> +	do_test_and_reset(VMA_WRITE_BIT, 65);
> +	do_test_and_reset(VMA_EXEC_BIT, VMA_READ_BIT);
> +	do_test_and_reset(VMA_EXEC_BIT, VMA_WRITE_BIT);
> +	do_test_and_reset(VMA_EXEC_BIT, 64);
> +	do_test_and_reset(VMA_EXEC_BIT, 65);
> +	do_test_and_reset(64, VMA_READ_BIT);
> +	do_test_and_reset(64, VMA_WRITE_BIT);
> +	do_test_and_reset(64, VMA_EXEC_BIT);
> +	do_test_and_reset(64, 65);
> +	do_test_and_reset(65, VMA_READ_BIT);
> +	do_test_and_reset(65, VMA_WRITE_BIT);
> +	do_test_and_reset(65, VMA_EXEC_BIT);
> +	do_test_and_reset(65, 64);
> +
> +	/* Three flags. */
> +
> +#undef do_test_some_missing
> +#undef do_test_and_reset
> +
> +	return true;
> +}
> +
>  static void run_vma_tests(int *num_tests, int *num_fail)
>  {
>  	TEST(copy_vma);
> +	TEST(vma_flags_unchanged);
> +	TEST(vma_flags_cleared);
> +	TEST(vma_flags_word);
> +	TEST(vma_flags_test);
> +	TEST(vma_flags_clear);
>  }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index e3ed05b57819..0e1121e2ef23 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -36,11 +36,11 @@
>   * ahead of all other headers.
>   */
>  #define __private
> -#define NUM_MM_FLAG_BITS (64)
> +/* NUM_MM_FLAG_BITS defined by test code. */
>  typedef struct {
>  	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
>  } mm_flags_t;
> -#define NUM_VMA_FLAG_BITS BITS_PER_LONG
> +/* NUM_VMA_FLAG_BITS defined by test code. */
>  typedef struct {
>  	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
>  } __private vma_flags_t;
> -- 
> 2.52.0
> 

