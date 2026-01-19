Return-Path: <linux-fsdevel+bounces-74541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F3ED3B9A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEB330BBBFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4291C84C0;
	Mon, 19 Jan 2026 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lquAqQ9i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GBC/bWAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53E2FC86B;
	Mon, 19 Jan 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857635; cv=fail; b=aRmpSaI3Ma0ugqD/DLq2qCq2iv3HKBpwX2b+ah7fo8dKvwHOuJbrwhp2hRn8yBrm44RC3148XKG/bbMVWh0igRkOoRWRSbUkryatz/igpDu6R/JTM0dvucglhM/hXG4xkK74q0gNPO83r7K7nTpdYLbR4WNXWMjwZIDEB/1ieFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857635; c=relaxed/simple;
	bh=JOjjTgbFOjKtQxy1BuOhbbXZwFQUlC9GqUJNyR7ZWoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3/iVQbxCZhNBJmk+8SJDfrDkWgMJusqEKgdjF/kccvrEcCs878+1Akjqi6iHyAUe/sucIMoKfEIjvg+t+ns3qszDGTTU/9qNmEfMLY6YediMGhPhLpzRC2rFZsYtGa+CJLbpUhYkcfKWZmL814EXd1kjnKOIgqv6fKpjUtdeGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lquAqQ9i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GBC/bWAn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDZg71342028;
	Mon, 19 Jan 2026 21:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ML+7S6+PbTvUE3UQKkd4wVRlcnGFbfObgZMlnMm7+zE=; b=
	lquAqQ9i2UsqFhnm69sX+8mtbfab57LnYp9XDwxIxLNV8ECS4TFZimxUR4zULyfA
	JA6wn9lcQuS6HWozHIUXTA65WCOJuiPM3wITePGdP3uYbSPvZ1rZIpj4ivMFfkET
	XkpTZl8RGWCWeSNLYj9Xyr6H6UdpwHY4rbdt1MAlIG+WQ8VTulTEeScpoKAAJ4u/
	vFQx5fjEGc04Wg6nMdDbMSQnIAbyEFQvwEADMgDPZNswZZa/BoK8yFUTRCRIqmJK
	51S9L6ESzghv9G9B8l+YXCQm+Gujz1ogrZ/9rfiMffIn4MRPrX41E0aSL5MVD+Kx
	K711qhMVx/nk1Mfi2X3U6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br170ath2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JKV84E022439;
	Mon, 19 Jan 2026 21:19:37 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcht17-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp+0moTOlXHQWp+ilWa8UJDlxvszrzQTNplqjiEdOlDFmHLV2Qx6QfmUvIwKzVMvEKKGHgPRRWUryCMaY0D0mdE2WybCmReWdzhbLLpHLwvwCC8rbZQR/oqgbmqjGlTOV35IW5xGLRSayGymoIWYUprq6j5awvxr8bEUmpjVTqkmstfiSGcNQsZOvRbinEls23OVlu5KKDdcyPXiYikzTpRG5vhvgvmlMbvcJNFoidtBHkH5OHrEL/HCjkwFOz4G4qWTKBXZabb5F4443+7n4hjTdnsloTYbmOMI7VOlmXEVoomlHTD3yV+8ZV/jjGzrEURll0gmJW9EaqCoboiB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML+7S6+PbTvUE3UQKkd4wVRlcnGFbfObgZMlnMm7+zE=;
 b=MWzvHTvmiuz2KAytDduIKn9aA9ImstZqwBCAzvsrNkwzJj3rcb//QM3npLF/tlFEzk4hc5HKK1d3h8nsz5ZalbreV2rb4WvUxnCiBpqDgM4QNuPZJjrArs5mxGL9yE/AMuRtlAOev32b57ce2pdZtQc4ogq5gEN1mabTR8lS+2gP932iVF9duOmke63vOCdcV7Ybyf19VI0ZJjwY2dR5GsaRTtL1VdpVfcaNC63LxpBdCrr0GuCQ4m+58/tHCHCnpicUqixbrCLOmGoKDhVBjmmxz4ZD5OGP9EVvoVwuc4/EJunCu0MbFWz4dqc+JMFzSlmgefjjfCXl38NFkpAO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML+7S6+PbTvUE3UQKkd4wVRlcnGFbfObgZMlnMm7+zE=;
 b=GBC/bWAn9AU7mQ5mYNMLnC6muyOIMkteoQICpDhKX26FY7ggW+HYXW5Kp3r11coKSRpo8xewT0F/ouvI/FeyOdT7OXF2mbPZds71n3SZRNYj4ZL8+msLZkmtIZ/7JFQnidlUDTzA1SP6Zvx0svbonNosy6D5B5NO+1iwP18zOU0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:33 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:32 +0000
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
Subject: [PATCH RESEND 05/12] mm: update hugetlbfs to use VMA flags on mmap_prepare
Date: Mon, 19 Jan 2026 21:19:07 +0000
Message-ID: <17552b67aa68dda8b5104ced1ba60c8dedc475ca.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: efb0113a-b88b-4644-c0ec-08de57a07066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86NXvf49juuHbPzsrxpcK00c3qgYcqyByVcIuFwovsDK6xzvFbp75Z5gJQvb?=
 =?us-ascii?Q?M/NJJuRVler2kGfZAPk1YQyzqAJUE7tRTfxOa5P63QId+RbbAZN774qEQeZc?=
 =?us-ascii?Q?EVfgitd/GyDZHPa7kg3ILsUrNTNRQz4YXbuA88va+3jofGseSzEtyV8slUJt?=
 =?us-ascii?Q?B6S1u8lCGsJ7A30f8rzmkRfZk6LqT8mCR6yEw9M+/yq6VWC7CFMGWNCpamVZ?=
 =?us-ascii?Q?ZF3Db+k58QJ84q5U1Rgp1xfsTUEkELgBr8NgNbhTNqehfORKo5q9IZpwJt53?=
 =?us-ascii?Q?DlhYrs3YT0h4JOzpfXUsNQXaCCeXeg4d/FpDvMAsHo3L3YWFEpRSvU2FIiHL?=
 =?us-ascii?Q?Z19kVHBiAa0LiXd7fZhhtOGlRU4rw4ghd0CRM0R1HLSB5EiDom/A2vO5QT4V?=
 =?us-ascii?Q?DR1KfM9q8EHVZhOQxb2DwukRj8WzBSbzpFuQa6AuiPz3cPwQC41aSp9BfbcH?=
 =?us-ascii?Q?x3TPiNGxxublmz2HTkRFXvm97tSb/NItkQ6PZkbNp9mGzHZM1VaJ0IbOiFOI?=
 =?us-ascii?Q?js0pDo4DpKexavI0OnjChrsgNXzvLIl+OtFquEZosp7GCKLAC5UkVz5iuihj?=
 =?us-ascii?Q?cwY/av5SwSo3XXOSy1R5cn8Kw7LM4Msako7pSa5mJl1e2I8wUxozXQxuAT+r?=
 =?us-ascii?Q?o2Muv2LwsS59LuX4zCCx7rxKeey4NIFe9vOni2RKLHZMfrkvoVVha5MR5+tk?=
 =?us-ascii?Q?OQOP4L+/G6dtb7GRbRzzsJoi3eQnfPXzbuqKk0cZajz2gHhLH/KIyS7enJ2x?=
 =?us-ascii?Q?BF6fvGtImekM3sWugd/5C9WoHn4YZndFWC8W7KmkBenJPC9OAGs6wtsJ8LMj?=
 =?us-ascii?Q?YLXlAWJTLlO8B7fON9j65zpq4aXZtl/L3XyZWg8ajXRbt+gY4w+zwhJCn1ZK?=
 =?us-ascii?Q?pLFGsg0OJvMb1KpSP5Ij8SW3cW+2nDV+OSAc7Ty7G4P5kEIKWgM8tJJQu/X/?=
 =?us-ascii?Q?bCQXov+Ga1QCLsOi06+QJY/SgQiBf4FoT6M2iCsb+VTJlQwclxpsmE47GRF9?=
 =?us-ascii?Q?30XnXjM1xAAx11rdxvWxOfVLv+PueYq3LmC3BTOhAtyywGCXFmLQSL+z6hm3?=
 =?us-ascii?Q?1qBKy6K5XyYDweLAeRwaUliHdU33PbptrNRkl5RGTUUrHk8QnVWJr6Lpuv6e?=
 =?us-ascii?Q?TPIm9EZT0OHP4ONMrtrKBL636EJzgsC90pWm1wCVxHVhIgrglPyB692OTCAd?=
 =?us-ascii?Q?XkCS9Q95n0qwWay4a0NHkW+TZLqIlzAOMZcAnMr5FgWjSgO5VO+ugedcdGOl?=
 =?us-ascii?Q?zdQsv4TvRfE6epbXMlcsMFCtrgPkhRbKzy62HNxMeL2cSMUyGDjrMl9OYs2G?=
 =?us-ascii?Q?Msec7Cfx6o+qI7N7a+z2nYBXJLpr82qQQeQ6M5lVckhInlX4e2UsSQRZSGS6?=
 =?us-ascii?Q?zn06p7Q9nxlIJPoaSHOhNhRiTX7txYOVDnirpNZ3PojxXDoXdTr+0Hdi7ZeI?=
 =?us-ascii?Q?MC3M/EN9+cPdPmHBuXpzSTM/GXbtRRepOSQvzbQvrq+nI2XSl1UFrUS49Ukq?=
 =?us-ascii?Q?H/OhsEm4s/VAlRjS2yun9MhtB6dlpD7riwIRJnYoU/W3SLzGN3IVjraIzaFP?=
 =?us-ascii?Q?btwxRU9YGsHF2vdoNb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2lMVRmos4RL7Ye7OpqnNHzbo3+I6+D0ePuJp7w1n+gWC6QOqDAHcZe/SsBE?=
 =?us-ascii?Q?+wCzgr/MKi6gpe9TAl8Majse3u1keXkRGLhf76hem6wiySsqbqm4BkGYoh1c?=
 =?us-ascii?Q?qw3v/SwNTry2h5PfG22v/w0IVMsHS9QYixTB4ZufULs1AuH5dmVDT2NlOwHt?=
 =?us-ascii?Q?TSTqkTdw5jBEnnxdZGY5TZS2ZP5/L7ixcX497IYD3BK3KlKEtjCVjakr5t8k?=
 =?us-ascii?Q?99BwDK1vl5DKQ+AqN34A2HjAxov6r/hrOBid0Zi3MCfGEsMvH2IbdMq0jx5T?=
 =?us-ascii?Q?X0RyERtDM0PjehPGh2SfwaDgIiW5MbdI2f/VsOp9FRQwgCYtVW8YbZiYxfoL?=
 =?us-ascii?Q?gdeCQJJiLYNAcFOz2XEjLbQ/56pOAUPIeSnZxgcNWmO734mF9z9m8ojpBHo6?=
 =?us-ascii?Q?lyoUoXgUKlpO3JJfFRq0C+sZ3G6VnqOBOUUA1SCfrqJA5KDX7Yg9Gu0oQQWd?=
 =?us-ascii?Q?YXkLPqdbGN0Zt8lydmdj73QYmEgl2TyCB9baenpkVrkn7qg23IapWv/mTaXe?=
 =?us-ascii?Q?zYVuIojCNy+kBpnx23/TQRuPuN1KJilnibMuKP3viMWo9ILT3JN4odrPAuGd?=
 =?us-ascii?Q?HhnymxX36eQaA1G99idw6K21iP3VcuALDc7OgZB2ULTC+WK8IXXKN2sCy7hT?=
 =?us-ascii?Q?RZsBmeSSyLy4OC6C4t/4amehERtbdDSSJ63aTU17Q0ae1NKigmTuZKxLvB/S?=
 =?us-ascii?Q?kmTscj+WPXxFoCYu0hlyZpOxqi0FsjpdFFNlw3pZG1ED/I6cFNM6McVatjAQ?=
 =?us-ascii?Q?eyZ8cg+y0xdHSW6FvTXIJzgKhVET+K+C6wphqKUie0un3j38beZZk5MDZssF?=
 =?us-ascii?Q?iy5nGvBqippaHxiHluGo65I0hFyTRbqcyxY/NDvYcq3UzqKulheL2Djvcj8s?=
 =?us-ascii?Q?2y6sLfnxLopJth87bLAZSoM2caHgEFH0rKdxi192DJJj9jJ/HbbXdKo8nI4P?=
 =?us-ascii?Q?M4HaMiqRlINEYfWJ2Yrh7tKGBf+qIhs+nabiWIJWX5H/c8fHVxvNavl5tb7z?=
 =?us-ascii?Q?TqEsNQbCCe48EnJGE/fkJOQ0Se+zjOqkp/Vg2v5m6mXLVMDUncrqYyPUcdeP?=
 =?us-ascii?Q?nbnM9xku/t8r1jYX3zcsn4gGjvkI6auwAA2iuhsx/dBAaIIGzDL/jJQos0j0?=
 =?us-ascii?Q?KrExQTS5PgxuG4FWnbwgLrYnGZnUGIAKFk28lI/eO0cq3N1/KluBuiKnJ0mb?=
 =?us-ascii?Q?1OdONYQgTp+hD5MH9sp0QxRpy52EXH0mm4oNocPcrIsqLQonyv8IZKroYG3J?=
 =?us-ascii?Q?cRYckjOcSAxhVyxqkYFTkd/Qng+vEAI8LByK9AVdyf84INlZF04i0xa0lwjP?=
 =?us-ascii?Q?ENCBA0rVEtFjSDpH/hLWGn45Qq8YCJl9Rg0gUkz+01DYL03Oo5lsDJ5e8+nR?=
 =?us-ascii?Q?iIZGaDYBp5SokgdxcQTOkCNtpBEyhyYpNZSN1Pg6vZj4v3El5y1XLQimJ/Aw?=
 =?us-ascii?Q?ipqLDyNTFALBzr4bqS/y9jK6Acn70cEpvPmbkWwhjIHSkB55tovBcFR+cZU7?=
 =?us-ascii?Q?k6sbbb6qeIGqP35xD2xw3I+iZf41OD1rw6ee0XDqdKIPejBiukviqCVmkK0n?=
 =?us-ascii?Q?6+vJagB08DRkYsz3N/6M0hEvTM0fIh6b7e+caHLjGe00Ysb8NMgoZxjTy3q2?=
 =?us-ascii?Q?QpFuLWsCxGy/1ygW09CKxAU/guhiEhGTK6IoFFr9igTeybdQrrIppoulY1ec?=
 =?us-ascii?Q?Ekiq7/2sQA7LWsHNOvf5H4WJhfDJ/7pUpavoChz5mDdLeEirzoEineyabMEk?=
 =?us-ascii?Q?59hNKgyKEy/Ns5/EghrFKGG6PV3Qveo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XuXJgeCsmlRGfeqpm9HXUrJw+PLfsqEdJPu9FXnGUzekKZ6gZgBIBDgbPB2zKeYFXmTEIQmpT6ySuJMOgsdRAcPdcwUXqFercs+3vyDs/iO0407RheDbqwDMhMGaHUBKD2XBXIbTuDEkwMlSExUiO0G/0mHOGq7sk1Kuy87FwHRw0/naHzJPtCaK7cf7xO5EQHiM11p2+VVdHzvVIRpiE27rqiYWXFN7VKCEc+GLzHCSmtQLrB/6cDSe/542YSUNDW11TVxr9HkiyUF2imuLsHBe5w6sNocs8g26wZ23oku9dJqz12R/Jl69BYd1X9HcsP1LldSIsszUf5ScX/Iqgdu0ZZl223vz0+nR3oGP5qDJWnqQqsz11VcVWRazBuh8hqTCIy9obYlOREwbGfvzdPlVGseOcYPVMBfl1sgUaKqnJ6LK7KhR+XY7QjqaVKoRprPbDW6pA3rt7AuXNvACGeLpuQT+vYwfVdWMCDZuxIf3rLBTRUiqDn3YWa8KWCfukEsIa1aewKYX4Y+KRufYWVlHnq7196Irk/uRL7e6qFqSbRedVFdGEGFvc+mTKYDyiwN1I70HzoY95cbPjWEgpTFq9PHn12ZesVSWowuCn/8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb0113a-b88b-4644-c0ec-08de57a07066
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:32.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cODqgLfF4PyHx7N8C5Mks83AWgAQwHDqIcwoK69z48xQ2nA42NNA1tkdOC0p4AgBewncnBAXTwpYNIig3xdaBqGrFlg8oT5Uucy+ixR5Ea4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-ORIG-GUID: BoB1KFyiNsKZLKkKbuU_wGKNBPs5klxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX6m0xJeZ9Nr96
 svRsNO9f3amrrVPu4XB2QM6jEYisH7HdDo45heM3q6tXM1uCba0/TotRyIf8ZtwD+8EfeIJSo93
 YQwVKjWOx+dMsaQZlCi3rmgIcmaowWTG8Sd0e9aw7N7NvbbINzXGuNNmVnA/X3klEHdtU8wKuBX
 Wzu28RMy5ZSj6GpF019g5hzsmUXoTWZpPOeIER/TKBOkvYnzwJ8sXxyfigaykqhhBue/exm29G1
 ZzgfmB9pfufi/YTCEdgmYgm0n1timW5HtHZQVm0v2pn0mZDj0+pu5uBCdUnezYJAz5kNTfq3cJ6
 SGzdYDkr6aMzDzBShWxws0ArwHPptctCC1R9qqFDqdLdpaosOf6+lyYQ7V8Qg/1M9P0J+If96eY
 XTBhkxTNeiwk2kdNir56n6bgsmrtVlZ1mIfnY/BRNQAEofaRgS+fi5P7QTx7Yj9ngOB7JcAiDBD
 jBlTKAMgjlenbTQakWMvGjGXfBoWoRhjtzpoAnr8=
