Return-Path: <linux-fsdevel+bounces-74591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2012ED3C34C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18C0B5AA14D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223173A9012;
	Tue, 20 Jan 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ds9Som+1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rfVBzhq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E11EE7C6;
	Tue, 20 Jan 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899746; cv=fail; b=F35ZJbTmmK6eMEwVzhsFnpJpbYoZdtIuitq3T+2ofsaoNsr3v5YzGeNivuA3Nu2fcz6vu7lKGgbkJAHZN+vlcx7HkAxC4FRGpDe4nwuMqBVtu2ZTTkyHJHhHwjWFRX7KdWtM5cBmWXBBT2+OTxDCT5zuOMdVSQDUPVudRwkC52U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899746; c=relaxed/simple;
	bh=4Yo9F5nmF2joKitEM5Y7Z/QUXADNTMl26iP1JfBSAOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OveHR2A2YP9eYN6pSLTuxBLgGAF+22clmTqi0dW8CAPj+QMzpjWyvYth104ek5TVFj4cId3yIzGi1mQlta0dAijQyWIOVEQcTdPYXT2xnKzSTkg3EJaXE6jkb9RyD7QiYVAGGuVTv0LA6XBN2U/4U/RKbEfyGih1zsZXm/jqUp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ds9Som+1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rfVBzhq/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7uoMN3429730;
	Tue, 20 Jan 2026 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PKwis+jkDFsb0CBTFh
	JBym/gCn6fEYs+hbSPuPS/HWA=; b=ds9Som+140fq0Hf+stHI06EEYBOWyBDGhf
	J3A2qZ3db+lK71ALfgGghP3VFsdr6MbR/s4Dp3/6IOKr9fMsHulptfII5jFIRh9b
	sUO56qwz7/k9pTFT0NsTj0Jg5DrUt00mF/BJWu77btCu1ikdOcO9133d9GzBbKnT
	Dxx9XzDITjd9fBIgkhXvuyGBZT0BzL6AUSTRSP7ShVLtBRc4ITOa74zcghULz4nI
	0fZ81SZGhrQwP2RK1TuY6UuEDeCdVSUa0GOddi1mneksIzXuHZ7nhn4i1PLqB3VQ
	1AyIPFDm/MQXO80fIhBL7FpA8t5yCrn4VYLthtmJnZ4Ger/j9rKg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5k6sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 09:01:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K8CYTn038114;
	Tue, 20 Jan 2026 09:01:08 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v9aw06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 09:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imxPXzVwE27SgMItOrHfVopCNLngVV80Zr2sLxO5N7x3aEIHIGoICixwRtWNYlR5BkwQh49G1gqWkLWxyYjisCHGLmqcvyDKZUf6tvibAbJh472bz6cZgpBdCzVFyHBcY25j4w2XbvEfozc1qLn23k685kvdZMWihMRzPCROa3ri22HaTIqN3O5G2B2vVMh9Mk87Ke3RfCfORFQUCECAzsjuk0cCUxzbvBQ5gnyMxlpo9dSM92KDacQcehqImYboWiLj/CRcBzaLHafYDdcO+idOiEdPuGS/FeJeJh9e963cknm2NVJvdf8Nj7mrCMj1ZZmNfRagT/RY+WPolyg2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKwis+jkDFsb0CBTFhJBym/gCn6fEYs+hbSPuPS/HWA=;
 b=boTvx53YaKtZTcWXoZmgjKq4agPhnSpXcT+0xElVMXQ2OU6jqMdtL4QH89jk8+eWxYZ8CBYmVCtvfZHKJftapFM+Km1XQNZPC1QghMhwRsFlosXiHcFeH3hmKGLw8E9cqEy4y95LoPSnAnf64T3/jdb8tL6Q2KrjTiRw58ndpg2+kUfkC8lKHzdj7mjboAeXShcr+aABrP2lBIfxzskY6k997F1RryKJP6GqIRhLhB9x1IizpvN6in7R14zg5wY97BST/PTv+hx6xF7q/RxmTW3r58V/zlxro2lawUeyY4VrRIBp5QvyHKhiUSOIRdVPkOxPSI0dRaAy8QX1j8eu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKwis+jkDFsb0CBTFhJBym/gCn6fEYs+hbSPuPS/HWA=;
 b=rfVBzhq/3E7mAF5gdgQD9EZFbrJx/kfrNAKHnYFolsmt31fV8pWUAZBvtdEPXPIg2rStvnWtUBoNWEL3RYIh7r3Wd+REZv5qgCqt5fKW6QZwSK+9Vcok5jeRMuX4UxskOqNiJMKg3HBXNeSGmcslTNNLgUY1n/eclgWxUiw0Yi0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BLAPR10MB5075.namprd10.prod.outlook.com (2603:10b6:208:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 09:01:02 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 09:01:02 +0000
Date: Tue, 20 Jan 2026 09:01:04 +0000
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
Message-ID: <cedeb1e9-93bd-4513-b1f9-7e41bbbc38cf@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <24317e6f6b71e8b439e672893da8d268880f7ada.1768857200.git.lorenzo.stoakes@oracle.com>
 <34F72E48-5F22-4A20-BF32-917CDB898164@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34F72E48-5F22-4A20-BF32-917CDB898164@nvidia.com>
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BLAPR10MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: e5143ad4-aeac-4271-4287-08de58026fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8xH3S2gVAE5+n4tmKje8MMpt25sUYHw8Cu77HR9GllVnfozq4rB2dH8gk4OQ?=
 =?us-ascii?Q?wPcklqSBWwCEHm9FU7fN67jK59/VVbhsW6PgFgRu6wn7npZPCety1TKU/Qcv?=
 =?us-ascii?Q?4j7Neb4T9mzz0tfElgUBf6v4n0209Vs1eM38L3pqZHdWdNUZDSZpfuf2sUji?=
 =?us-ascii?Q?KKXXqCAwW57AN99yJ2qLGZ45WxW3McSYahpuoZpDYwDT+xfZnn7HOp3XVMY+?=
 =?us-ascii?Q?TzxRqEGA6RsWRK4ycZtcdUgSrmdKgfPbg3Xm6JU8ZnDChJf71Ckz7CP/pO3J?=
 =?us-ascii?Q?ZkH5fQ14zWXUON1irJvBdH39NuJuHF28bMTOH1lj+Ck6grRD2CLrvtKQHdbd?=
 =?us-ascii?Q?w/Ol6EUc0SKbSE2IFNIEJ0klar9y+t5KtNi6dZjV7if+hlg2lgxeKXaztYgg?=
 =?us-ascii?Q?Fp2RJmw39nyaQCpIR+yHUDGK/Zs4dDulRWtQjZ1h6+p0qEj3kDiLsNN/xm9S?=
 =?us-ascii?Q?nvQp81KpCGeLx0nH7xqzl/3+6QTNQgm7A1j+kQjEXj7JlNPD45tVWSlPGWhf?=
 =?us-ascii?Q?SjiN2qU0w/3nG5Bk/Zc9vGmqSdLDL1xLoUIzJCmwgalOlkbDOhENlh+NtWlE?=
 =?us-ascii?Q?bAwFGa2cxOaCu5GqRrOhiEorJ2+psj6VKV03C6Nv49ExFq/fo5LvJlq4HVPo?=
 =?us-ascii?Q?e/z+B6VJSlFMci6mJ396ELAv91KuxqFXZWhQiEsycOhPP8niQZsYZj+04AD/?=
 =?us-ascii?Q?DLaYZ6xV4+jHDtuiQqkEuyaWC1gN6IJ5MBcLCwJBWNXluj5z8lPumG7MHbHG?=
 =?us-ascii?Q?KkoIculj53YlCthNjst/AWOiZPjtO6I159y9B+4TS55Kkpwk0jhAzgKmvROX?=
 =?us-ascii?Q?a+H2/YRoQRP0XWXSowMtcrBvSppRJBtOWqeUXjmduk+a6yud+3R4sYLuvCQX?=
 =?us-ascii?Q?oAHOwaAYY7l6VXWpyOA9ezHO9Gu31wMTho+cMNT6HKD64WDHYDte8qLip+lN?=
 =?us-ascii?Q?Ji35v1rC6Q+Wm0usscQJqiMfGUjN1c4AeoKnox8YaoktDK2p8DROAyRd5q0H?=
 =?us-ascii?Q?NHUjxxJEKyGMP2EAThomjajnrjUJR3fnw8URfiUskAMIPQFjLl4Muvl2cIZ7?=
 =?us-ascii?Q?g6KHmXuNQEaUsI7vxqUa5u6MCuvh/qWuD3E6U8BJo098fCCkcH9Sjqu567Ob?=
 =?us-ascii?Q?+DojJIYssngRokyGW8Hi0g9FFQ89ebfq6R/P0zzdaBT5OXxujDuX5+e/GleH?=
 =?us-ascii?Q?BNtu3oJwQ7XKMIHycN/tBNEAowp+0CQWf+UYuYxZSIIGlLcVkem4ftavw7zt?=
 =?us-ascii?Q?KoYzY+B0d9UImm0fXhvxgGkjj5GwByhagFRPyQn4CRHFRsIRhyLWBXG/LUez?=
 =?us-ascii?Q?xW2Rg3R99VJcHGTvHVwOR+oxrTebhYc9dEoCglkjr5EBRabfNyAZc/8Nap1c?=
 =?us-ascii?Q?tSN5yzN4y+IUDrLoJVdeduPUiESn1PpLus+lGwgJkJoo46TaJ1XBChxWMmAc?=
 =?us-ascii?Q?rkFwRsoBP6ounFIwBztwb2e/A5ZhLTnf29ymwXnlowqG8u9P5HjIDzjjChFx?=
 =?us-ascii?Q?rt6g4oRtn3htlpK3FWebnlae5USnrhGbOJBiTMjL3TCSOX1JlAKE86bSgLyR?=
 =?us-ascii?Q?M5P5GK02F7SSIziiev0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqi4M272LF9ibVrZBDHQhz0t93I/D/hC4SOhPRp996Vwfx3wbnUk29G7I99u?=
 =?us-ascii?Q?oVjAJm6Kn0/eGQolFBWT1a8pAYzRPkXRk4m3ROpuyGh2AvmH65qDK4HM/T6U?=
 =?us-ascii?Q?zSzf7LhF7+ZikOl0ahQPc06Y0Ar9e3HR7eDplHtIXr30ZkIbSnK5PJH5ez5I?=
 =?us-ascii?Q?nih0G4sqGiYxgxmA7MkbRVWhfohSEzS/M+M7vJ4OmgWxnM0Nl7w+5Px4pjg8?=
 =?us-ascii?Q?TiVV/JOLNpfS77xetOY8EHBeAc3gmjRYDfTS9Egq99+54Gmsz+nU7nMU8yOM?=
 =?us-ascii?Q?kxKjOiLJMyQSM6oboJg8Q7x0p9r3I9KbKTMMi0fgs+bz+U+W/PcphW4W7SE6?=
 =?us-ascii?Q?c3fdEHD89Ja+ciaL0LxADa24eoNYeIhS84CjcEJOix0RVuOPArs1RL4ayrOI?=
 =?us-ascii?Q?XXWWiUetnuvOKiBL3Y7KzT60d3iL1bbh4XtWcZ2ylu3dm2DVOW0WGs72itMq?=
 =?us-ascii?Q?FC1jBCqNABookrtAQThW+r3qXFyhySFUc0gNYURjvXCeoUsOQYbI/CUwu6Xa?=
 =?us-ascii?Q?MRdo08qZF9Tp95A/4FuPzlX6d0v9UC6vuOA3qlGG1CWv9aEHbit1DYNUfntW?=
 =?us-ascii?Q?6GRdU1P9VJ1l0tr201VGKX7zp4D5htDDHa91M9S8dAyKSp+xlI3BuEnxWyuK?=
 =?us-ascii?Q?L71c+K6UXVUS90+wA58Cfhg4dZZfBhcRVsZlIqXhmZICaVTeW5hzdi7T4grK?=
 =?us-ascii?Q?7ChEbH8W4PBdDpNp2T/YFEHx76lB0B9qYqgRJODWp5XQEKg+z4DtaO1nf/y7?=
 =?us-ascii?Q?pp4DOOuo+TBUJIA1HNZgGyKZa+S+Uf8r4LyqsgB1OAAQgHMUDt9C/QYE01yf?=
 =?us-ascii?Q?9Shd721IYVI0Hg7A7S0jwtWPz0EMsBoUCaPIZZiwo4+D64xUZmBII5lLPlUT?=
 =?us-ascii?Q?vU8xC8VIc60qndVra5HdlhVtPuGf4+qVuxTdbvcrP+uCZvKc/4jUt5mx/KN1?=
 =?us-ascii?Q?jDcXnfmhf/u9AHvbrNL1n4TcmlzRtZhGeVyCpDsiK2Mish8w9uE5/oaSGDni?=
 =?us-ascii?Q?2CnQajKudNppqisSRDPW6UYenW+JAJhhdhp3zP8TgrnhSVrJHU0Zk1+NIFwc?=
 =?us-ascii?Q?295m20v8naBhvRcOTODrPQRzhf+4W+S0gGF/oLXS5LtFMhNzMtGx+Z9xYPkc?=
 =?us-ascii?Q?oRBDavZnDZq8e23bM7f15Ol5fCcIOT3AR4r6suNr7el12fOizy+C8hAjy4xl?=
 =?us-ascii?Q?9LLVytodxSL9gUuj/XQHN26UfQNT6wDf/y8lLGk3NhZTODnmNPVZqXQYEe/0?=
 =?us-ascii?Q?QnR0v5F02c5Io3bUoj2si4lJJfMu2snNYIpT/W0nTLtEeQj0wVYVs2q/QxXA?=
 =?us-ascii?Q?NYi8ugh7vuFWKoODKiSrJwgb32GP2UjA3YEDtFuyC/x0OFWMPHfWMhjbH4MA?=
 =?us-ascii?Q?3ntZ0J0/YcgexOTORJEhPK6+yd2CX8LDJHtBcBVRbTd7UekGdjol6vcQHmu0?=
 =?us-ascii?Q?F/APv92s9c7QoZQ0DO6cdxAD4Or4ikGLTxpKYf18q/4PHRR3Gqo6M62pXaS0?=
 =?us-ascii?Q?KLZNguVMz5NV3t1E0VI+SOt/krik/uUChhNruR6yKdJ7xt/eAd0Cp4DGwi/j?=
 =?us-ascii?Q?EaWzh5jrkXEgwhIWJbGBGS/IHMwfxPRAe9NxTlNVuG+Y+tHCTYXPiTFlNpno?=
 =?us-ascii?Q?89Iw+2e0bDmYY+GQPzxj7z/0Ll/YjDHDqH+u0YAsU9jPiSh+5m3nWlUPUHJ0?=
 =?us-ascii?Q?FqZcSQ7BpxK0F/r2JVPz8Aff2lXOBIPLM6PcnmpOQ8xIRrMODksaWy/JXXCA?=
 =?us-ascii?Q?ExnaErBtllQm28v+jYCbGqsc/mPNVEc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fZCJM3qddgdn392rfPFMRrGVmvxxO2fYribrG9YmVAs7y7h8L4zES8iZ81WYD3hg4nElgChMJ3O0VwakqskTeASBkZdg8uc2YY4avbvR44m37DFnsjbzAsZHhR4CPaEJrWsJCVXz2zgo3r/su1sZbSWYdi/T3pY556EDAkGccs39hRSkKEjnpNKWv4NtAy9NixNGZKskKk1cIthcHFJZnMX9zKdP+dJhcx3j1L/egXtBtF6PMv7HMi4VPG0hJGcqtWoJemqaFMVe3wo34STSk1rEim4eEOLsNp8UQTFVYdLTT8vEwtWVkiS8s6zNqil4LFjaOX3BHJGEW599FH7S3RHqrlKFC1FokV4sIxFafKNJmDchkwI7FStvRVkV4IWfn6zqkY/shwI2YRXfJGBaGRDDfmpLIu0wC+pvzZeD1BLF6d8Ol2CtVosINBivcGkhzbHv7vZtu98918YY0KaN/80xz4nfkY37kUKmDrZp/xBN+Uw+g8hJ02Pgt+5BvwAuLoACyjgvFk9chV70TdraYewq455mfClHeHs/ptkwRk3tChTSa9Vc4jRXNcT7SmSFuuFy/WgUWIyfGLv2AKx9kTPIRGT4XsCegK1BsmIkIt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5143ad4-aeac-4271-4287-08de58026fc5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:01:02.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yw+N9HDemmUK3ge3djU7WrLX/kW16XuTTD7VVQTFzfu8bmsPxayTSYCze4smslB3Ug7G9A8YgybIIhFJQKRNXe6BDlHkIoZvaMNqNaOjjxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200074
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA3NCBTYWx0ZWRfXz0P0f5iIbfiL
 Gpo8RxRFTB2pZAJ9PsjY6YIUCWziXOYN5mnQFnKdePZ305xjI6yvDsm0epYc7DoWD9QOzkTiPHG
 zuiQPftNHG5ZlyPwUb+/Gy5RoleaVEkNggP28LuBzIaVpTUa7uMCghwc3xmwtnjfhHNTraTC1H/
 TKjcINFJv9tdZ4zz5Xfby5PlrNb65AsypkD33zHPhvGQGbV+DQ7iLFUsyAxU1C5sO+7qxJ05A7V
 SEXA9j1O3RCk272Vs9LpuTnWvcdp46fKgWVmOS4bpHFDzEMa3CfqE1Xo1YWN51AgvQNG9P9wcLD
 e5Sj14WYwg244wuJfaW4wtoE8qBQWZkimzRGe2lJTfFRx/gHWJH8dpTk4bZQGv0D3sKbCNRK2jq
 Zs5uUGYq/X68zH+G6zs1dmMBp1kNvSFRQ6d8ufkuC+ST+dsfmd0O1e1TIA7aDwJmnF7eRVVEzOo
 OEZUSP1a0MWSZ9Fsl6w==
X-Proofpoint-GUID: Qm9aUTlwkp34cECfkHhUsotJ6QDCmHd8
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696f4455 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=k_Svyaa291FHkd6FO40A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Qm9aUTlwkp34cECfkHhUsotJ6QDCmHd8

On Mon, Jan 19, 2026 at 09:59:51PM -0500, Zi Yan wrote:
> On 19 Jan 2026, at 16:19, Lorenzo Stoakes wrote:
>
> > We will be shortly removing the vm_flags_t field from vm_area_desc so we
> > need to update all mmap_prepare users to only use the dessc->vma_flags
> > field.
> >
> > This patch achieves that and makes all ancillary changes required to make
> > this possible.
> >
> > This lays the groundwork for future work to eliminate the use of vm_flags_t
> > in vm_area_desc altogether and more broadly throughout the kernel.
> >
> > While we're here, we take the opportunity to replace VM_REMAP_FLAGS with
> > VMA_REMAP_FLAGS, the vma_flags_t equivalent.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  drivers/char/mem.c       |  6 +++---
> >  drivers/dax/device.c     | 10 +++++-----
> >  fs/aio.c                 |  2 +-
> >  fs/erofs/data.c          |  5 +++--
> >  fs/ext4/file.c           |  4 ++--
> >  fs/ntfs3/file.c          |  2 +-
> >  fs/orangefs/file.c       |  4 ++--
> >  fs/ramfs/file-nommu.c    |  2 +-
> >  fs/resctrl/pseudo_lock.c |  2 +-
> >  fs/romfs/mmap-nommu.c    |  2 +-
> >  fs/xfs/xfs_file.c        |  4 ++--
> >  fs/zonefs/file.c         |  3 ++-
> >  include/linux/dax.h      |  4 ++--
> >  include/linux/mm.h       | 24 +++++++++++++++++++-----
> >  kernel/relay.c           |  2 +-
> >  mm/memory.c              | 17 ++++++++---------
> >  16 files changed, 54 insertions(+), 39 deletions(-)
> >
>
> You missed one instance in !CONFIG_DAX:

Yup of course I did... :/ the amount of testing I did here and yet there's
always some straggler that even allmodconfig somehow doesn't expose.

Let me gather up the cases first and I'll fix-patch.

Thanks, Lorenzo

>
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 162c19fe478c..48d20b790a7d 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -111,11 +111,11 @@ static inline void set_dax_nomc(struct dax_device *dax_dev)
>  static inline void set_dax_synchronous(struct dax_device *dax_dev)
>  {
>  }
> -static inline bool daxdev_mapping_supported(vm_flags_t vm_flags,
> +static inline bool daxdev_mapping_supported(vma_flags_t flags,
>  					    const struct inode *inode,
>  					    struct dax_device *dax_dev)
>  {
> -	return !(vm_flags & VM_SYNC);
> +	return !vma_flags_test(flags, VMA_SYNC_BIT);
>  }
>  static inline size_t dax_recovery_write(struct dax_device *dax_dev,
>  		pgoff_t pgoff, void *addr, size_t bytes, struct iov_iter *i)
>
>
> Best Regards,
> Yan, Zi

