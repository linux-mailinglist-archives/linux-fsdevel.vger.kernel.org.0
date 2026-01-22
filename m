Return-Path: <linux-fsdevel+bounces-75090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI6EFgtRcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:32:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5C6A006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770B130E76A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4637757D;
	Thu, 22 Jan 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hw+OKZ7u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mV261SEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA98377571;
	Thu, 22 Jan 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098083; cv=fail; b=jsTk16mnlhkcO3zAjKv6HfyCXCvXO46ROnE0ImCwRokWcVY+7mZmtDWA4Nb0v+V9db+heWDy0JCwyW5Fj89geeuaecwVS+QmTI8HzTlum5wDZdhwrpakXkxnguVq8rsvq8q7CD5zGqCY+BbHqBwd07lZpn2xsnffW9zVKVl2Ojc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098083; c=relaxed/simple;
	bh=LbZzpM0Y1OhR3q3e7sDcdKT6nLGOnWI2QvyODOkI2Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZochcTx7j79bROpKIlLaHv6PBeqokff9Uj0YlyvhSoc5p1awOXAfE7/DiSSTkiz6okAAvbr98dql6s4Hp6epDMOvdl13uJLfViUH6BfIMwZHnG3HzflgN1BZD1hDns23+CCkx5ap0hLH1r1LF27JbfgJ6eY2w4C2xIA4kP3A1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hw+OKZ7u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mV261SEv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgiUI198034;
	Thu, 22 Jan 2026 16:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=; b=
	hw+OKZ7uXskn1fuNp3AAGAKP7m2sRotrcchtNnUTMUZFa9sw6vIUWpunFqZEZsaC
	3Ekv4AQmE8Tuid4B+LpuR2i+BSX0Ex+yjgJrQK3vbnfVDNJ58zLK6/3WNwF0+XJM
	pvxPwXRzBSQ0v7jNdshqBIGccUe+TeY3bnU5Hwie298UosbGWrBYZQqraPsYtbl1
	BhOlsbYmZEOxSXSXUhGVuij4528niZS+74TsDr5JzV/TX4Px9ckZstYO9BZGS2Id
	wg1R/pJUO/PTDi5YdV+yl6wm8+Olx43k2WnsMJuTj7/y73WC9yZ0QDk5SbDJrtp7
	0/rMK643ylWeHdGcqtklsg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypyvkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MG4SLB022453;
	Thu, 22 Jan 2026 16:06:37 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgtxd2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8zowhtM0R9HvZgd+gL8w2JdhxruvNTIooFJwIowBzSebGrHQz50O4zGQOr3gwNxjuJAlTm/q03JVFefaznBzydSZ2wo1qF8rX7VZ3gE/Vplcu8ZX+n5I0dmEfc+OXpOcSt8rRSjxQZfFvhnTGszrnTHoD8osDi1KsZncgKA6XoYzjKx0wA8rv8TBWboMbBgQ8mBXEcwHR14D4Ji/wPBLe39ZFZD30LA5qni74/rpRnQrMqdLLdVlbknaB12wBQd0YHN+yPxMArgWGj/4gQUUE8+9yLFt86MrocARS4ou+HSSYM99xQAyJO1KOJxEZ8HF2lIDXHJbGiuo+IjzJBpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=;
 b=EOSpX+thvr7ZXnHEER9befMOtVB1LCphAn7VYRfw7dtZQ34BKFCPyW+mzTMe15xg2fdUy4Nwo46sD2agx0qC62vVoe9eE5eXv9YcbbPgSXtxUSiGb3cAamo1c7nAFbiZdad3E6fJh94/rZ/bKt9Wp3YOCQ9PwyeinT3PkK+Cy6ljMFoHCUbRMkRvgXxe9fYBPIb3fX5tid7JVCP5tq+mUO+zoRZT5n2ZJEvRYMLdoz2hJgmii8rAwXZaHre1qWS2Ql8aR3vJIe8uw62IUbrG5dntYjX1Vi9SWxbjI3f7OAggIzRN3KchmYXNNEgOWFMYS6cvBLix8AfeGNvBWtYvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NB/xNpGGorG6uLTe47zCLELvNAMhUaEudNabs9pE4A=;
 b=mV261SEvCu7cn3n2BQNyBp1bxW5qDsJwy1QmuhTvPiC8iQ5A6lvDJI2gO5oxJZZLQ7vi3V2yN9Ev4jES6nhiblYIMuq2jjf7KKr/D5tnnxzYSPDZjHnXDWFmYBKrsAFTHmTosVc2O4nz0rSE7DMTsncnWNTH7mG0xD03cr2mBNs=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:06:31 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: [PATCH v2 04/13] tools: bitmap: add missing bitmap_[subset(), andnot()]
