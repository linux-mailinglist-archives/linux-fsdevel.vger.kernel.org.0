Return-Path: <linux-fsdevel+bounces-14174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA9878C52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 02:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901F72815A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0175684;
	Tue, 12 Mar 2024 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QM76/8q/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ksaiTs8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE644C79;
	Tue, 12 Mar 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207232; cv=fail; b=UTzh09+NyM/ZmR0NQTHi4a7Qo4mJqV8rfmFoTt5jwYrcuvkeHZUpba6cW+/BwsJqaIF9T9ibcUi5k3mG3347RAwe8XhC9nj3uV++qilohDYEOetR+EIF0CsXxjOswk5uI0rylIRUh+UWCDIxOUJ16BWrrMrA8md03tXgJe4Nf5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207232; c=relaxed/simple;
	bh=zANa2ayM++u2f+Y9UBFSvKV4FQQkCI866+rId6cPOW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bEMBcIlcWDR4jyYag06dkETejP4s8DeqtrdlNfpTzPngeGnElCb+Tb2vREoWS0PUr8QxG0dzeuyoAY993y2mRlvzmle7zRyvWmzYxsBupXlbIdbESRGLVNMkncro9RzM51e505Y8GivF4jHhsefksRfJvE5nS1/QZoItptR7Y18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QM76/8q/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ksaiTs8U; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 905fec10e01011eeb8927bc1f75efef4-20240312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zANa2ayM++u2f+Y9UBFSvKV4FQQkCI866+rId6cPOW8=;
	b=QM76/8q/Ja+AChjSyIVwYJmh0ABCM1/BoyEHF5NKVUoZeissebIFl3L5WlmqnNxYrEQMaEl2EEGQIn4OTGhkJt7KgbiTmJcRnh1cIQc7hFaROOj4PfAAhK+0rWQLICP0Ma5GTEJ00jCOPEdaggrzGyU6sLsbOdG6gR1jZscCF7o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:bc815a1b-c76e-40ff-824f-114a07132532,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:21e36181-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 905fec10e01011eeb8927bc1f75efef4-20240312
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 387127515; Tue, 12 Mar 2024 09:33:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Mar 2024 09:33:42 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Mar 2024 09:33:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSWtXYlt5tSSKox9b51FoeaJcBzz1Zdm8l1iGcC8zH67x0BFcfmK1qwo5x6CyNQhVsMcFRVcvyNzYeQIsCwIRycG4jM6lAR6ijTSPAwWizeU50QHzBTm1i94i4OC4JSb49z6DjBeckZ4cG/SCZSXc+NYfsHZwqH/yrETTkdGHh1AxaByXqnCcL26hX/fb38R7VO6g/zt/sFEE/3q2X65rtq38Qxfr8/QajrgGU5faSUKQvUTy6/+ioVqUJGHP0gC0NKZA4S5UFBQZguv2rESd0MAx1WJ+mqjTVBsDk6AGfLsJnRDEFEKmtOS/46MK2vvElk86DiVHQugI7P3+s5IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zANa2ayM++u2f+Y9UBFSvKV4FQQkCI866+rId6cPOW8=;
 b=ec1zIVCedsrwWDWKNB+e7uKW9GQ+bT3JzBI9kUIZtlqZRuR/p9T3WVnK7Bu302wM0PkhZ5ai5w999dNP7iw4jJ3af0gvu7sPfst9B3CfWNKyNHt5FyvdRarx6gZsPoyoYkcH7u4fj1bkgIBhOjzUp0nWllgIwLa6sSzvkOROIVd8XLM1c7kCRm3ACQRjfIJtdZFUMHJQu0iLXdvU+r/oKluE1vF+wgqtk7ty6GZ/7BjO9FVC3p2aadGpf38EpBimB0USx30p++uuIoejWy9tP0WyEJoiaWM0qtA9XdZ4i1C1xVsRDMbxFhTOkKSLeRFPwRT2k1eXfluZIdWpQ/aXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zANa2ayM++u2f+Y9UBFSvKV4FQQkCI866+rId6cPOW8=;
 b=ksaiTs8Ud69lEQhpEbEzIoNki+8em8hackEEKCHsqA8Bwg9h4MGrwd7AAZiB/N2QAJckEwYu+85nkk95UvU6o2FQjiSC1bQniTWGX10B+ijW+V2B0BczfClBJsqUhQpZhQkFth5svENa1mGlahvjsjGuUxbd3MMI0wlHo14C0vE=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 SI4PR03MB9204.apcprd03.prod.outlook.com (2603:1096:4:25c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 01:33:40 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::fc5c:c5f8:1c54:9ebf]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::fc5c:c5f8:1c54:9ebf%7]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 01:33:40 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "hdanton@sina.com"
	<hdanton@sina.com>
