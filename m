Return-Path: <linux-fsdevel+bounces-75071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKiUKA1JcmkJiQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:58:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C747D69562
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F4A3030112
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25A4D90A5;
	Thu, 22 Jan 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZO5cxOc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QD8qHoeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A84219ED;
	Thu, 22 Jan 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096977; cv=fail; b=rsx+atIv+ia3WDcak0pczObBV8Td1x4dXZ1aoIfUCTff5v/cmn3cVEIi7iMq2UWDNaXxcX1RBXqdvvPfft71zmQ2qoycaMwuvHBEZDU9o+3V20MZrqBnbOGLB4bNt7bpMNJPfOgzkkzF6Rqlu+oPfhbSEmISOkp6x+FH7a5Aj+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096977; c=relaxed/simple;
	bh=sTm74uq/dsKsVQWMmxOiBT8LDPg/UmXst7HfJmzF5yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ncCGAjZSGNwhtlcPesOoMCCwjrouZ6VIlJ7WbTntzlBxuCT45+PFeXSc1dnu6k+K6jUDlCHzrgaGGzBqLQtWTSUpHFolQS0/Zj8pFvAYcCYB7gDSTaSLgAhMMzJWIQC7+TbILpSYCwLFJNSUuTjfeFPtmVf7bkgYuQT7408gQfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZO5cxOc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QD8qHoeN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgqVR516192;
	Thu, 22 Jan 2026 15:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LoB2bx60DID0K3V1pF
	IPTgAyLRpHidSSstsSGFrXOj4=; b=BZO5cxOcVv6KcnHCbOpqQE6VR8c4RkdisD
	TY9e5c7gjThz4KoedLTQcf7eBxhJRex6Mq5hpvFTl42MeKhmLheDankf9ItzmxUM
	4+UzbdWuuWKJoEpRx2NgqJjESszsfrI5khkgq4dsXbAA7E33gioU5D5gbj0IH5vQ
	XS/M172mWB3gBiJsBKDFAn10SBYGgqaIov88Kr/Ne1mK04KKllMqvAXcw9ntPz84
	7YGl8o1Ltctmn0mv4fcBU3cfsrar9zjSW2QQy/oMhRlsKIZdd3o2ew+U/E7YOTGz
	95p0XKKT9HyIwnxEIIOmS6B/GQhI04xA+LqwUYG9SHOSYTlpAqZA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qg3v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 15:47:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEVpf6024962;
	Thu, 22 Jan 2026 15:47:25 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd03t57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 15:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uu8/DFoFIODpA7H0R+Ki47SkmJS2j2iKgCBiTOYhKhOnuMOB73T9Nqp527NnsSHLBbTJ8s5722Av1nYhgz9VbNY4CjSnrXdfft4oplz1Hqgh+wjAROgv9vfqgb7IVDs3qrayyKJGU9feor5zNJTl0WrF66YHOtrCMiyxGMAkO029PUiLOEKsXiW4X9W2iIjApSCQYb0uFg6/nMTU4wqvLv1xViu6j5/nRKElmw5i8S+JEOVRF7ftmySbkcxPPKC362kWXoMiaIYq6MZWHFiqoWquFKmiAtfSL3gioTHwtQqdnyZrTp260P9GNg4aITs8bDiX9cIFK5+gNPP4k7Edug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoB2bx60DID0K3V1pFIPTgAyLRpHidSSstsSGFrXOj4=;
 b=nErfLLi4jdF+LgQB2Y3KAS/1iE9vfNjkQC0WrKoSnRw6aU4DFpAITADOEP7VrBjnIRgEehDUxwKCAPmSd8Ai/Fa/cOncAJNto36xgrcxhLgEguoVTsH+voSfl3WgRzOGenuM87IMFhy/K/w91akvQ1aTBS+Skgft0t44jpc3MtcdPtksUoh8LDwaxm+4E+lAIRuYDxsxPFzeg27XQge1CgorBYyQH1VTMXckmjVXIZO083KV8G0vNn7QzafU8zzSw1cNvEYSWQCFwwS0pPIXgZUk3QWlO0PUBFbG1CRC40MCypEcKxvxeRcSF9vRdsBeajRnnvWzKsU60/YmLUmxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoB2bx60DID0K3V1pFIPTgAyLRpHidSSstsSGFrXOj4=;
 b=QD8qHoeNC7LKFriklZRtZgpUI10ps9E/Dm3Ql/dCciGEn757zp8OtVnOgCApQW50BNSSzjBY2oZmO79z6dKuLQUrDGH2+coBwXLKw1aviT7cvC0T1fsWt/g0Un5gsfsxPtDquYszHN/qBLEs9h8HSX3MVsWdJyoGzoiLY/MdyTk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 15:47:18 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 15:47:18 +0000
