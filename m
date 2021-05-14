Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81393380339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 07:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhENFWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 01:22:32 -0400
Received: from mail-eopbgr1400073.outbound.protection.outlook.com ([40.107.140.73]:1104
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229477AbhENFWa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 01:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUzVF1AclRdCxj/3Xcr696MjfWqWeeJGZzBJ4hmQ5lugx4eTZl0VRsIDbEH9ZxyAHutR5NesWTAa4kQEP70Zo/fxAMvbSNdfpBtjody1D8IPLPqS4/SyT8tGzEl0iDCtwa5JP4aeZK7EDaIpB/9KBObM0L/U2NlGocxtH5og2CmiP2yiUkCb7Ti5pQPGJLTmYfinRBDTLPeKrNhIKcmmMBcEUGmzGch3bgQ8LqpVYddhtNmOXUTuUlj6T7JoAE5kvX2aWYlFxrc1HZWNhBfE8y9g9xVJxRsIaf6PbJr+cVsV4GKqcDcV6Jao7Bz6uVpXpb0FFGyPVzFKIkoP5AlHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIUXo7F0UR4crKLp7fc1PnZnwDBcpRctuB/f8UQNNM4=;
 b=agvXc4R7xBJPp9i2CNd8PAneOqDiz4pE6BRi7IAjoGHFNXmGs6E4UB2ZJP2nU/XXlS0LOXYMujhM7udpWtK9Sh5SIWJVeFhYbqxAnMaegBTfkYkZzgD1RbHyUNQMBI53KHob5aZwhZlV7wa+vX0MxQio+2YZf7p6rbDnnKZ4s/7wiQx328at8WZHxBOiawURMHFQVEaEcDjnsPjJVwXPKdhxlzigot2HY922+gxlmWZMxMMlb+X/YibHrUGwQSX2QQ23tax0z0LLc/YFYGd5L6mYyBcb+6YDivQdBWz4JQMvI7J5E6tWZzkMUbMNB/xhG0JW2L8YsCoAvCmR2EHqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIUXo7F0UR4crKLp7fc1PnZnwDBcpRctuB/f8UQNNM4=;
 b=QStL1UIWFjWA5kEVmwQWVgNBdSFl2jJBJybdAaweT+ThSbXyUgr3O26gSvy0zjrqlXeTLTyw/DvKzT4H4tR5k9H9efDdYLRZ+Rmp6XIRYGqZfQR1WXhyGZ1x0BmYVzQaZal6tkUWIdmPUPdoO0oaG1qw4LdBoXm/KdeaiACeXv4=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB7089.jpnprd01.prod.outlook.com (2603:1096:400:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 05:21:18 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Fri, 14 May 2021
 05:21:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>
Subject: Re: [PATCH] mm/memory-failure: make sure wait for page writeback in
 memory_failure
Thread-Topic: [PATCH] mm/memory-failure: make sure wait for page writeback in
 memory_failure
Thread-Index: AQHXRjK1j3a2Ru6gikyV8HnazUFHgqrd97wAgAANcoCABHBagA==
Date:   Fri, 14 May 2021 05:21:17 +0000
Message-ID: <20210514052117.GA983377@hori.linux.bs1.fc.nec.co.jp>
References: <20210511070329.2002597-1-yangerkun@huawei.com>
 <20210511084600.GG24154@quack2.suse.cz>
 <YJpPj3dGxk4TFL4b@localhost.localdomain>
In-Reply-To: <YJpPj3dGxk4TFL4b@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bc2abba-b833-4631-eb29-08d916981a31
x-ms-traffictypediagnostic: TYCPR01MB7089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB70894E9B373A10A1BC256F91E7509@TYCPR01MB7089.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EftUT0qZcByj/mAt0dJu3z5fYqsbwSVZbdsJ9LZFaIiRMLwliFpDPAuzwaDXJyCfl6NRb46RhXiGXNYceVIwEZUisdyGiufnYDoQp0JB8AWhaPAijGGToOZYdDBGCdUfNXLhBfaPz82w6uQvkIQEJ0NcEAgiU9UiQI93vc3rwQkfd1jxPwx5MbKiuo2J3uaKfe4Kvt2f/bBl1PWqJqybihAqgyJrhjQZG81W1YjAKN8SrkEX9TBIl/Yliml/xbgI+7C0LNSvH1jTte8Kcck8zGXa4GDB5hOwupAL4lh9tgpAwgMmOadkJN8UspnFVi/OCj/EHv/RZU39wj1PxgktAo3/VHnGMrororhUO6XWrDpcgwKr1abAP4b9TOFO/VFpZXx7S57sa3D95D7e8v8AwL/1Rka7k+B1irvOL61d+cU++yt28Y0Ug7FcRfNnOYbH5eKoXD+ZIadrj8z+t4zlVTr4BIAoyTVUaRBB7clFCwaSZLD631LEO5pxrTK9Yzh3mIqOjqphs0X93bSehXze2noS58MEvJJ5JRYhl9jFYjsEGW0CQk5U0bV/sgcq/nP5IBdEUfIzXyGwvQOqsRhLtrq7lyLLy/MnDwZ8z7bY2YA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(1076003)(316002)(54906003)(5660300002)(66946007)(76116006)(8676002)(38100700002)(83380400001)(6916009)(85182001)(4326008)(66476007)(71200400001)(26005)(55236004)(64756008)(86362001)(66556008)(7416002)(6506007)(33656002)(6512007)(6486002)(66446008)(186003)(9686003)(2906002)(478600001)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y3gvekJxenVCMFdqN2ZTZ0FsZU9Oa2Y2K3ROVVREZFZ1ekNiM2NkWWtCdmdT?=
 =?utf-8?B?VTEzZFVNTU5GTGprRHAzUXhmQjZxaThLeCsxanMyVU9KTVhvVGYwV1V3eHN5?=
 =?utf-8?B?N0hVenJzbURMVUVIb2k0NXVDK0R5bzJ3b1dpdmYxYWxBOVRJakI5Q0xKMlgv?=
 =?utf-8?B?MlY0bER6YnZYc3NGclBydmpPNTd5K3RqRXM4UVVBaFpGRzNJQjRhQ2FmVU85?=
 =?utf-8?B?M3lldSt2S1g1Wm8ya09rcDQ5b3VXcnRNSkpTaEhHMVhLQzFaQjJmcWdOSjVM?=
 =?utf-8?B?WjVXTjkyOFRiTVMrTWg2amtsdkZoYjFQaW0rQTVLQkczYnNQbHVtaE1hRkFw?=
 =?utf-8?B?RGhxaGkyMFh4cm13QnRRMXhFZHUwWG5wSTdidjVSdXdnY2dGOEpSU0JSTnZv?=
 =?utf-8?B?T0IyY05jSU85Sm5UQWkvNjNkaUwzUUlUT3pJaTVZaXM4ellvdHNibUhBR2x2?=
 =?utf-8?B?NTlDYnNheGY4UXU0bXd6WUZ6K2tFUUJkSFRnZkNvckFlRjg0b2ZRZnErSkND?=
 =?utf-8?B?WEtpY3pTWGNzY0VnMWdxQWh3OVNORkpzVHpoeDZTaUptWkFVRVNMQWN5QWRa?=
 =?utf-8?B?Slp6elVDaTNuUmpoUTV1TVl5cmNaN1dVUkt1UFVvdmJCdllOZFpQbStDN3hn?=
 =?utf-8?B?ekl4dDNYUmJzR0NjeHZlakdsZ2ZKemowTkcydVFGZmFYb1plYkpZTnVsZkY4?=
 =?utf-8?B?TnpoaVYzOGYwU2dTMmpxWDlJMVJ0Mnh5MzBmaHQ0NUozMFM0aVJpa0Erd3Fs?=
 =?utf-8?B?ZmhhOVpGTnorb1BmZTl5WTZRMmZhb3RscWpXUElJeUdCeHRlNXhDS0JVOHkx?=
 =?utf-8?B?c1FXQ013NWVBUWdLMDduRHErOXRpQXo0bnIzbm81U1VjaHYwVnNZRUFUakRs?=
 =?utf-8?B?MWM3WlE1R1l2TktDLzNrQXNDMUlCYUhyUm1NMnp3dnNZeG9pdzBsTHg0Zkxi?=
 =?utf-8?B?ZUNsZjlKVkVrWExiUWg0T2w2bSs1UllNdjc1c3Ezdk4rZWNBa25XMFFLakM3?=
 =?utf-8?B?M3NKMTdlQWluVnlvUi9OQnBNT1pLZWQ5a21MbDRMeWZpUTkxRzVZYVZoenFp?=
 =?utf-8?B?V1FJVm45d01TRnhGK1grcWNiN1B4S1RZandVZE1mUUJ0N1BjWVB5M3RNSk9h?=
 =?utf-8?B?aXd1SEMyU0NYMkNJbE44NHE4elNtdGMzWWlVeURIZEVzcWJ3R2JjMnJSQ3ov?=
 =?utf-8?B?ejhMMmFMSm1xOXJzdnA2RXdJcDFWZ1BCQXlZRi9iU3BiZW5JWXMvbCtyRHVJ?=
 =?utf-8?B?NnBiYXJWejd4TzQ3cU50VE42M0V5ZElMK3VZNy9jeXVISEdBcFM5SHBRSW5W?=
 =?utf-8?B?VEJtOERSZWJQMjVVQjh0WElIMFNQUVNvaTdjZ0JmblNwb2tLOXJoQmlZODdp?=
 =?utf-8?B?RXJNTnJvVTN4amxaVGdtbTVYcDdwbm1BSmcrazRHMThmUW1adTNQaVhkVEdC?=
 =?utf-8?B?SVJxbGxmUTBCWG1MTEhvWllBQmp6KzEwUDAwSm5ERDU0V0R4YlI5azV4cXRE?=
 =?utf-8?B?RUp6dC9qbFFTUWlDSXdjU3lFMW1KMXRMN1JqaThIYzQyd0pPdjVla0NZOWVa?=
 =?utf-8?B?bDAxK1dQVVFtWFd1ZWJOQ3RHZW95cXNRK1ZGemhWdFJobEhDSU1BSXVoNnBP?=
 =?utf-8?B?ZUk3Q3B3RlpVTldxZXRtdlYzLzBsa2dtQmZidy93RjhvQ24vcUQvaGJhUGF4?=
 =?utf-8?B?TUtHYUlocCtWVEZ0dTFzeWVPQmplN3FYbys1aTZrOUx4Q3I1QlA5ZTEybHpE?=
 =?utf-8?B?QjBCY1NLUnA5emcyQmdwMnR3M0F5Y2Q4MDQvQjVEcDRBeEhvS1ZZQUtVZnBB?=
 =?utf-8?B?Z05hN0F1QzlubHRYem1qQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <424D2EC79C6C004AB77D60D4D814066A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc2abba-b833-4631-eb29-08d916981a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 05:21:17.8675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8djcEAnfDCOMm+V3dzYx+sN3WEFZgeaLb+d3nnBg1dXeIiQKdFozZ7cjbe4+B/NqscjGxKdRHHzPs2FBFiamhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7089
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgMTE6MzQ6MDdBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDEwOjQ2OjAwQU0gKzAyMDAsIEphbiBL
YXJhIHdyb3RlOg0KPiA+IFdlIGRlZmluaXRlbHkgbmVlZCB0byB3YWl0IGZvciB3cml0ZWJhY2sg
b2YgdGhlc2UgcGFnZXMgYW5kIHRoZSBjaGFuZ2UgeW91DQo+ID4gc3VnZ2VzdCBtYWtlcyBzZW5z
ZSB0byBtZS4gSSdtIGp1c3Qgbm90IHN1cmUgd2hldGhlciB0aGUgb25seSBwcm9ibGVtIHdpdGgN
Cj4gPiB0aGVzZSAicGFnZXMgaW4gdGhlIHByb2Nlc3Mgb2YgYmVpbmcgbXVubG9ja2VkKCkiIGNh
bm5vdCBjb25mdXNlIHRoZSBzdGF0ZQ0KPiA+IG1hY2hpbmVyeSBpbiBtZW1vcnlfZmFpbHVyZSgp
IGFsc28gaW4gc29tZSBvdGhlciB3YXkuIEFsc28gSSdtIG5vdCBzdXJlIGlmDQo+ID4gYXJlIHJl
YWxseSBhbGxvd2VkIHRvIGNhbGwgd2FpdF9vbl9wYWdlX3dyaXRlYmFjaygpIG9uIGp1c3QgYW55
IHBhZ2UgdGhhdA0KPiA+IGhpdHMgbWVtb3J5X2ZhaWx1cmUoKSAtIHRoZXJlIGNhbiBiZSBzbGFi
IHBhZ2VzLCBhbm9uIHBhZ2VzLCBjb21wbGV0ZWx5DQo+ID4gdW5rbm93biBwYWdlcyBnaXZlbiBv
dXQgYnkgcGFnZSBhbGxvY2F0b3IgdG8gZGV2aWNlIGRyaXZlcnMgZXRjLiBUaGF0IG5lZWRzDQo+
ID4gc29tZW9uZSBtb3JlIGZhbWlsaWFyIHdpdGggdGhlc2UgTU0gZGV0YWlscyB0aGFuIG1lLg0K
DQpBcyBsb25nIGFzIEkgY2hlY2tlZCB0aHJvdWdoIGFsbCBjYWxsIHNpdGVzIG9mIFBHX3dyaXRl
YmFjaydzIHNldHRlciBBUElzDQooc2V0X3BhZ2Vfd3JpdGViYWNrKCkgYW5kIGl0cyB2YXJpYW50
KSwgUEdfd3JpdGViYWNrIGlzIHNldCBvbmx5IGR1cmluZw0KSU8gb3BlcmF0aW9uLCBhbmQgdGhh
dCdzIGFzIHN0YXRlZCBpbiBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2xvY2tpbmcucnN0Lg0K
U28gaWYgd2UgY2FuIGFzc3VtZSB0aGF0IHRoaXMgZmxhZyBpcyBzZXQgb25seSBmb3IgYSBzaG9y
dCB0aW1lLCBjYWxsaW5nDQp3YWl0X29uX3BhZ2Vfd3JpdGViYWNrKCkgZXZlbiBmb3Igbm9uLUxS
VSBwYWdlcyBzZWVtcyBPSyB0byBtZS4NCg0KPiANCj4gSSBhbSBub3QgcmVhbGx5IGludG8gbW0v
d3JpdGViYWNrIHN0dWZmLCBidXQ6DQo+IA0KPiBzaGFrZV9wYWdlKCkgYSBmZXcgbGluZXMgYmVm
b3JlIHRyaWVzIHRvIGlkZW50aWZpeSB0aGUgcGFnZSwgYW5kDQo+IG1ha2UgdGhvc2Ugc2l0dGlu
ZyBpbiBscnV2ZWMgcmVhbCBQYWdlTFJVLCBhbmQgdGhlbiB3ZSB0YWtlIHBhZ2UncyBsb2NrLg0K
PiANCj4gSSB0aG91Z2h0IHRoYXQgc3VjaCBwYWdlcyAocGFnZXMgb24gd3JpdGViYWNrKSBhcmUg
c3RvcmVkIGluIHRoZSBmaWxlDQo+IExSVSwgYW5kIG1heWJlIHRoZSBjb2RlIHdhcyB3cml0dGVu
IHdpdGggdGhhdCBpbiBtaW5kPyBBbmQgZ2l2ZW4gdGhhdA0KPiB3ZSBhcmUgdW5kZXIgdGhlIFBh
Z2VMb2NrLCBzdWNoIHN0YXRlIGNvdWxkIG5vdCBoYXZlIGNoYW5nZWQuDQo+IA0KPiBCdXQgaWYg
c3VjaCBwYWdlcyBhcmUgYWxsb3dlZCB0byBub3QgYmUgaW4gdGhlIExSVSAobWF5YmUgdGhleSBh
cmUgdGFrZW4NCj4gb2ZmIGJlZm9yZSBpbml0aWF0aW5nIHRoZSB3cml0ZWJhY2s/KSwgSSBndWVz
cyB0aGUgY2hhbmdlIGlzIGNvcnJlY3QuDQo+IENoZWNraW5nIHdhaXRfb25fcGFnZV93cml0ZWJh
Y2soKSwgaXQgc2VlbXMgaXQgZmlyc3QgY2hlY2tzIGZvcg0KPiBXcml0ZWJhY2sgYml0LCBhbmQg
c2luY2UgdGhhdCBiaXQgaXMgbm90ICJzaGFyZWQiIGFuZCBvbmx5IGJlaW5nIHNldA0KPiBpbiBt
bS93cml0ZWJhY2sgY29kZSwgaXQgc2hvdWxkIGJlIGZpbmUgdG8gY2FsbCB0aGF0Lg0KPiANCj4g
QnV0IGFsdGVybmF0aXZlbHksIHdlIGNvdWxkIGFsc28gbW9kaWZ5IHRoZSBjaGVjayBhbmQgZ28g
d2l0aDoNCj4gDQo+IGlmICghUGFnZVRyYW5zVGFpbChwKSAmJiAhUGFnZUxSVShwKSAmJiAhUGFn
ZVdyaXRlQmFjayhwKSkNCj4gCQlnb3RvIGlkZW50aWZ5X3BhZ2Vfc3RhdGU7DQo+IA0KPiBhbmQg
c3RhdGluZyB3aHkgYSBwYWdlIHVuZGVyIHdyaXRlYmFjayBtaWdodCBub3QgYmUgaW4gdGhlIExS
VSwgYXMgSQ0KPiB0aGluayB0aGUgY29kZSBhc3N1bWVzLg0KPiANCj4gQUZBVUksIG1tL3dyaXRl
YmFjayBsb2NrcyB0aGUgcGFnZSBiZWZvcmUgc2V0dGluZyB0aGUgYml0LCBhbmQgc2luY2Ugd2UN
Cj4gaG9sZCB0aGUgbG9jaywgd2UgY291bGQgbm90IHJhY2UgaGVyZS4NCg0KWWVzLCB0aGlzIGFw
cHJvYWNoIHNlZW1zIG1vcmUgcG9zc2libGUgdG8gbWUsIGJlY2F1c2Ugb2YgbGVzcyBhc3N1bXB0
aW9uDQpvbiBQR193cml0ZWJhY2sgdXNlcnMuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
