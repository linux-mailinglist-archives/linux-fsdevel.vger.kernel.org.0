Return-Path: <linux-fsdevel+bounces-61920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B4B7C5D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1D1BC1A34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96A2EC546;
	Wed, 17 Sep 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pi4tXPwv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VaEpHfeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582C27C17E;
	Wed, 17 Sep 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107765; cv=fail; b=Lz9JOMFucyqH2wwrFXO4APgbhgEHUXRh2Dgu3wuU2rBlTlyrKy1yoArS5i9wsAmm46G4ZuePNzy5OPKMmt8Mi5p2xh/hpXhwgFeISjGTN2ZKWKe9VOK22sCg2WXKwiRkcJS0hSBTYfx3OZNkZ8SfvGVm644HTJcmAow4hI/H1dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107765; c=relaxed/simple;
	bh=hkUMSFIOGVk54V91M3FjKXuVA5Rq9rcln+GvKhdKD4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iHIAGWZgKh7CdwRdv42xdMpXkb9DfY00bI1KuGijGeqgE0WTB2NXu+a+rPZ82w587kB5Bs7R+9peMWRclLZ5co1S/SUFW1Ame2P82btJi3gs5gvK8QNvBvdR1iAZ7HbMnhivP51QN/RiTg4xOwD8Hrpt8DDrp8NqQO65gDLupwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pi4tXPwv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VaEpHfeM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAQrJp012109;
	Wed, 17 Sep 2025 11:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hkUMSFIOGVk54V91M3
	FjKXuVA5Rq9rcln+GvKhdKD4E=; b=pi4tXPwvl3WCPmQuL8HIziTvpJTGNLFflu
	QVZH8o++E4OaK7r6ap/OMWGt3+flE6qL8pFIPcbSSOn3LLyuMSc6snLdioOn3kwx
	kJ+iRxaBOVddE+X0c+CDM2VImxFoZ7fh13RN5CJ6THVOkqxkFiFk6CopP3Hwt2Re
	/tSD46Irj3q99MRNwsCYQC6wlMhUHGtioe78kYfPfYkrb5dMrMETIy/FiO77TdPU
	/0dfjum49+DNZ/DynaaIgROQiKsuU2PFdiNelyfnZeF+o+h/nPLxMNCP2O2CiwvR
	jNIBnnejCl3gji0rlszCO+kh8IYlulUDsDgV2cP186k/sB3913HA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0k90n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 11:15:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAe0uC027257;
	Wed, 17 Sep 2025 11:15:18 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2kwcgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 11:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLU5jdAuaJxd2xiYdyl2optorEtyLs/VunZ4xMlo8gR4HI82flgoooa0xB5kto2CF2x84dQan2/PxIhiaSYqY321sOwhSot+jUVzuFVapvDS7nNUNyJ2CZ/CRhhWEjSdTUnZmnYHGScbcScQ9q5Uhf3rCtoHt0QNlHzZlXKICTsLFvEgjw+YwLe+uFVaiBcfNM6BMXAcWjMfZcGpmg7SlU8rSnrXbFEgx2mjkonihBeHGPscHuOx9+fm//51KRYo5NK5Afp6sXMpgljG7uUTvbR/qUh2CLgJqU8oMmVz0W5MevMO7ue1xcoxyJvHSaZYUpHkLzLg37Mr8KVb8f1yzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkUMSFIOGVk54V91M3FjKXuVA5Rq9rcln+GvKhdKD4E=;
 b=K9EFFWxyhyZqBOtypUkAzNpIS+vULOcxGomOqYzn+4unzisLZ3FF6O6V+rI0axJ+aJlBOxs0z72ZJincFfxiQuVPOGShzdlPiPE8YwZZXpIKR0c7uqh2CFECORz8JqbHN07Jw714QSxjg8NyJT5mT52wGVLGSebegH8M4BptULYD3ppkJXGQyy0Axo1I8sO2HodqW8gizi6B5FsgcaJUI7l8eW4+fmVix0c3HHzoXdTi2ajYYRILlJwRp7ld2ULOPmHAQIr6u8I/yeOFzIVGmr8um3waJIcdb4QTwEV3LpukIrGKm4413k+mVdC4IO+nQOSmmrmJ8BlMNdC2yxVEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkUMSFIOGVk54V91M3FjKXuVA5Rq9rcln+GvKhdKD4E=;
 b=VaEpHfeM6CJOuIFCaxCuZwIPSMeRY+f82PGRuuLGcrzWnGqKMlRuOZ94F46QYIP8TbSs9Vi0du5/HavK43PmZY2pnS21useobkE7WUJpQxsidfkVm4mSfBJH0bXoIBE7jhLUNNvXpaNkPzEQ37zag2VP1djUWwu7j2xZD9Qbe2I=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:15:14 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 11:15:14 +0000
