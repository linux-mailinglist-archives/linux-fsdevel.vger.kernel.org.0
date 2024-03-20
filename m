Return-Path: <linux-fsdevel+bounces-14927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC3881A2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 00:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDC31F220EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5786158;
	Wed, 20 Mar 2024 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lj9W0WDe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qKwJBkEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C21E87E;
	Wed, 20 Mar 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977708; cv=fail; b=TXsm3cFsnosVb5EUWiEwt/QaVaaDa1HYRZicvS9QKOv/CLMwJcVNDiIZW64a/f4VckXwmJ8dj4Q6RzbjvSW8J8Zsp+GJumgsg9VOPETbJbQHh3oTAIzZ1GOXNZKR/w0lb9DqyIX07bqsKbDVjatR0VmumS5QGCg4phaeeKPioc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977708; c=relaxed/simple;
	bh=LrIjRE5WrkcJaDY9H/n+18TedX0i7+c/9Ep13znBW1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flmkan7KycxCXmG8A6/BirW24+310FWaqPfOLi3UgjM108IIYTFRXl/9nidTQ+ggacPxQp/CG3cy3QFXmmcLiWFPl0YrW118J8sjnaHOZV5dfx4y3qlHkTOta9sRE+SjTCLNXGuISsTM9nOhYN85jwErZy5neSAxM+mikL6Kffo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lj9W0WDe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qKwJBkEv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 75e459a8e71211ee935d6952f98a51a9-20240321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LrIjRE5WrkcJaDY9H/n+18TedX0i7+c/9Ep13znBW1o=;
	b=Lj9W0WDevSBRvPjxEIL0yNAUPXPCNJQZQyS7elXLbeJ/IT0MXqrC0O3rE/veANclEg5EuGK62GgQvZkI7H7S//uRcJsEHzfd/QjJkr1AnKFENc6BiZ4fiynaX33gKNrsOmUltUKKgBvrAznFmnX+sWtgm5MacfVzWwpBkMVCalc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b978fdb3-f207-4327-aa7a-4ea13a349786,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c5db2100-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 75e459a8e71211ee935d6952f98a51a9-20240321
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <light.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 332198604; Thu, 21 Mar 2024 07:34:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Mar 2024 07:34:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Mar 2024 07:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mARtRozq8XMcJQ9P4MteETfjXSvA7ZYt5ywX7uIoNRjOurppcyr28KK5te2tSmFXnn9JTnOxShYDYmKEToMmL1B/JKeDwDriQDloS5mfxdpkHlh+u8MlZgFONwY7LJZfO+mdXnAaqNClPFkkj+baNV+BzhLkIYjPmegoxWwQAWUBa8sJ7viVB3dsxzpENqsq1Ah+k3kvTG7GUUcBUR04nvUY7JnCzmhjdGrVbjosSs44bTPV2pHfR7SL0lmd8PtpzIpshwh1kZSqH+AaklNu0P77HB/W87boAAR2yVFS2o9LHah0gwNqjqhesPwsVWb3UMv0T8X9Kqbv6qS3LvQIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrIjRE5WrkcJaDY9H/n+18TedX0i7+c/9Ep13znBW1o=;
 b=hYZpE95di9Eism29b/zPcdlWLgV62dWDmyGXDj4WBwkF2rmRBiEdd+4zXOasqQrnj2YGZLhvqxKEikMm2IlCydr/XyqfCBh+fJ63i9U+wjJhOkd97vGPm/vxrSy5mEC61NXmCm9zK7JJUS9RDTjxg4Sr72kQmRujeKbe3Tn1YDCkYM7sYsNWvgoIgaPV7eVCVRJWRGzOTSC7mcXDTEgPfXXO2HiC8WVvgHpaRvrIsbiX7mwXRqmB4NGTLfqcoY+I48HQjGu4xr9n6LxbTFOXpCRHsbvMD/ssdGpz+U0WkGr9Tufmn77ZX3+Orw5xJgb+BqzXyuyq1qcCfSaRcv7ipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrIjRE5WrkcJaDY9H/n+18TedX0i7+c/9Ep13znBW1o=;
 b=qKwJBkEv07DHmRPvJSWkjldM1p/uNYeJPyNfa/xjpISmGzUVc/kkG5dHRa6rRdQ0Fag1smETZR9pJn+7hOoby3dan/rFiKdJBtY3n0J7lAfLwTVRzRoNj60x7+h8mc+uQhow3DFvy4RULoqsrvMgmPfrKOlMWOBBSpgPIlsGY3w=
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com (2603:1096:4:108::5) by
 SEYPR03MB7951.apcprd03.prod.outlook.com (2603:1096:101:177::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Wed, 20 Mar
 2024 23:34:53 +0000
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::7365:45a2:14a6:2f86]) by SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::7365:45a2:14a6:2f86%4]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 23:34:53 +0000
From: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>
Subject: =?utf-8?B?5Zue6KaGOiBmMmZzIEYyRlNfSU9DX1NIVVRET1dOIGhhbmcgaXNzdWU=?=
Thread-Topic: f2fs F2FS_IOC_SHUTDOWN hang issue
Thread-Index: AQHaeo7EDmoANqtclUCBOdbH5nMtdrFBDxQAgAA3ZS4=
Date: Wed, 20 Mar 2024 23:34:53 +0000
Message-ID: <SI2PR03MB526094D44AB0A536BD0D1F5B84332@SI2PR03MB5260.apcprd03.prod.outlook.com>
References: <0000000000000b4e27060ef8694c@google.com>
 <20240115120535.850-1-hdanton@sina.com>
 <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
 <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <ZftBxmBFmGCFg35I@google.com>
