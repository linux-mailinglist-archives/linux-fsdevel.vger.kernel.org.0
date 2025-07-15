Return-Path: <linux-fsdevel+bounces-55036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672EAB0685C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3874E1BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8F2BFC9D;
	Tue, 15 Jul 2025 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5bbqSZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4026F44D;
	Tue, 15 Jul 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613690; cv=fail; b=YGzdCrgjxUBCN3bYril5CgVeJl+PQAXD6pCc6+qc413ntu0xFoYqHAR/OTKx8shULHl/bIyJj5SYSvh1x3VUwNSdvJiKONmPxW9gr8DdkIV91aPl9wdzUFZwIRp9lLinWhU/wCvQxXUrbZr1Cx4x97IVh6PlpyBfiPb1i59QeyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613690; c=relaxed/simple;
	bh=KJA5ekvseHiIvXyH3Zle73RX/169jdy8dJqLRtlOcd0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iT5vCEzmnShTJ/Z8qpBbSIpOTAH5fQc218p624FjylmEuFWYw1bsravH69j8yQLrqVii2/ARj+qRDfiYNdKmTjZeSQqVsECK3UsEiI8jrb52thZNRR0epQjmrbWlSeG+Km3TBJuRa6vEwI2ibC0eesS2G1cs1EPjsPivwNkkqQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5bbqSZy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752613688; x=1784149688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KJA5ekvseHiIvXyH3Zle73RX/169jdy8dJqLRtlOcd0=;
  b=c5bbqSZyMDcTZRDrXLfSy5C3hNm8jmP6hR0q4v8MGXS0hgfyfIWZJ1rX
   1+xLehbIlkb0HabJ34nmM8CoZTOFc4LqjrrTlDOdbTnk7MeeE/ddryjuQ
   JuAPgdKELnI7W67efdnL2gWzQO6pt+wqiDNkK7enlBG+IeYp+FfehEWQR
   rN7qOcNoPDzdJnHKYuI/8jiimHBIjvypFnBgCwZT+mWledh6HgsKp5Jrd
   FDTkxGKfYqWhQ1RhNbl+rOBMl/t6IQBzOWRJgVSU6Gcf/MKb/pOnYnLFr
   fzk8K9x+hLkb4nYh8LRVaE4TRuhtQmzVvYW4fMHyqFFCJquxUgr61rgtt
   Q==;
X-CSE-ConnectionGUID: mEwKVCfDRKacoxuFO1ou7A==
X-CSE-MsgGUID: Cghe30PLRU6XP+DQYkU7XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54703538"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="54703538"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 14:08:07 -0700
X-CSE-ConnectionGUID: hqoGKP9nRLyRrILJswnomw==
X-CSE-MsgGUID: xeTvtAj3RoGtlWIM95CWFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="156720083"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 14:08:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 14:08:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 14:08:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 14:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZocJSW7GwStaSNlu+aePJFgvikAPyEsOwVqqWsCvSLpH0mXwEyPqgQW4C2e1O2abrj+PEuCImDCHkytgnKem222jGkegitnlJq8cJ/7CvX4wbSJ2DpA7bRhyTduMUyugZUh0ZVGB4bhFz6+bS6c4pZOG85BqxS9xKqtQLHp+U7DZUzd+FYIJwUMv3txu2VFMkiTlCLVj9J1ty+TZNftrw05Bv+2cjPq0QNxGuGaddiSW67xN/3toqe7h8CSC006lojj07TzqRHa8Xw86N2rel60MVRYSFPSsv1nt7Vb+G1cFjGgV9mBOh/h6W1HRF0qqBMH75wnLWpOZ+BMJ0DugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51sGuAZEwEWIlwXKz68ur4VtoKkB7eeRBrlYVMpyVHE=;
 b=uaeeXuLQAlNV1//xUkpV91eau20nXfmaPBzfwrmywr4oJNnJxhqpIzn19rW+5x4hqnTNAdS1y8o3soimi8bapoWKOivUXmUNh+GeOO2+/CWnzoZzo6Lna3WwS0ll2ko+faYrxAsSn5s6Trj2l7cunUQ6hlTdd8es32dhQnwfdpDwjKabamo2iYjs59fgzbaeGXtNLl80BL16RfBzYEJQG0f5833Zyc3SMGSTsp1MiBAn4OtM02qjIPd6mYhVlP/ceUD6unn2+XVfzWLyUKktwPAowcqq7ZWQlMmHaW0kYxP6rczDiQ7cYiuv9Ni2CGeduQ2orEJzJWzEy3gv6fb0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8491.namprd11.prod.outlook.com (2603:10b6:806:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 21:08:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Tue, 15 Jul 2025
 21:08:03 +0000
