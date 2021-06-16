Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD433AA038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhFPPqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:46:36 -0400
Received: from mail-eopbgr140104.outbound.protection.outlook.com ([40.107.14.104]:52032
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235074AbhFPPog (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoViHEB6Iy9tkMONlU0YGimjXkqXGe8RDX+Ji208hvX5pKefFwiz6wSqTN2Pr3hp0i9UCJYpFj7YA5+qAORMUeTmifcUxIcYJCn6jbRAT1csAzbaxlqayPH5GUjdyxfei6rWqSy5Zs7Oo21T6/KRsBxP9NK8jSvh/ly11/x6XTBlLTu696zljY4LIHk4yPgHJ4gb0YGHOwB3y9bYTKrylH1xo5KlY6AEsD95y/NVS6Yq3nrHGx55s3lcgQqi0TYrbxES0fca2Y4XGBR1R306pNhO07ylPAVOEiKvnBuhjcKHk/Tn87HxyOwhLJn4N9uED4vj4Nebpjj1bZnzT4Q8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3zrj4sU2DUOMpOC9YBn3IReRAUn0WD1eF0IkybJxmU=;
 b=XGURfRAoE5o9ZCiPy4fRdCSMkZZaWzFa0hhH/nRFnmpxAX/VrgtJcgbYSI2v3N7ogQJJvC6mvtOGKJwozAxaV0rvcd073BcU5E8eaABNO0aLJS3CCK2x8UEswzLwSqQLsFG7vo8JbHN5AuUiF/+m07Mbnu2EaTAO02s4W8FXCxjcqEGeIBZOFH+h1Hw5W42S10UUPAp/dTsuUn6wBBiy6QRNY7W5Pu/eKF4EIuh99gFxrr4p5bfE9rgqP9aJ5RvI21SFl3XR1HDRXMtMlExDyEwg9YnBYNuD/xweSwUuBo8GAwFbik/5zuYFHPurtBBpxbj/hXaTHu8ggja2/1kdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3zrj4sU2DUOMpOC9YBn3IReRAUn0WD1eF0IkybJxmU=;
 b=QBpTXtIsWEBbh+qa5iYiT3SeLY+bZanog86muhsGiFSIdVrr9ugUkhO89eBW7I/K3PRkpVQXlSQWaT/jKtgwc9R5JJnPCTIBUXswu4ZEaR+FSJBHtgsH0zLervGIBHqnVIiBvYx8F26Zhn13cM2K+McveXxYB4lYMboGvzZ5kuY=
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com (2603:10a6:20b:ad::22)
 by AM6PR0402MB3703.eurprd04.prod.outlook.com (2603:10a6:209:19::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 16 Jun
 2021 15:42:28 +0000
Received: from AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::91d3:83e4:d90:a710]) by AM6PR04MB5639.eurprd04.prod.outlook.com
 ([fe80::91d3:83e4:d90:a710%7]) with mapi id 15.20.4242.018; Wed, 16 Jun 2021
 15:42:28 +0000
From:   David Mozes <david.mozes@silk.us>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: futex/call -to plist_for_each_entry_safe with head=NULL
Thread-Topic: futex/call -to plist_for_each_entry_safe with head=NULL
Thread-Index: AQHXYE57zRithvFGzkuN4Iof4OaWJKsSXfgAgALQowCAAZy8IA==
Date:   Wed, 16 Jun 2021 15:42:28 +0000
Message-ID: <AM6PR04MB56395EFFAC06E835A4F67DA9F10F9@AM6PR04MB5639.eurprd04.prod.outlook.com>
References: <AM6PR04MB563958D1E2CA011493F4BCC8F1329@AM6PR04MB5639.eurprd04.prod.outlook.com>
 <YMZkwsa4yQ/SsMW/@casper.infradead.org>
 <87k0mvgoft.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87k0mvgoft.ffs@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=silk.us;
x-originating-ip: [80.179.89.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1250b4b-5d24-435a-a4fb-08d930dd58a9
x-ms-traffictypediagnostic: AM6PR0402MB3703:
x-microsoft-antispam-prvs: <AM6PR0402MB37039063AFD4955A2D9BE1B0F10F9@AM6PR0402MB3703.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +a6L+q9ddYygrbYl2ya3aFwGBxV8iHn3bYgMSJ7OZs2Vpl7WHZbEL2jZ/8s9sCJcT+m4HsYRkxeyO5+5Ep0CuUQcqqU2fUFIC14TUiz26q8HJjv+aDLEmq8kZTKxnZt5hAm3YX+OGlY7ZM+YHtmtobyaoHRbgLBYbRCv7DwNfUnTF6VjVHzK07hoN3P2ZN6uUf/0eMqLvngzp6m1qMQAxQpQuTqDAf8mgEN8fM9535xy3XlqB3+vzH6oulONk3hdI8bKc/yEec6PcaWmvIOluj9d83mtukigtYMLRqI1k+2LWZ+n6LgylWuCbH9FY69hYuPRNFtt7fKJkatQLopISYnofBCA6L0LYqIgQieif1pHmYUngDEijw9lylrTCifC2n6mEI6dBSOh8tUklG9yBgucjqSgxGeTGMJZRVZtlMCwDRNsVBY6Kgbz9s0l9SCUmFo5n3xw0pPVP3+iCn8miE3W4b6aON1auv/qNGl+2Ke5lEEDTy2wNa0gjabouNHef297bOqWQ+ICugwk0n+bU7+3/s3JxyyY46OyTA69k7v1C/8PvuQNVuE//AMSC6grcxfpChIxmoJp/U8/LAaXl9oupTH/qYmngZhlwv3NkxRMm2UWrxxUun7aeqP/54AMhggUpo//aXff+Wuj2qp5fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5639.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39840400004)(346002)(136003)(366004)(38100700002)(6506007)(316002)(110136005)(26005)(122000001)(53546011)(55016002)(83380400001)(186003)(54906003)(7696005)(478600001)(4326008)(5660300002)(86362001)(71200400001)(9686003)(66446008)(2906002)(52536014)(64756008)(66476007)(76116006)(66556008)(8936002)(33656002)(66946007)(44832011)(8676002)(80162007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2IwSlg1N3dvRjlYNW1MdzJEV1BkUWRneXV1WmpMMjNWZWR0bUh3TEd0REk5?=
 =?utf-8?B?WHBBWUtFVkF3ZUp6U3Y5dHNabjk4Qll5VXhZR0t0MWE0blZxVGVzYjBYZmhq?=
 =?utf-8?B?Qm5FRGtHa1Z5NHc3NlZXWlEvZzNZTEJLTUtWeTNQWCtEQkhGdStDamRYSVZM?=
 =?utf-8?B?M09UamJCbWpLWGJyWThjOTUwL1F2aENVaUdhYitUeXFJaGxUSll1eitZY1Bq?=
 =?utf-8?B?MDRTejQ4Qm1XekN1S1hGYnR0ODYzV0RYSy9xTjRnQ2g5cHhOc3g2ZjBIUDNu?=
 =?utf-8?B?NzNDWm1HMUlRUWhrRDJWY1RZdzR0K1dmbnRlaVdmMzJqcnFwNVVybmJyb3Fj?=
 =?utf-8?B?WmR1Zml3M3d6R3pXaHloVjN3bUp4L0FuS1lXbWFCL21ndVczbFU2K1ByeDE1?=
 =?utf-8?B?TUN2c25UMms4ekQzRXJWY2V5UzBUWkgybUNDcFJEQkhPTjZOTmtJclhRSVRB?=
 =?utf-8?B?aHRFQVRka0I4aitUMVh2QXRGQUdVTGZ5UDNEeXcvaHFNQWhlbWlIb1NKZThh?=
 =?utf-8?B?eU0wR25pNWhrV0hvd3REZFdnSHpWOURIbG80bzA0QU0xcDRjbkpjbGVsTmhj?=
 =?utf-8?B?OXJxQ0lsRXFmMUxtekR5MGJvZGNiV2xkNnZEa0pITUFmZmNlb2JwakFKd2hC?=
 =?utf-8?B?OW40YU5wdHpEVVUxN3Myd1MrUDRXYzF4RzVQNjAzQlhiOS9oaDM4ZlFjWmN3?=
 =?utf-8?B?RzFxaW9tQTZiUXZBbE93SWptaFB3YVo3TXlUdEpURWlBNzhrekUzZ1VuUEpF?=
 =?utf-8?B?UzRuN2RBejVZOHpQNWx4eXIydzdMWDdMUkh0Y21kWEVqM3Zkem5oaXFXeHAw?=
 =?utf-8?B?OGJ3NHdhN1huNDNYODN5VE50U0s4bEQ3Zy9zai80aitmdmR5bk5wUERSL3pP?=
 =?utf-8?B?UVV3ZUlYVmxxTEtMNy9Wck5zMlJuVCtDT1ptSFp0Wi9pWGtjNzF5Q0pTVFFM?=
 =?utf-8?B?RkdwUlBvMStyanZob0RQVjVoR0xVTXlvTUNtOW1lWmhOdEVYZWxwSmU2RzRa?=
 =?utf-8?B?WDM2RWxIQzVBZ2U3ZnBLZU1DS1A2YWJPbnc5RVNxMEF3TmNrQlFNYmZxWEVw?=
 =?utf-8?B?Y2FXM0RGRk1LUFhLb09jQWhlY1hGdHprTm5Nay9BcFBZYnJJMmdvY0NxZkRZ?=
 =?utf-8?B?ejh0MXpPZGtxTEZFdFVWdktPVkNLRERGbkdyVDBIM2c4NlB4eDFFVm9CakNG?=
 =?utf-8?B?L1E2Vm00QzAwM3pUNXVnOElaaS9YTHVhRWpPcTZiUDdJWmtlRFlGc3V3K1J0?=
 =?utf-8?B?US9ZeUd3bUdwOTZocmZreVNudW9TZVl1UUFIbmNVaFV0TUhPV3hyZjhXajRm?=
 =?utf-8?B?L0x6TUpWU0RrZkh2TEZMWFJvenduVzBxNUQ5QzM1TEg1VzJqdFV6N2VJMFFW?=
 =?utf-8?B?SDluTXo4dEprK1VqSWJPTHJmbW95QnBZcjFxUnlzV1c5NmdES2NTbTF4N2Q1?=
 =?utf-8?B?eXFaZmlFaFZxMzhDVVJHN01xSkZCNDhlU0ZITW9mNkVLSnpqSVl5a0d0THdt?=
 =?utf-8?B?K3RPVEZMSXJMaHlESmJIQ01UVmZxS2dEMm02YVVqSldrQ1pydzZwL3pQZXBr?=
 =?utf-8?B?K21GK0c3b1RHVVVlRWNTMVFPMm50ck5DWWdkVmJYWTlxd3R1eG9ma3RVWVlO?=
 =?utf-8?B?YU1RbXFsOHdxcG1BOUhhRDBrbWllY2I5aDd4YkZpcFVhV1lsUUw4N2tVNUlQ?=
 =?utf-8?B?RVozN2NRcExHVS93c0RCUXljaWFUVklFN0xOMERRL3gzZUxzWEVRVkFSSW1R?=
 =?utf-8?Q?nO61PzaRuvabBvf/ewwNGU4oIvAmFzeESKxhau5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5639.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1250b4b-5d24-435a-a4fb-08d930dd58a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 15:42:28.1645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhdlDKMyVfprTtFpElR9Zm+VG0BqsV/zZ1pos3+q6FFqpEMZadq2H6/DjLzJzkfNxG0LTsAuJmPaJ2iJzUssBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3703
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSBXaWxsIHRyeSB3aXRoIHRoZSBsYXRlc3QgNC4xOS4xOTUgYW5kIHdpbGwgc2VlLg0KDQpUaHgN
CkRhdmlkDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4gDQpTZW50OiBUdWVzZGF5LCBKdW5lIDE1LCAyMDIxIDY6
MDQgUE0NClRvOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IERhdmlkIE1v
emVzIDxkYXZpZC5tb3plc0BzaWxrLnVzPg0KQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwu
b3JnOyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz47IERhcnJlbiBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFkLm9yZz47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBmdXRleC9jYWxsIC10byBw
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlIHdpdGggaGVhZD1OVUxMDQoNCk9uIFN1biwgSnVuIDEz
IDIwMjEgYXQgMjE6MDQsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBTdW4sIEp1biAxMywg
MjAyMSBhdCAxMjoyNDo1MlBNICswMDAwLCBEYXZpZCBNb3plcyB3cm90ZToNCj4+IEhpICosDQo+
PiBVbmRlciBhIHZlcnkgaGlnaCBsb2FkIG9mIGlvIHRyYWZmaWMsIHdlIGdvdCB0aGUgYmVsb3fC
oCBCVUcgdHJhY2UuDQo+PiBXZSBjYW4gc2VlIHRoYXQ6DQo+PiBwbGlzdF9mb3JfZWFjaF9lbnRy
eV9zYWZlKHRoaXMsIG5leHQswqAmaGIxLT5jaGFpbiwgbGlzdCkgew0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtYXRjaF9mdXRleCAoJnRoaXMtPmtleSwgJmtleTEpKQ0K
Pj4gwqANCj4+IHdlcmUgY2FsbGVkIHdpdGggaGIxID0gTlVMTCBhdCBmdXRleF93YWtlX3VwIGZ1
bmN0aW9uLg0KPj4gQW5kIHRoZXJlIGlzIG5vIHByb3RlY3Rpb24gb24gdGhlIGNvZGUgcmVnYXJk
aW5nIHN1Y2ggYSBzY2VuYXJpby4NCj4+IMKgDQo+PiBUaGUgTlVMTCBjYW7CoCBiZSBnZXRpbmcg
ZnJvbToNCj4+IGhiMSA9IGhhc2hfZnV0ZXgoJmtleTEpOw0KDQpEZWZpbml0ZWx5IG5vdC4NCg0K
Pj4gwqANCj4+IEhvdyBjYW4gd2UgcHJvdGVjdCBhZ2FpbnN0IHN1Y2ggYSBzaXR1YXRpb24/DQo+
DQo+IENhbiB5b3UgcmVwcm9kdWNlIGl0IHdpdGhvdXQgbG9hZGluZyBwcm9wcmlldGFyeSBtb2R1
bGVzPw0KPg0KPiBZb3VyIGFuYWx5c2lzIGRvZXNuJ3QgcXVpdGUgbWFrZSBzZW5zZToNCj4NCj4g
ICAgICAgICBoYjEgPSBoYXNoX2Z1dGV4KCZrZXkxKTsNCj4gICAgICAgICBoYjIgPSBoYXNoX2Z1
dGV4KCZrZXkyKTsNCj4NCj4gcmV0cnlfcHJpdmF0ZToNCj4gICAgICAgICBkb3VibGVfbG9ja19o
YihoYjEsIGhiMik7DQo+DQo+IElmIGhiMSB3ZXJlIE5VTEwsIHRoZW4gdGhlIG9vcHMgd291bGQg
Y29tZSBlYXJsaWVyLCBpbiBkb3VibGVfbG9ja19oYigpLg0KDQpTdXJlLCBidXQgaGFzaF9mdXRl
eCgpIF9jYW5ub3RfIHJldHVybiBhIE5VTEwgcG9pbnRlciBldmVyLg0KDQo+PiDCoA0KPj4gwqAN
Cj4+IFRoaXMgaGFwcGVuZWQgaW4ga2VybmVswqAgNC4xOS4xNDkgcnVubmluZyBvbiBBenVyZSB2
bQ0KDQo0LjE5LjE0OSBpcyBhbG1vc3QgNTAgdmVyc2lvbnMgYmVoaW5kIHRoZSBsYXRlc3QgNC4x
OS4xOTQgc3RhYmxlLg0KDQpUaGUgb3RoZXIgcXVlc3Rpb24gaXMgd2hldGhlciB0aGlzIGhhcHBl
bnMgd2l0aCBhbiBsZXNzIGRlYWQga2VybmVsIGFzDQp3ZWxsLg0KDQpUaGFua3MsDQoNCiAgICAg
ICAgdGdseA0K
