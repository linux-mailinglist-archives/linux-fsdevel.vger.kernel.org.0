Return-Path: <linux-fsdevel+bounces-47589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C983BAA09E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C789E16589D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C64A2D026B;
	Tue, 29 Apr 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qICbRn3d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SH1+n9Az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2B2C1E39;
	Tue, 29 Apr 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926475; cv=fail; b=acCD6cWsbtKVpuU5tYV8sg6ytVDzIRHumUUxpBgRCbdpGZfor2/RWkyTMJZ2AyBIbPHKvPwYy3aJGL6Iih+V6xuiGVgtgeOfnDWT4+ZMmVhcePF/zj1ozfJpM3GpJ9pQNRMnVg/k3IKI1gQE99xD98Dn+mntqx9XrL0jF5WP8ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926475; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oeIKVich405vVGvyytZ/P9Fuuub2oajWzCws1WToekkxt1S5asMy3xmH7iMgeq0wYuiDyWkX6zIc5/Q1LIcx8Q9z7KcJNyFWd+5FrfAC2V18tlxO85RyLAYkncU5gOY/yIu4VJeg/m0+h4hVLCP6rAy9BObty8Yxg/mUo1x9lRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qICbRn3d; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SH1+n9Az; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926474; x=1777462474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qICbRn3dglujd932LSzpQ533MPK3MwhI518D7f36DkOZcfHRcAObREKF
   u0IAnRA8LrJg7cEJB50I65kY57hhwm9cCpH9LlIVbg3rv1rc0kKyaBy1t
   nqOdMCuJypq/ZVxPEuoX9KYAfa5ITWuu0wStx5Z7pV0xutHLy9af0i8/s
   +jDKFUBONOaCrH9PULN5KssG3HoqKGvJA9pBVYJSgy3cWoChvYfARj4Fx
   hqefl/Rx7rPwEJ71qO0/SoNCL+adM+30YIk6kyeMkqVphTld3DHStoXWP
   yI2604rum2YuFB/Sn936Z35iPLVxLnX6oX9oLzykDS6mrtjI61ncl17Wj
   g==;
