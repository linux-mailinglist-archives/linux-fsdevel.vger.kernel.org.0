Return-Path: <linux-fsdevel+bounces-50698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C1ACE83A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646F218990D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D41F099C;
	Thu,  5 Jun 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX7LnGfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17860770E2;
	Thu,  5 Jun 2025 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749089204; cv=fail; b=RdhXuYz8K65iJVf1pobV+/8Cry5ZXC2/mgzHumgqLdGMu6GKAD/PM6oIprDVnHlbWpQO9xKlG3V4zjJW4/S9g9kHTNxNwaOAVYm1jJfn9LVtUsNzZkEj0ohzhFLT+ZdhN5AvAZBW68TSnGonVlWeoQqjjzj4civ+fPnIkjnPUs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749089204; c=relaxed/simple;
	bh=kgbGVz3netzGevZSeRAVbBSOKeKebteG7hNne9YYH/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hixsjEXw0zzwrcxCsHUJ+gIvePgLU0FTgx9Hs8daGJz3PVSBsuGamQjZlz1cfX7j6zkBqCuPptx0Q9fA+YK6S2PvL2rKHdCTq/tHPtPyW0NI7XJ9lrrdPq4+ImnA24qFw9th/YptKsbBY4Mm20sRU4y4kCtp6sQiEmOO8+Ovz3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX7LnGfs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749089203; x=1780625203;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kgbGVz3netzGevZSeRAVbBSOKeKebteG7hNne9YYH/U=;
  b=OX7LnGfsAuf+rJGp+ojuy2bPIinzPKxxqAicgN6HXWx6BgMUEGQDKzig
   H5dyNz+fNM0w1pF0q2ryVy+Y4Rie6gNpRl8dBO3/uEuQOUdK/KVWOEn01
   q9+qVbAb76YNSKiYeKcYOFd2S5Vw/9z5fytWnEZY00ZbZTNqGcge6M4C5
   r81tqbK0cdQ6kHLgsz1q8gHim2Gk44Rr13KmzZin7IcP/VCot/79EfDh1
   gS6NzX3H4ViYKEnOy8BJHxVk7ciYUT8RMf/SKuAcVG5n8AKvYApUaP/Eg
   IzG7VTiKOW3ETA5bS1HdC5176YLynEWhcpfTq87pzV2MywVcj0SthUn0L
   Q==;
X-CSE-ConnectionGUID: H8EDMp7+TualNAiI1wAuQA==
X-CSE-MsgGUID: E9VGz0PUROqlVIRh+D8KGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51338890"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="51338890"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 19:06:42 -0700
X-CSE-ConnectionGUID: sk4nLyRgRK+7rVV8O9Adtw==
X-CSE-MsgGUID: To389ub4SqqKsSsoSSSUCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150514276"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 19:04:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 19:04:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 19:04:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 19:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ylslldg/yGrqhZAi+fSgV6wCCQoUt02gItOWcDl5iC9sK00OfBtL6uur9OTJDWlWVYGuRtZx2iV1j9HHvNnTkVsmmsHTpXot+QPMXWKCOVmXnApNUp+JkCkWcckUS3bdQB/SZqpd3lEZlBFrv0TFIt/qewyoPNk+dvfsWkQ8ItNsBt6z5+Rt5LU/BkINqcTB8DtbUoy5FV/seJ1jzzGfJp1kI64HmClWkMJlUEsAdcjbQTaLdsz4jEtsgVZDN93AbuGrj7OkFzuwfPPjiF6+vf+AA+VLrRFVeBqG6yAGT3jZCIB69dkcX3nmZjci1ywiOXvGWXuI4Eqha6guTt4nfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsicUNFLW/RcNisC36S0SjgywQrdm4jwgrmcGMQuFoc=;
 b=kukIG1ysD4HfXHVy9qPbhbup3bYB+KtDwlqXU+opy7l1M8EU8FPRpmM6cdLnGLKqB1EMGX1gqHRVMnO6hrDf8OW9oc8EQ5e9BvL38sC1xHaDq+aa455+AHlCl3RLqkW35aXAvujO/ILpoy2uvkADiSPMfTD+5aly1b8Yn/o8x6CNN1aUAhoJWcuVD2qVZk/7ndwOWdoUaRzGJomJxXgGulYOvNYLb4pTcZJKq1AeF4rqlWl+2HYo1XoP4xSImwLMVpHNm+LHhE2RFJEwL3I2Yzn1uNxXWxMdusxiWe9UnnqcuSHmpbS32qHdkDWBhS1u338HnQYAm19qGPKBBsGpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 02:04:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Thu, 5 Jun 2025
 02:04:43 +0000
