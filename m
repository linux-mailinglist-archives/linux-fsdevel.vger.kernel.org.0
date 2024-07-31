Return-Path: <linux-fsdevel+bounces-24652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72718942485
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 04:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672821C212D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EBD12B63;
	Wed, 31 Jul 2024 02:33:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27EDF53;
	Wed, 31 Jul 2024 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393209; cv=none; b=Ah6xNe3iy+wVkDHDVRo8ETNa5NCchwuTjh6z3M7aOhKzN+mszN58whHhaPMI7u8Sc76Y77gv2Dbycqd1uCoZPwZUx/vCH/FWZKgFkYGywdd7j68cp8K0Vj4kjmGvPkXYEXoPjy3EvJ356yWLp0P6qXUiUyPqPojmhwiDJbKupuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393209; c=relaxed/simple;
	bh=nKIgkqWoUDkLrS3Vk2GD47CMoBP+6D2DKbNKVY6PbWk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ry1D7/w4EiFW8HJfUBrpon8ogEKJdI49eRLeVMkTjwS5vDkzIE1wNNLUze1Qvk58NReV7QeIcCIHrOhj1maxOKiSeH7b4WaQe8gf9uDRFhx4q3bHAvfiNdzvolOGlzTM7zngb+98A4Qa30llBUcTg5k+Cbf13E7NQZHbhAfvNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46V2Vo3x077811;
	Wed, 31 Jul 2024 10:31:50 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WYbYf5m0Dz2MPHPW;
	Wed, 31 Jul 2024 10:25:58 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 31 Jul
 2024 10:31:28 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Wed, 31 Jul 2024 10:31:27 +0800
From: =?gb2312?B?tN62q8HBIChEb25nbGlhbmcgQ3VpKQ==?= <Dongliang.Cui@unisoc.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "niuzhiguo84@gmail.com" <niuzhiguo84@gmail.com>,
        =?gb2312?B?zfXwqSAoSGFvX2hhbyBXYW5nKQ==?= <Hao_hao.Wang@unisoc.com>,
        =?gb2312?B?zfW/xiAoS2UgV2FuZyk=?= <Ke.Wang@unisoc.com>,
        =?gb2312?B?xaPWvrn6IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
        "=?gb2312?B?o7tjdWlkb25nbGlhbmczOTBAZ21haWwuY29t?=
	<o"<cuidongliang390@gmail.com>
Subject: Re: [PATCH v3] exfat: check disk status during buffer write
Thread-Topic: [PATCH v3] exfat: check disk status during buffer write
Thread-Index: Adri8ZbtCjWyZ2jhRWGdkfFZhmOLmw==
Date: Wed, 31 Jul 2024 02:31:27 +0000
Message-ID: <036c4601c7684a67b8caedef9917b929@BJMBX02.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 46V2Vo3x077811