Date: Tue, 15 Jul 2025 14:07:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Matthew Wilcox
	<willy@infradead.org>, Jan Kara <jack@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@kernel.org>, Li Ming <ming.li@zohomail.com>, Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>, "Ying Huang" <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
	<nathan.fontenot@amd.com>, Terry Bowman <terry.bowman@amd.com>, Robert
 Richter <rrichter@amd.com>, Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>
Subject: Re: [PATCH v5 0/7] Add managed SOFT RESERVE resource handling
Message-ID: <aHbDLaKt30TglvFa@aschofie-mobl2.lan>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dca44ce-8c78-45b5-8c11-08ddc3e3af8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s4ce2XTCB6H0yveB54AFpm/JRV6MNLdzIhNCzVcXpDs1r6D1l5aph26e69vW?=
 =?us-ascii?Q?lrnFrhviXS4f3clFc2rjjRudjfnd988FUN1I16Xg7zOi0YjKeUAgiSGlkgGO?=
 =?us-ascii?Q?69jvP8+jj16kNxkREyqgsdj4utaq/X6WwYFNzyeNFjM0MSiQIA5U4XNtda46?=
 =?us-ascii?Q?rDmFydD7B1ySN9mOS7s+uH4OSvm7kl9YU3K0NgkBiisCNP0aTX89K33G43+D?=
 =?us-ascii?Q?UFcm1WTrmzJSndWR8unX0QyvhrrT0Agpe1sjrNi8vsWfA0LdljSjM1aM2rZ1?=
 =?us-ascii?Q?TOrS4n2F0PtZOacow3iXJ6Ppu+XBQKW/kAsTUKKLU+pc2iFapcO5bb4Ajg1T?=
 =?us-ascii?Q?MjjmSqCeSFE0LwSfXWZmmg5uZwGT1Wmyb2lTIcgu77euD9Sf63k72Wp5pKwc?=
 =?us-ascii?Q?GyevoVp+EhixWqNj/5IYKTVN9SYrBHeVvoQGdLQEksOufAGd+O7gYQL2hRn/?=
 =?us-ascii?Q?xgm5Xj4uTHUNYqc/1yUL+qwmKHOi0oR+GTVdDF2zXQJn6Qu9NtlE2AfilfOP?=
 =?us-ascii?Q?kCdaJAfOQJzulcw9iaka7zEMSzrt6Yq/NTJlwPs91XagOIQX8e/cRK3wZzOw?=
 =?us-ascii?Q?PQyKJj47sYKgl++JJIGiDs1MmPsRNgCp7x+6TaLUabVCHQ0YXyTi3OaMLSVR?=
 =?us-ascii?Q?Ip9UcPFzKKUM/i+WR+rbbyu2fYFBmTKLxwA9RZnafIx2x2pptSf7A/JH/6/8?=
 =?us-ascii?Q?Ejo3x2z9P52+yW2AD2WsY5k+iaHb5jCsB7bmGFEW3LtN2xEL0vMnYu9AUPSy?=
 =?us-ascii?Q?yMVWObdH5NLweU6nlBJ/XOaZBTJiL0LkbembE2i+S7QSRY4AjEMrrBq0jXbD?=
 =?us-ascii?Q?Vq0epzj5ivr2Pq5zyyBAiF4b/1raTIHefXmwGH4n2NKRhrD7lVasAU9bWXdo?=
 =?us-ascii?Q?JKTysyko5o/Hu/gvRtqzFodfVfIcZUVA0N0gGXysdWGDiATt57lAizkJXAMY?=
 =?us-ascii?Q?ac9LSiZpUewDpvVnhJnwi2c2ieZujPG1D0TP1edc92JLmyhjCkJFI+w8xke0?=
 =?us-ascii?Q?xF82XXhf/3x0lSHjrCAdqqBddeHRg7fckBXOYP3o1dycqpQz8KGlPkTb9O+6?=
 =?us-ascii?Q?m8K4jwvSA/IvcOOl0h1I2EmcEnk2vfZWBmOyYppUSk8As+5iWi1MQs/Nnc4J?=
 =?us-ascii?Q?mDlGwtEL4F70zUCImPUm4IH/DSKiRFd9WkP8smYkHSpZqqBNQVrhXzSkXXWo?=
 =?us-ascii?Q?N1s9mrYdmLm8Onq8PPfsgAWuZqRalhAW91vOjwsmYYyJ7e+wrdWSo0Ly02Q9?=
 =?us-ascii?Q?XBZ6tqzq0/ikGPfwAbJknsw6oab77oFRZOqReZ+Je139MzqqEJ4RgMAqeenn?=
 =?us-ascii?Q?6W6+jgwAklo+pgZ5qXflQrgKsdL9toLJEUD6h655MjyRkTK90EsZugeEWHsd?=
 =?us-ascii?Q?UtkaG966s5+u/L7lKR0YUx7oNE1PO9tVDfa4OmvmWJzkgv6gm36OOW7eQ4xe?=
 =?us-ascii?Q?VjKYlVAqKC8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PK0F+1B/bTSVC8A60QQd0ZSv5vnMtIL/AGjX70hv8fY1eGrHoV3tkUPLqnpN?=
 =?us-ascii?Q?UlwxGCDcntDgIVdRUknz9blQfG8SiZm0otrInkcec/jJtBRXAr3+mOVbkeZF?=
 =?us-ascii?Q?CchjC7NFrTdK6qnamnCI9q9cvLrc0Akd+hbjglGg3L9CD6VmBSQxB7FtabT5?=
 =?us-ascii?Q?Y93lMIRRoW1CYrGnrw1KkZWD+vqQxip5wpsHdYo3JmU2Geu5KpBZaOAOaNfx?=
 =?us-ascii?Q?T5fWl5dk9Dt0SpVrL78mB1rNaYahI5oDEVxKYOvgHmBtr7c84kRP9TZbSgxn?=
 =?us-ascii?Q?ZwQHyg81+DxukxITq2EgN867iNALxkMTj2mmA2Lm4mr3wfB4yT9MIJM1c+mx?=
 =?us-ascii?Q?kq9UzBqBvqIG04xdJrj4/BMdbBZ+XFgvP8+be4TpnLYFMjHAxZSWrcIBpQdq?=
 =?us-ascii?Q?cp4vlGojcLj3BQKmUxD1vZ90Vcrfp0/tzDPk/IpLdhIBUMu6yI/1ka+tcp6N?=
 =?us-ascii?Q?zjq8YtGOL6948z+xgcseCb1u/kq4DEfSbZY0/TU0eTWv0Onv0ma+QQVRkjOa?=
 =?us-ascii?Q?malwrfwQCJvvljQyfKZV5O6zVWc91uGi18TtKRigKgBJbrQKZJMYK9rM4P6z?=
 =?us-ascii?Q?Lfaypx3jvULxZ3QSuGLq/bP3ErJmI7kpU06JvdhLO2BRtB6Nma1HyOKoHxhO?=
 =?us-ascii?Q?P9ZQXB6Tm1zfYA3xTh5NNpKxdptrMus+FwD2OMT7CLqTG+hnAZNyb0Ss4sFs?=
 =?us-ascii?Q?SoaQAUmEFRjOFmpQPO6a8fA/9jkfFGUitLfGpQtBSnCoDQiyjYQuGplql/3V?=
 =?us-ascii?Q?rLXfKTq/P/LesTJncLJo1U1OyQm+TP5Rhrhhg4fSLGfSVWUTzbMCpykCXo3+?=
 =?us-ascii?Q?lqoe/Gb87SW/FdWy1rf853CDRWnPT9LyKHR+Bz7XxTVn8L08uMMOAmA4iVPI?=
 =?us-ascii?Q?nQdKel1wW6BaC78v+XviZWDfWB0gkjY8ynDxenn5PRW7AaJLZmB+DXwu75o4?=
 =?us-ascii?Q?4+kVYESuCsaQv+zZNSfpYsvDT2Ja1cxSXhws7x6n2WxPq0uWVjcJfAUAyPIm?=
 =?us-ascii?Q?SZh3iOuv4EVn4JDrbAw2zu86NAnS2jviSa+NT+LSUsfeyx4rWU1diHZYl9Ts?=
 =?us-ascii?Q?gGAADdUH4XLsm/83WqQYdV9obwQROWJa2yU2kSiADqGd4jsv3AZ4z2IPVQns?=
 =?us-ascii?Q?OT9QmVSlnHN3BGVdURIa5zv6svw9EYv5o56RofqnlNKpUhU/pEmMLQhmoYQm?=
 =?us-ascii?Q?O8DRKAbI4nIEkZMyUp0nPlsT84LA8H+nzY6pp5McFkilaZin4y3kyCeWSqAP?=
 =?us-ascii?Q?rhHReGIHt5GKcPYa36k8ya21Up9JU0P6nmCN1IEgG/q7W0kM2elMAi9p798f?=
 =?us-ascii?Q?RLmSltH1um0aEyrzTN/X5gqdu20qZK2Q/7NahzG3pdw+DpsurKG6TkVhSCFW?=
 =?us-ascii?Q?FTV/pH3ilhvei4zTvIAxs5vCWFNWTVYuYYJwWbLhEn1sqPuy70kYOdHeBRS8?=
 =?us-ascii?Q?TbS5tvYS8pakcJ/8smlNs1KtlEBTMYd40tleGscnzSmFsbQWxOJpZvtkWFm3?=
 =?us-ascii?Q?pR+cNpkg+Vk/qI/H6QL4m1Z4GU7M6GCHmKAYj3DGvUXEwAuVmVUtNRS9Ir/e?=
 =?us-ascii?Q?zM7XSF3vlTY5ZM3Fud7a4HfqaOmUBh+Vlu8uNQl0fkLmMn4YU6JVj1MKoAci?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dca44ce-8c78-45b5-8c11-08ddc3e3af8d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 21:08:02.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twMV3ln/tVdm69vpVT0+/t9FTWaf11WdFIekBeuvnsKUlJMkU+m1x4+aIW6hwc6VdrFFe0uz/2LNieyo5zpLMsxTKpG4Zt+ACpucjn/8050=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8491
