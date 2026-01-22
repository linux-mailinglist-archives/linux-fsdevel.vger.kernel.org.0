Return-Path: <linux-fsdevel+bounces-75095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN/GA3NPcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:25:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAC69DF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB39830021EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092364DBD9F;
	Thu, 22 Jan 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdPy2H61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YzNBT84m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35693859D7;
	Thu, 22 Jan 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098101; cv=fail; b=Ggj7X03RnAY10EzgY3ZPd6Q5PpkKR2P1TFmCtHvT/Of03g2zt6YOoalwbQQjH/ymJyTdP4rYRAi6bg07a+n4Ybz9gVuvRqF8BpZ+mr1+/VQxKvVMP+S17gfE0b5RxMixfYYlCuuyy9w+lU5MexpLmcL7YR042rlQojN97fOSn+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098101; c=relaxed/simple;
	bh=Y5RRKsH/MybEHFnL+93UxqsQGkb+J7tp1DpqutAtzL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pJq6HyPVf2sNGkT1nKDl7P8F6eqUYnfhOige7yc8kae9fjZBI/wLwU4SCu6YwjFLaAo11UJJsJUGiv45Rfv0BTxFcVog6VpIXi7b9BlG4HtRnc2Y3eF6fPjV9Ooa5hfH0x8PCzqhb9KvDu5WDwOkPdU2iEJMu4OupD2odbwCN34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cdPy2H61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YzNBT84m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgN2H248898;
	Thu, 22 Jan 2026 16:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IxlAehEn2wCEaEAXCeMgbjxjG9wyjKPrxhsNi195/lM=; b=
	cdPy2H619caIG1G1C32buGlefQ97fVfH9JYKf66V3XAwRr35OmoSJuY/78JJhdbG
	EmWcARx3+GbuCHrSasuGW/dCdjdDXldDoRiK7F03k6l15IOw+yDMCl77fYSI0qeu
	hnwpnm54RBlbFjXzy25+6bGpJPEJAodtskrjBAjcnt8+6XMNbdginVkgS3uswqtw
	tfMu/dN6MsezbGvlBUy6ijiTR5JUoEW9Sv7voM3kConwm1ameZRIbm3Qu7CNdy9v
	9rgFFms+Zd9uQbc9etd8rAJclTOqlc3WrSygeoCUoOc5XP82f2QXi7R8ePxS5GUG
	bQwWFwRRogA0X4ehsDWv5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w000q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCR032257;
	Thu, 22 Jan 2026 16:06:55 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJyQAIxEJPUZ54tex0zC8xzvvxWMahDE7UmLKJngbvD0jSpeCkfPQubCqVYRNxn/k9kMlINDxPMGnGoPv/FhRSub1erhnH8VDjmEJTazVblx3Fo1fXTHqNVPRKEhc3apJY8SdraONkjydImlBF5bbOvVxXlyMH+meA2yygmuqp6RBeJwYvBmvObi6sGDey/yFNis0uU7xU/nnmvMJQK5+ENQwA1doUb0eOsZLbBaFTyIGbWJfEf6Irm8RRV1PYyPtV4VfHaIPBWV3//RH1b9rsURevr6ELK9biDQPTBj66rZDsm9/9gVBeNAWQwVbacEGmz2yOjsa0lK02Z225oCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxlAehEn2wCEaEAXCeMgbjxjG9wyjKPrxhsNi195/lM=;
 b=B+7+o2uH+Lwq/y1r69d/v7B2UMj9I2kFSv0N2CIC6doPq7KibxnRhBWbUbaMxMGu5h9/FFTVBfACXk8HzOPTVxUPjzaUYr4AtmZyROXma7E3bFAv8ID7ju3QmgOaGztXWM7F1HObMKdOd+4553OSqNf0jx41d/9jCjZAjS0N9bVa5r8prpCuY+9p1Xr7bi8Wy/eAihFpITLag6EKNwJB5Lvq1cHWBwuuptjUJP9lUBNKozQdK2yuCFWJFbGZ9chELNYwAV49HHVIbatMcExxtfqu256wKOGeDKc3qC8Ea+ikCv5NBHydqrmF76CahPAnfiKi1ET7BalADwiq2Ja9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxlAehEn2wCEaEAXCeMgbjxjG9wyjKPrxhsNi195/lM=;
 b=YzNBT84mcRGddIZdRl8c75DxNtlucooMwqLp/qxQNa/ZG/63NQVxaKDOAimn5ElUHkiU2yLGLzmmbsG96qH3i2tHsBIlNDT/Yg/1DFe0le654xADsWkKf4JvxGkhCzI4/4yMPpjanCU8S4nP9V7ak9/nez5Y2t0GAPgdCcXSjp8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:42 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:42 +0000
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
Subject: [PATCH v2 09/13] mm: update all remaining mmap_prepare users to use vma_flags_t
Date: Thu, 22 Jan 2026 16:06:18 +0000
Message-ID: <fb1f55323799f09fe6a36865b31550c9ec67c225.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c1a3da-897f-42f5-a187-08de59d03b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8p3/vGYy6qAAOpybnp0fjK2cLlT6q9FMkVXdm+GBtvLqzhQefn31doKd+SsZ?=
 =?us-ascii?Q?wxxR684gH0uc7CVwgcI5IRo5uqZZEW6g/hGSxeW6WgXHUIsREq/XHVxwittv?=
 =?us-ascii?Q?neYAXeAXf2a93hcGQ45/jgoN/wrFrC73pIWg+thXeyTNGpJYGvx3lsbyBCdV?=
 =?us-ascii?Q?BrB9OAXgIOVx9p53ojCeO/MZqQ4SHiRrJH+8WxiEcXdNbjViPLI30oyZ1JGK?=
 =?us-ascii?Q?F7uWEBnrRBtYIR9OFLE9SxU/2gp2Ix4HvQI/eNFL/WT2u7EA6llY/uu6sZPm?=
 =?us-ascii?Q?PEIWrdElzHFuKCWHlRgBbKrnCHqCKrQRYdEDzIbNQqWD2J0B6MTO139y4ZMG?=
 =?us-ascii?Q?txL7FcV69WiViD2SjGilqrsJTWGuZwlqw5eTiDx/u0Yw0E1g+c0NfEu8wfLp?=
 =?us-ascii?Q?Ff9blzH/0fSGZ2oRtSibNFYeEW9HOXFPc+/l5UsUHPD+HrY+bNkQq5zxeFkl?=
 =?us-ascii?Q?69IILxEIY+NuwfUYAukpDtNlk05x9z3DUiVROro6XjegTvtbGh6THeK7VUEH?=
 =?us-ascii?Q?edoIZ6RE5j58yj4lVdiTOaMQli6+hy+fJQms9x3eP/2GbISuhDyyEEJ0behG?=
 =?us-ascii?Q?lx/xD43H9H6Rh/z+1W7gaki5Luw776C93hL6JchREOjev+zrMPDTWeQUqfBv?=
 =?us-ascii?Q?YjKtFasYpLo1p2iT1EdrkjSw77oIon1SfdXNbGjzF2RR45/8IDm1vHOhpi0A?=
 =?us-ascii?Q?F9l5JLZ8CB0yL4ObHDYYjT5obhTo/LpKyTzxAIgqmbO3W6Z6UyEZvWSPxqt4?=
 =?us-ascii?Q?0r9Jye+coWjU9SDLJacrlg+lClWjGboHtsT5lnuUPqpIOktaUthjeoOMBcei?=
 =?us-ascii?Q?kbO7cABGUcezdaEYc+/eLtM8pr6L4SuUpgJwV5BW6yc382x7Zyr+2SzCoP+m?=
 =?us-ascii?Q?fp8KVdPWInv57DkpcU9m3iwv7zzksSCoo7VK9snaStqR8HUHKbpqVQnTLO9i?=
 =?us-ascii?Q?tBsG//Jxhcj8caQOci0TMEJGXnTcfBILcqiKZT01kxPSBqpoIiQvcDdLggxb?=
 =?us-ascii?Q?Wokf4G73Q/89dshxx2scD8uuemzV76fEv3H7aVcgUpIWfNU4maHfNOJzwQS5?=
 =?us-ascii?Q?XjY77wIfN+lq+8IpBdmK9piP8TYPhHumUyM5xa3bu60wFHHYSYrn2wslGWU6?=
 =?us-ascii?Q?pYGsivqLb6w+yKwoy7O+TYG2x+RlLxvnf4hDdKXk1eE8dF5OxtHBLB0MXP7V?=
 =?us-ascii?Q?KfL1xGlfsuIxALwfPaY3VDyxi7aO3Q6s2MUov0XGajdMT3ei7YMhpFmelC2K?=
 =?us-ascii?Q?iPLiOCDdDH9BYbLYJ/6dpyJ07rKUyzfIacdYEzQyvQCPRSPTafbgM4Nc+Y6A?=
 =?us-ascii?Q?A45ltjbXq51+lzFUyivVVW9glUto6RDaTuVcQPM157QxsMPhBJdbjx8C5vwE?=
 =?us-ascii?Q?UT2pD66JP8GfsPzqY2IGWPQ7/JzSzBsIw7wmDOuekfK75he4R7fzFAm8H32I?=
 =?us-ascii?Q?CO8dcgrPbPtrOZNq/9qFMxL4c82x1T5DjSbiLhy1NilUtja4uxXV83nG6Qnb?=
 =?us-ascii?Q?182yIKPa3OVwU1rNy6BPs3M9NXBj+co89dx8BwR+dDJjN2kJOX89rs1OHa6w?=
 =?us-ascii?Q?A0/B59dhsQTLfVqVIS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6GTV1knkT8GyZ6VKDBIDR+DDWJXjtOrSar6wKhMH3LXYBQd2/LJNaOWg9/F?=
 =?us-ascii?Q?jHqfQ9pUk3iO841fIjJEiWfsQCwNmM4IClXsPEwzepPr7LqBLaCCjK4YepSO?=
 =?us-ascii?Q?GWAAJ2sLRd5dda1eq7D149NskqUh69BrwljIqkAg9YwTaaYnTYpOOQDPHd21?=
 =?us-ascii?Q?vUCMviiV3XPDwbqUDQTrSIA/RZE8Mr4h6IzSZPGh0hZNbcCuUVzhurTWrkN+?=
 =?us-ascii?Q?EqpHa0qtpoQAnRTY4erD3vzsnWEFIx9ZK81Sicd7ylzbAV3vVz8xLZ/lR5LJ?=
 =?us-ascii?Q?OrHrrtMNWcmBz/L9NcRM3k4r7c6NNwM3b7VqFzgwGirJdz+UXcd+ecsibL9E?=
 =?us-ascii?Q?qGIRmTz+f5+V/gffmubrVKdOHHuxwqumsJ26P55Im3x3aIsUZikTQmU/95sM?=
 =?us-ascii?Q?WSaYazmULTZsqmc8bPTza3MImpvH6gA5YQyY6VRejFlImd71Fg5QzUAsw8xG?=
 =?us-ascii?Q?KfVClPbGW02oPDEwdAoLkR4npJNXBhStp3/zeL0oXcNVweaIzY7ytAW0we2V?=
 =?us-ascii?Q?ftLdiOk1cGTfEiEjhErgbIkQ/iNaMIDxp7cz4n8krdIcjOe6vA5YY8i5gYTi?=
 =?us-ascii?Q?91GudeVa3EPDzce5JvfFbceOMZY/EF9VHwqckgDI2VcLMTxUdzKexDKYRhiC?=
 =?us-ascii?Q?suy8l7F2rasTFA33r4CAfY70fkMeRWRtYJ8CteUHVqbFvt9rUF5MFUA+12Lo?=
 =?us-ascii?Q?hZD1SUsRs4WPhxWDu61nKiv00FR4toDX3ltTzsBCl+yAKpA2oq+VwETY4lAF?=
 =?us-ascii?Q?a7T4S+i+V2EVktkC6xqynPGMxMh28iP6yAksQhdAPGoNVliuh6sPylmAwa9A?=
 =?us-ascii?Q?Pv0q2sek8j+9uPn3oO+szjzDpKnJRvawCXkbzDP3qEI5HeJQP18oDLFeqUtZ?=
 =?us-ascii?Q?sk5BSIZnnkKA79k8dwzyd0M71TdyXhSIRbFocv6Bnn8cDVtDXKhw1X6YxmJn?=
 =?us-ascii?Q?KO5FIdvHcF7d3erdY4WzCD0JZx6CnI+yJINX/hKb87748OyVxFvhrhm9xetd?=
 =?us-ascii?Q?wWHBNJ1rBj4AkTqzYA6aDfOkce263S1rT3bc0/JYJbLkAELjKoVp8LtNwCTy?=
 =?us-ascii?Q?+giSW7rTX5Suo8bjpB/vidv+wDwYDQMv8S96RCk8grtk1AaCYdLotjCVzxeZ?=
 =?us-ascii?Q?rRn2yIKRkaYiM6MpD7QUbBIb2ZAsF/T5vc3kvCpsTl+EPYRyF+esStSdK8Eh?=
 =?us-ascii?Q?wvdN5n4LuUHvjVNpYCyrBP/rqUcSblZ5x2EYrk7EXT/CukauujjmjNomEyS8?=
 =?us-ascii?Q?i88idr4rFzOVxKZ4frzGe01LUNTfllLtmzxhKYCH1Bb/AUP+L0YFO9eeXbUv?=
 =?us-ascii?Q?DbdqWEFPlbMgduGYF/61BQ/4mVMxsfpHnuQL16PNePQyJgj6rQBt1IZGDW8C?=
 =?us-ascii?Q?L9UWqD02PunVvKIbpHaQUJcm4ewR+LSc+ntHTNIUQ7vWudk+onVLlTYnstqd?=
 =?us-ascii?Q?wp/7JlXgKjEwiwsKMqX0c0pgcyUgS6CVyM9z9v8h5PCK7LhME0QVce3Bqlkb?=
 =?us-ascii?Q?ofVYtISXWFc3tsTgzDjqbla/Q9PXhWJ+e/QHfMUq/kCSy5dN9q/Plocakujo?=
 =?us-ascii?Q?ZuZZ4QTF0dbNHuvyAz2v3YCaTWnq/L7eF08FxiYA1xHV6iOtHWYBFD07o0Gf?=
 =?us-ascii?Q?COdFXIg94Vs+hfQ1+kJ5hBvRBTMshWr5cHDIV5R9k9RDS8CvqVSgr30CWYqP?=
 =?us-ascii?Q?x9XlBzVawkyQRrMkJlC10TFN5PjTv8fHykKIyU6vShZfI7pJS90oD65gu3mE?=
 =?us-ascii?Q?UjklQnsSRXJyOiOYBi8RCrOfLEXrNOQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	19nPEAIPSAxstl009/qwHfJT9NOn60U+5qQOonfb3WjH6uFWp/TiKycj+vUmY6lSuWH1fYU7OfKXJlcW9KmJ/FBXD+N6ZG1oZeRqVXQ+SICQ+CbZDjpzW1gDpEjpy/eTF43P/UAkBqu1U4hNjsxTtfnHNrxM5oK3KzaO1fS01aD8+APvnEhRetC/diWc8XFBVJCfNuIzjtf0yuIl5MNrzzKW1P35+nXhFTZiy6m1nmCj9jcqzATqVMeGFT3pUKo1c7A9p3M/pnXFGskOToNps1g6Gp5EiOytLy9nIaoiFJ+njbTngf691GSXiiCdCuaasBJTRLTCJxq7ACtlVDnOhkNJ8+feqU/b08C7E48UOqJdpJ1tuGYKCczOeq89YihEp62CWQYDztQCECinegyyvsOEfZOC5LcUgkviwX1+z50S03Sn2E21k+mZ1eym8d/O0QejgLZLxf6posNkXya747lLZnfrros8ftKQdf0A8Is0hp9TMXpOQicMFBMzBbHSvZgUxiRxNtVm6ENgTPEckrkfHs4fNv/94b8E4J/JHGpRFxlQfdsi45wcLVJJLUUsBX2v0mZWULGebug0CkG1gV6JawXpPOVtKYCSA6QWmgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c1a3da-897f-42f5-a187-08de59d03b9c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:42.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tit1tkfHDWAdAO3iAWtx0NMxZYShjqvJv1+vU6UNfA8mILyz0SI7io51+G1r5VF3LeMPz1J0YsAIdwfC/6lHNJbQcZ1F9IyHgq8fBlUMAmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69724b20 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Y41x4OjG33KyMScx15sA:9 cc=ntf awl=host:13644
