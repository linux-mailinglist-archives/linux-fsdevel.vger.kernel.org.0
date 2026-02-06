Return-Path: <linux-fsdevel+bounces-76518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDv2DkNXhWkhAQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:51:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8BFF9750
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B4413025F7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC627FD5D;
	Fri,  6 Feb 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5kFmNMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3994261B70
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346297; cv=fail; b=GoYU1jbfjpIoIuCWM1gwU+/uOFcGLDMUK8OOzS9CzY3EsbExJQNlgq58R52uiOL2iR9LfU0nb317C1Zdnr8IUOe6Grv+YiqHaQClirb13nKRTzPXkQmbkPbCCH6kMCMHoiGYW8YDJCEt7x4CACx7FcLheYbiI7V6CDNWhgnI74A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346297; c=relaxed/simple;
	bh=HSUcStNSiag2fSLOrSgVQs3wghId4T9TVnBDD5NQlOc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PESBeUZXkDzIAfk8v27FucEuje+PdnAFsba1zXhZZpBfqjRuGa/RyNWuKjJd0eXyldK7Ek6JRZyVNYvA9Av1BeRxJDVLnNwBmvygureWyVSxWEvAU3bVm2029iLCgSRTya1mv6rOdYvv/P3VtRRDaQiKP7IXLz9TKamg3fa5Kng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5kFmNMH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770346298; x=1801882298;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HSUcStNSiag2fSLOrSgVQs3wghId4T9TVnBDD5NQlOc=;
  b=M5kFmNMHxNeNcrYz9VTJOjOKn58NpqYHZSB7bFaHpVtyNSCFOwSZXMP3
   la2Zxsj/0HMl9+s9s0vwAeq5+JkIyHMjJ0v/VEVHAjWM43BjbG3KKkdGL
   pmHfX6OfnfjmvdMm/XCc9tVciLUpyj7Au5eK1K0Zjd3N5bktqT2lbiY9b
   mQF4CtmKknSkxu1HGlezT2LE4hKrlbGHepcMfLGo178wC3cj4VtxAV0H+
   5zlHX+VBhQ4GFzQXJKJzEyvBfyquvYf1QNvt9/AX7LdESC7NOz7I9YL0z
   GxVVDS1HuM6imJEIRG8zeftE3MeTaCmSzKduXxHqLgVT5N8oc9t5tLdJC
   w==;
X-CSE-ConnectionGUID: 87Qgnli0Q4+6zQswxtR3jQ==
X-CSE-MsgGUID: av2cT285SIaSP/p6o2HSzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82669099"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82669099"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 18:51:37 -0800
X-CSE-ConnectionGUID: 9CbMuVfYRtqo7G66w6STaA==
X-CSE-MsgGUID: ZRZnRI72SQmsyR904ss7Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="241265690"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 18:51:36 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 18:51:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 18:51:36 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 18:51:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ1XRo9W7hYQUvlQZOVg3fbYQ+FgVF86+7hiX9susHzwHpyYRK87g+SSmxjynl9be0lweqAuXJfYKvPTyiO3S0G2p+73YauxFc2A4+FFp1G6HAC+bpHmaijTdXx3v0dmlm0RI9VcJo74EF0coZB3OtISO+xNuG8vpeu2MhZGLp3zVQ+Jyct8wAYZSTv/Rnn+pALhkBA8CH5+ocdovHjKVP+TyaVAOUt9T6YuAa4qiGyNbBa9uGV2KDLCzq7juw1Ju9//tesvGVYSdPCGVqqj+Kde25hKzErSbSVlmxCPbsqp+WjTa2d+bxvvgdl7SJtdxdej6LR9sTQxVQ1tHrx3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzUFvYZS9pkC28oOFnT4wNYAB8yev2lLFkeJI1FClxM=;
 b=iRlX6IVAPFtgytlMgXqRNbFrMWF0Wp3WaWNj3up2uCBcNKcW5bDH7ev7HUnlS9wOJN0vmLpbsaE8E01qeNfTvmM4GWbx1K96hukh2EZQ5pl+L0C6zaLW46A4OJEPnrxsQ8fVhZxnZYMn/JUD34jX//gMLE0IHqyBjrUnz0amk0MorI73khdrH+FdqFG4ZK2sbtUipd052JUAOQDoyK6zSML6/rPIqmek3GVvoOhqk6uJH6iFnBv9BixldETlTTC+5lNMxRIybZGFLqkcFJX9zLPAofuQ1goyD3TnvCDli0lCjG8Tbh9vGD/TJKkf/BQHiWZDxiWDG+yavmfug96TIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 02:51:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 02:51:33 +0000
