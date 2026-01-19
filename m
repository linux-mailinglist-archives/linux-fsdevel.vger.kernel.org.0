Return-Path: <linux-fsdevel+bounces-74450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96249D3AD36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D58E030066F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6238E5F7;
	Mon, 19 Jan 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kNrCNHnk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k+LtENzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05EC38BDB5;
	Mon, 19 Jan 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834366; cv=fail; b=D5qHzk1+jX1xzRO/A2R4hf2KCIsGvP6HAfi0yZWv18kbwCfUonk4P2XYwa7RU7d8FN2UhHamEaRf6px3iLZ7qWbKr73HxKW2x0Em4wFl8OR2OYBVufpPWnZ/rNPxrHUGzEW4vgTR/wOh4WoFwn8O9da7Y+VwgDj5PbHd7uA6ueU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834366; c=relaxed/simple;
	bh=Zfgluc7NIZDFJIlEWDlcpPGKAmYuZ7O8T8mLUWKGz00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ioWScKMTaGJuUvV277wkdxPRVlVt+8nKlbtxhqf1Eb4nAgOjkxsjx3rixtxTj8WpC3pBPEbYPsTNmlidoSBp3103DJCYNuijM+iiZAzyfTbULCd9eJdVwAgT1CND/L1Nbq1ztpt23N/vcWjNEz5eaINydv1VmVobQK09X5Retlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kNrCNHnk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k+LtENzm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDY1E1269595;
	Mon, 19 Jan 2026 14:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=stx4bPgAkRjIHLZq2EEVcJqSX0Sfg6Yeujz3eRNL8fM=; b=
	kNrCNHnkxxNlDSrF+nAmxrgdc0n2CBgiHVuZfnUCa4/CDPZsExRQwNgaH5J8R+zt
	zmHvjCemRkLuW3kvFsYFi5rafLZEv9PRrSzbq+Q5+vJYAbB+vejEyZLLgcLpoh8n
	u6kFcEW4ckpqHciRWam+KtgznwEBTPtucBVM9aoMMRTbQ+z+EIeQhlRClJ4Lpra0
	E1QPvcYRM9f6z7Tk2qK+mUqjgoMNDsVBQM077yCv30yUjsTwoaAlJUsi3+I4bQlZ
	tiWsS/rAYYefM6cZJmib4eBTr7VVA85eK8FDtIfmITTC2vYGezdE9uYGbEBZNUcm
	F6+yO7YUOARGcuVrMjuenw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8ad38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JEJdaF039386;
	Mon, 19 Jan 2026 14:51:48 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8f6xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 14:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMhTST05NA+3rdZmR21iZ1uSPj3wYsjukl2d+7ksqU8zFFycURH77/b1ocPJYLiFoB4lu6+qwB3HyiUy8o5LBYssF9DPAHQB3CzGln7J9cRUzMN0pAMhn/lsnSRer5dWOO3xkiVM5IF5eoMJGZeGdGSvOwexHA5SXdxHl0UfRw5jbYpRfCBhLkB0y0kkGBdoRCdr2klw9gZe0vX9+m9mf1iiVPvVPri2GWn8nIdcjOarNQmKwLJQWTiuwAY0zFAjqR3/D388EMDZR5HcNH/lmXzeMOoATlKLgQcRPGZnizsx/m9Tqf0vrgXlUlkfhJM77mGipWHyG26s5j5kGQokzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stx4bPgAkRjIHLZq2EEVcJqSX0Sfg6Yeujz3eRNL8fM=;
 b=kxiMnsNJMM3VHSh6denyOzllOmsa0ZoIQmxUgRPXV9nclp3870K3jkdBiHLEgOvUPdVu8ygjYrrBMk1onDj0/vsbo7zrhjS1aFMfA/dIUUdTtUm9GB5GQI4GRYbd8CEN6nyjIOSqLx70hQbUWeYkNHqgfHamjs8GIMax9xQLItP6Ui4Wibdb6WdnGfkV5YVTTKsld9FyfRkS6sNdjX37fULIGi6Ll5Xv7OMD3TRHLgfrAXOHDpzZlf7YoBS9F11ZYnnFxHDkzqpicaq6dHwX6XcpmOQFgEIyJTI5nc7EjpZlEcCyrJHE/J7wFvtphYigtiyFeWRZVa+F6jksi5XFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stx4bPgAkRjIHLZq2EEVcJqSX0Sfg6Yeujz3eRNL8fM=;
 b=k+LtENzmsQzOHZazu+1Sfh/GDMkE81dpbqTQKqYGp0/QYopitcMiKiCy6McAmMhZDAtk3Y7AWyNKsEIyXCociDg65tSM3xO+zlwQtsE+5yoNrrDTVViqoLZEb5Hl6taaISxCQ4gt72ZoIyPJq4kDsosbSoMTo9D7RMLBX8UEtD4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH0PR10MB7483.namprd10.prod.outlook.com (2603:10b6:610:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:51:42 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 14:51:42 +0000
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
Subject: [PATCH 07/12] mm: update shmem_[kernel]_file_*() functions to use vma_flags_t
Date: Mon, 19 Jan 2026 14:48:58 +0000
Message-ID: <678490aa78664f42d0fbd1a31311f261e74002bc.1768834061.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
References: <cover.1768834061.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdb9650-b455-4267-386d-08de576a4236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y92ACtPEVBgypM24bpMl5EROdvEcseUdT+5ZJy2udGYCshgSTGAnU+lJvqy7?=
 =?us-ascii?Q?ZBQeGc2dI0BBdtoZMii3KuaDnUSf14g+8wPFBPaLPp0+N2Txihr8A+MIPP3R?=
 =?us-ascii?Q?BQqzxgSv+c2cvir+Kx8lkfddS1rIifOdSejYtolXbFkhB/pGGy4t3e4yA5hD?=
 =?us-ascii?Q?+yqHuyfmxwyDNzeb5Y/mqdomAXPcUJAHNQKm959OcAD1YqiW42uqB7elDYQw?=
 =?us-ascii?Q?tiWLUMVEyTz3pZyC+TIl08QH9zLq2i8uf79Ut3gEv0gkjeCy9s9ozFRMiuGK?=
 =?us-ascii?Q?oqnTasVj6gHbKRkPVBqYB3rzrOoA6WL3U+rIiKjb2kYjOnTMiK6CkJxTZLhM?=
 =?us-ascii?Q?vOWpWkTyhjdXImHmDUYbB7rf3cVUzCiw8XeX6rKj2qVBMdc3KuxvVqMliqbo?=
 =?us-ascii?Q?3plHeBQTzcCKsAP5a1F8ZSiJzyjPEu4Vd1GNPVM/BIxY2fMfmF2hdrbqEarl?=
 =?us-ascii?Q?IYZsjsW+rMWm1xa7lIQCrX45SEZh7dl2Aqmd6Mjj5CbDg/rHpPka1iumr/3w?=
 =?us-ascii?Q?W7z/GAki21ytFrqDmPgNURdsQ9R4KgWlDJlWoUZomNE9DOrPJJp8PH54K0me?=
 =?us-ascii?Q?qdHkIluhycrGnIzudCprpOq58CXDj5bKG4hIP96nVLW6Hr1vp7/Jf10Lyd9/?=
 =?us-ascii?Q?IzCG+baOoNHPRVlKhyuhSEUxWKnwon2UtyZ4eqkIeyacwc9iBBRwQD1/p+u8?=
 =?us-ascii?Q?gJoNZ8INB6o88mcXX/QVwl91j1Kfq2OEOWoXeJzxNJ/uX/27+NIRV5GfAhby?=
 =?us-ascii?Q?KyeQC0u+8IbhDj4nzqlamyfwBrj6XifGg2PVnAYObX/V9IJrWM/yrXLsmGNe?=
 =?us-ascii?Q?e32NXRHK2EbamEhvYpWjpw1VDWfWHRSuVSofGfW2Oip4pv8QwbOsulgFS8Cu?=
 =?us-ascii?Q?QJ/Wolm6x5lv5SHBFE5XgN4lB5pjlSZ/sWrSGg48k6GeeDXdTCIwZCaBo5B5?=
 =?us-ascii?Q?hAaW9AYtergogULKx51ApnQD78pBgyFF5BLzT59l+f/zh/8XppCTTGFawXNI?=
 =?us-ascii?Q?kyyFMSREcjSYPzq3nLNOu5NvV3hRudKO1rdMKmFeaOlsF5NdgpI/fxo3CWJm?=
 =?us-ascii?Q?YADZ3OZENEHLm4BasO0swxLYdSb8teuCKrS6pXhgqvnDbgLxkZWu8QqrBBW6?=
 =?us-ascii?Q?QBR6tclJqZcKdtadreS/7P7BoZydrL3hL9raSmj2J+wGAdUT1SoT7ZwN16H/?=
 =?us-ascii?Q?GehzIlhzSz01y0/cmFGeGpbqaVgq2kypBvfpzlBXyWaIBZJU+csznlPxmHaK?=
 =?us-ascii?Q?b07+PLo/fafEj2CKtl8oz+g9R93c0XnFWrcyNHbZpg3nLxJXjGC1HGLnM+Eg?=
 =?us-ascii?Q?i7hp8LzzTBbe0IvuBXv+uI2wiYTJoV56a42xQNfxqxkMxYOtZu2l/1to5y44?=
 =?us-ascii?Q?CNPmOsSyNuih2qaNZc7eTwuvcDwxDjecglbm/6sjfSnBVFYZiByQBBxqhBqF?=
 =?us-ascii?Q?hDMYCyKq/iI3xTrCh7ehfboOO6SrYe3s/ZhSi2VHifE5034c/6Ym9yosqSDA?=
 =?us-ascii?Q?LwTbNfB67YTA5nbb0nEfqj5gDRmBUnJTiKBWR2iWpl5+Vfqj7ReFBBoRhfpo?=
 =?us-ascii?Q?c7SS05Ek186u6b3WL5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFMy+dyY3202W1lscQ31TPxkSF+eC2yYY5MUGJGrgbzaaScOjk2A+njHu9Ez?=
 =?us-ascii?Q?GAVs8r5LoebgIoiGgMfslqs48gmnyjOgPUQ9V6fDI0jg5TzaQE7YmhIZ7bK5?=
 =?us-ascii?Q?Rs0t2vKrOS0X01ut17oYX17fnEa3PIUNQBmZiRWeg17z0i5dFTJLKHKqPeA/?=
 =?us-ascii?Q?BB6FqxUK6sryUQ85rsnXvv08Pdk7ZvF4QpUZv9oxbe3Kg9GEIlF4C6LXR5WC?=
 =?us-ascii?Q?hGFDGnYkc65l6fl0vwv9hMUK+VfIjPZs/WyruhE1yfpWBTcCOWffgvVd7ohr?=
 =?us-ascii?Q?6+FXr+AiCMNRg3GsLynQoOHFObuk2m2ky8W7YrjOuScY5FPmoKGGk9FAsk37?=
 =?us-ascii?Q?MPVIiVV1MxGfexLZDOivhV0Ev3RdVFNdNBF6sm9jcCy37KReRXc4HDj+etRM?=
 =?us-ascii?Q?lldaSiuz9BlD716Bm8g8QoVBViYQBUKFsYgNIH2LNkp2kpDniC0b6wTC5Pyp?=
 =?us-ascii?Q?zJdTUE6G1Gb9FQsgFWxbDsPwSJIG2BDPQ+Kn1aVbtaChWwHKei/H3e9YNi7e?=
 =?us-ascii?Q?Y2hlNoL36TqR9yJnzX+jJCsuajExK4ruR8pSV5Cz7GRW7i4AJXOALFQY5WtL?=
 =?us-ascii?Q?8dW71Sjxurh7oHRPvrX+2QEK5qIdQIRyDnWJF8+acfl/aVXsHQSEEF1TbPDN?=
 =?us-ascii?Q?aRAgysJqBO6k4IkylDAUDtDhgVTXicQ1lnN6hbLJcbagFFkTSYEmuAvXap6+?=
 =?us-ascii?Q?TzmwiaWw3wAb6JNyyDesBzyNI8DJF2Q9PDJOTzbRxQKS90RR3XYm+TrfCXf0?=
 =?us-ascii?Q?GlStjgx2S7M9Q6nu5GHTUrWTni959OGXpnXQ/pvDnuNsa2/oWFdymkztszvC?=
 =?us-ascii?Q?3Vg3xMUYpmjt2H0dgqlAg29hLagtnT14skBfO3D+AE0J7x5nOGL1FnD2Lzni?=
 =?us-ascii?Q?7jBcwCZ3BtRtPbTHnlNEB/Xb022AoPs6rkxMR0deMWV+HKVLBODLiZ4r60oF?=
 =?us-ascii?Q?n27l/gNVOxw0uBurcJWPg1nwtfQAdReYTbJWnrKQqV86Flokqm7jR7BoOmH0?=
 =?us-ascii?Q?3awaBB5LB8HvMz8vdyfnYndV5FubO2hXV/1W71WhH8gFIaCJbAQ74IvsO2Q7?=
 =?us-ascii?Q?xu5txHmJ6E4XB3thJwWl+TCgC6QE00zZWndoKm1X9Srk/EfqRBrzNHaurJYA?=
 =?us-ascii?Q?XUsY/sE6/ArtCwQSilyKt83G7QjbwfLkDwk7j4qrnTmi1zHpC18QEQHTWpGT?=
 =?us-ascii?Q?TNR9b3wzRKUXofIv9V0zwoujqfoBuhFN5i8q6YvsSBWTfTDNgY7i2buQ6KWI?=
 =?us-ascii?Q?MCZHaZZR3s8uwUCCWoIhRpWdzOx+am8iYtHJPPbPIxOInUhT0/5SHNdlIW2Q?=
 =?us-ascii?Q?VRxlQ60XF1fWYPaUNsrKaeq3Op19SufDuCLBv2rp+oyFRw/cg+5TCSq2cRXr?=
 =?us-ascii?Q?D95oaWh7+8vXF5TUWTy5GAAGYfDNGiUPVPgDkiFbecMYmPhMML/DmP7SkRG0?=
 =?us-ascii?Q?lN1qiwLy7drQvOBOrp2BSsaaXOdEQMOp8kq5jo5ofC49SoSkCkHBKEbqRQC/?=
 =?us-ascii?Q?izjLTDSJS4XyDR5exwy0F9dYuO4icFNV0QQJaXuvu6obWuVfjQ8M0zZUmUqS?=
 =?us-ascii?Q?3xnqJdvglTbNQiYkurv1q9KM88Fy/MkFhtfBn+Mgm92jbvIWT6nyJ+bNtNce?=
 =?us-ascii?Q?7MySDWIONdIUs1tL2PUSCEPmRkDQ4+4/JRiJce5jTpUP2srJG0FsDbbyPmOH?=
 =?us-ascii?Q?qSEbs0/GLS9pfNFN4s8vZXZyNaIUJVZ0v2py4v1/ivVT+0c8OdXT8EeZvBlM?=
 =?us-ascii?Q?2Kpjy3YZHNUivKU1+8zPeWJRMki7Yxo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QO7sg0bEW+qLWYp4ef/x5LB52oLa6ucz5Y/R0RuMSS1sLDlzQabD07iV0aTArkJSeFoLXWomkYvDgkq3I1hLb5m3w0bYvcFQHW/UvfNfujVur/J4y89TN9aLfcoXV2Jrgo5P3SlmKnIIGe334d5+yh0kGRIvsGvWxI6tUNt/zq+9S3uDeQPmKYZbEGbkB+8r6DUr7lOi0ZFpuiuTWLA49khFQHWjH82lg8hmRi7jC+Wuj5CtzrKTTdNP+KZMafXJaYxYMtkVND1XEh16uwiACY3tUHuN3jRLlB1dgkZ3md9NMnhEXJOE5YNVcSW8/tq969wMlXXgJl967hFXbYLwD6zCO/PIWSRRtpdjBNlCid5roWxzBw+Dgwlxipn7hwBoIUY7owmcNU0sX4Tz2bxZxhNRf6kY/i/E5YVmq3CFIr0IFWTx5Q7D5wAvafPizitdV1TzLWC1ovhQIz3HYPCCRWqX+pJQguFYeCX+uU7GEEkGLYBib1ABXIdAKBApkg2EelHI1T6d8Ye0S7k1dU+FXyhM3Fo5apJX90yfnAkPMJ6z0QfkHwkfcuGqJzv5QgDFM4WBqzpsAkYROkP6PqTYRjSUT5yAvKmoGduDu85cCgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdb9650-b455-4267-386d-08de576a4236
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:51:42.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5whmZ+FAtonzxUEtnMvD46XroT+xv9qKP8HCX/6ovTMONGbc6L1BZocpRIWdOsjX/S2OlpzXshjibAc2j/iqXpExDnQMCJGahvvTfPU5CVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190124
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=696e4505 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=CsHpCq1HcQMTMJSP404A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEyNCBTYWx0ZWRfX5h+i9l3mTNKm
 dJhd/S1ix07Tv7lktpDQehJ9A0bXAi5J8eUyEGaZ96Z7/PanFGD2qCDNgNSQMMeifKBpgOqQcQW
 in1MxjI60qvy4Dm9DlCL/yWfko/bYfHq6lnhSGokhNSDTtgwIGD0ZiFfAweQg2WRjdXTQvOpYtp
 Wt1KB3vqghGg0nxd6Nxk4qd+xo25AixFKDHnUM9x6bqMJy7NoLZsP3IkBET91WJBEfBsh+mmWlv
 Hyqzde/UvNVm9wgt8Fq7mysQE2fLZ8g4BFtcsItnGtHyNDpS35YHQ3RPnIN8zHU4Lf9cwqy0W3l
 cCN/2QsB5STRHA7VFkX+W8+HWCZB8+fprtkrwmH3SXrC5th7OxuqN+Re+52VEk5Dj1rClpGBzr1
 ANd93y4mj6/yO5TCCtKjITBU8yQGIhUfK48Rl7PrdaVlRzyJivKi8DshmW81iLHqhSqe6X9LfOU
 d5h5DUYn/VhtmUZX5Zw==
X-Proofpoint-ORIG-GUID: 68yASKHcv0c_LodhLG8ZiZ71i4Ge1tqM
X-Proofpoint-GUID: 68yASKHcv0c_LodhLG8ZiZ71i4Ge1tqM

In order to be able to use only vma_flags_t in vm_area_desc we must adjust
shmem file setup functions to operate in terms of vma_flags_t rather than
vm_flags_t.

This patch makes this change and updates all callers to use the new
functions.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
 drivers/gpu/drm/drm_gem.c                 |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
 drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
 drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
 drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
 fs/xfs/scrub/xfile.c                      |  3 +-
 fs/xfs/xfs_buf_mem.c                      |  2 +-
 include/linux/shmem_fs.h                  |  8 ++-
 ipc/shm.c                                 |  6 +--
 mm/memfd.c                                |  2 +-
 mm/shmem.c                                | 59 +++++++++++++----------
 security/keys/big_key.c                   |  2 +-
 15 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 9322a9287dc7..0bc36957979d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl_size = secs->size + PAGE_SIZE;
 
 	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
-				   VM_NORESERVE);
+				   mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(backing)) {
 		ret = PTR_ERR(backing);
 		goto err_out_shrink;
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e4df43427394..be4dca2bc34e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -130,14 +130,15 @@ int drm_gem_object_init_with_mnt(struct drm_device *dev,
 				 struct vfsmount *gemfs)
 {
 	struct file *filp;
+	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
 
 	drm_gem_private_object_init(dev, obj, size);
 
 	if (gemfs)
 		filp = shmem_file_setup_with_mnt(gemfs, "drm mm object", size,
-						 VM_NORESERVE);
+						 flags);
 	else
-		filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
+		filp = shmem_file_setup("drm mm object", size, flags);
 
 	if (IS_ERR(filp))
 		return PTR_ERR(filp);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 26dda55a07ff..fe1843497b27 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -496,7 +496,7 @@ static int __create_shmem(struct drm_i915_private *i915,
 			  struct drm_gem_object *obj,
 			  resource_size_t size)
 {
-	unsigned long flags = VM_NORESERVE;
+	const vma_flags_t flags = mk_vma_flags(VMA_NORESERVE_BIT);
 	struct file *filp;
 
 	drm_gem_private_object_init(&i915->drm, obj, size);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index f65fe86c02b5..7b1a7d01db2b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -200,7 +200,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
 		struct address_space *mapping;
 		gfp_t mask;
 
-		filp = shmem_file_setup("i915-shmem-tt", size, VM_NORESERVE);
+		filp = shmem_file_setup("i915-shmem-tt", size,
+					mk_vma_flags(VMA_NORESERVE_BIT));
 		if (IS_ERR(filp))
 			return PTR_ERR(filp);
 
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 365c4b8b04f4..5f37c699a320 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -19,7 +19,8 @@ struct file *shmem_create_from_data(const char *name, void *data, size_t len)
 	struct file *file;
 	int err;
 
-	file = shmem_file_setup(name, PAGE_ALIGN(len), VM_NORESERVE);
+	file = shmem_file_setup(name, PAGE_ALIGN(len),
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(file))
 		return file;
 
diff --git a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
index 61ec6f580b62..bd5f7d0b9b62 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_tt_test.c
@@ -143,7 +143,7 @@ static void ttm_tt_fini_shmem(struct kunit *test)
 	err = ttm_tt_init(tt, bo, 0, caching, 0);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
-	shmem = shmem_file_setup("ttm swap", BO_SIZE, 0);
+	shmem = shmem_file_setup("ttm swap", BO_SIZE, EMPTY_VMA_FLAGS);
 	tt->swap_storage = shmem;
 
 	ttm_tt_fini(tt);
diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 32530c75f038..6bd4c123d94c 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -178,5 +178,6 @@ EXPORT_SYMBOL_GPL(ttm_backup_bytes_avail);
  */
 struct file *ttm_backup_shmem_create(loff_t size)
 {
-	return shmem_file_setup("ttm shmem backup", size, 0);
+	return shmem_file_setup("ttm shmem backup", size,
+				EMPTY_VMA_FLAGS);
 }
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 611d20ab966d..f73a5ce87645 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -330,7 +330,7 @@ int ttm_tt_swapout(struct ttm_device *bdev, struct ttm_tt *ttm,
 	struct page *to_page;
 	int i, ret;
 
-	swap_storage = shmem_file_setup("ttm swap", size, 0);
+	swap_storage = shmem_file_setup("ttm swap", size, EMPTY_VMA_FLAGS);
 	if (IS_ERR(swap_storage)) {
 		pr_err("Failed allocating swap storage\n");
 		return PTR_ERR(swap_storage);
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index c753c79df203..fe0584a39f16 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -61,7 +61,8 @@ xfile_create(
 	if (!xf)
 		return -ENOMEM;
 
-	xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
+	xf->file = shmem_kernel_file_setup(description, isize,
+					   mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(xf->file)) {
 		error = PTR_ERR(xf->file);
 		goto out_xfile;
diff --git a/fs/xfs/xfs_buf_mem.c b/fs/xfs/xfs_buf_mem.c
index dcbfa274e06d..fd6f0a5bc0ea 100644
--- a/fs/xfs/xfs_buf_mem.c
+++ b/fs/xfs/xfs_buf_mem.c
@@ -62,7 +62,7 @@ xmbuf_alloc(
 	if (!btp)
 		return -ENOMEM;
 
-	file = shmem_kernel_file_setup(descr, 0, 0);
+	file = shmem_kernel_file_setup(descr, 0, EMPTY_VMA_FLAGS);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto out_free_btp;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e2069b3179c4..a8273b32e041 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -102,12 +102,10 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
 extern const struct fs_parameter_spec shmem_fs_parameters[];
 extern void shmem_init(void);
 extern int shmem_init_fs_context(struct fs_context *fc);
-extern struct file *shmem_file_setup(const char *name,
-					loff_t size, unsigned long flags);
-extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
-					    unsigned long flags);
+struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags);
+struct file *shmem_kernel_file_setup(const char *name, loff_t size, vma_flags_t vma_flags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
-		const char *name, loff_t size, unsigned long flags);
+		const char *name, loff_t size, vma_flags_t flags);
 int shmem_zero_setup(struct vm_area_struct *vma);
 int shmem_zero_setup_desc(struct vm_area_desc *desc);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
diff --git a/ipc/shm.c b/ipc/shm.c
index 2c7379c4c647..e8c7d1924c50 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -708,6 +708,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	struct shmid_kernel *shp;
 	size_t numpages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	const bool has_no_reserve = shmflg & SHM_NORESERVE;
+	vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 	struct file *file;
 	char name[13];
 
@@ -738,7 +739,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 
 	sprintf(name, "SYSV%08x", key);
 	if (shmflg & SHM_HUGETLB) {
-		vma_flags_t acctflag = EMPTY_VMA_FLAGS;
 		struct hstate *hs;
 		size_t hugesize;
 
@@ -755,14 +755,12 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		file = hugetlb_file_setup(name, hugesize, acctflag,
 				HUGETLB_SHMFS_INODE, (shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
-		vm_flags_t acctflag = 0;
-
 		/*
 		 * Do not allow no accounting for OVERCOMMIT_NEVER, even
 		 * if it's asked for.
 		 */
 		if  (has_no_reserve && sysctl_overcommit_memory != OVERCOMMIT_NEVER)
-			acctflag = VM_NORESERVE;
+			vma_flags_set(&acctflag, VMA_NORESERVE_BIT);
 		file = shmem_kernel_file_setup(name, size, acctflag);
 	}
 	error = PTR_ERR(file);
diff --git a/mm/memfd.c b/mm/memfd.c
index 5f95f639550c..f3a8950850a2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -469,7 +469,7 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
 	} else {
-		file = shmem_file_setup(name, 0, VM_NORESERVE);
+		file = shmem_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT));
 	}
 	if (IS_ERR(file))
 		return file;
diff --git a/mm/shmem.c b/mm/shmem.c
index 0b4c8c70d017..94081461fb0f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3034,9 +3034,9 @@ static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
 }
 
 static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
-					     struct super_block *sb,
-					     struct inode *dir, umode_t mode,
-					     dev_t dev, unsigned long flags)
+				       struct super_block *sb,
+				       struct inode *dir, umode_t mode,
+				       dev_t dev, vma_flags_t flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -3064,7 +3064,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
+	info->flags = vma_flags_test(flags, VMA_NORESERVE_BIT)
+		? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
@@ -3117,7 +3118,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 #ifdef CONFIG_TMPFS_QUOTA
 static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				     struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	int err;
 	struct inode *inode;
@@ -3143,9 +3144,9 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 	return ERR_PTR(err);
 }
 #else
