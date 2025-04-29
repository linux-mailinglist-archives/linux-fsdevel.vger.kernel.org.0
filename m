Return-Path: <linux-fsdevel+bounces-47576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D1AA092B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253DA460699
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1192C178F;
	Tue, 29 Apr 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rfCRYjTb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kwpPv2SW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1628399;
	Tue, 29 Apr 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924645; cv=fail; b=iqeZCrZ6FfSy9uTEI4Xuv+fY3pov2+FaDhTvfkChQp7+PqBYjddYzqAOQ6A+TE5ajWmU4FfgGVkqORG8zRKSMeNoifDnuDLE62rnzFs+r1/5LTRLT8i0Hv+fikIvrOGICjJSV6h2kasdRFBT/M3hzpfgQkncnupp9ICfHqiDICw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924645; c=relaxed/simple;
	bh=5Z6IvF3r9RZJkjwDmFln7Ie6NLD9C44K+Y2bideObv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=noknoFQZYDjBTG0AriWtWv9zuXe4juSp1leOVsKG7zB7C2LvqpHaNe+GETHY86O9+srN6tDHVajfVuBlIvDBNd4sU8H5OcSuxK2Oz+69vgzYgFxYnVgiFw4IWQhlLPhqWqkfF5eK70vzDlPl9UdSmVBuE5p0R6Lz7PHQ+8fy2vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rfCRYjTb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kwpPv2SW; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745924643; x=1777460643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Z6IvF3r9RZJkjwDmFln7Ie6NLD9C44K+Y2bideObv0=;
  b=rfCRYjTb6StqS7ai0nWgd6h0cWT2ChZ6p+s3J/sUU3puTTSywi+EcK4a
   y4yqCa1HksuIeaXzkMIk/wIawjFgkI969Nm0AR/KRpRYOzI5DCmZjj4G0
   M5iYN6tH4svBdMWxaAEeWq7VF0kcl7X8mAyfPgcFHtGiwFAcBrmfE6o/K
   yoLLX8YPIAG7utUZvvxxXqxgIBqnQSd7uPRu50OxJuo5PtnEMMU0tsBU1
   v/28I9JKgf8c6h7F1AnFAH6tgIYOHMNY7Mxpsyg0KMughWB4q5MrnUYQN
   lqayp1l1s4afTPUfFbxN2VzcvG9yHvol+YuFgFQKIUkD+lK9ZzgxcBRZ6
   A==;
X-CSE-ConnectionGUID: O6yCRjnhR5WHM+MNF0d6Bg==
X-CSE-MsgGUID: wKzB78WhTg66hh4hiaN/BA==
X-IronPort-AV: E=Sophos;i="6.15,248,1739808000"; 
   d="scan'208";a="77461088"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:03:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv3ungiw3UYJQBuaNnkDBFtu8pkOArX8CEa445e2U4f5yCINUJDqkjp4RvjRVoAP4iZLeIvYxYjPqzaA6ZBsEbZvqqiV9pSikGYZSqPVjJv8ZFXlakYg21Om2woRteQOqkc7WeLslhBuHXf2bHjvf1ZWCaNUO1upXGjlXiIB1UgJz1qdEDK/mvWWLe2i+euoeUGpYqIA5xOHOQDcQdcUKB5h4g7td0D1o46YKId1rzWoufv5dSKYkVoht2YRRxUmj+NwQNok8pe3fAxFP/PvEoBDaOv4KBhgiPJ4J0oEm/ZMYWboDbRLm/jdXCwztQL2+oirCCG5dd9z5emji4NBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z6IvF3r9RZJkjwDmFln7Ie6NLD9C44K+Y2bideObv0=;
 b=rKi4YlgwCP6E8QUVSjrCvlVWXM0wZcPkZkijsUlTHOGZQAV1s0JuEQvmyW1/jcqLkY0HGONjeerfgVFCY24SpjsAFztJDnw9zuWnh570u73kQT2EzTarDYgboV/D5l0G7ZpV213kopCUffwOCyNwr85L7RSpEaiUfLELb07BCIc/oTvPkOWBYafuMjqMNiV4XjudkSVcLVUGz9OG4fE3Ii8fqFY+gPgYKJqGK/kJihFQVV56emAaqHfabWtJiYZcrCOhLj0mHmxFZik0/LZmg8zjsrziwtVAR5yL7p8Avw8uuwKyfYCsDxS+lux+Ud6yLsIjEHGfXGEJC83SoqGTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z6IvF3r9RZJkjwDmFln7Ie6NLD9C44K+Y2bideObv0=;
 b=kwpPv2SWr5Lmm8BxlC2LBSXdiqbKAcOahrI92IWUwti/83oAsvvT29iLpOB2d6i94fn7WxIArw5wVpmuoz9sn2mVXe6yNPxIe6poJFjj1tf24lkv4AhzFp9KN0JTF6viWiG/gNWaxarPjXQVRV9uYg92dEoAIxOdsN/OsAoYCj4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6447.namprd04.prod.outlook.com (2603:10b6:208:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:03:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:03:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Md. Haris
 Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li
	<colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 02/17] block: add a bdev_rw_virt helper
