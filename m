Return-Path: <linux-fsdevel+bounces-54321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EEAFDCD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 03:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E4C584308
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 01:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2F15E5C2;
	Wed,  9 Jul 2025 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPS55lTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39329148838;
	Wed,  9 Jul 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023730; cv=fail; b=hzq4s+hKhJ/l578STIUhX9z+oY+0FroAdnSTcONZWWiR/nQCehEG2x3sIcMTqG8MguEVPZ0iqReV4IVeOfMANnjyRKGZ/JQP3AeNxVGK9teAb/8wyMiANz6/FDrhpF680XL4lT9X8z4GLqqlNzWvDSKKANNRsxvqac0jp8E8vbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023730; c=relaxed/simple;
	bh=P8S4gAQ36lvejzfr8FDH12A1WTF/ysCzFkq5qANvxSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iBtIA3x2TxGJQF9ksNpLZ1iYlxWGbQd+efkTDxBRRPRoreti60CAAglEpMuY9oDyZtYsXOzoBj3fPLKMf31nPFVmx8SZ68UXKJdasmWSDLIcFfNH24yXQDuG/heHKEtn4vf66WLBGBHDLQzhhX3vp1qVyaEiyLwN9eZowTV1GG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPS55lTm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752023728; x=1783559728;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P8S4gAQ36lvejzfr8FDH12A1WTF/ysCzFkq5qANvxSU=;
  b=UPS55lTm6Eh9eJEc/hMe/knHE8VIYuoNZx7a1guVO2uEztaQaL0Q6bJH
   8f08ed3/Pc8xk/YJw+0sTWYCr1p1O5pm7Pm1cWn2wCYmDMJ8qLDf/19hl
   uWvZzjiW6oq4UxUIBTdox3QmjgXhNc3Eidhaxvf2QCmrcn3aNoUtLYax3
   ijdaMBSqlRadtb3pFJU6CQBIof3TPoSqebkwVgGnh+5q0SkzeQ9I1WgU9
   qplhKW6lFIn3A2KjOaSulJh0io9ewNGHUvf2ndbyfjr8aUCpWFxHafah3
   1jJa7cTI+JKlL1OBZY9aoB3vWucm+bZjODbPrxW2NPYQZMNhEUebImGI3
   Q==;
X-CSE-ConnectionGUID: lx/z7qVoTvqZDDQQ+3iwEw==
X-CSE-MsgGUID: 24qnu9ApSlW2NiTD2bAdOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53385710"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53385710"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:15:10 -0700
X-CSE-ConnectionGUID: ZrMwoaDITfaEZ8giAULWYQ==
X-CSE-MsgGUID: y1EeZEUXRNepZVmeuhl5mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155966521"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 18:15:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:15:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 18:15:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 18:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn01pxD7Bh4QpeXJtQlK6RD4+gWoDwXTklgq1fGZMDe2M8x2O+SOR4DTLZZouyDa7x5WlQPJOlPxF/1f5XFv2nkQ1sVyTW705bAt2WQ45Y51tvbimU49tssbxSNM14dLAfvjiFRxZDzBIpE7nICgpjFV8vJhsFW0MEo5g2HoeWgFoocm45jCcfOym97Pw6JGUdCfz4i17bP8dx8Q6HamAurpLe3zQ7Jl3OZO3WcBkaqpal2PBD7wMwA8E70dSQ2GIjlohjrQ0AShp1GCO1rD0Qixdg3CBdkUPeRduYIK7/0rZhJHba2z/lYKjbKMmJqIrihcrmFtjZrG/V2UqqZQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+tM+g+cC3ombZ5gda3JRegHnCTgX7cpVNrlSGGdPco=;
 b=GhCtRpg+kDryyt/lFyfBr/lbAx/gjbRMdu+pcrjeTxnsIGrz1EyZmEAXafdimaYwty2ASXrY8bZDATySTQc/4JbDTy9r1q/jM2MH7e2ZRUUdaQhyzwm8aUo+MUvHqQIsVFvehoLvg4J3vF5SEfxL53EapXETb1oKKiRWBiE+/LR5BuJVPnrNL8rqR2MV7UVd3HLWVIwerTknWaFgMhVSZKw5nIVxzujcpUbuY0zOrdLOKuMy3Asog9PeuEprLBicT+an4aeRRQOdpm/cK0kHcbmENfIc/xrA42MPMolFcJwx6eVVPLyD8xJMz828xdBeD+2jwzqaG6E6VNI5YChr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 01:15:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 9 Jul 2025
 01:15:00 +0000
