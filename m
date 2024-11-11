Return-Path: <linux-fsdevel+bounces-34191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31F9C3894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED6280E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED298155A30;
	Mon, 11 Nov 2024 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YQqZ1Yte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26984A3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307454; cv=fail; b=p/yMC0fouZyvzVl1chmmVBCvbMJuC3k7CN7nY2kfnesGkp+S73xZ/0ejzx8oCNsfziYH72Mo1EEVc0WQq/qoSOUYimCHIS59BpjTzWG9tVFlrJBLIZLrv2OwTF02tSXHJDazIm5FiSuBh7uRXB3D17F6lkI5rYwRmyEItHbBibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307454; c=relaxed/simple;
	bh=/MqUqZ0LtW9ElaPi2ZQHyX2CeBLjTnq3HIX/8L3u3+g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EVpcNNYgmjFdJV6YtebC1jRdBUsF0OesEwdhJs9WnR9czNTwqmqVFIx8v4hakdtizmeIIh6XJb+LHBqDUibsWeW78/n8EvyxWohZSSgFNUEMu+QwcfZXmhh7Vk/8G2GnuSMgN2poDrYd19Fo5kFFo3dowTGP6pL/oMg7rSyXugc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YQqZ1Yte; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AANvYcA002759;
	Mon, 11 Nov 2024 06:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=/MqUqZ0LtW9ElaPi2ZQHyX2CeBLjT
	nq3HIX/8L3u3+g=; b=YQqZ1YteFMvdnO48F/I4CMEVdXE7Oy/3gTRWFxQgx0yQW
	GBbFwmT7Tn/byJIoUDo+pspR9AiyT+/KpNnis5+fBOaVDnBc0q5FqiUxlRkmMVI4
	OmKlcuk1kA+3yNQvy0w5I78jIznF3IsNjTRmLThLp7Yf8dGAwtQYf0Z2o/4H9nzD
	LYgjEwRHp25/M2TFSoPU2QA8MwmhGPKql3rZcgjPzv9+2nCe8vNH3X1RrjOk/gsN
	T7eB28FZH7QWqQGpLASeDbZNmVR4RheJ2nSeDhZgjnVv3zPO9pL+8tg/RRewM/B3
	cmR47juLa8CSJwp9j7O96SyliYna3Hbg0XktubBqA==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2106.outbound.protection.outlook.com [104.47.26.106])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42t0h3h81s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 06:43:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x57gJdVRJsW1RgvnkVjhp2UU0V8+RBwmQXyLKxfQXZNKNoQ7coIO8rtp/YdP5oeBV6N131QR5JTn8cMGxXF3NUGKweZ7gqiZiuWCSfgw3yVpDgcwiJu948HfWBDUGs/FijG+YmV0ZpTzmLfbl1/Cxcc8dn8GjLzooFU7TWGEf9K/lbIx9dEVh7CQW8/fUNnHQpcp+RNByXIXXCJA4455Ernd35nzlm2PZTF346w6kn1I4r/wO0BcKRkFMgjXFdqTELoIclq5XDb00jbqnSABQAGkNYhSzGdQtfiVL3ysMNua+T4bIRj5oYGXVS6cBfSTU+90yog6wX22DgR6y2F2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MqUqZ0LtW9ElaPi2ZQHyX2CeBLjTnq3HIX/8L3u3+g=;
 b=a4QqmFh0Y5rkhcJmFB4Kh3AioYqLPuwwVO7lB+Ix/o4LXhn9mG+9KuhG4sK9ZETfA0q/Fwzjx4V/rXe7uJhQHo+uXOGnoe4NMIHBt4DpA0umHF4AxFtwCu4QBl4pugwODs/QC/fGqdSn4mZtL7OQ6y9hPj7w+1SSjyydtlOGmVJeW9uNdkGucpv2Ly54S/Jl3fgORuVF+Vb7bgGFIHoI13ZuUFzyWBEQNtmipTWSWHyrIK5gQaXn37mEG3lZISK+2vHougTBeapcSPFw1b/16KPHJ3ObS7ZMQuvX/4fuP/jUYVs5l5OZjred5KbLUcEoeectDf8jO9p9w/noACdvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6982.apcprd04.prod.outlook.com (2603:1096:400:33c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Mon, 11 Nov
 2024 06:43:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 06:43:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 0/6] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v2 0/6] exfat: reduce FAT chain traversal
