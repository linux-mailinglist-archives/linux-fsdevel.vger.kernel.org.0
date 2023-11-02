Return-Path: <linux-fsdevel+bounces-1791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B67DED0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 08:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4742E1C20EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FD538B;
	Thu,  2 Nov 2023 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="HT4JtmH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774E442D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:04:52 +0000 (UTC)
X-Greylist: delayed 3253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 00:04:47 PDT
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92CB112
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 00:04:47 -0700 (PDT)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A25lFUT021999;
	Thu, 2 Nov 2023 06:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=GP+AvCXqGDPLVHVgxHIYZNY8FxFGNMIxISpXM7lTopA=;
 b=HT4JtmH47T87vkFDotJHzgZnVdMNJi88LsejqormnaQxcceXYFaYH/oOpdL2MA0UKIE8
 UXc4QhuD+zvgrLFH3zNtxr2WE3LA0EYUg5cFSIj6AYA7OiElFpAcLYcFcZYyieQkAmwy
 qikSDdDWLBje4/AcZmKHgHs5IXr5IFbb8ubQ71CJOsSFVxUiNgOXv9dxa9vl207ruzPM
 2CjWzh6f1nk8LFRhpAuqvqkG8+OWM1Vf6VZAmIZDueRvynlVTzkdDCp5/covl+9GKeJM
 ifZFWBks8DGB0ki0LCzQFW2PpMBIlPRfrlvJ/IO2vh70NVadGFDqJ3FIvH5nb2Iruemf XA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3u0sn158m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Nov 2023 06:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeMmvrgxr6ST2/o8FK6lEJDH0cDH2fSEnOJCLZ8utiKdDPDnYP/P+OoGhGUwHOI0BN7ls/MLZoXmphzJjgPGPOoDPn8X6xqe4/znU3vq7B4O8E2sqnh3iZZ9pXRUBgwWW97UZfPY1O4dcfOFlJgOQqf+ZEHoy1fIP20ptdW52KnFHXwZdRuWS5gHO+hBQcAsv4NgVRv80Ok3eFyLljafbe6bMmWrjriv5GPNUaKxAq3fG/FfRU6TAKb1vWvTn3lymPHPEGp03U9iwDuJAjOZTI4OTOpG30hTUVVUp3rsIjYsBijh8/fPfBf56398Cptci9Cid35+nCJC6hGCuAfk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP+AvCXqGDPLVHVgxHIYZNY8FxFGNMIxISpXM7lTopA=;
 b=EgjeD9KMta4Q70vFwPZpYtWA0OyktOHVG9mMlKHMwFvF48UygKlgXauyx4YPG3vLkiRvBRCGG97R8X1Y45E//mQZS33kloWfyamKQ56/jQ7h4JinmNx65DPKnxBY6DidC8G2I/2uWDOu4c4M0qYQfeWDnmBw3BEc1hMZ/prufB92QWeFa40vdfW7sKiqjM2MfeaPrDT1gRhqhDhp1YYBHzc0VHJqn7EhTjhIuAtqNolueNyLyuJ2BcwCwSaDXIG6hh8McKJVxs5YyZm2OlOKp/qgqWA8Jjl+68RH8k2fFekptL+cVXaR73JRwwIXpx0qYjbobqWdsjNrpJqxrmSUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB7408.apcprd04.prod.outlook.com (2603:1096:101:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 06:10:06 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::2fd0:f20f:14a9:a95a%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 06:10:06 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "jlayton@kernel.com" <jlayton@kernel.com>
Subject: [PATCH v1 0/2] exfat: bugfix for timespec update
Thread-Topic: [PATCH v1 0/2] exfat: bugfix for timespec update
Thread-Index: AdoNUo2ubol4mHQyT0KsoWiYzXkvjA==
Date: Thu, 2 Nov 2023 06:10:06 +0000
Message-ID: 
 <PUZPR04MB63168C9C4A8EE4321AC575AA81A6A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB7408:EE_
