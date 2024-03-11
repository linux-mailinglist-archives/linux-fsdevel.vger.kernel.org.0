Return-Path: <linux-fsdevel+bounces-14110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53542877B8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 09:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089262822F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23B211711;
	Mon, 11 Mar 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nl2U+CFZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e7545sbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D2C12B8D;
	Mon, 11 Mar 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710144765; cv=fail; b=jw/eS/UFv1tluY/7dY/OyzIgSfZ5bdYgz7XZXJ5mI1SQTunio/WRlYjNvnky2ATlwUeXVRjCeCz65hPSvnZxypfw9dPKK6nMieSflYWrdxUou08G5mNu8P7WGW+ctzmgI22zIw2sF+L4qgk09euNNu6M8Adi+F1gQl8fEWU8aow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710144765; c=relaxed/simple;
	bh=Pa4mWPM5xGeEb+426mKJO+Tw23sS2KqlELMjyIdxB9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWstkUCJMxf0WW0NAmKXf7MBrCxiVAcKsstMTEwqnav36UyuWmcRLussycPGgdu0/aJc6q51pZKB7iQbBNPKlxe/hBn58mrvxS+ZRQg6ZhqncHb5sOVIt6akD2W1rm7UbfzF7nydyqMOTZk1pjLmF71JAmn6hdZf058ezpPCHRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Nl2U+CFZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=e7545sbr; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710144763; x=1741680763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Pa4mWPM5xGeEb+426mKJO+Tw23sS2KqlELMjyIdxB9I=;
  b=Nl2U+CFZF+3qAgG0HgPqJfuOBsM+5Oa/mqtxa0WKLy/LU6D9y7UnRaPQ
   2AvzptScSWE25QvBI1SfRHU/tmrkbaToCtyMUsvRQRMkwjSKOgbBXK6kr
   ptOk43S60CHncdsshEHUFNUGcxHiir2FPaKX3l+BAXAzrZpwrLLUwiI0S
   qZMzqE37zlMJFZyYw5dHdf2Tk80FPR//b4lQ4Mew0JiWoNi7QVKzVByHY
   f5dPCRmpoDumtdttMM8A9uk8WtfqdLi44B+tb06IZsp/SoT8RvNP1/gPZ
   X9bnQnFjVpOkZzcpkXF3xK9sq7p1JNpkgVuSpamEFvN7wPdYaw4BSVoO2
   A==;
