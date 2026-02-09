Return-Path: <linux-fsdevel+bounces-76708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLA0LsnpiWmdDwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:06:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25B1100B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 15:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11655302E785
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85303793A0;
	Mon,  9 Feb 2026 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1DQZhys";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KQd3tGRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1631BC2A;
	Mon,  9 Feb 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645850; cv=fail; b=eP+l4l+KHY1xuWlBbNzlAg73Ou9UKHUKbEUIl2QV9a12YyeSzUE7r0SK6FbU+OcxKnY3RqFWMM7uMdKLLzvTI+B/s1ouclQ8RGt5AmILSkuid22LPJICRi6vA7KJE9bMdu8Hn7HkFTqxrETorzbIs77n6SpjqnQ5hseFtHaLT5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645850; c=relaxed/simple;
	bh=5GHJ2Yv9dl38HtwSxd3KwuAA2un+fe+0KhFukS7D/IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aSyOq/JssdDmR+ljr+4TZDF262RIplIfkFTpZEWo1W2dkQdl8y8j1dYx1uJ88bPP88r0I5jm9Q7yhHspuUYDXoF6gL/93S8SO+SvTyvc6ExRHaJWCAzDHK+5fNAfrmOt4MEPQ7YWDk7vtfGZx+7bPU1X6+QAbZhhP19C2nk0KMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1DQZhys; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KQd3tGRj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619BusYo1719735;
	Mon, 9 Feb 2026 14:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZMxs8SGnkNeJ3RfLiR
	e87AGdCf9pK1OS7nrJH859g/g=; b=o1DQZhysJBZcu4BXTY1eHS/HklKPYZG+qQ
	pON1oGi7wu24IxG2sPJp0NWhPXLJNYGS6PjiyJA1PyqwdMBlDP5lz549VWuy3e1W
	AwNlViz/vS4RCF3JPCad345vvs4FWGVlNttWyfqssIL+BiynCbuGoK6fOTp9JdIa
	4+GZxDXik3sicF+P0vkD51pvWEJQjwUzdpSf13x1kVWiGLrkgJsO8iRKpxmUuqKL
	rF3ZNPw/POQzTwr96yWyyZmNKO02+NbCoekMV51RFYcckhWeWYINNkds1OoDC+Zl
	vK2CwBQplTUFnssvRxEqyPB7xcqBWQoiSSJ1Tct5f3rcs+4JDTBA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xj4hy50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 14:02:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619CubqJ030924;
	Mon, 9 Feb 2026 14:02:50 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uukjej4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 14:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izVEvw4AX5MEeIxrQn/mYWd5dUAZKFUBv9FWOjwLMq9tKmKaPMAVErXKBf4kA49jl03j0X4auDk2M/BcIsVqPsEaKsbf8AFsyUsCmHlc0WOxUhtip1er3vZ911EmWpsCUA0YSEqz11wOOjCqd5arSz4OqZ1ipBvehga9EFBfIFcPU5WizInWzIVHyNyMepCFPDL88YP6Af8AS6UsknavuA40QrLKqwSimxxro8qnwmp/ie+w6MosarwX8Rncm45YP5tfxaGB59FuWLGTzgDjZeryTmiyQXV92R5xoCSejG1+ednMdwajNnPIVZCL61x4mau9+oNKDDCzn4O+rf3Qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMxs8SGnkNeJ3RfLiRe87AGdCf9pK1OS7nrJH859g/g=;
 b=DUsanv8oQC8/ftWWE+MGKJGy24z0bskhXnGd68hijkIiJqVKwsAuB+6Mt0b1PDTOl1zgPDKoU+mbDPjZAwZx/VR6mAdzwjjyx8vi7OuxLKSeTu3OcqJwiVBooEwPSEHvAS+7Yj8wmLjpUyANbme/KHvlH5zJSfrQtGKzTTCGNR6690LAUKYUXXew64Hz7sEYPoFAGcABW9yt2fTEDJLIJoSmSsy9PJKxriT3Wgdi++qtiE4kuDDM/+yQnDYQ7HRuJpkjXF75HEaEIbfErhGEl6XsfpgaNJhqZ1CP+H2E1YBXbDLlZx4Waa8z4yTdhP65ECkzdJlbRbAi8ZNooaiGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMxs8SGnkNeJ3RfLiRe87AGdCf9pK1OS7nrJH859g/g=;
 b=KQd3tGRj3VGJ32kiOu3oYr8R2LIERg783ADacmqUhqujFX22ocCbnQLTlmeq1tm8/w1QlQRJ41jm4GYIEAo2CmGyytIwf/NSc7bkal1kVwaCDARnjH/cVxf5prSogWVT24gmlcE+XREpRQeTiYcD9xhOPPjEdwW7W8u2j5zn7C4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB997765.namprd10.prod.outlook.com (2603:10b6:510:39f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 14:02:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:02:43 +0000
Date: Mon, 9 Feb 2026 14:02:40 +0000
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
Subject: Re: [PATCH v2 03/13] mm: add mk_vma_flags() bitmap flag macro helper
Message-ID: <1790de6e-f45f-4852-a0ab-5eeaf14e4ad8@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <fde00df6ff7fb8c4b42cc0defa5a4924c7a1943a.1769097829.git.lorenzo.stoakes@oracle.com>
 <mflwgdnyipdf4reufmbx7qarjcgouct5coe2bllticrabcu6rt@vf3bvmpunimw>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mflwgdnyipdf4reufmbx7qarjcgouct5coe2bllticrabcu6rt@vf3bvmpunimw>
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB997765:EE_
X-MS-Office365-Filtering-Correlation-Id: c548ba4b-6e75-47da-604a-08de67e3e53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NCUfVdqYcPxuaDHPZi4VZGuIfv2F60XFKZ3Bt8E+7TxcONAnP8RBqd1Rg1L?=
 =?us-ascii?Q?uEUSZntWB4SoT+qremCXIJOq9zHyNsgMAZmcqxDfQxs+l4cptQf4TQCFC2Ro?=
 =?us-ascii?Q?BDVBT/tjH6rxjn6xe6FquMZz6oVdSam7Lis2TDiRyT5oCyzb5MB/fl81LiA2?=
 =?us-ascii?Q?3Wzkx8zAhEri5luEdjlBMocSxDzPilVB1vuJ+DI61Dcmnsysr9X2Vf3CoW1F?=
 =?us-ascii?Q?0Ub/pyqaXL6ZwLx4SaowGTfJouf1ViIPQnC8iTp12iKzOORpnj5IrmFqOKvA?=
 =?us-ascii?Q?/jQcl2KE/iBileb5hqUHW7gWBiJSYqDtD6nkUDHG/0CUT+lR2CP0KAalClFU?=
 =?us-ascii?Q?FtBm3hoYxT/YpPoZamPDnmboUOQfCsNMK/nkW5k9sEpLpRsMFApRJfu5mDoQ?=
 =?us-ascii?Q?094rBNNUX1sip5Q7BppU+PrFTumwht/E8NlDfZi0INmP1VeAWYF/kdsGmN2o?=
 =?us-ascii?Q?9hH30DaircOrqeO8+GKYvLsrxeM1gsWDkCMWl0eRahCcx3zSxNGhSmSkVuut?=
 =?us-ascii?Q?MuoCq90UQUi98362RYKeDJ7VkgX35V47RTF9eWzlxU4oOf3ablV6Vi1D0uUE?=
 =?us-ascii?Q?Bn67uFeouDDk2B78+Vdnupv9u6MxN5t4NQ/kJkF13Q4+70mRLFI8Ys79o9JM?=
 =?us-ascii?Q?fBpsGV5NxdB5/99el7Jv5MI7TIQPydoyc+IEARPqJ//kj8Y7ZCMuovIRQBWr?=
 =?us-ascii?Q?rVgsssxBmxpN/4+RctlhdlZkN2Fwo8shATSmxZohhL1t1d628mGntbboZHI1?=
 =?us-ascii?Q?Gt5ZddhW3Yczaj0tZeprD4MNeZkG/Ef/u2GHtMNqovgZ6OicLjQ9hEBY7NNE?=
 =?us-ascii?Q?jsX+wov3oGQkF7imZFTDm8Oov/tBth6AGP9I5R1Glaomyq2wXIemBUy3/xkZ?=
 =?us-ascii?Q?JjjBwHjEFq5EHHUGOe4GK2tyfqiETJ7H92lDYnsXE1ViJNg9tISNDoncuxTu?=
 =?us-ascii?Q?wsrRrSW/j2wCn0opRqAIjLoj6n0bK5eakht2qlqBDx6RfYKQJWfdGYNBGIxd?=
 =?us-ascii?Q?KSEEy/YBwJSS4FhHop9idQeLhxTvZCcY229vgozMj2VJCRFlGzUJXhKt6bWJ?=
 =?us-ascii?Q?JDaSqdazesrEaGVJKLhZErr/iKQWRn+Op5xA3L4WlooOJCW0Y8JG+XKEUN1f?=
 =?us-ascii?Q?YaPdt5mpItEmOjLyVwzk8kGpEaqhhL01/PyGJ0q8mRRITCPggW+ZO2AEaaD9?=
 =?us-ascii?Q?W0U0xqN7RUO/lVNAZdnhNGCS5PR6EKYOZaQxSc1doQQHSRSWoYoK1mSq6bDs?=
 =?us-ascii?Q?4zUtUmpxSljqtRUvwt/qanpXkjANXZH8i6zCDZbyd8OlkNoTU8sSyVBoR75N?=
 =?us-ascii?Q?m4a+Kt+i7z9kXoBlC3t4KYipbdsk3wOCf14nyVyKac5vIGDmrloz2X6IfPUW?=
 =?us-ascii?Q?X4DdTpriyKkYVrIXeNtGVPgKM49sr9cuA/BCN1uElWhZTmMBf50Uvf/yzpie?=
 =?us-ascii?Q?NGfXTwXh4LE3Uh5GM2eDt89TYLxl3PLkLLALG69Lon6pWNCPDwCYRP9Xc5Z+?=
 =?us-ascii?Q?WWL5mA1QWHGwMCz4ivNyX5R/miecCcV+YbZj8jdwgIZYrkpYiYLrPP7jrOeV?=
 =?us-ascii?Q?URDX0aEmMzTSZ/GOlFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y7HsoJ08kygkghmCFBOy4+ys0thUoA7G7GcBT6gbDbWcLTF73ofQxsjBr/eS?=
 =?us-ascii?Q?8mYMTfCDI2LkGrnmMVXnhWnvC+bV/R7suE64Ox/TOiFQRKUYHUdXwyBhPBZ6?=
 =?us-ascii?Q?7tU656G4jWz6Ax2QqXYV85QKmrSLF2d2YzOR4pjDEcCD8wwjAAnLQK9khVqR?=
 =?us-ascii?Q?Z06sA3JySjJ1QxT7rmyMCtb1qRAXfoxvcoOKrUnPvkZJ2arxWNVxO3xbm9Ph?=
 =?us-ascii?Q?4PbwdMFU6yC4eZOdHC+5wBEOaX9A1+cKXqldxeE9u1XDTMPf2cB9/mi0AS+N?=
 =?us-ascii?Q?1Vz/fAmqaJjLC5Yn6UavdaS/ln9QLYSQaK5VK5TWcoBznSX5uli76mU/om/1?=
 =?us-ascii?Q?osM/HKs2n8z+gsrHORVmBbAOFNEWUjyIyWGmOqeK1i5iHT6BOw7oLVupOGae?=
 =?us-ascii?Q?aKwnTbTw+Jac74AOczxTtecAPBvNQd5dhMr1QaH2x5rMuvdmQUaA/F34bvLm?=
 =?us-ascii?Q?sT2soqYpUYm51eLGcQKXhN8SAnyltuzi9L9foYshitZ2txc5Py/lfgzYV8e5?=
 =?us-ascii?Q?IMYMJLj9jrY7YHCp+/UuYu9QQDYuSgKmtkCq0x0xdNJ48+YRs34Awt7lulzi?=
 =?us-ascii?Q?7ZsEjfTC1zGUMPOKQ15QunPyUnIkEY9AvE2t6h+5SGOGoTmJvj1r9kaS2dtO?=
 =?us-ascii?Q?6cWn9p41nOC5yN79AD9IJzYp3aGTF4e/Tr9/iw/NsUuJDU9hfOF8a9f/yp+g?=
 =?us-ascii?Q?KWwzdT9+tkX6DQmmwRcRPICDZnfwwGWHlGaxilFcJPUrZd7LOPDbTB69F7zb?=
 =?us-ascii?Q?q0TccWWtofNJbf58+AR30GdZXETDY5EWWb9/l0KqFCOJGzZuCdF9Yb0mDDi1?=
 =?us-ascii?Q?Z9R2dmX33ATeCwOa0jOWZqEmBUj5kPzOK5xWFpc8UZZXMjEWhfHSm/3Zyumv?=
 =?us-ascii?Q?AXsWXGOkCFugmiH6uSoiDMeP7GAhlRQjHdmwWWhMrX7ycdb/IUHVNUybGAMA?=
 =?us-ascii?Q?PhjDAHgLOejTikMfHsaObbAM/7oWahv/hXeUmcX9BeGEFWzfozx+SGawqzFW?=
 =?us-ascii?Q?9VQ2vxwFEFcrsWF/ervnX1I1CjjOwE8KKCqx6AjyKECdXdQ7uZP7DypfUTN5?=
 =?us-ascii?Q?bxb2Vm/1fbDk54M0mo4QPZwArXbKzcy12wmZFx3uewgodWUnpYut+NhG3VWB?=
 =?us-ascii?Q?C3+5pUK5CGQE8hIbZ2yWvICJRPmJ9VXX9zF9+WtnjI5l7LmfLkvXW/Pi2ihy?=
 =?us-ascii?Q?BRWwuFRh1ZPQtQhpuxtC8Mgw5/kBkzFBj28xnQGQFuDb3a/NnbG/5jGvG5mt?=
 =?us-ascii?Q?egX59zpzpUMp45KE2NzxpmVKLYU6IwJ3+YGd2N2dJn+m92ZZBHmbih5Cl1Fu?=
 =?us-ascii?Q?2ub1DOU7wN6ej/cpfkhYYS6S1F1VsSttPVXbKzTZ3orSNfc5V2LQX/B6sou0?=
 =?us-ascii?Q?qYppkNz8cI0CeItF5UEx8lywGgu5RcVdNJa61NhX9LTKIRX5NdbAA4V+XG2l?=
 =?us-ascii?Q?iHh7z4kVJObNOeTN2bbYkcc9OEp9aV21oe2je01AGyQFsOfr+wWeqQMblXQK?=
 =?us-ascii?Q?XnaoTgQj8aJWrddTJZ45K8Yh+DBRI5+Ye/Qto0G6RlT6DRm1iH5t3zrNftev?=
 =?us-ascii?Q?Yshyi3uybjEe8ylcUDA5qQuX/evPHH5TMce5A7w7/TJ9ZuZ6NkzAo4SsPwcI?=
 =?us-ascii?Q?KpOD+Z+sZ5M9jj1HP7Tg8B2OFzU7VXb+VZeb7GZcb2xTFt+pwjn2sp1h2lkH?=
 =?us-ascii?Q?nKyEJyHa9zftV53+AmU75GzRASKVqhJfDMZNT4SEtPEak3Q41lfYdkUwtUKH?=
 =?us-ascii?Q?T/E56jSXRw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+bvxpuXODKyi5dm/VgBdQQ2sBnzigbDOIbUy8LG/8EBVSVcAJVIi5nVHHk0isFy/p6f8Hk7bvyL8ZDCJ+LMwxsvGGSkL0tPoeSo2NvkQy7x05iDbcf+nmkf4Gf32uFtws/Na6zd2RYfkC0YpsY23COPsvNEwgNjnCMHMLGQ7rYM4Pxvgt27ion3nIaJG/VXonGPEgEnU4d+o1b75bpvvMqBJ8+7aj4xIizY7kdodlYCwhlZVbFkElQ3xJe2Z2ItWiXCUOIf/JemqLCoqwxjkp6DAezpJDLlKkdSTbszE4tGLHQCbBZCXazn7kh3oEs8RUaB3qFtUeilh9CzyneQx+gIZoED8xMaHWcSQ2RpYOTstyhGmOuEFNh4vKp8fMpX0P1YQzpTusJBJHGi57cgp9oJf0PlrUaHF88urKdPERlgvuC9sDb0YyeGiOQoUIasGVds9o64KZm11Ls/AEY79rMa/0jbGtQ3wotUuDV0gFN8kabTzM9lI1pVdCYw8HWpemU14uImUemIhk4jkkb7pe+Dib4lUviryF5N3XBP5KJBNTI6zkdoVqCxA9ii1S8Frydaeh/IfdO3rLdOy2qBAWkUugLssl/5FdXI7f5dKmps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c548ba4b-6e75-47da-604a-08de67e3e53d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:02:43.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elBZfzWogI6uA24lviSRlIannytIYXvTZhEiGg/fiz1bLTNluNDDq2QM1lywPJGXrBvIMd8lhk7gL6WNNv/3Mt+ppq3jPGfMi6O01jLWkb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090117
X-Authority-Analysis: v=2.4 cv=Adi83nXG c=1 sm=1 tr=0 ts=6989e90a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=570kXksOqZftmgpdgrsA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13697
X-Proofpoint-ORIG-GUID: mp4V2xVU2-9kYTuwkrGfxtRsX0X20riC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExOCBTYWx0ZWRfX5izsjw2jfO+3
 iUdWvlpGanML+5ucbFIPSoxa0HeIGzWDNpQ5Q5qqj2JHNCyyBkQR5HEPd3BbFqvgQb1ml/WZvTx
 ZXVTImSSkAWt/jgCJlgxP9Hw0GmYLy3DPFwXx7oWDbmoLKtkEatbcgsHwE3MDfmgXmxlUdDhdHi
 WcYfedQpJ9W9au5DEB5A1yIX0uM7EYNG0GOKY46OURNCYC9i/oUH3mYTs1jI/1E2+HjIDoDY7+R
 mkIJ4rdE1gdZmblQPQM9P9aN11/Xy/NqVe3UiVNcfjTJDS+SYJyWq0oLKB+OyeDz1Y/PJoxGlOg
 +oxQhrAsue/vWEYysDeAj/1KSjWCQrlpcA3pSEsChqNCGfZjuzQhK04MItDKqV+I+o7iJi5OgE7
 jpFVoec5ScRw79hW5a0YI62UQ/VKQ9gNc6hPVLPONWPKsmFpjkAIgpPp5f0dG0LrU2VKLsIefOK
 rQn2b5e5M5AAadZSNVqNJuFeGnurbf965RyPocfQ=
X-Proofpoint-GUID: mp4V2xVU2-9kYTuwkrGfxtRsX0X20riC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76708-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,nvidia.com:email,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,lucifer.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3B25B1100B7
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:14:10PM +0000, Pedro Falcato wrote:
> On Thu, Jan 22, 2026 at 04:06:12PM +0000, Lorenzo Stoakes wrote:
> > This patch introduces the mk_vma_flags() macro helper to allow easy
> > manipulation of VMA flags utilising the new bitmap representation
> > implemented of VMA flags defined by the vma_flags_t type.
> >
> > It is a variadic macro which provides a bitwise-or'd representation of all
> > of each individual VMA flag specified.
> >
> > Note that, while we maintain VM_xxx flags for backwards compatibility until
> > the conversion is complete, we define VMA flags of type vma_flag_t using
> > VMA_xxx_BIT to avoid confusing the two.
> >
> > This helper macro therefore can be used thusly:
> >
> > vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT);
> >
> > We allow for up to 5 flags to specified at a time which should accommodate
> > all current kernel uses of combined VMA flags.
> >
>
> How do you allow up to 5 flags? I don't see any such limitation in the code?

