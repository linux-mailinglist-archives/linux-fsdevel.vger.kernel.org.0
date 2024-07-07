Return-Path: <linux-fsdevel+bounces-23266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6F929A4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 01:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D83FB20B27
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 23:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8D6F316;
	Sun,  7 Jul 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YWHKXwg0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AmevSDbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75111B948;
	Sun,  7 Jul 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720396346; cv=fail; b=Qg/L7Iv7nKO0k6vSc+/jlltLGHDSSYbteW5c0hekRaR5O+XrI36TEJQ7cpCT6dehs4eZmZ3GzsHU7c1YAp17AVHdfQLItw+4CTIKnrrfoqYVVBi9Js2+W3a96jBgKMtJ+sEIq5yzW8ZpSWK6Cyxx6bDYC7wBsqbvp29FUrgA2PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720396346; c=relaxed/simple;
	bh=k1U2Fi7yb3u66OmsZjTrPFY8JzW8uU0gCMpMPM7rKXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lL99h7GUUV2t65rIMPNpqyuaNdF7KsciXqbqZVa/epL4GvU1zxL8nsQXRXHIRH7foryic1qRQrrQBz4M9UONKCLtFvrqbDNEN2Zk35g28ibPaI99990vinLkf3fmgLzKha0KJdZcVB9Mt1VbWyDVeKg/bhd4V4JA41Onnwv3WVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YWHKXwg0; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AmevSDbN; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eec937183cbb11ef8b8f29950b90a568-20240708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k1U2Fi7yb3u66OmsZjTrPFY8JzW8uU0gCMpMPM7rKXI=;
	b=YWHKXwg0k26X6N8K7NUUU1ucamggLyzAx5gzYOv1996ouZCEEha9M5CV1DJ3SKOeVky+z79Slkpf34ltvqH1tfXSpJty8H8LMeEKERgvXJw6iCUmhRa7+NT/Bka+1C6CWvE8yAcAhwj3DS68OrscHsqQyczbp6PhVJdq9lglV8U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:4852a827-e2be-4561-883f-c8e194735587,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:061332d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eec937183cbb11ef8b8f29950b90a568-20240708
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2074593561; Mon, 08 Jul 2024 07:52:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 8 Jul 2024 07:52:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 Jul 2024 07:52:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiPzZ5KtNZj3GC59gQVUHczNuBUF1fMTKzNvSnDa+aQIUYH9kLje/uMzlzmbw65YiAe6HHw8qTdfBSrDNTk12JxNzK5YBCI6kIN/qBS75KOWqDgBrNGxU8RxQqtX+r4zOMZ2h+g9XE0gWT2Y4f4IhtVwu0lShCddlduq8k9iyAmtY617vN8Jv8/Ahsz3FkT1xpW15tuurW6ymef89aO+4NLp6aSmoeqUOBMFSF59qsm29M7ccznGyucJUcGY/3UjQNad6nsUugV7yADdb4Jog78vExen14BGMxdUyv88aakoPkUkqE8DhGMBeukR2tNLJpybr4UnR0asR7eOmHVsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1U2Fi7yb3u66OmsZjTrPFY8JzW8uU0gCMpMPM7rKXI=;
 b=RhpKiq5Pb9sqyt2ZiShG/SIR0R9VdKNK4NfyvtIBwL5jhBVEiY8E5KXaisTJmXNJf74gCb9n1RtWhXxINxq/cZ1ARrjqO4TXeJZ+0QIXVmbEP9HcxJPIcLkS7wvPa9aT6fHJs28QtxwnF3ps4xAO5TxtcuRR33Dp5sCTBVNIuTVlD+43NtK+JJSifuxcLmnNpMDJqC0OUOqb+amOaCpkQb1yJAPWQEqFxUcK9HLL9wUR3P6NkRa5dmfQWSRZY1R6OxRTO6eLYJd+r0tSHHrCHCjU5H7+RWcZOEc9jA92fbRwIlWCFbrQOJUBNeaZCgAzhDkhvcC20ArrdCVCrvs4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1U2Fi7yb3u66OmsZjTrPFY8JzW8uU0gCMpMPM7rKXI=;
 b=AmevSDbNRZDJxDZAMk5Rszym3YSaiEpVT7bSJONlpUNu2LiteS1zSNcBObrEgm1uH+FGtinPAbZU3mOuSpy5e4Ti/67H3tMs+bL/MEF8SQWGPjubd4xpK9m8Web8yl0uvg4RFGEz3ln9sTc4JoqWS+OqRBhEfcnlqvAPweP1Ry8=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 SEZPR03MB6523.apcprd03.prod.outlook.com (2603:1096:101:72::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Sun, 7 Jul 2024 23:52:10 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b%4]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 23:52:09 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>, "linux-unionfs@vger.kernel.org"
	<linux-unionfs@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH 1/1] backing-file: covert to using fops->splice_write
