Return-Path: <linux-fsdevel+bounces-61801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E4EB59F61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C994601D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1F2F5A07;
	Tue, 16 Sep 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cRSLDayP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RReHtjdz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFC32D5BF;
	Tue, 16 Sep 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044118; cv=fail; b=GkNfuEu7mEaQWc5xRXhiEVS8ioUS2AK7hj27T71BFK0983i9ykGH7ywiIvIS/1dBF6vg+OhWm7FOI+Zh/h3LuN51bXOQBnjoB/oOXYSUOLnfGKusX8Gp+r52XvMWdSddPmc6Qtb8mNMZT6ib+5He7CzmuU5Btxa53/6sN6qf+vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044118; c=relaxed/simple;
	bh=YESSuEmxylm4XZLLpEHX5Qr7MADi8SFO2BksB+WX50o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BqHXtMgHLDm45WZR7tTSWUx5b2yMZdKrgYkaAeamCJ10WGrudp44+OjHKMIX+zGWPF2zf0tgsiNY5QABLw3gezfzIMpb3VDePH8XXYiViU+wHOSAJLLDHZTbCr/tgKeAftdfBokI135F67W9buNOf2DIJJOoAD4UxNJljF+nA0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cRSLDayP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RReHtjdz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGNIPU025405;
	Tue, 16 Sep 2025 17:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=McApbIJyk7JoTiNouC
	o3jTLW2l1hz95cZ0yj5iWkaOE=; b=cRSLDayPPYL9xKcc1t835Ef+/R1tmzi6+g
	SdmcojqAYwG2wDaXLTWU/WDujveK2ScrE4U7pFEjVAHkSzwN9oFL+aKumeQzOXEJ
	dh9LVj0Qw+Ya5fbymVwHFqGNZVHyroRDepR6q7SSnHLd5ypNM11qEf1FJBRU/ZOZ
	vpyAmmBprHNOUsAHMhcv5rdp8wEBFVz7sBTRGW4r8bPY6HIWH2trspbjZxA4+htW
	Veu3ng+jj+1KkYPq+U86MV9Bdwigyw/0GONHYwTEJ9nZcHrSZ5su3u5MPFbtBke/
	hAAX4+G5iLN0VCjAU83ikBzlpNTYqS3VcDTiuQtjIO+BdlnlQMfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v54v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 17:34:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGcgbq036763;
	Tue, 16 Sep 2025 17:34:31 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cqufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 17:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkNdtYYaHlQ/iES5CPLbmS+xwWOwoTebid9TgzS3i8VJv3X+lCKk288MUZEToEVSc+aQmjR07Uvlwe+NtgoI2NZ9UHFFgmpKxL3hJyF7J0YKO1P9WOJAZkBgYhKE1B75LxNQyh3k/crdzCIzG061czjemSeog8KI96t31BuFtOrHyy90Zt+fOFhjxbJAmFBW5KV6cbCxNx99yb9AymWF5r4yWFWsK5b4uMO2AIYEsTQtkcuACnBLxkZo7fbCZjjo+NiYCMuXXcIHckf6QK21zymjvAVeSHC5Y1Vu9fDCpBJSs4I6DGwFe0emtmw2QckLhghXJ1VVZwGKctYSjaIyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McApbIJyk7JoTiNouCo3jTLW2l1hz95cZ0yj5iWkaOE=;
 b=vqaMcn3m1p5GzXVfw/ttUzX8drlKIoohNqiA+ZuAGcT9J9ieALu/Hx5WtcQ6sLXAxS4ErXzSE59Xw2VR1NqKGucZtOKFxBwzDOJPXuEZ0Au7f5Ph16zSTz9hW5/55nwYL0BnFEspaiI8ElYERPjOQ8O04c/yYduk2u4b3CNoX14/5LnbxQ6031vV7wZnPosrUeLb8puA7GDI/1bimqvbxJadwtWJJuq+JwF01c0Jw5ok1ZJuN4WUquCl5vG5+mZIRz1sP5S6SglLN2FnqjhiNJeNmjc94X0/o8TbWgfgV+KXqU4VtDqUFtNNarcE4gykpGKqp2hWztxT92ypsVYaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McApbIJyk7JoTiNouCo3jTLW2l1hz95cZ0yj5iWkaOE=;
 b=RReHtjdz1q+YB6eOYOyIoOD8DLyXZSEpM7mY4ghvMm2Q1P9N2JIoBbPBglM8+sIvvHhHF9ypNdr4xlMoiZskQpiEWJxcAn5xX3GtFbsIrJyk7eI+WcKLXubmRyjtilX10hCUVoN8gpq60ziETTglSV8v+YNo4K45WjOTHpKESIw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6474.namprd10.prod.outlook.com (2603:10b6:806:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 17:34:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 17:34:22 +0000
Date: Tue, 16 Sep 2025 18:34:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 07/13] mm: introduce io_remap_pfn_range_[prepare,
 complete]()
