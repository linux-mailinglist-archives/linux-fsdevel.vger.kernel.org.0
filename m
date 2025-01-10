Return-Path: <linux-fsdevel+bounces-38797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2CA085AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D873A9E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CEB1FF602;
	Fri, 10 Jan 2025 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU+Z9UMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966871F9428
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477044; cv=fail; b=jFdFumtPAL0qQlZKGUhwyin8SFgrPwxZp67Z1NHzr3g3pylSQsweZhYpcVDe3xi6OWuWPQb3R0RIrvvJ9Tctbzs/z2uOWeKvZNrvW6IMrqvqQsaYxsnnQsdpX0UUOa8GMQRCu+DSqUGcyTp/FxXho5c6C5nAsgD60BL1gIBhSOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477044; c=relaxed/simple;
	bh=jmpKf+VJxs5ddpJPFU1KTH9hza9JfPSg9iKN7Bsa4Gc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Qjv7GvfYHJu630fLG11y1fBaooFs7DzCbXDxcRTXv/jywcT/ZvlZo4b28/WuKE66Kw+uncClIVIgaOnqy+K9uVKEykSXH3DtjB8ZrJ2IzePP4BSv7Y5/OgCG2mqVS96lUYDZ/EdNgVqfH87+vpp8nyljvjPTCDyLwYfImCe7Zx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU+Z9UMa; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736477043; x=1768013043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jmpKf+VJxs5ddpJPFU1KTH9hza9JfPSg9iKN7Bsa4Gc=;
  b=nU+Z9UMaDSIKATxu+o1MHm5WLDrjMKTqQLJZZQ94TRDz4vlsGdsOMoHY
   bVAW48+FzOMe2yOwQ9TJLfcjG9i5QFBzYgKr/U+k3gxQkSafrH9fKYd2I
   dq3EOe1B7oytjZzMg+Ji+SdEYCQB8XEbatFVhzbK1R5K5U2G+BChkz9cC
   WNwyl0xEwGTN2ZnT/g/UTp+ySprpIqWPTMx5yj/BQSQzlYP6i+yGTbhA6
   PGQudnBWGRTIAC5QotbsOy4rp8j2HkgFysbg4n+W9VV1GjfhBzPCUNHK0
   KOfHmZi+0pziNQvDuiQn8uqs4CU9IbCDOMXiaL7J3rGHYPerGtaHSGIq1
   w==;
X-CSE-ConnectionGUID: 23T79gNSS8aQX002h/R47A==
X-CSE-MsgGUID: 2bmFE8XmTeC1J33J/gACUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36872608"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36872608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 18:44:02 -0800
X-CSE-ConnectionGUID: ELp7xjVBSPuiriZMNbNrrg==
X-CSE-MsgGUID: khI6rIdFT0eSeaQ6oc+UhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140908611"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 18:44:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 18:44:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 18:44:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 18:44:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXEIGlbaw99HOobLL2ybgObyRig38Cx+ilWmGCDjuT6dwIADEgWoDpSK16n7+ZKVYEoVY24jGi1QRJhr61fr6KXD3W7857Eyxv22noj5VUIXbZEW0jX8spaGURUEKhyIp8h4Y8B4E/Sfa3kXCMMgwjhpbbI42zVXB1wnpY0w4FgJYhmGSWJZ5EdYRkE90InhUk+Wga3M0NP4SIfs83htDxeRAazMOuEPcxODBpFPipYXifl2dfall2QqCNlaEKc9p1oEX+rKPQOnvDZBWYPUSeH+Y70FlL6IEjfDrOjbeXXTMi14PL2YiUwiMQ0R+EdqgYgI7smMQ84u1k6BNWDbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFSoUiKqrIlUWteC7xulRu534FDvVhpeYXpYDnlQ11Y=;
 b=GpjDq7XTPhOvEd0aNIGF+bC7XFk01NeJmcJ3TpmMyCDa4GYXTUIavNWE5EMaLig3vnZXzrRqhQz96gU6MXJ+pI/8j8c+BB4exRaE8o2u8rFHXsbGplazBlhoIl+j//wBCAAo1YUFgQIaotgjLJW44QFXW+TV2HuNlK6lPQGtgH8WbWPV7+WjU6EhqvPnj5reyewvPcM+Bj45i6xr0XA68MgDaKzLtAvgc9yMCUnKt3NHdTGCM8fWGe24BeHg1tSeI4OBEfErPqil8qYAbV2tyzEXFbrWClgVG+ENC4tSu7YIRwXykmtoqVT26Mvu8oQzJxJ3LDOAbIRQSA8tLYkxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 02:43:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 02:43:52 +0000