X-Proofpoint-GUID: bLSPJaftRcRXEEyDWxlo3ssWmCXCOdiQ
X-Proofpoint-ORIG-GUID: bLSPJaftRcRXEEyDWxlo3ssWmCXCOdiQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX3r2Uc64WVWjm
 pBqssOtWZRECk2H/3eVzOSFkT51cz/GTJEkrc2n1pwptMoeYDR/+NN9SyJsEyddQCedoFgS4WS5
 I1m6zO9e1HSZI3a2B92OIYfbESi9NCy9TAoMLvyuW4ztgRNnBXYlyvEWK+yUDtVg/TMEUU22fnk
 JoZIxPkSbCWe4kTvyrkH/3Fc/5pJM2qBUDt+oR6CqgY1txNa+dk5IDvrf/AiFqz/RcLsaDP+vz2
 QgWHKqnGqqqEsDYR5hvypQP8ywCc47L8flqk59uJX1x2w27dmoVJbkuviQ3uyCBsNe6sZewScHP
 XH6WbNj+ex1xJepILx2UDbLOZETabv6PCT39IJpW3dWwTBt+Cw0S5Xcrve3PWN+6cDmoly4Ekyu
 6B6Knn81fT6lucPLWb50qmt0QksZGlKeM7rOUQkwO/eRmq9qArbQHjzQXubzSv21nMH1ZaoCnBV
 vWsguQxfhMXxxQosE813eYdMjIoAKgtsSO6oRSHc=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75095-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8FFAC69DF8
