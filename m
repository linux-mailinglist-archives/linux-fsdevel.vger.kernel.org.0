Return-Path: <linux-fsdevel+bounces-75807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKOcLJl+emld7AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:24:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 581CCA9182
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B10B23006148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020B36EAB7;
	Wed, 28 Jan 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEpNP4Aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72E2882B4;
	Wed, 28 Jan 2026 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635478; cv=fail; b=llqmvdGhmR2CgU0fqUFcTQKGyHlH0qU0Xetd5tmhEyes2iAPIHJu59x8q3QH12osfYOH56Y4CZFesztSrWuwqLltdrSnBuwBL7Q6GuoC/NVwCDsAMC5G2mUOJwQEk0R2KRZs/Yv+xIJAdXaoiUac/U4NmN2ZpunvWaNKlTGbiEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635478; c=relaxed/simple;
	bh=zdynDpIAglDyudMez4Ljuwj1qP6htXIg5V4y8eMTorI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CIja8Hx1FEAvF2cftH1W7zHygYR1N38iSYKVe+EfHI/dWPVIVdmhkcKJYE/BcUMA5ICy65c9GmZCEkm7Xaulasg3ncAIACvbqiCGX/hrGtG5U6daV4l+14Xo6gIkK4WOBF8/F0jBe5X3rAHAISKRBndwyXE2geKVGTBHnxBi0OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEpNP4Aq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769635477; x=1801171477;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zdynDpIAglDyudMez4Ljuwj1qP6htXIg5V4y8eMTorI=;
  b=lEpNP4AqKBVIM3FdkXwlFscB3t/FilY/7+zHVnWfPY/iYCSDhjCrUvnv
   GGOlS/KWsHrYT7dztCffDvT/p6lqjHE9UEM3iC4HKT9FIFtmB9halY6vy
   8LIr0V4DbkTHuMwKIkRifP6+FCxsH5JUJUE/dczJWLzfhkzXZBLby0Lqq
   RVwKYj2+uMbTBwJrOFqLwpQ5XBfGyjaEG43nYk2bxv9EqLBDPmIZokAux
   HOz0s4CxhGq++q0sTWKk72MBouUf575ljWXUddpvQ53f9xlK7rm3Pmh7F
   S0hfzCURYYxvJC74fQm1ZUE/DKivcSjmcM0PQ2Hd/MSZzeGHRZpNxfmfc
   w==;