Yeah oops :) This is from a previous implementation.

Andrew could you drop this paragraph? Thanks!

>
> > Testing has demonstrated that the compiler optimises this code such that it
> > generates the same assembly utilising this macro as it does if the flags
> > were specified manually, for instance:
> >
> > vma_flags_t get_flags(void)
> > {
> > 	return mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
> > }
> >
> > Generates the same code as:
> >
> > vma_flags_t get_flags(void)
> > {
> > 	vma_flags_t flags;
> >
> > 	vma_flags_clear_all(&flags);
> > 	vma_flag_set(&flags, VMA_READ_BIT);
> > 	vma_flag_set(&flags, VMA_WRITE_BIT);
> > 	vma_flag_set(&flags, VMA_EXEC_BIT);
> >
> > 	return flags;
> > }
> >
> > And:
> >
> > vma_flags_t get_flags(void)
> > {
> > 	vma_flags_t flags;
> > 	unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);
> >
> > 	*bitmap = 1UL << (__force int)VMA_READ_BIT;
> > 	*bitmap |= 1UL << (__force int)VMA_WRITE_BIT;
> > 	*bitmap |= 1UL << (__force int)VMA_EXEC_BIT;
> >
> > 	return flags;
> > }
> >
> > That is:
> >
> > get_flags:
> >         movl    $7, %eax
> >         ret
> >
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> --
> Pedro

Cheers, Lorenzo

