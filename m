Return-Path: <linux-fsdevel+bounces-7868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C582BF32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 12:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568681C239EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC6367E7E;
	Fri, 12 Jan 2024 11:26:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2076.outbound.protection.outlook.com [40.107.239.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758167E7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=USbIZinfodata.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=USbIZinfodata.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeHXLX8iSy9D1o223F6mKwbHyiH8u6Y45866FEFILi/ajIDD0IvPtztdnnWM/DsOPoE0+WGhOqw1v/MI7rHmIt9lC1CTFGtuTeo0FuaXVIxy1Jya9gQlX002/I8URakxWif+5x6uue7vCB4KvujF1jXXtxMXwrANhcFCl1O7lpY4bnyGcW1grX8klKayJbrbNI35PAq0Ya83RLXs/wQQ98Z9OmXcSdOVFniuBKrhGmskwMVmK7Ls8rLQJnosL7teuqlKU67bv3F2lofKeGoVqfd5mo/oW4xLNorMXBtDYbDVbQhAlJ6eSDOjTYvwubqspkJuTdwaCsBx/kqdfgHYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYbiwBwZJTZJHEd0EjKCSCeNzfYoJoZk7uvn4Mpv7BI=;
 b=cs4+sJyvB0MAn6XeYH0ze3bwmWUiJ8Gjrydc+HcNc0zQut1zy0tAXYzvqq2cpIxahzhq6d0ZMFVQudbFqpapIaSisoGAYeW6VGba9lxcLjCJVh2W2AowAkMX6LmyQLwFVp/eNOBXFUl/e6QmSJMVrfijFsU2wpmBx4/s9PYgempWyFGDQr+zDVaxakvftbajWEZ9QZeio29na7VNsCKKkyRrSHCZPffikIuGffrkXEbqVRWzgqrZAhELO2w+gTB2ld0+NQu6W85N7J6PE+yLouXnL5T5XD8POkqk4ELeTbBiqmAkFm46P5GhygAYGukRR9+w3rkbjmdaD4ioLjr90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=usbizinfodata.onmicrosoft.com; dmarc=pass action=none
 header.from=usbizinfodata.onmicrosoft.com; dkim=pass
 header.d=usbizinfodata.onmicrosoft.com; arc=none
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:208::9)
 by MA0P287MB0697.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 11:26:02 +0000
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325]) by PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325%6]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 11:26:02 +0000
From: Emma Conner <Emma.Conner@USbIZinfodata.onmicrosoft.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: vger Hardware decisions makers
Thread-Topic: vger Hardware decisions makers
Thread-Index: AQHaRUoflQ0whZ/RlUK8XEJB9ysLug==
Date: Fri, 12 Jan 2024 11:26:02 +0000
Message-ID:
 <14a62520-0227-5149-f2a9-ee7454650cea@USbIZinfodata.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=USbIZinfodata.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2559:EE_|MA0P287MB0697:EE_