CC: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
	=?utf-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= <Freddy.Hsin@mediatek.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 f2fs_filemap_fault
Thread-Topic: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 f2fs_filemap_fault
Thread-Index: AQHaR5MBRVvJhmyJG0CiAY9rimhCqbDaxySAgFjkVIA=
Disposition-Notification-To: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?=
	<Ed.Tsai@mediatek.com>
Date: Tue, 12 Mar 2024 01:33:40 +0000
Message-ID: <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
References: <0000000000000b4e27060ef8694c@google.com>
	 <20240115120535.850-1-hdanton@sina.com>
In-Reply-To: <20240115120535.850-1-hdanton@sina.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|SI4PR03MB9204:EE_
x-ms-office365-filtering-correlation-id: 6eaf6ade-1290-410c-ac70-08dc42347248
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2Dx9VYHml/V/YDua8eqHfWZdcMpiaevyIB66FLx+8ojPDcA/lcCVxZV+8P9l+iQUOsebUink4uCdmI1xatXjxTUE6u9tgp59F2/TMl86a7BfFixjtnkMqJ1HpXtYSDPm5mFwElw4a5+DYY1VbqqP5zALo5FlbuA4zBWjCHRqcGOiFbeZRuNfwN5vPiG+hj9nc99EJz6M3vn3vY534z4AIYv5O/7tUKeapC/8HW/UIEnd47H6ei+/7En3aXJuzr2yoBVww0GVu40YekplUAgp1i38AmU1k44WK9pKhS8zOFoGo8dzU9FmNlmZ4VEcFh+ka3UTG0rjPIpgOLX10s6ZRsDCxWI+P91+QfYDfiuRAn8izcdCCstaZ8FU8tXSkaROpdx5+u/9riQOgwZcfA5NAzWY9v/2Wpj2jA58a6IXnWD2lrrjk4iXzgamrsA16m3pLtARgmSv+PFv63JEGvHygky7mWFhkLt1jkDmK/wjeGPhxQdgwmbaSUGYn+fxcUJpy2pdTX14T2Ou6jaU+LdArYo8/kmRvA3HEf7e5LzLvj2UfnhIUyXI6lpMjgK3BqYjCztyR5lr6AKGYlUdhLUplLu5Ec+5YfVy4pwZOGKOati9pAQ5k6OKaWCBj7raj8uS3fOmvcLN0EiDxb/JCgWfFfDxVRjw/QMkATr03t60QRQE3oljqH8sfvLhtcl3UTASDAYw17Del+Mwf8eCzyOiAUZwtP/u5cNB+zdF+wRhhs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGVHT215dXV0OVY3QkEyRFQ4Sms3MURjTUVKSGx6WkhraWlJazlzblpNSm5D?=
 =?utf-8?B?SVdNR3U2YnZXcks2QkZXbG9zem1RUndpVllMeTRsSHdJZG9wMlVUQ1NSOWZP?=
 =?utf-8?B?aldSTS9uOTIvN1RFVncyWWhjS3lvb29ia3NZT3JyYUIvb01DK0t4RVJXUkcv?=
 =?utf-8?B?WGdGRWpYK1RDNGIzUkFRSXNNVDFCV254TndKZjYzUURnSEY4WDdqRHpTWkZT?=
 =?utf-8?B?TCtDcHBwakFFdnlUT0NiTUZ3V2ZzRDdvdFEvT05tMXNWemhJVVRIeUhGUDF5?=
 =?utf-8?B?Y0FGeU9oQzBjbGZIakpWaWw5VVZ2RGp4Yi8yaUd5QmtleW5CcjFJbHY0V25v?=
 =?utf-8?B?OTdnVWN4T2Fka1dHTEZjenE2TVNtMFREdERCTjYvaEVuK0xkOHFkbkVFM3Fv?=
 =?utf-8?B?c0VHTkpOZUwvNGJsTHpCT2tyWCt0MDA3VEoxczN5OFprVWlHVDN1RTVickU0?=
 =?utf-8?B?MWJsNlpFRWVIVjdTbnkxK1dTZ1pRaUxLM2Mxd0RXWTAvakVJUm0wTTZ6MHhy?=
 =?utf-8?B?L3IyeSs0Qms1MWVOcTZpV1dSdDl2MTBabUZVb3g4Z0pJSE9tUEdISVlQQXZx?=
 =?utf-8?B?bjdUSllRS0FaeTdQMTIxWnRWSVpzWGNLVFUvdGNmdXhWSDNKZklLeHBnczZL?=
 =?utf-8?B?anFPTXB4WjluNWNTN2swWm52WEhab3R4eThtSHJvL1oxRndGRnNsQ2puZUVY?=
 =?utf-8?B?cmZ3ajNoK2hZZ1ZJbVZBV1hjNGtwZW1KY053WkNkbDhGTmVTWlM2bGxobmRn?=
 =?utf-8?B?QmpLRE9pcmREaDE3cWZmcWRLUThJSnlueWI0bkdHY3J3Ti9jNDJVNGtjbVpn?=
 =?utf-8?B?NmFyOG9DMmRRSHgxWFFlOGcvTTNMZTl0S2J4YmhpbVpzWEl2M29tbGhJWDNs?=
 =?utf-8?B?YTBuRktkQ3dJL0FWR2xoZGFoWDg5cFkvOGFxSDBYWGJ3dTVVKzREVXZtK21r?=
 =?utf-8?B?MjRwcFJsS2hTU0hvbkRRRVplL3U5dXFMNWNaUWgxeXM4dC92WlNTTDNTZy9v?=
 =?utf-8?B?UWhjSUtoNytsNndLT3RTTVZGVXJXZnpCNDIydWZLa0M2bkJ0bTJ4Q3c1djFa?=
 =?utf-8?B?NlI4QW96WUpQd2FjU24rNmR4Q2QyeUNiSmV4SXMxbFNMVmxoU1p1RDk5cjhw?=
 =?utf-8?B?VEpvb1RSQWltRDFHUkZ1Mjhka2Q3bzJCaUxCVHoyN1BBZkpkei95U1NpbEpO?=
 =?utf-8?B?eGIvdHlpSXlLSTlNc1dVTWVFOEwxNndub1ZQemk3OTdZWHpOb3NpVVVQc0lZ?=
 =?utf-8?B?dUhKaWhwNnlpWWFOdHZ3T2UyRlhITzUwV3c1UStJcHVsdmdZSlZ5bTQ0L21D?=
 =?utf-8?B?eUVqb01pb0hsMEhMU0dtUVlzcVQyLzJHN0duK2dYc0V0U1ZNZ1VFc3VuRlhw?=
 =?utf-8?B?WXgxaTN0Y0VlUFU2Sm9ubXBkemVVd0JENHBVNWJoOGVsck5kQnE1YTNyak1H?=
 =?utf-8?B?VHJKdVdxVkVwRi9LYS96L0hJeXpuRzg1Mno4cE5valpCYzhUL3JqOW1BOXcx?=
 =?utf-8?B?eTJsQnJJRjE1b3FhSXZwVUQ3QTczd1dGeUdpeFlhV0hBdHBTQTd2blpDaEh0?=
 =?utf-8?B?cnZHQjhRV0lqQlZSamErTnVsUjBKa1NlOEJUT3RicjJEOFFUaG5SZHRGdEhV?=
 =?utf-8?B?NzlpdHhWMENUNVBNanlKVk5GcG01ZzN2WnIrZytvNHV1aFFmSVF1Zyt3NzBY?=
 =?utf-8?B?MFlid2VGYjZwVGZpMkhISUVQZ1ZaOTRmR2pwcHRpWG53Myt4MXlXcnZFajJn?=
 =?utf-8?B?VzJQL1c5MldIa3AyVzdpTkVqOWdZdks1NDhoNzNDcjR6RlVZMVJFZlNrMUgz?=
 =?utf-8?B?eENud2VVR1Yvck5JTjJ4WHpKcWxMY29FTGlIc3BiVXgyTzVxdUtJRlBHb08r?=
 =?utf-8?B?dVc2TXlYTTRMajkrNUZKSHRSVExDTU5PSklxakNETjRzMkNiTStGOEhEY3RL?=
 =?utf-8?B?NG9NNVZoVDNnSW51MWVPRFAvRy9JcldoNitVaWtjMWxjaFNaTDdKcDVhSk54?=
 =?utf-8?B?SHlYa1BjNHpqdUZ1QURZSytybDBvVHNGRFk2Mk1paEhjUWNacjJueGdndWhr?=
 =?utf-8?B?QllzQWd6V3QyeFZ2NVdidVlSeWN0clFNZXdKQmJJSXcveFIvL01LSE03U1oy?=
 =?utf-8?Q?AjepmhWOSEvBk4Rygym8JnvFg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76CF917F4E53B74DA1C5C4289B12F15F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaf6ade-1290-410c-ac70-08dc42347248
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 01:33:40.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8hpPF+aZFZ3W2pzdwhMP0Q5gPr8bdmCzWJBL7T0rONqrreK1ySEtaortd8AcOpKKER20fIOEih0QIvzqYKNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR03MB9204
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.904800-8.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb480C8Dp8kkTtflY
	oV6p/cSxrKWVhE5vxYbDceU+QB8l9TRn2xdwrsXpzfqlpbtmcWjYP0VsOD0E/gzvg1/q1MH2sAf
	1c2yA4Sy4G/8PwEHazTs8CxsG6+jdcC92X+BT6RZIcJTn2HkqsaRagyMV8rderSR72b6g6bSRXS
	5OutA+Gfu1ukxNBkigJEWqPc0p2EpdleeOihB1yEIuDlf9E4HbcTTW0pvasBGbKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8C5G5ZK4Ai7+N0H8LFZNFG73Yq8RVaZivVaAvwS/F0yR8wZgkT415MZMd6y
	D2WfJ5QQFIYH8U1rDhKAhejuP4q7
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.904800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	98C591D65EE3968BCD05F7FCCF4A5C0DEBA7881772CA9D6D5DBB7D6152A5E7172000:8

