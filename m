Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEFC378F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhEJNeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349660AbhEJMtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 08:49:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0717.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::717])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D2C06138A;
        Mon, 10 May 2021 05:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu5SHxbLxa84n4TixNHHzjuB5jJsap86O79yeS+cdXxZdRxUOuqBhAApYBIDG76N/86wMEVKACov2ibN++9/qOv+osnlsTJNC9nRIWTuaS4ol9FRKPoIIruNjA7fs+yqpcLy5jY2zjX6Iye9IqzFITh64HWwU8rJRYa2R20NMRl0c2thTgWuiqRlB/7os/drlSonXWUwvpdobcm2dW8msXMdl9Te3fzQPFPJSyBTzLyfSlJgCbyCYTKmbU/0kiOD0lBdU10pHa0Qqf4jepv7st0XiYJrC2DKMR2JVJ4kXITk2ofh6hHQj+hbJny0dRcHZr3DfWVZ9nWk0E4TXc3aGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0qS4DAupAVb541zDuzNMeXa6I+ZGvb+fQn9PDYZ9Vo=;
 b=LGefpZKOEHF+MpUhnFH8tI3Crt+AnfuNJomGgj6YGFv6kQwuifLMUdDD1FSNOCeSEwaGVmNTK+PI+dzRZflm3Atk3yvgXOm58mH/LaHtDHOtZbFlRasY4x1gixcC4k3J2w/DcV93sCHxfBd5qcCBOgmi1mwrHNFWyWitUzfZvc0PLbVr0kvgloB/GqvLfQfWDCP3o0mDWiKVbz5+GzvjvpGaUXaL3PLHWr+n2o7u9uktLEet332JAKS25euaR4SGDjyVqrjPuvOwVaKxSSmjCt5eUugDL41dqRO+uKiOeNYoxtFCKhWblnd+a4baGsp9bUOg5Oi2tpRK6WZ79+Irkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0qS4DAupAVb541zDuzNMeXa6I+ZGvb+fQn9PDYZ9Vo=;
 b=Jmx4dkOamU422Un0bMdeQVEE9KlmDTkzi4zOm3/q7nf6cvHSgiwYQ5xHvulkzBDjWvCBTTunmOX9WPCF4Wg4ktoDi92/aRnNXs5mhSBp339hdYRVUH4anqbIN5fZCXEnLDRYiZZ4tI8P3fiZo7VD1vdVHiUS0a9EiB7ioQyhbGo=
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0702MB3707.eurprd07.prod.outlook.com (2603:10a6:7:83::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.23; Mon, 10 May 2021 12:43:58 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::85ed:ce03:c8de:9abf]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::85ed:ce03:c8de:9abf%7]) with mapi id 15.20.4129.024; Mon, 10 May 2021
 12:43:58 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "rdna@fb.com" <rdna@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: cat /proc/sys/kernel/tainted => page allocation failure: order:6
Thread-Topic: cat /proc/sys/kernel/tainted => page allocation failure: order:6
Thread-Index: AQHXRY1ZG2ESqLEgZ0SzsF4bQW36rKrcomIAgAAGywA=
Date:   Mon, 10 May 2021 12:43:58 +0000
Message-ID: <1656f09a4dc88517a7cedb5c66c423f34b65266a.camel@nokia.com>
References: <04735c17a20f6edd3c97374323ba2dc15e7fd624.camel@nokia.com>
         <YJkk2qnNwj60wzSo@casper.infradead.org>