X-CSE-ConnectionGUID: uXusbg0lSpadEHOkboeQ1Q==
X-CSE-MsgGUID: L7El595QRM6d3DkOlqo3vA==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="82771668"
Received: from mail-westusazlp17013075.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.75])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:34:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNFTxzuAvX+FFRb8YoiU1I99nxNOlxs1HP8j/HA3V+xMzt1pRRfxBDZ+E2rBsigoqe39Sp+Cto4Mlc3KMQu51hNiypjJlV10q3pCd3YcVicUTDh8WhQaFL5YVDtFP28AwHjP1b6vg9cHvlYzibV80E8i5hGXNUtQlXkI4rKJFO0DBKRDStrdl7KsNUOdfaQ/mSvv/8CS7wXzc9Ch0LG+LdChe9yxO+Eku6BvB/GAKbMmwu3VdcF+U+KJvcSobpoMJecSHq2sufHQBqRkJyPFYvR0ynf0cXT5SVeYHU5Jt/7sEBD4knbSC2CcywovsypEI+dXxe+P6Ugv5HCABoMiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gS4rJNC7xCXqlvWBeHNYWkesgnFI/tbduZkDjw9sjHKCW65HCs1JG2SqlPa1EoWBcS+T3TRbAI2yz9H/LSXwfMR1qDFfruZ/tZBwmY38NhMydvKqlV29vy32tIgkPG1vUGU/HdaUxgWdvh+ilyjQ++2S/XhZ/PpQYz2VGQbdaurmckdZoKQDUGquzaqUfv35pt++AAml7L9NuuJ5AfU9593gqKv2R3eyM6JWbdfH2f9d0aD1Y+ueMtE/E2EZGFAVKQhNUeee2SbNDVsKvOyL780ME2QEJgPNDIMS8yceUqOlVQVIBiSfBqS0Yerq7kuxJsmEMaKlqsrNqbINkj1NUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SH1+n9AzWU7RZAxOP8wvP0i65OPPXixgZyEFCTk+sUB8e99kfh2kIgHrDPUhWR73cYlwL+hAvTH8dUgE5jVDnqMhCfrUy4Qj8kN3ZcRbV4YgUfiGBmagqd52gYuJ1V18OAQZKjsAQ9XdUajLuz0FsN5cbw2S3qOw5cQ+68yj1lc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9606.namprd04.prod.outlook.com (2603:10b6:8:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:34:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:34:30 +0000
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
Subject: Re: [PATCH 10/17] rnbd-srv: use bio_add_virt_nofail
Thread-Topic: [PATCH 10/17] rnbd-srv: use bio_add_virt_nofail
Thread-Index: AQHbs5M6+SVbdvd1Ak6Y9m2YjYprpLO6ji+A
Date: Tue, 29 Apr 2025 11:34:29 +0000
Message-ID: <65b3e142-6539-4104-9dbd-4d832abf2565@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-11-hch@lst.de>
In-Reply-To: <20250422142628.1553523-11-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9606:EE_
x-ms-office365-filtering-correlation-id: 9e82756a-2e96-4672-5bf8-08dd8711ce40
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V3Q2ak1uaDh1aFRvMC9VdndFRHRlaWdQWVFsTkJZWFN6bDZnMjEvaWoyeWpz?=
 =?utf-8?B?NkY0UitiWUVpZnhLSm9leGR2eG9hMFBVb3pRZkxFSHRIWU04cnpwejhPR3dw?=
 =?utf-8?B?SFVrbFNhOTVBalM3R0N0WkQyOWRKeDAxYkFyVk91eGpBNHhFSk9kVmltbmlG?=
 =?utf-8?B?WlJXWS9JckhqRXlrbUdaNFBIYXI3ck8rUE9WOXovdXVnTVhxbGVNaFRkRVpE?=
 =?utf-8?B?NXBQSlFwckNIK0NHUFEyaTlGT0tlbEdiaEZqaWNyRHVLRXRJOEg3UnErRldE?=
 =?utf-8?B?dEduaFJTeTFSb0ZBSWordDZKYVdGcTBjemE2cEpES0FCaDU5Zk1mdEdMYTN2?=
 =?utf-8?B?dDlkM3RaekVVSXR4RVhWN3pUNWdYOG1OQjMzQU5tU2Q4Y0tma2dNb2dNTjFM?=
 =?utf-8?B?M3U5WjQxNDhKeWpObm5DM25obFFoaC9lTi9DWXpaODlzdnBoYkdXNFRkZFR1?=
 =?utf-8?B?UTUybnhOMCtJeXpuRXFBbWtXZGdPaUowTWlqRFcxMDVlaVV2M3dldVpaVHA3?=
 =?utf-8?B?MUY0LzRGUXNxc1FhSFdsbThJZStjQmNQWlR2Q1BscFVEdlVaaVdFREJyMnNy?=
 =?utf-8?B?Q3JoYmZvYTNMYzF2SmNKd25CaTkxM2R2RTF0U0NmS3h4aUJNUEZnNzIrcjdE?=
 =?utf-8?B?aHpHRElvZDFhakhIWXNWY21xYjJSN2JZLzNEQlhhMWFpMHZ6Y0hRMWU5WW9q?=
 =?utf-8?B?WUh3TmJuMlp2eUVuZVBMSmZEUXBsUXVUTHZUNXRoeFhJaGtZeWM4bWRBV29K?=
 =?utf-8?B?Y1A0b2VBeHBBUFhSSmM5RlhwdDVvVjU5bEZQRGJFWGpPZVAyM2Y1dnhiZDN1?=
 =?utf-8?B?T0YyQnkrMlRsRHI0RURDQjR4bFpmMjdMMHRJZTN6K0doekdzcHJQdmJyWUha?=
 =?utf-8?B?aFhYOGM3LytMK0M2b0lXa3JxYzU3NzVELzNyODlUUHhaWStreGk2QlRIZ2lt?=
 =?utf-8?B?SWVEMktYYnBtOFlrNGFhb1V1N1gyQWRQVmlramtBWXhheTFDaVBEUkZXV0pi?=
 =?utf-8?B?VlJpcFQ5dVNqMG9xVTBhUmhRWlpDM2FyWFk4M3p0cHlpNVFNQTVMNy9rbVNa?=
 =?utf-8?B?OGhtSDhZKzhyU2tOeGwrTFA2aTRmbytldUtrSm1BWTFVWlpJQVRTbGRPTjF6?=
 =?utf-8?B?VmxKZjBRc2UvaWtKUkJEVEt0YmpoZ2t4OXkxOXFXNkloRVpIM3lMUlVEZkNp?=
 =?utf-8?B?OWgvclo1bWVuZW5qSWdmS0lFWHd4bFNTSHdhUnRqTU9pMjFJWUdFVVFPTlZ6?=
 =?utf-8?B?RmdJc2N2bWtMME1CellibXFKTlYxRC9lRDlGS1FoVmgrc2tGSUhHdkF2cEtG?=
 =?utf-8?B?SndOSjdwSml4bjVWaXgxeVlRWFpITTF1TTdQMUFRYnhJTlA2Zy9qSVdzbGhz?=
 =?utf-8?B?TExQOGdOQmpjSjRhZ3ozM1V5TVlUWTdzQ3BxRmJnbTZacmM2Y1pHaWFRUy9t?=
 =?utf-8?B?NlJjOUNvSkxlSnZ2K1N5dUxqSlFhQTJHdDl5dkFIMWdabFJaQ3pNdy8rV2gw?=
 =?utf-8?B?WVNCanBMS2JlVk12VzNpQzhhYzdMcWpuN013OFR5TlE0N2lVZ09Eb1k1eUE3?=
 =?utf-8?B?OFNNQ3RjVlpwNW04aDNaK0FxN21KUkZoNURRTkJTMEgwWFNFcFArZCs4MXhD?=
 =?utf-8?B?RjBsd2NqQ1Q5TmhKVFpKc1gzVkJtQnhvZklVVlNaTzQxcFBSWm5KRzcrSUR5?=
 =?utf-8?B?eGtXNFVsR2dOUlBhQW0waFZlTjkyMU9YRU5ZbnluT2N1TnlQMG5oTy91SVpr?=
 =?utf-8?B?ZlJRbjdZS1JtcGlPdEdseDkzaEZDNEJCZzF3WGF0MVMrdWIxaWdLQ0YxbG1o?=
 =?utf-8?B?ZXh0cjVTdURxU0dZRGw0Nm9hUTRpdVc0cjVYekpLUXc5NTRRQXE0aE1nZjZS?=
 =?utf-8?B?VEF6Z0NKSlgwZThrVGdNaVZEWDZJaDFCbTYxSm5MWTdNczJxanVSQkphclBk?=
 =?utf-8?B?U1YvNUcvYllxSk9SN2hXUlFjbnBhY2Q2cUMwamtwRjNPNC9uZFRyYjFselN1?=
 =?utf-8?B?UC9QcTk3VEZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzJBemt6ZFF5TXAySFpIWS9CUU5RS21FcUU2NmxRa2pyVjI0dzNqeUxsYzFB?=
 =?utf-8?B?eDdQaDEvdmJZc3hDUDlyYnhyZzlkL1hWMkFYRTI5V3VTcmVRRWxqeUNyemNB?=
 =?utf-8?B?Vlphb0lqYW1JNFlaZXRHL0M4ekYwbVk5SjVNYnN5Rm5TNUdxQUwzYUNDNUlC?=
 =?utf-8?B?RjhlYzhGVG0wVFM0MEdsanpTOTF1R3Q4a0I0dkU4TGN4YzJPTnp5SjdjdUpF?=
 =?utf-8?B?WDE0YXRaL3c3aEVEWE13Tmloay83MnNuYytkTHp1aFd1d25SUEUvbFZMYk5O?=
 =?utf-8?B?N04wQktybHUvTERueTZGK1RSQjA1ek80bUVMM2MwdjJqbDV5Tkg0K2kyd2pQ?=
 =?utf-8?B?V01ZN3FkZWpSeEtIbWtOb0wyc2dFcXp6cFErUkZCcWJrRW1jYWdQWGFzays5?=
 =?utf-8?B?dHhEblREOVVVYVRrQkoyYzkvYjBSRzdjTXcxTUZtWmUvNDJFQ0NwUERwTVp5?=
 =?utf-8?B?TllZWm9ONVlHRyt0SUdnQzV4TE8yRHZ6eTJmM1NJbEVoMDk2Slh1aklJTWds?=
 =?utf-8?B?cnllRzFBTGVyY3RqL005VjltUWlPc1lGclg3QWxSL08rQnpPbldETWVFelpl?=
 =?utf-8?B?amd1T3lJMFByUzdsR0dMUzZTYWR3bHJ1c0FiSGFjUUNwVGVndHBHZlRsUzZ0?=
 =?utf-8?B?Snk1bitzYVl4NytoTDZVL0tCWkt6SEtmWE9SNVNndk5kZ1dVankreDFDSkVr?=
 =?utf-8?B?SCtvRjU1bFkwTHJUZmhyUkJHVDZMbXdmR3BRVTF1blNpOFpiYVhCdFAxaXdo?=
 =?utf-8?B?bU51TkRsNVhLREtvYktwTFNLdlY1SmpvZlg3OG1ibkQvSEl5NU52bUEwaHF0?=
 =?utf-8?B?WEpWcHpKbnpTQlJyUUxHS2JSMFBsb3llMjJvVWt2RVlXdzg3RUFMZHh2SGhI?=
 =?utf-8?B?Q1ZLbkI5QkIwNGVJSFo5dStTcm1Hb0N5ak1uK1I5NC9zSlNsT2VxNlNxOE1q?=
 =?utf-8?B?MHpuNWJ5Y0UwVFA2U1V0U0RGMWpicUJsRWhqeWpwS3dTb0dXMXBpMlgrVXZo?=
 =?utf-8?B?cU1YMXBHK1FpUHRKVU5ZTmVxMlpkbG56dnNTTDZNbGJyampjZURLMEppaWtJ?=
 =?utf-8?B?Z1pCWHlVV0pRbUovaTk1RS9JQllySWNscEx6RDR3c1pBWUYrUnFGTGp1UEpE?=
 =?utf-8?B?QlVtUkVyQXlZNFlWNnQ0Rmd2Ym9tSkRUUTdJaGFDdFV2N1dhOUpjaWNtZkdH?=
 =?utf-8?B?U216L0hUUE1xWmhyMEFFd0dKbENYRXdzQzVka3FtQXp3VjhMRU5SNHZkbzE0?=
 =?utf-8?B?L005enhLSzNKTUlSNWRrbXVVUDhKempvQXdhMWJRZWpoWUdHL2RRaFppQ2VL?=
 =?utf-8?B?dE1XQU5lWWk0bW53NWp5RFNMeldsV3k3S2NlM1VnUlhhZDdKR3FOOHJPMHlV?=
 =?utf-8?B?cDBLS2hyS00zVkNSRENFSzBBdEdwVlpNeTgvMGpqM2IzdVJCaUgwL1Y4N0pR?=
 =?utf-8?B?WnVNYmp2bXJheUsxYmxDblFHS2VvYjdlRHdUeW96dUIvZEpvWFRRYWs5NTk4?=
 =?utf-8?B?eUdrSVd3dXN2dnJHQ3I1RHpSWkM1SUEwL2VhdkY5YjRzT3U4Mk9Gbi9Zc3E2?=
 =?utf-8?B?M2ZsTm9KTHNNWjJUM2gwcjhKYjBld3k5SHVPMnZvN1lzbHF6VmMwZTlLMHF2?=
 =?utf-8?B?NjBlM1I2Q0NIQS9NQ2RzS1JsK3Eray9KVmxTL3E0dFd4WSt2QUF4N1l1Qmpu?=
 =?utf-8?B?Y3FmdThnQzAwamhHSmdDeE5kNHhaYzZ1VDl6dkJPTHBHNEVWQ25qVEZ0Uzhy?=
 =?utf-8?B?VXpXWkFZemVWdjBFcElqZEdFbjZhUUlLTk1OYXU5a0NnQVJ4SStBTW5QdDdW?=
 =?utf-8?B?SXRkNGcwMERNWklINllXdlJqS2ZhTHg4emZPUFpnSWY1KzUwWExLWWlwMlln?=
 =?utf-8?B?Nm5zU0gyUFg5ekhQUDFMa2VVdmVEektHekFXTDh2Z2dIcitpZHBVczJRM1h1?=
 =?utf-8?B?U2FqeTNKTTQyenZlNDY4V1FObzAxWlQrYWZreEhZQ3NWdFlKbnlNZnpxZFoz?=
 =?utf-8?B?dDgzT3R6YlQ4QlBWelZsWDJJSmNlMDZDblE3cFRMVTY3a0htZUt4RXNVeEV0?=
 =?utf-8?B?OC9SOW9SVTFlMG9oOHFIWkVuSURUM1lCclRqMjI1RUpuN2ZCVkw1blJtUmgw?=
 =?utf-8?B?L3hHRDFZeDF3MjI2L25nZjJIYVgraE1qYlY1Um8wMzRzRmZLSUhLbDdhWVFH?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <814E3BA03B09DC47AC75AF926B3BE21F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rLG5k/OuVybNoPTrLfOP34hctkhQ/D/L371ywhywb/+IBaSpQYd41hUUMXtMQDQjZKH9LvY+jPNDBR7S+0JvQa4jxI0kcraC4bCE7+pT/2Q62EAuI/NrRLtMS7w2b9K6pUIjhLuu5srPY2T5rhNIGUPW3XGWOYhBkGFFuEuJJbdrsLlFOYD7Bj9oTt7QXKp8QX8DUXT42ZFcxmfDCKOyjBw7FEBvs/+qQG76o6PTV5kyka7qP0BpMj7ZlxpymOoxJgpFvXNS2Nao+IYa7v3WZrn63YKd1EYmSFxrMTLK3LVPhEi0Z1aMVBYRwy7cAelouMzj7NaZB8kMuzzGh55uyM06+jsbLFdmnFkx2XrbLyXLaohNrNjt/XRpuXzPT1lkenXpqHvd+Aa3mW61OZHKbu53LGeRrRfqyauHLjV051CbkWCAVM2YuYRDAK0OiOn8hyVSLrWLcbdEZsIECqDgaRT7fQWM2Wn1CoZ7/ym5IUy+UQk4g7lCudc9mhMpjNwqgtaS9zidoBICgtl69z8AQabumkucT67OFNn8MJMOepNEPp4/TRhZHAnP79B8h88ydlCs6gQeIIHkIbXysHFtOH/W6f39aElyZVNS+DWiakq5QHymoMdg1dB+gsW8fda5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e82756a-2e96-4672-5bf8-08dd8711ce40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:34:29.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPQDZDIL8rDOzae7y9j5NhAC3/0jxVAzPqoRw5ita9Q/PeHvQPsDRAgMsAsuZ/OImv8sm3WZBbz3wWPXSi3ZaTjgF2HXDnDKQEMykDfjh5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9606

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

