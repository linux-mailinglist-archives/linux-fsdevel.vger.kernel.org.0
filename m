Return-Path: <linux-fsdevel+bounces-75282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIeQJgBrc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:35:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0375E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F83630504C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E603F29BDB4;
	Fri, 23 Jan 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FXBFaUhp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D0o+6nZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BED22126C;
	Fri, 23 Jan 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171678; cv=fail; b=iUeasitRn9GJrPCTquzVioONQTnQtrVhK5v2+AzvX+lCn+K/hemTfTbUDkLqvoN7sPcAv1e4vwBIn9dG/Od0pod9sKTguFf1ZjsXRZD11pXhkH3UW4ahGGb1LZPlelKnmkG2Ru0di0AFPInfPuEF7JcGacJAcVgur35/bB6SZo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171678; c=relaxed/simple;
	bh=11NCgZ7T7z1ZRugiA7T5mWkMVPU//BVqF0rBWqikuUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j8vypxGo7CXOFMvD6EpRaL0WE9s8pBdTeii9d/iWvObTbBhElblkBv5J9qqOy93mH/pM3Hmmb6lrh9NifQgAFtkNdbieKNBnp9TfFze0/MwoD5vg5mQmbGa3M8Hy/WQ8d1CSWLxdbhc33936YiyiH4ctzqfk8wjNf1yH6AUQcio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FXBFaUhp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D0o+6nZ7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NBjsB31674936;
	Fri, 23 Jan 2026 12:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=a3WPNuN/W4/NN95F7V
	zNHcnkNUA1ILUqifETh9hmD2I=; b=FXBFaUhpblbZGSxWVJjHZ/O/gZpZwm48ti
	6FCmBzAbH+ZIvazR4avb/N6vctLw7GzcfSBokubLP6VsPqbVw91FvvYGf4Jv/Tka
	yCyf5FH3CJvWdR7QiIwwMm36tNt/39JgXbrLjUN+HX3SsfRGNgcK0PhVFBTdevz5
	yr3MyXqQD9J0lW0J8KmF4JbAfQy0vL5SobZv47VT4a3pqYy1H+z1eoyQU7WhUJ/m
	ag903gOQbM1eF4OWFol7SLen/VNUti6yNvCz+cCCY5l/pHaLd27WD5uvMl9mBeVD
	uoG4G8hmAmdcRdDNH1Bzp1Xgit1/ilJoG1ktZ3GnRb1jclhw6SYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w29ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:33:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9x34P035863;
	Fri, 23 Jan 2026 12:33:41 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bux4y53r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 12:33:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8z9ZnUH6yPzg7wLCWxBwnNBF2c5MziuRoU5dS4oRQu90Pn3NblAqcE+tNsUrr2GMu0UOKeNHtZZ19aAeUtBBMhj3v7OkfS+sL2sYnS9Zl8paicnIMeSWUamEY/H8Qp5R1nRrpdfBSzmvAv2dHijQZDjDZ49oUbEjuX+2t9vrWBpF3jl9JZoTgBSl/F2yMU4GMdT1zDAo/aN/z332Et/mZqfhgFsarPkARWfAjfiY86KYSTvGxsKEyrGXji+6+ZzwGomqnj8aapERoit5DXsSXRrIHx8/ICedZg+LBRzBDxi9HdKOw+6HzN71OX0TO8OoceM3qS2c3lF0aTcnIXPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3WPNuN/W4/NN95F7VzNHcnkNUA1ILUqifETh9hmD2I=;
 b=MOzXFTiFjOJmzBCYNtqLiHcxHi545Ba/63iQvlEHygwfv3Lf9P00mCAHdGV41LCMvyAEr1LL9S2pvLrkWiSllGstDUm0nTm641vmWIF2bWoxHQSzUbQkqfKS0OYy422vi6iT1q/HKxq3wLXddqisrZQB/i6s2keUMv/eSPZ4TO7dMAvZXhd5hOL9GF3F9tW74KzvNa2FFvDuXDsjuZ6NbVvs5ku1WZ6fve8MfnMjKMemOZPvY8EC55XQyGyJlpgnAks/qPDqtqzxK6XvKQ9weRSCkMlaRGJB0ZQeFTMBgnjzrZzD3Zz1TQjaqZE1Qy4UzsWI3Z50bFCdnSqZI6GcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3WPNuN/W4/NN95F7VzNHcnkNUA1ILUqifETh9hmD2I=;
 b=D0o+6nZ79HsxCX84pTO8/DbR2bKQSBnpBHo2ZWhhGG22GaJnWrqdiXC+BsHDGx5LNx2S6t3shhiH5sR8mfT5cWuTYPqaVwFhNWKMyu2R0bzMr6fxvRfs/kNl/wq7YEHQJvo9ngCbKEC8Sk91107ZioW3R0bKNqMf7MNzHkA37I0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 12:33:36 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 12:33:36 +0000
