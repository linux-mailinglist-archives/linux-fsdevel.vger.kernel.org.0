Return-Path: <linux-fsdevel+bounces-45838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637DA7D656
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973163ADC26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D370227BB6;
	Mon,  7 Apr 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dRyCfPoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233F224AF9;
	Mon,  7 Apr 2025 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011187; cv=fail; b=C9h0Yvrmb+7wGZnrT6eukL/2TEF+5AqtwLWEAcfibYzMTLfmM4P6vC3sBJj2VMRSicF7AKR47anTbnjX23zlCUiSEiVggguM53sBmZdcC0FCWZ97LuS92aE4sxXSJ/g7UBzXn/xA0OixpTsIO59McCndO7yieJ6m2n/FPj49exo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011187; c=relaxed/simple;
	bh=N8P5U7oD1zG/rYDhZsRukvajeFddZwLNTraYovnG4UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Csw+xvEiF4xS/4O4JoWDd64wsL/ob4UdEmK/mI+RtTaLjN1TIJKxyGalHXd/ovAr3eOJMd5zlU6BkmM8/zYdM8ylC1UgRaYmLonaKrXwLoo3Wm4EC2GrDFJZXTOQiz5Lnq6hkAjZGFK+SUGFCLyY/TvYfxrw/WFk0dZFKpGrIcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dRyCfPoS; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744011185; x=1775547185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N8P5U7oD1zG/rYDhZsRukvajeFddZwLNTraYovnG4UM=;
  b=dRyCfPoSkrAA8GwdUPq/ks6nntGaXXKU84D43S0vrCe/lYzmU6byzZ+T
   +kpnQhKPPOOBfu13OtPMce8nQ32MHHQ5xLm03mokpHDG94/Uk94VfkPcF
   OGSlY7+D/ZNqS06yOKwNTaivx2F43V5XvzQKpYCCckNZ6iBwS76mx6Wh8
   plSiIJ0Qr0sgDPDFC+mRKsglgYpnlnYWxHyEv0mjpyWlNYkruH8u4LBZd
   AbspSGjilyTig4dd6QoFG8h/pz3yNx07iDHxRqtPYHmWonjjsLLePnZ1P
   WbQy4xquY5+m88jP4Rz0/yey63dMeiD5N+fHgw5C5AGLO2CbkZ1sg7j+M
   w==;
