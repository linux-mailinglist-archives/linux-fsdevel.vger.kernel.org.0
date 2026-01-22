Return-Path: <linux-fsdevel+bounces-75094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B0gATNRcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:32:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6F6A052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B3D3128CCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91E388859;
	Thu, 22 Jan 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dFSjurXe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vtbI/N/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F6377563;
	Thu, 22 Jan 2026 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098090; cv=fail; b=boA6K1YbriCuBNToZQOp3XL2DeP9u3fTkfJtNCs66lHokCgvMW7H1E0xxLda+SDVzV2JYbed9G6JKQ5PE3SeZDYAawCMrvvSigWhG0EfsTHb+xhlbUql7c/pT3n6hog1UR0A0orRzwd6A94GFreON3+mdtXeGM98DOUhQIjmNnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098090; c=relaxed/simple;
	bh=dQ7KWK/Yl3/83Ys5WlACJ2CBKsJVPr+zOzr4ZOooNNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfdxx5JChgA97Z7ZlTmt3pJVFfwPL/hqn/43ImWF/3ctne2GX8vM7gSXBOyWpriMDINMH328v8+7BuNJ5/NnNfoP7zvQDHbgVMfFJYAw4E/goJDUZAGJ2Kwvze8HecX1q7zGlWtBTA2VTbCrCSpoMdHGL2xobvFjAlVoidmenPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dFSjurXe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vtbI/N/0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgTG0460885;
	Thu, 22 Jan 2026 16:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/DPcphJwzRT/okcFXELaxf4QahTk5XJLfZrKNR+N3vs=; b=
	dFSjurXe4xceXdagdKa3s4P2ejezWlIhGm3e7nvWMNr+1cwlQt/tOpNM5hg8clvQ
	UN/O4XC57z7SpFrgzrWvxGtPWyU7zOMcsusjUv0zOk4djWgcG65cnKB7aL8EX/a0
	hDlkDpV21WgjWSsYGPm/OqWTgzLE1Q34LP7s47T4xFr8GfEbC+WXTfgIlDU0RS6T
	N7yfSe1D53GTJ+XjEiayZsmeX1vuwhT65HhjTMESn2ihyw6Kzoq5jM+LxsaMsyf5
	F/bJr/39Bdm3xvIFbKy+Xo/0mDU4ALYr11zPGVmspwzLexhr7pz0d486rRAp/fCG
	9u+TS5Ifej5wUz63ub7OVQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8g0ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCF032257;
	Thu, 22 Jan 2026 16:06:42 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqAPh90Aw3NHsDtjBRG/3NUcn9pNXXLa7y4Pl6LCFy55sA7cG4v6y4mLYS5QMg5sxds4jrcQQvLoCIivL+Ue5jO6IoKDGgQN27uXAHOtdGVZ6FnGyDezTamu3eYb5fA/L9+gTfCKy4qDqhMR3MgCaq0WJYSr6c/ec6oGvwkErvnB7B6/KOQuUYXH9PDNJwcQHkC4m/8sF/k1GfCOlGISajZbMkbAbNIv3w82WqHny9OQxsHdl8ltZyI/021MWo0Z1c1ohTushTR7iSDxPRMeRYXr8ukz69OYq9Wo2bEInfk7WzpOsB7fqxwtGe2b2y/DYu80/zdhjaT//NeALGDGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DPcphJwzRT/okcFXELaxf4QahTk5XJLfZrKNR+N3vs=;
 b=TjMkFoWkBuZ1Z7DPJ37y2V+AIp/voEwFbA05pIK+pfpIUH0Q0I2egxKYcPrP7IoXNTAAtwWSbUxul1M+rxk3Av3w62e25Himfx3zP2RaYqda31XqBdsaM5ufWG9QUEQ9vgkR8CMMqkwElphkjrZQEnRUSyk2qHdys2Og1ynRe/hcbaZXFaAFidYmMDacnpFMrl1ktdwZe/21Xe+y8LzyyVksEdLyH0NMen1b7RVf8S24wurQuRK2sDQrmj1aLxl7A/fyGr/Vq5M7wy+bkEOs0Hm6QG8UULFcbJtxbc2YdZdn1famvBp9dfwoURYpdm2Ge2BKvwWtnaLnRw+B12BVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DPcphJwzRT/okcFXELaxf4QahTk5XJLfZrKNR+N3vs=;
 b=vtbI/N/0WnRikuDVgSy4KwUVKX4saS+pqNX3s2nVl+oo3bWURljefWJH5bk/vHNNcdYtpiBUVXDUe31lRjeroSwB8EjJJcfDPYWc+FJETW7ArmHXuoC93GzzLrcT4E/WBXR7bbj0LDEsz1682KEPjq/gOSOlUjg3NnzIqyiZZow=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:25 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:25 +0000
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
Subject: [PATCH v2 01/13] mm/vma: remove __private sparse decoration from vma_flags_t
Date: Thu, 22 Jan 2026 16:06:10 +0000
Message-ID: <64fa89f416f22a60ae74cfff8fd565e7677be192.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1e483c-ce18-43d8-d019-08de59d03190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1dSpmlehPzAoMqfYDOLP9GyshfwjvjZ2b6pJtLMoPl1kgvghonDX5W67udc3?=
 =?us-ascii?Q?9QeTLSdOecCNDK0zFfqX7gGjp7VbgKLQjb4RdZNncCEYirD+gBWAIu0Co3Ef?=
 =?us-ascii?Q?O6J5HmQHeo8/OkgiTA/QHctqdsoW3kzBehPNgWVwnxFkW5vc449GxO6YRO7D?=
 =?us-ascii?Q?lT0hRAh3X8FSp8AfMCGtW+NKEy8q2JI1CF8I6T4QUOZiTB/3NttQbjb+do5P?=
 =?us-ascii?Q?4FL/6MHRAvKVJwJznYYHo7p/2ZtDOlBZsKysEL5Ovm1+VIHhbF7cozqV4a2d?=
 =?us-ascii?Q?mSMWqpJxMRQE8/iqH86UHkA8JwFrZMrsAyMWhbqNQrWY6H0EyELUu6hXzVSp?=
 =?us-ascii?Q?8GnpXneBz4YoLd4NoLr8c19Q6yNHHOHyVUNXXwRY+z9PkcePLGSZgs6uNTR6?=
 =?us-ascii?Q?n9rt5y3n/hci5UIimedh1dlysieVJu+vtcUGwogzaugcke1b6qtYOkYPMWWz?=
 =?us-ascii?Q?dcFkIpjdqXl2cGDZgKATvv36fmRY/42wn+ZWwVAucFRQM7j1UonEI+0pxr8t?=
 =?us-ascii?Q?JG4oelULUXtWEUasS0UNTupmEeoeiMvPAMMrwy1a43fJkywV+MlmDC206kdk?=
 =?us-ascii?Q?nFSNvkd96/NIrDUaYcSTtRaMjbAoQI5P7SvDRO1agld8RPkpCpdSGoCE5RqC?=
 =?us-ascii?Q?mnLCh9pqpuw8UGP3E3lDQHhSUp/osBnKeCMw0o/bAJs73b/NSVEIiukcV6SG?=
 =?us-ascii?Q?fEydsZuQ07P83X6Ji5p9L8oMEIT31/g63XGx60PayTdw8YnfCfwrSnjRGeHa?=
 =?us-ascii?Q?wOEAtOM9xlFA1luCsEzv5mWACajgxFh4W4v7wPgPNabpw0AgWhomQjXxpmYt?=
 =?us-ascii?Q?Cn2IxkosHnIXZSm9OcTk2xP5wnld8YivJm1ywBqFtTRDcr5k+IOsp2bOtX51?=
 =?us-ascii?Q?qJV5Z/VspbB5GR45LShphS2uCytivIaamJAMnk+Y/IqMGrFvfdk6x3oYhHBg?=
 =?us-ascii?Q?xUvNO3O18/W4LFDlJ8D8LswTFKekeFkgRCWy7g0r1m7pLKt7dSDHj4tXrhui?=
 =?us-ascii?Q?f540geJQfB7Hf7IvgW8tToFJWChpBQ7gsaxIhklXWBMrNmPFVe/b6ufIIEv2?=
 =?us-ascii?Q?bxLsqs6ocjL1bOoNwA+fmGHFPNtOzZrHlc2gF+KSUk0mEMNoLLTsdM/ycPcR?=
 =?us-ascii?Q?vQR3ZY442RMxmBOpAOASHGZyg0Ro+Aao/fSGqCfKQsULoNnHsQLPEdsQWfOg?=
 =?us-ascii?Q?ZWeYFj68mRb4xfeUsSCm/q1MarIIDPNYdC/t21rOn5iqpm2MMKwmQjQTJl7J?=
 =?us-ascii?Q?yHTpbhTkoWMx5nWkJfSfOlRcfvPptpdKBk+pnY9u+QivRhhc8pvoQM+n/txc?=
 =?us-ascii?Q?PbhhKMBN/wlBTiyDXcbk9cbQe3hdyt7Kay19LKMAhd2BF0bbdHwQ1L3CGlvv?=
 =?us-ascii?Q?9BPgHOmb6Wbme1gZs+uTrWvE27HGGZPrbR1k0WGxLz0E7q1Bo1nAfK/oKJZt?=
 =?us-ascii?Q?NGKI1EaAe/CdgZUcO1aBjTp7oXgRayNIx3qh4JmdrMjofj8WEPVkipKxMH4F?=
 =?us-ascii?Q?ANIqTXElSgbObSDJR69xr2JxHdEFHYzKQVNEnKeYUvl4DzO+FmHdxO+zYeUr?=
 =?us-ascii?Q?LK6wuE4zPc9x/cdUXq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wf/bG/7hgV9wjGWVncrRH8Q3+yCZgpWb0vvcC893dD758MKpXsYzdcohqx+M?=
 =?us-ascii?Q?gzqM/Jr0lhS9iMgbtO9EiZdTLcIHLWgfzr9U8TOTZ5QdYEYCfqJd0vR06EZf?=
 =?us-ascii?Q?yZh7qN/e8wdQUqXB195c302sHl8VEqCPYdrVLb4A/d26aBbA1Ydl52dYf6jG?=
 =?us-ascii?Q?WNKy2GKD/ZNMQxvNiMoWuWbeiY3CoEfEc2t9746EXDBWtTXS+y9rbSIG3J5u?=
 =?us-ascii?Q?UHMhgwp7Nn75Atk0D5UzQHLKi2fdNLCSODpgU61T7yk16qK/eDlQLFYhKqov?=
 =?us-ascii?Q?Sxj0eItSHlyITKIlcdyLa6AfT07XGQ7Fi2afCnuvVf/WwWjLmKn2VrKgYdy8?=
 =?us-ascii?Q?kvULj5T0SIcEzLhDJzD+3+ASOgYXc8MtrqvFwU1tEHmxjDAkLUXMpnA4O2Dx?=
 =?us-ascii?Q?fbHB5P9AXPdhikZZea1QVwmrE66ut8+1QHdMQvAV7R5Yslj80ImBkwiYtBwq?=
 =?us-ascii?Q?92r65aDn25ibeSiqNC0mWzeRtCJpZqvkx+KR/t12MOYslljV2fg7Im9CVt8A?=
 =?us-ascii?Q?MCT/kObP6OcdaHzmzRoBSXdiWgisbVe0Pwrho24gV4QnqtuDC/C591LRI7Yc?=
 =?us-ascii?Q?jiQtP74EkzdjhEIENEtiN4dAKYDDIKpkm0oF7ACimreHVhui6b/S5W2YqatQ?=
 =?us-ascii?Q?vX/iOOivnm2pAHDD6c4sazaBs9p7vnb97aGFECkyKWhR9Jq/fCp7MAXk3O4o?=
 =?us-ascii?Q?MqsQ++CsidAzA8K7Y6kYDtQYdzq3eFfF0IL4ghNQUqZ6ctGZn4R0MTutR3/k?=
 =?us-ascii?Q?u3IE95/ptlNYkwYk56xAEYR7/+WWR2o4EdPqCSgHRyAybABiV9sySjvRk+1m?=
 =?us-ascii?Q?Pj9w2mrxHPfF1xpiyWzPtuBpysrS3iErikugZG4q0M1mg6fl2EkrO7xJOroh?=
 =?us-ascii?Q?rFbEfo9AMUwSasfVw99AwL/SxwpQL9Gbc7cnV62d2fEeboC2s1AFdYNtwdjo?=
 =?us-ascii?Q?Jgkv0JlQHk0Hw36PEwahZGpcF4SbPfiFODf5RiQYsNzIoRoHDBuUm2q4RyMf?=
 =?us-ascii?Q?SAnN8xLDYCl8+OtVEkAxgRm3yoAES0jibxI+8MxisYswslCeicPNSQAO2iHg?=
 =?us-ascii?Q?dArmNtGb/QpnuqL7mKGSgyC+kV9NnIpQF9KRkENDxNwDtH7IeQSDQx8dR0iO?=
 =?us-ascii?Q?z/t4zxOSr00PXchHMFLI7P3FCdnFr0Lut/zNh3VwHm80PoHVZ3VKLRHxqM2G?=
 =?us-ascii?Q?39VldLQ2QvlRGcTe3fc1T7yC0wrZ4wQXpzIOKoY3JhDo1plijCa+F7SVCq7C?=
 =?us-ascii?Q?hZKRwF7ORwEb+4YZ9XHvS+Sjs+AfBztxD5Cvu3O/zfo8a0zwlCshKrexVWGp?=
 =?us-ascii?Q?7fGmqza6m39/NGJ6UazTNj+9seeHSPi1mDE3rpL2N7SJvMM4c0WIxiZNfm7E?=
 =?us-ascii?Q?1giGauQ4KI1DCL8xyiNG/bopBUfb1IkmTWQEMpavis+VeTrUIaZOVMcBfPEt?=
 =?us-ascii?Q?ebpjtqp0Lth0a9mKMvOLDL37R7vOzS+1XzPQymll4OHzQFbY2j8xeOn7ClVY?=
 =?us-ascii?Q?85rRovKlswuELjxG+TaRBuSzXM0uKqQaXbKJ/X79Hlz2QcQ0zbzATCrzXuPo?=
 =?us-ascii?Q?EUgDCZuTE7R0LQ45MlZAIAHB+p4+HEjJcpcXnU/mjf9CswRUyXN5bmURkLQI?=
 =?us-ascii?Q?3w26u+hRsxTXU/05jH/F0Ii6oU83z12yOHHbbV+i5Z3h81NIei+bsUf8KLno?=
 =?us-ascii?Q?BD3anj0isng1GesxDf3HFAPWi81WQhcf2cPtIF9/EV4vxzPH7+YlOpSe/hO1?=
 =?us-ascii?Q?HaINor3GklTuRFwDsQTE0uON7kLTt1s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7YUehHz5+kE5vT4bdmCTAMfrqOObhYB6e8FWql2671ixZnCOOLSio3jqIyGh2bpo7DpwBnztL9Twz8JZFWOtBR0VPglpzHoI3ETyWdruQRUUSDspmd2PxeLQVOIqq0vgz/fF+uY0hCHhdOyPORpgUkXlj4Q0uVTl7Z6jaRI7okudFiaz5rms3yNTh91Xvjlf4rzRo68CuxMif8NO/85M3mPHXKz1n7GeISv8OaABgVxd2l5ynNuTtQ/iCKOlGR3lDQ3g+ktHgr0qU5U6CrhHEk9Cckz8QNhRwCDBJiJhc00PO19uPQn/IulallAptezNa/PnCPutmzJWpQ1kHENuqHJYmIhJEW7JOBfuuwQ4Y1gxBrC5EAsyKfH+JTrNQ/YQI9IxL7mTUDedg6ncyKjlnNmJIffTBOEUyYkO3ZBmqeuEVLGB2drPyvHVtAXSOV7ctu6K1vKeQXeErUZ/gKfUqEYAorZ0fAAhEO6KyYcnBbbOpXXIP0TecxAnwiEvCMe3LVEJI6Ga7nNTN3GCqnufEPUPJ8rkMIvI1KaZB7CeZDxlUbJwrvSRXGmk0X3JsPytxnT0mPLGlqm68jXBcD6R2OCStB0DrQNXk6aXQV35rjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1e483c-ce18-43d8-d019-08de59d03190
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:25.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1b8hAVMdnZ8uUay8eJNkb5wWVqlmzUtYcyBcp2FTXjnuzK2L8147gMCZGjlyiRbHRO9A2rftY25CE0yNj7WJsM+6Cgon4Cp1M0gyJzGov4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=69724b14 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5VTENHtJNMBZo1aytQgA:9 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX2Jv7YZOuqn7u
 r9SUj98CfyOAtED0s6Pkt5xsRaOiVpeHEQPBH2WDKDlOvnIumnUYT4DK8a4deluhTAG2ckMs5fN
 hdwtQGZEIiphGvr4vK3Ct3LZiw3cs3jamSvPXCOLJo5lM6X8SEivbeeHI/dw2QrlrK6yNAGu0kP
 jTRHGBpZ22DsbDZsQ+zwa8rYYpHUJvrxocAIWiC+QCFvMEsEaLi55ZjqFryWmqCQFdIZ6+NmKbo
 K/Sw8mxtEWrfO++zIbwTrHOM4RkMBeNbfjH+zpYKIqkFlN59vNOIO0zwb8EW93SUvy1GUaqi9Ow
 We+c7S1RM9yRQsi5t1XFO90CUB3yDPcd0cFD8gIJbaws89BeTTtZwPxoQIPRdNu2WIjAWP1gYbr
 NRLAdqOQ6sIjZtR9Z+nDampvnFfkHFDz/mDtrkEoRP5XfQRdxKHpHx7T30Vfu0PQkW1j5iUD6QT
 WePUvWBe5WhFJAn75fYJfprN/uOO5OgBl/Q4Hr+w=
