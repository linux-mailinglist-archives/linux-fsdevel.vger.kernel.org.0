Return-Path: <linux-fsdevel+bounces-56628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1BAB19E09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854C7189A35C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D4242D9E;
	Mon,  4 Aug 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UyOXN8oC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3B242D8D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297836; cv=fail; b=FxhcSH/jL2dd3Muo4SWddM9uYO0hK9iAKCz3XlcG5p4hChFE2/UJFc3EjhZggNxYXgb77nFHe44MDnPilnEcXngEJxp/rCMkk5S+xMxA8y56twmqhnF5uMHfTGnw97mB50qgi1MP8iFg5uHNR+xlaOSlXrxPCBJGXZYi0K3plHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297836; c=relaxed/simple;
	bh=/38EhgfysUpePa2yJHXF2e1VmMdyNA+/4wepY72hdhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RvSyGOmgq2C1H+a3Ad+X7VMiSQjkVrTC9585i4RYaLNINuqB38lX52ng7KbCLKSWnHfCbopVBwLKTmfVDjqxykPWAkOT7HdnYCdTzSI2rghy3VtI6RlV9Vh1sAqEsiOQ6G7Syvxd4UYvfRGlZmyWavT6Of1/N2LS8xRxZQBIGog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=UyOXN8oC; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NZEPs004491;
	Mon, 4 Aug 2025 08:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=/38Ehgf
	ysUpePa2yJHXF2e1VmMdyNA+/4wepY72hdhM=; b=UyOXN8oCqe4uxaA8gjO2qll
	cRq4FbfcyZAqUUikCAEEK8xahsGuUMOEOBFfvkWr0qzE533Z0Geyy2GZfJLQNnqm
	ix2ILLpEcgtQqTDtnURJm2DroHl8dmml/5y0UpHuYDDoS7Q5cYdBRUqfaniaU57M
	RK5dr1OhHCIf0ps66emN0U6HG/s1iMeI7oo0BtetDIuObFORZ+Rq7kL4CYRwi2aV
	oFyXAEhnujkpdrxFJBTuRuB9tRjc6oRYpiejg/siQuqwsnXJCJ3bgxyOCJb5AxAA
	AdRDX3+mSvYk2FKZAKdLh7bdWzBb7SoSPM0u1Mg6oALza3znp4XyxuRlWeHwfUw=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012061.outbound.protection.outlook.com [52.101.126.61])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4898vj9m1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 08:56:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eio8kpKvJUo3cJaFhSaHQwOXxQk10nJGd148i2mNgc5uMC+vHyPp5+/OuxSI6YC8AhGNAaZf5QqLp4rCasPSGhSekJQLW46Dw9hy6Ok7im6TYrdfCO5knjE4kFfNj2n6T6NrrDb79fC76zp0LTFZH11uaVXGXVZaO6nuPnlVXXFZ3JFsrj45UrldynRFMJP8JnK7Zvi9KEJ3Vl+Yl9oXCuiId7uXVWQoUbGqXIqKehjmYSC/Z6PJyZ7HesYfHlOXBPOhK+TH5fIRJYXusXeruCyP/9GHarItM4o0O1SHCVcEoxY7or34YI0KogeYxAj7HAypb6ISrDLV6am8ZLP7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/38EhgfysUpePa2yJHXF2e1VmMdyNA+/4wepY72hdhM=;
 b=IDBIstF3cjCrJ25jcS+RuVmxcBuzmoGuoHKo2kxqcUHDRmKHKv4cqH02/nFQK4uLtxIwXSy7uDMX+9qZUq3lcifNR2EJuAyYO7k7+feJcT9Y4RNX69OaNNrMxOWg6ZuQNCBFP9XYGzDMOZuL7A26rsp/NXP8F/33l29Wrdju8A6MWShnVHv4gi4fulOQWU8OzFCcwvLpy/FKRoCJqolsBzuIRtmhOjhJy55U6597j1f+/KJ36a0JPC1qz0lDR3jlkCv1Hsn/EpTQRlgiJkCvLylOwTgS+WgYH1L/CMfTh70dYQz/NTjvcgLhGrFPsMD1DFGQrcIRg929S3o3qtW2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYUPR04MB6890.apcprd04.prod.outlook.com (2603:1096:400:356::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 08:56:42 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 08:56:41 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: optimize allocation bitmap loading time
Thread-Topic: [PATCH] exfat: optimize allocation bitmap loading time
Thread-Index: AQHcAnlexXVdV2orAEGaDpRsE4C0gLRNZ6AqgAQpYICAAKSvwQ==
Date: Mon, 4 Aug 2025 08:56:40 +0000
Message-ID:
 <PUZPR04MB631671AF6B812D54A033C4598123A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250801001452.14105-1-linkinjeon@kernel.org>
 <PUZPR04MB631623977A900687BA21F92E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd9sFBN+7=8xO35dY4adNRsuvTMbRuyPkMF6=k40QJCRhQ@mail.gmail.com>
In-Reply-To:
 <CAKYAXd9sFBN+7=8xO35dY4adNRsuvTMbRuyPkMF6=k40QJCRhQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYUPR04MB6890:EE_
x-ms-office365-filtering-correlation-id: 7565f98e-68c2-4c2f-1b39-08ddd334d42a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWxUUDF1c3JNckRqZzVsSU9taGk5YjdKczBTcG4wREd6WE9neVU2QVR5MXZj?=
 =?utf-8?B?K3ZYbnVDTmpaR2hhVU9lWmpXcU1VYmFKZ1VLU1BiUUV6QnRIQ2lMOWJEc2hM?=
 =?utf-8?B?eThLbW4yNVBtSFo1aG8wNkoycmZUV3NIeGhtdWxnc2RQM3ZmRnJJUHIxNFpO?=
 =?utf-8?B?VnhUMk1neU5wODIyMlYvemVRYzUyNTBxeW9sMVJLVXRiQUs2Um05M2pmeHJZ?=
 =?utf-8?B?bE0wMWk1aE92M04zeWI5SzB1eGdYWHVCN1BOWTFLbEdxMXZ1QWRFSlN0Q3Zm?=
 =?utf-8?B?VDhxY3c0Z285eGdQTU5jVm9GNEdFOCtxSWdRQXdwdHQrb3JSUWQ5emVsQXB6?=
 =?utf-8?B?bnpOMzRJR256VzJ1UmNLcGVFKzhSWXc1eHlnVC9YdlljalN0RmRvMnlsOWlW?=
 =?utf-8?B?YjRoRk9lMGZJUFdPUDF5ZmxqS1VWOWlnR1hMWFYxZHcrQnVzcTI0T0taTzBR?=
 =?utf-8?B?aWxpa0dqWW5MTUtnV1hzK3lKSzJJZjA4blhUZnNoTFh4ZEJVSW5UbTlueXIr?=
 =?utf-8?B?aEpMV3JlbFFDQnRIZmRHOFF4V0ZvNXAxVkYwUStIMkZobC8xZkRSK1V3V29N?=
 =?utf-8?B?UGdpdVpjK3BySXpGZmR6WC9KQUFubHNjQThaeTgxWTR2UU1tSUVDUlcyMk8z?=
 =?utf-8?B?dFpybXRQV3lUbS84TnBCenF3SlQyMjlQTWlwZWtwMGVUSGhDYXFuN2lzcEIw?=
 =?utf-8?B?Nk9aSGk2bGhWNHU3ekJPZUFJUzhPYTgyWWQ1aU5vV2hqeUVIUGYxUy95K1dJ?=
 =?utf-8?B?WjJnaXRVdkNFa0hzc0tvbldzTFdnN3NLNWJRTEVEbG1neHBnQ2lGSHhMVHZQ?=
 =?utf-8?B?cTFsQkxkMmVacmxsYkdwQVNKL0FKWFlERWxpK0NFd2MybE9JOUNvZ09qYzkw?=
 =?utf-8?B?SzJreUR1aTE5LzBVUUhSMWx3aTRJNkRuK2ptUEpGQjFEQ01WcG9pM1lNd0g1?=
 =?utf-8?B?MWlnN2RPQXk1b3BLaUVmanZQYTJpTEYxR2ZNZVhYL1VpcTJTbU0yRllscFpl?=
 =?utf-8?B?MDArM3ZyUWhCYm41OGlrVGlyMlM5Q0NWcS9EbHk3TTc1eGJLUTJQMHNWVys4?=
 =?utf-8?B?TkJheEU1Qjd6dHFSV1hsWXlnQkpiODBuaGtmNHNnK3BybEowM2YzcUN2RXZQ?=
 =?utf-8?B?Z0JZZTc3cWZQR1VvMU1jdEFIRnQ2K09VUkVXM3NId0ZBVDc1SWVzOEZmTXly?=
 =?utf-8?B?aGNJZ09oNk5pYUFuR3pOUlFpck1xVUI2aklncVdnWlJFMUxjait6N25xUlNV?=
 =?utf-8?B?Ym8yMWJzdE9EWTdXUEoydExnTlQ3QjY0TEtHOTNka3dPbFdqc1p1c1JONjF2?=
 =?utf-8?B?eEdLNGRwNDkxV0M2SXpqU1FwL29vYTBEb0hyYlFzSEk1OTJqNnhHdkRtOGpu?=
 =?utf-8?B?MHFuWjhVb25qYzNyTFRtOHJNSjlEYmVwU3hGVm8zaVNjNFpITFVqUEMxVmkx?=
 =?utf-8?B?Yy9Dd1V4cTNMQjVBYzJrWlVjODJwY3lDK21LcE1iS2lhcmprbU41UjEvQ3Bm?=
 =?utf-8?B?bVpneDJaN2lXOEN2UnhuY0hTUVl3eEJaUTIzY1JVeU5SbjZBSnl5TEdiNXU2?=
 =?utf-8?B?SkUzUGwwOFJaYzJ3TVMrczJqMEthQVVxelFReTMrVitwZDg5L2xNSnBsemVC?=
 =?utf-8?B?d1lvQzcweWtPVGxQZFdCQUFoanBWdHhYbWtDYTB3VXZaMHREYW9tOWRnV0Ju?=
 =?utf-8?B?ZlphTUxjWTlTZjVFemRDbUZ0YmUrcy9GdDM1K0lqQitzd1BrM0lvVDVya1l0?=
 =?utf-8?B?aW04MUFVMFo3YUFOK3VZdFFCc0EzZFA1Q0d4QmRObzBWMS9Jb1pKN0xkNy9u?=
 =?utf-8?B?QThNaGoySmZxRDZ1R3NCYUV6WWhuT0MvZ2JiRkNlOHFSeWc4cDJpU1ByQ0Zi?=
 =?utf-8?B?akxNRGowaWxjQXhUT0FsaUxFWFVqZC9La1kxWUNjWUxUSG9UdnBlQ2dHeHZ4?=
 =?utf-8?B?Rk56MTc2MnV1SUI1N1NWY1M1eWJEL2lsajVBWEk5SlNiRFJYZHJLYzdoclJE?=
 =?utf-8?B?YkNWMWRQRHh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmMyR0kzWHgxNFJ6YzU5ekF3YjNhZjR4TlJvTFBtM2t1OXpmUENWOHB3THZt?=
 =?utf-8?B?VU5Ha3RuT3Q5WFB1Wldvc292SXlwQlI3ZU96dXlxNS9PL0FpUHhnYitkUnM1?=
 =?utf-8?B?NWVYT2FiNmMyQ3Q2ZGNtMHNtNUphM3YvT2M2NnNxR1Q1eHJOWkIvbG9FTkpk?=
 =?utf-8?B?eGlwRXhXSU96cVJJbHMrNmN1UG9GbzNmUDRMYlVhSi9nVDZwaWFiVWN4NWZv?=
 =?utf-8?B?MWFucUh5WGEvVXVlazA0RVVEOU9ZN3lnbFBiN3JLdmVTcndFczFrNU5Wb096?=
 =?utf-8?B?Wlphd3lXbHZSNnNmWVNOVmxwbmJyam9UUGRvdGJWWDRLSUg4SEF0L1BvQWVw?=
 =?utf-8?B?Y3p3WE9BRFBnU2pkNTgwc1BCcHlhWkNuK1d1SHo0T3lZVURxN0VrTkJQYWZx?=
 =?utf-8?B?dnA5NFROZTBpNU1YbmpTb1o5NWJwM2ZMQmQ1NnVwS0ZDZ1M0UVZCZVdJS2Rh?=
 =?utf-8?B?QURwYXJzMWhhakZwT2RFRWszUlRFS0xSTXNQdHRVQk1oM3JURDF0WW5jYmhi?=
 =?utf-8?B?UHdYSUtGZ2tRY1pRTnkweDJXT2NQeW5weUlhbnl5QUcwYWhtd1BpbW1UT0NP?=
 =?utf-8?B?R2N3L0RjekRMaWVPRHNqVWxlVmVxSGZuZFBWblZEdW4zTXNyMmpaSGw3cEJB?=
 =?utf-8?B?V0ozMUNBbVZEclZRayt2Vy9LMWx6K290WC9EM1RvaUZ5cE5UejcvcmdCUnVt?=
 =?utf-8?B?RHE4UmhSanprWWdtOWFKdElaUHFYMVRDdWdITzVTaDZIWWtaQU1MMTh0L093?=
 =?utf-8?B?MGlCY09Sb2djOGdDL21GZEpMQVVyYldWM2tiVXRwaWZuR0k1WGxOd01ZUStz?=
 =?utf-8?B?amRnZitoLzF5SGowUW9iaVVDSXM4V1VPVXVPVEhmTjNnUlIxdHJVM2RMR2RX?=
 =?utf-8?B?TXg2T2dES0xOY2xyQkt2OVJORW85V1F6NkxkUHRLNFdsWVlQcEVmZXlWZ1FI?=
 =?utf-8?B?ZEl4UjRyS2FhcFNka1B5QnNnSEhaSW9DNWZnMUhhMUVydkhZd3IzMUc3cVZU?=
 =?utf-8?B?WWtmTUFXSnY1cEoyT0hXQVo5OThMZkc3Qlg5SXRrTldOVTIxdmlzdkdvRGtT?=
 =?utf-8?B?S0JZNis4SWo3emp3QWtBcGFlQnd2cTEwek9tR2VXdjBHMyszOUdFK2Y0bk4y?=
 =?utf-8?B?ZzFNU0NTSDhzMU13WTM1N05Dam5qSkp2ZGVlOFBVVFAxaE1QTXRCbjM4YlJB?=
 =?utf-8?B?SGhURitURFF1NGt2UjhqSEkwMnBYemhmcnNORExTcnphY2tFRDRIUzhiandy?=
 =?utf-8?B?a3NiczB3eUpHQldMUnRQOUNIWTlTS2lxR3JxVFBQeVBXdUp1WWhGODVOSG9y?=
 =?utf-8?B?Q3QvS1pjamxWYjR0SjZodjY4bUV2WFRHelkwUmdOU2pKUTNtbWw1eDk0VWZl?=
 =?utf-8?B?eWJBOG55YmMyb1piQ3V2bWhvOGlneXdKVXNsTlN1aHdHVXVqdUordEswbmRn?=
 =?utf-8?B?ekRCbUhRaDZQWUg5R0hrRDhQNm04ZWdaa2haeW9WanBER3BIbXdqeTI3QXNK?=
 =?utf-8?B?UlNCZXhKcVVQSlBnZWYyb2ZTRXl3VFF4QTdORDA3UW9uc2tGczZia0ppY3FZ?=
 =?utf-8?B?SFJHdm5VTjFyOTB4RnFMdXF5MnErN3ZXcTJSalRZcE0xYUwrUGk5SERxUVRn?=
 =?utf-8?B?a29aOCtIV1E3QjRzL0lHb20wbGRCcEFKL0c3cm9qN3VVWmJlUU5WdGFmRUph?=
 =?utf-8?B?ZEtLRElxNjBzM0ZyNUpnWXJjblpoMlp3YzVrN2wvd3FpZERleHNMK21HTFMz?=
 =?utf-8?B?L0dERXBRSitQZ2V0Nzl4em1DWlhHUTlkMDdaQ29sZWlJTWFYMkhtTm1LS3Uy?=
 =?utf-8?B?ZGFDNmNmeG5hZlF0RThIMjdhTmxhaGFrVkNIYk1ZODdwbzJHVGtKNlUyY21Z?=
 =?utf-8?B?TVR4NTRFRHRYSnRHOWRWVWdsZXliWE8vdlpYdmR3SG1NcUVqNUZKaTV0NWJT?=
 =?utf-8?B?OVg2T0J0VkM4VnBvYzNYK0pUT3A3Y2FpdENtSEhQZXlwMTVZZlJkbGw1Rm53?=
 =?utf-8?B?czBFNEVSVVhQZ2l6a211RTRMRHZIb29yYzRzY2NvYkQ3RUxLRHQrVk4ybUJZ?=
 =?utf-8?B?YnU1ZExtK3k5eDlxY2ZUUFhqOFRuVE9UZE9mcVdkMGI5U2cxbkhGVnJTbHkw?=
 =?utf-8?B?WUZtS3dzVnIrd2FaNDB4RkpKMThKMEFPNWwwdlNnTGRVQjE5VlZZYXMrKzJN?=
 =?utf-8?Q?XJTyC41vVKMRGTzpT+g6oCo=3D?=
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
	8wrWz4neU8CPW4O6CeXiCjyJBlf/Vp7ZF/b9TnF4uC2EYfdVbfEMw2lHZ2HPeaEbuF8UIbwz+QuuPTiGbU9Gnd03ZBOBl4iDztaAYVGCuKEhHZj3zYo4IxJ5dRR1P4JXdUmAdygkCE8V1NWqrrJe1p2pZ3Ircb+ZAMPwmpp5F/8n8aUTeXWikvU+s9uv4mrg1Nox95zksTAO0tIV41cgT/oP/Czq+rFqyBB68fuPZNS40bbnBzB5OL/qnXqKo7t6XdVWAXdeB0twZg/7XdqmpMko8niYCZ/6yT1v00vtsgfL6l9HbMrp0BKxTM/Cnn9/2NVmFu8Gnco5l1uoAyvOKmeELFrYHpRVj+7Kh/70qmrzTP8+Xb7np8YMXallUH83SHdZDU2sRWC+wwK7YjZCuZE4uf6tw+4avtbNVIgtUdcldXiitq0CnmsA6hddYBYT3ZsJT/I05AJYg25H9pIxdVVTlyzLGtPiP3+JeozjoThOAnnnVI/lz2JTph/bHVsc8OXqsXWDRmYwuS/cam7J1SxoxB3LghgvVNTlQJuHyHMsi3I0pzCuR/CzOaHXeBq/58wpJKBZxp7cudPe7CZRf5kATTaknz59cn8r4LOugVBwBuPzE3OLjKUG1ydxnmuV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7565f98e-68c2-4c2f-1b39-08ddd334d42a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 08:56:40.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoaCAbnsyVDzurCcwLQ10kmvTCbVzGZJg7EV3RTeFbmNsl3svdNNVRrKRzvJXZ5kvuDaDtItwwZK5XslAGalQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6890
X-Authority-Analysis: v=2.4 cv=BrydwZX5 c=1 sm=1 tr=0 ts=689075d3 cx=c_pps a=qeAktAfzmfXJUkKahksSlQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=0usUuScLJ0GHBQ4oN78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P9FY5xJyUvBXzMBuOT-OE0Wd2HCoAPcC
X-Proofpoint-ORIG-GUID: P9FY5xJyUvBXzMBuOT-OE0Wd2HCoAPcC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0NyBTYWx0ZWRfX5C3Vkj2yw60P E7PK9KBi3jOsGD709VPuKU2+wl/vN3PAinZNKJo35jDfByeNwCi1x2YRNduMTsyu89LX/I0/V0s FAo8k/53+k8ipnK2z6S6tLYliIg+GiPW29cDjDo0cMZX6jWR3Jh8qHecx8qutIkOF9TqvmoNf9Z
 r3Y/8VMoyePUboA+FupuMym4hOptnLkt49Cqgmwac/GBisOXbsAj1gijWINnnqo0K5yjnU0n0LN OYZgzwHYajcSsqViySL1LeUmT+VsCBr57mbw4u5HzaAzE61IN9/ZOsHqLbk9zHxZfXfMLU2Am+C 3Yk3Gung6Z1SXyZM1IIpdFkdIfrLvAwCa3/NoR+vzkGQ1SL4aUzQLkbNBZZR+qoSS1wUeMUvxDQ
 gvD6buolK69sSCM5LjssWguhTow9swDf/c33wgLymwBNy+1ygTOJrXcJyH7R3YI2c3FDqtS5
X-Sony-Outbound-GUID: P9FY5xJyUvBXzMBuOT-OE0Wd2HCoAPcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01

PiBPbiBGcmksIEF1ZyAxLCAyMDI1IGF0IDU6MDPigK9QTSBZdWV6aGFuZy5Nb0Bzb255LmNvbQo+
IDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4gd3JvdGU6Cj4gPgo+ID4gPiBMb2FkaW5nIHRoZSBhbGxv
Y2F0aW9uIGJpdG1hcCBpcyB2ZXJ5IHNsb3cgaWYgdXNlciBzZXQgdGhlIHNtYWxsIGNsdXN0ZXIK
PiA+ID4gc2l6ZSBvbiBsYXJnZSBwYXJ0aXRpb24uCj4gPiA+Cj4gPiA+IEZvciBvcHRpbWl6aW5n
IGl0LCBUaGlzIHBhdGNoIHVzZXMgc2JfYnJlYWRhaGVhZCgpIHJlYWQgdGhlIGFsbG9jYXRpb24K
PiA+ID4gYml0bWFwLiBJdCB3aWxsIGltcHJvdmUgdGhlIG1vdW50IHRpbWUuCj4gPiA+Cj4gPiA+
IFRoZSBmb2xsb3dpbmcgaXMgdGhlIHJlc3VsdCBvZiBhYm91dCA0VEIgcGFydGl0aW9uKDJLQiBj
bHVzdGVyIHNpemUpCj4gPiA+IG9uIG15IHRhcmdldC4KPiA+ID4KPiA+ID4gd2l0aG91dCBwYXRj
aDoKPiA+ID4gcmVhbCAwbTQxLjc0NnMKPiA+ID4gdXNlciAwbTAuMDExcwo+ID4gPiBzeXMgMG0w
LjAwMHMKPiA+ID4KPiA+ID4gd2l0aCBwYXRjaDoKPiA+ID4gcmVhbCAwbTIuNTI1cwo+ID4gPiB1
c2VyIDBtMC4wMDhzCj4gPiA+IHN5cyAwbTAuMDA4cwo+ID4gPgo+ID4gPiBSZXZpZXdlZC1ieTog
U3VuZ2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgo+ID4gPiAtLS0KPiA+ID4gIGZz
L2V4ZmF0L2JhbGxvYy5jICAgfCAxMiArKysrKysrKysrKy0KPiA+ID4gIGZzL2V4ZmF0L2Rpci5j
ICAgICAgfCAgMSAtCj4gPiA+ICBmcy9leGZhdC9leGZhdF9mcy5oIHwgIDEgKwo+ID4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4g
PiBkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvYmFsbG9jLmMgYi9mcy9leGZhdC9iYWxsb2MuYwo+ID4g
PiBpbmRleCBjYzAxNTU2YzlkOWIuLmM0MGI3MzcwMTk0MSAxMDA2NDQKPiA+ID4gLS0tIGEvZnMv
ZXhmYXQvYmFsbG9jLmMKPiA+ID4gKysrIGIvZnMvZXhmYXQvYmFsbG9jLmMKPiA+ID4gQEAgLTMw
LDkgKzMwLDExIEBAIHN0YXRpYyBpbnQgZXhmYXRfYWxsb2NhdGVfYml0bWFwKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsCj4gPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgZXhmYXRfZGVudHJ5ICpl
cCkKPiA+ID4gIHsKPiA+ID4gICAgICAgICBzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhG
QVRfU0Ioc2IpOwo+ID4gPiArICAgICAgIHN0cnVjdCBibGtfcGx1ZyBwbHVnOwo+ID4gPiAgICAg
ICAgIGxvbmcgbG9uZyBtYXBfc2l6ZTsKPiA+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgaSwgbmVl
ZF9tYXBfc2l6ZTsKPiA+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgaSwgaiwgbmVlZF9tYXBfc2l6
ZTsKPiA+ID4gICAgICAgICBzZWN0b3JfdCBzZWN0b3I7Cj4gPiA+ICsgICAgICAgdW5zaWduZWQg
aW50IG1heF9yYV9jb3VudCA9IEVYRkFUX01BWF9SQV9TSVpFID4+IHNiLT5zX2Jsb2Nrc2l6ZV9i
aXRzOwo+ID4gPgo+ID4gPiAgICAgICAgIHNiaS0+bWFwX2NsdSA9IGxlMzJfdG9fY3B1KGVwLT5k
ZW50cnkuYml0bWFwLnN0YXJ0X2NsdSk7Cj4gPiA+ICAgICAgICAgbWFwX3NpemUgPSBsZTY0X3Rv
X2NwdShlcC0+ZGVudHJ5LmJpdG1hcC5zaXplKTsKPiA+ID4gQEAgLTU3LDYgKzU5LDE0IEBAIHN0
YXRpYyBpbnQgZXhmYXRfYWxsb2NhdGVfYml0bWFwKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCj4g
PiA+Cj4gPiA+ICAgICAgICAgc2VjdG9yID0gZXhmYXRfY2x1c3Rlcl90b19zZWN0b3Ioc2JpLCBz
YmktPm1hcF9jbHUpOwo+ID4gPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzYmktPm1hcF9zZWN0
b3JzOyBpKyspIHsKPiA+ID4gKyAgICAgICAgICAgICAgIC8qIFRyaWdnZXIgdGhlIG5leHQgcmVh
ZGFoZWFkIGluIGFkdmFuY2UuICovCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoMCA9PSAoaSAl
IG1heF9yYV9jb3VudCkpIHsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYmxrX3N0YXJ0
X3BsdWcoJnBsdWcpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGogPSBpOyBq
IDwgbWluKG1heF9yYV9jb3VudCwgc2JpLT5tYXBfc2VjdG9ycyAtIGkpICsgaTsgaisrKQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNiX2JyZWFkYWhlYWQoc2IsIHNlY3Rv
ciArIGopOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBibGtfZmluaXNoX3BsdWcoJnBs
dWcpOwo+ID4gPiArICAgICAgICAgICAgICAgfQo+ID4gPiArCj4gPiA+ICAgICAgICAgICAgICAg
ICBzYmktPnZvbF9hbWFwW2ldID0gc2JfYnJlYWQoc2IsIHNlY3RvciArIGkpOwo+ID4gPiAgICAg
ICAgICAgICAgICAgaWYgKCFzYmktPnZvbF9hbWFwW2ldKSB7Cj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIHJlbGVhc2UgYWxsIGJ1ZmZlcnMgYW5kIGZyZWUgdm9sX2FtYXAgKi8KPiA+
ID4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMKPiA+ID4gaW5k
ZXggZWUwNjBlMjZmNTFkLi5lN2E4NTUwYzAzNDYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2ZzL2V4ZmF0
L2Rpci5jCj4gPiA+ICsrKyBiL2ZzL2V4ZmF0L2Rpci5jCj4gPiA+IEBAIC02MTYsNyArNjE2LDYg
QEAgc3RhdGljIGludCBleGZhdF9maW5kX2xvY2F0aW9uKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIKPiA+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4g
IH0KPiA+ID4KPiA+ID4gLSNkZWZpbmUgRVhGQVRfTUFYX1JBX1NJWkUgICAgICgxMjgqMTAyNCkK
PiA+ID4gIHN0YXRpYyBpbnQgZXhmYXRfZGlyX3JlYWRhaGVhZChzdHJ1Y3Qgc3VwZXJfYmxvY2sg
KnNiLCBzZWN0b3JfdCBzZWMpCj4gPiA+ICB7Cj4gPiA+ICAgICAgICAgc3RydWN0IGV4ZmF0X3Ni
X2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsKPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4
ZmF0X2ZzLmggYi9mcy9leGZhdC9leGZhdF9mcy5oCj4gPiA+IGluZGV4IGY4ZWFkNGQ0N2VmMC4u
ZDE3OTJkNWM5ZWVkIDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oCj4gPiA+
ICsrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgKPiA+ID4gQEAgLTEzLDYgKzEzLDcgQEAKPiA+ID4g
ICNpbmNsdWRlIDx1YXBpL2xpbnV4L2V4ZmF0Lmg+Cj4gPiA+Cj4gPiA+ICAjZGVmaW5lIEVYRkFU
X1JPT1RfSU5PICAgICAgICAgMQo+ID4gPiArI2RlZmluZSBFWEZBVF9NQVhfUkFfU0laRSAgICAg
KDEyOCoxMDI0KQo+ID4KPiA+IFdoeSBpcyB0aGUgbWF4IHJlYWRhaGVhZCBzaXplIDEyOEtpQj8K
PiA+IElmIHRoZSBsaW1pdCBpcyBjaGFuZ2VkIHRvIG1heF9zZWN0b3JzX2tiLCBzbyB0aGF0IGEg
cmVhZCByZXF1ZXN0IHJlYWRzIGFzIG11Y2gKPiA+IGRhdGEgYXMgcG9zc2libGUsIHdpbGwgdGhl
IHBlcmZvcm1hbmNlIGJlIGJldHRlcj8KPiBUaGlzIHNldHMgYW4gYXBwcm9wcmlhdGUgcmVhZGFo
ZWFkIHNpemUgZm9yIGV4ZmF0LiBJdCdzIGFscmVhZHkgdXNlZAo+IGVsc2V3aGVyZSBpbiBleGZh
dC4KPiBHZXR0aW5nIC0+bWF4X3NlY3RvcnNfa2IgZnJvbSB0aGUgYmxvY2sgbGF5ZXIgd2lsbCBy
ZXN1bHQgaW4gYSBsYXllciB2aW9sYXRpb24uCgpJIGNoZWNrZWQgdGhlIGNvZGUgb2YgcmVhZCBh
aGVhZCwgRVhGQVRfTUFYX1JBX1NJWkUgaXMgY29uc2lzdGVudCB3aXRoIHRoZQpkZWZhdWx0IHZh
bHVlKFZNX1JFQURBSEVBRF9QQUdFUykgb2Ygc2ItPnNfYmRpLT5yYV9wYWdlcy4KCklzIGl0IGJl
dHRlciB0byB1c2Ugc2ItPnNfYmRpLT5yYV9wYWdlcyBpbnN0ZWFkPwpJZiBzbywgdXNlcnMgY2Fu
IHNldCBkaWZmZXJlbnQgdmFsdWVzIHZpYSAnYmxvY2tkZXYgLS1zZXRyYScuCg==

