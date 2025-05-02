Return-Path: <linux-fsdevel+bounces-47891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813AAA69EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 06:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65934C04AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47D1ACEB0;
	Fri,  2 May 2025 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+pCEfNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACA38F91;
	Fri,  2 May 2025 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746161482; cv=fail; b=XcwPekjCNu21lRFUGpSEJ/ysz4RlUxsU4hbBBlxsQbpiV3/QgqI6cRQjVocgu1w/GXLFfMPVpHhX9ANrKtG+xuPbNYC0ajRBc/EHDzrXE9NR7faD0WOWnRzNdxwEMDDYLcKAmUaLn6N75ZCXVuB/fAz43ylubc1kc72YDhUACL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746161482; c=relaxed/simple;
	bh=8oT7nK9Z0rcIAlSyRSiaPloqkBtCABiavJZlExOzlUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uB3BwGMvPpvvVT0r5VIbZEkdRcrHjPBzdTfomL2MwB2i9PIwlhy84lqX++nU7PZop7C7HpmfXaIlQHL77is6xULvv094DBm4wSlIFgBT9xS7L3YgaekfNBRwRu0aRcB6rLvilEZC+7+G2s2ICr0R0lBVFKCfMDJVdWMJB9H0MQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+pCEfNp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746161481; x=1777697481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8oT7nK9Z0rcIAlSyRSiaPloqkBtCABiavJZlExOzlUk=;
  b=G+pCEfNpCGZxm8obRQDR4auBGpFcTxnUpOalbwPv66OG3VfP06yqHceg
   BgqkJ79HJDUImMwPCsvH+Xpt6S5M6QGe37dLGegeFrqyj82XopymHGOsi
   uzJfpRaqwvu5E0LlJa27nwJewiBpMkKFwU5u5He3PtHdFcx12vwX0LX6O
   7wSzjZYzT8LSegOq+Fo5BZ+fNqX1QUS3u1FOUKqerlprJmjBFsWxKi0kI
   RwyBNxw8NogKVd5M7Eqei/+ef6nnS58iQ6qT8nMTMRP7hJ0gMQucwKTin
   +5W6q0YKnV+c9NGViyrpSeQnOREP8h+lSNSWawvc03uZeQO3GZG8NrUwj
   A==;
X-CSE-ConnectionGUID: xy9JOm/sQgaSReGbO4SUYQ==
X-CSE-MsgGUID: FsS7glE4SUWEjma6SuYZog==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58468764"
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="58468764"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 21:51:19 -0700
X-CSE-ConnectionGUID: OecSC39ZRNKU+3zprCLAzw==
X-CSE-MsgGUID: W0x04yBFQn+92LTSRr6cYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,255,1739865600"; 
   d="scan'208";a="138576880"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 21:51:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 21:51:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 21:51:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 21:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEEDKdSJFMFtV/Dk3ldOKYjnfrIc3F4MlBulfcPnAXPApy40Q+rCdGh/l+OooW3N59rhImleo/3qNmwdlQObM9mwBKTJNuDHhUe/abgVET9Y4wt+Yq4jh5z0yjx1yyPpG64qBTLapewlziDVUo43w/j8xHpW4Mm9ml5aw1cGw34mczZYeE0pZTbK09zr5Oo9CFRqTc9fVZIaoErB6JjKlR9pGCpDFgz7OALSge4HtH7mKAKQ9MRSoaxQuQhkT41NVtziFpJZFdUYbOSha7ZGOT+PqNf0cCsROBNtEfY1sLh7PjS1IcBr9YJHVndhxaMRDky+obY+XNv6SwHRg7xZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLUd2R7ud3WNtpnGO+KVRuMpYVPxvUU/noML+cQA4qs=;
 b=iCnewgivuDkeCoTY3StEFL89OutNmfMINwCmfWr2WqJQp8fmzylCFeOsUibNffdQDiQbsSc/Cgofk3jUdNR/eliegxgq2ZblkCNAQ5UodbyqLersloPYT8prdHZ2evW/PMLEx4hyxF7UxPeR3zGYy0ek+iiJY3HNdzwPaks9Xwn9BGMKfmnKVg4bWLaLxAaaqPmZAsbiT2mlB2D6t/zfs1iRpppUs9ozp+D+6JVw0AdAhcKom+Aj5iIgNnpK7CmfyGOWfgfN4RL6Gfyx5Uj29rcYo1GxO2aqjR+kjEUSV49Rwe3jK9nL54ehRN2DPWA7MF0tmJcHwv1zUZan0VNftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 04:50:45 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 04:50:45 +0000