X-Rspamd-Action: no action

We will be shortly removing the vm_flags_t field from vm_area_desc so we
need to update all mmap_prepare users to only use the dessc->vma_flags
field.

This patch achieves that and makes all ancillary changes required to make
this possible.

This lays the groundwork for future work to eliminate the use of vm_flags_t
in vm_area_desc altogether and more broadly throughout the kernel.

While we're here, we take the opportunity to replace VM_REMAP_FLAGS with
VMA_REMAP_FLAGS, the vma_flags_t equivalent.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/char/mem.c       |  6 +++---
 drivers/dax/device.c     | 10 +++++-----
 fs/aio.c                 |  2 +-
 fs/erofs/data.c          |  5 +++--
 fs/ext4/file.c           |  4 ++--
 fs/ntfs3/file.c          |  2 +-
 fs/orangefs/file.c       |  4 ++--
 fs/ramfs/file-nommu.c    |  2 +-
 fs/resctrl/pseudo_lock.c |  2 +-
 fs/romfs/mmap-nommu.c    |  2 +-
 fs/xfs/xfs_file.c        |  4 ++--
 fs/zonefs/file.c         |  3 ++-
 include/linux/dax.h      |  8 ++++----
 include/linux/mm.h       | 24 +++++++++++++++++++-----
 kernel/relay.c           |  2 +-
 mm/memory.c              | 17 ++++++++---------
 16 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 52039fae1594..cca4529431f8 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -306,7 +306,7 @@ static unsigned zero_mmap_capabilities(struct file *file)
 /* can't do an in-place private mapping if there's no MMU */
 static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(desc->vm_flags);
