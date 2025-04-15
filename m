Return-Path: <linux-fsdevel+bounces-46454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E273A899E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5AC1650EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7FD28BA95;
	Tue, 15 Apr 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fx3NOn7e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AJUhU2jD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF127FD4D;
	Tue, 15 Apr 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712615; cv=fail; b=OJeRtUkp/pXYHtPi2k3uxEZNleAvL5UayBALN9QL1AsX3Yal7h4vmULgpGvIlPGvMNQ2cmejt+uv02ZG04+Pyg2l+3er3FOzTj4CX92HOhuo45oQdpUINne0gGMZj7WNj54lA++a+RmQpg8gz/UPniTyvRd40lHPxthTjky4BCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712615; c=relaxed/simple;
	bh=2X+/eO6prqi7ZKBKsMuQwqC1h0fomFO2zmsa9jO88q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LG5GyVdGwuBWYwjAKGKX/ExO9oRnMoqhcb7wCeiNND//3fPdrEYnYbrFkRVR5C8pnN626ujNHIGsvi1504fYqUJuvLWVklc3UmqX6AQxp1VPviewfkIQFCyzV2h52EmpW33PE2KGz6bci0yzsKrYoz+8mN5fXNHfE9K1CAmTaVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Fx3NOn7e; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AJUhU2jD; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744712613; x=1776248613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2X+/eO6prqi7ZKBKsMuQwqC1h0fomFO2zmsa9jO88q4=;
  b=Fx3NOn7eCgTYZwCgbO9GytBIG8ymab2+hsdgLfSfWu0UyPVvtNFUv42M
   6789vf18fqbMxU0B/M+QOl33agw9ZFawH/4oGVAiwJQTUNrnh78bdEvQN
   CYYDEqRZRznulEsZKfxwk/JvrWguZSRx02rRRBWVEAWmywz72r/u8uf+z
   mVq8e5D1uqwoKBxrpJoEWvEuQ/FPD1o0gTGGquc+sOu/o3XGONNE2/c5J
   FMRGopbwy+Oioj9XHbIGDn+sO61JOZdi+yn70mNFhdRwBCUrJ2oL2ZRgr
   e/lmZToif44/OvIErkY9JD/JwJhZOlK0fIbj1jh05NB3ejZt1ub4sWvoZ
   A==;
X-CSE-ConnectionGUID: zD0R8Si1RJqj87MwNo6UHg==
X-CSE-MsgGUID: anOv3G4aQ0mq/EnNcJiRrQ==
X-IronPort-AV: E=Sophos;i="6.15,213,1739808000"; 
   d="scan'208";a="76192419"
