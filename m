Return-Path: <linux-fsdevel+bounces-75644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJK4NxAceWmPvQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:12:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FA9A40B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38743039C90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462032E6BF;
	Tue, 27 Jan 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wdh2/jKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D123D2A3;
	Tue, 27 Jan 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544706; cv=fail; b=QHvooYjHZLaqgnPHKu95vz6XDP1HUJdri89gS8L3fQaFIFDjBtxo4kfZCTOiDJ8fsUaAaYY3P8H30pTRgczTNf6tppPuwGjL9enX1FAspf6/adRJ3RVQnl8YQ7pAdiKpIIgARW/tOzAMKTqVvjmJr53iUfeUEew/sv7HM24Jk4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544706; c=relaxed/simple;
	bh=jVXGST8geEdXJSb7UHoTY42zaPcs5BHlcvHzju0peLg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HkCeolFbfVZ1j8/UUSR/wbUJAv+ZK6lOjGCEGB68BJ4z1zR20XyKX8sjBSfMWk5/EtmWHsx/OLp8kVBpQeQLxL7nnKUfDJfE/9kX9MoDSBFxxJg0exPTvPxlOGDXpnTnoR744Dmu5p6ZsVszD/CthVX3d3+ATjGjMif4zDMqrTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wdh2/jKk; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769544704; x=1801080704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jVXGST8geEdXJSb7UHoTY42zaPcs5BHlcvHzju0peLg=;
  b=Wdh2/jKkIxJf2Wi0nORHoidbvgXMgIZ42TCCcEtNmtmtQLyFLIxk1t5s
   jG4gGKgSBPN3UJMf1dLbX0rPRDWeO/kBTPeR78IDJOEpwYUNyQALifq+B
   T6+yfeOq+5XA8CuB0QUW+Ee9cEqP8ki1U5DiC92SnVuzlyVx7txFOkxSS
   6hdJyq3OBKeXFKztXirk8e05Gqx46KF3rMVnJ8NzdGBN3iNTZGvV9wzw9
   Cgjot4MzrG/9CNOoktVfmwqwNHUJLZo/7Gv8orLCHgA3LAjtdor48xPTb
   yglB84BUYUeljIgYsQWGQSj+RqojsqPxpMYQgsMxegkk+qSc+kMQb2cE6
   A==;
X-CSE-ConnectionGUID: kp7K5MLZQEmJFNkTAe/B7Q==
X-CSE-MsgGUID: i3HRNinKTRWZsvtTdh8bLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69950741"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69950741"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:11:43 -0800
X-CSE-ConnectionGUID: wS4U9vEnQBmT2YSLrC48+w==
X-CSE-MsgGUID: bdw/ImMnQHCW4gksvj2ILA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="207311220"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 12:11:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 12:11:41 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 27 Jan 2026 12:11:41 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 27 Jan 2026 12:11:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0IoEErzmWnTH8V0iiAAXZbCuxPtARxhReFVq/e/ETFMTt4haqG5xRynFaU8fXLqNiHWNIox/zBm2MuvEQVbJ54+8Lbj7zyll7nHiNqgmvPzrxO19+c5fkXZGee8/jmBZ0VqGTmn2oWS/7k9N7XZJKh6X2lpmOIMrKrOZeU0bJcZfm+GuwLPRzdgbuNLAVFszzIoK4Kg/pD2dUQWzUiJvodiYwQFaQk89qyjYUO1Ru23rHwk/CXtT94If7BJc7L2yWnOrJggR0e/c20loubmeLrOWHkHtWAfGZRL6elFZLAYqbo0FQFqzuTtDXkPJjbYFOdKfNPciMkkUKPfCaa/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzrbnca8Nw2Csx9quIq2MzYsoD1++KKxaFY9d1KQ094=;
 b=NaoubTyCtOhD8vIY2yG2CQNMQFNdT23825LZkviPROwYARqtP3jzvv/sgN+YBxFijs6Yz6HUhXiaqeOA3RPoMPjDyHTSJl0NYWt2ljT5lsbepsP6OI8cTTeorFr/fDTHmZKUfHehNXUy22qw4kX6tblZognCfioIMNz55jjz4PXPopbZUuE2Fy2VigNxMT22TeqznwXRbQGVQVNQxMG3qoHPxJeejd66dWUoVG3lbDGKYWX+pV38xahYe9/zBMG/RMzGC3NHR+qsKgac2g2g4AhxUsHSe8MW/FGa61/Ly2EY3Ek+DIFbFr5y0+kLe/n6ynUh3yDkuttDdHD9wngUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 20:11:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 20:11:38 +0000
