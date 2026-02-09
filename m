Return-Path: <linux-fsdevel+bounces-76709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CpEDNfpiWmdDwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:06:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C9B1100CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86D33019102
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3033379994;
	Mon,  9 Feb 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GlIJTlUS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P+PtFuf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E91BC2A;
	Mon,  9 Feb 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645968; cv=fail; b=uZwNHYCBw9DAOis73CPulYz4OiNXaTiY+dAt3ecTgv3D3pqDsQ96QZP64JbDyce580QKR54l3BljQ93rV6i80KBvzua0rGDZV8QaxUWVbnFYoKWNf5U5JstuIeqqYdG5I6KrNnTBoEU0jJ5h0G1vEVLGttpdGOU7Re+GFRLTS3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645968; c=relaxed/simple;
	bh=fJNmoPnwSxDZjM0W1WuG1j5xtRu+OnUH9fHvpeGCekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMHOgL7Xfydg1JDsVjbOjeOa63bStsSegMvBPt25nVAHnI8gbx3aH1iXQ7qqZephp7JZaXfg/NCOgYx1yFAvs2Oms+xb9AGMBVWst/LvjPqEbJriUTx9TYdpKPJl2K1AStBmOpU3OcyHhhzqlVGZPAVm5UiOXtNQ6+JY6o4gO3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GlIJTlUS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P+PtFuf1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619BxP6L1405298;
	Mon, 9 Feb 2026 14:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XN9/pshIEtH6gcvYsx
	YLXigG8odRQF2zRrgNU1QZn0g=; b=GlIJTlUSyVHoNcrEBz9XhmPQ3EJ7+wcTda
	1MU8CAXZ/C7Uatg0kODeDX3JW0SziWcrKN5Vwj+OlHbq77Q6hv7iUk+1y8le1fkV
	QSaIcuM8mz/jSkmqe5v+u4RDaYl/YuchrT/elgVLuRnEJyqG5a/5ad+N+aiApBHJ
	ZHmHfQpDA9dP2Ew59aBGyIoe68qJRo2Yimg/VjD9pSwNkV3ruRICUYHn7R1r4m0E
	wKZM4ZN+0yNj/ESDyplo471sDEvpywFHCOWfhTDwysIsNGw9xcidey1czMTaFoKb
	WWc/fOzn0roPhwpdGImMRHWXxgzklwwdoKqLJ0HkYZ8QD93L8iaQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xh8t04d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 14:04:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619C0BrF004601;
	Mon, 9 Feb 2026 14:04:41 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c7ctxgyy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 14:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keZQUyefymZwa2a9/TtwfFCm2MrPR71zJnbKx4CX8PU9k4R2Kkvfg5ek3kmP+kDFtclnzdf7ImcodLWv0FuSFQ5zIXaNDiivSflWsrFl5IgdKpYP3BzMvdrQs8V1j8ELhc2XNVo42WYlfbhFwW5wUufLl752UHAg6YgKrMNVQ/URA2wyeuARKEZ6/wD8XQrBChqwwqLQR5WkyOfT3Jjx1zE3m6IHK09fM5QF9OOcW3jf3n1+f2I76IlwOY6KlpWoeZPnis3qehKA81fquEBEppx6KaZNnRZQZ6XPWbk5rr76bwuRtA9Qex9vdVzPf1nsHVJCaK4Td+mgi+kOAkUfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN9/pshIEtH6gcvYsxYLXigG8odRQF2zRrgNU1QZn0g=;
 b=mlRBlsJrTb7gz1BF6bjNoTcSidAe1MVzTaVjIB8SVfknWK2ol1SAukNWS9CXRPIjkNViAXzRT8FZcIvXR8XoOPjAssZl0pCoT85AHlkjDBs7meivAXRnq3GbHpKfzGJdciA4b/ibsi4gxFsF/pH/UuXz/eKTdQDhlEVoJSEAKREY6Zu0nDkuqCGBzqXldaMaZERCdEWSQatziOXa9IMmI98tG60ixdSTpZbEy1YXn9mP5x/KayrTsmagtWuEVbvt1YtAL+/WSALdlixQw6AnvXsnC+hZ8UDFnp8+EFoqYX3Yh2onUXTXwdLsx/KM8JmavU0sbK66gtvfPY8NoSyuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN9/pshIEtH6gcvYsxYLXigG8odRQF2zRrgNU1QZn0g=;
 b=P+PtFuf1CmX2/9w0bUrD3g2IJiInYNpHAUC5pUhKvilYpL/HgfaFkzFIPphs5PkB7qNXftUAVpV05n7blJL0s/4lP/G5+BShTx4SgaAHYVBcgVV1QrfbYT11aKAFYYpN6gL5PzPqYCoChJlZYF9xYiYY3T4uybgpfDg7mY9l6Xw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 14:04:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:04:29 +0000