Date: Thu, 1 May 2025 21:52:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Kees Cook <kees@kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Christian Koenig
	<christian.koenig@amd.com>, Somalapuram Amaranath
	<Amaranath.Somalapuram@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
	<matthew.auld@intel.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
Message-ID: <aBRPeLVgG5J5P8SL@lstrano-desk.jf.intel.com>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
 <20250502023447.GV2023217@ZenIV>
 <aBRJcXfBuK29mVP+@lstrano-desk.jf.intel.com>
 <20250502043149.GW2023217@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502043149.GW2023217@ZenIV>
X-ClientProxiedBy: SJ0PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA3PR11MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f446a9-1ff2-4238-acc1-08dd8934e616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?453DdmFUfnW0H84hf2CpdSFVM6lwIpDkr7SUchXzBjusM/+abA2k3H+hV8yy?=
 =?us-ascii?Q?yveA+GaJQS91SQUyGS+Ee0Z2CniaPJT90BcR/U7I0oJ3bEMA+JvjfiHeei9h?=
 =?us-ascii?Q?RT6vVw7QJ1eUID0y4uwAchzV8jTRoxthYAu7fAFEK5zzbbHBqpmy5sNGhEru?=
 =?us-ascii?Q?1V/W0RfQyEe/fZxL2A1mZ8f4XO1ZMt57AuHMAYkqmmtSgwbfN6S7qCuB9eY2?=
 =?us-ascii?Q?C1/U26ZidrydAtcc2hh2IJK3qOH1JONslT+gU+4xmasHxfe0Te4sF7ycpeAF?=
 =?us-ascii?Q?iiwb1iEGaGqFFRwEWduV/d7k/tZgSqk5hguznovIoazAiNuCYncnSk7eOujC?=
 =?us-ascii?Q?swBOTEAB2QTJuuI4zNu+JDzInoNiy/POOcvzCHTF1tftGj7rpE2TorJffA4k?=
 =?us-ascii?Q?Ojjle9a+sQJDSe+6SjtqsGhjJSLtvrrImplSB/6vf5r8Nz0o/KW4r5P+RgBB?=
 =?us-ascii?Q?3wJeaxpjMNa/KucDWyHl+W3zEaA7kj5oXZlr6aJHibcXK0HrbLFPxB2Vq3Xn?=
 =?us-ascii?Q?ldoaY6dBYDdI3lwKsBLWhNtWeXL6rJOCkT9sjEF0T6+W1lF4Vyy0mqnbztcB?=
 =?us-ascii?Q?RviOMToO5FE/9KaUSsy06GzbFNXS0gYFjBRBK8o95qIF2+kLuedFNa3lolgx?=
 =?us-ascii?Q?Dnphk73QsWUoSkqN14aDv7Ntwmrwr86nL6RKUcUDowR9WNKdWAEvEgr4uzEw?=
 =?us-ascii?Q?XoBaBLnV0AeevodkxU/ZJ17B982G1/sOXjzUJRN3y/SM222NL1Ppt/bgXpqG?=
 =?us-ascii?Q?rsqttJw3Ik4jJ7XiZ0s2xjeJdJQh3kDD6sZSNdSl9eK33hkmGGIitiwLjndT?=
 =?us-ascii?Q?+4WfW+hqKU/hOD/f8EnxNAFJz6BiCbDQbuZmlpk+IcMDNHcfYrctZrI0U1eh?=
 =?us-ascii?Q?bKm3lyj05/Pr6NJu/H59SlkmspLDmvGrLv2AfRHwj8kqzivopysIC727PNfL?=
 =?us-ascii?Q?tTtO5S82aQ/iwQ1D9AIAeBiwNi/PWkmvHPWmrVayF+l+pgKOm/Dx+k+nMnak?=
 =?us-ascii?Q?GbtQOy0HhHA4UIWNCsdf7hfO8GiD2VY8oQO9fHHhxvgFN8KPBrXAk21tUOrZ?=
 =?us-ascii?Q?z32Wc5TqdEFkZGr1HAn+EOEN20yEhPgB1W8qPNRwjLX3JbNki7kvVRQFKTji?=
 =?us-ascii?Q?R8DF+rYL9limIu3b1HmTt3yogqHzw+3fV9f/g/AqvzwO+pX4+I504CcPbRH7?=
 =?us-ascii?Q?Bmi5v+L9POSOETYSPZNhtUNTgVKCbEPNiT1F/K61AmwvlnTsk1dFhrmswQA1?=
 =?us-ascii?Q?G++FS5hZXN1QzLrRc6BgpcK0iLFDHnHOGHlE8yWIxcrpl503lOkVMZm6w4g+?=
 =?us-ascii?Q?4TYUe7swhgKwZZRRO+19PkAoEUppePQRYH0FG0JnEdVfqgQVLzt6emE9/Or+?=
 =?us-ascii?Q?h8GXLi78b8cDFH2HISxeXZ3CTPHD6wUxT2EFWL3g141wuLFngAogmisA8Py2?=
 =?us-ascii?Q?PabguzcIgJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cknkxcd9BKi5s/jJTKVAY2+Cu0lTdzqaaZbOWwHqPUmbBfahrIJ6ow6QPa5G?=
 =?us-ascii?Q?1ADBnrmUttUCKzPLOUdWx50D6lEsaGObtY12fFbBKf4qkHD9jCODV7rmZnOY?=
 =?us-ascii?Q?f6ETFiTPvBmEOdUz7Ql7PVGsC/hTCSgqRFUXpnHP1MJstO2HqMoaictR9ry3?=
 =?us-ascii?Q?QFFDpyKdtfGM3gxK22lzk+KzyU2mVR6Ra3yR8mem9OjRd87w5HhXl1eDJL9c?=
 =?us-ascii?Q?N4k4bpeuZ6ehOqZBZx621CuCadVp/EH6EXOd3eIT5F+4alXLRVHPsdI3+r4G?=
 =?us-ascii?Q?OhhJpaybqfPQ2hMvHUgvA5OAjnPfsgfm9Vr7sQsNAP1hkg+bwtzn7oTvGr6s?=
 =?us-ascii?Q?z0N+U1YGiia7ccaX+I1cBMM4GYOyiMJFCr5jeqP/dNUZrwkim7CDpWU7CDIF?=
 =?us-ascii?Q?bDoo/MVxdLLLjiffvBxl26cZOcTkprEtbsn/VyW7Whzg8TeY2YrfJoH22seb?=
 =?us-ascii?Q?tT0MpjHC3P3Rf5FU71M6seitQjU1oCiVeeVTHwj3KrufERl8Ymc55zlk/drP?=
 =?us-ascii?Q?KybxsOP5f9oObuJOWXKD2K6UcbZzH4y+6cFoJcD+Jl0vvYanvpeWLBRy2Mjl?=
 =?us-ascii?Q?YYnhC3JcSl9Ut6F/bzkaGfXiHbCAxRl+fLEjSAIBkN61aqbVr41ykfwX3VtO?=
 =?us-ascii?Q?oFor+1M25pLwyPiqN3bTBlJjnU7CQ12WZJX987hnVyDq2dXUTXh6wkhxJJcK?=
 =?us-ascii?Q?mX4WKjjZXSQHbNIA0YfiD2hi+SGdjoHhji/i4ct1txrYBIXjbdm7+4z2pZSx?=
 =?us-ascii?Q?wtXsinPRPcfQjLSzyKQccrvC+Tn3grTFejgqFw7YhoZeo9oq+QAoF2kCoUD1?=
 =?us-ascii?Q?jzcJ0FOSd3X0E28eSzVqpmdiVSpMxTIUoYNa9toZk1dre5q9CoTh9N8JwcYX?=
 =?us-ascii?Q?J9FK3/WJk21suJR8zIqdyvfXVnlah0GLJoWXD9jimoySeneOGEh0fot7Cjg+?=
 =?us-ascii?Q?h2WkWu0HuoJcr6fBbMMbniqjlfRbhpZ7/GZSTFrCHFYCUb+eq7cRmWHQ5cZF?=
 =?us-ascii?Q?B0zxMV3gHMfcEllXNkbHj1yt2QR2N4Sljg5wZZzqa5ns5qfsh/qy3/nKoEGW?=
 =?us-ascii?Q?S2ePLEUeJKYad8CEwP7mfSojZYWSAise+6VsQjp+3a236qRBXvdNdKnNiBUX?=
 =?us-ascii?Q?VGDhR3Cs/tNpPEGKGB+y7cyTpqBLFHFnTiPTGlOsu18GdS6NVrIT7SOZIxz0?=
 =?us-ascii?Q?t499cKsRpZlBsxPYCTH3BKOZ9A0x8/dZHvW0icj5vZ3C73dY7lVwtkf2bRse?=
 =?us-ascii?Q?axZp/BC7xUsUwfVnkYNKDqO2AX0hSkevPAma0tncGlTT6D4sONJTd8IKYizj?=
 =?us-ascii?Q?2bQCpIYco42bJp8Xde2LFIPgY+kuEjEO1D2sDFcUbn3M2p0s0dJDDjNaIYp/?=
 =?us-ascii?Q?fc/Cw3/vINy/Km/k19+ywDc8m6jM+c2HqQPfj4WU/f+C3T8xPz1qH6rWgrGy?=
 =?us-ascii?Q?HDowc5N6hSyq/95PB6XN9C378+KZgt0vcVXHm0AbhiDDZxhoA2DlTcLZqOoP?=
 =?us-ascii?Q?0RlNlI+o1dxUhKNanqemer1Mc53Ze1iRYvnQMGtgVCdgoyI7q8TfMga6/693?=
 =?us-ascii?Q?8af61gzxeL3McndX3thlbsJrFyDypWCHIr04ibCIo38CbP0/UIGMGCeq5BY3?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f446a9-1ff2-4238-acc1-08dd8934e616
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 04:50:44.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qY3iy6vV3gbAUqU/b69RAOqtFf8if+lyNxap1+XntTH33q1dTsUHsOMymzhqWKtYIkC35fF148p96S/wl1DMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com

On Fri, May 02, 2025 at 05:31:49AM +0100, Al Viro wrote:
> On Thu, May 01, 2025 at 09:26:25PM -0700, Matthew Brost wrote:
> 
> > I;m fairly certain is just aliasing... but I do understand a file cannot
> > be embedded. Would comment help here indicating no other fields should
> > be added to ttm_backup without struct file be converted to pointer or
> > that just to risky?
> 
> What exactly are you trying to do there?  IOW, is that always supposed to
> be a struct file, or something dependent upon something in struct ttm_tt
> instance, or...?

Create an opaque ttm_backup object for the rest of TTM / drivers to view
- it could change if the backup implementation changed.

> 
> And what is the lifecycle of that thing?  E.g. what is guaranteed about
> ttm_backup_fini() vs. functions accessing the damn thing?  Are they
> serialized on something/tied to lifecycle stages of struct ttm_tt?

I believe the life cycle is when ttm_tt is destroyed or api allows
overriding the old backup with a new one (currently unused).

Matt

