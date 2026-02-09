Return-Path: <linux-fsdevel+bounces-76731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJcpOVgrimm6HwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:45:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521EC113CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 667F6301D4C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC643AEF2C;
	Mon,  9 Feb 2026 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AetKDTyH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P/Grhj5+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347C2DCF4C;
	Mon,  9 Feb 2026 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662718; cv=fail; b=l0Y9jZTbWvFWizVqMg0mhu3psntYCiyQZ0ob4wQdlPPWsLgR9TCiWOGG7pl0XUtbqTwiOlvUxnNq6QeTPUCX3eNaOu0AX12BkMr6TRAWJP8BbfZ2PjLei6OlpkzyCGQiriMtzTTq8+44p3NidWI9zq2W/4YAOK9pnLQN9cnMZLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662718; c=relaxed/simple;
	bh=Im9w6feQ5uTm+SA18ekdbYAxLE/OVIkVn9FMtjLTq70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hcd+FP1IW0xY9HLkQpo+RpdNDVm+yMmBc3+hQEXZULK5rSZ0k+iYAPNSt8qR3f9QePrt0Cxv+RCeDj5tUOJbAgOqXXH99rlnBYI/kFlM2BDLCUCm0Cql/118P28mPeBggaSUzsNczu2EgMrPGFQAyy5SlYVO7nJibCjMJhLueHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AetKDTyH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P/Grhj5+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECWuF1945030;
	Mon, 9 Feb 2026 18:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=B0NYtwB6mvAW7jt5Km
	iOR5IOjPAKW1mqkBCc7TiTWxU=; b=AetKDTyH68itCGa0Nms49izLSUYlStN1n4
	eH/cc8nLkoz3iJz4XqF41XgnvdeSEOuAfVpuGPIkNaWP5wJaTSekIQGyryOHqhK9
	ydiva2UfSM/CQDa/3uvTCRcJqlx1biG/x3Q7DQX7lxJnNBPZwCVb1dObOrOXWJ9a
	ydX1P6cTOyqomXtlgS7NrDm0fPhqSZ8FinBKJeS4zGOMUxcoTb+J2ReL/BtVh+ol
	uXJvSWDXRxkEb+w14/8T1hNnGhn4XGBPS1KmjJeWqoloa0kAIslDtQRo7mVHDLJA
	47VLNLTO+r/3jDNckvNSKEZdka0ZyGtM0MPdD//Tv8Mx1+X/pzmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xj4jh0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:44:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619H0Hlg000539;
	Mon, 9 Feb 2026 18:44:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uudct68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atGFNKKB+dGLz8+tnQoVyQv8StVLGKpSfzBhBw1wCUCVFWkryEcrqUOWUuP+nxoAQKoxmDpTUXRFW7GJf7uv+3IStXGLgnKDIxG2yX736TTsg26obi1594BNCiEzj8Jc94s2jMEe8cBvVf2Iu+3b8FEGrfIwSgQbM8UmugHUZ65lmZxiN+izFCteOIrPZpU526rR9O+h3xgHMrOkaXtefYndM5snX32crbq5N0EA/xsFM1pk5mK6yGVYFw/IWV1QKNtopedL3AFyVAzZ/S3sjafCj2Fktj25igbcKZAGfcTYs4SisvXR+Uh61jv7/wbzTQQ5olsaqJjrHEQUuSj3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0NYtwB6mvAW7jt5KmiOR5IOjPAKW1mqkBCc7TiTWxU=;
 b=IZgJNSoCkNNdVbz/InNl8REcXd6MiL7Tx/T3HFUF35F1OK+2PmPZptV4297WPt9Yg1XGUg0+kStqCTQ5s4zB4WN67Mr/ZRa15tcbKLaU8uSnCi+bnuXxh80q4kKG0v1iRMkfXaEzsb94OE7f2CW9AjiCHRn0Xe2tS9TUmNnr1Buia2aoFAxD/+jjrYgC7rvM7y/ItoczTbHGCnY099k8BHgvm6FJ8Y0xi1BcOWbpyt5WUjmAgobvD5IxTbdufybIKxKpwBJGgigFQq+cu+MxFY77hPOBhb5PpslAwTmfGlX7/U1pShom0seks7+6vLTKLSLvYFEN/uO1oPXlhMuATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0NYtwB6mvAW7jt5KmiOR5IOjPAKW1mqkBCc7TiTWxU=;
 b=P/Grhj5+ObxAEIMk6Fa2MFrODDbHrsZokOBdR1q8bP8E99iGsuMeRZreqVghvWyNcypN4slCFOuTCG7Y8Zwpi9EjzoVXwreE02lGWjzSg6DqU/41A4c727CLd5C5qz/aXD9yXL6Yd/yLvdOf009VxpmokV4dW8tWWpD/cT9ddkc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ5PPF9BA2D2998.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7bd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 18:44:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:44:30 +0000
