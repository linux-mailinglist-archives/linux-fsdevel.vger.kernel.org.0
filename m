Return-Path: <linux-fsdevel+bounces-1686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4E7DDBB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 04:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA44DB210F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88215D2;
	Wed,  1 Nov 2023 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="R5uvb3nM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00A15B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:54:20 +0000 (UTC)
X-Greylist: delayed 711 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 20:54:15 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B510C
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 20:54:15 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VNJ598000418;
	Wed, 1 Nov 2023 03:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=GviEUZ9CzCoDzFttzlBWjB48ijzXQYGEj+4uWZchusk=;
 b=R5uvb3nMI9yCKxgdBrYYI/cox9pf+9H/JdDWTC9lPQGvuz65wkOSckUWdP7bEsDxOhiE
 ctLPWAiX1F3afKMFy1/4BdcwsalbR48EP+yAJ/LZf4QV6WDr1lSEYPlSIy7/eoEIppJx
 5HqofWUtVopPWzXMQgGGC8dd+QaC0pFRvwZogqsiev0lmaYcUQGGZdxIdEW2aP7A1Bkq
 ShrhhLCzSdVNolHx02SgDM1yLD+k57i0SLcTvUBdEP5/f9xSVzM1bP2Y50gXbayCI7Rq
 TtIm+pSZIKBTsiWBUzCgCjcZK/ikxjUuMGidTOKnFRG/WwsyHjrio4nIhoPWEQDq+pma kQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3u0rgh3yt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Nov 2023 03:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLrW/7SZNV+DQYPOxRTmoOUWyQIQtEdMzxeJMQTsJc450QoR8THVLXt++oXfLLQP8hUK/QncRXHUJ+quawWNsP0Kc/8DXSBAoDs4NzGq17+fYcILvv20Z55ByG8664eEVHrkBFyKQKW4siAshaxCA3EyF7t005MUrMbaJg8fJbwJw/lVHvKL8sxxIoULArTEGCGYi8Vl7rlFBY+CimRrNyZxy+O+mmN9G2MXeuZabhzrUE1MrKD/fFj41s3ZpI9i+rJ0EC0XG4aOAwSsr0KMXmUncH9hO2hQoBdBVCPJo9bSJT3n6m+jJR05QdDPeogj5/nW+ITbSr61IFaDq27DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GviEUZ9CzCoDzFttzlBWjB48ijzXQYGEj+4uWZchusk=;
 b=YS1Bk6PMlsiYh6NQXy02hxwzsUskiZeWZXnoBhu/p7tS0rceBlRwSayUtgvO7Sb/vs3boqaYTvp3dVA/1TzLEybELeC+uMQzIyrsc4e9eCSuwdAowtn66AlfJIqFxnqaP6yo+MiTpr4+1iN/OGz4aatwyDTWbQFOl+BqXmhlnqQPNYpkFIQivT/FTgCLsR1/9JrVvbqosUocktKqK9U9gj5mN9cwwrPk8S0UipqggV6ZoBzKTYyIdHl0Db7xNB0wj2xgjsT98G5Go54AXoAKk/tdv97Mp5531SIZ87lhNGtEo8vRldacVeINwmcFYQCSyR7WFMbml4gYXl4xNdQUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6782.apcprd04.prod.outlook.com (2603:1096:820:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 03:41:47 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 03:41:47 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "jlayton@kernel.com" <jlayton@kernel.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2,01/89] fs: new accessor methods for atime and mtime
Thread-Topic: [PATCH v2,01/89] fs: new accessor methods for atime and mtime
Thread-Index: AdoMcavvuRDbfdxTQ/2ruJi9O327Ig==
Date: Wed, 1 Nov 2023 03:41:47 +0000
Message-ID: 
 <PUZPR04MB6316B3676F0199B8DDAAD4FF81A7A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6782:EE_
