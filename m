Return-Path: <linux-fsdevel+bounces-45064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1BA711A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 08:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0883C7A173C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0751A01CC;
	Wed, 26 Mar 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqdEOvb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A719CD16;
	Wed, 26 Mar 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975559; cv=fail; b=Llv9QG1LdLKyAUzfVA1lVM3yhmbi03KwrShpvsO1UkjuXXBttImcTRSHNYs+z3SExiJ95EOw+3j3G6SWnkykjmx4IXbsdc2r2jH3a+ZnAzurJ8zpiHIF2TGs2g0lLDiG9E/fh7cBMEp7a1STwy9CoNQ4qfec91NV6Q6Gd29FKoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975559; c=relaxed/simple;
	bh=4fXCmWX4hWGn9HVZQTYV1pxQwlbSvaOxbysRZHPf8lE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nooO/yu3ZI3fsk3QbxOP7s7r+jGdQFxZSECv5W458Cv2Bmgfolk9gBaZA0WqZzLroOcPKvhyPJWiQDDr/DwguhOizCR41YSAFhFOHm5q4mdFrjxZ4/D9BT5tDk2eABP4D56gPsl5f79MfOWqe97AimxzCmC6M63s2DDeKxB54QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqdEOvb/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742975557; x=1774511557;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=4fXCmWX4hWGn9HVZQTYV1pxQwlbSvaOxbysRZHPf8lE=;
  b=iqdEOvb/Mzvb+IFj9X1dysPY1kmskqdlbDonsC4QBXqypB5MB47kmP1l
   PZnRbxI03MdBpdspnPP9K81TEIEhmlNcgqWs3nAqDPeDuZOhcmRaE5rak
   U2yilwyJ5YLl5xA/G7ctgMbYfNrFKS9Nq9KQXjMNvoSpAJqhMbXhntRtB
   i32RFoc7NMHdD86BPVCHoUBrheDzaBrwIDT0dYOapTvQIVMbV5XS+nPc0
   5bagx5Ons6h1nkRYv+mRRH2HVnT2dGhLVc1K1V+kgB5na7vqOMTUwnIYr
   dcgjVTdMPDm0HYoANlUcHGgAuB4bw41UdvnmQKZ2LpvfsxgXcrACHGAZw
   g==;
X-CSE-ConnectionGUID: tc2rzLHsTHmEbYuPooczpQ==
X-CSE-MsgGUID: 32JAzY3eQDG1DlornPYb6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44369567"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="44369567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 00:52:36 -0700
X-CSE-ConnectionGUID: Cd6tAbqPQZqS6+BWxj6Xqg==
X-CSE-MsgGUID: 1OkHdRJJT9mfOOwTpgByMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="129796372"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 00:52:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 00:52:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 00:52:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 00:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCKkLdNPnicEPXomQoG+8SmAruIipFMpnVtm/KRDODZGyCMotNkF59TKVWS55mj3JYF78Edxa3r3o7t3/DZsbxugMoCn/IB0iLfNH1iRyu4+ovzjtKgCPSB/flCVJywlBymdqryNgBoArWxYeH/fZdz2al7Tvj7++M6l7rYMkvCiASq6J8b4O55r/2lV1RLvbMrndnVgxFi3L3f6EJCnIuMWZkBjYTAGz1pRIHEtfo1mLKX61S9j8JJvFLmebcy+950jtWcbDhxLDLqBubx78MY+CUFx4VN9loq0Qf+b7E/NWp+PyhVEp0D2Ti5bpvNTHuUxeuZyretq5ccQvKp0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beqqInBpxVfj/5uF529FS7wKmBdr+SZmX8b4jMMARcE=;
 b=cEeYHQCx0zjJxKcBWzCEwEbPpP/LWyGy0EeiiqAShtT7Xvvu2Ss3q5dMA6LiIZsT8FwLuZleE3jqrdNJD1sXOu6zNTb3wnXsVOE/raMiaK/mRLbmLs4i54vko97uEKKJBhutIlQmCdAgj71kMvNdd16rfQ++LtwkLiFm3jB4Gnt9m590eA4gBREu376IoHPNLVno/g3vOKQ8nP7qHIBwhjzDn3un1PbTaIFGI2t5goHtaqKGs6Zjj2Y0CtKt+vhP5KKsDIMCko1gw1ZCm9NjBB8EDfxkyvZF0faIKlZlJG4PvSHnvpm6yQLBbdnnMOLWKJtpd+l/rI2KUN0MO65rqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB8091.namprd11.prod.outlook.com (2603:10b6:8:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 07:52:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 07:52:02 +0000
Date: Wed, 26 Mar 2025 15:51:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "=?iso-8859-1?Q?G=FCnther?=
 Noack" <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, Serge Hallyn
	<serge@hallyn.com>, Tahera Fahimi <fahimitahera@gmail.com>, Christian Brauner
	<brauner@kernel.org>, <linux-security-module@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?=
	<mic@digikod.net>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>, Mikhail Ivanov
	<ivanov.mikhail1@huawei-partners.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 5/8] landlock: Always allow signals between threads of
 the same process