Date: Thu, 22 Jan 2026 16:06:13 +0000
Message-ID: <0fd0d4ec868297f522003cb4b5898b53b498805b.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: c88f4d18-063f-4a24-06c0-08de59d03518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfoVnGJE85scSvRaShzymWORJtMhPCe1euDhN10V1AfEPl21icztE+yuBlSm?=
 =?us-ascii?Q?6FMSKlDUNhbRzQT/p2zyRyWqKZgnM3ubyOCnNTJ9t3OLmOE1peKP8lgcmu4j?=
 =?us-ascii?Q?QFoDsWfXW4Ra0NYtJlvBLYWdrWPfqY+AzzKCEWADyQni5Lossdcqg/dOXsJ5?=
 =?us-ascii?Q?p84cLWepcpNoFvN+Xn/LKLXKHB+nDQUGOGVyHLa/QRUUaXMUtIdu6BCEHdty?=
 =?us-ascii?Q?+hUBMGLdWRiH2NtUkBn6an2sTxlOY2HQaq62ieDCGDTWqxYkSIHYt+THV6Mx?=
 =?us-ascii?Q?/e6uC3qagKHEEEf+mKVte5VeSnuys30qZq/TSbnOcoLkzgQyJYghT3Ks99+x?=
 =?us-ascii?Q?85pxFn/XIgrtEguMo+kpYkSLvhQo918TZVvEYBfX2OaMGrIjTnqkOxtWGyID?=
 =?us-ascii?Q?9QXkbcF/SJjNwE3+JFUxOtwaj8rGFxeaaIVXdptodjPDspCZVtN2sKzBIzpF?=
 =?us-ascii?Q?T5fZMXJGiG3namz3grH06NGU43RS9GeGO5aQntU5UgEQGUc5khT0YHmWG+EO?=
 =?us-ascii?Q?4knbJsI2UDzZqLTvDUNKwwhIwA0gn/YDOFt/hv37ycxmdN1D4JcIOtPFYdLE?=
 =?us-ascii?Q?dKpQPBKjO5JDeQjG8N5R3JDm6IM9hGt8Xs9HgvpQYXCnyfBNmma2/troGJtM?=
 =?us-ascii?Q?fgUwIseom4z7GmbW/LD2O/mgEOjMv9DTH9670JTutnFaoCj6NY908JglMpKn?=
 =?us-ascii?Q?hiO60vM3mGhrxgBG6NTsF8P3qBr90qSQPl9cZ6phl2M/v8CA8GhwzxMUKmGL?=
 =?us-ascii?Q?ghIJ1BD9CX7ShC11e2aVcLVK4FwENPtAtMEAhSVawv2ryWIC0Ns3upWTE5HQ?=
 =?us-ascii?Q?sIR34YGIyqopXUfAx4FBLHQZPzxSIJoI4/M2RMrP1t12DnIwvFooZhgTkrcR?=
 =?us-ascii?Q?IXEuvA0csbRedT2nRLXwWpxhkhOEeiQHqlmEv2Nk2Zx1/lYMvCAOsJLoIJPn?=
 =?us-ascii?Q?0GuZMO6ydrRRQBZ15ye3KhZk/m1nIEx83aaMa901wqAAzuVduResPe+q8N8Z?=
 =?us-ascii?Q?/g7BAEizEqCb84f+wNn5F6zZyAFN1T/7KxbDFAL70Q2qlRJ0LNjfJeMu1wfo?=
 =?us-ascii?Q?lN8Ay3vDTfz5bBV+/THsRu3g7jJyooaBvKuc/evhIbXzal2hI9bzzPMrNwjx?=
 =?us-ascii?Q?PRi2xg0uMEmlUSeUnsTb8bea+ft+d4GLVd2zJcClAaIa78LCQP7P5btC4DTz?=
 =?us-ascii?Q?nmSAZabKCclZSdvnlnh7v2g0JjyL5XUVGHvS312OWgwrWTzY9iNNdJ22dKNU?=
 =?us-ascii?Q?D4hAOuMuWol0lEvU2kd/5OqtIi4SxpbkYIwoqLnVuKqrd9E+lUc/0vls/xhv?=
 =?us-ascii?Q?GTaxRmjH1zsLerf/0BMcxCxTngl1bg4z5Gzu6GF8mBqk9mWNxmUgOAjRmPjK?=
 =?us-ascii?Q?R1u0Hc8hKB3TsDJve7qjzA88SCN/qsjsl5eMdfkFwrIO57L/CbnKcIyyjn5I?=
 =?us-ascii?Q?iOgvZEmI/u3JMIj6KK9cdvdOA90WKMqFvBfzHKv4YN/lF0UvFfyJGpelONl7?=
 =?us-ascii?Q?8EPANHt6D3G2VhpE7MDkMWSFFcWHAwDp0bAzKWlDBiLUVjDtNkZmUnR4AiM7?=
 =?us-ascii?Q?xEyIdhwGx2xMOZZO0HY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L76/Jn8cTahVXC00N3n3BJQkkukBPf8Vse+A1fj3slnqH6G6mTJCxFEC/5dE?=
 =?us-ascii?Q?Nepgykpdj2HqUs13xTKTmZ90b0RQ9MOKTTZSEC6hPYhn8xemYl80jtzLeGZV?=
 =?us-ascii?Q?mESZwL9ok294l9VarI/WQNiVcVVHBMQvsk85sRXe6GZo3tMbvaXsCVJnucOC?=
 =?us-ascii?Q?6D0fsqm+MSsrABkYFB0KI7Klj6Whm8aBGeSfToLY3bybpc8mD+KIVhdl4xDL?=
 =?us-ascii?Q?uLbnfxysoPt3GnD96IaZRBZfa9KT/n/UMFhHtDFVR5JR4jtLNFP14x+hmYAJ?=
 =?us-ascii?Q?gPynOFFVDn5bCeFAA8JeBCbZmmWX+TH155JIGeatrIqWTVH2UxXwCPB9dnv7?=
 =?us-ascii?Q?YFUAlQ7blrmCD69Su1o/yhMdePJ+wYs5Z3ru2lZUZ+exT/YymFrS/XrwKTU1?=
 =?us-ascii?Q?2UGE/gZTik1hlLTAbZupyz+7Dd+ULhbIeBQkvaTR7psP5IvJhQ+vMjHk6KYn?=
 =?us-ascii?Q?aQbOBuCRF9oEd3uASusDAsWVPAbNTuqMxoa3cWgme4dhZwjm6Y+FG+tjmatp?=
 =?us-ascii?Q?hbAkuUY4C7FX3nGirtgX4fzOOyyaKTAlrPQn08amRmDTJoztuvzsiEPYpWAb?=
 =?us-ascii?Q?vFah3MuOW2Htwmr23BYw9ElinEXFuxRrASYyNB22WHbrR4VWBAYJ9nhTNK4t?=
 =?us-ascii?Q?WEP6PBbwia3GcoLOWWGiQqaomnEpBBaTxnX7gRrPy8p5trlZn7ZsRHjprWcV?=
 =?us-ascii?Q?P0pZeTec/Sdln3Z2hkxD8LdanJIdDNQytyS1d7r80UJaITPBHG8ErrDB3fPt?=
 =?us-ascii?Q?Uv+J2WK7/LEe2RVx78TWboPW4dKAl4CZVjU3Xn6moEHuhbflFgHXalJPxOmN?=
 =?us-ascii?Q?SJX1uwsO/i9aaAWHLXcXVyUc1Tdv+qkGkFQvEPiRITMYzFixwxWP+f5SfiTg?=
 =?us-ascii?Q?lr0Wc6mNe/z6gCnGCnla7udiV+oA/IPg6yhwRw1972V6kLYZYXVmEubEhrid?=
 =?us-ascii?Q?sg+LiyPYJsIjUMJrlaVKapHguquZ8j8ajJL3tnrX66AzSX+Al+TLwqEzjfsK?=
 =?us-ascii?Q?dqUaIN7qhPyYITFhyaigk8X7kTVPnSyQx8PgjL+Pnyxm66XVqhtu4YUADi4I?=
 =?us-ascii?Q?qQ9yQewzXqF0/fxYrfIG1qUms+rHI5rkYcEtPokLBiAUCxTwPlLGPY1QMxbr?=
 =?us-ascii?Q?Go049rH3lsuhIviiln0wc56e66Qp+AlukVGxLtZNfxGt8d9FWoFxjWX0zuZ8?=
 =?us-ascii?Q?0uXIFMyKV402gRjrXUPNYPvJGF2Zff0DLvysAMKW0NlpapQpGg3OHWwvFreR?=
 =?us-ascii?Q?fwqCp7t6gr1DfDru985KubckD0O/vwQeFxy8xc/9v2K6s6RAuvRbe4kab834?=
 =?us-ascii?Q?wh7txlhgoqlasYe3LLyhcJHO7eYOjZebh48aORWRuDsoX3S1ZxTXV0oK0SzB?=
 =?us-ascii?Q?7FSjhCniabYnrW60WB2cLz+NxcPtzGq7my/N+Qd98xSYcGGQw2exyRS9BCR+?=
 =?us-ascii?Q?r8vX+o82ID5vvZ44TXecWrlIJNMsULdQN5txblg1HMvuM4nAj64tObWr4CMR?=
 =?us-ascii?Q?f0ANvKhLEUC/dP0julN14MUMLrmlArq3ajkfCA0GXiSdmlgFmrwpUaeQJYCG?=
 =?us-ascii?Q?nFm8tTTKup13vJacMRtn+wenhKsrUvnSYefsHyM47m0ByELclMMR0rq2qzyX?=
 =?us-ascii?Q?FfYZtXNIQmn4ygE/YzST6ggyDumgACPRB6smzgv2Zeot+gsrvEXhCOcWGt9D?=
 =?us-ascii?Q?enzEngMATcpy5eRl000Z5VAKUgJCaPuq+x9iyWBxWC6Jnik5OvYWsPai4anG?=
 =?us-ascii?Q?g0DHFw/hujGYI/zCiI/a30L6rbXX6Y4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YlcNnCN57lINI6ol/Vnm/zjRLkUE96ssDaexh5N34utatPMlWPL7BQVklvalyGVMqHTjnRsvm9fG/CkD9KBOoiJG1JfEqmLkEvbZaqYDOptZpQOv4GG9lT5CYGxsNXdOvE1ih+xQfKaXbkGm/aD2340VBqSnwiB3bxtF9v2SrVVQuV+qHOBlPZDjYNmvz7jJmMeSGm5iwGm9JnfC0IJ01csBMo8MvYUHG04PdsodC+BASsaLPILPN0x6A5qpTPJtyTE8Dm2iLZ2FY03OZq5xwliy/oaZNFly+OgyRs79yIKOOoJHxQdb+J4ziXsqFwRzDAAXfvpzZhyhjpK2Zy9z00NHhzq6SgWNU95dKIpQ78CnGclolgqOYl9hidY9tcb8932K19nF9qyzZgP++YZ0eolJvtnyLkqFLBXzX5RIry4yFD8bJ9Jc4UJhVN7oSOzKgl5o/gekQqyuOdkMU4PgXqA+8uWasYH7O8gI02BNzwfuvrt1ITZ9vnTCkq3cGliinfxWKLaaLt2hjciaa4H9+Fh5CKrnZ/41AmLplAxeWadL7WhBlRmGoEn8nK3qFeRw79q3mdDboxoXaJQF4lJVNRih9/P9zB8VO2tbBryXoLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88f4d18-063f-4a24-06c0-08de59d03518
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:31.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywmM2geOmEgRR/5Kam/aT3sfd2Sd2qZkYmBhogTFWk5kA2rQ/d/DkxBBCqLlUJRJDB1bd2AJJKwTAY/maS2zZ/Mq8WruNtxdjJGH7NptjhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX+4peIZuIFXPE
 m+vvh8P4Q0HlwEnYpSkLjRgtGf/8EYtZZtpMKL/pGY5Z+s8iBX6P7U2bYUIZZXvfRlb7ZBCI3D2
 e+1dC4Z23xwzoW84N4mNkJcvB7scqAwZPBsWhwaP8YZxjRdgbDxl/zmoNH/9vwojnX8zEk54xjz
 w80aISD1rEB4I/yqUR1ZnKdW3S5Ps8AfYsjQghFutkbilthxu3ekyxUx8YYEQ1yMS/gIKNZg1Da
 vIbf7AD8Bk72nPTT3HibvxpjH6fyM3Nr3VMVTgWstrQ3B4Af/qigFdOuvy1RRe8Tqe8jUcma35j
 CvDfOY9brvQd3fN6F7zkcQ4xGZ+MAgDFUlOx2Sj25UWfe9iFsC2SEbMvidCeuPQU4rur1t3sdc7
 UFLDsSp77lkRkAgVypyTpvC2XRN1nin3C1GCT9YIjvhDf8Qtfb+kZjgzgFOyeySWYWAYNpN1lch
 OjR+cl5G3IYcienfakHPUVXnaJJqpa5yH38BkjVE=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=69724b0f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=a5eeGpJJMrXOYBdyZXoA:9 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: LpbcCs61Cr4IExl8fRFBbkbNvNnJCX_t