Date: Mon, 9 Feb 2026 14:04:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
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
        David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
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
Subject: Re: [PATCH v2 05/13] mm: add basic VMA flag operation helper
 functions
Message-ID: <ee3a8a0b-cf20-4d6a-9a0d-a2515b32c896@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <885d4897d67a6a57c0b07fa182a7055ad752df11.1769097829.git.lorenzo.stoakes@oracle.com>
 <vrbggto75ugvpa5wtugmayr7yops6cnvygit42f2md646y6qnx@3vzc7taleijw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vrbggto75ugvpa5wtugmayr7yops6cnvygit42f2md646y6qnx@3vzc7taleijw>
X-ClientProxiedBy: LO4P302CA0020.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2c49ae-110d-4de0-dd1a-08de67e4245b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jEsDz461LlyyV8NyviRb4tOn710YT1o2Ba5wS6//mAPfboQXAU4XBx1WhlhV?=
 =?us-ascii?Q?z44tpRySJsOe/a7gURaY1h4RlsnS2j/ANDy2XeLytQrEmtVUm4CMUDMwjxna?=
 =?us-ascii?Q?SPmk7zf/cIO6rqGxqdhl6zfscIEP3oNHj2GEOqPCAOqcD5cxQ2N8es0Tf3pB?=
 =?us-ascii?Q?rww3F5gDJnLNgxDsZBPwi/xfX1XSoGC45Ak1nQb4NPcxGRgZb8n1nNU4Eq+g?=
 =?us-ascii?Q?1QT1IQVkMvRXxZfF9xeej7d9g/X9UyYzGp1kvIJq4P4LUl27k/6DjYkQiour?=
 =?us-ascii?Q?A+FrCChADqz8nvgiqQHUXBJdTn3QypTADRGcRJgGvcrXDNbrr2ctXeq9Xg/C?=
 =?us-ascii?Q?Z2lXUtzO7f0gMT41cNEay+VWeSuIJfK8nnpgLI5ISmyOlCXW7kDGfUs21Lpi?=
 =?us-ascii?Q?y4vlkgqZ5d+5yfxcVJF1iI64DB9Df0GncL9pVFWUj8SLu5c7Rv4K1tdW/kOP?=
 =?us-ascii?Q?K/pYgDiKFPU/bfKmnuE/ja/NC0438a9UC6Y+DCxP9SMub6jaIQvNPFITlEAV?=
 =?us-ascii?Q?6OthsLmtXKjVIHPWjLAya7Vq/pnLutVNX/f1IN8z+4qP2JV+3/wJHZKTI0rG?=
 =?us-ascii?Q?CZMC75GiyB9AE2kGR8uZoap9EHlsGhBomdpzX5Zy3M/qijvVDpPdIQlBJgDW?=
 =?us-ascii?Q?vytNQq9+yFLBMNseCF5afNRUI7whYv5YM/55UQ5CWXh3cWP26FSolyZs11rg?=
 =?us-ascii?Q?GY2NrulMBUDZE5GCk2QB//Wocy+swvzaq1/8j6pjwed9UZtDWavPf935+pV+?=
 =?us-ascii?Q?W2jeZjNKbknI5fxE/DcenVt+yUWdZ89wZRcFfb9segQm0RuAj2SnHAki3y7s?=
 =?us-ascii?Q?1H2hoF9l4p5NPyVqKOKQ4zvH5LUbKpnA2NZCt/SMv1UhUea4oDib1KPMknEo?=
 =?us-ascii?Q?5vRs4RuzRY6SzrCjb2MSEJaDyMJaxe3d4Mf09tBm7zvuoa1jQyb+HZNiuVw9?=
 =?us-ascii?Q?TVM4KFvhDOuqOGUaL7PFCOKVbtnNZ5CA6rHqZ1a+v5jZhDDxkqQksCu+esWm?=
 =?us-ascii?Q?X86zNjO3MITpGHc+G6iZ/DNxIG+ScIrajfBECR81LXUNEhcCbfKngm4wsBOX?=
 =?us-ascii?Q?DnADLZqxB/ZCovzqrK0UTqZ/xCDMoqbz2BSt0+PaGKFKch9WWLyNgplAt5xS?=
 =?us-ascii?Q?4xN30Ux0saYpqc9/wrKZoWfYU/i5rZYWZWyolIfL/vT53hTLQWz98EKDg9j5?=
 =?us-ascii?Q?g3VbjQ7ZkuDhmcrBniGQv17o9WMqvMaud2NdBh/muTGaVWeNPUxm5/G6BbqF?=
 =?us-ascii?Q?adhjyNrNB7tniK/814WH7OPPWKk3CB5fOWrbznW7ODAkrzTuTFj2DxiMek07?=
 =?us-ascii?Q?Z5bSx8oWpOatfdmzF+1bUz5OAcBT1HVfPElsaOQLHMn4b0rFxMEWXrdwBbTK?=
 =?us-ascii?Q?FIloEhabKEAAGgO8G6XZB+fVUeED2ooJlNsI/ZBaO4KwX3+Lf74WAwJXZjCb?=
 =?us-ascii?Q?/AQuCGbuM35CHw4iJa4Wmur8VAR52jcDMJrOCOPG1x/NGil9fXiKdOmkzHUH?=
 =?us-ascii?Q?MLgdZeHjTOnt+M8kyYa+45dlyucmQxy+o3B/n4pmydaU7uL4u0rg3WEme9ki?=
 =?us-ascii?Q?LtT/cYgA5wdj0XEa+Sc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?algm93jTIV6IFZzwqxYt45GXti4mq6xDnk+JFqjmGddBxHXQ0ug7N2WeSpc9?=
 =?us-ascii?Q?y2RsOS9Dde2N/8uUigQMlgZnhWSZYk7mfFgOoVJJh852shIX4mxWxYEIGIbC?=
 =?us-ascii?Q?nbQpYoLGsHlDt5YzwFKQAGdxd+44j9jrg3CCCQkF7/F7m5zflTCdZWGJfBAW?=
 =?us-ascii?Q?CLlfRbDRxnyGLe0SIDo8GlBSsnilfmBFExqn7ly+bcIWHHHYaNgZZgD3KpPl?=
 =?us-ascii?Q?fiem1sPpf+1upq91jHJ7HnL307NJcfKjc6DncixiUFtMcQV5K6njwZlfuqPh?=
 =?us-ascii?Q?n/4lc+ULEB0adoX1ZNPqEnqhT65VJmFVklv1mtNVTTaDJjGTn1X6abAbKbcx?=
 =?us-ascii?Q?gwjHrBuDOrcUH+i6MXIV4ZU759UgtkaA+ukilMHS+9sNilCFjgLcQaIojABZ?=
 =?us-ascii?Q?CHqpAe5SFV5v4e4I80UVM7Ak0fWSD7PNZ2C/9onAZ/sfSbmCavWNr1dS/tZU?=
 =?us-ascii?Q?9Ow1wu6vqnFqiQGiMuRWWUcWEo981gwtEfgYq5rf1cJGEy+uxB0syJzLsweC?=
 =?us-ascii?Q?S24r/jRniT+LmHaP+AADTJX6IY+Q5GCJ3GxUtPLJfid1nEJaldkghRNpO9ee?=
 =?us-ascii?Q?XtF9d4D4EkIwR6BLX8TGnQKpIBnqHXF+GrtRzFfvbLctXvvFjApGMdO49AV6?=
 =?us-ascii?Q?Jprz/u7YqoVJwngb1tsQIlCxf6TltlCFjWf4O6cQGcNpAJDS6YxyJnN7XDj3?=
 =?us-ascii?Q?PD7ajDIZFUC1gauLOANmsd7lFCsza6G+c0HYm0KericLOcb5bbTI1IQXQaBz?=
 =?us-ascii?Q?68mhSJUN/u8BmVVuzIMVkvPblb/DK4NZkZtSXpZAVwFOB5eQ876SoPrpz4NQ?=
 =?us-ascii?Q?t8OOLc19iVVRAh1XmHabvGU/RC3cuo7nNZwJXuR1IoEkje7OaZc+AIKD3IaY?=
 =?us-ascii?Q?XhvHYFzV55xX+cHKgFPoFwCAUzKzeue6Ngr08jSTHNtn13axqZbhuZJtpXWO?=
 =?us-ascii?Q?HsWtdNk8Zp3R0pHDiljaYX/W3ZkTUiy+9dx5H0ZcCInM68zcyEbefK3xHj3R?=
 =?us-ascii?Q?VMfln6jHOonW/J3bYwbbMWjVAwwZaBUmALa0WQIe4dylj7dhkAqbu+pTo2VP?=
 =?us-ascii?Q?Ao0UrK/3xmzD+5HQBVcpg/nP+DR5eF3wY4zPsTQcjws/YtBlrNWD7Q9vyHTh?=
 =?us-ascii?Q?3vJHFG8ovDOGyB2MgZWZU611iGF9Y3HNjxLAvmmRF0YDgT17IFdELVsOLmIR?=
 =?us-ascii?Q?coB9rTBQbIe9tSp7nDyntAC5sVV8ppGtsa41Q8y5P3C0SN5jDRuN5S/YLb9m?=
 =?us-ascii?Q?ilMZKB286+D4QNIegUnz4YS5xPaITd+gJQfn0TnvyO5lEoiN6sKcDHEdDl1b?=
 =?us-ascii?Q?d1sIclNM2ctM3TGfzjtsPbX09RjNE2bmBcRQre9qAb0YgKxLzjlDlUtyzK5+?=
 =?us-ascii?Q?SgTuZM8lY5nI1aWl2DhOgpyNHHKw2hKo+c3C4nV+Q/YDDEjUIjbEyiwG/NYm?=
 =?us-ascii?Q?i1na4RQV8x/sx6c4bvm9KjAFE5c8OwTI6l1uJKL47k0Imtb5B/VzWcRDrHM5?=
 =?us-ascii?Q?LZ6S1kYeqZyLCtMB21qpl6YJmUBXCB9q4It3xrwg4HJ0P6scDZecNQoa1NEy?=
 =?us-ascii?Q?aZD26czewH5cOC44rVoaP6EolHPs+DQ6oofj6yL0oBGiTq4M66TLobQ3uFAT?=
 =?us-ascii?Q?wIsJOb4x6TslkIYIy7VFFbealaWXoxjLKnwBUoYkEbQoHR7d37ftprZoixT+?=
 =?us-ascii?Q?sjYSdIHuuYV+3jZGX9OYOkon1CKM/V14C3dhbvAEFIpunpHnaYHZ6I9eVs++?=
 =?us-ascii?Q?/9pA/mJXQA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	01KqIf54eTYJ389XoHV1TTvcQJXlwFzDjf4o37w3qHuZTIQkfKvz0WQ/EOPgYm5pm/wPcHUeWM1lGaLOhX0zW+a5ONrHVrypAJAStfspOkg56Q+LnECE9bFc04MxFBbR9Rhlbgu/RzM7BrjfiFPm5CXh3dRURyd8LSutGV2pPWwbOkcVy26bogDB2c1tqHv06ZnmjMFGEUeWhDs7g5QlQ8brQBbS1tvHNy3wKd8L3DPKCjvRTDLyAP9SqAvMENlhQERX4Hy51DMPQAA30Lsdr4Sa7udse22nT8fZWxzdf2VCO/XsY4ulF9SdK3Sd+1/2xRzTK313OM7o/V4Tj/e8ELV4rskDUl4zOGyDjD5OpB2fHPQQYpfRCz374BGOCRMCpAOqIFoDjYqP2stdpQH8I7n3zvHi579KXPzd33CMP7safWeIsPhIjrKNYHvQvT6WzC6OpIw98UosqkiAaf99/EyVTAdCiMSz8bdL6fLOrwU96Yyr2FlhSPjtx6Rval6PZllN6m5CINh3k3WsBMDW4UyZ9a9cT2tuBIbfp2+Tc04QsZS5ZIAsRy1L14ccMkbQJ782/to/eDmt9ddFTtyub/U0WPKEK3D0lWks0VOGSKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2c49ae-110d-4de0-dd1a-08de67e4245b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:04:29.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnkFz3Z7dqQugpLWqynHQ/59OBxP6yCMyrlLZBi7q8cJQjoQxXAFtHLJ+WMVYiZYKXPON6/hAADKdIwmuCOMfmyxCtTptfkpyOexlwrm0E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090118
