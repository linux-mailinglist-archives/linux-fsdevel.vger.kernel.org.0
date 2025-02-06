Return-Path: <linux-fsdevel+bounces-40997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C8A29DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 01:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073971888B38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B94610C;
	Thu,  6 Feb 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqyWiDyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34325A2D;
	Thu,  6 Feb 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800628; cv=fail; b=KOAm1apW4lKHL+P4ViNm8qs8DNdBQ+WIVD8Sykr7DqPLKfSbkgA3GOCjGBGd44S5iSpVPuMuXP6LnrFZJlm3wQShYM6QyhTl9ujNoQZ4HSDRVQKD1pvnKrBBSTh3qjuM4SPcsq6vSKt4WmOnniFLJtaUkJA0HiF6kMRdKuhY9UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800628; c=relaxed/simple;
	bh=hAWeaSDUhuQjxR9TBMQk8nDaRuOV49YjzfNcKRPYCKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XRrU48imyhhO/6UoWW5qmiGkjmZTjKdSwH+JwDPijpbwdvTl5hl4mm2TcZzXcm/jGuG1BR2Jpc2EUthxqS+cGWdCZ+7elnxW2iRbPzxrLa6ozX6QwmG5nFQIN3gc0+h3BUbPua+fAuqeqVlm5oRBSepaN+pA41KZ/1odaLUQ2Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqyWiDyy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738800627; x=1770336627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hAWeaSDUhuQjxR9TBMQk8nDaRuOV49YjzfNcKRPYCKA=;
  b=cqyWiDyyRYPp0BqEYD0aAHmbMFel+Bx7JAsCDeTqyXRZoboLeKo7qRBe
   Paei4vX7kuri26fmuv7U8139w21ge3eLunfwZI+O5hyH5W2BLXS3UMYMw
   vAPYzYnYK9zk4D6PgbQulXACVhgbsBzOTxpMhmHEtOLxKmVHXGh3E/Zy/
   VhpsZV70dany3ffAZxCza+zryWzP8EC92TxE8hvpzfr4fvLKtGJhjpwg1
   i8ImYbJWMqEmnLSKb9gEiOHyOUiJCsNRaCKliRuuYyOmE21ly1cEjV5tA
   wx1xqaDo/kFuOGCcUIjjXbRLnIY7bFZbDZhjB0juX7i6RAvuQs72BodvS
   w==;