X-Proofpoint-GUID: BoB1KFyiNsKZLKkKbuU_wGKNBPs5klxq
X-Authority-Analysis: v=2.4 cv=FvoIPmrq c=1 sm=1 tr=0 ts=696e9fea b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=atHbPFec4puc5jveiVIA:9 cc=ntf awl=host:12109

In order to update all mmap_prepare users to utilising the new VMA flags
type vma_flags_t and associated helper functions, we start by updating
hugetlbfs which has a lot of additional logic that requires updating to
make this change.

This is laying the groundwork for eliminating the vm_flags_t from struct
vm_area_desc and using vma_flags_t only, which further lays the ground for
removing the deprecated vm_flags_t type altogether.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/hugetlbfs/inode.c           | 14 +++++++-------
 include/linux/hugetlb.h        |  6 +++---
 include/linux/hugetlb_inline.h | 10 ++++++++++
 ipc/shm.c                      | 12 +++++++-----
 mm/hugetlb.c                   | 22 +++++++++++-----------
 mm/memfd.c                     |  4 ++--
 mm/mmap.c                      |  2 +-
 7 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3b4c152c5c73..95a5b23b4808 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -109,7 +109,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
-	vm_flags_t vm_flags;
+	vma_flags_t vma_flags;

 	/*
 	 * vma address alignment (but not the pgoff alignment) has
@@ -119,7 +119,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	desc->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_HUGETLB_BIT, VMA_DONTEXPAND_BIT);
 	desc->vm_ops = &hugetlb_vm_ops;

 	/*
@@ -148,23 +148,23 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)

 	ret = -ENOMEM;

-	vm_flags = desc->vm_flags;
+	vma_flags = desc->vma_flags;
 	/*
 	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
 	 * reserving here. Note: only for SHM hugetlbfs file, the inode
 	 * flag S_PRIVATE is set.
 	 */
 	if (inode->i_flags & S_PRIVATE)