X-Proofpoint-GUID: LpbcCs61Cr4IExl8fRFBbkbNvNnJCX_t
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75090-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E4C5C6A006
X-Rspamd-Action: no action

The bitmap_subset() and bitmap_andnot() functions are not present in the
tools version of include/linux/bitmap.h, so add them as subsequent patches
implement test code that requires them.

We also add the missing __bitmap_subset() to tools/lib/bitmap.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/linux/bitmap.h | 22 ++++++++++++++++++++++
 tools/lib/bitmap.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 0d992245c600..250883090a5d 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -24,6 +24,10 @@ void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int bits);
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int nbits);
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+		    const unsigned long *bitmap2, unsigned int nbits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
@@ -81,6 +85,15 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 		__bitmap_or(dst, src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+		   const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return (*dst = *src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	return __bitmap_andnot(dst, src1, src2, nbits);
+}
+
 static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags __maybe_unused)
 {
 	return malloc(bitmap_size(nbits));
@@ -157,6 +170,15 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
+static __always_inline
+bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ! ((*src1 & ~(*src2)) & BITMAP_LAST_WORD_MASK(nbits));
+	else
+		return __bitmap_subset(src1, src2, nbits);
+}
+
 static inline void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 51255c69754d..aa83d22c45e3 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -140,3 +140,32 @@ void __bitmap_clear(unsigned long *map, unsigned int start, int len)
 		*p &= ~mask_to_clear;
 	}
 }
+
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int lim = bits/BITS_PER_LONG;
+	unsigned long result = 0;
+
+	for (k = 0; k < lim; k++)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k]);
+	if (bits % BITS_PER_LONG)
+		result |= (dst[k] = bitmap1[k] & ~bitmap2[k] &
+			   BITMAP_LAST_WORD_MASK(bits));
+	return result != 0;
+}
+
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & ~bitmap2[k])
+			return false;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return false;
+	return true;
+}
-- 
2.52.0


