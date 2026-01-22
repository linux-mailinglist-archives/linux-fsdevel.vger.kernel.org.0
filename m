Return-Path: <linux-fsdevel+bounces-75103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMCYMABZcmkpiwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:06:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D16AC29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2FE3062220
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029339CED8;
	Thu, 22 Jan 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HVxv/g4g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NHr1wPo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418303BE4A4;
	Thu, 22 Jan 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098157; cv=fail; b=IOKqTP2pSMmYkNAyukffSQpX909pSYsk955o+8H3la3DbV+H+8vCFyrip7QOXS7wyA2ztkReF1FJuGVxPNUFJ9tZPrdxdF67bCcH1VOTX3ZYeGfezRIFLtOOC1mA21qYj5QZ4gN3aaR19t76aV8LT5X+lPvgpUD3IT282dZBggU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098157; c=relaxed/simple;
	bh=+YYCqkJK/awRUp24kJZiujwfaLDUub6FxXGYSwoKI3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTOsQ7e7SEUWRuG6eb26+c5Z1YQmJ7lHNL+STK+XTNtCir8+0l7TV/izy1ZDTqj8dPMb+5dfvaAS81dO+/xFogcSTG6cHnrF70mwdUTpNHpGKeU34lXo3/PNsmu48EFqYTLtY4YBXGIQXhqHYnv82MneFdA8eTA8wfDwGMZ1Z+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HVxv/g4g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NHr1wPo/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgK2T460462;
	Thu, 22 Jan 2026 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lyUUWrJI/1VMbmekNcVa7sslonowSkNove1aU5wgHsU=; b=
	HVxv/g4gHz/90QgXnz0iyGYbAGoH3VPZQQO3MLuG1odH6sxsY7c2m1oWnFlq8bA6
	b4lQgEw19kcnCSps/QVC8+XF679Zo5zg4oF+95GaWLgdgtjBvntuI3tOXfCl+US7
	gyduVFtkVjnzQ4N3wJEGlVozaqpJWQzTC8fRcMS13184FcrqI1BMistkqIFIX7Cs
	L1Vf3dGSq18uu9QO45gue6ikAN4xRpmQprj8UwQtNBR7GZ86xiKSfySKKQ7PN9Tb
	eArhO5fOrU/RW4gWKMQusVAjmUyDWHfwOr+fFNntXlPIjrMfxpd3gQKqBg2nEKDR
	fjWWxpSe4aaFkqEJWHlFBw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8g0bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MFod6Y032840;
	Thu, 22 Jan 2026 16:06:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vguswq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1JkYWuhv8bBGSFg9lRSuv4S2wLVKx80MuCiyp/HYcMP2sAA8UmD+LLNFTzqk72s47WLu0IJ4Lw+Wgv1e6pOxkfNRhPbM1tbB4MWvHyDPVfvRWrv4jKRWxLurx3b3DYvnOvajEikKBt5Fxzy6VyGDBnXyKDUqImGKu5LDbPu6LvG0m3JX36laeF6ZIoogVjdISY8fJKnsHqIt6oE8iTkF9tDqhM2nYbCUHogB7T1KKfUL/R1cPJBs+Jw6qTMpqBW2AaOdgR461kt72qB4lTi6vznCbzP2lZ3YJ4zuociSkRqkrqsPOPG9T1fGW1vWG00zHsB+96Jyqw94NDUkxvFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyUUWrJI/1VMbmekNcVa7sslonowSkNove1aU5wgHsU=;
 b=nlXB4244sJukSyBaOi1F6KB7Yy/ZepZo3D2XYelrvwp3s2HinV1APxi0KXM/xUogRV7G+RFGtWlFxeHEtUdkyHfimkEIxPntBG8r1oCIT4Kn5D78egxeygmTFQPWyG9lqPjgOH+aO9t5aL/IgB8qzP9ZyGhjZP3xnUp2hjvxuxlVYSeoQfYb0DtjAvc1OmQFwmM2I0ijMndant+4jZd7x7k0uyhNklv1k8OemHuXUN3RYR8Nz9dq6XAGyUChtlW0nZOZSAL3H6iaTWlM9rY7PgWwJQrNWdTMS7Ih6ojSAqpM9yc48rgRp8sEe2KLoGyhyZ0D7Sn/N/MNLOvtmefq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyUUWrJI/1VMbmekNcVa7sslonowSkNove1aU5wgHsU=;
 b=NHr1wPo/s4HP40qRTtUt/7SVNIp3f6G3Xn9iaTAXA64OOCTihFwfN/yAH/0f9vKaveikz6sqC8N+i692VcE3kfFdkTZjLJ5b88r6spn7nnpyLoYYY8q23GgvLrJ50JT/LTckDp/x9DUDhteEYXFe1NailvwbqsdFmlBGlcW4lcA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 16:06:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:44 +0000
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
Subject: [PATCH v2 10/13] mm: make vm_area_desc utilise vma_flags_t only
Date: Thu, 22 Jan 2026 16:06:19 +0000
Message-ID: <fd2a2938b246b4505321954062b1caba7acfc77a.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1203f8-ffd8-46da-6b60-08de59d03cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?haA5UbCrh2R0v4TQ8FxnDLUnymzOdkpvnqFUI/T3vbhFHXTUfrUVHoaBBsuz?=
 =?us-ascii?Q?zE94/NpHBrtZ6AEPVvk1OXiSRUkKxy/ylA04oyBC6UMFxIRiojM4mVFjj5N8?=
 =?us-ascii?Q?n9Ie1gXDJQzrP0Ch07hL4FDR2iRRw/RsUpbrbuOb6xNlGrkZ31f94V/xixdp?=
 =?us-ascii?Q?2ef8RFsKzeKr8klNKg4OXgXDjbvur+q3ampnudfzryoljl88lnY5psUav5/2?=
 =?us-ascii?Q?igPLZWvrcf3eis+9yn3zbk05C+dIA4+JYELJiub46DdiZyjUu4J+FouKDgUL?=
 =?us-ascii?Q?hqi5NjKoPgHbL/GIHCvocsOkZMo9VjxtSOsT1EKbJglDj1cBk9rICH+JTy7F?=
 =?us-ascii?Q?sE9x9WO2vPwJ+RV96ZkP5B0Kvyns3g4AtUQ31SRAeL0T6O1fWUaPoNHpuZD5?=
 =?us-ascii?Q?wRgoGKWMG/c+gT4bb9YPmb/dl7UKTIx2AL8RF/nSvPDj9mSVMUGC/veSeYcU?=
 =?us-ascii?Q?EckspocoCeO3rFBZ8C1bNgfcu0Cx2ouutGTR0/SGII/7KpUnGWnPaj5MdM7F?=
 =?us-ascii?Q?tiLM8qburfjOKbCfS1ar7CLD3RrMytRY3zNJnrpwpftBUUEDwfBikzCA8tFR?=
 =?us-ascii?Q?4k8wa0VNUjE44Bd+m7PqA3f5m2t9eRzZ0woO56RwaXL1BtWNPEZVfFSn+D3O?=
 =?us-ascii?Q?zAlz9de5ifmw7u1HAdTHK9zlNFV1lt7aAPN+HfA8SjrC9/W1NsYOu6n6OGP0?=
 =?us-ascii?Q?T4XemSgNSOeQFinE9oBs3nFhgR5dZ9F87bvmxmiRaLFtrh5NXsgL3th3xsAn?=
 =?us-ascii?Q?jX+wC/2+ZgQ4BylfBLx8LsM6uwk5rJx4kEko5HDRzzOvmxYR/6qkleS2G6Jf?=
 =?us-ascii?Q?SBocLB4mFKs5j+c2nh7SzBwds5lME1mwc3PQ6e6Z+HUytvRKsVtGCJHO4+vz?=
 =?us-ascii?Q?LfxTpW1D66x1l0juXiJWWVqbxGMhyPb9F9BsvM8H91ygeA8uDcsWepznyr6f?=
 =?us-ascii?Q?x+b0o7iePXrIrlGnvNkIDvTGBR+oABsoRfnaY+HuW/kFdZQ/GGd5EkC13xW6?=
 =?us-ascii?Q?8mfeDpj/pAskU16pcHXgER/K+eqS54fuug0U3ny6y/Zmw1fVnifmJpkClDSC?=
 =?us-ascii?Q?vBM4M+1wgKFmlk4H8SWIO6DDvXQKf04nICXGCc5FCgS641IaVdLkxueCl7s7?=
 =?us-ascii?Q?PQe7GXsjPNTHL+b/LW0Pnx/XTmarUVXPpky4B3aGv5UEAxDbk3IwtukABdns?=
 =?us-ascii?Q?uZzFEixS3jg8UnuyUj1LYJr0L+tyGJyJ/I210oK1eyPAoFEZPGNIZnPM6Fmd?=
 =?us-ascii?Q?6HGMgE4pjCErc4zYjK9AC7PaN6K4sq2GEf1FUKrecHmC94m2r5gQR9KN7MKf?=
 =?us-ascii?Q?uGS6vl7UBJ8NVE5l9vtNf6e3oZ8wO5I+uzWJfpeidGV6ClAL8U9evFlb1LVU?=
 =?us-ascii?Q?dyh//8D9wqtnC+uTV7ELR8xuJcnwLsdw1p7Pn9x7WhLV86xgY2cD4PraW2hk?=
 =?us-ascii?Q?90L1hN/PHSA8YfXrpsd0HyBhHXX/XQM091iQYUriBMknRGxs94EtQPuenNHy?=
 =?us-ascii?Q?JWVgu/kPCigEJ30f1w6VgaZftM5P9KgV7dXUnjCVpBjJFPaX5ogXjv0jkrqr?=
 =?us-ascii?Q?gh4LvYNx0LPc41dEnVI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzD1y1Ag+LxBorm56TSM8xyTdut2GwTx1kphsYqooyOEI2Zo9YIJUvBkHoUM?=
 =?us-ascii?Q?+boZHukr1ICtIUj0AhpliARTGPwzvvo+74aqNUq9pDhE2hQM+O51M8d30WbQ?=
 =?us-ascii?Q?YY4R7vXoNovo0CmO9KfYJKjpSn31gmASyslm8RRE0/K8kNVfkoqmLWopXzod?=
 =?us-ascii?Q?YQQUolQ6kXh0Vz8AJAehLxaebevWVeD6wJp6s1FYbukZRTKWnQ2pzn+DWvrZ?=
 =?us-ascii?Q?bEQNcpbD1byZ6MgNBV5QCKPfTTAHiu7ID1oEZX0egmmzZrYlkAis9DvQfeGL?=
 =?us-ascii?Q?YwjpxiVaZkgHNhC1+zuSTvmv3U1ikkbUXOM+sd4Dho4hCEtknLuI1DxmVPhG?=
 =?us-ascii?Q?viMv07ARQ4GZMVAKDRoAI71n47hwMzk83Xaa/fX0xu47LsgERXUHp+4X9XzC?=
 =?us-ascii?Q?uBam2w84M7Nx7yI1TAhpccqU0lJ5+Y0W92fi1Xi2NudBVJfSbIHkrslztvkb?=
 =?us-ascii?Q?egxk4SBDMWoBG0cCpk1oxVFGKoKKgeR8cRLDhrA34Dhm4U8QXejDszD1ioh4?=
 =?us-ascii?Q?CQyVLOOZwEF2QMJ4mywImomrN3yMnxwSCJXq3cuOc9iwcxmjahtGtgME0DMH?=
 =?us-ascii?Q?a+sys/9zRK0/50TsD4X2ayl/O3rOLCotR2zeDtow9e+zQxflhQdtZPO435n9?=
 =?us-ascii?Q?8jvANe/kGJ4ofdPKuNvxm9algcqgR1aeefXhK58+XfM90b++r+Lf2KA1HHRu?=
 =?us-ascii?Q?UbQpXFyJcLjJaYj6M8cdTOaMTmxb60nt5F2fZvJNBO0hhztpsB6Lb8k+TBrC?=
 =?us-ascii?Q?+7oqh+hAUfFlX+dYH9S42wm1DSzCaUoduJj9fvTVSX+qhKuOF709pjn9UCLO?=
 =?us-ascii?Q?omT5MZM+GFHwsczBgtEwLt/UhrkGouFJdD4/wfmcan8vmvB7Ucw19aGCbQVi?=
 =?us-ascii?Q?OUsp+lDwHgrnVD/FubGuUfjWL5k9p0oqHt5GyAzDbgKiImiJC5Le5BHp2Ii2?=
 =?us-ascii?Q?YxnRrBkFYot5bfgN78+rQudR5i/CF8lniVGYVDdhY3GloAoMxguK8reEkdL7?=
 =?us-ascii?Q?r0rvZxiRmHp257grBDZGAO8klQiZ4wlO1FnwvUG9MSTcssxvWxUgcE7a/WGt?=
 =?us-ascii?Q?is/tTvKqIS45MoTskJbqqXXNJqu1wWUaY4qf3R4+bX3N7DWLc3YlBbNCP153?=
 =?us-ascii?Q?PXKdSO0n16DDEtUS/yyxvUMEXzvhK/u+3m6MamvNPGi71YhZX89XDoMuynXf?=
 =?us-ascii?Q?BzKpM2wdv0T/pD6EFWSpiM0qjQLzJfYaU23ySNzLVefPnX9sqfRtIq5Rq91e?=
 =?us-ascii?Q?msWtQY4ulGaEP9GR4O26rvTo9JMHYsUf2YMZizu5B5SiqXY7hDjuIVhU8p/l?=
 =?us-ascii?Q?cVNM65r1l7EtLdJwVC9oUhshj/Sb7brFS5BBb63maVjgb+vpXcX/Rzv93E80?=
 =?us-ascii?Q?Oia1YIjH9XAu4iqfp78xxtW9JebPcZsxsszsHhh3dqt4eYc2M6UxN972SuAE?=
 =?us-ascii?Q?QhQYFK0S2hdGyZcBd86fiYTw+q+s7a/lHV01C7QCFWSXPse1sREFlMieQHhE?=
 =?us-ascii?Q?ZPY1wzN4WVVLXe3iB92SeV6aS0AtMuNTBOe+ZtxELA2255kMPnTgGCugOQn0?=
 =?us-ascii?Q?x57umwuNRrQXuaLvpVeNZTTwc0fBaWQp4ojPV/lh/eJu9MQ15NYfT0qen/VW?=
 =?us-ascii?Q?GSDx0iH935bp79+QEOHLkkpg3Vv9UnDNIKrfXIU5kFdTIb1NN9BioxvkduTG?=
 =?us-ascii?Q?+QVBsyCfhoCRVHSe5bJzE80OZ4j+hSxCvhqdWi4D4wLmVkJk5P4HeQQhAA5+?=
 =?us-ascii?Q?kec6Vxom96MKnpEaTOmR7yG3815BrYg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wuW1pqjftNZHHscj7NthxZ+NK8VKcNxZLkMikRD9TYjtUT+2WKXD4rnsT+VlfleBn9zcCio6ZAjOEWetP73Ko5UJ+JPenBi8+JyvicR6N7w6mB7usjMSwVF7FwvlP8G15fzac0mAmp8HRNRb9IQaB7ciuVCFaqK+I77O1Zw+gWGE47FioZzY3NBm94aDUxrkrQsOQ7trqMKhX0ANMtUF+B7/FbjZLRApx83J37JRaQPHuBMDybF61rQDMEKrzuG+EPE2OmTbfn952DkhBokPIRExzAJ/5mf3ClgOgIwMJN4Yff4QACum2YFCDAof3ZCv5cRMd5oFR0JbroTQJo7onhLqM0TQMK2Z+eb7vXi+fG5bwyZngBezEI/QJiTKMJRQ4QtT7Pr1cwDN/PWN9F4y2yIDqxgnCrD9iFVs5X81zXXl9OGy9vP4CGueHN4Pkm8GOa6vywds78wKzw4Dnzs3AwSHYAE9Q95k3QeWFHp2h24CKpjuWXr9e5wAP9FAv/3IqcagXlYKVNS0pvPFRNyh8C3nTnTHLIw6C8cKa8SA0DU3/HL+AG4ba0CPqX5fEYtds1XdUo3xpFv69FinCq9ebws393vitDHw8SVRTKbwTyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1203f8-ffd8-46da-6b60-08de59d03cf7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:44.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls2xxZuiAaGnGt48TGtSb9kZSViT3b1Bqb7GI0k3+c40+hb+jEliWSJxUzuk6P6PelFqRbLXqOsVnBOgbC59Bixtu26TK2Jxgc5yTww57L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=69724b1a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GHGLKwWzlU46qEklTYsA:9 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX3iPrdF8HIWVN
 rIwP3z7vXF88XnjKbbXGsElSwCGN4PpbNgPu89wZFf5K9CNuPpPmGHJ7ATF+vhH7iLMRZrwbdSn
 jU/o27Vs2T9/cNy/pXfOCRZX9QKVZ4CXaaEHYi7jlFn0pKLDVuLQwBzuR0J4h/Ql3CiyGgceLsu
 DolIVnLKyzSrJfLxhFUhX5lrFaZgqLRb3+2Gkkhwuu5E8T+NW60NOxxFDMBVSpnD9CueJfkMcjT
 NYQQzS3nXuxY7OGJVgM/vmdKizfAjugM2gET12g9a8hiNedKgNCOJOTphENVwmSkGdXH2nh79nR
 OwxvKUg708YnC7cRU9zFcr8dFdksKisX6AP3XUQUoAKPa+dlO4jydYpEkRh/+iy6vhm+N5MEFFe
 +HuwfFqOCtlQhIBrshDXLzp8Ccm8QkiPSwo5DqIcL4LwYdxIiIb+3uH+ZShwNdmkwjFSZ1dSSZN
 ZuaBNmWDclWuzawSsSgWUFEN022eYXiYMmENU0dg=
