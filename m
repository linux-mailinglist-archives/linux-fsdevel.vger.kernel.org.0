Return-Path: <linux-fsdevel+bounces-55199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174BEB08275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 03:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B8E3A9D88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 01:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4E1DB127;
	Thu, 17 Jul 2025 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pedX1y+g";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t6BKg3hD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13A1A288;
	Thu, 17 Jul 2025 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716154; cv=fail; b=AnmtQUjaxx2x8j3tVyRWFMgRmtTYChzHoY8Fe1EWfzu5u2vy4IPYAmKvHgkTzZs3CbcXF8kjSUUzjcVL73EtinjjS1Wqk7OvmpC28Oy0gBAj33x/IbC9t2aLynn48mNOWgYiDINiXEEhx/k8FoxM5gcexGbeLbK3dwuQ7y8J3/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716154; c=relaxed/simple;
	bh=9xD12U+1Q7IkrKuWEmehdsSGSbM8keaukfIM0NyjQrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jmG5IjuYvEYv4pjk98oXdcNwlAxK7SYACnqmy+SV+YKhPtXwTHcSJqufrGDNvNOavrh2w+5zfig/sTO0wiljjc4rTXaE+gJmpmC0BQCR2I/VNLLmiOE5BxM2TUpS4AOvpk/2zcanmMcDJJGfYHX2PU8rMSobIcR7lTLrh0ly+eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pedX1y+g; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=t6BKg3hD; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5b1d846462ae11f08b7dc59d57013e23-20250717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9xD12U+1Q7IkrKuWEmehdsSGSbM8keaukfIM0NyjQrk=;
	b=pedX1y+gPLNL8q2LEzlh9LUT1MW0mDy0ZSKWCvytNP0GXEt1UYXhq+74xGZ+jHKr+vZkJhkQzVChmotqG3B1W9uaza0nEaBiF2cd+9MUnDOYZ9htWCRN5ChPQXpqjkXtKpbjW6eHimAOanCsVENpoFvV6IYtM7eIgRR115m4Sv4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:4d204512-3e43-4b09-a2ee-a228e574923b,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:da7edd0e-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5b1d846462ae11f08b7dc59d57013e23-20250717
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 105565990; Thu, 17 Jul 2025 09:35:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 17 Jul 2025 09:35:42 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 17 Jul 2025 09:35:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGvMWBet/L+G8T+2yHXJuP6e4BnRpep1yjBz8/yP+NI+mACLjhvqpjDItk6vJqT3LZyeVJW9nglnQQuth453ydYJrbId6MZKFXM+mmMyZgaNhl4+3CP1wper5nrMbiBwjoe/UDbAKjO0FvBbVMlshftX+fsr84kjUGZdbSzQcZX8gHOmn10gSHvV6wVmWtof+4KhOYKZRHrfnizIMTJxUBiYSxk8RROoFtY3eWR2P1x7/RpH4Rm5lF7u60fjl3oP5d0HVC1nJHCJC8w7dndCRABHIT1unNBMQ+KyPcuTbppnuqP7OiR2rgBOWmBSEVaTv88CPx+vLxxEUkoeJlySjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xD12U+1Q7IkrKuWEmehdsSGSbM8keaukfIM0NyjQrk=;
 b=xhCaWb3KU+l9aHONR5a+8KRTG4aA9/tBz6GrJXvKPZYfK2CYV8InaFxcu0Fw/F/emkWO8Vuyfef7FrhhTNzVVDKN7pROmNv/OWj9aVVtR/wkyVkaRkPGqUrpzXuiTgQqMKlkv7JhcSYE5Q/Tq1ckEcOyA+d1IYvGODNpaLl6BFvvALSXQqv9GXqGgOYuPUJdUCeU7hTYJr/WPpNr8iiCoDuqGTaxyhiJIx4TDViX+xAEwey/AT4UaU2uez20TLtiTa5LuBhtUcWQUF/HesTlxBW1uJ/qgpalfB/gcuG2/X9KaH2IlYxZUTdgjnB4EhK5JAFHZw4zGXIa/6o5aAr9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xD12U+1Q7IkrKuWEmehdsSGSbM8keaukfIM0NyjQrk=;
 b=t6BKg3hDqsg1BI7qfitpdoywRUuTL56gNJQFU3F3EXTJ9xYP4PvQmkeVQla1RPNJ7QV88GhB6e29vrioe8OdiWzdHfS73uASuSpBNZsjK6r0pmzhlFjd6Q7E/wTLVRe/cax3vKPRhK5TYUvSi4wb7fFFVUZl0caFAbCr8VKqMqw=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 SEZPR03MB6668.apcprd03.prod.outlook.com (2603:1096:101:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 01:35:40 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::8b7a:97d8:96f4:2e6b%3]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 01:35:39 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "amir73il@gmail.com" <amir73il@gmail.com>, "hanqi@vivo.com"
	<hanqi@vivo.com>
