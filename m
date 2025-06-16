Return-Path: <linux-fsdevel+bounces-51723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0000ADABAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95564171240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA4273805;
	Mon, 16 Jun 2025 09:22:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993874A33;
	Mon, 16 Jun 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065753; cv=none; b=dITGGBEFByWs2w79Uvdl8GqE6FyiQpmEha91EqIqK7/3Gl9r0XPXeBJgu2C9IBdvXrbMv/Sny5xoAoqtGS+Z2KYBS6u+sEt9eOnMr9Iar8m9xVsRFONkF4Xv4PtroDDdg7BSZzsdol/0hjiXrAS+fhW2WA5XhcEc4A6zn94yEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065753; c=relaxed/simple;
	bh=sj0mm9m1O/8U8lkwTNwKNR/K+6FyXlt+/zWXc6yk2UM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9IQYM5vM4iXjgVpfRs/oypLpNRiO1CI0/xAubPoj5dmBjFJWGfGkI+sH6ibXjksqXNzvTz46IOw9kJpY/t4299hP2Dajh5X4uXdI+3ndRFkYbz7NpQ1NlegjzHkYiU/j63MV4NOfcMS2oaBfGpkcXqRjsjbRG63lk6zWk/Exv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 55G9LOLC071378;
	Mon, 16 Jun 2025 17:21:24 +0800 (+08)
	(envelope-from Zhengxu.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4bLPYW2Cy6z2P49JG;
	Mon, 16 Jun 2025 17:18:07 +0800 (CST)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Jun
 2025 17:21:23 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.048; Mon, 16 Jun 2025 17:21:22 +0800
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
        =?utf-8?B?5byg5pS/5petIChaaGVuZ3h1IFpoYW5nKQ==?= <Zhengxu.Zhang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiBmZGF0YXN5bmMgZmxhZyBzaG91bGQg?=
 =?utf-8?B?YmUgc2FtZSBsaWtlIGdlbmVyaWNfd3JpdGVfc3luYygp?=
Thread-Topic: [PATCH] exfat: fdatasync flag should be same like
 generic_write_sync()
Thread-Index: AQHb3CvF3g+Nw35RCU+Et+rOGeRoJrQA2ySngASsErA=
Date: Mon, 16 Jun 2025 09:21:22 +0000
Message-ID: <ebba6e12af06486cafa5e16a284b7d7e@BJMBX01.spreadtrum.com>
References: <20250613062339.27763-1-cixi.geng@linux.dev>
 <PUZPR04MB6316E8048064CB15DACDDE1B8177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316E8048064CB15DACDDE1B8177A@PUZPR04MB6316.apcprd04.prod.outlook.com>
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
X-MAIL:SHSQR01.spreadtrum.com 55G9LOLC071378

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFl1ZXpoYW5nLk1vQHNv
bnkuY29tIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0Nuac
iDEz5pelIDE4OjE0DQo+IOaUtuS7tuS6ujogQ2l4aSBHZW5nIDxjaXhpLmdlbmdAbGludXguZGV2
PjsgbGlua2luamVvbkBrZXJuZWwub3JnOw0KPiBzajE1NTcuc2VvQHNhbXN1bmcuY29tDQo+IOaK
hOmAgTogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IOW8oOaUv+aXrQ0KPiAoWmhlbmd4dSBaaGFuZykgPFpoZW5neHUuWmhhbmdAdW5p
c29jLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIXSBleGZhdDogZmRhdGFzeW5jIGZsYWcgc2hv
dWxkIGJlIHNhbWUgbGlrZSBnZW5lcmljX3dyaXRlX3N5bmMoKQ0KPiANCj4gDQo+IA0KPiA+IGdl
bmVyaWNfZmlsZV93cml0ZV9pdGVyKCksIHdoZW4gY2FsbGluZyBnZW5lcmljX3JpdGVfc3luYygp
IGFuZA0KPiANCj4gcy9fcml0ZS9fd3JpdGUNCj4NCkkgd2lsbCBmaXggdGhpcyBieSBuZXh0IHBh
dGNoLg0KPiA+IC0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0KPiA+ICsrKyBiL2ZzL2V4ZmF0L2ZpbGUu
Yw0KPiA+IEBAIC02MjUsNyArNjI1LDcgQEAgc3RhdGljIHNzaXplX3QgZXhmYXRfZmlsZV93cml0
ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwNCj4gc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KPiA+
DQo+ID4gICAgICAgIGlmIChpb2NiX2lzX2RzeW5jKGlvY2IpICYmIGlvY2ItPmtpX3BvcyA+IHBv
cykgew0KPiA+ICAgICAgICAgICAgICAgICBzc2l6ZV90IGVyciA9IHZmc19mc3luY19yYW5nZShm
aWxlLCBwb3MsIGlvY2ItPmtpX3BvcyAtIDEsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpb2NiLT5raV9mbGFncyAmIElPQ0JfU1lOQyk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoaW9jYi0+a2lfZmxhZ3MgJiBJT0NCX1NZTkMpID8gMCA6IDEpOw0K
PiANCj4gSG93IGFib3V0IGNhbGxpbmcgZ2VuZXJpY193cml0ZV9zeW5jKCkgaW5zdGVhZCBvZiB2
ZnNfZnN5bmNfcmFuZ2UoKSwgbGlrZSBpbg0KPiBnZW5lcmljX2ZpbGVfd3JpdGVfaXRlcigpPw0K
VGhlIHNlY29uZCBhcmcgb2YgdmZzX2ZzeW5jX3JhbmdlICJwb3MiIG1heWJlIGNoYW5nZWQgYnkg
dmFsaWRfc2l6ZSAoaWYgcG9zID4gdmFsaWRfc2l6ZSkuIA0KSXQgY2FuIG5vdCByZXBsYWNlIGJ5
IGlvY2ItPmtpX3BvcyAtIHJldCAocmV0IGJ5IF9fZ2VuZXJpY19maWxlX3dyaXRlX2l0ZXIpLg0K
U28gY3VycmVudCB3YXkgbWF5YmUgYmV0dGVyLg0K

