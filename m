Return-Path: <linux-fsdevel+bounces-72429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ACFCF70B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51CED3050182
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B123093CB;
	Tue,  6 Jan 2026 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="OFxedHjw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4030AD02;
	Tue,  6 Jan 2026 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684778; cv=fail; b=kKWFTIn3gOkgKYNe2qBCchcrBE/TExcnXMDl9yQFvra1w4dnFLdEgE6ECVs4FL04mv64sqXOQBORsbZaKNzaMrg2D45oW0rocx6eB+gyCXTIgpLWYPUfA4/q4bOPdNkQdhsco8HquMTGe5D5ROOhIq5FXsR0ZsOsfbmpGLJm8ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684778; c=relaxed/simple;
	bh=6QZRZhOauFVkV3XIjGEU3Gbyjh0fz8uu8mmzAUmIBTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkqNthlGbARzgQTO9tYYdmd67zerd6ZhwbBBap9du2s1wd7JXD7BVtpn/LDbVr5X3EjM4Av/I162790+QK2qyiJXxfkejrrBv+gpEFvqiWNevyXHUYlFUOl3/ukdQWhXAz1PK2ztMTVlYXKpUo07+2v61WBdDgVg7KFLONNtXvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=OFxedHjw; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605N1JsE006656;
	Tue, 6 Jan 2026 07:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=UqCCoqM
	O7j/akXqCBfuBlhzG9u84XjtTxdqfD2OQdxw=; b=OFxedHjwqMeiA6t3pVouDPI
	EiRhj9kC564I545SoyiownzKEmtX3j+ZUWaBLk2hdb/ZT5wKxJtMa3qDWk4SCTai
	51DSo8YDfe4q98yUFa6vE5SlpbSA3zwkk6I+pA57SXO2R2U9wcGc+hBXW/HUsd8h
	zzxZNlYZG17DEjwugozUw5Cdwwu8IR0HXTiu3aEtZ4vzR09NFLf95btYZgwMAlsN
	eIyGNTnx85sx+IB6xFjTHB/vZlF5zx8Z0zeXqjw6eq3lUanyH/nrP0ABT9R4piJd
	blqoPb0ajueTCALv7gSGCP9yh/DIC22GxDUp6wGCwCSG+F4jJaUV7JSfnCf9+Mw=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012040.outbound.protection.outlook.com [40.107.75.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4bes0g325j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 07:32:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzN9RoFO3eBpSRXstpOjLi1737n8Ok0nsaZejiSjSTntWdp8nSjkPNxusDn9D7OwMEJoC6wC4rBVZd9rZKvWI+zM9R9iNsOgz19GZntIVOFiOkrH9xsAIiWGcnO5yWqgAW4eB1/+P+UKVwGZLactbmsTuwZc/ataSN5LND5g9Nvw7ngufNRfcOy6E1UZeD0mj8BpnsnRu2Ir5ExNUyYwnWlzMscv5C2h/9JpQ1FmeYLPn3Wr1H0KZktEnJlXrePI5SLoGWlXIUyJeqgvDLtGTpRFwv6UHimmYoFp1bp5kCllrH7QsM9fymINCJLVPFbwfg3g/jlu8q300MEsGo0q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqCCoqMO7j/akXqCBfuBlhzG9u84XjtTxdqfD2OQdxw=;
 b=XAA8bIHa8+3QKuqpZEuGlGZosuQ3HSErct0vyQD8KkpKyIbkI9BiqlK5mVOhu+9kopxU1E++tR0fV2ACkQSiWMG0hRmzCmWskTi911Ko/YksY/OG5t9wwyMfZPIJ584dGH5uYRt72ULxAgJ0vkByf+KcMnjLWnEHKXchbnMJXEE4szY3QQbo4v4Adkpiycmgr4mz9kW3cGNLH2bQvuwCXPQ2vLMVnA35B56zTaW0B6tNpBe33oR+mFJZgLZBG5YMEQq8/u7vJ4ulaeMdmAg3JCD1JIiq0tXNqAZ23FQdKrH7DN4ZqX1hL+elKxRs+fFrYnv3T2dS3+UNbNJIrH2xXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB7264.apcprd04.prod.outlook.com (2603:1096:101:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 07:32:09 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%5]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 07:32:09 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Chi Zhiling <chizhiling@163.com>
CC: "brauner@kernel.org" <brauner@kernel.org>,
        "chizhiling@kylinos.cn"
	<chizhiling@kylinos.cn>,
        "jack@suse.cz" <jack@suse.cz>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v1 9/9] exfat: support multi-cluster for exfat_get_cluster
