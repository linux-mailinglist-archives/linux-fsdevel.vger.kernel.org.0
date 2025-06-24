Return-Path: <linux-fsdevel+bounces-52683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84CAE5CA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8D7AD729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF823909F;
	Tue, 24 Jun 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D8CK1o7c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AD1zWscg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3522FF22;
	Tue, 24 Jun 2025 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745377; cv=fail; b=FQ33vzB5szZdfNV8uFHy5cGVBHh42CxAtDKE3TrsDWCrFg2hHwWLVX71yt64bXuEGgex39G8IsTE2Qn3jwWfR/8dw0IfVT8/URZPboPiQRBchj+0kylghePCQ5K+szv/Sr6iwHYDzF1yEpAX7CY+vIupxMWsjArru9OwiLe+tU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745377; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ztses6k+LOFYdoVkINXaaky//frgaqCc3yCZB/GPwoHPZ9efcy5A8XrxY+yyKogXw59NW37IFArNS7/A/Mt5BdQEKtKBaamU9JPWg47trSe5Di+vKkITMMT/ZPOyPHODfYSIN3VpvIT6BsNEBR46wDr53sTLPeSQUv30Dy0v7rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D8CK1o7c; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AD1zWscg; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750745375; x=1782281375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=D8CK1o7cYSws8cgDQ0vFlTHtz9O6OA7JuxRLw2MoA9pZTR7fHFnkiY9x
   SVwbhpXxczQlAbIqKloqNsboFgpBSHNm/8OXgnAiA5bzz3n+AG5CHdSxt
   wBDA+rkeb9e7vfzdqaHQg7ijXDIT8KHwcyVLXjtam5Q1DUNtxAzltZ9ve
   Vkcl757c5fMzmTT+4h7AXWUlP0wJxa5Wq+CzGpInElEjtV+DS1bYDarXV
   dWuYXRP1wcXUH2Dau33A9R+cL4pLr4LrCb8Qlf7UWvidlaQL/gVZp3RB2
   jHBQQxNrZeYYU2BWmdeb5CzIvphNYKDZrZcwGRe1kesbiFcoJ1JWd2L0L
   w==;
