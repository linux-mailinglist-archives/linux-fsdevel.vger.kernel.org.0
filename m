Return-Path: <linux-fsdevel+bounces-18817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970448BC916
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B933E1C21661
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3806140E3C;
	Mon,  6 May 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0GHcvNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB510140399;
	Mon,  6 May 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982719; cv=fail; b=N8DuGrlXvFANLPgTQ4AmGHLagdwgd4MxkOFOIVdzVL2kiKC6VAppmvjOs+jUueJ1o9uaUXBO6DY65Svg392UAQuiFxOqFvPIZmzTC5qxhnQP4GCIzj1VXWRz0tkG1f5Cy6k8faa98YIxX0MCiVYrthpgVXsFv/6Y4RoKZFuNHQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982719; c=relaxed/simple;
	bh=8QSG3bEEATIXi8gQ0Nj/zmOmIpEW3KJSLa/sTN+IwG8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5e3Q/W1UOb2pz88LW7QckyWHEluttnsA+IcIDhSJrvhWcUgfyaE3+AIL0efdxgDEqcuFcH4b1XQuiMmuoP0ePZteRqbqWfW5WZNu0dBdDClB15PuvCpwFW3VFdcgF7lQ7Gb6NFGVNMEsI2a/JA8n3RmrXXEm2KBB+RMqEryWJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0GHcvNp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714982717; x=1746518717;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=8QSG3bEEATIXi8gQ0Nj/zmOmIpEW3KJSLa/sTN+IwG8=;
  b=V0GHcvNppK2YoCUk0dt9UHjUhJaT/vWnqM9w8qU1RQNhW2mmCF5fVn52
   VGEjMTHVZHW+Hsd8jr9f63hlri2seDxG3oi2DsmCqHLg8YMlE/4OEVRhY
   k7cWtKkf04l+sH/uyfbHkvQT1LJjEbmI2TqSRzxCo6zXgDljKO/QS9W46
   VA4HKDv2rzzzUHxejk+dHmj9UzNwND0bzzCdSr/cCwCobHQHoc0GBl37L
   9REMnNHF9KCBV+5XLVLcAr1qawPkoHINzVAWyx7KUFJd63A804C0Y+jfm
   aWIdM84aMPKu8j06xmjmYjBlGYkuuPN1NdZZvfmL2SbWjCDlUgPrO4XnK
   Q==;
X-CSE-ConnectionGUID: 2mFU2UFqTtqfmfdfRVsudQ==
X-CSE-MsgGUID: PFIgvnmeTveiuUIGSHY0bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="21394966"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="21394966"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:05:15 -0700
X-CSE-ConnectionGUID: knSXoaN5RaiWQ77uOyoQ/A==
X-CSE-MsgGUID: s178rE44S1GYTvtB7QQ/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="58974720"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 01:05:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 01:05:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 01:05:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 01:05:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 01:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZiH06A5Pk5LA+CzLFJzyzq5OUhKpfxWGVsV1JQ+up6FDb0T4y7WBXXpo0xD9lTyLZLSGchQK3LSP8IW7u5shmHBJ13BZ4yQKSRTpFs8QKUNP2NDUj7xh5cn5ueDMC2p133E1oBDu5YFUaNEdAnYqwgJMhdWez76O1DGmECK1N/x6xGCw2ODToxxStG3W0wf2rUr7A4sKka3JQoTioX+n1RzAMbyLOWqW8SRRW5gYxvW4WwApkuYbfnpoE6DlTcelyLX85scq6oRKFgSfMdTrLjCLfoJGIw9ozEduT4JQL5WjxinYlLG+RJk9A6jEH3/2uZ0o/IOfdTh8MLaZj9QBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+v77JN8hjehnd+oHNuK7xHNqtMzVh4+hqDTNOj1Mgc=;
 b=ElEn/qFRhCGX6YAwVY08mTkji3NrwxILY2r/8ZS4XwdJkszXxhbJzZGM9o4mZ0gQNV0I+4G68hiHwLXHBUsCXPzUn9FMFkaXA8HfkxdWa0zosDmCKsA73q26kfxMmqWt7YxdiobkRoqAvUYdlxtJmqMuS5PUwLv0o6Jj4OdYvuVy8z0Mlq+qvLk/5mOFc49nSktX3sOmqch67bM9LHEtpvA1r6+yeEyNilzFI62NH3ioc99T1rI1D3htHnXwvByeCrm9SqZH0ZGWqoLnP3h1dWi8kirF+/WCx88YegM1MW2xjje2vrnBCg/GxWgYE//4pnVZ0+z/n4bEc1sT7sopGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Mon, 6 May
 2024 08:04:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:04:58 +0000