Date: Tue, 27 Jan 2026 12:11:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of
 Soft Reserved memory ranges
Message-ID: <aXkb9BwPDfMeOCe1@aschofie-mobl2.lan>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 97508ce2-81bf-4557-ea8f-08de5de04785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8IyGVWUUYrM1zKa/Yo2fL9JJMSQOfztzPhIdJWPJMYzJqRiIPNySXvpqWxkn?=
 =?us-ascii?Q?mN8Zs35y5l8TpzFrmqdm2SczsqEQyICZ4UIEysB5ihoHtHEELmedI5pXD0ES?=
 =?us-ascii?Q?77N/mpcsHtdvzQIP72sLldterFYJTlamBGjOYJjU+LnHsUZRdFVrAEZhlpxX?=
 =?us-ascii?Q?lH/eFKq2BkkalGP3Br8zT9ahX3gUZmGZH8AK29Iowe1SlO7VM1YEgt0ShLT7?=
 =?us-ascii?Q?I851AeljaTvqpm2OIlJ3K2oRk4q0w2g0MNwzaNkKHMPOSuWFlKHvoetydl2B?=
 =?us-ascii?Q?OJCVQI4mACRoheCxA/saUnCKD3Jk8vYI0mljNXhketiiNgL7EEuqxY2zMHEt?=
 =?us-ascii?Q?l1lDjHU+ffuJBv8PVFPHNI6nMXSPUsqBKZ2VGK7PlhuhsWKCDc44ekb19Gv5?=
 =?us-ascii?Q?1Nf8ijeglDH0IQob6GuM45fEqjes4UpT5KtejDgdE/tDjna42qEqGEVLXXdu?=
 =?us-ascii?Q?FwGQIYgzBcm4K1l1+EkrzOMWuV0MJjrolQNy1HnWamhDs9LfFUZm2w6JAVzP?=
 =?us-ascii?Q?8wcWEv7uw0QCwPzIDMdB3V6BK0hbLf456sgAD2R5j/WtL8xx3tcbHGSqbgSN?=
 =?us-ascii?Q?fn3299RPDbkOi47wqRDTNazWcCvW5z1vFbQLHTujKEbG4kY3h0Rp9sRK31mq?=
 =?us-ascii?Q?wcv/9g7HTfUAFjen1mhNLVOEh2NdvqkgBaELv/OIFsSHjQNvzpAPMciEFIHL?=
 =?us-ascii?Q?Ehqu4y9aPZglH/NfQARrplOFeIfomBIeek5S1wdcBrZxUTkXHbpe9PU73Kv9?=
 =?us-ascii?Q?9yRUz784IXo8uRbbx5TzCz6OX4lCMtYH/eFlt7FUPxZElzZ3/I0JL6NjkmrF?=
 =?us-ascii?Q?zQTOn5Vh/XR4FNEZ86FQHxEpgbjMUBUShaeRflXhtTYT8XJNGwLLIKv7QQbA?=
 =?us-ascii?Q?7z/4k+zYvRjNnF7nD3V40WPuQCoeZ8FTD0d0y35iB73rUyJNLx/wt4LBMAQU?=
 =?us-ascii?Q?Z7RWhPJiYQExKZlPJ2yd+0w5visWFc0lF1osJkGbqKdK9w92DSyTNmU3PYEZ?=
 =?us-ascii?Q?hQt69FHG00IQcBJYyqn/nT6bMynvN6d/5wBboZN1BPwJmqnYQzcV/XpQ67KM?=
 =?us-ascii?Q?JXesG+lesrxR3p2BNkLoEQDMjCgezaSGkz3C1eI0Rf2UFA3AVWzvmWhyy+74?=
 =?us-ascii?Q?iDmeBEhQhMbQZFXLvc90FXE6AuvSrbSnEpRwiJ2DaKzedhgMZbdLSHAU2oFn?=
 =?us-ascii?Q?i0GfdvmxRpQznuOyZ8z+YKnj3oS6VtM2MafEey50zD/YVHjeirlssRM+WMtE?=
 =?us-ascii?Q?5vt/mEtS48+RxgyILloKvMoUi4C3Hn3/FDJ5G4n0pzgEV5N6FUBKitiMO35B?=
 =?us-ascii?Q?ly6hPXfaMhhtj7rbL76I9S2/1z9q+Vtl2pzIN0j2Hf5F8Dsj8YuSsU4GrgoX?=
 =?us-ascii?Q?qW9XiRrFj/a4eASFybnYzbJr4qlVVBDVoHjCPDt09Rn5HIkwrGU7riw9xQt4?=
 =?us-ascii?Q?bLTmHZy6dXm+ofanJ5Wn18B3DccWrmdH0iPd3Bm7jWrjwP41PipKBA6fW9NR?=
 =?us-ascii?Q?A06obxncZmBQlb7zkuWAqAEvnsk/D/RlDee2ZM+xXwRks2B8GkwXl2KgNbWB?=
 =?us-ascii?Q?8Z6BV9+VP3kfdoIdk5c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4By58uOWQBAfB7GtQLZe932/e7AHYC0xC+SSMy+/jVoktOca0Fqwv4yRLtn?=
 =?us-ascii?Q?eSWZAvyRb2FgxQEpmFBUXv50mnKY8ZwOBqMVTZvb+rBDCwH/+8NiQPSYHMrd?=
 =?us-ascii?Q?NeDXSzxiCZLEjbJl4fcepKnl9rem0n9VRBCnwmfAI2abNSkfbFXJmGB3rYK+?=
 =?us-ascii?Q?OgzLITITlekxKW+IwENT06Qp2zstApCjRTaTGpQtDWB0Hi/yLtUSZCeYsh3d?=
 =?us-ascii?Q?ZtzfRkQLWwVLG2j0NPXVAEVjA5Dpb2vOJkF5+XKIOUlWKjwpVdtwNgFMs72s?=
 =?us-ascii?Q?6MSHfn5KAqON1kgIIl+7S3KuEoiLhNypq6p0hiILmvo58OrWhtrnImRKuf9M?=
 =?us-ascii?Q?Y0iys2+YmibRnYw7c06DquhXlagiHp3vdH8V90vs5WSCleGWaoGGfbdeMJ/O?=
 =?us-ascii?Q?Vh6ZWLuyL2+BQwBxjgx+XlKtmeWKHVuILwk7/M/h2RIm0LGLe/LC8mywrsSK?=
 =?us-ascii?Q?Ziluhkqr7231679liIJycLSQ92GSnBXN7tDyYfEElX33EPQs2ONFUw9+hz7a?=
 =?us-ascii?Q?tIRiTAbhJpOSVyAMTiU1h0ep75uPPtXCJEtkDA6byM13mep3tnC1tnJae2BX?=
 =?us-ascii?Q?1pFFoOe1WOJvxOlf2imzNZe7545E4qrbHCituCiaFxMUAw3mOewmRpJykp+e?=
 =?us-ascii?Q?M+q2cZdu932ajcOCkXDCRdao/UybmWtVmZqzZWPswadPVJNEsYra950vWX/q?=
 =?us-ascii?Q?qs+tXPiIOdbkKgR2AgZHl1Ts+Ji3xVxr1AGmECh1REB6kl6QqFmUkfeGDhkC?=
 =?us-ascii?Q?BpiUjNNlAJRDPuM57q5oLk/SSy4EBcMDSmZxUE6UyriPg1cK8bgsxBVzgUBy?=
 =?us-ascii?Q?4i6nSlv9uFe7sFr3MUTEfnClCVicH72B6cQXeEmoUCx3ryiQp8GQ19ra45x2?=
 =?us-ascii?Q?79cpbCIJJWvbK17DGRoi95yETO9JeFDHqlXcjJxLnP2bJjhYCCiDX87Kicyb?=
 =?us-ascii?Q?hTbaAPLG3CazffN6ihriG9/aPyirJCBn+VkDRISnZlJ8tOvdQE5BSxFYArsm?=
 =?us-ascii?Q?yj087u6Iu4Z6Uwnk2pRjT/MMziMzARXl9xQi6zlktgem957JWFH+Ii1QWO4m?=
 =?us-ascii?Q?jHKsY7f7C357RctiKpv1rKtIkLqoVaq5z4d+stTnMUPgJww9f0wtV5DRMYjq?=
 =?us-ascii?Q?bK2Dx2mYXcpDjV+RLefy2p27qTTzPf8y03WpQMwAEtpQHixvOvjrzm5HtXgK?=
 =?us-ascii?Q?wXhJTerh1BhXG8zxoQPVEp7an5KeU/h7GgnS5wCBZ1gb3XvCRWnxVhydF3gK?=
 =?us-ascii?Q?bx5RQkUCdF04sIDY35czligmklCT+xnsGS8j7EyzbkGy0e/1O9MWXx7KUPWx?=
 =?us-ascii?Q?2IpbWydxzPn9QsfR4XbubuFBC+vCU5yZZGanqQgCtRH3oUOHGw5NiyEPGUrq?=
 =?us-ascii?Q?qjrpr1730qFJCAJRz9WSbUmfkAW7PmOmvjp7JE4rlpTXHLbsQBX4w4kg1JoJ?=
 =?us-ascii?Q?OK47yDfT41+O8zZukHWpGj84Qn151Y+ucLNtQQpWnEzvt26jyAU6UfP2wEov?=
 =?us-ascii?Q?k+Sb0o6TxoJ/SR2cTibQZXsA+Jyk1oKufmlqruYCPu2AkVI3jsHJcdPDskkF?=
 =?us-ascii?Q?tDs3iZWOZoDbvQBXov8GVCw63ozmqu9jjJ7Q0SMSOReII1nhv2h3laiPbgJ8?=
 =?us-ascii?Q?xGX5iAW9rRA0ckFY0SNAm/q8oPcPkbGTmRwjZjiH0buS3EBJGfMZmgjO6uCL?=
 =?us-ascii?Q?uorkslrPpqEb29eoegjamCUerlLLgF+RmvIcbkjBIbFHAUSultEbbBJcwWhD?=
 =?us-ascii?Q?kyV+AXEsDk/sL/QdEMpW9kBEqt1eHfA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97508ce2-81bf-4557-ea8f-08de5de04785
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:11:38.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrA5aDxITu2LclfnIrNk2lh7zimUaD2KqrRY8BRuZ8NCPDxS3B4mV+q7RIAzNs6JHY/z3a8Wf/qdZnsfXDAqFd+BH+hXSerGj9aZDNXnO94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75644-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 418FA9A40B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:55:42AM +0000, Smita Koralahalli wrote:
> The current probe time ownership check for Soft Reserved memory based
> solely on CXL window intersection is insufficient. dax_hmem probing is not
> always guaranteed to run after CXL enumeration and region assembly, which
> can lead to incorrect ownership decisions before the CXL stack has
> finished publishing windows and assembling committed regions.
> 
> Introduce deferred ownership handling for Soft Reserved ranges that
> intersect CXL windows at probe time by scheduling deferred work from
> dax_hmem and waiting for the CXL stack to complete enumeration and region
> assembly before deciding ownership.
> 
> Evaluate ownership of Soft Reserved ranges based on CXL region
> containment.
> 
>    - If all Soft Reserved ranges are fully contained within committed CXL
>      regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>      dax_cxl to bind.
> 
>    - If any Soft Reserved range is not fully claimed by committed CXL
>      region, tear down all CXL regions and REGISTER the Soft Reserved
>      ranges with dax_hmem instead.
> 
> While ownership resolution is pending, gate dax_cxl probing to avoid
> binding prematurely.
> 
> This enforces a strict ownership. Either CXL fully claims the Soft
> Reserved ranges or it relinquishes it entirely.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++
>  drivers/cxl/cxl.h         |  2 +