Date: Wed, 17 Sep 2025 12:15:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        kexec@lists.infradead.org, kasan-dev@googlegroups.com,
        Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 07/13] mm: introduce io_remap_pfn_range_[prepare,
 complete]()
Message-ID: <c8eed40b-e0d9-4251-8cd8-6219890d6935@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <3d8f72ece78c1b470382b6a1f12eef0eacd4c068.1758031792.git.lorenzo.stoakes@oracle.com>
 <hfczgna46ok6zvh3xxgzdhf5t5nzqybpxkmvuulbzncagmgrcy@ase57zw2xsj5>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hfczgna46ok6zvh3xxgzdhf5t5nzqybpxkmvuulbzncagmgrcy@ase57zw2xsj5>
X-ClientProxiedBy: LO4P123CA0593.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c4e0b2-fc7c-4d70-42ba-08ddf5db79b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTaE3RoL55s71TNIWcOlBAkZymuQc/UxbzxUhCVcVprAa/fxX65WCQZhWsyf?=
 =?us-ascii?Q?DgyhcpnEfV/Aq9OyiaVZr4QGynYFb/gDrd1r1d4v0T90lgbnrTqvo3kGrNnx?=
 =?us-ascii?Q?oins1p16illB3UxVYJtq0JidzTRNRjWa+SiNBIaGXZPdcbC4CTgA1x/BGH1T?=
 =?us-ascii?Q?+nJ3bjGk1TBKa40kdbouiObsCaFJUXCnyQTjiugF5+AjoPX9v/92KCTM59tb?=
 =?us-ascii?Q?gZulN9m7GCX1fM/6dJY0viwjQK3nhL0kZgEDQZ9QXhjgMEeKkjlG55Yfkf0J?=
 =?us-ascii?Q?SdK1Z9lVQqpOh64KaKBo1rKv61Jw8JyMIwohQDpHuvfWeh/HX64xaOLPy5Nx?=
 =?us-ascii?Q?MzmbfIO8a+x4OoyeNifcSOFgLdx4sPfNb+jIj4V2aDOGrYCchLy2Oa+Jb5vf?=
 =?us-ascii?Q?jlCsC7LjTBwR/WltqFMSmD373LcyJEmV7CClW483QbYR6UsJOlBjBUbAmdOB?=
 =?us-ascii?Q?JN0h3u8flV/YQZLFXR4TGmzslhSpUyWC1+EEJQ3I3PmayDUKOeheplqCHDOc?=
 =?us-ascii?Q?Tf48LSelkDLzt0qaOAbMzpvfijK4SGv1hcwSc2PfIfLum3RwZrKJ0e6BsStz?=
 =?us-ascii?Q?0g7tGUNFnAJgjgIhvEnlW8lt6nx72GtKVI9cLSlv+XfYpQD22fjqBvu16Fwv?=
 =?us-ascii?Q?9XIJRT1HFQDgzGkqf8RJKraEghBAkzULmTvQLjB83DR+TeofH/SXCqjYrBvB?=
 =?us-ascii?Q?hHRuzLGoUeVkE7+itoKRpqXpkXHn9Rs716jWv//yXF1lOO4jaehmVi/ZP6dz?=
 =?us-ascii?Q?8jn+r58hdwtm3ICPxXZ4On40IDYrGRSSw3sxu6Bs/rQkHp8Vl6ZHWNniFEa4?=
 =?us-ascii?Q?2SZwzwC2hW8MfviNULPKC88sJA++gvitsIdGNiI6IfCAWL7bqTP/AOr0S+/f?=
 =?us-ascii?Q?y/CtPbBpiNeBLeENEPA2fKODDNNic3HGD6fac1V8sw/v+MA96YNCS7VivMBi?=
 =?us-ascii?Q?aZVrksjm1XXGphpNDP5xQ2UtESbBq21tp7CpABBFS/nTKa0SN8fnpe3V5/5H?=
 =?us-ascii?Q?ojcuNjew6lh/59I8fAj7un9sEF7C2yCCIpG7Ymmt7ub4uVsJ/t77CeA2p1vg?=
 =?us-ascii?Q?xq2HSBpdlgohlYdbz7rFjvcDmbeN1VzHfHGSFAxzzJl1jT8QdhRBX6WGDDLK?=
 =?us-ascii?Q?9NuhIw1c0fuQEeFWizBZNhYKLNh5EbVmt68Qh5HhKR/JUWUXE/6xYrF4t+gk?=
 =?us-ascii?Q?KQH0de2jLcdqDv4b3kJRhi68Zby+GeWR+zCqx5glXubfoxBWm2ymRx0YN9ZE?=
 =?us-ascii?Q?mweecw4A9Tn8Ee5wrgAg+EPfdCHUL4cWbLGBzqb9+yH9MMI58CQMu3tfTHwG?=
 =?us-ascii?Q?JrF11yvlCWdE1uqzahVzKdy4CBYae9C6g7lh86xVFjhszqwKaJtCTxOQhZNU?=
 =?us-ascii?Q?66mT2YhynzEZpIvajAZQwg8i/dgqpegNkZu+lXWK3zcB6YJRof2/KIr9/vHJ?=
 =?us-ascii?Q?nZHVDv5PGcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IL/B67ICtKHoPLCXXT7VHoNiSOGSa7T94K0BMTaF26sU2WGne3qjXN0yyo3U?=
 =?us-ascii?Q?uGEJuGNigYs8BFYcrAnF2ur6FOZj8tzrFXJlz2SWGKUhY7AIzOUG1uRmFXNK?=
 =?us-ascii?Q?ceWpnbXG1iV0TPYM8VyQVBEHc0Gp5XiHuBoD/ltuRop5+4H/sTkKzqNiNYde?=
 =?us-ascii?Q?6IINEPHpf3p/nbh1hfsdsYYG/P1YT527TedKAS9UGhJJVaKH2NNU0FbEzQek?=
 =?us-ascii?Q?zHEhwjERrE5BRpErG2NHs42tYV8JqAVMw9G2Ct+Yp+/Tlw8bnFr7s3x5AX9T?=
 =?us-ascii?Q?FGKoIl7ViJqQZYR7nFa3kApH5wbgkWQI7hyvWrq4gOQ4g0DFC1gm5rnYxGk9?=
 =?us-ascii?Q?FaEqSGVG8GMD+Hb9yrYslq6j2f7MnxpS9qvZVr7jquYk8jC1w8W57u5pV/XB?=
 =?us-ascii?Q?0CZ+6B2yyGc9p3hF6JQRs8juTMdX0rP7H6KTis51Zd/jiT+yFeM+XTg/wtdT?=
 =?us-ascii?Q?vpCOrCMCVRIUaU+hZahzu3UK82ToDLpwLE2lgCNKupDHwFFSW6XQZ09m/Y3W?=
 =?us-ascii?Q?c1Y3pyYNS5en9bvhhL+q4HMbLQqvX6Q5c0nWFnMyU8QVYfxeCOvJbSCcBUDs?=
 =?us-ascii?Q?ncFQ91C27uy0r809SH7lVl+oZNUxSoJmP2gQraGp8dM8/bh61tOTgafJSQEg?=
 =?us-ascii?Q?ZHlWug5atYMkrbY4NCCst6eHc4qV23kFqFX46CMTcldfzNT1RF/LLFJ7Om0V?=
 =?us-ascii?Q?8rn4mKWDNtbyVrctOX0ej81GIjZ6iOQECJhxfkStE+LrF19l4MwIiUliag4u?=
 =?us-ascii?Q?Oz6LAizFiYZGp/PagQMBDzwmvPkh3Nk8nvJOeo1oAeWCsdgwOmLFP+eWby29?=
 =?us-ascii?Q?C22nClXg0bfxmLUDEHIFMP90y5297fBROVIFtSGgbQW3dp8uwkz6dgMLAGeb?=
 =?us-ascii?Q?XgjggVntzFQPTcJfHeH9bSlQu+mXu37EjpHZseyqpP5AKvY75XihEjw4Yuvw?=
 =?us-ascii?Q?okGLisOjaBqBG8QLz4bXdyCbLlAPKxo65OSj6mNujE/Zqmg2HLyEzaGIGG+6?=
 =?us-ascii?Q?2zW7JBMP2/c/xy0wxcZrLwNZGGSpg8Gyo8URQXzdemx9WYCF8U0u39HHdAD1?=
 =?us-ascii?Q?A1qAeTrbqWtx35V56AiLTIqPoF0fND9cfn+smAYdKXTKo2pa+lGscAx1c/gL?=
 =?us-ascii?Q?Ud5mZ+HUGka1NqFz+SDT39voZbad5qf5RiBgq/FPboyABFRvBjlWb6fgOXJP?=
 =?us-ascii?Q?UDWI+VNYZ97dWeXXWtnQbxcBrgcNcNbw5Z8UlZnr/sP9lf9yVnBpltCljP5Q?=
 =?us-ascii?Q?ktM/5syzxKbsSfXurHLC3sWN/PxXjHCvcSH8WoK1mNDQKcpHECWQdQ6eJ//9?=
 =?us-ascii?Q?gKGIMgV8G8KYwqHuFjl1YEe2WyTgeSsGQ8mVT+VJX8CGF516IYLfbRJOGESL?=
 =?us-ascii?Q?vwcyHQj1D+5g0jQ/ry7fb8hOVrGKYRg9TX2AgMzcOge1ExNEbd+2jjzmtK7O?=
 =?us-ascii?Q?EnT6KEtd2T9QlkWotMt4yGSDEvmt0Bm3u9S3QDbmFwwb1WLtHxLzLRjWI6XX?=
 =?us-ascii?Q?mejwvTwnBDdjXj7pvWglwt45IQa1VtFhrKf780W30XktU8B/FZifaXIxJ62t?=
 =?us-ascii?Q?r+bjUYKVZ/i+xtfSTYdU6eDD0vHya+sb3dlj++YHYwBFEj9blUGijGyxas24?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qYoxzZdSppvo9nVNdKB7HYXViKKKNPYta3C9tKGGo2ksrHsVDWBlrBL6W8GXwGKhg7hISwR1qNiw1Rz8w3s7dJRmDaCyoth1ctVycr6DGvF6OeYEDtePlIdjwW+Quz2P9ifA2hTjHI0yaXzB6YntIB1auolRj7JUg6b/OrzCf55YgM2iU3gl+plBWeqzK9GQhP0ejIDflE+hT5mYFw0Qe2X700PU8IBc1AglEidh1foJkPydp+oViTPgYlBlwtT8ftxnKTSkJ4ScWVqBlFU6k8ZWpVwOjLwiGgWGVrSa3R3W3HBltEdHzehMEhzKnevCOrdd1cHioOX/shqDXXqmNPuh7yXOTX0tUECpdYPgDt7hGfYrh+cTgHXahvz2yvKaKCRvXjsarfybujerDrMw7s2CiHpa5GOludSI5WINj+FoEuf5bts2XC2aC7EI2WtEzlujKEsEu4u517NR5DMZyAI7anvAIXbXxfYfCg73SS9impfX/IL9sEoDtyrqVdA0Q4T0989+/g+AcShzBxV+sDFHpxaDe5tlsnc0ougUkqSba2Tr+EDeoT7dgkjIMM/IMhqx3L+zREwePQLtaVPd5/QeEXBUEW6PoaLUMCk2ip0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c4e0b2-fc7c-4d70-42ba-08ddf5db79b4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 11:15:14.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fv7qtDH8eUAXeDCZz0yqHaLgrf7tDfAuNzowTbUqpPzylE2RdB9XGnbNkYIL56wVqtgA4EPg3ITJS7KOKDWf9pqYT7o8tBcpWYC0DQWQp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170109
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68ca9847 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wByeK9wiTKndq7Z3TXQA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: TUjq9JyozUCaW_BQQwJc2G0d5PrVIfEv
X-Proofpoint-ORIG-GUID: TUjq9JyozUCaW_BQQwJc2G0d5PrVIfEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX0sSL10WMVBry
 doMiVxitY9Iayg+1tYuJI9kIt2s8mrCD2f8iNeYJhclem0O0sfzjIRf5HCe7OV1HLnxfZ0ZaLWU
 lqzekE1ZfZ0/By2W6qspueYey1y2uxcQn2eton9jpvYYY+yV5kQCDcLgN3L0w2HByIOdmp0/RSZ
 l7vZ1ddqLuZBR6eVPizGTzeTT/q4ZtquCHn+mv1lNYGc503EMy3UYWPkEuefC/7vj2lnLOACBuc
 szWvQFuAX2yJfUNlagwo+4GDilIlsmpPmoCm9fYOdXgVUsy1cU0lLg3P1SCcy/R1guC2xWZfm2+
 RJp4smJDbjBzaxX8uiKfjsO/jIJ+eVC6Oga5MphCGeHwzO9fA54G8KY9Qk8fJkdn7m0GywX5pGq
 NRhOZDkB0gKUwANxQWFYQxfvA0+puQ==

On Wed, Sep 17, 2025 at 12:12:17PM +0100, Pedro Falcato wrote:
> On Tue, Sep 16, 2025 at 03:11:53PM +0100, Lorenzo Stoakes wrote:
> > We introduce the io_remap*() equivalents of remap_pfn_range_prepare() and
> > remap_pfn_range_complete() to allow for I/O remapping via mmap_prepare.
> >
> > We have to make some architecture-specific changes for those architectures
> > which define customised handlers.
> >
> > It doesn't really make sense to make this internal-only as arches specify
> > their version of these functions so we declare these in mm.h.
>
> Similar question to the remap_pfn_range patch.

There's arch-specific implementations, which in turn invoke the new
prepare/complete helpers.

(This answers your query here and on the remap_pfn_prepare/complete patch).

With the abstraction of the get pfn function suggested by Jason it may be
possible to move these over and just utilise that in internal.h/util.c.

I will look into that.

> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Looks ok, but again, i'm no expert on this.
>
> Acked-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> --
> Pedro

Cheers, Lorenzo

