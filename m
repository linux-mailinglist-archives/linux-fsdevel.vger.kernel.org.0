Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975C11F9194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgFOIdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 04:33:31 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:46243 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgFOIda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:33:30 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 5EA363A3F3D;
        Mon, 15 Jun 2020 17:33:27 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 49ll3C2NXwzRjbV;
        Mon, 15 Jun 2020 17:33:27 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 49ll3C24R0zRkDl;
        Mon, 15 Jun 2020 17:33:27 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 49ll3C25pwzRjgB;
        Mon, 15 Jun 2020 17:33:27 +0900 (JST)
Received: from APC01-PU1-obe.outbound.protection.outlook.com (unknown [104.47.126.52])
        by mf03.melco.co.jp (Postfix) with ESMTP id 49ll3C0rCvzRjnV;
        Mon, 15 Jun 2020 17:33:27 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZzz5mBytjdvkbYqkvL4J5cc2IFpm2cgKzvlDfWb7XV5d7A0Qnn6iayrOoY0D9HVqT5ja765KVSWvK+YTK+Su1+hCIAO4TL18OnTVknOkcnMbcpuPtRJsXITFCfEGFsOoGg6rMtm59CuGIGtEkKSb4iq2q2qaCiz/GjpAEqGQVPYgrZJODiyiKvr4OeZ7yUyWkq7mlGx4/6PK5TMfAow9JQ/lN+08haDy9YQbDsZXogKzRnid4uvv+JiFRSiLnnpOG5zOAy7tNbkpBaxtsUv+1HRQf0r+MmpBnWf8D8Z+f1ZQGddtmKTHZ8AGffb9VIlCtuC78zoMs06rb2RSAR+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHWiASz8bYcV/M5FHYJ+bTH52Vyn5277leLoh+60InA=;
 b=aEXqhhucfcrZJxCuB/qARa/6C2PmAnaS8z3z2u0QUJSj9CDxQT6tOZ6GapDDPpKVtJnQnV4SGL3j8GP5IPQx/8VS68HGC/6nJooi+XpoP/IwTYGsbGHa6rvauL6xRnzfUtnWqRTfcT7Hd6AOJmOmwJbZMich6aXVog3hxBKTlfsuiHCpTQaOjrLcQeiyAWHdijTBeHiifgWAyEGhUqZT5GgQNw5cPrFSmAWklpLusVZOjGWsYdnAltOr852ZJeD2gYnhBPTob17MvGLGlN4i0yAXDzN+I9CaZY6KoQQUGpoXgjt4NubybobHDRTuFbZ25NftQMDK2mHXjIO+nQ0JUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHWiASz8bYcV/M5FHYJ+bTH52Vyn5277leLoh+60InA=;
 b=fX7zwI0wVVbI4YCcvJvV7C4BvS7qGRNb1TYlaAnvhsyfZJQu1sOcbBrGYk/Ew6BCsXzwmPb4OlZOOZMm9uojBgJO/may44Zg+dWsnEyUPLlYkcnydM4m5YgpzSNbg3NWH2GTNYsCZhdr/JRw11FvMT2mVyF5Qp+tgPbozoohvJs=
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com (2603:1096:404:6b::11)
 by TY2PR01MB4185.jpnprd01.prod.outlook.com (2603:1096:404:d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 08:33:26 +0000
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51e1:c5ae:8ef8:4b76]) by TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51e1:c5ae:8ef8:4b76%7]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 08:33:26 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "'sj1557.seo@samsung.com'" <sj1557.seo@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
Thread-Topic: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
Thread-Index: AQHWQsEORi2TuyTfckCQBmL5eJ6kQajZJKZw
Date:   Mon, 15 Jun 2020 08:31:22 +0000
Deferred-Delivery: Mon, 15 Jun 2020 08:33:00 +0000
Message-ID: <TY2PR01MB28755044132E6FCF00F68FFF909C0@TY2PR01MB2875.jpnprd01.prod.outlook.com>
References: <CGME20200612012902epcas1p4194d6fa3b3f7c46a8becb9bb6ce23d56@epcas1p4.samsung.com>
        <20200612012834.13503-1-kohada.t2@gmail.com>
        <219a01d64094$5418d7a0$fc4a86e0$@samsung.com>
        <b29d254b-212a-bfcb-ab7c-456f481b85c8@gmail.com>
 <237301d642c1$09b77e30$1d267a90$@samsung.com>
