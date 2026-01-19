Return-Path: <linux-fsdevel+bounces-74540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 821BCD3B985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD29A3074682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8E2F99AE;
	Mon, 19 Jan 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ra+ud70j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tOa9m/FQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCC2773C3;
	Mon, 19 Jan 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857626; cv=fail; b=YNd6cA4vrsXqsIJiVFPuLBbi2zLRdqTiqN7GVlo9wNkAah4H8/a0ViN5Al+bO9PtNZgVGJyhExoM22OYCcUNJQYscfVLkEUPemmY1957eXnPIjNVBTlNR9CcRnfX9zzKmbHdGS/bo378k0iJBszC9JqB3eCNNdUMe231OkR1TJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857626; c=relaxed/simple;
	bh=9z7vSlYUBIkFJi7tJHX2skekmso9dIcZZ/R0xih6Khs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdrGCrnu7Q0hvvnIQRgQhff1dkok+arAraUqr9fPe7cQpXjraVZKOffrd62BMktrcSfr8oTTyb7x8RolDzypDgOn+clbds3RIfEXrIeZ4Xph/xbxVt74DtOZs/3cY0wKFaK+d1wsR/EiX3Nvd1/yBYOZ2Fg4txceDqQqlJJ3VNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ra+ud70j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tOa9m/FQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDW3M1512488;
	Mon, 19 Jan 2026 21:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UyEoEfL3TTEPL0jXTixCoRIS7NI+4KHS9j7GvuHEC8g=; b=
	ra+ud70jxj9L2BEuG0y/LZlyeZlczeVlkAYFrTHF07zcZ9WsSJXihxU9sCdABb5h
	vGsBjYAVVieinOmbqupgX+gGRfEqPEyyF26FqmhWAbwg6B/elOv7CVVCr+H1vs0B
	B4LkjPbcfMe7OWJA9wj3TCixSPFUjGasL5GCh/7YFV2fFPyRcWs4i3wTtJcMx95j
	WBjftrlQ5S+HOK7DKIFLyGRKn/2YQ0WATJVgxncrQqUH6IWixTJ7/o95mGitolb2
	h4uR3yC1d7EEWgYhPAImOWAiBGP/QcGy/lgx4tvyNdZEa7v9lIVycJKM0YkJGjmF
	10QqQIuySB/5VLqGnGSi4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qas1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JLDfoR015518;
	Mon, 19 Jan 2026 21:19:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8sb2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 21:19:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD0W9ZVilJ2ck1VxL+3MoL8CptG6syIJLij4BUGefROR98kyeJ1KoAS4zX0HTQgBT3fwE9MuCulaOp3CR5dNQCUvXwRwOxKD2dlutoo5ipKEERruoBJTVIjvhniIcgel9dKhRVPpFS7f+c4cmLDJdzcKBW/PKx0zOfcfL1NY+CNMBg+8pQNoN/hh81ux0YvhpeFZbwC0MT54sU6aHnl/Z2ZuJUwJ4PoDin/kJlu+0/3bs4p0tDtZ4EIUrRngBQ19xJmwimm7BNEle11Z6Cya+VCUFgYoJfzLWB9Ypi77DK1ZercVvZyej/5o1Bm7OdSHyzZSwnSs6O31pDP8wIihWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyEoEfL3TTEPL0jXTixCoRIS7NI+4KHS9j7GvuHEC8g=;
 b=lzSgj7lRzZvuJ13WX+aJKCS28R3QmWH/8HUJtZy67wwsm7lH1D89kgzs1/F/ZSJ6Ciig+fwolvE+auDgG/d3qehD/eaDR6jM9+NPotwUAgH0MaHA7klciRw4dOMXWyOxeVzOTCFyoTuO9HkPvRMBqGkytr0HXz8MyVK7vKrl9UivWJOKlPHcHZdPrijIa52udN0qgRCFY28EN3HP9t23I2uekP9rh4uBwEu4bp7ZciRL2tnuOSedV0gD/0EwklVqS9hn7lo4tP+rq1N3a13eqMRGj0kalh/N3Qvm8C5gXqC6IPyebJoNFMwcnMbz4JIWwUcB0cbuLrjweK0huEZCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyEoEfL3TTEPL0jXTixCoRIS7NI+4KHS9j7GvuHEC8g=;
 b=tOa9m/FQUQpLKbv8tg2aKchEfjeXwMlM9+Ah7MyH4wps3GlkM6qry8na7gZOAj2k96bcgwKoPSJvExIBYsrPnQVyTdciXMgs5sEG1V4fJElu0e/VlnRV/oavIYpJVDk6AgFYbIhlwCkW9dzVx1rxHh4woA4HUSYXA5kTNTugVt4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 21:19:20 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 21:19:20 +0000
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
Subject: [PATCH RESEND 02/12] mm: add mk_vma_flags() bitmap flag macro helper
Date: Mon, 19 Jan 2026 21:19:04 +0000
Message-ID: <2dbf01bf3538e13b2bd6125e6723165a94eaf06c.1768857200.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9077c919-6a3b-42dc-7753-08de57a06942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hm4CkGKUtC/FVYt9z27rRprV8Y3Yt1xdcCNRETIVT4haKzMePqgRxFU/B7UA?=
 =?us-ascii?Q?n0Ion0vIKxmPkTEY2RvUp58UyUoFDNm4dhmfVwwDqMtkf/r6ctzWX9SQo73o?=
 =?us-ascii?Q?I12rAfQLNk0MN7dOLaR7CFrBXEp1/DVogHmmQ1HMkcInxCtQaf/bWCYHidOG?=
 =?us-ascii?Q?ALBTHCeL3uIVy3QnWNcOi7a0Pugbe71qsGXgUr11QjU3hXqIb2ryzs9bD3xK?=
 =?us-ascii?Q?14IK/AqVvZdNopVyPZd020rvCQJ1mZxY+1FFThBJCfb4rTu6NLl/FzaWipz7?=
 =?us-ascii?Q?qRD3EEo5IKh2yhPhNF+xW1zZW0tXP6I6wlWtRMh6bNuJqaCB1I+lMfY26b+c?=
 =?us-ascii?Q?d39Qi/NR6mMeVPrD4NzkQ7ZlODBackPtKQE2WLmM3TM5Mi+dngN/dekhw7ZM?=
 =?us-ascii?Q?hF6Es6PKvG6CAfv3uLvqztL/YTSZ5MNNbV+N5Okk/wBxvIm0Tq33U/wmWrO9?=
 =?us-ascii?Q?L95y41owa6ZCCyafNxaSTh2AqgIdQUaG3CxAF6KdsNmBNrmTRtrhZubRxuQf?=
 =?us-ascii?Q?PZUfS7SGcRdwy0wnyFJFXzlJHdyg31qXI5IVsee3iHN/UHfZdJvnIEPzFdjT?=
 =?us-ascii?Q?yA10u7VjbvwEvGjYy5OT3rYFWypOsGdMgqj8LiVUyFZnBI6LjC2H1zDfh7zB?=
 =?us-ascii?Q?xAeFsnDAw7Mks21ZhJ2DnX5M+hXlrhfYbguOTXjNR/5DyeJp8VBE+7221BFb?=
 =?us-ascii?Q?g0RJT9gwkaqbxHj/xzpCi2Izr3g5C0H2rsursszjaY4qxkxmQhRouDaFfYcJ?=
 =?us-ascii?Q?5RW69EMXv1OLcLQDPryE4TVVq1lJ1dcW3jFnRx75N4NI8hzkjayckZd4SDey?=
 =?us-ascii?Q?LNhVYSebl9L3gglv0WVgHTjghK9Cnq0RgEOHN00XxYAd3iLT16emrfngPZ28?=
 =?us-ascii?Q?RwiwmSeFPzh6A5Km9SnkTGx9X/AuV4Qd0a8q0mFosQyhdMPTIekvaw2Kvsz0?=
 =?us-ascii?Q?NeYuFdeIemwKY2PrqyKrO55KAmMs8T1qdYko3cVZ7/uuLvvxIWZRnLm9oDJw?=
 =?us-ascii?Q?sLaJtKSbCZwLVC3FHDDJSr24IEgyp52gSOTS81UrkJcHUXCkpBIBiHg05Kn0?=
 =?us-ascii?Q?0feTw+S5JvsvBWeGmkHTy7nT20jXHxj0jLd5E2iDw8C+nvNT2V3v2KmVZGeJ?=
 =?us-ascii?Q?rlCodpQi6wpnUyw4fY+u+Mj0sRnF+7blKwZiLuhe6LDL6WVl4hy3CyXYRdGt?=
 =?us-ascii?Q?vtrp0PLdLUlKSYennFfV6L2qtVSUsOmDFd+Jq2p7YKx++BnHe+aNwtu9oWBu?=
 =?us-ascii?Q?c0GgpzIvIenzoB2myHU3uAKEQfegwxRpFnleadYLLV4Xl4SPqgLw1ow1yhIZ?=
 =?us-ascii?Q?dZe+BAXv8LfwKp4TzAmvZgLJeC/KeVNcxUUa8rKOcwD91AbtcCn64+k0zwCa?=
 =?us-ascii?Q?xJEpAhpWowYD9VeMQRTjjcA5pJsuxlokrpslFgmPyyerH4GxBcTI3VIQTtRu?=
 =?us-ascii?Q?pYNPunabtqDKKWMcHN/LltW8kpM883ZyUcvRruJmsKXXVjyj2rC75i27b/4R?=
 =?us-ascii?Q?5XbWwXlDoRSKVS5STA+fdZUsHHKa8O1JDXYlHO+7vXUvNZSQYeEQ1vVpXgLW?=
 =?us-ascii?Q?gps7RzPHv3JXh/I5Avc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ex8Gaip/+6h2nnLJBpDlcykt52+PE4tFqwnhN4BgRf5nqzGFiPrzS3RGT2br?=
 =?us-ascii?Q?ikQ+iqU51LVAGFn/6TyEwLbg/ss0pxQzOIoeJYX1g1WF/tMCs9vwr/2F1czE?=
 =?us-ascii?Q?6tOKOmYs+nfRHJkpZUgKnjLZ7L/IYX68LVg4l1T63/e5tBYnGRQSBrdY8kxq?=
 =?us-ascii?Q?HffRreuTHb3y9G/AC7vVtKyCilP78ew7RthtL33WUDn7WWv1a6Et1xId7bMT?=
 =?us-ascii?Q?PZT0zC2kO+jVtEJFkAQwyTklT/q5AzrVftslts+l/H2hoy1enSaK4aaOX4Ip?=
 =?us-ascii?Q?1hE6ByuZbJpCKU/+zpAFPXMUEYABW42MqIzkjWXXyjwJhdkCpGFvhnSWyTi0?=
 =?us-ascii?Q?bIw5pMFWMm5D89nNbxhDSo/CD+rgregQNA+sU/RU8J5dWmisP15JdV2kBrK3?=
 =?us-ascii?Q?ieLxWtOaiV1jT10tSz0v70QLPJrl3u36RW9zlV2SbTPdMSX5BgWgI/IZi93M?=
 =?us-ascii?Q?yPixGRaysDp3F5FUhG+KojFEOdk5WCjVF7GHF+tyytyO4Hdm54ZN7uLvZYbw?=
 =?us-ascii?Q?IwplfxyfFM85HA+cFzAdWgFHtLIDbTV0RC+CMaJMgNclxOqrXJOZIHxP+EKk?=
 =?us-ascii?Q?Jh4hvah3KnwsZnOqBIfEg+GD7ZhO4vNvHcLoOOYIVBH/hI4QVDJ1DWcBoTS3?=
 =?us-ascii?Q?5kzVMaoksGLF0xnGArdgZGrRuzzk+6iMH/2poW3rYIcaTE1f0AwcStRX9j+H?=
 =?us-ascii?Q?GPohEVWb3Y/2Rt49fq6YQ4OQEGYRUvyvba1A29wc2E6vV5xwhlnsAzjHpxRQ?=
 =?us-ascii?Q?5KBdRXFfRjnhlXiBVx04/jjJAs5onC8geE/GCXkRk8446vfCl+Gi5AGAV4tg?=
 =?us-ascii?Q?68/iUHM05Z0ERjDONg9gI80YEsrSSt4RyeEg5YHKGUTIET8m0mSHlhzG+JNT?=
 =?us-ascii?Q?CG1WKGQJc47Aas60qwK/JPVCU+7lp+s5WZXxaqgkj95KzOqakb8hwwaz+ggt?=
 =?us-ascii?Q?TqOD85W5Ihbf3OGnkhh1duRiIxyQRTx8HFtkztrGNmMIhsttZBcvvYix2s42?=
 =?us-ascii?Q?ek2lDe9qEhZYwf9PKJ8xcsWxCD5dxxS8eiN5RFMtIC7tez4m39Fs0hFj33La?=
 =?us-ascii?Q?JQo2n+oK4D6SN7t9RuhXGRPvl8P1hIHNyNdNNdc5i+bPGSBuFYGIwoztSgwR?=
 =?us-ascii?Q?oeVtMBJMRhRbdMYwIuwfTvL7IBUEZSJBP/9J7paGxOJ36Yo7zsI5m/lrcnhV?=
 =?us-ascii?Q?q54GVB7vXX4YO6OA6GW/O/cxH6aDbz0jN5F5pGyUNSpZ/t9AjDhIHmQMK/Tf?=
 =?us-ascii?Q?gEUrRlgFZk5bdMnAX34J8uQe9Oy/X689J3IMzdbkeArrXcWXtg57BMuOhXG7?=
 =?us-ascii?Q?UWOKRv0vLEXOBbJRlHdhSrpzO5bLMSo6v6dY6dEJKwK++nnUOr+d/0FUxGKf?=
 =?us-ascii?Q?j+9ww+QkirLOME6TWLc42Pmp55gjtb0TIia6AzPX1YTZ7jG86GF94F94pvEC?=
 =?us-ascii?Q?Anh5A0uKUfICAWQJsbleprwRUpgQv99Qu7N9k77H3IvDyoHgzEveviPMl74H?=
 =?us-ascii?Q?9aLfzxTMceRE2svxwK7dR6/rNMNKKp7jsSLDIr5WiRILv4Vqx+JNyfAsGbLR?=
 =?us-ascii?Q?7u40npOBvCGyUVobNB7TftlZZk/NWuaTvsCYDz3l216tN14Vo48apUBQW0fW?=
 =?us-ascii?Q?9G/CtD4tnLOF4T7nCvpbYcFT1emTpCnehyMPynX4lkOZWDyz/2VNq7M2smUv?=
 =?us-ascii?Q?DT8buTPY3JfghRCcFBsn5pFYksdp/qXZBCL0bqMr/bgTOSr7v5JFNdjWYouz?=
 =?us-ascii?Q?u/Tl6NL2Oc7ATQWlwPrDiJV3vUkQsn4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YmY0xgjf/szL/Dr7AW2BMDG1TLZ+3+RL3eIhCp7QlkrTpnZWUnhA2o/Tem8ohJDCm6r7b3mdSlWHKXIlSn+zLXjq1bRhyF65WxySO0LAtYbKohBg6l0oEmOJAz0zPq0CWDyktP2Jp3X0toPb8erGJMV/h/DM8KR8Kqq7YKjrc0IwWZwsX0FZ7eQoYp8KafXWG1gkIF4TMFjoNqX58dYZvTkihrbmbs103FtRmZcw1AiaeQQwmLScotBKhhUZlkhnyyseRL3o4dwaw/cXymS8zLwOZY5YDcVS4sA/rdX9Hcqgmc2mAoSwTALwVtTAbZlw+/CydeR7zuuYbQC1dtYdp4oMiwJ+Gb6RAkRMWWv2yE2dmqfHlw6Dum77ZY8h32KaAeRUSWDYlrRXK2sAVnFfAgYwl84kkfig7AcqB0tesz8ASo9s2EPXWpR5NjlqKC8nqdOVECnc0cMIk9Nv9nrB+GVHrA3kwpGRqd7xSQpjfYLFA2CuDoBFlJClEvMzWfkPt9DZSDirCdSMK6qrolGZSk2Y0yuu+4StbO52oY0lPf551sqXYjfFxuaOU5ThhSCfYvVoCmRxbu6vAvQOBvvgSonsznQn2gqnAvBjETg+b+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9077c919-6a3b-42dc-7753-08de57a06942
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:19:20.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXX5ErdguvREgSMKzzRkRsu7eyxvKMuFGUkhxsaoQe8Ta4I1Trc4as+hXKckF/+lWO/QTfE+WqjFsiv1iN4EKvevKPOOQd/Lr8VnDoVcsAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190178
X-Proofpoint-GUID: 2xcCNtiy58jD32hmu336X1U93WeqPeZG
X-Proofpoint-ORIG-GUID: 2xcCNtiy58jD32hmu336X1U93WeqPeZG
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696e9fde cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=X9FSn9lvzeJUOF9phsgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3OCBTYWx0ZWRfX2sDBrSi96RqA
 MZgaqhBoBvX+mJiuhvnv2WzfR8xsYe04Ct7QnEh90SZvryEaAf8BVhBzCy2u1ZLsYlv2PyZo7fv
 Dl4uMXByaQgpRzQRtZScxOR+kvYZqkPz/NME76ztnNQvRBz2TJ3QFH1y4LIBVbvwWyrQJVHVlt2
 EAZwLp3L1kUsH9ul4iBp1siRSRzukgt3amAvIpWYjXe53XgiTTJRZHP92/rCgyy4JQDqRd3Ke4L
 eAc4qUJIgiSOVrHToXpTtmaxCgJZxjhaMf9ROOLkz5m66yBz5Cq3vGmpPr+XOfaiqGMFkDXxaqL
 kWTfYeL9fH0VBuuthwSVwyV49TitqpT72yOUuPsGYFLB4B3aMzVcuBZugodJx+XJDSHJn+9G3/p
 +VBqsZ61OOHkLf1i2WRqQOv5TxzZjreOF2akLcT5YDehCAsfqhaw3Xfu/fwOPpKoiqQmDXt4D1a
 L26UC7TI1AaF0yw+szQ==