In-Reply-To: <YJkk2qnNwj60wzSo@casper.infradead.org>
Accept-Language: en-US, en-150, fi-FI
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nokia.com;
x-originating-ip: [131.228.2.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be41753d-beab-4d02-12f3-08d913b147f9
x-ms-traffictypediagnostic: HE1PR0702MB3707:
x-microsoft-antispam-prvs: <HE1PR0702MB370771FA884B3AF3C5D76960B4549@HE1PR0702MB3707.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOghiy/H8o1ApwpZZcAaq7yaBiWTpjpYK0Vc4487Sq0Mvi0ZeYSxPEbBHvQDsmzZjLjZKpiZGSnSIxGPpHodIoLAOMxZ+2VkZ5XFMehKDs1zV3ynzLsoegeQ0To3UGAKGI9JrVxxIVtp4+p4dyzLhu6F6vUc2Bc7XaZ1ioKNdwmFuG12g5Nm4YHVCm2DpVdGXEbfIVBUhWSxhsI4bT01wbowMVZm7Q4nWjmoDKeGhq+xLAcMbnxMXPM8wgLAOh2hjYPXKtxZoTyjIXZEUxz/FeM5nsrbcCfPIKh/9u+3/7Gvs9VnMk+HiOBtHZy2a6KuDZGeAFjq7q2H16lFp9ryu7iB/4RfWfnH/vUewmO3wZw8uRLKwQsEtWyYonGjd9BBEIJSgSt6L/GWaf899UNI6COyVmmWMqjMDBpm9T5D0Eplm3YcOzlfAVnUZSYToZ3yjFfocAXRGWUMz15NxtLCd6Zn/GYSCRZp7crxMjbD1qSUIdV8Gj3pub2Sa0tWUYauF8uknPPI6RSgbJDfoULUKx+HIg0t9EcOO+0NUK98uO8+vubs5UbX4R4DI84H4XKYwEz+6Dlux4F32/ilRwteHlWdNkk5efZu1cn7NridtRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(64756008)(2616005)(66556008)(66946007)(66476007)(2906002)(91956017)(76116006)(66446008)(8936002)(86362001)(186003)(6916009)(316002)(478600001)(83380400001)(8676002)(6486002)(4326008)(5660300002)(36756003)(26005)(6506007)(54906003)(6512007)(38100700002)(122000001)(4744005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L0UvZURucytpYnRrNWRvM1NNeEErK3pCdUd6WVY3ZWl5cVcxdG1mYXhVeHlv?=
 =?utf-8?B?YVBhc3Z4UVJWQkhIWTMrQ3B4ZUNSSkRvVytyL05YZ0ZVZHhYZ0RjU0g1WUM2?=
 =?utf-8?B?NGF0UGl6UytsMkovWTN4aDVRZUtHUG0rd1BnWDk2ZkxjTmszZi80YjBldlR0?=
 =?utf-8?B?d20rWW91MTQ0a1RMdnM2Zzc3ZHJNOE5jUzdVUW4zbTFYVXA2Wlg5QU93TGdQ?=
 =?utf-8?B?MTdUaWo4NG5qYVZNN04rNWdGUGdQRVpOTW5tWjIwb1JwQzVacTdmcDA1YWYr?=
 =?utf-8?B?MVNaZFJvTTVReFRaUVpmT3RJZy8yRnN5dVhzbXNPb3A0MnNuUm9sVFY1YWE3?=
 =?utf-8?B?WkZtSHVjVDhwVlBHanM0MzdJVG5UQTg5V2lUVlR0VjlPOE9Cckgzc0ovTTVG?=
 =?utf-8?B?YzYzNE1Kc0JtclNSQ21hS1pLdGhrMi9QV2p4TUtGbFVCdXVLdldaYk9KV2pw?=
 =?utf-8?B?RzVONmFnczNla1J2NlFaZ2tyM0dseDdnRkxBelUySWtsYnR4NHF4eElUckV4?=
 =?utf-8?B?SkRFbitwczNNb1RMNEpidE5lK2w2cVE1d3h5SWZyTVpGc25EWWErQlNka2x6?=
 =?utf-8?B?NENmRFdIdzUzVDlQalRyN2VFUXBMcXdmQkFISDVkRFplN1lFUjRnRkZxQ0g5?=
 =?utf-8?B?SE84WHFaSzJ4b2hQV0RSSE5BRjVUYUVwYUpRSmVPSDBTY2gwVzdtcnZmZWJY?=
 =?utf-8?B?bzhwZEQ5U3o0bElUZHhtZndQYWYyUnJaczFNenVpYTZtU0dta2hWRDZSbmpK?=
 =?utf-8?B?TzBsMngwbHZEaTJ6VVBJaEpkZW1lWUErTkRBZGdhcUV6RnJKaDc1cUk4VWxL?=
 =?utf-8?B?UlQyZHBoelNkTFlUYU9EbitJNUVxdWhlcko3R2pDSUdCd0NacTQ2ZHozZXFS?=
 =?utf-8?B?dExobFh6L21ybHpqR1Bzc1ZSWnovZWFaTVlZaFpZcDUvTGt5ekhnRVRiUDVz?=
 =?utf-8?B?OVYya2pJLytMWVdHMGJJS1NZc2NtUnM4VERKMldqVTlOYk92bnNkb2FWQmtr?=
 =?utf-8?B?V1Q4N2Y4Z2ZQK0pUQ0VQQ0pJZ3Nnc1l5ZjRSL0lxNE5ZQytiUStjR2FwSU95?=
 =?utf-8?B?cG9YR3VRMWdyRmZETGpPRHQ1cUluYjNKV2M1clkvUnBXc3ZXdlFZVWp0VXpI?=
 =?utf-8?B?RjlDZEEvOGFMdnUwelB5WnkxVE5qR1NVeDI3S1FaaUtvb3FQNENFZ1haSzJU?=
 =?utf-8?B?ZCtJNndjSGpNdlpUaHExNzdVa29TS0pjend2V1M5MWNNaGJoN2p0bmtvMnp5?=
 =?utf-8?B?SmtHUWlhWUluQ1ZHaUhCRGoxMlBYUFVwSEdoVm5sVU4xVFArSUJHQTB1ZitW?=
 =?utf-8?B?bXV5dTlwVmpDcFQ0SVB3cjVRcHJIZjJhanFJNXZMMkNWeUVSWWFUNmJnd1Vj?=
 =?utf-8?B?VGxWN0FJZ2J2MnZQWlV6bVI3bFBoY1ZFcEFDQ1NMeUU0T2pIOWlrVUtqd3RU?=
 =?utf-8?B?UjFwMy9lblJxNDFJZ2pCV0ZDNkdYL21rb3NyUGNXYXN1OXRsUUFma013NU1F?=
 =?utf-8?B?dWEzNXlSeVVDSEt1cXhqVnhON3ZUVzdCWkgveEhDd09kUW9HSkVSZFIwQ0N3?=
 =?utf-8?B?MXVnUXkyaG4zcmNWeDN6N2NBNDRpSXh6TTFKUmVmZHArTUtiTUg3KzA2R3hL?=
 =?utf-8?B?T1ZieklVbDM4Y3FZZkV5S2Z2N1VvQ0Q0MGovdXdQTDZnZm11ZldYWStIdXZl?=
 =?utf-8?B?eGJ2Mm8zZEgxa1dTaWhUMEczVndTbjlaa3AzNzZNQ3pGdTF6MHRTekxWMjJW?=
 =?utf-8?Q?A0EOc7+erbejDLNsCwBvR6yJroma/2tnEHh534m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1887D7F808AF62468AF9E9B8F7C2C869@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be41753d-beab-4d02-12f3-08d913b147f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 12:43:58.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjyxsH5dhBtRBJUCg6x1qf2tUQuLPVhu9GBUK42wSKiW1eEuCz01dDrqsqoiXnLGGk1tkGbLszVvEs5BnsRgnI54J+WWDf8Vm7P0uMKZIxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3707
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTEwIGF0IDEzOjE5ICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBNYXkgMTAsIDIwMjEgYXQgMTE6MTI6MjFBTSArMDAwMCwgUmFudGFsYSwgVG9t
bWkgVC4gKE5va2lhIC0NCj4gRkkvRXNwb28pIHdyb3RlOg0KPiA+IFdoeSBpcyBvcmRlciA2IGFs
bG9jYXRpb24gcmVxdWlyZWQgZm9yICJjYXQgL3Byb2Mvc3lzL2tlcm5lbC90YWludGVkIg0KPiA+
IC4uLj8NCj4gPiBJJ20gc2VlaW5nIChvY2Nhc2lvbmFsKSBmYWlsdXJlcyBpbiBvbmUgVk0gKHdp
dGggNjVkIHVwdGltZSk6DQo+ID4gDQo+ID4gWzU2NzQ5ODkuNjM0NTYxXSBjYXQ6IHBhZ2UgYWxs
b2NhdGlvbiBmYWlsdXJlOiBvcmRlcjo2LA0KPiA+IG1vZGU6MHg0MGRjMChHRlBfS0VSTkVMfF9f
R0ZQX0NPTVB8X19HRlBfWkVSTyksDQo+ID4gbm9kZW1hc2s9KG51bGwpLGNwdXNldD11c2VyLnNs
aWNlLG1lbXNfYWxsb3dlZD0wDQo+ID4gWzU2NzQ5ODkuNjQ1NDMyXSBDUFU6IDAgUElEOiAyNzE3
NTI0IENvbW06IGNhdCBOb3QgdGFpbnRlZCA1LjEwLjE5LQ0KPiA+IDIwMC5mYzMzLng4Nl82NCAj
MQ0KPiANCj4gVGhlIHVuZGVybHlpbmcgcHJvYmxlbSBpcyB0aGF0ICdjYXQnIGlzIGFza2luZyB0
byBkbyBhIDEyOGtCIHJlYWQgKCEpDQo+IHNvIHdlIGFsbG9jYXRlIDI1NmtCICghKSBvZiBjb250
aWd1b3VzICghKSBtZW1vcnkuwqAgVGhpcyBpcyBhbHJlYWR5DQo+IG1vc3RseSBmaXhlZCB1cHN0
cmVhbS7CoCBQbGVhc2UgdXBncmFkZSB5b3VyIGtlcm5lbC4NCg0KQWhoLCB0aGFua3MhDQpJbmRl
ZWQgSSBtaXNzZWQgInByb2M6IHVzZSBrdnphbGxvYyBmb3Igb3VyIGtlcm5lbCBidWZmZXIiDQot
VG9tbWkNCg0K
