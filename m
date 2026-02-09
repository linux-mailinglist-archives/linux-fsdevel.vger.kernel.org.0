Return-Path: <linux-fsdevel+bounces-76749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P3oKLY8immsIgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:59:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9B1144DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1968C3026151
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115D2428468;
	Mon,  9 Feb 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dHy0o4MB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wXpXpcZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA03A0B1E;
	Mon,  9 Feb 2026 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667173; cv=fail; b=nwYP7wp8qD1mUeZ1R53MyyBWUdxMX2mbwM5CmtZGS+TieT/rTpuQiWfersYWEd07nnGEu26w6i4onBw4vbOs8psw8o6gHRimNpsUG7km1i/yWuk3uBSZyDf/boRslvg/RYg3msmfw9tTxNWrZKbvKoUoaDui8wO0rZwu8+zLPo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667173; c=relaxed/simple;
	bh=G1ZQHEpY8cAPpwRXtCkec1mkJ0w70y0oEOIzEjMWOX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ax40oG68xVM32NvFwlE1p8GSHxlwGqJWqbmE596DHD3mZl/77EenmWOoyLgNay2u4xENGXeKzsWTCelFxjmR8jDDrWvja7L4Q2tuCtT3xAnL+NjdBpn0GK81RpSAniwyObZ89AmEjtye4FttMDseSKoA8TArmEsYo2xOsM/faT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dHy0o4MB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wXpXpcZe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECi4J1822662;
	Mon, 9 Feb 2026 19:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Jf5XTdoXPxM9NkO9iQ
	ikReodhlfiuZtNKscDKPVSwV0=; b=dHy0o4MB1/EwRLZnCdl6P7/k0s/tPzBwBB
	SZnIGpigmgpCVpLXvjkSp5j38hf0uFeXa1bbLx0Y5gtLSot+E3WO0cPNU+ql11IW
	mPcHBW6X4pC5t5q6C+HEwgTGDFka+77icxqBQg7PS3TvNrxXMs2/H7OCUMM1Zvge
	GROGL9BNClaaRp9Niy/FuqCMv0y3ucHP4Q2tLzc3CHKoN2G+ukOflxLwOULz0KZq
	31Y2v9dfA8gsczX9shlK1xS0Cfn/uE97GRaxPuDVu2M0FYX8GpWq1iPZqwugZPvx
	AppNn7U94izTGjtPtObX3Nwu3D/WjpbghFo3fx2Wlq4OhgEYchuQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xk4tnn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:58:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619J3fdx040824;
	Mon, 9 Feb 2026 19:58:40 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uukf427-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 19:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsVhCLs/IQzE8ESeEm/5wdKCtXU9L4kFAcAv7W2nmL/pyF5WsN9XuA2cCwD+uFrWQluevYNMoC9KJBIuW5wvdeXgk2058wmOU4twh7bg9Kbc/Ac6juXdVM25HwptK57Pf36fWCDXO5X0WpKepew8rAwJfaankPjiE2Lu7GBy0LWfzn8u36IUuV9LlBmNyePCp+8l7HuMbZkS7GjeXtGSz/nk0zyiLR7dWLmgVXPKzUuUOzTwQWo6NyJdOK6EMsP0fTnus5GskP6ZdoEWLeg8DzL9oh8ZjV1O7M6Kc/ErojaQ2qAOtkwcJy51KNSu2Tdd/d5+ne9sv4mFjbclR0HUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf5XTdoXPxM9NkO9iQikReodhlfiuZtNKscDKPVSwV0=;
 b=I0rw8OC4IVLm18wZ2AogxlqDPw7Cb90AKtfD62/we3765qorf96Bv87+afDmCCRUZlv06lEVcBaiF09CHOW2f+TjjSKuDC0pajOgiiptPSw3qMM7Dq7ntFqBsX6rOyDDuwwPE1bNPZnbjNVTRDCRzrsTbR97LmdghFFwjzE7X+qzwJbVRJO+m4KbBVDoOXg/osxbo49+KImOzBtMoAAWqWGMaTuQPIPAqp0wxd44e56rO9wakWe+6Rk1uoKPZoJQKw5lFZMGCFVdsLYEfsh761nNwJqQmTiLET31UuNBwdsUN09OSdPFcVLtVY639YJMFxCfO5PN+kOyi0UE8lDeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf5XTdoXPxM9NkO9iQikReodhlfiuZtNKscDKPVSwV0=;
 b=wXpXpcZekiZGL6hbJ53Lh+xEjm+C/wJZ1R9Mwd9E19Myqn+l6ktrg5Sw3eAEosiXofiMqc67XEe8GpxYlMgHXe1art7QkYwsH3GrCXvmj5oUyvdMylp9BRlCVvU5pRCe3cgc0PVzaXqfsPd259C9GE+QxYBnbl61PKjZD/47VbI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:58:34 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:58:33 +0000
Date: Mon, 9 Feb 2026 19:58:22 +0000
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
Subject: Re: [PATCH v2 11/13] tools/testing/vma: separate VMA userland tests
 into separate files
