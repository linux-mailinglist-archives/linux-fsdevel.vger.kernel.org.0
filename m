Return-Path: <linux-fsdevel+bounces-73358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A197DD16202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69F8F300A3C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7726A0DD;
	Tue, 13 Jan 2026 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivOR1L0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24C1BCA1C;
	Tue, 13 Jan 2026 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267086; cv=fail; b=h5DmYb/PoC8+2z1JZcvLoggENujfg27HLeeVPIerZFjQqSBCJW0NX1g4A++jwvEMX/kduE64uK/MrgTY/+4NtthXksW/PtOTJgFdh8wgUguQdkMyuzthLRaxtipcCJ/I5M4eHJT/LtbjGhXhV2j8Pr9Kz30YqCIrDys2hjkLkd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267086; c=relaxed/simple;
	bh=l2j+VwGEUNNoWWvXu9iLfUYtvnOqjVF4tYiE/3AtpPg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CbBCFs8YEt3QO2Sm2iK8X+Li00kanU3BHJhjq/JXAO+UxnzRnYAG/it5fqjiMZtgfl5VdbbJy2ZkCC/FneIYKcPEtww8ygMyIjuMFZRZQ+TC7vwLIsSn/TkYuES1iAjfP4N3pkV4t1vJkvfnZwTMtyaTWM4CNUaU3k+jS1u6BbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivOR1L0q; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768267085; x=1799803085;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=l2j+VwGEUNNoWWvXu9iLfUYtvnOqjVF4tYiE/3AtpPg=;
  b=ivOR1L0q8agt2dif8b/NmwRdhW98vssYei637kzwIQPGbFWcYaIn18Xf
   7h83TzYMui+1DVwBeQVowUGhW6IccCCziuw/tAUdp6jyNRKB6nuNhnyue
   FI1KB9nKa2EryReGsTHd4lS2BRtAOBy5NRMYCvWsj93UdfWO7BZiRMI3B
   OK0qArhHz5d0dOpYt45h9ENtbzLck57R9N5MeShB0XjglsUtIJ3ev3gLj
   MoUDX08BdRdIGoAchOCnMBXHpzYl69YyakqVfh1v6k8BSVM0+xO/BL3Ck
   WiU5eWGuL/6zi9TOttRCmnMxXb5yeWGAu3QhsxJAwn8NmvY9DNDbhdIqK
   w==;
X-CSE-ConnectionGUID: Afr8WyB2QdemR0JY1GNECw==
X-CSE-MsgGUID: WhngSihfSq++BQ+zj1gDdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="87129674"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="87129674"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:18:03 -0800
X-CSE-ConnectionGUID: tyVFO71QQTKU5CJEmIoTHw==
X-CSE-MsgGUID: tNoWa8L+QfaEWoA2qZoBDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208713289"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:18:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 17:18:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 17:18:02 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 17:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biQ7DMM5XnTOSluiE9nLsZfE19x+q6Bo5K6ecycHW3mkTW4cnrK5O1Nhp9rCoraFMnAlXj0cpt2C8YxNvdMPXnbK8SjsvUL684zufto+HKzAB7eXXaZoHoiB9LCYwWEq9FTrYPK0IgOJxyesLzlx0apXimwSu7j2AZ02iVVV/IGqnmAQKLN6ddIfryrSBr2esgdoEWblQm5hVRcMn0gAqZqJfPy09lV6LKVmXuhH0EWd17Fp8DWEZZ1EF5ngRk5TwjePFLAvA95Rhq70xcYOzYCJpPjKPIc8SOWPQXR2VDlyypZdfeqp0MfE1MdPAAFiNv+ynjAK40jVyd6peLgLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUtU8xyzTrKLTb7E3IujW/kqtsvgLxf5/cgkQss0Bw4=;
 b=TY249+PtIUTJE7y2yKQiR0064fqM+0mzsYHayIm2wI2vZ2IQiSB+5TLMP+wNDSPmZ0LW9vv0iqtHElKMUPyG543HIBb9cqQ4LY1/eqsdqJNJKfJ439RdSYGKi9voqm9ZPA9JYgUJoerTvNyGDGkoD0ZENj9RTFBhTUHL/9b8ZJcMl8tSv3/Ko9zjB703oKiY20xvDJ1Np0WEtvAm7HLlRbJypH/yqO2KIN8YHp+NrU8Fmg8WpRM74XVf3KkATyrijAJS9QZjNmxqYPGQCm2+vNpX/fL1W6lqTDSsd/slWVbymjPDL5oyaCu30L5W1novyt4MRPePeWS0TxmqJ7n/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:17:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 01:17:55 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 Jan 2026 17:17:53 -0800