In-Reply-To: <237301d642c1$09b77e30$1d267a90$@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30a39eca-27db-4758-8d54-08d81106c61f
x-ms-traffictypediagnostic: TY2PR01MB4185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB418596706A239F2B96CACFAA909C0@TY2PR01MB4185.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UDjnUwu23ZuAfR7Mih2i8zYB3rC9LbTCWjKPSsOgEJFr7uFxltMpdPCMZdbB1RU2pitGy6uz4Ayz80WNkgHdtOKJ2nxD4AVkDssxghpRyYkLq7WAc6/kIx3s9EyjqqoaRUsskFLDH4UAzxxpxqGNaCFl+Jew763Nk+O9qass90PDlTRQIfnkn9TnuOgGcFz3pgcI7p99wxfiFPYG71NQ+SEOrXJ80JtCgWPs7qlynKHvAVua9PPLhH232bthmQBCJHuaQf5udXNxB1LRwWgp0zVzBhKkJFR/S1wAmZ2sOa7uJM42icud++9L+2c/ixGj5J8zVyGIMp8ruhwVlDI1fVSjtFi6qaBGCth+I7BEURDIdf7WTuuCxcA6oyMg+lFYWYhMbIK+/Rua7Ava/1uReQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2875.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(8676002)(478600001)(7696005)(6916009)(54906003)(186003)(86362001)(83380400001)(26005)(6506007)(53546011)(5660300002)(71200400001)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(8936002)(33656002)(6666004)(2906002)(55016002)(4326008)(9686003)(52536014)(316002)(14143004)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +NO1E4As8z3HOQEvgeLsnGqzWIEio9tOncbHqVjjMF92Jritq6e8+3oNYC7rnV1AJ1UiCUxWLdF++sCj7mSNOBu0i2xRIXVa608QtKpXaRhZaf6+LaLGmzYHRRtqOPMHZJURrbeN4e+X7irnY/Bdtjkm+9kAP+zi6GlJtz1L5+eeQvap2CSMuGysDq1tST6mCavR5kE613P8x1akVNtmq9jEq4KoERZQbhZJGFBj32Q3QFKkJrE28sMEH2snHxEBDceCPLLGHJLnkAdLu1QmlGBrQz3VuoBAMVtev44QMO3qYKCZhRb05RRaRhBY90c0PDiOq1Ugo+uaz/dKd742Ty3726/rMEfFsRuVNFm69az8sDdFDtGYBxuPji4zS584LvS8C8B16wKxIkkYimRBR9VP+hR33HUYS2al8MlA6UMYTZOKOVLl4jUzEsfNKlx7U+WS2RbQTg3GLZarkiKyvIsDutphg3GEKsi/TVgWX1I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a39eca-27db-4758-8d54-08d81106c61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 08:33:26.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKsbiEOrq0lgSn5hs96n8InkRkaHwpX/zchXka7pnk9dHbDDVvrO0l+kCfG3DfNjnm64e69UEiTZBrSbWiQsyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4185
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IE9uIDIwMjAvMDYvMTIgMTc6MzQsIFN1bmdqb25nIFNlbyB3cm90ZToNCj4gPiA+PiByZW1v
dmUgRVhGQVRfU0JfRElSVFkgZmxhZyBhbmQgcmVsYXRlZCBjb2Rlcy4NCj4gPiA+Pg0KPiA+ID4+
IFRoaXMgZmxhZyBpcyBzZXQvcmVzZXQgaW4gZXhmYXRfcHV0X3N1cGVyKCkvZXhmYXRfc3luY19m
cygpIHRvDQo+ID4gPj4gYXZvaWQgc3luY19ibG9ja2RldigpLg0KPiA+ID4+IEhvd2V2ZXIgLi4u
DQo+ID4gPj4gLSBleGZhdF9wdXRfc3VwZXIoKToNCj4gPiA+PiBCZWZvcmUgY2FsbGluZyB0aGlz
LCB0aGUgVkZTIGhhcyBhbHJlYWR5IGNhbGxlZCBzeW5jX2ZpbGVzeXN0ZW0oKSwNCj4gPiA+PiBz
byBzeW5jIGlzIG5ldmVyIHBlcmZvcm1lZCBoZXJlLg0KPiA+ID4+IC0gZXhmYXRfc3luY19mcygp
Og0KPiA+ID4+IEFmdGVyIGNhbGxpbmcgdGhpcywgdGhlIFZGUyBjYWxscyBzeW5jX2Jsb2NrZGV2
KCksIHNvLCBpdCBpcw0KPiA+ID4+IG1lYW5pbmdsZXNzIHRvIGNoZWNrIEVYRkFUX1NCX0RJUlRZ
IG9yIHRvIGJ5cGFzcyBzeW5jX2Jsb2NrZGV2KCkgaGVyZS4NCj4gPiA+PiBOb3Qgb25seSB0aGF0
LCBidXQgaW4gc29tZSBjYXNlcyBjYW4ndCBjbGVhciBWT0xfRElSVFkuDQo+ID4gPj4gZXg6DQo+
ID4gPj4gVk9MX0RJUlRZIGlzIHNldCB3aGVuIHJtZGlyIHN0YXJ0cywgYnV0IHdoZW4gbm9uLWVt
cHR5LWRpciBpcw0KPiA+ID4+IGRldGVjdGVkLCByZXR1cm4gZXJyb3Igd2l0aG91dCBzZXR0aW5n
IEVYRkFUX1NCX0RJUlRZLg0KPiA+ID4+IElmIHBlcmZvcm1lICdzeW5jJyBpbiB0aGlzIHN0YXRl
LCBWT0xfRElSVFkgd2lsbCBub3QgYmUgY2xlYXJlZC4NCj4gPiA+Pg0KPiA+ID4+IFJlbW92ZSB0
aGUgRVhGQVRfU0JfRElSVFkgY2hlY2sgdG8gZW5zdXJlIHN5bmNocm9uaXphdGlvbi4NCj4gPiA+
PiBBbmQsIHJlbW92ZSB0aGUgY29kZSByZWxhdGVkIHRvIHRoZSBmbGFnLg0KPiA+ID4+DQo+ID4g
Pj4gU2lnbmVkLW9mZi1ieTogVGV0c3VoaXJvIEtvaGFkYSA8a29oYWRhLnQyQGdtYWlsLmNvbT4N
Cj4gPiA+PiAtLS0NCj4gPiA+PiAgIGZzL2V4ZmF0L2JhbGxvYy5jICAgfCAgNCArKy0tDQo+ID4g
Pj4gICBmcy9leGZhdC9kaXIuYyAgICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiA+ID4+ICAg
ZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICA1ICstLS0tDQo+ID4gPj4gICBmcy9leGZhdC9mYXRlbnQu
YyAgIHwgIDcgKystLS0tLQ0KPiA+ID4+ICAgZnMvZXhmYXQvbWlzYy5jICAgICB8ICAzICstLQ0K
PiA+ID4+ICAgZnMvZXhmYXQvbmFtZWkuYyAgICB8IDEyICsrKysrKy0tLS0tLQ0KPiA+ID4+ICAg
ZnMvZXhmYXQvc3VwZXIuYyAgICB8IDExICsrKy0tLS0tLS0tDQo+ID4gPj4gICA3IGZpbGVzIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQ0KPiA+ID4+DQo+ID4gPiBb
c25pcF0NCj4gPiA+Pg0KPiA+ID4+IEBAIC02MiwxMSArNTksOSBAQCBzdGF0aWMgaW50IGV4ZmF0
X3N5bmNfZnMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCj4gPiA+PiBpbnQNCj4gPiA+PiB3YWl0
KQ0KPiA+ID4+DQo+ID4gPj4gICAJLyogSWYgdGhlcmUgYXJlIHNvbWUgZGlydHkgYnVmZmVycyBp
biB0aGUgYmRldiBpbm9kZSAqLw0KPiA+ID4+ICAgCW11dGV4X2xvY2soJnNiaS0+c19sb2NrKTsN
Cj4gPiA+PiAtCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoRVhGQVRfU0JfRElSVFksICZzYmktPnNf
c3RhdGUpKSB7DQo+ID4gPj4gLQkJc3luY19ibG9ja2RldihzYi0+c19iZGV2KTsNCj4gPiA+PiAt
CQlpZiAoZXhmYXRfc2V0X3ZvbF9mbGFncyhzYiwgVk9MX0NMRUFOKSkNCj4gPiA+PiAtCQkJZXJy
ID0gLUVJTzsNCj4gPiA+PiAtCX0NCj4gPiA+DQo+ID4gPiBJIGxvb2tlZCB0aHJvdWdoIG1vc3Qg
Y29kZXMgcmVsYXRlZCB0byBFWEZBVF9TQl9ESVJUWSBhbmQgVk9MX0RJUlRZLg0KPiA+ID4gQW5k
IHlvdXIgYXBwcm9hY2ggbG9va3MgZ29vZCBiZWNhdXNlIGFsbCBvZiB0aGVtIHNlZW0gdG8gYmUN
Cj4gPiA+IHByb3RlY3RlZCBieSBzX2xvY2suDQo+ID4gPg0KPiA+ID4gQlRXLCBhcyB5b3Uga25v
dywgc3luY19maWxlc3lzdGVtKCkgY2FsbHMgc3luY19mcygpIHdpdGggJ25vd2FpdCcNCj4gPiA+
IGZpcnN0LCBhbmQgdGhlbiBjYWxscyBpdCBhZ2FpbiB3aXRoICd3YWl0JyB0d2ljZS4gTm8gbmVl
ZCB0byBzeW5jDQo+ID4gPiB3aXRoDQo+ID4gbG9jayB0d2ljZS4NCj4gPiA+IElmIHNvLCBpc24n
dCBpdCBva2F5IHRvIGRvIG5vdGhpbmcgd2hlbiB3YWl0IGlzIDA/DQo+ID4NCj4gPiBJIGFsc28g
dGhpbmsgIOKAmGRvIG5vdGhpbmcgd2hlbiB3YWl0IGlzIDDigJkgYXMgeW91IHNheSwgYnV0IEkn
bSBzdGlsbA0KPiA+IG5vdCBzdXJlLg0KPiA+DQo+ID4gU29tZSBvdGhlciBGaWxlc3lzdGVtcyBk
byBub3RoaW5nIHdpdGggbm93YWl0IGFuZCBqdXN0IHJldHVybi4NCj4gPiBIb3dldmVyLCBhIGZl
dyBGaWxlc3lzdGVtcyBhbHdheXMgcGVyZm9ybSBzeW5jLg0KPiA+DQo+ID4gc3luY19ibG9ja2Rl
digpIHdhaXRzIGZvciBjb21wbGV0aW9uLCBzbyBpdCBtYXkgYmUgaW5hcHByb3ByaWF0ZSB0bw0K
PiA+IGNhbGwgd2l0aCAgbm93YWl0LiAoQnV0IGl0IHdhcyBjYWxsZWQgaW4gdGhlIG9yaWdpbmFs
IGNvZGUpDQo+ID4NCj4gPiBJJ20gc3RpbGwgbm90IHN1cmUsIHNvIEkgZXhjbHVkZWQgaXQgaW4g
dGhpcyBwYXRjaC4NCj4gPiBJcyBpdCBva2F5IHRvIGluY2x1ZGUgaXQ/DQo+ID4NCj4gDQo+IFll
cywgSSB0aGluayBzby4gc3luY19maWxlc3lzdGVtKCkgd2lsbCBjYWxsIF9fc3luY19ibG9ja2Rl
digpIHdpdGhvdXQgJ3dhaXQnIGZpcnN0Lg0KPiBTbywgaXQncyBlbm91Z2ggdG8gY2FsbCBzeW5j
X2Jsb2NrZGV2KCkgd2l0aCBzX2xvY2sganVzdCBvbmUgdGltZS4NCg0KT0suDQpJIHdpbGwgcmVw
b3N0IHYyLXBhdGNoIHdpdGggdGhlICd3YWl0JyBjaGVjayBhZGRlZC4NClRoYW5rcyBmb3IgeW91
ciBjb21tZW50Lg0KDQoNCj4gPiA+PiArCXN5bmNfYmxvY2tkZXYoc2ItPnNfYmRldik7DQo+ID4g
Pj4gKwlpZiAoZXhmYXRfc2V0X3ZvbF9mbGFncyhzYiwgVk9MX0NMRUFOKSkNCj4gPiA+PiArCQll
cnIgPSAtRUlPOw0KPiA+ID4+ICAgCW11dGV4X3VubG9jaygmc2JpLT5zX2xvY2spOw0KPiA+ID4+
ICAgCXJldHVybiBlcnI7DQo+ID4gPj4gICB9DQo+ID4gPj4gLS0NCj4gPiA+PiAyLjI1LjENCg0K
QlINCi0tLQ0KS29oYWRhIFRldHN1aGlybyA8S29oYWRhLlRldHN1aGlyb0BkYy5NaXRzdWJpc2hp
RWxlY3RyaWMuY28uanA+DQo=
