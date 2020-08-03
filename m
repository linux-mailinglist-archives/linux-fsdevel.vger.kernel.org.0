Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF523A059
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 09:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgHCHd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 03:33:29 -0400
Received: from mx04.melco.co.jp ([192.218.140.144]:51572 "EHLO
        mx04.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHCHd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:33:27 -0400
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 07C323A3ECD;
        Mon,  3 Aug 2020 16:33:23 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 4BKqPG72DGzRk3T;
        Mon,  3 Aug 2020 16:33:22 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr04.melco.co.jp (Postfix) with ESMTP id 4BKqPG6kFGzRk29;
        Mon,  3 Aug 2020 16:33:22 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 4BKqPG6VdczRjxx;
        Mon,  3 Aug 2020 16:33:22 +0900 (JST)
Received: from APC01-PU1-obe.outbound.protection.outlook.com (unknown [104.47.126.55])
        by mf03.melco.co.jp (Postfix) with ESMTP id 4BKqPG507SzRjym;
        Mon,  3 Aug 2020 16:33:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzBDF8626ZBoJDSUSn+1ZcbKsVk8VZkpGxfszCNYiM5E9LN3OYb5aIoB+sjAssPWNTPpxldmGNPsE7BaKfkvqdO8oJ7xPDMGl4PJTF/slkqZTkb0Z7IxFYMsL63o7tnkQ+UdkgLERwgpLXjLGZnIWl/5WFBqOsHYQqtmuDdrzApIjhNi2Gy8rDVI8Xl+vdE2WKpfYb+qVLLSJE1Q7xDGT3B05LDFwdu0luP/WvBw8jlxB+WnqOfGxxV2sAwMAwOzCQJfirNRURWaU1ey2ZPi0IpyO39/2h0sxcfwhzA0nANgtbO1EKK18zN5C7PjCzIaO6oQscCFijO+Tqim/m5HxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu0R9eHByOHMYEgrdS/G+Iu95nK1oYdhSMcoABCYDAQ=;
 b=E/k2pTG938qm56zT4mK2PL0epI8IMU7pcT2NAgw0iVpZ32Cb4FjqopGNjeSgHYxxwlXeFos/k5HZI2Csb/urD3s3fy/dvl1YYFPd1DKvhxD0+H/pkUwUO4Nla3x8Me235V6d6czaDhKhAsmwBljOGKQOsClOxCTI7V0Rn1v894prSakU63aGPY+eFStF0rTMb9APDfPE+wleN0qiNeSIn4V7UoW9mhTMNrPI/cWSbWnWEQkxkbOvDaD0bz8TUiG+ndU8IYRsTYqjZTO8p6BM7Qn2gCtAai4qmsvXFcrId71NOBhAKWDRxK+ug2LXEdouVNBKFDS1r8dazIfkazPWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu0R9eHByOHMYEgrdS/G+Iu95nK1oYdhSMcoABCYDAQ=;
 b=UvlPKE8vMIO16CAiA5MbEwXtfNA57ijF/Lz04PZseUG9X1yxu7wo41L/lsymxSkiGSbiWMdu3nOLJNXgWE1E4VTOh2BwI1RlI73lFLhGdRPw291wNcRwu9F3neMUnvIMiEEz9P3qK8UsPkvWfLrTqlrlp36bXL6oy73qhHV5iXU=
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com (2603:1096:404:6b::11)
 by TY2PR01MB3131.jpnprd01.prod.outlook.com (2603:1096:404:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 07:33:21 +0000
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::c6d:a4cb:3c4a:2373]) by TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::c6d:a4cb:3c4a:2373%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:33:21 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Namjae Jeon' <namjae.jeon@samsung.com>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] exfat: integrates dir-entry getting and validation
Thread-Topic: [PATCH v2] exfat: integrates dir-entry getting and validation
Thread-Index: AQJkKvf3lVanaAlN2afWcUIlbNXqzwJnQ0rYp/DmSOCABgCqoA==
Date:   Mon, 3 Aug 2020 07:31:02 +0000
Deferred-Delivery: Mon, 3 Aug 2020 07:33:00 +0000
Message-ID: <TY2PR01MB287579A95A7994DE2B34E425904D0@TY2PR01MB2875.jpnprd01.prod.outlook.com>
References: <CGME20200715012304epcas1p23e9f45415afc551beea122e4e1bdb933@epcas1p2.samsung.com>
        <20200715012249.16378-1-kohada.t2@gmail.com>
 <015d01d6663e$1eb8c780$5c2a5680$@samsung.com>