Message-ID: <opopo4rlyxz7upi2bzrx7e6cyji2nmaynvlhvr2nzvtvb5pfxu@4fekgb5faybz>
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
 <a0455ccfe4fdcd1c962c64f76304f612e5662a4e.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0455ccfe4fdcd1c962c64f76304f612e5662a4e.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ0PR10MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4ab9af-d411-4db7-0c15-08de68159ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/++uqzhMPkluCcYGDkOmYhKy0uGiSNVGaFyH5ENJJGBGAuIHUGHQ5vwZF9I9?=
 =?us-ascii?Q?Xqb7wnOwFjb37PT+vjuWWSw2CZlEepTF3GYNv7h+NEcAE+sDqbkl1w/ytsB2?=
 =?us-ascii?Q?CPDWitobkiz2iCXVXfy3W2f2XJ1xWG2Od1eBE0hvBR+xVgVDZ+VBnkwyUv+D?=
 =?us-ascii?Q?NcoOcA7mr8S7tfKAShBiEjIxN6jhCt8docfyElPO3Lz53OX42IKLm4ZvIo5j?=
 =?us-ascii?Q?0a3+mFOdNvT++Oj+l8JIqRBmP0fBZ5rwS3UW0nXRdNkQEg3zpXyS+potKNz+?=
 =?us-ascii?Q?0CoNTVDOMzzoyRX/+3jQd3TEnK4OFLUM8IjQgyC1PPqjDMux38iMFoUdNbFZ?=
 =?us-ascii?Q?AfA2raCTt0cVvf+9eZLeKymYOjTIBRn3IT2iEqyhPwzYDgSS7eVbJQl2R5hY?=
 =?us-ascii?Q?yVsa5ZFX0X/03BLoHZtfbG1jY10XdpIfS4oUkaCJZEQ7x0qnlGcOeRtGBvEy?=
 =?us-ascii?Q?u+6nrP5/UpYia0DjsSxdk4YuVvTWHKJ5y5U9vmQwwqXHU/HLoVas2V81hflZ?=
 =?us-ascii?Q?wCEdM9yV3qH+3e9xgtteOzSdalcnnxdk0MnU0ku9qHD/8C1RnlHR/gcA7Bqu?=
 =?us-ascii?Q?R8X61WtPHIZ674RuU4xYHg/NvCvsbTK9uu4EyuQMDfk4GaWos0hqSBmz6SkM?=
 =?us-ascii?Q?LTinTQa2KhlgpO6uzKZ7ITK5o8FJs8/EkSEYhyWPA5DhPUy+NGDLG5zPF2q9?=
 =?us-ascii?Q?XCo60XBGwPvl1ZoY/n5nFi0gDej7eOOR0GVPIjsgwX5hHRNDYoy0/dUex3Qn?=
 =?us-ascii?Q?pGkMHASt9756dLd0Noe7A35dJ6Q9qoq/g6AkUEtosS1GEQjh/D1q4CaAPVUA?=
 =?us-ascii?Q?8FcdVzz0NwE37lpR5e01G2gU2rCab2xSu4JRsDyIUQ5hc/6mEI3c1BHdnIjO?=
 =?us-ascii?Q?4fnVxr/XIPC+UPOliMPPYKmSsXetZRhZofHxqJACK5p3WfpV156ZVd88aEdY?=
 =?us-ascii?Q?EkbOHEA08rTJ+STwYq+BdFiDKD7ZUjz/75D5Jb8Mb5wvI94D/PQbTjT3fM5E?=
 =?us-ascii?Q?9a7G1iZbkIsIKVAURNctEbIkQvdNK+TDtUqApvg6b8mmJrAWjzcqw1W8AYs1?=
 =?us-ascii?Q?XvHC91gcB7eX6oITGaElh8VA/u1nyPuV1/krWBz20E47M1IN9nyYDB7W5VbB?=
 =?us-ascii?Q?Q7FNWzV7Bvc4JGQU9bdupRDUUi4InAdCOyeng8v+9r8phsaadWSa2zwSi2qL?=
 =?us-ascii?Q?Bbk0er6ltIhJEjxfKRoJmPYiZG5oww1rZWfGx0FR36Syof60Jy1TNTVhZuHK?=
 =?us-ascii?Q?tJ4Bp4g98YkfaLmnm6MvABtS7tNm6blfBORua9OuIf7uKI6QMvTYYcvX1c7P?=
 =?us-ascii?Q?z4gSTyqTYMbXfeTY6jtwF2cgqm25TAJlwVBGrNc7jq2/NVdp7ghBN6fr+hwn?=
 =?us-ascii?Q?nQyPjAL/EmWRHtn34lex64LvSzzDekUIJ/a+3dCbxwE2OAd0depKNGccwcnv?=
 =?us-ascii?Q?4cUXOR+yutdE7zU3bAdVl/RlI3V5fOLKRIxFrVYLTk62holI2dpbQ8zThNDy?=
 =?us-ascii?Q?HAw2QPRdjbWTE3wNRcIfcCs1s1GnNAH2tCo0EMU5V/fluZF9CyTlr3EBcpip?=
 =?us-ascii?Q?twjv/05Ych0aEVZ3RQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9SQ5gwFe1NYTEW0WJJl2JpZVCq6UisE8Z8KNPb65AN0b7qqppO9duRLw2i/w?=
 =?us-ascii?Q?niEMg/cRzQLtMWdMTk0MOCyraxBgAopN3lm3CCZT7MKV0I2qkgNvJPc3XK0a?=
 =?us-ascii?Q?tJvhIgn6AT1T+w3WPTu0Kv1SyJk8tLrFRBTK9Fc/XYGL+saPvjH8uIU17kcW?=
 =?us-ascii?Q?iyg0a6V/dvqUnpz5qL1Hut6YKl5l5UVRyvuNhgmAJ76PAqHvJDcfrWPk1Ifx?=
 =?us-ascii?Q?JTbGCmXzO4XFoGxc7rwvDY3/3m0bWq4KYv7JA1WkCNtCrZMWB4f8jNt00OHG?=
 =?us-ascii?Q?SnJKLg9QMn6R0Li5q+uaNPrgoK73wBeZT4OupQ8OCeilxuELO+dJIFJofA7t?=
 =?us-ascii?Q?NL4DvwLvxWZriLX1zPqK18F9mOOm+zKskPxXa2rDpCWigrL7CD+z20mI6eSU?=
 =?us-ascii?Q?wZxKAsroVOTpikYsJwXLXt9J+NAkq4zCfvYKhwC04g4snxu+sfksOd6ONqvQ?=
 =?us-ascii?Q?3DYcrcpoD94+aMvIvULPUlHu3Q4LlrdWJAPnA5R2mdFopVsKD597K/S8Mvq5?=
 =?us-ascii?Q?SIexK4wi3Voe0rAJxGbara46fddwq4FDZZj6MmjDpUBYLLGtmZUP+aM+ld+A?=
 =?us-ascii?Q?GajJKuUt9v6Sph0e5OluEl3PayRDvFlZK/HlhUrIwZ/05oyEh8CFVjj/a2HJ?=
 =?us-ascii?Q?Y+RriwNed695Jj46CuvcCfU7OV9ygoqBoD/4b+fxPUxfrVSw6Y9dHrrLUQ0X?=
 =?us-ascii?Q?XIiCuEiNtNROuhoFJzPcESqB2w+qV0fEkI39VSJaXipCCfGdaGoFmffWfyBc?=
 =?us-ascii?Q?zBQiIXcoV0qDlWioXTMPCcgnAMQXJ6p1JIqPJFuF00YfaggNnsvHIwc9Q0/l?=
 =?us-ascii?Q?pNeOUnGhbS1krtHhdcNb080HEY6nlw2ryoo+Rbdkn9gtXThM1iojXlPPzdCc?=
 =?us-ascii?Q?RJQYd3BAVjPI0DmaghKYyj/ZR5113jHQWIxJKUYZcvOzVrPHr3hwmB0BhHdV?=
 =?us-ascii?Q?IBBwQ8oslQr2qsX/I5lTk9foerM8qcjzSr+kXUKfulIsZjsv+/BSAm7c+UN/?=
 =?us-ascii?Q?3WUD9Mto+7EUbgnw2iZM2uEYB+DmSZtpSD5EVEvgP258HGxwuBquGQ6NP3o5?=
 =?us-ascii?Q?X3SjFnCYVYJB94EIZoKfo8/0zdmJl0G4QVPya5Oa6AsGFtTRK09R1kBKfERi?=
 =?us-ascii?Q?RsUBOBp7139t/X/mC56HiD5n4b2w27NsAjb2JuI8r2iC+vVrW6ZaqcqG7kNB?=
 =?us-ascii?Q?tD9hot6qeVJjRGpRG9ZqNc878ezlMqX2H5Gl/pQxuqEg/LJfoHB9v8GfFk3Q?=
 =?us-ascii?Q?viAQHF44Hhh8wAn9z6fLDRhVM7VGViYbfHmXFmMub7TpCqyUGtwhKkgrMIIh?=
 =?us-ascii?Q?yusZzDlEQfXqkCNeBm2wZsX0uHS2MonsT9hrSfvy6BTM7O+k9qcA5dY2GfwL?=
 =?us-ascii?Q?rK6hwrI8gM8xX83o+MbGCiArlElfJTqwOGZf+C07YngQrDjYWwzbibV+rRaP?=
 =?us-ascii?Q?CqvGuFKs0h5wuhGnM7qXDgjRoiL1gez/uD+3NZnpVz0snysGz74JjwsX1KkK?=
 =?us-ascii?Q?x0dA74+OX3RReQfatePuFeXtJoH6VEYXdNzmLvnm/GHmCNA/G7RHsrnns5hj?=
 =?us-ascii?Q?aUYrZa4zouP8NR/f7HKBOqQWo9l4lxXzL48/5PBsALCDriev1BUOkPSnqxxg?=
 =?us-ascii?Q?RXuBSQlICj/B5eIzf6FDyJK2xRsMcvjiiyxwyYD5y+b1s1OzxydUx9jiWCtE?=
 =?us-ascii?Q?JNMNq7OLVMwa96RKM71lrivkGnwTwdLM3LwFQTt7PlFeQqS1RYf1vKHNU099?=
 =?us-ascii?Q?Mu7rHl+qBw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Td3Ss5MiZUiMq7GSkGQ8OTfqqpDRfDpGE2gpI+RDGDVjE6OogD6dxhq3HesGFYK45tMqTeIh+zvvkAhZt4fIJTy8mVK0Dsh2asDes56Tnb/QVuXXr79HKNcs9Q5Fw6ti/00PBHVNFkzISBkul6JtEIbyGtfwLGeF4m2XphXfdekH2PEUjP1NqF+FobUGHdDhNoGpcCm+uNdWwsKNXc1G3vphoaCn0B1j0IvcJbpucfWygsET46XFAEWdbFW/ErhsIMdaSovnC9BMUR9G/t7mqeLcxu+R9SxWPPpPsoIxyRKM8hXWSZHqu+mEn0xuJZU9hcS6dQWQkGBMAK6T8swZqsOc32nqcPXtwG/7uvmBKTy7RsrG/Oj+zCzr35qX6hV27cVOYsMy4rhnDEBN2PvfZU1QUVE9sFk0G5uoiGEi1WJQqqKiFj/118nZewT53qwaRfH0xW+w0TSD+u4dCMbH/7j3bKZ4+mgK+A82yYLvdAMj2IwwRsqTjif5YJl3mZeqmHMuQjQY8zQGkK8w42tXUzRX+MxrM7POPU4Lt1ag28s/6zGWThR+XipC+98ip3dP7rmoRFRSIZG5cLXKGHOiDMKa/NLrYKS1Pm364iu5rAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ab9af-d411-4db7-0c15-08de68159ae6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:58:33.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7p7aO0W/Ar6Ayy+F6QvB7600QR2q6DkmapHVb8YTuYgc0ogV/VOTa4eQmdeNoEkU9OOsHMODlLrwTt2fYj1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE2OCBTYWx0ZWRfX067al62us1j5
 VpEb6CEkmY/bEDWKuoAxJ2uOezRtF7TOST636IDevmL08M+Nde4BY1KYjXoaQAvbVlbq4070Bku
 R4zdsWnYWVR3xZBTet16UALXsmVjbmP5jr7Ibxkg8Hp8uyYVVS3jkjjh17a2MoIXJIQS5PBKnHz
 iWhm28kv4HffW7/PCVUrpqypixYJIV4DCBGjj3FRL0aaNvtQqYMtVnNLu2isbwGxD1eoAv75kR8
 9Lka5q8UO8ZYglGkZMwYBJvJ8gly4zMhuFgQd2zKSnrxV9NM2OSC9HZQzPtJAA0i5qrUw56p2BI
 wl3pAwPIh0h2Nn9v2eAoHiGT6WPE90It5OvssHIU1uEl0wNXZTTuJU3a2ecdqyo4nBmN9J9zzU+
 g9gTq182+i5BgYg88oShJblnWquH6oNs/mCF/Z8NL0ThOsWX1VucmBhEzR4WKoNBlkRCQ5MEKEu
 bGRR10lkjJc6VUtLGlxuLkMhkkhMa0vPiJBRZPB0=
