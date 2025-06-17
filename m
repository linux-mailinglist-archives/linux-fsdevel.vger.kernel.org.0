Return-Path: <linux-fsdevel+bounces-51870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB347ADC748
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A0D179FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 09:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AFB2C030A;
	Tue, 17 Jun 2025 09:54:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10897217F36;
	Tue, 17 Jun 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154087; cv=none; b=he/WjdwLh+KlsiGtQC25WOQEnojiVDH97NLAmFLdC9TWbmXDLZv5KEpJZS2TdCNceOlz1b/IbhxeQ4eCPA/xzMnvxHecQpUMKz8H3G1QhjLXqoLL+8BmwNkdD0ELnZtM3DqF3HaCHJKsubTMkp8q9n3ZGNnNmW6tTa1GwrajoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154087; c=relaxed/simple;
	bh=0pYRtcQ2OP53TQTX5Yrhd/Gw6Y+wOtAA4iwokvmliE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ka89GmJrPnSE7UdvBDfmj/wkl496jl/9es9y7B/Cn5cgUK7CQ7G/1kRR7IvRU4v36ZtyVKvpd9gNUaYqBJKp8s98EIt90SSm4Q9WYer42iapUMzLqBd7/is7s5tkaO3TjAdpyvEwQgTfUC88AzXob0qFviYP2VHUW8FQIwEI6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 55H9rxR3099920;
	Tue, 17 Jun 2025 17:53:59 +0800 (+08)
	(envelope-from Zhengxu.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bM2Dc1Tt1z2PB1Ft;
	Tue, 17 Jun 2025 17:50:40 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 17 Jun
 2025 17:53:57 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.048; Tue, 17 Jun 2025 17:53:57 +0800
From: =?utf-8?B?5byg5pS/5petIChaaGVuZ3h1IFpoYW5nKQ==?=
	<Zhengxu.Zhang@unisoc.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        Cixi Geng
	<cixi.geng@linux.dev>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiBmZGF0YXN5bmMgZmxhZyBzaG91bGQg?=
 =?utf-8?B?YmUgc2FtZSBsaWtlIGdlbmVyaWNfd3JpdGVfc3luYygp?=
Thread-Topic: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Index: AQHb3CvF3g+Nw35RCU+Et+rOGeRoJrQA2ySngASsErCAAKsRAIAA7MsA
Date: Tue, 17 Jun 2025 09:53:57 +0000
Message-ID: <52218ac9664b406d897ca3c0bd0bef5e@BJMBX01.spreadtrum.com>
References: <20250613062339.27763-1-cixi.geng@linux.dev>
 <PUZPR04MB6316E8048064CB15DACDDE1B8177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ebba6e12af06486cafa5e16a284b7d7e@BJMBX01.spreadtrum.com>
 <PUZPR04MB6316B91DB1F5E14578C65C0A8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316B91DB1F5E14578C65C0A8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
X-MAIL:SHSQR01.spreadtrum.com 55H9rxR3099920

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFl1ZXpoYW5nLk1vQHNv
bnkuY29tIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0Nuac
iDE35pelIDExOjMyDQo+IOaUtuS7tuS6ujog5byg5pS/5petIChaaGVuZ3h1IFpoYW5nKSA8Wmhl
bmd4dS5aaGFuZ0B1bmlzb2MuY29tPjsgQ2l4aSBHZW5nDQo+IDxjaXhpLmdlbmdAbGludXguZGV2
PjsgbGlua2luamVvbkBrZXJuZWwub3JnOyBzajE1NTcuc2VvQHNhbXN1bmcuY29tDQo+IOaKhOmA
gTogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IOeOi+eakyAoSGFvX2hhbw0KPiBXYW5nKSA8SGFvX2hhby5XYW5nQHVuaXNvYy5jb20+
DQo+IOS4u+mimDogUmU6IFtQQVRDSF0gZXhmYXQ6IGZkYXRhc3luYyBmbGFnIHNob3VsZCBiZSBz
YW1lIGxpa2UgZ2VuZXJpY193cml0ZV9zeW5jKCkNCj4gDQo+IA0KPiANCj4gPiA+ID4gLS0tIGEv
ZnMvZXhmYXQvZmlsZS5jDQo+ID4gPiA+ICsrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KPiA+ID4gPiBA
QCAtNjI1LDcgKzYyNSw3IEBAIHN0YXRpYyBzc2l6ZV90IGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcihz
dHJ1Y3Qga2lvY2IgKmlvY2IsDQo+ID4gPiA+IHN0cnVjdCBpb3ZfaXRlciAqaXRlcikNCj4gPiA+
ID4NCj4gPiA+ID4gICAgICAgIGlmIChpb2NiX2lzX2RzeW5jKGlvY2IpICYmIGlvY2ItPmtpX3Bv
cyA+IHBvcykgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgc3NpemVfdCBlcnIgPSB2ZnNfZnN5
bmNfcmFuZ2UoZmlsZSwgcG9zLCBpb2NiLT5raV9wb3MgLSAxLA0KPiA+ID4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlvY2ItPmtpX2ZsYWdzICYgSU9DQl9TWU5DKTsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoaW9jYi0+a2lfZmxhZ3MgJiBJT0NC
X1NZTkMpID8gMCA6IDEpOw0KPiA+ID4NCj4gPiA+IEhvdyBhYm91dCBjYWxsaW5nIGdlbmVyaWNf
d3JpdGVfc3luYygpIGluc3RlYWQgb2YgdmZzX2ZzeW5jX3JhbmdlKCksIGxpa2UgaW4NCj4gPiA+
IGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyKCk/DQo+ID4gVGhlIHNlY29uZCBhcmcgb2YgdmZzX2Zz
eW5jX3JhbmdlICJwb3MiIG1heWJlIGNoYW5nZWQgYnkgdmFsaWRfc2l6ZSAoaWYgcG9zID4NCj4g
dmFsaWRfc2l6ZSkuDQo+ID4gSXQgY2FuIG5vdCByZXBsYWNlIGJ5IGlvY2ItPmtpX3BvcyAtIHJl
dCAocmV0IGJ5IF9fZ2VuZXJpY19maWxlX3dyaXRlX2l0ZXIpLg0KPiA+IFNvIGN1cnJlbnQgd2F5
IG1heWJlIGJldHRlci4NCj4gDQo+IEhlcmUgd2Ugc3luY2hyb25pemUgdGhlIGFyZWFzIHdyaXR0
ZW4gYnkgZXhmYXRfZXh0ZW5kX3ZhbGlkX3NpemUoKSBhbmQNCj4gX19nZW5lcmljX2ZpbGVfd3Jp
dGVfaXRlcigpIGlmIHZhbGlkX3NpemUgPCBwb3MuDQo+IA0KPiBUaGUgbGVuZ3RocyBvZiB0aGVz
ZSB0d28gd3JpdGUgYXJlYXMgYXJlICdwb3MtdmFsaWRfc2l6ZScgYW5kICdyZXQnLg0KPiBXZSBj
YW4gdXNlIGdlbmVyaWNfd3JpdGVfc3luYygpIGFuZCBwYXNzIGl0IHRoZSBzdW0gb2YgdGhlc2Ug
dHdvIGxlbmd0aHMuDQo+IO+7vw0KPiBPZiBjb3Vyc2UsIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB2
YWxpZF9zaXplIDwgcG9zLCBleGZhdF9maWxlX3dyaXRlX2l0ZXIoKSBvbmx5DQo+IG5lZWRzIHRv
IHJldHVybiB0aGUgbGVuZ3RoIHdyaXR0ZW4gYnkgX19nZW5lcmljX2ZpbGVfd3JpdGVfaXRlcigp
Lg0KDQpJIHRyeSB0aGUgc3VtIG9mICdwb3MtdmFsaWRfc2l6ZScgYW5kICdyZXQnLGxpa2UgdGhp
czoNCiAgICAgICAgaWYgKGlvY2ItPmtpX3BvcyA+IHBvcykgew0KICAgICAgICAgICAgICAgIHNz
aXplX3QgZXJyID0gZ2VuZXJpY193cml0ZV9zeW5jKGlvY2IsIHBvcyArIHJldCAtIHZhbGlkX3Np
emUpOw0KICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQ0KICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGVycjsNCiAgICAgICAgfQ0KVGhlIHRlc3QgY3Jhc2hlZCwgdGhhdCBtYXliZSBp
byBlcnJvci4gDQpTbyBJIHRyeSBhIHNpbXBsZSB3YXkgdGhhdCB1c2UgaW9jYi0+a2lfcG9zIC0g
cG9zLiBsaWtlIHRoaXM6DQogICAgICAgIGlmIChpb2NiLT5raV9wb3MgPiBwb3MpIHsNCiAgICAg
ICAgICAgICAgICBzc2l6ZV90IGVyciA9IGdlbmVyaWNfd3JpdGVfc3luYyhpb2NiLCBpb2NiLT5r
aV9wb3MgLSBwb3MpOw0KICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsNCiAgICAgICAgfQ0KVGhlIHRlc3QgcGFzcy4gcGxzIGNo
ZWNrIGFnYWluLg0K

