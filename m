Return-Path: <linux-fsdevel+bounces-49424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E6EABC0F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F271787DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE260283FE9;
	Mon, 19 May 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KsOmVkj/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XZcZLXRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665352D052
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665448; cv=fail; b=HuWr0QHlxbBWOYy5t5pbTO/wFXnBCLnBUJF4dbZKJz6CIDj/k7TjMbaBgUADvOXAbW+OgrxOHeSL71Zd3EXdpN4EquhZJTqIcSWOvBs1DvH06uQhxb6pIzVDRdDMedmcGzX538VWeSnK45dQQ47pJh4fQHhzrrV5jTx31avkf5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665448; c=relaxed/simple;
	bh=527AB0n4POHZKCnw3NMDmBvCi8Uag2C+u861bt96SoI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kmBPHOmu2JKNkMZ1su8Z1YnzhZUaR7FRxfW3cuSGySRkza3I0C3ukxEoLF4jVGRcvFC9FIiWp9x/jsyHyG0vfJv/A/nZgRPp3Gk7wAfqkJ6hq9LMIYQ+lABdS0+/LnwanJ8WgXQQxRfOlI4seKGkm9YaCmH8v7BRHn2zWgNmOoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KsOmVkj/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XZcZLXRU; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747665446; x=1779201446;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=527AB0n4POHZKCnw3NMDmBvCi8Uag2C+u861bt96SoI=;
  b=KsOmVkj/GSAUaaumnq4XeYrr8i15AHACyq3jezmqHddrFzM8wAYxmTn/
   yhZrW4OMZXXxi/qv6k8/1jY9QKYJnIYxVo/irkgrQLz81Lqel+sERz0yD
   cmpEB6Vt9rViGx/JSh3FEXfY2uw5RUJWqSIheOdSX/pjPeu3XNYgcvGOf
   KhFl4jZSJ5Vecov0LFUaaLFDaLaQl+fLxyyNSmlnJ8Ys5B6j0UXDpuSky
   1lWeAckjsVcjuw6GTxENIoLX+FAWKgU+iq6lGHMTesv2D3QBAQrw9zXgC
   V5+JMSTGwY4+G/hSgFYt4/btYBmT257zId4zSnFEHy+AhRwjH4CJ8ozsQ
   w==;
X-CSE-ConnectionGUID: lxSjI6o7TIOPgC8OyDVOIQ==
X-CSE-MsgGUID: RWqp5ioMTpOW11LWHlhvvQ==
X-IronPort-AV: E=Sophos;i="6.15,301,1739808000"; 
   d="scan'208";a="83314884"
Received: from mail-eastus2azlp17011028.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.28])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2025 22:37:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEqiyagUmZmp5ORwxLuF+8e82Px5xox9nHVoqpUvVbijqYnmZRgM/4zJ/4jv0mU6SeJ3grdaTH9Hk3vbTbJpbuXy7j09XLnPlK4rg6iUXYFkE3rqi/qWk7syINq/obKXUIaY8ukM1MJTGSX86bs2NjHxDOr47NSO5hdqC8GjSpAXFd7Sml9z72WrnU7Bn1NfXtBhEO2uzmxBUXK/1ayvRJE6MBzdJVfH8ra8h3smvQgDgFOs2cMWQWf1rkHdaHuMI9/iitiyjJVDZT40gawgriw39pr4VX4imbfH5aiMY7iFST88PFCdRdFCg/g+lS773JBlY5uYbzLKXBi5RTf4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=527AB0n4POHZKCnw3NMDmBvCi8Uag2C+u861bt96SoI=;
 b=jP9wfuNQwKG6tBwe9QqGSxwLp9D94aaUHQo7Uywo9WbUONTfRf33AnrCdokgDbrA0c9LCW9BG2Os9wQrJ9saUgQnu3K8sAgf1YxwcJJDZhUi0oL13/LFSKC0Ok7Ch3zJST35abTkRkVKHyLGzYIcSU6c8MgSEF+gVypmtb/J3EBM2l7VcGNoE8fuwfrx/lCssqjUKGkRBy/2DxRVI1Zb0pU11hAwPHwvQmpv57EzCOj27jExR1aD6rfsYl/wDMzfedxBvkQVHakR5BGSeu3ONop1ok5kvxSg8s8sOuabwc+Gr9jKvQyx5FPPV053ayWIzbD78fClXhzZTopCJuE9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=527AB0n4POHZKCnw3NMDmBvCi8Uag2C+u861bt96SoI=;
 b=XZcZLXRUuOxcfFbfjhhW46F12rVrThNHJVWZGor/BNg5qOfkQOBBDpuOE35w7qbH+tIdFOUmiVooW2ESsymurWp4/nCVXGVya3Hcn8EgaUQ1rZ3g+J6Rg6NX45hLAe8zwNBwpSXA69S0l6/ArUcgBGOiijd6IdA4jj7q0a602iA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6747.namprd04.prod.outlook.com (2603:10b6:5:243::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 19 May
 2025 14:37:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 14:37:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] block: support mtd:<name> syntax for block devices