Message-ID: <07448a14-68f9-4577-9c00-36f63c1f2e90@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <3d8f72ece78c1b470382b6a1f12eef0eacd4c068.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916171930.GP1086830@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916171930.GP1086830@nvidia.com>
X-ClientProxiedBy: LO4P123CA0302.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 487b859e-1e92-45b9-2dfd-08ddf547464d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EC3ZOLdcIDN1AUPFORsVz4qP6DsQ0XY6VcurhdegazhGPFtpFGsptPmORc9A?=
 =?us-ascii?Q?vh3z8whPeEHHsXA3mm05NCG/5LhZB4StYkFFoyjQfCoH4D3cupIQyNxfZcSH?=
 =?us-ascii?Q?v0rY1Ibq8w1TK0BbKwcj6lV4s9wM+YMF8Ib5oWTPm3r7kzrb3ycxNFmgb5mL?=
 =?us-ascii?Q?zWYpOixIWxGrn2MLwVDqdpCA/+zdtlJ8z9aI9owRcauz4bXU14eGRSMsu3fD?=
 =?us-ascii?Q?IUoMnCWQUFgcJ+rIuFR1TY4HLXkxTghTSaNFoIu85DeHd8b+RKaNpJhGL2hp?=
 =?us-ascii?Q?xAJ/K7FZGxSmgjAq19SgkY1frChB07zVkSeo9mbSyz2Trq2q6meR7W6Uba+/?=
 =?us-ascii?Q?jiVcmKBP2YD4868ZvOgP9YU9NCIpXQ+duV2SdzsszWgRQpNgbYkRiGSrbgT3?=
 =?us-ascii?Q?k+hppkYEqDEA3LH+PFMWgTpw2iDLdz/y+ayNUtI2qbDVKdjZbcEI3kXB8Mnl?=
 =?us-ascii?Q?PQrepD1+ojK2ckH5k5QD7Qe30+n/iYUGo9+Qfp9Myr+ibUvdOZZ+SdH/IxiL?=
 =?us-ascii?Q?KLYkWhSUdpab3cUBdPxHx76DJsDvk1NpErdxXaSs1oStZ5QqoYLJREMuJU3I?=
 =?us-ascii?Q?hqDLoIsPrPq/zhoUsNyDUxPser2CT/nuQQMiTkEDhrsEE8rVHM/USgT9B/JS?=
 =?us-ascii?Q?RPhD/bPFTn+iU7Wc8mQND9WL/+atzBzgZG6R4l1XVjRijGo4XkVPsX26kwqb?=
 =?us-ascii?Q?cL+MWUfOIKZZ988nV0P79mahLmCDnJ5oCyv6SA9Yl60PSKdYTgGcnymCIGjv?=
 =?us-ascii?Q?LFAKcKYWOhjNKdYTxrqVao6DVyKJsfhsRYnCqlnTDpKI0X+umwUSiiDCULMl?=
 =?us-ascii?Q?47i5b2+QeR5Wo4IQm/LoYLyoZ6BkS5vwlWB3ZAdCPr0SE/xP2Mby5lhF1P53?=
 =?us-ascii?Q?jpbjxODN17BlQPpwnAxfk+OTyBVusurPbn8eqWz8dKfGUal8XxgE+DLMumqo?=
 =?us-ascii?Q?zlvCbSwyeIgIjQpz480/00GFbTw2E37YWDAOW/lhhPJGWgmfLXmtZuUiZ2BQ?=
 =?us-ascii?Q?D7MoOzznw7V/9brc4OKPeVHCJ1PvWyKX5WPKgFlvT+2CTR/fS87Xrima1xR4?=
 =?us-ascii?Q?8DtLL9k+dosU6Hu+I6CAEvCe6SEg+vu+8sgNAti5MxLguI8xaqsjrOOgHsyB?=
 =?us-ascii?Q?yjgF1Qgk2y1gElOLcBwM5SdfKFNdSsMSryR557ksqGHYDoAww+ju5aGzTHEo?=
 =?us-ascii?Q?POJZcWKjVxWCpeikbAIXKgjQrtazbnJpYn46as7WNfmmaZCbR2qQAOU/GYQN?=
 =?us-ascii?Q?cbhB2rbuxyzMw6pflaUBrt2a4CPAVuh+VulWpPPChkNICBnaefiRL/EGIYrv?=
 =?us-ascii?Q?q8FqZ1lw9X4VnnfAXXPOFRJTRBYv460fMMAfbbuWK8eSdJJWM3hGRBjTtph4?=
 =?us-ascii?Q?hTujJmKVhX7Pb1biWzjFd8lYwV7O1PHzdjc9w62BOBLamxltWG/F0LglFVDQ?=
 =?us-ascii?Q?zLg8l4xrqzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E1Hvlxc6nE5ghtaC1WdF6Dp6EU3crJnjrVJEqbpN/4dRuxv/DooBqUxxqXQU?=
 =?us-ascii?Q?ZaXydMWTaTMq9ua0Cr1upaO0lp9Pa78rkOvQ3NyvXtJXDQDklXaG5f+WBNRe?=
 =?us-ascii?Q?8rg3sLkImKGFFJ0BKY1n47VoSdaenbJukIM61E5MtKQET3rhk6V6WJEZPdGy?=
 =?us-ascii?Q?6zTQ3wEVuFNeBDqFq8XtmHjj1PDNGRu3HB/WOP6QWf5Gpu19FkpXj+vmYyyk?=
 =?us-ascii?Q?jUjA9c6Ic28cZee9Z6s1B1bu7CIsGoJmhnEQfh0GF2UK61xldus96uGK3jfE?=
 =?us-ascii?Q?K0QyfAUFcwFAHcbsSrGL/gGx2cULPx1+mFLK1RC62pEwCR5f35pyAtUc8B+9?=
 =?us-ascii?Q?c6uWB1+f4N54y1Pd3Qoy31F/Lx4Hy2VJMR9GEEJQPp+nbwAdjH5PCAZOOI6p?=
 =?us-ascii?Q?I/hlFEmqSbQRSOLdta2wEyZ+JaGGMV4B7PsH6spKTWvdveplO82YT4DQOb95?=
 =?us-ascii?Q?n8w29wy1KqVr4C9aS0vPev5jzCTvB3e/0KDcVhtzpyrGPK8AZ910D894CkCR?=
 =?us-ascii?Q?0zK2X6lOGAL/13EhuY9obqmFQfRPpkWGZ/DVqCj6Th2tP5ItxFjglRIfOjnz?=
 =?us-ascii?Q?ZXNMuDH2eb/Mo6jBJE5WNC+aCUvKZPt8hkFkLBgUmk8sfrnakEEYwY+RVFKs?=
 =?us-ascii?Q?1+ePb2gTdz01vEaoiBtUx8YtPengvHFqfQbm4IjOdmvJ4PoEQkx3qKJVBePh?=
 =?us-ascii?Q?cquU7QAnXdqlAMQLmE4j57PKVZMiivnRmjtN4ZGrM1W1qXPwzaCxBK5lwCHO?=
 =?us-ascii?Q?t54u7ihI2EwRoE0Z/XyZKz274BwNsXeTYz+v9qVqZA+WKqM629OYVxDBCfz9?=
 =?us-ascii?Q?AL1yY97miy4jmioA3K480ALyb46WOSD1fyd9YbvKDXbk5x/rZrn+Frj9Up8b?=
 =?us-ascii?Q?3Irczy71j1M+n5nMcoqG5swVUhxewOLrTZNAhFanO0OsDmobRA2TXhtLjVQN?=
 =?us-ascii?Q?rVDhvqZS4qJQpA/bJu+eyw3mru4s++yJ3bXsKBWzrlSGcJEwqf43EtxeJyPO?=
 =?us-ascii?Q?ZjGkzDwLzHquucSPjGYxiip47lVNJha9Qi4dL+oM996CwayaCuVuuJZnlSNX?=
 =?us-ascii?Q?TUXHgapOY176PU+pNW0Bj/fKwUVa4iOcZ3eQ4upfSmshv9BWvEF+rY9wpxMS?=
 =?us-ascii?Q?O35r2XCfe7W6vIzZKyaCK+LUe4+/bA9L3GKwiFHfdlPYXEgVJQ7h/dA6/NcR?=
 =?us-ascii?Q?889Vnsowg5ruyu3QErC05JDKI3THpAaE9qzZbJeLqp9kXnfSNVpd55Ydr68G?=
 =?us-ascii?Q?qEx2XJv1hG7Afg7xNbtMBvtrS1jaz/ScwJxtOQ3rX67+Hgu86xFUl55edMTz?=
 =?us-ascii?Q?+y214a1z7OYW3qL17uCALwLXICQkd4vltL6F1c+Lxss/SDvx+DXeyR3Aubu9?=
 =?us-ascii?Q?eIeB1fA9/nV7VmQRcUbRUIWoDawrI4Qy2pcqJen20voY7a+E4t4FMo73lfra?=
 =?us-ascii?Q?CyCGseS8WtSXJwtZVHnHAQh21BgdeHdjsP5s7QEpNJu85ytzJ7IHF9xAuNrB?=
 =?us-ascii?Q?G6dBpZPkpOcr6rt1hicEZ2G7HnFWNdgREWjMDudoP8PhqnAc9/rHUfTVNtyy?=
 =?us-ascii?Q?Xgu/+SdgkvHhpaCV3ZzVoxf7CV3wIwUXBrfG8pNwfB5IC5LZwvHKJDzRSSnA?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8V8HnWJG+noNB0E2cFocpsxWGpAJFjFJ0slNYfnED9kvMecLKUG3vVM6CXXJ0q3oKWG7okPy+0GphWEfL46g4PYcMyP6U/65xl6xVAqRfx5WRxPm8nWxzxGGdqzKZu0uz2JIgPd5y5c3DTuc1S3MfOtG2SPQrg7xjcipwUtVlT+Zi2j3N3qoJOg/vTKM9CADxPG1+8BvKwKtjesvjK7MX24YQSLffec9YaLHAkpFSCSPohYLGsF6yzWdCM28mNtvGXPJW5teJohQiSqhMcFf5hlaeDT73pQ1so5LpoTAW4QTN7RohQKwNbU2N9+7RX0ooilxaH0IOMJbn0PKnthQ4YUkl3eqKLjge2jgj35SDOjHRZo26HYwTqxKJXP4SyzVyKp+ODwljb7jDZR2At7rLESrnJpKWQ1SmVeNx54FLp7XZF+EG7MfctxpA3uQo/DLZGEIvwtaPleM24Gu44o2tHR9rnx3/oQX/628pgjhCPet1BUy9mmXtIkiOYj0Fxx2AKnlqATj85ow+cSt1Eno310Zuxi0ER+3UYH0DgswH8I0K7LYR7SskmSIejddBOLJDPhF2RrOYcJf3dR0rmKX0xM5jML/YpbA8xxrqmlJYgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487b859e-1e92-45b9-2dfd-08ddf547464d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:34:22.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbftQxYddvxirrDPm4mNPzsWKfmRTwY4loMJLCAPi+VihB195cJct7hj/h7ktHnsZ4sFCgrB+JW5ozikf7R9MAC1XS+VZ1qpqUOP4I6qXds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=938 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160163
