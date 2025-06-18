Return-Path: <linux-fsdevel+bounces-52031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1537ADE9A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C88B3A6358
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46C28DB71;
	Wed, 18 Jun 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="m/pj0BvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7EC28C2B3;
	Wed, 18 Jun 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245117; cv=fail; b=ZoebI7ar0NlT2cK44d087dgWGkhxVZaq1INZ5CPth9QhVsAij7v/e3ibLYtjO1Fqxa78JxX4b9K+YeskY+LdBLQs+GB4C01+H3EHO0prneRY3VHpRHSJiKv5z9+I7Uh2op598bMmdiuA24XQD9u5iQnA6pRcbl+xvZx1YzU1ID0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245117; c=relaxed/simple;
	bh=0G3+QKzDaK3SnxeDUmTEBCT+u19b1fTcG9wfsFKs7K4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDiH6vLha/MpPMGV8Pky2/X+q8CKvuMAb75GZoVFa1oM5zhLBuGebnftUC+/lgD9hyYo3WzZv22lqicnR284z2LKdRc6PKWg8mVuenqAD8cIZGV4IQ0xZKS6pJ50Eg5sTRk3cnCTnVmwRZ0hlif6J0WUubHZczrjKgWej26+Ls8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=m/pj0BvI; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IAfB6S028959;
	Wed, 18 Jun 2025 11:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=0G3+QKz
	DaK3SnxeDUmTEBCT+u19b1fTcG9wfsFKs7K4=; b=m/pj0BvIOSjgtu6Po9K3WMA
	lVdRP3VN6M3VYmRbYsh0ccWegmEt34daf0/F8TNgkYEjgUPsk38rRMngdPnl1OFg
	GKksZU6ZAVU5ys34xqIfzqDQwiqnrvULN1Rqy+ZSTI5T7QTwyj8bNBgJnTdQxo9z
	0zpn6vRWoNOpzPtgUWpRvRFAmI5ov8P6ftXYGgV9JCabBReDiLIMNSmFz2sMs55i
	pEZqtHzv3G39cCviCxlUIBApSqITgXCR7QiFQbVlW7ikGytXYjHsOReZY5lQexaH
	E5o1J0YGXhadxhbaTpMKfx1hj7bT9bHEeLkMJPNyDb6dYipuUVtl3rCarlqFOjA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazon11012033.outbound.protection.outlook.com [40.107.75.33])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 478yr1uue0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 11:11:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXCmiz080s9JCHM1XaYtcsJIdzCGqOuZ+EhUIxGCGDD+TjIKIk/HHXYAYVgJB3asSFbpY+k26fqJIgMeu9gJezZWc7bDxO/Mk/mUfTDF7QL4mRKB9xwbQjvNoFYmDJmKGvhy4+79D/E8Zbdt39aha5ed0SmwplU1igjRx7FtPVe9SEiLDMCrD36gZMN8PooOqzh5HSpbkrjomp4rvYallWUSMhfW4izs11mr4IbhWKh1KJC767NzatF9sK4hjUUSF3W/4zalHRF+r/EUXVi1s2DYzwfo5IjXZDC08a6gCq8OhELvBhbvFptOmNv5Wwv/XzeRjWBQtmVUMZ5P8SeG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G3+QKzDaK3SnxeDUmTEBCT+u19b1fTcG9wfsFKs7K4=;
 b=PMaPEvCPRdWX0GHhGzpiH8vrRYDRW+g2yOi8QBcFFcAa+UGC/8TfTfwYf6nJgwhnOwnaw91J3FX2JMFL2YAYiK+RfcejtXnETSutuOZQBkE0xAg+yvq3oUtXNkFYsM3sYODBKZr+MTBhI0r6vRRZglAPqBWhT1FrzNaSZhS2GOr2UV06k0gRFj6O93dB1Tj20F202iexLG/aDFU7LVfNon8URXvXoy/hZla79t50Lq/jyHskfWlzme6LYgjNxUOrYhwHyMcXaBu8M3H9WICEKuHBQZUSNl0SL1E9/Fxxx1bb7ADdDHBJVjdiLMS9w0U/z8WNUEbfCT0bmnBDS9Vg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SE2PPF10E5687AA.apcprd04.prod.outlook.com (2603:1096:108:1::606) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:11:04 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:11:04 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: =?utf-8?B?5byg5pS/5petIChaaGVuZ3h1IFpoYW5nKQ==?=
	<Zhengxu.Zhang@unisoc.com>,
        Cixi Geng <cixi.geng@linux.dev>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
