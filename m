Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8E2CB4ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 07:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgLBGTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 01:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLBGTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:19:40 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0708.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::708])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE246C0613CF;
        Tue,  1 Dec 2020 22:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZeqfGIRTQdmUXrC18vsdMw2fnsD/Bh4jUEYDjD1HX85zu0fZs1Q52z5VAcb4dpKaOZnKFNUSj1SkhTPDBPM6mIDL/ZcY8GGUiIyAlif8F5GlohYQaFSJpF/ZDp+pz7wsHYXVQ6yDXXrVp7h+5mO0PBQs/e+1c60GTVBjp9GljjZvR2VedwpcGuAkAKukeJOHpvpuz0F+yv+5GbtBfdM/tIVL67ShFUxOo+icdbiv7HiLu7FY1xgYVisgWHxpESSDybVsN6DMsOItZkEbDLP3bFR2bCCaggfpE6KPtxTJIDDuotvbMIaa03YbKH9AlEwmjfN999r53wJeW2nKRhcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj6pqP2WRwi8JB9mSXGXswD/Vk1syWXpOyJXUeXd/Bc=;
 b=n3C0oqmsBloLWfHqxjHqy6vXiZULEdbDaObuMY0+Cac9QV9d5aFkXnRzGc2sfg37xYURbNTUIYOrVThCo73CbEiKSOfFk5NOUFl6n1RczH3BVRGhsri613CnI6fpIlfvXbhkPFvcx4L8wxb67ZTWUDh2NzTFnkG4Z9CdOyvC0t1VNFA8BlL9/OtoxG/uBqSK/i2iFOOB3jpqd6lbvFfZZWrmdr51nA7HZkMoRUvwqYFUST3o3TMasw1uKYvsRLzhvwWEtY/uURollBfWnQuyPgTS0O4CAg7mSeD/OWOluA+reFVXA8FDQROrIDfCZN72yYujsqk+QTo/kBdyDNVz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj6pqP2WRwi8JB9mSXGXswD/Vk1syWXpOyJXUeXd/Bc=;
 b=UxDrV9uc3JNmETtcK5jNRDjh0CPhVic3CJUv8cUvXI3I2ADgjxbVf/QFZMQH1l7ASI8iw2Il4VGKxaB7udDIAzwhSStJ+KLq1JUjazu/Zkdi3Do0ES3e67AXkr53J+2C3EMxmSkR+9/OejnJCilF6Xh49OXgoIEBosnGMrYSb2c=
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR07MB4169.eurprd07.prod.outlook.com (2603:10a6:7:9d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20; Wed, 2 Dec 2020 06:18:44 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::2cc9:4540:2eb2:a434]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::2cc9:4540:2eb2:a434%6]) with mapi id 15.20.3632.015; Wed, 2 Dec 2020
 06:18:44 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "adobriyan@gmail.com" <adobriyan@gmail.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: /proc/net/sctp/snmp, setns, proc: revalidate misc dentries
