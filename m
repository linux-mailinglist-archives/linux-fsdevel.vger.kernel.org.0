Return-Path: <linux-fsdevel+bounces-25405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A2894B952
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77873B22122
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795EF189BAA;
	Thu,  8 Aug 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqMnGWyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C4188003;
	Thu,  8 Aug 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107123; cv=fail; b=AIez3ovOe5uZDzYjAPHzbBI+B5lzgqUvYeOFA8eqWrYXHZNaaNXr4xF3QqaiPpiDGkzyBetARE5CEbGmkHRplwgs8MoZ7WianUFcWzHrqXcITlvrTkO6A9M67Fi3GcFkOBL/QBWehwuoKqSGyRo+uZmefEKXgogKGVe5dzfHepk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107123; c=relaxed/simple;
	bh=2vgg6JiwpJQK6oS/K/fFxQE475nSl1niODqi0yO65JE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HaL9u3gVC6vC2DnPR0paFOtCQilqwRz5gERrqIwRXeEZklwtfGBuq58qfcZJ8rsFRBBHHNYplnkytlafUSMnEoayAu7TOifarco5tgy4wtIvJ7YdwZYmOrGfSTHQNIreU55HWMcUV3POnD9BrRZnlBYE/qDaXgG0eU3z2gAZ+cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqMnGWyA; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723107122; x=1754643122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2vgg6JiwpJQK6oS/K/fFxQE475nSl1niODqi0yO65JE=;
  b=iqMnGWyAazmm5aZGNKvCwZbIho6+KdDFdsOYsfxiUZ6+jEIO6Uy2M3d+
   UvofJw94hBSYzUm+X3x3Zu2Qfk+pGT1+Gj4vxEwIGYbH/dvwccmjKs1Kq
   vreXgMxOre7ybcoVq2bUmWvk+kM2IstiTMHT86CYgoMPEbcs7fpMfx54T
   HxjHgkzrc/BhuFDUyFQgTrBfiDZZGzxfkCtrLPBiWEhMvcuxkJd4szov9
   qgVCyx29LSPUdVQHPSAw8RuTgsZbHxw7Qpdy5zZB8bgMDvtue2K4tS1Z2
   q0dKZfWEkEj59YJoSaiLp7q7NSzD0cJgs8CIfKKmm2q67JctnrBHrpj2E
   Q==;