Subject: Re: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Topic: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Index: AQHb3CvFSyisR7Q+SUOzmxnGLTa10bQA2ySngASskQCAAS9Lb4AAbCSAgAGQM4k=
Date: Wed, 18 Jun 2025 11:11:04 +0000
Message-ID:
 <PUZPR04MB6316B9353121616B7C0928D98172A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250613062339.27763-1-cixi.geng@linux.dev>
 <PUZPR04MB6316E8048064CB15DACDDE1B8177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ebba6e12af06486cafa5e16a284b7d7e@BJMBX01.spreadtrum.com>
 <PUZPR04MB6316B91DB1F5E14578C65C0A8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <52218ac9664b406d897ca3c0bd0bef5e@BJMBX01.spreadtrum.com>
In-Reply-To: <52218ac9664b406d897ca3c0bd0bef5e@BJMBX01.spreadtrum.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SE2PPF10E5687AA:EE_
x-ms-office365-filtering-correlation-id: d76f96e9-9a69-48d5-d1bd-08ddae58d10a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3ZsN3JhNWdnQkdibDlGZHpWWHUydVFzSkhCOWttVHc5RHg1Mm5WOWtnQmZO?=
 =?utf-8?B?R2tEZENka2QremdzVlppbUV0MjFWbWVGb1ZxN0hDdEJ2eHdpQXUxZytSMVhT?=
 =?utf-8?B?WFBZWGdNS2VPaGF2UENNYW1RU3U0aW82QXEyRU0xSEd3TU1uaCtvTG9kbjRO?=
 =?utf-8?B?Nyt3TGJGVDNoMWx3dVFHdi9waVlwbDFhR3lHWkVIUnRFdjVFSWlpMy9KLzR4?=
 =?utf-8?B?UlVvY09YSkNENDJqNmRtSCt3elQ5OTlWNUQ0S25Oc1FMTHUyL2kvRENTM3da?=
 =?utf-8?B?VFBoMVcvbjRoUUxaM1Jwbm1La09QanAveEdpeXduTXRaNm9YQTlKdklEaytB?=
 =?utf-8?B?ZHJBNmhFK0laM0Z4RWlja3hFQ0dkUnNJL2J3bzh3WThQY0JkQ1RWd05FSXFO?=
 =?utf-8?B?cm5zUGhDbnNFQ1pLQ2RaMXhtaS9HcHRCcEV1YlRFZzhuL2JoajhVcUt6NnpO?=
 =?utf-8?B?aXRxSXpCcGtmMXAzNTV5VUNTOUUvU1JNZVVpVjRwVXltYWo0dnZoZ255OW1F?=
 =?utf-8?B?ZUdyMktnT1ZodTRvbW14TDBJQXk0SUNadTdQZndjMDkwbVVDMnRIK0hMYnpT?=
 =?utf-8?B?aWlpOGNDUVNmR1JGeXdudkNlbHVPaVMzY1JCY3k0U3lob0NINGRIak0vOTU0?=
 =?utf-8?B?dStrSGpySmhmSEg5cGMzeW5YR0diNm1DMjQ0SmZWK2VydUxxemtJS3E5d3lk?=
 =?utf-8?B?MGlGWVdESk9YUzl1eTNlbzhjQW4xc2QwVWVnN3JFOW8yK3NtUzZJamFvbWl6?=
 =?utf-8?B?Qnh3ZWNESUNzYU9IQVJ4RjdlRTJDUldZdTJGMDBMTEJEYndSVU5xQXg1Yi9S?=
 =?utf-8?B?aGR2VEdzeTNpSzhLMmNWNjNkczcxcENEakdFK1hLaXdPdkFCbStGUTZ4QnU1?=
 =?utf-8?B?R3AwTmx1eUU2KzJHZUJqbWQ2dm1ER3d2YW5lS3RFLzVtb2wxRUVuaGVJVXh2?=
 =?utf-8?B?cHk5MHBCYzkwbmVtV3lGL1NTa1F5SFdlRlJKOXBpQkV3bEQ1WVhzaE13Vy9u?=
 =?utf-8?B?NkREeGFDY0puZzhpWXgxNGVmUlV5enhKV1NkYkducDJPRkVTSGdYUFZMclBK?=
 =?utf-8?B?bkNEYWhEemwvZmozUkFJdnpadWt4d2pnZVBkNVpGbEtjbWNjUVM5eTFXbVNT?=
 =?utf-8?B?K0N6dzRWbU10V3BGNklWaGo0d0dQeE9DNWRPRVo2Nmt4aVNaVjZ4WXErQ1JQ?=
 =?utf-8?B?NnlPQ3NpYzBFK2tTTGEzb1p2eU93YzZ4VTk2a2d6MFZ3Nm5XVVV4MisrYngv?=
 =?utf-8?B?VFE4aVA0Q091MFlwTEkwckdHeEVwYlgrQ0w1aWhtRURYTmFBdkNnbUt5YTkv?=
 =?utf-8?B?aHZSSFNFNkRWSzV1VXpEd2IrdkV3eGVBN3l3eEZlVFltSVRFQ3RkZmNwbitX?=
 =?utf-8?B?Q0Nmb3pDYWFQTWVaL2xWTkNZZlpZYjUvTDM0Qnc0WnA2RC9YZGhkY0huSFdw?=
 =?utf-8?B?SlFXY3lMUnNiaG8zN08zOTE2VUFkZ0RTNGJnTEwvcUZySlBDODFEbVBnanRy?=
 =?utf-8?B?QWM3OGR0ZVg1aFBTSWlrTzcwdDJFZ2N4MDJDMmtZTUhUU0JyMTN3cTZqK2t5?=
 =?utf-8?B?WTU2Q0JIL0tyTU1MMXd2clp0TmtOYTcwRmZKdVdLejYrQ1FZSktNdXY0cmNm?=
 =?utf-8?B?T1c1bUk2U1FhVmZFVm9yV3RGUUkzNFVKWEUxcGh2NDVqWU1zNE5CS1dOazgr?=
 =?utf-8?B?Z0h0Q2dhdkFpV0oySjdMMkp1d2lXVHB5R2hpT09SM09oclVPUEkvUllmMEZW?=
 =?utf-8?B?NHA0OXNmdkhtWGN3R2ZVY1VNTmlabWluR0xtWjdYeWhtam9FQmVlYXJLWVUz?=
 =?utf-8?B?WER1OWo2RkM3dUxDYVgvWXV3RjlkcmFocTRGazhacXVwOXFZRjY5aHZTQXZZ?=
 =?utf-8?B?OHA1TkRmYWxUMnZtM0VQOTFFMXYrMWkrcW5WUmVlM2JuQTRHTTVscEFnemcw?=
 =?utf-8?B?emVBVXR3VG1yRW9rSzc3NlhDbzRBaWhrejE4WVdWQzY2MUl3ZjlTQUl1c3hh?=
 =?utf-8?B?RHAzYWxnUk5RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmpVRzVtSzFaV0lOTXNPclNoL08zQTcwVGVRajBmNElkNm9na0RtdnBkUEhs?=
 =?utf-8?B?RjVicmJIS1NGU0E2L2MzaHl5K0l5N2dUeFRZVTg4a3RuVng5UmlVb2tPQjl5?=
 =?utf-8?B?RjY2bWNwdlplZ0tHVmp4UStrajFCaWZvMTQ2NHRtQWlYMkJTTXBtZ2FZaUpD?=
 =?utf-8?B?WHJwWkhkUnVwMnNacDV0dENWRndoOWVGYncxaFRRQVB3Rk5MV2JNRUFtNTRO?=
 =?utf-8?B?anluUWZxS1dwZFA2ay82b0tVdXAvUXVWaXRpRFFsYmVMdHNubExibUo5clVS?=
 =?utf-8?B?djBmVDFGbm4zT0svc1JkeEd5dUtxbTBWbEg2VHdVRUc3ZUNSTDhIKzMwdkJK?=
 =?utf-8?B?ZVZpZThlbTNTak9MQjJzcCtMRGZURUt0Q2ZCcFVZVExuQWNjNml2cTEvbUkx?=
 =?utf-8?B?NFFwRVZIczZXR1h6YzVBR0VXT1RHWHh2YkEvdm9kU05MN2VPZjNITE5sUmxN?=
 =?utf-8?B?aU1HR0l0MU9td3dHZmhTbi9KaEduVVBDa29HK3FFRUF4dmltNm50VVB6NTVV?=
 =?utf-8?B?SVRDSlBybzRlalF1a2FKZDV2SkV5Y3NtdWNiVzJyQWFCamRyb1FpbkxKeXg0?=
 =?utf-8?B?a0w3WUxSTm1Tei9TaWhwTjBTZjFYc0k5Ujc0SWJiVC9xQzNBREFxYTMrOFJq?=
 =?utf-8?B?VDg4TDJwVU1qVEFVSTA1VFFtUVpwQzZvN1hhelptd25WL2dwbDZZYjR1em02?=
 =?utf-8?B?cEwwbkNyZkF4eGN1YkgrOFZtMGR6N2Z4MlJXUHAzYlBwMTNuU3B4OUF2YmUw?=
 =?utf-8?B?anNaMzVSc1VmV2hXZ0dESi9RUTNMQklCaVdNQ2xsTjdBMDh0NnFXdFRac3ZH?=
 =?utf-8?B?ZnBwY2lCcXVqcEtzRU5qZSsva1B0N3RZdFpmTEUxd3NKbEQ4QUVRVzhiMmIx?=
 =?utf-8?B?b3Y1Snhkc3hQcis0TUNlQTVNWCtKaTFReEIrcktNeEtnTkEwakswR29odFVu?=
 =?utf-8?B?K2IxQnRJY292cnhEVFlOUGhkTWlJQjI5MWl3SmxvM2syUWdPTUtJVC9UTWRN?=
 =?utf-8?B?ZDF1eW14WE5BR1pxN2QwRnBmL0IxcnlVL2pxZWV4Ly9IbEpLS25aRjRzYlhT?=
 =?utf-8?B?eFgwbnZ5R1E4clo4TmVMMHZaTEZOVDFxMUxibEkzMUNOVzByUVloYVFDd2w2?=
 =?utf-8?B?dENwdVJOS1Q0bHFZRFcrdkpkTjRMWG5xdmpSdDZmVkZFZnFSV0tJUFJOYk1m?=
 =?utf-8?B?R3lqV3U4a3p2N1kySGkyTFZ4dzdiYkx5L0RNYTZBZW90MlRZL0VsMDJoRVJB?=
 =?utf-8?B?cG1lWmIzSlh0VU1zTHJmQXBIUVJHZFgxa2taQUluZnRTVHMyTXVNanZYZTc0?=
 =?utf-8?B?RmFIOUVNdTlkSjQwTzBTamRzaVVjcWVxdytRNkpWQUVubG1zWUpUNWxkY2dt?=
 =?utf-8?B?Y2JrbXpsM2pLYnFiZ3lTL0lZT3d1d0Z2b0pPeWhIS29rRjNVOEVPYzh2TjFT?=
 =?utf-8?B?cFFZdCtvdXFKdUxuQ2FBMG5rRXJ5ZEo4ZmFldUxYcWRCb1FUZGFVd0hsM0Rr?=
 =?utf-8?B?bzFFRlZWZUNwOG16WmdnNGRoempCUUkvOGlILzJkZ2ZndWZlYk5LTXBuWnpX?=
 =?utf-8?B?ZzdxSDB4MXBlU0FnMWROcTZPZ0NFU3BUbkorUTBtWTY3d2JMODhPS0c0RlpE?=
 =?utf-8?B?Q3owK3IrekxjeWhMTHNteDZSZEV5Yzd3U3c3aGp5dnZVQU9VSExnVVpFOVVa?=
 =?utf-8?B?dThEZ2hHNE9EQVBiamlFMGRtcnJKWWJ5UXBPVEhkYW1UQlB3bXBscStnbWdZ?=
 =?utf-8?B?OHpsQlF4bHREbnpFM2ZhNjk4eDBpcjRGdGpsQ3RTNFRtZ1o2UEt4c1ZhcmlB?=
 =?utf-8?B?VjhtTzh5bWlFWnc0N01hampLU0ViTWFmdDhWVE45bThaWkZsMEtyWEphdTl3?=
 =?utf-8?B?Sk5qb2NnNVZGT3cxUlgydlFEVGxKNEd4bHpLaXRMWkQzTlhxN05yT01MdzBz?=
 =?utf-8?B?d2NKNlVna1p3VTVMZGhrRzhObEJxMXJ6dkdhZiszYWtoVGFXT2lvZlplM1dh?=
 =?utf-8?B?OW9zTmdyRkRiVFRyRWM1ek9XOXFpMldKcUZNVWhwMk94a0hBTUxDRlY5NEhV?=
 =?utf-8?B?ODVjWG9KVTdoQXNidStmZmxJZ2tsSC9jMDFQK1hCUktDOTBBYnlIYlRMbzJW?=
 =?utf-8?B?eERQN005M3JLcEI3NTRVOTNTVzlIWUlPcG83RUNqZENZS2J5aldlTHpRS1A4?=
 =?utf-8?Q?/b/2og7hUhweaDJVFqFwOSU=3D?=
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
	XnsEZFj5Rqp+MmlpS0J3ZVYg7XPLudDf/04bIz2muO1iJotBBsrALlV/xCeHAGFeEhNsmVcXX+w3XDya5DddQZ+KBEU25rJkYu+Fd0ZV5e+pQDYXiNpLNx2dU5RNqlUSPQZLtUexSYeylCwfQk0kjQmqsByiGhWu0RQ6Mh7dwfLWw0VUZW91WyA5NoPBLZptCRcnHcI7kTEHwavYFXnF/PfXfmyCzUHs+PKFUh+kQhevi/dsS5sI/G7g9jvb/AyWmsHhn+j3K3nTfFAEOravTAyuX0izdm2dw4hJSWIrjNEi0MgL0jUB2gAkJb/0nwS+QoBYoLLYxinEag6Rp72fvzG5KR1cv9hIJvidZDEQNLRtHGTZPnPCAoBIz/Hhjn2TpOP1/9dQTNP72BQ/0ZfE5gIE7j9A9CPMC6CoWkvOpG6lBnytJcGRkcV2h7lPawbyi31M7pqjR131kRvjASAwDmXDsBBzGtjtWJPHTTQGNswcZE7rXdtljJp3J6pPSUHfFd/RJOj8+DTZbHQuojki1vWQ7bXFKOYRF5PG+HqBLtnWzWgO9zHZGN0RYBfQKGO7w9gwA+/vjRpnxHNZK7H1nj96E/jLK+PC6zcdMgvtjZy88ZUTYENhDl27bye2WqP5
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76f96e9-9a69-48d5-d1bd-08ddae58d10a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 11:11:04.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQGIXyjVW4EPWCZpIRa3qgJ/+UOG+WANBXNT5LItgHN2h6lGgJIx/okxBUHY2n+w7KHsKei+uPTpbCFi675IqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF10E5687AA
X-Authority-Analysis: v=2.4 cv=cqGbk04i c=1 sm=1 tr=0 ts=68529ed0 cx=c_pps a=gFJVHZCVAhmtLL1cVVoHwA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=ORuLHrG8YFrWWVR4hEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GqxZRKPLqit8JcHHdaUkA33ANw7aBtVV
X-Proofpoint-ORIG-GUID: GqxZRKPLqit8JcHHdaUkA33ANw7aBtVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NSBTYWx0ZWRfX8Kallei73l/J bV5RgvUwDjPtaqYQxpUQF1r+7z7b49+OCzoIKc0/ftHW6QSvtKZkIONqf1HFvltS6MFV+GHzIAr JZ2fvVpsxH3h1jc2HUvCZPN69DeCaw+8lTj0pSu5y94nKCmnHUaRZcaY9CggSqvrexOoU8IsY83
 b6tUMC1Wu0CibUcz176unXBcHIzBCyE7lZYIPuWZXmHbE+zspUP5hfa8nDAmquhr+PObTO+TYXM AUlrUjSFBJWL4UYY8k7hRKlu2UgTlnkiVrLmBtCnhhGzxaz7VZmdMKtKySNC+bRKwpG6Lt4KADD aofS/rdZxXLAVGCOfpUNd9h3ZaDYk9kqIRzWyNX5F4dSeIt8/H/jOen6+XUM1uvBueho0xPq6nu
 Bnj0Dh07M3dKRyl+2jS2rbrCGISlUPQGcz6aLHccRE3qfeYhnVkLlnTz6andB5AJoFJDaPOd
