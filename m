Return-Path: <linux-fsdevel+bounces-38160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3D9FD29B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3351883A1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D971815666A;
	Fri, 27 Dec 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/f16b6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AD14C59B;
	Fri, 27 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735292791; cv=fail; b=f7ZTqfIXQgYqUgi3xsOQhZWgw3TDVVNWCkYpixHmhUrFKViW4Rjx/4wU8YVijiYoYRWeKnYJiJIYx6L6BwCR9jmtnZVUI8Hk/mFExSS0va8SfE5gQbLf69xTD6eZmRHKB588FqM0fAkH4CVb6MK4Fz6HX/V8YbKKABtt+qRjywQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735292791; c=relaxed/simple;
	bh=OkMPP91PjBmYN7dKXmJewqAuZ5RXaOYeWXb8VwO+Qxg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kpz/UXuSbXbniK8J997TyNwieihPkdWZTz3bGYEgkYTUhSey3mJdt4GAEs8CoNgydFXCTfQ7j0DpbmGDmohvzy9VBmt+P3XKe0fVSKT1VqZc/2qVpmRE892wYxI7xbQ72y1KFcKjyum1+QofIJp1QWiseCT/ySvdi5DDUI4edWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/f16b6n; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735292789; x=1766828789;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=OkMPP91PjBmYN7dKXmJewqAuZ5RXaOYeWXb8VwO+Qxg=;
  b=F/f16b6noYWNtTswmuhkh04UV6myhRdIZUwOWXu5rPPoMaR/d1jBxWxK
   mXA3UQjR36EQ4I8pV1iviMgqE64hyHdcrYx0ozsvwM18qfzkHYXzRBapN
   tsIiGcw611uNREpjj8GViBy+e2POqTdkoWSA1AMK+06IakMOOJ/Cfs3l3
   xYJWnQYabzRsKjHpKQoyAH1wzdahQhBARaNX6wIV0OVWXmOidvo61UkP4
   UOPZGv8ZPnEWWu0vdAjUeeMrLl9NOwTExXVR/b3HzqAaWT2r+2pkCA4c7
   JT/YbBJVv8jzohoQKj5Wf2vgX9v55BYnDwbrzO0hwjke3pSFb0xDh8i21
   Q==;
X-CSE-ConnectionGUID: +oXPs01pQzesIycIgOL0XQ==
X-CSE-MsgGUID: REJ/vXlpRAKFAqewv0iE6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="39383878"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="39383878"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 01:46:28 -0800
X-CSE-ConnectionGUID: y2eKoIIgTQm6Yog7kTGKsg==
X-CSE-MsgGUID: 8bL4JEuGRdqgZmVwvLS2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="100312063"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2024 01:46:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 27 Dec 2024 01:46:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 27 Dec 2024 01:46:18 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 27 Dec 2024 01:46:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcAzf/4Ims6t3xw0yH8ScbtGvPDXik5kDNu2Eze6M1hX0Me1FRZJHGp/pfRziQl5Gaoubfyio88cNj4kkDqZvNQtAhu4Cm4wRpHuDSRx4ccRYDYQByGYOzN4Y40Zcn0/8pVwCtuL5Up9XB8PR0TjyIxCNbhtFUVPS/oCMukVBNmmLfJZPZUy+RGoWtFeEsKjnlKC327B9Qtupz5z2QDzrH+aKF2S7eo3ZhczsKoEoH9Gpy6E+YQS5Y++yPGdBsj6+yD4gjDVqvb6PUXuUPicnW38cBtt9q3MTAdMWd7sZIu1+tXVXoSbFfQ2iuUVfhm0eY25sgDwe3887N5+sA9RbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Neov3jm9vzU1f5L/fXNcp6JUP0PdKbCKbP4kYRTXz4=;
 b=DFlvUNr5pvu2XxoH4o8wNiOPX+Acoec0rZiWNsXPVU0m5kRDUW7PDqKSyHwKLmyxdN7XMeM14UM4bo+cfHl39Xn9pmXRFwSw/TDv5jYWB3VwimSyNYc19hZjnRIosVpCsTGh84GMZgb1gfrDYeXccngiyj8gMj/tzkKswcRd4w4fiUpC1hwR74GfE46nDfo89xDVR3XVlB7GwjEvkWIRXkAgNR5S74BBbQHguw4G8xp/Rngt192kUgeIU/CsWVuOYTZWDxe05Ib/eqlayOcPN3vzNDsA9oVM0aPd8754JsPWe3xyp8IkdIwu8wT1TqXwlOTd/n6cbmkpYiN7NEQneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Fri, 27 Dec
 2024 09:45:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 09:45:48 +0000
