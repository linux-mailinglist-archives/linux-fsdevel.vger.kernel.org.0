Return-Path: <linux-fsdevel+bounces-23662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09A93109C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651E61F2275D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60901849F2;
	Mon, 15 Jul 2024 08:52:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247D1E890;
	Mon, 15 Jul 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033520; cv=none; b=tqmrX/2wrnaExa38LEySHf2VHuLTekJTVCJEGvqm6w/48L4nz5ef1Q2cKXuiwqyABDHOOMtBvvpFrRJPnrnERCci3qjsuHnRumzYymmFPJeyNA6n/suwpO+tUdmSv8D9OONA4SlPTW2jB0SKLRHzwMBw3UZetl9Y8jYtYfc+z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033520; c=relaxed/simple;
	bh=MULiLWRxGosoInm+lDZuYZy61OJ+nSPylNPCR/kM1aI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IT5CJ2yWcRJnY9Fz6ThTPN6IUGqQDxSNWHx2KQKTe00hPIhpXaAgn8ZLyx6UUYhZ807FYmX+pDlVmvGfPtqMCD7XhP59PApDD7qha3pSwP9i8wMeGX/vshVaApTODOiJkbVswUM+4ZK+q+jiP9Hc8WBHmIRZAbDRoHZTXZkQiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46F8pKfF064264;
	Mon, 15 Jul 2024 16:51:20 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WMwlW3Zmyz2LKZqD;
	Mon, 15 Jul 2024 16:45:59 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 15 Jul
 2024 16:51:18 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Mon, 15 Jul 2024 16:51:17 +0800
From: =?utf-8?B?5bSU5Lic5LquIChEb25nbGlhbmcgQ3VpKQ==?=
	<Dongliang.Cui@unisoc.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
        "cuidongliang390@gmail.com" <cuidongliang390@gmail.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiBjaGVjayBkaXNrIHN0YXR1cyBkdXJp?=
 =?utf-8?Q?ng_buffer_write?=
Thread-Topic: [PATCH] exfat: check disk status during buffer write
Thread-Index: AQHazrN5wdl9vyZZ60iQ5gkqO2k6u7HwvA0AgAbHZNA=
Date: Mon, 15 Jul 2024 08:51:17 +0000
Message-ID: <da2c0cd06c4a4dfa86f0ea2dbc3e1435@BJMBX02.spreadtrum.com>
References: <CGME20240705081528epcas1p32c38cfb39dae65109bbfbd405a9852b2@epcas1p3.samsung.com>
	<20240705081514.1901580-1-dongliang.cui@unisoc.com>
 <459601dad36f$c913a770$5b3af650$@samsung.com>
In-Reply-To: <459601dad36f$c913a770$5b3af650$@samsung.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 46F8pKfF064264