X-Proofpoint-ORIG-GUID: mYGBpMw4otnrrh4M6hyi_PKHL1ni2NDC
X-Proofpoint-GUID: mYGBpMw4otnrrh4M6hyi_PKHL1ni2NDC
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
	TAGGED_FROM(0.00)[bounces-75094-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 5AE6F6A052
X-Rspamd-Action: no action

We need to pass around these values and access them in a way that sparse
does not allow, as __private implies noderef, i.e. disallowing dereference
of the value, which manifests as sparse warnings even when passed around
benignly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h       |  4 ++--
 include/linux/mm_types.h | 14 ++++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d7ca837dd8a5..776a7e03f88b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -943,7 +943,7 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 	 * system word.
 	 */
 	if (NUM_VMA_FLAG_BITS > BITS_PER_LONG) {
-		unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
+		unsigned long *bitmap = vma->flags.__vma_flags;
 
 		bitmap_zero(&bitmap[1], NUM_VMA_FLAG_BITS - BITS_PER_LONG);
 	}
@@ -1006,7 +1006,7 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
 static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
 				       vma_flag_t bit)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
+	unsigned long *bitmap = vma->flags.__vma_flags;
 
 	vma_assert_stabilised(vma);
 	if (__vma_flag_atomic_valid(vma, bit))
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e5ee66f84d9a..592ad065fa75 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -866,7 +866,7 @@ struct mmap_action {
 #define NUM_VMA_FLAG_BITS BITS_PER_LONG
 typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
-} __private vma_flags_t;
+} vma_flags_t;
 
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
@@ -1056,7 +1056,7 @@ struct vm_area_struct {
 /* Clears all bits in the VMA flags bitmap, non-atomically. */
 static inline void vma_flags_clear_all(vma_flags_t *flags)
 {
-	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
 }
 
 /*
@@ -1067,7 +1067,9 @@ static inline void vma_flags_clear_all(vma_flags_t *flags)
  */
 static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
 {
-	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+	unsigned long *bitmap = flags->__vma_flags;
+
+	bitmap[0] = value;
 }
 
 /*
@@ -1078,7 +1080,7 @@ static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long va
  */
 static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	unsigned long *bitmap = flags->__vma_flags;
 
 	WRITE_ONCE(*bitmap, value);
 }
@@ -1086,7 +1088,7 @@ static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned lo
 /* Update the first system word of VMA flags setting bits, non-atomically. */
 static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	unsigned long *bitmap = flags->__vma_flags;
 
 	*bitmap |= value;
 }
@@ -1094,7 +1096,7 @@ static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
 /* Update the first system word of VMA flags clearing bits, non-atomically. */
 static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
 {
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+	unsigned long *bitmap = flags->__vma_flags;
 
 	*bitmap &= ~value;
 }
-- 
2.52.0