Date: Fri, 27 Dec 2024 17:45:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<christianvanbrauner@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:vfs-6.14.pidfs.rbtree] [pidfs]  edf7688ac3:
 stress-ng.vfork.ops_per_sec 6.3% regression
Message-ID: <202412271749.c850f314-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6757fb52-56e9-4b89-2c80-08dd265b3e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pmbk6TSq7aJLpbnhsN7V5JTV4ZhHSCkViv5cRbQX5NjdkPZzUjH1WVPVNg?=
 =?iso-8859-1?Q?BXDax+HvTAVWslX6qrMjkXt5eZzgCgO9k+8llH0MkoMBpxi3FNucnpd61u?=
 =?iso-8859-1?Q?mjcs4SDo8EpxjnQl0ZSo+RxJV+pUgpHmbotUCvj3BEN9jIvK7y44Oag/0i?=
 =?iso-8859-1?Q?Cjv+vo2xIZDV3G/QroKyxI0xUNw/xigRWW513XINInWsphgj4bv/GJVxSR?=
 =?iso-8859-1?Q?5deSEo2S5NfbRSne0i/GOzEmQS1+Io9C78FRUKx/ceEaaEnuDvRZDH7pOE?=
 =?iso-8859-1?Q?FVhpINxN51f7Yg6kHD6H0aR2pfcZI7wFxP9rdmq/wpN+JIMSUu6sXazyrg?=
 =?iso-8859-1?Q?Ps9jq0MIMxEvf5eL2LKsVozi+YkRm4GG9qcTUMEnX9Rb6K7lJ9wdnAkIrZ?=
 =?iso-8859-1?Q?STdwXZZBtST99zb/nqGBQow78nw/vfr5g/CfDkwyIhuUbC0OJMjKDXkv/0?=
 =?iso-8859-1?Q?2vPsy2wDnhjhtPr3iVcl11mzDoIsSz7uZ1w6RTr/+EG3lEkZkUcwPiOF4X?=
 =?iso-8859-1?Q?SjRTToutCu4SHdYSNzqx2NXLoXe4s9A8JHRM85Oa7NtvtfufRFSGJ3ttLr?=
 =?iso-8859-1?Q?SYMMTWYKQI6dHB3gnPGkxhSOo4OsYAq56t697a0gHV//2bJsVutNmNyH55?=
 =?iso-8859-1?Q?rPZKn9/mOyEg79UPvlJcYc6XgTACFa81GAzQLNMTU83rn3TJzrKjEvceEc?=
 =?iso-8859-1?Q?dxyIPfWOqQjgr1CtQ3rZcOtpK5AsubWw0JC9pTSOmFWIA5Rj1TnoZ5u+6b?=
 =?iso-8859-1?Q?HnVOWWEDzh5DhB5I9xs6AcuWokzi6xsHdH+BwKWTiIoCpcP3U3g82rhAjm?=
 =?iso-8859-1?Q?zGoygV79LRoQn4tjkyBw0S/MoeS3XB5bvicRceWkr5rhtZ+LeC+/Q2/9C1?=
 =?iso-8859-1?Q?dRVhlhqDxTxnd6s0y8/JPo1ICGUXSv3LRr0Ikyz0ObxHR7v8b9VRrW8I90?=
 =?iso-8859-1?Q?XUQNRxHw2KRl7eSrdAqLhyOUeYT+BFhUbdYSmKy8KhO6/ehVzPxtK/jomu?=
 =?iso-8859-1?Q?CZZENff90OFuykBum7cBa7Q6+gFmH+z/Ra5Dy1uIkVuYpQQV2U0YpP1W7K?=
 =?iso-8859-1?Q?TlzuMUY5yP8jaA3Kl/TqFlZJvRfsStv4h1jCrZ32yGjEVzHDAykyi0bWte?=
 =?iso-8859-1?Q?FGFWUtDIsF5gGWSFOXMhjckv7v+3X0sAJZ7z5JeLOj4EQ4KLAC5AeOzXTz?=
 =?iso-8859-1?Q?9xtCnv3GEfGD7hIiDt4n5kVo7a8Nb58pm1We/JduG+s5zicATzMkFuaeFt?=
 =?iso-8859-1?Q?2y3rXa4JJkrpd4K3em1yTDjmlSGcsWUvgzAKihPfzMt+xVwAmli4cecrwx?=
 =?iso-8859-1?Q?y0Jo1O5j085GaGq04FKufhxF27SAGld0xodsRqtoI9uNsICX4QGw3FuExK?=
 =?iso-8859-1?Q?UmqO/ID0SQc8ewj4aUvzRXZdDfuie+2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KBqfSLZ0aqEtkKUNxCsAYwpVSfDO6DE1y5WyJ0eEIL5nvKXI8OVMCORPNY?=
 =?iso-8859-1?Q?yhUO8zxL+QM5GZxBdWbp6OdyA5PU9fb1XTWGKJK4qljRpWiMujNLa0KMLx?=
 =?iso-8859-1?Q?5w5Ak2CDowWy7nMtYY7uWHvpyYhS6dcJ+kw48FBOv4XUBJ4azafEE1nvkB?=
 =?iso-8859-1?Q?GlJKyGYcmRJ/XyGGK697REjgG/cTLWIe1Cpfm09+fB9ovVrkyxzO3pfXb8?=
 =?iso-8859-1?Q?o6Sh87qRerWBcWTpyTtleU2FsZ65i73101fr+n15VgNAFxRtkxpsE3pmc2?=
 =?iso-8859-1?Q?8uthpBF62pVPl4Zeal1hWyI0QIZ8f2bfNAyluUKqmXZ4Dvi2Jr0Lwcef+Y?=
 =?iso-8859-1?Q?MzIo9iwiOLSIXA537MLKRj8ofLvYuqrBn8NuXIxVWnJVVVTtEPk34DcQqt?=
 =?iso-8859-1?Q?Nw4QdNskksfdKe6qSzDMMoWpr9LHfi/w5Og+rEcNp6HNrkF48iMRVnnKyJ?=
 =?iso-8859-1?Q?8cQt6WymDvdPsuOYVw3GxN1mxDYW44lCtcMeBZyxjj7YfPRlgReG74F9Jk?=
 =?iso-8859-1?Q?j9XEQ697eMt+uJWQ3jDTv4nDE2ar6Zh+oON9rlWoStdaw5jhVu7vXrFOsx?=
 =?iso-8859-1?Q?mgk1JO+56ijM3P3H3ufi2gFxcOBrCnTYDkpEZZZSxZ0weq0nAwdAdL4DHN?=
 =?iso-8859-1?Q?V8cYvT644qC9qTb3Yp+DvEZX+y1y4n6kNsLvlf3HQ5zP2r0OOmjANPBK6b?=
 =?iso-8859-1?Q?3IfR2V1v8QaM8n656TaJUF1995Mqevg+wFlyN+DSl0C+ypazQ5A3M3PuZN?=
 =?iso-8859-1?Q?aFyiw4wdnN1AZce39L4dm8yaeoIAp+KT7VGBSYnObqhmDrE1X2GhFcaTVV?=
 =?iso-8859-1?Q?o4kIMwqWJK6zbKa04OIZbUP3q4NXFX8+UVY81jJOPOJUjj2S7InKbN2vc4?=
 =?iso-8859-1?Q?Y0itgTxLrDVIv9kU/n//xSpk7MvnNavXHwvO/2/U/HYWq4sY4xJ3vmCmIm?=
 =?iso-8859-1?Q?dtFyljLAOHg/4A4F2DC6pf0tmGuczauPr3ehiV70SgkEKzXilBCCzR6hBi?=
 =?iso-8859-1?Q?c3Yoj4uH3EcDU2scf1dk3zdKrE+lqEm2m+Y105eRs4qStA6v0SBpFVjmac?=
 =?iso-8859-1?Q?2DevVjvUA62CZbjWM1H9laL6Hla8rkTMvmBMs+j2AEDFCz3kAT7TQ7lDkh?=
 =?iso-8859-1?Q?xX3pSYxYws4lr45td8Ai1AvVIagSX4rBIZLZggknyin12p2hkiuo+sUvNn?=
 =?iso-8859-1?Q?W2Hj1Z/HqGX1G9HnL7gdHQH8dBHhYPUF5n75rFw4zSlnq+KaVxb3SBqxwA?=
 =?iso-8859-1?Q?Rh9QDpRuKfAuG0zuUwiyVc4VZuZYJluLqavVomkYPQer5JalqcXr7xNHtq?=
 =?iso-8859-1?Q?oo0AJX7tTc5YlCS9Ck7ZUS7jxc3f1BcrH1cJlExpFdX2iOR0P3go2AK7XW?=
 =?iso-8859-1?Q?bWuIra8ko2OR/puiXzkvbeNqrqD/KaxqwWNc5ZvFeG400SVfQIDdYmhnav?=
 =?iso-8859-1?Q?WKR0t6K3ounQPUqQYcqPQ8HmjtXLnNgC/fnaZLU7BXw1e90FyzuqfcCaub?=
 =?iso-8859-1?Q?7o2koTi4HaUsTZRKAxg/GcLbgqBMCC9odni2s5Il3FDNNcP9EgZONkzYwF?=
 =?iso-8859-1?Q?cAku4WaDRar/QwO0lXuwK+YZec4VjV7chIjQP8eacHKB7TabVYLgcgJuGR?=
 =?iso-8859-1?Q?0wl8okXbb32xu/vdHCh23FuJ5xJUTTYcIXLdiEeL3epnF2zjPsorsH8w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6757fb52-56e9-4b89-2c80-08dd265b3e41
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 09:45:48.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FPlK7QPLSjhClhM67Xjv2DESqHj9Bg2gehGxSAxhMioEVQw8exQj0OvVlPVj+rasCAi+3B0kCGe5M3QGiKxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.3% regression of stress-ng.vfork.ops_per_sec on:


commit: edf7688ac37a6a47514e2cb177fe10e410db9674 ("pidfs: switch inode number handling to rbtree")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs-6.14.pidfs.rbtree

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: vfork
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412271749.c850f314-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241227/202412271749.c850f314-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/vfork/stress-ng/60s

commit: 
  edad425380 ("selftests/pidfd: add pidfs file handle selftests")
  edf7688ac3 ("pidfs: switch inode number handling to rbtree")

edad425380ed4116 edf7688ac37a6a47514e2cb177f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  15918750 ±  5%      -9.9%   14336251 ±  3%  numa-numastat.node1.local_node
  15950029 ±  5%      -9.9%   14365294 ±  3%  numa-numastat.node1.numa_hit
  15954161 ±  5%     -10.0%   14366480 ±  3%  numa-vmstat.node1.numa_hit
  15922883 ±  5%     -10.0%   14337437 ±  3%  numa-vmstat.node1.numa_local
    647206           -10.5%     578993 ±  5%  vmstat.system.cs
    380717            -8.9%     346823 ±  5%  vmstat.system.in
    167147 ±  3%      +8.7%     181643 ±  2%  proc-vmstat.numa_hint_faults
  30332837            -7.0%   28221931        proc-vmstat.numa_hit
  30267884            -7.0%   28155207        proc-vmstat.numa_local
  34551304            -6.9%   32180388        proc-vmstat.pgalloc_normal
  33009410            -7.0%   30684198        proc-vmstat.pgfree
   1614931            -6.7%    1506135        stress-ng.time.involuntary_context_switches
    790.07            -0.8%     783.52        stress-ng.time.user_time
  23265260            -6.3%   21800989        stress-ng.time.voluntary_context_switches
  12307961            -6.3%   11529554        stress-ng.vfork.ops
    205132            -6.3%     192158        stress-ng.vfork.ops_per_sec
  29302878 ±  6%     -17.8%   24086759 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.avg
  96873364 ± 12%     -37.5%   60585832 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.max
  18734253 ± 18%     -29.5%   13208183 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.stddev
  29302878 ±  6%     -17.8%   24086759 ±  5%  sched_debug.cfs_rq:/.min_vruntime.avg
  96873364 ± 12%     -37.5%   60585854 ± 15%  sched_debug.cfs_rq:/.min_vruntime.max
  18734253 ± 18%     -29.5%   13208184 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
   1856068           -20.7%    1471996        sched_debug.cpu.curr->pid.max
    809836 ±  2%     -19.8%     649589 ±  7%  sched_debug.cpu.curr->pid.stddev
      2392 ± 14%     -19.6%       1923 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
      3.09            -5.8%       2.91 ±  4%  perf-stat.i.MPKI
 8.899e+09            -4.0%  8.543e+09 ±  2%  perf-stat.i.branch-instructions
 1.264e+08 ±  2%      -8.1%  1.161e+08 ±  5%  perf-stat.i.cache-misses
 7.167e+08            -7.3%  6.648e+08 ±  2%  perf-stat.i.cache-references
    675889           -11.3%     599542 ±  5%  perf-stat.i.context-switches
     64552            -0.6%      64181        perf-stat.i.cpu-clock
    129400 ±  3%      -6.5%     120940 ±  5%  perf-stat.i.cpu-migrations
      1722            +4.3%       1795        perf-stat.i.cycles-between-cache-misses
 4.113e+10            -4.2%  3.939e+10 ±  2%  perf-stat.i.instructions
     12.56           -10.3%      11.27 ±  5%  perf-stat.i.metric.K/sec
     64552            -0.6%      64181        perf-stat.i.task-clock
      3.08            -4.3%       2.95 ±  2%  perf-stat.overall.MPKI
      1709 ±  2%      +5.1%       1796        perf-stat.overall.cycles-between-cache-misses
 8.677e+09            -3.2%  8.399e+09 ±  2%  perf-stat.ps.branch-instructions
 1.235e+08 ±  2%      -7.5%  1.142e+08 ±  4%  perf-stat.ps.cache-misses
 6.999e+08            -6.5%  6.547e+08        perf-stat.ps.cache-references
    658555           -10.3%     590475 ±  4%  perf-stat.ps.context-switches
  4.01e+10            -3.4%  3.872e+10 ±  2%  perf-stat.ps.instructions
      0.05 ± 33%    +121.5%       0.11 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.13           +11.7%       0.15 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
      0.14 ±  2%      +9.3%       0.16 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.03 ± 10%     -12.4%       0.03 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.vfree.part.0.delayed_vfree_work
      0.04 ±108%    +380.0%       0.17 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      0.04 ± 78%     -80.1%       0.01 ±134%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vm_area.vfree.part.0
      0.25 ± 10%     +62.4%       0.40 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.52 ± 51%   +1084.8%       6.20 ±167%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     84.94 ±169%    +839.8%     798.27 ± 21%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      5.46 ± 46%     -78.4%       1.18 ±122%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vm_area.vfree.part.0
    396.01 ± 16%     -54.2%     181.29 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     27966 ±  4%     -11.6%      24715 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.down_read.exit_mm.do_exit.__x64_sys_exit
     30.75 ± 21%    +106.2%      63.40 ±  6%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      6.49 ± 59%     -81.8%       1.18 ±122%  perf-sched.wait_and_delay.max.ms.__cond_resched.remove_vm_area.vfree.part.0
      0.06 ± 59%    +796.1%       0.56 ±114%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
     84.87 ±169%    +840.5%     798.17 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.24 ±102%    +180.7%       0.66 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.03 ± 23%    +188.5%       0.10 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      5.43 ± 46%     -78.4%       1.17 ±122%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vm_area.vfree.part.0
    395.91 ± 16%     -54.2%     181.22 ± 10%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      0.29 ± 51%   +2699.9%       8.02 ±147%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    251.43 ±172%    +297.9%       1000        perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.25 ±  7%     +43.4%       0.36 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mm.do_exit.__x64_sys_exit
      0.81 ± 37%    +178.2%       2.25 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      0.27 ± 23%    +928.3%       2.79 ± 94%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fdget_pos.ksys_write.do_syscall_64
      6.45 ± 59%     -81.8%       1.17 ±122%  perf-sched.wait_time.max.ms.__cond_resched.remove_vm_area.vfree.part.0
    127.42 ±168%    +631.3%     931.78 ± 55%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.52            -0.2        0.30 ± 81%  perf-profile.calltrace.cycles-pp.nsinfo__new.thread__new.threads__findnew.machine__findnew_thread.machine__process_fork_event
      1.68            -0.1        1.53 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
      1.64            -0.1        1.50 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.64            -0.1        1.50 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.64            -0.1        1.49 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.20            -0.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.12            -0.1        1.02 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.12            -0.1        1.01 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.12            -0.1        2.02        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.08            -0.1        0.98 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.08            -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.96            -0.1        0.87        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.96            -0.1        0.87        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.96            -0.1        0.87        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.74            -0.1        1.64        perf-profile.calltrace.cycles-pp.syscall
      1.70            -0.1        1.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      1.69            -0.1        1.60        perf-profile.calltrace.cycles-pp.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.69            -0.1        1.60        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.30            -0.1        1.22        perf-profile.calltrace.cycles-pp.dup_task_struct.copy_process.kernel_clone.__x64_sys_vfork.do_syscall_64
      1.70            -0.1        1.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.48            -0.1        1.40        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__x64_sys_vfork.do_syscall_64
      1.38            -0.1        1.31        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.select_task_rq_fair.wake_up_new_task.kernel_clone.__x64_sys_vfork
      1.29            -0.1        1.22        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.sched_balance_find_dst_group.select_task_rq_fair.wake_up_new_task.kernel_clone
      0.96            -0.1        0.89        perf-profile.calltrace.cycles-pp.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone.__x64_sys_vfork
      1.02            -0.1        0.96        perf-profile.calltrace.cycles-pp.acct_collect.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
      0.68            -0.0        0.64        perf-profile.calltrace.cycles-pp.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct.copy_process.kernel_clone
      0.64            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_find.acct_collect.do_exit.__x64_sys_exit.x64_sys_call
      0.59            -0.0        0.57        perf-profile.calltrace.cycles-pp.machine__findnew_thread.machine__process_fork_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.56            -0.0        0.54        perf-profile.calltrace.cycles-pp.threads__findnew.machine__findnew_thread.machine__process_fork_event.perf_session__deliver_event.__ordered_events__flush
      0.54            -0.0        0.52        perf-profile.calltrace.cycles-pp.thread__new.threads__findnew.machine__findnew_thread.machine__process_fork_event.perf_session__deliver_event
      0.84            -0.0        0.82        perf-profile.calltrace.cycles-pp.machine__process_fork_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
     23.22            +0.1       23.30        perf-profile.calltrace.cycles-pp.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.22            +0.1       23.31        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.40            +0.1       20.49        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__x64_sys_vfork.do_syscall_64
     23.22            +0.1       23.30        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.22            +0.1       23.31        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     20.04            +0.1       20.12        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__x64_sys_vfork
     20.81            +0.1       20.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4
     21.18            +0.1       21.30        perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4.do_syscall_64
     24.26            +0.2       24.42        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.55            +0.2       20.73        perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_wait4.do_syscall_64
     18.98            +0.2       19.17        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait
     19.38            +0.2       19.57        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait.do_wait
     20.42            +0.2       20.61        perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_wait4
     20.71            +0.2       20.90        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
     19.86            +0.2       20.05        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit
     20.22            +0.2       20.42        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
      0.54            +0.2        0.77        perf-profile.calltrace.cycles-pp.alloc_pid.copy_process.kernel_clone.__x64_sys_vfork.do_syscall_64
     42.20            +0.3       42.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
     42.13            +0.3       42.41        perf-profile.calltrace.cycles-pp.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
     42.20            +0.3       42.47        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
     42.24            +0.3       42.52        perf-profile.calltrace.cycles-pp.wait4
     42.00            +0.3       42.29        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
     41.84            +0.3       42.14        perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26            -0.5        0.77 ± 74%  perf-profile.children.cycles-pp.__cmd_record
      1.68            -0.1        1.53 ±  2%  perf-profile.children.cycles-pp.common_startup_64
      1.68            -0.1        1.53 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.64            -0.1        1.50 ±  2%  perf-profile.children.cycles-pp.start_secondary
      1.67            -0.1        1.52 ±  2%  perf-profile.children.cycles-pp.do_idle
      1.14            -0.1        1.03 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.23            -0.1        1.12 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      2.12            -0.1        2.02        perf-profile.children.cycles-pp.wake_up_new_task
      1.10            -0.1        0.99 ±  3%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      1.19            -0.1        1.08        perf-profile.children.cycles-pp.ret_from_fork_asm
      1.10            -0.1        0.99 ±  3%  perf-profile.children.cycles-pp.acpi_safe_halt
      1.10            -0.1        1.00 ±  3%  perf-profile.children.cycles-pp.acpi_idle_enter
      1.14            -0.1        1.04 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      1.75            -0.1        1.65        perf-profile.children.cycles-pp.syscall
      1.04            -0.1        0.95        perf-profile.children.cycles-pp.ret_from_fork
      0.96            -0.1        0.87        perf-profile.children.cycles-pp.kthread
      0.17 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.radix_tree_delete_item
      1.30            -0.1        1.22        perf-profile.children.cycles-pp.dup_task_struct
      0.16 ±  2%      -0.1        0.08        perf-profile.children.cycles-pp.idr_alloc_cyclic
      0.96            -0.1        0.88        perf-profile.children.cycles-pp.handle_softirqs
      1.57            -0.1        1.49        perf-profile.children.cycles-pp.select_task_rq_fair
      0.84            -0.1        0.76        perf-profile.children.cycles-pp.rcu_do_batch
      0.86            -0.1        0.78        perf-profile.children.cycles-pp.rcu_core
      0.20            -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.15 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.idr_alloc_u32
      1.39            -0.1        1.32        perf-profile.children.cycles-pp.sched_balance_find_dst_group
      1.33            -0.1        1.26        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.13 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.idr_get_free
      0.96            -0.1        0.89        perf-profile.children.cycles-pp.alloc_thread_stack_node
      1.04            -0.1        0.99        perf-profile.children.cycles-pp.acct_collect
      0.69            -0.1        0.64        perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.54 ±  2%      -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.53            -0.1        0.48        perf-profile.children.cycles-pp.worker_thread
      0.43            -0.0        0.38        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.48            -0.0        0.43        perf-profile.children.cycles-pp.process_one_work
      0.74            -0.0        0.69        perf-profile.children.cycles-pp._raw_spin_lock
      0.42            -0.0        0.38        perf-profile.children.cycles-pp.delayed_vfree_work
      0.37            -0.0        0.33        perf-profile.children.cycles-pp.run_ksoftirqd
      0.93            -0.0        0.89        perf-profile.children.cycles-pp.dequeue_entities
      0.41 ±  2%      -0.0        0.37        perf-profile.children.cycles-pp.vfree
      0.45            -0.0        0.42 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.53            -0.0        0.49 ±  2%  perf-profile.children.cycles-pp.sched_move_task
      0.68            -0.0        0.64        perf-profile.children.cycles-pp.mas_find
      0.22 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.put_cred_rcu
      0.60            -0.0        0.56        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.96            -0.0        0.92        perf-profile.children.cycles-pp.dequeue_task_fair
      0.50            -0.0        0.46        perf-profile.children.cycles-pp.kmem_cache_free
      0.51            -0.0        0.48        perf-profile.children.cycles-pp.exit_mm
      0.52            -0.0        0.49        perf-profile.children.cycles-pp.try_to_wake_up
      0.80            -0.0        0.77        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.28            -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.remove_vm_area
      0.45            -0.0        0.42        perf-profile.children.cycles-pp.__vmalloc_area_node
      0.53            -0.0        0.50        perf-profile.children.cycles-pp.mas_next_slot
      0.35            -0.0        0.32        perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.44            -0.0        0.41        perf-profile.children.cycles-pp.mm_release
      0.37            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.56            -0.0        0.53        perf-profile.children.cycles-pp.try_to_block_task
      0.59            -0.0        0.57        perf-profile.children.cycles-pp.machine__findnew_thread
      0.52            -0.0        0.50        perf-profile.children.cycles-pp.nsinfo__new
      0.23            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.47            -0.0        0.45        perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.84            -0.0        0.82        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.42            -0.0        0.40        perf-profile.children.cycles-pp.complete
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.cgroup_exit
      0.23            -0.0        0.21        perf-profile.children.cycles-pp.clear_page_erms
      0.58            -0.0        0.56        perf-profile.children.cycles-pp.dequeue_entity
      0.51            -0.0        0.49        perf-profile.children.cycles-pp.fstatat64
      0.46            -0.0        0.44        perf-profile.children.cycles-pp.vfs_fstatat
      0.44            -0.0        0.43        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.54            -0.0        0.53        perf-profile.children.cycles-pp.thread__new
      0.23            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.56            -0.0        0.54        perf-profile.children.cycles-pp.threads__findnew
      0.84            -0.0        0.82        perf-profile.children.cycles-pp.machine__process_fork_event
      0.20            -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.perf_event_task_output
      0.21            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.12            -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.perf_event_task
      0.23            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__put_task_struct
      0.12 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.cgroup_leave_frozen
      0.37            -0.0        0.36        perf-profile.children.cycles-pp.filename_lookup
      0.42            -0.0        0.41        perf-profile.children.cycles-pp.vfs_statx
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.cgroup_css_set_fork
      0.82            -0.0        0.81        perf-profile.children.cycles-pp.enqueue_task
      0.17            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__task_rq_lock
      0.37            -0.0        0.35        perf-profile.children.cycles-pp.path_lookupat
      0.15            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.cgroup_can_fork
      0.27            -0.0        0.25        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.22 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.put_ucounts
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.step_into
      0.26            -0.0        0.24        perf-profile.children.cycles-pp.dup_fd
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.find_get_pid
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp._atomic_dec_and_lock_irqsave
      0.12            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.23            -0.0        0.22        perf-profile.children.cycles-pp.memset_orig
      1.16            -0.0        1.15        perf-profile.children.cycles-pp.perf_session__deliver_event
      0.16 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.copy_signal
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.___slab_alloc
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.__switch_to_asm
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.17            -0.0        0.16        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.free_vmap_area_noflush
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.handle_internal_command
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.main
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.perf_mmap__push
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.run_builtin
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.28            +0.0        0.29        perf-profile.children.cycles-pp.free_pid
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__wake_up
      0.53            +0.0        0.56        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  6%      +0.1        0.13        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.pidfs_remove_pid
     21.18            +0.1       21.30        perf-profile.children.cycles-pp.queued_read_lock_slowpath
     24.29            +0.1       24.44        perf-profile.children.cycles-pp.copy_process
      0.11            +0.1        0.26        perf-profile.children.cycles-pp.pidfs_add_pid
     20.55            +0.2       20.73        perf-profile.children.cycles-pp.wait_task_zombie
     20.43            +0.2       20.62        perf-profile.children.cycles-pp.release_task
     20.72            +0.2       20.91        perf-profile.children.cycles-pp.exit_notify
      0.54            +0.2        0.77        perf-profile.children.cycles-pp.alloc_pid
     95.77            +0.3       96.03        perf-profile.children.cycles-pp.do_syscall_64
     95.78            +0.3       96.05        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.25            +0.3       42.53        perf-profile.children.cycles-pp.wait4
     42.13            +0.3       42.41        perf-profile.children.cycles-pp.kernel_wait4
     42.00            +0.3       42.29        perf-profile.children.cycles-pp.do_wait
     41.84            +0.3       42.14        perf-profile.children.cycles-pp.__do_wait
     60.00            +0.5       60.48        perf-profile.children.cycles-pp.queued_write_lock_slowpath
     80.38            +0.6       81.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.20            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.76            -0.1        0.68 ±  4%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.13            -0.1        0.06        perf-profile.self.cycles-pp.idr_get_free
      1.14            -0.1        1.08        perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.55            -0.0        0.52        perf-profile.self.cycles-pp._raw_spin_lock
      0.23            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.36 ±  2%      -0.0        0.34        perf-profile.self.cycles-pp.acct_collect
      0.36            -0.0        0.34        perf-profile.self.cycles-pp.mas_next_slot
      0.22 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      0.42            -0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.10            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp._atomic_dec_and_lock_irqsave
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.__switch_to_asm
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.enqueue_task_fair
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.pids_release
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.put_cred_rcu
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.user_disable_single_step
      0.06            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.2        0.22        perf-profile.self.cycles-pp.pidfs_add_pid
     80.22            +0.6       80.84        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