Thread-Topic: [PATCH v1 9/9] exfat: support multi-cluster for
 exfat_get_cluster
Thread-Index: AQHceWR4L2gswImwWE6uvNkpmwBpsbU7CWKAgAaVBPeAAU01gIABwDPC
Date: Tue, 6 Jan 2026 07:32:08 +0000
Message-ID:
 <PUZPR04MB63162C265F7C0CB87E6457988187A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <PUZPR04MB6316194114D39A6505BA45A381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <d832364d-02e6-458d-9eb2-442e1452a0f9@163.com>
 <PUZPR04MB631627BD83F409B370337E4D81B9A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <eb265ced-5694-4bf8-884c-b188a670d796@163.com>
In-Reply-To: <eb265ced-5694-4bf8-884c-b188a670d796@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB7264:EE_
x-ms-office365-filtering-correlation-id: 91d647cf-5b8f-4aad-209f-08de4cf5b322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Sa7dANQ8FnKD645ApBjdrxHUij0wzfApVvyOa4UOfE52XN8Linnwk9X0m+?=
 =?iso-8859-1?Q?E0xdVkJ1+mGcmLpJOWxLOd/oBjiGMUs+Be5JSqRXn8c+HyqQV4yqnYNfZM?=
 =?iso-8859-1?Q?uPK8DU3Ka0S8qiDONZY3Gv+jluaBD4O6EgY9un7+t7Rlzgfr71VQxyS5ok?=
 =?iso-8859-1?Q?NdvQo8EvhAjBZFQMu+CQ3QWaVblXaS9pDTXY6avxw0kpwRy9REheBzLH3b?=
 =?iso-8859-1?Q?go+Yn45El40fYR5qtCYM98Nbxb6n+6pbLhaaIX4FY31czeEI+bHu8uArLI?=
 =?iso-8859-1?Q?iCYHBMkAXFVcZ32qPwyQwWdv1R9s7fqY/9mPF1DHcHakcdvvQACKNd+zaX?=
 =?iso-8859-1?Q?B43ISkJm17JaDhm5lcxcYCf9V5phLVKUae9zlWHWIXe+55X9zAQWV29+SJ?=
 =?iso-8859-1?Q?aPBZ4FwC6ofxz5fTffRsSgWHaZ1r74hex4AHxpCSraxSUoAzP5JfCm7RTO?=
 =?iso-8859-1?Q?I7641MgZ0tL3A8cjK+3MzbcznsFlzxx/p1oTkMim0qC+7zhCarerKi+V6f?=
 =?iso-8859-1?Q?Ca32t+qhhjG/MWZbLJlsoyO0CDCQwfwnAga9+zcGL2tSIUcTwfy/e5mB6T?=
 =?iso-8859-1?Q?EPo7Dop8uwnlHLuzUHjsqfQeI7mkshZlOxsT8kyNVGS5nEbEZjCpea1kjc?=
 =?iso-8859-1?Q?oUHEPhCfMPrcNHVV/ymftAqPgMDG/RI+pftTYiK3yh41R4hY+lwyKcFYd7?=
 =?iso-8859-1?Q?4PX0D0OiPisvnE1VzGY7eMJNzDa0gLz3M+DOIEJ3dWl4zp2ZntGiL5Q+r+?=
 =?iso-8859-1?Q?D5fADYCdc9nt9OwNhDkN57Yk4CLX6oryFSd6m719Zc81RaS6C7QWVYP9J9?=
 =?iso-8859-1?Q?+ocReqgMD/B6A9+HFUap79YUDX8/9vISSroSgAClrnOG3Ag70xZ3q8h2YQ?=
 =?iso-8859-1?Q?B4vBajHLsdTuZFqiStStVJ67aD5hwU9t2APE9tTMsv/Qct2JO89fi+lnd1?=
 =?iso-8859-1?Q?jneGfn9zUegfH8iTkB7gk5E9rqjyblIhCz1Hjke0Iq/vOjG+83+Thc39+8?=
 =?iso-8859-1?Q?RqDt4LiYiZGkIC4OWMCXCMXpcrxCg2dCNmOrPG3l9TJ9QTj0zTFzumedaQ?=
 =?iso-8859-1?Q?dYnFU8ibC9kx0dJ56jo5IAx2VFMLbExAMqSncDskoeRZgHNCS5+UJFw6te?=
 =?iso-8859-1?Q?g6nO5PNUH1zMAWOzTsXcarARCQ62Pc/6sOyl8XqmDSdHX6yRVEQ5Fk2rZa?=
 =?iso-8859-1?Q?5yLrb3B05MJaTgY34ndsXgPRwbU0r2N1u/8I98aVOTP6EudYsp264XcELZ?=
 =?iso-8859-1?Q?tkh/HKidEEg3oq2GhLp9AeqhJU6P5KF8ucrTM99ajutUox6gsHrXvasz2r?=
 =?iso-8859-1?Q?trjZsSd/RfzhO5FkIDnID1qN6+cAyWujWAio+x6u7ykxJoPD/fHQN7X3VW?=
 =?iso-8859-1?Q?E/AeaVatVvqIo8OkhcCXgIvLiXOpeDIFbZw/UWsfopuokihv1iGIsUOdn3?=
 =?iso-8859-1?Q?XrbKBQn/S6gsoirqYJYGhvOyd1dIQkDljVbBGTSwQif8tMYPUBisr3aI74?=
 =?iso-8859-1?Q?J9MWU0VSiVH0pKYuEPDnJP9BHnLpKNeVmjujv4gpJVZoQzG9kPI16be6D/?=
 =?iso-8859-1?Q?zs6iUgpNB9btt3IiqhLIvgR4btaj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QWEGS04BDntt4OHtCQf0g1RbEk67JN/cj4vDQb226FuBjoJkEZ78LaNW6Z?=
 =?iso-8859-1?Q?/rGESeaOElzlWN1yIwoo28FHYp2em3LyBAkRSIeiHv9rkkZmSvV8LSSMS1?=
 =?iso-8859-1?Q?f75FRm54jhFxPK99HAd7Umrp7VEk1TjVxrsXk+K3qDny86XF3GdgyivyqU?=
 =?iso-8859-1?Q?Sk14sZLHkp3XjnubKttrcUvm0vWuM7i4UFWS4/iKgzIiT4Z/pxAw8f3P6w?=
 =?iso-8859-1?Q?n/IWEfQ79o3xn8lO+Muc2jFlDp+uAsSEyXifRHAopF9K/ovxrRk1uFihuW?=
 =?iso-8859-1?Q?Ex9vwu+JJtDNRL5pqBxrf/SHUlanAgOZpltkYsRDegPB6GT5eHCJK+q7Br?=
 =?iso-8859-1?Q?CB0VTamWsdOze6d2euz+Av+tiVth4avDOjMvVlEo6Z1y5mhytyeFXmTDu4?=
 =?iso-8859-1?Q?l+F5afuPzfVlC65NrPHQltYpkPK86DgoYRYl6T7FKe+IknaHLM6SG8Qb2t?=
 =?iso-8859-1?Q?EW944D9Mdv42P1AfFAPdgu3MZc05yeyVWcfB/cC+yuvfRQrxdD58ulXBDR?=
 =?iso-8859-1?Q?btu82g7gaIrhyzQImVz88uBZyPk9/JH1hOpIcHAbVHUr9VkxmLuTSnivM4?=
 =?iso-8859-1?Q?ab1kk6WeVXP+b0iHgBwq8NDMWZgobF2uLfjeUU4Zt2RQzDYCSPhw3DvZqn?=
 =?iso-8859-1?Q?Y6GwVAxX3jULHgTYWj70c34irloXPR6Csz80zPhVYsyrHtN0MCULPczO73?=
 =?iso-8859-1?Q?FfIYB6BdJegJkWOXee1b+wfS+3hogNkXXCji9vPHh6QvtUOC/jhnvzZHfC?=
 =?iso-8859-1?Q?BKQGgtEEtKUAz1mwjVmSR0OjlRCebud3WHtKRbDmmUFJrIIYkzCPRX/azB?=
 =?iso-8859-1?Q?ynmieEO5xLkkMzBCn+SvicaWwtZGES9JUaxs30iWIM7xlqWxTYiRDgKnv3?=
 =?iso-8859-1?Q?MFWhdCMJBUBrcgu1Fr/rPG3JIgTfUFIHBaDf9Nk8wgN+FtcpRDIrYx61GN?=
 =?iso-8859-1?Q?XqYzzc1NNTUQNJDIY3j28C0lW4uiZIjt9SW4GySlAPloF2xW4vV6/ldUSw?=
 =?iso-8859-1?Q?AK8UT7lH51S3zcVSazmcO76gcRMoEpL1JeaPRZCxkgRJZhT2Y/X0aElRBt?=
 =?iso-8859-1?Q?x/Tm02Tutk0dkUI570sXr61Hwj/U3iC8etor+eTziWZbfm3usHKwITEt60?=
 =?iso-8859-1?Q?RO1fICTjAgkxNXt/mtUPvyKDX8cQO++r3dGjylmX1wkje/ckQfX8IIV6ri?=
 =?iso-8859-1?Q?akNBRvNu9Neh3RrhRUENrfpioV22lKwTzjcYuafQkpBnNjKLUsqiHk+4vk?=
 =?iso-8859-1?Q?Xc2FP196h4ZKXzQcLsz96aUji4hY0N4jKULoXbxpsoFYuGBf/UTClGJy6w?=
 =?iso-8859-1?Q?OF1KdVsU3EvzjCjRBvZqgjje0H88MIGzhRzlzDsbhPVEtrV9w3BWAk7F8s?=
 =?iso-8859-1?Q?RWsHlCU41QqyrpVZJHdZk+xGK6tfw9NnmHyE/x7DKF9rpN/0VgkicvxRgX?=
 =?iso-8859-1?Q?AVqLoHJHGLz+NDgXQk2FKyUyNfg0U5ZDn87LarMTYbZNas6TWqJtQn6trt?=
 =?iso-8859-1?Q?HMFlJGgEXaoF3au0zzsDwFZmkJj9SDIb11MQxkprh24mBfS491ForjpEnI?=
 =?iso-8859-1?Q?c6fs+aXfnus/VEpoNk6u8hEp1BGznUOVUGt+R5gr3j4c0CZoSVxHS2YgzO?=
 =?iso-8859-1?Q?t++yC/0axnOrmy6UG4ytnYMOA7rHFAxmgbBoJhVhF5xoy3gIdalt4RMhp3?=
 =?iso-8859-1?Q?h3PkVk0XFZucy3tr8Aj5H1BdAqBL1Ou8+tqy8/cwNezGAzcLLU8GfiODsQ?=
 =?iso-8859-1?Q?Ap5sIYw2Xa029G/0IkQ6yybi+Mr5YOA6djH37x9pm+6JCCKQYcgFmWndBO?=
 =?iso-8859-1?Q?MoJ8YA6OzQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aWCzSeB2qVlRzxexHWIHMElj52LVfFyITEcl6HLmBpmojg/c3YIf4B6ZnhJTbzKX0uq9H05u7d1Raln1oXA8/P3OgaXFq6paHUXmz89yTRKIMZKX31qDbwCS2CwjuRRGINcRIxdIr+ir0fCNPYfeTeEC2f0ikMr0ak/H/BlHdbx/8vkzgr33ZDZsCujErVK9UOWlAYritODL6H1YwBfcex43d0NAXQBYEHC1IUoe3tBnSHsEBGW5l01NMGcRqS504nQ02q8qiqov7NmjpCH81pjWLRuyxzsOZkfFqi3fKe8mzK6UFbq0jphD6IHhkFPHv2rhnnBzZU5hBo3bqRt0rihZ2exwbIf/UEq+YujgPkardum/VwLcR053MGf/dmQvYFvaCfw6z3yFz6A3/cBftu5sS7QAYtoddSgXnqLEtoHYt+mC1F1hV7ITNYU2SQdAWoiNt5XJEpRGm6JE6+zL2x5yx/aTa+faBCVYrHFvkKo28edgoRxgQl/9rlH0IEmjd/yQgx/tZyu0+dtpN4hvVA+yZnNm5moK/yt8E0S3/Hw4nIDtQfWJxQFB9Hu9PVGeubNJ7zwVkADv65mhIBzNxOSqGjEL39k6fmi6aqQju1pvCdbbUeNplE1A1gB8gtz6
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d647cf-5b8f-4aad-209f-08de4cf5b322
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 07:32:08.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opwdgK3aR21Nl3jLpPRiJgEUtH6CvntVWT2EN484HnzvB6U1oj2+i2Mfz8Rd2wcolxhHJ+pJ8BTngNHfmBGaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7264
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA2MiBTYWx0ZWRfX/m6uloLBxeT+ UrHs77QCK8Zl0h8F56wQjcDteB8GOaYPaCis46ykSGWxUh9edhCPdCv2+8BGwXWwvzGcZzpZCXz 2+buUmwryD2neizBrkSf3dcs0ZJGj39IcG9fFIFORHB5rw7NzD4Yof5FEWBNrpUVFeTXTBhZCTx
 1Ac0UOxHGrvNtlihZHK5afFz4q48rND/EYY0ZKMI0KIqeLS7dKeunOYgTD3Pd7Enr8u0kLm5qZ3 zc9RBVK00Khs59hE/mhcDE/DYsL5IjyGxZ/CUe5mTxEZxKSjEQcjtdOa/xWC1eKMQ9sP+XPl3TW a6XKGcOar1DiMTZ7LN9o5+0nHn0caCYVK7PK5tscYMN8DLi4pzdnKHAHE2V+ufmJ0+2IMR57ILM
 9SpDOyw45ncfOOhQVT5k2LCTAhi5G1bVA9VbSRc+FQEhF7iUpAvhcdMhRiJNiNf4oHLgyPn21Xg fyEXWAfRWW8mB35qRdQ==