CC: "miklos@szeredi.hu" <miklos@szeredi.hu>, "liulei.rjpt@vivo.com"
	<liulei.rjpt@vivo.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>
Subject: Re: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
Thread-Topic: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
Thread-Index: AQHb9kfHg0MUwhWt0ESvkVmcsSKhiLQ0qeSAgADfvgA=
Importance: high
X-Priority: 1
Disposition-Notification-To: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?=
	<Ed.Tsai@mediatek.com>
Date: Thu, 17 Jul 2025 01:35:39 +0000
Message-ID: <aa24548c220134377b2c8a3d2d47620b9e492db1.camel@mediatek.com>
References: <20250716121036.250841-1-hanqi@vivo.com>
	 <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|SEZPR03MB6668:EE_
x-ms-office365-filtering-correlation-id: 3487240a-67bc-45aa-ba10-08ddc4d23c8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VlpVSjVTdzNpRWFGMVN4K2RVQTJ0VmRNdW9xNTA2WUdZQkRzYTlmUGtmeFBt?=
 =?utf-8?B?clQrN3dXSEZlUFJ3SnBONDBtQ0E4Y1FaWUJLRHZDZHNSUWM5dktiMG1CdSt0?=
 =?utf-8?B?bzUzbURhbHl1d2lVaVhiZEdkbG9scTZybTk3S0JLVENyRnJSQ2ovR2o1SUQv?=
 =?utf-8?B?QURubE1uMndwYTZ2cTdDbWZVcXJKcC9TRXNta2VyUG9RY3UzbVBMd1UwcUtB?=
 =?utf-8?B?aDAyUlEyb3kycE94VU1XZHJBdU05aVNBMmF3VGNHOWhWQlJFS1lORjRYTzNF?=
 =?utf-8?B?d0pkUWNVd3FyT1FnMkg3bTg4elVBNlI3Y05NTVpFR2VBSW45cmVuSHd0UHRO?=
 =?utf-8?B?Y2dCNkYxemRNQ29waE4vZmFuZzF3UTNLNFF3Wnlna0tUMW9GVW5uNzdVaW9o?=
 =?utf-8?B?cHBXai9CU3FwclhVMUtFc2UrUS9jcHp0ZzRBZjR4RXg4RnJIT2FBbXF0ZVNx?=
 =?utf-8?B?Z2NrbndUQ1kwUmI1Vm1DOE5CNXYvaDRSUXgwNUxreURuanZWdnc5RXZPUURy?=
 =?utf-8?B?RzR1VkxPYWhyaUg1eVNrNFYvOWRueWx4dTI4VHYwVlJ1K1Y4bGpxOXpDU3Iz?=
 =?utf-8?B?OGpKeHFabEZueHlsb3lYZ1g5RTE0ZW5abmo4L2FZYVlZSlZ2RzhhUUJTTktw?=
 =?utf-8?B?Z3dNdzQzLzR3K1dVN2xORksrTExIb1RsTG83VDdpWkcxamZ4dy9uOWlVVHFQ?=
 =?utf-8?B?TkRyaFdLOG1IUVZHWXBTMFBpMW5kQkZKZjQxeTIwMUl2QUJjTEpKelNlMlVU?=
 =?utf-8?B?Qit0eGtIbCs3cFJ0a3VuS2JvR29wZmV2MTFkK0NlRjhMOVlwR2JwV0JLMWlH?=
 =?utf-8?B?Ky9kUzJOdnhoeVZEYnk2WG1zTmFSdkVYVUhnYmpNeWxhZURxNFlJK2o0Vzd4?=
 =?utf-8?B?emVUSnoyeFpnK0hzWXpLYnZtSUY0bU1xeTRzbEQra3M0YWI1VTBHNTVnMjcv?=
 =?utf-8?B?WUpKWEx0UE9icldyK1h1U25SZWxIdHlQeDU4Mmxrck5DL2Zodks1dWdCdTZO?=
 =?utf-8?B?SFg4TU9sUkI0QjNxNEdva2Ntbi8xWkZhZXVYT1JrRUZneXB6V3ZUcUIva2lF?=
 =?utf-8?B?MkJCanM5dndkL3orOVIxYjZGdUJlc09WdW5Pa2txZ2ZvV2R2bVhYbjM2RkRp?=
 =?utf-8?B?N2wrSWtFZFdxampPcVV3Tk12WTNaaU9kN0lUL2xtL0pmd2VIbUtSWGw0SkFk?=
 =?utf-8?B?QWx0ZzhxSGlPVVp4ZkgxdmRZSnMzdGxpcDRraEdUdHNUK2Y0djVoUjhTMFBk?=
 =?utf-8?B?c2tuZHhacHNSYktMRmFMQ2J4Rk1FMVpDWUFRQWxEb0J5QnVJWTlWR2gzbjlG?=
 =?utf-8?B?NVhBRmJkblZOV1BqT21ZYjlzV1BrbmFXK2haWHVtcG90ejQ5WExKQjN5Sm9Y?=
 =?utf-8?B?dHdVKzZEK0NPVktVSUFmUXVFVERiZGE1M0dIcWlCMGd0dVJNUEkzNWNWbkcx?=
 =?utf-8?B?UERHYzY4Yko5bW1OWElQdWNSMFg1U1AzWStoM0JjZmJtODd4WEgyR2syLzlT?=
 =?utf-8?B?dXVTdm53ekdrWmlYTUZVMm9iRkRVMmF5dmM0Tk5zbUlOOGdRUytGcGVlYW9Q?=
 =?utf-8?B?SjA4dWVaNU9xR0RFOU5lbjJrb3MvMzQ4OHV3V29kQnB1U2c2WUxCL2ZheE84?=
 =?utf-8?B?OFpzejVRL0R6K2l3cTU1ZGsydllYbXh2YWthRzM0bzdkNGZvM0Qxd2FmTGU4?=
 =?utf-8?B?Z2hNbWhscFUvR0NVakp5d2JCS3Jrb3lCWmRaODA3M1NZTS8vWS9BZlJDZWF5?=
 =?utf-8?B?cnNROEhScVkrd1ZuU1FsVWNYT0cxOUp5ek0zdkdTTENTQ0NOYTc4WDZwMERu?=
 =?utf-8?B?TEdRTzFwUnZVS2p1emRVbVZqM0dGdXlNZE5mL0h5Wk8vc3VxZWJvcUFnajdI?=
 =?utf-8?B?SmgwOEE2NGkrOHpaQlFnbWdvaEVTUU1OZ3FGNHIvaWphb2RxMXFESm1KZVpn?=
 =?utf-8?B?NmdlV05RSllxeGppaFcxTzJiTmxiYlo4VEdZMVF3M1lOMDl4ZmNKU3JLZmdL?=
 =?utf-8?Q?xFTGc72m2GeSn87sE8q77LN3vvw/v0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzRuTkEzYVRNdkpxSlc3V1o5d0xuRjUzRDZ5Q0o3c2xhQ3NOWEdKT3JaanNa?=
 =?utf-8?B?S0c1UXJtY2hTL2JUb0NpSUFHWWFhU2dmdmp4QVpCOElTSVk4UHpJSDJNT2th?=
 =?utf-8?B?Z2wvQ3loVStrWlI1UHNtS05Fa2VhNWREOTZTNk5uWlhDNWJ2QUhaTlV4VlN1?=
 =?utf-8?B?N2dlZUMranNhWkJPQWt1ZHJqbWo5K2N5T1dubHB0RmhvOHBrTVR4Wm15U3M0?=
 =?utf-8?B?bitYem1LRlc3WlhIeVlpWm1OS3Q3WWZTZGN4VUp1K1ExRHVEaUhTS2NPTWJJ?=
 =?utf-8?B?UXZIZkl2QTloY1RaaEUxWXpxYzd6LyswNUtpY3NkK29YQS92MmVrYU5tK2dC?=
 =?utf-8?B?MVMyL2YydUVsZjg0VGticm1TbGh5VDV6M1dDZW1KYjdkY2JCWnVoZWh1bzlX?=
 =?utf-8?B?aUxwa2YyWkJEQVQ0eURpNU1UQzF6UmQwTW4vSk50V0ZYRjMvYnNqQytVbDY3?=
 =?utf-8?B?N0xzYXc5dmNOR2tUai9BekVOZ2thMVo5MlBHcTQ3Z04rbXdFNWlEcDBwN2do?=
 =?utf-8?B?akNHYU5yeXpFYzYzcXZGUXMzSTN1VFdQczdFZzcwZmNwYW5nSFVlbTg2QzFa?=
 =?utf-8?B?VEdPd0ozTCtqK3djRzltMk9HbURyWmFVSi9FZzFaeE5OZEpRQjVFQUxQelBF?=
 =?utf-8?B?aWFpdWFJZUdzN3VQTHMzU1dycDdQb2NTZVBpckZzTEYyZFdjUW00bnAyYnJw?=
 =?utf-8?B?TmtMb0hNTVlDWVFiOUZLRWI0SHdWU3h6U21YUytMaW8vdTdTTnJMajVPVDhZ?=
 =?utf-8?B?MFJmUFZnTnFodTd0WGt1L3dibjBXd0NFeGViNU81N3NMY1JXb0Ruekd5ZEYr?=
 =?utf-8?B?UEdQdUJ1cEdlS1BrRXFHVHZweUhRQ21saWRiRFo5RlpBcUplMEdYV05FV1JF?=
 =?utf-8?B?RlN1Q0hObkw0M3JDWG9Ibjc0cmthMENCaUpwVzFMU2l3MmkvMkJaa2ViWDlZ?=
 =?utf-8?B?VjNWbjRrUTNOa3dCMEJzSDNjamdrUjNsL1lyY1RlMkNBeEdDeFlnZ0Q1UitL?=
 =?utf-8?B?d1NJMnJtS3hJbmhpUlhLVktmQUtXSUxtbU92THZzbmdVZjhqa0JUbVArTE9u?=
 =?utf-8?B?aENPa1FqOEVPU1JQZGVHbmg2Y0lYRUhpTHpSUE9ETm8wN3RReGw5RXNzU3Qz?=
 =?utf-8?B?bmx0SG1jdmlhSjB0M3VDUUg4OHhXS2REMjBLSWVLK3pPZHdPNklwL2QybldZ?=
 =?utf-8?B?QWRMajBPZGVYMEJSWnlFcEhNcThuajFOcG5nVTAxdUtOWG4ybVNkMjhvS0Nw?=
 =?utf-8?B?cnZCNFI3eXRad2thSGxiZWVqS1FOK3ZvVERSWVdsa2VlaERUb0VQMkJWTjl3?=
 =?utf-8?B?NzEwb21qVWEvSlBSZjhkMWtURmlUbTBhL1JOV3VBTWxFQjhBYm81L3JJNlNo?=
 =?utf-8?B?Ynhha3AyR0pZZDUyaFl3VjBMSnhuRElOZ0ZsZ2ltUEdzWU9sNXZnRUxqTUVZ?=
 =?utf-8?B?ZmlSaE56VG9mZm9tWWRIZVlPWXluU20vdFdhWnNYWC8yc2NHUE9TUThuUHoz?=
 =?utf-8?B?bnd0bkJWc1VJMU9CL0xsQ21rdG1lTHB4WVRrdTZ4SHZ0bHdjOVpVcHpSRTdw?=
 =?utf-8?B?Q2FveGRhbnpGc0hwb2NVYnovZW0rL2U3cU5YR3VKRksvcG5SY25weTVoT1ho?=
 =?utf-8?B?TmMrRUJEUHRNRjNudkZuMzhRakwvUG1tZ3NRWlZQa01aTDl1UHZYMmFEeVUx?=
 =?utf-8?B?KzR3RHpjejN2T0JsUXNCdCs0UUFvaE8xVmVReWVlNU01M1JiK2NaZDNqMTB1?=
 =?utf-8?B?aU10QzVlWGlxSStJQmFUbUFXU0RrZ1lpMmtUUHJNRlFiWmZLLzdzNEVlcHRS?=
 =?utf-8?B?WXZVY0ZhMzloanpkWS83WUJvMW53T1dhMVgrTllRSHY3VE1YZFlqVzZPK3pj?=
 =?utf-8?B?S2VjNXNBd29SempMR2JRb0hwYlkrVXBQK3BlV0hiQjNsMDhxb0FZZUpHS2Nw?=
 =?utf-8?B?aG5OQzRyaW5hWjNFZXNuNzAwMk9NM285V1NmNXBqTVN0UkZFVy8rajcvSzhj?=
 =?utf-8?B?TkZmcG5Qa2RSa0VFaDk4RDJiTFZ1eFRQa2k4U3AzWHhtVjJockpTdkk5bGNM?=
 =?utf-8?B?dzc0QUpsY0dXTlh5UndLRzlTWmVnSHR6RVpORWNnOS9GWnNzQnE1VFROZm11?=
 =?utf-8?B?MHJhcGtHRUFEalN2TUk4dWx4eVZKZHBaaHBjekRmZnU3aHdDZmJUUVdPMEd2?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <596C529BED4B8849BD99D20B493DD871@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3487240a-67bc-45aa-ba10-08ddc4d23c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 01:35:39.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zYb77eTL+fTEI6vj/vDSkMtFQOvRGkPtoU4Kzx2kD77SILj8dC+1dTLxGD2/MSG8zIZQk3CFVWkG6EWA2uqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6668