Thread-Index: Ads0AFsQJmG3/mHbS+2WCm19UOFO+AABBJjw
Date: Mon, 11 Nov 2024 06:43:47 +0000
Message-ID:
 <PUZPR04MB6316E3576F9431D57C9D7B3681582@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6982:EE_
x-ms-office365-filtering-correlation-id: 05900225-efa4-4d11-cf90-08dd021c31b3
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmNQYjZreHJPU2Z2M0VZNW5sNStLR090STgza3FWSW1aSTlUMXdlQzhWUEZV?=
 =?utf-8?B?UzV6OTdPUjFEdXFpUmw1TitTdlRiWW5zS2MxdFJQZUxUUVFYNDBMN3cvQ1g1?=
 =?utf-8?B?RjdENUExRzNmQ09MYm9GbVNxelBzT1NhWGoyTGJxNDAyMk93Y3pKN0Y4Mmg5?=
 =?utf-8?B?WjQra1RMRmhxTnFHVXI4OHZwRkVWNk8xNkNyU1ZyT1oxSEk4TG55WHBlOHJu?=
 =?utf-8?B?aGJjdFM2MHZUMElsR01WVU9ZcnhnY3dCYkcrelRXNUVrMTRYTHZxWlFIUWxG?=
 =?utf-8?B?SHN5MHpsV0lrUkZSMzVzOWx4U01NRGRUNjdvcjJzWkdIeTBuOEo4RDB2d0xq?=
 =?utf-8?B?K1BIN0dEU096SDVBc21LVmE2OU9kcDhYWUQxTjA0UlV1aDJBeEV0akdWb3Nz?=
 =?utf-8?B?THE5OUw3bTNDb2c1MmtUR0VOK1RLU2dQbWFSRGFjY2Y5QmREaDhuYStBNFNT?=
 =?utf-8?B?UlBiQWovdXFIMVNhNllidStHY1ZUZnlJZHFRV1ZpWjFaaEMwY1kxUVgxMVRR?=
 =?utf-8?B?VXhCdXdzN0g1NlgzSWNvdVo0RlI0VUx2ZWZBeXlhSWdzQTFkbzRZS0JIWVlr?=
 =?utf-8?B?MUpwMXBKaXZmZDc3cG96WGNPMGNaMWRFL2FhMHRsRzdOdzFwbEp6d3l4bVAy?=
 =?utf-8?B?eDh1UGVXMG1ya0V1VDVoaHJieW55NkN1ZVJ6eFJpSzhmRUVGWHBzb3NKbEFW?=
 =?utf-8?B?UVZKUFdsNVgrejYxTEVEQnRTTThkZDI1bTlxTEt1M3BLUUJRc3JVcWkxSTlN?=
 =?utf-8?B?clVuazg1eWs4UlVyeXpySXhyanRIUkdxNjVGOWwyQ1BWOG5La3hlMThLbEht?=
 =?utf-8?B?czlDYlFLd0s4M1BDWVJpN1NMQ1B0SDUybml6SFhjbTVkMWx1YkVEdFQ3RTI0?=
 =?utf-8?B?ZmlsQVp0WHBXNW05ZXptK1FSbnBPT2FiYURJQjhCK1hZaGxaT0JhYXFYcjlI?=
 =?utf-8?B?c2VzUE80Zm5DYkVaOGhrcEQyZGFvVmhJM3crU3JWVmY0Rm9aUVZVRmsydzY4?=
 =?utf-8?B?UGFHMHQ4dVROeVZiY2dUUkhOcUhnVnNybEs4dktzTnZiQXlLWTNXUDV4LzdC?=
 =?utf-8?B?bEUxK0UvR09jbHBWVWxyZFdycWFvcEJSaTNBZmFxTVBZVGI5Zzk2bVpkS1FP?=
 =?utf-8?B?aWw2OE9SdHY5Tm54MkRod2Rkc3B3dGNoNElxS0JCeUxJRGkvY3BvRUoxekNo?=
 =?utf-8?B?eW1iZ1o4RVFoYk96VUpJVy8rcFp6T3lMUUpHRDJwV0lnRndLSzFSN2ZNL0Zw?=
 =?utf-8?B?T1JxRlc5bFpheFhnQjMzNkdLQ3lpZDNyMVNaajlRSnU5bGFrWjhHUGkwRkxy?=
 =?utf-8?B?SXMrQmhTYkpMS2MwMHlFOVN3NXVJVnJETXphWWRWTm90ZGdqdmptSW1JYWE0?=
 =?utf-8?B?b0ZJc2ZSRjhoTjlCZldMZDkxOUIrOUF3VE1ZQ3dtZ2NJV0s4bUMzd3hKNXZR?=
 =?utf-8?B?S1IzYWtPMzk4V3FBM1VvdjZRMGo2YkwzMExHNWJNa1FqR0t5OHpYa0VCY0R2?=
 =?utf-8?B?NUZOQk94MGFUbWJoNHVFb005ZEFrZk95Z1lreE8wWm5QaXIxWGZSb05ZaXhk?=
 =?utf-8?B?a24ydEpLa0lKczJuZzdsZFo2QjZCUWJmRmZ1YUFaUzE0R2YxQ3lPWEZaZGdr?=
 =?utf-8?B?NzlGb0dUV1pwMmg4SXYwMDBXUjVpZnhwck9hQ2IrNnZsODNRN2pIK1hqamVz?=
 =?utf-8?B?V2Z3NFFyWjRQZ05peXBRWS81TVQzZFo0QWgwQzRCckFadE5WNE5Wd1ZqQ2hP?=
 =?utf-8?B?cXdmUHFiWnZWNlpUd1NUZUpvQXJBYmpLL0FrU2VsZFNPWUZOMVMrc21GRkVw?=
 =?utf-8?Q?hnuZ9D1xNvpz4ubylzWhib8ezkn9j5eyBbzT0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHUwd2RqaHh0TFl4QVdKcmJzayt3TnZpcXdBODFuZ00xNVFPakZCRGhsZ1Rs?=
 =?utf-8?B?bWhjSGJnRlorcEVxQVUxMy8xVEw5ZWxabGNIbUROQjAzRGMzRlQ0YjE0UmRC?=
 =?utf-8?B?UUNnVWllalUwZ05MenFOK0d5WGVOS2VUM2J1eVhWWGlSTHFmejZHNFhmVGV6?=
 =?utf-8?B?aXpNTWVheXR5WVcxck1IcHNzQlB1YXFocnljSnBVN3p4YVVGTkovczN6Y21V?=
 =?utf-8?B?NW9HWitHSUlWWmVMZ0ZOd1VFcklIRVR1ajZZNVk3Mk9NT1Jmck1QN0N4WGVx?=
 =?utf-8?B?dTJwNHh3SGFYN0xBcXlER0tLRnViN3dneHBYcnhIdjE0aWUvTGdvUTY4bjRt?=
 =?utf-8?B?V1JzcnMvaWpJMUYvV0YwR1J4dElCK0grMGZESEd4SkNEdDhFbWc2WXRSMGNi?=
 =?utf-8?B?VUxqaHRLUWE2ZEVwQ1M5NSt3a25VYnVSQnMvY0RtTHcwM1pTTE9FbnN2OHJt?=
 =?utf-8?B?MW1SSm1Kcy9vMWI1OHBzNkV3eHl6ekczamJKTzhvcHRQMndERlJUMHE1UVhH?=
 =?utf-8?B?dTl4YzhIVllPME9vZnpOdFgvV1JQU1B0cklEM09hQzAvRTZ4eE1nam1rUHcw?=
 =?utf-8?B?bzB1Y2ZxcStuUXAzeDFpQ1ZlK05oNXE4Z05NN1FFMU1JRGdseVU1aVNNL1I4?=
 =?utf-8?B?ZXFDTmM5dWhXNTN0MGJmR1RldTFUSCtZTHdpcWh3eThZV2VhL1BkYXp1OFZX?=
 =?utf-8?B?LzFRaU4ycXoxMlFmU3ZtL0dVNXpmZ1dRdHh6NDg0WW9adWhGZEdkT3hCenlK?=
 =?utf-8?B?ME41L3daR1dRNzBCWFJxelJhWnBYY1pxR0tMZmtpUUZ4T1pXdDY0Ty83NU9Z?=
 =?utf-8?B?S0M0NTFXam9oR01RSXlicTFFZEQ1ZCt3MFpMcGUzVThNQ2xOa1lIRlRuc1A0?=
 =?utf-8?B?QkhRc0ROdUFxUnQ2UzBzbEdLbnAwcWNvOFl6TmdoR0dzRDVKcElFcUUza1dh?=
 =?utf-8?B?Q3NUUm9ZM2UzdHllcE4yaCt0RlN4blpyT1pQbEtjZ1lxVU1HdGx4YmlNanB2?=
 =?utf-8?B?NnBuZEVYQkxMR3VreWppcGcrVEpPKzhwUDlRSkc5Mk5BK29vdDl0cWtLZDVN?=
 =?utf-8?B?a2paTWdkRFF2b05hckR3Z1FSMGxpMXorRCtXY054YlZ2RXo5a25ZYU9LaWdC?=
 =?utf-8?B?aURmUVZScWVYVWcwSFFBa0oreEJQdVowZHM4NTRJcUh0OVlleVZ2Y1EvVldi?=
 =?utf-8?B?YnpJbVhmdHFSa2FkanQ1YzNGZXlrcnBtYzlWNVFrMVFiOW9EZTRuZGVSWi9E?=
 =?utf-8?B?Yyt6MGZHTTVsUThQVTFtemNTVkVEVElxQkhuVnNoVUJjeDV5a0lNYTZ6eUY0?=
 =?utf-8?B?R0gyMnhwYWRlOUtUOG80MHBVQ2NMYmxJeStzQUcxVGNMaXRra0hlWkdyUnJw?=
 =?utf-8?B?a0tMdHlxK2ZLZXZlc3hvYUQ0YnFRSGhmQWZsamREaGdiblNDcHU4MUJXNEFI?=
 =?utf-8?B?RTFOU3h3M2ZJTVN5N2EzMGhJYW1HcklWdEErRnJVM3I0d0xtVS81YndTUjFB?=
 =?utf-8?B?VVljdkdFdERUTzBIbjc4TFlVRk9TOE10L2R2Z1JsVExiLzNKV0UvdHhWbksr?=
 =?utf-8?B?Tnl6WGtHTkZqTTVDZG9GOFVkSHZEU3FVMVhrMjA2U0RjRVJLZkVNSVdTbmQ4?=
 =?utf-8?B?bE5yOGtwczArZDlmeVR5RUhhNlNXWUNocnE2VEQyU282MEdCN3dlaTJGRDVh?=
 =?utf-8?B?Nzh5WmVNMUFmaGFhd2R0amYvemRnc04wRHl5T21LSnZkTkROWDlZdHNRNVRT?=
 =?utf-8?B?OXN5ZUZackE2V2pvRVBzVEU3Um42RmwrYURtMGxMSkZWWDFNdVhmSE04Rm14?=
 =?utf-8?B?bkJiZDRzNWk0OU9wL3RhUGplTitnYU1qb3BCcnJZeU1IeEo1eEw3VG5PRThJ?=
 =?utf-8?B?VlZaQmNUeFBBZkxXV3JyMGtOcDRXWGQvZUVKVU4vQkVNeHdYWW9RY2lHVUho?=
 =?utf-8?B?TVNqY3hMTDk3eEtpcDFtVjhxT1hiNVgxZFVlTlZkZlJZMmhnSk5LbWk3dWZz?=
 =?utf-8?B?a2xKUVRZUTdhQWoydmdqeGNCMVUwSkc1UWJzRGpVdFRVRjI5L1lmT0hsT3ZE?=
 =?utf-8?B?MHR0WU9icmlmS0Rqd3lSN0ZJOXlWSjUvb0lMdHhLdnYzSkxTWVFqUmFCVTNU?=
 =?utf-8?Q?1VQ3gaWN4QRG89gAEqO2OJNtZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VQ9FNLoCbJ0jbh6elkXVXzZvk+31L0wzDEA746IdhuhKJ+VHowQ0zGiKKKsNN0aicLMo8wxQNh7V0m159jZMk7QlyCdtKidF1lREzNdXdFUzfaDB2+r9A4a1CuAes+EfTteUrB2k6xQPlG9G4cAldPhDqCj3zF3kzVXHti115ujjfyB1SHbbylyGdEzKSfbBx+Aa7yJwNWLNmWy6uHTMiOxpRE672VmyQiua4Wm5X9OvCw7Qvvf9Dy6BO6qWzCssUcXVacKt1ofc60m9noKdITUrcqyDKOFbmMHxJkU4dllS16N12Y9K8eHvDZZsnKO3ooZYN9j9Vf3cEL92qDeOQAhnvwC1n6ANTG8eB7a21vYJC9d71uUiK0k8YeNL83S17bu38KPg4vLe3ikhn23IbFTWO4GOpg3dD1sqMqbHt2LnRXFMjyL5+kpEPClxNfMAWwgD0k42TAhRkNrntgjnhDzgmaPAmKMbSkFPDSyDDSlxZ6UkXxBSHVzSLfWNrQ6W5RlViZnJnpRBseWAPsN958+mB7XK/xegITPZreHLu0qArPSYADiIM/gjenLjRv8F+qmmsUoKuFvvq0HtNSHRd8sMLyLeZM1xMMYB5Z9x2AVb/lwBX2dnRUeP6QKJGqGL
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05900225-efa4-4d11-cf90-08dd021c31b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 06:43:47.2516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMb/ftNfBMtsdtVCv0oznCZC92C6+qOcPbVLQGNbyuLWQshCBvAHQmYVVvtwWWwqnUL66s3MBQXwtJBNfWE0Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6982
X-Proofpoint-GUID: N8ohX-EyPFkskMiSp5NdNUiCt0MqZ76a
X-Proofpoint-ORIG-GUID: N8ohX-EyPFkskMiSp5NdNUiCt0MqZ76a
X-Sony-Outbound-GUID: N8ohX-EyPFkskMiSp5NdNUiCt0MqZ76a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_06,2024-11-08_01,2024-09-30_01