x-ms-office365-filtering-correlation-id: 7482a720-6487-475a-6211-08dc13614247
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r1aW5uPSMReCEJEIjcJIIoJaZRenL/mkTHanhBFOJZhc+BGNH5DtoFOC/3jlUt+3eQXa44MD1310jesuRQ4+uD7m3mgOVhxesdCCLhvnYgzLnwbdoWvslgWicyn0yjueb9+LUCHPpg29Ams/R1+9wAWz5rvOZMTz1q1izVMoq8/UY5szkQmNo3bzHT/PwNnIXXBD979vQoC0Q/K2nUnA2++XlcZMS/hHA5sJqLNGK96CkD7M0urT4P7y/PXayQDPzyS8rs1E/jBMbADWi5wNYKlBLnWYexxcPpqIIZMZyCtTvi074cq+Tq14bOmHnYF5c63ShpBksgGt8i3AYGNeUxgwYVS6pwcLhjCTuM5NvpoyShYcHkDau8JjbGMJ/Uco5GRSZgd5uH5z1UglqeiEHNHD4V6Av+dEdT4ZwbMadN5LfE7xVxAlFwocxldt8kvYpxHv2L9K0PF9j0Txq5SLUDHWmkoRC3rAUh+ME374FqDqUWqMmUGhlVgOYqfBUjDaWFd/5dB30ZATfVkYqguIqpXerzgJM6l7R19y7+1OO2n7b0gEVBH7wHV2yui63oPfoiO+S8FysQ8P8xtAnGP8Ss8PuwmksQRuYH6C+YX2MJa+JrtGVI+A5zi5ngaaF2iA2ptZuwQW12OPu/Re/FdxOg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2559.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(34096005)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(83380400001)(71200400001)(26005)(122000001)(3480700007)(38100700002)(66556008)(41300700001)(66476007)(76116006)(64756008)(66946007)(66446008)(6916009)(316002)(2906002)(8676002)(8936002)(6506007)(6512007)(91956017)(53546011)(478600001)(6486002)(5660300002)(86362001)(31696002)(31686004)(38070700009)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkIrVlA5S1dIYlN4TVRhaUpYaVdZZnJWUTgrOTJMREZHZkU1U2t0ZVJUTWE2?=
 =?utf-8?B?Y2VaZHpWTnBpUFJWZ3IrdUJ1NmM3Y3RxdFN6QS80bEdEZWliRklac3dXOG1B?=
 =?utf-8?B?c1NNK1dnNEx4UkdHbmkxM1IzRmFyTmpWZE5yazdWYlpxQTdaQk02dkc4L3g3?=
 =?utf-8?B?eVlOb0luS3B6WWgyeC8vaWNnV2I0aWtIdGIyUDdCUm1qWjNxaHhibDhLQmt0?=
 =?utf-8?B?RW9qbzEvYm40ZXpxVmNTbWU5b0FRSnhsWTAyRDJjSVV5U2g3QW56VVNERGZh?=
 =?utf-8?B?bU1NNVhGK3k0OXZzcmQ3Z05yTEJ2Q3Y0UE9EaGRTckYyQmNIcTFkRmlrNVpl?=
 =?utf-8?B?WW5MNmlrSjlGbjVORzNHWVoyYS9DczRQRVhneUVLb0hMZ1hsN1VoSjhqYzg1?=
 =?utf-8?B?OHZlRlNGVDVEbCttMm9ULzZ2Vk4vWHhnMzVrNjFKT2hCUVlkT0ZkeVc3WDYz?=
 =?utf-8?B?alU0dkJrMStMcG9ONE4xNlBzYW1PSFM5Unl2Vi96NGlJZFVubDY5Wk5CZUNz?=
 =?utf-8?B?VkJaRzJ3Qlo5VEtLU2lQcDZLaW5lSDRadVFZT2pDekg0RTE1Z0M3Z203MVhU?=
 =?utf-8?B?RVAzLytza0xjWFkyZmh1RmZoWUc4ZlYvUVViak9hOG5veWRJSCswNnhSMGox?=
 =?utf-8?B?a05CdXkvNkUxYXBBQUNpdUZPMU1qSmtHcFF1RGtITVJTMVY4OVZnZDdXcGM4?=
 =?utf-8?B?ZGovVkxaY1FzdVR2Mnd3dG5OampwbUlodlBkaExJVE9UdnlMT3R3akc4RUY0?=
 =?utf-8?B?SXI5UThyS1NqUk9Wb2thdXphTEdPaGJVWnJNbkhWeTNZdkF3OVo1c3ZTRzJC?=
 =?utf-8?B?bjBwQWorcXgvMitOMnlPVXhOWG1sbVp2TXg0V2thRXFuZUNoZjF5Nm1xNmR0?=
 =?utf-8?B?MWNuNnA2Njk1Y2c2aWp2Q1NsWVE4ZGtrQnhRb2N2bFY2ZDJUS0RjMHBFWXR3?=
 =?utf-8?B?T0F5V3ovSEh6OUxqRUdVaUY5SjRrbHlya1NXbDMwVGNOWkRTbVEzQThCR1BX?=
 =?utf-8?B?QXJ0YnBvNnBqbHppU0JkdXlDcXhKbkZuU1d5cXBHVVd4L1dGelJMQVBKRzlK?=
 =?utf-8?B?R2pJeVJTMEkrVzlzQmRkeEk1OXNtdXcxZW56WGRZM01wUy90UmU0YmVrWmRN?=
 =?utf-8?B?RHVXZUZjTERNU3lPRzRaL3NTcDQ2cURoSFZBMHZQdGdqUjRhOWg0Yi9pTzhT?=
 =?utf-8?B?K25Jck41MzdBWTJTWm9QM3pwY0hxZlp1UFVDMG12L01kRTFJYUF6dWlCU0or?=
 =?utf-8?B?YXZUYjljUVU2VWlaZWJzY1pkQU95LzJzbzFXVzZGc0psWWVtQnY1SjhSWEhl?=
 =?utf-8?B?THprcnFwdHpEZ2UxNDducGp0aDF0V1pQdDd1TWVWb1E0VDJ4WGh0QUo1QmZU?=
 =?utf-8?B?UlQ2SHprZ1RXUXlCc2N6OWFqZ0xvVE4waGxmbWd6eWVMSXA0QWJ5cFkvWTh0?=
 =?utf-8?B?d25FVjErZTlMNmJCUHNMZ1JySVNNdzUvRUQ3YXhLRVpWdDRWT0FaRS9UMlp3?=
 =?utf-8?B?N0dKSVRvWXhlSWNoN2g5K0UrMFUyQnpIZFIyY3J6UWVEU1p4UHRLbWdDRVBP?=
 =?utf-8?B?S3pxV2huVUFwZGVJT253U2JLZlBSckQrak80MWIzazRqeTNsbzJaWGF4VE5Z?=
 =?utf-8?B?RVZwZXZkbTdHQjRkVUxUWWlOd0JZSHd1cGlWQTVGd3JxdjNvaXk3MjM1Q3l0?=
 =?utf-8?B?U3lXMi9qMk8ydDA4TytYcy82Y1k5amNrdENaaFdqbWdwcjhSOGN6eGRRWTJy?=
 =?utf-8?B?TXR6N3NKMCtPL1lCUFY3UWhXWHRXZkErYS9reTZVckc2WUd1bDU1MEZ0M1FT?=
 =?utf-8?B?RkRRdjFhUEgwQWNoS0VLVThuVERuZ01DR3g1WC93NitIeUY2MnUvRGEvcnJ1?=
 =?utf-8?B?Q09uT0ZSb1FSZU1XVFo3N21iZ0hsVVArYXVqTml4eEtWVXQzejRlRWplQks3?=
 =?utf-8?B?WDYzaTZ1ZGxrS2ZYaTRKNXJyS1l2VFAyeCtMdDlzNDlCS2tNU1hKZVhnWmh3?=
 =?utf-8?B?L1hFZ0xramh1NE1xT1VkUWZoU2hDb3VsSkxaaUwwdnF1dGtvcENjKy9lcDNG?=
 =?utf-8?B?S2E1MllQb2FGUWo5STVXN0ozTVptdEtMSWtBZHpvVWhEYjRmV0IzejNncFRS?=
 =?utf-8?B?R3cvdUtKUlVyVmk5OWZVMGJXRlF5SHpYMHljMXFMTHVZenRCT2NWaHVGWkM2?=
 =?utf-8?Q?qLotUsS1fd5SYruJD1+F/hE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B29B09A925142A44B1B564822EEFAF49@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: USbIZinfodata.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7482a720-6487-475a-6211-08dc13614247
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 11:26:02.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8985d2c-274e-4d2e-b47a-e4113825a86d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hf27wcOdk8oKLDnli8iCvJ6ErO4lPwDh+JNkeHRmQJxzdxNynEoCydiSzTRg1s1426rGnCY+8Rj2ow1+xG8B0GMp+ImObmNyCLOJCkTZpMTqFRVRcJPCjkp0o2IKcazbj7eiH68QYQ4qK9XBPxP9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0697

