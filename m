Return-Path: <linux-fsdevel+bounces-59733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6987B3D80E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 06:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6E1760F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 04:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593E21D5BC;
	Mon,  1 Sep 2025 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="byMIiMaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFA1A275;
	Mon,  1 Sep 2025 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699351; cv=fail; b=TmKwJyW7tVvbxQfewDxSzAe7ogVgzP/BbB13WEJGmRL9g6RuhYWPh/qEBulzuVmkS3g601HJzKAGcmykfC5lC30W0m1TSZhPRgKlSiNLvAGqei22KBZW5zeRTY9yjORIp14ZC2+qcZyxOPqJ06SD/BdLhmDKaamHanC2r56HTBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699351; c=relaxed/simple;
	bh=B+ClDtUvkCp0MKFK03SUauHCX6T8/YxrXJpyuBrBjjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DqC+jRYIXg5i9OlbQAE/8dgZXrGlOIqB7zu346059GW5++4dwB9PGZadMG893+8J7NaOmbcHl/juoQioo+fwabeMgzyx2vJ3zLhDISJYjuZoxY1IRmwtTXD0mBmrc44L7bgTVCHSAU7XZ+gEjkeLLb2I9o8jIxE6aT5cv0P5fEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=byMIiMaZ; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1756699349; x=1788235349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B+ClDtUvkCp0MKFK03SUauHCX6T8/YxrXJpyuBrBjjU=;
  b=byMIiMaZK3yNBKtZNJmh/Bk68OEvR6106yHIXziKAI8q+3KZonCXd8hd
   SRE97NUZX4O3Jr9ULjOLnByrrt5HCfVEWc6834llF3G2GUsgDcyo7/lUN
   lkhRxLs4Z0a0AKTQ01xoJwdYFkOQeZ0QHL3VD2xwCFNqCX2PIt2AycGG0
   o/wHP00b6wi/7oqHt1hU1Fkm0sJOa/GMkEvJ7/tK2d9sjRpRWEKq/h/un
   4Ore9auadVLhzYm8iNKlRbAdkK9uR8dNgoCs7mARleSUjM036DT8IuUzj
   Z94Y6oc45NS/Q3M2tvw1TPvUTu5ivR/SBQlMcxxVEIEWmglrsGqd7eGd9
   w==;
X-CSE-ConnectionGUID: RSyeDszaQEWju2eFDdYvMw==
X-CSE-MsgGUID: WFiMv4MzT4u9DlM0GrsTcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="166396110"
X-IronPort-AV: E=Sophos;i="6.18,225,1751209200"; 
   d="scan'208";a="166396110"
Received: from mail-japaneastazon11010050.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 13:01:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unf7YxGq6SUSHCT5N3O3pMIopPMKdcwwgEFyq/I9UjVnOQVCRuBL035EfTW27UfHOYT1ugfNG6x9YpKwaqOlloFzkqdsJreXjAG59xOuhkes+t6E7KAooYnxRsqVMnEt9afCa6gMWkxrKCeK3Y2Lfb5qdiD5dHKKPSm5nrK6Ihh1bHbtVQEVlhoqAHH3/a/3xGPZHN2Zhprzf1RHhHh4myGTt6oK4+qyTKBGLUYzXl6y1bJKDHiq+O2B/rMl209zEi9w6McJ0ckRefCvd3PUmxz/cC8mGAq4xhzO+HTLcue7KOP+UmtwpZJPZwJVnr/R/WzmF0/mp0rYb9434tASiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+ClDtUvkCp0MKFK03SUauHCX6T8/YxrXJpyuBrBjjU=;
 b=Sr+wjweQ5xHFLwMdqZvxeFVVZhWaKxoo0ciM6ojUEEAco2JGKIvohdIIIeow9qHdvY45lupuqCW+xpjeVxzBmrsK1SAsDeHcS9UmeuMqj1Wrq2XFMDii0P1TqLvmuyOCaJKA+jEW5l4Ex9R8Pm5qhwUF3GQXT+br15zTc2YRIFToF7tFXWGRvscgt8l5F+MHwHiJnuqNi/AChLxoy1WmCd/wN/9uXDKdBhxN2vLZlTjqaM6Xnuh32bC2zgvz0n9Mn/4bDhr6jR7EDjnC3ejkAh4lEKF8aOsZujz1c0iIj52s5xGq4sgnxUbc9nCYoyHsBs8BpMGV+bgiIRGq6QLQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by TYRPR01MB15099.jpnprd01.prod.outlook.com (2603:1096:405:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 04:01:06 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 04:01:06 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Ying
 Huang <huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH 4/6] dax/hmem: Defer Soft Reserved overlap handling until
 CXL region assembly completes