-		vm_flags |= VM_NORESERVE;
+		vma_flags_set(&vma_flags, VMA_NORESERVE_BIT);

 	if (hugetlb_reserve_pages(inode,
 			desc->pgoff >> huge_page_order(h),
 			len >> huge_page_shift(h), desc,
-			vm_flags) < 0)
+			vma_flags) < 0)
 		goto out;

 	ret = 0;
-	if ((desc->vm_flags & VM_WRITE) && inode->i_size < len)
+	if (vma_desc_test_flags(desc, VMA_WRITE_BIT) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
@@ -1527,7 +1527,7 @@ static int get_hstate_idx(int page_size_log)
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
  */
 struct file *hugetlb_file_setup(const char *name, size_t size,
-				vm_flags_t acctflag, int creat_flags,
+				vma_flags_t acctflag, int creat_flags,
 				int page_size_log)
 {
 	struct inode *inode;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 94a03591990c..4e72bf66077e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -150,7 +150,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 long hugetlb_reserve_pages(struct inode *inode, long from, long to,
-			   struct vm_area_desc *desc, vm_flags_t vm_flags);
+			   struct vm_area_desc *desc, vma_flags_t vma_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
@@ -529,7 +529,7 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
 }

 extern const struct vm_operations_struct hugetlb_vm_ops;
-struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
+struct file *hugetlb_file_setup(const char *name, size_t size, vma_flags_t acct,
 				int creat_flags, int page_size_log);

 static inline bool is_file_hugepages(const struct file *file)
@@ -545,7 +545,7 @@ static inline struct hstate *hstate_inode(struct inode *i)

 #define is_file_hugepages(file)			false
 static inline struct file *
-hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
+hugetlb_file_setup(const char *name, size_t size, vma_flags_t acctflag,
 		int creat_flags, int page_size_log)
 {
 	return ERR_PTR(-ENOSYS);
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index a27aa0162918..155d8a5b9790 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -11,6 +11,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 	return !!(vm_flags & VM_HUGETLB);
 }

+static inline bool is_vma_hugetlb_flags(vma_flags_t flags)
+{
+	return vma_flags_test(flags, VMA_HUGETLB_BIT);
+}
+
 #else

 static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
@@ -18,6 +23,11 @@ static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 	return false;
 }