Date: Tue, 8 Jul 2025 18:14:51 -0700
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
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
Message-ID: <aG3Ci5tcVMTBpF3R@aschofie-mobl2.lan>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0915ce02-37d4-4c9f-881c-08ddbe860689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+O3AtkUnNgPmIsYOUbdMDDZZnU4Zud7WFzLi5ivoIvucOBwzs7K///qybxQu?=
 =?us-ascii?Q?cLnEGD+8Ye9ACLJG+YHgfB+O/bDJEh8boyuUqdazaoOjZgwwLmWloHNsXnwA?=
 =?us-ascii?Q?MkYfrWp7o/G8dt7D7l+nsz85uKPGE50gekZ9ExsbP+K0XklbvzbYrN6o9hpw?=
 =?us-ascii?Q?eUaljS+hoEVsM/Oljd/46dcP5h7J7ikMGnh+LXm93sQE5tadI1WQ0rpD2bqo?=
 =?us-ascii?Q?3a+60KoywG4EPzG351nNTKihIpLEMRHHBiJ6rpOCsOplpEdQHDAnSSve7XKt?=
 =?us-ascii?Q?iJPneHC3s0dcmrTF3lvHGajh9Ba2jbs9JuJwi9+tkXiDJN6Sk10JKwozRqKa?=
 =?us-ascii?Q?2XbkXxLbaq5MqM08LYlGgMrsUEmCEYo5V1ZzL5WMSQAoSMSxjAab6Sema3/A?=
 =?us-ascii?Q?hDKhGtel/s4nhpTmrPtOFiNWtf3j/w9qQnAKV9Nv9SPiAAs4aRM+cN50d+Ik?=
 =?us-ascii?Q?+HX2yVKseI81wLJSK4enHWc6/0io9+C+iFKC4Ds4Cgva/wz0s0MuMuDAFtoj?=
 =?us-ascii?Q?PORMVPppgKbL0IJ6f0bMpezI0NVdZ/tag+IhxQXFWeIvsOiz0Obc98qAud2/?=
 =?us-ascii?Q?SulBBrCGocKyXRJ6BP+kz5lCJGYHqaRNENugMnSPk7SymLIRijhIzn4Hg2Ti?=
 =?us-ascii?Q?BDy5IuC7eZU9w0sm6nW9vL3sJDUdYv1hExk1nL13VCXMHH1HO9HnNw4fisFm?=
 =?us-ascii?Q?wn3g/D5LWHkztMtHq5gTvng9pBa3Oz/3RrjuYt7MnSYyYCNH0r77TshAnqSy?=
 =?us-ascii?Q?LHjELx4Jf0bpELjT1b9yPP7Wt2Si+jaTXiAVbFWL6tS4pyAGFxWkR3eYXDaX?=
 =?us-ascii?Q?ZA94scBZa00IU/7EfqdzJ1CeL2cFjEVoit3nrQYbRH5ZWrhWAS6j4Wt33VHB?=
 =?us-ascii?Q?bFRWGL6owCJBsHy89mhg8Fgj41EPP4FCc559bDe+gmQqWbH3Zjs9bhDVtak2?=
 =?us-ascii?Q?y8UJI9us0g0J+LPCxtlK9/DphulEKSSBxpniUCr4QhDW7iWEGE2YryJfCiee?=
 =?us-ascii?Q?iISIpv52wVluLKaLg9EzNjC7WJoQbuRhKHkmrz5o4y7c2h73ITXlRjvyB5nu?=
 =?us-ascii?Q?Av/cSqUrDump7aAHY3D6kFptsGf9Z8HJqJsakz5MMnkjfod3kgQMFvd4qsqb?=
 =?us-ascii?Q?t8p+Od2fJ+cSG7ZNrBQymOgcC5cPB18i3ryxKSNlJ3tQ/YWAus7z2skyL8Uw?=
 =?us-ascii?Q?38RYJV1IFp6dfZL0NhuVNsbiGostmSoeZnFVPhNCQF5aEScqWIP2vyE+mV2m?=
 =?us-ascii?Q?AkTfChgT2ILClKzoWyuy7onJz6eItNYB0cIJLGpX01g26RC7TfdZxPmRiVeT?=
 =?us-ascii?Q?IElU8Qf/uTqzDNuPBo8ugoriy3hC54lCYY9TwgvSLsNdsal+OqOMEPQYrNaA?=
 =?us-ascii?Q?C/2djjEcL32F5MTpQJN4o3jx36/LXV+6gftimYTEjROw6AMMgKsBl3zfj9xw?=
 =?us-ascii?Q?NsjaA2kO3nU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WkSNMnuB91I/S2tOu89enOybrucP9OmUtpsJ6LAZIKVB87i4hmaMVasJFzLE?=
 =?us-ascii?Q?O4Vr2wEJQGdpQWH+ZwJrUahwcDqxiLGLeNeBuMqLJ8n54k0vlF1y/c5+s78p?=
 =?us-ascii?Q?3AENSGqjmvIPfr8oW620OvBb7boaB9cuam8sBcXrICyyNBIWpXSHmEB3OXwL?=
 =?us-ascii?Q?gy+e9IrrVPKlQj3r7YYy36wTAOjmM6xxY4ZSAIkeTjgVegxTR92k772m+z7V?=
 =?us-ascii?Q?wgjAtIamugI3wtYkoyjjEkPI5doLC9OFujXIM/46DczSUnPhr38/Ggjy2AE6?=
 =?us-ascii?Q?U0fTs4wVZOCx4WmWY9pxGogw19+wPdd8UoJKsTBi0mOB42734INTT4AgNqna?=
 =?us-ascii?Q?qtUluLWH0hxxcfp2jjN9t9h/g7fBGR2FHxklhCkjKDCzFBhsRGttuLsTrBg6?=
 =?us-ascii?Q?3Fcpdzr0wBsVWLDOC5llw0sz3LTPELiPMyPB+AJX+ckW1saKs7Qzop+iEqMo?=
 =?us-ascii?Q?8xMbUf69TNFN+ejuIpjsuCnrri+pTDHE1yBdRfbxV5+I5HyX76684atlFZaj?=
 =?us-ascii?Q?QkhEn5sVDb85Wnw5bFF5B+DE/+oZ2ZzZbsqx/j2eU8W3IcTAQcan6whvFKk+?=
 =?us-ascii?Q?pb3W4Lhsslc7hOYRJijbknwBiETHc4CGjdNi5VgJvJ2NNBekjPPo565Yk0G9?=
 =?us-ascii?Q?eLcWNcabqVE0kr4goMRVIxXst/vH0Fp021+gxCmwDjQyaoHNhFdPa1kEVhpg?=
 =?us-ascii?Q?XsIhksajx6Wsq1klFm1p1euVTFn/5mkm9n0jquB4E7vjGtadQdJiEEi2+0fg?=
 =?us-ascii?Q?iE2l3LSks02hCTif4pUkAlhsMYirNgStnrFt9vWsUTwqblqzE8ilbdDXTlQ6?=
 =?us-ascii?Q?w1/ZJR1Va+i/+aMiU3u3wXS8SXgPUR+9/IMmHEUX7ek+sn7+H162/j8bMiqL?=
 =?us-ascii?Q?9fRikIJKnemlloqS7z7R3ycUsBLJfb3GMRRbWPvEmecYcGNBZMwerPepDZG2?=
 =?us-ascii?Q?NBPjUxiUp1Uwpyf4wcE2098TaiRHRcqtqbOV/OmkOJ6C5GHGVopv5pI3w0PT?=
 =?us-ascii?Q?uYTlwHVMEzWFbGe1yMnDZUh6/Dzc+CkUisIvaPKM3RAAe4v4GObARDfRCYkn?=
 =?us-ascii?Q?6Ik6h48qmYXmqBEZOjjjVdlr4iQXIWUSwPQtQnlrpGoF54x7NT0XKEi8ufCz?=
 =?us-ascii?Q?7UZUbeOWHoC1D8lhER/QOZWo1N1H0jtF5EB62OvS+bmtYxlBlPqRn3joAiX2?=
 =?us-ascii?Q?6zWC9lnmaRaP5/rF6vJYnHhgfbqtjbap/9MmjPXsIMGn061Z6l0ZK2yiF0JF?=
 =?us-ascii?Q?YPlDYBjhMzpuZ1NjLDRRPWm74THkefxODap6CaEBaAlquXRtqR6rX76DWbSd?=
 =?us-ascii?Q?U/Tuo2AVzi/77tVocevixwlt/lvuh32f0gkGB3D+K6eT4wBHVWr9JUcxbo32?=
 =?us-ascii?Q?tpXilpUWrJ+e30Ru9l+d84BfQPkdR6v/kyeIHFDMsA3tf9NY1czLevsxwgY0?=
 =?us-ascii?Q?T0rY5EkAxG6GdQz+y7LpZGFT8cmzXPyP1YV60WRq9HXN+qdp1TvPLOCg3A8o?=
 =?us-ascii?Q?RD5GwN77SCY9BLPNdbGIaZxP268iwJ7u4TTigLKml+Z9JSeSDyGSOw6/NbYV?=
 =?us-ascii?Q?Ug9wBSV2eaQbxINnhtSsz8kcb+AtQ43ho691Rn47BZcmPb7EcKhKIDX7L2Rf?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0915ce02-37d4-4c9f-881c-08ddbe860689
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:15:00.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l87Mxy0xzKtDQwqnhc0LA06wol31MUPBNwVwjL8ceFU3C5VtqtayXjPVklQtBlnLAtGpjheTShe165fKnJrcYRCyTY55c5NgMYvn8PhASpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com

