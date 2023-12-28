Return-Path: <linux-fsdevel+bounces-6979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5681F53A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 07:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC821C203A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2C64409;
	Thu, 28 Dec 2023 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="JJZddn5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D53D72
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BS6U2Aj009401;
	Thu, 28 Dec 2023 06:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=5ugyRy1AFcODDRZ1CCVGKkPQmTrClcdKuVI3SqG9oJE=;
 b=JJZddn5FuYHaivVg0sEeAysB4Am4mKFz9TqmJa5XYmNvu0hgppaaNDzIOBey+ksoibNE
 CL9zi5LmNv2VJmT7cf/eREncWEfAaxt66+ul57j9QluWL6iOzk9MFYGCcEgnaPtme1EI
 AQZXQWxs8cTBy3ui7pM90Yj/0d5WeyAm2iRo2gZQufS2Ql7TGMajDTISZ9ImAjftps8E
 q/qNYoN1BAgLYZJlbzkPNOM6N6z/iVhtdVYhii7zDhXbKOYUxytcorV5ZB4tPdvBT4ST
 FHttq6dG+VCAnYfK2mYQ86jjhtGTlZjjVRm/woF1pBjNR82gpkhbeGl8dUuAXjj8YWnb Vw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3v5my4uvag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 06:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDuo5dSD4lvd3xxu5jDVhs0Jd2LMk5NUXud7EEIvaVFIy6JoQ1cFB0t8PwBrVBo/KLVnbAc578feBVhL8J3qb8TUofu9W906tuWKiFQ9EMS/zpGyWtwtlRn61a1UodC+fYnzGKaWkO0H+Okh78ryG72KjnyNrP7oTI0xhN081KIz3GJZx8jKo0HlT6Zihn65fNtpAStZ9i8pr0XWPrGX4uQmQ1EDYzBNuY0zvWo/AHl7HNsTJBxGFpjlOxsJv8gPK0BZRxSY/XCBaVvcJmsY1fpSZ/2gT1PhNH+VoF9SBMz6oCmeQ6aEGDeqfZDAlzhmR3tf6jMGhnU9MO0S+tRt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ugyRy1AFcODDRZ1CCVGKkPQmTrClcdKuVI3SqG9oJE=;
 b=ahFBEU+PA2+gm9ExmrIdZ9NhakqNi7IdLOUlKsOkg3pCTSrJoewa9TgYFEqLGoz5Emy7POMSNSLOGHMvAhIRRCk5GgaMs9n5CXX+/8JZ+vKDAxYTG4fL6PA/IhdMfElvF08PlV6nDuTir9KETtwRXH2v7ruRI6xnOvt7rB7S5mb9e2uE8YbPDTHOWliJHEmAcpZAZBCkfe70e/Fr3Yh2agrstyVYAvW/cwriI2odVnDvKHLLRZlrKmM/Hkr0dbb9ZG2fXcgBy/ak9wJ1HPj8C8SOIbXZpE2j0sC39BKiOJb2eC4XwAXf93nwx3w2tVmY59AXnG/GRRF2f6xPtnPuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6878.apcprd04.prod.outlook.com (2603:1096:820:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Thu, 28 Dec
 2023 06:59:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::5914:6fc7:b79d:7e34%7]) with mapi id 15.20.7113.026; Thu, 28 Dec 2023
 06:59:20 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Topic: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Index: Ado5WSoMFJmHKVpOTLmXDrw3gU+2Cg==
Date: Thu, 28 Dec 2023 06:59:20 +0000
Message-ID: 
 <PUZPR04MB6316C5AC606AABE0E08AC2A6819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6878:EE_