Thread-Topic: [PATCH v3] block: support mtd:<name> syntax for block devices
Thread-Index: AQHbyL+3soLZJaKEfEGkBssMEbzd27PaBYsA
Date: Mon, 19 May 2025 14:37:18 +0000
Message-ID: <6e90a2be-a1a9-46fe-a3f3-bd702c547464@wdc.com>
References: <5a3c759c-4aa9-4101-95c2-3d9dade8cb78@wdc.com>
 <20250519131231.168976-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20250519131231.168976-1-joakim.tjernlund@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6747:EE_
x-ms-office365-filtering-correlation-id: 7c8fa834-cd44-4a68-406f-08dd96e2a840
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3VFZjVzMkw0SnkzRTY4S1E2Q3VjSlpaaE5ETzJaaWpzbVFjZVh2SWNncVov?=
 =?utf-8?B?SGxRbjh1WjlPUzkrN1RwL0FSbHpsUXdhRnRIbmZwN3F6NjRUdWdmVitheHh5?=
 =?utf-8?B?NEYvTjF2QzdIUWtZaWtwUS9La2UzMUlRdVFqaks2d0FzYjJZQ1Fra2ZwMjlj?=
 =?utf-8?B?bTFnVWNFRmNFeHRsV1lkdFArNW5GRjkwU3hNbnc0SnNFL05ra2p6S0JwUTFB?=
 =?utf-8?B?K2UrYjMxaWpiVG83TTE2dWs1MU1LZ3F4cGhydjlPTlJIb0pOZDZWZlVsZGtE?=
 =?utf-8?B?SEJqQUoxd1dzOVFkL1Jpa1djZDFtNUo1ai9KWWNYZFJmUGhhRUliaHhGUkw2?=
 =?utf-8?B?eGlidi8zWFRKRmdoaXBhcVdSUVZHQlpNT3Y1Uis4VTdURXFHQ1BsdVhlaFNp?=
 =?utf-8?B?VVoyYmhrSlY2NllvdFN0MXlrQVA3WkVrK0RGaFp6V0EySVh1U09qUksyNHhF?=
 =?utf-8?B?eThUZjdPYkpUZ0RPMGhVVnZBcmtaVXR6L2swOWJyaUVnT3VaUDFkd0NPenhN?=
 =?utf-8?B?bzNvbUJ4cmRtblJUUU1JSXU3QUdjQ092c0lHakwwMkpXSWNveWd5S0V3OHJv?=
 =?utf-8?B?bjVIRitITXQvLzNBMFdTMitrU3JkSU5VWE5vVno5YktDU09wbytBSUZRVjFp?=
 =?utf-8?B?dzkrSnBJZUJ0RXYwQmFGOE8yZUhEbTFnVjFZNyt4dXhnRlNPVWlOenREM0Zr?=
 =?utf-8?B?UFo5czd2aGxGQzRDbGNFM3ZtTE9yL2g3M2UzTGhKZGw4MDdKVFdWTGZHTTg0?=
 =?utf-8?B?aWovQnJBcytFY2FzY25OMnpJbmdyalBHZnhCSnorWWlLVU8xOGdOdlQvbkNW?=
 =?utf-8?B?aTRwVVE4a3dKUVorOGdBcUVOMHFLZy9QSnpzd2dvM3BrWWhnYWxUbEdqbk1s?=
 =?utf-8?B?MlUwdm43dVU4dWhuTFZsTjY4L1UzWWsrcXZvTmtNUXlMRmZhRllnUXpHNVRY?=
 =?utf-8?B?MWN2d1g1OE8yTUJkRkV5bFBENXFsbVVzOHlnQWZvZ3lzVHRlZlZRVUNpUEVF?=
 =?utf-8?B?ZXpCeWpWKzNHbVJ4R2lQbk1pMWJMT2hqVWJRdlFmejh2eXRVL3c4RTRTbDN1?=
 =?utf-8?B?SjZaZnNZZ2ZHNVhPUVFxNDNZajllNWRRSDJhbkNDS09Fbi85bE9IWC9sL1RP?=
 =?utf-8?B?ZjFWT2lJRTV1R29VMHVsZU5EalBuc3RYbXM0MXEzeTBBZHltbXRaTkl2cTN5?=
 =?utf-8?B?RVJwQWc0QnNOdEV4QWVWb0VyN0MzUG40MnlkREQxS1BGR2RGLzAvUFBxU3VP?=
 =?utf-8?B?ZzJDNXdnRjF6cFBTa0x3WTN0OVJRNm1XQ01xT3B5NUpVbXVubWpRNzBXR01y?=
 =?utf-8?B?YkJqOGU3dnBkSjY5WkJzUnk1bHZ2cUhjTVlseUV3YzNyWksrMzVKdUpPYjZG?=
 =?utf-8?B?c0V3Z0NxL3M2SE9BczhONWYwZGMzRit6Qkx5L3UyektmVy9lNXQ2azdnczJt?=
 =?utf-8?B?Uyt2UVNCMUVtdE1pN0VyUEhGdHFnZ2NLWGRJY05hK0Q5M0dUUVp0QThxeTgr?=
 =?utf-8?B?bys4WGlueFc5Ym1KTHZpM0FYNGN1RnBBekIraW5CUC9kZWlQdTlJQXNwRVc3?=
 =?utf-8?B?blY0c2RuRVg4SUJSeVdncjgyK2I3RlBTK3IvRWNvem1iY3RCRU9Fb1NIR1NE?=
 =?utf-8?B?N3JhR3F5MzNvRzJpajVsa0JZdkk4Wmo3a1M5d1lDcUFxZVMzeUQzZnlubXV4?=
 =?utf-8?B?ODFqUldZdnRNQzExK3pva2xOdTRiaGZDcnFPVVJ2VU8veEFoMmhOa1BRYzVy?=
 =?utf-8?B?NXRZU2paNjdvL1FsSUVvZnpTMll0b0xKWEVlOGRrY2psdkJzU3F0NlF2RVZ1?=
 =?utf-8?B?T09acnl0czhWZkxGQ1AxaEd3TDk1a1NIeE1aazQ4aWxXUjJOTW1lYnhKUHkz?=
 =?utf-8?B?NHdkaEdPdy8wbG1PUDhYQkY0TU9oczNmTXM1Ky9UU1ZYV3dDSW5WUHhTblEz?=
 =?utf-8?B?RFROR0JOT3R1Sjk3ejdRT0dxS21VVEp6QXBzTzNqV2hxUnlBSG1pTXBMZitx?=
 =?utf-8?B?SEJTZVc0OVd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFd0YXlPcFFzOWU5dCswdzQycU1ydGJ0bnBXbkFqNkg4cERZZURaaXNiOG5O?=
 =?utf-8?B?L1RSVVVDcTloZ0U0bEM0aXN0b0d3L2QyMHBUbnBwUnVzMUdSWTVnejdhdXZq?=
 =?utf-8?B?NUNiYWY0MG1hdjd0R3JLODBPWUMrZTBQcFNXdEFoNVBRZXc2cEN0UlZ6ZXJQ?=
 =?utf-8?B?L3pORkVpTWxrQ2VRNGllK2pmak1jNmVjN0Q3b29MT3pJNkJqa3pobUQwK2Na?=
 =?utf-8?B?MUg5Ukk5dHA1NmlLRHJINm83VmprWmFhMW0zb1o2ekVJekk0VmNBeVRzQzBy?=
 =?utf-8?B?SURpMEs2RXNCR1NYMTdrOEZIL3lFN2VJUUZyNVI1SFlaQ09hYjNUYitINVZ6?=
 =?utf-8?B?YUdwQ2RLZjBrNWE4N3N0MC80NWZnMFkxcDVwaUtsRSsrUlRweGFVb0x6RXJp?=
 =?utf-8?B?ZFJtUzAvSG1weXBTa3hSaTM2dTBOc3Vlamo1Q2czb0xQMzFMTCtsTHhYZHlI?=
 =?utf-8?B?dHpEdzdXWlBFYzFQRDNWVUhyTGlWVzJBTEM1WmpmNElUTEpybi9aY2tlVjNy?=
 =?utf-8?B?WE9DYjVwRndqL2NhVDlQYU1TSnVJYncvdjFYWmJaNldMYThaemZSWE5DaDdk?=
 =?utf-8?B?OTMycUdFdEpOZlFpNS90VXcrUTlTalEwaHBqMSt3dU9NeE5EVXJpWGVTSTRR?=
 =?utf-8?B?WHpxOXd1bG1Xa1JBd0VVNVNjTlhCdFhOQ1RiYjJlOWRUZy8xTkpBcDRMSXR3?=
 =?utf-8?B?VDcwUUNKSzliUXZpcGJEa3JuUVd3MUlaRDZJMDEvZVBEbzJVS25sbk16dTNt?=
 =?utf-8?B?SzhOVStVK2dGYkVwZkpQeXdlUldHaVRtMmkvRDdVSEdUWVZsNDZiU01JVWJI?=
 =?utf-8?B?RjBkV3pvNUw1Rlo5cUsxZDQ4OHhsbzVWODlpaERVbVNpT2JsdmhVbHlEQ29a?=
 =?utf-8?B?VlYzc24wTmVST3FRN2lCcllocTRHR2c4d2RtQ0lReDY3UENkMjZKMjB3angy?=
 =?utf-8?B?UDlyVTl4YkM3aXdxT0tKaFZERy83YUJzUEdJYmd3Q3Z3bGovVFlpZXhtcXo2?=
 =?utf-8?B?RFFrZ0hFUUtEaHpYUS9PRlZFWlNwZlh2amZYblkrMVpTQWdoODZJeGpPY0dQ?=
 =?utf-8?B?d0QzNkpGMk1RV3U3NXJjZ2c5WTRWVldCQW41Rnpnc1Z2L3hlcHRLRXM1M1Nn?=
 =?utf-8?B?anVjWUlqa2lqWFp3VE5DaXdJTFUvR1B3Q29pUitQa2NxNzNwYVh6akhJWW9W?=
 =?utf-8?B?TjRhUndkdnk1eWx3b1cxQnBpcS9lRmYwSjdZYm54YnUvSW0rekg5bkE5dVlB?=
 =?utf-8?B?WnYwNHJtTm01bTgyTGpGTW1Qb1k4ZHZEb05jTFpCSTZXNUtvSFI0NW5hYmt4?=
 =?utf-8?B?OC9qWnQ1dy8zSHF1WkVNQzljTDlrTnRXNGNvczFLQnJoYlk0eHZxNDREaFc5?=
 =?utf-8?B?NWx2Ykc3aHNGcEp2dCswMWhZTm5PanpXSHVyNUpxRHpIY0NUUUFGcjBUTXU2?=
 =?utf-8?B?T0JWdzVTQVBWTTVlcEVUb0E2dFRzSkdDeDRjNEg2RVZmbWpzcFhXNlBxbFUz?=
 =?utf-8?B?RTRnaGdVekxDaTdxeWhNRklETlByOU1FM2FFbUlJOWQwcHVhSHV3anN5V0d3?=
 =?utf-8?B?K2tvVFpENWVwK1BseTFiZkdMc2VUTXh1MjE5ZXhwWThUM1R2V1J5R3RrWG9D?=
 =?utf-8?B?WHB5aU9pczJTVjEzZEh3eVVWNG5GTmRRVFlBcnRTbDdmTkNlaExpL1pTWDl0?=
 =?utf-8?B?WUdLMWpQOWZiUjJKdmkzOE5PdEhLQnZSajRNbWNPWWZCTjdDOTQzSG1EOGl5?=
 =?utf-8?B?dHN2UzM4RFhNMGx5ekNyN2FTSDhZV3YwdFZSOFBTVDloQ1BwenlWK3pKYThD?=
 =?utf-8?B?eW02RDJPZEgzdUxZdjdMUnIzSEpkMEpMdjNHNE5JVVJCd1R4OXFOa0Y4NTdD?=
 =?utf-8?B?Tm82azV3Y0lVRzk4Zm5Zam5OWmZCMGlnczBaS0NLREdzMCtKYXdWRXRFN1dU?=
 =?utf-8?B?clRkRmhoalY3TUdLVkZDLzlDL3k2RGtITko3VjJGS09wMDJCNXBKN2x2Q0RO?=
 =?utf-8?B?M0pGOFNhdDk3blE2b2V5cE5ueWwvS3ZpdXIxdU5xaDJYUkJnb1FJQTJQMVFn?=
 =?utf-8?B?VnlPSDZpM01yVk5FUHVuc0RCUzI1SlZTQUd5eHp1amF2Z1lKK1FIaC9NSWts?=
 =?utf-8?B?MUtYWDRQeTVqRUR3VmpZWHluaks3UUFjNmdkQmhVSGR1Q3pWeFlLZFdIZUJF?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C1C46CAFBBF0D4991364FCC54D89F53@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gNHMC/mebXodOG2oBDQtwOVY2umVZhx29m0Kt70Q51ImozeGnQLnypwBjBQ3tMl33ikqW4M9Fq8x7gpS+cfaH6O+aTNlwdA6y07W/pxvvV4foH8udj8HT5h5oQ/FNJf4/CWqKCKfvS77x3FqscGQTY0+27W8dUg7bQJoOlV3U59sWAUdCBKuoxKoN76H6svpNA+gYJeJyh/W1HFdfqUN9HjYXOfmolmsCwcyYk3Ep7zPxwhcg5XWCWJ9hAA6VgOwtEcBzcDRUIhMpAAJsGuR1dmQfyBylQSpWMiP1XECJE0NXLTK+NCUWjZ5/4J6gOBQTM7hmeG5ssPojAoDRhQzSuqA1ZSpvkfKDMx/+dfR0uuSI+8I8okEzlRhSzTM5sUFP21+gJLAjExKgrYfO5knyx2lGm6wOrtbFJOod/+/bMIZaKKGFq3kDrcRJRpzaVAfERAl9R12t6hg8APP9oArSV6E1E0u7sekA3bPII+mD1xITZpM87NMDlcWBfous8WNOA/BjIlbndO9ySFWGqEbXRwUBHFp9SgBXJZwOcjyYMWD1sw6Gjhm8w7aU2frdwNI0lK8h+zF04l0qMYIXdWWMeVb0rQrTRxqjC1dougyKXrs++tZWcchF6VL6JzcNuo7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8fa834-cd44-4a68-406f-08dd96e2a840
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 14:37:18.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgpHAtv9PaPHRvuVcJ10+fnpPFRxjLZWCtRammIBh3UBJfdkm34jbmnTdfBjxeaKKfRZPVuwBkumtSE1k5RfSjUBgijSLsEIqec3a+2XbSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6747