Thread-Topic: [PATCH 4/6] dax/hmem: Defer Soft Reserved overlap handling until
 CXL region assembly completes
Thread-Index: AQHcExbJETQ92cR6jU2KThNEYOARn7R9w+aA
Date: Mon, 1 Sep 2025 04:01:06 +0000
Message-ID: <98a7baf6-1fb2-4d8e-be87-2ca6cf6cdc0d@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-5-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250822034202.26896-5-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|TYRPR01MB15099:EE_
x-ms-office365-filtering-correlation-id: f99570a2-ea15-4730-237b-08dde90c2d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVI3R3FocjVNVGFKbUNObHB3Ulh4WGp0SHh2dFVQdGxxbVJTeUpxWGU0NnIx?=
 =?utf-8?B?TEg0QzdDcmRQVHVYN2lQZCsxeHZUeWdrMzlVQ3p5SGVpNEozem9aK3hhalBB?=
 =?utf-8?B?d2tNSVFTOEZKd09PNkdjcEZTa3lkM2VZTDRCYTZGME5VdkluUk9neHFxUXVO?=
 =?utf-8?B?b1RkaktTZzFIb2d0SFNYeU9OZ1p6OTQrR2xSem9CcEVtZXlSVFhvU3g3UXB4?=
 =?utf-8?B?cXJMcm1iUHlHYk53VkZMcVFvaE1tcUNEbTFTVjd0M2R0ejFzTkRPTEh0NHBk?=
 =?utf-8?B?NDVmdVVrWUQvdlpyNGJickJXVHo4TmxOSmNQdUhQdlpIOWQxVHRQVEd6SE5V?=
 =?utf-8?B?c2RGU09pMXF1WllSbG9jVzBTQ3JnMUlnMUhLMEczeWNDU0FYajdFY0ZLWW4r?=
 =?utf-8?B?RE1UeHN3NjlaY1IyMUhlcU9yZ0IyVTQ2TU5mNXdpd085ME0rSG5aaW5EVG5U?=
 =?utf-8?B?bTdleUhDSzgxT25lM2FLTVhzdHBLS3Y4MXlsWUpPeW9GZEhaTG1HM1MrYlNs?=
 =?utf-8?B?R2xmbXJnS29lb09MOXdHbXF0cTV2OW9nZlBzQjZXTXhocjJNREFST0o0Q2Rp?=
 =?utf-8?B?ME9MVU9hSklLM0hLRmx0QUpRYzZva2hKZTVTZTVlTFVCbmZqQmJFVm54SnFZ?=
 =?utf-8?B?MmdoNVByN2NaazhTSWZod2VhdEJpNnE1Q2RwZ0tiTDlBSkRhbkNLSk5rRnJL?=
 =?utf-8?B?K1ZHaE96emtOazE2c0hHa21CUGVISnBXUFVGVFRwL1FQMEYyb3lyNGFSR3VW?=
 =?utf-8?B?K0x4enBTWUNvdXprNjcwbXZSMUgreHliV1JsOUw2UXBLS0F6VGNha1FZUHdq?=
 =?utf-8?B?ekxrVXVlSDg3WHRUYjhDbHV0MCtPUldHZWNJVElhMXhRdUM5UStqUXhvSUpz?=
 =?utf-8?B?NEJ5NnV1VmxObzBOYjc0T0N5alZMQmJ5NFdMNE12NGw2WEhheWFtbzBBM0tn?=
 =?utf-8?B?azZPZFR1SEp4Yk5BblhpR0p1RitWeU5VK1pCaHRDQnhzdWVKcUlFT1RLTlA5?=
 =?utf-8?B?d0F1QTczZ25vVFNCbk1ENTU0Rk5LTExPZjJjSVgwNkFPdUd6OWluQTF5RnFy?=
 =?utf-8?B?c3Rpd2ZxdlJhdy96NkhlYTVVMmdlWWVkcWVJV0dOVVNxL0pwR0pvazQ3dmNP?=
 =?utf-8?B?cjdrSWhrMHREVFEzdU51RlFKbG5vNzROc2FweERCanZmdHMxbXhxVUI3OHNs?=
 =?utf-8?B?dXlKMkhiM1pTY3dtbHdKSEc1Nk4xeWxZWjRHS1pRY2tndnd1Yy9wVnFXcjBT?=
 =?utf-8?B?dW45dGhYQ0c0QitUR293M1d6MFpoeDJvL3pVTzA5ZzQwQjZQdEVTczR5UUxt?=
 =?utf-8?B?R29PWHBNUVAxQ1lma2pZWlcrOUxmSnFYcDJkOERkNnVrc1RhbWkzbElidXdG?=
 =?utf-8?B?bUJaNlhHRWZQeXRScE9hdGVEN29zVWRDRjdsUGNHMmk5bno5bFRPZHdPN3Ba?=
 =?utf-8?B?ZVQwbHZoYW5RR3BxZGNjbEF4dlRHSjh2ZmtFVCt2bTdRV2k3NTBhWUY2RkxF?=
 =?utf-8?B?NEtNVDlTak82OWdtMktaZ1NwYXlHL1I3T2QxcnFpNWdRTTUwYzlsRUlMTGpn?=
 =?utf-8?B?ZDFtaFQvbmh4aE1JSDhOakZSc29ueGxvcXJDakFDTUpGelBvd3haUDNuaW12?=
 =?utf-8?B?eUZhd3R3bzF5RS9uSjZ0UGtlalVTZ2F4VHdwbmh6NzJBMWNkQnBjMXNCWU9E?=
 =?utf-8?B?YW9zM2dtcU9rLzBnS29VZ2ZSa2syem85NVEzZXFsTWFXMjhaOXBHd2dBQlNM?=
 =?utf-8?B?WTNFS3RqWTE1SGhUTkRTUUhsTnhCRk9RUkpXekhCcFNFMjJRSUg1WE80U3Q2?=
 =?utf-8?B?Z2dmWEZkMFNUTWIva2RTallnNHFVOWp0WjVhcDJyZXE2NmFHNW9lWkI1eXFl?=
 =?utf-8?B?REoxOGVJb0M5Um45Y0dvUjdsTlB0QytwK21BM3VQZlNDZDJwdGxCd3hPNDcx?=
 =?utf-8?B?bzJ0Zi9UbVlwNFlyQkpLOE9XNnBybHVXUzJLbzFwU1F5SmpnOUxBT0NtYU5X?=
 =?utf-8?B?T1ZjUXg0bXBISzNlS3BsUys4cU9YRW5KcktQUXR6bkYybGdqcXlSY0lYUS80?=
 =?utf-8?Q?yaCZdw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWF5NW5Ic21zSHVNdzBIckpJbEdkbmYwSFh5Wnd0QTBEYStzYnc1UHEraGEy?=
 =?utf-8?B?WWErRjlMN1FoNGJKRTQvVHZiNzJ4YkVCaDFlcWh0TVplQ0hSUTVhQlRxVXNH?=
 =?utf-8?B?YW5PMjYranV6WS9ieXo5amtEMjlpczE5K2VsckZzVUVIeExXL1FiNFlXRWpy?=
 =?utf-8?B?dDliR0l1OGZ6cFFxeFZ0ZVZtdDVObWZMckpEUVlBRVhLYk1SektZdnYyNGd3?=
 =?utf-8?B?TWVGSS80V3JadDZJVENWaThwaUlKMU5Td0hjOVVzNlpTM2hqYStGOWpKMFJ6?=
 =?utf-8?B?UTFWR0hVLytZT0t6SzhJQ1RMV1hrWHZNVmp2QkZPV09ZR0dPWGFTZVV6dkV0?=
 =?utf-8?B?bnAwUTNJVFUxZExYbGEzQ29ENVg0TDNTQ3F5cFBzdHMwQzFUWmE3aStvc3B6?=
 =?utf-8?B?WDdVTkVBRStzbnhvRGI1MmZBYVJTRzhjNXhicjNad0Z0UmRHS0wvL1JCaFhV?=
 =?utf-8?B?VEtPdzFLTVUyU1dMZXdWOE16TlBZY2M1bnJxNVRKaU9ieEZTS0E5SVh5blRG?=
 =?utf-8?B?RmpwUmpjaXRSaEdBbUFvaHdmQk85TzBUd2ZFNksvSnJCUkdkNUxNSThrTDJn?=
 =?utf-8?B?ejB1YXVmc3NYaVFvZFBVRHZmb3NTMHRSY25qRE5rR1czZXVLWmxodUd1dE5F?=
 =?utf-8?B?am9lZkRiYWJsVDBqSnRhc09OUFlGcWtkeURzZy90ZXR5bjYvM1Q4UmtRNC9o?=
 =?utf-8?B?RURPancrTDB6WTFJdVJoVTExb3RLMVNlSndMMCtScG9rYUM4cDFwSVdCeG9n?=
 =?utf-8?B?Sm9ySUxraHo0aS9CQTk4WGpHS01hNDVnejM0TWo3ditoTHM3bXFTRUFDRitu?=
 =?utf-8?B?VmsyMDkzajJGMnhHeVRzeUo1ak5UZG93UjBYd0tjQnJSenJ2emhuZXdoZ2NK?=
 =?utf-8?B?M3BXdzIxMHg3WDZzK0VHdTdOc2c1Q1ZnSDU5dGpPWWQvak1FZWRwQ1NLTDBN?=
 =?utf-8?B?RlJ2bEh3VUk0MEdrQUwrVHJSbTdBSDlnRUMvOTZKZnpnWjZubnp2MDR5WDB4?=
 =?utf-8?B?WXNTakFKaGZaUHpMWDBhK0FCZ282Ymlna2ZkTkJGMS9pU0RoZFRaUGphamtp?=
 =?utf-8?B?Y081RVZyM2FqSUFxcHpLOXkvNU9mUDB2SEozbVNUbjFxeDBZYzhFZ1poRHcv?=
 =?utf-8?B?SElnZEhSQzRybzJWQjdvczY0ZTd6ZWJXamF5elFRWXNJUG4wVzhjNU9VUDBF?=
 =?utf-8?B?WDBWUnZZQnpFVGQxZFJVZlpxQURJNlRkR0dwb0tkdS9rR245azlidmNvTjQ3?=
 =?utf-8?B?bFdsS2ZVUXRWMGtBb2JpdkNHbERYeTZnNDJMMHJnTzBSRDRoS0Qzbzd0MVVE?=
 =?utf-8?B?cWdHYlQzOXY1dkJ0MzkraFhzKzRXYis5OU0vcTRHWG9nL2xGc3lTRnVDNDZM?=
 =?utf-8?B?L2hkUnJndExrRFdrQXp3Qk12WHN1YXdEdkc1V1FpZHkrYWVhYUpSVUZvaXZH?=
 =?utf-8?B?T21idklpVHJ2dlBxOFJGbU04MVpraWpId0NWbE93NWZyVnZDQlpTSVVrOWtO?=
 =?utf-8?B?Q1dDL2Zma1dZbmV0SVRQTU5VeGFSQngrb0Y3YTdNZE5ZUmRkQjVodFNGcUIr?=
 =?utf-8?B?U2RWK3N4L1RyZktPUzBCRkEvYVZaNWVCeVllOU5rMk83T0QrSnJMTjZOc0hk?=
 =?utf-8?B?MU9EK3pvSFpRZ3c3NFNoOEpCdGRnTUZFYy9NQmdkVGQ2ZG0rL3c1b0hnb1l2?=
 =?utf-8?B?ZjhPRFdLQTMwd2ZYcWwxNE1kY0phajJ0ZFFGRkFobUJtbnhVY2RwQmJZY01H?=
 =?utf-8?B?Ri9XbHNyVTMxcFNZT3B1ekQ1S1ZJM2pqTXJSYmwzOXlQMWJjdDdjdkVuck9m?=
 =?utf-8?B?UkEwVGFEQktkclp1UGNSSUxzRzVzN0hWTFR5azROenlkcjRMbDhSVVhiT01S?=
 =?utf-8?B?alV3WCtuSWlFTi9ETTloR1BUS1JpV1k5b3BMRjloMDA2eEN3bk55SGd5MWdR?=
 =?utf-8?B?MS9Kc2RXNUpvMjFzdlQ3d25hK1VBYkRNVzkwdU0zN2d4Vm0zYkwzMjUwRnRs?=
 =?utf-8?B?Q3U5cXhLaHBIbXFoMlFxUnVLVXdYMi9SK2kzVm5Sc3hacVJ5a3ZBZ2d3dFQ0?=
 =?utf-8?B?bzNobFk3V2U3NzI1MlRrempqd2VQMFlNVkxKbVV3M3NwdnYrNVBEcVl4NFpY?=
 =?utf-8?B?TjlvcTB2MDJWVzM4STFNM2dtT0FldzBTT1JCRGY3dnBBRGJvem1FT0lVWFVm?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6851C487E82114EBCF9AB6382D13D6E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JIEdd+Mu1HwYZ1ep0+mWdxYQZp9UUqq8z71+D7RrhPXP0g0ENYDwVFz+ue6q9JBOCb28anNaM1eZMW+aoM81yrU7Cgz5kBfLMoV662YAAGSxFNYcqj8LTi+Sx+fOzq8z02afpkm2ngIEEnZOfGKxrThT62/pAtgf8qR8OVcIiKicC5VFvoZdqt3lwK1avHiQBXsDCi9PLxqjdZNiFw0WnYdGE2iVbyn5qjYEfCw98FRRbU7NKoWHU7B0VzHHZJM5S4y7PeomTHz9UwQ7A/MH9Iqg6LhWvBMoIQLzfcDnQQXpr3PPs6RfbuuQStGlE+Vih++k/0vMJe3O30oeNqulle0bFT8lHuX8+67r5S4lVDmcTlPw1CFPPsx6lJxb0Dl03woF+Vrlm7pgOaMspgkebzzMQgKrxI8JKb+FoRFjaLtO/SnRtpcKpPBQdz5uSsk5NqHXH0K85f5XIwpa926661uuym8Xuu82+9J5nmDg+X1ns20GJuQo9otDZBt6KY9f9jT2HSyIOwS1NcvaC2lP/EPn/UTtA4yYBWICGQfOQp2atpy1r34+POf/Zoc9u/iPy+3CbdOnMoBbpizKvzVAQdIxKjxpc8h6QqDmrFtyXKJHkC1008oO5Dllwax3n26Y
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99570a2-ea15-4730-237b-08dde90c2d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 04:01:06.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbpQQgzTgCCvmIN39ewIWB2mvbG4mIlppZdCZnuiqJKtNEzqWMTKwBc7Fxc97oMEftRHkENiNaMiz84tU1VAWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15099