X-CSE-ConnectionGUID: Drb5gxloTqau1GvvWoiMkg==
X-CSE-MsgGUID: nwzsGcpyQDCDt1ylXQarWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="63253426"
X-IronPort-AV: E=Sophos;i="6.15,193,1739804400"; 
   d="scan'208";a="63253426"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:31:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjYInU0ALAqyZX5dXy1s5UuDqlX1zuskzDKKPXrkfmAL4/jlx3XtervyzssMMVUW2Ceg6bpbkDaQuVhgRc1dYA8mkP/4w4/hr/zNHLis3dzPpSNEg24Ooh/PXl4hJ/Y42TaP9vgUvbmmdiCP/0V2laWN/CROMGeCOil2OUO79okxOVZhs9tl2h97c03VVV2PUyO4URHmz81Z+S3uKY/pUdkoSjUlwpyagmjhkR0+JW0w9FE9jGAGoOo+qPt2xXUT4Xvw0eCMFqB8FzLxtVGbyCPdb1p7/lm3F3x+2LHVa5BjvKvLR12SHDahpn2EWjGwyhAA2Q5Z1dgiBFOuFrF8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8P5U7oD1zG/rYDhZsRukvajeFddZwLNTraYovnG4UM=;
 b=fIy2a+5TzS93dqbZgZ2eemKhOYtPlScCSz4aGF5YidoGt3bqlJHEkAqYjADxC4rbSOlG03ElpvTUWSowReXaKqRQQZfXkg5l2o9WkxCQRWDu5uF/a6474Hk2WOm7hLl/sPXrA3eWcrF2ODMZVRFNzSN5kr0HK1A9Vv1qRGYQM6Vi6GvFRCsTr/aHsfAoHadhWv6/oEjvhoCj631eau4iiw6yVmGi1prPARuLZ82WGJA+HVn9xDyMOdZ/NItc3i+jB04bn9DRHehyp3eyZd3BYwllUQoIUosHsTaAhBR1+X8LBbNsQ6VDp3TP+LrdY1M+gznTCnNfH8Wuk+UBCg8gpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSRPR01MB12030.jpnprd01.prod.outlook.com (2603:1096:604:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 07:31:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 07:31:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Terry Bowman <terry.bowman@amd.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>,
	"rafael@kernel.org" <rafael@kernel.org>, "len.brown@intel.com"
	<len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "nathan.fontenot@amd.com" <nathan.fontenot@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huang.ying.caritas@gmail.com"
	<huang.ying.caritas@gmail.com>, "Xingtao Yao (Fujitsu)"
	<yaoxt.fnst@fujitsu.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gourry@gourry.net"
	<gourry@gourry.net>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rrichter@amd.com"
	<rrichter@amd.com>, "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
	"PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH v3 0/4] Add managed SOFT RESERVE resource handling
Thread-Topic: [PATCH v3 0/4] Add managed SOFT RESERVE resource handling
Thread-Index: AQHbpMbq6DhXvKmPdkqumkkJErQoGLOX1KEA
Date: Mon, 7 Apr 2025 07:31:37 +0000
Message-ID: <00489171-8e9d-4c97-9538-c5a97d4bac97@fujitsu.com>
References: <20250403183315.286710-1-terry.bowman@amd.com>
In-Reply-To: <20250403183315.286710-1-terry.bowman@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSRPR01MB12030:EE_
x-ms-office365-filtering-correlation-id: 10944f19-fcd4-4076-3f49-08dd75a63b83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUhud3BZTXJCWGR5NkNCTk1EOG1QTVRNZ2pYaDdKZWQwaFU3bHRVVFZQMC9D?=
 =?utf-8?B?SDRoT0xJQ0xENVlOVUZzVHJic2ZnWmtmS2lXcVJmc1FRempMY1pMeDlwWDBy?=
 =?utf-8?B?S2ZDd2hUb2pTaG5xRHVTNTBvblFNOVNUNm40cU1wT3kwcno5WlhhcXltelcz?=
 =?utf-8?B?K01MSVJrZ1Z1T09raGdOMXV6ekgxVUgxSlhlSTJKSlFIbDRqekwzSjhHWnJj?=
 =?utf-8?B?cG9iMHpGYS9JRXBZTXVKUVQ2NmxoQzJWZytIbkV4Z2YzVlNOekpVeWtCT3ZV?=
 =?utf-8?B?OGZRNTRDTDNVMnErM1Y0bkhvQ2pCcnYxc3BWaGJUenJFcm11eUhJdjhZaTg5?=
 =?utf-8?B?TU9Id0FmQUtDOER3UWI0WUxRS2ZJcjRvWUo3a2RPSWZ4ZTgzMkNQRjhZK2VD?=
 =?utf-8?B?bVp6ZTdlL1J1Wnluc3ZERDVkdUJGQUdzeUlEYjJOeE5PaHNQODZxOVhUdU5j?=
 =?utf-8?B?cVQ2RjhWeFdTenhtbzUyR1NtMkw5NDdDbHFJK3haelJ6NDF1bk1zaWR2ZURq?=
 =?utf-8?B?MDJCa3JxTCtNUWUrdWJwRjlhVDdBQi9xVEhwQVQ5LzJJNjNEMlh5L3d1M2JQ?=
 =?utf-8?B?NEZUSWYvNlpCc0xuT2xJVEgxNHZ4ZEdWS1FXenV2SEQ4TTJDZ0IzL0oxNU5U?=
 =?utf-8?B?amEwYnY3YTB6TTBMdnc1M0tNN0xsK05WNnR5enBUQmdHNlJTWEcrSjQ5bkRQ?=
 =?utf-8?B?dE1laGF5L005RVBIYlRMai85NCtucFNPbGx3b21TR3dMejlXY2lOOWVJZWNz?=
 =?utf-8?B?M2t2bkg4WC90V0FVdDZpQSs1VUNiT0NOVDRLR0FIY2w4b1kxZUo2eDkvNGtK?=
 =?utf-8?B?ZDF6MGx4dU8rZjluSFVCcXdFS0FhU1UvMFNiZTVzOTZPVjRsNytGZWJzZUNr?=
 =?utf-8?B?azNKV3RhRWVuREhmQk4yQm51cFNIdjA5S1N0V3FjUXBnbzFiRlM1dXZSZ1N3?=
 =?utf-8?B?NStIWWltSldkUmh4T0pCVGhiOXAreE04ZXNtOUJ3Y0ZhU2hsN0VLdDhjeWVr?=
 =?utf-8?B?anBjMkpwSzI3cGgzYnR3a01NNGExNmxKZ0RPMUF5eE5ocDZjcHhsQ2w4UlVy?=
 =?utf-8?B?dnRLQVhNazJhSmNkUXJWb0crQ2FVTWlCSWdPcitZdHVHbHowUUtEdzg4OFhK?=
 =?utf-8?B?MENJOFhaZzVuSjNuV2lQS01CZ0F5aGRDbzRYdWx2UW5CMGR1OWdUMnVQQ3oz?=
 =?utf-8?B?MnNnQWplKzV6L3d1c0U1RzY0b09mNlEzTW9aNHdhdUFndURCRndxTFh3akpN?=
 =?utf-8?B?TW13bWZZVFQxRTRLSFdOelJncUpuKzNxdEhORHlUZmhkdGRjMmlvdnh2a0lJ?=
 =?utf-8?B?VVZFbEJ2MW1wZlhHWElBRE9mVkVOUTNWNEJJbmR6YW4rUHlzQkx0WUFVZmtr?=
 =?utf-8?B?TVROYzUzM0dKUFBobnBuUlE2STNmUWlRY0NpMVpDbWZrayticS9aQldNVWV1?=
 =?utf-8?B?ZnpHUTBiZHl6aHVlOXlxUzBzU2tMeWFuS2VOR09FenIrZUZiWE5idDh4TG9Y?=
 =?utf-8?B?L2doOW5odWN5T2tXN09zcW4rOHVIY1RSMmh3WVpRQ2huUHlWRi8vdVZkdW9j?=
 =?utf-8?B?TEhpSGFta2Y2N2VacGI4ZGdLc0dmQkx1ZDI0WWpGbHdJT2F2SDdwOHcvbGRn?=
 =?utf-8?B?aG5tV3I2WGdxek5FbGZqYXpieTdBSDdYaitzbVdJK1BrL2ErWldXN3V4WWd2?=
 =?utf-8?B?UVFydktPQWI4Vjl2aTRTaEJDMXhOaW5paG85aUxzdDRTdzNlRnYzM3JLQ0pH?=
 =?utf-8?B?RmdMSzFZUjRiNU1peDBvamxhQ01GSzFSRytQMUZ6NytVSjZEY3VrS0VUejlY?=
 =?utf-8?B?U1pxbW9ReVFpSjBVRk0rMStRSVRQVmgwcjNyNVpaQkd6L3hFY1AvUVRWT0Vi?=
 =?utf-8?B?cDJycE1XbVRLelF0MEpZMm5oWDc1VUV6VERzdkIrWXcxQjM0c2NyWFRYREdT?=
 =?utf-8?B?Y0hQRFhOeFo5VkNLdGlBZGswcGU4UWQ1eWxEWm81QkJEcWtzRFd3ZzNSNGJE?=
 =?utf-8?Q?vMUCSt/jXQ94CGDfxUKsLZkhjW6uCo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFZBWnpNbXZFQnlGN1JhUnNkSEVZWnJYenk2bXhOdnQzbGlKUWRCQmZoWjMx?=
 =?utf-8?B?UVpzYzJrL0FkZkpUREdqbyt0RllQdmthSGJnd1lZT2ZzT0drVm9EM29saWRz?=
 =?utf-8?B?TnZGV0tBMzU2dG1iRlZ6bmE0MjFLditVUWFGRHF4KzQ5bWhLcnBrWnpBb1Qw?=
 =?utf-8?B?ckhNTVdSaTJCSVNKOEc1U3o2RFF0d1dSVXFhNGZJVnlNR0h4WWdNR0VJeXZp?=
 =?utf-8?B?QW9VL1NST3RGbW5SR3Yrang3TUgxSTM2SkwrdFRKdmZZMEVBWUc2OHBDU2RN?=
 =?utf-8?B?SDdrT3RENUc0blhCdTBDdjNRMlJGZ1cxekxCQkZoaENJcVJjWTg2aXdScTI1?=
 =?utf-8?B?VzNkdUZYNGZ6REZFY2R0ekJEb2cwZzIwTWpKVWFMZzRsNXh4QjltaE1icVZU?=
 =?utf-8?B?TlJWR0JnTEs3R0xQWCtJMzMxUU10bG83SjFDb1REV0dMaTlhYUIyOUJFL2Yr?=
 =?utf-8?B?MG1Gd0pobTJVK1I3T3BSZXE5bFpTRHFpSU44WTcxZEM1YUNjMUh5bmtSdDly?=
 =?utf-8?B?K2d2ZC9rZkRMaEo3VFhmWWZEbldrQ2xUa3BFZjV3cDg0ODNGR1NySDZwcXQr?=
 =?utf-8?B?cW85a0p5Qm5WVURvTjVwd1dCb2FDcVJKYU5jeEdYdDBQQlBZWm5kM0FRdWdy?=
 =?utf-8?B?RmRBSDNYMGtnalBOcWcrRy9lWlRSaGt4VVBJUTZZaFJXY2J3Tk5OUGJsK3h2?=
 =?utf-8?B?ejhMWXZlWEtjbUJYcXQzTUhIOXNpV09iMFEyYXBzQXVseStCSDN5YUUvbEZL?=
 =?utf-8?B?R3J2b3ZwZnU5Y3hDTmNDZzVWQmxtaCs0eVhEWEVUaTJqeXY4NFhHVXNkeFUx?=
 =?utf-8?B?YWJqMm1kVmJoclQxejNuU3hjUkxpSGR5WjdTYytYUHZ4N25DTGRJT045MzBB?=
 =?utf-8?B?SWhzbWJXaUhWUDhOVUZqZHdMVzhlRFlNZzVPWWdpZkxkcmVGaCtCWVpsZHpW?=
 =?utf-8?B?REdoV2djaElEREN6dEtnQnJEaU81ZmplbExITG9pdXVZU1RVZ3RkOWhaVU9N?=
 =?utf-8?B?dndlUU5NM3QwUkpxdGRCc3FmVlMwWDJQdFJGWmFiMzIrTVBNclRTeXFaajZl?=
 =?utf-8?B?RWpSUUJLK29OVHVLQkZiSXl3MlVvNXBJbS9MaVU0NUl3dWtQTzRjRFpPL3FJ?=
 =?utf-8?B?bkVNWDkvQWFFaXA4anJjL3J1YVdzNXA0MnBtcFFyRERZSnB0YndoZnFsdW1O?=
 =?utf-8?B?S2pJREhTbEdSMkpNbnNVV3ZReGNZWktiTEg3MW9saG8wNkdZSjJ0Sjd6dWp4?=
 =?utf-8?B?UzAvTnhHS0pwZVh5Z1BJcVhxbnY1U1I3QnIvRnQ1S2pCT2JlYUZERzdIME9r?=
 =?utf-8?B?WjAvR0l5Z1lBU0ZVSFdiMW9XWEFJMTVlNnZnWSsraWV0WHZoayttYysyekQw?=
 =?utf-8?B?T2JhMDAxck5SdS9OQ1A1ZkNyNzUyRkltL29kYjVCSDhnTTJoWjJFSFFxak9V?=
 =?utf-8?B?MGNJb2RhbGtTMkp4R1Z0cFpvT1Qza0xmR0xvY2pJNzRFUUU0UXJ6WnJkWjdR?=
 =?utf-8?B?QTMvSGViZGhJSVRRQW9ndnRLbnlJSzhKMWxrQy83Zk9HeVVnK1orOHhZZ1Jn?=
 =?utf-8?B?YWJpOGlMMEZxSzN2cEorLzVIYnc1bE4zR2dhS245M0NPd1VZS0VuM21BeUE2?=
 =?utf-8?B?Mnd0QXphemwyeEtRKzdrbTJNNlMyYlEveGFRSEtGREVGZ29ySFVVYzBlUFcr?=
 =?utf-8?B?UExlMlgydlV1YU5PZHFpT0lGejJ3WWZzcGMrM0RzWjB6NE1RNUhtRUZOMnJi?=
 =?utf-8?B?Qm45MlFwSTEyZDRDQkVRVG1JMllDSFJ1Q3lBeGRPZkdNdndlODlJSzBpdHFB?=
 =?utf-8?B?NS83ejdVZHFQODh2c09TenJoSjg5UFFUR2w2NlduSSt0SnFhbUJMVEFaLy91?=
 =?utf-8?B?dUt3amRYZzVUQ2QyTVM5K041T3prR1lVWnpxcjFyQkVFamphLzFhMVk2ZFd5?=
 =?utf-8?B?M0IwQ25qUm9IM2lPbEh4NDAzL1JrSzVpM2FOdWVHYVZtdklvYTRMWGNZTXJa?=
 =?utf-8?B?bDVRTDBWWjJIOUtzVGxjcVBXcjJ0ZHdId1YrTXAwK3p5MnRJSzJGVjRCTUNC?=
 =?utf-8?B?MGVZdnZLSks3ZlovV3pXK2VxK3gzcC9valpBVEpNUUE0QmhkWHV1cUttd1ha?=
 =?utf-8?B?dldpdFJQMjJGMExyNTd0V1dXM0g4ZHdTTHpVbGN1eitsM1ZvYjJ6SUZIaVRt?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAB013F9A44E82469F84926CF8569E49@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FwGQP1HAHCMdHZ5zOyETtk3phfzZUov4sk3fyXx5ACVq7cyrx+xJh6TE1MugVyq47hZf26D0Z14jQsUw6dF3vc0w8YEDt0hlVCZ5Fu5zq06GYUu5vBOutMa0mArz5Gt/FpYkq25Tu3ZpatDB1hgMsUKpMMf3IswcQVrNCqlw9PtR2fR95voFyfcFDrfwMDNZfjrS0dRIlVTfFYkihGclk1hMBk7d3E5P9eILdzmSdi1RrLVFrhTCVlWQs/XksjsfW6zYAgpia+tasotTtTdFvxXv8IUGoMx5iijZEV3IuKzaOqgt6ElBVGIVZbzpOrfnLa6Xkzg037wj+KHTCNt6k7UiP7rcDxFPEuHwARoxobKBtB1OBgVdxB3suWz3aOui29B1aX52ozgkj3APGJSCElm1PQK5uZesB84APqgwVh9W0G6ochBRmS3dkKZnHvS+RshgEogz9MmfF1hehLDcvSrqFRisjrAewFaSZapKYbljmV3KbzkMu7SS92m8zdYYDVX0Zm6NM23BVm1TGqE9TCEBwZIKIb44BOJJZ+B9BbCQz0kk57k7py6VYRuzYOl67mZobjuxx23aRkjww0q2W+0Z1O8MocZyUJ8WJmWhjnSw3hyRMDl9txMUo0xLxrUd
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10944f19-fcd4-4076-3f49-08dd75a63b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 07:31:37.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFeqO/p1gpoLhcD6sGW+udKeaB4m+Sn07kA/7zPz4nVzLPCTY9AyMzk4rjjUVHyqQ6BUTB54UBR3Lxq58fKF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12030

SGkgVGVycnksDQoNCklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoaXMgcGF0Y2ggc2V0IGhh
cyBvbmx5IGNvbnNpZGVyZWQgdGhlIHNpdHVhdGlvbiB3aGVyZSB0aGUNCnNvZnQgcmVzZXJ2ZWQg
YXJlYSBhbmQgdGhlIHJlZ2lvbiBhcmUgZXhhY3RseSB0aGUgc2FtZSwgYXMgaW4gcGF0dGVybiAx
Lg0KDQpIb3dldmVyLCBJIGJlbGlldmUgd2UgYWxzbyBuZWVkIHRvIGNvbnNpZGVyIHNpdHVhdGlv
bnMgd2hlcmUgdGhlc2UgdHdvIGFyZSBub3QgZXF1YWwsDQp3aGljaCBhcmUgb3V0bGluZWQgaW4g
cGF0dGVybiAyIGFuZCAzIGJlbG93LiBMZXQgbWUgZXhwbGFpbiB0aGVtOg0KDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpQYXR0ZXJuIDE6DQotIHJlZ2lvbjAg
d2lsbCBiZSBjcmVhdGVkIGR1cmluZyBPUyBib290aW5nIGR1ZSB0byBwcm9ncmFtZWQgaGRtIGRl
Y29kZXINCi0gQWZ0ZXIgT1MgYm9vdGVkLCByZWdpb24wIGNhbiBiZSByZS1jcmVhdGVkIGFnYWlu
IGFmdGVyIGRlc3Ryb3kgaXQNCuKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkA0K4pSCICAgICAgIENGTVcgICAgICAgICDilIIN
CuKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUmA0K4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQrilIIgICAgcmVzZXJ2ZWQwICAgICAgIOKUgg0K4pSU4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSYDQrilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilJANCuKUgiAgICAgICBtZW0wICAgICAgICAg4pSCDQrilJTilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCuKU
jOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUkA0K4pSCICAgICAgcmVnaW9uMCAgICAgICDilIINCuKUlOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KDQoNClBhdHRl
cm4gMjoNClRoZSBIRE0gZGVjb2RlciBpcyBub3QgaW4gYSBjb21taXR0ZWQgc3RhdGUsIHNvIGR1
cmluZyB0aGUga2VybmVsIGJvb3QgcHJvY2VzcywNCmVnaW9uMCB3aWxsIG5vdCBiZSBjcmVhdGVk
IGF1dG9tYXRpY2FsbHkuIEluIHRoaXMgY2FzZSwgdGhlIHNvZnQgcmVzZXJ2ZWQgYXJlYSB3aWxs
DQpub3QgYmUgcmVtb3ZlZCBmcm9tIHRoZSBpb21lbSB0cmVlLiBBZnRlciB0aGUgT1Mgc3RhcnRz
LA0KdXNlcnMgY2Fubm90IGNyZWF0ZSBhIHJlZ2lvbiAoY3hsIGNyZWF0ZS1yZWdpb24pIGVpdGhl
ciwgYXMgdGhlcmUgc2hvdWxkDQpiZSBhbiBpbnRlcnNlY3Rpb24gYmV0d2VlbiB0aGUgc29mdCBy
ZXNlcnZlZCBhcmVhIGFuZCB0aGUgcmVnaW9uLg0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQrilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilJANCuKUgiAgICAgICBDRk1XICAgICAgICAg4pSCDQrilJTilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCuKU
jOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUkA0K4pSCICAgIHJlc2VydmVkMCAgICAgICDilIINCuKUlOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0K4pSM4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQ
DQrilIIgICAgICAgbWVtMCogICAgICAgIOKUgg0K4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYDQrilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCuKUgiAg
ICAgIE4vQSAgICAgICAgICAg4pSCIHJlZ2lvbjANCuKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KKkhETSBkZWNvZGVyIGlu
IG1lbTAgaXMgbm90IGNvbW1pdHRlZC4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICAgICAgICAgDQpQYXR0ZXJuIDM6DQpSZWdpb24wIGlzIGEgY2hpbGQg
b2YgdGhlIHNvZnQgcmVzZXJ2ZWQgYXJlYS4gSW4gdGhpcyBjYXNlLCB0aGUgc29mdCByZXNlcnZl
ZCBhcmVhIHdpbGwNCm5vdCBiZSByZW1vdmVkIGZyb20gdGhlIGlvbWVtIHRyZWUsIHJlc3VsdGlu
ZyBpbiBiZWluZyB1bmFibGUgdG8gYmUgcmVjcmVhdGVkIGxhdGVyIGFmdGVyIGRlc3Ryb3kuDQri
lIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilJANCuKUgiAgICAgICBDRk1XICAgICAgICAg4pSCDQrilJTilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgNCuKUjOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
kA0K4pSCICAgcmVzZXJ2ZWQgICAgICAgICDilIINCuKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0K4pSM4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQrilIIg
bWVtMCAgICB8IG1lbTEqICAgIOKUgg0K4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYDQrilIzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCuKUgnJlZ2lvbjAg
IHwgIE4vQSAgICAg4pSCIHJlZ2lvbjENCuKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KKkhETSBkZWNvZGVyIGluIG1lbTEg
aXMgbm90IGNvbW1pdHRlZC4NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQoNCk9uIDA0LzA0LzIw
MjUgMDI6MzMsIFRlcnJ5IEJvd21hbiB3cm90ZToNCj4gQWRkIHRoZSBhYmlsaXR5IHRvIG1hbmFn
ZSBTT0ZUIFJFU0VSVkUgaW9tZW0gcmVzb3VyY2VzIHByaW9yIHRvIHRoZW0gYmVpbmcNCj4gYWRk
ZWQgdG8gdGhlIGlvbWVtIHJlc291cmNlIHRyZWUuIFRoaXMgYWxsb3dzIGRyaXZlcnMsIHN1Y2gg
YXMgQ1hMLCB0bw0KPiByZW1vdmUgYW55IHBpZWNlcyBvZiB0aGUgU09GVCBSRVNFUlZFIHJlc291
cmNlIHRoYXQgaW50ZXJzZWN0IHdpdGggY3JlYXRlZA0KPiBDWEwgcmVnaW9ucy4NCj4gDQo+IFRo
ZSBjdXJyZW50IGFwcHJvYWNoIG9mIGxlYXZpbmcgdGhlIFNPRlQgUkVTRVJWRSByZXNvdXJjZXMg
YXMgaXMgY2FuIGNhdXNlDQo+IGZhaWx1cmVzIGR1cmluZyBob3RwbHVnIG9mIGRldmljZXMsIHN1
Y2ggYXMgQ1hMLCBiZWNhdXNlIHRoZSByZXNvdXJjZSBpcw0KPiBub3QgYXZhaWxhYmxlIGZvciBy
ZXVzZSBhZnRlciB0ZWFyZG93biBvZiB0aGUgZGV2aWNlLg0KPiANCj4gVGhlIGFwcHJvYWNoIGlz
IHRvIGFkZCBTT0ZUIFJFU0VSVkUgcmVzb3VyY2VzIHRvIGEgc2VwYXJhdGUgdHJlZSBkdXJpbmcN
Cj4gYm9vdC4gVGhpcyBhbGxvd3MgYW55IGRyaXZlcnMgdG8gdXBkYXRlIHRoZSBTT0ZUIFJFU0VS
VkUgcmVzb3VyY2VzIGJlZm9yZQ0KPiB0aGV5IGFyZSBtZXJnZWQgaW50byB0aGUgaW9tZW0gcmVz
b3VyY2UgdHJlZS4gSW4gYWRkaXRpb24gYSBub3RpZmllciBjaGFpbg0KPiBpcyBhZGRlZCBzbyB0
aGF0IGRyaXZlcnMgY2FuIGJlIG5vdGlmaWVkIHdoZW4gdGhlc2UgU09GVCBSRVNFUlZFIHJlc291
cmNlcw0KPiBhcmUgYWRkZWQgdG8gdGhlIGlvZW1lIHJlc291cmNlIHRyZWUuDQo+IA0KPiBUaGUg
Q1hMIGRyaXZlciBpcyBtb2RpZmllZCB0byB1c2UgYSB3b3JrZXIgdGhyZWFkIHRoYXQgd2FpdHMg
Zm9yIHRoZSBDWEwNCj4gUENJIGFuZCBDWEwgbWVtIGRyaXZlcnMgdG8gYmUgbG9hZGVkIGFuZCBm
b3IgdGhlaXIgcHJvYmUgcm91dGluZSB0bw0KPiBjb21wbGV0ZS4gVGhlbiB0aGUgZHJpdmVyIHdh
bGtzIHRocm91Z2ggYW55IGNyZWF0ZWQgQ1hMIHJlZ2lvbnMgdG8gdHJpbSBhbnkNCj4gaW50ZXJz
ZWN0aW9ucyB3aXRoIFNPRlQgUkVTRVJWRSByZXNvdXJjZXMgaW4gdGhlIGlvbWVtIHRyZWUuDQo+
IA0KPiBUaGUgZGF4IGRyaXZlciB1c2VzIHRoZSBuZXcgc29mdCByZXNlcnZlIG5vdGlmaWVyIGNo
YWluIHNvIGl0IGNhbiBjb25zdW1lDQo+IGFueSByZW1haW5pbmcgU09GVCBSRVNFUlZFUyBvbmNl
IHRoZXkncmUgYWRkZWQgdG8gdGhlIGlvbWVtIHRyZWUuDQo+IA0KPiBWMyB1cGRhdGVzOg0KPiAg
IC0gUmVtb3ZlIHNybWVtIHJlc291cmNlIHRyZWUgZnJvbSBrZXJuZWwvcmVzb3VyY2UuYywgdGhp
cyBpcyBubyBsb25nZXINCj4gICAgIG5lZWRlZCBpbiB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
bi4gQWxsIFNPRlQgUkVTRVJWRSByZXNvdXJjZXMgbm93DQo+ICAgICBwdXQgb24gdGhlIGlvbWVt
IHJlc291cmNlIHRyZWUuDQo+ICAgLSBSZW1vdmUgdGhlIG5vIGxvbmdlciBuZWVkZWQgU09GVF9S
RVNFUlZFRF9NQU5BR0VEIGtlcm5lbCBjb25maWcgb3B0aW9uLg0KPiAgIC0gQWRkIHRoZSAnbmlk
JyBwYXJhbWV0ZXIgYmFjayB0byBobWVtX3JlZ2lzdGVyX3Jlc291cmNlKCk7DQo+ICAgLSBSZW1v
dmUgdGhlIG5vIGxvbmdlciB1c2VkIHNvZnQgcmVzZXJ2ZSBub3RpZmljYXRpb24gY2hhaW4gKGlu
dHJvZHVjZWQNCj4gICAgIGluIHYyKS4gVGhlIGRheCBkcml2ZXIgaXMgbm93IG5vdGlmaWVkIG9m
IFNPRlQgUkVTRVJWRUQgcmVzb3VyY2VzIGJ5DQo+ICAgICB0aGUgQ1hMIGRyaXZlci4NCj4gDQo+
IHYyIHVwZGF0ZXM6DQo+ICAgLSBBZGQgY29uZmlnIG9wdGlvbiBTT0ZUX1JFU0VSVkVfTUFOQUdF
RCB0byBjb250cm9sIHVzZSBvZiB0aGUNCj4gICAgIHNlcGFyYXRlIHNybWVtIHJlc291cmNlIHRy
ZWUgYXQgYm9vdC4NCj4gICAtIE9ubHkgYWRkIFNPRlQgUkVTRVJWRSByZXNvdXJjZXMgdG8gdGhl
IHNvZnQgcmVzZXJ2ZSB0cmVlIGR1cmluZw0KPiAgICAgYm9vdCwgdGhleSBnbyB0byB0aGUgaW9t
ZW0gcmVzb3VyY2UgdHJlZSBhZnRlciBib290Lg0KPiAgIC0gUmVtb3ZlIHRoZSByZXNvdXJjZSB0
cmltbWluZyBjb2RlIGluIHRoZSBwcmV2aW91cyBwYXRjaCB0byByZS11c2UNCj4gICAgIHRoZSBl
eGlzdGluZyBjb2RlIGluIGtlcm5lbC9yZXNvdXJjZS5jDQo+ICAgLSBBZGQgZnVuY3Rpb25hbGl0
eSBmb3IgdGhlIGN4bCBhY3BpIGRyaXZlciB0byB3YWl0IGZvciB0aGUgY3hsIFBDSQ0KPiAgICAg
YW5kIG1lIGRyaXZlcnMgdG8gbG9hZC4NCj4gDQo+IE5hdGhhbiBGb250ZW5vdCAoNCk6DQo+ICAg
IGtlcm5lbC9yZXNvdXJjZTogUHJvdmlkZSBtZW0gcmVnaW9uIHJlbGVhc2UgZm9yIFNPRlQgUkVT
RVJWRVMNCj4gICAgY3hsOiBVcGRhdGUgU29mdCBSZXNlcnZlZCByZXNvdXJjZXMgdXBvbiByZWdp
b24gY3JlYXRpb24NCj4gICAgZGF4L211bTogU2F2ZSB0aGUgZGF4IG11bSBwbGF0Zm9ybSBkZXZp
Y2UgcG9pbnRlcg0KPiAgICBjeGwvZGF4OiBEZWxheSBjb25zdW1wdGlvbiBvZiBTT0ZUIFJFU0VS
VkUgcmVzb3VyY2VzDQo+IA0KPiAgIGRyaXZlcnMvY3hsL0tjb25maWcgICAgICAgIHwgIDQgLS0t
DQo+ICAgZHJpdmVycy9jeGwvYWNwaS5jICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysr
DQo+ICAgZHJpdmVycy9jeGwvY29yZS9NYWtlZmlsZSAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvY3hs
L2NvcmUvcmVnaW9uLmMgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKy0NCj4gICBkcml2ZXJz
L2N4bC9jb3JlL3N1c3BlbmQuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICBkcml2ZXJzL2N4bC9jeGwuaCAgICAgICAgICB8ICAzICsrKw0KPiAgIGRyaXZlcnMvY3hsL2N4
bG1lbS5oICAgICAgIHwgIDkgLS0tLS0tLQ0KPiAgIGRyaXZlcnMvY3hsL2N4bHBjaS5oICAgICAg
IHwgIDEgKw0KPiAgIGRyaXZlcnMvY3hsL3BjaS5jICAgICAgICAgIHwgIDIgKysNCj4gICBkcml2
ZXJzL2RheC9obWVtL2RldmljZS5jICB8IDQ3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tDQo+ICAgZHJpdmVycy9kYXgvaG1lbS9obWVtLmMgICAgfCAxMCArKysrLS0tDQo+ICAgaW5j
bHVkZS9saW51eC9kYXguaCAgICAgICAgfCAxMSArKysrKy0tLQ0KPiAgIGluY2x1ZGUvbGludXgv
aW9wb3J0LmggICAgIHwgIDMgKysrDQo+ICAgaW5jbHVkZS9saW51eC9wbS5oICAgICAgICAgfCAg
NyAtLS0tLQ0KPiAgIGtlcm5lbC9yZXNvdXJjZS5jICAgICAgICAgIHwgNTUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gICAxNSBmaWxlcyBjaGFuZ2VkLCAyMDIgaW5z
ZXJ0aW9ucygrKSwgNTUgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IGFhZTA1
OTRhNzA1M2M2MGI4MjYyMTEzNjI1N2M4YjY0OGM2N2I1MTI=