Can the region teardown helper be introduced in a separate patch before this
patch...like you did for the contains soft reserved helper?

>  drivers/dax/cxl.c         |  9 +++++
>  drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9827a6dd3187..6c22a2d4abbb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_region_debugfs_poison_clear, "%llx\n");
>  
> +static int cxl_region_teardown_cb(struct device *dev, void *data)
> +{
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_region *cxlr;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_region(dev))
> +		return 0;
> +
> +	cxlr = to_cxl_region(dev);
> +
> +	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	port = cxlrd_to_port(cxlrd);
> +

How about a dev_dbg() here on each killed region, and a dev_info()
at the call site proclaiming what is happening.


> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +
> +	return 0;
> +}
> +
> +void cxl_region_teardown_all(void)
> +{
> +	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
> +}
> +EXPORT_SYMBOL_GPL(cxl_region_teardown_all);

Maybe be cautious with who can access this function:
EXPORT_SYMBOL_FOR_MODULES(cxl_region_teardown_all, "dax_hmem");


> +
>  static int cxl_region_contains_sr_cb(struct device *dev, void *data)
>  {
>  	struct resource *res = data;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b0ff6b65ea0b..1864d35d5f69 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  bool cxl_region_contains_soft_reserve(const struct resource *res);
> +void cxl_region_teardown_all(void);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
>  {
> @@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
>  {
>  	return false;
>  }
> +static inline void cxl_region_teardown_all(void) { }
>  #endif
>  
>  void cxl_endpoint_parse_cdat(struct cxl_port *port);
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..b7e90d6dd888 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
>  
> +	switch (dax_cxl_mode) {
> +	case DAX_CXL_MODE_DEFER:
> +		return -EPROBE_DEFER;
> +	case DAX_CXL_MODE_REGISTER:
> +		return -ENODEV;
> +	case DAX_CXL_MODE_DROP:
> +		break;
> +	}
> +
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 1e3424358490..bcb57d8678d7 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -3,6 +3,7 @@
>  #include <linux/memregion.h>
>  #include <linux/module.h>
>  #include <linux/dax.h>
> +#include "../../cxl/cxl.h"
>  #include "../bus.h"
>  
>  static bool region_idle;
> @@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
>  	platform_device_unregister(pdev);
>  }
>  
> +struct dax_defer_work {
> +	struct platform_device *pdev;
> +	struct work_struct work;
> +};
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> +	struct dax_defer_work *work = dev_get_drvdata(host);
>  	struct platform_device *pdev;
>  	struct memregion_info info;
>  	long id;
> @@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			      IORES_DESC_CXL) != REGION_DISJOINT) {
> -		dev_dbg(host, "deferring range to CXL: %pr\n", res);
> -		return 0;
> +		switch (dax_cxl_mode) {
> +		case DAX_CXL_MODE_DEFER:
> +			dev_dbg(host, "deferring range to CXL: %pr\n", res);
> +			schedule_work(&work->work);
> +			return 0;
> +		case DAX_CXL_MODE_REGISTER:
> +			dev_dbg(host, "registering CXL range: %pr\n", res);
> +			break;
> +		case DAX_CXL_MODE_DROP:
> +			dev_dbg(host, "dropping CXL range: %pr\n", res);
> +			return 0;
> +		}
>  	}
>  
>  	rc = region_intersects_soft_reserve(res->start, resource_size(res));
> @@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	return rc;
>  }
>  
> +static int cxl_contains_soft_reserve(struct device *host, int target_nid,
> +				     const struct resource *res)
> +{
> +	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> +			      IORES_DESC_CXL) != REGION_DISJOINT) {
> +		if (!cxl_region_contains_soft_reserve(res))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void process_defer_work(struct work_struct *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +	struct platform_device *pdev = work->pdev;
> +	int rc;
> +
> +	/* relies on cxl_acpi and cxl_pci having had a chance to load */
> +	wait_for_device_probe();
> +
> +	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
> +
> +	if (!rc) {
> +		dax_cxl_mode = DAX_CXL_MODE_DROP;
> +		rc = bus_rescan_devices(&cxl_bus_type);
> +		if (rc)
> +			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
> +	} else {
> +		dax_cxl_mode = DAX_CXL_MODE_REGISTER;

dev_info or dev_warn that we are doing the teardown.


> +		cxl_region_teardown_all();
> +	}
> +
> +	walk_hmem_resources(&pdev->dev, hmem_register_device);
> +}
> +
> +static void kill_defer_work(void *_work)
> +{
> +	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
> +
> +	cancel_work_sync(&work->work);
> +	kfree(work);
> +}
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
> +	int rc;
> +
> +	if (!work)
> +		return -ENOMEM;
> +
> +	work->pdev = pdev;
> +	INIT_WORK(&work->work, process_defer_work);
> +
> +	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
> +	if (rc)
> +		return rc;
> +
> +	platform_set_drvdata(pdev, work);
> +
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }
>  
> @@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
>  MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
> +MODULE_IMPORT_NS("CXL");
> -- 
> 2.17.1
> 