-static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
+static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				     struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+				     umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	return __shmem_get_inode(idmap, sb, dir, mode, dev, flags);
 }
@@ -3852,7 +3853,8 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
 		return -EINVAL;
 
-	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -3887,7 +3889,8 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	int error;
 
-	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto err_out;
@@ -4084,7 +4087,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return -ENAMETOOLONG;
 
 	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
-				VM_NORESERVE);
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
@@ -5085,7 +5088,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif /* CONFIG_TMPFS_QUOTA */
 
 	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL,
-				S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
+				S_IFDIR | sbinfo->mode, 0,
+				mk_vma_flags(VMA_NORESERVE_BIT));
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto failed;
@@ -5785,7 +5789,7 @@ static inline void shmem_unacct_size(unsigned long flags, loff_t size)
 
 static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 				struct super_block *sb, struct inode *dir,
-				umode_t mode, dev_t dev, unsigned long flags)
+				umode_t mode, dev_t dev, vma_flags_t flags)
 {
 	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
 	return inode ? inode : ERR_PTR(-ENOSPC);
@@ -5796,10 +5800,11 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-				       loff_t size, unsigned long vm_flags,
+				       loff_t size, vma_flags_t flags,
 				       unsigned int i_flags)
 {
-	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
+	const unsigned long shmem_flags =
+		vma_flags_test(flags, VMA_NORESERVE_BIT) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
@@ -5812,13 +5817,13 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 	if (is_idmapped_mnt(mnt))
 		return ERR_PTR(-EINVAL);
 
-	if (shmem_acct_size(flags, size))
+	if (shmem_acct_size(shmem_flags, size))
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, vm_flags);
+				S_IFREG | S_IRWXUGO, 0, flags);
 	if (IS_ERR(inode)) {
-		shmem_unacct_size(flags, size);
+		shmem_unacct_size(shmem_flags, size);
 		return ERR_CAST(inode);
 	}
 	inode->i_flags |= i_flags;