X-OriginatorOrg: intel.com

On Tue, Jul 15, 2025 at 06:04:00PM +0000, Smita Koralahalli wrote:
> This series introduces the ability to manage SOFT RESERVED iomem
> resources, enabling the CXL driver to remove any portions that
> intersect with created CXL regions.

Hi Smita,

This set applied cleanly to todays cxl-next but fails like appended
before region probe.

BTW - there were sparse warnings in the build that look related:
  CHECK   drivers/dax/hmem/hmem_notify.c
drivers/dax/hmem/hmem_notify.c:10:6: warning: context imbalance in 'hmem_register_fallback_handler' - wrong count at exit
drivers/dax/hmem/hmem_notify.c:24:9: warning: context imbalance in 'hmem_fallback_register_device' - wrong count at exit


This isn't all the logs, I trimmed. Let me know if you need more or
other info to reproduce.

[   53.652454] cxl_acpi:cxl_softreserv_mem_work_fn:888: Timeout waiting for cxl_mem probing
[   53.653293] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:321
[   53.653513] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1875, name: kworker/46:1
[   53.653540] preempt_count: 1, expected: 0
[   53.653554] RCU nest depth: 0, expected: 0
[   53.653568] 3 locks held by kworker/46:1/1875:
[   53.653569]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
[   53.653583]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
[   53.653589]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
[   53.653598] Preemption disabled at:
[   53.653599] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
[   53.653640] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Not tainted 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary) 
[   53.653643] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
[   53.653648] Call Trace:
[   53.653649]  <TASK>
[   53.653652]  dump_stack_lvl+0xa8/0xd0
[   53.653658]  dump_stack+0x14/0x20
[   53.653659]  __might_resched+0x1ae/0x2d0
[   53.653666]  __might_sleep+0x48/0x70
[   53.653668]  __kmalloc_node_track_caller_noprof+0x349/0x510
[   53.653674]  ? __devm_add_action+0x3d/0x160
[   53.653685]  ? __pfx_devm_action_release+0x10/0x10
[   53.653688]  __devres_alloc_node+0x4a/0x90
[   53.653689]  ? __devres_alloc_node+0x4a/0x90
[   53.653691]  ? __pfx_release_memregion+0x10/0x10 [dax_hmem]
[   53.653693]  __devm_add_action+0x3d/0x160
[   53.653696]  hmem_register_device+0xea/0x230 [dax_hmem]
[   53.653700]  hmem_fallback_register_device+0x37/0x60
[   53.653703]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
[   53.653739]  walk_iomem_res_desc+0x55/0xb0
[   53.653744]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
[   53.653755]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
[   53.653761]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
[   53.653763]  ? __pfx_autoremove_wake_function+0x10/0x10
[   53.653768]  process_one_work+0x1fa/0x630
[   53.653774]  worker_thread+0x1b2/0x360
[   53.653777]  kthread+0x128/0x250
[   53.653781]  ? __pfx_worker_thread+0x10/0x10
[   53.653784]  ? __pfx_kthread+0x10/0x10
[   53.653786]  ret_from_fork+0x139/0x1e0
[   53.653790]  ? __pfx_kthread+0x10/0x10
[   53.653792]  ret_from_fork_asm+0x1a/0x30
[   53.653801]  </TASK>