To: Gregory Price <gourry@gourry.net>, Balbir Singh <balbirs@nvidia.com>
CC: <dan.j.williams@intel.com>, Yury Norov <ynorov@nvidia.com>,
	<linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <kernel-team@meta.com>,
	<longman@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>,
	<mkoutny@suse.com>, <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<ziy@nvidia.com>, <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <rppt@kernel.org>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>, <yury.norov@gmail.com>,
	<linux@rasmusvillemoes.dk>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<chrisl@kernel.org>, <kasong@tencent.com>, <shikemeng@huaweicloud.com>,
	<nphamcs@gmail.com>, <bhe@redhat.com>, <baohua@kernel.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>,
	<roman.gushchin@linux.dev>, <muchun.song@linux.dev>, <osalvador@suse.de>,
	<matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>,
	<byungchul@sk.com>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<cl@gentwo.org>, <harry.yoo@oracle.com>, <zhengqi.arch@bytedance.com>
Message-ID: <69659d418650a_207181009a@dwillia2-mobl4.notmuch>
In-Reply-To: <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <6604d787-1744-4acf-80c0-e428fee1677e@nvidia.com>
 <aWUHAboKw28XepWr@gourry-fedora-PF4VCD3F>
 <aWUs8Fx2CG07F81e@yury>
 <696566a1e228d_2071810076@dwillia2-mobl4.notmuch>
 <e635e534-5aa6-485a-bd5c-7a0bc69f14f2@nvidia.com>
 <696571507b075_20718100d4@dwillia2-mobl4.notmuch>
 <966ce77a-c055-4ab8-9c40-d02de7b67895@nvidia.com>
 <aWWGZVsY84D7YNu1@gourry-fedora-PF4VCD3F>