Date: Fri, 6 Feb 2026 10:51:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <luca.boccassi@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<christian@brauner.io>, <oliver.sang@intel.com>
Subject: Re: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on
 another ns
Message-ID: <202602061056.b94e9170-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260127225209.2293342-1-luca.boccassi@gmail.com>
X-ClientProxiedBy: KUZPR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc9421e-04cb-419b-87da-08de652aa2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hDmXdUJhr0YzHjp7K8yvJPxb1NT70HMgP26WeZoXr26TzK06Fv4wd6fTeXkX?=
 =?us-ascii?Q?kP6FQCVtq9mAL2+dR8ZjnQNfZIg9DhNCn9V0ivLEwkeOsHLp3Svg1KCmw3km?=
 =?us-ascii?Q?VxoGn7AKRWjEbTi6Xa5a/bnYh82szdhUq9oFPiH3lLRiq1qYSV593Y6P4huw?=
 =?us-ascii?Q?xazldjTyyWatF5nHxNGWMqewd5wloJngWT3Xi3yh8lXkS2hes+yxhEvtPkSK?=
 =?us-ascii?Q?eaUr8aEkecsAYq0Vk/wGln74pJLoDPgl6cUoCvmiDD2yimJ0CBhNfaAIfRWS?=
 =?us-ascii?Q?c0tCIaODgIShiEXaaD6axslYN+skw6SL16dtBfUDPDa1+NhV2l+eV1QVW1rw?=
 =?us-ascii?Q?CtWZ6lye1xBnBsmXNIq70xQBSaTmLrfwVpUSuESkJOQuuEKAwId+6vCNrrwG?=
 =?us-ascii?Q?pmg/Er/qD3lgkmSBPcLcaZh5pDoqVXLpv1qN4tjphfDKLZYg2WpC0ymoeJL2?=
 =?us-ascii?Q?bUrIk5HLA7xmD339wt5gsGIjEvDrwCPW/jmMXpDseM2XhWUlfPQackwYNGu/?=
 =?us-ascii?Q?q5xujbNninWQtgsH2ZkQPvw0JyAaiE2HkRHqr0hfR6rLS9mXot3Ftn3lhPl7?=
 =?us-ascii?Q?QgfHQJbcfez/Gdg9/D1yn9EKoGDvrwCVWEnvmhfehdmbLeyVNdthPPupFeFC?=
 =?us-ascii?Q?Uw5J1HwkxIm9OPh8CE+mj0tSJLMx+g1e/qpungq+a7JB6Jt5ZETMs9gWTFDZ?=
 =?us-ascii?Q?kdC48p4RIlem9uDXE5aQXFyrlbQK2lE5x1VJsiW4gfQzFrMFXDYtOwfBnt7z?=
 =?us-ascii?Q?zUtlb9jQ5M1CGE3HPSNpSNzItAflcvfYPB1vc0/14R/0+mBGZQ4MIU8SUC2r?=
 =?us-ascii?Q?6G5e8igGFFY6EP36eSsUmH+9MBLWXhz+ARM0JJh8FejtMhtkdqlLLHwPtgzI?=
 =?us-ascii?Q?O4L/TVyvQjn+gF1iroPYEB2AurzOtkwKqQZo3m96MaorEMeLJkQ6KcrGPA9n?=
 =?us-ascii?Q?Y3fL1RVQUWyQaGUE8IAF1yVr1qIrtNZD7iuOdGz0KMazR/y4GyxkThpSHtdw?=
 =?us-ascii?Q?0MmgdMdooKDIcLO0VqzTspFaUYggZ3U2QVTjd4vXnXBUL+pUF7/so/lQj7cp?=
 =?us-ascii?Q?cqCCYOc5r9g4qoY7MGyw+kMU6JFNO9PzJSRPRncCM37nhYRreFJGh435CFHy?=
 =?us-ascii?Q?+yvpu3kx3T1fjke5K/KFnA4Mk6zrd6G/igTB0l5uKfJQHVvLbDQTrMwSxTwG?=
 =?us-ascii?Q?jk6f+HiqAwC60oqlBUWNJfLnoRFqlt3CjxQRMHmMFU92txvDg7nA5fjZJtfI?=
 =?us-ascii?Q?W0uwomH3V7m6AdwDN/uNXui0Wmtv0CWAJ4FTAXv0Gjbgz+zMhbl0JCbkaiqk?=
 =?us-ascii?Q?nCmenc4GStuknzyOMK3pkQoN638XdpTvpjZrFfFMznv93UsqyW3Bii4CbR6E?=
 =?us-ascii?Q?TGjwrYusSpSYDGs5BXOwPphRpvi9LIDPhEhygEAQbhdzBhI5nSnNMGIsaRTg?=
 =?us-ascii?Q?3mC+6UcLdkwCQnMD8oisT5DT240lY/UaHLUWtL4AyMToXMJJfCvKlLrGGUKd?=
 =?us-ascii?Q?q1KSXtAefP/ah9zP3rZ2H6TnrGwc4NyXg5Sh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dutrUNTCMevqN4F/AVK2g33TxPLA+zqKDyoneNMYwnTi5vdy9yfOei7MyScI?=
 =?us-ascii?Q?2bd1tha/MiskfZSMgfAZWRJ6Qz+9LxZqipENwXY6p1irOFs+ZfKNcDFlWjPm?=
 =?us-ascii?Q?jZk/l7GZUtzwBcfMsFGf2ajsIzg3AgjNpokoGMnB76AFOGhRTtk1Ey/V2zTv?=
 =?us-ascii?Q?w7R9LwFTzEop98rjGVy+4+WRPgHeKeBHz/E+o2EmM3way9nOWFGvpWjZZChQ?=
 =?us-ascii?Q?1HEJUcomxjgPKdr/jxVF+tG7ziXXNdVCI85jb5OOcROxlbO8etMxN65e204m?=
 =?us-ascii?Q?T2kceQtarMkQbV3uGWX59KUkxvqXR+weW5LZzfDDC5JmsQvbBAT6RD0P7fnL?=
 =?us-ascii?Q?r00RyMdatUSWO4cPTc0BrF4lL7N40WF6bv0/sWeNUlBvDAPgKHU7jJM5vluc?=
 =?us-ascii?Q?VxB89+8v9TMTdNDzGzRvT9ooRVkefk1aQwJZZAQT67uvDMw7y438Wa2jt6Kk?=
 =?us-ascii?Q?rWVx02f4bGMHmTfta1+5/4CvuYEIVlOkPIcEuHpcsB4kzOr6xPja/7LSWlSr?=
 =?us-ascii?Q?HM7T+rgD5RVwHErffjmW1L9W0qV59E/zPCyAnV10VT8+2TZ0sF0UV5L2zhBZ?=
 =?us-ascii?Q?iqUQo43x3DHsQ80yrO+qQMSF50nrxsK0xnwexr6qkBdOq+ti7k3ADxXNjECb?=
 =?us-ascii?Q?pHhqtE9OIP/ZvERDeBGG6ks7vjiNJwT8qRqqoGSpjS1IlQr4SbZft//Rnj9H?=
 =?us-ascii?Q?mFSGPjrUTkzRVDyvGcY4gg9LRrIPhO851fDSfjPMLFKSzA1OKVWHy8bBmnhD?=
 =?us-ascii?Q?zY52nf2m9TLC4W9R8L6kRiaWWrljnt7o63jKdnzoNJz7VQHS/r5ObFH6CKaR?=
 =?us-ascii?Q?OQY77Xt8FiQ53I3pNM9v9J7y/jfd3qcpo7aQYTEs4kR4Y/wQGITE9ghPaU9r?=
 =?us-ascii?Q?6XJUvByIN3/DIjFdG3M6Qz5YgKHmmdxMb9FCMsPGZgX1Dlt5oy+K9mTwjnvj?=
 =?us-ascii?Q?vhMC/l/ASHdNfwlVYYHWJsyeMzrZ/XWj+pBxjjD2ozVXXO9wcrQS6xh9a6Lh?=
 =?us-ascii?Q?FI3seT/WAF4oDimK8mJlq5ALGLCu9mBa+o4Oxl+8wPDlkMrxgH5MQnORpI2C?=
 =?us-ascii?Q?FSLtx4Fn6iZm0m7OaieCVCFpi94UHnYtGodchHJ4MkTKGfTccgSc6jXcNZTZ?=
 =?us-ascii?Q?z2APEq1EaGl5OCsutZlI4Gzb7CmxDp7eQVWF1v0VGJQY70GHCF+fxy2vZDxJ?=
 =?us-ascii?Q?IPwITS682FtCcG730468iit/dyjeHOzGDc+LCXJ9utxCzmWWOMWF7VmAVkOo?=
 =?us-ascii?Q?/s1Z3meO/Xn+ZnTCuMuRORSYnDQaJHYlR8XBN8bGdztDBE+AmnYDBOKv23T9?=
 =?us-ascii?Q?M2ShJcEp5ctt8WWEkTMyC3lxXuRySHVmfI1ti8HTothkdfbLEKNENGIxP0AT?=
 =?us-ascii?Q?+ZCzbhjtxhds/4TyOpuLWeS0xmURHm9H10pLXjmXG9DdJJ+Bg674xUIlOlRr?=
 =?us-ascii?Q?HTJL2HSCoav8LRmV7TinLLowIZSUyqrqPjhVngtOuhoa+5adehmL961rx5NE?=
 =?us-ascii?Q?3og29WolvxlCDBCfwX4J96iXjEZrB2IXJ+dUUTCNAa/pmlt5ZGfA7BVHj2RI?=
 =?us-ascii?Q?ZVRy6Qmk7VLrMvEfnSZC0ulPKmSKmfGOlHi5soo0iC4Ni0H/66LivYZDlKGo?=
 =?us-ascii?Q?2URmPDaopzfSxEN/3KZMDYyvetQ/hSkcSFbzTZiAgSUTPCaUMWRGJMOi4WuQ?=
 =?us-ascii?Q?FfQO2FUZN6yeIsKi8gPAifupvpBcydBknkemI5+ix5c0WxZtYRmMgqYurk9W?=
 =?us-ascii?Q?7OLJ5PVFIQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc9421e-04cb-419b-87da-08de652aa2c9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 02:51:33.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sH8rHa5nFikJaN7YTwEYP/6nvNOSpx0WZf10TY0gcuEjK6o9K417KfZisPkNyBpE9BQIGGUq7TFLAqbNY1NzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76518-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8C8BFF9750
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "ltp.ioctl_pidfd06.fail" on:

commit: 16cc0cf19e0b75a336cbf619d208e22b351bd430 ("[PATCH] pidfs: return -E=
REMOTE when PIDFD_GET_INFO is called on another ns")
url: https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com=
/pidfs-return-EREMOTE-when-PIDFD_GET_INFO-is-called-on-another-ns/20260128-=
065425
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20260127225209.2293342-1-luca.bocca=
ssi@gmail.com/
patch subject: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called=
 on another ns

in testcase: ltp
version:=20
with following parameters:

	disk: 1SSD
	fs: btrfs
	test: syscalls-00/ioctl_pidfd06



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (=
Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602061056.b94e9170-lkp@intel.co=
m


2026-02-03 16:33:15 kirk -U ltp -f temp_single_test --env TMPDIR=3D/fs/sdb1=
/tmpdir
Host information

	Hostname:   lkp-ivb-d04
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /tmp/kirk.root/tmppqdrj0by

Connecting to SUT: default

Starting suite: temp_single_test
---------------------------------
=1B[1;37mioctl_pidfd06: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m =
 (0.034s)
                                                                           =
                                                    =20
Execution time: 0.100s

	Suite:       temp_single_test
	Total runs:  1
	Runtime:     0.034s
	Passed:      0
	Failed:      1
	Skipped:     0
	Broken:      0
	Warnings:    0
	Kernel:      Linux 6.19.0-rc5-00159-g16cc0cf19e0b #1 SMP PREEMPT_DYNAMIC T=
ue Feb  3 23:56:34 CST 2026
	Machine:     unknown
	Arch:        x86_64
	RAM:         6899592 kB
	Swap:        0 kB
	Distro:      debian 13

Disconnecting from SUT: default
Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260206/202602061056.b94e9170-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