Date: Mon, 6 May 2024 16:04:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "Kees
 Cook" <keescook@chromium.org>, Will Deacon <will@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Mark Rutland
	<mark.rutland@arm.com>, Kent Overstreet <kent.overstreet@linux.dev>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
	<jack@suse.cz>, Zack Rusin <zack.rusin@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti
	<andi.shyti@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>, Matthew Auld
	<matthew.auld@intel.com>, Nirmoy Das <nirmoy.das@intel.com>, Jonathan Cavitt
	<jonathan.cavitt@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<intel-gfx@lists.freedesktop.org>, <linux-hardening@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 4/5] refcount: Introduce refcount_long_t and APIs
Message-ID: <202405061514.23fedba1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240502223341.1835070-4-keescook@chromium.org>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 5632cce3-ff39-4a07-face-08dc6da338d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S0QJu5qoOnSB9/nwzZckfNF/cWaWTfXd5A6Thtnfgw0f419lvfqvpQa8ntuJ?=
 =?us-ascii?Q?Kd/6zwT4PXg7/Zon59j20WXNW/dlsIYc3ZF5qYZr3CRNE5NMw5cW8sZcNT5V?=
 =?us-ascii?Q?YFL3Xar3BLNRvsjGy9/Ius/O4RiDKYeWNlMZoktDdPEL/DpXKdnwkvm4he+Y?=
 =?us-ascii?Q?tHSFQfLic4n+An4+hJF0Y5e9qFUrAsPAYCnAN6cyHmyuqC5VDbOTSVTC143A?=
 =?us-ascii?Q?Qz7e6rEllzgYcVxpvdYa1nXgxUQYY/ze69L3inQQuEfsr8D4bYvlS6bs4hSq?=
 =?us-ascii?Q?DeLePcuTe+oiamQreokh9/1F7gEoF4N4SMjpxg3dQBZE+ZxOaVdqZoe0E9Wc?=
 =?us-ascii?Q?VmZqXIk6zJGXkU7cvSVdWGVVrlhcxGJzEZNn5b/H/4sNIGhBo+KwRbijtVRB?=
 =?us-ascii?Q?niOq3c75I1VKDS7V9q92EcaMph9CgwopNgaYazb8scMGTWiZNp6SFKy+3Fv9?=
 =?us-ascii?Q?nTde/XVF/jXkkukjxDUMd9CSmDDGeCylxVKav5UidOv1ZAkFo4mIJ+c44w18?=
 =?us-ascii?Q?BoAUxXOI9Ngx1uLZvFVioBq6cJryAy4rfTcDJG+hohstMM8hw0Fh0v8tFmVt?=
 =?us-ascii?Q?n1T8mf8FOpFD7KNvuoHa5w0mX2Mco4vneiw6vqiyV24rUWZWga7onnOR3w/F?=
 =?us-ascii?Q?Bf7fx/z7UWBLOIMs3IRUtR7bvOkWRl3epARoGaJGiwPWUxqva01Z1TIR3egW?=
 =?us-ascii?Q?f7fK4Es1RBhCCFLIkuJ4+JwxqpjonQYzlK8q19bCsD0om8EhgcHOy1//oRiJ?=
 =?us-ascii?Q?/esueyEIwcBwy7whc1EiBd6eoxES2jtrsbI1C53WMVouSTmG0pYE6vZKVdgT?=
 =?us-ascii?Q?c6GMf9EpsPbqMkUXTm+g0C8R7xsQTbSgiHYKRufqMS0wBrpwSxrlGtSsd2kQ?=
 =?us-ascii?Q?SiKrQUGpsKXSDuOchzum/7RfjVD+rknvt/FC4r8mDzbrBjRiswi8jENEJsDc?=
 =?us-ascii?Q?fb3UTZOE21iy5k7tvLvT4I4tfDPtZdd66byD7KTh6/XaJiIZBNhSgUXKTNXD?=
 =?us-ascii?Q?4fsVbLQQgqG+FxzxqJhiNg9BR73f6TKrCg9Ueo57UP1jYfhPYtJhUTOSC0Gn?=
 =?us-ascii?Q?VPymuKloLbFlqDNt4n+58mLLITtzvVYCzrNT1mcYpv2au6wR8ZmKEKgMhvM9?=
 =?us-ascii?Q?L4f1N0sDwwLkLXH7FTspmhv2t9G9Jo3yGt+j935R2xBaTf0mcAAIgcRGXUNv?=
 =?us-ascii?Q?sOvRyBiGwj+/uaAKhdkSZLFffuBUXP1q19Ut1OqXtM/AyecHDcj6P5Uw19c?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXB1eYfjOlWSg2jHRNJXey+xNQSjAdtf2w0Lvs4TiLA0ZeBUGSYtATyCPZz7?=
 =?us-ascii?Q?Gci7cSkNzne22mk5mZIWVbYHAmmhecPoAOcNtlaUvtCxX0QaScoNiKF66va0?=
 =?us-ascii?Q?1PrmkXrEibKjA40bKEHpd8SzDY96nppa6dOc0GxSf7HH140Y2Q8b3QIHCsnW?=
 =?us-ascii?Q?F5BWOwobhPhJdDsacY3vIcUK+0VFBQXPUmatsOLzAss2eRwNnjz41THmdgfE?=
 =?us-ascii?Q?zmwrQB2AyKK1TSZD/bzjc/u3PUrDyS6cVK/nR+J3JioI5V+wf5AYb7C7XA7w?=
 =?us-ascii?Q?D3OadNDw882tOPC9D3wsyrDHt43pL9mrrYmW5g5CogQ51sqJEBeS20rNYp3M?=
 =?us-ascii?Q?j6aU/1HdJ2eooC+2dc3uyYU0kyHi84mm4/ve0ALEHct9uSg5juegyGPg2sJX?=
 =?us-ascii?Q?O1mReexY4KO//snherEIWhAz+xcaLds9P4Km3pJbWhwy77DUelgXtSnKTWg9?=
 =?us-ascii?Q?H3QU3mOTa0ZO8MTlukgBwsIwimpKrjmdJJMrivCGUWZerMbHWhjrxuZPjknm?=
 =?us-ascii?Q?1nVniFKeKbH5w73lua4PScfn4G5DMviClQhmegfYjvMQynbxsGEfAMlOeIrJ?=
 =?us-ascii?Q?6DjNGvSLzbGNKZ7sAejaKDXODAEX++fASFcchBPJFeV29cda1lvdza7/4S1g?=
 =?us-ascii?Q?Sc/tdW8p5leqpTVaXVce7t492WZNYnSOI+VhJgKlUOLTdvqZZUSqv+C8tGAU?=
 =?us-ascii?Q?OcxuqVMEdeHpuoidEzYIyFhQAlLy//MlPFnkiwe8gJzS4niOcpaKXnXzZJdA?=
 =?us-ascii?Q?Z6YF3cuu978rEBnAi7eW0D6zboKwbDKYGfe0EGStwDQLPN6Ms8ZZl0RICePl?=
 =?us-ascii?Q?yeUL2gmcsJdO0OXVIfI5aIGOY/Ik+32RoLrUp1ZfVrma4Xoy+UjwSB4nOV9G?=
 =?us-ascii?Q?+K7qU9cDlL63w2TWD39CMRolv6ArbAEAjs0jhYsxlnelX5fTTRlIDHtRiXg+?=
 =?us-ascii?Q?3DBFX7mLE3kYHQqAwx1tCC0zoQ521QEhk9uQZZ4NroqGTvY3vw99EfMw6Fnp?=
 =?us-ascii?Q?GjN0oBX9ZspRjmyPe5UEvRdOuoz3YgPERyfCg949yACpjvQu175FO92I+M+1?=
 =?us-ascii?Q?R37Kt2h9OodsUURN3CgAC2/fB1mmz9dxYK89PPy+DKP/vm9ooJD667M5hFtd?=
 =?us-ascii?Q?boKBg8Rx1rOAmL0iSzKhhJ4nE+PFT5orXIRJHoVM2qlaYM2odsccRSqTDPE1?=
 =?us-ascii?Q?YYx6NKhWa77TlxGRQuinAN0jedX0EOmSO4nrgAoKWS+oLkaJPiDrojTYZL7A?=
 =?us-ascii?Q?ANt3YxRsxd5SBzIPqvobRMyO8lUTwhO47ahxg24Y3xxKBGDynJmZLae81M9I?=
 =?us-ascii?Q?Mcwv7ZeqfLhF2IBB9aWHQUvENd2l3wRlYjdVgG4vnD0AZw0Sc2x0m9zsPjba?=
 =?us-ascii?Q?jMvL9K0MPexgf7wiwIiFujMBGB8wOXU5e1BN/37fNHm+1BikSUnBlvtlWmMA?=
 =?us-ascii?Q?PO8W8FBj1PnBQ1dVYQspsht28GOE+j84y3+50LqTkZFfa7MVE8sVjotyPKyJ?=
 =?us-ascii?Q?Xa4ZttAra2tINXGFSfouSxE9OHlS+sGKnpOZsx9bcD6FkJiAWhaC+gi8Zz2s?=
 =?us-ascii?Q?nqDuUUNTKd45Mgsju4AHxFsK13bWTGiPGj4CSZHU1ajhz09kZ+yhfTjLhO/+?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5632cce3-ff39-4a07-face-08dc6da338d9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:04:58.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8RANUwdS2lp36sw9zatkpsR7zPpLd/kmeswnxVeMrBFZpF2rfT5mAJgYqtwBVp+Nh5zoOrEoPv/7MUDAH88ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com


