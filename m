Return-Path: <linux-fsdevel+bounces-76732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOVQFIorimm6HwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:46:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2D113CF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88045300BB91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDD3ACEF8;
	Mon,  9 Feb 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImpP7lor";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qwZcWCYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C24371063;
	Mon,  9 Feb 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662786; cv=fail; b=BptP8+u2zpjifP7A/2BVYKVqP/VNzjnTUm1RFllCw86sMRwWhGu6FeLKxj1yS+L4dzjktQcTYrueFxWCkTf8HTe+xW99c+j4CSjsNZtmdZuCyosvI8z3FDB/Ir0XIIgsOWlvwaZv1ySenFfzppZw/zUerhfC4LQExvoAr5rsVZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662786; c=relaxed/simple;
	bh=IBfnkreWd1+HxzRjM7z8pUDmsB+nojxk4A8iqnzNlIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pg/m8pN7cgjFN/N8TihWgOgaKTJlbytDWvgela8jW4rLaBBY+8t7nuqEzTqi6hfBjn+JVT3NFZIiK1vxYDipNuFJ3qxGXXWXAjufT9dcvkK+qHS3woMhQCVxunQoWyvcUOMVI9ZAiWpExOymCeTnOhRU1L60fnmrhjG7BKVXsyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImpP7lor; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qwZcWCYF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECY9C1945056;
	Mon, 9 Feb 2026 18:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5s8TRZ/jtrLUZBoYkh
	u52wx1B1wOSakzJp7RDyxNJG8=; b=ImpP7loroBD3L2xxbaG3Os2FRgvW0I2pqC
	ASd5bQZsmIOYfHWl5kKj8ePMpMhMrr2QfG+3UAatIEPHGWJfGzElUgB5u6x/A2vs
	nnBGQyS/GYWw4yT+dkv2DappyhtRst+GniTcbVCnAwc3TQrWbS50KQXwCm9fEFjH
	jUFdXC5jgxLrqMoBY0uhCQSUSsiTQgZvd7dfSjN7BHzLDieR6XJowTDntV1uv1yQ
	VXtUulfqza3QzDtRbzdA6zdD6gxR0RNsv1xe5kRR6u3dOvh4ckMhMztfKDKlIGPb
	ZCn1I594lwfbnpw9l7IwWUrMqixL1G3e+Vmo+ZGQwEdDXC9A3WnQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xj4jh29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:45:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619GxguQ000579;
	Mon, 9 Feb 2026 18:45:40 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uudcuhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0CSeYpH3K6dT8vO4xukmEPzCZ2Tjm15S6+JG7ta1DKO1FdVgXqusXHfaMkNEBxhLloqG5bDDFldzzwRjujYeH4Brll4PVFwKqOFobkpHM5AB7/VZnQBjGipCdRg+CcRyCDrPU4J3/dnS4m8XaqEvtG+y3wxZzn32Nxb8Q0agWp/N9dZrYk7FpgiV/GEwYLihmz01E9a1H73M0et8LpUc0EOdUFL61f1gKJnzPHQRbYPvlfB04TU3cSXoQiEvqEH5mCOMhNBU31182MwfbF7avIJipvAzcj/EEAqPTcQ3tcljYkji9f+AQbfSkI9tolqvB4UIOtfzIbN2R6fUuLNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5s8TRZ/jtrLUZBoYkhu52wx1B1wOSakzJp7RDyxNJG8=;
 b=HAipxY9dRcmpiPALzH2cuRI2tjBWQxCudn/R5mQpPulC6eNt2KbgQUDR/bxLF6in0UM8gdzRX2opOIx99rEb7OpF5FzUHEViGK9I77iFn1OMIHTYGyPIcvLcuL/VZJY6/0C1R9ZFAYkmWsAepqOosT7/jMztOJ+5CPUYX0wXy4NCWsQTiRi9e7F9yr8XUPmgB9WgK1BjOtPTmn3+oUCE30B2VoSq1OQuzZ7wBnmLwEyqLLEYVpRvV853CBsnkUXrTgloYjW2AUMdGyMG1Gxlq/soT3VDqpNpyRaK6RxnUzlU3QxlEbzD4sbF3jTa8aehpwsAtiz6SMTIsvbicq5EUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s8TRZ/jtrLUZBoYkhu52wx1B1wOSakzJp7RDyxNJG8=;
 b=qwZcWCYFHmrpihXQyG95INko8EcaofZWDcq2jUHelZsDerXUkzqllFCsKwZCUu1OFzHnE692uSGt+1oeeP0EmvSPQUxEUahpZDR/U0etXQOo5qIqJ7nltSoTyK4rQiSK55NPM+svN6gS6h3FqQ4ENzWokJodkaGaEiElZI85YAk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 18:45:32 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:45:32 +0000