[   53.654193] =============================
[   53.654203] [ BUG: Invalid wait context ]
[   53.654451] 6.16.0CXL-NEXT-ALISON-SR-V5+ #5 Tainted: G        W          
[   53.654623] -----------------------------
[   53.654785] kworker/46:1/1875 is trying to lock:
[   53.654946] ff37d7824096d588 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x34/0x390
[   53.655115] other info that might help us debug this:
[   53.655273] context-{5:5}
[   53.655428] 3 locks held by kworker/46:1/1875:
[   53.655579]  #0: ff37d78240041548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x578/0x630
[   53.655739]  #1: ff6b0385dedf3e38 (cxl_sr_work){+.+.}-{0:0}, at: process_one_work+0x1bd/0x630
[   53.655900]  #2: ffffffffb33476d8 (hmem_notify_lock){+.+.}-{3:3}, at: hmem_fallback_register_device+0x23/0x60
[   53.656062] stack backtrace:
[   53.656224] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary) 
[   53.656227] Tainted: [W]=WARN
[   53.656228] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
[   53.656232] Call Trace:
[   53.656232]  <TASK>
[   53.656234]  dump_stack_lvl+0x85/0xd0
[   53.656238]  dump_stack+0x14/0x20
[   53.656239]  __lock_acquire+0xaf4/0x2200
[   53.656246]  lock_acquire+0xd8/0x300
[   53.656248]  ? kernfs_add_one+0x34/0x390
[   53.656252]  ? __might_resched+0x208/0x2d0
[   53.656257]  down_write+0x44/0xe0
[   53.656262]  ? kernfs_add_one+0x34/0x390
[   53.656263]  kernfs_add_one+0x34/0x390
[   53.656265]  kernfs_create_dir_ns+0x5a/0xa0
[   53.656268]  sysfs_create_dir_ns+0x74/0xd0
[   53.656270]  kobject_add_internal+0xb1/0x2f0
[   53.656273]  kobject_add+0x7d/0xf0
[   53.656275]  ? get_device_parent+0x28/0x1e0
[   53.656280]  ? __pfx_klist_children_get+0x10/0x10
[   53.656282]  device_add+0x124/0x8b0
[   53.656285]  ? dev_set_name+0x56/0x70
[   53.656287]  platform_device_add+0x102/0x260
[   53.656289]  hmem_register_device+0x160/0x230 [dax_hmem]
[   53.656291]  hmem_fallback_register_device+0x37/0x60
[   53.656294]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
[   53.656323]  walk_iomem_res_desc+0x55/0xb0
[   53.656326]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
[   53.656335]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
[   53.656342]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
[   53.656343]  ? __pfx_autoremove_wake_function+0x10/0x10
[   53.656346]  process_one_work+0x1fa/0x630
[   53.656350]  worker_thread+0x1b2/0x360
[   53.656352]  kthread+0x128/0x250
[   53.656354]  ? __pfx_worker_thread+0x10/0x10
[   53.656356]  ? __pfx_kthread+0x10/0x10
[   53.656357]  ret_from_fork+0x139/0x1e0
[   53.656360]  ? __pfx_kthread+0x10/0x10
[   53.656361]  ret_from_fork_asm+0x1a/0x30
[   53.656366]  </TASK>
[   53.662274] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
[   53.663552]  schedule+0x4a/0x160
[   53.663553]  schedule_timeout+0x10a/0x120
[   53.663555]  ? debug_smp_processor_id+0x1b/0x30
[   53.663556]  ? trace_hardirqs_on+0x5f/0xd0
[   53.663558]  __wait_for_common+0xb9/0x1c0
[   53.663559]  ? __pfx_schedule_timeout+0x10/0x10
[   53.663561]  wait_for_completion+0x28/0x30
[   53.663562]  __synchronize_srcu+0xbf/0x180
[   53.663566]  ? __pfx_wakeme_after_rcu+0x10/0x10
[   53.663571]  ? i2c_repstart+0x30/0x80
[   53.663576]  synchronize_srcu+0x46/0x120
[   53.663577]  kill_dax+0x47/0x70
[   53.663580]  __devm_create_dev_dax+0x112/0x470
[   53.663582]  devm_create_dev_dax+0x26/0x50
[   53.663584]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
[   53.663585]  platform_probe+0x61/0xd0
[   53.663589]  really_probe+0xe2/0x390
[   53.663591]  ? __pfx___device_attach_driver+0x10/0x10
[   53.663593]  __driver_probe_device+0x7e/0x160
[   53.663594]  driver_probe_device+0x23/0xa0
[   53.663596]  __device_attach_driver+0x92/0x120
[   53.663597]  bus_for_each_drv+0x8c/0xf0
[   53.663599]  __device_attach+0xc2/0x1f0
[   53.663601]  device_initial_probe+0x17/0x20
[   53.663603]  bus_probe_device+0xa8/0xb0
[   53.663604]  device_add+0x687/0x8b0
[   53.663607]  ? dev_set_name+0x56/0x70
[   53.663609]  platform_device_add+0x102/0x260
[   53.663610]  hmem_register_device+0x160/0x230 [dax_hmem]
[   53.663612]  hmem_fallback_register_device+0x37/0x60
[   53.663614]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
[   53.663637]  walk_iomem_res_desc+0x55/0xb0
[   53.663640]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
[   53.663647]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
[   53.663654]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
[   53.663655]  ? __pfx_autoremove_wake_function+0x10/0x10
[   53.663658]  process_one_work+0x1fa/0x630
[   53.663662]  worker_thread+0x1b2/0x360
[   53.663664]  kthread+0x128/0x250
[   53.663666]  ? __pfx_worker_thread+0x10/0x10
[   53.663668]  ? __pfx_kthread+0x10/0x10
[   53.663670]  ret_from_fork+0x139/0x1e0
[   53.663672]  ? __pfx_kthread+0x10/0x10
[   53.663673]  ret_from_fork_asm+0x1a/0x30
[   53.663677]  </TASK>
[   53.700107] BUG: scheduling while atomic: kworker/46:1/1875/0x00000002
[   53.700264] INFO: lockdep is turned off.
[   53.701315] Preemption disabled at:
[   53.701316] [<ffffffffb1e23993>] hmem_fallback_register_device+0x23/0x60
[   53.701631] CPU: 46 UID: 0 PID: 1875 Comm: kworker/46:1 Tainted: G        W           6.16.0CXL-NEXT-ALISON-SR-V5+ #5 PREEMPT(voluntary) 
[   53.701633] Tainted: [W]=WARN
[   53.701635] Workqueue: events cxl_softreserv_mem_work_fn [cxl_acpi]
[   53.701638] Call Trace:
[   53.701638]  <TASK>
[   53.701640]  dump_stack_lvl+0xa8/0xd0
[   53.701644]  dump_stack+0x14/0x20
[   53.701645]  __schedule_bug+0xa2/0xd0
[   53.701649]  __schedule+0xe6f/0x10d0
[   53.701652]  ? debug_smp_processor_id+0x1b/0x30
[   53.701655]  ? lock_release+0x1e6/0x2b0
[   53.701658]  ? trace_hardirqs_on+0x5f/0xd0
[   53.701661]  schedule+0x4a/0x160
[   53.701662]  schedule_timeout+0x10a/0x120
[   53.701664]  ? debug_smp_processor_id+0x1b/0x30
[   53.701666]  ? trace_hardirqs_on+0x5f/0xd0
[   53.701667]  __wait_for_common+0xb9/0x1c0
[   53.701668]  ? __pfx_schedule_timeout+0x10/0x10
[   53.701670]  wait_for_completion+0x28/0x30
[   53.701671]  __synchronize_srcu+0xbf/0x180
[   53.701677]  ? __pfx_wakeme_after_rcu+0x10/0x10
[   53.701682]  ? i2c_repstart+0x30/0x80
[   53.701685]  synchronize_srcu+0x46/0x120
[   53.701687]  kill_dax+0x47/0x70
[   53.701689]  __devm_create_dev_dax+0x112/0x470
[   53.701691]  devm_create_dev_dax+0x26/0x50
[   53.701693]  dax_hmem_probe+0x87/0xd0 [dax_hmem]
[   53.701695]  platform_probe+0x61/0xd0
[   53.701698]  really_probe+0xe2/0x390
[   53.701700]  ? __pfx___device_attach_driver+0x10/0x10
[   53.701701]  __driver_probe_device+0x7e/0x160
[   53.701703]  driver_probe_device+0x23/0xa0
[   53.701704]  __device_attach_driver+0x92/0x120
[   53.701706]  bus_for_each_drv+0x8c/0xf0
[   53.701708]  __device_attach+0xc2/0x1f0
[   53.701710]  device_initial_probe+0x17/0x20
[   53.701711]  bus_probe_device+0xa8/0xb0
[   53.701712]  device_add+0x687/0x8b0
[   53.701715]  ? dev_set_name+0x56/0x70
[   53.701717]  platform_device_add+0x102/0x260
[   53.701718]  hmem_register_device+0x160/0x230 [dax_hmem]
[   53.701720]  hmem_fallback_register_device+0x37/0x60
[   53.701722]  cxl_softreserv_mem_register+0x24/0x30 [cxl_core]
[   53.701734]  walk_iomem_res_desc+0x55/0xb0
[   53.701738]  ? __pfx_cxl_softreserv_mem_register+0x10/0x10 [cxl_core]
[   53.701745]  cxl_region_softreserv_update+0x46/0x50 [cxl_core]
[   53.701751]  cxl_softreserv_mem_work_fn+0x4a/0x110 [cxl_acpi]
[   53.701752]  ? __pfx_autoremove_wake_function+0x10/0x10
[   53.701756]  process_one_work+0x1fa/0x630
[   53.701760]  worker_thread+0x1b2/0x360
[   53.701762]  kthread+0x128/0x250
[   53.701765]  ? __pfx_worker_thread+0x10/0x10
[   53.701766]  ? __pfx_kthread+0x10/0x10
[   53.701768]  ret_from_fork+0x139/0x1e0
[   53.701771]  ? __pfx_kthread+0x10/0x10
[   53.701772]  ret_from_fork_asm+0x1a/0x30
[   53.701777]  </TASK>