Thread-Topic: [PATCH 1/1] backing-file: covert to using fops->splice_write
Thread-Index: AQHazrPNMVBj3/M920ORTYkpBBF/L7HrvwUAgAA07IA=
Disposition-Notification-To: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?=
	<Ed.Tsai@mediatek.com>
Date: Sun, 7 Jul 2024 23:52:09 +0000
Message-ID: <e2fc762dafb191b70557b1bab72ae5f50cdda69a.camel@mediatek.com>
References: <20240705081642.12032-1-ed.tsai@mediatek.com>
	 <Zor9wiPTXCsnTVdt@casper.infradead.org>
In-Reply-To: <Zor9wiPTXCsnTVdt@casper.infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|SEZPR03MB6523:EE_
x-ms-office365-filtering-correlation-id: c8797e54-4982-4a66-ff87-08dc9edfd065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RDZ6ckFyQ2FZR2g0TDhXTUdMeXdKTFp1ZmZiQkJ5RnF3MzNTU1ppOUEweFVL?=
 =?utf-8?B?M2VQaHJJRXYrVHMzblp3bUNFR0s1MHBSL0pzdHF6Ui85bHQ1TGM2K1ZVOTdD?=
 =?utf-8?B?c2s5ZDJ3aW5MM25VSW92QThFdmFsWnQ1VTc0WlFPN21XTERHNDhPR3FVaGF1?=
 =?utf-8?B?NVJRdlR6em9MbnpHT2x6WitqRlEvWkFlb0YyZFJKSkVpRmZXUDlLVUhkaC96?=
 =?utf-8?B?ZytCRzZ1TlUxL1dVNW9GV09sbGxRS2c0blZHRWVvUU9TRFpMR0Z4Q2h6d2xn?=
 =?utf-8?B?TDl4bGdTcDVNdjRQTjVQSEFnVWwrRDBCeGt3d0grbE1Fakh1WE5ONlFVWWUy?=
 =?utf-8?B?TEVoMFZ3UFVPdFVJS0wrdXFWcFpBcTNza0NwekVHVTBtdm9iYS9SN2V0SnNs?=
 =?utf-8?B?eTZiWFVsbEw4akY4OGRmK0xQNlp4MWRHeWc1OVcvaVpXdDhWQzl0TTQ3Rkwx?=
 =?utf-8?B?SlRpcllOdW9WcXdPMU0zNitHYjdCdXBiK3poTzRvV1U0TWUvYkE0N3hQMFZi?=
 =?utf-8?B?RG53VmZFUUdPZTg1aEhPcDRFNkJMUVRXUjlwUGkxRjFGUDBBYmRwZkVMczJK?=
 =?utf-8?B?RzVSaWZPcDBjZFdzK1ZaRmNjQ2p1UUFhQVNSWWlnZW43eXppQnBpWlUzV1gw?=
 =?utf-8?B?aGJQbEM2aVF0eGxtL2E0R21VNnl6NVB0TGYwcjBkM1V4bUtCNElUbDYxWnp6?=
 =?utf-8?B?RXg3VUdmZ0xOTjdmZkd2ay9KT3BSMm16L0xNRjJUOTc2NDhvN2NBWllkTE0w?=
 =?utf-8?B?YnFBS1dWRTB3U24rUHBZdkc2UnBNcmFNU3RJNzhSNyt5OGw4eksyVGRZKzQ2?=
 =?utf-8?B?dmNISTRLbU1EMWppVm53R0hxS2htYjZMTWNXS0FkQXNEQ2gzRTBsVkdrTHBP?=
 =?utf-8?B?KytqMjZYbEhtV2ZaTnlJRkt2L1hYdnNYQnMxaU9TYUxLRUVYQkQ4TmN4VVlZ?=
 =?utf-8?B?ckhYVlBFOVc3Nk8vd1BhVWt4WU1DM0JYUXgwUE9XUjBsRCtqQlR2M3p6ekdm?=
 =?utf-8?B?c2R1THRXbitOVHBCSkY5bWU4WXB6R3ZSYU9teWQ4V2k4SzM3b3BEcjErQzMv?=
 =?utf-8?B?WlNmTjR1YU93YWE5YmgreW9sRkt6K045RGZEWXBRSHl0MlZWVmVSSUJ2YWVQ?=
 =?utf-8?B?L0VWY3lRbk5IeGF1K3pobmIyQVVxZGVFbzJUYi9mc1NnZy9jZFhyQ0VtZ2FS?=
 =?utf-8?B?dTJ0S0ZrSXpXcUlGN1dodzBtMGpJZk1vQ1NnSThFL0U3VlBvL1h0RFIzWEF0?=
 =?utf-8?B?VHZ6RlJ4cGdueXdLOWxCRnZ4Uk51K0o2bWRYMkY1YVlnSG12Z2RCV0pzQnBw?=
 =?utf-8?B?LytlUDZHdUlwT0NRcU5lREpJMTJJMWV4NG41SFNEVWxXSjcyeUJRQ2dmclU2?=
 =?utf-8?B?WDAwMElVcXEvSnB3MDBsOUNaUWFFT0t4Y0JmbnVLWm45bnZmRmFPUWRtYXlz?=
 =?utf-8?B?MlBkdThkY0tyRHVNNmZzQ2JKdjVwMjB3NjBFWktaZVpDL1d1TXFCcm5yM0ZP?=
 =?utf-8?B?SkgwYStON2ZNZ0FOU0l4VkZyZlFZZDQzT296UkR1cHNiZXUxaUNwZm01MmhS?=
 =?utf-8?B?U1VtWDhMNHdxVTA4MG1laVE4L3dpZnQ4QlJDVG95THZoNy9SSThob1pwUVpw?=
 =?utf-8?B?R2tzbkN5alNtNU84VG5DSVJUZ2FEMk95SkdXWi9CdzJjUmtvRWtuZ0ptdmNx?=
 =?utf-8?B?VlNlQ09tMEJma1QzR0R4WUt5aVE4N1pRVXhJRXZXWnl2eVdrWENWWWdrcGFx?=
 =?utf-8?B?QUJWR0RPZERxSXpFYlBjMUhxM0Y0SGxvK1VZWHIwY0xaRXNpZUZwMUNHV28z?=
 =?utf-8?B?eG54K2VmUzkzcGhLZHFqMXJDbmQvd0I0ckI1dWFnYTh5dDJJakxpdjZJYWVW?=
 =?utf-8?B?MXpkbGdVMG50aVBnUThIVVFQU2RIdHJBRXJKTlNmRWgya3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG5uL1F2RUluV2tjdzFLNit5V29iWkFBYjB5RUprWjdKR1pvaEE5STRFbHlZ?=
 =?utf-8?B?SUpkU0Yyazk1ZTlZVjlRbktxMXl4NmhMMDFxSGsyenIwbWtiemF1T1hVUlJw?=
 =?utf-8?B?bis2ZXNaZHVGTXhuSVh6UTZTYlhtbnpwb3lzL0tWcVZNSFlabnBObVRYWjEx?=
 =?utf-8?B?Ry9VdnoraGxWZytnTG9IbmRmSWZsRTc1anlQTHRiOUV4VU5FcFJtM0k0d3Fl?=
 =?utf-8?B?UjNuRmJXQXBKcFc1QnltOGJJdzRnRUxWU0pCemFNVTJSdmltM01xaC96Njdw?=
 =?utf-8?B?WnRqRDFmT2Zjcm0vTUJJSmFPYWRoRWM4NkVuZTczQVQ0UERia09wVklmVERI?=
 =?utf-8?B?d1ZiSlFSdjVoQ1RtdkJrdmVzbi9UQWg4d0c0Nk1MSmZhcndTZ094cUN6MmFY?=
 =?utf-8?B?SkgzM0dVU0dpYlBDR3JjQzRpNUpVNnBITnY4eVJ4TnhvenVXbmtLdURweHE5?=
 =?utf-8?B?ZjU0RWVXRm5BVHNHY3JVS0djNU1PRDVGUnlPMFlyK1dCZm1NeFIwRGNjYVo2?=
 =?utf-8?B?RDZ2bmV2bDZIVENhWUdHUWloT0w3SXRyNENnUERxeUE5OWl0akdoYVFrcDZt?=
 =?utf-8?B?RS96YWVxM005bzlXWDlJOUg4cG53RVZmY25TNitJMW1nZU1wSEdrSkZXTktB?=
 =?utf-8?B?NzlDcEF1MEhwSXRwZHZ5cVRDZndiR0puN0xBOTVNWGxLR0UxeGFmT2htZ1Vy?=
 =?utf-8?B?YVJPZjY1RVRqSzZKaUxvdVlXMGw5c3VRY0xBbUQwMzRoQmhmM2EweWlNK3JG?=
 =?utf-8?B?RHh2ak5KYzNGazd0cVdLREJ0N2s3M3Z1Y2habERVTHFCUFQ4QURVYi9QNURm?=
 =?utf-8?B?dGhVVVVIS00wb0kvekJ6N0lmRDB4eEVzd3VLbHdHUVZ6b2JIQ1JWVE1mR2JT?=
 =?utf-8?B?RGdWeUlsTTR0anp6blRmUkVjRXpzMVMyTnF4ODJkanNydkJMZ0ovSG1iWmRM?=
 =?utf-8?B?RUl2ZWoybFF0Q0dVMk0vVFlVbUx4c0lxMTRNc0tzZTNKamw4UEoxTURrTzJk?=
 =?utf-8?B?bkxFSWk0YlFMMHRFMXZUZ0FPbXFZOW02Vkw0YXRmSm5rNEFqLzNROGU4TDdD?=
 =?utf-8?B?dVJLeGxaOVFYSjMrTG5GZ3N4cDYyaDZRbmdCaVRlZlY0Ym5ZbFV3cTRob1JJ?=
 =?utf-8?B?eS9JZWNNTzJkUTZQRkp1OGg2U3pzZXpMeVE2OEFkMFdWZFdNQ0l2ZWdMQkdI?=
 =?utf-8?B?dXlnWGxhSGNFM0o4WFgzRExKQkNSQzBvWUNKd3RSZERFeGZLM2I5dFFFeVhJ?=
 =?utf-8?B?Q3Y1WUk4SHErLzdER0JjaHYzVU5ZUHBWbEpGempFVk1uM1Vjd0tNckxWcTha?=
 =?utf-8?B?aEV4QnlQM1FDZnBwNUVnLzlWQnN6RUJRdjhiMmtFMTJpNXRER1E0cHpWQnRN?=
 =?utf-8?B?NDJCVkVOSDBrK0F4WEF4cGplT0gzZ2tSZnR3V2drM0J5MHdMRjA4OTVhTlND?=
 =?utf-8?B?Si9sZHpKdDFLeW1CLzFiNDBvR28yK3JNb3doeXQ1NWRYN2M5SDFjdjVLR0dp?=
 =?utf-8?B?eThlSU54YXgwQzhzSlBrOE50R1hBd3Q3TXExbUg1TGR2T094VFN5Q0lNczdt?=
 =?utf-8?B?T0RsUlU4aXZFTzBaWHNKNFN5SDhDVG1PajZtWi9PKzdCVTFMeDA3UHhYbGpO?=
 =?utf-8?B?NTdraW9tdjVCMGxFcGx4SlBmc0VFNHNKaC9laWVQU2h0NU56ZTFkaG9OM25h?=
 =?utf-8?B?dWNuZlMySGZGQldobHk5c01sL0ZDZVpRVldkSkJUUGlpOUloRVBLQVNabDho?=
 =?utf-8?B?SWlmamdRWHZhWDc0a1JwWlFwb0U2SGt4cGZ6V29KNThsWEU3eDZTYTJFZmk1?=
 =?utf-8?B?RGZGZ3g4RjlXbmhXMi9XUmpyUVBpTkhRMmd5Q0xkNHNMVkFXZWFCeE9URWIz?=
 =?utf-8?B?UGxYeG1OcU5MVUhWTjVSTG53akNzdEl6SzI5dmtTYllFeThXOHJUUy9iZzZQ?=
 =?utf-8?B?dVc2VVRpYjQzazdORjQwc3Z5a3h1RDVwZlljVG0zZzltejVVbmFMRGVRUWNG?=
 =?utf-8?B?Q3pTaUtGNHNQRnROT2MxRFAvU3c2alZBSno5TnF4MVJ2WXVWaUMxS05Bcjlu?=
 =?utf-8?B?UHc2QWhRM2VLbk1BMFhNc3RwSDI0YXI3eUZ0VlRDQ0ZST1MzSGg4NGJRbFgw?=
 =?utf-8?B?MWFXczVFbmR6SnNFOVBpM1BCU3RyR21VUTdpWlFsdHRjazBKbGFGVjRNS3lW?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E018C08C83FDD74983BF727D80BE2B79@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8797e54-4982-4a66-ff87-08dc9edfd065
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2024 23:52:09.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZz6HOHybGscrolQfXWZIdf2HySgsGbn2/YKd/aF0S2CMDVNXHRfQqnLjMkiO0EgQ2SI6mSy6FM/fa6Eu8pV8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6523

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDE1OjI3ICswMzAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBGcmksIEp1bCA1LCAyMDI0IGF0IDExOjE34oCvQU0gPGVkLnRz
YWlAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEVkIFRzYWkgPGVkLnRzYWlA
bWVkaWF0ZWsuY29tPg0KPiA+DQo+ID4gRmlsZXN5c3RlbXMgbWF5IGRlZmluZSB0aGVpciBvd24g
c3BsaWNlIHdyaXRlLiBUaGVyZWZvcmUsIHVzZSBmaWxlDQo+ID4gZm9wcyBpbnN0ZWFkIG9mIGlu
dm9raW5nIGl0ZXJfZmlsZV9zcGxpY2Vfd3JpdGUoKSBkaXJlY3RseS4NCj4gDQo+IFRoaXMgbG9v
a3Mgc2FuZSwgYnV0IGNhbiB5b3Ugc2hhcmUgdGhlIHNjZW5hcmlvIHdoZXJlIHlvdSByYW4gaW50
bw0KPiB0aGlzPw0KPiBvciBkaWQgeW91IGZpbmQgdGhpcyB2aWEgY29kZSBhdWRpdD8NCj4gDQo+
IEkgY2FuIHRoaW5rIG9mIHRoZXNlIGNhc2VzOg0KPiAxLiBvdmVybGF5ZnMgd2l0aCBmdXNlICh2
aXJ0aW9mcykgdXBwZXINCj4gMi4gZnVzZSBwYXNzdGhyb3VnaCBvdmVyIGZ1c2UNCj4gMy4gZnVz
ZSBwYXNzdGhyb3VnaCBvdmVyIG92ZXJsYXlmcw0KPiA0LiBmdXNlIHBhc3N0aHJvdWdoIG92ZXIg
Z2ZzMiBvciBzb21lIG91dCBvZiB0cmVlIGZzDQo+IA0KPiBUaGUgZmlyc3QgdHdvIHdpbGwgbm90
IGNhdXNlIGFueSBoYXJtLA0KPiBJbiBjYXNlICMzLCBhY2NvcmRpbmcgdG8gdGhlIGNvbW1lbnQg
YWJvdmUgb3ZsX3NwbGljZV93cml0ZSgpDQo+IHRoZSBjdXJyZW50IGNvZGUgY291bGQgZXZlbiBk
ZWFkbG9jay4NCj4gDQo+IFNvIGRvIHlvdSBoYXZlIGEgcmVwcm9kdWN0aW9uPw0KPiANCj4gVGhh
bmtzLA0KPiBBbWlyLg0KDQpJIGNhbWUgYWNyb3NzIHRoaXMgd2hpbGUgY2hlY2tpbmcgd2hhdCdz
IG5ldyBpbiB0aGUgbmV4dCBMVFMga2VybmVsLg0KDQpUaGlzIGFwcGVhcnMgdG8gYmUgdGFrZW4g
ZnJvbSBvdmVybGF5ZnMsIGFuZCBjdXJyZW50bHksIG5vIG9uZSBoYXMNCmVuY291bnRlcmVkIGFu
eSBpc3N1cyBhYm91dCB0aGlzLg0KDQoNCg0KT24gU3VuLCAyMDI0LTA3LTA3IGF0IDIxOjQyICsw
MTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4gT24gRnJpLCBKdWwgMDUsIDIwMjQgYXQgMDQ6
MTY6MzlQTSArMDgwMCwgZWQudHNhaUBtZWRpYXRlay5jb20gd3JvdGU6DQo+ID4gKysrIGIvZnMv
YmFja2luZy1maWxlLmMNCj4gPiBAQCAtMjgwLDEzICsyODAsMTYgQEAgc3NpemVfdCBiYWNraW5n
X2ZpbGVfc3BsaWNlX3dyaXRlKHN0cnVjdA0KPiBwaXBlX2lub2RlX2luZm8gKnBpcGUsDQo+ID4g
IGlmIChXQVJOX09OX09OQ0UoIShvdXQtPmZfbW9kZSAmIEZNT0RFX0JBQ0tJTkcpKSkNCj4gPiAg
cmV0dXJuIC1FSU87DQo+ID4gIA0KPiA+ICtpZiAob3V0LT5mX29wLT5zcGxpY2Vfd3JpdGUpDQo+
ID4gK3JldHVybiAtRUlOVkFMOw0KPiANCj4gVW1tIC4uLiBzaG91bGRuJ3QgdGhpcyBoYXZlIGJl
ZW4gIW91dC0+Zl9vcC0+c3BsaWNlX3dyaXRlPw0KPiANCg0KT01HLi4uIFRoaXMgaXMgdGhlIHdy
b25nIHZlcnNpb24uIEkgd2lsbCBzZW5kIHRoZSBjb3JyZWN0IG9uIGxhdGVyLg0KDQo+ID4gIHJl
dCA9IGZpbGVfcmVtb3ZlX3ByaXZzKGN0eC0+dXNlcl9maWxlKTsNCj4gPiAgaWYgKHJldCkNCj4g
PiAgcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gIG9sZF9jcmVkID0gb3ZlcnJpZGVfY3JlZHMoY3R4
LT5jcmVkKTsNCj4gPiAgZmlsZV9zdGFydF93cml0ZShvdXQpOw0KPiA+IC1yZXQgPSBpdGVyX2Zp
bGVfc3BsaWNlX3dyaXRlKHBpcGUsIG91dCwgcHBvcywgbGVuLCBmbGFncyk7DQo+ID4gK3JldCA9
IG91dC0+Zl9vcC0+c3BsaWNlX3dyaXRlKHBpcGUsIG91dCwgcHBvcywgbGVuLCBmbGFncyk7DQo+
ID4gIGZpbGVfZW5kX3dyaXRlKG91dCk7DQo+ID4gIHJldmVydF9jcmVkcyhvbGRfY3JlZCk7DQo+
ID4gIA0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IA0KPiANCg==

