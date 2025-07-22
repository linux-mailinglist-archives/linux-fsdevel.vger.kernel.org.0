Return-Path: <linux-fsdevel+bounces-55751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C484FB0E5B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1717A6C96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A2286D5D;
	Tue, 22 Jul 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7er6GdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A70B6F06B;
	Tue, 22 Jul 2025 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220657; cv=fail; b=ig4fHYmowprLRfrrOmzx5XJBCIU4JO09jOB23mX1VSb6cvkGxO6LSHXmUc+jTxUAK6BhsQzf3qobzDPIclXnhN7MPulfHz7KTba2TTmvTgeFmHRc8Cgvm7138+DCZdgJbqf0b3O3dd0aWhaKQTwXNzJqHKtGvlJI9k0vB8jZ6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220657; c=relaxed/simple;
	bh=n5r2YEqP4RGszgK6ql8ua5bUYp1zstlx392ApJ6JSBk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=VV9DNOzG49byAW7s+dEB4VS5+Xnvviv0L1bs00sJQs4FdW1X1vKm/DzU+rDJ7/+A33ZcsU/JlJs/a9XyQYYfVsJu5WPyAJqIvRb+F5e6Vkdk8nFR4yZOHYOegr31zUSbxZrRnoMiH4BYf7yz3Bk17XNdLzeWnptj9CWCZeJ6r/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7er6GdK; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753220657; x=1784756657;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=n5r2YEqP4RGszgK6ql8ua5bUYp1zstlx392ApJ6JSBk=;
  b=i7er6GdKFJSnKHTXqSWvGvjzn0qeF9RX71SpYIkc7fW7D73X0EJSVUAJ
   oXj+ji1qERamTRDJvjumD/4z9Il3bRSIOKjfw/IHFNtduTYyC+eJRWizU
   bcTl8BlWNkR5Hnsk/6tAMfCloqbAEEMW5VP/tXBJkfqLTwRvn4A95YmPt
   By0IQnwVoE4jcnVqHFqCQrGbDENUKmQJkqdLs64dASak6nF2NKZxrZarW
   zDqqAkb30wBsNiOLDEFDxvOQCNNVHBNkgYztn3smoO5lDb5+e0eyEbV1/
   qwhsCyns8ss2DJ76aPxv1+mX9yzfG7qAwtfEzp4rAVCFE0QBBsmXsPXfO
   A==;