Date: Fri, 23 Jan 2026 12:33:27 +0000
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
        linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
Message-ID: <d4acd230-562b-4e86-bb25-2410a7d07a33@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::6) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: e403c11c-8ac9-4fa6-0d23-08de5a7ba088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHEpTUNpdySDS/spXaEpkO1gSs4kXmwIQFhrvWdNgD6gj4conY8W/Qu1E7wd?=
 =?us-ascii?Q?ZtUestVc9guX7JCG9GPtWPdc3P596xKe69MTNzmeeGd1teI+UB/LcyZEy9Om?=
 =?us-ascii?Q?PwlztY7iUFrJq/4buEcGVB2Ivv1O5zsmTmGmbZ5MMqCbkGZFWLlZHPNBcN05?=
 =?us-ascii?Q?yhU7y3RUQqLlIUdvQmJOcxwFoDEmotHjRTscs4QF08F1zjrDKWprIqyrPiTm?=
 =?us-ascii?Q?9BX9MsMs+tGe4brUOEpxMtdg2XDkpPYNHZTBiDeIzTLaIxOV+kfl5rrm2VTl?=
 =?us-ascii?Q?1dZwtXWHvOyC0MH816+O/jt8YOosJ8e796qajrWaBfMo4mSqYyjG0F6joYuk?=
 =?us-ascii?Q?mTkGS6l29T9N6M9Uz3ad9yEkIV+po9UHdN8Q49OLr+wzR/hdmJTjZ4tx4TJF?=
 =?us-ascii?Q?ZE00zoPpcTD/qASiZo/UHVprvQrVGNnhMahDTY/tOvOgpt0z0U/307k0ZQ+C?=
 =?us-ascii?Q?QXf7KUOJtxtw/otKjyMfw7FBJatrBOdD/8hqkZzCF5qN/3IBML7RGI/KkcDm?=
 =?us-ascii?Q?9B7gP8q+ffnQ5rORrP0k1rJ4wpwyt8WaeNxzLgEUBKfwip4ufooyfbwzOqWM?=
 =?us-ascii?Q?U7ZERSLHgiVmT/TzJZNOeflx55SllxxIKJPs1coTrgMjK6ryrhiXPgQEikXc?=
 =?us-ascii?Q?SVLnXd0SGHPCjwnC/B9Ndm2A/96BO69LpJZuLg/NEp8Z8p9z+84pFR7QmuWQ?=
 =?us-ascii?Q?Ac0wiGVnlv/tHEqhTyXgm1WvJKiLcmRvCsGn4k+CojeK7UGouNoHIN1PBRA3?=
 =?us-ascii?Q?tbKdfGp5+QGmXGwx5T2l5hQsMf690iaCrx7YKKixM+yQZkbU+quXx1cHHQz2?=
 =?us-ascii?Q?nLtXx9WcET3Aw+GkEUhSIEEzhdbWCr1lIEdMgAMeihcUvosH5dObnA41ZSYc?=
 =?us-ascii?Q?9QHT3/nurODHCw8pEluWEHcHa2vjjFORRJmhrQi12JgDvBqSZ+jKzhxQOmKH?=
 =?us-ascii?Q?g+mvYNnzpLeSNxht2RGhW8IYu1pmpI/sWIfRgr/UG1B1UtnAzUJ4Cb7GA5Xz?=
 =?us-ascii?Q?ireHW3EjaRvu+e+qf27WptVd7kszZmjt6SxDAW0vujlHao/mxjHY60n0ANFQ?=
 =?us-ascii?Q?1KTKVxHR/x1y9F1BYfuFuX+blc3YG7qVyHVu5Z7UjV1vqNU8ZiAe5PRbnG4V?=
 =?us-ascii?Q?Rp4dDiZlx0VAfMc5sRlibsb2AOZCiiXrobPu0QU5/EWJ/VdbRRJ4FL1/Kh2r?=
 =?us-ascii?Q?lZhrrrJ/qxPfSEwwQUHtRuSJ63dcLIbDEkbyfLv1leHZStx5Q7OdDB6SxjXb?=
 =?us-ascii?Q?gDgB04LjpKhFzABOdULm8R05UvTj8bcZa2pQ5JdKX8eDKkXz9nxO8rIjjBJV?=
 =?us-ascii?Q?VJlgCFcV2dbXe94a1kn7xu0+XCPOesPKmxRY0kT+JS66AevPMvRBInzkq/3W?=
 =?us-ascii?Q?HUxHvQBLXrrVwtJnrzGTHBvCK7vjbPU53x0DgR6+1BjAyUWawEUHMa6pfXr3?=
 =?us-ascii?Q?esOgJV7msstuCcUeMAhpRzplnPqvE+pgnpMfLCeJU5c8HTLkfpg7+Oo1t71C?=
 =?us-ascii?Q?TrfUUiyoHtsFmWo1KHJrIEhA3P5J78NiP/U28aroLY5zDjmgNx8Xazvf1pav?=
 =?us-ascii?Q?4mfZ3iglqLIcm/VuST8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VDGehMbKUCZ5UIWR9AB7c2SqdSEh1aMzpGU+BvxiL5MdtoamGnYC+I/c8XXo?=
 =?us-ascii?Q?q4xtRQc+LqDv5aUSmd1ODUAwH9CLGHMLCsHn9Txrg/bEOKKih1z0TC1bCR1Y?=
 =?us-ascii?Q?eEtHq/1GMrI5PvnrB+siM7vBRbF+vYyDbO83mvUfrVbM6QryzSGZPsKiO1Wl?=
 =?us-ascii?Q?spMlOqPkgvfdDrSJM9Tltr7MqVoijDb4XglJSOO64bP2sGOkL3XBmEFt70tf?=
 =?us-ascii?Q?cNrdqS5H9br4zV2bB1+BlCkhXGXvSLKiJ+Z6+Xd+ab6u9tk65V9fbgL73mtB?=
 =?us-ascii?Q?MwcXhGolt02Aln2X72MwbChwKJgJ9cCMDyx+ED1+R/2Yp6yYz1WtRviXQvKS?=
 =?us-ascii?Q?6TQpiTQK6Cjz9vd8f1zqaOknYqVl2nFuJn3P0tyQA/m7ve6rmO+X1bhqixxZ?=
 =?us-ascii?Q?qGfi+QS+OEp0l6jMjE6zbsQCoQxxHkfZ+cAwm+PObpsga2YiiNTiGN8PEuiO?=
 =?us-ascii?Q?V+f5bhXX0+AHZH12LFVMlw7liKVzSAjeTJdYZS2/9aqXphdQ9KNUaEdUKSRt?=
 =?us-ascii?Q?sdd2Kt1o/y5GbltyZ48mg1XsKLqLewR/a1MyTiVnHx6WUkWVzKvxQ2bOeNOF?=
 =?us-ascii?Q?eMBfP5lo1skI6FD7h+KKeaoofE648SJ57PiKXXSYqwwK2SaZ5BFh2Wmzg/cF?=
 =?us-ascii?Q?mxtunbKipCdYz1ffMSRb/4Ua6RnLoMzd8l8QfD40U7bSqktmNWMzZ3idqfi1?=
 =?us-ascii?Q?xaLdseUWGKkXTVZ2fNPF7/PleRJZcwC0QNoJb0O0XFgoHQQNf1WNu52a4iKB?=
 =?us-ascii?Q?28iRf1Lc+0Ir+ICM1NAwbRDLkElYcB/IkUHPR4BBls3D6g8G/nEsBT3+66a6?=
 =?us-ascii?Q?zrFroBr0+tc68pVbFyQRk4Xyz9/KqobZCgZleooGx9zu3dLj5/Czx4V+9Rpb?=
 =?us-ascii?Q?+MA1w/mAfRJ1LeWlyMyneQrRFT+7jol98mBmAQV93tOaI2UBw7xQmBsvIrQv?=
 =?us-ascii?Q?mLljhFMVMTE7jLzVMnF+qp4GQ64rVpgqJKXg6r+TSVrUQ3dxq6j1h4VgQ0yz?=
 =?us-ascii?Q?UwpOT0GNaaVAE9sSMfZp5rzHcSI9YNXajD0xPwNB2IctRr9A6yhNa+LL2uGG?=
 =?us-ascii?Q?dM7JgHoeWz3o7eiwfOPEZj4GFhCoiUWf9xHfn3q8ofqZI1xzsBEEzLDd1oyt?=
 =?us-ascii?Q?3AM/zox9fkSaeBzxW8NsfkDpZq5COG4arrKyYMrsHo7VTqicjVFiwpQndvoq?=
 =?us-ascii?Q?ZuvzGt3bR2FNy2oB6iR8HUL82DfpbeaniH5wzy1+4CQe2FWEykiLWaFwh6JI?=
 =?us-ascii?Q?K0vJKqgrzTT1M7CLk9i+csYDOl5TmIX1wuulez1b8rkBRTXIfupnA7la5anF?=
 =?us-ascii?Q?ZFtLL0iIjRrG92xxmXxtmiG0+pABov6kG6fr+8F6o8MCwwP7cJZ+7cml3XNP?=
 =?us-ascii?Q?goJX+zi+DaI/Fgj8mu6AKDwODXwGoS0YhqujIdorTsjophilPk/RFp2ok5Gw?=
 =?us-ascii?Q?sA4ZFn990lSATMiYidNHcEN/O6/str1Cvpngle7CuDi19cSoLnqEYSKr0bDC?=
 =?us-ascii?Q?B11farmy0n9cDdS/CzXNhHGJmExaveyMD0SMcEfnpSm6xhJL2AJXwdGbX4d4?=
 =?us-ascii?Q?Y0XigQEz9OlzWEg5jVwkiNVFeV0tIPVJ3lSKzxPfg8G8gvySjIzBljwVxzOz?=
 =?us-ascii?Q?DQhF9Mv/GZ6gzhwOBhXdZRNYMhqydfvQDLoOBx9etYcTJcclwdp8QZXFDOAN?=
 =?us-ascii?Q?E4gylV0/XLwKKAMHZL4QeVjdG0VbnsbZs/tIG/skHKEJP6aQ7nXzNqJm5RwM?=
 =?us-ascii?Q?c61zlNRBysCJrc4KjLpUok9kLLXqo6w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wTOZWIm/OVuEWWssX5Y6PLDrdltQN/tT5e2xH51FxvH2ncgUf/YHJHYD4GwzpOBi3SagLVfDccRDhHJjikB459jEwwm5twK1LZYcvPf57/0eD5Xdd7ioX0fzY5GlAn/b0Nj+QboKeuoq1Bj+dBTbG5rSOw/BA21xULmVQ2z/PwcZ1A3ocaz5SGMex6W6ILZ7wNQF5xHkmJEm7KRJ63y5N0Kilq1p0pZCvGhhrztZYq8RMPKiDr9RMFiq+vApzzDPy3d4vfHAWoyjkmm97LjlVgwABE8s+kuombQeXQsr95/iWr2JfZE1VHkhkalt14u5ufJJTdEXW8tQldkxQhWset+k+2RIuDEWR0j6AB7QYhXpnKmn377ICE96gmNNhb98QJTG0rLh/cXW7vcmFRnrHN85oYpLgG1Fj2BnfxOPquBN6HTu7UpjuJtw0TAO8BE5J1Ia1WMVxFne2HyzNyF1dU83dlNc4mRutHUyuSV6GzziVpxfgCD9OA9pHB3Mi0C5WF6heIv0fCz/c3qTuFwbk1BKciGufCzAKcAj0XrpJ00rno0wGst9K5CGd/UQULMzUp8E0+5Cck/U5WVBYB+hDhWyB4T1Uk8rqvjs8BSufK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e403c11c-8ac9-4fa6-0d23-08de5a7ba088
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:33:36.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxqmG2UpSIfcMFWJdrLRXTCumJ8TWSW85ZWoVdtV2V9KJq3kfMwC+pG2q7MGRPzE2k4wuvFm/c1HnhHB80bYHC9irrPJj2NZ8w34wecDdXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230103
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69736aa6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=tRyWSp2Ri3fI7cgBtN0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Buur5JNA-k5OSPcLkVEev4xrzfbyG9ic
X-Proofpoint-ORIG-GUID: Buur5JNA-k5OSPcLkVEev4xrzfbyG9ic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwMyBTYWx0ZWRfX/zIvTqFskhaD
 dJ4mfRF8vPbDEVWI/rdZF2ErIgbaY0GvX9XXVKnXrqkXR2fg6j+h2qmOL20rWle4XStCbZTGbWv
 NvqOI6mJ1uoJL3naCrthRL002WvAcemqAhNKe/tFmL6htau4MeEMGnelD6adIea63eipHq0uUAO
 yLRPQhYVwcOEuXwYC5k/en4/vzIZv9jKpjRLrg6zZKOvgnG51Z6s5skoZvl6oPs/5o9Hij9/50t
 rjMt4DiEssUlJDlKYk5Zsp2xc+gHW2Ymg+s0aAEyi3602adUOtGzgCkMsnyWpvQVOHbRIWoSAiv
 wnuuzSWJEGvHB28yNv8WBzNK8dch1jf5mgPdfcSjzB2ACQbcgEunNDMa476oIxOcdj6SdwOmT8v
 KMUKSqZNBAqt+PC6NsoFm/jvQfZvl80URlVQakmNlZBrL++6NOe6i+nKL2/op5YfuhJgQ7faA9J
 I3zezLepk0l4tAec/qg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75282-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[92];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E6C0375E31
X-Rspamd-Action: no action

Hi Andrew,

Please apply this fix-patch which addresses some minor issues in the kdoc
comments for this patch.

Thanks, Lorenzo

----8<----
From 0283ddb073248f00bfa9694901fcba25362bdc58 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 23 Jan 2026 12:30:34 +0000
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 97a8f55c7296..b9ddd38621a0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5869,7 +5869,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
  *	checks are provided at the key or shm level rather than the inode.
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
+ * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
 struct file *shmem_kernel_file_setup(const char *name, loff_t size,
 				    vma_flags_t flags)
@@ -5882,7 +5882,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
  * shmem_file_setup - get an unlinked file living in tmpfs
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
 struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
 {
--
2.52.0