X-CSE-ConnectionGUID: l8a1XJR6RM6fY5SpI3kVRg==
X-CSE-MsgGUID: gnqzp0BwQ3iHKtntgHappw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39522922"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39522922"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 16:10:25 -0800
X-CSE-ConnectionGUID: vZqSb/V6Rbacv+FBy8vo/A==
X-CSE-MsgGUID: 0OFgLGEjSW+PTO/omdehbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116245106"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 16:10:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 16:10:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 16:10:23 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 16:10:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAXpkC4eBU0zaxQ7cmJlYmKmU4TeUMTSy9IeguuDnxKLp6hvFZQ0jl0Db7Bo3dNUCXRbjj3PS+SzGgj6Q7UzfFtxayOd8wELKJXsOow5eVHg11wUwkYdV9/j+l/7MsFXQHNyx78RkUJWSN+tsUa5XT6Zn9n1KPL05GAc7w5GsETQPIv+lWLgTM54W39yLKwPuhgDjz2vKUv9tnx2G8mD4mnWoZwGWy/MKPZUnVrBD6zSLOZsYub+r0gsytPu2Tk+kbVo0RC6OABPMKVrihVzFk+v2w+A+0VZkski1PIPP840SOcpl2P4B8RZHbFtzbRiC5PmYVgq0vnd64Dn5sGQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6qxBDQu/p90h4cOQeI8Slzx6GlmQZwCIwPzLe2KxRo=;
 b=UkBdLskk4Ys6CvB1aRY7Sl+pA2ybi5ZL6AF+DfXoYHH7Pt6MStETyu1o6D++mpysv1onERfkaKZYlwNVYKFzpz9Wg+x91iYEFNJ20/DpKvW3JVXQ7vBuotmdZzrnJeyjnYXJ83WDXfw1eD9HZVU6P/f4UGX7bSQ0WbeON5R7SZCBYiEKmOWWq4DJ4dB9AjJDtmYORQbgZdwyF2QCgkh7PIza4h9ZgkWWpaaS8pVp/VQnTeot8lpt9gaAFk/evAIxLwsQbfNhYO0F4cZi5VdGjTxW7v/Nu7s1p8PkixQvsytdZe9IBpSIkfSR3IJ9SAdWk7ZKPdOvGB1z6zDDEad0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5971.namprd11.prod.outlook.com (2603:10b6:8:5e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.26; Thu, 6 Feb 2025 00:10:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 00:10:20 +0000
Date: Wed, 5 Feb 2025 16:10:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Vivek Goyal <vgoyal@redhat.com>, Alistair Popple <apopple@nvidia.com>
CC: <akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<linux-mm@kvack.org>, <alison.schofield@intel.com>, <lina@asahilina.net>,
	<zhang.lyra@gmail.com>, <gerald.schaefer@linux.ibm.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
	<bhelgaas@google.com>, <jack@suse.cz>, <jgg@ziepe.ca>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <dave.hansen@linux.intel.com>, <ira.weiny@intel.com>,
	<willy@infradead.org>, <djwong@kernel.org>, <tytso@mit.edu>,
	<linmiaohe@huawei.com>, <david@redhat.com>, <peterx@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<david@fromorbit.com>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<loongarch@lists.linux.dev>, Hanna Czenczek <hreitz@redhat.com>, "German
 Maglione" <gmaglione@redhat.com>
Subject: Re: [PATCH v6 01/26] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <67a3fde7da328_2d2c2942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <bfae590045c7fc37b7ccef10b9cec318012979fd.1736488799.git-series.apopple@nvidia.com>
 <Z6NhkR8ZEso4F-Wx@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z6NhkR8ZEso4F-Wx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0374.namprd04.prod.outlook.com
 (2603:10b6:303:81::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 544d3815-c84f-4207-f235-08dd4642a4fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OyVzQYNXaLnfcLBXZTk+TJCDLPyoVQlBPaXHb+dDuy9/NETnDk1rQhVG3Jd2?=
 =?us-ascii?Q?3Uzs9A3/Oo88cgbeQ4Lv4vaOYsHBF00/i2x+jpJl1DXowWJL12BEDI41ztUb?=
 =?us-ascii?Q?WNs8yBvi3Bd0C+4yoNlytsgTyLZVUXjIGslWvQJiMle9mXFE/aDi/yZnxeIe?=
 =?us-ascii?Q?29nvs/waLtp7Os3ZBUN3VoBPyg3wM00g0bEl+lUOfu3j2F60+SqiXw/AvStP?=
 =?us-ascii?Q?dl7N8oheVotTvf3iFC2nMjz8MGGqknOJBOvGbhcgbxB4LFX+T2VFHpGCtbqK?=
 =?us-ascii?Q?nMmZgFuwFyux/TSwejG3hHm8KpUxP2XrJB9JNn8cyCFK6BaAtsvMLdc/TEN3?=
 =?us-ascii?Q?2EHYLUAMEPIKktPzXGr84hMLmCsjCH8rnULG2Bp4z7snweyQyq/JQGNZJwBW?=
 =?us-ascii?Q?zSMbLxjU7e5F5UoVFu5QvySxKxwFJyTykArHueFqBBmLk/0iFUquS+hqnjir?=
 =?us-ascii?Q?r1UuGJMmNXS0FSMdpWqEruw2ccRDdJxpEjqpkNJWgw/Rh/xefFtZCxttyUD9?=
 =?us-ascii?Q?fHsrHlRqx6O9YtwrHrTEFF4XQIRC9wRLOqcxHS/33T/OfZ92oXhxxTQa96IS?=
 =?us-ascii?Q?NeMtxUeZV5cB5Fx+quKs6wx9svIbDpGaxVS5HxRlQIbDaEojjnD3KLht7o/x?=
 =?us-ascii?Q?u8IvA1NaL7+RK2NGuXgMbEVHRgtYXep97IF889HR4EMxhNOzEGt5QwGabpfO?=
 =?us-ascii?Q?Q1M98tF3MBlQ+X9fQ/5sgdhh6Cc2O4PUK00JAVcURUufAhZJm+6imbbAkx/L?=
 =?us-ascii?Q?3OL/j6wjyQadrH+PjbLOrgB7PuyDAzcPSbqsXfoUv8DkGx4GAJnh1hupIOuU?=
 =?us-ascii?Q?TZZH8SHftFEvFlNTpkJLOKxCdZRxN2PuUjU7wORejC/alowctwyTMyY8wfuD?=
 =?us-ascii?Q?E4bLI44+QWTssXiLNm59y5fN1ZVzLAvaP7OZPTS5XXbMOu3DhovNEs7abWEa?=
 =?us-ascii?Q?HrBlxTxTLa2Gu3gfuBFFyN0YZ9coWVpkofbchnkpFlgmsqq9PvAqE5nkje3I?=
 =?us-ascii?Q?AbEsQpcNFYGUKfSeqCfkuaC4Vx2fw2QGfO5VnAE9zs6KEylqsf5xb6rwkuHs?=
 =?us-ascii?Q?tazQoLY3YbZqPpbPdyPymQDpZ1MLxutMipl1hx2qBr/j0rjzNhphtMDcpQwb?=
 =?us-ascii?Q?8PmQ4tPt7lb2mChPh5IsmmZD7DdwS4XzYEyvm7berEwZVJZzyNBSlC+L40KU?=
 =?us-ascii?Q?lrOkQf6uUnKUoN7lm09vuY2pXDhQ5FFm0HmKQrBcea0q8NHU+NK2INcXmCci?=
 =?us-ascii?Q?mLwHafgIlZXYIHj7bkPff+8mAlxOTloe0a9LosFwS2DsfjQLhaUBWAKs7bhZ?=
 =?us-ascii?Q?3adyIUYuGu6CSSCMUFR8eKezUgOA6SK+4Qq8SR/L2b8NyveAW2LjWLTEsj1/?=
 =?us-ascii?Q?Ej4rbaAKZwPziyY5H9O7DV4uRijU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+T5iBUn1qdTtEKp6HCrqaIk2cHoeaDRO4fizQiMpEkZk3c9orOek2ToYVNCk?=
 =?us-ascii?Q?OCTUXCJgLDwWmABzBi/jadbfudG7G2h/ltKFfJ4WXtO3IGky7KDKup+O1SNV?=
 =?us-ascii?Q?8SjYI4v3c8dM2qduOVGLE/Gjg1iZNClbWuKdNhzGliteuodz30ng2Sz88Go7?=
 =?us-ascii?Q?6r3VQhHb2vkf+zNrdXptW0ITn5w+jFctSQrwd2aRqmcdPgJo+GVnfh5tn8Dr?=
 =?us-ascii?Q?ZBd6FzgKjPFpjVKc7wRhH2qrgqgRDoBjSpIPK8e0sCANfEz05CbKfelvOu5S?=
 =?us-ascii?Q?JH3HrVRUiL0Cp5MzhesKWXdxyRdQNiNflPX9YockAJ+0SUr3RHRlBcsoVbLQ?=
 =?us-ascii?Q?0zYYFzl7k9HQmu5uxAcxwLnJG4Ze+oFACdvqSsX5KNfz99kg9ByX0IseaVOg?=
 =?us-ascii?Q?UQVnppq2BZO0Frfl5Ef5nVYPir2/pBFrMenjY27/2A3bxmCFgBrVoMviegNS?=
 =?us-ascii?Q?PRyS4SQDzbUP8CEe2CxquEfID1AHz0NtGFMaBZOZxtRZdV2QIz3ycscZt33h?=
 =?us-ascii?Q?G4cxcS7E5Njb7OvrOSGzpS4QYhe8DEwFBC8EfL53T0s7vpshuBLmLq0nCUT5?=
 =?us-ascii?Q?bLncurZw3P5ZmRPlThQjBfiVNhtQ/W1vh44syVOVBdqMydkZwUwOBOTYOzcj?=
 =?us-ascii?Q?+5FWI68Qxr15J0sflAxwV+fMCw0JseA+pmmxdS1JjRjOPC04omJ1Zm6RKmVH?=
 =?us-ascii?Q?8ASybsL7vQ/gWm6yhryQXekh1YWmtyevTfzOrqeMwUL4wQtvkxS1aOZOBcEZ?=
 =?us-ascii?Q?YYifer/BrWyLXh2qiIS3lkdCKX0upLmvF6lnZ0OCFgrUhnnMcZxVFyI47b5T?=
 =?us-ascii?Q?8LJ8UlCLTGmXr14x4l4XmL9X1ryQgGdrfZBB1vCjOR+X61qGnKP+ZHji9NLF?=
 =?us-ascii?Q?+2cH19xKroC8X6M/9W3nLjVkgFJOZIh8B6B2lnCIn+O6+Bgi/baq7YpN0mwb?=
 =?us-ascii?Q?taUZf69HNQgZX6qNbEvWoA0uldwNT1DRPMmWtdlJb81Fj9TJ1E4IpSOglDb0?=
 =?us-ascii?Q?IUk0daNVfNRWHqU9pvvbLfyValZEHOeeD3LtmDE/xzcd+OweRLJJHlnGwUYy?=
 =?us-ascii?Q?OSjJQv2IBdp55xxuMRyctnoPDjaidBea5rop/+v5ukPRvSPRdy040mgm3XmU?=
 =?us-ascii?Q?AL3qzzmVrrkNAuQPtyhJS7gI1TiCKOwf27lU21H6gh6E27EPbzWdGMNZjHGx?=
 =?us-ascii?Q?9IsWUx4+PGBcjxxL7Qgtof0TJ1yWpqJ56QhUYonhSt0lGeMnMEMV3kd4Zz3w?=
 =?us-ascii?Q?rvOr0xAI4nBRK6Ec1Vr1DIhSMSXRjc0mkMwcadjVugL5ELTCPMszp0/oImSX?=
 =?us-ascii?Q?4B1ybgFOcbsQ6bl+kmPaitg//mOeMaWjP3AK06g2QSJw4tzm8mts/9GDbVKa?=
 =?us-ascii?Q?yurX6KDoOAkrIED3LZM7iBlU96U8dKvCaPNpLlhtMt5JiF9p6UvlV77pCO+0?=
 =?us-ascii?Q?Oip5P71gBJ+W382cqhnofus9x6U9qprDjng7i4GlYeeGbLeaWNads9o5Oz1i?=
 =?us-ascii?Q?kxEKd7SsSeraI4YuG/cxeDgb1clIvpz+qD8foPDpZP5+iHCB661hJx13ylsH?=
 =?us-ascii?Q?kRz7toINxsI4zHwI3sUKwwpumXuatATSKkNpBqL2yq96Sxs4b7EKulsoglVS?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 544d3815-c84f-4207-f235-08dd4642a4fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:10:20.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNsMnUuN1Omf1B/uG3ULfekZ6W1ZmjvvmtdfS8waz/VXUVxh2HEovG6l9QPdTtTsROTsrgRRqtfiPKRR9+0nug47/9du/bhS3FJAfon5gw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5971
X-OriginatorOrg: intel.com

Vivek Goyal wrote:
> On Fri, Jan 10, 2025 at 05:00:29PM +1100, Alistair Popple wrote:
> > FS DAX requires file systems to call into the DAX layout prior to unlinking
> > inodes to ensure there is no ongoing DMA or other remote access to the
> > direct mapped page. The fuse file system implements
> > fuse_dax_break_layouts() to do this which includes a comment indicating
> > that passing dmap_end == 0 leads to unmapping of the whole file.
> > 
> > However this is not true - passing dmap_end == 0 will not unmap anything
> > before dmap_start, and further more dax_layout_busy_page_range() will not
> > scan any of the range to see if there maybe ongoing DMA access to the
> > range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
> > which will invalidate the entire file range to
> > dax_layout_busy_page_range().
> 
> Hi Alistair,
> 
> Thanks for fixing DAX related issues for virtiofs. I am wondering how are
> you testing DAX with virtiofs. AFAIK, we don't have DAX support in Rust
> virtiofsd. C version of virtiofsd used to have out of the tree patches
> for DAX. But C version got deprecated long time ago.
> 
> Do you have another implementation of virtiofsd somewhere else which
> supports DAX and allows for testing DAX related changes?

I have personally never seen a virtiofs-dax test. It sounds like you are
saying we can deprecate that support if there are no longer any users.
Or, do you expect that C-virtiofsd is alive in the ecosystem?