Message-ID: <202503261534.22d970e8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318161443.279194-6-mic@digikod.net>
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f935fa-cbbc-4cc2-b35d-08dd6c3b1879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZiHIishh/bQDY17/VxZI7ExOgF2J+61QwXQGHBzExTaVXwWNc8KCRU92L0Do?=
 =?us-ascii?Q?5rdgAtKmodILiuyS0Jhq2cSGoPo7y8PGSJcWxAvtlyfFgPOkcMexAnfOr0dD?=
 =?us-ascii?Q?oNAbcRq88AdfcVZktaGnwDrq6sSHz5CbC0b649WkcCQQNJ35xZSZQtRgQOGb?=
 =?us-ascii?Q?Oc4igcEcrM9kLIGE8wNTkJshAQ74h8fETqfc/fXtQknmpJ3P48HUkqiJqxRP?=
 =?us-ascii?Q?PgJUVd/QhNCdmrlROnKLkSV/tiSPDfkswXk32NSpSxWXsKNxbvNj1vgt3xJG?=
 =?us-ascii?Q?vKnch+rrmacnD7bX1rCJLV4CRwzhhwVONtLTeWKyZ5lymsvk3f4rQckhtiEu?=
 =?us-ascii?Q?0dNtEjhwFoiMsS/UdM+SNvRvctwPEeaDb11z8r//WpyGvySVE/KfxWi6O0fY?=
 =?us-ascii?Q?xch1rKMZwLSV/bVTcZBSAv9fT4mpkSaPTXv1eOGATfv8k8lxhVobsfrfNUQ9?=
 =?us-ascii?Q?W7w5G5SU0WDA28vMNNphyDmjt4bp0hOtc9SJmeXvVPX5PAtvCMx3+KQIiIoC?=
 =?us-ascii?Q?wJGY8JK25kD+X19jIqejh8zl0E4NHuDE86b3aMsOx24JhkA+/uoWObanwFfR?=
 =?us-ascii?Q?b1s5/qTi2dUTcSupaBTFGtzCjvs2dkmb3sjwJ2eL/hI0hfXNGcNsYv6stGzg?=
 =?us-ascii?Q?K3JVblfcY8xgVwS8L0olmciueHuKEEOLtzSB13xRYLb/FSeTOu0jFb/uDL0y?=
 =?us-ascii?Q?PuZT3/F1G1y0MwgHKRkWuPGhYu+ji+7SKkgrtiVGn17Wad5dVyETp6IWCMJG?=
 =?us-ascii?Q?4dAaMLgiZdF+VuV5tS1lkAyG8mBsY8eo9JdW9rmcexTYh0lCnShxFBLAf3Im?=
 =?us-ascii?Q?qYpIqipFsqSdYcuniP7LKusfLgV0MSeS6hJ6Hf8mBygHO6xAhFrdF5P2t1ZJ?=
 =?us-ascii?Q?dHA2LPsDaxRWrBM9M8ZPDttvAAJ9detJWyKxj1xIbui7uIfgEU11/N0+Ygzf?=
 =?us-ascii?Q?DGvOVz5tWk4qKrA09N1YryYdvVVLASL/hufatgOPIn3gOM8NHnyDaGcCbr/v?=
 =?us-ascii?Q?zIAAmufxkSmia3iSmeXXPc3fWG0qOVrAl8r9+rlWvqDnzgdB83aWbgw0EDzu?=
 =?us-ascii?Q?PUlh2bLLvX7Ctah1/kzef3aSWHfGod+8MDmeGaBRGLnmxDOi5ow4vGXdvV7P?=
 =?us-ascii?Q?iZK0n4yY17atEPD6YsFff2Elq+Ja+XlGeE6crtodMhf+2JoGi/POF3j/qpge?=
 =?us-ascii?Q?m2LRbNTJZdOMrk2w0fHp01WppUJDAmUy5LhPshRSFTDbA+Mx/ByBXuNw0dSW?=
 =?us-ascii?Q?g8tTTjxJFi8u2aLBbjOZLqPqSc7N2pRmWX4+DNS43fw0swVpYEwCWsPZ+ZqC?=
 =?us-ascii?Q?A1zDNOHTVyGPqIVe74/XWwVGeMqr3wd7H37k8Bxhjg1+pA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnTu2VW+SJd++YQHTWmq1r5P+IKeYByRdVvaK9iI61Vce7UGlXzxdjyQIV8l?=
 =?us-ascii?Q?wvuXDjtaCBFNie9ec5whnvZ1DkO+aK/928NCDv2PhnLpZpALAFSSkDTdL1j1?=
 =?us-ascii?Q?Ub+2mx7GLq5lktpwzhVDh4Kt43dPcu2HZkhI4N7PzBtcdMY/OoycrUNs/DPx?=
 =?us-ascii?Q?H0pMQYC7xkcIrgI4w8m9v/q7D/UF7GBh49FoKDbuQ8joztS35wx2ULkckE58?=
 =?us-ascii?Q?lhpDMYDVTDIZS5uxxR4O5KRRzEwb3zxoRxEPjy7+gV9rPaQrkMOMp2MEgOj2?=
 =?us-ascii?Q?Layf1eTZNvozbKF2GyYQz0QgcGuEaxJUMxmyzdkyO8oX+sryb29MNHidC8Cd?=
 =?us-ascii?Q?jQE48zJJ+l8Up6G1oRkleagaMETCWV4zJBq1HqcbGStEfgjT5NHsYRY+QROU?=
 =?us-ascii?Q?g6mnDDMLUHT5avIBH3lPuf9t+DCnzHvt6EZaMyHmw+At93OJfd2lz2mvOb7S?=
 =?us-ascii?Q?Kyi8oSJJCyYsmvhP0WdZEPP/VpOvLG2Mr47/2mZ+RJrStAl01WhSG8gMOU0q?=
 =?us-ascii?Q?OB+/EFCotkQvsDqJBoPTgmM2KLa3eUwv+yoUQNZGGbOVQQKvrCdBp8zwcP5h?=
 =?us-ascii?Q?aqME6i8uHC5XrzZZ9wtzy05+etX2hyhUUuah1C0Dwpwb0rB8vXTSxQHrI7LX?=
 =?us-ascii?Q?xXVYzuHpSLAh4+7PKT+E0nk7OG/+Babxoyzh9ti5fStL1BNjAqy7XYlbC7F4?=
 =?us-ascii?Q?JnwIdbaSEK2XKb8XhfFltLKI8/0jvuKvF6nrzDfyxH/85lP6rNImj+ca9Tzo?=
 =?us-ascii?Q?Otk1mi3/a2Cc8cLH9UalvpehJAk6cYs6A+IuplTOIorJrPDOdpbCmkDoZIQ6?=
 =?us-ascii?Q?paveObb9H2GlxDiuUBavil3GrSKDwGUP900Uid8oCUmDrhjZeU5FsKqFQ9Bd?=
 =?us-ascii?Q?GcZMm6obKE+Tt5iLeYxNVjYNkYCXcTdb4CZ/IrOMcLXQLIW4WbA7fAPFReYO?=
 =?us-ascii?Q?tNlmvF/ElUOcbES6OK845jECywJ4/LlBKFODAE9hJYFpDXho7Qpys04X8NNj?=
 =?us-ascii?Q?GoZ78b1KsLE/kiVc/jdK6x3lguEg7Boe5z9vGcRPTFL1BTa3P+CHCSIKivwV?=
 =?us-ascii?Q?fRw+atpQb0RlF744xqcLaVX/TNLqtgDJqsqLwhyNXp+Jfr7YbOW8okEcSjRa?=
 =?us-ascii?Q?7Tn7h0FPhKNEnMq+fGXSmkKFvg5hxRjFljTtyIGUxztF1DZi2+5SMr3+hsRz?=
 =?us-ascii?Q?mbfmbhVpt0klTuBwvXDP3eJYaxAv8Fdq4Op+j605aAhHF+21h4B2F1csl0dZ?=
 =?us-ascii?Q?aH2skvdoTn2J/rrbT0MPqANemkyAFdtfm+3AOUYZn51ySflunClc9Bh/r+qF?=
 =?us-ascii?Q?HaDyAAxjxEaeMBdOSCoq+FvdXkr6Bfh0MuVuoRZFQbDy1+Wpuyb2uQ4N+ElZ?=
 =?us-ascii?Q?du01tDK5OK1kvlfK0ZFSTlTxq8tD94fWSu4vlFwXflcVE/R4nnxaSZQTbx3x?=
 =?us-ascii?Q?iJr78TY9Qe4ckmfutWUhp8WKgsdQPP3q+8hnS8FFBvocbv0YiFbtu3nWE1Ex?=
 =?us-ascii?Q?k7FK3aCeODJdDQAGWrKxdIG952s2LeFQUrxgxDR29m5U61tGTDz2fXagsKLA?=
 =?us-ascii?Q?J9wD34QtdqPsFPsuu0wopyMP6/WMPGLeLDDM36H8GyXL2qie9pm6KKUqganR?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f935fa-cbbc-4cc2-b35d-08dd6c3b1879
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 07:52:02.6943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cxCNJtsVVi4pf9m2fI8aV7V4YussjGXg1BD17vINrb441hlofMjfb7P3NgpnmQi0G6ESgdeufz4EdfShBPKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8091
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:

commit: b9fb5bfdb361fd6d945c09c93d351740310a26c7 ("[PATCH v2 5/8] landlock: Always allow signals between threads of the same process")
url: https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/landlock-Move-code-to-ease-future-backports/20250319-003737
patch link: https://lore.kernel.org/all/20250318161443.279194-6-mic@digikod.net/
patch subject: [PATCH v2 5/8] landlock: Always allow signals between threads of the same process

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-005-20250325
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue happens randomly (35 times out of 200 runs as below).
but parent keeps clean.


37897789c51dd898 b9fb5bfdb361fd6d945c09c93d3
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         18%          35:200   dmesg.KASAN:null-ptr-deref_in_range[#-#]
           :200         18%          35:200   dmesg.Kernel_panic-not_syncing:Fatal_exception
           :200         18%          35:200   dmesg.Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
           :200         18%          35:200   dmesg.RIP:hook_file_set_fowner



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503261534.22d970e8-lkp@intel.com


[  354.738531][  T222]
[  355.199494][  T222] [main] 2245715 iterations. [F:1644455 S:601688 HI:11581]
[  355.199514][  T222]
[  355.934630][  T222] [main] 2273938 iterations. [F:1665198 S:609188 HI:11581]
[  355.934650][  T222]
[  356.308897][ T3147] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000151: 0000 [#1] SMP KASAN
[  356.309510][ T3147] KASAN: null-ptr-deref in range [0x0000000000000a88-0x0000000000000a8f]
[  356.309910][ T3147] CPU: 1 UID: 65534 PID: 3147 Comm: trinity-c2 Not tainted 6.14.0-rc5-00005-gb9fb5bfdb361 #1 145c38dc5407add8933da653ccf9cf31d58da93c
[  356.310560][ T3147] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 356.311050][ T3147] RIP: 0010:hook_file_set_fowner (kbuild/src/consumer/include/linux/sched/signal.h:707 (discriminator 9) kbuild/src/consumer/security/landlock/fs.c:1651 (discriminator 9)) 
[ 356.311345][ T3147] Code: 49 8b 7c 24 50 65 4c 8b 25 e7 e4 0c 7e e8 52 63 33 ff 48 ba 00 00 00 00 00 fc ff df 48 8d b8 88 0a 00 00 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 7e 02 00 00 49 8d bc 24 88 0a 00 00 4c 8b a8 88
All code
========
   0:	49 8b 7c 24 50       	mov    0x50(%r12),%rdi
   5:	65 4c 8b 25 e7 e4 0c 	mov    %gs:0x7e0ce4e7(%rip),%r12        # 0x7e0ce4f4
   c:	7e 
   d:	e8 52 63 33 ff       	call   0xffffffffff336364
  12:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  19:	fc ff df 
  1c:	48 8d b8 88 0a 00 00 	lea    0xa88(%rax),%rdi
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
  2a:*	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)		<-- trapping instruction
  2e:	0f 85 7e 02 00 00    	jne    0x2b2
  34:	49 8d bc 24 88 0a 00 	lea    0xa88(%r12),%rdi
  3b:	00 
  3c:	4c                   	rex.WR
  3d:	8b                   	.byte 0x8b
  3e:	a8 88                	test   $0x88,%al