Date: Wed, 4 Jun 2025 19:04:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>
CC: Alistair Popple <apopple@nvidia.com>, <gerald.schaefer@linux.ibm.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <willy@infradead.org>,
	<david@redhat.com>, <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<zhang.lyra@gmail.com>, <debug@rivosinc.com>, <bjorn@kernel.org>,
	<balbirs@nvidia.com>, <lorenzo.stoakes@oracle.com>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-cxl@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<John@groves.net>
Subject: Re: [PATCH 06/12] mm/gup: Remove pXX_devmap usage from
 get_user_pages()
Message-ID: <6840fb3848258_24911003e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <c4d81161c6d04a7ae3f63cc087bdc87fb25fd8ea.1748500293.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4d81161c6d04a7ae3f63cc087bdc87fb25fd8ea.1748500293.git-series.apopple@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 921a7f0f-c876-4adb-4f09-08dda3d55680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t1GZXcNzS5LsgFpg7s1ba65o/1yNhgv7/JnUpk15RSYssgno3Bc1QtiWtu55?=
 =?us-ascii?Q?dCHVM8bPrN+Panh7TCFTbX50+l8DI18Kw2FbBvvMWNYqjr9X2l2sadusHfAj?=
 =?us-ascii?Q?i6mMQJ35UVVHQtXOIXVNlyiY1AmvVu87cbi1CZOVvg0MkPHWsaHJDUcgE7RK?=
 =?us-ascii?Q?Es6w/3sl+mIsuIrXzEYMub5Ig2ElK/KSY7qbSgGCrXYcb8Kxeo2K772FVyV9?=
 =?us-ascii?Q?pXDuqdTCGz+6I9xubD518nz+dgRb4oheJbzGoMChLb0eferw50oH+kTZ90Tc?=
 =?us-ascii?Q?RIdnZotVtzvQM+5mIA6WkK3mCRkIypnOBLucdTe0Aj5eARLYW1mvWj3KZGLJ?=
 =?us-ascii?Q?YNl7V3yzFy28GzRCl9lR4EvrgcI/J9Mes6ZfriNR01n17bWTqDZYNiJRT5JU?=
 =?us-ascii?Q?A55PRipsT0RD4ZYEEl8DHy1ds04xUwJzbJEL6szDfOx8Bo2E16SGyXh0qNFV?=
 =?us-ascii?Q?cuNL1OZvVp7+FEu+JmKIPhk6TvI7lyTsuQqOB1on3EdT0Xpy4LHbS4xz2tP0?=
 =?us-ascii?Q?vQJi4fd6J0PgDx2Zgzv2bfqpSdGvHuuYFrVzre7CP8mtk1x+rEuTSph+SMjL?=
 =?us-ascii?Q?zjFXtG9lro+pWE63d2udcfeMOcw/DPXgTMFDQy/5+wQVWSKDjLPE6pS8W2rg?=
 =?us-ascii?Q?ee3dgsZvEVTcJkNUNTucd1iHKUA8RltsJXpM3nTny2FJFHpZv/GlFvATERm6?=
 =?us-ascii?Q?qfAW767wGHXcUrcuL23TN5Wz+VmDmGh5Ai+IszVC5oITSxSkcyMkAkwZmj06?=
 =?us-ascii?Q?2lzULn3URPTG3sM5lp15QyAz1SK4fabVBkVZY3sZc+95c0qaapEg3N/dOrzg?=
 =?us-ascii?Q?IlIWIapbhGb3595OV5/dHSiWSKTpduvLUrrjKDvAytxK6r7MeDhkQ0MitqGA?=
 =?us-ascii?Q?MPKEzULNDDFnSQ2SeCVcdrvpravkC1Su4BvJ8txPptvpppestnaxCAQwLUdZ?=
 =?us-ascii?Q?YaHsLir45gKSt8jZklV3PXlOBofTaz1jU+5lo6qXinGwsdeoTk7bz/SU7RSO?=
 =?us-ascii?Q?wcwW3cVdFxd7WZD9Q9KB++wXcjI7o5skynVA28CQ+oUHGrQ9fgsnhLBeEiEe?=
 =?us-ascii?Q?Azj6H7sfqQiCnd0ux7CqaA2ZPT1ql7Zc3BtDGL0SiMVb3x8DNR4hF2p3KFoV?=
 =?us-ascii?Q?Hnx0KC7/noJ9Ei9xb5cieKrDegCPr7BZ/VKtCrP3wsKjItEZPBFssrPfazmm?=
 =?us-ascii?Q?acsUu4+yJMzwxTZEt941UqxjwAbQYVw6svxJ47hpZd5tndDDVh0+B33Gx5Rw?=
 =?us-ascii?Q?hEWo4dp13Zh9DsTS99FnYNjwa1uNaMLRassq9QvvhSyDqsYqP3mn98PafUYy?=
 =?us-ascii?Q?usP1jZshoI7kgeQQQebLkslC2L+XkqTj9MuDg6FNYsDYiWJX6YTLcLfxrn89?=
 =?us-ascii?Q?NN/R6jRswz3Lfocp06iE8yerLfg50KhzPHXz7fR2fiCTDjJaJJOeJ98DR/n/?=
 =?us-ascii?Q?qRmo+cqNnR4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4jxf3zRkomqA76/rdkdGGp0qPtvg71vrSeCbmuqixAYAjgMdjliMDsMElfHi?=
 =?us-ascii?Q?M0K1WvMeSG/r8j3QJ1GM3LrqBtOXHuej/MxkMUaHi5HPPa2wx7ktCCPr079c?=
 =?us-ascii?Q?jIaSI4YUJ8WNBGzhuCon5Ewb6y98DGeVYuwLoFF9qpT+nKziadnrkO6dt5Pe?=
 =?us-ascii?Q?o/B/qlVvdgtK3CjCZ5M+mFq6T4vxYqQvHAf5wYHGA8wOtGOI3ff8S2dbDIo6?=
 =?us-ascii?Q?cXW45UasHPYohctg4UK1MbIxCLQh0inY5isdV+luaWGpeRH6VqkfHFK/TsV3?=
 =?us-ascii?Q?ATTpeWxngbXVQAG/RRXRuHMr/ZJVtsbNm5l+Go6FqqEV3P6cKNwqm0JvJo/K?=
 =?us-ascii?Q?VigQBYNEktUlNCzNci3LyjWXAp5tyChd5nnfY8hiIqaCnMh2T2lf/zLuO0Ds?=
 =?us-ascii?Q?MVkZS1CAltrE85hBiPpkXwO25VQMuOykk+4jTG12Dz8bpkA9IuVPpPubVikL?=
 =?us-ascii?Q?lu/7kgs+qtXi0ob5mwCs45fsmKWVsAjHR3HZd2mfUlarlukq4OPO3SIgUhQo?=
 =?us-ascii?Q?ShuiOdnU3mhKdxOnyHYZyNKp9mhWW1O2OvKhtSzjlRG9w2tYGz0ColjGc+47?=
 =?us-ascii?Q?D+2M4WQdeB4ZirwdeSDVw5MDF5Q2dLX7unTGcE9JVJEBtMr/OpLp64Aq6WU9?=
 =?us-ascii?Q?gjJBOsBVy/R8hThE0PiW2WzzkUQdJGlf7WT6T/cZD81lCpPi5nrKRxt2okEy?=
 =?us-ascii?Q?Svti6pgm+KNcNl4FAQ+VsOawWGwE1fAOzemvZRjCQCqqaHWoJdEJcD9aiLtp?=
 =?us-ascii?Q?6Lz3pitNFeYkGD5jgxLaFFjLIQEISW52lEjDprCC3v8D3IuwRg+2y4AQgyD5?=
 =?us-ascii?Q?xXuZa85dMNn8H3rJEI7Nla7GQjShhfyNSOPIHLpia+d+tP/CWbpcAiVuok1o?=
 =?us-ascii?Q?VkoormPscxdMAk3agJXMeIAZPhRBn/pqOKsbGTClj4AIswtyAQzV9dT6Hlo3?=
 =?us-ascii?Q?yVOT9F+EqJyRRhtStwPYGIHZQtZjAp9+ySU7LMHnQaDxqhhYZGHfPiZm/syv?=
 =?us-ascii?Q?3wnSnZ5HF6LyD5CL7SJ2Y3TdgKVM3kHE9eZ4O8UwtTjLmpQK89cfOcEhD2FL?=
 =?us-ascii?Q?9ZWCuyc+1CS67TISk0eBnC+xG3vWrn+YLiRMHvJQffyGrdxFOxv7LzYXgJLB?=
 =?us-ascii?Q?XxqLagCk0+59wR2MP/u8IeB2qaXs/IkCPpVlKqvs0VBOcIsxz2KLPweA9yoi?=
 =?us-ascii?Q?eiMrrQigzrEjqggFB3ypHAHPPfUDOEFsadx4osduNuKhN9gXIVIc4tUOuwP8?=
 =?us-ascii?Q?AeBEBqcxF2lKVJVKXTnvrWt7w7Fx3iTUnfxlme3n+Mx3P4gpbSfEuC7INFNp?=
 =?us-ascii?Q?GkxQM45BMD9y12UFLIhLYknbtMZBOg2pv2QpcUELbWLln8/jC1viJvMMFfx4?=
 =?us-ascii?Q?sDpQELmsrnm8UiAqERc0e3/wambObzFTXutlllUxKJq6Fp4tbxQKXkTQLCsr?=
 =?us-ascii?Q?pNgxq6T2azm2Cgavq+MeLxT7b5AJK5MAn+zRuv6HSM04tSVJcl3KWg4e26uh?=
 =?us-ascii?Q?74WRYDM4tgp6nRlllgpv8trqrijPKQ7lub0Q0HmN54DBWZtWjrCce9duRb90?=
 =?us-ascii?Q?ec4p9bpJimx9G8c3OJK2n7ehV8aCwk6PmmJEGfkezoB6iO5QGBaejnfhK2dc?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 921a7f0f-c876-4adb-4f09-08dda3d55680
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 02:04:43.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUwyUHhdwz67dZq4IqgPwLSoumjovyehS6e7OgI7rAiDcqung/39kalRr2eyrui3Oi0hmybt6zQiylMjXpUP3R/WTgf77Drt2B2gJjwtnJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> GUP uses pXX_devmap() calls to see if it needs to a get a reference on
> the associated pgmap data structure to ensure the pages won't go
> away. However it's a driver responsibility to ensure that if pages are
> mapped (ie. discoverable by GUP) that they are not offlined or removed
> from the memmap so there is no need to hold a reference on the pgmap
> data structure to ensure this.
> 
> Furthermore mappings with PFN_DEV are no longer created, hence this
> effectively dead code anyway so can be removed.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/huge_mm.h |   3 +-
>  mm/gup.c                | 162 +----------------------------------------
>  mm/huge_memory.c        |  40 +----------
>  3 files changed, 5 insertions(+), 200 deletions(-)

Hooray! Goodbye dev_pagemap mess in gup.c.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

