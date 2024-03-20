Return-Path: <linux-fsdevel+bounces-14862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59618880B94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 07:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C441F2238D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24E20DCB;
	Wed, 20 Mar 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I6xL56vd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="D01ay4zL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008E14A96;
	Wed, 20 Mar 2024 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917963; cv=fail; b=tvowx+pq/GjzS+q04YuHg8DzaKs9mEAKreP+3NUJMa96Sa5OVzqK8Tky5u/P2pd0vbhp6DF5e1RRaQ4qgrYsT64NzU2Q7UG40nH8TFvhYntQbbbb8cj/FmtADgK1bumWsh4ts8wN/aOU8OwcR+RiQ7GIJK0uxQk3bomjUwTe//o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917963; c=relaxed/simple;
	bh=446eNsfbIDwXe7IE2Fp/jX5jPiS8/ogl1fa8zLnhMtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlOcXJS2lJ2XVz5ghcrmESw9k6Zl+/QaKOcc98v+pyDVQxXVHGT0isrXDzY4wd+homSk6jknbqNrd3mQ+/pxvFYOoUnViQ2TrFtghPeYfnm8qAgz/URfsvuUKI/JXUDo7vV2ew8J+lEFqFMBpWm90hw6uigGeG/lRC3bvX3ZP9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I6xL56vd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=D01ay4zL; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5bf5f21ce68711eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=446eNsfbIDwXe7IE2Fp/jX5jPiS8/ogl1fa8zLnhMtc=;
	b=I6xL56vdjmU+JkyvLKeJOlPZExp9v9CHkbG+0uhbMTNG6KDTsoY48+nf2AWF41MIh1vk0CZ140GjPtBWTKWLxG9sGGcXvyjwGfXbmAAkOj/VQeZwMJbDQ0b+wJe+sW+IekX9iN2RiwrvAI/j7V/vxac9625+fpu3Wdm9l40CaMw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c8f88434-f347-4488-828e-e8723ef65cff,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:2b7f3685-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5bf5f21ce68711eeb8927bc1f75efef4-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <light.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 854040417; Wed, 20 Mar 2024 14:59:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 14:59:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 14:59:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXV/QbcfYd8fXcZMo3/p6bersNRkzO3FFieEAktiQUW0DB0yLNTSzj7JSvT3w89y3I7MICSeNfXJ6t38BIjk9F4SmUszldHaRmfWvmAbAB4mPizf7S2bwVA4wudfvkOwek/4wDWGHwTi3bSfjyeYVhYiKHuPtilZXZLpmwEiDlTFjjRUlp5EHwVlDYythkoWvIYfJRxpnWcTceXHJYeuXYk5stOauLILtCmC9QI7JtFsIwy3Y+s8bN9o170+VacimEOXf4hbf1RfqZvyeUZRg2uA7tPksPkbSoYjxWHygw23CSz453Nuhlo8DDDWZdkiAuIA12+iJvdLMAqPJ4wcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=446eNsfbIDwXe7IE2Fp/jX5jPiS8/ogl1fa8zLnhMtc=;
 b=jcBz7alAPQFL5Zf7yDjGa4s0UfVoTCvGyhZks9HTS0I1k1k4cpAWDOiOt9qc/ohRSLpfS1AjrR97lV1zSsUH08A6yHQC2a+w+jlT+9XK3jatVf83k7FYzgwjxZ1aK5O6y2NO5e5Ak/bkTUHo/kawXn6ZMls2/lGZMxdLsrOJmllJCE8aJAJjbrFMpWjLE3UZQvHxQPM11i5jWuFml4xKDNbypE7MSCUAUV/3onjhtcf805EcvG/PYm4op85vHSUci2Y3PmxLLl54Uc6Jc5EWXO69q8g2e92i1XlIsOynGMQ3ctPrZKuL76G3NdMt0j9YoDxhbLpFAHumBbqvPliogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=446eNsfbIDwXe7IE2Fp/jX5jPiS8/ogl1fa8zLnhMtc=;
 b=D01ay4zLLgasDnCKQNxIoh4vyHDmoLDtW9viF5e9R8893gAwSE+mUmR1Ida5R3gTrnMJNIP/E8EBxRVQwsWXBXHUGNLK92D35ZteLnJJwascqv5HqxrGnKe3VP8AqYM6+yJC1wEmlsBMtLZimJGYBgx8w476I6V+7YDZp8V9He4=
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com (2603:1096:4:108::5) by
 KL1PR03MB8196.apcprd03.prod.outlook.com (2603:1096:820:109::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Wed, 20 Mar 2024 06:59:10 +0000
Received: from SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::7365:45a2:14a6:2f86]) by SI2PR03MB5260.apcprd03.prod.outlook.com
 ([fe80::7365:45a2:14a6:2f86%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:59:09 +0000
From: =?utf-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
To: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>
Subject: f2fs F2FS_IOC_SHUTDOWN hang issue
Thread-Topic: f2fs F2FS_IOC_SHUTDOWN hang issue
Thread-Index: AQHaeo7EDmoANqtclUCBOdbH5nMtdrFAMrCO
Date: Wed, 20 Mar 2024 06:59:09 +0000
Message-ID: <SI2PR03MB526010F58DF7408F9C72F90C84332@SI2PR03MB5260.apcprd03.prod.outlook.com>
References: <0000000000000b4e27060ef8694c@google.com>
	 <20240115120535.850-1-hdanton@sina.com>
 <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
 <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>
In-Reply-To: <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5260:EE_|KL1PR03MB8196:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1laqUSZKiUN2O87VQheozk5PYoIqJnesr/+R/y2yEhC1u8A0fHgJOB6QW6aDKIOcTxGhZQhknHU1QC+TMZ+gNzuY6QCCJp9beSTATQcagyDhxtCT2Ny8OJe9Uxg/6YYj7NdHVBV5XiYbM3goSzuctiWHgzcn9yNS1Dc+IE8N0sfdpRTNCF7VOx2vSamYKR1ZiAyXTE06rfDLYRfTZFkBWpKMGpqfAKO4OFSIGIFR0aOylvTz4te9yMlA9Ts17eLxHgVGEs1FTXbytJfYOfHm6HKPQlmpWpkQCRTnZFLZYdljL9KA1d2Ukhqt3aMSNuYd3MzOSgJ+xyl+mfAcGqTVdjkmseFtF1UuAPwLGsZ6243jEMahVeWb0eTdBc021YEUutaBx0aR79k4ngc2He7+rVbfQw7FRa/Pg1aiNFi4NSsWL3I9EIYGLBk4VA3QqC8BV6da2CpDVRG4mgAmABI817sPy+l+DZbrgtM8zia+/qSBFkIS1qjYawdg65YqwmcOwOF4kWtvwun+3rjugFlCEtn9n6FLMpylS7zFLRH6n8u0/V25QunX6uQ5HweVvPPhMLrGlVRS7VE/jPjdEu8aLlZ5FqAyUMtn19xa8Rm3kvq/Fq9hJUkoyLjHzPlyOeRbTSgvtGE+iFNCcGGeGfvDS2GMqMTIrWLcoKNX7Lbv/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5260.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVJndjE4RXRLVWZtWiswT1VIUTJ4a28zUlhaSlp3dW0wSUdFSXZMU1JvRFdn?=
 =?utf-8?B?WU1RZUdaQXc4c2FVRkRTMWw3QTEyTGwyY0MxSTVYTmhJbS9xZ0xRb2RYRURW?=
 =?utf-8?B?cThQVzlSclNXZDdUMXBXVlhmNFBkU0lUbm5PV2tIRGlIWXNIV2RldU1acmVI?=
 =?utf-8?B?RFU2MENJMUE2OVBLUThRajBENjBnUTRLdEYrT0xsN0thblFwVGI2K29aaHBv?=
 =?utf-8?B?c2JCQ0xHTVhidWFiSlRqOU9YS0JiTU1wTlU3M0dyQ0todDZYaHpCNW1UYjJU?=
 =?utf-8?B?RDJHKzFFZ2lIVStEdTZDYW9nNnU0SHNzbEpWZ0N6OXJvNXY5WEZVQ1VDd2Qw?=
 =?utf-8?B?VDZaZXlaSEdKRTVrSW5veEFHT1oyVVBmdFVTeDNpcXdWbC9MVEp5aVN4bzc1?=
 =?utf-8?B?MW5kSlE4UUJPL0tIWUR1VUlhNWF3b1FCV1lBM0p2VVZ5K25GbTN6QWZLVmNl?=
 =?utf-8?B?S0RnNkFLYlBtQlUvbTJVVXBjM3hpRmt5dS96NFBxKzFlSk5ZQVVialdDcjJv?=
 =?utf-8?B?bjN1REE4cHJOS2tRMmlYQ29uYTU5Q2s0bS84RjkyUExGRnJmYnIydXc2YzB2?=
 =?utf-8?B?WFNBWFplRzl6dFZYb3FjTGVtaDh2SHlwKytsNktNamc4TldBNTBtc3YvbXdX?=
 =?utf-8?B?Zk9pdXR1MVRkM21HYXkrQVhJUnpIa3dSN1FydE9jSGFzS0xWYXR3V041dzdh?=
 =?utf-8?B?Q2ZOYzM1VUYzWkFTR1VhM1lCWG94L250YUFGK0ZBMFdMbHh5Rk14SVNqVTVq?=
 =?utf-8?B?Ym9jWXJnYWI5d2FzMVFVOVkxYlNMWUFwK1FkV1pQUE5GOEhCVXNvV1BNU1dj?=
 =?utf-8?B?WkpBdGdJdXJiV2FXejY5d09ISjVyQ1QwWUUvMzRzbml6akh2R3hQQ2NxV1hO?=
 =?utf-8?B?T2U5NVVtNVlRWnNCNzI4WGgzZWNDWVVLQk5WMkU4Vy9TRW5sMkVIVWR6azBs?=
 =?utf-8?B?Y0Fxa2pSYXl4bWxJbXlkMHFFZkczWkFkOW5PMXVWRXNic0FpTkwwZGY4NGxP?=
 =?utf-8?B?cDFtbW5QMUpwVE10OGxPb3B2bEtvSXJyZW5oWGVaWUJkazNrdExzOXdtbkZZ?=
 =?utf-8?B?UXlESjNGWFQxVU95SjdDb2EwY240QU9ZWnZJU2VvTVFNc0JQWC9CczRoaGkx?=
 =?utf-8?B?cmZ5SFpsL3p6dGhEWlpyUlZ1K1hrVG4rR2pxM25hNUZPb0NSeDlCMGpESVVH?=
 =?utf-8?B?aVpaYlNtWEU3dDdqYVlyZFVXcHVKcEFtejNSb3Z2WEhnaUtOb3BaZE5oZjFP?=
 =?utf-8?B?eTB3Y1BuSFdqU1JjRnJyS3pqamtLTWcrOWFRSGNYbjZxTExBeEJqWFhrNjFN?=
 =?utf-8?B?UUt0eWdkeklyVkhudytlUmdQa3IzZ3ZoK3RTQkJRQkU3b2ZEMlNja2laZGdv?=
 =?utf-8?B?SFY2bWJjUnRCeTQwNlBFaHVvOVA0RFBCN0ZVVklvSXZDc3dRSmhVV3VFV2U1?=
 =?utf-8?B?b2VQb2pHVVlqdzFMU0t4NDFueG51WUNtZFdoaEtMa2tiY1MyUDFTa2RMR1h5?=
 =?utf-8?B?Wkl5dG5uR0VqNWpMVFVpeThZOWZvbzdCTmZmU0hNTkdGeHQ1MmYzSGI1L3Ez?=
 =?utf-8?B?bmIzYi9VODhkWEtKTGwwQnpYZXorYllIdGsvWUhsb0VzN1BMeVRKMnF0Ukpr?=
 =?utf-8?B?clFqb1N2cmlxTkxnNFlFc04yNU1FS3pzZ2dDZ3REd1l4dDFlRTk5VXdQZVJK?=
 =?utf-8?B?aXh5Z25Nd1JSTWZyOXBlbVNKc2hySmluRTJ6ejNEc20zclRIMUZXUEZTMllV?=
 =?utf-8?B?ZXhBcXc0TmJWMW15eXBPbzlPcERpd3BGT0ZIcldCZUR6NUxQOVAxT0VoeHU3?=
 =?utf-8?B?N0pMbmZlMkpqdmloMktRckpqMU5iSnlzYnI2ZGU5WElTN09JMVlLZGt5NjUx?=
 =?utf-8?B?TEtaOFdaMkpCYTNmMjhsWjhGYjRYUzFoc1N1MldZTW5Md0F4S1pzc3FPSUx5?=
 =?utf-8?B?dFp0aWFxbGdySjRHdlFkRGNzWGs4ZlRKdGUwaWxYSDd5eEs1YzFhOW5keXZO?=
 =?utf-8?B?THEyektTMFhIWCt5ZTJWSkZkS2loVUpTT0t0Q1lvd0NUSXRWckRNUTd4REZ5?=
 =?utf-8?B?Njltd29NYVRkWlJKRm4xRm9JZE5rdmRxcElBUU5BKzNnYzJHV3lHSUsrOFZE?=
 =?utf-8?Q?OqZYIC8LrCoN77GLzEqmMNP17?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7357e7c-c37e-4a12-a809-08dc48ab3de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 06:59:09.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIkAFWOb9vnHZGIGv5Ps4R5qPFp+OmhxVrgGK6CkEg6tP0DTlXtbC0Kzpc01lrhFXZ+ak/zwyb5tQWaZzJC3ZK8AkgOfwughfBEGqAu/nLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8196
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.054800-8.000000
X-TMASE-MatchedRID: NKO9ekWIDjbUzvcPSorAlLxygpRxo469BGvINcfHqhdFDR0AKGX+XOuw
	oQee+VXRwdQCqlx9EovzslOXY3oDJDP+djhKO2fxngIgpj8eDcDBa6VG2+9jFNZE3xJMmmXc+gt
	Hj7OwNO22utO5qEfOUQEaRg0OKJ+YpRerJnvpe7Anxwwd/tivEbcWipbNVupNxTsaGBvE95spFI
	HB/XmEwxKExvg6Z2yib/JdHQ7g/kuZsaOxH6CzN7WCpoMv4UR6epsqrlTWW7Ggkr5B+W9CjQMQU
	kaz2w6PHIV02d1rpG8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.054800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	66A2E5CDEF119852D709139732715DCD8A6F22E56FA33F5190E738501432B4ED2000:8

SGkgSmFlZ2V1azoKCldlIGVuY291bnRlciBhIGRlYWRsb2NrIGlzc3VlIHdoZW4gQW5kcm9pZCBp
cyBnb2luZyB0byBwb3dlcm9mZi4KUGxlYXNlIGhlbHAgY2hlY2suCgpXaGVuIHVubW91bnRpbmcg
b2bCoCBmMmZzIHBhcnRpdGlvbiBmYWlsIGluIEFuZHJvaWQgcG93ZXJvZmYgcHJvY2VkdXJlLCBp
bml0IHRocmVhZCAocGlkID0gMSkgaW52b2tlIEYyRlNfSU9DX1NIVVRET1dOwqAgaW9jdGwgd2l0
aCBhcmcgRjJGU19HT0lOR19ET1dOX0ZVTExTWU5DLgpUaGlzIGlvY3RsIGNhdXNlIGRvd25fd3Jp
dGUgb2YgYSBzZW1hcGhvcmUgaW4gdGhlIGZvbGxvd2luZyBjYWxsIHNlcXVlbmNlOgrCoCDCoCDC
oCDCoCBmMmZzX2lvY19zaHV0ZG93bigpIC0tPiBmcmVlemVfYmRldigpIC0tPiBmcmVlemVfc3Vw
ZXIoKSAtLT4gc2Jfd2FpdF93cml0ZShzYiwgU0JfRlJFRVpFX0ZTKSAtLT4gLi4uIC0+cGVyY3B1
X2Rvd25fd3JpdGUoKS4KCmYyZnNfaW9jX3NodXRkb3duKCkgd2lsbCBsYXRlciBpbnZva2UgZjJm
c19zdG9wX2Rpc2NhcmRfdGhyZWFkKCkgYW5kIHdhaXQgZm9yIHN0b3BwaW5nIG9mIGYyZnNfZGlz
Y2FyZCB0aHJlYWQgaW4gdGhlIGZvbGxvd2luZyBjYWxsIHNlcXVlbmNlOgrCoCDCoCDCoCDCoCBm
MmZzX2lvY19zaHV0ZG93bigpIC0tPmYyZnNfc3RvcF9kaXNjYXJkX3RocmVhZCgpIC0tPmt0aHJl
YWRfc3RvcChkaXNjYXJkX3RocmVhZCkgLS0+IHdhaXRfZm9yX2NvbXBsZXRpb24oKS4KVGhhdCBp
cywgaW5pdCB0aHJlYWQgZ28gc2xlZXAgd2l0aCBhIHdyaXRlIHNlbWFwaG9yZS4KCmYyZnNfZGlz
Y2FyZCB0aHJlYWQgaXMgdGhlbiB3YWtlbiB1cMKgdG8gcHJvY2VzcyBmMmZzIGRpc2NhcmQuCkhv
d2V2ZXIsIGYyZnNfZGlzY2FyZCB0aHJlc2hvbGQgbWF5IHRoZW4gaGFuZyBiZWNhdXNlIGZhaWxp
bmcgdG8gZ2V0IHRoZSBzZW1hcGhvcmUgYWxlYWR5IG9idGFpbmVkIGJ5IHRoZSBzbGVwdCBpbml0
IHRocmVhZDrCoArCoCDCoCDCoCDCoCBpc3N1ZV9kaXNjYXJkX3RocmVhZCgpIC0tPiBzYl9zdGFy
dF9pbnR3cml0ZSgpIC0tPnNiX3N0YXJ0X3dyaXRlKHNiLCBTQl9GUkVFWkVfRlMpIC0tPiBwZXJj
cHVfZG93bl9yZWFkKCkKCkxpZ2h0