X-CSE-ConnectionGUID: /0vM805TStSJvhh/NiU1Vw==
X-CSE-MsgGUID: FeJ5viM+SbGOpJ3tqLt0uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55193139"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55193139"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:44:14 -0700
X-CSE-ConnectionGUID: TrgeZHM3TAaliTyshRDlqw==
X-CSE-MsgGUID: 6/W3NqbKRMK04unQoRK9iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158559802"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:44:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:44:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 14:44:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRuqHVI+2yl9unIFiTEM/XpsFWUIqQtD8LTB1iaxY1Po0/p3GV3NnDX10AIJ0rRhDlW1ybFxYQwWYd5lBRQTWv0kvlbx+Nns4+ABGaxZZZy0UtFU+mvABm4FUynT6K2R9XFUwleQHhf+IvLzZ7QQrHjam6JGxD//IszCTYCnMNwYRAnqWC4QkMprds9E05H9HuU0F/XiDQyyBHJQxKHdZ/89ba8yCVUWs/EOQYcgmWSOk6KGZokXPKoJncqPjNgV76hPV8hoXXMTV+hY4Mbu0iNEmkOzqUgHYKhJ958oqwWZ5aOl3OxRtyVHUVSdJ9J2jmc3A5P6hiGT2jcc6zE6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHeLQbTa8Ij0I5B/3C1AS3Wzv8gKwRX1v1gNqeDGiNk=;
 b=ZmCSk8d9wfM5TiBGbdoFPitOaYQFl3X+sCcRRiwBDGRYpPQk0tZvFmm/7V94Sj///7y5BrUaBbeSJvsdOabmsaQ2lRpdgSlShdWMOcJWFt/44SmPYXfd8fOIpHUxY65IL6rw2lwhGPodGAYeOHRhlJcWS9kjiE91d+HnJbjKH9pmvFxKqHkmIdTptYwRLAa07uZdCmBuiIaHfT5zZAycAKx8izEmutbquJJ+YunA91kAo6Ttgph2egBDBvDX+vi8gP7DLXZetxi6xPjWvcZN+nsT9TLLI0hdLRIBdmRhMcW6d06REVwWHl2hIT9EgTzBoaQIZnU70bA+N1TtGJHs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 21:44:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 21:44:09 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 22 Jul 2025 14:44:07 -0700
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, Zhijian Li <lizhijian@fujitsu.com>
Message-ID: <68800627676e1_137e6b100fd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250715180407.47426-3-Smita.KoralahalliChannabasappa@amd.com>
References: <20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250715180407.47426-3-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v5 2/7] cxl/core: Rename suspend.c to probe_state.c and
 remove CONFIG_CXL_SUSPEND
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d077b40-5f26-4986-1e6c-08ddc968e3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2RsODZiaVNZTGt6eHM0M1hVejZQQmh1TVJ0SzVkUWV3Ukx6eitXMlcwQnpk?=
 =?utf-8?B?K1Y1TFZtRGdoNlc4NmRDbkdyeS9XREY4cHQxNk42VVc5VG81UEdFdzR2eUpS?=
 =?utf-8?B?NlZVcnlxOUtWa0NxM2pWbXF2bFVhdjVoRmNwSEQwSHpaWFBsMlJ5WTdtOHlm?=
 =?utf-8?B?YjhIVFd4d0JqSlk5K250VHFWdjNWWUNsMCtmTkw1Qnc4L040elR6MFZLc0Ns?=
 =?utf-8?B?aXY1bGNpdHhaNDROTi9CQnlDNnVpdng1dFhCdUlxcThRMUUxYUVZZ3h3dG01?=
 =?utf-8?B?b2hCOHRWSkdVWnA2Ti80R3hmMWt2bThBU1BCZ0lSTVF3dnJ5a1BlSThPei8y?=
 =?utf-8?B?ZTEvTFJJaTcreEVkdGFXa3NSendjOEpheHhTQm5DZ0dpTEtEVEpKZ29QR0Va?=
 =?utf-8?B?LzFZSzJISVRBWjRCYWVaVmlXSVZWZU5LZSs2RnJ6cCtNeFB4QkxLVjl3eHAy?=
 =?utf-8?B?bTFGcCtWWHBDVURIWlVCMmFreStkWGJsbTB6STBmY0ZZTnp4NGREakU0TTBn?=
 =?utf-8?B?RWdJcGc4TkNiTy9Jci9CVGt4anQ2bUZaUXkzeHNiOEtzajlTR1JyNUtQeWlZ?=
 =?utf-8?B?YkpHN3c4UHh6d1VNSngrUUcrM3ZSMHVKVHlRQVVBMlZ0MGhTdEJzK2ZYQkNB?=
 =?utf-8?B?Q0F6RmFlakQ3VjdSQ2lGTDlVSjFqcTdmVmkraTF5a3RsamFKR1c1MHFKTDhV?=
 =?utf-8?B?V3piWW9TRWxzQ3RIdXdwOHIwT01vM09sZ0pjWnBCQ2xEMUMyVTdqdWZzSTZR?=
 =?utf-8?B?Z0Q1S3NwMjBoUWxWSWF2dWQwTUh2OHJaVUVJQzY5dUV5RHRMTGZ6OFErL21D?=
 =?utf-8?B?aTlST0pLM043eTQ0c2VXRW5qb2RmUkhpeE15bEdhQXlNSDdJNjQ0ZVNmZUVq?=
 =?utf-8?B?ZGp0VW51WGpPdVYwSFBZYzRWb0lUTnBYOWZuZWVKMFRKQ3FhaS81RWJPOVo5?=
 =?utf-8?B?Tjd1cTZMeXRmczFXbkkxSGJSZkgwRDZ4ZkNpbExydm5UZ2R4TkZ1TmhSdlk0?=
 =?utf-8?B?ZXhDRGZOWXZZajZSUU12ZkhBWnhadzlZTy9Fa0czYSt5cGJCK09PSlNmdldI?=
 =?utf-8?B?MzJYYlI3akZGZm9SMXZzNFFLaWVFeVpxSTB3MWVZWlNFV09hZGR4MDNFK3Zs?=
 =?utf-8?B?RzBHcW1kNVFSbkFJRytiR3FJYTlPd2Vybk44bFZqYTdmWmpWb2lLUFh4ZHkz?=
 =?utf-8?B?cmJxS1NOWDFLbCs2SEoyY0tmaStEZU5oR0JHSDM4aDlXUmY2RGNCZzBBbVg4?=
 =?utf-8?B?NGxSUTF6aVlmQ3pxcWdlUCt5ZTJ3NDAvQmdBT1RWVUFUY2R5M3puVCtLWEVL?=
 =?utf-8?B?MU1YeFhtRWJyR21peThOZkJRNjBjWlJ2c3FkM2t2ekpMMWFOamREdWFoMlEr?=
 =?utf-8?B?V0lXWlU1UXdvY25qUzEyeWdzNTVNUkxXNGdRb0xZSklWaE9PWGlBRUhVVmNm?=
 =?utf-8?B?TzNhQXhtUzFLMWpHMEpPNml6Rm5wYUVkL0xna014eHFQRkFEZndja3k0WE9j?=
 =?utf-8?B?NlpWWXRZTzc5Y0lheG1pazJ3am5sMDkxSk1ITjc5SUxDT3NhanNQd1F2cHBB?=
 =?utf-8?B?cHB4T1BsTmtMaHNZSmpZY0R4VVZGTGE3TVRlVDY0NG80TEJ4amFOV1VtK05E?=
 =?utf-8?B?bHV5MmQzaVRPN1VOdklyU215U0hhVDJEK0lxb05JRWpRVmEyZFNJSzFQb0wy?=
 =?utf-8?B?WVIreFBaMkJwMW1iWU44R005RCs3bjVEVmlDdU4xZ1EvTFk0OFVWaVY3Z0tP?=
 =?utf-8?B?M1lxU3hiMERzOEUzMjRkNjFzanBGbGl1Z0tMT1ZWUUZwejZHcGlEOERkclNs?=
 =?utf-8?B?VGFneEVoRHcwZDZUTmlUSXlZQkU2czJNR2xTWGhpYk5UNVg1Vk95KzNjVURV?=
 =?utf-8?B?RmsyVmwzdXo5OTVMcTVIcVV3SGJCdVdCUFZYL3huaUxadFVjc1YvTE1CQ0p3?=
 =?utf-8?Q?JCTCpt8r+dY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NngxY0xsYXFOc20xT1lkVUVxczZOSkNQU1MwYzAxcUFicW9tNTUwV05aS2lL?=
 =?utf-8?B?UU5kR2E1V2duVWRmK1hVc0RXWWxiM3FnNHN0U2FvWGNEZ2VXK2VyYlNOUFgx?=
 =?utf-8?B?UHBwTnVDQWc0V1huUGliVXJtS2V3bzNuaGFsMFczVzdKTkxoQUxvK2JWWCtQ?=
 =?utf-8?B?UHpvQXQ2OW5VYTlqbTgwVHMyRSs1aXJ2OC83Uk5qNmZmcW5ycGJlcEwyZUtI?=
 =?utf-8?B?WGtNSGxCdXZvNDE0UW5lOUdyOXNxa1JSMlF2VVZtbEY0dGh0RHByQUZyeTV6?=
 =?utf-8?B?Y0tpU1JneElYaGFQWlN4WEU5MHBuakRjeTZ3akM2alhHMUpZMXp6dnpTQU85?=
 =?utf-8?B?ZlZZR0ZDVDVCY1NZRzNTUWY2VGxmTUQwdXJOTzl6RldZM2ZLd1o2dzRxU2I5?=
 =?utf-8?B?dDJ2cHV4UkxHMnlOcE90dTZJU2dTUXRKVU9hcVhqNDk2dmpLaStuQmlXWFRG?=
 =?utf-8?B?cHhGUW1NZUFuNWlkMGRHZkJRdmVub3R5aERETU1QbnhNU1o3SUVrb0NvaStT?=
 =?utf-8?B?bHMxMUFuMlhrclY1bldVRXhBUTRYUG1NeWFMOW12WlVPcmJxSjU5czg4SGhQ?=
 =?utf-8?B?ZHF4R2RKdnFDN210UkZ5emQzK3l1aVFybDVhQ2Z3Q0ZZNVVIZkZJRzhaWS9J?=
 =?utf-8?B?dzF5UjYxcWZLRlcwck9OdWRFZXoyR012L1liZ0s2TEVLRnl0Q05EYitJVUt2?=
 =?utf-8?B?WlZqU043OFZQbEdReGF2V1RwUHcrd0s3bmsyTTdndlM0MDQyUXdhL3hqUkJW?=
 =?utf-8?B?TUpPdDIySXFVZHFHQVFoZW1UYjY5SjkxMEtseWRRSS9NWjVTMk13ZDNoVy93?=
 =?utf-8?B?TVZDMjF5UDhmWDRzdXZhVGlkVHorSWlQVEpMZDVMU1hTc01nUVpiSUFFTERH?=
 =?utf-8?B?SEF4Q0Y4N3Z1c3owM3dGODdra1lGU0xqTlk4RlhhWVBncml2c1A5OFlTcnJV?=
 =?utf-8?B?MkxiSDQ0c1U0cnRHWlg4UmhTd213WlZadHd4cDFNRnB1TU9nQTBYN0ozMHdX?=
 =?utf-8?B?Q2JlM0ttNFdUVWJWTDRNTlNhZnladUdCcng1UythZUpzYVRXcG5iYkQyR1Z2?=
 =?utf-8?B?QzYxaTJuRnVZSzVWYjg2Smlib2x1Umg2MmZ4M2pVeHdhR1RhTWdwcHZpN0xK?=
 =?utf-8?B?elcydkJ2ZmRHSFY5cWduVC9nSDY2UjlkRUJUaGRHQXZOZi9wOUV1bEdWa2s1?=
 =?utf-8?B?R0RLWklsNlYxSEZRejlRdmYyOHNxR0UyY0lhMUFLRGJnRlpNMTFVOUM1Z3V1?=
 =?utf-8?B?YloyZGxhU2MxRHZ5aGdTd29CbW1MT1pldUlBQThHdFU5bmQ3Yks5TmhsaXZi?=
 =?utf-8?B?VlM4cXMzK3VVdzdvWVBKTWpJdVpUOHlUYzJnZUV1b2lsaUd4RW1OdDNscHhn?=
 =?utf-8?B?TjdmVkxzVnVEQWsxSWlYWlY3NzJXbjNhaGhPM3UxMC9CTmYvSWRXcGRBUDdl?=
 =?utf-8?B?VFlmN3h5d0FGYWNjK0ZHT1Bpc1lockZKRmhGNDdIQjc2NExGbnpjTE1wcDhM?=
 =?utf-8?B?a2NUUWlpWjhDNFJZTHFUL1BQY29NRmMrcHVqdXFVeGxrNFpBVFJiNU5WMmFT?=
 =?utf-8?B?ZHgwbGRDNVZabWxuVW1qL2tPN1VhSkZwTzNrSEF5NWxUNUxqYlFWNlF6WGxs?=
 =?utf-8?B?VXpsOExQMldvYUNydTNzZEtYQlpUS3lsTzIwVVZCZEdqTXhRRU5xWGJLckVJ?=
 =?utf-8?B?ckpCeHJYYTRxUk5iYzFTRjhmNzQ1NTN4UFJVUGNuaGFzT2MwSGNiM2h5ZmFi?=
 =?utf-8?B?VmF4UUJQUS9ZMGdPSmFtQ29FRFRiSXpKeGR3ekgrdkhmVjNqd3VES3Z5bmlD?=
 =?utf-8?B?ODBEdEFzSEVLckNERGNub2xKZUkxUnV2VVpET01MOEJ0UWhJaXJRbmZWT1NW?=
 =?utf-8?B?eFkvcDYyVTJBWkJwRVVMSVh2a0J0RldaTGRDRE83bjBEN2xkUnVaTkNZZ0Zw?=
 =?utf-8?B?MzQ4bHA0bThiNnpUSzlTaE5MVHBseHFHU1Mza0h6ZFpRV0pnU000RlpHblBN?=
 =?utf-8?B?N3dvQTdIWFJCR3pvQUk2YjU0d1JWUlNrT1FMbGNlZFF2dXpyaWtwUTJ2dnlV?=
 =?utf-8?B?RUF4blZHMWZHQTMxZGZuaW5Jd0piVmtOUyt0S1VFa09mSmV4ZHRaWXZvbHNs?=
 =?utf-8?B?VGFMRXEvZDh0VG02U1dnaTNacEVITStiUG9reGxBZm5hcTFPZFdxbm9XNDF4?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d077b40-5f26-4986-1e6c-08ddc968e3d1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:44:09.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfRJhAB2cwk4ysXy63VIIWVaB5X4blStmY1rzsRST9oAbUQQMCJ9FAfLP2Ee8IETWKqPixXwC2cUyibvvAR106NpFWlSyn4ADF3dewO+iWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> The cxl_mem_active_inc()/dec() and cxl_mem_active() helpers were initially
> introduced to coordinate suspend/resume behavior. However, upcoming
> changes will reuse these helpers to track cxl_mem_probe() activity during
> SOFT RESERVED region handling.
> 
> To reflect this broader purpose, rename suspend.c to probe_state.c and
> remove CONFIG_CXL_SUSPEND Kconfig option. These helpers are now always
> built into the CXL core subsystem.
> 
> This ensures drivers like cxl_acpi to coordinate with cxl_mem for
> region setup and hotplug handling.

I struggle to see how blocking suspend in the presence of CXL memory has
anything to do with soft-reserve handling? Maybe the story is in a
follow-on patch.