X-CSE-ConnectionGUID: QjeTfp56T6+VYh51FP3kbg==
X-CSE-MsgGUID: 8ojIS4z3SYyAACb5zzOQsg==
X-IronPort-AV: E=Sophos;i="6.16,260,1744041600"; 
   d="scan'208";a="85119782"
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.42])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2025 14:09:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW5hVxL0bf9MP5Vodqo5ejlZ/nsU8VRo+cDXBSZpFgnOLI1YLGd672lgK406hfRu6s1/relblsPzSpKJ/x13hHErS5zTCxZwOXifkmoGIDIYqV55oMSGlptIi/zTcz/zqEPDmuCvC83PVqHPCDCG7cqT2p/yJY14cY3Kzw8TGAFpdtIMpK21/JbFnFz3yHO6DHn6reargtAQpVdxNVadEvj31wUPHTmNKsNENtGRpwU90vUzVMlGbDRBm2brqCUPli8y029xZmd55qVHRs0KTng+F2022/OtsOivLWzr8WpMn22kifKVBU5wMgBAnP0nQHmq9SQ+w5yTvgPCWjnG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=TFiWIOPGVAPVyHyZg1Ix+g0e+B26c3tB1USJo9hknmBBJ/KM/LxIikMy4kYTzW6UzprlaUc8lfOuyV7JS/aveU5klCcYQbK1WmtFq352l4wE3gRAqLFj74ahcMLoUU5NYKjAy06qBWpDfhBZNaTxDU/chStGitNDs0CAb6qQIfRjGiWLpmu4grkRaN3Q7W9UgJtIEGyDSu0Whi1yE53J2jmub0ZL/8ZNlwDkm8P+uVKAzxRzDteW0qYiCJiZqQrqxryMDOMnW2UWiuHJ6JU1EYJC7yEfKNqDZiSN/nsBuCBfSuZYOUC451Nhnc0WaKkzg6mQrXXEZs1iTZ4w13tWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=AD1zWscgeWqkZAiF72lThGwnwnlxd6BuoFSnO6lN3Q7tPvX7ZCHofq5/BTZ7g1JmeGlwn+VMX2SBnbDzpiror8R+Ba4ZhZKVi6K4AYNvmLp8dw5SuM/EqE42crQ5W2eLB5Z8bmlziP5JzPPeXFXDa63pBTK2A8kURFvlWCwcJdk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY1PR04MB8629.namprd04.prod.outlook.com (2603:10b6:a03:52d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 06:09:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 06:09:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Joanne Koong <joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: hch <hch@lst.de>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"brauner@kernel.org" <brauner@kernel.org>, "djwong@kernel.org"
	<djwong@kernel.org>, "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, "kernel-team@meta.com"
	<kernel-team@meta.com>
Subject: Re: [PATCH v3 02/16] iomap: cleanup the pending writeback tracking in
 iomap_writepage_map_blocks
Thread-Topic: [PATCH v3 02/16] iomap: cleanup the pending writeback tracking
 in iomap_writepage_map_blocks
Thread-Index: AQHb5K72t5eOSvZKO0WovhdzwHd6lLQR07AA
Date: Tue, 24 Jun 2025 06:09:23 +0000
Message-ID: <284b449a-5ebb-4c11-bb77-37f8242472ff@wdc.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-3-joannelkoong@gmail.com>
In-Reply-To: <20250624022135.832899-3-joannelkoong@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY1PR04MB8629:EE_
x-ms-office365-filtering-correlation-id: 6dde3f47-1e50-4fa6-0ed9-08ddb2e5aad5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3NlK3JkTGtUS3lvMVluZE1XdCtpYnlQeWkva05sbUlMTkpQWlNJcm9INUk3?=
 =?utf-8?B?eHA2WTh4ZXJpeC9kUytaTjNzMzNici9RMkxxMmNxYjBBbTJ4ajk1a2VCZll0?=
 =?utf-8?B?djRPU1VQRXlpSXcydXdMY3lZV3Z0NDQ1TjEwM2hSNlNSME1MeEl0SDVPYXhJ?=
 =?utf-8?B?SWxPY2pmNVdaUmNteXBpNUJWUTQ5eWM0OTEvNGQ1MHlGeGlpMWVlMlNUa3pq?=
 =?utf-8?B?UFM1R0tTd3l2ejFnZzlMNjlLcGc3ei9GNFhpSTRDMndqMVB1V3RLeVpNdUxa?=
 =?utf-8?B?U0s2blFTZEN1cTZXK3Z0Vm1iSWo1aG1WME9BQjVuN2tCSE5FbVI3QlE0cWRZ?=
 =?utf-8?B?YWZRckVqT0xFWTRTakFjWjR1dWRQQndULzgzSzBiR2lnSGs2eDRnUTU5bjdu?=
 =?utf-8?B?WFdJU203aW9xTlAwTGgxdzhGeG9BVTJ1VXZ0OVp3eHJjQmdDZnZETWRHTi8x?=
 =?utf-8?B?OTFac0Q5c1NWT1pXaUFZYUZIbzNOQTI0TTJwU0FHUFU3amxUUW4yUGFRd0Zl?=
 =?utf-8?B?SG9TekNnZVVuSFA3WW1sWjY2ZVR6RHRid0E1bERGUDNveTJZdStUMUU3dnA1?=
 =?utf-8?B?TlBPdG5IK1phNk1WWWdheC96SXFIcnpnL01xc01zWnhVRU13amFLQUFtelVQ?=
 =?utf-8?B?QWUrKzk4dTdTUXB3ZmFTVEpEaE9RTERvdlVOQURvdjliZFBTUkJ2Q3hxcXBx?=
 =?utf-8?B?cXIxTGsvOHVaSmNVdEZmaUprTjFmV0xobVJNREc0Wlp0Q01ITnZac3Z6UFFi?=
 =?utf-8?B?dHJ3aC9HbmREYTZrNmRVUUgrRmlEb0haMkpicU1IZjM5MEpvTm5UNDBkTU40?=
 =?utf-8?B?emEzY05Vbnc5aFpROXQ3bTB5R2NJeldpa2FWOUt1WU5YK3A4ZUNNZCtCSW5s?=
 =?utf-8?B?dzRtNE1nL0VOUTM3MnpQbTdmYzYzS0NpMDkyUWlDcE1IWlNLU1E5YzQzeitB?=
 =?utf-8?B?S2lDOXlxNnl1NTQ1c2RqMVI3NW5JU0dYVVRBb1dtNG4vTW40YjdRMXp3T3cw?=
 =?utf-8?B?aU8wdzVYdE1qekhJNTVwRHhGZHUwR0x4QTg2MU0vUloyZEJTNTF2bTYvNkpG?=
 =?utf-8?B?RXdObzRWay92ZWJCcUJES3Q4N1h2SWtrWlpkM1E1YmlkbHh5VVFYWGI2cytj?=
 =?utf-8?B?bjlUVWMwSUNrbHljandsaVo0c0l3a3Zod1NxdGdqNFhzZGZ6cmcwNW84QVZ5?=
 =?utf-8?B?V3ZUT1VyZDMwZXI2OXJreWtwSEYxUS9HUXhhMEtzNEh1SSt6SzJ1WEpURnQ2?=
 =?utf-8?B?NE1HaWllQ0pEZFlSV3hwMklJM21FK2xMSGRGVmFkRWFmcDl0OHpPZTBRaUhx?=
 =?utf-8?B?eitNS1h2QmNKdFdTUHhtOEg2UGVhUXFUUDVXeWdBVG1XSXA5N0kzUjVSL1pN?=
 =?utf-8?B?emdEdHNTZG5mRGo1UEZMQmhCbEQvNVlXK1RWOG0zRTJnR1ZuVjU0eUxGRGd5?=
 =?utf-8?B?Vm1rZVEyRzFiQ0RZVEQwbnVaQ2lISDhnZCt1RWNOTlljYkIwRmRwK1dGQkV0?=
 =?utf-8?B?VExGT1djQzIxYWxFa0N4TGg0bnJQMzhUWG9EUkl2dGxrNjhzWUZGeXBvdzk4?=
 =?utf-8?B?aXRwaXRub1Baem1oQWxiQmxGWk9FQUxSZDhYaTBlenIrZHg0c09VMmFLUlVY?=
 =?utf-8?B?K3lQaFVBL0hNOTlGZTl0VFpaOGNWKytZMHl5V1Z0N3R5aXh5cUZQZEE0TEN1?=
 =?utf-8?B?QUVBcU1EWVM1MTF6cDZoQkZmQjNxMHU3cTZFVHJZeFlFSE9Dc0FxVnFLM3J0?=
 =?utf-8?B?SXJsMjhTb0xLQlhRdTg1SHo2WC96NlU0czBMQ1F6L0NXUDYvVkQybHhieFJZ?=
 =?utf-8?B?VVh0L3owYy9TdXM2WnFFR1hjQnozZ2pNWlZIaG1HdmVHQnpOY2piVGlsQTNk?=
 =?utf-8?B?bHZwSFByYmJ3YmNxbnlqNlQ1K1JTakk5VjZnbEp2bHVXcFpBcFZRbmJZcFgz?=
 =?utf-8?B?SHlsM2JuYlpReHFjU1ZadlBUMVFxYU1hakI5ZHB3QUszeGNHY21MNWdYNnZD?=
 =?utf-8?Q?D5N3Op9ZAu7bmyd1HtXTc0Dq41OqxU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXh3d0wvbVBmNjE1ajZ1ZWZMMEtrTmdueThrN3dXNTJzVzgwZEFGbVRNZ25T?=
 =?utf-8?B?cVlWSXlvWTdYaFlyVGdDYUlCSHRDejM5bEV4cEJFUzM4cS9uaUQwVEZuY2VG?=
 =?utf-8?B?WVZWbUlBUDk0YzF2dTRzbXl5YjE5MXJoTHdQNWJlRW5vT0hWM01hS3FBSE9P?=
 =?utf-8?B?eDh6aWlhT0txSzhiVUtkZmxlWUtrQktzWW53SjE4cmpYcjVSYnBPVytBVVoy?=
 =?utf-8?B?TjB1Qm9GQ1VoQVQ5b0FHdVlWR3RQVll1d2J6QWo1eFlNRTVFZ1g0MXJhd2xJ?=
 =?utf-8?B?R0FHZG9BK0hGeEFkMVM0RVFqWEE1WW1BRVNJWXN1MGFud2hqZUhKeWd6Wkla?=
 =?utf-8?B?QzRRam1ZSmNNNy9JektDWDhkMDBxKzFmSTZyMUlDRVdRWE9WaDFVSHFnZmhj?=
 =?utf-8?B?UXQyVGtVVUN1WTdrOHF2Q1pGbjBvRHNKa2N5VkJvaWJucE9tbnZYOUJtQVpJ?=
 =?utf-8?B?TTN0elZuNlcyVnhSY2R1ajdueEs3WTN3VHNvZkJ1OXMzZ1JrTk1VdW10Sy9U?=
 =?utf-8?B?OGVlZW8rbDZyMXpHYTR4LzFYclIrcHJoT3JxdWxES2x2RU1kRmJBNkdybVlI?=
 =?utf-8?B?aG1TekJXaUdzRFlVQUZwS2pTMWVVY0VrNVNJTVVGTVA2UHdEYU90ZUxjREdq?=
 =?utf-8?B?T1BGZlZ3ZmFybEhJRG9DaGNCQ1M3UzN0UzZ5dHJFV0o2aGtHVnU3cmszcDVm?=
 =?utf-8?B?Y2c3WGVSUGhVbXJTY0YxTTRDTGJZdGI3RzJVaE1DcXMyNkJ3bkwxV0hKd0kz?=
 =?utf-8?B?WG5yY045MkZXeWk4UWRGSDgrZVNQUXpXeTI5eUFoZ3JFRFFDYkoyeXJqYkY1?=
 =?utf-8?B?bXBla1pRMHVrbEFXWjdscTVnSHhlblBUSmlnNU1oaWc2cG4vTlNkU2JYS1hj?=
 =?utf-8?B?WFZPWEV0RkJscGJ6VFNuMnd5VDJvZStJdkE2NS9RdFExVjNqVE5HYm80UDBH?=
 =?utf-8?B?MmhLUEhCbEk3WlpjM3YweW1yTlVyTlIxQVVYNitKWUZuVDdGRjIzMUhzbjF6?=
 =?utf-8?B?Qk54K1o5bEJILzNjb0NUZlF6TG1vWGI5YkZYRGtpSXBrbC85S2x4YkRVK3dD?=
 =?utf-8?B?NnJWQmhYRk02OFJ3emlZV1RZbmdCaVVDU2RYWXFLMmdCMmp1RnFFRWVvV0FO?=
 =?utf-8?B?U0VPWHFQeHg0M2xtcm9BdGRVUUd4REZMUkMwejlDWnV3dmt4SnZNM1V4c3BZ?=
 =?utf-8?B?dFhtUDFBZ0lESnVkZ2ptNVl1Wkc4WVJ1ekU3MmpWWHkzUmdmWVZGNEJLSzl2?=
 =?utf-8?B?a0MvbGFmVVZvbkRVTmtzQlg2MWJ4YTJ1cVZYYXY1RHVkQUo1UFN3RHdWMW9i?=
 =?utf-8?B?M0IxMFJ6RndWQXM1Q3U1RTN4WC9iSklLKzdpUm9mc0FDL3p1UzRpbXRKNWQv?=
 =?utf-8?B?L3BZQTlUYW13ejQzdU1tSFNGcDBoeU9saGQyWlBzTzgxQ0pva0FIamNPYUNG?=
 =?utf-8?B?NklPdWpxcmdKY3hTbzBsaGxmRVNTM25Nc0xaNVphNW9uNXpRaDJpQnIySjln?=
 =?utf-8?B?NVBHVkxqc0JKZlFmNlE4UndqaWhkKzhiYzNXaXJDZ0VBSFVWdWZlcEdxM01s?=
 =?utf-8?B?cXNCMGgwdWQ3R0dTbHo1L09BRU5BVFlFQXpvMHBSNXZUZzlONnBLYWw1aWxa?=
 =?utf-8?B?NUlUVWtiTXJ0NmRYcGxQYUxaK1VvK2hFbjR3bjl0d1BOUjhsbzBpQVFMY3Na?=
 =?utf-8?B?eTdKNy80RzdzT2R0ZjdxdFBZMm03QkwwSzlhc2F0ZUJuTXVsVWRNQWxNclV5?=
 =?utf-8?B?NThjVTNUVG4vS3NiZm9LZ1VnWFZrUCtSZ1Fsbzk2NGdJK3hSM1hJZTdHbHRV?=
 =?utf-8?B?aTFwd085RXR3U1o1bk5CSFF3M01sOFJ4NDlnSDBqN1BneFUyL0pjTkpGdXAz?=
 =?utf-8?B?cWhHcVVMNjNsa1FVbmJtUFJFdklKRUhvekEwMXRDOG1OemhzWkJJR0tydHk4?=
 =?utf-8?B?QklXNWtyYmlvTFRYallGMjJXUDBrUkdIR0pzZ0hzQ2M1TTdieHFmdEFTckd0?=
 =?utf-8?B?OWEra09uL0oweEp3TkhRYlRjSGxqWUFLTGxEeUxYVWp1emNjZUtMSTd1ZmZQ?=
 =?utf-8?B?c1pMUDh3OFpiTlcwQ2liLzI4dmtaNGJsNDVvejgwelRWRyt4eGdjLzFVS0tK?=
 =?utf-8?B?ZXVyOG1QUHE3MTB5MnV6RUNIUjBOVWRXVFJVSWRsdjVSbEp4bEFjM2tucWNB?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08D844BB9A5E4D4C9759D916248CF452@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	opbrc8Fmd4FyPRo/gAJGQm2TC3kwiF3kKVeRouObpW/bWCCPaTxrPm8urNftNRoiPZmbz/7ymM7LUyKLHH3LOTccu8gMx51oJBYdKqQ6XtXQjBTSiXBLYdn+zBTegW78mA1VROPTWFmyW6485bl8yk0Jhg1dgfI+DenP5s5+M97A1cXSkxRkiL3OxNk5I5wc86XWwF3j0gN5WdhYMOkdpbvYP15DqPczj0YwO+3pCncgCmIY9y7jq02+U6YACfFI21AXGVFQh82+/nw8jh4QrCZzZZeFbDIXcr2ofdICd7fTwsywq2YpvCg7P8pcWip2L4p4oXCALj8c9kJ74Yb62QKYWemY93PnoPNM7g7rCQkclNK3+R8DniBFLvYt/PbecjaoLkjCCy29/FHN6rEvk4Hg0LSO+r8reDy3XcDHo4gqwmbn8gp+8WFEQp93WRP3zgA9Ovbtf37YXi7vF9rIkeAhkAy44FzHeUyKu4DM12m0TeUBGKApmX4Dl5pPvRDXQt7lthH41xWUXYv2yY/0tcgaISc9MRTXiBIxoRWFw+69GTjfWszas4reoHfknPYLZLJngWGfBkUzx59CnCcMPRwCOWgncmqyotoU5e8Vt9l8HBympJaFrGSt+ycqajyL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dde3f47-1e50-4fa6-0ed9-08ddb2e5aad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:09:23.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1TBA8gjQvzegbZH8z6+Eect5zeUrnC/VBKuW87HxL/Q7fvPnOXABBnAJmFENB5Li5rhIFHIMRvLWFxBVvbTQGbC2i66K2AhGYJS5PwhhAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8629

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