T24gTW9uLCAyMDI0LTAxLTE1IGF0IDIwOjA1ICswODAwLCBIaWxsZiBEYW50b24gd3JvdGU6DQo+
IA0KPiAuLi4NCj4gDQo+IC0tLSB4L2ZzL2YyZnMvZmlsZS5jDQo+ICsrKyB5L2ZzL2YyZnMvZmls
ZS5jDQo+IEBAIC0zOSw2ICszOSw3IEBADQo+ICBzdGF0aWMgdm1fZmF1bHRfdCBmMmZzX2ZpbGVt
YXBfZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IGlu
b2RlICppbm9kZSA9IGZpbGVfaW5vZGUodm1mLT52bWEtPnZtX2ZpbGUpOw0KPiArICAgICAgIHZt
X2ZsYWdzX3QgZmxhZ3MgPSB2bWYtPnZtYS0+dm1fZmxhZ3M7DQo+ICAgICAgICAgdm1fZmF1bHRf
dCByZXQ7DQo+ICANCj4gICAgICAgICByZXQgPSBmaWxlbWFwX2ZhdWx0KHZtZik7DQo+IEBAIC00
Niw3ICs0Nyw3IEBAIHN0YXRpYyB2bV9mYXVsdF90IGYyZnNfZmlsZW1hcF9mYXVsdChzdHINCj4g
ICAgICAgICAgICAgICAgIGYyZnNfdXBkYXRlX2lvc3RhdChGMkZTX0lfU0IoaW5vZGUpLCBpbm9k
ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFQUF9NQVBQRURf
UkVBRF9JTywNCj4gRjJGU19CTEtTSVpFKTsNCj4gIA0KPiAtICAgICAgIHRyYWNlX2YyZnNfZmls
ZW1hcF9mYXVsdChpbm9kZSwgdm1mLT5wZ29mZiwgdm1mLT52bWEtDQo+ID52bV9mbGFncywgcmV0
KTsNCj4gKyAgICAgICB0cmFjZV9mMmZzX2ZpbGVtYXBfZmF1bHQoaW5vZGUsIHZtZi0+cGdvZmYs
IGZsYWdzLCByZXQpOw0KPiAgDQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gLS0NCg0K
SGkgSmFlZ2V1aywNCg0KV2UgcmVjZW50bHkgZW5jb3VudGVyZWQgdGhpcyBzbGFiZS11c2UtYWZ0
ZXItZnJlZSBpc3N1ZSBpbiBLQVNBTiBhcw0Kd2VsbC4gQ291bGQgeW91IHBsZWFzZSByZXZpZXcg
dGhlIHBhdGNoIGFib3ZlIGFuZCBtZXJnZSBpdCBpbnRvIGYyZnM/DQoNCkJlc3QsDQpFZA0KDQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NClsyOTE5NS4zNjk5NjRdW1QzMTcyMF0gQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0
ZXItZnJlZSBpbg0KZjJmc19maWxlbWFwX2ZhdWx0KzB4NTAvMHhlMA0KWzI5MTk1LjM3MDk3MV1b
VDMxNzIwXSBSZWFkIGF0IGFkZHIgZjdmZmZmODA0NTRlYmRlMCBieSB0YXNrIEFzeW5jVGFzaw0K
IzExLzMxNzIwDQpbMjkxOTUuMzcxODgxXVtUMzE3MjBdIFBvaW50ZXIgdGFnOiBbZjddLCBtZW1v
cnkgdGFnOiBbZjFdDQpbMjkxOTUuMzcyNTQ5XVtUMzE3MjBdIA0KWzI5MTk1LjM3MjgzOF1bVDMx
NzIwXSBDUFU6IDIgUElEOiAzMTcyMCBDb21tOiBBc3luY1Rhc2sgIzExIFRhaW50ZWQ6DQpHICAg
ICAgICBXICBPRSAgICAgIDYuNi4xNy1hbmRyb2lkMTUtMC1nY2I1YmE3MThhNTI1ICMxDQpbMjkx
OTUuMzc0ODYyXVtUMzE3MjBdIENhbGwgdHJhY2U6DQpbMjkxOTUuMzc1MjY4XVtUMzE3MjBdICBk
dW1wX2JhY2t0cmFjZSsweGVjLzB4MTM4DQpbMjkxOTUuMzc1ODQ4XVtUMzE3MjBdICBzaG93X3N0
YWNrKzB4MTgvMHgyNA0KWzI5MTk1LjM3NjM2NV1bVDMxNzIwXSAgZHVtcF9zdGFja19sdmwrMHg1
MC8weDZjDQpbMjkxOTUuMzc2OTQzXVtUMzE3MjBdICBwcmludF9yZXBvcnQrMHgxYjAvMHg3MTQN
ClsyOTE5NS4zNzc1MjBdW1QzMTcyMF0gIGthc2FuX3JlcG9ydCsweGM0LzB4MTI0DQpbMjkxOTUu
Mzc4MDc2XVtUMzE3MjBdICBfX2RvX2tlcm5lbF9mYXVsdCsweGI4LzB4MjZjDQpbMjkxOTUuMzc4
Njk0XVtUMzE3MjBdICBkb19iYWRfYXJlYSsweDMwLzB4ZGMNClsyOTE5NS4zNzkyMjZdW1QzMTcy
MF0gIGRvX3RhZ19jaGVja19mYXVsdCsweDIwLzB4MzQNClsyOTE5NS4zNzk4MzRdW1QzMTcyMF0g
IGRvX21lbV9hYm9ydCsweDU4LzB4MTA0DQpbMjkxOTUuMzgwMzg4XVtUMzE3MjBdICBlbDFfYWJv
cnQrMHgzYy8weDVjDQpbMjkxOTUuMzgwODk5XVtUMzE3MjBdICBlbDFoXzY0X3N5bmNfaGFuZGxl
cisweDU0LzB4OTANClsyOTE5NS4zODE1MjldW1QzMTcyMF0gIGVsMWhfNjRfc3luYysweDY4LzB4
NmMNClsyOTE5NS4zODIwNjldW1QzMTcyMF0gIGYyZnNfZmlsZW1hcF9mYXVsdCsweDUwLzB4ZTAN
ClsyOTE5NS4zODI2NzhdW1QzMTcyMF0gIF9fZG9fZmF1bHQrMHhjOC8weGZjDQpbMjkxOTUuMzgz
MjA5XVtUMzE3MjBdICBoYW5kbGVfbW1fZmF1bHQrMHhiNDQvMHgxMGM0DQpbMjkxOTUuMzgzODE2
XVtUMzE3MjBdICBkb19wYWdlX2ZhdWx0KzB4Mjk0LzB4NDhjDQpbMjkxOTUuMzg0Mzk1XVtUMzE3
MjBdICBkb190cmFuc2xhdGlvbl9mYXVsdCsweDM4LzB4NTQNClsyOTE5NS4zODUwMjNdW1QzMTcy
MF0gIGRvX21lbV9hYm9ydCsweDU4LzB4MTA0DQpbMjkxOTUuMzg1NTc3XVtUMzE3MjBdICBlbDBf
ZGErMHg0NC8weDc4DQpbMjkxOTUuMzg2MDU3XVtUMzE3MjBdICBlbDB0XzY0X3N5bmNfaGFuZGxl
cisweDk4LzB4YmMNClsyOTE5NS4zODY2ODhdW1QzMTcyMF0gIGVsMHRfNjRfc3luYysweDFhOC8w
eDFhYw0KWzI5MTk1LjM4NzI0OV1bVDMxNzIwXSANClsyOTE5NS4zODc1MzRdW1QzMTcyMF0gQWxs
b2NhdGVkIGJ5IHRhc2sgMTQ3ODQ6DQpbMjkxOTUuMzg4MDg1XVtUMzE3MjBdICBrYXNhbl9zYXZl
X3N0YWNrKzB4NDAvMHg3MA0KWzI5MTk1LjM4ODY3Ml1bVDMxNzIwXSAgc2F2ZV9zdGFja19pbmZv
KzB4MzQvMHgxMjgNClsyOTE5NS4zODkyNTldW1QzMTcyMF0gIGthc2FuX3NhdmVfYWxsb2NfaW5m
bysweDE0LzB4MjANClsyOTE5NS4zODk5MDFdW1QzMTcyMF0gIF9fa2FzYW5fc2xhYl9hbGxvYysw
eDE2OC8weDE3NA0KWzI5MTk1LjM5MDUzMF1bVDMxNzIwXSAgc2xhYl9wb3N0X2FsbG9jX2hvb2sr
MHg4OC8weDNhNA0KWzI5MTk1LjM5MTE2OF1bVDMxNzIwXSAga21lbV9jYWNoZV9hbGxvYysweDE4
Yy8weDJjOA0KWzI5MTk1LjM5MTc3MV1bVDMxNzIwXSAgdm1fYXJlYV9hbGxvYysweDJjLzB4ZTgN
ClsyOTE5NS4zOTIzMjddW1QzMTcyMF0gIG1tYXBfcmVnaW9uKzB4NDQwLzB4YTk0DQpbMjkxOTUu
MzkyODg4XVtUMzE3MjBdICBkb19tbWFwKzB4M2QwLzB4NTI0DQpbMjkxOTUuMzkzMzk5XVtUMzE3
MjBdICB2bV9tbWFwX3Bnb2ZmKzB4MWEwLzB4MWY4DQpbMjkxOTUuMzkzOTgwXVtUMzE3MjBdICBr
c3lzX21tYXBfcGdvZmYrMHg3OC8weGY0DQpbMjkxOTUuMzk0NTU3XVtUMzE3MjBdICBfX2FybTY0
X3N5c19tbWFwKzB4MzQvMHg0NA0KWzI5MTk1LjM5NTEzOF1bVDMxNzIwXSAgaW52b2tlX3N5c2Nh
bGwrMHg1OC8weDExNA0KWzI5MTk1LjM5NTcyN11bVDMxNzIwXSAgZWwwX3N2Y19jb21tb24rMHg4
MC8weGUwDQpbMjkxOTUuMzk2MjkyXVtUMzE3MjBdICBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KWzI5
MTk1LjM5NjgxMl1bVDMxNzIwXSAgZWwwX3N2YysweDM4LzB4NjgNClsyOTE5NS4zOTczMDJdW1Qz
MTcyMF0gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4NjgvMHhiYw0KWzI5MTk1LjM5NzkzMl1bVDMx
NzIwXSAgZWwwdF82NF9zeW5jKzB4MWE4LzB4MWFjDQpbMjkxOTUuMzk4NDkyXVtUMzE3MjBdIA0K
WzI5MTk1LjM5ODc3OF1bVDMxNzIwXSBGcmVlZCBieSB0YXNrIDA6DQpbMjkxOTUuMzk5MjQwXVtU
MzE3MjBdICBrYXNhbl9zYXZlX3N0YWNrKzB4NDAvMHg3MA0KWzI5MTk1LjM5OTgyNV1bVDMxNzIw
XSAgc2F2ZV9zdGFja19pbmZvKzB4MzQvMHgxMjgNClsyOTE5NS40MDA0MTJdW1QzMTcyMF0gIGth
c2FuX3NhdmVfZnJlZV9pbmZvKzB4MTgvMHgyOA0KWzI5MTk1LjQwMTA0M11bVDMxNzIwXSAgX19f
X2thc2FuX3NsYWJfZnJlZSsweDI1NC8weDI1Yw0KWzI5MTk1LjQwMTY4Ml1bVDMxNzIwXSAgX19r
YXNhbl9zbGFiX2ZyZWUrMHgxMC8weDIwDQpbMjkxOTUuNDAyMjc4XVtUMzE3MjBdICBzbGFiX2Zy
ZWVfZnJlZWxpc3RfaG9vaysweDE3NC8weDFlMA0KWzI5MTk1LjQwMjk2MV1bVDMxNzIwXSAga21l
bV9jYWNoZV9mcmVlKzB4YzQvMHgzNDgNClsyOTE5NS40MDM1NDRdW1QzMTcyMF0gIF9fdm1fYXJl
YV9mcmVlKzB4ODQvMHhhNA0KWzI5MTk1LjQwNDEwM11bVDMxNzIwXSAgdm1fYXJlYV9mcmVlX3Jj
dV9jYisweDEwLzB4MjANClsyOTE5NS40MDQ3MTldW1QzMTcyMF0gIHJjdV9kb19iYXRjaCsweDIx
NC8weDcyMA0KWzI5MTk1LjQwNTI4NF1bVDMxNzIwXSAgcmN1X2NvcmUrMHgxYjAvMHg0MDgNClsy
OTE5NS40MDU4MDBdW1QzMTcyMF0gIHJjdV9jb3JlX3NpKzB4MTAvMHgyMA0KWzI5MTk1LjQwNjM0
OF1bVDMxNzIwXSAgX19kb19zb2Z0aXJxKzB4MTIwLzB4M2Y0DQpbMjkxOTUuNDA2OTA3XVtUMzE3
MjBdIA0KWzI5MTk1LjQwNzE5MV1bVDMxNzIwXSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRv
IHRoZSBvYmplY3QgYXQNCmZmZmZmZjgwNDU0ZWJkYzANClsyOTE5NS40MDcxOTFdW1QzMTcyMF0g
IHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIHZtX2FyZWFfc3RydWN0IG9mDQpzaXplIDE3Ng0K
WzI5MTk1LjQwODk3OF1bVDMxNzIwXSBUaGUgYnVnZ3kgYWRkcmVzcyBpcyBsb2NhdGVkIDMyIGJ5
dGVzIGluc2lkZSBvZg0KWzI5MTk1LjQwODk3OF1bVDMxNzIwXSAgMTc2LWJ5dGUgcmVnaW9uIFtm
ZmZmZmY4MDQ1NGViZGMwLA0KZmZmZmZmODA0NTRlYmU3MCkNClsyOTE5NS40MTA2MjVdW1QzMTcy
MF0gDQpbMjkxOTUuNDEwOTExXVtUMzE3MjBdIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8g
dGhlIHBoeXNpY2FsIHBhZ2U6DQpbMjkxOTUuNDExNzA5XVtUMzE3MjBdIHBhZ2U6MDAwMDAwMDA1
OGYwZjJmMSByZWZjb3VudDoxIG1hcGNvdW50OjANCm1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBp
bmRleDoweDAgcGZuOjB4YzU0ZWINClsyOTE5NS40MTI5ODBdW1QzMTcyMF0gYW5vbiBmbGFnczoN
CjB4NDAwMDAwMDAwMDAwMDgwMChzbGFifHpvbmU9MXxrYXNhbnRhZz0weDApDQpbMjkxOTUuNDEz
ODgwXVtUMzE3MjBdIHBhZ2VfdHlwZTogMHhmZmZmZmZmZigpDQpbMjkxOTUuNDE0NDE4XVtUMzE3
MjBdIHJhdzogNDAwMDAwMDAwMDAwMDgwMCBmNmZmZmY4MDAyOTA0NTAwDQpmZmZmZmZmZTA3NmZj
OGMwIGRlYWQwMDAwMDAwMDAwMDcNClsyOTE5NS40MTU0ODhdW1QzMTcyMF0gcmF3OiAwMDAwMDAw
MDAwMDAwMDAwIDAwMDAwMDAwMDAxNzAwMTcNCjAwMDAwMDAxZmZmZmZmZmYgMDAwMDAwMDAwMDAw
MDAwMA0K

