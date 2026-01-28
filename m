Return-Path: <linux-fsdevel+bounces-75775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHxmMYs9emlB4wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:47:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 427AAA61A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2803330431E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2682FF661;
	Wed, 28 Jan 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G7PPwhgr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGnLY0Q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CC2C21DF;
	Wed, 28 Jan 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618721; cv=fail; b=ObCrQzR6AWLrDEGDpokFy3dZ7mJjJnhGNhBcHgKSsfAuzBcBkD4BtIrP8YeAMMIZOG+9AQxz0ikJ+sHmMFHyi6VKf9wMVKkYE4DV3efRmNdgsrckW00vA1ymJmOGiTByAiJ0jZwd8/RgszpsPm5VLx2Ap54ZZSdUkLFcd8gbPEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618721; c=relaxed/simple;
	bh=BgP4n0Cf54Zp8Vf/uP4IAL7Kkmno9v4hA4n/WBOwrQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LUQKQB+lxwQxqJVKtiwNTukNQ+W6L+ShMHbhDwPYSzB3yh5UPTQzYqXpH9GS4v5EqBQCZeljQn3vGQwgEH8/EPMB2ozT3tdMGWG2n+xq3fKOGJsF9grz/ww7dP7MC7A07SM2eBFISQyvKIjYzv5tLJSFkxQK8twyzVx7LhBTBS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G7PPwhgr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGnLY0Q5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4C6fC1432082;
	Wed, 28 Jan 2026 16:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=opu0x7FeVMzcAlmS8d
	PWKS7gc5jBEPD0/D78+u6NWys=; b=G7PPwhgrLKw8QEMf5XWD7w3MJbyJxiUq1W
	+JXWNq7MBozkvpQldYDKVmynYdLZ/1oZaivUpfEx8AnN2R4ZHd7r4xH+g05EGO67
	f4rhssNNT8xssUIieKgYwUWUykxUXrcGI7ZeIZdyXy0KcoVSkjbY7GuW4yW7UB/x
	XcZvtmaDSeIquxKHPv9/VAMAl+AloKezTRK+/OEnSWEVUHJlZpuW/xz30zth8wh5
	I+B5cy2FMeyUCmKqG7rdqGPd/SqTJPd/eeTV/sU+4XpVR43kn7OWaMBJ5bhbsZzm
	seu0VzVVycUiUEnG/tb0rKd2rGiWf/iWE8oRPnlUeVUGwGJjsNgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5dj1cah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 16:44:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60SFNTUZ020001;
	Wed, 28 Jan 2026 16:44:24 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhgf1xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgbnES/GllpFsPIcUf2ZE+8NUlvVBLHN+iiqs17JnhoTnSm6bkYMDLby5ohGsY4W+/hcVEHOprDuzPsWs4TG7PbVIbYAaRJSdSgu38My+bYFEMRhrgG52BrLo8pvFLU9e4f3waaQzLRDGJOiL6a2tgl9t9e9WeOCaKN3D91FZ5ulmToeqsl80vXarfwRmGP0TngWW1jtaZ5/5BobLUEWccpzxYlQl7gO3iH1q97Y01xNDSEOAJ8uwW+4IsFir3I373dTYcy+5Stji+cKHHzmpzdP/R2eGRGNCJNXsExeggD2KVePbI2s00yyWGPw4pCSSST4UUkSVKuHt74YertU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opu0x7FeVMzcAlmS8dPWKS7gc5jBEPD0/D78+u6NWys=;
 b=XJCmWpo0h3xO91lLF3YTtium4zRa0h+KrAjwEPjSarfES+Rexcfs+h0d7tgpTjsBfmfMQfpm87uW+CkSGhHKE5Zc0fOiLBw0jystcJn4QRv3Wqhmg5Emv15PS3URuTiLEuPr2rETj/rpQAbXk3D7sA8xxI/KxzgpNXtbTc0USzGLysL6lLBUjsWrI/h9X0/NwWoyYFBSC09KeQkil4uDBoMuOSpJ9ya3q5BN2j2tNXiOKLrRQbisXplcxFXdPdob0ICdnqXF4gvVlQabu8z87jWnwhf2FvT+4okXcFynwxa7k3bPMBBnNVmmjfr1kyqoqky7TrCvYkGiAz4bIqmCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opu0x7FeVMzcAlmS8dPWKS7gc5jBEPD0/D78+u6NWys=;
 b=fGnLY0Q5nmwq0s7XFHIg9VFkzWvpWWBCUtHfhTG1cQ5w74T/6O6QLTTK7P42qDvUDnG1pLcJs3YmUZB1mMIrTwKMSDM4DPJDZXdksvFxY03iRr17IkMLH+s11Avb6eszc3yfCgsv7WRkWLgD8FTOBnZcFnW/0YyA5MnB4Hv3htg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB7198.namprd10.prod.outlook.com (2603:10b6:208:3f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 16:44:15 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 16:44:15 +0000
Date: Wed, 28 Jan 2026 16:44:12 +0000
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
Subject: Re: [PATCH v2 07/13] mm: update secretmem to use VMA flags on
 mmap_prepare
Message-ID: <3aab9ab1-74b4-405e-9efb-08fc2500c06e@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: f93b3cd6-62bd-4e6c-3ecc-08de5e8c78ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nfd4jrR37+I4JjuqOag+LkVrWVENa9nJNfakhfix+8ewq7mrgPq8XnusvV24?=
 =?us-ascii?Q?ajV1BW9RDrAV0hP6YX8lOV+l8Rel3uPN62kWxiN8Jo5dpMv1/B2vpk/4GMHA?=
 =?us-ascii?Q?hoATZ6aa1UR/WeSccQZSjYpBs51/HhixSyIsys0LCD99PxTvkfcqg4GVBsAL?=
 =?us-ascii?Q?sva79tXOiYvX8IjXv+nt3E8wxBJrVimBMnQWqa9akHji7McHnK8l1cS2C3R7?=
 =?us-ascii?Q?a1mM2we5LQKULQIVo5wHSFVvDrgAM+PKDa3LqBhbNYaE/NzDEH9+QbIFcieL?=
 =?us-ascii?Q?5VCm/ZCrS214WKw1es1SPCWoMmDmhkNhG/MwdYLg3Hj83iZqYhTajWmnnqGR?=
 =?us-ascii?Q?gBXiAcnWeIyBroCmvV4xdU1ytQAWFtfGDZFCMRkV0WX7I3A5hF4bseOjGWQ8?=
 =?us-ascii?Q?qIG8aP9diiO10c1j0d09E72thGwJWNbNwJjC2E7L6kCCl//ZGAUVaz2s89sl?=
 =?us-ascii?Q?vAjbqSFjLzO9F6/C3lCrDf+mwumPyh0rvp2aRzBbdtov+zdkHOYhnkrdnjo8?=
 =?us-ascii?Q?/NkhQsm0iGZD6kSfeVYyTGTriVQ0MyhrdacH/RkcbvjKYb+RJAw87Y4/7pBS?=
 =?us-ascii?Q?rIl+aurA7XeM5tTO5ZRxWaal6I7o+qKRXC1ESMATH00301SpfSsjQaROcHu2?=
 =?us-ascii?Q?DLXMKn0UVxfMDrSmOO6itAzo/7TDs6Ap0271TXbLl2M9Z8iOh06DzbQihebR?=
 =?us-ascii?Q?SFGLcuLRn7WrkuftFGybtdCAnssL4QB/lNBG9vx2wzM7OovcurKm+92O44Fu?=
 =?us-ascii?Q?ETXC035vlwbAEfsR4Zde63XXRywvDpP6URPWTzmFEUnGP18KbO/pKRSAOMpC?=
 =?us-ascii?Q?imSW0yVpxaYeJlXo0tt/aJtZ+QBcILWn01ygX51cwf9WWlNvZcZ2qfhIhJE2?=
 =?us-ascii?Q?Hb5IJGDCqqP7L2ZOuNPUlkHoT1N3DitdTaOrcE4IleUDJgQ8CwF81ZjVfqg/?=
 =?us-ascii?Q?Coij5W7OwA20zAgFiFXsKWODMFPfkXOHyDV85LUWxnADG60f2thmaOuPK/Re?=
 =?us-ascii?Q?XeX1BMc3kZ5ByrpPxQ6AdCs/KYggAOfaLsrQceYKqVpLYqaQTEICBI0pQbO7?=
 =?us-ascii?Q?NBToZho1vaDJ9QjWmlccYeS6qsUbQPI/+UPj/E79xcPzUwl0zMJHhadGOOpH?=
 =?us-ascii?Q?80fK8d58Ru5yCPxInGcRoEqx9rqUah9RO4Joryxladp0waT2Q0nPJVvg7JpK?=
 =?us-ascii?Q?ILcI6XQzgGUCWl+4QsKifkhg+Wmv6bRjI/0eAeUA4BNyfFYO3bE/EcssheUC?=
 =?us-ascii?Q?iR8kBDJ6fuESnVjuCZ6E0L4JYkR2HrBdsBP9hGDLXUJO8ZlEpHtrVpsr/ha2?=
 =?us-ascii?Q?6IH1xYlIldo57Vj4+3r4fdAxANXTvtX9wpYSowPwjfdJIQKxtlW3qw94yr7K?=
 =?us-ascii?Q?9QBPdy7dUywsNZVLYWZnjwLa6gV8wYN4DdNL6l+N7WePPmISoMvjWglxQpQC?=
 =?us-ascii?Q?LRLYBXft420t2yovf+5iVxkhbfsxUyBez8RlBBjYvCE3VJXwdypAHptjzjxM?=
 =?us-ascii?Q?33dWXHkFCLK107O9RzCn3jDn7XcUIo/7uYZkziNa7NzF7tFJZQzEUXMMRvrT?=
 =?us-ascii?Q?uJucOKlyZ5Z2fRDSrnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4G/hEbqprUEaZgXH65Ikvwor0IWWvhxOyThD2pNGHWD6eZDd4zb98gzFXNT?=
 =?us-ascii?Q?XV7JlUTyj1vyDsta3ST2vloDfDF2+LQViGFQ4D68YY+uUIbI4iDgrWWaJEsZ?=
 =?us-ascii?Q?iTMzNMdVADQ9QHHIzhp7o5JPJF87POYZ5wavHhdToCF8MlJzMoPnJVCKtuwG?=
 =?us-ascii?Q?3tLe+Y2QMvdQKxOTJkKzVOh/9QD5VCG8Q61eXc/I2EPxGY1wS2yVFCq3jGou?=
 =?us-ascii?Q?5/egDA5Ip69H8jC7/6HXTJFB+GzWa7kfARLPezGXEhJDdhE4zEwdHNgxcsM6?=
 =?us-ascii?Q?HHAifDzXcp2YQZUmHt8ecFcATzhige1uYAywB2112CHDNZW2FuSOs4OaTd30?=
 =?us-ascii?Q?ruGEbXh++H6TL9XSxMR1a2xesdbRmbndCPBVrsGOjbKc/R1jWzCgxlhS/BYQ?=
 =?us-ascii?Q?Ac1ufAH7BlhBhdISw/ZJ07Ux91UunmAfc6aVrCxCRHpAzo08u1SIGEyBZsN6?=
 =?us-ascii?Q?MPteu9wuGX5GCDrwIOUNAJ6F0v6eAnYJzCu0CHEojQh1K2qc2EZGcw2FFU3d?=
 =?us-ascii?Q?oOzdev+8cxtuIZZNlM71iTSIrYQIwBh6YRsfCu6U9AlqFk6vBLeYLprW+0y2?=
 =?us-ascii?Q?ODBVS99AWIIMS67rk9id+NVL9q7/fSgpMoVXL+Gjs+fEJkdiqiTIxI2vwIzo?=
 =?us-ascii?Q?kjzSBTEfF6SPw+b+hwRQW0dw94elC9yS+mx8tqCwgnhSWth4MBixn2Jzsc56?=
 =?us-ascii?Q?p77saWxXySUcVtxwOCdMOt+8zsJn6DpZA0R78QunFBPZoEt4o3RxG+bcU2C9?=
 =?us-ascii?Q?Cen7ZE1WGLPs/e/KsPd4mQHWrZ9mQr2Isu2715UZcS1y6KtyPDUZjRL4uOFH?=
 =?us-ascii?Q?elA5s/5HFsTpKy1VZuL3y+5Sjw9RBMaGXLsReNKkxDEDKh90j+G/MIaYPx7m?=
 =?us-ascii?Q?98uYFebyKez8LvVVOc11LMt2HgbjPKyyWKhC384vTvbMPZ12S9Y7QEFrZKYQ?=
 =?us-ascii?Q?Uo3cyV5vSpNS3sqRfJ3X2MXnG81PW/aK88lFmfXxzD4QH6TSqQUu+7hEj5hG?=
 =?us-ascii?Q?gFTMFTG7TnHhhXUKDG6eQULlnarFtiYsbb42C2Rxk7aj0n9y0DAG+9gV4HlG?=
 =?us-ascii?Q?7xeoCNAsuAO90fKTSJ93op1o635zcVNWnJjQQS3MIpWr9WLEJAgMkANnO6zZ?=
 =?us-ascii?Q?S9fslqu1q/lF/3SF004ixL1tU4Q3Q+cWw/7KQC0E2Az3t7rmNTRoUX55Hkbk?=
 =?us-ascii?Q?HNYBYs3hL6RlLaxT9S7cEJjO5jgGNaaya6VErIGdAixfWbTsaiIj2eNNX2Ww?=
 =?us-ascii?Q?H4spZlyvk97G6Eed2t6hT0KOXf9BZPFyh1o1JkXg5oeEsvAYKGJnqJ1G9ffM?=
 =?us-ascii?Q?kwiGiHpRbgDyIMec3f+bRNz2EgkKJ2hCOVDZLJzk6pMzN5w7iKEUx0bQyXmo?=
 =?us-ascii?Q?gyiTDL61tLJsNcTyDxAG6v3j3HwGyn8D9rpbA2MP9DYCqqbnAgjG/BvWZURg?=
 =?us-ascii?Q?vYoiqgZTWUJr66m5sSZKXL/SPCXsXFGAbd9c9br0eRrN2SCTkUgmWb7lkcF/?=
 =?us-ascii?Q?zJebMEhSQ8sOtB9DpJaQa9OaB9m0kRU29MA3tzBlc6E6mgycXH9OI7YbFtyV?=
 =?us-ascii?Q?GVopTtKJAOItYFpP/oc/of7TkVoEe2BY0MKnUue6Yzr8/wRWzxRTpe0RbUNa?=
 =?us-ascii?Q?sSASe8EmRQu2CoRXk1vE9IeYF/4JXzvEJJMzAuJgRgSDXo0aaTSSsPoMN2ne?=
 =?us-ascii?Q?xp8jF8cYzeN7I8WpeCCRUuAeE6tinmra1Dxav9wMSmAiID6RQVDgWRWlN1qe?=
 =?us-ascii?Q?lr0O5FlheMIgYhmzK0L2LsnUyIdhRlg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UIMhI4yE04TGD8YouozrZ0ciab4Kwj7mhubXi8fwxyCUi0OyK4Ac96RARKQcQyKgkpv9K1tu1Ys6K2p5cXNGeboxLhOeZrf8tJ0xC459En3FdBf0S8/gjJdnqefxtjx8SHc3vREd0hopdHYt4s7FwBpkMNegW9b1MvnkY+ygw6/7xfZmLfK5xlAp0SAIukLkplvnvKuBMwLQV0n5Qm6W6gYZ0F00W59NHjhdCwvne11BVS3+RKeLSVS1Gm163svdKq2Zk3DQ3wqtiK1o4APg/B4NL9VvqkPoNP43HQM6OswYur0MrIOdCOVCQ7lCoeQsJzGNuA2Cw3SULNJm5UYRjCu3PpDwGQPzNglMhiWlLkSGfpe+h9mLOI4+qUeeDDrN9ygIMymBcLJ6vUKDJd3sZ5nE0espktBUGTRPsSvJkIM1C97eBwXyuxZchuYzE7mXdIQlgYpWyqm8lUBBKPncBkRB1U2lL0wEKP94EHb63JRCpgl2aqWwuaskP45t4BWOU/WwfJz3AYlhPLcHVUGcb4KdEfB6rMGlTvGSAuEwo3fid4m/vX9rSXcM0Pm29+ssidYy9yrSdovvhde1/3cd3PS4M23COXsi6y8BMuSdyyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93b3cd6-62bd-4e6c-3ecc-08de5e8c78ec
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:44:15.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3ma2GMRC6GWNaDE1YJ81RbNfpAVtVWo+6eTvANoLL2VB6UACrpNKM/7LthpEXUB7TLJ21BsLQPCBKQYoQce4DmEj9jvUL/vFryHNIldlgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280138
X-Proofpoint-ORIG-GUID: FlZPLo73qH5dlmnq9SqtNdXqvFhWjvGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzNyBTYWx0ZWRfXz3JaJCLZI9Yh
 plFd4btUPADJWMSeUglpMWbTzcrt8ZxW6+LJZ55Pu38vougQ5HCzmNiqnsOfi1f44ZzEC0hawkH
 Y9camBZlXXVAU8o/o3VwO7/EbeykxXxpXOUaS8MofhlRVfN8nUvnSWSn8vfFs+ZKY5AUHWoWj/K
 kRGeEuXkNtZQQSlr8sjGeU4oO6cm5/BPPgQl+497PaFevnqQ0KqbSBKg+6z7Rk1JBLWw6CHHW6l
 wu8AeKGlqtN7FRLvVG4W50j2aW5+K6RnjVFX83L9+zkQSP6AEIxZ+z2ZQIgL68c52nOaH74RqEp
 T87CqNtkOKAUU09G+mBMozlbmxmxC6VDv049EU+IdclzjMJqxaRZvS6xGryQgbACmVQtOX/1061
 ITvT8CfiFk2skfqEg9fEFlx7yWc5f2TXKoQ2S+7Tn7tPElw0flb+omqLlWYwo9oXhN03zCUgapM
 hKD3gh5Hl0MiLlrBrX+StKLm6ZCit3mb3G23XlKo=
X-Authority-Analysis: v=2.4 cv=IrsTsb/g c=1 sm=1 tr=0 ts=697a3ce8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=REBL0svVakopdHju3rAA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12103
X-Proofpoint-GUID: FlZPLo73qH5dlmnq9SqtNdXqvFhWjvGL
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75775-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 427AAA61A1
X-Rspamd-Action: no action

Hi Andrew,

Could you apply the below fix-patch to resolve the issue Chris's AI checks
detected, I missed out one caller of mlock_future_ok() (a very human mistake
;)).

Cheers, Lorenzo

----8<----
From 652146b4d93a31bb6f9da9428ddaab8a4a53e170 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 28 Jan 2026 16:41:55 +0000
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 354479c95896..5dfe57b6d69a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -108,7 +108,8 @@ static int check_brk_limits(unsigned long addr, unsigned long len)
 	if (IS_ERR_VALUE(mapped_addr))
 		return mapped_addr;

-	return mlock_future_ok(current->mm, current->mm->def_flags, len)
+	return mlock_future_ok(current->mm,
+			      current->mm->def_flags & VM_LOCKED, len)
 		? 0 : -EAGAIN;
 }

--
2.52.0

