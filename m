Return-Path: <linux-fsdevel+bounces-38111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451EB9FC365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 03:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A98164F58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 02:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BD1BC3F;
	Wed, 25 Dec 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npkSGzQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFC20E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Dec 2024 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735094989; cv=fail; b=XPB5FW73lNsQrGGnea7Bm+7tcMqzIiXtYdvWi+1npb0xcyAL+yx5ImcFf6bCq/XtlWNIhLJJRyYNd1Xv0pW/rlTqc1t7wfVSQDr/sLhprF+85FGKLGGh9ct7F8WV2gB1CsI8rP7Ap1VsM/R064TdBztU/0azl/ssEj3xjjC/coo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735094989; c=relaxed/simple;
	bh=e55sgHEFuKHoSswQLYSgKiE45Rlr9cZUAPBrzsOg0Dk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TfM5w97dDRZIgFN5jvhxo94VVnEeRZc9T0Wjo58j6vEOSucd0UkF+qaGjzgHphIOCKr8BKPZ5x0UDpxy8Ajg0GCjjAhEw0TMkhuJCcr50eZze2kUn4h0ilj0mUr5YvjIWdRtzclAnAJ6z2BQKIE4iV89d2G/pJDoeKHJIFYZjqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npkSGzQg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735094988; x=1766630988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e55sgHEFuKHoSswQLYSgKiE45Rlr9cZUAPBrzsOg0Dk=;
  b=npkSGzQgXQqCBeBvTvkocOk/5NtmveS7swkP+SQ6Z3nKxZc3xIJdYYz7
   jnH8c8mBL4fj0MwMpl52Uh5QiL8wJ73CG8JjBvlnDV/MBidxZglS+G41e
   mCEpyVxinw0ePoo+l6pOT8QMiQvUwcBHDZrkmqCOsXw55mHMAr/CpqtpC
   0nQte5HpvHxPsY50ICZwPPQNQd3TixVy6hm7iUOi3kpcfX3KZOECvyUtj
   npFlQ0wQgc7HutL0FV1kUGbhITgOFP6g7J+WgIiIui5Osf5IX+/Ii0+3D
   2LOSgVvITHqSCs+MqERqL1yqWGI95L9O7FmN3lcwHtL4/1b5H7LsO4XYh
   g==;