Date: Mon, 9 Feb 2026 18:44:20 +0000
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
Subject: Re: [PATCH v2 03/13] mm: add mk_vma_flags() bitmap flag macro helper
Message-ID: <2kqlot2zn4a7slndz7rnxqe3mwi2x3v4o4hqan2y5lgqwv2aeo@euwqxzx4b7or>
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
 <fde00df6ff7fb8c4b42cc0defa5a4924c7a1943a.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde00df6ff7fb8c4b42cc0defa5a4924c7a1943a.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ5PPF9BA2D2998:EE_
X-MS-Office365-Filtering-Correlation-Id: 835761e0-38bd-4d5d-9514-08de680b4277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6/bZVShZbaOA5lTqGO0fY5oKk3Vz2RKxyv8Xa0FY8sanbl1yUtziCiI+Nqz?=
 =?us-ascii?Q?6R1/yICdsQNuNET3FZlwwOZbJqBKPnjAqJNQ0Go9Dsvqka7Md/3eHjwSU2uo?=
 =?us-ascii?Q?eiUmCfDACSHAVI/fNTTBzlcQoWMmN4g+FLPgMHnwk5bkRkNdDQtsElHsMfkv?=
 =?us-ascii?Q?8y7yTXTvQH6WnFS/jTDqhXgPfhasX5RQVcpNEQyviiZnpwg3YntX+lbf6HBC?=
 =?us-ascii?Q?r6xr4b/XtVTuNxRqpRYbpOmso6S0Q+oZ8Q2GOvKI7u9LF0jPeaZ40kpl/SjB?=
 =?us-ascii?Q?Tjg9gUHTvicI9HGv8gLeaupmxXx1pANINXo3edqpmj1UkX+Q22d08ihxUBKz?=
 =?us-ascii?Q?HhCRA6aiaQzJiAJ8GzDPL0FpoeYvYw5AkMuVDoCOR2kPHk3hgR63C7RqCkCc?=
 =?us-ascii?Q?6ardWZ1mQ6tDohizUmGXTJXM+yyDHc7XC0hIKBoowiVaamovn33Mm8BLqoT3?=
 =?us-ascii?Q?Ob98lxRUe1QEQJEhxZ1jH/agS1uG/aGDlRBN2BdCpm2j/p5w9snpQbmCzL//?=
 =?us-ascii?Q?YAnSViQS5hdeHVgBONTV5TL6ydM3EKLS5x1YPVAoGNlPneZr0RbDrJE9giZT?=
 =?us-ascii?Q?6znD5DN0x6ie5nUECDHzR3Ro0WlNN1NsmlrEN4J9TkML/pGC5xojNm0TR8EJ?=
 =?us-ascii?Q?RlVV8IJhQjsjK9MARP8Gtu9+E1AtL5qvvl5nsVWh+hmQeb85knQaXGq7toe7?=
 =?us-ascii?Q?bsifULyB17+9zNuEqBe7vgeYaC/rzlvdSSqUE8gLTxfrHdUNwbTJdXA9q09v?=
 =?us-ascii?Q?lSdR0FE7JI37uDE1LTAiyAnpNQlNmkpNKCw1RpAg3Gm9OcyYPfT0TgBGIyZd?=
 =?us-ascii?Q?OMVchXgb2m+R+rM8Fe+j0xvp1TZrTeb6+LVp4fkdEbQjKd49+zXbXPYqw3qH?=
 =?us-ascii?Q?hkfDrsiZJN8+Ltzv6EHn8PYcQt0lufPOY90+Ch/xTBU0IrWsEhyvTUiHljjq?=
 =?us-ascii?Q?VVxdSUCIid4F1FhMo2mXxHSkiSW7yiTx2PwyUUH6gq8eI6/r/4PCfPqKanof?=
 =?us-ascii?Q?zsNNQ5a0ZJpUOvHFlAeZtlPk6fneieMQquEs1o2JbQRW37O7WmAsXKM5xFka?=
 =?us-ascii?Q?DUhUScU6R6TbzOXUHNTCfvdt0WVDBlkA6qSxchfosTjlYbiCnJ6ZzlIt/C+d?=
 =?us-ascii?Q?fEC932BAROusxgER5AM7VvZxNh8tgmQUrcv21/OTpLmh3p0MIq8LD5sF6h18?=
 =?us-ascii?Q?iO6b/kI0XzKYJ4GARUkKufjlEluO98SmGNuPgjPrkyjjCUf4lWr4qe3S286C?=
 =?us-ascii?Q?WeiI8Omv4lqWFEPGfYV1eH1uBTGzIo5jZIgT0h7GBZca+WNOG6RKrHVvru93?=
 =?us-ascii?Q?hNr4vfTsW5CffOYryvdn4EpszQvj/unEVAxeUEcsFKayURU87Ayq0Gy1YLeG?=
 =?us-ascii?Q?qzYvFxObYCHTLCM4rF2VGQGnCRP77OcCD4YUauTqm5zn9kd0aS1h9swBbh6d?=
 =?us-ascii?Q?de+W6fyGhA4GmeCgrfjB8TUCQ6Qqa80RcC/jRjgzpe9USeGOqNFiQF6ZvoWQ?=
 =?us-ascii?Q?4B4s2Evg/iHIkO7ONQ4c4jQSUqREzaSlSS/Qnm5M9epiABBqTL0rk5MPOqaS?=
 =?us-ascii?Q?ZINh0J32beZSRKL7pi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ggLOdY54t/hDOd/mOSVN0ij7suoJb6dsuquZqztUX9DKy+i55Jo2MMUQ/0D?=
 =?us-ascii?Q?ZcXzMwklveqt8pHu21tOay2f2bsa648OQO5DTuX6SB+ocDo1Lkmk4n+uZY5G?=
 =?us-ascii?Q?DeKkLzjrahsWdaGxAlwWMaNEit5zhyWDDR9scFeAGUsGdEXFFl8pOhX0uFCb?=
 =?us-ascii?Q?engvPa6jQai2CqZj4UQIUm9EUB0lDuKP5AzvV90cji3J4AJ6Hlb5h+JKONwW?=
 =?us-ascii?Q?h8hjxifJhbKPqmbO+xHEwXmI2yo/XGUOQf/L5RFFT7sSIX3ruH2rCa+1lspQ?=
 =?us-ascii?Q?cm1W7SEAGPHKqmv1CdkF/4UVvpPdvv1klkQ5Y2bqy5H41eDsxlb3fT3SY4+/?=
 =?us-ascii?Q?9Mjp8mEg5OaLimsvPc5dFKJVt2jwgoX6Ub+VPY+/RRdOZA7/GzCWA5pQ7kBe?=
 =?us-ascii?Q?Upfa93PsiOhbg1dr744cg+/X0OMSGYq5VXvIV5h91OuW/GCwvswDDnG+Knur?=
 =?us-ascii?Q?rZEG4/fzZJY6jot7HNp3Tsz3Gqi7rY7THZFFoIGMoPF4tt1Aw0su2UQ26GQ7?=
 =?us-ascii?Q?ky/pVPGxhEGK9cFuB03k1UAi3p0aeXl9PTe2o9f4kpx2ClEdpFFIuGHz+JJb?=
 =?us-ascii?Q?zNLxb0ey8PHR2SOl9TVzOnN01Byr6LJcnLibstJ59QVwnK2ASWu7nxha+wjy?=
 =?us-ascii?Q?P2xOJNyDM0YGWyyWYi2NZCCRHlvNlGhPtUh4RrI2ndtLvYVdQMfTzRvj2TOc?=
 =?us-ascii?Q?428rpR/pkHooUsEpTEJmtXkRIjBzbpa1e55xNC9pHVPrQfOC3XwgwMVex8uk?=
 =?us-ascii?Q?KNWh6/sAvDSL2N95jr8zu25lSnuQn+UPil5d/ej+rRVsRqLZ1JjElMcQRLVO?=
 =?us-ascii?Q?dQp7Gx5hBV1EgOyD68EfWzNsLz+OcR8gCXqqddvcJ6GbL3idNqKlhk2DIHNA?=
 =?us-ascii?Q?eeacywIP79pBE2xRvPSwQWiNzjQvA0xliMurQgN0FXV8ZpaRNYCfpFLB0WVD?=
 =?us-ascii?Q?bgFEV3BfZ1eNHf5Ja/zazoaMe/VfdGJUPccrFJMJSQn2SL+5zGrA67iA5iJ0?=
 =?us-ascii?Q?NdzyWBQg95BaHT/Rrl/JAlcIs0UlraTWg+usXPRlJMfGkYEuwkxyKsWbDLPz?=
 =?us-ascii?Q?dnTHL8y0UkQORV7zlFC/c6YuMc0E8CkZMGUn/2xhkCy+7WAx17TkK9uB1Gu8?=
 =?us-ascii?Q?FUEfNVQPV7Q/CxXzssDrnF5JJuUXcf/S3Qz5ANzugumqhAwH9BriFJRrjxX8?=
 =?us-ascii?Q?esUnbWF/bCZxgKLyfXFWa5u8NB1bhcyBQXsw5vMP5GqP8yimy4RF4JPzC3AO?=
 =?us-ascii?Q?Tx5gCgQIxV3BRt3JJCxrp4c7JVF3WmMjU2SQm8qEJqRBk0PsE4iXaruHLi0L?=
 =?us-ascii?Q?daKODNtS0ZW4Bam2/d7Vr7qdQL4dQxTd7jDW9/WTeTz2xywg70IYtySbY9FC?=
 =?us-ascii?Q?MZ9eaQv7/DMU2HCA/QbKvSmIMN3kOKwzdpwWt7VFsdXEEGbnIEunwby4nS0X?=
 =?us-ascii?Q?ttPj6SkH1te6qUJmErGSGArLAo4hE3ex985OLRI1JZfxvW/OPLIPk/yPBZHe?=
 =?us-ascii?Q?FuhuJQTsImhpuQfPOt6ZCUQMnKJRmmfkU9TEQEL4AaaTA+Z9UGFledMrSkbw?=
 =?us-ascii?Q?KsNupEXqQn9MNVgFXGq4LY61qEkutTXXm2nHJ61l3w/xn38HxRZh/YBvGrOu?=
 =?us-ascii?Q?hjkro4OR7iyKrn4sCL1fzRpFXkWxeRz0b5S8McxksXbLOqc3E68k5m9y1NdB?=
 =?us-ascii?Q?+hu/csw8r3rK5yMfzsC3zoT1y6u8oMKu8VI+Upk2ay4QHffIM477m9rS5MEP?=
 =?us-ascii?Q?IdaYEscqzw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+twhLtpIfBfU8tP/B1j8ZGKcEpU+ITwk8wOYlPayRcipzW9bVB8IBFA75CK6SF30wxwFQzDM9g0t9hJIutsjoAxH0i2Dnhu/5vGS2RNRETijAUpt5bSLvbIPEtpq9CNtJOFoji/NvY91AeNtka4cxYZhwBz82Z5j+W6/7RiW81DHYmA1FQzhDN+u7T1TcaXdPicGqHxPxF7Wwwg8WLIpjStcFx20/NbNvKQDfvD5SyrDWfVgnouz1koYHILpg0L5ft+af/UmP9qGA9Iq1K34VOLlUScVzBP2Pj5IC+2L+GCv5m+IDjHJ5gJdjibkLTH3hDSrrrkrSZoHmGROmmN4Rl0KojcE+5x2ddtIuc1FkJUIJa8FQGE6Soay9FiztTKvoSFoU7H3fzuueeEogXzeZRdq+fAdPwJC2pGj7MnRO8rkJm/cgMGSngzmidLYBa5KbZjNn/nuarnpMgGrFY2BexdM7l7DbKeL4wwBVk8003cjS97CLODL5ZiJl3qPjVsgA+0fk9/k2FnEF+CQhsVEvm2ABA0E6MYOHj/r/a8rXEVGVTGC2jhc48f0Rnj7x6oTjmAp2Gq/GPdjGk+OCBL4GAgvJkmUBEaTKKvvmxgd+8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835761e0-38bd-4d5d-9514-08de680b4277
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:44:30.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U8ksQ52ouHCda6JECLJvmgvNqQx+7m8wKepGpuK2mv+NdqaPihsfoCnKTmpyDDHkL/22Nkb/iEcwMyNhh5VbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF9BA2D2998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090158
X-Authority-Analysis: v=2.4 cv=Adi83nXG c=1 sm=1 tr=0 ts=698a2b16 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=cU11hptOtYW8uLkjrFMA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12148
X-Proofpoint-ORIG-GUID: ICvlLRZA0enzEYO-mW8--q1v8tOfxqVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1OCBTYWx0ZWRfXwddEpke44M+4
 gXhVDYpY4NG2OfTQPlnMxosb09Xgdo9GCI+ZyoIGDpMBCiV9zXKvfXzf08WjPNp2OIDmhiP0Tpo
 rqehI4SjN1vSqCdtDGNh1DjFgsv+iCS1gWRcI+H5vFigQpuvYCeHA/8WVhaAi9BSC1XC2TxeAYC
 ohVrMHEWLllAZtw6Xuenw2yGcwRuAl1KSL98TK0OvvNZduD5uk4Qk239gFi8WLpe/PsCzp+NpgV
 SW9HLDKxiAww9BFVoE3M+8HLDcKyKD/+tTtuqqmdhJ9aSyyLgv29LWf9ur5slOXe1UWr/d8PCLw
 1Nb44bkf1vtAVtVaOnNboQPx6N1fH1i3M5xDOhuWEQkuu61h7KKTi5Avq1yFM7cgNH9Qryk2c1n
 ao4+jqN54xd+0NukM83MDJiJeMapEccFSIA5wrf8gry91uL4w9hYDRLoqpAUu+FyYgIAWQG4w02
 d6nymsQzTCQs4zEWwV3eWgxVeqkySqZV8oVsi9NI=