hi, Kees Cook,

we noticed a WARNING is our boot tests. 
as we understand, the WARNING is not introduced by this patch, instead, just
changing stats as below.
however, we failed to bisect
"dmesg.WARNING:at_lib/refcount.c:#refcount_warn_saturate"
which shows in parent commit to capture real commit which introduced the WARNING

just made this report FYI what we observed in our boot tests.


8090de6a0536f462 93b9cd30de232c9b4e27221dff6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.EIP:refcount_report_saturation
          6:6         -100%            :6     dmesg.EIP:refcount_warn_saturate
           :6          100%           6:6     dmesg.WARNING:at_lib/refcount.c:#refcount_report_saturation
          6:6         -100%            :6     dmesg.WARNING:at_lib/refcount.c:#refcount_warn_saturate


Hello,

kernel test robot noticed "WARNING:at_lib/refcount.c:#refcount_report_saturation" on:

commit: 93b9cd30de232c9b4e27221dff6d02ac557b86eb ("[PATCH 4/5] refcount: Introduce refcount_long_t and APIs")
url: https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/fs-Do-not-allow-get_file-to-resurrect-0-f_count/20240503-063542
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20240502223341.1835070-4-keescook@chromium.org/
patch subject: [PATCH 4/5] refcount: Introduce refcount_long_t and APIs

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405061514.23fedba1-oliver.sang@intel.com