Subject: Re: [RFC PATCH v3 0/8] mm,numa: N_PRIVATE node isolation for
 device-managed memory
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 3265b456-5402-42fb-c60f-08de5241945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGNjWWN5cGxXL3BVcm9NUVhUWEU0TnNLMTZRSW5kbXVwbjFDdWxlR3hBQXcy?=
 =?utf-8?B?Zkp4aTYzYUZoWFpjZ0lnSnU4ZU5lcURHVnUreElGd3VjWENLWjRxeWs4SnFH?=
 =?utf-8?B?Z3RJUFRTaW9oVUJMaWhLYnBqRW9hS2NoT3NlR3BFTkNvM3JncmxpWkxxYXNz?=
 =?utf-8?B?K1VkV0k2Mm1RejRZT3N0dTlzYUlnT2RBRWxKSys2Z1lsbFRvR3BVRTM1WW13?=
 =?utf-8?B?ZXdIaUd1aWttMHVrckpOejJaZWY0MnIrSEZJeExiTjJ1WmVHTWVFMks3am45?=
 =?utf-8?B?Y2RhTWZOSzFJUFRwREhiZWlZUWw2WUNSZTNsbmN1OGFROEZTQ1lMdTc4a29p?=
 =?utf-8?B?Tzk1ZnVaZ2hHVlM5WldwVjIrb3M1SXhJc3hXWE0yNUdwRmxpZDh3Yk9HK0s1?=
 =?utf-8?B?M29USTlod1JGT0RtS00rNDM5L2xlMmhqOVFGam5UZWw0SEJFUlk5NXpKYUVH?=
 =?utf-8?B?NldzTTVHNGQzNWw5NDlraGlvYkZqTklQM3lHSUVGbHJWTndsWXNSSEVuVXd6?=
 =?utf-8?B?di9ZeXQzbC9IdmZ4dW9MNDU5ZG1BeE13K3BpSTc2WlRTQVJqdVBvSE96Um02?=
 =?utf-8?B?UW9xSE5GckQ4NExrNTk5SE5GM29jbWsvdHRpQUQ0a3NUa2tZTzNKLzJVcjEy?=
 =?utf-8?B?NS82YXRNZHo2Nzc1ZHcvUDdsTnBYNitOWFEyZjYyL0ZjRHlrc3psVHpaZzJa?=
 =?utf-8?B?dzlIbHV2VjNxczJSWGkzdlBPbjkyeDhGcmcvZ0NuWW55aUUvZGoycnFjaVky?=
 =?utf-8?B?aVBaRThnQjJDK3F2UFJVRXNsQWNxeml3WkxzcVVuajl4bTdTZXgxZVFCK25X?=
 =?utf-8?B?aWRIOWoyNzVFSFVRUmtKcFQ4ajZIT0g2L0VlRERrQ2VDcXZ1YW5HSWNnKzdu?=
 =?utf-8?B?UUtrdHlGTG5PaFZlZ2hjem5pZGlXQ2svakRsVnhGcnFxUGw0OXFPcWhOS1Zj?=
 =?utf-8?B?MWVnZGcxc09SQVBjSFl4MjBHM2xlaHdqZzE4b1RXQ00yTklqT0NHeUZxTEYx?=
 =?utf-8?B?bkxvOWRWdytjOHhBaGRsS3lzWlZQK2VWVy9iQlVVbUlMUzk1WDE2VVQyOUFD?=
 =?utf-8?B?WktVcGRXa1NlVGZEM0k3aXg5eTdEdVpJMktTUXU2VnRYMEFVNkpIV2xoWmlE?=
 =?utf-8?B?UGF2eGtON0h6Wnh6ZEw4QXJFT2pLZ2pOa3F4dUFEWU80d1hPcXVtOVg2OUxO?=
 =?utf-8?B?c1VOR1dtb0JCTnZ1MkxVd3hEWW43ZFAwdWJ2VnM5YU1QZ2tRWElvZThyNndY?=
 =?utf-8?B?Y01mcnozd0N6dTBzSnlURVdPY3dabnlvM05ycHdZYXo1ZjVCQUJ3YmhBNGhH?=
 =?utf-8?B?bktaSVRKMmx5VDR5NDBFSGQyOEhXOGFzcVBUaVhYYlVCS2JsMi9vYW5DdEJC?=
 =?utf-8?B?bGVvUlIyM0EvbitaalBIWkJiR0tOTDIrMlIxN3ZYUERxWWdERnNwdjF4dFBt?=
 =?utf-8?B?MkoxbmFJNDBKTDNxVTZ6cFdtWVZtZmNWMkgzc2JxOFluZUdoMk1IcWdUcVg2?=
 =?utf-8?B?YUFnaFc5SDRrOGxPcU5jTzZLY0k2cWxQQnlBSlV5bjF6MkRrZzdNUW9oSEhl?=
 =?utf-8?B?SzdJNE5QbFp0TDAvUGNOTVpuOEdlT0hOUi9iWjA3M0dsUC9zNmZSVXhYbG1v?=
 =?utf-8?B?MlFrdjdON0RJWGZoVHUrbWloWUo0eXlPUWlxWkRYMG05dGxJTjFOOTFxRSth?=
 =?utf-8?B?YytpUUlVc3VMbUtYT2RVVDhkVHRxa01aZzF2dTV0Q1FkUWZ5azR4VUpkTmFw?=
 =?utf-8?B?Rm5ET0w5VW1ROC9uUDBOTVRPVGQrejNQVGxuT3A5Q2MwZldiY0ttcUJqTEpk?=
 =?utf-8?B?cnNEeHNEWWxlTW5IdDhiZmxCK0wvQ2hiMGxHalFyOFNVTXhlUjg2TERFMjlx?=
 =?utf-8?B?THZaOGY1R0x4dkltdk5JTEFFTW5XWldzZlRhb25LSHEreFhyM25yVjJWUy9Y?=
 =?utf-8?Q?51CY/soD07DAAf6jBok7wNXuHzFLJ0ci?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUVSTDRYU2FQc2pyR3lGaDN6ejNsRmlhWXJoN09VZnA5RFNkUm92cDlZeHA4?=
 =?utf-8?B?MHIvSmluNW9EMmc3bmhkU2M0eUpKNDhQOWFXb3ZYOVpqNzhrRndldElTNHQ3?=
 =?utf-8?B?eXZUOHI1anc3L1J1SHFPQ28xdXd0NHFZN0hNNG9Ra1RENnJVdXRsa2MxTlNw?=
 =?utf-8?B?S3puRzZ3UjE1Z3hvT0VGV3drVFZmOGdFTnY3d2lFMUVXS0ExMlVUNWJ5ZUJm?=
 =?utf-8?B?VlVaVmY0VlBKMkVXQWtLVTRtVTZqbHl4UVA1bmVMT0xISUEvdjNRQXpZUVBR?=
 =?utf-8?B?ZlBaNFlJKzRidDI0ZmI2RWNicEVLeFhaakhNZFVEdXFDSW1xMGF0Uk14Z3Yw?=
 =?utf-8?B?YlFiRWJ6RXZKUlhBS2MxL3gvbElqakNBekpnQUp0VEw1dzN0NnY1aW9iN2Nr?=
 =?utf-8?B?a3I5QU1yY3RKOGRtM3BqUm94bUF3aStiOEg2YTBKRGNmNHBlc243dDBJYUk5?=
 =?utf-8?B?Y2pvM2dEUVg3UGsyei9hSWpVY2F1ZVpJV01PanZNeFQzRFBVUWxTOTJsWWEv?=
 =?utf-8?B?dm5kcDVyNmN4M205cXdlQitHd3BmSEhNTFhWNENZMlAzajhOUTdFLy8rcTg3?=
 =?utf-8?B?MDJWdEZLbXMyZGpMaEVZdTdGUW9pOEhQV3lJU2ZYWEpSSEE4eERJWjlydVJw?=
 =?utf-8?B?ck4xczR5MjZKZ1EreGUxWWpjSng0QVM3NVRKY3RUNUlmVUFpUFFyV1VaYmZo?=
 =?utf-8?B?QWlENndscnBSaFdldTJDbXNIeE1Ob2hVKzlIeTBJbDRKN2ZHZ2JKYUtYblRa?=
 =?utf-8?B?UmNRRm05YUsrQ2JjNndUbUE1eGVLTERsN29nZmVVNmh4QWV1NUdvNVZjOGR6?=
 =?utf-8?B?OVZGSjJlNzl6TUpkeHZ3MmFkeEZTYUFFd2c2T0pta2kwb3N6ZGRPRE9EQ2pY?=
 =?utf-8?B?VkZvMVZ3VytCSnNWWU1qeE1yZEE4c052WFhKR2hPZ0ZUTmppdE5OSS9rYmxi?=
 =?utf-8?B?WUR6TWVUMnZuU0NDaUlodENISmJwbjVPb3BRSkQ4dUFQWHRzbUtXV0FSQXdp?=
 =?utf-8?B?Q0VROVZMYkl5VHQvMzlndVRSUk41N1hod2NaME5LbE40UVJIdEMrUngwRkxI?=
 =?utf-8?B?L0s0ekNPcS9iTkxHVzROT3VqeExHYkdOR3VRMEVEM2xQaGdZZGZrdHpFYldr?=
 =?utf-8?B?UUtUdksyRENXd0haUmpjbm9JUkZWZWJWVFdZTmpqdGVYVXdneC9WOERqbTdy?=
 =?utf-8?B?WHlTV0xwV2U3UGI2UCt6TEh0TEYybUIwUkFVWnVVNzA2SXhoUGViRXRZZEE5?=
 =?utf-8?B?TFRDRlRvRmhKbUZUQXI3Z0pEbnpvUVNMWSsvS0FBUXlkcG9rQStJdUthT1RK?=
 =?utf-8?B?bzVCNTZWblc3QmI0RU5SaWRPNDdjMVhxK1hFWmZCMFYzKzhuYklPN1pFZy9K?=
 =?utf-8?B?dDl4b3Q4Wks3WW9uRnRPdUs5V011U1FZc1RPbkYydE9HbTMyQW91ZHluYTBW?=
 =?utf-8?B?M3lPbWNXOHNhSERiZ1ROcWYxelV4MC82UFdZeHJmUjh4Y0psTEQzVXczUXdu?=
 =?utf-8?B?MERsZXNYSjNrQlpuQXRuQmdpNXNxbXRoWlk2Z0lrOHg4QVRUaklUZ1Q5d2Zo?=
 =?utf-8?B?S1R6c2JiWEk1eTF5c2FrdmpJbjRDSnUrQWxmenRzdjE0Uml3K3BMNEdGWUJl?=
 =?utf-8?B?cFdkdDZLNTA4ZTFBVTFjcjhtUkZ5SDR0ODhZbGg2eURWSnZjSGovTktuUTJh?=
 =?utf-8?B?cU1meFBId2JZWWlYVlYzSk9oemV6TDlPYlFGRGp0azAza0pSS3pwQUVoampx?=
 =?utf-8?B?UzNzcVdaY1dNR3l0YVFxMk9vcWdpUXduVGpGaU1yV3JtS3dOc2xaeHJmV3Uy?=
 =?utf-8?B?eHROTnlhWm1uSGJOTzdRNnlQNVZ4R2RQUEZzVTQwVE5CVFRrY2lQRjI2QzBp?=
 =?utf-8?B?SGYzV3RYYk9FVjgvbUx4Rm4yaHR5K0FBUHdGcCtMNXliZEFvanphRXFCRVBo?=
 =?utf-8?B?ZmFPTG01bTlOd01XVGJCMkd2NXI5WFlMekFiS1A5RTBUZmMyQ2tzWllOYWUr?=
 =?utf-8?B?OE5Hc2hmZzBHNzFTTFNTdFhsVjBrZXo2bTdNQWd0a3VhK21UMXRURUtGbjFV?=
 =?utf-8?B?YmNwWk00UnRqQUpHN1F0SUFuK3dHdlRmdyszN2wyVTV1bkFBdWl1cW13SXR4?=
 =?utf-8?B?U24ybzlweDF2dURNVnB0KzJrSEhOZW9lWWZ3Y0M2M3hsS0NpTVJPRXZuUFZD?=
 =?utf-8?B?N245MkR2bWNUUnN1VFloeHZTWWFyMnJVa25YL0tJNk9sNlZhMXpTVFZwS05a?=
 =?utf-8?B?WllJZjV2VThTN3pNMXoyL1p2clVoQ25iM3A0VVdLaWk1d2w2UHNoSmdkOTg4?=
 =?utf-8?B?eDl4UFNPK0JtM1IvSzM5QlIwMFVGTXBubTJzcnA1K3NyVTZVRlV0Q2o3QVdC?=
 =?utf-8?Q?VExcrNjDOOo/NU6s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3265b456-5402-42fb-c60f-08de5241945d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:17:55.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2WzYV5F/PQ6dA+hqyz98iusyS+CcOBtiCEEQlsBCQfOZuTPOn3l8aHNbPA5bq9N4kFOz62bWEbYo6OSHXnjOmoQU/ipFhKmGv9dWXkkbnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Jan 13, 2026 at 09:54:32AM +1100, Balbir Singh wrote:
> > On 1/13/26 08:10, dan.j.williams@intel.com wrote:
> > > Balbir Singh wrote:
> > > [..]
> > >>> I agree with Gregory the name does not matter as much as the
> > >>> documentation explaining what the name means. I am ok if others do not
> > >>> sign onto the rationale for why not include _MEMORY, but lets capture
> > >>> something that tries to clarify that this is a unique node state that
> > >>> can have "all of the above" memory types relative to the existing
> > >>> _MEMORY states.
> > >>>
> > >>
> > >> To me, N_ is a common prefix, we do have N_HIGH_MEMORY, N_NORMAL_MEMORY.
> > >> N_PRIVATE does not tell me if it's CPU or memory related.
> > > 
> > > True that confusion about whether N_PRIVATE can apply to CPUs is there.
> > > How about split the difference and call this:
> > > 
> > >     N_MEM_PRIVATE
> > > 
> > > To make it both distinct from _MEMORY and _HIGH_MEMORY which describe
> > > ZONE limitations and distinct from N_CPU.
> > 
> > I'd be open to that name, how about N_MEMORY_PRIVATE? So then N_MEMORY
> > becomes (N_MEMORY_PUBLIC by default)
> >
> 
> N_MEMORY_PUBLIC is forcing everyone else to change for the sake a new
> feature, better to keep it N_MEM[ORY]_PRIVATE if anything

I think what Balbir is saying is that the _PUBLIC is implied and can be
omitted. It is true that N_MEMORY[_PUBLIC] already indicates multi-zone
support. So N_MEMORY_PRIVATE makes sense to me as something that it is
distinct from N_{HIGH,NORMAL}_MEMORY which are subsets of N_MEMORY.
Distinct to prompt "go read the documentation to figure out why this
thing looks not like the others".