@@ -5841,9 +5846,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
  *	checks are provided at the key or shm level rather than the inode.
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
-struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
+struct file *shmem_kernel_file_setup(const char *name, loff_t size,
+				     vma_flags_t flags)
 {
 	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
 }
@@ -5855,7 +5861,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
  * @size: size to be set for the file
  * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  */
-struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
+struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
 {
 	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
 }
@@ -5866,16 +5872,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
  * @mnt: the tmpfs mount where the file will be created
  * @name: name for dentry (to be seen in /proc/<pid>/maps)
  * @size: size to be set for the file
- * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
+ * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
  */
 struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
-				       loff_t size, unsigned long flags)
+				       loff_t size, vma_flags_t flags)
 {
 	return __shmem_file_setup(mnt, name, size, flags, 0);
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
-static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
+static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
+		vma_flags_t flags)
 {
 	loff_t size = end - start;
 
@@ -5885,7 +5892,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
 	 * accessible to the user through its mapping, use S_PRIVATE flag to
 	 * bypass file security, in the same way as shmem_kernel_file_setup().
 	 */
-	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
+	return shmem_kernel_file_setup("dev/zero", size, flags);
 }
 
 /**
@@ -5895,7 +5902,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
  */
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
-	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
+	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);
 
 	if (IS_ERR(file))
 		return PTR_ERR(file);
@@ -5916,7 +5923,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  */
 int shmem_zero_setup_desc(struct vm_area_desc *desc)
 {
-	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
+	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);
 
 	if (IS_ERR(file))
 		return PTR_ERR(file);
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index d46862ab90d6..268f702df380 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 					 0, enckey);
 
 		/* save aligned data to file */
-		file = shmem_kernel_file_setup("", enclen, 0);
+		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
 		if (IS_ERR(file)) {
 			ret = PTR_ERR(file);
 			goto err_enckey;
-- 
2.52.0