PiBXZSBmb3VuZCB0aGF0IHdoZW4gd3JpdGluZyBhIGxhcmdlIGZpbGUgdGhyb3VnaCBidWZmZXIg
d3JpdGUsIGlmIHRoZSANCj4gZGlzayBpcyBpbmFjY2Vzc2libGUsIGV4RkFUIGRvZXMgbm90IHJl
dHVybiBhbiBlcnJvciBub3JtYWxseSwgd2hpY2ggDQo+IGxlYWRzIHRvIHRoZSB3cml0aW5nIHBy
b2Nlc3Mgbm90IHN0b3BwaW5nIHByb3Blcmx5Lg0KPg0KPiBUbyBlYXNpbHkgcmVwcm9kdWNlIHRo
aXMgaXNzdWUsIHlvdSBjYW4gZm9sbG93IHRoZSBzdGVwcyBiZWxvdzoNCj4NCj4gMS4gZm9ybWF0
IGEgZGV2aWNlIHRvIGV4RkFUIGFuZCB0aGVuIG1vdW50ICh3aXRoIGEgZnVsbCBkaXNrIGVyYXNl
KSAyLiANCj4gZGQgaWY9L2Rldi96ZXJvIG9mPS9leGZhdF9tb3VudC90ZXN0LmltZyBicz0xTSBj
b3VudD04MTkyIDMuIGVqZWN0IHRoZSANCj4gZGV2aWNlDQo+DQo+IFlvdSBtYXkgZmluZCB0aGF0
IHRoZSBkZCBwcm9jZXNzIGRvZXMgbm90IHN0b3AgaW1tZWRpYXRlbHkgYW5kIG1heSANCj4gY29u
dGludWUgZm9yIGEgbG9uZyB0aW1lLg0KPg0KPiBXZSBjb21wYXJlZCBpdCB3aXRoIHRoZSBGQVQs
IHdoZXJlIEZBVCB3b3VsZCBwcm9tcHQgYW4gRUlPIGVycm9yIGFuZCANCj4gaW1tZWRpYXRlbHkg
c3RvcCB0aGUgZGQgb3BlcmF0aW9uLg0KPg0KPiBUaGUgcm9vdCBjYXVzZSBvZiB0aGlzIGlzc3Vl
IGlzIHRoYXQgd2hlbiB0aGUgZXhmYXRfaW5vZGUgY29udGFpbnMgdGhlIA0KPiBBTExPQ19OT19G
QVRfQ0hBSU4gZmxhZywgZXhGQVQgZG9lcyBub3QgbmVlZCB0byBhY2Nlc3MgdGhlIGRpc2sgdG8g
DQo+IGxvb2sgdXAgZGlyZWN0b3J5IGVudHJpZXMgb3IgdGhlIEZBVCB0YWJsZSAod2hlcmVhcyBG
QVQgd291bGQgZG8pIA0KPiBldmVyeSB0aW1lIGRhdGEgaXMgd3JpdHRlbi4gSW5zdGVhZCwgZXhG
QVQgc2ltcGx5IG1hcmtzIHRoZSBidWZmZXIgYXMgDQo+IGRpcnR5IGFuZCByZXR1cm5zLCBkZWxl
Z2F0aW5nIHRoZSB3cml0ZWJhY2sgb3BlcmF0aW9uIHRvIHRoZSB3cml0ZWJhY2sgDQo+IHByb2Nl
c3MuDQo+DQo+IElmIHRoZSBkaXNrIGNhbm5vdCBiZSBhY2Nlc3NlZCBhdCB0aGlzIHRpbWUsIHRo
ZSBlcnJvciB3aWxsIG9ubHkgYmUgDQo+IHJldHVybmVkIHRvIHRoZSB3cml0ZWJhY2sgcHJvY2Vz
cywgYW5kIHRoZSBvcmlnaW5hbCBwcm9jZXNzIHdpbGwgbm90IA0KPiByZWNlaXZlIHRoZSBlcnJv
ciwgc28gaXQgY2Fubm90IGJlIHJldHVybmVkIHRvIHRoZSB1c2VyIHNpZGUuDQo+DQo+IFRoZXJl
Zm9yZSwgd2UgdGhpbmsgdGhhdCB3aGVuIHdyaXRpbmcgZmlsZXMgd2l0aCBBTExPQ19OT19GQVRf
Q0hBSU4sIA0KPiBpdCBpcyBuZWNlc3NhcnkgdG8gY29udGludW91c2x5IGNoZWNrIHRoZSBzdGF0
dXMgb2YgdGhlIGRpc2suDQo+DQo+IFdoZW4gdGhlIGRpc2sgY2Fubm90IGJlIGFjY2Vzc2VkIG5v
cm1hbGx5LCBhbiBlcnJvciBzaG91bGQgYmUgcmV0dXJuZWQgDQo+IHRvIHN0b3AgdGhlIHdyaXRp
bmcgcHJvY2Vzcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRG9uZ2xpYW5nIEN1aSA8ZG9uZ2xpYW5n
LmN1aUB1bmlzb2MuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGlndW8gTml1IDx6aGlndW8ubml1
QHVuaXNvYy5jb20+DQo+IC0tLQ0KPiAgZnMvZXhmYXQvZXhmYXRfZnMuaCB8IDUgKysrKysNCj4g
IGZzL2V4ZmF0L2lub2RlLmMgICAgfCA1ICsrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9l
eGZhdC9leGZhdF9mcy5oIGluZGV4IA0KPiBlY2M1ZGI5NTJkZWIuLmM1ZjVhN2E4YjY3MiAxMDA2
NDQNCj4gLS0tIGEvZnMvZXhmYXQvZXhmYXRfZnMuaA0KPiArKysgYi9mcy9leGZhdC9leGZhdF9m
cy5oDQo+IEBAIC00MTEsNiArNDExLDExIEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IA0K
PiBleGZhdF9zZWN0b3JfdG9fY2x1c3RlcihzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpLA0KPiAg
ICAgICAgICAgICAgIEVYRkFUX1JFU0VSVkVEX0NMVVNURVJTOyAgfQ0KPg0KPiArc3RhdGljIGlu
bGluZSBib29sIGV4ZmF0X2NoZWNrX2Rpc2tfZXJyb3Ioc3RydWN0IGJsb2NrX2RldmljZSAqYmRl
dikgDQo+ICt7DQo+ICsgICAgIHJldHVybiBibGtfcXVldWVfZHlpbmcoYmRldl9nZXRfcXVldWUo
YmRldikpOw0KV2h5IGRvbid0IHlvdSBjaGVjayBpdCBsaWtlIGV4dDQ/DQoNCnN0YXRpYyBpbnQg
YmxvY2tfZGV2aWNlX2VqZWN0ZWQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikgew0KICAgICAgIHN0
cnVjdCBpbm9kZSAqYmRfaW5vZGUgPSBzYi0+c19iZGV2LT5iZF9pbm9kZTsNCiAgICAgICBzdHJ1
Y3QgYmFja2luZ19kZXZfaW5mbyAqYmRpID0gaW5vZGVfdG9fYmRpKGJkX2lub2RlKTsNCg0KICAg
ICAgIHJldHVybiBiZGktPmRldiA9PSBOVUxMOw0KfQ0KDQpUaGUgYmxvY2tfZGV2aWNlLT5iZF9p
bm9kZSBoYXMgYmVlbiByZW1vdmVkIGluIHRoZSBsYXRlc3QgY29kZS4NCldlIG1pZ2h0IGJlIGFi
bGUgdG8gdXNlIHN1cGVyX2Jsb2NrLT5zX2JkaS0+ZGV2IGZvciB0aGUganVkZ21lbnQsDQpvciBw
ZXJoYXBzIHVzZSBibGtfcXVldWVfZHlpbmc/DQoNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGlu
ZSBib29sIGlzX3ZhbGlkX2NsdXN0ZXIoc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSwNCj4gICAg
ICAgICAgICAgICB1bnNpZ25lZCBpbnQgY2x1cykNCj4gIHsNCj4gZGlmZiAtLWdpdCBhL2ZzL2V4
ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jIGluZGV4IA0KPiBkZDg5NGU1NThjOTEuLmVm
ZDAyYzFjODNhNiAxMDA2NDQNCj4gLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KPiArKysgYi9mcy9l
eGZhdC9pbm9kZS5jDQo+IEBAIC0xNDcsNiArMTQ3LDExIEBAIHN0YXRpYyBpbnQgZXhmYXRfbWFw
X2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgDQo+IHVuc2lnbmVkIGludCBjbHVfb2Zmc2V0
LA0KPiAgICAgICAqY2x1ID0gbGFzdF9jbHUgPSBlaS0+c3RhcnRfY2x1Ow0KPg0KPiAgICAgICBp
ZiAoZWktPmZsYWdzID09IEFMTE9DX05PX0ZBVF9DSEFJTikgew0KPiArICAgICAgICAgICAgIGlm
IChleGZhdF9jaGVja19kaXNrX2Vycm9yKHNiLT5zX2JkZXYpKSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICBleGZhdF9mc19lcnJvcihzYiwgImRldmljZSBpbmFjY2Vzc2lhYmxlIVxuIik7DQo+
ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNClRoaXMgcGF0Y2ggbG9va3MgdXNl
ZnVsIHdoZW4gdXNpbmcgcmVtb3ZhYmxlIHN0b3JhZ2UgZGV2aWNlcy4NCkJUVywgaW4gY2FzZSBv
ZiAiZWktPmZsYWdzICE9IEFMTE9DX05PX0ZBVF9DSEFJTiIsIFRoZXJlIGNvdWxkIGJlIHRoZSBz
YW1lIHByb2JsZW0gaWYgaXQgY2FuIGJlIGZvdW5kIGZyb20gbHJ1X2NhY2hlLiBTbywgaXQgd291
bGQgYmUgbmljZSB0byBjaGVjayBkaXNrX2Vycm9yIHJlZ2FyZGxlc3MgZWktPmZsYWdzLiBBbHNv
LCBDYWxsaW5nIGV4ZmF0X2ZzX2Vycm9yKCkgc2VlbXMgdW5uZWNlc3NhcnkuIEluc3RlYWQsIGxl
dCdzIHJldHVybiAtRU5PREVWIGluc3RlYWQgb2YgLUVJTy4NCkkgYmVsaWV2ZSB0aGF0IHRoZXNl
IGVycm9ycyB3aWxsIGJlIGhhbmRsZWQgb24gZXhmYXRfZ2V0X2Jsb2NrKCkNCg0KDQpUaGFua3Mu
DQo+ICsgICAgICAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgICAgICAgaWYgKGNsdV9vZmZzZXQg
PiAwICYmICpjbHUgIT0gRVhGQVRfRU9GX0NMVVNURVIpIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgIGxhc3RfY2x1ICs9IGNsdV9vZmZzZXQgLSAxOw0KPg0KPiAtLQ0KPiAyLjI1LjENCg0KDQo=