x-ms-office365-filtering-correlation-id: 3bab8acd-d61b-4f18-1910-08dc0772845a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UUnHA5+ThB/pMl8oMkigRAcq+iulAYcDvDao8LeWvaLP9MRjiQWq+hpBlSLahBFOk3ZQWLIPv8geJQKW2zF9IZDf4puZlP9cLMyjuePaJQM2tRXbPKTS3qk6gsRgk4SJCkLBhRgbk5E+hmPJDtSalbYiHiIJs+2uLEEU7J6vx5mQN1qd/DP5UQwYZVDGGMhmt8446LQtQ4CX5TVT+G/vrA9IFT+1cr9wq6jyINQe+F4cxeNP0kr7av07OffW7ESCF/zjOSJ+UuIyegektzicWOFuXxAwqMQHKqFzOtxtycS51EwXIozf5lAVMn97JasUwnpJ1EO/F3PxQMFYxLRm4M65Rtebo6WvoW7joP1DoP81Xv/w1SNvyxPAnU+1Jxk03gds5V7xL9QKRKa2Ycq4H5tSvaBmLs9IclcqEL/yU1gJRheCwuLkTrOtX1o3t0p2Y0UlIRErEERr2ORFYIi+dWVJDiL5XXm+lzBqEC/25vqQpQXfpZ2eGQ50SojIZRVqXEtvXlO/7/7mfqduDGirKFUSNsx3dcBGASDfazDci5LU6OdPZ5Trp4UAAvt9OaDT0YLWX5bmfRSrC1jbPGhlsESRdE7xhUcEVo2ZrkaMXTlcxSFhP9SvBvMzv3PcZqgr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(9686003)(6506007)(71200400001)(83380400001)(7696005)(478600001)(107886003)(26005)(38100700002)(122000001)(82960400001)(41300700001)(316002)(54906003)(110136005)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(8676002)(8936002)(52536014)(5660300002)(76116006)(2906002)(38070700009)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aFE3WnNXRlZTNE1idE1rTXdXaGdWSi9HYTNWYVgvOXdXS3dnNTFycVB0dWUy?=
 =?utf-8?B?bGdTaUdtWHhqTGM2YysrQm5BOE9Va1RxY2tDbkpCR2JEYVRUSWEyY0ZjckRh?=
 =?utf-8?B?cW1aaHFZVHVodzFlOFA5WHZkbFRIMWsrWlgzcCtCN0RlU29nZVZ1YUg5NGMy?=
 =?utf-8?B?Yi9nbmFic29ydEFOaUV4QXhFaGRsTTR4OWJDTllScGRuZytCUkZDMVJFRTMz?=
 =?utf-8?B?K1RTRzM5K2xKdG1mQWw5Rm92RU5CV3EvQUJ1a2cwVUF0YnprMWZBUVlYSzF2?=
 =?utf-8?B?K1JFaldmc2NNUzBsbHIydERVVUhnUjNJeXNxQnF4TW0rU3JvbmtpNzI3S1pM?=
 =?utf-8?B?bHVhMzFDMEsrTzJTYjVLeS9wdkJhaUkrMmdZQXBjV0p3cDBGREp5eHNzc2FN?=
 =?utf-8?B?RStIcmN3TnRJWDFrTkd1NWVDUVBLVDI3UElDQmtadTdEUjUyczMwZi84SnpU?=
 =?utf-8?B?L2NzM2VXWUxTTDQ5Q3Fram1ETm1uM1hqZmw0alN6ay9JR3ZqQ3I1Q2tYaFJ1?=
 =?utf-8?B?NDZDZ1IwcXlPOElkdUVwZlAwT21JTWJTTk56R3VxRERpYkJoVERqOFFNYVU3?=
 =?utf-8?B?TGhTY2hxbU81dVVISlBNSTd0TVROelVmZ2xPUVhjem1mL09MbXZxdG8yY3Fz?=
 =?utf-8?B?cXN6YTk0bDE0c2EvR0l3ZzBHU0FhcndkaDhTRk96eFMyZkUwUTBqaDJrU2tr?=
 =?utf-8?B?a21rdlRzcnpmcVdMck9vaXZVbVFxNnMyYlZzbXNLbEN4azJGUWRCMEIvbDVx?=
 =?utf-8?B?Wkl3T2E4d2gxR3kxRFZ2cEVPdmYrT2hyZ2tmdDE0VENHU0RNNjRMVkZ6Mm5P?=
 =?utf-8?B?NjhNeDhRMTNpYXhSWXh1NkdQbWJ2YkRsMEQ3TzU2REFhVFl3eE5vWlFiK1gv?=
 =?utf-8?B?T0FpSGozOUY4cXRsem5vUE93VnB1c2JnSGVBL2pnRkh5UHJsUCtXY2xrLzQy?=
 =?utf-8?B?ZCtBd3hiV24va3BvRzRLTXdZdGlhNXBQNmpWZURDaHl6SFNhMjgvdVZsTGJi?=
 =?utf-8?B?ZTZrUW1DVHdHa3M4T3BWeUVvRFZoOGVpdkRLekorTWVSd0NWTWpLQlNYSlhj?=
 =?utf-8?B?b2FGYnFLalNOWU94L2htVGRocGYyWVVlSUJuMEpPNlZJWnhWOTJOZDVLTXly?=
 =?utf-8?B?dWRSa3hCRHJTUlNUZ09VVWVlMm5jMVl6NHVHQTlGVjhEZXJUOEx3OUZrUjY4?=
 =?utf-8?B?NVBRbGQ3SnhHTjdOcU0wYnI0cjNDSElsQUlMUEVzZE1KeThZV20rZUE0c29p?=
 =?utf-8?B?cC9jZjZGSzVRZGMyUWorS3lUOTJKZjd0MlY3TGpCTHNFSXNaVXM5dnBaeU55?=
 =?utf-8?B?dzQ2MHQwaDQvTytwNlBHd0x0c1dZNlg0TlZza2VOSGdUZkZLNi95NHhrV3Jz?=
 =?utf-8?B?MHR4ZGhmeUZMUDQ5cXhKR2htQjNTUHpqNStvNVppc3VlZ3BJK0ZKMUg0UDBw?=
 =?utf-8?B?Q2Q3blBCQXYwQjAxZitKUlIwTE5pQkFzRmdrZkFBajFwTWJsSll5Mzk1Qklz?=
 =?utf-8?B?VXB4bmJROHI1SE5xSVR4RkhRVTEvZGw1YzY2c2dUNjgyYzdxSzNVNzRvMEFO?=
 =?utf-8?B?TnR1Vjhidy9jYW9vaGc1VnVOT3VYMUtCdGtmVkRtKytIc0hEK3VzdDBBMnkz?=
 =?utf-8?B?YnlFZzhqTnE2bWpGU3VLQ2MzWWQ0L1NRS215dlMvMnE1eERNSmp1T0FzSzhL?=
 =?utf-8?B?dUJHT3Z0Z3ViUEhtWnRFUkNNOHEwVUIxT3YxcVFNQzR4MzdscXMrK1dVa251?=
 =?utf-8?B?NktOR0lUNVp0N2trcThZbVIvZ1AySVR6cFpxbVQvRThmTjI0Y0dlWlI2cjFU?=
 =?utf-8?B?djJGdEkyWUgrc0VEWHd1MTc0aDJFZXF1K2FYYzQxUUN3dXBTUkJGcy9LN3V3?=
 =?utf-8?B?UmluZ3hJNlBTbEhQeUxtYjRpekJwZldKSDNycHdkeXZNVjJ5SmYxTHRWdXRw?=
 =?utf-8?B?ak4zbGNGYUkvQzNVMGN4NGRSeE96Y0JPUmtjSWp5ZU1NN25vcWRaSjhmOTNa?=
 =?utf-8?B?TXhDbjRZREtVV1VLMWpwTTljTmp1ZGhyZ0xDc3ptNGxTYXdZVzJxSUVNREhO?=
 =?utf-8?B?c2hrbGE1cHFSK3VLL1hNWUgrWjR0VVN6djJUdkNEY3NaVnNvcnFxS0MxNERC?=
 =?utf-8?Q?SwJJb4h0V5iaOE7MEXmzcs7Rx?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jwZkYPfTurb41ztsRvRVatM9pju8zPkQlmaFPuLhABZHU0C8Dq7fYBAb3H/bUc8QlPsY0YGnaHzN4LMtIHuXZE81GzvhqdzCGN88vbRsXTnnKsZnQ0OK2m9luWA4lCRiObFNXDbnMnyYsaJh6uBXiIcvu+75pG/hjJC4d+QIGZ7wCIm8Y2KHU5+sy3labnu6PPUMObp1ihyHCDNkzkiK31Lr+RHRNrV0+OA4gbwJuQCshelJZpcmRgFzaobgJN1CZda+pac1q5urRMvL6f2SdrYsqaIqel8DmE8Hzx6x4TCE6bU/EN6cga7OB8/7Xi2z/bYwKn9GcMav3E1le+YnjP0rQzI/n16a0ueCoMcX430VdBwMwACxvDJeFi7axnE59KyF5dzYiGolaJea15QyXprDrumYnvxK4TxB4csa+RKvrwzzimTLoy+P10VNoGKvhzuHV9GupHFGry0hFGvO5Cpw51UA4Q7qDheKYHNqEmWoSsJQcE5N6VUpsbQYB0GqH/SWRpqZmgLwOF6jSlx6XfRXeg6C4IT6FZIsMRFTp1cr1l0nsShjmkb0fdjRK8JYF/tlB11+M5LL4Fw63vhMa4ihjw9PWVcVR4enwIHZYcetBo+LPgogudMG2x9mmo/C
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bab8acd-d61b-4f18-1910-08dc0772845a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:59:20.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03weZQEyLg1tcOjcIlOVX0873FB14blgO3Qa0BiXD0nXLkdmk5klq2rPVgL1lIQITYFc4mLQQRcrmaSjdl8THw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6878
X-Proofpoint-ORIG-GUID: rh1ECNr0qvzJ3wVpdruqU3jqo7E_S199
X-Proofpoint-GUID: rh1ECNr0qvzJ3wVpdruqU3jqo7E_S199
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: rh1ECNr0qvzJ3wVpdruqU3jqo7E_S199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-28_02,2023-12-27_01,2023-05-22_02