x-ms-office365-filtering-correlation-id: 1c5a5072-27f1-4315-3e52-08dbdb6a5c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8SdM3A/X5ki0rmtHlvwV+AIFBrDMeLOa/X+QCvS4Wj4fyzktJ9T8HcJjxhybWWzbjV2h5AMCvLmEA6Z+FikiIiCFb5eaZ3n7Hsl4FrHT32RcNX6HsPunu3tbXCF5cLYf1AC6JojKCmTXu++avJOXNL54fK54pEP3CV/kCEiXGFPoW32SgtdPDOdTnKDCK2Qpm3EcwcYDfhzvG+mkblRJCV3SO4bNPljYh0X9FtBvOcyZ6p1JE62FjqLZOxOgcaFR37AG2vBl8lVoYudvNF8fohUsp/bNObY/NIC6KqoBqNmaswje8fD9u5yZ95BnZVX+1GlEE2QRGLaqN7PHvITonkZV6XXXgD7dS3PvNGmRc09pYIlSP4GGRm2kJrReaMvUerJN49F3S1otZURQrPrD0Bm+a+rAmity9MYverdlGbdwAvWQfXQH9caig6VMjzB1sXahmjon0FlHSH9nv3FjItxXK+3B//BYptj+bSH/ENobmr6RM6sjRrim4+/BCkj7KLAO/uZHXxiQpjzfFjucMTfuJs1WfUivxWohd6H90Q5l7eGN4F5nO33vedTQz39gX6dwybA8kZb57HCgkZYB2k3UnwEZQF+KISTmVsknWv3p90LlTxmJrwxqSIncthaQ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(66946007)(76116006)(9686003)(478600001)(71200400001)(66556008)(66476007)(64756008)(316002)(54906003)(26005)(66446008)(52536014)(8936002)(8676002)(4326008)(83380400001)(55016003)(6506007)(7696005)(5660300002)(15650500001)(2906002)(38100700002)(82960400001)(41300700001)(122000001)(86362001)(4744005)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UzNkdXQwRGpkeU9rd2JCZ1dBdlBSTnZYQ2t6QzlEMHQvQWFZTDJ2VnRlNHR0?=
 =?utf-8?B?dEp2VE5FeDJSN1BmYmlCTWxYY1BSZWlhbEkyVUE2RmMwOXdWM2kxWVQyMWV0?=
 =?utf-8?B?aE1EMXNYS0lSRTFiVTdNSzEzNlNqTHpVRmZsTVMrWmt6ejBBbGk2MlR6MmY2?=
 =?utf-8?B?SXlQVnM5cWQ5NEdvd09qVjRZQU51SmVFNXJmWlBOMUJST0t1alF3UWh5UVN3?=
 =?utf-8?B?SXhidVJpVjZ5MVlLb2hJcFpJQTJXb1FTZG1XbzIzK2ZUK3RjUk1NcEFaSC9n?=
 =?utf-8?B?WXFhZXZEWmc4RFJjMElIb3gzNll2YUw0c3YrZUVyQlg2cUpMUmZrWVQvbitw?=
 =?utf-8?B?L09CZjlwOHdvUEV3ekRDWWNjSXIzNTlGSlgvTEQ3MHBaL1k0blQxUlBnWkRV?=
 =?utf-8?B?a0R0YmlqZ21nNjk5b08xNEFmRkdGcXlLdEtma3hmaWwvWnRFRTdzWTlZakpm?=
 =?utf-8?B?MlJoU3F1VEVudWdwMTZTc1VXNTJSeTd0L2UzYUI5Wk9yTFJqUnprRHU3Z2lo?=
 =?utf-8?B?Q2xuWDFBWmZJOHN5OG44ZEJqdHN0bXBBNGNqS3ZoMU41WmtrT2drT0RMcnE5?=
 =?utf-8?B?RkxUNlZ1SGFOazFycTk0cXpXSVBJSUhoVkQvamxuRHVVVDJuNjFzUTUzekpL?=
 =?utf-8?B?SXc2N2R1WTVaa1hTYUtGMHRSQlhkRWZLWXdTelZxMVN4SHVML0dzaUtPTHJX?=
 =?utf-8?B?cXJPSW9ISUlJNk5UZ0FsaXYxYjVseGg5RUpxR2N6WkVHa1MxelBYYmhvVmNV?=
 =?utf-8?B?cVE2cE5zUk9TdndHanRsOGtvS2RQbnV3RngxUHJQRDIzcFFDZ3RPVm5PeGtJ?=
 =?utf-8?B?Qm5sKzdGT3VOSThCY1l2WjFrVkYxcEVJd3FMZEM2ejR2VmpwRS96WUJoV3VB?=
 =?utf-8?B?Vk9RYnZ4SGRRWGtOa2M1dFZGTXBzbG5DMVlZZ2ZhOGNzbi9jY2laRVBrYkpO?=
 =?utf-8?B?bTdBYVpEcEQwNXluVEErQU93YWZzQ3JzVWxZWDBPZmJ6b0oyYVpVZEh0Y2N2?=
 =?utf-8?B?ejZlUjRTSUlmUGNJb1hrdWFiUC9pTGdTb1lHbzB2V0tmeWZ3c2N2bjg4aitW?=
 =?utf-8?B?YStqQyt4a1lVSXp4YlBFOGdpR1pLQmdqbG1QemJ2OThTT2VWbVBIY3RWUk9o?=
 =?utf-8?B?Mk9rM29yQ3pSeGRDdHRpNEg4cXZNRVNIa2JaVWRpb0lzbFcrR2JsZk1qWHBQ?=
 =?utf-8?B?Nzd6Y243cWphTXFJVm0wVFpxLzkzaEtrNEJsUUM3VTVvVDBHNjNQUXhabitl?=
 =?utf-8?B?UWRqcnJlUktJWWd1TTg5ZUZaT3FzZWQ0TVI4end1MTFTaGE1THFlb0ZsTjVy?=
 =?utf-8?B?bSsyMHR6TkV6Z1hvUjhXTU9MbHpLYUZlQW9DdUltZUNKLzNvd3loWVZBRTVW?=
 =?utf-8?B?RUc1SUx0RXdwQUNhcDFScHNKd2RURHF2VXhVOUlBcEkyQ29KMDgxTUhNVHpK?=
 =?utf-8?B?YWxNZEhscG4vQVRNMjdlSGJ4bkhta0Z1MlhUOGw2TkpGeGpsVEQvMWhqWWRN?=
 =?utf-8?B?bWFlQ0pHaGNPM1Judy9KL0FmeDBzRDhZMjJLQjhVdHR4elhZR0ZkaElRaWww?=
 =?utf-8?B?T0Z1dUYxQ2h6YW4vemRCRzFhVlNIUnBVSXdBRTd4SW5jd3FFR2JtL0J1Tklx?=
 =?utf-8?B?cUxWQUo2cjZKZFVCT1R6NGYwV01GaEJXNE9EZnM3M291Z0JLcitSVko0dlVG?=
 =?utf-8?B?VWdKNDhEYXpYM1dFYnFUelJUcFR4djI0eEIxcUVzclp6dW9tTEZPY0o2bzd1?=
 =?utf-8?B?SGJ5T3VCaklRd1cvb05xa0NBbTBJVUo5NnhmeXQxdDlGOEkzOTcxaDlVM0Vi?=
 =?utf-8?B?dkhJQlVidzAyaHcrVDJ6VEFNdTVyS3grRWo5QXpHRGh2dmsxUXZLMEFXWXAw?=
 =?utf-8?B?R1pPWVRNUEdPQ0pEeFlzZFhKWDk2dXhBMUtRSE5IV1RCMkZSbzZKVERwUWJl?=
 =?utf-8?B?c3c0RHdxaUhtWTJsTjNRK3ZVK1dGVVJwcHNpQUhvbXFoTUZ4Y05SL1l6SkNQ?=
 =?utf-8?B?OWtBVzYzK0prcGJNanZueWFleGNxU0JPeU16T1cwRlNqWW5FS081d2ZRcW1N?=
 =?utf-8?B?TzE0QnIvZzRSa2EwVjlKcWQ3WEJ1ZEhNT2VHY21KTC8rZjcyOWJoc1d2dDY4?=
 =?utf-8?Q?64EUyUjFeC/qqFbTwDGUttE2N?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1iR4K04fMhHWhSevG/jB48u85ojtw3Epoi9NPKtX0X/40VNadkZ7xyYupL2qz1BAyvDTj0Ntuc7p1t4P68+9mt/UmmN1AbqmSXOehTBwZsittuPKIbqPjR0AJYRFfbXohOcVrLgsxDULkpb1BEDMenrZ1MqAekXCs06aDEycJACyWggLR9IU3bJrYpz2Bx/XuPolOjsmBbyQB7sxKpf5V3S6XEJd0ASiL9g02gYuuppa3Gw5LbRT7zvLJOzqI3c+ynKNfsc8b0Px4gKMIep/oo9l0rHC6gGd13Y5m6pOIx23vNmGAaBlo06UjZnLFZ9F7TGPDDVheAadhZAuiQfMhL+zSkaA8Ne0W7DnD9oJC0Yuz/86RdpJB/3b1ss17hVLdBKycvIfPuYteKhfjh8Z5vry5jHix/UTI7p30TqcjSAYpy9MDUjJzeuH0dP4UinHig+mMhIYo89WNvdSFu4LVNsOI60T0wlfv6l4kg++OjBRloa9ayRGvMAZ5VlNd3rYnVleIlc/oejvwN2osMps5tN76jbVevLN0HRJyqiLbdSo3q9Cv02+wO2bJtHqUdrx59v9OMBrYq+R9b1+NgfMHx9kly0Me9M/35w9yjr2Jz+Fwlh4eMNAFZZeVlNpaYzWeT+zZuxu8KlK1Jub4RdlOnFHXM83tuIeQtk1aGbU2sSpfVQmnbR8Vl8uENV1tHLjZuZ8m4ZHWBrr/tdsze7clvdTG11iwvBrR0oociMK6iGDiTkm7lgzDXlnJaArbfcbloGzTONQqfDwpsqmAmZtCZ6ZBn1D792A1nX3r104Vg/lastRoW9e3siKC8EW/kVHkkGgEAdbC+cTE6NRaG7/8CvrGYb3hTPgTQ3vJUfBRNjpQoT1M0SnAXAOty4e5ho4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5a5072-27f1-4315-3e52-08dbdb6a5c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 06:10:06.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWN4x5xfyuC4OfESuhH+0CqLMDtiPrW3IO/e4MTTwvwvS49v4Ybjs28FqcG8toeCj/CKqHosCrYyMhMPkG6KPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7408