DQoNCk9uIDIyLzA4LzIwMjUgMTE6NDIsIFNtaXRhIEtvcmFsYWhhbGxpIHdyb3RlOg0KPiBQcmV2
aW91c2x5LCBkYXhfaG1lbSBkZWZlcnJlZCB0byBDWEwgb25seSB3aGVuIGFuIGltbWVkaWF0ZSBy
ZXNvdXJjZQ0KPiBpbnRlcnNlY3Rpb24gd2l0aCBhIENYTCB3aW5kb3cgd2FzIGRldGVjdGVkLiBU
aGlzIGxlZnQgYSBnYXA6IGlmIGN4bF9hY3BpDQo+IG9yIGN4bF9wY2kgcHJvYmluZyBvciByZWdp
b24gYXNzZW1ibHkgaGFkIG5vdCB5ZXQgc3RhcnRlZCwgaG1lbSBjb3VsZA0KPiBwcmVtYXR1cmVs
eSBjbGFpbSByYW5nZXMuDQo+IA0KPiBGaXggdGhpcyBieSBpbnRyb2R1Y2luZyBhIGRheF9jeGxf
bW9kZSBzdGF0ZSBtYWNoaW5lIGFuZCBhIGRlZmVycmVkDQo+IHdvcmsgbWVjaGFuaXNtLg0KPiAN
Cj4gVGhlIG5ldyB3b3JrcXVldWUgZGVsYXlzIGNvbnNpZGVyYXRpb24gb2YgU29mdCBSZXNlcnZl
ZCBvdmVybGFwcyB1bnRpbA0KPiB0aGUgQ1hMIHN1YnN5c3RlbSBoYXMgaGFkIGEgY2hhbmNlIHRv
IGNvbXBsZXRlIGl0cyBkaXNjb3ZlcnkgYW5kIHJlZ2lvbg0KPiBhc3NlbWJseS4gVGhpcyBhdm9p
ZHMgcHJlbWF0dXJlIGlvbWVtIGNsYWltcywgZWxpbWluYXRlcyByYWNlIGNvbmRpdGlvbnMNCj4g
d2l0aCBhc3luYyBjeGxfcGNpIHByb2JlLCBhbmQgcHJvdmlkZXMgYSBjbGVhbmVyIGhhbmRvZmYg
YmV0d2VlbiBobWVtIGFuZA0KPiBDWEwgcmVzb3VyY2UgbWFuYWdlbWVudC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFNtaXRhIEtvcmFsYWhhbGxpIDxTbWl0YS5Lb3JhbGFoYWxsaUNoYW5uYWJhc2Fw
cGFAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZGF4L2htZW0vaG1lbS5jIHwgNzIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNzAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RheC9obWVtL2htZW0uYyBiL2RyaXZlcnMvZGF4L2htZW0vaG1lbS5jDQo+IGluZGV4
IDdhZGE4MjBjYjE3Ny4uOTA5Nzg1MThlNWY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RheC9o
bWVtL2htZW0uYw0KPiArKysgYi9kcml2ZXJzL2RheC9obWVtL2htZW0uYw0KPiBAQCAtNTgsOSAr
NTgsNDUgQEAgc3RhdGljIHZvaWQgcmVsZWFzZV9obWVtKHZvaWQgKnBkZXYpDQo+ICAgCXBsYXRm
b3JtX2RldmljZV91bnJlZ2lzdGVyKHBkZXYpOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyBlbnVt
IGRheF9jeGxfbW9kZSB7DQo+ICsJREFYX0NYTF9NT0RFX0RFRkVSLA0KPiArCURBWF9DWExfTU9E
RV9SRUdJU1RFUiwNCg0KDQpUaGUgcGF0Y2ggbG9va3MgZ29vZCBvdmVyYWxsLCBidXQgSSBoYXZl
IG9uZSBxdWVzdGlvbiBmb3IgdGhlIGNvbW11bml0eToNClNob3VsZCB3ZSByZXRhaW4gdGhlIGBE
QVhfQ1hMX01PREVfUkVHSVNURVJgIGVudW0gdmFsdWUgd2hpY2ggZm9yIHRoZSBmZWF0dXJlDQp3
ZSBoYXZlIG5vdCBldmVyIHN1cHBvcnRlZC4NCg0KDQpUaGUgaWRlYSBvZiBoYXZpbmcgYSAncmVn
aXN0ZXInIG1vZGUgYXMgdGhlIGxhc3QgcmVzb3J0IGZvciAnU29mdCBSZXNlcnZlZCcNCm1lbW9y
eSBtaWdodCBzZWVtIGFwcGVhbGluZywgYnV0IGl0IGlzIG5vdCBlYXN5IHRvIGltcGxlbWVudC4g
SW5zdGVhZCwgdG8NCmF2b2lkIGluY3JlYXNpbmcgZHJpdmVyIGNvbXBsZXhpdHksIEkgd291bGQg
cHJlZmVyIHRoYXQgd2hlbiB3ZSBlbmNvdW50ZXINCnF1aXJrL21pc2NvbmZpZ3VyYXRpb24gY2Fz
ZXMsIHdlIGFsbG93IHRoZSB1c2VyIHRvIHJlcHJvZ3JhbS9yZWNvcnJlY3QgaXQuIEhvd2V2ZXIs
IHRoaXMNCmlzIGJleW9uZCB0aGUgc2NvcGUgb2YgdGhlIGN1cnJlbnQgcGF0Y2hzZXQNCg0KDQpU
aGFua3MNClpoaWppYW4NCg0KPiArCURBWF9DWExfTU9ERV9EUk9QLA0KPiArfSBkYXhfY3hsX21v
ZGU7DQo+ICsNCj4gK3N0YXRpYyBpbnQgaGFuZGxlX2RlZmVycmVkX2N4bChzdHJ1Y3QgZGV2aWNl
ICpob3N0LCBpbnQgdGFyZ2V0X25pZCwNCj4gKwkJCQljb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJl
cykNCj4gK3sNCj4gKwlpZiAocmVnaW9uX2ludGVyc2VjdHMocmVzLT5zdGFydCwgcmVzb3VyY2Vf
c2l6ZShyZXMpLCBJT1JFU09VUkNFX01FTSwNCj4gKwkJCSAgICAgIElPUkVTX0RFU0NfQ1hMKSAh
PSBSRUdJT05fRElTSk9JTlQpIHsNCj4gKwkJaWYgKGRheF9jeGxfbW9kZSA9PSBEQVhfQ1hMX01P
REVfRFJPUCkNCj4gKwkJCWRldl9kYmcoaG9zdCwgImRyb3BwaW5nIENYTCByYW5nZTogJXByXG4i
LCByZXMpOw0KPiArCX0NCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RydWN0IGRheF9k
ZWZlcl93b3JrIHsNCj4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0KPiArCXN0cnVj
dCB3b3JrX3N0cnVjdCB3b3JrOw0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgcHJvY2Vzc19k
ZWZlcl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqX3dvcmspDQo+ICt7DQo+ICsJc3RydWN0IGRh
eF9kZWZlcl93b3JrICp3b3JrID0gY29udGFpbmVyX29mKF93b3JrLCB0eXBlb2YoKndvcmspLCB3
b3JrKTsNCj4gKwlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gd29yay0+cGRldjsNCj4g
Kw0KPiArCS8qIHJlbGllcyBvbiBjeGxfYWNwaSBhbmQgY3hsX3BjaSBoYXZpbmcgaGFkIGEgY2hh
bmNlIHRvIGxvYWQgKi8NCj4gKwl3YWl0X2Zvcl9kZXZpY2VfcHJvYmUoKTsNCj4gKw0KPiArCWRh
eF9jeGxfbW9kZSA9IERBWF9DWExfTU9ERV9EUk9QOw0KPiArDQo+ICsJd2Fsa19obWVtX3Jlc291
cmNlcygmcGRldi0+ZGV2LCBoYW5kbGVfZGVmZXJyZWRfY3hsKTsNCj4gK30NCj4gKw0KPiAgIHN0
YXRpYyBpbnQgaG1lbV9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IGRldmljZSAqaG9zdCwgaW50IHRh
cmdldF9uaWQsDQo+ICAgCQkJCWNvbnN0IHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiAgIHsNCj4g
KwlzdHJ1Y3QgZGF4X2RlZmVyX3dvcmsgKndvcmsgPSBkZXZfZ2V0X2RydmRhdGEoaG9zdCk7DQo+
ICAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQo+ICAgCXN0cnVjdCBtZW1yZWdpb25f
aW5mbyBpbmZvOw0KPiAgIAlsb25nIGlkOw0KPiBAQCAtNjksOCArMTA1LDE4IEBAIHN0YXRpYyBp
bnQgaG1lbV9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IGRldmljZSAqaG9zdCwgaW50IHRhcmdldF9u
aWQsDQo+ICAgCWlmIChJU19FTkFCTEVEKENPTkZJR19ERVZfREFYX0NYTCkgJiYNCj4gICAJICAg
IHJlZ2lvbl9pbnRlcnNlY3RzKHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSwgSU9SRVNP
VVJDRV9NRU0sDQo+ICAgCQkJICAgICAgSU9SRVNfREVTQ19DWEwpICE9IFJFR0lPTl9ESVNKT0lO
VCkgew0KPiAtCQlkZXZfZGJnKGhvc3QsICJkZWZlcnJpbmcgcmFuZ2UgdG8gQ1hMOiAlcHJcbiIs
IHJlcyk7DQo+IC0JCXJldHVybiAwOw0KPiArCQlzd2l0Y2ggKGRheF9jeGxfbW9kZSkgew0KPiAr
CQljYXNlIERBWF9DWExfTU9ERV9ERUZFUjoNCj4gKwkJCWRldl9kYmcoaG9zdCwgImRlZmVycmlu
ZyByYW5nZSB0byBDWEw6ICVwclxuIiwgcmVzKTsNCj4gKwkJCXNjaGVkdWxlX3dvcmsoJndvcmst
PndvcmspOw0KPiArCQkJcmV0dXJuIDA7DQo+ICsJCWNhc2UgREFYX0NYTF9NT0RFX1JFR0lTVEVS
Og0KPiArCQkJZGV2X2RiZyhob3N0LCAicmVnaXN0ZXJpbmcgQ1hMIHJhbmdlOiAlcHJcbiIsIHJl
cyk7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBEQVhfQ1hMX01PREVfRFJPUDoNCj4gKwkJCWRl
dl9kYmcoaG9zdCwgImRyb3BwaW5nIENYTCByYW5nZTogJXByXG4iLCByZXMpOw0KPiArCQkJcmV0
dXJuIDA7DQo+ICsJCX0NCj4gICAJfQ0KPiAgIA0KPiAgICNpZmRlZiBDT05GSUdfRUZJX1NPRlRf
UkVTRVJWRQ0KPiBAQCAtMTMwLDggKzE3NiwzMCBAQCBzdGF0aWMgaW50IGhtZW1fcmVnaXN0ZXJf
ZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmhvc3QsIGludCB0YXJnZXRfbmlkLA0KPiAgIAlyZXR1cm4g
cmM7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQga2lsbF9kZWZlcl93b3JrKHZvaWQgKl93
b3JrKQ0KPiArew0KPiArCXN0cnVjdCBkYXhfZGVmZXJfd29yayAqd29yayA9IGNvbnRhaW5lcl9v
Zihfd29yaywgdHlwZW9mKCp3b3JrKSwgd29yayk7DQo+ICsNCj4gKwljYW5jZWxfd29ya19zeW5j
KCZ3b3JrLT53b3JrKTsNCj4gKwlrZnJlZSh3b3JrKTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBp
bnQgZGF4X2htZW1fcGxhdGZvcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gICB7DQo+ICsJc3RydWN0IGRheF9kZWZlcl93b3JrICp3b3JrID0ga3phbGxvYyhzaXplb2Yo
KndvcmspLCBHRlBfS0VSTkVMKTsNCj4gKwlpbnQgcmM7DQo+ICsNCj4gKwlpZiAoIXdvcmspDQo+
ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJd29yay0+cGRldiA9IHBkZXY7DQo+ICsJSU5J
VF9XT1JLKCZ3b3JrLT53b3JrLCBwcm9jZXNzX2RlZmVyX3dvcmspOw0KPiArDQo+ICsJcmMgPSBk
ZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoJnBkZXYtPmRldiwga2lsbF9kZWZlcl93b3JrLCB3b3Jr
KTsNCj4gKwlpZiAocmMpDQo+ICsJCXJldHVybiByYzsNCj4gKw0KPiArCXBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIHdvcmspOw0KPiAgIAlyZXR1cm4gd2Fsa19obWVtX3Jlc291cmNlcygmcGRl
di0+ZGV2LCBobWVtX3JlZ2lzdGVyX2RldmljZSk7DQo+ICAgfQ0KPiAgIA0K