VGhpcyBoZWxwZXIgaXMgdXNlZCB0byBsb29rdXAgZW1wdHkgZGVudHJ5IHNldC4gSWYgdGhlcmUg
YXJlDQpubyBlbm91Z2ggZW1wdHkgZGVudHJpZXMgYXQgdGhlIGlucHV0IGxvY2F0aW9uLCB0aGlz
IGhlbHBlciB3aWxsDQpyZXR1cm4gdGhlIG51bWJlciBvZiBkZW50cmllcyB0aGF0IG5lZWQgdG8g
YmUgc2tpcHBlZCBmb3IgdGhlDQpuZXh0IGxvb2t1cC4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhh
bmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHku
V3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBz
b255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCA3NyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgIDMg
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Zz
L2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGNlYTkyMzFkMmZkYS4uYTVjOGNk
MTlhY2E2IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5j
DQpAQCAtOTUwLDYgKzk1MCw4MyBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCXJldHVybiAtRUlPOw0KIH0NCiANCitzdGF0aWMg
aW50IGV4ZmF0X3ZhbGlkYXRlX2VtcHR5X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3Nl
dF9jYWNoZSAqZXMpDQorew0KKwlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcDsNCisJc3RydWN0IGJ1
ZmZlcl9oZWFkICpiaDsNCisJaW50IGksIG9mZjsNCisJYm9vbCB1bnVzZWRfaGl0ID0gZmFsc2U7
DQorDQorCWZvciAoaSA9IDA7IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KKwkJZXAgPSBl
eGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQorCQlpZiAoZXAtPnR5cGUgPT0gRVhGQVRf
VU5VU0VEKQ0KKwkJCXVudXNlZF9oaXQgPSB0cnVlOw0KKwkJZWxzZSBpZiAoSVNfRVhGQVRfREVM
RVRFRChlcC0+dHlwZSkpIHsNCisJCQlpZiAodW51c2VkX2hpdCkNCisJCQkJZ290byBvdXQ7DQor
CQl9IGVsc2Ugew0KKwkJCWlmICh1bnVzZWRfaGl0KQ0KKwkJCQlnb3RvIG91dDsNCisNCisJCQlp
Kys7DQorCQkJZ290byBjb3VudF9za2lwX2VudHJpZXM7DQorCQl9DQorCX0NCisNCisJcmV0dXJu
IDA7DQorDQorb3V0Og0KKwlvZmYgPSBlcy0+c3RhcnRfb2ZmICsgKGkgPDwgREVOVFJZX1NJWkVf
QklUUyk7DQorCWJoID0gZXMtPmJoW0VYRkFUX0JfVE9fQkxLKG9mZiwgZXMtPnNiKV07DQorDQor
CWV4ZmF0X2ZzX2Vycm9yKGVzLT5zYiwNCisJCSJpbiBzZWN0b3IgJWxsZCwgZGVudHJ5ICVkIHNo
b3VsZCBiZSB1bnVzZWQsIGJ1dCAweCV4IiwNCisJCWJoLT5iX2Jsb2NrbnIsIG9mZiA+PiBERU5U
UllfU0laRV9CSVRTLCBlcC0+dHlwZSk7DQorDQorCXJldHVybiAtRUlPOw0KKw0KK2NvdW50X3Nr
aXBfZW50cmllczoNCisJZXMtPm51bV9lbnRyaWVzID0gRVhGQVRfQl9UT19ERU4oRVhGQVRfQkxL
X1RPX0IoZXMtPm51bV9iaCwgZXMtPnNiKSAtIGVzLT5zdGFydF9vZmYpOw0KKwlmb3IgKDsgaSA8
IGVzLT5udW1fZW50cmllczsgaSsrKSB7DQorCQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVk
KGVzLCBpKTsNCisJCWlmIChJU19FWEZBVF9ERUxFVEVEKGVwLT50eXBlKSkNCisJCQlicmVhazsN
CisJfQ0KKw0KKwlyZXR1cm4gaTsNCit9DQorDQorLyoNCisgKiBHZXQgYW4gZW1wdHkgZGVudHJ5
IHNldC4NCisgKg0KKyAqIGluOg0KKyAqICAgc2IrcF9kaXIrZW50cnk6IGluZGljYXRlcyB0aGUg
ZW1wdHkgZGVudHJ5IGxvY2F0aW9uDQorICogICBudW1fZW50cmllczogc3BlY2lmaWVzIGhvdyBt
YW55IGVtcHR5IGRlbnRyaWVzIHNob3VsZCBiZSBpbmNsdWRlZC4NCisgKiBvdXQ6DQorICogICBl
czogcG9pbnRlciBvZiBlbXB0eSBkZW50cnkgc2V0IG9uIHN1Y2Nlc3MuDQorICogcmV0dXJuOg0K
KyAqICAgMCAgOiBvbiBzdWNjZXNzDQorICogICA+MCA6IHRoZSBkZW50cmllcyBhcmUgbm90IGVt
cHR5LCB0aGUgcmV0dXJuIHZhbHVlIGlzIHRoZSBudW1iZXIgb2YNCisgKiAgICAgICAgZGVudHJp
ZXMgdG8gYmUgc2tpcHBlZCBmb3IgdGhlIG5leHQgbG9va3VwLg0KKyAqICAgPDAgOiBvbiBmYWls
dXJlDQorICovDQoraW50IGV4ZmF0X2dldF9lbXB0eV9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9l
bnRyeV9zZXRfY2FjaGUgKmVzLA0KKwkJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4
ZmF0X2NoYWluICpwX2RpciwNCisJCWludCBlbnRyeSwgdW5zaWduZWQgaW50IG51bV9lbnRyaWVz
KQ0KK3sNCisJaW50IHJldDsNCisNCisJcmV0ID0gX19leGZhdF9nZXRfZGVudHJ5X3NldChlcywg
c2IsIHBfZGlyLCBlbnRyeSwgbnVtX2VudHJpZXMpOw0KKwlpZiAocmV0IDwgMCkNCisJCXJldHVy
biByZXQ7DQorDQorCXJldCA9IGV4ZmF0X3ZhbGlkYXRlX2VtcHR5X2RlbnRyeV9zZXQoZXMpOw0K
KwlpZiAocmV0KQ0KKwkJZXhmYXRfcHV0X2RlbnRyeV9zZXQoZXMsIGZhbHNlKTsNCisNCisJcmV0
dXJuIHJldDsNCit9DQorDQogc3RhdGljIGlubGluZSB2b2lkIGV4ZmF0X3Jlc2V0X2VtcHR5X2hp
bnQoc3RydWN0IGV4ZmF0X2hpbnRfZmVtcCAqaGludF9mZW1wKQ0KIHsNCiAJaGludF9mZW1wLT5l
aWR4ID0gRVhGQVRfSElOVF9OT05FOw0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgg
Yi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRleCBkNmM0Yjc1Y2RmNmYuLjU0MjEzNmIxNGEyZSAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2Zz
LmgNCkBAIC01MDIsNiArNTAyLDkgQEAgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2Rl
bnRyeV9jYWNoZWQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogaW50IGV4ZmF0
X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwgaW50IGVudHJ5
LA0KIAkJdW5zaWduZWQgaW50IG51bV9lbnRyaWVzKTsNCitpbnQgZXhmYXRfZ2V0X2VtcHR5X2Rl
bnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQorCQlzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgZW50cnksDQorCQl1
bnNpZ25lZCBpbnQgbnVtX2VudHJpZXMpOw0KIGludCBleGZhdF9wdXRfZGVudHJ5X3NldChzdHJ1
Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywgaW50IHN5bmMpOw0KIGludCBleGZhdF9jb3Vu
dF9kaXJfZW50cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfZGlyKTsNCiANCi0tIA0KMi4yNS4xDQo=