X-Proofpoint-ORIG-GUID: 5xpW3M9yN53RKbW9r7vwcBqTrfd5VPkx
X-Proofpoint-GUID: 5xpW3M9yN53RKbW9r7vwcBqTrfd5VPkx
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75103-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 138D16AC29
X-Rspamd-Action: no action

Now we have eliminated all uses of vm_area_desc->vm_flags, eliminate this
field, and have mmap_prepare users utilise the vma_flags_t
vm_area_desc->vma_flags field only.

As part of this change we alter is_shared_maywrite() to accept a
vma_flags_t parameter, and introduce is_shared_maywrite_vm_flags() for use
with legacy vm_flags_t flags.

We also update struct mmap_state to add a union between vma_flags and
vm_flags temporarily until the mmap logic is also converted to using
vma_flags_t.

Also update the VMA userland tests to reflect this change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               |  9 +++++++--
 include/linux/mm_types.h         |  5 +----
 mm/filemap.c                     |  2 +-
 mm/util.c                        |  2 +-
 mm/vma.c                         | 11 +++++++----
 mm/vma.h                         |  3 +--
 tools/testing/vma/vma_internal.h |  9 +++++++--
 7 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e31f72a021ef..37e215de3343 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1290,15 +1290,20 @@ static inline bool vma_is_accessible(const struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
-static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
 {
 	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
 		(VM_SHARED | VM_MAYWRITE);
 }
 
+static inline bool is_shared_maywrite(const vma_flags_t *flags)
+{
+	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
+}
+
 static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 {
-	return is_shared_maywrite(vma->vm_flags);
+	return is_shared_maywrite(&vma->flags);
 }
 
 static inline
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cdac328b46dc..6d98ff6bc2e5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -887,10 +887,7 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	union {
-		vm_flags_t vm_flags;
-		vma_flags_t vma_flags;
-	};
+	vma_flags_t vma_flags;
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..6cd7974d4ada 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4012,7 +4012,7 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 
 int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
 {
-	if (is_shared_maywrite(desc->vm_flags))
+	if (is_shared_maywrite(&desc->vma_flags))
 		return -EINVAL;
 	return generic_file_mmap_prepare(desc);
 }
diff --git a/mm/util.c b/mm/util.c
index 97cae40c0209..b05ab6f97e11 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1154,7 +1154,7 @@ int __compat_vma_mmap(const struct file_operations *f_op,
 
 		.pgoff = vma->vm_pgoff,
 		.vm_file = vma->vm_file,
-		.vm_flags = vma->vm_flags,
+		.vma_flags = vma->flags,
 		.page_prot = vma->vm_page_prot,
 
 		.action.type = MMAP_NOTHING, /* Default */
diff --git a/mm/vma.c b/mm/vma.c
index 39dcd9ddd4ba..be64f781a3aa 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -15,7 +15,10 @@ struct mmap_state {
 	unsigned long end;
 	pgoff_t pgoff;
 	unsigned long pglen;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	struct file *file;
 	pgprot_t page_prot;
 
@@ -2369,7 +2372,7 @@ static void set_desc_from_map(struct vm_area_desc *desc,
 
 	desc->pgoff = map->pgoff;
 	desc->vm_file = map->file;
-	desc->vm_flags = map->vm_flags;
+	desc->vma_flags = map->vma_flags;
 	desc->page_prot = map->page_prot;
 }
 
@@ -2650,7 +2653,7 @@ static int call_mmap_prepare(struct mmap_state *map,
 		map->file_doesnt_need_get = true;
 		map->file = desc->vm_file;
 	}
-	map->vm_flags = desc->vm_flags;
+	map->vma_flags = desc->vma_flags;
 	map->page_prot = desc->page_prot;
 	/* User-defined fields. */
 	map->vm_ops = desc->vm_ops;
@@ -2823,7 +2826,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		return -EINVAL;
 
 	/* Map writable and ensure this isn't a sealed memfd. */
-	if (file && is_shared_maywrite(vm_flags)) {
+	if (file && is_shared_maywrite_vm_flags(vm_flags)) {
 		int error = mapping_map_writable(file->f_mapping);
 
 		if (error)
diff --git a/mm/vma.h b/mm/vma.h
index bb7fa5d2bde2..062672df8a65 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -286,8 +286,7 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
 	vma->vm_pgoff = desc->pgoff;
 	if (desc->vm_file != vma->vm_file)
 		vma_set_file(vma, desc->vm_file);
-	if (desc->vm_flags != vma->vm_flags)
-		vm_flags_set(vma, desc->vm_flags);
+	vma->flags = desc->vma_flags;
 	vma->vm_page_prot = desc->page_prot;
 
 	/* User-defined fields. */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 2b01794cbd61..2743f12ecf32 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1009,15 +1009,20 @@ static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
 #define vma_desc_clear_flags(desc, ...) \
 	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
 
-static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
 {
 	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
 		(VM_SHARED | VM_MAYWRITE);
 }
 
+static inline bool is_shared_maywrite(const vma_flags_t *flags)
+{
+	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
+}
+
 static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
 {
-	return is_shared_maywrite(vma->vm_flags);
+	return is_shared_maywrite(&vma->flags);
 }
 
 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
-- 
2.52.0