T24gMTkuMDUuMjUgMTU6MTIsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+IFRoaXMgZW5hYmxl
cyBtb3VudGluZywgbGlrZSBKRkZTMiwgTVREIGRldmljZXMgYnkgImxhYmVsIjoNCj4gICAgIG1v
dW50IC10IHNxdWFzaGZzIG10ZDphcHBmcyAvdG1wDQo+IHdoZXJlIG10ZDphcHBmcyBjb21lcyBm
cm9tOg0KPiAgICMgPiAgY2F0IC9wcm9jL210ZA0KPiBkZXY6ICAgIHNpemUgICBlcmFzZXNpemUg
IG5hbWUNCj4gLi4uDQo+IG10ZDIyOiAwMDc1MDAwMCAwMDAxMDAwMCAiYXBwZnMiDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2FraW0gVGplcm5sdW5kIDxqb2FraW0udGplcm5sdW5kQGluZmluZXJh
LmNvbT4NCj4gLS0tDQo+ICAgZnMvc3VwZXIuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9mcy9zdXBlci5jIGIvZnMvc3VwZXIuYw0KPiBpbmRleCA5N2ExN2Y5ZDkwMjMuLjhjM2Fh
MmYwNWI0MiAxMDA2NDQNCj4gLS0tIGEvZnMvc3VwZXIuYw0KPiArKysgYi9mcy9zdXBlci5jDQo+
IEBAIC0zNyw2ICszNyw3IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3VzZXJfbmFtZXNwYWNlLmg+
DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2ZzX2NvbnRleHQuaD4NCj4gICAjaW5jbHVkZSA8dWFwaS9s
aW51eC9tb3VudC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L210ZC9tdGQuaD4NCj4gICAjaW5jbHVk
ZSAiaW50ZXJuYWwuaCINCj4gICANCj4gICBzdGF0aWMgaW50IHRoYXdfc3VwZXJfbG9ja2VkKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsIGVudW0gZnJlZXplX2hvbGRlciB3aG8pOw0KPiBAQCAtMTU5
NSw2ICsxNTk2LDMwIEBAIGludCBzZXR1cF9iZGV2X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIGludCBzYl9mbGFncywNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwoc2V0dXBfYmRl
dl9zdXBlcik7DQo+ICAgDQo+ICt2b2lkIHRyYW5zbGF0ZV9tdGRfbmFtZSh2b2lkKQ0KDQpIb3cg
Y2FuIHRoYXQgd29yayBkb2Vzbid0IGl0IG5lZWQgdGhlIGZzX2NvbnRleHQ/DQoNCj4gK3sNCj4g
KyNpZmRlZiBDT05GSUdfTVREX0JMT0NLDQo+ICsJaWYgKCFzdHJuY21wKGZjLT5zb3VyY2UsICJt
dGQ6IiwgNCkpIHsNCj4gKwkJc3RydWN0IG10ZF9pbmZvICptdGQ7DQo+ICsJCWNoYXIgKmJsa19z
b3VyY2U7DQo+ICsNCj4gKwkJLyogbW91bnQgYnkgTVREIGRldmljZSBuYW1lICovDQo+ICsJCXBy
X2RlYnVnKCJCbG9jayBTQjogbmFtZSBcIiVzXCJcbiIsIGZjLT5zb3VyY2UpOw0KPiArDQo+ICsJ
CW10ZCA9IGdldF9tdGRfZGV2aWNlX25tKGZjLT5zb3VyY2UgKyA0KTsNCj4gKwkJaWYgKElTX0VS
UihtdGQpKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCWJsa19zb3VyY2UgPSBrbWFsbG9j
KDIwLCBHRlBfS0VSTkVMKTsNCj4gKwkJaWYgKCFibGtfc291cmNlKQ0KPiArCQkJcmV0dXJuIC1F
Tk9NRU07DQo+ICsJCXNwcmludGYoYmxrX3NvdXJjZSwgIi9kZXYvbXRkYmxvY2slZCIsIG10ZC0+
aW5kZXgpOw0KPiArCQlrZnJlZShmYy0+c291cmNlKTsNCj4gKwkJZmMtPnNvdXJjZSA9IGJsa19z
b3VyY2U7DQo+ICsJCXByX2RlYnVnKCJNVEQgZGV2aWNlOiVzIGZvdW5kXG4iLCBmYy0+c291cmNl
KTsNCj4gKwl9DQo+ICsjZW5kaWYNCj4gK30NCj4gKw0KPiAgIC8qKg0KPiAgICAqIGdldF90cmVl
X2JkZXZfZmxhZ3MgLSBHZXQgYSBzdXBlcmJsb2NrIGJhc2VkIG9uIGEgc2luZ2xlIGJsb2NrIGRl
dmljZQ0KPiAgICAqIEBmYzogVGhlIGZpbGVzeXN0ZW0gY29udGV4dCBob2xkaW5nIHRoZSBwYXJh
bWV0ZXJzDQo+IEBAIC0xNjEyLDYgKzE2MzcsNyBAQCBpbnQgZ2V0X3RyZWVfYmRldl9mbGFncyhz
dHJ1Y3QgZnNfY29udGV4dCAqZmMsDQo+ICAgCWlmICghZmMtPnNvdXJjZSkNCj4gICAJCXJldHVy
biBpbnZhbGYoZmMsICJObyBzb3VyY2Ugc3BlY2lmaWVkIik7DQo+ICAgDQo+ICsJdHJhbnNsYXRl
X210ZF9uYW1lKCk7DQo+ICAgCWVycm9yID0gbG9va3VwX2JkZXYoZmMtPnNvdXJjZSwgJmRldik7
DQo+ICAgCWlmIChlcnJvcikgew0KPiAgIAkJaWYgKCEoZmxhZ3MgJiBHRVRfVFJFRV9CREVWX1FV
SUVUX0xPT0tVUCkpDQoNCg==

