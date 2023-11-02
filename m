Return-Path: <linux-fsdevel+bounces-1790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057E7DECCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 07:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9711C20EC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D443524C;
	Thu,  2 Nov 2023 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Vr0f+l6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5022187A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 06:10:47 +0000 (UTC)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D4111
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 23:10:42 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A20Tpqg009008;
	Thu, 2 Nov 2023 06:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=9uq/XVxP2Sv0y2MiuhbU/RmhijkS2qlG/LIhcsbkDhQ=;
 b=Vr0f+l6yJDKRLo9wj3gkoQEJ4qThHGozmILzw8tRsBgU1En6bnPNiisW5uxp9nvT/Odl
 sahk3qnwSerXiDh7Cr9U7kuoiOJ8diZ/JBE80xGTv9LZ2dMBgA1fElga7aDj2+6yZdj4
 1ynZtn7GC1P5GkeIw7Lg9tYdeqrSuf/nR9JZPD+RealO55YZdMuOYiiE3L3Y+84OiLKV
 9NaWg+iQf6GIRWASwnkXEHLkR8vo/kZoXvSdcJgE4tAr/OFJ3cpqWNxGJCuWVVkHXDXW
 2HSJip52cXZ3h/6qrq19k3tppmTvv6Q3E4vGLHuhDqLCVUWYiLAJImlGTztNTXDcd2cv cw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3u0rxywa8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 06:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoJ5PSDqi9R9mAju85TTmtxVcS2zJU//vDTnraSp1iTJwAQEm+pFFYTmzTACrvPBL5xG2s3ZsQgWC4je27bQiq3Tes7bpo/r3uyDraTAES2cm3m2LRT2Nz89YURAxDuCGDN7ApnOQ2wN7BK313dTozzNvvjvUhwaga7vqSCvkPkZBp9mm8/UNDRtKeGS9Le97XOzRHfYmeQU9rOOtwUZUKrA1ENAw3ViaA3/JEqZnN6hU+67pzj4YoIFJQtMegRNeJ68MAbu3Rd5qPmZT8BjJCXpn/720YAuJlig3ok/+rH0AhZa3Rgmr+cey7nGZH2IpNMJebmkTaraeXp0zZfZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uq/XVxP2Sv0y2MiuhbU/RmhijkS2qlG/LIhcsbkDhQ=;
 b=NERe8Y7McKXqJ1l1iNKeq2EWj1hEhXPKQ5OAcBrLmy66UM65MmI1r9wP2k2OvxR3wHZ5dvSbWzs5Jz8FV/txs7GNT2Z4zRZPusuAEIwE7QtVDmNBbYBjjjltrrE17xre/YIy3kf8e1wcg7lyiYZJNNj90wbH4BcLU/sQZZvULaVWBtUimMCDDSG1RdhmfMBwNtc2Qcnannqhn8ylCfTAHb9Nz8niWkMl1fZAxYa6pIyS0YFmsf4edQJ+8dBodPvwXc4vF0Ey5MEetiJEtHUxuizpF5/kB7PVq8JzbhCSqM3M1KLJBcHE5Rql2bap70wJM+bd5y0Vtp54QkPbfrqP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB7408.apcprd04.prod.outlook.com (2603:1096:101:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 06:10:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 06:10:20 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "jlayton@kernel.com" <jlayton@kernel.com>
Subject: [PATCH v1 1/2] exfat: fix setting uninitialized time to ctime/atime
Thread-Topic: [PATCH v1 1/2] exfat: fix setting uninitialized time to
 ctime/atime
Thread-Index: AdoNUr0C2LAJqTRjTDmnw7fbPMjyPA==
Date: Thu, 2 Nov 2023 06:10:20 +0000
Message-ID: 
 <PUZPR04MB63163B71EB1474935175FCC181A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB7408:EE_
x-ms-office365-filtering-correlation-id: d3533538-4f71-4302-7fcb-08dbdb6a6488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ps1tAbVp22J13XZO9svMrDENwWqDpXMNYfBruwVbuSI2Gv/9S4XdNxs7QZelJKjLXBCbVmSRv9bK6D5u6r2w0sl/diEhU2g94fGoIiHjTyMMmWIU9WFCq6K1FwYFfxIHK4mgYXWynpSNS4s2myvH/GG2vKx1MtlFJ7GXnVNh2K5eD2g91pJRbnxN/m/sErNsGTnz6RNkGh7BuW3cdoPpXxgTcoNhNnttL2FOzbxlyGYh2wvGZ1ecjkL47C5bMhDD9ULFxML/MNrRiMHZUZIrHx8sjpYTv/6VK3pMiquPo5A8/d7L0cNQQxhf9vHVVGsR0niB/z1ZLrqcg5P/0FuwA0IIVrWo9SBmwcPUkzOhnKgz3n8DiqcBNAurSy3DcONuPeaRA2OJxOIUlbthyhyVLY1qFUdFTJXAGsnUosNVdD2nAr64TKTw5dRZBeMPL7XtPkuLPQjQqlTWb5ghq8mfsm0NTz+l0qDp5+F0R7VtvFgZZGEa6M+ww9e/AT8W64Y38j3Az5y88u6k7i638UmcDRNDO6gGOTj0CJOrldl3J9hG4347vII+RmgthKgnj+1jvYXw1zVs/6iNpCgdHE29t4s5z+JIgxk29SQGHCK9fFMcPTXCYARb2SjGgvhHCMmM
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(66946007)(76116006)(9686003)(478600001)(71200400001)(66556008)(66476007)(64756008)(316002)(54906003)(26005)(66446008)(52536014)(8936002)(8676002)(4326008)(83380400001)(55016003)(6506007)(7696005)(5660300002)(2906002)(38100700002)(82960400001)(41300700001)(122000001)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WmJtbDFKVERIeisxZ0I0aHBmdGc1UXpWNzdnb2VFMmRoWDN1dTlWV2Q3Q2kr?=
 =?utf-8?B?ZXFtUFVZeW9VMUZWQjV5aUc1d3JEMzJkeXNtRWVWQW15a2wrYm94RkRFRlFY?=
 =?utf-8?B?dnJHa1owUFBtUU0xdXJzanVPdWhtZ2UxRmNNLy9pTFpmVElRdFNabnowSHhi?=
 =?utf-8?B?YU9qck5vYmIyM2lsYWJFY1A2R0xocFZyRUVpWDRBd3NTMzM3ZW9PN2dDMHhn?=
 =?utf-8?B?N1lMUHdMcms5TW9RU25TNlNuT1NUSERieHExL082VE1RdDZjYTRtRTZzZjEv?=
 =?utf-8?B?OEl3L3BBaDRST2Nzc1ZtV2prUmIxS3NRZnFYZkZoRVNQand6OGtTcElhZjhH?=
 =?utf-8?B?d2c5WXJxdFpVNmVvNHAxaDI0dVFBcWJBalBxSEVtbXFoUFg2NlgxRUZOYno1?=
 =?utf-8?B?WVN3ZEFnNWpMRld1YlNmdFpmVVJBVDVNcEpkdFgvSkg1MGRaTTVEVFBpQXhZ?=
 =?utf-8?B?TmNEbm1zMncvWmlIN2xiMXZPRTdNVWdpVzc5WGkxVCtMUGg5QWJSV0FzU0JK?=
 =?utf-8?B?MjBhN1dRMFZYUFlpT25vRlJVUGZqdUpHdHBZYjAybmY1c1VJaWpDcTI4THBH?=
 =?utf-8?B?bytZM2sxeFcrTlp5R3ZuWHJJb3ZJdENQdnFZdmpOK21DakRQaktkdEtkRko0?=
 =?utf-8?B?NUJqVG9VR3lNblVSUk1FQTd5VHJHOFRCanZsOXlSODRsODFiVG9qZDYwdGtE?=
 =?utf-8?B?UjNaRk9kL1FWRlBJdCs3djFJcG8vbU9GMGhpNzRmYXc4bFNnSjdpZXI5NlBX?=
 =?utf-8?B?a2Z6UlVGT0pOSFZTN1lIdmlJNkZYNWV1MUMycG9EejJxQnJZT292VHBnSHFt?=
 =?utf-8?B?MW84aWhEWjNJM3lIaDZMbWhKUXREVURtaXppRzdvbFZTV0dEQ05WNlhaK1Vp?=
 =?utf-8?B?d2N1M01ycWowL1NXUUFGR0RFM29xdEltcjdLMlRMTmJMQ1pNdUV0YVNFdGk1?=
 =?utf-8?B?OHhTKzFqbVNMdVlLT08vNGsyUWlIWFloVHB5d2NxZkUyYitVZ3hISktRVUph?=
 =?utf-8?B?QUh5ZngxbTUydDYzV3NwY29kRUthYUh6Tk9tdTFkV25MU2l6ckR3QXFqbkFR?=
 =?utf-8?B?cHRacUt6RG1RRDNKa0FMaUJBKzQ1NHVCbDNzWE5xZUFIT1J4NEw2ckM5a1pD?=
 =?utf-8?B?THUxK0taZS81UkJZTkFObCs1SU9CalBxc3ZKVWJ3cG1CWFhjQjNMSktsQzhn?=
 =?utf-8?B?R3U3N2dOeDA5YkcrVnFjQW1qUjdJaEY5SUV3MGhOeCttb1hDa0htWTNaWmQ5?=
 =?utf-8?B?dGVSRzMrdHNNamZ2ZlMyMUl0S2FXcEFwRzNtam5oeVp6L3UzVE8xMUxaUTB4?=
 =?utf-8?B?Q2hUWkw2Z3RYV2lxUC9oVEZQb3RHaUtaNU1UdVAwc2dIQlQ0SHREYSsyQ1lS?=
 =?utf-8?B?WWg0T1FIVTVsYlZwZG1yRlROZVpPNVVBZ1FvTTJxUXh5VkhBczN3c0Y5S2hX?=
 =?utf-8?B?V3V6RXl2MDgrbzJIS0x4bnVqWDVyNXU2ejRyMFF1T05hZ2VsWUxOWjEybkhT?=
 =?utf-8?B?dURLOS9rQnVzVlR3NTIvV2NxaHptUi9wMFMxQjVORHNUbm8vZDVERUhYNXow?=
 =?utf-8?B?djJUd3B3eHpqU01pVWVISDdmZXV1MkFqKzRLNlc0UW9yTmV4TzhQWEZ6Y0Vq?=
 =?utf-8?B?VkJFS3ZOQUMwL3lsWXlPd09xdkF1NWk5aU8rWm5aVWxPYU5sTENOZFZ6aWdk?=
 =?utf-8?B?Q21lT3c0UC9RZDFrd1B0ZWlUVUVVZ0MwR0ZyRnM2Y2g2b3dYalliUmNTUlhB?=
 =?utf-8?B?L1FFY3Z5WmlDN3NRbG9veGF6NGtVeXdKVEFKTi85NXp4N1ljUHBFY1dnaTVN?=
 =?utf-8?B?dUVUWUhCK3cvZHFxVlVSSzcyZElDTkVFUHhsTzhORUltQ082YWN5ZEVYMHpu?=
 =?utf-8?B?d0R2QVlXaGdEK0RxdEdvUmJBbXU2aTFUS0J6elNTTUZoVHdqck5GSU5Gc3c5?=
 =?utf-8?B?QjZJSWtUTFhBcmFQNXFIR215K3BTV0VWZFkrNUlXOHpYczlhTzNtZmgyL2Y4?=
 =?utf-8?B?MTJZZ3MySEQ2STVCOU1EVWRuV0JuTFFTNkRmbVF4TWhMY0Vqa1hDM00wcUd5?=
 =?utf-8?B?QTNPYSttTTFYZU1FdXJDSGp3dDVac2dDODlmbWZjRUtUWVFuM3dOeHNyVk1W?=
 =?utf-8?Q?oyCBcjWpNmgb/liEU1f1jza7F?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	praih2zd7ZHPtXQYnxGLSTi4XSpDzXcb+gQOH0d2U7yJXBxuqsbBw53W3FUvy/UNmZsR8KyYVpNc4lVh2DisdVQn4EkzZ/yk9bMt8PTJEArgdFuDk35jTd+Va+M5svcti5sUMgsP4+K10RZUVhEvbXsELUeeD3vl8JekVmOYhmn8l+DOaRqYigw6SNLGoHhDvFsBSgWvT8yxV85KpAmv/rmxdn6l4oIEre2m4jgwWpKax7MBp/Nq7kPP90L9mAon6+stSxEWmGvLsd2JPKbklaVH31Kv3K40OMdYLq54oc4/MXjxUJ+rMyoXSk0Dsq/7ljQiygCr9wiwaSkYbNqjO6JsXzyDP/jQEz/j0p1rh0m9AgeWd8vY7HqmWIajc3Udd/hxxwb10sQfH60uLzbP2sFOJNoWefeKiZDWcwfbOi6SDhX3pL/uz1uWk3t8E0IlSKJPK4E8f9oMz+wVsVsKWlNZDdCOItqdptE9ct98pBIu/fgQUJJkGlL/zogV3cpyo8GHDjtzawdhMxQk9n4m31i0y8uqWlgFxZPxOKkF+UnoLryuIP18o1QvoH2ydWYdvAbm6H7+RY3YK2NpjHL1NTh0FNr3jz5D8lVxcsfIHn4xItHTUKoj3j99gFuHVIar2/G7TamjcbruYjKJoCJBey97GtAcOTNQcITbXJW1kvry83MNSxvWkWCzJinqgR374RMl6WjrzhoWCJve6V3I/vhVXPsEoIySLVw03+oZO6IWEFloW9+y161R6AuaAMqCDjJ8OzlujjtzeBtRZ78IlUg9MLtabxS8iLtRjDgC0zZBTdwOka8Wd52Ur+LPA3nLlNJ4F+6XUVObuXApCbddimU/HjfYTcw4NWNucGL1Fp60mS7S+aHCmu1jjq3vOGuy
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3533538-4f71-4302-7fcb-08dbdb6a6488
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 06:10:20.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9K4C+ZxnuqrOnPvJ67iSbVov2APSydb63B5BFH7Dv8vLR+Kf2fs5i9J7YRHjehnMBXAAxCYdmgxmum5jS7F9hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7408
X-Proofpoint-ORIG-GUID: 8RCnjGoXTgKwBz5H4WpdIL4Cc8ChlTCP
X-Proofpoint-GUID: 8RCnjGoXTgKwBz5H4WpdIL4Cc8ChlTCP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 8RCnjGoXTgKwBz5H4WpdIL4Cc8ChlTCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

QW4gdW5pbml0aWFsaXplZCB0aW1lIGlzIHNldCB0byBjdGltZS9hdGltZSBpbiBfX2V4ZmF0X3dy
aXRlX2lub2RlKCkuDQpJdCBjYXVzZXMgeGZzdGVzdHMgZ2VuZXJpYy8wMDMgYW5kIGdlbmVyaWMv
MTkyIHRvIGZhaWwuDQoNCkFuZCBzaW5jZSB0aGVyZSB3aWxsIGJlIGEgdGltZSBnYXAgYmV0d2Vl
biBzZXR0aW5nIGN0aW1lL2F0aW1lIHRvDQp0aGUgaW5vZGUgYW5kIHdyaXRpbmcgYmFjayB0aGUg
aW5vZGUsIHNvIGN0aW1lL2F0aW1lIHNob3VsZCBub3QgYmUNCnNldCBhZ2FpbiB3aGVuIHdyaXRp
bmcgYmFjayB0aGUgaW5vZGUuDQoNCkZpeGVzOiA0YzcyYTM2ZWRkNTQgKCJleGZhdDogY29udmVy
dCB0byBuZXcgdGltZXN0YW1wIGFjY2Vzc29ycyIpDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5n
IE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1
QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29u
eS5jb20+DQoNCi0tLQ0KIGZzL2V4ZmF0L2lub2RlLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IDg3NTIzNDE3OWQxZi4uZTdmZjU4
YjhlNjhjIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQvaW5v
ZGUuYw0KQEAgLTU2LDE4ICs1NiwxOCBAQCBpbnQgX19leGZhdF93cml0ZV9pbm9kZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBpbnQgc3luYykNCiAJCQkmZXAtPmRlbnRyeS5maWxlLmNyZWF0ZV90aW1l
LA0KIAkJCSZlcC0+ZGVudHJ5LmZpbGUuY3JlYXRlX2RhdGUsDQogCQkJJmVwLT5kZW50cnkuZmls
ZS5jcmVhdGVfdGltZV9jcyk7DQorCXRzID0gaW5vZGVfZ2V0X210aW1lKGlub2RlKTsNCiAJZXhm
YXRfc2V0X2VudHJ5X3RpbWUoc2JpLCAmdHMsDQogCQkJICAgICAmZXAtPmRlbnRyeS5maWxlLm1v
ZGlmeV90eiwNCiAJCQkgICAgICZlcC0+ZGVudHJ5LmZpbGUubW9kaWZ5X3RpbWUsDQogCQkJICAg
ICAmZXAtPmRlbnRyeS5maWxlLm1vZGlmeV9kYXRlLA0KIAkJCSAgICAgJmVwLT5kZW50cnkuZmls
ZS5tb2RpZnlfdGltZV9jcyk7DQotCWlub2RlX3NldF9tdGltZV90b190cyhpbm9kZSwgdHMpOw0K
Kwl0cyA9IGlub2RlX2dldF9hdGltZShpbm9kZSk7DQogCWV4ZmF0X3NldF9lbnRyeV90aW1lKHNi
aSwgJnRzLA0KIAkJCSAgICAgJmVwLT5kZW50cnkuZmlsZS5hY2Nlc3NfdHosDQogCQkJICAgICAm
ZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190aW1lLA0KIAkJCSAgICAgJmVwLT5kZW50cnkuZmlsZS5h
Y2Nlc3NfZGF0ZSwNCiAJCQkgICAgIE5VTEwpOw0KLQlpbm9kZV9zZXRfYXRpbWVfdG9fdHMoaW5v
ZGUsIHRzKTsNCiANCiAJLyogRmlsZSBzaXplIHNob3VsZCBiZSB6ZXJvIGlmIHRoZXJlIGlzIG5v
IGNsdXN0ZXIgYWxsb2NhdGVkICovDQogCW9uX2Rpc2tfc2l6ZSA9IGlfc2l6ZV9yZWFkKGlub2Rl
KTsNCi0tIA0KMi4yNS4xDQoNCg==

