Return-Path: <linux-fsdevel+bounces-4317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A37FE851
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 05:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD4281D4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9920DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="BNmGpxWX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541910DB
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 19:10:02 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATL0FQl021090;
	Thu, 30 Nov 2023 03:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=W/BIjbbpi3z/oqM3SdmSZ9rxxfUbrPh9RigfuOcr59Q=;
 b=BNmGpxWXUxSXKLOChXVyyr5QXc45+ozfkj+/US/fkPZWOgsGqXL0ErdLD7LZvlvTbZDE
 Jdpp9NWqUDDCPR64ASwcaLFY3uA2S2PBYSFMe7rYgYrVQmLbvAzgd38bVn29jtLyQzSV
 ubR2TSD62EAeLtftPlTPrjvz02aqwFDFcw8Kk/7VFkVpk5/2MGJXJkSEadMLQqvw8KCV
 LTDXSQZWqEPM1vz9cIcQxRMGGnBH2+XTO7s1psTSkRK+MjTytI4PnQZkwGy4+ZyaeABH
 Wajflj6MFL5e/SmNwwiQqdk/PmHAEpew/6CnnG3u8UxhE1CtOk6E/vZbzXUh3YtzqKAY /g== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2109.outbound.protection.outlook.com [104.47.26.109])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3uk636535t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 03:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHmUTcSpBEuFHVc/CWjFtLLiHz1/oUpzypI+3OTMOtpo2a6CW8hWQAzL728hAG3t6kSOaCNRFnQYOlkba0ZdYPNsLPda3C8ocCPN1nzowxauI7YtOdoORy2MigMRSdKg1SXLyFUw9Vb1tqT+6PCpDMpBdmpwigFkc+RBYsPXNW1tEmt+BMG66s6wNMQdaYg2hVI/ZjrkMWCdYGtF+xa3Zk/XTaizgwb0to7QGGY+J/LrPBPFQBGN8fzGYMTa1TIhG8JIUC5EZYdfo4E7BGGlxY+YvPzX2IF1oP1MXtQdHPzPaMPKo/wJ+9pZHhr+jVnreJdVd8WKTDpF3whkUvYUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/BIjbbpi3z/oqM3SdmSZ9rxxfUbrPh9RigfuOcr59Q=;
 b=dHjmZ1wS7EoftTChPKnqU0B4/1OBpKwpfcFh/ui3EPlYXtIU3kHSYBVSb/eIf3Be+kGh0aFmpXkWPG7GOVr3nZ39J93+xMHwuNAYZHYYQU6TOeC2BStKhwWiXKhT3BGc3/gbtzpymiF6tCNB8vIPchw+dMmpDbAab4XhMyZImcNaOsj3sX+sBrOySxrSpBS54BjPXTdF8OKfEfbwMFs5kqOpajIpfbbWknYXY2U95tORW50N2IzjWCqEnsg6Iloq8X26nnSlD0iL8ZeYuObQlcjMZcwPQfNH8Tz4952bF5m1Qk7DnbTwEeySqKvqyXgLC0t/GN5Ohoxlwi2fiyNaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI6PR04MB7955.apcprd04.prod.outlook.com (2603:1096:4:249::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 03:09:45 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 03:09:45 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>
Subject: [PATCH v5 0/2] exfat: get file size from DataLength
Thread-Topic: [PATCH v5 0/2] exfat: get file size from DataLength
Thread-Index: AQHaIzqrwWxZXkD3Nk6Vsq7UNH5y9w==
Date: Thu, 30 Nov 2023 03:09:45 +0000
Message-ID: 
 <PUZPR04MB63164691A5119414706F66998182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: 
 <PUZPR04MB6316D39C9404C34756CA368981A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI6PR04MB7955:EE_
x-ms-office365-filtering-correlation-id: 717b459c-a3ee-4dae-e1fc-08dbf151ce29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UA2VGqBc2oeBDCMXpUB6RIP4LfE23ip65uEH/LFaTW1bfCz9S2IX4EHlv2ZIKqJanh+cdN5APLoOBWe2qiMVFihhqPBf5wry+nNXd1gN2XXe8d9kh+zFVaLCQvvOUrTHxZaJW9hLkJZ5O+0lUrTzsnuNv7HBbK+tavjDwO4MgXQfLG1lmXyLCGWgeRqiZam4mngsXr10rGc4XZWvVRY4hxz0I+q5JpOrEiX68VOH6YdoE74wvFbPJTouKIsVrfB02RVVEKx/5Ad6vZ4xH6jtMQN19sMZWg8K+YS2Hw7Jo4Fkx4ZiO/a/VCAB6ySzkqV/o/YEeoXuUkQyK0uwQEKR2+1R2QsEYIAH+SiLY78cMciVFl7CAO7Nuu6KhiYQuYr96Floh4xEixmaNbeAWl+wMd1dIHTBxEZPpUWhxWtz1fKadU9oRJyF5dYJROkNUZ2iDBowG4Z5mJpbyt+0yWl2qhirw8TTRgT5xiKTD2VZ5g9VPdAc0Bu3olR6O6t+GJOW9tltmqjzCfG1mvzvDaMkqA/V9O7FVuQCmWSZQkGVWMpWjmOJYloP61HBu/jlyQeny298gyxteV3hZipOlShi7N/cC/46+3mTe9UAOVISuuIZHz9h7oUt/wQ/IuQSad81j3vUfaDfv2IL2MlfhcUkTpJqZDMCrh1rw81IjYylIUI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(478600001)(26005)(9686003)(33656002)(7696005)(6506007)(41300700001)(38070700009)(38100700002)(122000001)(83380400001)(86362001)(71200400001)(82960400001)(2906002)(202311291699003)(66946007)(52536014)(110136005)(76116006)(55016003)(66446008)(316002)(64756008)(66476007)(54906003)(66556008)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WWNxZkx6WjBiSlVyOFpXNnpTL1JFUXQ1ekdwQzJ2aVNXUHNxZU1SMVU2ZWVQ?=
 =?utf-8?B?MVJtc2xGVGwzWXRTNUJ2WVdoZ3pRMEt0Mk1wWndMaDhVSm9PWlNtYjdOQkti?=
 =?utf-8?B?WXBMdWtXYzMvV2Vxc3dnUk1iLy84SEk3SSs0cks5a3FqZHZtSDFBaFB1dG1C?=
 =?utf-8?B?ZEpkSlZuVk1qZDNnSEZDWFBaSVVzTG8rOHpwaUtDMndyVUttdVh6TjZPWHFZ?=
 =?utf-8?B?OHFiVGQvbldTWnlWZm5WaVBMMW41WDdWaEtLSEJGZ2h3MEJHYU5obHVMMUFn?=
 =?utf-8?B?UnZwV2x1Y21jRDZNajRsbFd5WVZIbnk2U1Q4TTRoVHdWbnZ3dzlrdHZhWU14?=
 =?utf-8?B?VkdSeGJndXYyS1RiRnNJdlFod3VnWXBvVkxyS2g1U0FOenVnMm05ZTRYRHda?=
 =?utf-8?B?YnZlUks1WUFldU9STVB3SytlS043VU0zSS9Ed3pPc2QzclBKWnhqUUFZbnEy?=
 =?utf-8?B?MmQreHJicTJmUFQzalp0WEdSN3BTZjV4UEdPdmI0RG00UjZpV1hHNTFKUWpx?=
 =?utf-8?B?c1hnSkttZjJVblcrMk9DUXg1UWxvWWlRQXJjdUVveVpkZUdsODhQSUFtd3ky?=
 =?utf-8?B?bFZTY212eUc5R3Avb2JqWlZ6NnQ1d2JSSjYyaWxla2MyMnR5czdJY1pPUVRC?=
 =?utf-8?B?eWlkNkdLb2tzU2hQQTdIczUwV084bUM5YmdYZEdtQ2dpYkM5d05yZkduZEFz?=
 =?utf-8?B?cHg2OHJ2d0dIeGV6cE9kcWFMYmh5a2VzZTJZY01tZ21iRHRJbU1qK2JLaE9T?=
 =?utf-8?B?QklhTW55ZEZKODEzTHBlSFllL0V0aFNSUkVMRnpQUVZsbWJjdittb0FRU2dp?=
 =?utf-8?B?SUNqWkJoYWk2S3FRVUtXZHg1NmkzT0ZZSE1mT1AwZUVKdXhoT29zV3Uza25N?=
 =?utf-8?B?ZGZFd2pvNWZwN0VCT01wRmdxNTlza1V2bytyVzczMnhzWFdOVTBFMFVwRUFh?=
 =?utf-8?B?ZWZjeDNiT0pleFh6Q3JXSDQ5a2lqdGJib2N3Mm5KVURpcVZLZFYrbUhxa1dY?=
 =?utf-8?B?ckJJS0xpTW9UMEMvbGJxT0c0UGsvZncrc2hnMGlISnl6ZDJrUCtLOG1hcW0x?=
 =?utf-8?B?MkxSKzY4aDNmS2IrYy9menV4YnZUbEtEV0gvNm56RStnSlFNbVNFeVkreXFO?=
 =?utf-8?B?UDliRHIwaXp1V0NYQVJLZU41S1NtVGhsNkNKdkFCVjBkL3FVMFdiWWdYajAy?=
 =?utf-8?B?aWRCSHN5amJaYVFpS3ZXNDFTUU9IK24yeHRtczVOVkxDZEJuYUNEOExWU1d4?=
 =?utf-8?B?VjZPcnUyaC9aa1B3a25CNENYVDdpMmZxSzlneXVLYnp2Y0JzT0xkTFRBWEMx?=
 =?utf-8?B?dURaUGlwWEVXTTZyTWJzREVQZHdrcDBwczFkcDZ6bUJ3VU96c0ZWN0hOdkM3?=
 =?utf-8?B?NGlpZ3BjZzJndk0xNk5zemdCNUdKNmZkaytLNFpHUG9EYzZDaktNSWNZcWJS?=
 =?utf-8?B?UStkUjBqRS9pc1VmM1BPdmJCSjFnbGJqSHdBMm5CV2Z4Ry9SUE1vT2ExUmdM?=
 =?utf-8?B?M3JRNkdPYy9iUTJIdzJYMGZ1MGc5M3BBOTdWeGdYTEJvL2VwQkhTc3pJQ2tW?=
 =?utf-8?B?UVFQRlRWYVZvODFOT1o2M2I1aHNwT0VKMXhiNzVEVkdHWWZMNVgzaTl4MW1i?=
 =?utf-8?B?eHNIYTBHeEhKVnZOVDA0c2hrMzZ4ZTIrSUU0cGFrK2hXa21GdkVhYkpwaitO?=
 =?utf-8?B?RmtRcW54WTJaY3pEMGhHRVk0M3BBV3FYdDNnTGFNUFBRMFRCVnc1RUdiZFZO?=
 =?utf-8?B?UU1RdkdpbWJDRDl1TGY2ZFE3QzBzSC9sSEJFMnhUM0VtUDg5OUtIbFpqd3po?=
 =?utf-8?B?ZnJFQ0ZXTCtvYkQ3THNvbkRobXhma1pVNnllMjhCQXEzWEpkMWgxclFKQjhZ?=
 =?utf-8?B?OUpXL0dSYitVSVo0dmtKYmlDVDdjYTNmMXJXMk4vT1RmRkpoQjNGNkd2bks4?=
 =?utf-8?B?UUpDdWUzMHFQVExoZjhsSVpsK1NWNC8zZ1RXWjd1WUR1eURyaFVLMC9mZGQx?=
 =?utf-8?B?bnBodExOUmRaeTFEdTJVdVZRUkhjYkV0ck1SM3FneDJGMEx4cVlWQXZib2JQ?=
 =?utf-8?B?elFmcWN2cFVDR3lzbVpFZVh5NlBNeC9IWUpPSjZuckQxTkNCa21sejM1NHFS?=
 =?utf-8?Q?e2j2XsWtWH9ac3YSbz2XAllP2?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nOENyJJH3dwbBkPn0okAYGwRvvK2c4m1me5pI2Qk7FoJPDVHL3u0zgx98KD9CeenlQKud4WZB0zGSASsFaLn/EWIkPEg1Kx9meyvV+46o/5Tqty7ijn2ksQZS1nMyPL/teB+a1Lz0yeACUpI6sWdQQk1QPG462Lq+7liyYQoMprUdFj406rrqvvoryc8Kq8+/XEMq4Oh2+25/WYyieQnLMEgOzJIRyFovqSyO9QOSYH83e9VF0wpVqGMMe60lT9HBwIK3m+ksVQ7r6+mfhSFFKDXdsHYICupGSsm6wtZxbDqB0TTpIFN6RzmhCYBCPJdRNGZRB4/rtomLwDXrIDK4XYtkT0MkQuiRqNqfMadLUDks84ApCyD4ZkEZaEKj1i8tickHLNjTC1W9jFzgNlDqAmha+C89jjzAXSoqdfbnp/83hdNNAYb34C2Hy8uqn77OA5wbztk5+vRaQ77suuZBGi8zqUs/4GprpXPTgj//fuBWtvrWMtoEOARGwgvXzQ5eengrCPT28bIUacfuzsNe12+xWspc8l3oosVUnhNtoQ74lkt/ChqkbgFowjXhVLdKG89mw9hsnCbJ4rcvCCRMxguzPc58ezwUvVFQ/chxY6/iiFbPnCBtTExphVy5nFQqASJ5lT0r93DvkWplY25LV6+fFbAq/RFOhyUPxpFcOW/isKWMAG/86YxSC4z+0Khl2DaRlJxDxPKIZsZf7SeW+1RlZqX5UjtsQl/C8UTnJ+QwlmpJol/CtyTfDLdZyX1AIO2v2XKet8O9IBaEGtV2uzUnTPCSs5bKoGZ4eduEqGGfK3nVFDQWCpHvinLgHfd4BW2mJ0FRQptTeGF9jviuw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717b459c-a3ee-4dae-e1fc-08dbf151ce29
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 03:09:45.6341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ll2pQzA7D0A2UQ3lc2dF+D7yDBxIfLvmlW2aVxwXwIguQYZSNU0fRT0DvvMsBJkyWoW8G+C+kh5hIW+vu1Wmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7955
X-Proofpoint-GUID: pq_BvTnVgb1nDdTZOs_AI6UYNAOsHOOF
X-Proofpoint-ORIG-GUID: pq_BvTnVgb1nDdTZOs_AI6UYNAOsHOOF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: pq_BvTnVgb1nDdTZOs_AI6UYNAOsHOOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02

RnJvbSB0aGUgZXhGQVQgc3BlY2lmaWNhdGlvbiwgdGhlIGZpbGUgc2l6ZSBzaG91bGQgZ2V0IGZy
b20gJ0RhdGFMZW5ndGgnDQpvZiBTdHJlYW0gRXh0ZW5zaW9uIERpcmVjdG9yeSBFbnRyeSwgbm90
ICdWYWxpZERhdGFMZW5ndGgnLg0KDQpXaXRob3V0IHRoaXMgcGF0Y2ggc2V0LCAnRGF0YUxlbmd0
aCcgaXMgYWx3YXlzIHNhbWUgd2l0aCAnVmFsaWREYXRhTGVuZ3RoJw0KYW5kIGdldCBmaWxlIHNp
emUgZnJvbSAnVmFsaWREYXRhTGVuZ3RoJy4gSWYgdGhlIGZpbGUgaXMgY3JlYXRlZCBieSBvdGhl
cg0KZXhGQVQgaW1wbGVtZW50YXRpb24gYW5kICdEYXRhTGVuZ3RoJyBpcyBkaWZmZXJlbnQgZnJv
bSAnVmFsaWREYXRhTGVuZ3RoJywNCnRoaXMgZXhGQVQgaW1wbGVtZW50YXRpb24gd2lsbCBub3Qg
YmUgY29tcGF0aWJsZS4NCg0KQ2hhbmdlcyBmb3IgdjU6DQogIC0gZG8gbm90IGNhbGwgZXhmYXRf
bWFwX25ld19idWZmZXIoKSBpZiBpYmxvY2sgKyBtYXhfYmxvY2tzIDwgdmFsaWRfYmxrcy4NCiAg
LSBSZW9yZ2FuaXplZCB0aGUgbG9naWMgb2YgZXhmYXRfZ2V0X2Jsb2NrKCksIGJvdGggd3JpdGlu
ZyBhbmQgcmVhZGluZyB1c2UNCiAgICBibG9jayBpbmRleCBqdWRnbWVudC4NCiAgLSBSZW1vdmUg
dW5uZWNlc3NhcnkgY29kZSBtb3Zlcy4NCiAgLSBSZWR1Y2Ugc3luYyBpbiBleGZhdF9maWxlX3dy
aXRlX2l0ZXIoKQ0KDQpDaGFuZ2VzIGZvciB2NDoNCiAgLSBSZWJhc2UgZm9yIGxpbnV4LTYuNy1y
YzENCiAgLSBVc2UgYmxvY2tfd3JpdGVfYmVnaW4oKSBpbnN0ZWFkIG9mIGNvbnRfd3JpdGVfYmVn
aW4oKSBpbiBleGZhdF93cml0ZV9iZWdpbigpDQogIC0gSW4gZXhmYXRfY29udF9leHBhbmQoKSwg
dXNlIGVpLT5pX3NpemVfb25kaXNrIGluc3RlYWQgb2YgaV9zaXplX3JlYWQoKSB0bw0KICAgIGdl
dCB0aGUgbnVtYmVyIG9mIGNsdXN0ZXJzIG9mIHRoZSBmaWxlLg0KDQpDaGFuZ2VzIGZvciB2MzoN
CiAgLSBSZWJhc2UgdG8gbGludXgtNi42DQogIC0gTW92ZSB1cGRhdGUgLT52YWxpZF9zaXplIGZy
b20gZXhmYXRfZmlsZV93cml0ZV9pdGVyKCkgdG8gZXhmYXRfd3JpdGVfZW5kKCkNCiAgLSBVc2Ug
YmxvY2tfd3JpdGVfYmVnaW4oKSBpbnN0ZWFkIG9mIGV4ZmF0X3dyaXRlX2JlZ2luKCkgaW4gZXhm
YXRfZmlsZV96ZXJvZWRfcmFuZ2UoKQ0KICAtIFJlbW92ZSBleGZhdF9leHBhbmRfYW5kX3plcm8o
KQ0KDQpDaGFuZ2VzIGZvciB2MjoNCiAgLSBGaXggcmFjZSB3aGVuIGNoZWNraW5nIGlfc2l6ZSBv
biBkaXJlY3QgaS9vIHJlYWQNCg0KWXVlemhhbmcgTW8gKDIpOg0KICBleGZhdDogY2hhbmdlIHRv
IGdldCBmaWxlIHNpemUgZnJvbSBEYXRhTGVuZ3RoDQogIGV4ZmF0OiBkbyBub3QgemVybyB0aGUg
ZXh0ZW5kZWQgcGFydA0KDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAgMiArDQogZnMvZXhmYXQv
ZmlsZS5jICAgICB8IDE5NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAgfCAxMzYgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tDQogZnMvZXhmYXQvbmFtZWkuYyAgICB8ICAgNiArKw0KIDQgZmlsZXMgY2hhbmdlZCwg
MzAzIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjUuMQ0K