This patch introduces the mk_vma_flags() macro helper to allow easy
manipulation of VMA flags utilising the new bitmap representation
implemented of VMA flags defined by the vma_flags_t type.

It is a variadic macro which provides a bitwise-or'd representation of all
of each individual VMA flag specified.

Note that, while we maintain VM_xxx flags for backwards compatibility until
the conversion is complete, we define VMA flags of type vma_flag_t using
VMA_xxx_BIT to avoid confusing the two.

This helper macro therefore can be used thusly:

vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT);

We allow for up to 5 flags to specified at a time which should accommodate
all current kernel uses of combined VMA flags.

Testing has demonstrated that the compiler optimises this code such that it
generates the same assembly utilising this macro as it does if the flags
were specified manually, for instance:

vma_flags_t get_flags(void)
{
	return mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
}

Generates the same code as:

vma_flags_t get_flags(void)
{
	vma_flags_t flags;

	vma_flags_clear_all(&flags);
	vma_flag_set(&flags, VMA_READ_BIT);
	vma_flag_set(&flags, VMA_WRITE_BIT);
	vma_flag_set(&flags, VMA_EXEC_BIT);

	return flags;
}

And:

vma_flags_t get_flags(void)
{
	vma_flags_t flags;
	unsigned long *bitmap = ACCESS_PRIVATE(&flags, __vma_flags);

	*bitmap = 1UL << (__force int)VMA_READ_BIT;
	*bitmap |= 1UL << (__force int)VMA_WRITE_BIT;
	*bitmap |= 1UL << (__force int)VMA_EXEC_BIT;

	return flags;
}

That is:

get_flags:
        movl    $7, %eax
        ret

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52bf141fc018..c2c5b7328c21 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H

+#include <linux/args.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1029,6 +1030,38 @@ static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t b
 	return false;
 }

+/* Set an individual VMA flag in flags, non-atomically. */
+static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	__set_bit((__force int)bit, bitmap);
+}
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		vma_flag_set(&flags, bits[i]);
+	return flags;
+}
+
+/*
+ * Helper macro which bitwise-or combines the specified input flags into a
+ * vma_flags_t bitmap value. E.g.:
+ *
+ * vma_flags_t flags = mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,
+ * 		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+ *
+ * The compiler cleverly optimises away all of the work and this ends up being
+ * equivalent to aggregating the values manually.
+ */
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
--
2.52.0