TG9vcCBtb3JlDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiC03rarwcEgKERvbmdsaWFu
ZyBDdWkpIDxEb25nbGlhbmcuQ3VpQHVuaXNvYy5jb20+IA0Kt6LLzcqxvOQ6IDIwMjTE6jfUwjMx
yNUgMTA6MjcNCsrVvP7IyzogbGlua2luamVvbkBrZXJuZWwub3JnOyBzajE1NTcuc2VvQHNhbXN1
bmcuY29tOyBoY2hAaW5mcmFkZWFkLm9yZzsgbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCrOty806IG5pdXpoaWd1bzg0QGdtYWlsLmNv
bTsgzfXwqSAoSGFvX2hhbyBXYW5nKSA8SGFvX2hhby5XYW5nQHVuaXNvYy5jb20+OyDN9b/GIChL
ZSBXYW5nKSA8S2UuV2FuZ0B1bmlzb2MuY29tPjsgtN62q8HBIChEb25nbGlhbmcgQ3VpKSA8RG9u
Z2xpYW5nLkN1aUB1bmlzb2MuY29tPjsgxaPWvrn6IChaaGlndW8gTml1KSA8WmhpZ3VvLk5pdUB1
bmlzb2MuY29tPg0K1vfM4jogW1BBVENIIHYzXSBleGZhdDogY2hlY2sgZGlzayBzdGF0dXMgZHVy
aW5nIGJ1ZmZlciB3cml0ZQ0KDQpXZSBmb3VuZCB0aGF0IHdoZW4gd3JpdGluZyBhIGxhcmdlIGZp
bGUgdGhyb3VnaCBidWZmZXIgd3JpdGUsIGlmIHRoZSBkaXNrIGlzIGluYWNjZXNzaWJsZSwgZXhG
QVQgZG9lcyBub3QgcmV0dXJuIGFuIGVycm9yIG5vcm1hbGx5LCB3aGljaCBsZWFkcyB0byB0aGUg
d3JpdGluZyBwcm9jZXNzIG5vdCBzdG9wcGluZyBwcm9wZXJseS4NCg0KVG8gZWFzaWx5IHJlcHJv
ZHVjZSB0aGlzIGlzc3VlLCB5b3UgY2FuIGZvbGxvdyB0aGUgc3RlcHMgYmVsb3c6DQoNCjEuIGZv
cm1hdCBhIGRldmljZSB0byBleEZBVCBhbmQgdGhlbiBtb3VudCAod2l0aCBhIGZ1bGwgZGlzayBl
cmFzZSkgMi4gZGQgaWY9L2Rldi96ZXJvIG9mPS9leGZhdF9tb3VudC90ZXN0LmltZyBicz0xTSBj
b3VudD04MTkyIDMuIGVqZWN0IHRoZSBkZXZpY2UNCg0KWW91IG1heSBmaW5kIHRoYXQgdGhlIGRk
IHByb2Nlc3MgZG9lcyBub3Qgc3RvcCBpbW1lZGlhdGVseSBhbmQgbWF5IGNvbnRpbnVlIGZvciBh
IGxvbmcgdGltZS4NCg0KVGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBpc3N1ZSBpcyB0aGF0IGR1cmlu
ZyBidWZmZXIgd3JpdGUgcHJvY2VzcywgZXhGQVQgZG9lcyBub3QgbmVlZCB0byBhY2Nlc3MgdGhl
IGRpc2sgdG8gbG9vayB1cCBkaXJlY3RvcnkgZW50cmllcyBvciB0aGUgRkFUIHRhYmxlICh3aGVy
ZWFzIEZBVCB3b3VsZCBkbykgZXZlcnkgdGltZSBkYXRhIGlzIHdyaXR0ZW4uDQpJbnN0ZWFkLCBl
eEZBVCBzaW1wbHkgbWFya3MgdGhlIGJ1ZmZlciBhcyBkaXJ0eSBhbmQgcmV0dXJucywgZGVsZWdh
dGluZyB0aGUgd3JpdGViYWNrIG9wZXJhdGlvbiB0byB0aGUgd3JpdGViYWNrIHByb2Nlc3MuDQoN
CklmIHRoZSBkaXNrIGNhbm5vdCBiZSBhY2Nlc3NlZCBhdCB0aGlzIHRpbWUsIHRoZSBlcnJvciB3
aWxsIG9ubHkgYmUgcmV0dXJuZWQgdG8gdGhlIHdyaXRlYmFjayBwcm9jZXNzLCBhbmQgdGhlIG9y
aWdpbmFsIHByb2Nlc3Mgd2lsbCBub3QgcmVjZWl2ZSB0aGUgZXJyb3IsIHNvIGl0IGNhbm5vdCBi
ZSByZXR1cm5lZCB0byB0aGUgdXNlciBzaWRlLg0KDQpXaGVuIHRoZSBkaXNrIGNhbm5vdCBiZSBh
Y2Nlc3NlZCBub3JtYWxseSwgYW4gZXJyb3Igc2hvdWxkIGJlIHJldHVybmVkIHRvIHN0b3AgdGhl
IHdyaXRpbmcgcHJvY2Vzcy4NCg0KU2lnbmVkLW9mZi1ieTogRG9uZ2xpYW5nIEN1aSA8ZG9uZ2xp
YW5nLmN1aUB1bmlzb2MuY29tPg0KU2lnbmVkLW9mZi1ieTogWmhpZ3VvIE5pdSA8emhpZ3VvLm5p
dUB1bmlzb2MuY29tPg0KLS0tDQpDaGFuZ2VzIGluIHYzOg0KIC0gSW1wbGVtZW50IC5zaHV0ZG93
biB0byBtb25pdG9yIGRpc2sgc3RhdHVzLg0KLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8IDEw
ICsrKysrKysrKysNCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgIDMgKysrDQogZnMvZXhmYXQvc3Vw
ZXIuYyAgICB8IDExICsrKysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRf
ZnMuaCBpbmRleCBlY2M1ZGI5NTJkZWIuLmM2Y2YzNjA3MGFhMyAxMDA2NDQNCi0tLSBhL2ZzL2V4
ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC0xNDgsNiArMTQ4
LDkgQEAgZW51bSB7DQogI2RlZmluZSBESVJfQ0FDSEVfU0laRQkJXA0KIAkoRElWX1JPVU5EX1VQ
KEVYRkFUX0RFTl9UT19CKEVTX01BWF9FTlRSWV9OVU0pLCBTRUNUT1JfU0laRSkgKyAxKQ0KIA0K
Ky8qIFN1cGVyYmxvY2sgZmxhZ3MgKi8NCisjZGVmaW5lIEVYRkFUX0ZMQUdTX1NIVVRET1dOCTEN
CisNCiBzdHJ1Y3QgZXhmYXRfZGVudHJ5X25hbWVidWYgew0KIAljaGFyICpsZm47DQogCWludCBs
Zm5idWZfbGVuOyAvKiB1c3VhbGx5IE1BWF9VTklOQU1FX0JVRl9TSVpFICovIEBAIC0yNjcsNiAr
MjcwLDggQEAgc3RydWN0IGV4ZmF0X3NiX2luZm8gew0KIAl1bnNpZ25lZCBpbnQgY2x1X3NyY2hf
cHRyOyAvKiBjbHVzdGVyIHNlYXJjaCBwb2ludGVyICovDQogCXVuc2lnbmVkIGludCB1c2VkX2Ns
dXN0ZXJzOyAvKiBudW1iZXIgb2YgdXNlZCBjbHVzdGVycyAqLw0KIA0KKwl1bnNpZ25lZCBsb25n
IHNfZXhmYXRfZmxhZ3M7IC8qIEV4ZmF0IHN1cGVyYmxvY2sgZmxhZ3MgKi8NCisNCiAJc3RydWN0
IG11dGV4IHNfbG9jazsgLyogc3VwZXJibG9jayBsb2NrICovDQogCXN0cnVjdCBtdXRleCBiaXRt
YXBfbG9jazsgLyogYml0bWFwIGxvY2sgKi8NCiAJc3RydWN0IGV4ZmF0X21vdW50X29wdGlvbnMg
b3B0aW9uczsNCkBAIC0zMzgsNiArMzQzLDExIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGV4ZmF0
X2lub2RlX2luZm8gKkVYRkFUX0koc3RydWN0IGlub2RlICppbm9kZSkNCiAJcmV0dXJuIGNvbnRh
aW5lcl9vZihpbm9kZSwgc3RydWN0IGV4ZmF0X2lub2RlX2luZm8sIHZmc19pbm9kZSk7ICB9DQog
DQorc3RhdGljIGlubGluZSBpbnQgZXhmYXRfZm9yY2VkX3NodXRkb3duKHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IpIHsNCisJcmV0dXJuIHRlc3RfYml0KEVYRkFUX0ZMQUdTX1NIVVRET1dOLCAmRVhG
QVRfU0Ioc2IpLT5zX2V4ZmF0X2ZsYWdzKTsgfQ0KKw0KIC8qDQogICogSWYgLT5pX21vZGUgY2Fu
J3QgaG9sZCAwMjIyIChpLmUuIEFUVFJfUk8pLCB3ZSB1c2UgLT5pX2F0dHJzIHRvDQogICogc2F2
ZSBBVFRSX1JPIGluc3RlYWQgb2YgLT5pX21vZGUuDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvaW5v
ZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMgaW5kZXggZGQ4OTRlNTU4YzkxLi5iMWI4MTQxODM0OTQg
MTAwNjQ0DQotLS0gYS9mcy9leGZhdC9pbm9kZS5jDQorKysgYi9mcy9leGZhdC9pbm9kZS5jDQpA
QCAtNDUyLDYgKzQ1Miw5IEBAIHN0YXRpYyBpbnQgZXhmYXRfd3JpdGVfYmVnaW4oc3RydWN0IGZp
bGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCAgew0KIAlpbnQgcmV0Ow0K
IA0KKwlpZiAodW5saWtlbHkoZXhmYXRfZm9yY2VkX3NodXRkb3duKG1hcHBpbmctPmhvc3QtPmlf
c2IpKSkNCisJCXJldHVybiAtRUlPOw0KKw0KIAkqcGFnZXAgPSBOVUxMOw0KIAlyZXQgPSBibG9j
a193cml0ZV9iZWdpbihtYXBwaW5nLCBwb3MsIGxlbiwgcGFnZXAsIGV4ZmF0X2dldF9ibG9jayk7
DQogDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvc3VwZXIuYyBiL2ZzL2V4ZmF0L3N1cGVyLmMgaW5k
ZXggMzIzZWNlYmU2ZjBlLi45ZDdkOWM0YmE1NWEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9zdXBl
ci5jDQorKysgYi9mcy9leGZhdC9zdXBlci5jDQpAQCAtMTY3LDYgKzE2NywxNiBAQCBzdGF0aWMg
aW50IGV4ZmF0X3Nob3dfb3B0aW9ucyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCBkZW50cnkg
KnJvb3QpDQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0aWMgdm9pZCBleGZhdF9zaHV0ZG93bihz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKSB7DQorCXN0cnVjdCBleGZhdF9zYl9pbmZvICpzYmkgPSBF
WEZBVF9TQihzYik7DQorDQorCWlmIChleGZhdF9mb3JjZWRfc2h1dGRvd24oc2IpKQ0KKwkJcmV0
dXJuOw0KKw0KKwlzZXRfYml0KEVYRkFUX0ZMQUdTX1NIVVRET1dOLCAmc2JpLT5zX2V4ZmF0X2Zs
YWdzKTsgfQ0KKw0KIHN0YXRpYyBzdHJ1Y3QgaW5vZGUgKmV4ZmF0X2FsbG9jX2lub2RlKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpICB7DQogCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaTsNCkBA
IC0xOTMsNiArMjAzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzdXBlcl9vcGVyYXRpb25zIGV4
ZmF0X3NvcHMgPSB7DQogCS5zeW5jX2ZzCT0gZXhmYXRfc3luY19mcywNCiAJLnN0YXRmcwkJPSBl
eGZhdF9zdGF0ZnMsDQogCS5zaG93X29wdGlvbnMJPSBleGZhdF9zaG93X29wdGlvbnMsDQorCS5z
aHV0ZG93bgk9IGV4ZmF0X3NodXRkb3duLA0KIH07DQogDQogZW51bSB7DQotLQ0KMi4yNS4xDQoN
Cg==