Date: Thu, 22 Jan 2026 15:47:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
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
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: Re: [PATCH RESEND 08/12] mm: update all remaining mmap_prepare users
 to use vma_flags_t
Message-ID: <8e02a213-8cb3-4338-801b-8f1705b3cefd@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <24317e6f6b71e8b439e672893da8d268880f7ada.1768857200.git.lorenzo.stoakes@oracle.com>
 <34F72E48-5F22-4A20-BF32-917CDB898164@nvidia.com>
 <cedeb1e9-93bd-4513-b1f9-7e41bbbc38cf@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedeb1e9-93bd-4513-b1f9-7e41bbbc38cf@lucifer.local>
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: febd411e-21a1-4c6f-97fe-08de59cd8604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHQeuNCzdjAz5PRMw7xo4plzqWyNubm6o6wgMMV3DRF/VMLVmYXGQoG3Sg61?=
 =?us-ascii?Q?UODcvoXXx85iPU9JEs6tz0QwAXbIKJKWUWlYhX3JcT4ypTkjI0RG3uP9oJGO?=
 =?us-ascii?Q?inDq4pcGjM0rVHwqY/Cg4RGlNc3YWsUV4RLIabH52ars7GRO3FLsKOqy2VjK?=
 =?us-ascii?Q?dij1gdPgKpFaYyVXKmw3NWnHcemOyqvvVZQesGPMhkYbopfxk4PLiJenHkGK?=
 =?us-ascii?Q?v/b8qzCtk06bmTj2r9F2WCUb0Zkb6ECHDqbvZ9nnz9xb6ow/U4iaE+N73i6v?=
 =?us-ascii?Q?/MYMb+kjejcYX38xbbKi+dbU3JR5e/4M+zpsdrpP4hseEe2z5LAPEVIax5Td?=
 =?us-ascii?Q?vXoaoYYFCQC6R/FJiGQdGTP8Rxz1UpENIFhK3bNL072zMVRM+t6RQ1D5E9Rm?=
 =?us-ascii?Q?QHf57FgqtcWmqw4PE08IQTRxJlZ1DIyQpc0vAB+sS+4mykdQ3xLp/BP5AhJY?=
 =?us-ascii?Q?Gi89ZJbfacPCMX5gfcBuDayKP+Z0OHiN7kMRrVBCZKOrjDwiPD4V+lnt7ciG?=
 =?us-ascii?Q?BCclJA/cGNzku7OSEQTUh7GHn8yYAX07GTIrapR3bHcCcyhigKlXkhuvqoR8?=
 =?us-ascii?Q?VM9+kwIXorswcYtozck2eAc336tfHsue23wFzm2YpVTaXXytUYWOH33VCTcI?=
 =?us-ascii?Q?ojjlu3XFw26NhtoIsA0MsHokknq4gHTcZBTvbHeaVhdLkZp265MVfPSKjkk4?=
 =?us-ascii?Q?DKgJ5OJjLS9YhniGlgjXxr8pvVzYSuJLJYP6pDLdcWk57je8GHV22hGkTWLi?=
 =?us-ascii?Q?R5Q0dyf8BD1zfDrfr8K43+Ao6I8E3l2WKBhnq/X/beRyYV4uRr625bFyxqnG?=
 =?us-ascii?Q?1/Itkc9xMbqoXWR/WO4b/AEEsAQxdqdF4JisYu1xcNyV52H3aKa4LEdwaLg4?=
 =?us-ascii?Q?PBIGfi0iYiRrfs0P03OtDWf/9PE4CQaLrg5yCSAP1QV0cnRVyjmyQdyZvXcr?=
 =?us-ascii?Q?BvTU3Yesvou312G60KyfIr7wcJ6Fy6eel6aVMo4scWdcUR7nNCzYyb9Ph7cC?=
 =?us-ascii?Q?SWxE1NdcerhMtGh+ZXtIC3gs94tCRkzHMgaM7r2aUQds9l5hpNjKgvtJFpAF?=
 =?us-ascii?Q?tVRj+17TsMZINEfOmKJhepiFYuwvBBWAGkFqwPf7LK0cz0bMvcQPbeBfrHyc?=
 =?us-ascii?Q?S2T362ZU6WvcMXc5IgeYFHJRc+q5qc73KdvLQfVHCPlbwAzsnudVVaYzMj69?=
 =?us-ascii?Q?0o/11PcXNl7/zU4k6xdhCIC1lhWiWjk20PIN0P52j0TIzWDtM31UMdT1hvMu?=
 =?us-ascii?Q?J6o01x9mTQlS96eeOviNmarQFQChfAGzXQhvRs4IRVF+K50bO/25vxiidX3w?=
 =?us-ascii?Q?EhkPaT1/aOSIlbfjHPvEW4havrJkjNmqFI2fkGliTUU0LDuhbxOmsNF+bPBI?=
 =?us-ascii?Q?2I0mbbf5EYYcc5BaKIPlDts7BOiAqKOWxvAbe/1xtRNmBMNQSwpTo2+weVBK?=
 =?us-ascii?Q?JjskRss5zDSSlbyqHNCwYSPgWc7FYjyK5+vFv/3k4wHaG6cwB9EFhsFurFXd?=
 =?us-ascii?Q?VMv/PV4FIMVj5Bq+mgttVaowpMlvPkxE77zldyRaWM5bhDo2KWbfntq6Idwi?=
 =?us-ascii?Q?xfoKLQcaeu9LHjhMce4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzN89I5GziCeZ0bDvlKNf+Uz27amApFF4ZRSxcXDWLyZ/k1Ph3votdfOtTDQ?=
 =?us-ascii?Q?2Je1XCQJvjrAhFBB2Mq4IxkeABuO5BcFTv2Scn4+5M4vThjK03+S2t59fsgF?=
 =?us-ascii?Q?qTgljjWjGyZV7XbcYSJsqWKO5PzX/w0D7Ss0gtYviITx/ZRW40nGuEz+kHch?=
 =?us-ascii?Q?zNxRw8a94bQ9GyKgn6wiV3BOPUW7k4ucgdC4Szuxo536+GXNJjE+rBGlnJ4l?=
 =?us-ascii?Q?RgINREWfkoFEAcHau3sr/gMOj18chw/3vZEcUY47D19ARppwApXIPXCPiKfb?=
 =?us-ascii?Q?B+8sqnCB4uSRwQgNhCDPSV1dRDS8W2gsPIey1FltBCe6+7Q8692/rdj91+ZO?=
 =?us-ascii?Q?0J1TGPp2B3R45rG91+NxDQLqext5/xrPzEIy20BVoT3A/aIaQHt7oC1ikKme?=
 =?us-ascii?Q?U9VmOW2vVJOgdZxLVMWabyhJjD9d5EwN5RYLQKU2ore0v3ujFlKF86xYodDC?=
 =?us-ascii?Q?0kUbLvJhG9zo8Lq+C2VB7SvIGEdtXpdzc5XZFAc8l0Jt0AjQ2feMl5u74cvI?=
 =?us-ascii?Q?KSaIEom6KiO0XHUUUMjEVwJeCoyrATd1cN8Ayu+VJIB+RMeRUSOuCNJaTBsM?=
 =?us-ascii?Q?GdklD/LDjS8e92VffvCCgfXyrWTRMGLsZ0Ni8L23iT68oMPAYCW7eSMzc5ut?=
 =?us-ascii?Q?KHzxycWAJ6Ecmo97G9Silb//El7QbF+2j7D5+3C9pGVnuE38oTrCq/wp9qRw?=
 =?us-ascii?Q?gz/bAm9rZzl6/I1Zxx6HHkteBgxPzdpaJSetocLlwco8f4Fu8Dqc1hcMIblM?=
 =?us-ascii?Q?tq7AyPf3yqhZiTykWSNx1c+hhAHFSr+bjurT6+/fdLK3x1LQtEcuRjhf5J6d?=
 =?us-ascii?Q?eYwbfHKf+Ab7ql2H9jnESUhkdsq+ZfCMbrlHD3oKQT1G8cfFu4vVCYzmIo6U?=
 =?us-ascii?Q?mmGjo0XP3J7JZKbwygrIKL1xKWD1T7yCLPGqsm0UUi0YDG9emYAix2krLYtp?=
 =?us-ascii?Q?E6JfhHnUXvPSn0FjNudZ9TM3YypB/El9col0YFTP4nx4w5qd2qOi6i/jfgqZ?=
 =?us-ascii?Q?Y4AL/tHTnC/VYifjs2kg2PcXQjEmD0ne44eJ+wmykJ7DtBvY60O32TFXh9Px?=
 =?us-ascii?Q?xgicg4jR0r0U8tXWfS42Tod11UIsffPzVS1K9FPFoiYEJTuAYFIXiQiDCTMD?=
 =?us-ascii?Q?42sRT7HV6fuu7iqE+YD+cPWrkx7ihhEXuzuwLTzTDS/u/U7cajzSByT1YmDd?=
 =?us-ascii?Q?vXiZXCIfkh4T17fpWQqMMPaF736/TCG89gI9XVyO+LzN2whP0sma6oH/vc5T?=
 =?us-ascii?Q?d5AzR6/c+5HyPQVJ9K+QflANg4XciXpP6oCc9Pa/5m08lCORtDbxt3xTfW4H?=
 =?us-ascii?Q?YVyZ2HRZWV3wUjZVTItUCNhcroWr7EdO4XTYaNsXNWInj5Z3BZzyhHFN8pKF?=
 =?us-ascii?Q?zx6lq57Xofns1jTneU+08s4JAFPzA71UdFpxxGVr2RjTpCcVc81kDA4IwzV8?=
 =?us-ascii?Q?wQJM6nCiu6qfVywfKfKvo62ttzeuSrQWIrntIVve56E9RY5XI2ySvMY5pmW0?=
 =?us-ascii?Q?u85sgvo8xNn4GDCLk8OBGCfJxYkw4yntWuqsiLdybHo+JmCSuocPiShu73vH?=
 =?us-ascii?Q?RGKHXhSuxRNA0FrlH/dKQ0ra545t1EsqTLnT7MDjeVqUEVBNEX64Qg1e+Xu8?=
 =?us-ascii?Q?hIOdc0MREhIuBNipqiXFqkwgGsXxxcVcjhSE0RLzwWt1QcMa+tFpR8yl5KP7?=
 =?us-ascii?Q?Nzx0+0KBUPSKBE7aSrTYWYcRp1F3RXKFjMC4CyLT/K7GOBCP67QvTRmjQq27?=
 =?us-ascii?Q?LExlSU7sl7GuoJFia7cfmSqlRwgtNJE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ukNF0OXt4x68CVufhyDWBCuTAHewW9nNTzm8lKp8ci2lTsyRWCoXKI4sDthRvYln+Ypqa1Wv1JPZrqlKlgSKdnTsDnCR2a2/oQnz0uVmt1mb05lbEmj/Esq3BeiZ+2h2d3m1Tr3fwt78YCYDAu7D0W2yfHcped2OdE2OQ7k3/rryN8hv1FAYK9+8MTBDRfsJMVy4C2pmdDf98MyqfPjW1AYR+hbilK0HsR3FRWGr5YtUdYnvGCHtqpb1B5qBLnlGBPBbtSFlZLkvzqP7evTSw+E/vyee428wOPRGAiUFD8saiRNY7LB3YiqKZwxGivaxClsPHkp7pRVJVdYnkzyx/YuYP00CT5kyUBJsyEJQjLXA+SsxX4aXSuaDAyA8KebOLg/GNkhgvyvbooOmCiTGDH8WYiWwyu797aw2bvqIu2wkbB+UQMJBP2utR2O1zXqYOCW2mMKiKgv9juspvJ1zwl7RgiMeoDZvdH8cPbEHZd+KN6H6CQPveLvYoeXaqC3aGcX7Z/EN64mzI9wo1OwGnxQqJ3Ybme+XnyHhQ8eV/86zgnWX9iM6vUypaUDlpgHcdXIaOlJqGVRVy9NKHxciFjcs8duWMUUMh6z6nXZteI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febd411e-21a1-4c6f-97fe-08de59cd8604
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:47:18.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNtEzOrtXKT64D55NAtPkTcZznec8O7HnC6WJHCnFJMIvnrDrWyFP+NATtGgIUi3X2tb4QwdO7XqqQ+tNSmW8wslrh3YGjqPePjVpPA4Ea4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220120
X-Proofpoint-GUID: KsbmHv-9RaY07h_MHf_fi17SfTcCxJFf
X-Proofpoint-ORIG-GUID: KsbmHv-9RaY07h_MHf_fi17SfTcCxJFf
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=6972468e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Q8JlcxFr-QmPdjnbR6cA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMSBTYWx0ZWRfX7+xBqVgx9YmB
 lVmH1anqmHvYwA/vu7z+moCDtBBujgBC7dfW/A+CWHPhLTvieCeN/In3BSvTHw5TXIF35XcXIt9
 casnALAy75/hohAFQqvnimmPui3so/HQk7JcCxUtkLcz658R3ljNfPVnH8Ce+E73l+KAmV0dVfW
 lCCGFzzhhS97GuZG02rmd+5dKpE5+MkmHAlaxGUY/jgJE7JQ712fT27bca3RPiuZuouwtmAGwtF
 CqJELH5Cbt71zJqlD02M9/P8OCqrK2HXmi3FYsNKZUkdhz+uD46LngMjBgBDfeo0jn0XaCJ+qWR
 GBODx+8FEMDcQakG0MzLiQDByG6Pbp28lc+7FDImIGnZNada9mQHO5llP2dJug0jQbgtjmomkvu
 XExTuVIxQC+U8xf2T+H2YSD7zy3I1WvtGxRs97SyWbyhmSpzqczLShd8JTybGnW82sDaVJU6+/4
 7jcM/F1/MbN//kxqlnskdJ7Ek3/2bqwx/SIpSE+I=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75071-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,oracle.com:email,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C747D69562
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 09:01:04AM +0000, Lorenzo Stoakes wrote:
> On Mon, Jan 19, 2026 at 09:59:51PM -0500, Zi Yan wrote:
> > On 19 Jan 2026, at 16:19, Lorenzo Stoakes wrote:
> >
> > > We will be shortly removing the vm_flags_t field from vm_area_desc so we
> > > need to update all mmap_prepare users to only use the dessc->vma_flags
> > > field.
> > >
> > > This patch achieves that and makes all ancillary changes required to make
> > > this possible.
> > >
> > > This lays the groundwork for future work to eliminate the use of vm_flags_t
> > > in vm_area_desc altogether and more broadly throughout the kernel.
> > >
> > > While we're here, we take the opportunity to replace VM_REMAP_FLAGS with
> > > VMA_REMAP_FLAGS, the vma_flags_t equivalent.
> > >
> > > No functional changes intended.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  drivers/char/mem.c       |  6 +++---
> > >  drivers/dax/device.c     | 10 +++++-----
> > >  fs/aio.c                 |  2 +-
> > >  fs/erofs/data.c          |  5 +++--
> > >  fs/ext4/file.c           |  4 ++--
> > >  fs/ntfs3/file.c          |  2 +-
> > >  fs/orangefs/file.c       |  4 ++--
> > >  fs/ramfs/file-nommu.c    |  2 +-
> > >  fs/resctrl/pseudo_lock.c |  2 +-
> > >  fs/romfs/mmap-nommu.c    |  2 +-
> > >  fs/xfs/xfs_file.c        |  4 ++--
> > >  fs/zonefs/file.c         |  3 ++-
> > >  include/linux/dax.h      |  4 ++--
> > >  include/linux/mm.h       | 24 +++++++++++++++++++-----
> > >  kernel/relay.c           |  2 +-
> > >  mm/memory.c              | 17 ++++++++---------
> > >  16 files changed, 54 insertions(+), 39 deletions(-)
> > >
> >
> > You missed one instance in !CONFIG_DAX:
>
> Yup of course I did... :/ the amount of testing I did here and yet there's
> always some straggler that even allmodconfig somehow doesn't expose.
>
> Let me gather up the cases first and I'll fix-patch.

BTW this is turning into a respin I'll send shortly :) as addressing other
feeedback and removing sparse makes fix-patches not viable unfortunately!

Cheers, Lorenzo