In-Reply-To: <015d01d6663e$1eb8c780$5c2a5680$@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84937104-73f4-40dd-d266-08d8377f7fe8
x-ms-traffictypediagnostic: TY2PR01MB3131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB31311A42902C2A5A9312C619904D0@TY2PR01MB3131.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BQpQm/k2gaMp2qklSxNn07TYF5nLB2EhUpA285wJlGy+whEeXjLB7atCl324zHGFSObFNYohKjKRUweR4h1sm9Lao8St8JGDlJsJguiPee7JcEK6Hbm36rlnIbdQKUI0ePi1diLhbfyFkf4P9sDp+85pCjcv3QaalFM3i/ZU/5PCvfvRg/gyJhHHpXFRiR6h0Z2m7AI2QqQO+rzqDT0fcWvXfF9SgRQm2gAKG75JLUc533f+thX8RhP9KvCx5pw1PHaQYml34AzqIedcOpQRWCbrP/9M3U5SuRcEbXaWBtkbGKGz/YnnYnRqHCXWeCS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2875.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(136003)(346002)(366004)(52536014)(66946007)(7696005)(8936002)(478600001)(2906002)(76116006)(8676002)(6506007)(66446008)(64756008)(66556008)(66476007)(83380400001)(54906003)(86362001)(26005)(9686003)(186003)(6916009)(5660300002)(4326008)(316002)(55016002)(71200400001)(33656002)(6666004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gtFm4uueLgIaTJiN02jde5U9wAxh2+K+TDLH1fSVZXE3SiUeiw1lR2Sw9QIdIJtYfFS6J9N8hLUzVM5XRxDhnTlAscsjk8wI9ttuZF49nbKbK56eGOEL3YnXMSkLHpdjHp4Elwhp+19rYPTaSGPjSfptr+uGlGNphQfg8K4Am3JdYOirvFGe/y6HETNhkgo0aVeoUVmcDoFWTgRHVUAlcZAOX3W9QNRrY0ReSmf+dbvxehsN6MIlg50B+s+AZoMBYkNwmLNKlV3dLBIDI5DXsUWJJw/wgwlKCpgU1E4ra290w/QCymh4JRYkFQeXcz+Xq/2BNlWl5PBqxUfErCNPEmF2Sq0XEvtdXt6O4syYHP2ldqG9PKOdTFzl49Nz6uO20DMBFdqZmf9DwpuRgg/khdFTokRoIMoErtHTCYO+6BhB1u+WhivPeTEwWAVOccvlhDcbAB8G0LwhOEm/G2n9CpXiBLnJcyS2XWMTgVdx2mSVc1lpRQSQPp2B7wYh3enNGNya9hCOYL3ORHD86x1OVmTcnAJwayw3Mc3qq4QM9yaXZDyEF53qw6gHVS21xHD0OIeVqTO90VaI7xFjUL+mtQs25p1nURn4C20BJz1AdHqI+DRRyKT3mZLYBPIAFbPNPCz7nwKbtUgbPcmVcuH4wA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2875.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84937104-73f4-40dd-d266-08d8377f7fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 07:33:21.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdIgw/vftrGrj+4B/wQ90TBIAOMMy2V8NKM1pYN/tGWcVj5msyptM6Mkz2nwQ3pGuBvREobbgw9QGR8HHLw63g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3131
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rp
ci5jIGIvZnMvZXhmYXQvZGlyLmMgaW5kZXgNCj4gPiA1NzM2NTliZmJjNTUuLjA5Yjg1NzQ2ZTc2
MCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9leGZhdC9kaXIuYw0KPiA+ICsrKyBiL2ZzL2V4ZmF0L2Rp
ci5jDQo+ID4gQEAgLTMzLDYgKzMzLDcgQEAgc3RhdGljIHZvaWQgZXhmYXRfZ2V0X3VuaW5hbWVf
ZnJvbV9leHRfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgIHsNCj4gPiAgCWludCBpOw0K
PiA+ICAJc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXM7DQo+ID4gKwlzdHJ1Y3QgZXhm
YXRfZGVudHJ5ICplcDsNCj4gPg0KPiA+ICAJZXMgPSBleGZhdF9nZXRfZGVudHJ5X3NldChzYiwg
cF9kaXIsIGVudHJ5LCBFU19BTExfRU5UUklFUyk7DQo+ID4gIAlpZiAoIWVzKQ0KPiA+IEBAIC00
NCwxMyArNDUsOSBAQCBzdGF0aWMgdm9pZCBleGZhdF9nZXRfdW5pbmFtZV9mcm9tX2V4dF9lbnRy
eShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiA+ICAJICogVGhpcmQgZW50cnkgIDogZmlyc3Qg
ZmlsZS1uYW1lIGVudHJ5DQo+ID4gIAkgKiBTbywgdGhlIGluZGV4IG9mIGZpcnN0IGZpbGUtbmFt
ZSBkZW50cnkgc2hvdWxkIHN0YXJ0IGZyb20gMi4NCj4gPiAgCSAqLw0KPiA+IC0JZm9yIChpID0g
MjsgaSA8IGVzLT5udW1fZW50cmllczsgaSsrKSB7DQo+ID4gLQkJc3RydWN0IGV4ZmF0X2RlbnRy
eSAqZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQo+ID4gLQ0KPiA+IC0JCS8q
IGVuZCBvZiBuYW1lIGVudHJ5ICovDQo+ID4gLQkJaWYgKGV4ZmF0X2dldF9lbnRyeV90eXBlKGVw
KSAhPSBUWVBFX0VYVEVORCkNCj4gPiAtCQkJYnJlYWs7DQo+ID4NCj4gPiArCWkgPSAyOw0KPiA+
ICsJd2hpbGUgKChlcCA9IGV4ZmF0X2dldF92YWxpZGF0ZWRfZGVudHJ5KGVzLCBpKyssIFRZUEVf
TkFNRSkpKSB7DQo+IEFzIFN1bmdqb25nIHNhaWQsIEkgdGhpbmsgdGhhdCBUWVBFX05BTUUgc2Vl
bXMgcmlnaHQgdG8gYmUgdmFsaWRhdGVkIGluIGV4ZmF0X2dldF9kZW50cnlfc2V0KCkuDQoNCkZp
cnN0LCBpdCBpcyBwb3NzaWJsZSB0byBjb3JyZWN0bHkgZGV0ZXJtaW5lIHRoYXQgDQoiSW1tZWRp
YXRlbHkgZm9sbG93IHRoZSBTdHJlYW0gRXh0ZW5zaW9uIGRpcmVjdG9yeSBlbnRyeSBhcyBhIGNv
bnNlY3V0aXZlIHNlcmllcyIgDQp3aGV0aGVyIHRoZSBUWVBFX05BTUUgY2hlY2sgaXMgaW1wbGVt
ZW50ZWQgaGVyZSBvciBleGZhdF9nZXRfZGVudHJ5X3NldCgpLg0KSXQncyBmdW5jdGlvbmFsbHkg
c2FtZSwgc28gaXQgaXMgYWxzbyByaWdodCB0byB2YWxpZGF0ZSBpbiBlaXRoZXIuDQoNClNlY29u
ZCwgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgY2FyZSBmb3IgTmFtZUxlbmd0
aCBmaWVsZCwgYXMgSSByZXBsaWVkIHRvIFN1bmdqb25nLg0KSWYgbmFtZSBpcyBub3QgdGVybWlu
YXRlZCB3aXRoIHplcm8sIHRoZSBuYW1lIHdpbGwgYmUgaW5jb3JyZWN0LihXaXRoIG9yIHdpdGhv
dXQgbXkgcGF0Y2gpDQpJIHRoaW5rIFRZUEVfTkFNRSBhbmQgTmFtZUxlbmd0aCB2YWxpZGF0aW9u
IHNob3VsZCBub3QgYmUgc2VwYXJhdGVkIGZyb20gdGhlIG5hbWUgZXh0cmFjdGlvbi4NCklmIHZh
bGlkYXRlIFRZUEVfTkFNRSBpbiBleGZhdF9nZXRfZGVudHJ5X3NldCgpLCBOYW1lTGVuZ3RoIHZh
bGlkYXRpb24gYW5kIG5hbWUgZXh0cmFjdGlvbiANCnNob3VsZCBhbHNvIGJlIGltcGxlbWVudGVk
IHRoZXJlLg0KKE90aGVyd2lzZSwgYSBkdXBsaWNhdGlvbiBjaGVjayB3aXRoIGV4ZmF0X2dldF9k
ZW50cnlfc2V0KCkgYW5kIGhlcmUuKQ0KSSB3aWxsIGFkZCBOYW1lTGVuZ3RoIHZhbGlkYXRpb24g
aGVyZS4NClRoZXJlZm9yZSwgVFlQRV9OQU1FIHZhbGlkYXRpb24gaGVyZSBzaG91bGQgbm90IGJl
IG9taXR0ZWQuDQoNClRoaXJkLCBnZXR0aW5nIGRlbnRyeSBhbmQgZW50cnktdHlwZSB2YWxpZGF0
aW9uIHNob3VsZCBiZSBpbnRlZ3JhdGVkLg0KVGhlc2Ugbm8gbG9uZ2VyIGhhdmUgdG8gYmUgcHJp
bWl0aXZlLg0KVGhlIGludGVncmF0aW9uIHNpbXBsaWZpZXMgY2FsbGVyIGVycm9yIGNoZWNraW5n
Lg0KDQoNCj4gPiAtc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQo
DQo+ID4gLQlzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywgaW50IG51bSkNCj4gPiAr
c3RydWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X3ZhbGlkYXRlZF9kZW50cnkoc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQo+ID4gKwkJCQkJCWludCBudW0sIHVuc2lnbmVkIGlu
dCB0eXBlKQ0KPiBQbGVhc2UgdXNlIHR3byB0YWJzLg0KDQpPSy4NCkknbGwgZml4IGl0Lg0KDQoN
Cj4gPiArCXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7DQo+ID4gKwlzdHJ1Y3QgZXhmYXRfZGVudHJ5
ICplcDsNCj4gPg0KPiA+IC0JcmV0dXJuIChzdHJ1Y3QgZXhmYXRfZGVudHJ5ICopcDsNCj4gPiAr
CWlmIChudW0gPj0gZXMtPm51bV9lbnRyaWVzKQ0KPiA+ICsJCXJldHVybiBOVUxMOw0KPiA+ICsN
Cj4gPiArCWJoID0gZXMtPmJoW0VYRkFUX0JfVE9fQkxLKG9mZiwgZXMtPnNiKV07DQo+ID4gKwlp
ZiAoIWJoKQ0KPiA+ICsJCXJldHVybiBOVUxMOw0KPiA+ICsNCj4gPiArCWVwID0gKHN0cnVjdCBl
eGZhdF9kZW50cnkgKikNCj4gPiArCQkoYmgtPmJfZGF0YSArIEVYRkFUX0JMS19PRkZTRVQob2Zm
LCBlcy0+c2IpKTsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKHR5cGUpIHsNCj4gPiArCWNhc2UgVFlQ
RV9BTEw6IC8qIGFjY2VwdCBhbnkgKi8NCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgVFlQRV9G
SUxFOg0KPiA+ICsJCWlmIChlcC0+dHlwZSAhPSBFWEZBVF9GSUxFKQ0KPiA+ICsJCQlyZXR1cm4g
TlVMTDsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgVFlQRV9TRUNPTkRBUlk6DQo+ID4gKwkJ
aWYgKCEodHlwZSAmIGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKSkpDQo+ID4gKwkJCXJldHVybiBO
VUxMOw0KPiA+ICsJCWJyZWFrOw0KPiBUeXBlIGNoZWNrIHNob3VsZCBiZSBpbiB0aGlzIG9yZGVy
IDogRklMRS0+U1RSRUFNLT5OQU1FLT57Q1JJVElDQUxfU0VDfEJFTklHTl9TRUN9DQo+IEkgdGhp
bmsgdGhhdCB5b3UgYXJlIG1pc3NpbmcgVFlQRV9OQU1FIGNoZWNrIGhlcmUuDQoNClR5cGVzIG90
aGVyIHRoYW4gdGhlIGFib3ZlIChUWVBFX05BTUUsIFRZUEVfU1RSRUFNLCBldGMuKSBhcmUgY2hl
Y2tlZCBpbiB0aGUgZGVmYXVsdC1jYXNlKGFzIGJlbG93KS4NCg0KPiA+ICsJZGVmYXVsdDoNCj4g
PiArCQlpZiAodHlwZSAhPSBleGZhdF9nZXRfZW50cnlfdHlwZShlcCkpDQo+ID4gKwkJCXJldHVy
biBOVUxMOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIGVwOw0KPiA+ICB9DQo+ID4NCj4gPiAgLyoN
Cj4gPiAgICogUmV0dXJucyBhIHNldCBvZiBkZW50cmllcyBmb3IgYSBmaWxlIG9yIGRpci4NCj4g
PiAgICoNCj4gPiAtICogTm90ZSBJdCBwcm92aWRlcyBhIGRpcmVjdCBwb2ludGVyIHRvIGJoLT5k
YXRhIHZpYSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgpLg0KPiA+ICsgKiBOb3RlIEl0IHByb3Zp
ZGVzIGEgZGlyZWN0IHBvaW50ZXIgdG8gYmgtPmRhdGEgdmlhIGV4ZmF0X2dldF92YWxpZGF0ZWRf
ZGVudHJ5KCkuDQo+ID4gICAqIFVzZXIgc2hvdWxkIGNhbGwgZXhmYXRfZ2V0X2RlbnRyeV9zZXQo
KSBhZnRlciBzZXR0aW5nICdtb2RpZmllZCcgdG8gYXBwbHkNCj4gPiAgICogY2hhbmdlcyBtYWRl
IGluIHRoaXMgZW50cnkgc2V0IHRvIHRoZSByZWFsIGRldmljZS4NCj4gPiAgICoNCj4gPiAgICog
aW46DQo+ID4gICAqICAgc2IrcF9kaXIrZW50cnk6IGluZGljYXRlcyBhIGZpbGUvZGlyDQo+ID4g
LSAqICAgdHlwZTogIHNwZWNpZmllcyBob3cgbWFueSBkZW50cmllcyBzaG91bGQgYmUgaW5jbHVk
ZWQuDQo+ID4gKyAqICAgbWF4X2VudHJpZXM6ICBzcGVjaWZpZXMgaG93IG1hbnkgZGVudHJpZXMg
c2hvdWxkIGJlIGluY2x1ZGVkLg0KPiA+ICAgKiByZXR1cm46DQo+ID4gICAqICAgcG9pbnRlciBv
ZiBlbnRyeSBzZXQgb24gc3VjY2VzcywNCj4gPiAgICogICBOVUxMIG9uIGZhaWx1cmUuDQo+ID4g
KyAqIG5vdGU6DQo+ID4gKyAqICAgT24gc3VjY2VzcywgZ3VhcmFudGVlIHRoZSBjb3JyZWN0ICdm
aWxlJyBhbmQgJ3N0cmVhbS1leHQnIGRpci1lbnRyaWVzLg0KPiBUaGlzIGNvbW1lbnQgc2VlbXMg
dW5uZWNlc3NhcnkuDQoNCkknbGwgcmVtb3ZlIGl0Lg0KDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2V4
ZmF0L2ZpbGUuYyBiL2ZzL2V4ZmF0L2ZpbGUuYyBpbmRleA0KPiA+IDY3MDdmM2ViMDliNS4uYjZi
NDU4ZTZmNWUzIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0KPiA+ICsrKyBiL2Zz
L2V4ZmF0L2ZpbGUuYw0KPiA+IEBAIC0xNjAsOCArMTYwLDggQEAgaW50IF9fZXhmYXRfdHJ1bmNh
dGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXplKQ0KPiA+ICAJCQkJRVNfQUxM
X0VOVFJJRVMpOw0KPiA+ICAJCWlmICghZXMpDQo+ID4gIAkJCXJldHVybiAtRUlPOw0KPiA+IC0J
CWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIDApOw0KPiA+IC0JCWVwMiA9IGV4ZmF0
X2dldF9kZW50cnlfY2FjaGVkKGVzLCAxKTsNCj4gPiArCQllcCA9IGV4ZmF0X2dldF92YWxpZGF0
ZWRfZGVudHJ5KGVzLCAwLCBUWVBFX0ZJTEUpOw0KPiA+ICsJCWVwMiA9IGV4ZmF0X2dldF92YWxp
ZGF0ZWRfZGVudHJ5KGVzLCAxLCBUWVBFX1NUUkVBTSk7DQo+IFRZUEVfRklMRSBhbmQgVFlQRV9T
VFJFQU0gd2FzIGFscmVhZHkgdmFsaWRhdGVkIGluIGV4ZmF0X2dldF9kZW50cnlfc2V0KCkuDQo+
IElzbid0IGl0IHVubmVjZXNzYXJ5IGR1cGxpY2F0aW9uIGNoZWNrID8NCg0KTm8sIGFzIHlvdSBz
YXkuDQpBbHRob3VnaCBUWVBFIGlzIHNwZWNpZmllZCwgaXQgaXMgbm90IGdvb2Qgbm90IHRvIGNo
ZWNrIHRoZSBudWxsIG9mIGVwL2VwMi4NCkhvd2V2ZXIsIHdpdGggVFlQRV9BTEwsIGl0IGJlY29t
ZXMgZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQgd2hhdCBwdXJwb3NlIGVwL2VwMiBpcyB1c2VkIGZv
ci4NClRoZXJlZm9yZSwgSSBwcm9wb3NlZCBhZGRpbmcgZXBfZmlsZS9lcF9zdHJlYW0gdG8gZXMs
IGFuZCBoZXJlDQoJZXAgPSBlcy0+ZXBfZmlsZTsNCgllcDIgPSBlcy0+ZXBfc3RyZWFtOw0KDQpI
b3cgYWJvdXQgdGhpcz8NCk9yIGlzIGl0IGJldHRlciB0byBzcGVjaWZ5IFRZUEVfQUxMPw0KDQoN
CkJUVw0KSXQncyBiZWVuIGFib3V0IGEgbW9udGggc2luY2UgSSBwb3N0ZWQgdGhpcyBwYXRjaC4N
CkluIHRoZSBtZWFudGltZSwgSSBjcmVhdGVkIGEgTmFtZUxlbmd0aCBjaGVjayBhbmQgYSBjaGVj
a3N1bSB2YWxpZGF0aW9uIGJhc2VkIG9uIHRoaXMgcGF0Y2guDQpDYW4geW91IHJldmlldyB0aG9z
ZSBhcyB3ZWxsPw0KDQpCUg0KLS0tDQpLb2hhZGEgVGV0c3VoaXJvIDxLb2hhZGEuVGV0c3VoaXJv
QGRjLk1pdHN1YmlzaGlFbGVjdHJpYy5jby5qcD4NCg==