[    2.683270][    T1] ------------[ cut here ]------------
[    2.684014][    T1] refcount_t: decrement hit 0; leaking memory.
[ 2.684829][ T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:29 refcount_report_saturation (lib/refcount.c:29 (discriminator 1)) 
[    2.686080][    T1] Modules linked in:
[    2.686633][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc3-00078-g93b9cd30de23 #1 ade0d32fff89aed56247bad9c6991c6e60a975d2
[    2.688188][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.689523][ T1] EIP: refcount_report_saturation (lib/refcount.c:29 (discriminator 1)) 
[ 2.690327][ T1] Code: c2 01 e8 92 8a b1 ff 0f 0b 58 c9 31 c0 31 d2 31 c9 c3 8d b4 26 00 00 00 00 68 ec bc f4 c1 c6 05 3e 42 4a c2 01 e8 6f 8a b1 ff <0f> 0b 5a c9 31 c0 31 d2 31 c9 c3 55 89 c1 89 d0 c7 01 00 00 00 c0
All code
========
   0:	c2 01 e8             	ret    $0xe801
   3:	92                   	xchg   %eax,%edx
   4:	8a b1 ff 0f 0b 58    	mov    0x580b0fff(%rcx),%dh
   a:	c9                   	leave
   b:	31 c0                	xor    %eax,%eax
   d:	31 d2                	xor    %edx,%edx
   f:	31 c9                	xor    %ecx,%ecx
  11:	c3                   	ret
  12:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  19:	68 ec bc f4 c1       	push   $0xffffffffc1f4bcec
  1e:	c6 05 3e 42 4a c2 01 	movb   $0x1,-0x3db5bdc2(%rip)        # 0xffffffffc24a4263
  25:	e8 6f 8a b1 ff       	call   0xffffffffffb18a99
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	5a                   	pop    %rdx
  2d:	c9                   	leave
  2e:	31 c0                	xor    %eax,%eax
  30:	31 d2                	xor    %edx,%edx
  32:	31 c9                	xor    %ecx,%ecx
  34:	c3                   	ret
  35:	55                   	push   %rbp
  36:	89 c1                	mov    %eax,%ecx
  38:	89 d0                	mov    %edx,%eax
  3a:	c7 01 00 00 00 c0    	movl   $0xc0000000,(%rcx)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	5a                   	pop    %rdx
   3:	c9                   	leave
   4:	31 c0                	xor    %eax,%eax
   6:	31 d2                	xor    %edx,%edx
   8:	31 c9                	xor    %ecx,%ecx
   a:	c3                   	ret
   b:	55                   	push   %rbp
   c:	89 c1                	mov    %eax,%ecx
   e:	89 d0                	mov    %edx,%eax
  10:	c7 01 00 00 00 c0    	movl   $0xc0000000,(%rcx)
[    2.692770][    T1] EAX: 00000000 EBX: e19ee0c4 ECX: 00000000 EDX: 00000000
[    2.693685][    T1] ESI: e19ee0c0 EDI: c37ad880 EBP: c3767dd0 ESP: c3767dcc
[    2.694597][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[    2.695638][    T1] CR0: 80050033 CR2: ffcb2000 CR3: 02723000 CR4: 00040690
[    2.696557][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.697464][    T1] DR6: fffe0ff0 DR7: 00000400
[    2.698106][    T1] Call Trace:
[ 2.698586][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 2.699197][ T1] ? refcount_report_saturation (lib/refcount.c:29 (discriminator 1)) 
[ 2.699975][ T1] ? __warn (kernel/panic.c:694) 
[ 2.700547][ T1] ? refcount_report_saturation (lib/refcount.c:29 (discriminator 1)) 
[ 2.701322][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 2.701960][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 2.702584][ T1] ? handle_bug (arch/x86/kernel/traps.c:218) 
[ 2.703208][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 2.703850][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 2.704538][ T1] ? devkmsg_open (kernel/printk/printk.c:596 kernel/printk/printk.c:615 kernel/printk/printk.c:919) 
[ 2.705173][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 2.705798][ T1] ? refcount_report_saturation (lib/refcount.c:29 (discriminator 1)) 
[ 2.706578][ T1] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 2.707215][ T1] ? refcount_report_saturation (lib/refcount.c:29 (discriminator 1)) 
[ 2.707994][ T1] refcount_warn_saturate (lib/refcount.c:40) 
[ 2.708693][ T1] __reset_page_owner (include/linux/refcount-impl.h:318 include/linux/refcount-impl.h:333 mm/page_owner.c:228 mm/page_owner.c:266) 
[ 2.709377][ T1] __free_pages_ok (include/linux/mmzone.h:1100 mm/page_alloc.c:1144 mm/page_alloc.c:1270) 
[ 2.710036][ T1] make_alloc_exact (mm/page_alloc.c:4828 (discriminator 1)) 
[ 2.710687][ T1] alloc_pages_exact (mm/page_alloc.c:4859) 
[ 2.711357][ T1] alloc_large_system_hash (mm/mm_init.c:2531) 
[ 2.712095][ T1] inet_hashinfo2_init (net/ipv4/inet_hashtables.c:1193 (discriminator 1)) 
[ 2.712770][ T1] tcp_init (net/ipv4/tcp.c:4714) 
[ 2.713348][ T1] inet_init (net/ipv4/af_inet.c:2032) 
[ 2.713949][ T1] ? ipv4_offload_init (net/ipv4/af_inet.c:1942) 
[ 2.714640][ T1] do_one_initcall (init/main.c:1238) 
[ 2.715294][ T1] ? rdinit_setup (init/main.c:1286) 
[ 2.715927][ T1] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 2.716542][ T1] ? rest_init (init/main.c:1429) 
[ 2.717157][ T1] kernel_init_freeable (init/main.c:1550) 
[ 2.717852][ T1] kernel_init (init/main.c:1439) 
[ 2.718455][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 2.719085][ T1] ? rest_init (init/main.c:1429) 
[ 2.719700][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 2.720348][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    2.720999][    T1] irq event stamp: 263893
[ 2.721599][ T1] hardirqs last enabled at (263903): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050) 
[ 2.722782][ T1] hardirqs last disabled at (263912): console_unlock (kernel/printk/printk.c:339 (discriminator 3) kernel/printk/printk.c:2731 (discriminator 3) kernel/printk/printk.c:3050 (discriminator 3)) 
[ 2.723947][ T1] softirqs last enabled at (263164): release_sock (net/core/sock.c:3560) 
[ 2.725080][ T1] softirqs last disabled at (263162): release_sock (net/core/sock.c:3549) 
[    2.726210][    T1] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240506/202405061514.23fedba1-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