VGhpcyBwYXRjaCBzZXQgaXMgZGVzaWduZWQgdG8gcmVkdWNlIEZBVCB0cmF2ZXJzYWwsIGl0IGlu
Y2x1ZGVzIHRoZQ0KcGF0Y2ggdG8gaW1wbGVtZW50IHRoaXMgZmVhdHVyZSBhcyB3ZWxsIGFzIHRo
ZSBwYXRjaGVzIHRvIG9wdGltaXplIGFuZA0KY2xlYW4gdXAgdGhlIGNvZGUgdG8gZmFjaWxpdGF0
ZSB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhpcyBmZWF0dXJlLg0KDQpDaGFuZ2VzIGZvciB2MjoN
CiAgLSBbNi82XSBhZGQgaW5saW5lIGRlc2NyaXB0aW9ucyBmb3IgJ2RpcicgYW5kICdlbnRyeScg
aW4NCiAgICAnc3RydWN0IGV4ZmF0X2Rpcl9lbnRyeScgYW5kICdzdHJ1Y3QgZXhmYXRfaW5vZGVf
aW5mbycuDQoNCll1ZXpoYW5nIE1vICg2KToNCiAgZXhmYXQ6IHJlbW92ZSB1bm5lY2Vzc2FyeSBy
ZWFkIGVudHJ5IGluIF9fZXhmYXRfcmVuYW1lKCkNCiAgZXhmYXQ6IGFkZCBleGZhdF9nZXRfZGVu
dHJ5X3NldF9ieV9pbm9kZSgpIGhlbHBlcg0KICBleGZhdDogbW92ZSBleGZhdF9jaGFpbl9zZXQo
KSBvdXQgb2YgX19leGZhdF9yZXNvbHZlX3BhdGgoKQ0KICBleGZhdDogcmVtb3ZlIGFyZ3VtZW50
ICdwX2RpcicgZnJvbSBleGZhdF9hZGRfZW50cnkoKQ0KICBleGZhdDogY29kZSBjbGVhbnVwIGZv
ciBleGZhdF9yZWFkZGlyKCkNCiAgZXhmYXQ6IHJlZHVjZSBGQVQgY2hhaW4gdHJhdmVyc2FsDQoN
CiBmcy9leGZhdC9kaXIuYyAgICAgIHwgIDM4ICsrKystLS0tLS0tDQogZnMvZXhmYXQvZXhmYXRf
ZnMuaCB8ICAgNiArKw0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgIDIgKy0NCiBmcy9leGZhdC9u
YW1laS5jICAgIHwgMTU1ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogNCBmaWxlcyBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAxMTUgZGVsZXRpb25zKC0p
DQoNCi0tIA0KMi40My4wDQoNCg==