X-CSE-ConnectionGUID: +cKOz8PPQpuidfS+yMe2uw==
X-CSE-MsgGUID: cXVsKqj7Sy2MoJ6bL11I6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21190797"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21190797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:52:02 -0700
X-CSE-ConnectionGUID: Gevjymg3Rzq5/yuxl39VPg==
X-CSE-MsgGUID: v/l7dTyPSZuLu/wMLxEnEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="62099714"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 01:52:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 01:52:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 01:52:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 01:52:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 01:52:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgBPuTyhgRzX9wpLDxOhVjiiS2/TlDQwCBGW5t6Ihs+WfxA6Ih2EmRgSjQmnzf5dIO4PoPchxJH7NLwzaB6O+aunLKhg/j334I8ZSTEa8HiTXrixEn05koODnFR2XAaZZVOQjPNbFKZ/66vKalf++sbLQ95tiGiDFOKo/zDLyhzCmR6VqcRzEN6/ngw8ofsNVWmmWERSpDrvbK5hTsIledMhNrEJOQWiACELgg+XoMun1oChyy5AuaHS80e/wZ9eRizHYQG6rk4voCpnJwSselpQau0BsgD1thCU56X9AFK0NlU5jJgiDMBRM3kpVyhV5qw7ogypvKEHFQrx9qANRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5LlQFqKa7OvNdeu+tdPh+a8UJvqWTdoxXYDlMCVXjo=;
 b=TnPrnh1ryzNn+7wUi0trrMyk5Nn4aNBN8RKRmpu5woImRhK8xRyoMxXZtoqQDCh3gtGCXtuXqLHHBmO2P6AkNwPM2eNFBTqi/M2eRrenC10CqBr80Jox1Yvzs7lVDabF5UFfd7eWA692g9PXkEgipq6Tc8tkTjYlECToM68hxAoJ+kuLn/ctXmM0FRfe40RJqh76saPoKVjY5FWUEU4F63o/BcFEFf4ZlzII9hVXvktaBEvR4MxscqfPXE2dzIfdSw12R3gm4Q8GpF0GDy1Io60Su6bqjNr+58rMpO2D3QV2r6ZQ0Y7IvY/aGDb2GgwC5PGQSow6WkVZiqSqlvB2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7884.namprd11.prod.outlook.com (2603:10b6:208:3dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 08:51:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 08:51:58 +0000
Date: Thu, 8 Aug 2024 16:51:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Howells <dhowells@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jeff Layton
	<jlayton@kernel.org>, <v9fs@lists.linux.dev>,
	<linux-afs@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <oliver.sang@intel.com>
Subject: [dhowells-fs:netfs-writeback] [netfs]  383151c58c:
 xfstests.generic.465.fail
Message-ID: <202408081612.9d5c488b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c6d196-5f4f-4478-adf3-08dcb7875c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vUm3ba6yvGk1Z86z54XW1jTkQE+HMPV7tdniZht4Lmo6Z83/gvW1DYObxxPA?=
 =?us-ascii?Q?x8/eLiGesA3BlBA+FWEyCXFI1PfVv1sl45CpsD90Fwpt8KH9uOMlRaNqoJhz?=
 =?us-ascii?Q?fwUdKef8CEHO6+pDRdZzPo0T6Yy6ZQrh1mluAfNqNUMWGmqrCus+kOfoc23O?=
 =?us-ascii?Q?KtuCgWZd1zpf7sUTOP4BzD2yWbddgdk+pCyaK2BPkeBYdo3nzWr8QYiE53ne?=
 =?us-ascii?Q?ekJX2dnrTGxxJRMByYiWLoGfgXpkvM0o28BznekYvncwklncDbdB3GasMGwG?=
 =?us-ascii?Q?LiGUxXQNN93jjq3zK950jql70AvlpHnr0iI60TJfmv+OPAHBCEsdx4vctmUJ?=
 =?us-ascii?Q?3J2Mgbwqjz1ywmWId2DSvsvobPmqFUN4oAtr/tgH54TbsVthtpgXtG6r2APM?=
 =?us-ascii?Q?fBI8yTnIhmbXV2W2LMc0LQjbp7iq40ZBr9tt5T4qpkVzKzbgF09R6L38GyIo?=
 =?us-ascii?Q?b0d731XR50tNfTBkCIuIvIaEuORwf5BZ5VABXjXuCKEU17D0yFoIbtUSSX7L?=
 =?us-ascii?Q?FMT6MLlOM5VgTFptl9QjjE/s/cQr8tqJsmipTV9/B0dZr4l9zVDyXb7D2GRy?=
 =?us-ascii?Q?VOSnE1gMVIeh486o9K6UPqzLRg2Tn7nxEfMbwFX3Xc1u/rxpk9A6mD9WCzi5?=
 =?us-ascii?Q?3CxxuU2OYcfOAkP+YGiwkfVr8W0ycxSyotGGnmyrHAvi0WmfrxA7iOWF962m?=
 =?us-ascii?Q?8klh08645CNChEMA48g0ow9EQ951twL9NbuVrqxIWZk/xjzKIeMRw9rd7WR2?=
 =?us-ascii?Q?4DUJNywOJbIHjzG8UetbnarZsOmpnq79+PpNwMJTfI0eUKg9qNZPJjxdjAmD?=
 =?us-ascii?Q?uatvyxE673EdxzKK7BQIcURuDVOvXKcXp++g5+ABzoJtA+d/lIYtxx2v1Jt6?=
 =?us-ascii?Q?ER4gmkNS7hCXpFIYRaSPJKruaRanR7thqQQZTZ9oYOQM1LNuTkL89YCNvTPs?=
 =?us-ascii?Q?ooic3HbWO68Bm8ExGKiWJ54oDRKWGrkubqDhRYPV2xww0C5W7k7ci5oGgO8n?=
 =?us-ascii?Q?q5oBXGILTmtik2ZmXhxPydFWdFtPBpqFXSvsJwLl+1H1AhNUbpPGMNDAtSMl?=
 =?us-ascii?Q?CQ+jG0sX4Wx0APH8swtKGbQSqI3nBIkCb2ZWR/YT+9Of+JFco3mp0rlBJ8J6?=
 =?us-ascii?Q?Jlviei4xFZcJjiUCEIJSm4AG659aWoTzStM3NfEVDoN9NDowuI4isvgwmJVT?=
 =?us-ascii?Q?MOfUUyDi0eRmtK4eKkpI/fxHlvnqJDC3hXsLjgodPXyRWvuywHob5D5TPhnP?=
 =?us-ascii?Q?JBWQp4oVcc3ExH+BE7D9+YBsytBVZgOt8QwXiQnT74F6Kw0K11cIjQVqjlPo?=
 =?us-ascii?Q?biM6XG/aNDgMtw//qPPNrq2C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2AJLbuNS1Lw1cmw1JT3LiUKwoGqNhHVFtW5RO9sM5G3hILB1timzvRgUFNp?=
 =?us-ascii?Q?3VYK3JpLAoEPeKAul24JVHICZWFqHHYsLjzV5zPy4RZCy6rpWOZJGx+eajiS?=
 =?us-ascii?Q?YZaOJFqx1AaaZTYytUrmmkxKUoPhBogXY8x3bAQIarUonjYlCa1Znj0STgm1?=
 =?us-ascii?Q?aompctb1Ez5Q7GmY8Jzv7+Hv0pzNRJgjbd6TdV2j1+CNfMwf8tYng1bGv/QM?=
 =?us-ascii?Q?HkAr8ZUMC+fInxi645iovFWubhTYIeRzsYSiFMlA/fWW6PROcjlZCI3YjcKu?=
 =?us-ascii?Q?md2da+4+joKJ78bsibZRcfsOxENSHDMBExdS4KA9pjfKfeQ1i2Bh1N1D3muN?=
 =?us-ascii?Q?jFUGw1OuZyJ/e4RWtEY1gwRM3ymYcAEvvQqdw+jzqVMRsU0LgX9y0ve1TY+f?=
 =?us-ascii?Q?D7IVDOb2RH9xDG/xk2wEptdqruJOxuve/YiSw2OPFmGLI1Qztt2w2dORdgCR?=
 =?us-ascii?Q?qC2PeTXiZbJgzddVSy662q7NcBW2nH9zZjuuisNjvMv3G1POYSOU3s6mEfKC?=
 =?us-ascii?Q?3uS9vO12boXLgpwXxUd2CXfrcXYLFQpFaTfOGDMGP20SzVpkSQniiDaQaDpn?=
 =?us-ascii?Q?2NJuatO35hQm2yURl8Py5L0UccEHzLr7jaqJJUvK5NG4mrfrl5NolgGR2SRp?=
 =?us-ascii?Q?S7NZ+TifmomkKwGY8KeMlPC9CICsaf4LVW13ltUUKoTZw1klh7OSAbNm9tSX?=
 =?us-ascii?Q?UqA8IR2LcwVaKVpjWQ3vw9/HPxvfq6rDnhTrEl1wr1nhTsGpGpokHX81dE77?=
 =?us-ascii?Q?F8MDJ8jGjo+ec5HYHle11CGB07v7Z5iVMn/dIMoYtUE6GGRD6indV95kpw3C?=
 =?us-ascii?Q?f5wXYysCHDkq9PKr3lXsVXUCrno7ZDUYtpGdjuo0HCea5ejQ9dWatSeV4s4I?=
 =?us-ascii?Q?ZNYaaGOnRYMdIAE/4KRBRe4ohb80azBwNNvIawMGdZb+V0YZwZlBqy4Tie50?=
 =?us-ascii?Q?N8UKy+s3FtTp7rIZfndzD4Pd6Bl7BCvjfKBRgwgp0yoaDTOmBg0YYCUktXsR?=
 =?us-ascii?Q?65sKCTA/IFFPNlyc2i4Fw9kxCm1I7VgyUvd3ok239HEr1l5E5Mu/t2qWHenY?=
 =?us-ascii?Q?mce264smo8PY7t7WdcQXi2YM/4T5YGf0rg0UOv49qiiN4oaPVvow2bgSG+zZ?=
 =?us-ascii?Q?GHfImJnBwIl6AJ4B7jO3Z9YYfH7+zcIwD4ZKh6TALnCmve+AJyAJQpKecZ2b?=
 =?us-ascii?Q?rG/lKo01HuAcOo4m++1OE0ZJ08VJRnd5TiGiBHnvAbVZjXRXTKvquFALliM2?=
 =?us-ascii?Q?TwXak9QAMkGC4rUvMCn7K3wMMzUmKzavrZeA9Tum6xktMhkBw4no9HQDNg+W?=
 =?us-ascii?Q?tjxEDNZunpVPEgTRvvs0C2nfijRH2yZwD9qKNa7CklJ9ImpAb8DXYgmPXH3Y?=
 =?us-ascii?Q?33b5GCTCx0zRBU51M/7aVK+YcxM5GrtfADR7cBlPm/aJiWWhgL4yP0Q/fKaW?=
 =?us-ascii?Q?R53HMdR1K6kxwR68/IL1lN1w62uV6/GXozv2l73TVS21ADzUCjGnw2sY9hQM?=
 =?us-ascii?Q?ushWdibwFz4zdj7gEO5Qkkc0Lkf2l+myVPEj+ziQMGIxCAJoCzYcjYZnDfb4?=
 =?us-ascii?Q?4g/7M1euASiPFD69/BK1xCGHHrp3DDnozPk1ci4leTVnKfdAZ/zM/76DuGxj?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c6d196-5f4f-4478-adf3-08dcb7875c6a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 08:51:57.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tne7AB9J9GsXYi5W6XVqncYMphmZ4T9QOXIKWOd1u6/LvdnkQ8oX7jXSg3MpA0K3fplipt4LxSEMaHM1KxejfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7884
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.465.fail" on:

commit: 383151c58c85c735c45970bf3cde7f6fc96f958d ("netfs: Speed up buffered reading")
https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git netfs-writeback

in testcase: xfstests
version: xfstests-x86_64-b3b32377-1_20240729
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-465



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408081612.9d5c488b-oliver.sang@intel.com

2024-08-02 13:50:42 mount /dev/sda1 /fs/sda1
2024-08-02 13:50:43 mkdir -p /smbv2//cifs/sda1
2024-08-02 13:50:43 export FSTYP=cifs
2024-08-02 13:50:43 export TEST_DEV=//localhost/fs/sda1
2024-08-02 13:50:43 export TEST_DIR=/smbv2//cifs/sda1
2024-08-02 13:50:43 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=2.0,mfsymlinks,actimeo=0
2024-08-02 13:50:43 echo generic/465
2024-08-02 13:50:43 ./check -E tests/cifs/exclude.incompatible-smb2.txt -E tests/cifs/exclude.very-slow.txt generic/465
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.11.0-rc1-00022-g383151c58c85 #1 SMP PREEMPT_DYNAMIC Fri Aug  2 18:33:48 CST 2024

generic/465       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/465.out.bad)
    --- tests/generic/465.out	2024-07-29 17:28:39.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/465.out.bad	2024-08-02 13:51:40.918295861 +0000
    @@ -1,3 +1,260 @@
     QA output created by 465
     non-aio dio test
    +read file: No data available
    +read file: No data available
    +read file: No data available
    +read file: No data available
    +read file: No data available
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/465.out /lkp/benchmarks/xfstests/results//generic/465.out.bad'  to see the entire diff)
Ran: generic/465
Failures: generic/465
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240808/202408081612.9d5c488b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