x-ms-office365-filtering-correlation-id: c17f3555-e011-4684-d4f1-08dbda8c79da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ioqUSzmTbO4WQGDNwLDdzHZPLu4FAUhAO+DpmLY5J+LJ8HQ26i1woTyGKp25qp0md6Ny6lZ/qLHWirvf54kNRktmH+Wa9nojnnoN5e+gRS8kMaQi2Yd7ZBl3tBPq86lW/DnfbKv1UF3ZMTd9W163EQZdF5K5mPI5ZKasJDbNFxKKlQbUMfGU5OToJYZkF7mgFxGScu/1XUmz0lPvFfoxmHQYvqDw3oHUfKRxRQbwErW9PjsiZjm+rCFgHU7Cl195/qW05J1jUVv5sYc6CnnO9L/Bj0Ndl3EF2RwQRUk/hhLXBS0LYKyR+qPl17QZDgTEyWqYMclTr0r6CXsvWPTNa+ZCQyyWNp95EGBoVTo1sSobYOf9C/+WSyHne92C+64R+Dr1W9J90W521eH/cEYcAWjLjxynjpDtpQu+aKoCvU3gRKJ7A0Fej0jACj8lVvThdQCa30IVaZhLxdn3kH5hsMm8AAX5EsyxMzcgYs/5zZH0wiEVgpAog8VHeuPiO34xAv8C4WOB9XReW30P+p741UkOxiw56uGCgKK/hYl70eY/Gdv1wx/zCy8dmm//SmWTCKYtZrIDbWKXyIbelQJ7u8t6p81m4B+F29+UIijKus81FMvLYknJKoc9zBDgpu9j
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(71200400001)(478600001)(122000001)(26005)(55016003)(7696005)(66946007)(6506007)(9686003)(38070700009)(316002)(110136005)(76116006)(66556008)(64756008)(33656002)(66476007)(66446008)(52536014)(86362001)(41300700001)(8936002)(5660300002)(2906002)(38100700002)(82960400001)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZEVIeTMrVEdqSjVUeitGaUR2K084eWpkaWNsR01pQlZ5dkN2eXA4amlwZitS?=
 =?utf-8?B?UjBKa0hJZEZ5MmMvY1UwdnlQMW9yRFphYkc5dmpiVWVCOUFRTm9MeXAxOHht?=
 =?utf-8?B?M1ZJL3lveVJkcUlxYXhlTHZ5cDk0SElRUEZPZ1lkNklGTHd6QTVhWk5vMkMw?=
 =?utf-8?B?aU15aW5PcStTUWFPNk5YSS9SNjlzSDF1SnBvZ3l5OElQbFNPUXlyN255ZEsw?=
 =?utf-8?B?S2dOYm5PR1ZlelVwNThFd1dqQit5RFFqTVRacnRhR1VvbHJNckovL2JEMHRW?=
 =?utf-8?B?MjhlMXZKUkVsaXpDYm84bTFPcStFNkJ3Z0hadkd2bnYraElCR2ZkK2NQYnZX?=
 =?utf-8?B?cVVSdElYcTE0WkV2RFR3TDlYMTNONUc5VTI0anpVcHJJdnRXTE96cCtEUW15?=
 =?utf-8?B?Y2tCZTFpV2Mzb29wMTZDYWQwcFJCUUMzVGRaV3JkeEFSdUg4T05rc3hlRVlt?=
 =?utf-8?B?a01mYVRLd1Y3YXZqQU9kbCtnQUxpaWgzMjdMckFxYkMxSXI4ajNJSTZzRmw3?=
 =?utf-8?B?Y2poVmR4M1ZVdEx4L0dJT2FndHdZdU5kVW85eXczQzBtV1hyWDl2c2xlWGVx?=
 =?utf-8?B?S2dPd2RwNkcxOXpCTzJGc0xjVjlZSE1wSThsblpjLzFOY2d3QlBVV2J4VXNx?=
 =?utf-8?B?ZjVVbmVpbWtMWlhCd3J1N25HTmZsMUNkSzNFcW1wN1p1YTdVNGJzVXB6N3ho?=
 =?utf-8?B?RGxpZ0dvckJhRk1SbStFblJ6Wml3eTRtQ0NFb2tOSmpObkVxb2VyZC9XaTRx?=
 =?utf-8?B?cWFncElwN0NScFJKT1RJUHR2c1huazVwU21hUnlVU1JubGRKNFI3cjlZdDRt?=
 =?utf-8?B?ZzRzd0syNXdIU2ZqRkdjdlRzcEVOTkNQNXhwRjlRcjVMb1lRUTJhWjl6Umxl?=
 =?utf-8?B?OFh5dWdqbzQwOEZLMGUvVWZSeFR5Vlg4MERDTjVZRVEralBEalY0cG5NTiti?=
 =?utf-8?B?bkQxMEtNTHdyN2FtQzNtSkM5TUJXalNBcWxncnROem1FemNrd0N1OTZoc0Fk?=
 =?utf-8?B?YWlHeUhoVEtVMEY4aVR6VnRRT2tUL0Y1RUcyUDNQVnBibldCV3laU0NEN1V5?=
 =?utf-8?B?MTVFS1duQVQranpneGp3OEV6Rmo1U2pEcENFWDdNZGJOUG8wQlFVWG42cFNI?=
 =?utf-8?B?UVdMbjM0QTVDT0JnVjFaYW1tKzVGQWZTMkUrbzRLVkRwNEo0Wit4bzZGdEIv?=
 =?utf-8?B?WXgxWFEvYVhtVisyOFhkZS9abkM1eFAyL3Z4MVVwdkpLZGEvTDBINjVGVlJL?=
 =?utf-8?B?Q2EwYkR1OEYxYWI2MEVha2o4cnlFTjNpaEJQREM2MXV1SnlBYmtNek1iK25G?=
 =?utf-8?B?YVp0ekxNNWVUY0V4R0tFaW5FdnFGT3hBc1gyWHVsRUx5eUxTeDhZSnFMbkti?=
 =?utf-8?B?UFptMWRsOUx2Y05HWUZrUlROWCtMNHlUdkNaNGtZaGNHalM0WXAxWW43Y2VL?=
 =?utf-8?B?cWZ5SGpjK2d4QVJnMXpJR3Rob3Y0b01YcVo5eWF1aDZtbmhtNHFlNnd5QjNu?=
 =?utf-8?B?RUFmSWlwWTRid0lwc0tMVTVvYWNscTQvajM1akJtRmxrYmNVaFlWMEpJNVp6?=
 =?utf-8?B?djRSV0pIQWpKalJ4OTRxQzl2ZmI0cnI1WmdKN09CK0Q0TSt1cm45NmZudFc1?=
 =?utf-8?B?NGJJaSsxa0Rad3Y2bUJURkFIVDdmSXViNDRWTkpqbUtzL2cxTGRuQ1E0MFJs?=
 =?utf-8?B?VFpMbC96SDN1ZnZvK1o3eERqR0F6aGFQUWpTS3c0VDJLVU81dU1XVzZ3ai8x?=
 =?utf-8?B?Y0xkQjcvTUxpYThCbWlvam55WVJ3S0VjTFB0eWM5MmNreUFic3psTjNKcVZV?=
 =?utf-8?B?UlNEY1Z4ODRHS0FCZ1lRTUkyY2hKeFV4NmdubHBwUEJLOWFLbkg0Q0NPS1dv?=
 =?utf-8?B?TFAva1ZEWjUyR1FTS0FHbUVlWE5FcEk4WkowZHlxemI2dGlCbnZHbzhCTTJ5?=
 =?utf-8?B?ZFNSWU9SU1UzT3lsQTlKQkhHRDN3aXJWOUNIRnE1eHFqeUkrclhSUHFNK1ln?=
 =?utf-8?B?V29lTWJrN0JJbkg1K1l4NDVEZW5EWEhCcnlsTVFCRkJwQVZSVzZKclpJTHFo?=
 =?utf-8?B?UXh5b0FlbmJvV0loSUlFdG5TLzRtbmh6SVN3MkNhd3VpK2k2eVdXNk5RY2Jx?=
 =?utf-8?Q?NyEFRtm6SFXKb8o2V6E47ueiF?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zW+w/qsX3dMpHZHLAH71o4Bmy1E7x9CulVdjtWT4BtLAO9vuJi7OP0pBhqvs1ZdL/I6CmefDe3A2TaBa78Y1X/T82SRv11jE8wYXMao+uchiY3haK0jqwfZAG6nCurYZBV19wpwN+6T/i+lSPYOgNMSJFpp5RhX3bLzrSLX2mt6gJAXaOXDCH+JA50CIO9wVpBulo4+EyD6kRqAbhiOANuO4RvT7Kr/5hc8KsuC7mPyWtYTGANVCoct+cpEV6X+VAbnscUkclRI8kmY9ZMROGXOJnMgw9NE2ZRAxd0uk9u47ZkoDe6e6dY5cm0TqS5c/zO/NgJ08uNK+XAhi0cY9C0zkBEvnHtRFUV5yNt3tNjGPxjehKhJo3Z50Bn76pR4x4/7eo4eDD/hbui7r6otvmJgOJ74uDqNfV0jwDL8R3P11P5rceDamFro8gFEXd9p4f+euxy73f76g1fNpIYodvTm8bdTpiTYHnvHCUFlR/IFtJh19o7Ht/9E0Im8razcVAcBWcRMNB6w7XRAqUrDR1abGckK16eHjQxvsstaV/U6gJQhvdUAHFhNtAywSeqIVeZxZdJGZIw58cDDoOkdEbVYoWkEKrDvnihlY2++uJBir7drt2XEG8mRx194aI5P2yE3JkdkQ6V7aoos5olJzPkX69BjOl9PcrwtaDkPPUtqqhTJNe/Zn2Jgos7B2z8LRYpEl6cljM28S+XYD2Pld6OHBhsw9nv6ukuRFuApVvcqdY4rh938vQp2mutfKzG7yRRQ9bRsWFw+QuHH3eUG62CVsPWTuKP6IzDaGlAh2M1zQqKtXvCy42wIpM88zSikDTUUl0/UVqXgJmCMGmT5Xdg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17f3555-e011-4684-d4f1-08dbda8c79da
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 03:41:47.7210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IR9P9fXZvSrOuR1/yazY+VzNqwSzHgoZWbfYzimZcWqTybAZHchEF729tvuw8wLBJD2ldRosWCRv406NzeeeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6782
X-Proofpoint-GUID: -Ak70cnm8Q4f981a_kydjVrpk__VlzP7
X-Proofpoint-ORIG-GUID: -Ak70cnm8Q4f981a_kydjVrpk__VlzP7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: -Ak70cnm8Q4f981a_kydjVrpk__VlzP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02