Date: Fri, 10 Jan 2025 10:43:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [fs]  f8f25893a4:
 WARNING:at_fs/debugfs/file.c:#open_proxy_open
Message-ID: <202501101055.bb8bf3e7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 86df8a67-67f2-4f15-1d5a-08dd31209e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FbC06Mxyaog0IGG94l73JSMzP9k5D3QPAOOdxWVrdWfNZcRvr9A5vUVFp6cz?=
 =?us-ascii?Q?h+5QAGX/+mJEhnjrFOdUb8jNzcBjUXKNUo061+2W23fcZO+xReqCvgSzVFf2?=
 =?us-ascii?Q?Gpv8ssDUvf64xpiGmGZ/bkjYqrPcuPW1BjQtBOm3mAW7mXtJKWZNKqLvwk9t?=
 =?us-ascii?Q?kf/kEBtfZuTH4cYi+sAfCsNFX1n/gxoiConUi4iHB6CfjFVhV/Gb0w6SJOva?=
 =?us-ascii?Q?+QJIZ95QLkcRovyQeGL6Sygjni5jTA7NtGMvmJl2Q3fVseGtf8zgs+ZGMMUI?=
 =?us-ascii?Q?ZpvSWzW2ENEDbPGAlGJr5MDkVDxpPwXQMy3dX1B7GS+FY+weH11m5TM8GmKU?=
 =?us-ascii?Q?itkIFcuWrzYirAjSwQOp9W/uYHpQRLQAInNw1zu8fIAbhFSmAZGIinFZa7XA?=
 =?us-ascii?Q?Vj10nlnZTkWlkVzxuBPis8a0acp+fg+sPPEOxKFm4y2Wo7uj4/D7tUGUufc1?=
 =?us-ascii?Q?3GKa7lexD/2lDqyXS7ELCyaSjmy4dKusewuCIqLC1fWS3LSPz9538KFmDdJW?=
 =?us-ascii?Q?1/oE1Cmo7ARV6bkQlpTur1eE4ftSSq+2qYs5JEJLKkPsrQ+23tWzZHmJX0Tj?=
 =?us-ascii?Q?QlZ1jk1aFkRrcx5P0J+u48Bdd2E6Acyo/XIVdyX3TvkJ37CHH+gD4kE4iqib?=
 =?us-ascii?Q?gKwtt5ABvzYEYbuM9uS8JzKKHO4GwlSTQSoWdgjpE6SU72bsWmTRYG19jjK7?=
 =?us-ascii?Q?PqCylO5Six7hiVu0WmIpgreZ4OlrR4HQHGN3CtQt3kFgBgxni0R9DuhCe4kZ?=
 =?us-ascii?Q?CZlZBKT9FwSaXIaaBl5AuoV/EoMQejx97syR9RQfKL1Q4Rd23euhgl73wQZM?=
 =?us-ascii?Q?zAkiYm6AJRUgJG6QWInfiN4CRwsJLeFpNRcUOfWqN5Nmhc0nSRZ+9c2+ELdk?=
 =?us-ascii?Q?mJ7uyqGBKiD4e1eY2hK3j5wH2NtAhoagHKJ48QA017iV6T7MS53DRNvtXFJQ?=
 =?us-ascii?Q?GyCAyPiXsVdQ6ZAHbxVK82QDFE9GKMwVcUq3pBgx4APQC3Lf1KSoCwY+921R?=
 =?us-ascii?Q?xLvsz3pU/3LEnNjIxHpWbdZrZuvnt9OD9o5x9X/xhxfc/BTZJDgW0+ueti2c?=
 =?us-ascii?Q?X2586EDSefuwEdn9dWebaSuoCZRK/6U4iVYOtOm9bftXnv9qEdy05rafWz0Y?=
 =?us-ascii?Q?qeN7sfXvQsfQ4z7XHgyqRF+McAEVOSQz3c6UBsc+0W5UBKyg1YJb2LrKQlrN?=
 =?us-ascii?Q?Nh9P3KhMfYUg++8J1WHceJCgm5YUvhPkD6j/r8NE0OnsGF3ZEAuc30vX5Su8?=
 =?us-ascii?Q?U9frqk+wkRG3jvXIK7OInGRXDIedTMgMmbePqKxQNVrQKqmOosba17hJErdq?=
 =?us-ascii?Q?RcCPqf6kRzr369LSipcyD2UGX3d1t/zqgvSvsAbjOo9jNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tDHcTm248LhADL8gNqLN/Ecgqa2fsC9yYqD62GMsGgr6RwqwlJq3KbheHuo4?=
 =?us-ascii?Q?vnWc+JZl0NiwFWftVgWn2qYwJVvpcM1O/om9MP/Y0GH+4OWnf7Ham7JgilrM?=
 =?us-ascii?Q?C4SnkK354RfyjmHEyAefLCSYm4dQO6j6aeIC+/pKemuSDtyPbDsc3ZtZh3D4?=
 =?us-ascii?Q?jtnEnafoy6YdMn4tLRQlFPuND1wlKEPmVTzlR7bS6U5F0SmctRyuQY6khnkJ?=
 =?us-ascii?Q?u6aw6bm2hrCXJQjxW1kXq44uDNkOV7K6cHq+oTcEibjs1ztmbcGHj6SeiA+G?=
 =?us-ascii?Q?0KfOqKLVDvXEEJn/GbR9hBToZ0AIAruyZXJRnd9B4qoPBBXdsL/5JK6Wen92?=
 =?us-ascii?Q?+sdmPy9Jr63ooPWVA2rmepOwEYl4ifebUXVezZbVweKmyKpSwpEUyY7fZ+no?=
 =?us-ascii?Q?F1kap0dfyrN96pvu6SowXE2SxTXMe1fCfItWGfzvxs7NqYbU+XbfbqstK6hk?=
 =?us-ascii?Q?PLaHwGUI2sJnClRGhXScUVQfxyQM2VCYYJ1nvrKknW+CVg3ZNc0/sFckT5bW?=
 =?us-ascii?Q?wA0xnjZbaY8/D88sFMwROnHvgh1wtaGR5bkZHLlC60Y2cHpn/Hn7+PngkbLQ?=
 =?us-ascii?Q?eUEwP5euXwLTBOF4w1HrtN3xAIp/pVX95X1p4VEhh8kARYIkiBFz1UdvJVZC?=
 =?us-ascii?Q?PEXR2mFksGcV6RPK/l9z2AYtffzPXyiuvLzChmYAHbjgf13QF7Wzi1AWHfju?=
 =?us-ascii?Q?MK4r/nJMBMRNml5w1/bO+51jvwXN3kLrDWwwMAashh2xOQPgh127xk9YtAwl?=
 =?us-ascii?Q?GlUdv0fPfLII3lfiqPjTV37VxLHZGfgVfEHHGn5ms+4MBB6GtZ8is4bkCUcz?=
 =?us-ascii?Q?22GctKOTypCJfKmTp11Q9uBlxKck1uBPOc/rMHDl/5UvF9n8+CZUi5dj8acN?=
 =?us-ascii?Q?BsNx0+Pj7zKaeISY86tNn7La+ahfoezR3SknyzkhRIVq/6zGmTQtOOK3fY1m?=
 =?us-ascii?Q?yAZDVApSpc5TNfN1hZdhxzWzX0RGC+GCxVd8T0aZW/y6cOVOD+onNkGJs0+S?=
 =?us-ascii?Q?MYLLLvLj2x5q7sCPMaHugQ7ZOAJvaBw1s13pFrgy//IaylbmmGair9E0TU0l?=
 =?us-ascii?Q?XP10cB4unTm5Qlprtj/vHIsMhPPWbrxSOciiFLtSUOUAM3GhfxLZu7vlRp8q?=
 =?us-ascii?Q?KQWS17I6QEjii2imISdXFOEl8aFxqXcCIoLrYwEgNWFl15IQkiDGL/lcZ4lZ?=
 =?us-ascii?Q?8YzcmqC7tnkYRCq9k9H+EVqE5TdV3GPqnkEEWvLnL2Al5ujK2/EQEOcXzplT?=
 =?us-ascii?Q?xm/5hUMuTIdgJZKgmXvPT/xdgspxOXRm/l5fN0kYEVIKeSbLElR1Pgo7u7ge?=
 =?us-ascii?Q?Xu28LE0oLUE3eHAd+n5tSh+hmEm5iWTn9zZqwZcnRfuffZcScdVvXH372Y4n?=
 =?us-ascii?Q?YiG8/St5aPrzGsDWBT6g0OtDdSu1ZHUo31xuLKrD91XsWrdez7ImiaFWNq+R?=
 =?us-ascii?Q?o8VVnFU0AMfmg7XO4nUr5XojNGAFnBk5JYWFtF7gapRMP+E21o+bYZwe9U2y?=
 =?us-ascii?Q?ObJo5kL09ZrouDa9t5EKWiYJJewkbe5ILNFYpgkzuh+GdsFh48GSjy2/HTWS?=
 =?us-ascii?Q?NLIM+FKlzQ8/b0Wwdm/tS69hJN90I41QwMz8gUU//8mv9CA/ogscpni/CdPz?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86df8a67-67f2-4f15-1d5a-08dd31209e9d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 02:43:52.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf7bSrM+e9fhFUNU3wxIZKquoyPl9EHOix+5xJqWwBCrW9Q6jSYl0nErLGgVIs0njuBW40mw8v3tpkgmpmZcmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/debugfs/file.c:#open_proxy_open" on:

commit: f8f25893a477a4da4414c3e40ddd51d77fac9cfc ("fs: debugfs: differentiate short fops with proxy ops")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6ecd20965bdc21b265a0671ccf36d9ad8043f5ab]

in testcase: boot

config: i386-randconfig-054-20250108
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------+-----------+------------+
|                                                                         | v6.13-rc3 | f8f25893a4 |
+-------------------------------------------------------------------------+-----------+------------+
| WARNING:at_fs/debugfs/file.c:#open_proxy_open                           | 0         | 24         |
| EIP:open_proxy_open                                                     | 0         | 24         |
+-------------------------------------------------------------------------+-----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501101055.bb8bf3e7-lkp@intel.com


[   26.402607][  T279] ------------[ cut here ]------------
[ 26.403497][ T279] WARNING: CPU: 1 PID: 279 at fs/debugfs/file.c:90 open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[   26.405856][  T279] Modules linked in: crc32_pclmul floppy i2c_piix4 i2c_smbus bochs i6300esb intel_agp intel_gtt tiny_power_button qemu_fw_cfg button
[   26.407586][  T279] CPU: 1 UID: 0 PID: 279 Comm: run-lkp Tainted: G                T  6.13.0-rc3-00001-gf8f25893a477 #1 1ddff3390d23c70538fc5495354291f300c5b61c
[   26.409304][  T279] Tainted: [T]=RANDSTRUCT
[   26.409883][  T279] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 26.411181][ T279] EIP: open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[ 26.411815][ T279] Code: 8b 71 08 83 c1 08 85 f6 89 45 f0 74 39 8d 7e 01 89 f0 f0 0f b1 39 89 c7 8b 45 f0 74 2b 89 fe 85 ff 75 ea 31 f6 8b 45 f0 eb 1e <0f> 0b be ea ff ff ff e9 47 01 00 00 be fe ff ff ff 39 5b 28 0f 85
All code
========
   0:	8b 71 08             	mov    0x8(%rcx),%esi
   3:	83 c1 08             	add    $0x8,%ecx
   6:	85 f6                	test   %esi,%esi
   8:	89 45 f0             	mov    %eax,-0x10(%rbp)
   b:	74 39                	je     0x46
   d:	8d 7e 01             	lea    0x1(%rsi),%edi
  10:	89 f0                	mov    %esi,%eax
  12:	f0 0f b1 39          	lock cmpxchg %edi,(%rcx)
  16:	89 c7                	mov    %eax,%edi
  18:	8b 45 f0             	mov    -0x10(%rbp),%eax
  1b:	74 2b                	je     0x48
  1d:	89 fe                	mov    %edi,%esi
  1f:	85 ff                	test   %edi,%edi
  21:	75 ea                	jne    0xd
  23:	31 f6                	xor    %esi,%esi
  25:	8b 45 f0             	mov    -0x10(%rbp),%eax
  28:	eb 1e                	jmp    0x48
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	be ea ff ff ff       	mov    $0xffffffea,%esi
  31:	e9 47 01 00 00       	jmp    0x17d
  36:	be fe ff ff ff       	mov    $0xfffffffe,%esi
  3b:	39 5b 28             	cmp    %ebx,0x28(%rbx)
  3e:	0f                   	.byte 0xf
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	be ea ff ff ff       	mov    $0xffffffea,%esi
   7:	e9 47 01 00 00       	jmp    0x153
   c:	be fe ff ff ff       	mov    $0xfffffffe,%esi
  11:	39 5b 28             	cmp    %ebx,0x28(%rbx)
  14:	0f                   	.byte 0xf
  15:	85                   	.byte 0x85