X-Proofpoint-GUID: 8Aq8d2fE8qigvEjkqxvnKTA_79srTI3F
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c99fa9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=-_BMN9QQeijdksKfcvwA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfX5o8UyLZGrpZ6
 HAWDfq3A6S5X2Gczua/xkl0Dp9O6F+NUi9WS5Yo3l7A5Sv2vb3oEa3nV5NM1YG3CdhjN1BE+/P0
 yQDDjGuzG5H9fw7MzYfhhYcEbURXbAo8IRRIC902nABiV2cPzT7wL7wdVqkGztvpsXK+d7oe/dW
 fxpP8zKPRP5hYwbjN5sWR6rtL5X10X1waHw1sRVC3gRSgW5DiROgO2mTjeiw8+RbSsCpEtti4y+
 GfN2weJlIweuoiBnSC8UwBaCeveJ2H+zolud+QU2Bx//KNncJvKEYNzFeZwzWQkR3oY3fgsVmLF
 rYy/ecgS/ZxXkfNudgCZ3BcYQonttUDbbvXiO79d+14AtvNvSr1TKEz/r+rqRlNdkjgT83m4vGX
 BK8dS4PBN0HEMDJxKh4LpO+Tn9PZRQ==
X-Proofpoint-ORIG-GUID: 8Aq8d2fE8qigvEjkqxvnKTA_79srTI3F