On Tue, Jun 03, 2025 at 10:19:47PM +0000, Smita Koralahalli wrote:
> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

This isn't really "Introducing" is it? Looks like it adds the new softreserved
helpers and then adds the caller to the notifier function. And, that notifier
function triggers after probe, not on region teardown. It's setting us up for
a clean teardown for sure!

So let's rename something like:
Remove a region SOFT RESERVED resource after probe

I'm chasing a problem with v4, that wasn't present in v2. (I skipped v3)
The notifier is working and I see the SOFT RESERVED gone after probe, but
the dax device below the region is still present after region teardown.
I'll get more details, but thought I'd throw it out in case anyone has
seen similar.

-- Alison

> 
> Previously, when CXL regions were created through autodiscovery and their
> resources overlapped with SOFT RESERVED ranges, the soft reserved resource
> remained in place after region teardown. This left the HPA range
> unavailable for reuse even after the region was destroyed.
> 
> Enhance the logic to reliably remove SOFT RESERVED resources associated
> with a region, regardless of alignment or hierarchy in the iomem tree.
> 
> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/acpi.c        |   2 +
>  drivers/cxl/core/region.c | 151 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   5 ++
>  3 files changed, 158 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 978f63b32b41..1b1388feb36d 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -823,6 +823,8 @@ static void cxl_softreserv_mem_work_fn(struct work_struct *work)
>  	 * and cxl_mem drivers are loaded.
>  	 */
>  	wait_for_device_probe();
> +
> +	cxl_region_softreserv_update();
>  }
>  static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 109b8a98c4c7..3a5ca44d65f3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3443,6 +3443,157 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>  
> +static int add_soft_reserved(resource_size_t start, resource_size_t len,
> +			     unsigned long flags)
> +{
> +	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
> +	int rc;
> +
> +	if (!res)
> +		return -ENOMEM;
> +
> +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
> +
> +	res->desc = IORES_DESC_SOFT_RESERVED;
> +	res->flags = flags;
> +	rc = insert_resource(&iomem_resource, res);
> +	if (rc) {
> +		kfree(res);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
> +				 resource_size_t start, resource_size_t end)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	resource_size_t new_start, new_end;
> +	int rc;
> +
> +	/* Prevent new usage while removing or adjusting the resource */
> +	guard(mutex)(&cxlrd->range_lock);
> +
> +	/* Aligns at both resource start and end */
> +	if (soft->start == start && soft->end == end)
> +		goto remove;
> +
> +	/* Aligns at either resource start or end */
> +	if (soft->start == start || soft->end == end) {
> +		if (soft->start == start) {
> +			new_start = end + 1;
> +			new_end = soft->end;
> +		} else {
> +			new_start = soft->start;
> +			new_end = start - 1;
> +		}
> +
> +		rc = add_soft_reserved(new_start, new_end - new_start + 1,
> +				       soft->flags);
> +		if (rc)
> +			dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
> +				 &new_start);
> +
> +		/* Remove the original Soft Reserved resource */
> +		goto remove;
> +	}
> +
> +	/*
> +	 * No alignment. Attempt a 3-way split that removes the part of
> +	 * the resource the region occupied, and then creates new soft
> +	 * reserved resources for the leading and trailing addr space.
> +	 */
> +	new_start = soft->start;
> +	new_end = soft->end;
> +
> +	rc = add_soft_reserved(new_start, start - new_start, soft->flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa\n",
> +			 &new_start);
> +
> +	rc = add_soft_reserved(end + 1, new_end - end, soft->flags);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot add new soft reserved resource at %pa + 1\n",
> +			 &end);
> +
> +remove:
> +	rc = remove_resource(soft);
> +	if (rc)
> +		dev_warn(&cxlr->dev, "cannot remove soft reserved resource %pr\n",
> +			 soft);
> +}
> +
> +/*
> + * normalize_resource
> + *
> + * The walk_iomem_res_desc() returns a copy of a resource, not a reference
> + * to the actual resource in the iomem_resource tree. As a result,
> + * __release_resource() which relies on pointer equality will fail.
> + *
> + * This helper walks the children of the resource's parent to find and
> + * return the original resource pointer that matches the given resource's
> + * start and end addresses.
> + *
> + * Return: Pointer to the matching original resource in iomem_resource, or
> + *         NULL if not found or invalid input.
> + */
> +static struct resource *normalize_resource(struct resource *res)
> +{
> +	if (!res || !res->parent)
> +		return NULL;
> +
> +	for (struct resource *res_iter = res->parent->child;
> +	     res_iter != NULL; res_iter = res_iter->sibling) {
> +		if ((res_iter->start == res->start) &&
> +		    (res_iter->end == res->end))
> +			return res_iter;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int __cxl_region_softreserv_update(struct resource *soft,
> +					  void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct resource *res = cxlr->params.res;
> +
> +	/* Skip non-intersecting soft-reserved regions */
> +	if (soft->end < res->start || soft->start > res->end)
> +		return 0;
> +
> +	soft = normalize_resource(soft);
> +	if (!soft)
> +		return -EINVAL;
> +
> +	remove_soft_reserved(cxlr, soft, res->start, res->end);
> +
> +	return 0;
> +}
> +
> +int cxl_region_softreserv_update(void)
> +{
> +	struct device *dev = NULL;
> +
> +	while ((dev = bus_find_next_device(&cxl_bus_type, dev))) {
> +		struct device *put_dev __free(put_device) = dev;
> +		struct cxl_region *cxlr;
> +
> +		if (!is_cxl_region(dev))
> +			continue;
> +
> +		cxlr = to_cxl_region(dev);
> +
> +		walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> +				    IORESOURCE_MEM, 0, -1, cxlr,
> +				    __cxl_region_softreserv_update);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_region_softreserv_update, "CXL");
> +
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  {
>  	struct cxl_region_ref *iter;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1ba7d39c2991..fc39c4b24745 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -859,6 +859,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_port *root,
>  		      struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
> +int cxl_region_softreserv_update(void);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
> @@ -878,6 +879,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  {
>  	return NULL;
>  }
> +static inline int cxl_region_softreserv_update(void)
> +{
> +	return 0;
> +}
>  static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>  					       u64 spa)
>  {
> -- 
> 2.17.1
> 