+static inline bool is_vma_hugetlb_flags(vma_flags_t flags)
+{
+	return false;
+}
+
 #endif

 static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
diff --git a/ipc/shm.c b/ipc/shm.c
index 3db36773dd10..2c7379c4c647 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -707,9 +707,9 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	int error;
 	struct shmid_kernel *shp;
 	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	const bool has_no_reserve = shmflg & SHM_NORESERVE;
 	struct file *file;
 	char name[13];
-	vm_flags_t acctflag = 0;

 	if (size < SHMMIN || size > ns->shm_ctlmax)
 		return -EINVAL;
@@ -738,6 +738,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)

 	sprintf(name, "SYSV%08x", key);
 	if (shmflg & SHM_HUGETLB) {
+		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 		struct hstate *hs;
 		size_t hugesize;

@@ -749,17 +750,18 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		hugesize = ALIGN(size, huge_page_size(hs));

 		/* hugetlb_file_setup applies strict accounting */
-		if (shmflg & SHM_NORESERVE)
-			acctflag = VM_NORESERVE;
+		if (has_no_reserve)
+			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
+		vm_flags_t acctflag = 0;
+
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
 		 * if it's asked for.
 		 */
-		if  ((shmflg & SHM_NORESERVE) &&
-				sysctl_overcommit_memory != OVERCOMMIT_NEVER)
+		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
 			acctflag = VM_NORESERVE;
 		file = shmem_kernel_file_setup(name, size, acctflag);
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f4494251f5c..edd2cca163e1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1193,16 +1193,16 @@ static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)

 static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