SSBmb3VuZCB0aGlzIHBhdGNoIGhhZCBiZWVuIG1haW5saW5lZCwgYnV0IHNvcnJ5LCBJIGhhdmUg
Y29tbWVudHMgZm9yIGl0Lg0KDQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCB0aW1lc3BlYzY0IGlu
b2RlX3NldF9hdGltZV90b190cyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiArCQkJCQkJICAgICAg
c3RydWN0IHRpbWVzcGVjNjQgdHMpDQo+ICt7DQo+ICsJaW5vZGUtPmlfYXRpbWUgPSB0czsNCj4g
KwlyZXR1cm4gdHM7DQo+ICt9DQo+IA0KPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgdGltZXNwZWM2
NCBpbm9kZV9zZXRfYXRpbWUoc3RydWN0IGlub2RlICppbm9kZSwNCj4gKwkJCQkJCXRpbWU2NF90
IHNlYywgbG9uZyBuc2VjKQ0KPiArew0KPiArCXN0cnVjdCB0aW1lc3BlYzY0IHRzID0geyAudHZf
c2VjICA9IHNlYywNCj4gKwkJCQkgLnR2X25zZWMgPSBuc2VjIH07DQo+ICsJcmV0dXJuIGlub2Rl
X3NldF9hdGltZV90b190cyhpbm9kZSwgdHMpOw0KPiArfQ0KDQoxLiBGdW5jdGlvbiBuYW1lICJp
bm9kZV9zZXRfYXRpbWVfdG9fdHMiIG1heSBsZWFkIHRvIG1pc3VuZGVyc3RhbmRpbmcgdGhhdCB0
aGlzIGZ1bmN0aW9uIHNldHMgaW5vZGUtPmlfYXRpbWUgdG8gdHMuDQoyLiBJdCBpcyBiZXR0ZXIg
dG8gY2hhbmdlIGFyZ3VtZW50IHRzIHRvICJjb25zdCBzdHJ1Y3QgdGltZXNwZWM2NCAqdHMiLg0K
My4gSXQgaXMgbm90IG5lZWRlZCB0byByZXR1cm4gdHMuDQoNCkkgdGhpbmsgdGhlIGZ1bmN0aW9u
cyBzaG91bGQgYmUNCg0Kc3RhdGljIGlubGluZSB2b2lkIGlub2RlX3NldF9hdGltZV9ieV90cyhz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBzdHJ1Y3QgdGltZXNwZWM2NCAqdHMpDQp7DQoJaW5v
ZGUtPmlfYXRpbWUgPSAqdHM7DQp9DQoNCnN0YXRpYyBpbmxpbmUgdm9pZCBpbm9kZV9zZXRfYXRp
bWUoc3RydWN0IGlub2RlICppbm9kZSwNCgkJCQkJCXRpbWU2NF90IHNlYywgbG9uZyBuc2VjKQ0K
ew0KCXN0cnVjdCB0aW1lc3BlYzY0IHRzID0geyAudHZfc2VjICA9IHNlYywNCgkJCQkgLnR2X25z
ZWMgPSBuc2VjIH07DQoJaW5vZGVfc2V0X2F0aW1lX3RvX3RzKGlub2RlLCAmdHMpOw0KfQ0KDQpU
aGUgY29tbWVudHMgYXJlIGFsc28gZm9yIGlub2RlX3NldF9tdGltZV90b190cygpL2lub2RlX3Nl
dF9tdGltZV90b190cygpLg0K