X-CSE-ConnectionGUID: Jn48NFH3SsOpPBxAHfJEQQ==
X-CSE-MsgGUID: Vxq4j1avTkeieudgT1X9HQ==
X-IronPort-AV: E=Sophos;i="6.07,116,1708358400"; 
   d="scan'208";a="10806332"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2024 16:12:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvAYmwqQah0vvVnm0VKgZEsA6U6uH5/m0g6SFCaMnsLWsO49Cty5k7aGMPx7HDFJLDLd6gKzR0b9ZvhU5k3z72wsliSP0hkYqBHGeAGc54WbzANt968zndP7UPjJ+8pHM4OS64ZEDWBlWPr4e/dNzTny7LGClXTeWBGk+vcK04O+QY5x/hFKXnj5Pq0ZpT/VoQP1FhuyBIZdNuEwW+TVQMNE5cGnaniN4W8FY3R+MLUDQ7xxoDFv4e6tmd/TRTqKdn8F0f791BkOWLElz2BBLz7DPArndmq21fs2eB+H4BmWlOJ4iUN+QG4iYZFC6Y6GH6c+oxTVxmenVDrLWeLUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa4mWPM5xGeEb+426mKJO+Tw23sS2KqlELMjyIdxB9I=;
 b=ZqkSaB79s0mi+H7e7/zZUNfnxVssXE6B6a8BSLoSGi/s09vOhDGtjN2rBG7y5LILenasbrWwHvTXwBEQBlgrDl1GQKptPaAHmepCTtVZzDl2+AqxcvNUlMPpFEEL3jvbUigICcJRvIu4dtv6bogxdWV1HT+0+nOMr9YvoYPMO0Qa09nE/aoA/PoPKPMOTsmisHrQoluDH9kBWJnLdIZbOIoRQCT41oa12JL0CdVX3tQwC5UR/KKOYDfYRkoefu5HJDBj6FJ/Znq1OJmE8S5fcEJ5j+Sb1W4PaguMm7o6pRMHWAfAjYPBQAKi9h4Y1RxpcsQnXvbf6B5eSNM5hZyBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa4mWPM5xGeEb+426mKJO+Tw23sS2KqlELMjyIdxB9I=;
 b=e7545sbrswtRaGBdY3xn56+XYC+Iew+gPmz8Gyx8LTYObWevUAIkKdYgI2a4d0tUv5/5nRvVfOOraNr8d2RYv38KSXOv1j+/Mq0jDycY0O57y0tqt7oS9iq+DcrHPfus9OxlFJ8n9D2RFfdJml3j6weovLBUymxBYQ7z/ZAWv3U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7450.namprd04.prod.outlook.com (2603:10b6:806:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:12:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 08:12:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik
	<josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, Christian
 Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Thread-Topic: [PATCH v2] statx: stx_subvol
Thread-Index: AQHacQB7a0OzBoIW0EyYceG+9ps3fLEyNboA
Date: Mon, 11 Mar 2024 08:12:33 +0000
Message-ID: <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
In-Reply-To: <20240308022914.196982-1-kent.overstreet@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7450:EE_
x-ms-office365-filtering-correlation-id: 565d7f92-9763-4950-859e-08dc41a3011c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lwGexL7GTiTjjyIdljOoQuciJTIonYMfiwnK57OZWo4Wxl1INfMGVB7759gQxhrOl+mxCBGxr1nRHyXC9hqhGsFYFyxP/yNnNYDLqYUEMkxY5vGAiT37vCLBq/VPaPE937d/yxNy+mqSIyacVi9K2CB1otNaHmTcDBIEjUYI6Hwt6LiHaYYJucAUtSCb8ezIARBnpz9gSNCOxs1+97JauRL5B3LXlSY+VJ7UM3f5f/GT11neokG/sj9hQzNV/Tqoz+VitXLMir04JZH+zNbZgCQrm0eHnjHsN02R277JiAhrI4rXe33MJiWv2DV2t+ZX8AHIm1RNJMmTe3S7jt5Bqs25/JB1JyS5eZIjtxRh1l05z14JRFwftApo5Pl4bNMphg/ylBn847IiAU5Y3kAk6q421sGExWF2BIOMsO6llxZe+QBsCvjyMYhFdS7T94O/geAR53dVVYnri9y9KJvRsGjuLC+ZJG6nEEmij3+t106iu2aSEbH9nNtZ0PjUin82QbYzm5PchMfFaVIKHeAjyAE8Iix7P89yT37Uk2Zd0FFPCW60mudhE5SkW+zUeloolXvB+472esOMX12tlozuviVxsS0sv0IwOnUD6QurZZhW6f1UVxDVWd7MYMPKpUv5SujuFB57tu/DETnbEMYP94y7LDnsvaN454L3XYvAonOtOee8SUvLzFhdJv9Y2yjq+XQ0/sqmf9z2jCI+1YctNRF1c5qc8APFedBk191ilmw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWxuVFJCckNtOXR2N3N1SUxRcFFMcEdqa0RqbjN3cGNKTUsyNUR4RTBEcUxi?=
 =?utf-8?B?SndjSHE4b2E3Q0wybUpBdGx5ZmpqKzlsT09lODlLVXFxbjdjUWJCWHlUNkY2?=
 =?utf-8?B?SlE3RExVRzNQN25CdUh2MUtaTjhJTmkrUFlHemwzRjg2cVVYRERCYlRtM01D?=
 =?utf-8?B?bGxnVmE5NFZUUEhMcXpPOUJoUTV5aFBDNnhZSzNvY05MVW9ucFlSVWhUSk91?=
 =?utf-8?B?cXJDWnprYW9zNU9UL3BWb0JSUktjTkRLNDBjTE55a2JTdmVsSWp5Ky9oWXhG?=
 =?utf-8?B?Qnp2eUliTWFMN3lGU0w0VExHa0NNUllnNGl5ZWY5bzdRdEFxaVVPSUxzMnQ0?=
 =?utf-8?B?TjhYSzJNam1mYW5sU0RUNVh4Y1M3UkhSTFBFd3F6KzdtOTZEaHpQenpwN0ph?=
 =?utf-8?B?d3hIK04yRTFnMXBHMHVXbzhEV2NOeVBVMkRSS05Ba1BNUUNyYjhsMTkyMUhu?=
 =?utf-8?B?SWQ1aTZKV3RNdGFUTzJLSkozNUtQWU5YRVRubGd2aUZYSDY1M1ViY01YbGVJ?=
 =?utf-8?B?WWkrdDd5Z0RuOXdVeEsvK1cxazNFVldWNmhpbkNPUi9mR2dMRVkxM3hxSGpG?=
 =?utf-8?B?V3FxQyttTGZjbTdSQWlveVBKa3pOV09rMWY4MERqNW9rQ0d2ekx5UU5YQ0hL?=
 =?utf-8?B?NUdSbW9tdldETTQ1MW9pK3huWUh0bjRBckpoTW9aMFlVMUtaNXF4d1ExOTRR?=
 =?utf-8?B?MTFKOGVKQTA2L2UvOEVDeDF3dU5uWTBCWlF6bG9DbE9pZUlzWkFxK0cwY1B4?=
 =?utf-8?B?cVF0UmYyam50WHpuY1Y1WlRsMnU1QnMrbmRZSjRzUjhxa3VvYmFzbTRFMmdv?=
 =?utf-8?B?eWo4ZVZZOFgycFB2WUtlU0VDMFgwUldWN003S2dhUG1jQ082Zm9xZlR6TzRV?=
 =?utf-8?B?eTdEREdIemlmWUk5S2hkaXQwV21ORm1QZFk1eTQwQ2drSmI2MUIxQXhUQnhx?=
 =?utf-8?B?Vm1pTjlGd2owSW45dTNKeDFIc3FlYU9GU096QldrZCt3Rzg3V1k3WVBMVVo1?=
 =?utf-8?B?VWVJWGdVb2tvN0VNSm9GOFBnTnZoQVQ4d3hKS2Z1R3o4QlVFcW1WNkpObllM?=
 =?utf-8?B?YUZVaER2MW02VmxOU29FVDUxRjlzYkJqa3pKbVpxajkvOHBqN0xoc1lJaUZs?=
 =?utf-8?B?bDUySnNHWmlqbDBZUUVOakJNdXg2alYrTXQ5RXo5N2l4RHF0NUFaM3FtWThN?=
 =?utf-8?B?SnhGb0M3ZFoyaysrYUhzZXJWeGlxVm5qOUZjZ1JjN25LazRidUFLU3R4UVA5?=
 =?utf-8?B?czF4R3N0ZWlUOU9PeGQxVTJNa0xmMzJRTVNnVkZqd1lxakxTSmdxdUJUaDQx?=
 =?utf-8?B?MW1tS2RTR2tOVEFlQUJRNWw4NmRCTWx0cG5qUVZmemwvNHllZzRWSVMvN2RJ?=
 =?utf-8?B?WWR1d094WHVjK2JLU2VIS2ovRjJ3cEczWnczYjByQlVENmlab1lPTUFiOUJQ?=
 =?utf-8?B?Wmx5Vm9MTFd5Z2ZMZGphUkNQUkVwWWFTZ0xkMXd5Y2ErTHBWWW9BOCtOTExS?=
 =?utf-8?B?Q3oyd2ZZWmcyYXdrOFFWL2d5VVQ5OU1IZ0ZZb3JySC9LMDlUODZqMWx6SVRI?=
 =?utf-8?B?cWczd2NpeXRiWXh6bG5DeWJYb2hrWSs0Ry9aMUxoK2dxdlBHSDljaHhwSDU2?=
 =?utf-8?B?K1hNUHphVXBOYVEybnUxSjN4Q0FOeVQ5ZDRWT2sza2RpNkhhN09xV3I0RXIx?=
 =?utf-8?B?R0s4ZCtseTd5VnUraHBLM1VkQ3E0K3JzQ0ErTm5UMW5TS0VSUWlQZ0wvWXll?=
 =?utf-8?B?OTd0bEJaYXJRS3Q4c2NSWDZQUUJDRDJTZ3BkNmE1cFl2NGZWWVZRejM1d2x3?=
 =?utf-8?B?cEhEVTl4N3FkemNPTkVxNy9GN25VL2EzcG1KMkl6UFRnRGNqMnlsMUROWVli?=
 =?utf-8?B?L3N2UGs4Z0ZON0h0aHZ1YUxYODdLeVNhM1A1WVdtek5PRk5pNlJvSWt3enpr?=
 =?utf-8?B?c2hVZDFlcEVNZVBjTzdibXI1cXVGY3U0ek93MlJvekR6Rm8zRW1BTFpJcThz?=
 =?utf-8?B?RGxxeUE4THg2RGlZVHp6S215MHBKZElZQkdCTHlITXNIdno0VWlQUlpPUzBX?=
 =?utf-8?B?UWdYM0VRYVBSNmoxQVcrY1VDMngveGdOSVRPQjgvRnRiY0d1anBEMmF1NGxy?=
 =?utf-8?B?SEZXT3JkUnlIclIrNFhzRFNSbXhRM1lxcXZXbndjN0EydUhVNi82eHlLMXdS?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCF1A465172C4A4EB42FD170C7C55BC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kRlsrMsusrUZUt/bQdUvslGcR8xQLROK1xcgOO+XVXB1nkxACnPKdZKK0hqtJNLiwKT2potaZJvJBAAkvu0Ccj7wri0jUuB0/A7wfBuP7KXz8YygsRSVh5QTpjKvB7Q32AQS7I5SazeiqIKlEk771dOOabOaW8QRrD1XD2PAnukYAzEQs9jON7XUXOpblm6bVvEw6af6ZS4egp8OFM1JPeEQ7gnCrefvfbpdvo92XtEvYw689lcC/JIvZC4MuM5/MZaUJfxgGjEnlnkNZ1ySrvU043s9FvXU/neHOtfvv5VtAeAidLmWdzgHS7itcNyWiCeYpkvYHVBi+ynz8LHXt3p6t7ThTjFr9WXZKj1udKXOTaMykdkQbL5k3A52nYmAvumE/R57B7blb+TpsAiip3mUcDNit6XNW/EzDxdvi0fm18ChalIEVuHHsr+ds0rxUZWD9+nprtuE/sUOSBz8oJeWCCi6jvc69IUkid2GZ4gGqFZ/xWl5FnVwxwnH/QWwmgwmswHdgLWdurhn3JinqZ+w6DEUAdngjcurz4/XaGrrMCuNFwdCJVptJzi8hMR066hxr7kw/nKpcb5cFMyxkwsBVqZ5yFB1PfZQLRHOmU+kUjapRAG9FG7e2Z9ClxsQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d7f92-9763-4950-859e-08dc41a3011c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 08:12:33.3430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDAg9FLRsIHoOdJbawczmGqClAbJ2bSvfc+a6aSkT7YkdFnjdq/jIYnsPMFxbC1LuLxjSt6rWxGkmtuq2urUtZMyQqAh5GR46+zwORlg9dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7450

T24gMDguMDMuMjQgMDM6MjksIEtlbnQgT3ZlcnN0cmVldCB3cm90ZToNCj4gQWRkIGEgbmV3IHN0
YXR4IGZpZWxkIGZvciAoc3ViKXZvbHVtZSBpZGVudGlmaWVycywgYXMgaW1wbGVtZW50ZWQgYnkN
Cj4gYnRyZnMgYW5kIGJjYWNoZWZzLg0KPiANCj4gVGhpcyBpbmNsdWRlcyBiY2FjaGVmcyBzdXBw
b3J0OyB3ZSdsbCBkZWZpbml0ZWx5IHdhbnQgYnRyZnMgc3VwcG9ydCBhcw0KPiB3ZWxsLg0KDQpG
b3IgYnRyZnMgeW91IGNhbiBhZGQgdGhlIGZvbGxvd2luZzoNCg0KDQogRnJvbSA4MjM0M2I3Y2Iy
YTk0N2JjYTQzMjM0YzQ0M2I5YzIyMzM5MzY3ZjY4IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0K
RnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCkRh
dGU6IE1vbiwgMTEgTWFyIDIwMjQgMDk6MDk6MzYgKzAxMDANClN1YmplY3Q6IFtQQVRDSF0gYnRy
ZnM6IHByb3ZpZGUgc3Vidm9sdW1lIGlkIGZvciBzdGF0eA0KDQpBZGQgdGhlIGlub2RlJ3Mgc3Vi
dm9sdW1lIGlkIHRvIHRoZSBuZXdseSBwcm9wb3NlZCBzdGF0eCBzdWJ2b2wgZmllbGQuDQoNClNp
Z25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQotLS0NCiAgZnMvYnRyZnMvaW5vZGUuYyB8IDMgKysrDQogIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lub2RlLmMgYi9mcy9idHJm
cy9pbm9kZS5jDQppbmRleCAzNzcwMTUzMWVlYjEuLjhjZjY5MmM3MDhkNyAxMDA2NDQNCi0tLSBh
L2ZzL2J0cmZzL2lub2RlLmMNCisrKyBiL2ZzL2J0cmZzL2lub2RlLmMNCkBAIC04Nzc5LDYgKzg3
NzksOSBAQCBzdGF0aWMgaW50IGJ0cmZzX2dldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAs
DQogIAlnZW5lcmljX2ZpbGxhdHRyKGlkbWFwLCByZXF1ZXN0X21hc2ssIGlub2RlLCBzdGF0KTsN
CiAgCXN0YXQtPmRldiA9IEJUUkZTX0koaW5vZGUpLT5yb290LT5hbm9uX2RldjsNCg0KKwlzdGF0
LT5zdWJ2b2wgPSBCVFJGU19JKGlub2RlKS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQ7DQorCXN0
YXQtPnJlc3VsdF9tYXNrIHw9IFNUQVRYX1NVQlZPTDsNCisNCiAgCXNwaW5fbG9jaygmQlRSRlNf
SShpbm9kZSktPmxvY2spOw0KICAJZGVsYWxsb2NfYnl0ZXMgPSBCVFJGU19JKGlub2RlKS0+bmV3
X2RlbGFsbG9jX2J5dGVzOw0KICAJaW5vZGVfYnl0ZXMgPSBpbm9kZV9nZXRfYnl0ZXMoaW5vZGUp
Ow0KLS0gDQoyLjM1LjMNCg0KDQo=