+	return is_nommu_shared_vma_flags(&desc->vma_flags);
 }
 #else
 
@@ -360,7 +360,7 @@ static int mmap_mem_prepare(struct vm_area_desc *desc)
 
 	desc->vm_ops = &mmap_mem_ops;
 
-	/* Remap-pfn-range will mark the range VM_IO. */
+	/* Remap-pfn-range will mark the range with the I/O flag. */
 	mmap_action_remap_full(desc, desc->pgoff);
 	/* We filter remap errors to -EAGAIN. */
 	desc->action.error_hook = mmap_filter_error;
@@ -520,7 +520,7 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (desc->vm_flags & VM_SHARED)
+	if (vma_desc_test_flags(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
 	desc->action.success_hook = mmap_zero_private_success;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 22999a402e02..528e81240c4d 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,7 +13,7 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+static int __check_vma(struct dev_dax *dev_dax, vma_flags_t flags,
 		       unsigned long start, unsigned long end, struct file *file,
 		       const char *func)
 {
@@ -24,7 +24,7 @@ static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if (!vma_flags_test(&flags, VMA_MAYSHARE_BIT)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -53,7 +53,7 @@ static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		     const char *func)
 {
-	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+	return __check_vma(dev_dax, vma->flags, vma->vm_start, vma->vm_end,
 			   vma->vm_file, func);
 }
 
@@ -306,14 +306,14 @@ static int dax_mmap_prepare(struct vm_area_desc *desc)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+	rc = __check_vma(dev_dax, desc->vma_flags, desc->start, desc->end, filp,
 			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
 
 	desc->vm_ops = &dax_vm_ops;
-	desc->vm_flags |= VM_HUGEPAGE;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 
diff --git a/fs/aio.c b/fs/aio.c
index 0a23a8c0717f..59b67b8da1b2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -394,7 +394,7 @@ static const struct vm_operations_struct aio_ring_vm_ops = {
 
 static int aio_ring_mmap_prepare(struct vm_area_desc *desc)
 {
-	desc->vm_flags |= VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
 	desc->vm_ops = &aio_ring_vm_ops;
 	return 0;
 }
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb8455..e7bc29e764c6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -438,11 +438,12 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
 	if (!IS_DAX(file_inode(desc->file)))
 		return generic_file_readonly_mmap_prepare(desc);
 
-	if ((desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
+	if (vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	desc->vm_ops = &erofs_dax_vm_ops;
-	desc->vm_flags |= VM_HUGEPAGE;
+	vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 #else
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b30932189..dfd5f4fe1647 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -822,13 +822,13 @@ static int ext4_file_mmap_prepare(struct vm_area_desc *desc)
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file), dax_dev))
+	if (!daxdev_mapping_supported(desc, file_inode(file), dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		desc->vm_ops = &ext4_dax_vm_ops;
-		desc->vm_flags |= VM_HUGEPAGE;
+		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	} else {
 		desc->vm_ops = &ext4_file_vm_ops;
 	}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe..2902fc6d9a85 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -347,7 +347,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct inode *inode = file_inode(file);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 from = ((u64)desc->pgoff << PAGE_SHIFT);
-	bool rw = desc->vm_flags & VM_WRITE;
+	const bool rw = vma_desc_test_flags(desc, VMA_WRITE_BIT);
 	int err;
 
 	/* Avoid any operation if inode is bad. */
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 919f99b16834..c75aa3f419b1 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -411,8 +411,8 @@ static int orangefs_file_mmap_prepare(struct vm_area_desc *desc)
 		     "orangefs_file_mmap: called on %pD\n", file);
 
 	/* set the sequential readahead hint */
-	desc->vm_flags |= VM_SEQ_READ;
-	desc->vm_flags &= ~VM_RAND_READ;
+	vma_desc_set_flags(desc, VMA_SEQ_READ_BIT);
+	vma_desc_clear_flags(desc, VMA_RAND_READ_BIT);
 
 	file_accessed(file);
 	desc->vm_ops = &orangefs_file_vm_ops;
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 77b8ca2757e0..0f8e838ece07 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -264,7 +264,7 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
  */
 static int ramfs_nommu_mmap_prepare(struct vm_area_desc *desc)
 {
-	if (!is_nommu_shared_mapping(desc->vm_flags))
+	if (!is_nommu_shared_vma_flags(&desc->vma_flags))
 		return -ENOSYS;
 
 	file_accessed(desc->file);
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 0bfc13c5b96d..e81d71abfe54 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -1044,7 +1044,7 @@ static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!(desc->vm_flags & VM_SHARED)) {
+	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
diff --git a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
index 4b77c6dc4418..7c3a1a7fecee 100644
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -63,7 +63,7 @@ static unsigned long romfs_get_unmapped_area(struct file *file,
  */
 static int romfs_mmap_prepare(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(desc->vm_flags) ? 0 : -ENOSYS;
+	return is_nommu_shared_vma_flags(&desc->vma_flags) ? 0 : -ENOSYS;
 }
 
 static unsigned romfs_mmap_capabilities(struct file *file)
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745af3..1238ec018bc7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1974,14 +1974,14 @@ xfs_file_mmap_prepare(
 	 * We don't support synchronous mappings for non-DAX files and
 	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!daxdev_mapping_supported(desc->vm_flags, file_inode(file),
+	if (!daxdev_mapping_supported(desc, file_inode(file),
 				      target->bt_daxdev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
 	desc->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(inode))
-		desc->vm_flags |= VM_HUGEPAGE;
+		vma_desc_set_flags(desc, VMA_HUGEPAGE_BIT);
 	return 0;
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index c1e5e30e90a0..8a7161fc49e5 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -333,7 +333,8 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * ordering between msync() and page cache writeback.
 	 */
 	if (zonefs_inode_is_seq(file_inode(file)) &&
-	    (desc->vm_flags & VM_SHARED) && (desc->vm_flags & VM_MAYWRITE))
+	    vma_desc_test_flags(desc, VMA_SHARED_BIT) &&
+	    vma_desc_test_flags(desc, VMA_MAYWRITE_BIT))
 		return -EINVAL;
 
 	file_accessed(file);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d624f4d9df6..bf103f317cac 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -65,11 +65,11 @@ size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
-static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
+static inline bool daxdev_mapping_supported(const struct vm_area_desc *desc,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	if (!(vm_flags & VM_SYNC))
+	if (!vma_desc_test_flags(desc, VMA_SYNC_BIT))
 		return true;
 	if (!IS_DAX(inode))
 		return false;
@@ -111,11 +111,11 @@ static inline void set_dax_nomc(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
-static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
+static inline bool daxdev_mapping_supported(const struct vm_area_desc *desc,
 					    const struct inode *inode,
 					    struct dax_device *dax_dev)
 {
-	return !(vm_flags & VM_SYNC);
+	return !vma_desc_test_flags(desc, VMA_SYNC_BIT);
 }
 static inline size_t dax_recovery_write(struct dax_device *dax_dev,
 		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fd93317193e0..e31f72a021ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -550,17 +550,18 @@ enum {
 /*
  * Physically remapped pages are special. Tell the
  * rest of the world about it:
- *   VM_IO tells people not to look at these pages
+ *   IO tells people not to look at these pages
  *	(accesses can have side effects).
- *   VM_PFNMAP tells the core MM that the base pages are just
+ *   PFNMAP tells the core MM that the base pages are just
  *	raw PFN mappings, and do not have a "struct page" associated
  *	with them.
- *   VM_DONTEXPAND
+ *   DONTEXPAND
  *      Disable vma merging and expanding with mremap().
- *   VM_DONTDUMP
+ *   DONTDUMP
  *      Omit vma from core dump, even when VM_IO turned off.
  */
-#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
+#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,	\
+				     VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)
 
 /* This mask prevents VMA from being scanned with khugepaged */
 #define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
@@ -1925,6 +1926,14 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 }
 
+static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
+{
+	const vma_flags_t *flags = &desc->vma_flags;
+
+	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
+		!vma_flags_test(flags, VMA_SHARED_BIT);
+}
+
 #ifndef CONFIG_MMU
 static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 {
@@ -1938,6 +1947,11 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 	 */
 	return flags & (VM_MAYSHARE | VM_MAYOVERLAY);
 }
+
+static inline bool is_nommu_shared_vma_flags(const vma_flags_t *flags)
+{
+	return vma_flags_test(flags, VMA_MAYSHARE_BIT, VMA_MAYOVERLAY_BIT);
+}
 #endif
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
diff --git a/kernel/relay.c b/kernel/relay.c
index e36f6b926f7f..1c8e88259df0 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -92,7 +92,7 @@ static int relay_mmap_prepare_buf(struct rchan_buf *buf,
 		return -EINVAL;
 
 	desc->vm_ops = &relay_file_mmap_ops;
-	desc->vm_flags |= VM_DONTEXPAND;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
 	desc->private_data = buf;
 
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 3852075ea62d..ad78cb7e64ec 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2955,7 +2955,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
+static int get_remap_pgoff(bool is_cow, unsigned long addr,
 		unsigned long end, unsigned long vm_start, unsigned long vm_end,
 		unsigned long pfn, pgoff_t *vm_pgoff_p)
 {
@@ -2965,7 +2965,7 @@ static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
 	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
 	 * See vm_normal_page() for details.
 	 */
-	if (is_cow_mapping(vm_flags)) {
+	if (is_cow) {
 		if (addr != vm_start || end != vm_end)
 			return -EINVAL;
 		*vm_pgoff_p = pfn;
@@ -2986,7 +2986,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
+	VM_WARN_ON_ONCE(!vma_test_all_flags_mask(vma, VMA_REMAP_FLAGS));
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -3110,9 +3110,9 @@ void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
 	 * check it again on complete and will fail there if specified addr is
 	 * invalid.
 	 */
-	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+	get_remap_pgoff(vma_desc_is_cow_mapping(desc), desc->start, desc->end,
 			desc->start, desc->end, pfn, &desc->pgoff);
-	desc->vm_flags |= VM_REMAP_FLAGS;
+	vma_desc_set_flags_mask(desc, VMA_REMAP_FLAGS);
 }
 
 static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long addr,
@@ -3121,13 +3121,12 @@ static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long
 	unsigned long end = addr + PAGE_ALIGN(size);
 	int err;
 
-	err = get_remap_pgoff(vma->vm_flags, addr, end,
-			      vma->vm_start, vma->vm_end,
-			      pfn, &vma->vm_pgoff);
+	err = get_remap_pgoff(is_cow_mapping(vma->vm_flags), addr, end,
+			      vma->vm_start, vma->vm_end, pfn, &vma->vm_pgoff);
 	if (err)
 		return err;
 
-	vm_flags_set(vma, VM_REMAP_FLAGS);
+	vma_set_flags_mask(vma, VMA_REMAP_FLAGS);
 	return 0;
 }
 
-- 
2.52.0


