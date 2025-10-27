Return-Path: <linux-fsdevel+bounces-65659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF72C0BEFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 07:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22D9189B9B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D22D7DF7;
	Mon, 27 Oct 2025 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2l4zjuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14B2BE630;
	Mon, 27 Oct 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545937; cv=fail; b=f9pLfLc081m6A48pcKxr+SCyEgKob+V+j+5IiwxHHsFicdkXS/1X5MNPjhJaypengsO7Xz04f9qAiveXHrZMU/NzBnE/2EtJDJoXRaUGYc4a+kXbiqzPoc9x4+1VFuzUhwTVeDTPGEWNnE/7qJuQOU9qFMu7QpO5x6o6p7U/qp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545937; c=relaxed/simple;
	bh=Y6398dYZ4tn1bVuOG6/edi0SicQngoX51fxsHS0Ia7k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gYzYzPKAlaYUjYyB0bnxUX1vECABai1XFFqMcr2RuFGEOXcRZCoJknL7sn9cXTiZS/T/x2VJdPW9YxOz9/EUiJ1+IUFESmusEEZEJT7FP5dJuTX2x91CdTOFPYGp1F0pRN2PirQIw+rpNJ7VDJXwMfyacmaOBed92UUpunUYpIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2l4zjuy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761545935; x=1793081935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y6398dYZ4tn1bVuOG6/edi0SicQngoX51fxsHS0Ia7k=;
  b=U2l4zjuywd9sD02X2UY0MHnMh4A9v9n+aVkYYVsYR+P3L3av9/DsqgrA
   Hcno0gQyHHnaG/VRzXDkB1Nec11GotzxDW9Wt4MyqoMJiHZ9SEk7J0HM1
   sq/r3Y3nw1tbADKfGQ+KKN0Q+L6QFo4MMMO5fK7ca5ps6DLcUTgACbDw7
   vsgTrskBuchXbYMeyB5QrzDaWcLO7daP9ObFdJ1KVPMAWA/E4WTubSRFa
   Mf8f9fxaR3SfzpYI1SewEwt9Eo+7tNvxxRsudKZhWGcK0tAVWQD3tvJKK
   nvIdq+LWqV+ygoMIukm2jQwlgU4MfArKJN594tnQiwKXpmeahJruSTZkX
   w==;
X-CSE-ConnectionGUID: dpDewHniSMyxeNikuFvTRg==
X-CSE-MsgGUID: i7hL3lMtSD+tUT8rfob7/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63510331"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63510331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 23:18:55 -0700
X-CSE-ConnectionGUID: kG6FmLrpSOytS055N9l/kQ==
X-CSE-MsgGUID: ZOg93znFRqmX/qQSSglkIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="208582866"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 23:18:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 23:18:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 26 Oct 2025 23:18:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 26 Oct 2025 23:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyKZp5CoN64PY4WyFweEhG9g4pUZhfYpY5J3a+LMi2ZN7TDrVYuJS3dh5amsxqXf24MtjkWEDXlzpRX1fXj58uetVTe6/m7tDfzOX09B54wvLgBr0IVqEdE3i7yJ9LyTPCDO2gXlITxynOvgNE4NsPamL7SCP8l65ITFwk44Rc0Aq/oB0ilxi1VfO7VuAdHiXSJdUKH0hKP3InCK8tT0Do4H3vCRFMCiRsTNEMAnx/fc+lqlsjpP+3SVmYSwHEifylnqwjkBZlQtnIkGxv8htm3/MvBWdImKEcMjfiV7Te2UvwDPETtlRWQ5Uq/8xayeis/8VyCMMu8Xb/1HJyWEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzALxf/hsD2gK9pyeIoVtzgtSdhIRFgZrC1hJpLRlF4=;
 b=NMKQO5EWGXDDay/XG4CmP1Bgnz0DUhVNr0G+1Y4KP7b3EYscONu0hhg0UCor4/WEM0rDC8MIhsBbcCcMuReD38yRiuWTgF5jESUSKZay56hMgA9c2S4/QjHL17D06bCMCG6wp4qPa1zXUFWt6m34K04zakn2zx7SWnORL11Bm5VpTvTagUWwh4E3mKujQzRmHKwvtW+X4shMExhjBc4d4Gj7/MF2Reso6SuMSOccKRLkL5ONHUT+GvMmC2i81t0hpA05XXUvFZ6dK6yJxPCcSFWWkS+5PrdVim68zQ3btEIfimt107D9N6WAKB39FiS3J65ShX4mGjgXMK0/QtyS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 06:18:51 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 06:18:51 +0000
