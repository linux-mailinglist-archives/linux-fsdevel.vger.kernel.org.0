Return-Path: <linux-fsdevel+bounces-76730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANHYLaYqimm6HwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:42:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BDB113B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 519823002D02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF23A1E70;
	Mon,  9 Feb 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qmi/Bkz3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+L9T3dU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693C220F2D;
	Mon,  9 Feb 2026 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662551; cv=fail; b=XBl53BHgJg3y/oIckaglLPb40rpZjmniiJceCbzQVQfckrLs0THz11t2G/9QLVO3X8legfWbPCiICVIdhNRDEQaoVvirp9r50La1BxD+hQ0MAtVZI1FmlLz30XEdA/5dT9qXAwdF+QuhYE/FMa1G4claWTPCF2DVJMUZ/Lpzsag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662551; c=relaxed/simple;
	bh=HsgFRL4s3tuA5UWbpFtNUhmf/j3ZZ8T3v+XJkZ4JiMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZvntjQ5pvNFJpBgAN2i+VLDMR7gyq+KYM0w7HknJ4wkQbfTwkEZvkCPwaU5B7agqL22ollMXfVmFqZxTJ7ko69KvUMwzvegOpm9j+FX9ZxzWP1upGB28qydGw4UtrejaRwNzyIC+spOBnJcmVzkwMxT7nyR0v8gxGdudXMwySGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qmi/Bkz3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+L9T3dU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECfQP1822621;
	Mon, 9 Feb 2026 18:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jurXFHhDaDtP3dxLkK
	kPkYwhvUU3aA6xfBhTyzbOw3U=; b=qmi/Bkz3XNduSvhYuj+Qm1sPWrIRWI1IVS
	y6Wf//+Ny2jEvDHWisCbfvKpJXlZNsmB4/S90SvCbTTqjDjMHnOB47mFgHTYQaVe
	/67hgxhB54O0U2aKakhgxkzVi3pwowkgcHLokkj8IHcE6dJkjuH9itQNduWSFCBS
	QLJIuyMSmpFp8yzbEdOnLx3Eqdzlzp3otmW6NTM/UhMwJjeBwUeK324APTWxpEd0
	lRoUeu+sIWgArnc53kSzJpejgmu2N6M1ed3cg9FKceIlJnv+UQz9Kw/xl11JC7JX
	LbKK9iaPIsJaPxR7mm9H+QXN4JAsWvtQswitwxN2pLrIGl9v8WYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xk4th7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:40:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619HdE4P035525;
	Mon, 9 Feb 2026 18:40:37 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu9dv3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 18:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2+dSScj35jK8+kL3j5xwPePLQjfG9HqyGzsHyxwDk482Ny3YiFnflM4h23aKUCXpd1z1wwsglyrUzaYBJlKhZOJbPZsPRUyOV1cQFvbx8T69cXt0hjfc+f7CBvaxLaIGYn0ODKoSYMb/aDg8aBE0QyMe93dqpCAX0m1g0HzddHA8/Gk3rx3gsHkPM0BkDM2XYmiixeCyUkPmXJ0K5YJk2Elwj5LGvjJuqTsBjKi3h1QsWM31p+0YbI8VuXCphMyxbQt30fyAM0V1/3CyJG1rFoeLzuXBTo0RquK0a2kWEZHfqBo9BjICaZQocSgyeVCkv6xZ7DknOytraUr1Z9C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jurXFHhDaDtP3dxLkKkPkYwhvUU3aA6xfBhTyzbOw3U=;
 b=KjaHdlNAQCmhkvZXov+BDb1FkaS5ca55tdjJEDJfgv/qXOJBoHY7cJ0I7Bk0cdj3tI460zCzlJ+9MIMZpgV1VJuwI1JyCRe9bbcMdZcmwOtX7GqurHulzrVlkmshcTNbayapydoSIZ8YKG30gCEWVhXTriY8+StE9WDhyBt1oOkv41b9Ur0V9H+HlB7t4psyMv+lIj3nVxufyBe4NzbbzKErgt6b2ywYWdU1vKqClOWzq+A/P1gtWe2QcOegHrdlPIXL7BSANcS7SQlEfooY9OgbzMeqihoTuk6mUm6FniN31F4MTkIQPwI5x9Ml5BIoN5kDZ0pvhUwYb73hbfi8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jurXFHhDaDtP3dxLkKkPkYwhvUU3aA6xfBhTyzbOw3U=;
 b=e+L9T3dULoFAnrNBpwDjM5xdIAk5IakaTWlJMVPirIJI1mIix9VBemfM6NtrSj7sVGHBXZ8dLmk2e4d/nruh+3M5cTwMGCranUWU7WD7d2PsVgf/WMRWJxDNvae8q4T6hsFlH7lIWK3Phowo+G42FZYmX/s0pVCUyl6waSSY17w=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7532.namprd10.prod.outlook.com (2603:10b6:610:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 18:40:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 18:40:30 +0000
Date: Mon, 9 Feb 2026 18:40:19 +0000
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
Subject: Re: [PATCH v2 02/13] mm: rename vma_flag_test/set_atomic() to
 vma_test/set_atomic_flag()
Message-ID: <nt4vh2sny6xzfuebs4wvpzhscror6eqn6cliqgrlpkpa55ybsu@kixld3vioh2u>
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
 <033dcf12e819dee5064582bced9b12ea346d1607.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033dcf12e819dee5064582bced9b12ea346d1607.1769097829.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: acff7bc4-b6e8-4b6b-aa7c-08de680ab3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CAXaOG8Ne9IPAUPyyFfVhIQ58uZ2to8oWy8rygiIMkVXGa/KkhxEdr/6bhpL?=
 =?us-ascii?Q?qofg7a7lh/4D227Cl1asbVo/LWSDXWT6QwrGdCsoY5xXI6qFa6yA7Rg9nlIE?=
 =?us-ascii?Q?pgOnwrjpEwJhcXJdEaRKW1vyPV1w5333A94R5h9B18QtQk6RlMVxsKphDOmb?=
 =?us-ascii?Q?RInyGF6RjK3vwNQ70OeF1Xq4bxgBNMsFlqWXj+Oa8uk07QzAIzxhPo1GrWjG?=
 =?us-ascii?Q?0mriNVqIBtnddyf/ANsMx2J77RJPQzTEtZ/MfRDtuUGFY7148l+uDk/k7Pl5?=
 =?us-ascii?Q?LgvhanJEYhS1ix9XCOdcRidnbtvjJfKAHbiBpOPkvtt/06pJPwE1mbYHjOzn?=
 =?us-ascii?Q?VpBoj+7UC2iL51lU64xzTrTs6uKD5ZLLErPFwvOyLCxV6pucjDcoU9/cWDty?=
 =?us-ascii?Q?x7I43GKmvwDFF+TLIpvSiz58hIboh8nnvMkhA4iIFNmHCiqIN7gScU9ZUtQW?=
 =?us-ascii?Q?jfQgYSitzZsklvO1eYh4pgYz/7GKYHopS7JBcA1EYoQot6oWwkSjDdHlVKmT?=
 =?us-ascii?Q?UqgI2+QNacWyEhJufNCUj+xlzgHcsqod2qH5mdHcCF/avpLipnb+rv+BLA5l?=
 =?us-ascii?Q?ELzWa9PtgPlZ8F2medzNqrLfqB5PGkNYbWpcj/FS5MkBkpugXbj+zvAHpEnc?=
 =?us-ascii?Q?Enhl6Sbey8gfi1gzkawzMqATgzpD910Cg/nnwTe5/fGo2d6LWOoYIg/uelI2?=
 =?us-ascii?Q?8yxF8fnAnm17Rj2SylU90ZcJgvv47xDFX6SgOwCJdiZg1PoIkcGjbCQofX1+?=
 =?us-ascii?Q?Y9rGbFRh0hOLSWGUtro0glKXflyJUj6PLVj4XZ0KjyCjgvPVYtuFY8w2xyBI?=
 =?us-ascii?Q?jlBtFGjI9AOjlSonfbLSt6gH1orJ9wGJs0QuqP/56kArpA0CA7jzK9yTv04f?=
 =?us-ascii?Q?yx42PonpltMdclr68HIOUfL8UrokoiQcVCBbkAd/6kN2UUWBkjeaxgfojv7t?=
 =?us-ascii?Q?TZshISZMdbwa8uR0O7H8dHJuux8Meu9h6zWZPQwHVf3ub9sG58yBir6xSbir?=
 =?us-ascii?Q?bzTHFtIbza4InDefc+/I0JLHU39rvj8MoKbmQp9IAwMsgCiuxRf4GL5rpF0d?=
 =?us-ascii?Q?GGdqvHkk+MRosSMw3ThTuY8HyC1wmawjlQoUiGbH78/pKULJU2181QmOxFa8?=
 =?us-ascii?Q?w5QkNTYjNV/elPkl7j4bZCSy88Q03PLFxLwZGwp9C9yvaJbDysXe6NlVGy4s?=
 =?us-ascii?Q?c5/koVRCyFAt9aD40mMxMVRjmvkRtm3y9vuvJvfLz/6q6iVsuhbV0VNpbHGG?=
 =?us-ascii?Q?TUdHeUuqcpUp1n7bvfLVaWP4FiY+FfdUOmO/vE//q/h3qb2t7p22QhgVJjv2?=
 =?us-ascii?Q?czXeryN/N2psJMWqhR1yovNncS7+3tGsKpFGQdYLz2YeBJGgZ3x7QRtItMW2?=
 =?us-ascii?Q?q4UD9m0g94NS1XhzWPc25HvM/ucfvvwLsjMJI1VmUqqBW9JSD+haMTMzxWTz?=
 =?us-ascii?Q?RPwjk4HyCWn+9g375Sh5arzVaBrnF0Rh0Dz6RkqSnyAPhHQzmWFzY5whLUtK?=
 =?us-ascii?Q?Z90vtRWFfnzWhTT1Tc9mUv2qg3bHZcjRVqDZMNQiwLh9VOHRvneyUzozBuCe?=
 =?us-ascii?Q?7fJJ+oWxmqbCU4biQPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OPQxP4u55aiUkUCqgsDvWGSZYRvDN3uGko4MGnMDKj8btcdNYatUolMps+Kw?=
 =?us-ascii?Q?+gtrd3lbY3VptNEdaBqfRMEMHmlW01baeid811iyTh05uOndKMQmk8a+IP+V?=
 =?us-ascii?Q?muu1IZuD0vLqcF6vlSrAj+HOiPvNZWnS4wLKYZ0d3ELS7xG3w9ZQiwuOJGLh?=
 =?us-ascii?Q?SMcbt84jBfc2DcMi0kFcEV03CzRsx3Muu7VVG7ENYL3uVcEeN5astJIPeQuT?=
 =?us-ascii?Q?XnHjmHTq2oflplaeFfcjMOZksJYKCZ+DjZ9bhDn10KFtsMKYopT8Fbb9lCLC?=
 =?us-ascii?Q?MUC81kwKx2UXhQZwHF2bBhTTnB9a4Ja/kO+naYEulczS+uPNiJaafwTQXONK?=
 =?us-ascii?Q?l7yasqquYsymg8EVuXX7GEsaFOy5RrfSs6Zapio+ASJiot/52yFSSk3B0ZAY?=
 =?us-ascii?Q?5HTv/puTnl8Ykj4Syqa1RiT4+Pp2AOANMlv57WvtumeZouDaL0y2NKt2fpaa?=
 =?us-ascii?Q?xre1CJPh3kXnLiw+RF9KDHmnCSWX0JLZYDajxPpM2SXZ3S/+H9PWuvr541XP?=
 =?us-ascii?Q?xrHCZcb+DqcQ7jhTh4lvGarITnLn13smT78aDKjiPGBR6QxycHS7E7+1aozF?=
 =?us-ascii?Q?cA1JE+CVxw3W1t+A1HzXKFhoE5s4So2nHW6hYvOAuFItr6VYyKIC0oB2EFPj?=
 =?us-ascii?Q?HlUt+CFXRWumimooJYVDYWPo5ElS3ynyog7CtEH57b/xIWbuvqpoJ4QYYx1B?=
 =?us-ascii?Q?ivWIFhKk3xelFp9wSIm5ybsCAdF0FpfjWnMXppXth6/IuIHEMGxouElt2OnV?=
 =?us-ascii?Q?Y45UOPWmtYdfnuDwlEZkX7CuzleLJScwQlUeW8kHgJCuX0pWbwv3UyOSJeO7?=
 =?us-ascii?Q?hFLsd2WWJWqiiLu14ObMCt8Af2URKACJCsrDx9/s+O+NVr5MtZxjhux6V6am?=
 =?us-ascii?Q?8MhjeGvw2VujA0xtnNWkjkE1VUjQw50zZqqR6CfRsve3m1qryppQlT6iLeAf?=
 =?us-ascii?Q?3MwPqyshgFhWXmrLElwQvnpMoli/88X8Wc7sSFraAbJod0dLCruKiN2F6Dbo?=
 =?us-ascii?Q?GyAuyNVfVUmYNKiscI0U71IiNVksJTZOTRgQMRU4yA1/VHrR9sj//l4thw06?=
 =?us-ascii?Q?/mgCnf2hQQTXgo33B6Et88hLK/IiRh8EjahANNGT1tmLU8ftt3ERvd9d1ByA?=
 =?us-ascii?Q?0L1lZ+zY2n4H2+M895lypF5l//51T5qvo2PPd37tOC51ZOJZrevhQiQvqbLT?=
 =?us-ascii?Q?CVOKmKDkdJh5WJaYNrtE059uk6S8//LxOXYxLwlC/q8ixn6NePPaTY9oztx3?=
 =?us-ascii?Q?rJIWhJNHBjg7wSuuwdncrUgWOY5a9Xwkjl+b8/qQrbSR//8Z/bUa3fY+J298?=
 =?us-ascii?Q?/Gpg2/9CuWNR8H/bQm7f67ae3ZnXtjernavaTlip/D0QhG4xYFzVF+hUOTvA?=
 =?us-ascii?Q?ajDErKYOZZOkFdVBfRhx9Hz6Nw//vtdhRqFefaXkph1mRhWdvGoUrtofFxFm?=
 =?us-ascii?Q?BzzLSDP4ns7TJyKkDonParVV+dWKKOO/X7HNKpqlZSnFmE2RMyrDOSEZIJPT?=
 =?us-ascii?Q?ZL5ZAxzzZGDsSgAB6Z190m0bf4ggUS81UwhUQQ1qDjIwP/7t80GZJsHCEz4S?=
 =?us-ascii?Q?kkXE+hdAHBx9pskpbeRVcenYg/TzXFiya525/zq5AhIRiEutWDCckQi5Slma?=
 =?us-ascii?Q?xUSc5JVC9WJEMVXE4ksedd7v82LBOvQgV0Z8j/F/nZvcQxVfmc2nzOvxwsR/?=
 =?us-ascii?Q?EBJswJhA8tqh0H8CbUY0iMp46q27YgrpcM7s70Sr2mIwrbeJ2HbgslwNaBgf?=
 =?us-ascii?Q?PAAlgOaN1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iM3RWg1ODcV9A4Kwu91Vo0fIfwnxpTCtZw6kCw/ghQcSGB4kHWbsizXhNTG295WEUeQjNsLReEd+uVXRrzguMPuCPfwiRAOkPJ6obxfBJYON1gfUolxg6aci7GKCVK3iGSsFIMTAj4mi4Qy9bhDzInVPGonk+O/8JBDjXjrdVxDrPEsTaqIdwfKBbl87Bnb7aZQSPJrxadfp879RzCD+JhrlEMxOZMdPpiMC8rrbmw466Sf+dJ/QfPr7vjp99F1sUk3LjdTG9ZFmSUVPvCE1Vun/yEWjL5bYilnbJ3o+ba/vzdS/TJW8mhZyG2Y7z4ffpmDV2HAYteMQbIbYXzsu+8AuoiZjR+jrRwnK+7YFBZtuim52mQKLQ05iJ9lRxaGKQZ3HM3Dh7LF46J3qUqKyLQN7iwHSaQfGDvpqpf8J42u/CFTLx2FTwArmj42gDzC8HkMFj2+mfzu7LGqXY7jtWwub21Dv5XNnKWxD8bgYdsrqnLN6rRwBD/oiZ102wC/JJZ1N1Sp+YoN8xlznPDXhStKQXE87En+HSAONowVauZXDos7IyW5I7Nh2koEN+ADv2zUTEAfTTVTyDVQx3zBg6NQO+ZQxfYZcdhzMeYiFQnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acff7bc4-b6e8-4b6b-aa7c-08de680ab3ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 18:40:30.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN7ak0/FUAGHGegFL/6ubyqxt0SFtFuNvvKDf0Is+YAcDrBpCR0BuZj/ypjwaQOfzUNm6ZgNvVyFTXbQJXiOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1NyBTYWx0ZWRfXwWYb7WXPIvRu
 nkZtCIkqJGd2/m1jonnHm8YMZ8BJtfQKa9qyOAuPyucnKdenMOh4uaQ8pgwNBKCZbu2jWeX5IxU
 VaT2PdElKNuZ6+L3ry9ZRDjYC2G+NkEsLa0ijY2BCsI0FC4XSgj6x4SEdCcpfwZwNwOiBYEMeZ/
 wZs92s/+Y06AxVv695cDrdSJhu1Phlh7kj8awZ3ng/8cZPcVJq+PhKA5ccM63wV+l3EHe646oQ1
 oE/UfZVIzzqkxE//F3sJLrnFFKBiRZAtT+qgCp2HWPV8PLG7iu142DxS3ACbNWaou4brBifqXc8
 qyNnUar0ekd1Le/uXq/Ii4yzpfmJRl3I4hFsxmo5ddEzlQ1uK6vvm4loDCnZyc4ienPeRYMaEL5
 Su5XA7h8VyYCNrsilh7PTkh9VxnZPGcpPu1/itkBrWGTl3UEL7QPLoQ72fpmsXtRx/eYFYPh6qw
 54aqeB7WWkv/aLUwG5g==
X-Proofpoint-GUID: XicvhZCiWlmWEhrBIjrwD9NM852tx20E
X-Authority-Analysis: v=2.4 cv=ccnfb3DM c=1 sm=1 tr=0 ts=698a2a26 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=XjIor7wckl-Q5dKBHhkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: XicvhZCiWlmWEhrBIjrwD9NM852tx20E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76730-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C2BDB113B8B
X-Rspamd-Action: no action

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [260122 16:06]:
> In order to stay consistent between functions which manipulate a vm_flags_t
> argument of the form of vma_flags_...() and those which manipulate a
> VMA (in this case the flags field of a VMA), rename
> vma_flag_[test/set]_atomic() to vma_[test/set]_atomic_flag().
> 
> This lays the groundwork for adding VMA flag manipulation functions in a
> subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h | 13 +++++--------
>  mm/khugepaged.c    |  2 +-
>  mm/madvise.c       |  2 +-
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 776a7e03f88b..e0d31238097c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -987,8 +987,7 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
>  	__vm_flags_mod(vma, set, clear);
>  }
>  
> -static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
> -					   vma_flag_t bit)
> +static inline bool __vma_atomic_valid_flag(struct vm_area_struct *vma, vma_flag_t bit)
>  {
>  	const vm_flags_t mask = BIT((__force int)bit);
>  
> @@ -1003,13 +1002,12 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
>   * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
>   * valid flags are allowed to do this.
>   */
> -static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
> -				       vma_flag_t bit)
> +static inline void vma_set_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
>  {
>  	unsigned long *bitmap = vma->flags.__vma_flags;
>  
>  	vma_assert_stabilised(vma);
> -	if (__vma_flag_atomic_valid(vma, bit))
> +	if (__vma_atomic_valid_flag(vma, bit))
>  		set_bit((__force int)bit, bitmap);
>  }
>  
> @@ -1020,10 +1018,9 @@ static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
>   * This is necessarily racey, so callers must ensure that serialisation is
>   * achieved through some other means, or that races are permissible.
>   */
> -static inline bool vma_flag_test_atomic(struct vm_area_struct *vma,
> -					vma_flag_t bit)
> +static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
>  {
> -	if (__vma_flag_atomic_valid(vma, bit))
> +	if (__vma_atomic_valid_flag(vma, bit))
>  		return test_bit((__force int)bit, &vma->vm_flags);
>  
>  	return false;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index fba6aea5bea6..e76f42243534 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1741,7 +1741,7 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
>  	 * obtained on guard region installation after the flag is set, so this
>  	 * check being performed under this lock excludes races.
>  	 */
> -	if (vma_flag_test_atomic(vma, VMA_MAYBE_GUARD_BIT))
> +	if (vma_test_atomic_flag(vma, VMA_MAYBE_GUARD_BIT))
>  		return false;
>  
>  	return true;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 1f3040688f04..8debb2d434aa 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1140,7 +1140,7 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  	 * acquire an mmap/VMA write lock to read it. All remaining readers may
>  	 * or may not see the flag set, but we don't care.
>  	 */
> -	vma_flag_set_atomic(vma, VMA_MAYBE_GUARD_BIT);
> +	vma_set_atomic_flag(vma, VMA_MAYBE_GUARD_BIT);
>  
>  	/*
>  	 * If anonymous and we are establishing page tables the VMA ought to
> -- 
> 2.52.0
> 