-	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(desc->vma_flags));
+	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));

 	desc->private_data = map;
 }

 static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
-	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(desc->vma_flags));
+	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));

 	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
@@ -1216,7 +1216,7 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)

 static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
 {
-	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(desc->vma_flags));

 	return ((unsigned long)desc->private_data) & flag;
 }
@@ -6564,7 +6564,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 long hugetlb_reserve_pages(struct inode *inode,
 		long from, long to,
 		struct vm_area_desc *desc,
-		vm_flags_t vm_flags)
+		vma_flags_t vma_flags)
 {
 	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
@@ -6585,7 +6585,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * attempt will be made for VM_NORESERVE to allocate a page
 	 * without using reserves
 	 */
-	if (vm_flags & VM_NORESERVE)
+	if (vma_flags_test(vma_flags, VMA_NORESERVE_BIT))
 		return 0;

 	/*
@@ -6594,7 +6594,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * to reserve the full area even if read-only as mprotect() may be
 	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!desc || desc->vm_flags & VM_MAYSHARE) {
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -6628,7 +6628,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (err < 0)
 		goto out_err;

-	if (desc && !(desc->vm_flags & VM_MAYSHARE) && h_cg) {
+	if (desc && !vma_desc_test_flags(desc, VMA_MAYSHARE_BIT) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -6665,7 +6665,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!desc || desc->vm_flags & VM_MAYSHARE) {
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);

 		if (unlikely(add < 0)) {
@@ -6729,7 +6729,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	if (!desc || desc->vm_flags & VM_MAYSHARE)
+	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT))
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b..5f95f639550c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -87,7 +87,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
 		idx >>= huge_page_order(h);

-		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, 0);
+		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
 		if (nr_resv < 0)
 			return ERR_PTR(nr_resv);

@@ -464,7 +464,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 	int err = 0;

 	if (flags & MFD_HUGETLB) {
-		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
+		file = hugetlb_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT),
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
diff --git a/mm/mmap.c b/mm/mmap.c
index 8771b276d63d..038ff5f09df0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -594,7 +594,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		 * taken when vm_ops->mmap() is called
 		 */
 		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
-				VM_NORESERVE,
+				mk_vma_flags(VMA_NORESERVE_BIT),
 				HUGETLB_ANONHUGE_INODE,
 				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
 		if (IS_ERR(file))
--
2.52.0