X-Proofpoint-GUID: ICvlLRZA0enzEYO-mW8--q1v8tOfxqVN
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76731-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 521EC113CAF
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> This patch introduces the mk_vma_flags() macro helper to allow easy
> manipulation of VMA flags utilising the new bitmap representation
> implemented of VMA flags defined by the vma_flags_t type.
> 
> It is a variadic macro which provides a bitwise-or'd representation of all
> of each individual VMA flag specified.
> 
> Note that, while we maintain VM_xxx flags for backwards compatibility until
> the conversion is complete, we define VMA flags of type vma_flag_t using
> VMA_xxx_BIT to avoid confusing the two.
> 
> This helper macro therefore can be used thusly:
> 
> vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT);
> 
> We allow for up to 5 flags to specified at a time which should accommodate
> all current kernel uses of combined VMA flags.
> 
> Testing has demonstrated that the compiler optimises this code such that it
> generates the same assembly utilising this macro as it does if the flags
> were specified manually, for instance:
> 
> vma_flags_t get_flags(void)
> {
> 	return mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> }
> 
> Generates the same code as:
> 
> vma_flags_t get_flags(void)
> {
> 	vma_flags_t flags;
> 
> 	vma_flags_clear_all(&flags);
> 	vma_flag_set(&flags, VMA_READ_BIT);
> 	vma_flag_set(&flags, VMA_WRITE_BIT);
> 	vma_flag_set(&flags, VMA_EXEC_BIT);
> 
> 	return flags;
> }
> 
> And:
> 
> vma_flags_t get_flags(void)
> {
> 	vma_flags_t flags;
> 	unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
> 
> 	*bitmap = 1UL << (__force int)VMA_READ_BIT;
> 	*bitmap |= 1UL << (__force int)VMA_WRITE_BIT;
> 	*bitmap |= 1UL << (__force int)VMA_EXEC_BIT;
> 
> 	return flags;
> }
> 
> That is:
> 
> get_flags:
>         movl    $7, %eax
>         ret
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Besides the part about 5 arguments that has been discussed,

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e0d31238097c..32c3b5347dc6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MM_H
>  #define _LINUX_MM_H
>  
> +#include <linux/args.h>
>  #include <linux/errno.h>
>  #include <linux/mmdebug.h>
>  #include <linux/gfp.h>
> @@ -1026,6 +1027,38 @@ static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t b
>  	return false;
>  }
>  
> +/* Set an individual VMA flag in flags, non-atomically. */
> +static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
> +{
> +	unsigned long *bitmap = flags->__vma_flags;
> +
> +	__set_bit((__force int)bit, bitmap);
> +}
> +
> +static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
> +{
> +	vma_flags_t flags;
> +	int i;
> +
> +	vma_flags_clear_all(&flags);
> +	for (i = 0; i < count; i++)
> +		vma_flag_set(&flags, bits[i]);
> +	return flags;
> +}
> +
> +/*
> + * Helper macro which bitwise-or combines the specified input flags into a
> + * vma_flags_t bitmap value. E.g.:
> + *
> + * vma_flags_t flags = mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,
> + * 		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
> + *
> + * The compiler cleverly optimises away all of the work and this ends up being
> + * equivalent to aggregating the values manually.
> + */
> +#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
> +					 (const vma_flag_t []){__VA_ARGS__})
> +
>  static inline void vma_set_anonymous(struct vm_area_struct *vma)
>  {
>  	vma->vm_ops = NULL;
> -- 
> 2.52.0
> 