X-CSE-ConnectionGUID: jC/yvbdVQDybLefkys7oVQ==
X-CSE-MsgGUID: SGCw+guITTOTlYVBUHv7XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74722937"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="74722937"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:24:36 -0800
X-CSE-ConnectionGUID: Uk0cBhKnSJOGvavWrZYYPA==
X-CSE-MsgGUID: LUDdVb+pS2qJcAphrRMr8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212885346"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 13:24:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:24:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 13:24:34 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 13:24:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdj5Vaai03iR5I3H4FnpcgiI4cqK/ffqYuCKszwkVZv3NDxqv93/ZsGamfGD1SVqk4b6/JOpQAmX5y3Nz/7sR/LrjjqIOFtFDPnmfk/aRlsK0QQ3UiXufz4puxj9y7PBuKpcHFCInSp2ijZONmj5bZlB3EMX1TP77HdtEPYJ8Pb90CFmFHXn9zknNKOcT/Ftx7dNHW/c35o4+bwMBqFRSwMp9+K3XySC6wHv238fu+5LVQXAG5Wr1Zbky9jcJhKfN4Ujtx/gTBxOiXi6WT5u/iyZjKpMQ+9yizT8yHZcHrOKmvgySzUOlXLKueyGi1qjsZ3rO3KxysoefCIXpOeK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku/k8+/LCqKeocjn20XgyYZqsuKWdlqWZUXg6qYhKaU=;
 b=m/WSxSR7U3HeHL0sJ3cni48hIvlpzCBdSPQM8mOxGOEMF21ACbVdKPGzw2cZdw49EFOasmpmekFuw4KsgKsF7dD19S+pDhnq02/NG8Y+4F1azL3Ry9cUi6n6wj0GpXe5YBcocfsxtqRB85YuhUS7n/k0q8vZBAKgGv90hlgjhRfAQooBX23GFQIjVcY1SakrOIUFQz1t69Qmivl/OKBnJW+LGdM5tlENPgll/m0dCUkwA/XjcJ7lGaBFD3wO4rJjnB0/43u8e9wuiePB12zYHuIhcoRy2SFUQ5OVR/5/hNk/WxZ1sOYebhpJ3hrmT+Y5gbjn4evZwO8rrCkkl/6ZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPFEEDD586DA.namprd11.prod.outlook.com (2603:10b6:518:1::d5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 21:24:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 21:24:27 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 28 Jan 2026 13:24:26 -0800
To: Alejandro Lucero Palau <alucerop@amd.com>, <dan.j.williams@intel.com>,
	"Koralahalli Channabasappa, Smita" <skoralah@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Message-ID: <697a7e8a815b_3095100e9@dwillia2-mobl4.notmuch>
In-Reply-To: <04e92860-e616-4e74-a349-1397b3a0db81@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260122045543.218194-4-Smita.KoralahalliChannabasappa@amd.com>
 <20260122161858.00004b0c@huawei.com>
 <9c5150ba-c443-4ce1-a750-57736f0dabf0@amd.com>
 <69794c2512bfc_1d3310087@dwillia2-mobl4.notmuch>
 <04e92860-e616-4e74-a349-1397b3a0db81@amd.com>
Subject: Re: [PATCH v5 3/7] cxl/region: Skip decoder reset on detach for
 autodiscovered regions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPFEEDD586DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8618d9-fcc0-41b1-b63b-08de5eb39dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTB4bnFMRlJNb203SldSTWFLQ0lkVHZTVHZESjVtYUk1ZkZNUHZkNGw4SHRt?=
 =?utf-8?B?QWNwWDFGUi9zWmZuR2RIdkhaUjNuNnNpYUc4SFk4ME9oWldmUkllWTkwQmhz?=
 =?utf-8?B?RnpBaDVCeVk3UDZiSmNxVFlDa2xENGpFSHFSWkhNOTR0ZEUyMHg5SWJ1Wnh2?=
 =?utf-8?B?R1N3N0x0cDBrVkpmeEVLVlNrQmdxTElaeDlYd3UzOCt5bnIrU3V4K1ZPbGFL?=
 =?utf-8?B?SEt1QTFhT3VrM0VteElpMllQWnBKZzFnM3pabW0rR0NkZUtRS0NsNEdQbzhx?=
 =?utf-8?B?SVJ0OUwycTFTc0tMdTNrbkZjZ2IwaWxpVzBPWmpKL2pMUDJLaHBJQjBjbGE1?=
 =?utf-8?B?SlpZU2FWUUFIWUtJeEdoR0JveGpvUlhFUExkWDl4NHlHUzBySUxER3hTWW52?=
 =?utf-8?B?ODZMT2JaR3BKcERmSDhHTTVIQ2luOWFNRzdvV2ZiNXZ4NERSY2RLS3dwcHFZ?=
 =?utf-8?B?OE1PWFhHWGlJaEZTZlR1cXJFbEhIY0x2cWN1cklhMWlrTVcxbjZnTWhVU09F?=
 =?utf-8?B?OUMzRGJ1cmMzd3lJRjJ5YnlmbWVFd3RzUWRDVkNBSStGc0c0cWtDSitRWTVW?=
 =?utf-8?B?bzExVzVQNmx5VmxTVjBzd0xaVUlSWEpqeFNIVGx0cjFUM1VaTWU1YkRaOGhu?=
 =?utf-8?B?MGdWYVBGSGlIcmZQdkNLYjZKQWVlL3BuUnR4cnFQeFIyZnR0WS8rVnVLY2NZ?=
 =?utf-8?B?OW9VS3V4QVFRN3BXcUxIb1B6RjhlZ2xBMVpzeGo5WjlkWk9CbGVWUjgzWEJt?=
 =?utf-8?B?dXQ4djIvSTRsdjFLanVCa1JDV0ZURk9STWgxaEU0emhqNlF3eURQQ0VIbTJI?=
 =?utf-8?B?RUhGdDB5QkppNnYvcjhzNHRVdHFsRGEwWWYyZEQvWkQ2b3ZJV1FBNW9IaDcv?=
 =?utf-8?B?Y0JXMlV4R095UG5pSzdGTUxiWWZQSExvT3dCSkNZVUY3a0dXb1BQMVpubTJh?=
 =?utf-8?B?WTlkQUJYWm1Ecm9rZHFWdFZmN09yU1Q2R2lHdkN0ZFBJWUhrVjFubm1LMFNs?=
 =?utf-8?B?MjF3bldjandidnlFVmVxK0RXMDRUQTZlQ0JTTnZZUXpuUGJucWw2NndGai9I?=
 =?utf-8?B?MzV6c21RWXRwZFhoNW45cXE2Z0ljSE5wWk1nWjZRNlZkK3VJd2lwUTcxR05S?=
 =?utf-8?B?UlBCUUs0UzJNbE53dVpDeWp1Zm1LOEI2QmFJbHRrNlBJUEhyYlYwKzh5RjI3?=
 =?utf-8?B?STlGSnBEVHlmOWMxNlRXNFNscHZCbk5IUGh0VVdtclUrUE13Y2pIS0ZnbEU2?=
 =?utf-8?B?RU1HN2swMldrZlRqT1Nmd0pORFJrc0xiUSsrTDQwZE1jc0IvTGE2a1BPNEZN?=
 =?utf-8?B?TmM2aURqaVdRQkRoeXA1U0EwNDVpQmpWaWdvRnB0T2J2TTBaN245STdMWjlD?=
 =?utf-8?B?cGhNNjd1VWZQN3o4QUdjUmt4UkhyMHRIYUM5ZElLM3NkQkg1V1gzTkRhMVVY?=
 =?utf-8?B?Mko0TnF3dkpnV2lwL0JFQTMvMjVJT1JObFNUSVMxbnhGS2Jva1V4djJwb1Fr?=
 =?utf-8?B?VjhJSXZ6ZUpTUzV2emhIZWZRQmtUVlBna2h3SjlEWUZIcFM2S1lkUVNaT1Nq?=
 =?utf-8?B?TjhjMy9vMVA1UFRQTG5nRFovOXJKTkNhK1pjYVhZQU9pUVhCTk1KRExHQWlx?=
 =?utf-8?B?d3dSZE1IWERPcFRuV05pRnpmN0xXbkNCc2haRkE5dlVoWjYrdXNPY1NlRmFR?=
 =?utf-8?B?UnkwTTlrMXNRRk84R1hIWkZRR0Y1dmpmVmNLc2d3UG01djYxVWI3YzVMOVNj?=
 =?utf-8?B?eDZlN3Z0ZURYNjFuRmgvT1VlQWZ5NiswS1JSVmNTMUVuVlorY1F0Y0N3aHhD?=
 =?utf-8?B?Lzl2OUwxejUxd1pzL1hkSDAxNG9yK1RlU2JueWVBM1RtbERtL1ljU0JFNVdu?=
 =?utf-8?B?SE5WOHArNTh1QWNiazRraDRnUGxKOXVxck9RbHZtTkxVeEhkRHlPb2Q1OWdt?=
 =?utf-8?B?d2VOK09hU2syOTRtT1FZRnQ1Rnpsb1NudDNTNkZKRGc4a1FCNXppOTc1K2Mx?=
 =?utf-8?B?Q3Fhcms0bjkrdUhQODlJMXZBSFFUYmR5dms0ZjVHVGkyaEZnWVhWaWpNL3Y1?=
 =?utf-8?B?dzM2L25xdmlBMFJ5WmVzdW1KeThyZDhIeFYyVkw0eDRVNTZhRUpoNHU4REZk?=
 =?utf-8?Q?juRM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJWb0ZHMEdqWkZEZFN2ZFRDYzJUZVYrbkxYMjBFN3MrMUVvaWdMZW8zYXg0?=
 =?utf-8?B?UnIzdGlySG5HdTNkbkVWZGJoSGpsK1pwdWprQWZFUE1DcU91VEk5ZWJCU3ls?=
 =?utf-8?B?OVh0eU03clZiaUxoVmZMMnhMUlBHUWExRG40NHdVTlFQZUQzZWVLM2sweSt5?=
 =?utf-8?B?NnA1Y2k1bHd0eE9rNmU4ZUdySGxoOUN4YjdpV0RQd0ViY1BwSUZtQ3IrMVo4?=
 =?utf-8?B?bzVBbTMxMytYOWhpd01FU1VHMDFVUHl3ZW1qZGtMdGFSNnNiRzdla0FDc1Ji?=
 =?utf-8?B?ck5wTktWRGZNRVgraUpoU3I0a0xaNHcyTUs3QlpENEQyU21TaG0vS1ltTnhC?=
 =?utf-8?B?ajQ5UEtlMFo5OVFiUUZmNDdGWUVjam1mZ2E5bDUvOU0wakcxQ1dVY1BZY2wx?=
 =?utf-8?B?R2plRHRmL0pGRnJPUS9SV2VKSVlnMmhsQmFpRGJnTHlBSlRpNlA2ZTlxNHph?=
 =?utf-8?B?OHZqN3N4M2NyRWQ4eDZyUEdIb0lGTGZZaHE2a1NiSUhZMHZxWGM1QWtXOGx1?=
 =?utf-8?B?OU45RXZkU1VucHVkTWFML1RrN1h6QjFJaDErSTJZU3d1dHo0WWkwUXRacHly?=
 =?utf-8?B?NklrVnFFS0Y1cDZTTnF3RHJpVEpvMDB4YWdobEdoY2xRSVk4aDVjMXZ4M1Fa?=
 =?utf-8?B?SnFIMXlvRzZETXNSeXZ3YU5IczBsQ041cFBpUmIvcll6NWkvVm9QQ0tkakJP?=
 =?utf-8?B?aDRhNmY4WGZmV0FMT3pLclNtQis2bVFveVN4eDdIVTRXVDhOYXlEblI5VStZ?=
 =?utf-8?B?ZTlwUCtDNlN1ZjdRczF1MHo2dXU3dkFmY1NMZ0dkVDc2b2JZVEtEMU0xQVgz?=
 =?utf-8?B?eHg1emh4QTkwd0Z3MFVhU2t0THhEREtoWmxFOENYRXNWMlhXY3RZWHRSd1Bh?=
 =?utf-8?B?MzVtTmF6UHVtdC9CS2g2b2R3ZEEwZGhMc2U3NUgxRm04TnkzZkxWTHJPdjRF?=
 =?utf-8?B?Wmpldnd3R1JzamNhZEJqYksxSittN1ZxZEJ3cWNQekhhWjl1bXVxU2E5UXRj?=
 =?utf-8?B?K3hXL3FnYWk3WjFsc0hnUmljb2tPdHQ0K0xid2lHLzNEMHhRV0o1aWtQZmZI?=
 =?utf-8?B?ZlU4azY5M211VkVYQk9IM2NXTlVobE5YTGl6QXArK01uM2tXeWlEWTNmT3Fn?=
 =?utf-8?B?TUs1eGVQYkk5aWhqTm9zdUJaVW9FNTBPOG5QcjFibTJTc1NESUlMenE3WlYv?=
 =?utf-8?B?dFhpdzlhbys1NU5FTnB0ZjdUQTVQRVJQcEg2VWdYTC9lTjVrdlI0UHZqNE9Z?=
 =?utf-8?B?WE9sR1dNSjYyWUJiZlRsTFQvcnR0RUlkKy9VNEhDQno5K0pxSnBuMlE1YWlq?=
 =?utf-8?B?Z1RDNkFNVnJBNnVPUFdxQnZkTk5nQy9XZGhIcXE5RnFHSEgzdlJ5WEw3WlBC?=
 =?utf-8?B?bWRROWFRblpkRTF5ZjJIaGFrNm5lNnZjSlJhZzZQNFo2WnVlVE9OblpsSjdu?=
 =?utf-8?B?RWx0NWRiemdNUzc2NjNadXQ1b2lxOFc3K1lIRGIxcWQ4bEZzcExTWENEOEE4?=
 =?utf-8?B?SjBIbDROVWpqM2MxWDhiSGJFdGZoUUpqbzBWcE5tUnl5Ymd1aHpJZmo0cC9V?=
 =?utf-8?B?RGxaUGl1RTAzQ2NzZEdaMmh2U0dPSFNXeW9uVlVTZGhpa2hHL1AxRzlLQ3k1?=
 =?utf-8?B?RzFaamJtTnljM1lqaDgxNTlPMkRoS3l1M0JwajZQNzJXSUE0VzJLbFBzV1RM?=
 =?utf-8?B?V1JVVE80Y1N5OWl0THpabGJUYVhqOGJScGJyZXhVdGYrSHB2LzRPaGQxa0tP?=
 =?utf-8?B?b3BLdFJBSjJ0RHp2SHVyUE1KU2c1VU1DYUQ0Yk5TMU1NcTdhNlVUZ2M0a3BK?=
 =?utf-8?B?MWRkUDBXQU5LckRDMUQ1Z29BQ1FRZDVrVzEydGtSK0MrWURzSHlkNG9IdWtj?=
 =?utf-8?B?aXl6TW1SS21mamN0dWpRS0pOcDQyYXpZbnFZWitJWHp5SmI4S0lUa3kySDlj?=
 =?utf-8?B?ZWpyLzdsZkZwN3ZtQmdxamxscHU3LzRleE0zNFU4cHJZYTNNRTd6VzZPL21J?=
 =?utf-8?B?dGtCbmxkWFZnVExOZDYvY1ozZStCNkdjZzVWNHNGbkFaVjBqbDdpVENpTGMv?=
 =?utf-8?B?MkF0M3AzbEFlcEhoYitpKzhDYzA0TG0rL0pseWw0QmJ4Qjg0Sy9IcW05RTZa?=
 =?utf-8?B?V0FpdEpUTmJBdkViNTY5QmgxN3NkVWRlcHRjMHl2UGZiV3J4ZDVDMFBPVVJ5?=
 =?utf-8?B?RnFSRVJndUlPT2ZXN1djT0dXQTdXRFFPejVaWE0vRHNVYXUyTWpiQ043SWFr?=
 =?utf-8?B?dzlVaDN1V29YWFhGQTArb3RhcEtmbzVSRkVrSmJ5L1FoRi9kc0ZoSUJPaEhH?=
 =?utf-8?B?MW1iSVFYTWJ1SUc0TDVqcmxtK2M2emsxQzQwcFpPY3ZlTGtmTzhuQS9lVlJl?=
 =?utf-8?Q?hkRFip1+PnEAQ4Co=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8618d9-fcc0-41b1-b63b-08de5eb39dbf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 21:24:27.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPGyw2puWhlV7CM6Lqr0GQufRPq8tSObEhhuaItZkwQN3r3TyUqjZKqAFBrYLbhpI2ZnZa+4RgKmcIIuYuZnz2o4BdEeRMnet5gQiiH1AoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEEDD586DA
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-75807-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dwillia2-mobl4.notmuch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 581CCA9182
X-Rspamd-Action: no action

Alejandro Lucero Palau wrote:
[..]
> I have been trying to figure out how to preserve the decoders for Type2 
> auto discover regions since, I think, this was demanded after v22 sent 
> upstream. This patch/change is what I was looking for, and although I 
> did implement it in another way requiring "consensus", this one seems 
> good enough and already discussed and approved, so all good.
> 
> 
> However, I think it would be also interesting to give the Type2 driver 
> the option of resetting decoders as well, what I have been using for v22 
> and successfully tested. But this change will preclude that other 
> possibility, so, what about an option for clearing CXL_REGION_F_AUTO by 
> Type2 drivers? If you want this only to be done by admin/root, I guess a 
> module param would do it.

The expecation is that as long as "Fixed Device Configuration" is not
set then reconfiguration is possible. The best case is BIOS does not
create the ambiguity and leaves accelerators alone. The hard part is
that HPA space going back into a general CXL pool for other regions when
it is really earmarked for a singular use case.

So yes, a future helper for accelerator drivers to reclaim decoder
ownership from the platform seems reasonable, but the first hope is to
just have a BIOS switch / change to stop mapping accelerators and let
the OS handle it.