In-Reply-To: <ZftBxmBFmGCFg35I@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5260:EE_|SEYPR03MB7951:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rs1rdtDka0wZIPNYJG3saYbd4MsHx9q/ak1pdMnlnh2bpb12n0Euq5B6v7BXHHMSRtMkatK56w8WJAHTQ/Bw+GNndzZCM0LzFWoWqQvyZMtisL7QF8RezhOXyVGXujl6ODDbouRdKJlioo0JS99qXuqLOEGRWXkk1m1+qCyHQuEUtr59eEEH1q5nYCMa7hf3zmMeAtjmIdxgPhQM/AK+Q8LYM9sNYsGhET43TTtsAi3G42IcJTY/gmezAfhTVnuWutzKUsW7xt30Hg6kLghs7DMCJf7BJ1pkZc08UulRgMUeC0ibXEZIkwMqvKUolMEVAdA+O8/iqdrYOhfWlkzruD6TnIi2zywpXfyN9KYeiIGMrXdJTtYhj2w2Zi+RUMjwwzfehvh3dhiIpWJWxXAID6M2r5DyZmm6nanv+BpCA2dkHkeOoNJsNuWhEV7pXfXreB+aDc4iks1c1uYPpi4b147m30Bp/5K5s5FIyj4HnW3z3AZbh17FBBXfHWo1KRnbBbbYkv/VkzFmyHTe0zIRMKJbRbfBSomt5W851YCcyl5pYPwloAeLQNdTPTdcrW0RRiuioLoVP7dFcwbGw+H9U8oNR3rkeaCiYVVfM0hD44PFOLhlRsNLh6JxiMKG4RC1Wpemqo79SrtfXZtt56pFJf6ay19LV12/7QbbExECnjw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5260.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmlXUDVTb29IYlNCM1ZPQjR3c0ZnQU4wWERGOEY4OGdFa2VSNms0ekJvTWYw?=
 =?utf-8?B?UkpqQ1BMTk9lVWNBRjVTOUhadVBaTlR3aHVJY3NEckE5VDZCMFhaSFZxMVlZ?=
 =?utf-8?B?ckl0bVBwWWpFbmY4NnVRSFYxM0JBUmhwUFBnemlWNHNLbHFyMk01ZithUUI2?=
 =?utf-8?B?MHNJVE1UTlJZY2phWHFYTlFLQ2RveUdYK2VzS0Nna0twcmJuY005azFZdmU5?=
 =?utf-8?B?MHhEbysya1NuU29YVjNWSmkxeFNUL1NKOWtsN3JETFJLT2NDVVowNnZNZXNS?=
 =?utf-8?B?MnZueHVwSXAzdHluSFJCbUVxWDJvTjF5S3FmenNGVmJZcDYrdjFpM0VpRW9q?=
 =?utf-8?B?NWRqdXZvMHh0NGZTNzlBbkhieW5iUjZwRlMyblkvcjJsL2lMZ3JCdFRuUmJV?=
 =?utf-8?B?U3NnYlhLWFVvd1Z4RHBHL2pXeittRHJsR2JoZi91RHFrT1JVaHFJdnkxVy9N?=
 =?utf-8?B?eTh5RUc1OThkRmYwNmx6b2NjSGgyQWlWb2dEY0dxMmZ2RWFMNm9LZGhhMjIz?=
 =?utf-8?B?YmRTcVg4VksxKzVGZkc5R3IxREhhdDFjbUpmUUh4N1ZscW84K3A3R21UZmlx?=
 =?utf-8?B?a0dDSmdnRDluQWFtaHpDRS9jTWlpdWlXY1o5Zzl0ZDVjVldzZmVpY0JpSWx6?=
 =?utf-8?B?ZkJoUkFGL0MxZ2FPMjBnNm5XcHRrTGZHMmVXSWJYYWhhdytndzExdEtscTFw?=
 =?utf-8?B?YWhncURScGYxSld2VG8xbHgxRGQrcDBVcDgvZDRGN3JpL0lMRWNDTFBGRzRm?=
 =?utf-8?B?bXZrUkw1SVUwR2gzdUNxV0FKRExBZjEwSUl3dGVJMW1IaEVLNHR2RDRZNVhx?=
 =?utf-8?B?RVRlZzYwVmgySDFTRWtXWEljQ1p6VGpJQ0pETENLSVJhclFYVTRGOUI1Vksy?=
 =?utf-8?B?QUlSbmx2a3JndmxPNTVIb0FscDZWMENCcHpaQ2JoK0dyZlNSTVYyR3dlYUU2?=
 =?utf-8?B?VVNKVEpHNHhIUTV3cGx0ZkYzZ1doWU9yYzZtNVpOM0s4ZVFhaElNdHp1YmhR?=
 =?utf-8?B?TDhqSlRaUm0ySmF0cEo3em5EbzNGcUhvcFAyVG54SzFZaTJyR001UG5YSTNY?=
 =?utf-8?B?aWdHSDJQMk15RmNMYmRxR0taZTd3SnFUaU1zNVFQMXlnOTVmR3diVzVZdWZo?=
 =?utf-8?B?L3ZLanQwVkRUOVlVa1A0bXJJUVcxS2tTV1VGRjNVTUErWmp4ZStlNlUxK0Zw?=
 =?utf-8?B?YWhCNWxCTWN2ZVJjcTBSNG5RMklBY0dSRDhLSUhaMEFmWFI0eEdKbldCQ3ZG?=
 =?utf-8?B?SWRqckFKOWIwRjIrSXRLWWgzWXdHNW0wZ1lBa2prVHowc2x4cndXdVhxUmdt?=
 =?utf-8?B?WGZyMEFUM0xVRGg5eUg4UWxFU1NTcytpUWtab1Fyb3pScEhHN2VkMUhsVWhj?=
 =?utf-8?B?S2sreTk2Tjk0bzE2ZTlGeFpJQTBmd2txYUJzeVp4VHhzRVlQOExrN2VxVFJB?=
 =?utf-8?B?K2FUWHNyYnlGSFh5WmRjME1rVm05NEZ6M3FueE9MWlhSSTNBTWJOVmNkdm5E?=
 =?utf-8?B?WXZvSU5meXRtcHpvUVFZYjhZU0VIT3ZyaDF3NU44Q2tLL3RocWtObjFoOFFO?=
 =?utf-8?B?dUg4eFZBTUNKVjRiVU1IdGpxY1FJZFo0dXJYZ1VXdm4xVURFMGpYOVUyWEtw?=
 =?utf-8?B?QUFwSTlVdlpzakkwaDVNWEF4d2VBV21NZUh5eGdUbEc5b1hEOHYzNzduSnNW?=
 =?utf-8?B?cEhPR1F6Z3U1c1V3cmhjM1V4bDBXdXlnNmVvM1BZWlQ1MUp5c2ZoNVdIbWRO?=
 =?utf-8?B?akU1Tk9qd3FMaGpoYTFSclgzT05ndVJBc285ZG5WckNIL2JtUDhqNGZpOHo3?=
 =?utf-8?B?eE9xSHpjK25ibDljOWs3NGtsWFpReEl4MnFvMWVxeG94K2IzNmh6ekNoeWUw?=
 =?utf-8?B?c1E2NW5SZHM1TVo3dFhhREk0UHF0VU95RENhYzNWMTBkUGpsVjdSNlF1ZStJ?=
 =?utf-8?B?dmR2K3JwZzgxSDY4TzJRd2ZJQldrWmdVU0poWkR2YlNzUFlmM3JzTzQ0dGto?=
 =?utf-8?B?eDR2VVk1ejJnWHZEU1JEZzJyN1JwczRvaE4xb2ljSW1TWVJiWEdKSy9FWXl6?=
 =?utf-8?B?SHpieWxpdG5YM2JTUzZBUjd4WENqeXFhWitWbTFhM2RrNldDempQNFNtOTV4?=
 =?utf-8?Q?4EEJJdUV/dglxsZoD+A3WvsFH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5260.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42fdf34-02aa-4678-bc89-08dc4936580c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 23:34:53.4019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfnzQJLyehlHPPkjQrLwfDGtRK7G2DCnY2+k7T1qJsXOREA/aUooxVLVdarJ4ZIZgSwWZres1j1Cr0yTCcg84H4v3m6iO4hFOchbXS8kAZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7951