Date: Mon, 27 Oct 2025 14:18:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linus:master] [pidfs]  3c17001b21: ltp.ioctl_pidfd05.fail
Message-ID: <202510271348.f0d33753-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: PS2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|DS7PR11MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff6b0c8-fc5a-4eb2-6b38-08de1520b1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nVVL6ZNxA9HRHHOX0njjGMjVNh9qYNjQ7SHKYV/91dW7yzfnxkVkRQRwnN6M?=
 =?us-ascii?Q?N7rLIpNUGGcE2bniHvlGvQ+2xVx8/JLtkDIm8/RibxkKyy/EQOUg5uVzq1vn?=
 =?us-ascii?Q?hoOnTGySE8O8oAJFoIJ/MXwyRK96gH72p0qAorCQIYTgWAKHZ7Weq9MwYx+A?=
 =?us-ascii?Q?JCjId5jQoEAzEXSDFOmnT0G4F/pLRQhiQhOGFRxXvGgPq6xdH8hg/5T2Xqcc?=
 =?us-ascii?Q?gfzmahDT8zlNM6tTTiLRTlWC/TeNJk29bo26vOVnGtgwTKUqYSgFK83WpsN6?=
 =?us-ascii?Q?qvqbOtZuH4OLzZBX5nabfHxnRJG39PktCzl5BFm6zvMymjxrZWtpYDK8zMy9?=
 =?us-ascii?Q?MjpLL31Zt8OhoMagT51rteByhF8N3550/ufRZhAAtZ9ppr7WHD0OOmPeN5WC?=
 =?us-ascii?Q?hylWI3JHBjfeC0Qxh09diBu0+X8uGcVhtlTc6oO3yTKWnHdm4lOr0GjD0Ygg?=
 =?us-ascii?Q?OAx8U3IDPXi+/1WgZ0mZCYSOXVvDh7woOECFlr1mZ+uQ6j8Z1uBKJUqL5vm0?=
 =?us-ascii?Q?ahjzV5wMcXfMhSU4JSidcc61RO/cphNXgQrCBHtq8rjYFZrF5ifmQ6Rm7li9?=
 =?us-ascii?Q?WfwWLnxq43WEK+4T+Dwq4CvC/kENcWQdtP8Qx7ukazIu/w1yuDtjEPrmv0Vs?=
 =?us-ascii?Q?qXtnI7we+VrcTI5s/fyQ4/9fWP/nLdVsNx51ZqhV55fMnL/CC9GrZ87fLCnj?=
 =?us-ascii?Q?/TxbABdW2BxDhQp2jHEKzOyCML07tom3g+bQ2I6NzJEPIeu/nrGSOfHm/hU1?=
 =?us-ascii?Q?FUEDB0CTunEGm/zvw0lbT5inpx6y/ID4ZimbmUcY6hSs6hE9mXZLjMAFqAYJ?=
 =?us-ascii?Q?/oO66q7nAxqetNSgXJWVw/bjf1tyB6fclpRszqz+rVx6Mbja70tfTDwwjCAQ?=
 =?us-ascii?Q?BNYM+llxJDfGRK931kkpBmTgJbI/dkt0fv5aocXkn8QDpemzs5QXTdk2iZxV?=
 =?us-ascii?Q?z9eoxzBI9FpDSGmhPSiblic3eZbqNAFl0tuFam6wmGNDeL74RQ/Ei1r4XAVZ?=
 =?us-ascii?Q?yoNyObuuKrqn1eYN4JQcq6t2yiQmO4CY5hqb5yZeVhZ9akF6lG6KeGJeTef/?=
 =?us-ascii?Q?yfzNOmd/70wHOawI9NDYlOrnC6gUVvwip7CilMdR/i9A1lYrpHk/hvoHMuyN?=
 =?us-ascii?Q?03MfBY+5rT6dJDi51b9HDi9s2PtFx5l3OtHUnE/sGg9KVTs2NrascGSgIun3?=
 =?us-ascii?Q?tezbO730Xxq4BgTG/zDvURaKUAYh2+/mYgljA1VTisO8iGrsWJZUPWKbaQ17?=
 =?us-ascii?Q?0JlrWQBMeZAaN1F35g70lZWke+yrkmIBNe74+2tdqJ5DTawy3AIi8VWr6uMk?=
 =?us-ascii?Q?2ZO8vyBzGzsGjQ+dJv2cwm+Or8o8DZxb6Moj1HFW8JwajYMh5/spb97ZnJu8?=
 =?us-ascii?Q?Wj3KZ0/P5wyKHXDBdmxVDlTPesw1RY5UGA/1TV/BeVOBLly9sE4YYcTqj+Jo?=
 =?us-ascii?Q?njO1JCni8AFHnmYBf7TnsxhPm71SjNDJ5k5CNuUTfJ1hrEimunBkFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HsoU8ieXpZLlJd6GcZdz1jc80bT96mWKl/qk+YhIx8KxvueIpOJEPvMstYnR?=
 =?us-ascii?Q?cLXur/3VxcsTSQ5QLUiXmkWE0T3r8WMaYFqZM233d22rFzWR3HaieKIKhiRs?=
 =?us-ascii?Q?vsH81itFMEVGMEAgXbDFtfwZw1RyxijLlqKscnGQEBzFHKMIemlI4tIDNPA0?=
 =?us-ascii?Q?BSefYshrkoaBnD3b8AQjg1pYfc14ouW+1WQzagMtl0iimsWHxnQcq3xagBav?=
 =?us-ascii?Q?Gcd1vLS6cYBgmYPRR28INZzfymosb0HGS32XK063+5aTPSb106C6ZvNspHPg?=
 =?us-ascii?Q?LyH9MD0IIUTTjP1tOsP+wLAFgwzBj889RUC8c4/l0El13KcPdfkgdqrQe4dM?=
 =?us-ascii?Q?U/czZW/4ulBxtMmK6pEQ9oTw+zqqtdm2Tq49IbgYvb9jlDqFnjITiHtEPp2p?=
 =?us-ascii?Q?QM2t1kLtpOn3xXCKRXKXYy8bCDZo1jMtrBA1116660OJ9eUg+aPk0eHYPmgL?=
 =?us-ascii?Q?hhxWKJ4S66gGsK7zdsOBMJEBOfdjvK4fJHBZ2eAvvds5lRnlEAALNoqCa6Mi?=
 =?us-ascii?Q?zy//1VSuORLVRioX23Y1oDCneE0YPovZtkkVPblz1gsoyOYBe5v2Enx4+ATh?=
 =?us-ascii?Q?l7cFNleyT5kJgeg7S/o8l1dhgTbF0KLW6DdFmJXIxC7YKp9yv7TEiASJaNaK?=
 =?us-ascii?Q?MyWNrV/Lupraot+Ww+I1HyXH4QHoSRF+0pENZHpqm4wn28RBLa12Sxj8DMDZ?=
 =?us-ascii?Q?wmjh2325DE6/JJpe4b4/8YiPPKYfMyVIAdwWxCgcJYQRkN0R6LWWqam0haI6?=
 =?us-ascii?Q?fbQGGlbyHPdIruqYjV5ip/BJjQ3OjZ6ZGTWb+MJtQzNIYYXAveMFzWiIZJDw?=
 =?us-ascii?Q?6VHHITPBn5W6hQWgRNVjyVRP15WQayR8EtcHepIRk5X1xCmM9vRUkyy9e4WT?=
 =?us-ascii?Q?F4pdSVwlw8kNZQKuk4Hn6cmSnerJnZ3F2NBB5Pe7tJUga6n/78zFUGxds3bj?=
 =?us-ascii?Q?Ijs7E+wiIWvbwjdnD483k5CnyeJKQKey7symWbP9t89o/95TYZRvdhlRJwHv?=
 =?us-ascii?Q?reotOK7GOexLgxgaRQIXCq9VROhunTMGR8WvZYTlb1IeU+jV1kD1og3n9CwX?=
 =?us-ascii?Q?0PmzpnTXiE3WseYMQursSROXMBBkjs7/gRkWuCn+6Gm2ZOF88n5/V1fbvBcp?=
 =?us-ascii?Q?/2Q+My6EG/uxDPSJNCpwjdzP0sWRS3lqEb7cFEW0Vq3HFcAAng+EDmZrj+B9?=
 =?us-ascii?Q?I8b2D6hHFs33YR5i7UINAfqbr/EGeCWYOs0xaV6DhMNgRHXUiwgbgmZXRm1o?=
 =?us-ascii?Q?WsszmuRvrhmMqmwAbJpqsaSpZovcgXT6uH/JOx9Bm3PdAVftMi5UnZxVQ8Pg?=
 =?us-ascii?Q?HkCYhFpHro3cUk6dQQAGUKjjhryfKgAusbUDM1mhTocV+KpvhQ6nbXUB+tRN?=
 =?us-ascii?Q?t/OkPW7Ebu1AVGhEkZD+DQSLqmC3n2wiiPBx4wNsSF3ynAEQdAYEYRHm87d0?=
 =?us-ascii?Q?piJDS5P5AIUcu37klB++nQkKcFkzftSupeuiyCfCCQjJS6rvzEipgCUPQbz+?=
 =?us-ascii?Q?K9qmV5XD7vaRqkUPDdsbe2e4/8HV9I2agAY4Od5IQeWvDP/Cy6jA32tkVuQ4?=
 =?us-ascii?Q?aH6OWJXOdzXy0CyY5pddv+VOfT0s7swehgsuHY6zZtuTDzGRakBh84lKep7M?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff6b0c8-fc5a-4eb2-6b38-08de1520b1a7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 06:18:51.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q3P8Q6NHmBR6NBW+j55JdvrU5lGDzJuNnbrogW4FWHv7iBvhDYGZ7U1iuZg8rBrZ2NMdRmGlp8Aql1CVrO+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.ioctl_pidfd05.fail" on:

commit: 3c17001b21b9f168c957ced9384abe969019b609 ("pidfs: validate extensible ioctls")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 566771afc7a81e343da9939f0bd848d3622e2501]
[test failed on linux-next/master 72fb0170ef1f45addf726319c52a0562b6913707]

in testcase: ltp
version: ltp-x86_64-8566228f2-1_20251019
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-06/ioctl_pidfd05



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510271348.f0d33753-lkp@intel.com


Running tests.......
<<<test_start>>>
tag=ioctl_pidfd05 stime=1761396961
cmdline="ioctl_pidfd05"
contacts=""
analysis=exit
<<<test_output>>>
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2021: TINFO: LTP version: 20250930-11-g8566228f2
tst_test.c:2024: TINFO: Tested kernel: 6.17.0-rc1-00001-g3c17001b21b9 #1 SMP PREEMPT_DYNAMIC Sat Oct 25 19:45:26 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 10m 00s
ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)

Summary:
passed   1
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20250930-11-g8566228f2

       ###############################################################

            Done executing testcases.
            LTP Version:  20250930-11-g8566228f2
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251027/202510271348.f0d33753-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


