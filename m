Return-Path: <linux-fsdevel+bounces-50601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D397ACDA2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2607018870C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AAA28C2D7;
	Wed,  4 Jun 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="G5CwmJxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B137289E0C;
	Wed,  4 Jun 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026609; cv=fail; b=spF+E0Cy8rfVslkf7gN85yl+z/vQNAV+1I8dnbCp9wXlr33Zd4uHQGni4k82hbD8TmVoFIY029pq/I00Xj+SdjfgoVki6/cOw+le8jkRwwLHyNvGsCrLtvCIP1Ttu9JejeDVhGC6eNVs8bdF7HnZ+PU5n50mi7Xs+vXLF+w0H5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026609; c=relaxed/simple;
	bh=4eR5iWxEbVVK0lXcp2BAB775SlPjaUmq3ckYYpeoA6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqEhXDi7RJ+iyRYNYChURouMFGl5KxFs9UsbKqNdYw1TcOEVLL3iAOv5ywNM9eZ6Eaf65dzKlrpKMtnUGsmj86xwXuu9HDi6vdd/spZaXw1BXX70s69+zRc9kT3PwAmkWIxQ+hF3iaeyUdjIV+6rCcnBaReJCTt8mpTjv1EnHss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=G5CwmJxZ; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749026608; x=1780562608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4eR5iWxEbVVK0lXcp2BAB775SlPjaUmq3ckYYpeoA6Q=;
  b=G5CwmJxZxnciEm/WMqP2p6/zxwayrlAzU9GNvaPXnivE6V8k4QosmPxg
   2/i5av71C8lo4D3B8ilPafBEsP9YSR2BY0Iik7FgvWOv/vgZzGmPdquMK
   Er6iq6lmMqe0aA7FXQDCC9m3HvZ4Jlvl4dKiYNlUGRDpW5ET6sCv9tMJH
   0LiQvNpDJnm4BaGavWUPWsWAxNjJkwuIutCq5/hkFcWjpVDEGPyEI6+o8
   X6bijFejyJ777dqiw/HWmmIsRUFgR9DOCXhXsnTcVR9ea4Ri0K7AuvqPW
   IVnccxHfKXoZm41rjGx1A6cAuA9yfRSITfPw8dIYXwEyP+KwkPvhkVsqR
   g==;
X-CSE-ConnectionGUID: AShgU2UAQHC4W3nA4uXNTw==
X-CSE-MsgGUID: lrfwNl7lQdKw/weVMNMLFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="157064775"
X-IronPort-AV: E=Sophos;i="6.16,208,1744038000"; 
   d="scan'208";a="157064775"