Thread-Topic: /proc/net/sctp/snmp, setns, proc: revalidate misc dentries
Thread-Index: AQHWyHL8IEJP8DBrh0miKxWS/S9Zwg==
Date:   Wed, 2 Dec 2020 06:18:44 +0000
Message-ID: <6de04554b27e9573e0a65170916d6acf11285dba.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nokia.com;
x-originating-ip: [131.228.2.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84218bf3-08a0-49d6-c7ae-08d8968a1f6b
x-ms-traffictypediagnostic: HE1PR07MB4169:
x-microsoft-antispam-prvs: <HE1PR07MB416991B02A79050691DBA902B4F30@HE1PR07MB4169.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wJIbB5Q2O0iDnPFgxlZCURZJfLpFhhzSb2BqkkzniE14MpK0o5vRKpBr0PVlI01vWBwFAFL2eb6nTaZKo+XngYr/9IIJaA1BVtgfS3g8V6OaF8IQ33BdAP8wypgaRNfdNqn9ljsfWK04YCAY5YjIvIrSZZWfF0JekW0VBbov+DQS8KC5nDAY26RXst3MogvIBHjHVmN9r25MHmaHN2SByxVwBz1Rz1q3xsIv7CMveiq9yg1Ck2PQ5U5gBFhRBL0Tv33GFo57KosU2fVuQxHzZHtLLcuL0nChG0cFqRYUHCf/jQlYF/g/z23N8eTpTW+PGeZWlO34v5L2ouqK9X1M5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(99936003)(26005)(2616005)(6486002)(54906003)(186003)(6506007)(8676002)(6916009)(76116006)(6512007)(83380400001)(66576008)(86362001)(66946007)(71200400001)(66446008)(66476007)(478600001)(66556008)(64756008)(2906002)(5660300002)(4326008)(316002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NlI0ektlbGxibFBJMm12ck5Qa0orY3FwTVpvejBYSHIxVG9lKzg3cWk3aUJY?=
 =?utf-8?B?NXVmVFM3K2gzeEduVEZndHhkUTFzZkFieGtuMEFJZDlsQzE2VWoxVGRqeVhx?=
 =?utf-8?B?K0xBL2k3RUd0RnJScVZHVjd6TFFmd2kxMDQ0TEVaQWw1RjNXTzBZMk5hOGR5?=
 =?utf-8?B?MGNKRE9WT243NGxORTg4eDhpRW1RUXRyVEVIdHcxWmMvc2hGYnN5dW80K1Fp?=
 =?utf-8?B?UnphUHl5bE45TXA2RXdnK0ZvcTFRVWRzVVlYZ1FBUnlPaG9QaG9MbjNYRU4r?=
 =?utf-8?B?UHNqQTlzSmlMVmhLSjloSGZTUnVVYVZybHdqUmtkcFNDUE0wR1BCSkZXb0kz?=
 =?utf-8?B?RUVJbnJReEdNb0V0Tkdsd1V3ckFBOE9kUmFTVndTOUI1Z2RYdDB4SjdJc2E3?=
 =?utf-8?B?UFQrRjl1WkU5ZnJlKzJuZCs1RXNhUkQ3WUJMc1kwYWRQakozVHB4QVk0U1Rw?=
 =?utf-8?B?aTd5SDNBM3V5aGpUTHBMdkMzeHpaRUI0c2dCQTN2MFROY2phcFRzWVljMndE?=
 =?utf-8?B?ZnpwSjBkVGllcFRrWi9sTFNCTU41V0tGWitXTFJybldueWIrL2MrN3NTRkJF?=
 =?utf-8?B?azhSaU8rQkd3bTJMVmk5VWtDS0hpRXE0bGRaY3ArWDdHa0V1Z29jVFJ6cG0w?=
 =?utf-8?B?L2c3MUhJYWw3L29jUXdQMC8wT0FxQ0IvK2hBeGF5Z1J6SDl1cHdtMy9lUHBl?=
 =?utf-8?B?eFZXalovcVNEdHFJcitRSTZjcnJWUUdoK1IvVTlqZGRQQUN4MkVKZEpXeHo1?=
 =?utf-8?B?SnlsSU5DMElZQUVRTU9RaklNczNDQzVXR1VpOEVvclVDRFVTdkxwK29HTm1H?=
 =?utf-8?B?elVoRHRDYSs3V1VCWHk1Y1BRUGNBNjBremRPaDZzenZtaHpLZ2ZBODM4QzNv?=
 =?utf-8?B?WEUzdnhJa2tZVTBsdDRkQkRHb3UxYW1wbjg1YkJVUUdvTnZJL1V6S2lycE00?=
 =?utf-8?B?YnhlVU5wb2NvOTUycDJjTDV3Y0kvL0IzTUpieVNDVnhsS21xb080WHY4T0R1?=
 =?utf-8?B?dTZkeFowbDFISmIwVFFMZU1iZGlEYWJjcXREQ2F1Qktrd2hSUW9iL3lsTmxS?=
 =?utf-8?B?WG1BcTJDNnczd0dmU0ZXRytmQWNLcHgzTlp2UDRZRnRvRThTWmxsSS9yVGtI?=
 =?utf-8?B?TXFQemRjRUF3SlFXbHJ3UGtlcGI2azdybkFUSVBhenBFSkZIODMzb0FnWlNZ?=
 =?utf-8?B?Tk02ME1zTVk2V2oxUGQxTjk4aDF1UFlOV3NYaWoydDFGOWYrK2ZOQTZQS3ph?=
 =?utf-8?B?eTV0cjBSK1lDakl0VGtxNHRsSTFpK2RUM3RiZmhHdmlmdVRyWlJLN2xIZkUv?=
 =?utf-8?Q?c/cUPx1V3txpoOOpKAjEN817CIsfq1jXE2?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_003_6de04554b27e9573e0a65170916d6acf11285dbacamelnokiacom_"
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84218bf3-08a0-49d6-c7ae-08d8968a1f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 06:18:44.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1h0+p0QQZxb7HdpFbSgIYjbm2NuexZ6Ls91NverWW949E6ehbWjZqzqZsYJy/yL0FsAylynaQyHDwE5Z8FJ5Nkaohx2Q62zoGJ2CTIWxM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4169
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_003_6de04554b27e9573e0a65170916d6acf11285dbacamelnokiacom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <381EFE5293899C4D8AB27AEFB38D2E35@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkJpc2VjdGVkIHByb2JsZW1zIHdpdGggc2V0bnMoKSBhbmQgL3Byb2MvbmV0L3Nj
dHAvc25tcCB0byB0aGlzOg0KDQpjb21taXQgMWRhNGQzNzdmOTQzZmU0MTk0ZmZiOWZiOWMyNmNj
NThmYWQ0ZGQyNA0KQXV0aG9yOiBBbGV4ZXkgRG9icml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+
DQpEYXRlOiAgIEZyaSBBcHIgMTMgMTU6MzU6NDIgMjAxOCAtMDcwMA0KDQogICAgcHJvYzogcmV2
YWxpZGF0ZSBtaXNjIGRlbnRyaWVzDQoNClJlcHJvZHVjZXMgZm9yIGV4YW1wbGUgd2l0aCBGZWRv
cmEgNS45LjEwLTEwMC5mYzMyLng4Nl82NCwgc28gMWZkZTZmMjFkOTBmDQooInByb2M6IGZpeCAv
cHJvYy9uZXQvKiBhZnRlciBzZXRucygyKSIpIGRvZXMgbm90IHNlZW0gdG8gY292ZXINCi9wcm9j
L25ldC9zY3RwL3NubXANCg0KDQpSZXByb2R1Y2VyIGF0dGFjaGVkLCB0aGF0IGRvZXMgb3Blbity
ZWFkK2Nsb3NlIG9mIC9wcm9jL25ldC9zY3RwL3NubXAgYmVmb3JlDQphbmQgYWZ0ZXIgc2V0bnMo
KSBzeXNjYWxsLiBUaGUgc2Vjb25kIG9wZW4rcmVhZCtjbG9zZSBvZiAvcHJvYy9uZXQvc2N0cC9z
bm1wDQppbmNvcnJlY3RseSBwcm9kdWNlcyByZXN1bHRzIGZvciB0aGUgZGVmYXVsdCBuYW1lc3Bh
Y2UsIG5vdCB0aGUgdGFyZ2V0DQpuYW1lc3BhY2UuDQoNCg0KRXhhbXBsZSwgY3JlYXRlIG5ldG5z
IGFuZCBkbyBzb21lIHNjdHA6DQoNCiMgLi9pcGVyZi1uZXRucw0KKyBtb2Rwcm9iZSBzY3RwDQor
IGlwIG5ldG5zIGFkZCB0ZXN0DQorIGlwIG5ldG5zIGV4ZWMgdGVzdCBpcCBsaW5rIHNldCBsbyB1
cA0KKyBpcCBuZXRucyBleGVjIHRlc3QgaXBlcmYzIC1zIC0xDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KU2VydmVyIGxpc3Rlbmlu
ZyBvbiA1MjAxDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KKyBpcCBuZXRucyBleGVjIHRlc3QgaXBlcmYzIC1jIDEyNy4wLjAuMSAt
LXNjdHAgLS1iaXRyYXRlIDUwTSAtLXRpbWUgNA0KQ29ubmVjdGluZyB0byBob3N0IDEyNy4wLjAu
MSwgcG9ydCA1MjAxDQpBY2NlcHRlZCBjb25uZWN0aW9uIGZyb20gMTI3LjAuMC4xLCBwb3J0IDUw
Njk2DQpbICA1XSBsb2NhbCAxMjcuMC4wLjEgcG9ydCA1NDczNSBjb25uZWN0ZWQgdG8gMTI3LjAu
MC4xIHBvcnQgNTIwMQ0KWyAgNV0gbG9jYWwgMTI3LjAuMC4xIHBvcnQgNTIwMSBjb25uZWN0ZWQg
dG8gMTI3LjAuMC4xIHBvcnQgNTQ3MzUNClsgSURdIEludGVydmFsICAgICAgICAgICBUcmFuc2Zl
ciAgICAgQml0cmF0ZQ0KWyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRy
YXRlDQpbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgNi4wMCBNQnl0ZXMgIDUwLjMgTWJpdHMvc2Vj
ICAgICAgICAgICAgICAgICAgDQpbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgNi4wMCBNQnl0ZXMg
IDUwLjMgTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgDQpbICA1XSAgIDEuMDAtMi4wMCAgIHNl
YyAgNS45NCBNQnl0ZXMgIDQ5LjggTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgDQpbICA1XSAg
IDEuMDAtMi4wMCAgIHNlYyAgNS45NCBNQnl0ZXMgIDQ5LjggTWJpdHMvc2VjICAgICAgICAgICAg
ICAgICAgDQpbICA1XSAgIDIuMDAtMy4wMCAgIHNlYyAgNi4wMCBNQnl0ZXMgIDUwLjMgTWJpdHMv
c2VjICAgICAgICAgICAgICAgICAgDQpbICA1XSAgIDIuMDAtMy4wMCAgIHNlYyAgNi4wMCBNQnl0
ZXMgIDUwLjMgTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgDQpbICA1XSAgIDMuMDAtNC4wMCAg
IHNlYyAgNS45NCBNQnl0ZXMgIDQ5LjggTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgDQotIC0g
LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtDQpbIElEXSBJbnRl
cnZhbCAgICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUNClsgIDVdICAgMC4wMC00LjAwICAg
c2VjICAyMy45IE1CeXRlcyAgNTAuMQ0KTWJpdHMvc2VjICAgICAgICAgICAgICAgICAgcmVjZWl2
ZXINClsgIDVdICAgMy4wMC00LjAwICAgc2VjICA1Ljk0IE1CeXRlcyAgNDkuOCBNYml0cy9zZWMg
ICAgICAgICAgICAgICAgICANCi0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtIC0gLSAtIC0NClsgSURdIEludGVydmFsICAgICAgICAgICBUcmFuc2ZlciAgICAgQml0cmF0
ZQ0KWyAgNV0gICAwLjAwLTQuMDAgICBzZWMgIDIzLjkgTUJ5dGVzICA1MC4xIE1iaXRzL3NlYw0K
WyAgNV0gICAwLjAwLTQuMDAgICBzZWMgIDIzLjkgTUJ5dGVzICA1MC4xDQoNCmlwZXJmIERvbmUu
DQorIGNhdCAvcHJvYy9uZXQvc2N0cC9zbm1wDQpTY3RwQ3VyckVzdGFiICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMA0KU2N0cEFjdGl2ZUVzdGFicyAgICAgICAgICAgICAgICAgICAgICAgIDAN
ClNjdHBQYXNzaXZlRXN0YWJzICAgICAgICAgICAgICAgICAgICAgICAwDQpTY3RwQWJvcnRlZHMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0KU2N0cFNodXRkb3ducyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDANClNjdHBPdXRPZkJsdWVzICAgICAgICAgICAgICAgICAgICAgICAgICAw
DQpTY3RwQ2hlY2tzdW1FcnJvcnMgICAgICAgICAgICAgICAgICAgICAgMA0KWy4uLl0NCisgaXAg
bmV0bnMgZXhlYyB0ZXN0IGNhdCAvcHJvYy9uZXQvc2N0cC9zbm1wDQpTY3RwQ3VyckVzdGFiICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMA0KU2N0cEFjdGl2ZUVzdGFicyAgICAgICAgICAgICAg
ICAgICAgICAgIDINClNjdHBQYXNzaXZlRXN0YWJzICAgICAgICAgICAgICAgICAgICAgICAyDQpT
Y3RwQWJvcnRlZHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0KU2N0cFNodXRkb3ducyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDQNClNjdHBPdXRPZkJsdWVzICAgICAgICAgICAgICAg
ICAgICAgICAgICAwDQpTY3RwQ2hlY2tzdW1FcnJvcnMgICAgICAgICAgICAgICAgICAgICAgMA0K
U2N0cE91dEN0cmxDaHVua3MgICAgICAgICAgICAgICAgICAgICAgIDE1NDQNClNjdHBPdXRPcmRl
ckNodW5rcyAgICAgICAgICAgICAgICAgICAgICAxNTMwDQpbLi4uXQ0KKyB3YWl0DQoNCg0KQnV0
IG5vdyB3ZSBzZWUgYWxsIHplcm9lcyBpbiAvcHJvYy9uZXQvc2N0cC9zbm1wIHdpdGggdGhlIHJl
cHJvZHVjZXI6DQoNCiQgZ2NjIHJlcHJvLmMgLW8gcmVwcm8gICAgICANCiAgICAgICAgICAgICAN
CiMgLi9yZXBybw0KL3Byb2MvbmV0L3NjdHAvc25tcCBbcGlkOiAxNzU5OThdDQpTY3RwQ3VyckVz
dGFiICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0KU2N0cEFjdGl2ZUVzdGFicyAgICAgICAg
ICAgICAgICAgICAgICAgIDANClNjdHBQYXNzaXZlRXN0YWJzICAgICAgICAgICAgICAgICAgICAg
ICAwDQpTY3RwQWJvcnRlZHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0KU2N0cFNodXRk
b3ducyAgICAgICAgICAgICAgICAgICAgICAgICAgIDANClsuLi5dDQoNCnNldG5zKC9ydW4vbmV0
bnMvdGVzdCkgLi4uDQovcHJvYy9uZXQvc2N0cC9zbm1wIFtwaWQ6IDE3NTk5OF0NClNjdHBDdXJy
RXN0YWIgICAgICAgICAgICAgICAgICAgICAgICAgICAwDQpTY3RwQWN0aXZlRXN0YWJzICAgICAg
ICAgICAgICAgICAgICAgICAgMA0KU2N0cFBhc3NpdmVFc3RhYnMgICAgICAgICAgICAgICAgICAg
ICAgIDANClNjdHBBYm9ydGVkcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAwDQpTY3RwU2h1
dGRvd25zICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0KU2N0cE91dE9mQmx1ZXMgICAgICAg
ICAgICAgICAgICAgICAgICAgIDANClsuLi5dDQoNCg0KLVRvbW1pDQo=

--_003_6de04554b27e9573e0a65170916d6acf11285dbacamelnokiacom_
Content-Type: text/x-csrc; name="repro.c"
Content-Description: repro.c
Content-Disposition: attachment; filename="repro.c"; size=1127;
	creation-date="Wed, 02 Dec 2020 06:18:44 GMT";
	modification-date="Wed, 02 Dec 2020 06:18:44 GMT"
Content-ID: <A29B86F499B694438A28E034843A4087@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzdGRsaWIu
aD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzY2hlZC5oPgojaW5jbHVkZSA8c3lzL3R5
cGVzLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8ZmNudGwuaD4KCnZvaWQgc2x1
cnAoY29uc3QgY2hhciAqZm4pCnsKCWNoYXIgYnVmWzgxOTJdOwoJc3NpemVfdCByOwoJaW50IGZk
OwoKCXByaW50ZigiJXMgW3BpZDogJWRdXG4iLCBmbiwgZ2V0cGlkKCkpOyBmZmx1c2goc3Rkb3V0
KTsKCglmZCA9IG9wZW4oZm4sIE9fUkRPTkxZKTsKCWlmIChmZCA8IDApIHsgcGVycm9yKCJvcGVu
Iik7IGV4aXQoMSk7IH0KCglyID0gcmVhZChmZCwgYnVmLCBzaXplb2YoYnVmKS0xKTsKCWlmIChy
IDwgMCkgeyBwZXJyb3IoInJlYWQiKTsgZXhpdCgxKTsgfQoJYnVmW3JdID0gMDsKCXB1dHMoYnVm
KTsgZmZsdXNoKHN0ZG91dCk7CgoJaWYgKGNsb3NlKGZkKSA8IDApIHsgcGVycm9yKCJjbG9zZSIp
OyBleGl0KDEpOyB9Cn0KCnZvaWQgbmV3bmV0KGNvbnN0IGNoYXIgKm5zKQp7CglpbnQgZmQ7Cglm
ZCA9IG9wZW4obnMsIE9fUkRPTkxZKTsKCWlmIChmZCA8IDApIHsgcGVycm9yKCJvcGVuIik7IGV4
aXQoMSk7IH0KCWlmIChzZXRucyhmZCwgQ0xPTkVfTkVXTkVUKSA8IDApIHsgcGVycm9yKCJzZXRu
cyIpOyBleGl0KDEpOyB9CglpZiAoY2xvc2UoZmQpIDwgMCkgeyBwZXJyb3IoImNsb3NlIik7IGV4
aXQoMSk7IH0KfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7Cgljb25zdCBjaGFy
ICpucyA9ICIvcnVuL25ldG5zL3Rlc3QiOwoJY29uc3QgY2hhciAqZm4gPSAiL3Byb2MvbmV0L3Nj
dHAvc25tcCI7CglpbnQgZCA9IDE7CgoJLy8gT3B0aW9uYWwgYXJnczogL3J1bi9uZXRucy8uLi4g
L3Byb2MvbmV0Ly4uLiBuCglpZiAoYXJnYyA+PSAyKSBucyA9IGFyZ3ZbMV07CglpZiAoYXJnYyA+
PSAzKSBmbiA9IGFyZ3ZbMl07CglpZiAoYXJnYyA+PSA0ICYmIGFyZ3ZbM11bMF0gPT0gJ24nKSBk
ID0gMDsKCglpZiAoZCkgc2x1cnAoZm4pOwoJcHJpbnRmKCJzZXRucyglcykgLi4uXG4iLCBucyk7
IGZmbHVzaChzdGRvdXQpOwoJbmV3bmV0KG5zKTsKCXNsdXJwKGZuKTsKfQo=

--_003_6de04554b27e9573e0a65170916d6acf11285dbacamelnokiacom_
Content-Type: application/x-shellscript; name="iperf-netns"
Content-Description: iperf-netns
Content-Disposition: attachment; filename="iperf-netns"; size=303;
	creation-date="Wed, 02 Dec 2020 06:18:44 GMT";
	modification-date="Wed, 02 Dec 2020 06:18:44 GMT"
Content-ID: <D103993D39A1574886E699A5C21CB8BF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKc2V0IC14IC1lCm1vZHByb2JlIHNjdHAKdGVzdCAtZSAvcnVuL25ldG5zL3Rl
c3QgfHwgaXAgbmV0bnMgYWRkIHRlc3QKaXAgbmV0bnMgZXhlYyB0ZXN0IGlwIGxpbmsgc2V0IGxv
IHVwCmlwIG5ldG5zIGV4ZWMgdGVzdCBpcGVyZjMgLXMgLTEgJgpzbGVlcCAwLjUKaXAgbmV0bnMg
ZXhlYyB0ZXN0IGlwZXJmMyAtYyAxMjcuMC4wLjEgLS1zY3RwIC0tYml0cmF0ZSA1ME0gLS10aW1l
IDQKY2F0IC9wcm9jL25ldC9zY3RwL3NubXAKaXAgbmV0bnMgZXhlYyB0ZXN0IGNhdCAvcHJvYy9u
ZXQvc2N0cC9zbm1wCndhaXQK

--_003_6de04554b27e9573e0a65170916d6acf11285dbacamelnokiacom_--