Thread-Topic: [PATCH 02/17] block: add a bdev_rw_virt helper
Thread-Index: AQHbs5KzXx0QRjwzy0mUjG87WueCIrO6haIA
Date: Tue, 29 Apr 2025 11:03:52 +0000
Message-ID: <9f2d2ff4-2aca-4e1c-92d7-2063c21be40c@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-3-hch@lst.de>
In-Reply-To: <20250422142628.1553523-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6447:EE_
x-ms-office365-filtering-correlation-id: 9b5c2e2e-cd89-4e43-552c-08dd870d86fa
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEROb245VXozd3RrNUxUVGY4RWNmWTV1VVlRZW5tNk5uSFcrVXgwQ0pTemk2?=
 =?utf-8?B?L2FzWjEwRHd6OXc0akl4bUxYT2pFMmhBK2hDZzY0STQ2c2VPNlJ1TmYzWk8w?=
 =?utf-8?B?NUlOdnRLd0xqMEFOSHBKdE0zbVZDSE05cnB6bmpQNEprSnh4cU44dkw4Rld6?=
 =?utf-8?B?dDJjUEd4N3FFTEVrNjZTYjd2eUtGWFVSVXRSTlpuOVFiOFAwTDZIbGJlMHJh?=
 =?utf-8?B?WmlyRFJBaUcrSkN2blJIbW5lS2J3TFlIMnZBNVZQYkdkWXFLeVhDYkFRVEFI?=
 =?utf-8?B?aWY0czhDSm9OZktLdFh5N1lxQmQxUWZyRTUwS2dmQTN2dHA4NlpqM09tSXBi?=
 =?utf-8?B?RW1oQ0VwRlhXWTd1WVZiZzVjVlVsTjM5YzlWc2RiODlSTWsvUU45TENHeTMr?=
 =?utf-8?B?NjhvWkVBVWptdW15amxoWno5TDRGdVRqeS9XQk9OY2Z6ZE5XZkEvU0ZaemFs?=
 =?utf-8?B?cXpXQlUyVzFJRHNKRnR0NGdlVE5SeHdiVUJGQUxSMDErWXNLUm15Mk1MblA5?=
 =?utf-8?B?bDBXdEJ5YzN1RlVpbHY2bHdKNXJUeVNEalNlQUJHaGwzVGQ1MlRxQ2xqcEdo?=
 =?utf-8?B?emhjNXBNSGF0eUNJQjdZS3hScUxKVmZLVHB5ZXprYkd4SCs5WkV0a05hbmtB?=
 =?utf-8?B?ZUE2Y1V3Q2NIZTB3RWZQcDJiV0w1ZXJlOFVBei8xZ0Q5bzNzcVUwTGV4TGN1?=
 =?utf-8?B?SFA1c0xqS1hEcndNQlpYYWRTeTI4K3BaRGxZcFY5UlprN0ZsbWlxYXlaaEgv?=
 =?utf-8?B?N1RkRHREbmFRLzBzazVrdDYxMGpEUzBLNGZrYjQ4dU40YUNReWVBcVVTTFQz?=
 =?utf-8?B?ZnNXOER6YXllYVRyZC9NRS9KaVQ0dkRmZDNUQ3VJcGd4VzI3d3hhM3ZlTjVy?=
 =?utf-8?B?eVlIRVFXank5UUgzME5ZcVUxM3dpZ2pKeUVUNGJ1ZUxxZWVROUdoVEkwbTFG?=
 =?utf-8?B?R25rY05BMm9tWWNDWlkrT2h5UytXQWhhMlU0V0xITVZ3WWlPQTYya1cxRlUv?=
 =?utf-8?B?QzV2TTl5d3NnN3hmUmd2N3RGV0xIRm5TMmNLUXcyd29UQ1o4TEh2S0llRTRw?=
 =?utf-8?B?Rkd2N0xwS1JHa0RIYmhsYjNUdEh1TEhvRHlCWnNYcXBuLzRnRFBkM2VscmlE?=
 =?utf-8?B?aUgwMHdTNXJIbWt1UVRVMEV3V1lmNzliY1d6MWVHUGNrR0dBOGl6alUvbERG?=
 =?utf-8?B?NWdMUHdVVmVzVitxUE5uT2xxeXp3bk52UktYdW1BTkF5VS9aU0JVR1JVR0cx?=
 =?utf-8?B?anBpZmlQbkhrSTd0dXhoeFJNcmgyL2NDS2FJc3ZnQ281Q05ib0pRR0lvUXc1?=
 =?utf-8?B?REd0V0JRd3dIZitGejVBVFFUbkJJUmJYaDdMZ1RXTWNMaXFUMGp3Ny93bFlI?=
 =?utf-8?B?QmJ3Rk9IdHNoYlp4VWlEcTlCeC9VcGU1aW5NckhnTmJZNGZHMytxR0RIY2Vu?=
 =?utf-8?B?aEtRNXk3WWJkSzN0bUp0bXdibFhDVmRCa21tL0YwRmFkZlRDVzEyMVZubnRt?=
 =?utf-8?B?c1Z5VmlDQnZEcjdFcmd0VURzam5rYW5vcDVwOTI2NGlyTVpTNHBHSHZ5RWhq?=
 =?utf-8?B?ay9oUE5oQVEvcitybFE4dTl1YWNRelBRcWYyVWJYaTFWMEhtbnFPZXR1K3RQ?=
 =?utf-8?B?SHRYWDdEVEZpdjBxbUh4Y0xHdUt2TVVUczR5Y0pFNkFWSFI3QnNtN2trSW9m?=
 =?utf-8?B?VUY3S01PV0V2d2NGeEJvYmp1em80bU1QSllvVzZVUlRxOGF6eW1hY1ZzaFB0?=
 =?utf-8?B?dFFxV2FPK3Q3d0tpcytSUHVOVTlDMDJMWmZTOWQwSkkrTWY0U0xWZUI5R2hO?=
 =?utf-8?B?OUFSUWt2TXFTYnhxS3ZNZjNPSVhxZk8rQ0JxNnZiVjh6a01XUDRSdEQzMUlD?=
 =?utf-8?B?THVBVGtwYW9RWW9wZkVnREhqZTE5WUFOSXpCb01TRU04aGdWRXZIZGVSc3Fr?=
 =?utf-8?B?M1dPSE9xbDRXc3VXMVpHTlJ1SGZybVR2R3lnd29kUVhPSjZNWHFwdlVQNGZF?=
 =?utf-8?B?d2ttdjRpU0pBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWVMdmd6YW4vT2xVanI4a0pqNDREVlRMT0gwbVdTV0VuMmZ2NzJ5dDZDdUpM?=
 =?utf-8?B?TnkvdWFDSUV1ajNGdGVDZnFWd0JEQ1p4cTllWDBCQzV5b2ZVTDlIelNQZ3NT?=
 =?utf-8?B?OHFEWWQrVlRoQkdTMHljY0VrV1poTzBDVldXM1IvenRkV0ErRi9pcG90TUY5?=
 =?utf-8?B?UlZsNFE4U3RVbGhyMUxxQVpmSWhIVllpVEMwLzl0NzliN2p1dGlBbjJCUlVN?=
 =?utf-8?B?Mlc1Ny9UQVBieVBYZVNBSmNWM1RQWlJ6MjlpeUwreUxMbFJFRG11Rm12c2VK?=
 =?utf-8?B?VStrZk9ZSzZoNitZV1F2S3YwdVRwUHJWcTRibmpDaXk5TGFYeXdzSFcyUHph?=
 =?utf-8?B?UkVkclRsaGxxMFIvbHFtS0NCeEhKejc1M2lJdXphMFFrZEN3ME9lblp2bjdm?=
 =?utf-8?B?UG5mV29oWFJjRUNiVHZ5MTVFd1ptZmZDWk4ydVpPUExzbk5QNmVvNE0wR21G?=
 =?utf-8?B?dnUvNnIzSFpzdS8zenE1SHpZVzBKTkFkaHBsZkRhaWprRUp2aXgzcHh4b0hE?=
 =?utf-8?B?Y1kxcFJGdVVFSjBibjJiRGxtbUQ0UHNCNWdsWlJ2NW85a0hnK1FTa2J6TjV5?=
 =?utf-8?B?b2ZNb0xoTncvZ3pjUnVUWHV1ZnFEQm15VlRZNzNMRDk3VkN3UkNydGwxZ3lP?=
 =?utf-8?B?SkZINWdZdUdrclFZSkJNcGlzR2NLZ0hZSVZWMVdWTTNubjdmSTRyb1ZIdDcx?=
 =?utf-8?B?MmRueGdBeUpMYlNIZFRITUtWZDcrc1RxZEFKeUM5Um8wTjhOUm1PdTBWVXlY?=
 =?utf-8?B?S3FQdjJXLzNXS3hFTCtQSHA3MEJldUw3MHNhSjh5TkNLYXY3clA2aVlCRWV0?=
 =?utf-8?B?QURBTitmZEpWbTdYTHl1d2pPb0RJZGVGRlVCQjFYaVcrTnhycy9aV1lTYjQz?=
 =?utf-8?B?MHM4SWhpTStpQy9yOEF3YmxMaEpJcko1OEE3RGlVd3VlYzhteFRIRGZGV25R?=
 =?utf-8?B?cmw4L0FxTkpLVysvZTV5SldjNFEwZmhjZysrNmVZUXB2a1c5N3AzVmluY091?=
 =?utf-8?B?N29LcVBsTUxaOHN3OU53bXVURytQMnFRQm1QeGNTVEU0eVJkUU1ibFp4dUZQ?=
 =?utf-8?B?TEdwQzdFZFV4TlA0NWxsaEVVcWpJTGNZOVJRZzczRnBjRk5kRThGWktVSWVk?=
 =?utf-8?B?M1pEUVU4d1NaVFlUKzVOaVVtNmE0SkxkL25BSHB5V2VlR1AyR1dBU25wRi9L?=
 =?utf-8?B?bW9FRDdSeFBVcWdrRlQ5OVFFOW5RcFMrblkvT1RYMWFEM1JoL0UzV0xpZmN6?=
 =?utf-8?B?bVNLS0QzQ3BBWmt0ZS9tUVpHclNxd280cDg3NUdJL251S2taMTRheXlHdUxC?=
 =?utf-8?B?Y1ZzRUdVMFNHMVEzVUpLYjVJT25ucndjR2ppMXh5azFwQjFZZ1A3SnZNa2o3?=
 =?utf-8?B?MGUxUy9YbW5lTlJWYzNJdE50K2RDMlBYUmlWaU01M1JncFNuWkRLdnZKdURl?=
 =?utf-8?B?U0xNZCtNQjNuRy9tcGtSdEtodmJTMFhzMExkR1J5dVNLUGhNcUQxUVR1T3FX?=
 =?utf-8?B?dVNkRzczSXluaGlJaXdpRU9MS2cxc1MxN0FHaUZ3Z1JQVmdXVy9TWGlxd1U1?=
 =?utf-8?B?S3lPejhSRk5hWCs5R0F5aXp5bG92WFk4UjRvNXdPREs5ZjVDemhCaG5NbXZT?=
 =?utf-8?B?UXJici9NaEQvdkpxNDBuWWNIcTh5aUxPa1BiYmE1ZWI3OWVud3pKNG1ZYWdw?=
 =?utf-8?B?MXVCQzlGZW5tcEhFUFE2UCtrZ1BabDczUmVwa0czcG1yTGlVbGxKcEJVbFpW?=
 =?utf-8?B?aXBOTjMwVHh3aEZTNWVOU0VXcnpCVEVpVjFoUFhTSGptaTgyTDhFTWd2NXhu?=
 =?utf-8?B?T3ArSjBVKy9kcml5anVUaFB3YStFN1FySlduekE1NWZJbTNuekJQc2tiWTRD?=
 =?utf-8?B?T25XUmlkdmZIV1FwSVRYUWwvbHlVTjJPK3ZKVGkvdlVLeXlRZXRaUE91MFJz?=
 =?utf-8?B?cDFMK0JacXUwRHpLU1ZsaU9MaDBSUzhudjcxMExLQlhyU0lyZVU5ZXBFV2Zj?=
 =?utf-8?B?WHd1c1dhTXcrQ0h4cy9CYXR0T3oyUmQxQnp3TkJuVFFWRm4rM1BPU1R0L3lW?=
 =?utf-8?B?RzZOWlJPK1VSbWxrUXJiYlIvNXQrUjJmdE10NjRBUitwRjdqN1FseGdYbnBs?=
 =?utf-8?B?VFkxdmt4aEl5UE9aNXE0OHJSMENjZ1NOUVE1a2JJVXR4Qm95aERNbFQrZ2Nt?=
 =?utf-8?B?VTJxbU5QalYyMDEwQ2tYZ051SkxwZ2VKc0QwYzdnaXBzOFBoMHRFYWJtNFJO?=
 =?utf-8?B?WkkvU2pKQlJXbE4vZmF5ajNEM1Z3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1A026F0CC8F641873FDE743A6832FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BeGNh9ULpYC3PMJP0FXstUQOiGN12tbohWthXni7B2XiUzKQn5vQ3DLLnQa7Qz1r0pSdMfve7FMumlMzpNwg1EDYHY3ndS71TQ7UeT1XV281NzrEIo515YsfM7uCny2xvxMlL5g81aG57cgkydMV0QxTpZvjvH4OAohnVsahtlf1TdJuUNvgy+LtElfQm50quP+I3ZTyTgH4WdHJRAO3AUUqpmEUde1VZatVKqoeU9TcXbiIPziC4wZjlCOtJkLROcnOBJBbZYVX1oPWeRFrO9Bvdr5eu6FI2h61TlcVGGOm8Ki5Mpt+gZE+7Q5DuQPSiKpnHgycUjaR5w0zFCvaAOqPmu31mAZtpXKnQV/5PCQHsXuXm4uhZqUqrJK1+vFWKjdCSRNJe73giR5is5MpJ4zrScMyHYYg75lIC2jnrmAoepOeZYEA89kWAzugF9JSbGpV4gjusxNnYXnhEra+awPXo3EqEqXSpwzh6Un9IpepmMSzrpiXk0tZGpHQmm9gnRQaqobdBL/c1qoE9FTlOi7bx4DfPGNoX/o2URQfceGbBa0us2hGwfI10K/bbzMXUbJiy2Dx8MnoF6uF587i5/NNVvbd1HwUCScgb0OJg8A1Uq0THuS2O9jBobgR/HLX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5c2e2e-cd89-4e43-552c-08dd870d86fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:03:52.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8aU7zW7ImfFR/oEBh/4Pkg8ThvUHzd0PqSHU92116e+ijDCLdttwj0ivUj8Jo/xSaTAD0izOpsxsep6kfOcqiyAD22AWT63e0DDgRfiWHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6447

V2l0aCB0aGUgdHlwbyBmaXhlcyBhZGRyZXNzZWQ6DQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1
bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K