SGksDQoNCkkgZW1haWxlZCB5b3UgYWJvdXQgb3VyIElUIGFuZCBjb21wdXRlciBkZWNpc2lvbnMg
bWFrZXJzIGNvbnRhY3RzIA0KZGF0YWJhc2UuIFdlIGNhbiBncmFudCB5b3UgYWNjZXNzIHRvIG91
ciB1cGRhdGVkIElUIGFuZCBjb21wdXRlciANCmRlY2lzaW9ucyBtYWtlcnMgd2l0aCBJVCwgSVMs
IEhlbHAgRGVzaywgQWRtaW4gbWFuYWdlcnMsIE93bmVycyBvZiBzbWFsbCANCmJ1c2luZXNzIGV0
Yy4NCg0KSSB3YW50ZWQgdG8gY2lyY2xlIGJhY2sgYW5kIHNlZSBpZiB5b3UgYXJlIGludGVyZXN0
ZWQgdG8gc2VuZCBtZSB5b3VyIA0KdGFyZ2V0IGpvYiB0aXRsZXMgYW5kIGluZHVzdHJpZXMgc28g
d2UgY2FuIHNlbmQgeW91IG1vcmUgaW5mb3JtYXRpb24uDQoNClJlZ2FyZHMsDQpFbW1hDQoNCkVt
bWEgQ29ubmVyIHwgTWFya2V0aW5nIENvbnN1bHRhbnQNCg0KT24gMDMtMTAtMjAyMyAxMTo0Mywg
RW1tYSBDb25uZXIgd3JvdGU6DQoNCkhpLA0KDQpXb3VsZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiBy
ZWFjaGluZyBvdXQgdG8gSVQgYW5kIGNvbXB1dGVyIGRlY2lzaW9ucyANCm1ha2VycyB0byBwcm9t
b3RlL3NlbGwgeW91ciBwcm9kdWN0cyBhbmQgc2VydmljZXM/DQoNCiDCoMKgIEMsIFZQLCBEaXJl
Y3RvciBvciBNYW5hZ2VyIGxldmVsIFRlY2hub2xvZ3kgb2ZmaWNlcg0KIMKgwqAgQywgVlAsIERp
cmVjdG9yIG9yIE1hbmFnZXIgbGV2ZWwgSVQgT3BlcmF0aW9ucw0KIMKgwqAgQywgVlAsIERpcmVj
dG9yIG9yIE1hbmFnZXIgbGV2ZWwgSW5mb3JtYXRpb24gc2VjdXJpdHkgb2ZmaWNlcg0KIMKgwqAg
Q29tcHV0ZXIgTWFuYWdlcnMNCiDCoMKgIEhlbHAgZGVzayBNYW5hZ2VyDQogwqDCoCBJbmZvcm1h
dGlvbiBTeXN0ZW1zIE1hbmFnZXINCiDCoMKgIEFkbWluIE1hbmFnZXINCiDCoMKgIElUIFNwZWNp
YWxpc3QNCiDCoMKgIE93bmVycywgQ0VPLCBQcmVzaWRlbnRzIGV0Yw0KDQpXZSB3b3VsZCBiZSBo
YXBweSB0byBjdXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZvciBhbnkgb3RoZXIgDQpy
ZXF1aXJlbWVudHMgdGhhdCB5b3UgaGF2ZS4gUGxlYXNlIGxldCBtZSBrbm93IGluZHVzdHJpZXMg
YW5kIGpvYiB0aXRsZXMgDQp5b3UgdGFyZ2V0IHNvIEkgY2FuIGdldCBiYWNrIHRvIHlvdSB3aXRo
IGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQoNCkFwcHJlY2lhdGUgeW91ciByZXNwb25zZS4NCg0K
DQpSZWdhcmRzLA0KRW1tYSBDb25uZXIgfCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQpSZXBseSBv
bmx5IG9wdC1vdXQgaW4gdGhlIHN1YmplY3QgbGluZSB0byByZW1vdmUgZnJvbSB0aGUgbWFpbGlu
ZyBsaXN0Lg0K