X-CSE-ConnectionGUID: 5UVouylaTVKDgmDoDHWezA==
X-CSE-MsgGUID: vUXtm2FDR4GvrZpTYt27Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35720167"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="35720167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 18:49:47 -0800
X-CSE-ConnectionGUID: lmpo4g2oSm6IGfHcjBwgzw==
X-CSE-MsgGUID: XLS9ehTDQuutbzkoWpSELQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; 
   d="scan'208";a="99716504"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 18:49:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 18:49:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 18:49:46 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 18:49:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9L+rWjf0lh7LvQfHx+dUi9k2JoetBlZslPAGbN428VNexashLKR6ht2IYILAjoGjsyF3aSZoft5Lulg7lMrqvFeOobPbEew66inmODuQza9SY4QIIqYX+PIrwpU5Ec7G5gADN+FuQ3avx2y/GCNM+cj/p75o8+f9BA77p0xqsKCn9rCir8sjRhha+ILeaGqLY/3nLmEIpBWj+MWv13A0z48xti67ldb3DsoGpXwqLCyqvwBI1CDdEd1rHxt2xYSblkVGwqdoySbjqc9ZkrBv2WLG6kuMqRWMZ9F8fF92CJqdnnxrvZgJn+al93tVS0d0+Md5g+ahIJTRrM5g6vCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLRtfGPcWl+SC2X5Zv1jAO+FpnVIwJ/LCT7X1OdjhBg=;
 b=L/YCFPwTTIySw9Kd5GT2bdZp+XS0dJKkDlgkViUFnghTo6NrYvERxdoEyJrh+UPfesqsiNWNdjIN02tGPeeonPebB2efO5Vkm1cSSEKdhYTmzDbpktoGw0YKOcfNoYknATaeBe31pBpBjipJnCc5x5bwUJ3f8hW+lrqrnsWOOevvShoySHsyuX4SUPwap+zYefAtRWfFuBx4M1HDoSe9ZjUO+2aBrpL73K+tyfNXRR84RUR0S0Iol+Fo8ZWjmSvRcud++SoBMRr3bmgdhL5Meu0amId5VWxj6cTVCMDR1rPvPc4NeM+roZNGEcMFcTmqTsPyT2sYEvZbJ7jmsXCWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4603.namprd11.prod.outlook.com (2603:10b6:303:5e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Wed, 25 Dec
 2024 02:49:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 02:49:13 +0000
Date: Wed, 25 Dec 2024 10:49:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [libfs]  d4849629a4:
  libhugetlbfs-test.32bit.gethugepagesizes.fail
Message-ID: <202412251039.eec88248-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa6da0d-4255-4785-211f-08dd248eb75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NaVNdRo42KrTqkfDL17bc+Eu8N+oEGP4aWRLvPHWE0G2u/S4/+quCC646q1H?=
 =?us-ascii?Q?i2xkkBeXzY9MB0OC9WjAyFPhbRe3J4iz8MunPSsk/4PG4LoK0hdVuwlA+2PX?=
 =?us-ascii?Q?5vRFzUVF8GywnXwj7kwO36d5aPXHNIrEaEnxmQY1/QHwP0294/wlpzgGZ194?=
 =?us-ascii?Q?wjs6qc2aqzMXV8N3Answ/yI5XHoaLRMgOuLuYddKYc/s2q1RTWOblFVA+fah?=
 =?us-ascii?Q?M7G/gbsFusaZvnl1J8Af4vvkF8rotpU+yg70LcOvvlIEdnuQUne7pVTTSFGg?=
 =?us-ascii?Q?D01B5Q0PhEsZGiZ2wyehVr6IIAIKMQZnIpqe+CN9qvXWmO0lTT29nXNwuTSs?=
 =?us-ascii?Q?QpAoTcqjTfovKffmMXgiVqbqRzpjUQCRCZ8LFmf27+b4IqpWKWZxwANBwPG1?=
 =?us-ascii?Q?J9hS+T2ezgvH8jytW0XiAscVHwCI0tuSBnCTgh3jqNbDuQcOGHABdDYzDIlX?=
 =?us-ascii?Q?544Qm+bCYH93trCKyWVeS177ZU4C5wn4FdTiiWJo8aqi4KmkCnnXKaV73zIo?=
 =?us-ascii?Q?AyUNR03n8pa9qwpUsoDiQq4XbFuznC3IDnF/5nJeJ4VJUIbgcsVbl9TV5QwX?=
 =?us-ascii?Q?kCvxxR7WM3vAvNglMOUDf7CEhJD+5hexRL5oB1TecrIVIEOeMEkRBivGHubz?=
 =?us-ascii?Q?kMLnkVwhlJSAq5g3g/6N5IFOReclTA0WZwppZ2llj9DlvKSv6ZSplw37uFeR?=
 =?us-ascii?Q?mUTAMMO98qxU39vkBIiY3yPmMcLXqMZRli5s3TImGStEfI60YSvW9XxEUEPK?=
 =?us-ascii?Q?vwYKhVN9KKXG1LlJ4S6fNkgJDJBHEIrzBSYbwu3KGciGqGdT38NHRabeG55o?=
 =?us-ascii?Q?5bBjFi1oXPh8HEpIYfDWFrnaYRnVdgZKbgW02cKtmfHh9HZ/KIOzVOK8xa46?=
 =?us-ascii?Q?h3hM4SB0h7OaEmyRgnbeUgcj4OcJJUZf7KGF6+ccp8uGNhEfCGcSO41XbeJf?=
 =?us-ascii?Q?A2vG1Fc1wN48yMmVMhf5O6dp7ZLqd/6lX0/ka2nQS9gbGxCt3nYXHccY5E+Z?=
 =?us-ascii?Q?xgvBJ8A29qV7d8cxSGZaA6/a9NNcCyKzOX549Ns782mczi4rxua5Ar2zx4XZ?=
 =?us-ascii?Q?P4IYQA+aJrtsCO5MUSNlL2l2R/xXWHqOlyRKtD80w6g6r+mkX3JinLIT3AmH?=
 =?us-ascii?Q?EAZY89KHJzT7l0cUPQjhHF14wSupGqL2KO6ITA3o8rcRkm9v6FU/hfb7IQ+y?=
 =?us-ascii?Q?PvF+h4ExyPppPTE9MAbatuEZCHsfHrtHuPC55aSy8wOXRw5OzAYbcCkGyFz3?=
 =?us-ascii?Q?EiYA4Gq1Ugc2e8svLe4S/y/Y9fORgjlCm39+sEwzgExkkXy3rEBjyBiLj98A?=
 =?us-ascii?Q?fWd8KA3PQdXGtnJkp4iMdfY7/keiXfTCnJeJ5WtUZTbk6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grRSXoDPGfB/N5qpxXmBsFxKg1h66TRLllsEcORxKU60ob5KY/7v555eUOZQ?=
 =?us-ascii?Q?BPKggCP0rrwcrDIrS9eFc1k4oppS3vWOSVu6GKiYG19nnrF4dGMuNOKVWAlo?=
 =?us-ascii?Q?E5ryMD1uLsWEaHazZpaNn0UQrL5c6tptvc2bmBK/mSG/4A0Nf99vPx9qBtW5?=
 =?us-ascii?Q?BI2gmgGKCs5YBJCsYiA4BzcOiNLKGocG+nSgENuHzFT5l0sHd6agRjHjCtF/?=
 =?us-ascii?Q?p7koaiu39VrFCGNts/cvMokHox/T1Wc/gr5t9Q9UmEq/DX9cSjBk7Os3G1jq?=
 =?us-ascii?Q?C9bK5RDwA6+EYmW+TSFKbywDC7CTUZzgUIYYSwqAvujPa53AMAU5Nn5clTR8?=
 =?us-ascii?Q?g7YST18neA1YaBWTJvV82TIc7a6j/snuJe98f8FE197GKeUGc8IA5kl9x55z?=
 =?us-ascii?Q?0VbU36jA5v8FlOR6khHwmNrvxa/Vh0jXB1w+qNw6Rpo8Ey/QIz9mgN7KZz3m?=
 =?us-ascii?Q?7529yiCtRpas9HotHn2uzhGElJrkvV3arwhlt/56whjJj/jTbiHF2XEziJD1?=
 =?us-ascii?Q?AOBIMRE+p2x/NoWwHoDx99tCJz0lyf5SCSi9yk9+z0J5TlIKLe8EXz0EvQ1m?=
 =?us-ascii?Q?9pNTJZyPycaCLvMpsCcMysxZkxbKCLlCSCHbqeeo7fZSG6pZsb7P87F7GZW5?=
 =?us-ascii?Q?2TaM6qcpmjib1wY2hwQNMs+9ya65vmp3pxbVq62oIDXdHWCC2OH0y9ZNhA3e?=
 =?us-ascii?Q?16E5+DPj5UAK9FwyhZhyvODZnu/Nc/pmqaSKy3jTXh90QmHNczyWXlKPt/BP?=
 =?us-ascii?Q?+NwK8C9hmMsObrs88Jv2B0kJPOPZpgBs0UYbEqDiKnSgY1eKXcIDE+BhaNNm?=
 =?us-ascii?Q?Pu6gpSdfqzM4owq2bGtsjCmulmtHz9E9iemklXDyYhzUHVl1i7U/iPEpB7sY?=
 =?us-ascii?Q?mnSZaZcuvQ1TC1cDLJ7FHpo9GI64wFT4gFbLuyidUgg40dCB/cyDSJQBJ6oe?=
 =?us-ascii?Q?K1/AHju2EWy7b/2BaUnvYKSPHQJjjq0KvH+Ocw0lnIDDzwFPVyeyHrighxFc?=
 =?us-ascii?Q?tNnsdqT9QjlEHvT5ssTT52YYtSe+i7YMnxNi9OVDvwPZC6bNxIf65qmdXkFO?=
 =?us-ascii?Q?cc/0anOWSzRqAcLChF+M0oU8LyKts+Lg7SyuqkRsuE1ZSPAZfZ3UsVRybtEb?=
 =?us-ascii?Q?Q5e7hgY3yd/HGcKTZ09eZ+TywWuweZPIABBcWSQLsQkhCMYpLNFwH4UYUxYP?=
 =?us-ascii?Q?tKh2pp/hzRx0Z8uaDfEfN+LKf2IHEPjRUEpkzEvxoay743m9XsOppy0RWmIc?=
 =?us-ascii?Q?lshm6IohmveDBy1Cyqin8wNYaFBve+g5Qxm06RFoXlmk75zD4U1v7+kH2OE9?=
 =?us-ascii?Q?5QsrAfq0Rko9b1WJZT5KFGos5zYE2yIITbKQKw/ubh9FgheoEI+pmkS9F85t?=
 =?us-ascii?Q?/AL4M0lvP4i4v6JnbnZtitp2Lg5/zVY+VbC/OkhlpTfn/zxNzCzMPmePUagH?=
 =?us-ascii?Q?DVzwbc68beKb/CG5X32qHFWt4tpqq2Ug9VYxKrCLbS9S35+MV8tkiVNKgZ1J?=
 =?us-ascii?Q?yB9zr3Z3Uz5g+rjENzwoV3tQacispmwaSaTtMBlmDA6fPdlsUqbauyIpIXji?=
 =?us-ascii?Q?R3V3snVCxxYIC0SxH6limZjNeZYvyl/dxv/L9Jpc9sQW2KhY/iTB9fsuVa5G?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa6da0d-4255-4785-211f-08dd248eb75a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 02:49:13.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXOGHb6iRQIQVl9A3374Dp9y0GufPBehBYyPT2o/vk0Ql+l6ZDYPDWDdirAabA5AOUZ0y9l/gZpiVaJqealNEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4603
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "libhugetlbfs-test.32bit.gethugepagesizes.fail" on:

commit: d4849629a4b7dcc73764f273e1879e76497acdc7 ("libfs: Replace simple_offset end-of-directory detection")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

in testcase: libhugetlbfs-test
version: libhugetlbfs-test-x86_64-6ddbae4-1_20241102
with following parameters:

	pagesize: 2MB



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412251039.eec88248-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241225/202412251039.eec88248-lkp@intel.com



gethugepagesize (2M: 32):	PASS
gethugepagesize (2M: 64):	PASS
gethugepagesizes (2M: 32):	FAIL	rmdir /tmp/sysfs-fPtma7: Directory not empty   <----
gethugepagesizes (2M: 64):	PASS


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