T24gMjAyNC8zLzIwIDg6MTQsIEphZWdldWsgS2ltIHdyb3RlOgo+IGYyZnNfaW9jX3NodXRkb3du
KEYyRlNfR09JTkdfRE9XTl9OT1NZTkMpIMKgaXNzdWVfZGlzY2FyZF90aHJlYWQKPiDCoCAtIG1u
dF93YW50X3dyaXRlX2ZpbGUoKQo+IMKgIMKgIC0gc2Jfc3RhcnRfd3JpdGUoU0JfRlJFRVpFX1dS
SVRFKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIC0gc2Jfc3RhcnRfaW50d3JpdGUoU0JfRlJFRVpFX0ZTKTsKPiDC
oCAtIGYyZnNfc3RvcF9jaGVja3BvaW50KHNiaSwgZmFsc2UsIMKgIMKgIMKgIMKgIMKgIMKgOiB3
YWl0aW5nCj4gwqAgwqAgwqBTVE9QX0NQX1JFQVNPTl9TSFVURE9XTik7Cj4gwqAgLSBmMmZzX3N0
b3BfZGlzY2FyZF90aHJlYWQoc2JpKTsKPiDCoCDCoCAtIGt0aHJlYWRfc3RvcCgpCj4gwqAgwqAg
wqAgOiB3YWl0aW5nCj4gCj4gwqAgLSBtbnRfZHJvcF93cml0ZV9maWxlKGZpbHApOwo+IAo+IFNp
Z25lZC1vZmYtYnk6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+CgpUaGUgY2FzZSBJ
IGVuY291bnRlciBpcyBmMmZzX2ljX3NodXRkb3duIHdpdGggYXJnwqAgRjJGU19HT0lOR19ET1dO
X0ZVTExTWU5DLCBub3TCoCBGMkZTX0dPSU5HX0RPV05fTk9TWU5DLgoKT3IgeW91IGFyZSBtZWFu
aW5nIHRoYXQ6IGJlc2lkZXMgdGhlIGtlcm5lbCBwYXRjaCwgSSBuZWVkIHRvIGNoYW5nZSB0aGUg
aW52b2tlZCBGMkZTX0lPQ19TSFVURE9XTsKgdG8gdXNlIGFyZyBGMkZTX0dPSU5HX0RPV05fTk9T
WU5DPwoKCgo=