X-Proofpoint-GUID: apfmPMYXIZZA1P-Auj9lix4Jv0THb_9x
X-Authority-Analysis: v=2.4 cv=ccnfb3DM c=1 sm=1 tr=0 ts=698a3c71 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=TFr53SC5hDGcbPrpWZ8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12149
X-Proofpoint-ORIG-GUID: apfmPMYXIZZA1P-Auj9lix4Jv0THb_9x
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76749-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1CB9B1144DC
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> So far the userland VMA tests have been established as a rough expression
> of what's been possible.
> 
> qAdapt it into a more usable form by separating out tests and shared helper
^^^^ Typo


> functions.
> 
> Since we test functions that are declared statically in mm/vma.c, we make
> use of the trick of #include'ing kernel C files directly.
> 
> In order for the tests to continue to function, we must therefore also
> this way into the tests/ directory.
> 
> We try to keep as much shared logic actually modularised into a separate
> compilation unit in shared.c, however the merge_existing() and attach_vma()
> helpers rely on statically declared mm/vma.c functions so these must be
> declared in main.c.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Besides that typo, it looks good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/vma/Makefile                 |   4 +-
>  tools/testing/vma/main.c                   |  55 ++++
>  tools/testing/vma/shared.c                 | 131 ++++++++
>  tools/testing/vma/shared.h                 | 114 +++++++
>  tools/testing/vma/{vma.c => tests/merge.c} | 332 +--------------------
>  tools/testing/vma/tests/mmap.c             |  57 ++++
>  tools/testing/vma/tests/vma.c              |  39 +++
>  tools/testing/vma/vma_internal.h           |   9 -
>  8 files changed, 406 insertions(+), 335 deletions(-)
>  create mode 100644 tools/testing/vma/main.c
>  create mode 100644 tools/testing/vma/shared.c
>  create mode 100644 tools/testing/vma/shared.h
>  rename tools/testing/vma/{vma.c => tests/merge.c} (82%)
>  create mode 100644 tools/testing/vma/tests/mmap.c
>  create mode 100644 tools/testing/vma/tests/vma.c
> 
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> index 66f3831a668f..94133d9d3955 100644
> --- a/tools/testing/vma/Makefile
> +++ b/tools/testing/vma/Makefile
> @@ -6,10 +6,10 @@ default: vma
>  
>  include ../shared/shared.mk
>  
> -OFILES = $(SHARED_OFILES) vma.o maple-shim.o
> +OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
>  TARGETS = vma
>  
> -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
> +main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
>  
>  vma:	$(OFILES)
>  	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> diff --git a/tools/testing/vma/main.c b/tools/testing/vma/main.c
> new file mode 100644
> index 000000000000..49b09e97a51f
> --- /dev/null
> +++ b/tools/testing/vma/main.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "shared.h"
> +/*
> + * Directly import the VMA implementation here. Our vma_internal.h wrapper
> + * provides userland-equivalent functionality for everything vma.c uses.
> + */
> +#include "../../../mm/vma_init.c"
> +#include "../../../mm/vma_exec.c"
> +#include "../../../mm/vma.c"
> +
> +/* Tests are included directly so they can test static functions in mm/vma.c. */
> +#include "tests/merge.c"
> +#include "tests/mmap.c"
> +#include "tests/vma.c"
> +
> +/* Helper functions which utilise static kernel functions. */
> +
> +struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
> +{
> +	struct vm_area_struct *vma;
> +
> +	vma = vma_merge_existing_range(vmg);
> +	if (vma)
> +		vma_assert_attached(vma);
> +	return vma;
> +}
> +
> +int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> +{
> +	int res;
> +
> +	res = vma_link(mm, vma);
> +	if (!res)
> +		vma_assert_attached(vma);
> +	return res;
> +}
> +
> +/* Main test running which invokes tests/ *.c runners. */
> +int main(void)
> +{
> +	int num_tests = 0, num_fail = 0;
> +
> +	maple_tree_init();
> +	vma_state_init();
> +
> +	run_merge_tests(&num_tests, &num_fail);
> +	run_mmap_tests(&num_tests, &num_fail);
> +	run_vma_tests(&num_tests, &num_fail);
> +
> +	printf("%d tests run, %d passed, %d failed.\n",
> +	       num_tests, num_tests - num_fail, num_fail);
> +
> +	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
> +}
> diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
> new file mode 100644
> index 000000000000..bda578cc3304
> --- /dev/null
> +++ b/tools/testing/vma/shared.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "shared.h"
> +
> +
> +bool fail_prealloc;
> +unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> +unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> +unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> +
> +const struct vm_operations_struct vma_dummy_vm_ops;
> +struct anon_vma dummy_anon_vma;
> +struct task_struct __current;
> +
> +struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> +		unsigned long start, unsigned long end,
> +		pgoff_t pgoff, vm_flags_t vm_flags)
> +{
> +	struct vm_area_struct *vma = vm_area_alloc(mm);
> +
> +	if (vma == NULL)
> +		return NULL;
> +
> +	vma->vm_start = start;
> +	vma->vm_end = end;
> +	vma->vm_pgoff = pgoff;
> +	vm_flags_reset(vma, vm_flags);
> +	vma_assert_detached(vma);
> +
> +	return vma;
> +}
> +
> +void detach_free_vma(struct vm_area_struct *vma)
> +{
> +	vma_mark_detached(vma);
> +	vm_area_free(vma);
> +}
> +
> +struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> +		unsigned long start, unsigned long end,
> +		pgoff_t pgoff, vm_flags_t vm_flags)
> +{
> +	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
> +
> +	if (vma == NULL)
> +		return NULL;
> +
> +	if (attach_vma(mm, vma)) {
> +		detach_free_vma(vma);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Reset this counter which we use to track whether writes have
> +	 * begun. Linking to the tree will have caused this to be incremented,
> +	 * which means we will get a false positive otherwise.
> +	 */
> +	vma->vm_lock_seq = UINT_MAX;
> +
> +	return vma;
> +}
> +
> +void reset_dummy_anon_vma(void)
> +{
> +	dummy_anon_vma.was_cloned = false;
> +	dummy_anon_vma.was_unlinked = false;
> +}
> +
> +int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
> +{
> +	struct vm_area_struct *vma;
> +	int count = 0;
> +
> +	fail_prealloc = false;
> +	reset_dummy_anon_vma();
> +
> +	vma_iter_set(vmi, 0);
> +	for_each_vma(*vmi, vma) {
> +		detach_free_vma(vma);
> +		count++;
> +	}
> +
> +	mtree_destroy(&mm->mm_mt);
> +	mm->map_count = 0;
> +	return count;
> +}
> +
> +bool vma_write_started(struct vm_area_struct *vma)
> +{
> +	int seq = vma->vm_lock_seq;
> +
> +	/* We reset after each check. */
> +	vma->vm_lock_seq = UINT_MAX;
> +
> +	/* The vma_start_write() stub simply increments this value. */
> +	return seq > -1;
> +}
> +
> +void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> +		struct anon_vma_chain *avc, struct anon_vma *anon_vma)
> +{
> +	vma->anon_vma = anon_vma;
> +	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +	list_add(&avc->same_vma, &vma->anon_vma_chain);
> +	avc->anon_vma = vma->anon_vma;
> +}
> +
> +void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> +		struct anon_vma_chain *avc)
> +{
> +	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
> +}
> +
> +struct task_struct *get_current(void)
> +{
> +	return &__current;
> +}
> +
> +unsigned long rlimit(unsigned int limit)
> +{
> +	return (unsigned long)-1;
> +}
> +
> +void vma_set_range(struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   pgoff_t pgoff)
> +{
> +	vma->vm_start = start;
> +	vma->vm_end = end;
> +	vma->vm_pgoff = pgoff;
> +}
> diff --git a/tools/testing/vma/shared.h b/tools/testing/vma/shared.h
> new file mode 100644
> index 000000000000..6c64211cfa22
> --- /dev/null
> +++ b/tools/testing/vma/shared.h
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#pragma once
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "generated/bit-length.h"
> +#include "maple-shared.h"
> +#include "vma_internal.h"
> +#include "../../../mm/vma.h"
> +
> +/* Simple test runner. Assumes local num_[fail, tests] counters. */
> +#define TEST(name)							\
> +	do {								\
> +		(*num_tests)++;						\
> +		if (!test_##name()) {					\
> +			(*num_fail)++;					\
> +			fprintf(stderr, "Test " #name " FAILED\n");	\
> +		}							\
> +	} while (0)
> +
> +#define ASSERT_TRUE(_expr)						\
> +	do {								\
> +		if (!(_expr)) {						\
> +			fprintf(stderr,					\
> +				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> +				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> +			return false;					\
> +		}							\
> +	} while (0)
> +
> +#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
> +#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> +#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> +
> +#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
> +
> +extern bool fail_prealloc;
> +
> +/* Override vma_iter_prealloc() so we can choose to fail it. */
> +#define vma_iter_prealloc(vmi, vma)					\
> +	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
> +
> +#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
> +
> +extern unsigned long mmap_min_addr;
> +extern unsigned long dac_mmap_min_addr;
> +extern unsigned long stack_guard_gap;
> +
> +extern const struct vm_operations_struct vma_dummy_vm_ops;
> +extern struct anon_vma dummy_anon_vma;
> +extern struct task_struct __current;
> +
> +/*
> + * Helper function which provides a wrapper around a merge existing VMA
> + * operation.
> + *
> + * Declared in main.c as uses static VMA function.
> + */
> +struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg);
> +
> +/*
> + * Helper function to allocate a VMA and link it to the tree.
> + *
> + * Declared in main.c as uses static VMA function.
> + */
> +int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma);
> +
> +/* Helper function providing a dummy vm_ops->close() method.*/
> +static inline void dummy_close(struct vm_area_struct *)
> +{
> +}
> +
> +/* Helper function to simply allocate a VMA. */
> +struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> +		unsigned long start, unsigned long end,
> +		pgoff_t pgoff, vm_flags_t vm_flags);
> +
> +/* Helper function to detach and free a VMA. */
> +void detach_free_vma(struct vm_area_struct *vma);
> +
> +/* Helper function to allocate a VMA and link it to the tree. */
> +struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> +		unsigned long start, unsigned long end,
> +		pgoff_t pgoff, vm_flags_t vm_flags);
> +
> +/*
> + * Helper function to reset the dummy anon_vma to indicate it has not been
> + * duplicated.
> + */
> +void reset_dummy_anon_vma(void);
> +
> +/*
> + * Helper function to remove all VMAs and destroy the maple tree associated with
> + * a virtual address space. Returns a count of VMAs in the tree.
> + */
> +int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi);
> +
> +/* Helper function to determine if VMA has had vma_start_write() performed. */
> +bool vma_write_started(struct vm_area_struct *vma);
> +
> +void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> +		struct anon_vma_chain *avc, struct anon_vma *anon_vma);
> +
> +/* Provide a simple dummy VMA/anon_vma dummy setup for testing. */
> +void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> +			    struct anon_vma_chain *avc);
> +
> +/* Helper function to specify a VMA's range. */
> +void vma_set_range(struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   pgoff_t pgoff);
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/tests/merge.c
> similarity index 82%
> rename from tools/testing/vma/vma.c
> rename to tools/testing/vma/tests/merge.c
> index 93d21bc7e112..3708dc6945b0 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/tests/merge.c
> @@ -1,132 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> -#include <stdbool.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -
> -#include "generated/bit-length.h"
> -
> -#include "maple-shared.h"
> -#include "vma_internal.h"
> -
> -/* Include so header guard set. */
> -#include "../../../mm/vma.h"
> -
> -static bool fail_prealloc;
> -
> -/* Then override vma_iter_prealloc() so we can choose to fail it. */
> -#define vma_iter_prealloc(vmi, vma)					\
> -	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
> -
> -#define CONFIG_DEFAULT_MMAP_MIN_ADDR 65536
> -
> -unsigned long mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> -unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
> -unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> -
> -/*
> - * Directly import the VMA implementation here. Our vma_internal.h wrapper
> - * provides userland-equivalent functionality for everything vma.c uses.
> - */
> -#include "../../../mm/vma_init.c"
> -#include "../../../mm/vma_exec.c"
> -#include "../../../mm/vma.c"
> -
> -const struct vm_operations_struct vma_dummy_vm_ops;
> -static struct anon_vma dummy_anon_vma;
> -
> -#define ASSERT_TRUE(_expr)						\
> -	do {								\
> -		if (!(_expr)) {						\
> -			fprintf(stderr,					\
> -				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> -				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> -			return false;					\
> -		}							\
> -	} while (0)
> -#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
> -#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> -#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> -
> -#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
> -
> -static struct task_struct __current;
> -
> -struct task_struct *get_current(void)
> -{
> -	return &__current;
> -}
> -
> -unsigned long rlimit(unsigned int limit)
> -{
> -	return (unsigned long)-1;
> -}
> -
> -/* Helper function to simply allocate a VMA. */
> -static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long end,
> -					pgoff_t pgoff,
> -					vm_flags_t vm_flags)
> -{
> -	struct vm_area_struct *vma = vm_area_alloc(mm);
> -
> -	if (vma == NULL)
> -		return NULL;
> -
> -	vma->vm_start = start;
> -	vma->vm_end = end;
> -	vma->vm_pgoff = pgoff;
> -	vm_flags_reset(vma, vm_flags);
> -	vma_assert_detached(vma);
> -
> -	return vma;
> -}
> -
> -/* Helper function to allocate a VMA and link it to the tree. */
> -static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> -{
> -	int res;
> -
> -	res = vma_link(mm, vma);
> -	if (!res)
> -		vma_assert_attached(vma);
> -	return res;
> -}
> -
> -static void detach_free_vma(struct vm_area_struct *vma)
> -{
> -	vma_mark_detached(vma);
> -	vm_area_free(vma);
> -}
> -
> -/* Helper function to allocate a VMA and link it to the tree. */
> -static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
> -						 unsigned long start,
> -						 unsigned long end,
> -						 pgoff_t pgoff,
> -						 vm_flags_t vm_flags)
> -{
> -	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, vm_flags);
> -
> -	if (vma == NULL)
> -		return NULL;
> -
> -	if (attach_vma(mm, vma)) {
> -		detach_free_vma(vma);
> -		return NULL;
> -	}
> -
> -	/*
> -	 * Reset this counter which we use to track whether writes have
> -	 * begun. Linking to the tree will have caused this to be incremented,
> -	 * which means we will get a false positive otherwise.
> -	 */
> -	vma->vm_lock_seq = UINT_MAX;
> -
> -	return vma;
> -}
> -
>  /* Helper function which provides a wrapper around a merge new VMA operation. */
>  static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  {
> @@ -146,20 +19,6 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  	return vma;
>  }
>  
> -/*
> - * Helper function which provides a wrapper around a merge existing VMA
> - * operation.
> - */
> -static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
> -{
> -	struct vm_area_struct *vma;
> -
> -	vma = vma_merge_existing_range(vmg);
> -	if (vma)
> -		vma_assert_attached(vma);
> -	return vma;
> -}
> -
>  /*
>   * Helper function which provides a wrapper around the expansion of an existing
>   * VMA.
> @@ -173,8 +32,8 @@ static int expand_existing(struct vma_merge_struct *vmg)
>   * Helper function to reset merge state the associated VMA iterator to a
>   * specified new range.
>   */
> -static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
> -			  unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
> +void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
> +		   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags)
>  {
>  	vma_iter_set(vmg->vmi, start);
>  
> @@ -197,8 +56,8 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
>  
>  /* Helper function to set both the VMG range and its anon_vma. */
>  static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
> -				   unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
> -				   struct anon_vma *anon_vma)
> +		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
> +		struct anon_vma *anon_vma)
>  {
>  	vmg_set_range(vmg, start, end, pgoff, vm_flags);
>  	vmg->anon_vma = anon_vma;
> @@ -211,10 +70,9 @@ static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long s
>   * VMA, link it to the maple tree and return it.
>   */
>  static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
> -						struct vma_merge_struct *vmg,
> -						unsigned long start, unsigned long end,
> -						pgoff_t pgoff, vm_flags_t vm_flags,
> -						bool *was_merged)
> +		struct vma_merge_struct *vmg, unsigned long start,
> +		unsigned long end, pgoff_t pgoff, vm_flags_t vm_flags,
> +		bool *was_merged)
>  {
>  	struct vm_area_struct *merged;
>  
> @@ -234,72 +92,6 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
>  	return alloc_and_link_vma(mm, start, end, pgoff, vm_flags);
>  }
>  
> -/*
> - * Helper function to reset the dummy anon_vma to indicate it has not been
> - * duplicated.
> - */
> -static void reset_dummy_anon_vma(void)
> -{
> -	dummy_anon_vma.was_cloned = false;
> -	dummy_anon_vma.was_unlinked = false;
> -}
> -
> -/*
> - * Helper function to remove all VMAs and destroy the maple tree associated with
> - * a virtual address space. Returns a count of VMAs in the tree.
> - */
> -static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
> -{
> -	struct vm_area_struct *vma;
> -	int count = 0;
> -
> -	fail_prealloc = false;
> -	reset_dummy_anon_vma();
> -
> -	vma_iter_set(vmi, 0);
> -	for_each_vma(*vmi, vma) {
> -		detach_free_vma(vma);
> -		count++;
> -	}
> -
> -	mtree_destroy(&mm->mm_mt);
> -	mm->map_count = 0;
> -	return count;
> -}
> -
> -/* Helper function to determine if VMA has had vma_start_write() performed. */
> -static bool vma_write_started(struct vm_area_struct *vma)
> -{
> -	int seq = vma->vm_lock_seq;
> -
> -	/* We reset after each check. */
> -	vma->vm_lock_seq = UINT_MAX;
> -
> -	/* The vma_start_write() stub simply increments this value. */
> -	return seq > -1;
> -}
> -
> -/* Helper function providing a dummy vm_ops->close() method.*/
> -static void dummy_close(struct vm_area_struct *)
> -{
> -}
> -
> -static void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> -				     struct anon_vma_chain *avc,
> -				     struct anon_vma *anon_vma)
> -{
> -	vma->anon_vma = anon_vma;
> -	INIT_LIST_HEAD(&vma->anon_vma_chain);
> -	list_add(&avc->same_vma, &vma->anon_vma_chain);
> -	avc->anon_vma = vma->anon_vma;
> -}
> -
> -static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
> -				   struct anon_vma_chain *avc)
> -{
> -	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
> -}
> -
>  static bool test_simple_merge(void)
>  {
>  	struct vm_area_struct *vma;
> @@ -1616,39 +1408,6 @@ static bool test_merge_extend(void)
>  	return true;
>  }
>  
> -static bool test_copy_vma(void)
> -{
> -	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> -	struct mm_struct mm = {};
> -	bool need_locks = false;
> -	VMA_ITERATOR(vmi, &mm, 0);
> -	struct vm_area_struct *vma, *vma_new, *vma_next;
> -
> -	/* Move backwards and do not merge. */
> -
> -	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
> -	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
> -	ASSERT_NE(vma_new, vma);
> -	ASSERT_EQ(vma_new->vm_start, 0);
> -	ASSERT_EQ(vma_new->vm_end, 0x2000);
> -	ASSERT_EQ(vma_new->vm_pgoff, 0);
> -	vma_assert_attached(vma_new);
> -
> -	cleanup_mm(&mm, &vmi);
> -
> -	/* Move a VMA into position next to another and merge the two. */
> -
> -	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
> -	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
> -	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
> -	vma_assert_attached(vma_new);
> -
> -	ASSERT_EQ(vma_new, vma_next);
> -
> -	cleanup_mm(&mm, &vmi);
> -	return true;
> -}
> -
>  static bool test_expand_only_mode(void)
>  {
>  	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> @@ -1689,73 +1448,8 @@ static bool test_expand_only_mode(void)
>  	return true;
>  }
>  
> -static bool test_mmap_region_basic(void)
> -{
> -	struct mm_struct mm = {};
> -	unsigned long addr;
> -	struct vm_area_struct *vma;
> -	VMA_ITERATOR(vmi, &mm, 0);
> -
> -	current->mm = &mm;
> -
> -	/* Map at 0x300000, length 0x3000. */
> -	addr = __mmap_region(NULL, 0x300000, 0x3000,
> -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> -			     0x300, NULL);
> -	ASSERT_EQ(addr, 0x300000);
> -
> -	/* Map at 0x250000, length 0x3000. */
> -	addr = __mmap_region(NULL, 0x250000, 0x3000,
> -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> -			     0x250, NULL);
> -	ASSERT_EQ(addr, 0x250000);
> -
> -	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
> -	addr = __mmap_region(NULL, 0x303000, 0x3000,
> -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> -			     0x303, NULL);
> -	ASSERT_EQ(addr, 0x303000);
> -
> -	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
> -	addr = __mmap_region(NULL, 0x24d000, 0x3000,
> -			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> -			     0x24d, NULL);
> -	ASSERT_EQ(addr, 0x24d000);
> -
> -	ASSERT_EQ(mm.map_count, 2);
> -
> -	for_each_vma(vmi, vma) {
> -		if (vma->vm_start == 0x300000) {
> -			ASSERT_EQ(vma->vm_end, 0x306000);
> -			ASSERT_EQ(vma->vm_pgoff, 0x300);
> -		} else if (vma->vm_start == 0x24d000) {
> -			ASSERT_EQ(vma->vm_end, 0x253000);
> -			ASSERT_EQ(vma->vm_pgoff, 0x24d);
> -		} else {
> -			ASSERT_FALSE(true);
> -		}
> -	}
> -
> -	cleanup_mm(&mm, &vmi);
> -	return true;
> -}
> -
> -int main(void)
> +static void run_merge_tests(int *num_tests, int *num_fail)
>  {
> -	int num_tests = 0, num_fail = 0;
> -
> -	maple_tree_init();
> -	vma_state_init();
> -
> -#define TEST(name)							\
> -	do {								\
> -		num_tests++;						\
> -		if (!test_##name()) {					\
> -			num_fail++;					\
> -			fprintf(stderr, "Test " #name " FAILED\n");	\
> -		}							\
> -	} while (0)
> -
>  	/* Very simple tests to kick the tyres. */
>  	TEST(simple_merge);
>  	TEST(simple_modify);
> @@ -1771,15 +1465,5 @@ int main(void)
>  	TEST(dup_anon_vma);
>  	TEST(vmi_prealloc_fail);
>  	TEST(merge_extend);
> -	TEST(copy_vma);
>  	TEST(expand_only_mode);
> -
> -	TEST(mmap_region_basic);
> -
> -#undef TEST
> -
> -	printf("%d tests run, %d passed, %d failed.\n",
> -	       num_tests, num_tests - num_fail, num_fail);
> -
> -	return num_fail == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
>  }
> diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
> new file mode 100644
> index 000000000000..bded4ecbe5db
> --- /dev/null
> +++ b/tools/testing/vma/tests/mmap.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +static bool test_mmap_region_basic(void)
> +{
> +	struct mm_struct mm = {};
> +	unsigned long addr;
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, &mm, 0);
> +
> +	current->mm = &mm;
> +
> +	/* Map at 0x300000, length 0x3000. */
> +	addr = __mmap_region(NULL, 0x300000, 0x3000,
> +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> +			     0x300, NULL);
> +	ASSERT_EQ(addr, 0x300000);
> +
> +	/* Map at 0x250000, length 0x3000. */
> +	addr = __mmap_region(NULL, 0x250000, 0x3000,
> +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> +			     0x250, NULL);
> +	ASSERT_EQ(addr, 0x250000);
> +
> +	/* Map at 0x303000, merging to 0x300000 of length 0x6000. */
> +	addr = __mmap_region(NULL, 0x303000, 0x3000,
> +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> +			     0x303, NULL);
> +	ASSERT_EQ(addr, 0x303000);
> +
> +	/* Map at 0x24d000, merging to 0x250000 of length 0x6000. */
> +	addr = __mmap_region(NULL, 0x24d000, 0x3000,
> +			     VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE,
> +			     0x24d, NULL);
> +	ASSERT_EQ(addr, 0x24d000);
> +
> +	ASSERT_EQ(mm.map_count, 2);
> +
> +	for_each_vma(vmi, vma) {
> +		if (vma->vm_start == 0x300000) {
> +			ASSERT_EQ(vma->vm_end, 0x306000);
> +			ASSERT_EQ(vma->vm_pgoff, 0x300);
> +		} else if (vma->vm_start == 0x24d000) {
> +			ASSERT_EQ(vma->vm_end, 0x253000);
> +			ASSERT_EQ(vma->vm_pgoff, 0x24d);
> +		} else {
> +			ASSERT_FALSE(true);
> +		}
> +	}
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
> +static void run_mmap_tests(int *num_tests, int *num_fail)
> +{
> +	TEST(mmap_region_basic);
> +}
> diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
> new file mode 100644
> index 000000000000..6d9775aee243
> --- /dev/null
> +++ b/tools/testing/vma/tests/vma.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +static bool test_copy_vma(void)
> +{
> +	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	bool need_locks = false;
> +	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vm_area_struct *vma, *vma_new, *vma_next;
> +
> +	/* Move backwards and do not merge. */
> +
> +	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vm_flags);
> +	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
> +	ASSERT_NE(vma_new, vma);
> +	ASSERT_EQ(vma_new->vm_start, 0);
> +	ASSERT_EQ(vma_new->vm_end, 0x2000);
> +	ASSERT_EQ(vma_new->vm_pgoff, 0);
> +	vma_assert_attached(vma_new);
> +
> +	cleanup_mm(&mm, &vmi);
> +
> +	/* Move a VMA into position next to another and merge the two. */
> +
> +	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
> +	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vm_flags);
> +	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
> +	vma_assert_attached(vma_new);
> +
> +	ASSERT_EQ(vma_new, vma_next);
> +
> +	cleanup_mm(&mm, &vmi);
> +	return true;
> +}
> +
> +static void run_vma_tests(int *num_tests, int *num_fail)
> +{
> +	TEST(copy_vma);
> +}
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 2743f12ecf32..b48ebae3927d 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1127,15 +1127,6 @@ static inline void mapping_allow_writable(struct address_space *mapping)
>  	atomic_inc(&mapping->i_mmap_writable);
>  }
>  
> -static inline void vma_set_range(struct vm_area_struct *vma,
> -				 unsigned long start, unsigned long end,
> -				 pgoff_t pgoff)
> -{
> -	vma->vm_start = start;
> -	vma->vm_end = end;
> -	vma->vm_pgoff = pgoff;
> -}
> -
>  static inline
>  struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
>  {
> -- 
> 2.52.0
> 