Date: Mon, 9 Feb 2026 18:45:22 +0000
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
Subject: Re: [PATCH v2 04/13] tools: bitmap: add missing bitmap_[subset(),
 andnot()]
Message-ID: <jxt4kif73tbt5aai2aogo2pgho2tlpjkhimjtcw6y6vkemn22c@mn6jzgnnbgxs>
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
 <0fd0d4ec868297f522003cb4b5898b53b498805b.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd0d4ec868297f522003cb4b5898b53b498805b.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0058.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b1ccaf-eb9a-4bee-3d7e-08de680b6793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fps0yfTrdTMxssm4S+yygYlfo1Zm6vk5gvXG6j22+RIgHgK7Lagp9ERLZQ7c?=
 =?us-ascii?Q?C51w2v/Shwhwb1v80iUfKAwJ2U1jfeQrditJ3lVXmfMljZYvqclNBNjl/SYW?=
 =?us-ascii?Q?0q+8j2qtifYUceSW817gcY8GkEiV6iGtOthK++bjLuPdXp9jTOo5ns/9/5Ly?=
 =?us-ascii?Q?k5ywtiIyO1NVcw2lRivCFahDNNzKLwow9EQvecxMsMkPLCuOn87R+H1j97Fr?=
 =?us-ascii?Q?kxOk29TXYkSS1M6Ef1YzcmDg+guV37sPW/HQgnSWvUQuQ3LAC/OFK/F+zODC?=
 =?us-ascii?Q?CRi3Ys2FGl6TnNNsYVTj5zsgFyMsn5BqBAOjd8XshnY+HgLZejCDNjAQaVJl?=
 =?us-ascii?Q?9DlNAfbKBQoeJECJYpBQueewVcWvoradZ9Cd2r5jsgpvxrgudFQMcibVzh58?=
 =?us-ascii?Q?pyQ8s7XoslDrwEoWOBH0SFjq0re6kpiuGTD2jzwf3euj7T9aEhBphr1l0p1K?=
 =?us-ascii?Q?59Ec7IsQg6wphNEAsG5bbw8crUPuU9k2aX/RZZaClHetFcLryUIdvgVSObz6?=
 =?us-ascii?Q?SQenD5n104gCRD+J4JIf0CZUbbYGVYZr89tytmhRszgytOdYWcHdGx3Pjxih?=
 =?us-ascii?Q?h+YT/QNlw+OHQUEMtnHvfYFAXt0BANhQcQXds2YInCyTZ+IUbHQTm5FxsdV5?=
 =?us-ascii?Q?ihOpMlGsUG6UWWt5AU57yX7QjZp0y8kV5LZtyv4GOFCsK87+c82EuGJBr9px?=
 =?us-ascii?Q?cVPuMMWvJRcRmeiT1rTwMc/2GxkpUdy5H7ycQVoaz+hHpKMnPLT8HLCTxBOG?=
 =?us-ascii?Q?Mj/exjpf3a5YMAxKPXEuTi/3dZ7lnA9+efaqiYv7iMx/vTTzeGE4IedoiDxa?=
 =?us-ascii?Q?m7ElmcdHy3Hk8vQwy4cSTgCBsYTscVgIAVET6Zuv2ekZNWaR/1yk5xd3W0SQ?=
 =?us-ascii?Q?PGXiGWgwiISzrudppNIi7qUJqG+adcg+In8gSguzyFRKjI5tJ/R5HsBEyFJx?=
 =?us-ascii?Q?PUKVoSQHa766Ne41rseRff3anwAoZsfmXjbHX7oj+7a1Om2IL1hWffgLuIhw?=
 =?us-ascii?Q?g3RSsGfnSZLeNgbCNwbNS+INtxFWwL4FB6T4EA2eF/6a1NCi+k36kZ0VAe2C?=
 =?us-ascii?Q?On+c8+/Z7ko4Lfh9SLVJQXtGiAhGAwME9hX0aPR0DCxzmLb8ZeE4QZHs4y8J?=
 =?us-ascii?Q?1OYHcGGVEcbLDNhCv1h3mEeb2E8MtUbXtjBZSvjp7nirSiOlLzIrysgtYTQO?=
 =?us-ascii?Q?END44hZjSwAtpQ6pvpcMDx54qJu3pmRXKgrKTWXo+K4YSc6MzD368cs7FC9O?=
 =?us-ascii?Q?CXKOxF8iQfJRlplyK7wkyrTedNTWSSKriGowzqF3kregOzQD/W8PG5JGvre/?=
 =?us-ascii?Q?ijG0iKS15alrzIsxPzrRzcRkkVOc43Z/NpZEcd9B0wQnTQchXVLgR27GFUQu?=
 =?us-ascii?Q?phwCKjfoEUL7X0NMtz/RlH7CEs7Y1JIbave60cin+SFpWq9OvhzVLcMQT+xF?=
 =?us-ascii?Q?njg91WisKpNqCTFxUAxKvwfG49enjMnz+FntW6TquWugJrUFkOmaEgEvO1h0?=
 =?us-ascii?Q?XyVjA7mBTs5mrWyGYXwRa7BWh97ftkxFsu9/BxObjqv1lcKGwy23ly5/rChF?=
 =?us-ascii?Q?RusYfr8zUHo4Wsi23aU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2SwMrdqaCGUyFrvbJ5e25f/bj/jjBqtriwpxNQRLq1FNe0eWQuFwaYdlXBJ?=
 =?us-ascii?Q?gHyF8t1itdk8eCwlPo9uKMGVmkHTiZm4zrE4eDKmrdu0KYxF2N9PYi0qq594?=
 =?us-ascii?Q?7j7L9qHskcdnTH/mapUh09GEj8YaHm6LcEkBmZcBg3CWdY+7wiF6yY5P8zCB?=
 =?us-ascii?Q?4ocQmdQts4ZBF6iNNVj3FVRG+FxOdLpRWJLROFtj9PTFtKKx5dnuGQJBoUMS?=
 =?us-ascii?Q?YnwOGOBuziJ06gZkMer8I1bI+Q1k0KUI1tvtz8ExkXGxrdeINDQEn8XUtVCk?=
 =?us-ascii?Q?ZBmDaROKCpNFyuvSRZGtjZyx7zYTLV9bcAhvPidowxM/ei2vqDiUc/L3HKDJ?=
 =?us-ascii?Q?CwjrXBoQWDmn1uo5d6b1wQOEMtT2AoqZOwFEBBb0opE3m8gzUrg6TTRkIyd9?=
 =?us-ascii?Q?kBo4wRnN0tnXipr91Wdl2oF+iW208epMjcOgo022ANUbhS2JIHVTMN6qTKLQ?=
 =?us-ascii?Q?NO6wQRGZ01bYsBZT6nBTv2VBG0aCYy30ph6gRrTeP30MVELUeaIGWCZZPtyW?=
 =?us-ascii?Q?1jQ1AQ1iRkrmF2+F/+nRUpkjPG8Pvt4sYjdlbM2SeaxO+pPCdyWlhRa92g5B?=
 =?us-ascii?Q?pQohMOAt1SBvnV0isVJyYBVXE2gWwdBoqrU+0+KuFw6CjVNty/L3hJhypLaE?=
 =?us-ascii?Q?6nkVNOfV+nGgAnllnRroDT8aINBOFDEbrlt3SwFKxzlQ0la3MEi60U6lYcG6?=
 =?us-ascii?Q?z71Opekxm/f5swmyE6I925MoY3ZL21CyKGe+XVBGD4UK0IQhpy985IpVIm4Q?=
 =?us-ascii?Q?uZtvM3ftg7Yqm0z+CAK8rtCOuCYY6Pd3VfFKNehUk9CK5FiXQVixXRbCtT1I?=
 =?us-ascii?Q?L/vOhZImYydCgtp+pu+2968IP4LMSnug8KBlBW9KDo4tm6KnJn0oJ1X+ILUv?=
 =?us-ascii?Q?jEFntrHaMCr7euEcEU8ZpWMZGabaE76T+1czHrh8KmXJ8P/kWP1ArsM9QHF8?=
 =?us-ascii?Q?5x89s0skjKDZQbAFv0aSRzNBYOx6fJCzlKAY4emOwq47YTIRM0D4D4dXbrss?=
 =?us-ascii?Q?zqIut4hNNYXagkVe88fPRi2aRL2+52q2ELEpoSM+e4VbCbSOvcatOwR8uPtB?=
 =?us-ascii?Q?XeoJBTvCbc0WJyTJEqwEldt53wBN6wEsI0AdO3YFSvQeqRz6ojNmLIXmXw1T?=
 =?us-ascii?Q?FGzn/J7LAbcpzkVOdJNsi9kuBwamUjK3qUMwYDgPwSaCa51LFYaAX6Yome5n?=
 =?us-ascii?Q?afTnLLdhz0KpOrxPW81bOdexutP1e5v6vMQpJIk45WIQnd1zA+OnLV05g6Aw?=
 =?us-ascii?Q?53YJzvwWU0Jv8SL0WNu6FZc3b7VA148t5ji8qLhXfhq3kFX/7RkpEzG51V56?=
 =?us-ascii?Q?SnpOC8rvqrKKYrDRj5vAvTOzoYgQdPmIZ4vEz5QSXAL9EP9zm7l044WnA3pn?=
 =?us-ascii?Q?nIanm05kXdmTtJUkAr2a3aLmkWizmTVeNyCOKMJi2bf+tKmvG1O+bkASChKd?=
 =?us-ascii?Q?T9ZN/1nYggbiv1ZSNDbXbRkr3Tlv39RfjwNv1OoJnlcyq4o/nJsVzYrRzjx8?=
 =?us-ascii?Q?qOxokHKekR+0r5jCvVAkGEYifJJeAG7iMg79/yfSTvBvg9Z56UA0TpN2VxXC?=
 =?us-ascii?Q?crubLT6p5hRVk4jsFK4I+XNXfoMX+r3mGBsGNSp5OYO5UwTwJVWWnxojsBrF?=
 =?us-ascii?Q?+Wbkv/QdgumW/sDKW0VVcDr6JglwF1qiNUz7fZ5yviJZltOqQuaeKy18LII5?=
 =?us-ascii?Q?JTY5RON6AKMbx1s6vRhxD/VdTNi6JUSYWqnqQLgkmMF/8yRZq/uNbxymGp09?=
 =?us-ascii?Q?gttMQJByiQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hSzfZTh9f+6bsYNSI1+sVlhGVmJcx/yRflJuLrjm8kFXTdDoYLgjJ8XsaIpvQtJIX7ZYqPxbheqJRvYoHQE66ZaH1lAv8vSdH6ko2ZjXfpxCiZBhKH1LjRvuwU2hWgy4Mo8t+I/7UN1lnNc6QWwlxeRkvyskgPFfEsGRq0w5hP2FmRl4GEGNmgpr46HWRgEhsERzFQkcPfM8h+r2Ki7iZqdipw2bzvdQS/09lXuHlGhZjV6A0Q6912J3/o0tYI6yZD4IR6Fr4pErVadbmq1aZ5hMF9u07uJcnnElNERanknDVuxIP8cZQG2EogxjdjSYotgQxObd2wANPK4s2MGNyPZCYmqVF2rAOEAK5MFZCs11MhWn6L1g44ZukVZfwXdt54BMJhCKGElwVHVIKa/KkmJQgM/CZd4945gKsM8GjOrGM2UVXxInVuqxe2L4aoACmpHbnRKXFUTk3YGJJgKexKxDH+JWnl0FhNtUbwlEP7sj+5njGEDE9Cmrf9Tiopi432KAITRbIhdlSZ8EzI+YvFXgWKM+sKsj9maInBkPf/LookxGhnUvX2EtX0KqIzxiySgu18q+xa2pYjYD9+Tx2ROIpWqaZBy9M6ycOzzKoWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b1ccaf-eb9a-4bee-3d7e-08de680b6793
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:45:32.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIsOgFHG+5FhPT0DdU41+KVm7gXiXQNXRuN3ohz16aYeUhM0VlOb+vJGhbWXBKgegR04WPOepy6rsN0zwfw4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090158
X-Authority-Analysis: v=2.4 cv=Adi83nXG c=1 sm=1 tr=0 ts=698a2b55 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=t6BfYyOvF-pkWyapnwYA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12148
X-Proofpoint-ORIG-GUID: xEp0tnjdpguBac9gsWgNOcbowExM1dgb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1OCBTYWx0ZWRfXyQQBnXlN8nEW
 bjigLXpwfiiPF5dtOmcrL4bkwI1cVIdxoYTnSuXYFqlCWWwU8C5o/mX2K0XDXDS9oNNocE1j80v
 MkZ6ubNG+tqFmBiLbm4tXOpAJGP7My7fAdEfqnHv4AwKin4qk0cpGljfoICC2RWzE0j7qACKD7b
 GLoKrrj/nAYlh3N8FdvDDpFkE0fzKM19CJShpQtjWGzWHqZ3gRsqge7T35kMmmbwvpvYIzOCwD4
 GoJ1aOdmmnGxnLi2If2gXXbBVFW6nx3pqRNVb955GOMbOdlOAsW7kW7gbHJVQtMXq1xnRXM3yG6
 CGSCySn8DPnQ1b5eM4XEjAFDV3UDhzbDtlm2zJrE9q3Syn8+qCDCM+/R1jpMK5Dj7Gls1Le2UHh
 i/PNavW06yZVHhcYyIo24bP/7+rhsAWbiUYldrvdopRAnE5S7MyuFJplqm28M3felhW+VaXD7U4
 NJcXZgqOhI9wJOL/V3G/Y5FVX9W5fZkWulhAAfKQ=