Received: from mail-japanwestazon11010006.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.6])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 17:43:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1aXLDEgo9bULI98ngQxXcWMYZ/mDTVcwzE0RAQad1m8MzxyajLB5ur+23m14ly0m90aJNVRG37n8GAD3gqSZxZ4rBvMlMJ6lW6wV9vCPWNwCpm8GR7Rpv+oczbYS5RoT7aN3SHnj86KxZ1GmXEEpRs7Q/dK60Epv6nXtOIhUk9K8iQPT3H7R4XezcOD+o5LWRU3O8j2xUu/XTjldTFVnlR5rutDV9+IdErlIpIvhUXe2TGSeTna8cgHAh60j++6B3+w5R3WQuZsuwrq2NmlgGdlRvxqWMl/U0Qbnz+06eV4FG/jWDMbZGStzK6QiJ8D6y2Ey884l9GW2lqk2X32xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eR5iWxEbVVK0lXcp2BAB775SlPjaUmq3ckYYpeoA6Q=;
 b=cq8bOrH/Xv/KyGntI4hRIBDBwEaAepqfImQ0RVhbq3T+BMWbYGt4gY0oENb4H4xLQRzD6oYfEyKjxK7YbMZZr9Q9x77ArLUDNVZohLEYj6UX3HThDlTHMUjH8fvUFfgxBPRWSeJ7Jqi05YCJ6cBCgVfL1gq2x+BErSFHAKS1nFcCffaIozAy/j34dA3GaBQp1R3BItAnpNvTc1B4KLEs7O4pqYvHeBj3NxcXNf/69OuXXKCh4FEPgl8A3jJXwEbQRYWTDkzASOv5lKPPPyBbgIkeMsJ63+yAd+MRl0U8ikoUEUQTTFFr3sNxaN79wdTKaJhgyVlgFSkt/YywWjVlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB10414.jpnprd01.prod.outlook.com (2603:1096:400:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 08:43:08 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 08:43:08 +0000
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
Subject: Re: [PATCH v4 0/7] Add managed SOFT RESERVE resource handling
Thread-Topic: [PATCH v4 0/7] Add managed SOFT RESERVE resource handling
Thread-Index: AQHb1NWu79RVwSqVXEulodtbceqNDLPyr7WA
Date: Wed, 4 Jun 2025 08:43:08 +0000
Message-ID: <a1735579-82ef-4af7-b52d-52fe2d35483c@fujitsu.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB10414:EE_
x-ms-office365-filtering-correlation-id: 4cf6e39d-ca5f-44bc-f198-08dda343d4a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3k1eHFQRkpyRkxhNkFWcjJoREY0WmhqSkJwNlJvVmtDVzhvWTZ3NitxSE1L?=
 =?utf-8?B?UU9VdEFheERqVERkcVUwNVRUZS9sQWhtSDI1YUJBaUt0N0paeUhlTytFQkF2?=
 =?utf-8?B?OHRoNmRxd3d5cHdlZ3IwdHNndm9rbTJXeWpIUEhxV0IxUkJ6SXpSa25NRmVz?=
 =?utf-8?B?dTdHZDRpVWsvcGhHdDl2aU9iMkVhdGJrclVEbmUwUC9FMUZrTzh1L0paUmQ2?=
 =?utf-8?B?Y1c4UVIrczJROVV4MkRGRlgxUklWcWxyRE1maTkvUFZoa2thM1cwWDBPcHhs?=
 =?utf-8?B?Y0RSRERtWWQvQkFjeUd5VWdOQm9WS2NLM3dweTFqZ1hDTVVjZDRickdGWEVj?=
 =?utf-8?B?SzZYQnRaUHJqdUZ5dHZNSHQ2SFJaUXFkWStNUnh4MTdkNjM3ejZTZ2tzeG9V?=
 =?utf-8?B?NFZnNlRrUzhzMnpDL09jS1F3ZlJJMzUvNEVhK0xMZ1U0bzdNSWVsSHJKak45?=
 =?utf-8?B?bW9BMjkvZytCOWVIenh2Rnp5WDlmc3BzZUlnWGxBbjdaWm1zUDB0OTkvMVhP?=
 =?utf-8?B?L3IwOE9DelNla1hvWm51Zk81OGk2SENWUHUwZ3FKZjVnRDlOS1lNTGg4UlNU?=
 =?utf-8?B?U1pIV1p0Q3dkOGN4MEJySjNWV3RrelAyNG95SUFzRG1TUXRlRlNwMHNUTHcw?=
 =?utf-8?B?SXVtOWhBOGI2eTNhMWwxYTdqYXRza0JZRllXYkQrbWxhTmxKK2JtMTMzZXpt?=
 =?utf-8?B?ZS9TQTRqMXlKa0dURnpLb2dEbW5HR2RIRHo1ZVFONTl3bjB0RUhuMzdaZm85?=
 =?utf-8?B?SkNyZ092S2U4Wncyb2N1cDdkbFhBZ0V3bFM1WHJIdjJSUCtuNFdDVzFsZjQv?=
 =?utf-8?B?OUFjUmYwQ2thelhSRldRTVVtOFNFNU5oVjhNZWJWVktqNlN0eENkaHVVZzhV?=
 =?utf-8?B?M3FuQVdXVWo3Rnp1UXM5eVdTakFBNXRtOWtXOVM5MCtuNDd0WFcrU2phREhX?=
 =?utf-8?B?dFpiNE9LUWt0ZHRDdGtoZzcwN09LUjBFR1VpemtRclRJVklXcUpIMnNrTzE2?=
 =?utf-8?B?YkVrTlRqRmpNSktPazVDQTJjeWRQQk5mRThycEpKaXVmY083c0J1REtRMDY2?=
 =?utf-8?B?MVJHNlc4R29SeS81K2szbWlkVVR1L0N5NHo4WkZvQnM3SkdrdWtzVFE1OGQx?=
 =?utf-8?B?Mk5NTmZuQjNmWEFWZWV4U2FlMFZWK2hReW82a1kzUDdISk94ZWMwZWNxMTc1?=
 =?utf-8?B?RWx5YUhZVEtONCtSbGJSR1JoTWtqd1VoUHV0Y3dxNDZrWFRWQ2JYM1N1eTY2?=
 =?utf-8?B?eFFvVlRJYkhvazlrM2xxMnhWOFk3SDF4UjVPU3I4V1hYOG5sZ01qbWdHUExh?=
 =?utf-8?B?OXo4WlZ0Wi9vWldGNjRrZmVnZmhZRElqdmI5TjBNVFNXUEpyM0hMVC9aVEwv?=
 =?utf-8?B?N1F3MnNjd3Q5bDNyMmhDMWRWa1pidFpXOE5ydndJRjIzMmN3R1VPVGFzMTNH?=
 =?utf-8?B?MGQ1cEpDM3hyaWdJZWxBVUtScTVvOHFMNUhBZ3pTbVNjc1E5ckdEamF0MWhM?=
 =?utf-8?B?bnVHbnlaZ28rYjVWYStkRkpFdjNjZU45d2U2blhPMXIyb25OWU1ESFJtbjZP?=
 =?utf-8?B?UUZLQ0puNWV3aW82N0J4a3BWOXJZcVBjT3NEV2xGWnQxRGpOeHN6TWd5VFJN?=
 =?utf-8?B?TW84RWRGdnplR21tSUlDODhGa1lFa1k3SVdIRUV1b2llT2E1Ykcrd09ySmpX?=
 =?utf-8?B?YzZqWVRjVWM1L1lkNVl5aWJzcFNnSnhNNkhXMHE3U1R6VnkxOHhCY0ZpRTFM?=
 =?utf-8?B?VzR1WG5BNFp0S0FvL2FzN25pclRya2E2T05pQW9yZjBKdi9UOUcvT01rVXR0?=
 =?utf-8?B?N3V4c1hLU2VWQlhYVWtHTGVXUjV6U0JKdEtOaFFGMjFmbUg1WUFNMDVUNWtn?=
 =?utf-8?B?bHM2ekdjU3Bka1BObGNKSUZmeFROZlZ2NkpIY1U0MkdXbzgzU1lnMnJtbGlj?=
 =?utf-8?B?WWpNekYzamVRMzJOVDZxVi80eWY2UkRRYWtablorc211bVRmL2JhMlB1M001?=
 =?utf-8?B?RzRzVXVEVmQ0aWJGSGdVWGJXd0VWTTNaZWtoRHlaci9BM2V6ek9KNmNmQXdW?=
 =?utf-8?Q?6RiFfp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnN5ZFVkSmc4QUhxbVNRdWU3OGNCQ1JCYSs0b2FrVVlVRk9UWG8xbXlpSEk2?=
 =?utf-8?B?YnZ6dTJWNkFFSjEzTHllV01ER2J6SDV2NW1SYXJuSmkwU2RxREp2OEtkbkt3?=
 =?utf-8?B?dEEwVFRuYUwxNzdGWjM2MFBWMjRsdm8wNHErYWFCQ1oyQ1hMdDhIajB1czBo?=
 =?utf-8?B?ZUVWdWFYQzlwMDdVNVNqOUVGM2NCWFE2R0NidG5hWVBWcWlFN3RyVHlOYVVn?=
 =?utf-8?B?cW0zclc4bFpHUHQvYlliNTFnTUJaRVVFWUdFb3hrb0hBVWhOZERQWUlVMVNI?=
 =?utf-8?B?cDFMeWdYYVpmUzkrOEdOektEbjhBcWlnQ1oxa0l3eWh4NS9NVWEvaFZKQU5q?=
 =?utf-8?B?MHhaVDVmQWU4TThoNWpQRjdhY2NwV1o0S0RTOXhvdXdVQjlQRFJsL2pOa25P?=
 =?utf-8?B?ekFLZm04V3Arc0pDc0JvazlkcUFGNEQ3TXdlS2FTS2NHSzlUNVZxLzVBajFS?=
 =?utf-8?B?Vll6a0RSZkJFWmNwc1VhZWZoZUd0UFh6QU5paUNhY0tZVVZhbzNHcFZTYmNC?=
 =?utf-8?B?S2lDTG8vc3FjclU1QVlmUjlaYzMvTVFwMVpLQTJRMTR6RzZPLzVjR1U4aXk5?=
 =?utf-8?B?UzhLdHI3QXc3WThNVElESVZLd1BtaU5UZ3BWR2x5MVAzdCtDWmJPbzZhVGZC?=
 =?utf-8?B?MGlVbEJ2VGJpYUNYRFNWTnhwOHNjUGVQbnlZRWRRTW9ZRGI5Q3ZXNy9heTV2?=
 =?utf-8?B?bUNxeDhMOUxoRnltbzVJUTN6SDZ6c1JYSm1sNTNmMHVTS3VMZHQ3b3JraGtk?=
 =?utf-8?B?ZEdrTVVQK3dwUTErUkwvdVFSV2RyK3lJRWo4OHFhYTJPa3dDMENqNVVUcDdl?=
 =?utf-8?B?U005RUgybmVUd3FnUXY3U0o2blFGSlZBbUpjcVF5SGRxWEM4SFE1U1M0UnVQ?=
 =?utf-8?B?dWNkSElHY3ZWazlQS3BLb2pDckxzRGFmS3crQnkyRlNuUTJmOWMrV2tFb2dh?=
 =?utf-8?B?aTI2cUdRWjBSL2hubUdzNVY2d0ZYbGxxV1NBSW8rZFQ4SkZHMmFCaDRUa2dl?=
 =?utf-8?B?NUcxRFlkc2FJOG4xZ2NQazd1SzZ3UHVneVRwV2ZyYkhTMlRmYUFxQWJ2Zkw1?=
 =?utf-8?B?SFdoQm9tYVJkVTI1bFFPcmxCL3pwaENJTkRROXRtRDRkT0JXRzdMdm03UnZ6?=
 =?utf-8?B?U2d6TUlkK1h1aHpqL3Vrb3dCTUw1cm9KclgwdFJPcERxNThmMXBReUFFOVBJ?=
 =?utf-8?B?WjVneWJ0SGxkamxMbS9aTjBCL3lTOURQZ1RKN0JUVitxdUdJdk40TG96emFY?=
 =?utf-8?B?RVU0eStQS2t1ZTVYbFJtUHJ0UHJSZy9oVkZwbm9oTWRWT2J4V3FiZEJiWnhu?=
 =?utf-8?B?ZlFoVzAxR3JCOGZjak4ydTZwMTg3RUV6UzBGVFF1VHNST1hTVVphc2JjdjAx?=
 =?utf-8?B?TVpJQko3eE15cFlPb2ZOVUxZWXQyWWJLS2hNNjM4anZhaWx3Mis0OEcwdCtr?=
 =?utf-8?B?UDZPbCs3VWpyQ1RMUnhhbDN0eVNPWmtvNUFWTDRiZklFN20rS2dXcTJLVUtT?=
 =?utf-8?B?YXBoKyttVGxLRWJKOVN3SjViNnZ4V0dtbHF4WlZmRWEzQUlwcTk2QkxBSVlD?=
 =?utf-8?B?QlkyWmJpaHJ2MW5RMWxjSWt6Vk8velBvb2doMCt5TTlNdDNSR1Joend3eFQx?=
 =?utf-8?B?dkozb2RvYjNvZER6YlZGdVorZWdkcjVlTm5wZWZHYmRVOWdORUF5dkQ0dVRu?=
 =?utf-8?B?YlIxZlNDZ3J4dTZ3cU13Q0RkRGpYSWM2OEcwbnR1SDlXUjZVeG5GQnVRc0oy?=
 =?utf-8?B?QlRUWlphTnAxRjR6bXFMUWM0VTdsODdxZU9Zb2FXclNKVnRjcDVYcGthdXNm?=
 =?utf-8?B?QTdEYUlPWVo2ZHlSd3hDS211R0tPSFlYZFpZaFQ5YU1MdzlKQ0NjbHQrOGdh?=
 =?utf-8?B?VzJDc2UvbkFqYUNnVDF3ckZtUSt5UENhSWNMK3NHZlUxOXl6dGtaR1hIRVJW?=
 =?utf-8?B?TE1XTEV3ZitRUHNxMnVZcGk4YmJWL1A1QkUvVlpISk1zZTE0bmdwdWJmRXk4?=
 =?utf-8?B?THNpampDb0dOc0pEZUxUN3piVUtMSzFuclBCRTd6RDVEQ0VRYjlwc0lDK3pX?=
 =?utf-8?B?ZGRIZ0hhOCszeGFSbVFDRVRoL0g2Wkh4N3VKQVdqMWgzSWluQWtMRkZ3TTZB?=
 =?utf-8?B?bUE5SEJmUHB3S2NFVVZUSVQyUUk1Q0hJaklaOUpzTUUycnpMZE5DN29Gcjdl?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <663E196B2B12ED4CACEA70B9D0A5F5CE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UxXUo3khLJlTAiT89EPejHkY/UnkXP2OxPw3rKVLJfbCtupKCVDRm39sBbvpcrokK7bUrUGuVKqUwVbtjfxmEhc4KImDxxxZhcexOkv6bL7DYgkwsRpu5BeBcydwFgkP76wJqpFEFg60hdl2rl4uyyI5Q56AVwh7jv6dktAOPNyTGOaYft4/02KaGiDwITbJ04G68h4HG0gxEbPq2TVU1t7XtR4CJZlI1oGY0mRD51dG6xYCe/gPl03c4h4h/NC0KFrCParpY2OHbOe0FeEGK7ekgs3dy8bJSY9s/1SLaSNlQbj4LOyfMRjgKSoCrft2djIHYwSDveeopA8VGTV8RG47+U6q62d7H5d3xC8k43NOBH0Zd0gnp7R2BSRzBw4SPdVwoNNB/ry7NqGU1Sq1OniuBqu/1QSrkRshI+Dh0/LS2MaZJ5GQnD2YCbXZJByzJdPmTuGSYPyERr14EavVtt1oHdsmxxP3b0Aw1uW59rclGihqEMTV1JcCLtg7k20gP1yGr/5yK/7heERSUhjr4shWQzdKuocmy672dTIggfdgjXizCnAEtCbjbYrkJj1oNfRYQDZO4cDFaNLn8vgBPLQeCXR6OwZisMod9QUPio9GfMBMCXnTjzsvZSQUQIFP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf6e39d-ca5f-44bc-f198-08dda343d4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 08:43:08.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUrciJWyRmT2LClnWrlGpfSDKuMlkmbgRElgqqts+h6xJuvoVSwOwVSSsHKSXKxusoLGlXPFwnT6tz395/LLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10414

U21pdGEsDQoNClRoYW5rcyBmb3IgeW91ciBhd2Vzb21lIHdvcmsuIEkganVzdCB0ZXN0ZWQgdGhl
IHNjZW5hcmlvcyB5b3UgbGlzdGVkLCBhbmQgdGhleSB3b3JrIGFzIGV4cGVjdGVkLiBUaGFua3Mg
YWdhaW4uDQooTWlub3IgY29tbWVudHMgaW5saW5lZCkNCg0KVGVzdGVkLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KVG8gdGhlIENYTCBjb21tdW5pdHksDQoNClRo
ZSBzY2VuYXJpb3MgbWVudGlvbmVkIGhlcmUgZXNzZW50aWFsbHkgY292ZXIgd2hhdCBhIGNvcnJl
Y3QgZmlybXdhcmUgbWF5IHByb3ZpZGUuIEhvd2V2ZXIsDQpJIHdvdWxkIGxpa2UgdG8gZGlzY3Vz
cyBvbmUgbW9yZSBzY2VuYXJpbyB0aGF0IEkgY2FuIHNpbXVsYXRlIHdpdGggYSBtb2RpZmllZCBR
RU1VOg0KVGhlIEU4MjAgZXhwb3NlcyBhIFNPRlQgUkVTRVJWRUQgcmVnaW9uIHdoaWNoIGlzIHRo
ZSBzYW1lIGFzIGEgQ0ZNVywgYnV0IHRoZSBIRE0gZGVjb2RlcnMgYXJlIG5vdCBjb21taXR0ZWQu
IFRoaXMgbWVhbnMgbm8gcmVnaW9uIHdpbGwgYmUgYXV0by1jcmVhdGVkIGR1cmluZyBib290Lg0K
DQpBcyBhbiBleGFtcGxlLCBhZnRlciBib290LCB0aGUgaW9tZW0gdHJlZSBpcyBhcyBmb2xsb3dz
Og0KMTA1MDAwMDAwMC0zMDRmZmZmZmZmIDogQ1hMIFdpbmRvdyAwDQogICAxMDUwMDAwMDAwLTMw
NGZmZmZmZmYgOiBTb2Z0IFJlc2VydmVkDQogICAgIDxObyByZWdpb24+DQoNCkluIHRoaXMgY2Fz
ZSwgdGhlIFNPRlQgUkVTRVJWRUQgcmVzb3VyY2UgaXMgbm90IHRyaW1tZWQsIHNvIHRoZSBlbmQt
dXNlciBjYW5ub3QgY3JlYXRlIGEgbmV3IHJlZ2lvbi4NCk15IHF1ZXN0aW9uIGlzOiBJcyB0aGlz
IHNjZW5hcmlvIGEgcHJvYmxlbT8gSWYgaXQgaXMsIHNob3VsZCB3ZSBmaXggaXQgaW4gdGhpcyBw
YXRjaHNldCBvciBjcmVhdGUgYSBuZXcgcGF0Y2g/DQoNCg0KDQoNCk9uIDA0LzA2LzIwMjUgMDY6
MTksIFNtaXRhIEtvcmFsYWhhbGxpIHdyb3RlOg0KPiBBZGQgdGhlIGFiaWxpdHkgdG8gbWFuYWdl
IFNPRlQgUkVTRVJWRSBpb21lbSByZXNvdXJjZXMgcHJpb3IgdG8gdGhlbSBiZWluZw0KPiBhZGRl
ZCB0byB0aGUgaW9tZW0gcmVzb3VyY2UgdHJlZS4gVGhpcyBhbGxvd3MgZHJpdmVycywgc3VjaCBh
cyBDWEwsIHRvDQo+IHJlbW92ZSBhbnkgcGllY2VzIG9mIHRoZSBTT0ZUIFJFU0VSVkUgcmVzb3Vy
Y2UgdGhhdCBpbnRlcnNlY3Qgd2l0aCBjcmVhdGVkDQo+IENYTCByZWdpb25zLg0KPiANCj4gVGhl
IGN1cnJlbnQgYXBwcm9hY2ggb2YgbGVhdmluZyB0aGUgU09GVCBSRVNFUlZFIHJlc291cmNlcyBh
cyBpcyBjYW4gY2F1c2UNCj4gZmFpbHVyZXMgZHVyaW5nIGhvdHBsdWcgb2YgZGV2aWNlcywgc3Vj
aCBhcyBDWEwsIGJlY2F1c2UgdGhlIHJlc291cmNlIGlzDQo+IG5vdCBhdmFpbGFibGUgZm9yIHJl
dXNlIGFmdGVyIHRlYXJkb3duIG9mIHRoZSBkZXZpY2UuDQo+IA0KPiBUaGUgYXBwcm9hY2ggaXMg
dG8gYWRkIFNPRlQgUkVTRVJWRSByZXNvdXJjZXMgdG8gYSBzZXBhcmF0ZSB0cmVlIGR1cmluZw0K
PiBib290Lg0KDQpObyBzcGVjaWFsIHRyZWUgYXQgYWxsIHNpbmNlIFYzDQoNCg0KPiBUaGlzIGFs
bG93cyBhbnkgZHJpdmVycyB0byB1cGRhdGUgdGhlIFNPRlQgUkVTRVJWRSByZXNvdXJjZXMgYmVm
b3JlDQo+IHRoZXkgYXJlIG1lcmdlZCBpbnRvIHRoZSBpb21lbSByZXNvdXJjZSB0cmVlLiBJbiBh
ZGRpdGlvbiBhIG5vdGlmaWVyIGNoYWluDQo+IGlzIGFkZGVkIHNvIHRoYXQgZHJpdmVycyBjYW4g
YmUgbm90aWZpZWQgd2hlbiB0aGVzZSBTT0ZUIFJFU0VSVkUgcmVzb3VyY2VzDQo+IGFyZSBhZGRl
ZCB0byB0aGUgaW9lbWUgcmVzb3VyY2UgdHJlZS4NCj4gDQo+IFRoZSBDWEwgZHJpdmVyIGlzIG1v
ZGlmaWVkIHRvIHVzZSBhIHdvcmtlciB0aHJlYWQgdGhhdCB3YWl0cyBmb3IgdGhlIENYTA0KPiBQ
Q0kgYW5kIENYTCBtZW0gZHJpdmVycyB0byBiZSBsb2FkZWQgYW5kIGZvciB0aGVpciBwcm9iZSBy
b3V0aW5lIHRvDQo+IGNvbXBsZXRlLiBUaGVuIHRoZSBkcml2ZXIgd2Fsa3MgdGhyb3VnaCBhbnkg
Y3JlYXRlZCBDWEwgcmVnaW9ucyB0byB0cmltIGFueQ0KPiBpbnRlcnNlY3Rpb25zIHdpdGggU09G
VCBSRVNFUlZFIHJlc291cmNlcyBpbiB0aGUgaW9tZW0gdHJlZS4NCj4gDQo+IFRoZSBkYXggZHJp
dmVyIHVzZXMgdGhlIG5ldyBzb2Z0IHJlc2VydmUgbm90aWZpZXIgY2hhaW4gc28gaXQgY2FuIGNv
bnN1bWUNCj4gYW55IHJlbWFpbmluZyBTT0ZUIFJFU0VSVkVTIG9uY2UgdGhleSdyZSBhZGRlZCB0
byB0aGUgaW9tZW0gdHJlZS4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgc2NlbmFyaW9zIGhhdmUgYmVl
biB0ZXN0ZWQ6DQo+IA0KPiBFeGFtcGxlIDE6IEV4YWN0IGFsaWdubWVudCwgc29mdCByZXNlcnZl
ZCBpcyBhIGNoaWxkIG9mIHRoZSByZWdpb24NCj4gDQo+IHwtLS0tLS0tLS0tICJTb2Z0IFJlc2Vy
dmVkIiAtLS0tLS0tLS0tLXwNCj4gfC0tLS0tLS0tLS0tLS0tICJSZWdpb24gIyIgLS0tLS0tLS0t
LS0tfA0KPiANCj4gQmVmb3JlOg0KPiAgICAxMDUwMDAwMDAwLTMwNGZmZmZmZmYgOiBDWEwgV2lu
ZG93IDANCj4gICAgICAxMDUwMDAwMDAwLTMwNGZmZmZmZmYgOiByZWdpb24wDQo+ICAgICAgICAx
MDUwMDAwMDAwLTMwNGZmZmZmZmYgOiBTb2Z0IFJlc2VydmVkDQo+ICAgICAgICAgIDEwODAwMDAw
MDAtMmZmZmZmZmZmZiA6IGRheDAuMA0KDQpCVFcsIEknbSBjdXJpb3VzIGhvdyB0byBzZXQgdXAg
YSBkYXggd2l0aCBhbiBhZGRyZXNzIHJhbmdlIGRpZmZlcmVudCBmcm9tIGl0cyBjb3JyZXNwb25k
aW5nIHJlZ2lvbi4NCg0KDQo+ICAgICAgICAgICAgMTA4MDAwMDAwMC0yZmZmZmZmZmZmIDogU3lz
dGVtIFJBTSAoa21lbSkNCj4gDQo+IEFmdGVyOg0KPiAgICAxMDUwMDAwMDAwLTMwNGZmZmZmZmYg
OiBDWEwgV2luZG93IDANCj4gICAgICAxMDUwMDAwMDAwLTMwNGZmZmZmZmYgOiByZWdpb24xDQo+
ICAgICAgICAxMDgwMDAwMDAwLTJmZmZmZmZmZmYgOiBkYXgwLjANCj4gICAgICAgICAgMTA4MDAw
MDAwMC0yZmZmZmZmZmZmIDogU3lzdGVtIFJBTSAoa21lbSkNCj4gDQo+IEV4YW1wbGUgMjogU3Rh
cnQgYW5kL29yIGVuZCBhbGlnbmVkIGFuZCBzb2Z0IHJlc2VydmVkIHNwYW5zIG11bHRpcGxlDQo+
IHJlZ2lvbnMNCg0KVGVzdGVkDQoNCj4gDQo+IHwtLS0tLS0tLS0tLSAiU29mdCBSZXNlcnZlZCIg
LS0tLS0tLS0tLS18DQo+IHwtLS0tLS0tLSAiUmVnaW9uICMiIC0tLS0tLS18DQo+IG9yDQo+IHwt
LS0tLS0tLS0tLSAiU29mdCBSZXNlcnZlZCIgLS0tLS0tLS0tLS18DQo+IHwtLS0tLS0tLSAiUmVn
aW9uICMiIC0tLS0tLS18DQoNClR5cG8/IHNob3VsZCBiZToNCnwtLS0tLS0tLS0tLSAiU29mdCBS
ZXNlcnZlZCIgLS0tLS0tLS0tLS18DQogICAgICAgICAgICAgfC0tLS0tLS0tICJSZWdpb24gIyIg
LS0tLS0tLXwNCg0KPiANCj4gRXhhbXBsZSAzOiBObyBhbGlnbm1lbnQNCj4gfC0tLS0tLS0tLS0g
IlNvZnQgUmVzZXJ2ZWQiIC0tLS0tLS0tLS18DQo+IAl8LS0tLSAiUmVnaW9uICMiIC0tLS18DQoN
ClRlc3RlZC4NCg0KDQpUaGFua3MNClpoaWppYW4=