X-Authority-Analysis: v=2.4 cv=YbOwJgRf c=1 sm=1 tr=0 ts=6989e97a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=fvR3Ec5kcXMutB-RvbEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QZ_mHi027iN1x7vBbRhRx2U0ENVk-54g
X-Proofpoint-GUID: QZ_mHi027iN1x7vBbRhRx2U0ENVk-54g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExOCBTYWx0ZWRfXzv8SoinjNsc+
 hBrjhbq4T+HLcPoG2wxRC8RU6zoG5mXEERE/X47rZq2xW/vd8a+swZ/btk+T7xInxD8LDqQL0Wl
 pPm6drnhTT65xYkld2Tug8L6f/pnA+4P1xFR3XjVjvzZhxEL7ELV/03LyUcH5H6ozPHGwpJiwgy
 H/COQGO96pfookgxb2Nf+GSt+oRLgo0q1v1aztwHisDJFI1Ae9PfF5DOsBKXGfnmQwANw9hVP/G
 Zb4LE+RetacojNFffsDkZXe5hswjd9fvU157soml/spF+LHJuwThquPlK/6ASAAm7t8bnmVbTK4
 IdgWBDg+zSUIxy0TmCYszADj1ibSe4x4qgm7sRFi4fyjotgGsLVgZsegVdzLT/LQw4GIRMcFrNb
 92KA1P2VeTXFy0WE2wcvHhgR0Ff3pAL9js/5K06nwr8qvM6FuDZqyB9iu1L+iweAUjzRyhBGL8m
 9QojpC+jv7Swzy8wjpQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76709-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.com:email,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,lucifer.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B1C9B1100CD
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:35:49PM +0000, Pedro Falcato wrote:
> On Thu, Jan 22, 2026 at 04:06:14PM +0000, Lorenzo Stoakes wrote:
> > Now we have the mk_vma_flags() macro helper which permits easy
> > specification of any number of VMA flags, add helper functions which
> > operate with vma_flags_t parameters.
> >
> > This patch provides vma_flags_test[_mask](), vma_flags_set[_mask]() and
> > vma_flags_clear[_mask]() respectively testing, setting and clearing flags
> > with the _mask variants accepting vma_flag_t parameters, and the non-mask
> > variants implemented as macros which accept a list of flags.
> >
> > This allows us to trivially test/set/clear aggregate VMA flag values as
> > necessary, for instance:
> >
> > 	if (vma_flags_test(&flags, VMA_READ_BIT, VMA_WRITE_BIT))
> > 		goto readwrite;
>
> I'm not a huge fan of the _test ambiguity here, but more words makes it uglier :/
> I think I can live with it though.