Received: from mail-eastusazlp17010006.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.6])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2025 18:23:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNTSs8xXRQhqHEzub9NVY+3hqmALNFA1i8FGBGRg55pZrp1nYiVdFZ9G/GYAprumeRFJqZxCj+q67qlWbhDuU75xh5itxkGSW/6y7+ee/bOW4CchjgEOeWYPVDdkVR30aBBn7jqZKx1NjF1bDjIz372Q2HBkMQfIrO9zQ2Nxx/1iH6pL2dSb2/yQQ0R9Y7NEH4/9e4CCwvE5MVpEi6EAKce1wTYCgcw9dNLhYecJ0gtAQ141MPc2mkqmfn254sc8xb1giwDpl5WmaUqyWw3fLXT8wiQmQHXFlO33xE2PxkhPkFGUCQeCGTiydghJM6SZmdga15wdzXj50SdBskvD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X+/eO6prqi7ZKBKsMuQwqC1h0fomFO2zmsa9jO88q4=;
 b=DcHjnnN5v664adhmK7abKzlQkVX5Q0KD/RPW71JoyMSwnApR+ut8YJhtYDEQy+dljZMiI2MzT8cLSJmHUtd1Ieoj1K1Ii06eJQDtOXiC4HfOnwKscssIO16ndgJz42uCwTTi116gNnQ+xd1P7K19iy2QWyDScBQvj6rF3I0J/yvvYE2G5z8eVCnE/L5daA+97ghbjFFDz3Aop6Onip9cLgkavKMmGyXhy0LsnXNDlEpfitsiQ1IqsasHbfHl7IJou3EpfrRO/s5/GhNiGXnuayRnVGWq6UtBAyj/nkL6yBnUxuIAkx8v2dobbBpbWi5XV55DKKb9vpaAE0tD0zKI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X+/eO6prqi7ZKBKsMuQwqC1h0fomFO2zmsa9jO88q4=;
 b=AJUhU2jDLeBTHcwYUBlmpAm/LQFJ3euC6o9s+jaKvnVNQyOvxaM9cNCxdnGt5qxw+ydnEZPq+e85h3ytlcWusync/8vCA4SvB2O2kZsVAeHiqiyoqcR/FpQSBxJKbiNkk9R8NXW1JGGGsVX5vxsySZUT3zhRRUDeLtO77WM9R7g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN7PR04MB8644.namprd04.prod.outlook.com (2603:10b6:806:2ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 10:23:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 10:23:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christian Brauner <brauner@kernel.org>
CC: David Sterba <dsterba@suse.cz>, Linus Torvalds
	<torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>, Viro
	<viro@zeniv.linux.org.uk>, Bacik <josef@toxicpanda.com>, Stone
	<leocstone@gmail.com>, Sandeen <sandeen@redhat.com>, Johnson
	<jeff.johnson@oss.qualcomm.com>, linux-fsdevel
	<linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Thread-Topic: [Bug Report] OOB-read BUG in HFS+ filesystem
Thread-Index:
 AQHbrUhNty3+fdMAPUuyNCJ0QAeZCLOjPRqvgAAbcACAAQOfgIAAF40AgAAEDQCAAA6GgA==
Date: Tue, 15 Apr 2025 10:23:27 +0000
Message-ID: <8bd5e290-cfda-4735-a907-27611d1aac67@wdc.com>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
 <Z_0aBN-20w20-UiD@casper.infradead.org>
 <20250414162328.GD16750@twin.jikos.cz>
 <20250415-wohin-anfragen-90b2df73295b@brauner>
 <786f0a0e-8cea-4007-bbae-2225fcca95b4@wdc.com>
 <20250415-razzia-umverteilen-4e8864b62583@brauner>
In-Reply-To: <20250415-razzia-umverteilen-4e8864b62583@brauner>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN7PR04MB8644:EE_
x-ms-office365-filtering-correlation-id: e0f13b87-6b52-41c5-e5db-08dd7c079032
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGpUMkU0U3h3SmN0YUZQL1hma0czNVRoa2duNE5SdkpadkdzZFVyK05aUFln?=
 =?utf-8?B?UlFjb0RBcEN4aUFreE9ZRU1XOFltVTVjRlZOTUdtdjRUa3g4UUdzVzMxN09Q?=
 =?utf-8?B?aWdYSm1kOHA1NkFCbUViaDNLREg1ejBWaWQ3ZlVqeDhyNnRSeVF2Tlo3a2pE?=
 =?utf-8?B?TnlxSkVieWJhRExUUERxSzNjMTdjTG5rdVZnTDRkSmEyaHBGeTlFT0FkeVBB?=
 =?utf-8?B?U1BubEFLd3pGZWk3TnZMaXZaVm5XNzlYSXY4ZkxXdlI2QUN2SjZsZXovTzNq?=
 =?utf-8?B?emR6eVZSa1NQcHlFNktSOGdkdFB2bjhNWUs1YkZzN1JzZ09XVnF1aEc0YXlN?=
 =?utf-8?B?anBZOFU1b285VnlFM0h0VWI2Y3ZDNHFYeHYyakM0S0NiN25JNGIyellOQ1Z0?=
 =?utf-8?B?UHFiWnlhZWkrSkdDNW5icGtQeC9Zd1pvUkxPOXhpV2kzVjVKUXJIT0Y2QklC?=
 =?utf-8?B?UWNaTGczZWVZcUFoVmFudXFzQ3M3WWtDdnRCeVpUMDU0N2F6eTN2ODB1S1JW?=
 =?utf-8?B?S3lUQnQxK3J0WGRLc3FadDByMzRESmZ4RkFvTjV5dHRjWFVpK0diVGZyZlRV?=
 =?utf-8?B?TjVlUDV5Zys2cXAvU25GeEx2ZENMaHdXR0l4WWdlQnErMi9WTmo2TXNONnJt?=
 =?utf-8?B?VFhXSHdZckJkL0FFNlpkNWFQSmFPaXd1QXBWMVBmaVBDUmY2Z3FHbmRpdnVR?=
 =?utf-8?B?WXhaTUdOdXlDV29OTFBRbDh1U0c1bno2WWhyZVI1VzliTUhQUEpheDgvMVBq?=
 =?utf-8?B?eFJzeWZTVGRiQWpxYVhCY1ZNblV4Y0EvemxEMVg2SDJoTWJWbVNIQkV0OEVH?=
 =?utf-8?B?bnFXTFhDV3RnZDBkMGx1WWJDa0MyU3IrUVl4c2dYblJ6QUo1TGV1dlVNNk13?=
 =?utf-8?B?NTFqTUhCVVZSSjA3aTVjZlRQUnk3NmxqNEtsc0RJMkl3ckNCTHRScHFtcVgr?=
 =?utf-8?B?MCtrdHdsT2EvTGhBZXZhT1UzQUl5YnM4WVMzSUFNS1I1Mnp0RmFGL3MvS2No?=
 =?utf-8?B?K3NaNU9oSHdnSkViN09HU091WGoyeXZBUTlVNndyQWxNNGdReTNKS1hXb1hh?=
 =?utf-8?B?STFGaUdnY3dhTWtyWlBLdGhIeThEQlk5aTk3Uk5rQVBYVTJMR0lucFEyMWty?=
 =?utf-8?B?OEN2b1hOdW9ITTNlOTh3ZGp0M3RMQTB1YVBxOWtFeVJoRTFZL3VGOWV5NnN0?=
 =?utf-8?B?dEgyQStPQ0FocnNXQXhNWWFjVEdiTjFxdTlLVUk4KzBZR2JFUVlyeHZuNEIv?=
 =?utf-8?B?VWo5cmVBZkh5UnU3QnE2dFpxL3BsSUFpRWJ2bTBXZ05ad0hPNUovUmpQYkdp?=
 =?utf-8?B?S0RlMmNlejAvZU43bHJRU2R2aWxyQ3ljL0cvcUlyMlFMTVZlUnU2a0VOb2dx?=
 =?utf-8?B?eUxabTJSUy92aUpqSjBabHFwSmJ2Qms0VzhTNzhrQW04NU51cHkxUlNCV3Ir?=
 =?utf-8?B?bndRSUlhVVlxNFlwVVlVbXZndmV0YnQrTkxaejViK0k4ajRjSmZOd3hXVzZS?=
 =?utf-8?B?aDVNSWdWcjhkbmJLR1ZHdUl3S0xZSElBaWhUUnc5c0ZDb2F2Z3hWZDRxbDJl?=
 =?utf-8?B?cWpuN1JLb25IRVQ2ZmhJUVZLcUJrd2g3VktkRTZlVzJNelNhelVBdkxaNEZS?=
 =?utf-8?B?WFVYamRVZndtenB0cGlQZEtid1RIb1ZQMUNiMkxRSUNXUjNnUUVjNDRoKzRL?=
 =?utf-8?B?ZGlSbXQwUTM4cUhsbkF3YWhLU2preDZPcUR4SXkxQzJTZ3hmSmk4RDY2b3oz?=
 =?utf-8?B?NWFUK1VyZE4xWHZReDIycWxPcFJTOEhPSUFpSWZkUmdsZHRieEowNUtoUi9G?=
 =?utf-8?B?Ni9BK2VTUmxUbTFHQ1g3eEY5aEViSExIY0Y1bC9YaEtKRytORi9WTnZGYmtD?=
 =?utf-8?B?NFVaQW9sa2phRXpWM21mM3ZmWXcrZ3lPQ3U0ZnAxTEE4a0ZCdTczQ0svREsr?=
 =?utf-8?B?amtBUnJ0anFVcmJTdWJCTmhKbEJIOVNXN3ZzRTlTZG9vT3k3M0ZtUG05RlFK?=
 =?utf-8?Q?fiBehdEbhPx+RU2aDixm/VK+xxK3x4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V21CRUhobWpKQllEenQ1bU1QNTBZQUNxSHFvTjdJcE9mSnZpT3VNSjBPRS9V?=
 =?utf-8?B?ZjlkZ2crLzhvK3JrMFlFRUsyaHFCelJRK3RvYnBzaHZyT0k2L0NVdHYwaWl6?=
 =?utf-8?B?eXRraVdTamJNTlQ3clRhOUwyYTNhcUM4b3owazBuSkVkdnZtNE1NODBNQUlq?=
 =?utf-8?B?emljeFZBeGhUNlVNRTZYczZBSVVjcm1lRGNnbDlZUEFORHZyK3lCQlVYQ0RQ?=
 =?utf-8?B?c0Z4NWE4aXhFKzVvUnptSG5lekYvTWwvOEdadU5pV0l1WlkzNjN4M1M3QkJ6?=
 =?utf-8?B?cmVMTmRXOEpkbUNkVy9vSGlPSURIeWdxY29vSXo2Vkg4Yks5aWU4dWtWQ1l3?=
 =?utf-8?B?N0gxcFJIaUFkcENGZFdtUUFjZFFLSkNYSXVEcjNHMHRYd3FpTzJPR2x4UUVI?=
 =?utf-8?B?YXJ6U2pBR2pRRnR1RCs4RFF5bXBub3pPWmIvY0VhN3pzSmRDNDB4VnlIQzd6?=
 =?utf-8?B?eEUyZEkwNWVqTVdrUmZVMFF3cFdTSWRVUC84TTJBWUptMWtFYnd4eFltV05i?=
 =?utf-8?B?U3B4ZTdxd2xIMWNEWWdCdGxUYzlXVUdDbFFJN3FpbVZJTm10UWxRMDBoNktq?=
 =?utf-8?B?bE5jOXEyNXNxcVBxbm55RFE1UTdxOXJiYUZrcFVlTXlDVS9oYitRdWY5aUN4?=
 =?utf-8?B?R3VCQzR2ZklVZGJVMXhQaTJaZ0lRVkwyTmVEZTJBTExQOVlNaDE0T1RhVmVB?=
 =?utf-8?B?Umw4RVZUTzhSQ2V4SFFLZWxGUzZXN3ZjNUlsRUVWaStuY1ZOT0EzVDNtNGNP?=
 =?utf-8?B?Yis4aGpUdDdQbDZHNzN5ZzdhdkJQQ3A0RERmNzR4MnMwUXJxVzROcW5BWXRj?=
 =?utf-8?B?Yzk1MC9MNVI2S0ZrSkttYmtMWlpKYW1sVmVZZnJFVFpQRTczdkRuQ055WXR2?=
 =?utf-8?B?bHMyTDRoVDNBVGZkZGJOcTVBbnA4UDdsSkhXZDU3WVZTTmtnMWtyM1lzWUVQ?=
 =?utf-8?B?L3gvSDc3L2N6L3VNaFh6UlF2Q1V2TWdpZ2VETkVZL21tZEIvbHdRYnRKeW1G?=
 =?utf-8?B?aHB3d1NWeUl5VVlWUlZxYmxhWkhrdldjSkY1blZ6MlJXWHlNdUxTRmcyN1ND?=
 =?utf-8?B?ck1jUUJ5OWJBeWtqY0J0eDJMOHA0RlprYnc2RDM0N0lMdDhWR1hJVWpFalpu?=
 =?utf-8?B?Y0x0MXN3YzdNTkk2Rm82am00Rm5ZbkUxVlcrcER1aEJFOVl3NU1UYnRnL0pR?=
 =?utf-8?B?ZnNKcUVyRkpvZEVRV1R4eWVOZ2VLWS9MZ01SQmw2d01odUE2U2ViUjlOa2xv?=
 =?utf-8?B?djIxZHBhWS9FU3RHRm1QYjFTNnZtbFBRdXprM1ArNHJENU5hK01xdzFHMHZt?=
 =?utf-8?B?ZlpHKzhoTjNMRE1PZGQ0TFpDUmtLcjZhRnFObkxhRHB0UG8vWGg2R2FjeHBF?=
 =?utf-8?B?S2lOOTlJUzVrR213KzlDMjQzWTNDMmhsUVltMUtjNUVodW9NanNaQ0JZQUJk?=
 =?utf-8?B?bTNBcDFXeitPZTBqUVZJYTl5UER0ZURMMjRvSVl2K3ovTSswL2Q1NytTMkN4?=
 =?utf-8?B?TGlmWWNYU1RDa2RCQ0NMWVhFeUxlMmU5dFk3TkMvNk1kQWgzNjRQN3dTNXgv?=
 =?utf-8?B?dEorUXBXZTBPYy9JRVN2LytDWlMvY2swMm1UQVlCMitLYUd4Rk9sQVg5dFBQ?=
 =?utf-8?B?T0ZQbHBBUFdFaGhzU2k0ZGFYaitWRUJwc0JpaUZNbUF6ZkhwNHBPd1V6Z01O?=
 =?utf-8?B?UFVnSFlIMVl3WVJpY29aUmtmM3BiWEtqcldIMkZrVTkyQ2x4VGhsb2N1YmR0?=
 =?utf-8?B?YWtDSVU2QTVTK2JNYnVJNXVUZU8wcURuZnltWmlndC9LdmdMYjB2dHBmZmhK?=
 =?utf-8?B?LytVbmtKNG5Fb2d5ZE1Hd0ptcDJuZmgvS0YrSXdqOTdYTDhNWThSU1dMOFN6?=
 =?utf-8?B?ZzMyTWJTeVJIUm5nV1dYa2pBUmVVaVhldXRpZmNqdVNjMHF4Ty9XRG0yMDBq?=
 =?utf-8?B?L0Nja1Z4WUx6bEEzK1NRVFJVRysrcUpiVnZjSGd5b0FoZ0lDSWhwSnNjTURq?=
 =?utf-8?B?a3Ezc2d0cVR4ZUdwbFBQS1B5UXRHUHh3aGI3dC84eVB3a3V6djU2aE9qUXBk?=
 =?utf-8?B?ZDR2TkdMRk9OeUl4eXNpUE42aGJYS2NLL29yV1ZDZzQrT1puQnMrNTI0dGlG?=
 =?utf-8?B?VUV4UXRQU3oxd2hOc2VGSUlJaUJjWi9GZEtBVzAyZ2hlZE94eGRoeEIwKzEx?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83C14FBE6D1E9C4AAD1811325DFF4C0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E6p295c3AJQ+8BETK3NXcLRkSWAh5bhZQIoOAN/Gevrxp6jhMMeUdekULC8RCAbu43Eeyj5E5XQyICzQerFx7QYz89iZiaDHKvY62vPYXx3Ia8bRw19R744k3zkmbtFNPxRJC0VhOxquoNSFayE9ok+qNVtS85t2rqF8XAfFnjmMgUGAdoNFkv5LSEATsMmVwScD2Q7XjjtlcjQBXUTr04kZxak0cT7BNxC6VQo5+JMsIePSMLgSvwLGtyFXB1Jy3G+LAbwKIgv28gEuTwCLbARUCFN2phrl3xDBjrwP2IFPw/zKtUuN96v8wowDG7U5CawhhIKRp6SSr253gbkxWVC8hre+VS6VPeKN50TysMvkic9lNZkIHm2wr2RgULm8pGb/oVUFR06Go1mfSHIdCxTVX877CVp0AO92A8sf8knw6tUCapkQpOQclkqJ6oND2OklbZGNkQ9kveB/xs4qJ/u7jRAbjNNbGXrY3rlPVi8hfKpSGkfIipu95JkjXw5aejPCzikjNFvHlFHQhL21fPH9B9h10ZIFFytPOhjeEzJ9gc2me2pOn1U3u2ED0XHYWd/+CDlEqXG6OtcCkDqmcskXV3njSXJ608xdDDCdsozVG7jjJCh3AV4mIGJmFAGt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f13b87-6b52-41c5-e5db-08dd7c079032
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 10:23:28.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGFtkvBYYCy+z/B92F+l1nd3hGctynrHuVkc8MwGL1eJJR/uRJrnwfEI8Mis09+I8Qab4W1yTo+SKx2JtEdNYCEN+yLYHbciJ1LqXGQ9x48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8644

T24gMTUuMDQuMjUgMTE6MzEsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBUdWUsIEFw
ciAxNSwgMjAyNSBhdCAwOToxNjo1OEFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBPbiAxNS4wNC4yNSAwOTo1MiwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+Pj4gT2ss
IEknbSBvcGVuIHRvIHRyeWluZy4gSSdtIGFkZGluZyBhIGRlcHJlY2F0aW9uIG1lc3NhZ2Ugd2hl
biBpbml0YXRpbmcNCj4+PiBhIG5ldyBoZnN7cGx1c30gY29udGV4dCBsb2dnZWQgdG8gZG1lc2cg
YW5kIHRoZW4gd2UgY2FuIHRyeSBhbmQgcmVtb3ZlDQo+Pj4gaXQgYnkgdGhlIGVuZCBvZiB0aGUg
eWVhci4NCj4+Pg0KPj4+DQo+Pg0KPj4gSnVzdCBhIHdvcmQgb2YgY2F1dGlvbiB0aG91Z2gsIChh
dCBsZWFzdCBJbnRlbCkgTWFjcyBoYXZlIHRoZWlyIEVGSSBFU1ANCj4+IHBhcnRpdGlvbiBvbiBI
RlMrIGluc3RlYWQgb2YgRkFULiBJIGRvbid0IG93biBhbiBBcHBsZSBTaWxpY29uIE1hYyBzbyBJ
DQo+PiBjYW4ndCBjaGVjayBpZiBpdCdzIHRoZXJlIGFzIHdlbGwuDQo+IA0KPiBZZWFoLCBzb21l
b25lIG1lbnRpb25lZCB0aGF0LiBXZWxsLCB0aGVuIHdlIGhvcGVmdWxseSBoYXZlIHNvbWVvbmUN
Cj4gc3RlcHBpbmcgdXAgdG8gZm9yIG1haW50YWluZXJzaGlwLg0KPiANCg0KSSBob3BlIHlvdSBh
cmVuJ3QgY29uc2lkZXJpbmcgbWUgaGVyZSA6RC4gSSdtIGxhY2tpbmcgdGhlIHRpbWUgdG8gDQp2
b2x1bnRlZXIgYXMgYSBNYWludGFpbmVyIGJ1dCBJIGNhbiBvZmZlciB0byBsb29rIGludG8gc29t
ZSBmaXhlcy4NCg==