On Tue, Sep 16, 2025 at 02:19:30PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 03:11:53PM +0100, Lorenzo Stoakes wrote:
> >
> > -int io_remap_pfn_range(struct vm_area_struct *vma, unsigned long vaddr,
> > -		unsigned long pfn, unsigned long size, pgprot_t prot)
> > +static unsigned long calc_pfn(unsigned long pfn, unsigned long size)
> >  {
> >  	phys_addr_t phys_addr = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
> >
> > -	return remap_pfn_range(vma, vaddr, phys_addr >> PAGE_SHIFT, size, prot);
> > +	return phys_addr >> PAGE_SHIFT;
> > +}
>
> Given you changed all of these to add a calc_pfn why not make that
> the arch abstraction?

OK that's reasonable, will do.

>
> static unsigned long arch_io_remap_remap_pfn(unsigned long pfn, unsigned long size)
> {
> ..
> }
> #define arch_io_remap_remap_pfn arch_io_remap_remap_pfn
>
> [..]
>
> #ifndef arch_io_remap_remap_pfn
> static inline unsigned long arch_io_remap_remap_pfn(unsigned long pfn, unsigned long size)
> {
> 	return pfn;
> }
> #endif
>
> static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn,
> 	unsigned long size)
> {
> 	return remap_pfn_range_prepare(desc, arch_io_remap_remap_pfn(pfn));
> }
>
> etc
>
> Removes alot of the maze here.

Actually nice to restrict what arches can do here also... :)

>
> Jason