X-Proofpoint-GUID: xEp0tnjdpguBac9gsWgNOcbowExM1dgb
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76732-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E1B2D113CF3
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> The bitmap_subset() and bitmap_andnot() functions are not present in the
> tools version of include/linux/bitmap.h, so add them as subsequent patches
> implement test code that requires them.
> 
> We also add the missing __bitmap_subset() to tools/lib/bitmap.c.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/include/linux/bitmap.h | 22 ++++++++++++++++++++++
>  tools/lib/bitmap.c           | 29 +++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 0d992245c600..250883090a5d 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -24,6 +24,10 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len);
>  void __bitmap_clear(unsigned long *map, unsigned int start, int len);
>  bool __bitmap_intersects(const unsigned long *bitmap1,
>  			 const unsigned long *bitmap2, unsigned int bits);
> +bool __bitmap_subset(const unsigned long *bitmap1,
> +		     const unsigned long *bitmap2, unsigned int nbits);
> +bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> +		    const unsigned long *bitmap2, unsigned int nbits);
>  
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> @@ -81,6 +85,15 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
>  		__bitmap_or(dst, src1, src2, nbits);
>  }
>  
> +static __always_inline
> +bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
> +		   const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits))
> +		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
> +	return __bitmap_andnot(dst, src1, src2, nbits);
> +}
> +
>  static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags __maybe_unused)
>  {
>  	return malloc(bitmap_size(nbits));
> @@ -157,6 +170,15 @@ static inline bool bitmap_intersects(const unsigned long *src1,
>  		return __bitmap_intersects(src1, src2, nbits);
>  }
>  
> +static __always_inline
> +bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits))
> +		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
> +	else
> +		return __bitmap_subset(src1, src2, nbits);
> +}
> +
>  static inline void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
>  {
>  	if (__builtin_constant_p(nbits) && nbits == 1)
> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> index 51255c69754d..aa83d22c45e3 100644
> --- a/tools/lib/bitmap.c
> +++ b/tools/lib/bitmap.c
> @@ -140,3 +140,32 @@ void __bitmap_clear(unsigned long *map, unsigned int start, int len)
>  		*p &= ~mask_to_clear;
>  	}
>  }
> +
> +bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> +				const unsigned long *bitmap2, unsigned int bits)
> +{
> +	unsigned int k;
> +	unsigned int lim = bits/BITS_PER_LONG;
> +	unsigned long result = 0;
> +
> +	for (k = 0; k < lim; k++)
> +		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
> +	if (bits % BITS_PER_LONG)
> +		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
> +			   BITMAP_LAST_WORD_MASK(bits));
> +	return result != 0;
> +}
> +
> +bool __bitmap_subset(const unsigned long *bitmap1,
> +		     const unsigned long *bitmap2, unsigned int bits)
> +{
> +	unsigned int k, lim = bits/BITS_PER_LONG;
> +	for (k = 0; k < lim; ++k)
> +		if (bitmap1[k] & ~bitmap2[k])
> +			return false;
> +
> +	if (bits % BITS_PER_LONG)
> +		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
> +			return false;
> +	return true;
> +}
> -- 
> 2.52.0
> 