X-Sony-Outbound-GUID: GqxZRKPLqit8JcHHdaUkA33ANw7aBtVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01

PiA+ID4gPiA+IC0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYwo+ID4gPiA+ID4gKysrIGIvZnMvZXhmYXQv
ZmlsZS5jCj4gPiA+ID4gPiBAQCAtNjI1LDcgKzYyNSw3IEBAIHN0YXRpYyBzc2l6ZV90IGV4ZmF0
X2ZpbGVfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsCj4gPiA+ID4gPiBzdHJ1Y3QgaW92
X2l0ZXIgKml0ZXIpCj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgIGlmIChpb2NiX2lzX2RzeW5j
KGlvY2IpICYmIGlvY2ItPmtpX3BvcyA+IHBvcykgewo+ID4gPiA+ID4gICAgICAgICAgICAgICAg
IHNzaXplX3QgZXJyID0gdmZzX2ZzeW5jX3JhbmdlKGZpbGUsIHBvcywgaW9jYi0+a2lfcG9zIC0g
MSwKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9jYi0+a2lfZmxh
Z3MgJiBJT0NCX1NZTkMpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoaW9jYi0+a2lfZmxhZ3MgJiBJT0NCX1NZTkMpID8gMCA6IDEpOwo+ID4gPiA+Cj4gPiA+ID4g
SG93IGFib3V0IGNhbGxpbmcgZ2VuZXJpY193cml0ZV9zeW5jKCkgaW5zdGVhZCBvZiB2ZnNfZnN5
bmNfcmFuZ2UoKSwgbGlrZSBpbgo+ID4gPiA+IGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyKCk/Cj4g
PiA+IFRoZSBzZWNvbmQgYXJnIG9mIHZmc19mc3luY19yYW5nZSAicG9zIiBtYXliZSBjaGFuZ2Vk
IGJ5IHZhbGlkX3NpemUgKGlmIHBvcyA+Cj4gPiB2YWxpZF9zaXplKS4KPiA+ID4gSXQgY2FuIG5v
dCByZXBsYWNlIGJ5IGlvY2ItPmtpX3BvcyAtIHJldCAocmV0IGJ5IF9fZ2VuZXJpY19maWxlX3dy
aXRlX2l0ZXIpLgo+ID4gPiBTbyBjdXJyZW50IHdheSBtYXliZSBiZXR0ZXIuCj4gPgo+ID4gSGVy
ZSB3ZSBzeW5jaHJvbml6ZSB0aGUgYXJlYXMgd3JpdHRlbiBieSBleGZhdF9leHRlbmRfdmFsaWRf
c2l6ZSgpIGFuZAo+ID4gX19nZW5lcmljX2ZpbGVfd3JpdGVfaXRlcigpIGlmIHZhbGlkX3NpemUg
PCBwb3MuCj4gPgo+ID4gVGhlIGxlbmd0aHMgb2YgdGhlc2UgdHdvIHdyaXRlIGFyZWFzIGFyZSAn
cG9zLXZhbGlkX3NpemUnIGFuZCAncmV0Jy4KPiA+IFdlIGNhbiB1c2UgZ2VuZXJpY193cml0ZV9z
eW5jKCkgYW5kIHBhc3MgaXQgdGhlIHN1bSBvZiB0aGVzZSB0d28gbGVuZ3Rocy4KPiA+IO+7vwo+
ID4gT2YgY291cnNlLCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdmFsaWRfc2l6ZSA8IHBvcywgZXhm
YXRfZmlsZV93cml0ZV9pdGVyKCkgb25seQo+ID4gbmVlZHMgdG8gcmV0dXJuIHRoZSBsZW5ndGgg
d3JpdHRlbiBieSBfX2dlbmVyaWNfZmlsZV93cml0ZV9pdGVyKCkuCj4gCj4gSSB0cnkgdGhlIHN1
bSBvZiAncG9zLXZhbGlkX3NpemUnIGFuZCAncmV0JyxsaWtlIHRoaXM6Cj4gICAgICAgICBpZiAo
aW9jYi0+a2lfcG9zID4gcG9zKSB7Cj4gICAgICAgICAgICAgICAgIHNzaXplX3QgZXJyID0gZ2Vu
ZXJpY193cml0ZV9zeW5jKGlvY2IsIHBvcyArIHJldCAtIHZhbGlkX3NpemUpOwo+ICAgICAgICAg
ICAgICAgICBpZiAoZXJyIDwgMCkKPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Owo+ICAgICAgICAgfQo+IFRoZSB0ZXN0IGNyYXNoZWQsIHRoYXQgbWF5YmUgaW8gZXJyb3IuCgpJ
IHRoaW5rIHRoZSBjcmFzaCBoYXBwZW5zIHdoZW4gcG9zIDwgdmFsaWRfc2l6ZSwgYmVjYXVzZSBl
eGZhdF9leHRlbmRfdmFsaWRfc2l6ZSgpCmRvZXMgbm90IHdyaXRlIGRhdGEgaW4gdGhpcyBjYXNl
LgoKPiBTbyBJIHRyeSBhIHNpbXBsZSB3YXkgdGhhdCB1c2UgaW9jYi0+a2lfcG9zIC0gcG9zLiBs
aWtlIHRoaXM6Cj4gICAgICAgICBpZiAoaW9jYi0+a2lfcG9zID4gcG9zKSB7Cj4gICAgICAgICAg
ICAgICAgIHNzaXplX3QgZXJyID0gZ2VuZXJpY193cml0ZV9zeW5jKGlvY2IsIGlvY2ItPmtpX3Bv
cyAtIHBvcyk7Cj4gICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7Cj4gICAgICAgICB9Cj4gVGhlIHRlc3QgcGFzcy4gcGxzIGNo
ZWNrIGFnYWluLgoKJ3BvcycgaXMgc2V0IHRvIHRoZSB3cml0ZSBwb3NpdGlvbiBvZiBleGZhdF9l
eHRlbmRfdmFsaWRfc2l6ZSgpIGJ5OgoKaWYgKHBvcyA+IHZhbGlkX3NpemUpCiAgICAgICAgICBw
b3MgPSB2YWxpZF9zaXplOwoKJ2lvY2ItPmtpX3BvcyAtIHBvcycgaXMgdGhlIHRvdGFsIHdyaXRl
IGxlbmd0aCwgdGhpcyB3YXkgaXMgZmluZS4K