X-Proofpoint-GUID: 4Nyu8j_U113FJd_vYbXF6XwgOI-Sn1A5
X-Proofpoint-ORIG-GUID: 4Nyu8j_U113FJd_vYbXF6XwgOI-Sn1A5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 4Nyu8j_U113FJd_vYbXF6XwgOI-Sn1A5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02

VGhlc2UgcGF0Y2hlcyBhaW0gdG8gZml4IHRoZSBidWdzIHdoaWNoIGNhdXNlZCBieSBjb21taXQN
Cig0YzcyYTM2ZWRkNTQgZXhmYXQ6IGNvbnZlcnQgdG8gbmV3IHRpbWVzdGFtcCBhY2Nlc3NvcnMp
Lg0KDQpUaGUgYnVncyBjYXVzZSB4ZnN0ZXN0cyBnZW5lcmljLzAwMyBnZW5lcmljLzE5MiBnZW5l
cmljLzIyMQ0KdG8gZmFpbC4NCg0KWXVlemhhbmcgTW8gKDIpOg0KICBleGZhdDogZml4IHNldHRp
bmcgdW5pbml0aWFsaXplZCB0aW1lIHRvIGN0aW1lL2F0aW1lDQogIGV4ZmF0OiBmaXggY3RpbWUg
aXMgbm90IHVwZGF0ZWQNCg0KIGZzL2V4ZmF0L2ZpbGUuYyAgfCAxICsNCiBmcy9leGZhdC9pbm9k
ZS5jIHwgNCArKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi4yNS4xDQo=