Yeah, as discussed on IRC it's a bit of a trade off here unfortunately.

I don't love having the _BIT stuff there but is necessary for now I feel until
VM_xxx flags are finally fully deprecated.

>
> >
> > 	vma_flags_set(&flags, VMA_READ_BIT, VMA_WRITE_BIT);
> >
> > 	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT);
> >
>
> The variadic-ness here is very nice though.

Thanks!

>
> > We also add a function for testing that ALL flags are set for convenience,
> > e.g.:
> >
> > 	if (vma_flags_test_all(&flags, VMA_READ_BIT, VMA_MAYREAD_BIT)) {
> > 		/* Both READ and MAYREAD flags set */
> > 		...
> > 	}
> >
> > The compiler generates optimal assembly for each such that they behave as
> > if the caller were setting the bitmap flags manually.
> >
> > This is important for e.g. drivers which manipulate flag values rather than
> > a VMA's specific flag values.
> >
> > We also add helpers for testing, setting and clearing flags for VMA's and
> > VMA descriptors to reduce boilerplate.
> >
> > Also add the EMPTY_VMA_FLAGS define to aid initialisation of empty flags.
> >
> > Finally, update the userland VMA tests to add the helpers there so they can
> > be utilised as part of userland testing.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks (also for other tags :P)

>
> --
> Pedro

Cheers, Lorenzo