Code starting with the faulting instruction
===========================================
   0:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   4:	0f 85 7e 02 00 00    	jne    0x288
   a:	49 8d bc 24 88 0a 00 	lea    0xa88(%r12),%rdi
  11:	00 
  12:	4c                   	rex.WR
  13:	8b                   	.byte 0x8b
  14:	a8 88                	test   $0x88,%al
[  356.312254][ T3147] RSP: 0018:ffffc9000883fd20 EFLAGS: 00010002
[  356.312556][ T3147] RAX: 0000000000000000 RBX: ffff88816ee4c700 RCX: 0000000000000151
[  356.312933][ T3147] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000a88
[  356.313310][ T3147] RBP: ffffc9000883fd48 R08: 0000000000000000 R09: 0000000000000000
[  356.313687][ T3147] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88814f0c8000
[  356.314063][ T3147] R13: ffff88814f92b700 R14: ffff888161e71450 R15: ffff888161e71408
[  356.314440][ T3147] FS:  00007f3c72136740(0000) GS:ffff8883af000000(0000) knlGS:0000000000000000
[  356.314879][ T3147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  356.315194][ T3147] CR2: 00007f3c708bd000 CR3: 0000000165606000 CR4: 00000000000406f0
[  356.315573][ T3147] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  356.315950][ T3147] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  356.316334][ T3147] Call Trace:
[  356.316498][ T3147]  <TASK>
[ 356.316645][ T3147] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:479) 
[ 356.316859][ T3147] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 356.317066][ T3147] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 
[ 356.317349][ T3147] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:574) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250326/202503261534.22d970e8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