T24gV2VkLCAyMDI1LTA3LTE2IGF0IDE0OjE0ICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gT24gV2VkLCBKdWwgMTYsIDIwMjUgYXQgMTo0OeKAr1BNIFFp
IEhhbiA8aGFucWlAdml2by5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhpLCBBbWlyDQo+IA0KPiBI
aSBRaSwNCj4gDQo+ID4gSW4gdGhlIGNvbW1pdCBbMV0sIHBlcmZvcm1pbmcgcmVhZC93cml0ZSBv
cGVyYXRpb25zIHdpdGggRElSRUNUX0lPDQo+ID4gb24NCj4gPiBhIEZVU0UgZmlsZSBwYXRoIGRv
ZXMgbm90IHRyaWdnZXIgRlVTRSBwYXNzdGhyb3VnaC4gSSBhbSB1bmNsZWFyDQo+ID4gYWJvdXQN
Cj4gPiB0aGUgcmVhc29uIGJlaGluZCB0aGlzIGJlaGF2aW9yLiBJcyBpdCBwb3NzaWJsZSB0byBt
b2RpZnkgdGhlIGNhbGwNCj4gPiBzZXF1ZW5jZSB0byBzdXBwb3J0IHBhc3N0aHJvdWdoIGZvciBm
aWxlcyBvcGVuZWQgd2l0aCBESVJFQ1RfSU8/DQo+IA0KPiBBcmUgeW91IHRhbGtpbmcgYWJvdXQg
ZmlsZXMgb3BlbmVkIGJ5IHVzZXIgd2l0aCBPX0RJUkVDVCBvcg0KPiBmaWxlcyBvcGVuIGJ5IHNl
cnZlciB3aXRoIEZPUEVOX0RJUkVDVF9JTz8NCj4gDQo+IFRob3NlIGFyZSB0d28gZGlmZmVyZW50
IHRoaW5ncy4NCj4gSUlSQywgT19ESVJFQ1QgdG8gYSBiYWNraW5nIHBhc3N0aHJvdWdoIGZpbGUg
c2hvdWxkIGJlIHBvc3NpYmxlLg0KPiANCj4gPiBUaGFuayB5b3UhDQo+ID4gDQo+ID4gWzFdDQo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjA2MTQyNDUzLjE5MDYyNjgtNy1h
bWlyNzNpbEBnbWFpbC5jb20vDQo+ID4gDQo+ID4gUmVwb3J0ZWQtYnk6IExlaSBMaXUgPGxpdWxl
aS5yanB0QHZpdm8uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpIEhhbiA8aGFucWlAdml2by5j
b20+DQo+ID4gLS0tDQo+ID4gwqBmcy9mdXNlL2ZpbGUuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0K
PiA+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9maWxlLmMgYi9mcy9mdXNlL2ZpbGUuYw0KPiA+
IGluZGV4IDJkZGZiM2JiNjQ4My4uNjg5ZjllZTkzOGYxIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2Z1
c2UvZmlsZS5jDQo+ID4gKysrIGIvZnMvZnVzZS9maWxlLmMNCj4gPiBAQCAtMTcxMSwxMSArMTcx
MSwxMSBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX2ZpbGVfcmVhZF9pdGVyKHN0cnVjdA0KPiA+IGtp
b2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKnRvKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChG
VVNFX0lTX0RBWChpbm9kZSkpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBmdXNlX2RheF9yZWFkX2l0ZXIoaW9jYiwgdG8pOw0KPiA+IA0KPiA+IC3CoMKgwqDCoMKg
wqAgLyogRk9QRU5fRElSRUNUX0lPIG92ZXJyaWRlcyBGT1BFTl9QQVNTVEhST1VHSCAqLw0KPiA+
IC3CoMKgwqDCoMKgwqAgaWYgKGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fRElSRUNUX0lPKQ0KPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmdXNlX2RpcmVjdF9yZWFkX2l0
ZXIoaW9jYiwgdG8pOw0KPiA+IC3CoMKgwqDCoMKgwqAgZWxzZSBpZiAoZnVzZV9maWxlX3Bhc3N0
aHJvdWdoKGZmKSkNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBpZiAoZnVzZV9maWxlX3Bhc3N0
aHJvdWdoKGZmKSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZ1
c2VfcGFzc3Rocm91Z2hfcmVhZF9pdGVyKGlvY2IsIHRvKTsNCj4gPiArwqDCoMKgwqDCoMKgIGVs
c2UgaWYgKGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fRElSRUNUX0lPKQ0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmdXNlX2RpcmVjdF9yZWFkX2l0ZXIoaW9jYiwgdG8p
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgIGVsc2UNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGZ1c2VfY2FjaGVfcmVhZF9pdGVyKGlvY2IsIHRvKTsNCj4gPiDCoH0NCj4g
PiBAQCAtMTczMiwxMSArMTczMiwxMCBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX2ZpbGVfd3JpdGVf
aXRlcihzdHJ1Y3QNCj4gPiBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgIGlmIChGVVNFX0lTX0RBWChpbm9kZSkpDQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmdXNlX2RheF93cml0ZV9pdGVyKGlvY2IsIGZyb20p
Ow0KPiA+IA0KPiA+IC3CoMKgwqDCoMKgwqAgLyogRk9QRU5fRElSRUNUX0lPIG92ZXJyaWRlcyBG
T1BFTl9QQVNTVEhST1VHSCAqLw0KPiA+IC3CoMKgwqDCoMKgwqAgaWYgKGZmLT5vcGVuX2ZsYWdz
ICYgRk9QRU5fRElSRUNUX0lPKQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBmdXNlX2RpcmVjdF93cml0ZV9pdGVyKGlvY2IsIGZyb20pOw0KPiA+IC3CoMKgwqDCoMKg
wqAgZWxzZSBpZiAoZnVzZV9maWxlX3Bhc3N0aHJvdWdoKGZmKSkNCj4gPiArwqDCoMKgwqDCoMKg
IGlmIChmdXNlX2ZpbGVfcGFzc3Rocm91Z2goZmYpKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gZnVzZV9wYXNzdGhyb3VnaF93cml0ZV9pdGVyKGlvY2IsIGZyb20p
Ow0KPiA+ICvCoMKgwqDCoMKgwqAgZWxzZSBpZiAoZmYtPm9wZW5fZmxhZ3MgJiBGT1BFTl9ESVJF
Q1RfSU8pDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZ1c2VfZGly
ZWN0X3dyaXRlX2l0ZXIoaW9jYiwgZnJvbSk7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZWxzZQ0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZnVzZV9jYWNoZV93cml0ZV9p
dGVyKGlvY2IsIGZyb20pOw0KPiA+IMKgfQ0KPiA+IC0tDQo+IA0KPiBXaGVuIHNlcnZlciByZXF1
ZXN0cyB0byBvcGVuIGEgZmlsZSB3aXRoIEZPUEVOX0RJUkVDVF9JTywNCj4gaXQgYWZmZWN0cyBo
b3cgRlVTRV9SRUFEL0ZVU0VfV1JJVEUgcmVxdWVzdHMgYXJlIG1hZGUuDQo+IA0KPiBXaGVuIHNl
cnZlciByZXF1ZXN0cyB0byBvcGVuIGEgZmlsZSB3aXRoIEZPUEVOX1BBU1NUSFJPVUdILA0KPiBp
dCBtZWFucyB0aGF0IEZVU0VfUkVBRC9GVVNFX1dSSVRFIHJlcXVlc3RzIGFyZSBub3QgdG8gYmUN
Cj4gZXhwZWN0ZWQgYXQgYWxsLCBzbyB0aGVzZSB0d28gb3B0aW9ucyBhcmUgc29tZXdoYXQgY29u
ZmxpY3RpbmcuDQo+IA0KPiBUaGVyZWZvcmUsIEkgZG8gbm90IGtub3cgd2hhdCB5b3UgYWltIHRv
IGFjaGlldmUgYnkgeW91ciBwYXRjaC4NCj4gDQo+IEhvd2V2ZXIsIHBsZWFzZSBub3RlIHRoaXMg
Y29tbWVudCBpbiBpb21vZGUuYzoNCj4gwqAqIEEgY29tYmluYXRpb24gb2YgRk9QRU5fUEFTU1RI
Uk9VR0ggYW5kIEZPUEVOX0RJUkVDVF9JTw0KPiDCoMKgIG1lYW5zIHRoYXQgcmVhZC93cml0ZQ0K
PiDCoCogb3BlcmF0aW9ucyBnbyBkaXJlY3RseSB0byB0aGUgc2VydmVyLCBidXQgbW1hcCBpcyBk
b25lIG9uIHRoZQ0KPiBiYWNraW5nIGZpbGUuDQo+IA0KPiBTbyB0aGlzIGlzIGEgc3BlY2lhbCBt
b2RlIHRoYXQgdGhlIHNlcnZlciBjYW4gcmVxdWVzdCBpbiBvcmRlciB0byBkbw0KPiBwYXNzdGhy
b3VnaCBtbWFwIGJ1dCBzdGlsbCBzZW5kIEZVU0VfUkVBRC9GVVNFX1dSSVRFIHJlcXVlc3RzDQo+
IHRvIHRoZSBzZXJ2ZXIuDQoNCkhpIEFtaXIsDQoNCkluIG1vc3QgY2FzZXMsIHdoZW4gdXNpbmcg
cGFzc3Rocm91Z2gsIHRoZSBzZXJ2ZXIgc2hvdWxkbid0IHNldA0KRk9QRU5fRElSRUNUX0lPLCBz
aW5jZSB0aGVzZSB0d28gb3B0aW9ucyBhcmUgY29uY2VwdHVhbGx5IGNvbmZsaWN0aW5nLA0KdW5s
ZXNzIHRoZSBzZXJ2ZXIgc3BlY2lmaWNhbGx5IHdhbnRzIHRoaXMgc3BlY2lhbCBtb2RlIChwYXNz
dGhyb3VnaA0KbW1hcCBidXQgc3RpbGwgc2VuZCByL3cgcmVxdWVzdHMpLiBJcyB0aGF0IGNvcnJl
Y3Q/DQoNCkl0IGNhbiBiZSBjb25mdXNpbmcuIE1heWJlIHRoZSBkb2N1bWVudGF0aW9uIGNvdWxk
IGNsYXJpZnkgdGhpcyBzcGVjaWFsDQpjYXNlLCBvciB0aGUgcGFzc3Rocm91Z2ggZmxhZ3MgZm9y
IG1tYXAgYW5kIHIvdyBjb3VsZCBiZSBzZXBhcmF0ZS4uLg0KDQo+IA0KPiBXaGF0IGlzIHlvdXIg
dXNlIGNhc2U/IFdoYXQgYXJlIHlvdSB0cnlpbmcgdG8gYWNoaWV2ZSB0aGF0IGlzIG5vdA0KPiBj
dXJyZW50bHkgcG9zc2libGU/DQo+IA0KPiBUaGFua3MsDQo+IEFtaXIuDQo+IA0KDQpIaSBRaSwN
Cg0KSSBqdXN0IG5vdGljZSB0aGF0IEFuZHJvaWQncyBGdXNlRGFlbW9uIGRvZXNuJ3Qgc2VlbSB0
byByZWNvZ25pemUgdGhpcw0Kc3BlY2lhbCBtb2RlLiBJdCBzZXRzIGJvdGggRk9QRU5fRElSRUNU
X0lPIGFuZCBGT1BFTl9QQVNTVEhST1VHSCB3aGVuDQp0aGUgdXNlciBzZXRzIE9fRElSRUNUIGFu
ZCB0aGUgc2VydmVyIGhhcyBwYXNzdGhyb3VnaCBlbmFibGVkLg0KDQpJZiB0aGF0J3MgeW91ciBj
YXNlLCBJIHRoaW5rIEFuZHJvaWQgRnVzZURhZW1vbiBtYXkgbmVlZCBzb21lIGZpeGVzLg0KDQpC
ZXN0LA0KRWQgVHNhaS4NCg==