[   26.414405][  T279] EAX: c406c2f0 EBX: c4004008 ECX: c2599185 EDX: ec4bedc0
[   26.415331][  T279] ESI: ec4bedc0 EDI: c144fde0 EBP: edf3dd0c ESP: edf3dcf8
[   26.416318][  T279] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010202
[   26.417258][  T279] CR0: 80050033 CR2: 004e1a10 CR3: 2c4b7000 CR4: 000406d0
[   26.418217][  T279] Call Trace:
[ 26.418680][ T279] ? show_regs (arch/x86/kernel/dumpstack.c:478 (discriminator 1))
[ 26.419395][ T279] ? open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[ 26.420080][ T279] ? __warn (kernel/panic.c:242)
[ 26.420669][ T279] ? open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[ 26.421369][ T279] ? open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[ 26.422017][ T279] ? report_bug (lib/bug.c:199 (discriminator 2))
[ 26.422798][ T279] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 26.423456][ T279] ? handle_bug (arch/x86/kernel/traps.c:?)
[ 26.424048][ T279] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
[ 26.424725][ T279] ? handle_exception (arch/x86/entry/entry_32.S:1055)
[ 26.425536][ T279] ? debugfs_leave_cancellation (fs/debugfs/file.c:278)
[ 26.426343][ T279] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 26.426977][ T279] ? open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[ 26.427665][ T279] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 26.428307][ T279] ? open_proxy_open (fs/debugfs/file.c:90 (discriminator 10))
[ 26.429504][ T279] ? debugfs_leave_cancellation (fs/debugfs/file.c:278)
[ 26.430226][ T279] do_dentry_open (fs/open.c:946)
[ 26.430821][ T279] vfs_open (fs/open.c:1076)
[ 26.431374][ T279] path_openat (fs/namei.c:3829)
[ 26.432010][ T279] ? stack_depot_save (lib/stackdepot.c:686)
[ 26.432760][ T279] ? set_track_prepare (mm/slub.c:937)
[ 26.433483][ T279] ? getname_flags (fs/namei.c:?)
[ 26.434155][ T279] ? do_sys_openat2 (fs/open.c:1396)
[ 26.434795][ T279] ? __ia32_sys_openat (fs/open.c:1417 fs/open.c:1433 fs/open.c:1428 fs/open.c:1428)
[ 26.435544][ T279] ? ia32_sys_call (kbuild/obj/consumer/i386-randconfig-054-20250108/./arch/x86/include/generated/asm/syscalls_32.h:317 (discriminator 1141047296))
[ 26.436271][ T279] do_filp_open (fs/namei.c:4014)
[ 26.436934][ T279] do_sys_openat2 (fs/open.c:1402)
[ 26.437559][ T279] __ia32_sys_openat (fs/open.c:1417 fs/open.c:1433 fs/open.c:1428 fs/open.c:1428)
[ 26.438228][ T279] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-054-20250108/./arch/x86/include/generated/asm/syscalls_32.h:317 (discriminator 1141047296))
[ 26.438978][ T279] do_int80_syscall_32 (arch/x86/entry/common.c:?)
[ 26.439688][ T279] ? handle_mm_fault (mm/memory.c:5817)
[ 26.440403][ T279] ? lock_release (kernel/locking/lockdep.c:?)
[ 26.441403][ T279] ? do_user_addr_fault (arch/x86/mm/fault.c:1419)
[ 26.442202][ T279] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234)
[ 26.443014][ T279] ? irqentry_exit (kernel/entry/common.c:367)
[ 26.443673][ T279] ? exc_page_fault (arch/x86/mm/fault.c:1543 (discriminator 1))
[ 26.444279][ T279] entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[   26.444945][  T279] EIP: 0xb7f77092
[ 26.445472][ T279] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250110/202501101055.bb8bf3e7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


