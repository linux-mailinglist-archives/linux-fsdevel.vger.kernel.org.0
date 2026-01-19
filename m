Return-Path: <linux-fsdevel+bounces-74545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154CDD3B99A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 451823034417
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039222FC86C;
	Mon, 19 Jan 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mC3fNOVH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uohUluwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089132FB616;
	Mon, 19 Jan 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857649; cv=fail; b=o4gXnz9p2pQ1oepNZzjyKFa6dwhXlTIzKm8Kh44gk3NlfYeF2ILNq5uiIQdOHDyK3H1I6HvePh5YSP+KF1h99D4CjP/HCKTqQl2K/ImN8qrFUMUc3QRy/Q+hzrCGQ2YWEQrwkrUJUXs4PIFQWrah6bz1SuEvkZNU3laAQgAx4ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857649; c=relaxed/simple;
	bh=lzOnnnX8jSNvYBaLIGYGbO+iPq02NGfQodH8OGryD1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAOCRItT8DbHc1IfQTkdD4z+sJXelgjy5/qo2jfc1BXmG9Zt6T4iV6vYwlevgXNv/wnbZfDl+WcFtqKIYqQTjCC2lZHcMlyMV3kRkqa43CqqpC2Eu9iRK7YGC3RPLo/cabDU9FY3/UNABPJfC5mEGPrn7RaBDS9YOdOfqokCJjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mC3fNOVH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uohUluwq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDYwn1429552;
	Mon, 19 Jan 2026 21:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CJDahWgAH3ZJVy1u8VHOx6kBL7yG5bo6NeQbqR1js2k=; b=
	mC3fNOVHrLKRvbHW53vYab6xEhOJKqF6hvSkQsaGoKz2VCjaXBEp1+5BBu3Am2Nj
	5f7VILi38zVrWgeG7WF2NUnaYf2zVafzvfxPiu22s6xOuXe4V5jEvbTLsZTxGJYF
	+e/N59LGQfvK1R6X6m20piC2m2A+jLjSsjw/rXKs23hd9jA2v0NlpLTEEWBq8qoN
	guWPRimvUwGJDsKhwPng81pxqd+2GDHWE5gJX9uYG+4sML9lTljSeVewNFx6QS47
	oJwzzwhwFmV5h3nT9YavOMoI4eHM7bNjoWo7qGRmsmhIWuZIr+Nycg6oHVANH65O
	IG4m2yRi678RvcEijLRy9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5jpg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIQNgS017988;
	Mon, 19 Jan 2026 21:19:49 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8sb8j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE4NfZhPZrv5h9PpEI57A6jTcJF8nR9dXOfHM1JbcIdYA3OknkJXKpp3dCX+qtZCJtQ/xPuNWwTIPZN7bmpjwtFqVoO3SbIfPlxaDwpQsUTCoNcx77/PldDyNrY9ZLyJSokjtX6LoMzFnJNOrS4MjURblbFenqm3RPAJFdl+UUor3rLTWNdLi2EiDPSRWbUqLLxqKHq5e10GEOZk+ey6gxykVdCVkNl6lwUgbt0YI+PEMUH6MpLvjusxGOPi72UngfNCvkted/MUUo+l7290cjt2dPDV2GtFkIkWaujOMNizrDfl3KN0vuVl+Tt2oOPNfv+HwLfqIOjWXfRHY7XnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJDahWgAH3ZJVy1u8VHOx6kBL7yG5bo6NeQbqR1js2k=;
 b=weKDyhTBqeLYQM8+pKbd/MfBSpDkuEdHcLkPiKHh1DMAanm58yDQ4b6KA94ksMK3DrD4967Fz4rY6bbSfdiPoJBIWow5U9KnRs+SnQlIOyFF5zkR6dEQDKnJIf1YLo4CCq67VTHzllmJYomsQCNJXJTLftl4INCUCqf+TUSymT0jf9Vc0kDPbptK5zfo++A+L2c6K4SpiX9zElfLihGyQiLM77q9fExlm8XppZU2BL1HtJPUwD/k2smRrzAs8fTGYVSxmYUFdB+DAsjugx6g9SCGxKJ7hsu5UuCttCctTLExtKKnIZUykmAmGgej9PzjS1Be/oc9xgIZxqXY0c7ApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJDahWgAH3ZJVy1u8VHOx6kBL7yG5bo6NeQbqR1js2k=;
 b=uohUluwq2HEuoWxraWKcj4HS2ThqzrvJPspsiTLe/iilDYISlu3/xJZR+OoBGhYWhjEAzT470NELbcgGMjZrfjAspZuYQUbJzh5qWkySGgAbQkML8kAngm0Z+I8FLafst+3dzKsRvx4s3CoQr/tE3uIe3/iqk5AHvg3rvhGJAKk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH5PR10MB997758.namprd10.prod.outlook.com (2603:10b6:510:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:42 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:42 +0000
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
Subject: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t only
Date: Mon, 19 Jan 2026 21:19:11 +0000
Message-ID: <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH5PR10MB997758:EE_
X-MS-Office365-Filtering-Correlation-Id: e334312c-1f86-49a7-f3c9-08de57a07619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8j2WdDI8hEkGnVW2Jrz3IyinvC5+KFmmC9sfJVLpcAowohNFOsRwAuo2Hwad?=
 =?us-ascii?Q?0dnZWvLaX1ahEi0AjGNV6XNREpd+za/QvPa6eeMCCCcb3b1fgTaY75TF28IR?=
 =?us-ascii?Q?fmtl0k98wulpNYCeOvELIxNZ7aNL0ExHVxF6nOK0VXDkzRkcKWun3TtbCDBV?=
 =?us-ascii?Q?9oXdnJVTwj5kTZcqs7xxfFDgHR7peHdQ6nLik52yrxtywSy2yYWff41DiDqf?=
 =?us-ascii?Q?xlmHucTHoNhOOOGoVprUZTRiN0efrAGCOEBt5cYzoPd4aY93R37YQw/cv2mA?=
 =?us-ascii?Q?6XqFSJEEKduQEvmTMNCcuBTtZgtHAM0epMgM/xvh8bcBUTmUauklVs8S32Ez?=
 =?us-ascii?Q?N+9mu70TBnrCTcS6a0V6NaXBERIC8VNcWj3VuL3/xALquFmIsPIJZ5KWZbi0?=
 =?us-ascii?Q?4ko0CbvydqjhTLLg7XTijGAvNlCnU1SF0Cgkf4CTH2fS3e8rUb9L+tAaQ0bF?=
 =?us-ascii?Q?Y8G6+A4svtAI1sufdcD6RP0C6+wwL+YQNOrLYI0ro2ybeesxviSVj6Blh/WN?=
 =?us-ascii?Q?1HLb8xa4EH6sMGpwMPcFoBX1iIcUw5801ogrfvX3HZHCbURsK08MWCLoAPyh?=
 =?us-ascii?Q?Fh7vIZoxWDsUbdP702PL5LC1gu2Z4q+5EEI2+bH51E/C0+strAbyovsQdr6w?=
 =?us-ascii?Q?7+XAK2Ico050I4MXScmSbYp1tMNy0cIFoPlB+CkvchrTbP1GZZApy7TLlZyJ?=
 =?us-ascii?Q?VGhAbtX4Ve4fc+h5rKJI8j1NXRY66EKylFoREhDoL1Wq1uGVAaNl3o9FeE1m?=
 =?us-ascii?Q?V9lL+YUR/XG4LKkJvFz7Nz1p1D8IL3NZaOrv6LegP4aEoY8E/v1D7c6y67aQ?=
 =?us-ascii?Q?Lb9b9jL5IH0cK1FFrQphtlbudHe6rX2vg+oGJXGRkC+x+PTrKiRNNJ0SJ+Os?=
 =?us-ascii?Q?PYKChZG0yHwNM2XIfFTeRijqwLbjWxTFO0H5eC6T/QAWPFo/t4SWL7E+R2Cw?=
 =?us-ascii?Q?f9hp/IZvi3ycWpWjNuPyWzvCrMcEheiE72drYIyuosPRv+ALByHt8fM0U/6m?=
 =?us-ascii?Q?AZC5mQMx0SkMHE8qD4mNOrumSBAuXMydhC0yyRbUXf8OxDmXQL/6B5tdsqPt?=
 =?us-ascii?Q?Y6iQPIel4dgY2pnvrmHiiKiYxU50XiXKM1Z70v8YUePeSHDNvCgW96oTAfRv?=
 =?us-ascii?Q?eioBFC/EV1bY42+ofJ9zXQoNw4uHhYEVWviX2dMOMmcfjyvyguthLPCCuhVt?=
 =?us-ascii?Q?PSzsabzVSNZ4gH/hZc3sb6PhLf1g1LsZL1pZDJapc0ah2o+gRc4MF1Dv0BQz?=
 =?us-ascii?Q?xNBGzw+p4LGgb8Kg/yvWl4XiBEbLV3nl8yHxIWNqHz8PPrWmMyW//NOgCZsa?=
 =?us-ascii?Q?0OnIXdVsINqkje3hHEB7OjteBQH7C0QnywoVQNZu8b67g5QTVXAHI79U1ii4?=
 =?us-ascii?Q?lBZfKibIOEe86+NxmflOt13gwS4R8PiFrH6Ki7qtNy+/YGzKdDxcwl+vH9qw?=
 =?us-ascii?Q?qQKcE6uhKYGUStJpciiqX3bFfMB49lv88D/2Htf7dXNwoPLsPhKUSPhzRqIF?=
 =?us-ascii?Q?IuolCE5JxeqqGpA0N9omyEhOZDgC8IAbp9Rk+eDoO9aanFxV2om2kbWG5HmL?=
 =?us-ascii?Q?RPKlpxBwFMyuFUBtojU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+OekqCdEcKvbEZRu+5vrLy9pAwrmrM/zh3NCGOsDEWxtcHswfb2BiInVdFYe?=
 =?us-ascii?Q?hdmaTF5c6IFEPfcC+c9uWCVT5ZzRGgbm847rN6JRDu0VNkyzChznIVBP55IT?=
 =?us-ascii?Q?AqxVGSi/sjtP8D8TeudhkqbYlE29DZ1wcApSQ5KoYI/IKRHd4YVieymW/R83?=
 =?us-ascii?Q?kHUrPaUePPtIsKMmDDmkmQozCdkZxCyKhHtV1HsTSRy9dFGTLsgLzyU1v5iV?=
 =?us-ascii?Q?zzo3wZfV4hPuPY3UmZ0xy6rDc8O+NtxERrUW7YI1R/FV0HKzaE3XdHrRZ+6t?=
 =?us-ascii?Q?bPhy19EfTd59CTgWhuqxY8hb8fNxQYSADmB3Ny4NeB0PVpJBgUOXR4actPrf?=
 =?us-ascii?Q?dKSUoo4od/zgSDZB/3TONVN8/WADZPNH3UCRSBeL+HayFwWoTDRo680J5Ob/?=
 =?us-ascii?Q?z5Rx4xssDYJeumCQUwsz33PN0TvPDXb5TIznj2j81RxkkOA8X510rTPvQ6iQ?=
 =?us-ascii?Q?FXy/Ixw7w9V0F05X3d3Uq0DTGkYRN4osxIlkPazyGc7kK+sJWzpA6jxcFn8U?=
 =?us-ascii?Q?F4ueD59okxKL73asGb5RzSPR63xPr9lm7rHVs0xNd1hsnuc5pPAdanAu7kh8?=
 =?us-ascii?Q?gRATu3mMO8EPKaLcxcBdgNLGE2MEvUphS7QGJqVVqMDIskSnJ/h+Uid2dpUJ?=
 =?us-ascii?Q?pwU7+RH/ZrKLArqDztQC/6csXBzz1JcAr30NNXb0Xv/UBzgsGguSGdycPSqW?=
 =?us-ascii?Q?JbKTB1CLGr2RqAVVyRKlmi3z/7fLr5DgzWVIHphj3tZOVLo+xDMQNuKWR1zD?=
 =?us-ascii?Q?TW0wMxzWJAvCMVbxkNUZjiJ2pXcZC6XmrEVETQo85GWaoRdl9tku6HQCM0y6?=
 =?us-ascii?Q?9VrXJeDaQIJX6qNf52erw4z17zlvvFLAwRLKrkKFWtQeHJ8ZGKN0lDy2UaHW?=
 =?us-ascii?Q?av9RzkwtbYJyPlP/qX6IeXIMpHkyzjwlkHZkZaAU9EiamxYkBNAQ8CVh0yFN?=
 =?us-ascii?Q?V9oIM7P+M7a7HQngUkQK/bBaKjkJ1H0eavEqCMR5YRX/FgRf/z/kwx0u56cB?=
 =?us-ascii?Q?bm9/4dpYH7hQLtqHVtpN/f9+ES7r9GIw9KRUybXiONB4Yox2uuKsI2ypCMpM?=
 =?us-ascii?Q?ynuvJiwJZGl206XQoRN5JK7Gtol1vg76bBIKyCtEq9T+OETTObIro9RP994q?=
 =?us-ascii?Q?sM6ziFM62WgkMnZ3FHtUqCl0PvRfzuAkJjbQb5UbiGf7VMx+AF9kuWprjmuC?=
 =?us-ascii?Q?1/H2gjceM8BbKxtcxN2eyUikVA8yCF+uku992JOxdXp18TSzkq1gouYKq666?=
 =?us-ascii?Q?nYhIP5H+CF8p8ne73reOSfxo8Xqy0YzSQaxJuoIe+qD4cWgrJS/vF04MiMzV?=
 =?us-ascii?Q?arhZHcs4h/svPe6uLkb9/Or9sw7cfFgdjAWU/S8NUh2kTCG8eE+3TKnylgA2?=
 =?us-ascii?Q?HMym+FaBkMq4Qq5qcGEv6Xg8hu9xGY+oBw2gcfEJlbgW69tv37Iu5KucJZPc?=
 =?us-ascii?Q?K9n2dLsZJX15OcRR1xhAOiF4xHi+fqVWqvkqsf6oXGSPezG4lhPMyRzTKcBg?=
 =?us-ascii?Q?lnEOe6C0qynuxLNmAD/fHqttL+mo0MAntd44Ue+nYBXIZh9lQMqAES3BE01w?=
 =?us-ascii?Q?Wm33jizD+pHe1gkba6TE3GYBUnoG7xn/nvgelofS5N+o3AJXcS2b/Lg6UWeh?=
 =?us-ascii?Q?0rxBlqLXqHFroqXODhUdZjuIMkNrN6QWbxhNjqexX2fjXR8YKzvqr0MaYBj3?=
 =?us-ascii?Q?SII1v6vXzxaxs4gMocC/8R3oxvJatXvD5x2HcMDTwa9DjAZQRq//lkS4hGII?=
 =?us-ascii?Q?MVjRPe0vOKPAi7kYcQDPbyiysip2zDg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qrpd65py129XBsNqNfgunr7rkt3emDnp4NIKo1Q6ug9l0rlDOnRbwVqn1Q+jnjszDQFhm5mcFlXalblb/2Z50A9y9BW47OoKSQqS2/C6YldhpKjxia/aAV1qVYYSSXq5znzzNns+YsY/39My1L3r78ZP5p1qjObSg1VhFMX1vLXIFwydYef4yV8iWU8pD37OHy1252+iSlapQtxWT13LPWM221RvHmH6VcWpLpkdbCEg3YjAEq3tMSNHOtErLQ+DOuMtdH1jt+DyrY9T2gYyuSzaXrU3bHUwFWuzozFimHJhyYm7Cd0Ofa54Xx8ISEoELiEXJPbCIo28J9bvsK2ncrIUHKHj21fWJvhwAn0n8OYxrStXVn9UmNsvI5TR/JzKzJmSYWDZPzvQGPHtUpCwb4qsYcjGdIgSm/thnF6+c5B4JC3TIVOCzaazGXTdnTW2N3K2dq28tRFQaldq3YIIGG0HLQfbZ8UclRqobqvOODYhhhHh14Ec6Chfvv1fJAwuMZXiM4az93ekZOda0wIhV1YS9rqGrWtMGgY9x+qNG5iBY5kqDtBEzk2mO4fODlaawyaA/P6Oo1+8eBezrVGTW74J8+fWzTA4ofT3Hb5UIVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e334312c-1f86-49a7-f3c9-08de57a07619
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:42.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuofYPZo60LMNu/pB5gm2RhrsQvGiTJUxv5PV/OFjqxdnYtMStVvPdRmFEK6wXWyroS/1eVEx+iBzpbuimM8gVdSanWcSBjSWbUMzHRIBE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfXyx5rFF6JVL2s
 7REJ6aejOQzeyi7vdTAF7tpbywIL1BxSUXN/TwVZ0EpYVW+iUIWifaQAaKk4nYC/cMyEmlAyfDc
 vAroWPVYCqs/np8JmmL9WC3YuQ+yRJbWqcyxsQzaFHbKHpybD+7Ag/n7q2zSd9ZyW7G6icVT9ST
 q6Vpdh9qFbXP5fvH4I3dvL2if4JFF8ecMdrredR48egF+WLsbnZPIteeTtW5cL6o2sJA2waeGJV
 5nWfU5Co18UcAlvIultEFm2LaoXldMD2uuopMCo9rPVJgIR7XHDpPSm/KZJl2FxFG27K8oaz+se
 7VC0i1VGZ2xkRp1N0ZflHU/oFoR4RqVM354XeQD/A207Ez7BpE1s2rENvdXW0uXm0k6L/iGAbx6
 /bbE8p0OjBOepwRANJJCJDX8AXK+6JmCGmAY18HYpD1HBz2G5yIFx7qio6ndjWFsypHOpKEn7o4
 E2KBwcp1RO4t8FklnEg==
X-Proofpoint-GUID: Ihr90QjHjBlP-Tkg2Adn85AVc5auN-c1
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696e9ff6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GHGLKwWzlU46qEklTYsA:9
X-Proofpoint-ORIG-GUID: Ihr90QjHjBlP-Tkg2Adn85AVc5auN-c1

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
index 32f48d5a28ce..407fcdc4831d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1293,15 +1293,20 @@ static inline bool vma_is_accessible(const struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }

-static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
 {
 	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
 		(VM_SHARED | VM_MAYWRITE);
 }

+static inline bool is_shared_maywrite(vma_flags_t flags)
+{
+	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
+}
+
 static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 {
-	return is_shared_maywrite(vma->vm_flags);
+	return is_shared_maywrite(vma->flags);
 }

 static inline
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3589bc3780e..5042374d854b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -877,10 +877,7 @@ struct vm_area_desc {
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
index ebd75684cb0a..109a4bf07366 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4012,7 +4012,7 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)

 int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
 {
-	if (is_shared_maywrite(desc->vm_flags))
+	if (is_shared_maywrite(desc->vma_flags))
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
index 1ac81a09feb8..8143b95dc50e 100644
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

+static inline bool is_shared_maywrite(vma_flags_t flags)
+{
+	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
+}
+
 static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
 {
-	return is_shared_maywrite(vma->vm_flags);
+	return is_shared_maywrite(vma->flags);
 }

 static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
--
2.52.0