X-Proofpoint-ORIG-GUID: zXw6ZPJPGgtsdEJhvvwdSxNmfojwYWOI
X-Authority-Analysis: v=2.4 cv=Pt2ergM3 c=1 sm=1 tr=0 ts=695cba7e cx=c_pps a=jqpHywuIAYjcho0ATFeEVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=7j0FZ4iXMVMA:10
 a=xR56lInIT_wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=z6gsHLkEAAAA:8 a=eslVn6od-_ngXIrWYcgA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: zXw6ZPJPGgtsdEJhvvwdSxNmfojwYWOI
X-Sony-Outbound-GUID: zXw6ZPJPGgtsdEJhvvwdSxNmfojwYWOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

> On 1/4/26 15:56, Yuezhang.Mo@sony.com wrote:=0A=
>>> On 12/30/25 17:06, Yuezhang.Mo@sony.com wrote:=0A=
>>>>> +     /*=0A=
>>>>> +      * Return on cache hit to keep the code simple.=0A=
>>>>> +      */=0A=
>>>>> +     if (fclus =3D=3D cluster) {=0A=
>>>>> +             *count =3D cid.fcluster + cid.nr_contig - fclus + 1;=0A=
>>>>>                 return 0;=0A=
>>>>=0A=
>>>> If 'cid.fcluster + cid.nr_contig - fclus + 1 < *count', how about cont=
inuing to collect clusters?=0A=
>>>> The following clusters may be continuous.=0A=
>>>=0A=
>>> I'm glad you noticed this detail. It is necessary to explain this and=
=0A=
>>> update it in the code comments.=0A=
>>>=0A=
>>> The main reason why I didn't continue the collection was that the=0A=
>>> subsequent clusters might also exist in the cache. This requires us to=
=0A=
>>> search the cache again to confirm this, and this action might introduce=
=0A=
>>> additional performance overhead.=0A=
>>>=0A=
>>> I think we can continue to collect, but we need to check the cache=0A=
>>> before doing so.=0A=
>>>=0A=
>>=0A=
>> So we also need to check the cache in the following, right?=0A=
>=0A=
> Uh, I don't think it's necessary in here, because these clusters won't=0A=
> exist in the cache.=0A=
> =0A=
> In the cache_lru, all exfat_cache start from non-continuous clusters.=0A=
> This is because exfat_get_cluster adds consecutive clusters to the cache=
=0A=
> from left to right, which means that the left side of all caches is=0A=
> non-continuous.=0A=
> =0A=
> For instance, if a file contains two extents,  [0,30] and [31,60], then=
=0A=
> exfat_cache must start at either 0 or 31, right?=0A=
> =0A=
> When we have found a cache is [31, 45], then there won't be [41, 60] in=
=0A=
> the cache_lru.=0A=
> =0A=
> So when we already get some head clusters of a continuous extent, the=0A=
> tail cluster will definitely not be present in the cache.=0A=
> =0A=
=0A=
Your understanding is correct, so if the cache only includes a part of the=
=0A=
requested clusters, we can continue to collect subsequent clusters.=0A=
=0A=
> =0A=
> ---=0A=
> =0A=
> Here are some modifications regarding this patch (which may be reflected=
=0A=
> in the V2 version). Do you have any thoughts or suggestions on this?=0A=
> =0A=
=0A=
Although these modifications make exfat_cache_lookup check the entire=0A=
cache every time, I think the modifications are reasonable since the cache=
=0A=
(EXFAT_MAX_CACHE is 16) is small.=0A=
=0A=
> =0A=
> diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c=0A=
> index 1ec531859944..8ff416beea3c 100644=0A=
> --- a/fs/exfat/cache.c=0A=
> +++ b/fs/exfat/cache.c=0A=
> @@ -80,6 +80,10 @@ static inline void exfat_cache_update_lru(struct=0A=
> inode *inode,=0A=
>                  list_move(&cache->cache_list, &ei->cache_lru);=0A=
>   }=0A=
> =0A=
> +/*=0A=
> + * Return fcluster of the cache which behind fclus, or=0A=
> + * EXFAT_EOF_CLUSTER if no cache in there.=0A=
> + */=0A=
>   static bool exfat_cache_lookup(struct inode *inode,=0A=
>                  unsigned int fclus, struct exfat_cache_id *cid,=0A=
>                  unsigned int *cached_fclus, unsigned int *cached_dclus)=
=0A=
> @@ -87,6 +91,7 @@ static bool exfat_cache_lookup(struct inode *inode,=0A=
>          struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
>          static struct exfat_cache nohit =3D { .fcluster =3D 0, };=0A=
>          struct exfat_cache *hit =3D &nohit, *p;=0A=
> +       unsigned int next =3D EXFAT_EOF_CLUSTER;=0A=
>          unsigned int offset;=0A=
> =0A=
>          spin_lock(&ei->cache_lru_lock);=0A=
> @@ -98,8 +103,9 @@ static bool exfat_cache_lookup(struct inode *inode,=0A=
>                                  offset =3D hit->nr_contig;=0A=
>                          } else {=0A=
>                                  offset =3D fclus - hit->fcluster;=0A=
> -                               break;=0A=
>                          }=0A=
> +               } else if (p->fcluster > fclus && p->fcluster < next) {=
=0A=
> +                       next =3D p->fcluster;=0A=
>                  }=0A=
>          }=0A=
>          if (hit !=3D &nohit) {=0A=
> @@ -114,7 +120,7 @@ static bool exfat_cache_lookup(struct inode *inode,=
=0A=
>          }=0A=
>          spin_unlock(&ei->cache_lru_lock);=0A=
> =0A=
> -       return hit !=3D &nohit;=0A=
> +       return next;=0A=
>   }=0A=
> =0A=
>   static struct exfat_cache *exfat_cache_merge(struct inode *inode,=0A=
> @@ -243,7 +249,7 @@ int exfat_get_cluster(struct inode *inode, unsigned=
=0A=
> int cluster,=0A=
>          struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
>          struct buffer_head *bh =3D NULL;=0A=
>          struct exfat_cache_id cid;=0A=
> -       unsigned int content, fclus;=0A=
> +       unsigned int content, fclus, next;=0A=
>          unsigned int end =3D cluster + *count - 1;=0A=
> =0A=
>          if (ei->start_clu =3D=3D EXFAT_FREE_CLUSTER) {=0A=
> @@ -272,14 +278,15 @@ int exfat_get_cluster(struct inode *inode,=0A=
> unsigned int cluster,=0A=
>                  return 0;=0A=
> =0A=
>          cache_init(&cid, fclus, *dclus);=0A=
> -       exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);=0A=
> +       next =3D exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);=
=0A=
> =0A=
> -       /*=0A=
> -        * Return on cache hit to keep the code simple.=0A=
> -        */=0A=
>          if (fclus =3D=3D cluster) {=0A=
> -               *count =3D cid.fcluster + cid.nr_contig - fclus + 1;=0A=
=0A=
If the cache only includes a part of the requested clusters and subsequent=
=0A=
clusters are not contiguous. '*count' is needed to set like above.=0A=
=0A=
> -               return 0;=0A=
> +               /* The cache includes all cluster requested */=0A=
> +               if (cid.fcluster + cid.nr_contig >=3D end)=0A=
> +                       return 0;=0A=
> +               /* No cache hole behind this cache */=0A=
> +               if (next =3D=3D cid.fcluster + cid.nr_contig + 1)=0A=
> +                       return 0;=0A=
>          }=0A=
> =0A=
>          /*=0A=
> =0A=
> =0A=
> Thanks,=0A=
> =0A=
>>=0A=
>> ```=0A=
>>          /*=0A=
>>           * Collect the remaining clusters of this contiguous extent.=0A=
>>           */=0A=
>>          if (*dclus !=3D EXFAT_EOF_CLUSTER) {=0A=
>>                  unsigned int clu =3D *dclus;=0A=
>>=0A=
>>                  /*=0A=
>>                   * Now the cid cache contains the first cluster request=
ed,=0A=
>>                   * Advance the fclus to the last cluster of contiguous=
=0A=
>>                   * extent, then update the count and cid cache accordin=
gly.=0A=
>>                   */=0A=
>>                  while (fclus < end) {=0A=
>>                          if (exfat_ent_get(sb, clu, &content, &bh))=0A=
>>                                  goto err;=0A=
>>                          if (++clu !=3D content) {=0A=
>>                                  /* TODO: read ahead if content valid */=
=0A=
>>                                  break;=0A=
>>                          }=0A=
>>                          fclus++;=0A=
>>                  }=0A=
>>                  cid.nr_contig =3D fclus - cid.fcluster;=0A=
>>                  *count =3D fclus - cluster + 1;=0A=
>> ```=0A=
>>=0A=
>>>>>=0A=
>>>>> +             while (fclus < end) {=0A=
>>>>> +                     if (exfat_ent_get(sb, clu, &content, &bh))=0A=
>>>>> +                             goto err;=0A=
>>>>> +                     if (++clu !=3D content) {=0A=
>>>>> +                             /* TODO: read ahead if content valid */=
=0A=
>>>>> +                             break;=0A=
>>>>=0A=
>>>> The next cluster index has been read and will definitely be used.=0A=
>>>> How about add it to the cache?=0A=
>>>=0A=
>>> Good idea!=0A=
>>> will add it in v2,=0A=

