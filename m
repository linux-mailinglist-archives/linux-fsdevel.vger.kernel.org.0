Return-Path: <linux-fsdevel+bounces-29640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3197BCBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56BA284543
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0018A6AB;
	Wed, 18 Sep 2024 13:05:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8585187FE6;
	Wed, 18 Sep 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664736; cv=none; b=nhLeBfBvpPV8IbUt5uGnlzycn4BAAve+bc9g++lMBV1zhp8hBBHaWoBRk2FpCcVCl97qLp3LJQeSBKc03BnWllBkrYlRgp/qFRdmjCxaJMaJcEyp5TAJ49bQzPk6Hq1+Ua6Ka0QklY8uDEejgiNMjIRK5KmQw+ZqtTiedFIsRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664736; c=relaxed/simple;
	bh=afX4bkpPEcf8jyT8KIj1mim62akw0BvMOjBFscO0oxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIjgpLB6ZGm41xlxXJUOYfShRri2bJMd+X6LP1d+peSeJD6woCZ2fJ2rtTOz4Py6ATj1og92RKm3907FjwkRTD8MRrH7eRHSx18A6u8XEfsqtZ5MNbFZHsEehytkjQAXqonSbu5Knc+zgeZfFR5/CsRKEaNsFuWODXZCwBUhZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 4+WXDfC1T5eqhrCrZUvxPA==
X-CSE-MsgGUID: rdQq/ww4TyqOpKT4uhEetA==
X-IronPort-AV: E=Sophos;i="6.10,238,1719849600"; 
   d="scan'208";a="96676329"
From: Huang Jianan <huangjianan@xiaomi.com>
To: Yiyang Wu <toolmanp@tlmp.cc>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Subject: Re: [External Mail][RFC PATCH 05/24] erofs: add inode data structure
 in Rust
Thread-Topic: [External Mail][RFC PATCH 05/24] erofs: add inode data structure
 in Rust
Thread-Index: AQHbCEBKRNg1ub5CFEOhxt8swuAy2bJc/+0A
Date: Wed, 18 Sep 2024 13:04:21 +0000
Message-ID: <753cd249-e90e-4473-a576-dc0cc44eae34@xiaomi.com>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-6-toolmanp@tlmp.cc>
In-Reply-To: <20240916135634.98554-6-toolmanp@tlmp.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <649DA2524C3D524FAFEAEF2005E05E5D@xiaomi.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMjAyNC85LzE2IDIxOjU2LCBZaXlhbmcgV3UgdmlhIExpbnV4LWVyb2ZzIHdyb3RlOg0KPiAN
Cj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBzYW1lIG9uLWRpc2sgZXJvZnMgZGF0YSBzdHJ1
Y3R1cmUNCj4gaW4gcnVzdCBhbmQgYWxzbyBpbnRyb2R1Y2VzIG11bHRpcGxlIGhlbHBlcnMgZm9y
IGlub2RlIGlfZm9ybWF0DQo+IGFuZCBjaHVua19pbmRleGluZyBhbmQgbGF0ZXIgY2FuIGJlIHVz
ZWQgdG8gaW1wbGVtZW50IG1hcF9ibG9ja3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZaXlhbmcg
V3UgPHRvb2xtYW5wQHRsbXAuY2M+DQo+IC0tLQ0KPiAgIGZzL2Vyb2ZzL3J1c3QvZXJvZnNfc3lz
LnJzICAgICAgIHwgICAxICsNCj4gICBmcy9lcm9mcy9ydXN0L2Vyb2ZzX3N5cy9pbm9kZS5ycyB8
IDI5MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAyOTIgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9lcm9mcy9ydXN0
L2Vyb2ZzX3N5cy9pbm9kZS5ycw0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Vyb2ZzL3J1c3QvZXJv
ZnNfc3lzLnJzIGIvZnMvZXJvZnMvcnVzdC9lcm9mc19zeXMucnMNCj4gaW5kZXggNmYzYzEyNjY1
ZWQ2Li4zNDI2N2VjNzc3MmQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2Vyb2ZzL3J1c3QvZXJvZnNfc3lz
LnJzDQo+ICsrKyBiL2ZzL2Vyb2ZzL3J1c3QvZXJvZnNfc3lzLnJzDQo+IEBAIC0yNCw2ICsyNCw3
IEBADQo+ICAgcHViKGNyYXRlKSB0eXBlIFBvc2l4UmVzdWx0PFQ+ID0gUmVzdWx0PFQsIEVycm5v
PjsNCj4gDQo+ICAgcHViKGNyYXRlKSBtb2QgZXJybm9zOw0KPiArcHViKGNyYXRlKSBtb2QgaW5v
ZGU7DQo+ICAgcHViKGNyYXRlKSBtb2Qgc3VwZXJibG9jazsNCj4gICBwdWIoY3JhdGUpIG1vZCB4
YXR0cnM7DQo+ICAgcHViKGNyYXRlKSB1c2UgZXJybm9zOjpFcnJubzsNCj4gZGlmZiAtLWdpdCBh
L2ZzL2Vyb2ZzL3J1c3QvZXJvZnNfc3lzL2lub2RlLnJzIGIvZnMvZXJvZnMvcnVzdC9lcm9mc19z
eXMvaW5vZGUucnMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li4xNzYyMDIzZTk3ZjgNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9mcy9lcm9mcy9ydXN0L2Vy
b2ZzX3N5cy9pbm9kZS5ycw0KPiBAQCAtMCwwICsxLDI5MSBAQA0KPiArdXNlIHN1cGVyOjp4YXR0
cnM6Oio7DQo+ICt1c2Ugc3VwZXI6Oio7DQo+ICt1c2UgY29yZTo6ZmZpOjoqOw0KPiArdXNlIGNv
cmU6Om1lbTo6c2l6ZV9vZjsNCj4gKw0KPiArLy8vIFJlcHJlc2VudHMgdGhlIGNvbXBhY3QgYml0
ZmllbGQgb2YgdGhlIEVyb2ZzIElub2RlIGZvcm1hdC4NCj4gKyNbcmVwcih0cmFuc3BhcmVudCld
DQo+ICsjW2Rlcml2ZShDbG9uZSwgQ29weSldDQo+ICtwdWIoY3JhdGUpIHN0cnVjdCBGb3JtYXQo
dTE2KTsNCj4gKw0KPiArcHViKGNyYXRlKSBjb25zdCBJTk9ERV9WRVJTSU9OX01BU0s6IHUxNiA9
IDB4MTsNCj4gK3B1YihjcmF0ZSkgY29uc3QgSU5PREVfVkVSU0lPTl9CSVQ6IHUxNiA9IDA7DQo+
ICsNCj4gK3B1YihjcmF0ZSkgY29uc3QgSU5PREVfTEFZT1VUX0JJVDogdTE2ID0gMTsNCj4gK3B1
YihjcmF0ZSkgY29uc3QgSU5PREVfTEFZT1VUX01BU0s6IHUxNiA9IDB4NzsNCj4gKw0KPiArLy8v
IEhlbHBlciBtYWNybyB0byBleHRyYWN0IHByb3BlcnR5IGZyb20gdGhlIGJpdGZpZWxkLg0KPiAr
bWFjcm9fcnVsZXMhIGV4dHJhY3Qgew0KPiArICAgICgkbmFtZTogZXhwciwgJGJpdDogZXhwciwg
JG1hc2s6IGV4cHIpID0+IHsNCj4gKyAgICAgICAgKCRuYW1lID4+ICRiaXQpICYgKCRtYXNrKQ0K
PiArICAgIH07DQo+ICt9DQo+ICsNCj4gKy8vLyBUaGUgVmVyc2lvbiBvZiB0aGUgSW5vZGUgd2hp
Y2ggcmVwcmVzZW50cyB3aGV0aGVyIHRoaXMgaW5vZGUgaXMgZXh0ZW5kZWQgb3IgY29tcGFjdC4N
Cj4gKy8vLyBFeHRlbmRlZCBpbm9kZXMgaGF2ZSBtb3JlIGluZm9zIGFib3V0IG5saW5rcyArIG10
aW1lLg0KPiArLy8vIFRoaXMgaXMgZG9jdW1lbnRlZCBpbiBodHRwczovL2Vyb2ZzLmRvY3Mua2Vy
bmVsLm9yZy9lbi9sYXRlc3QvY29yZV9vbmRpc2suaHRtbCNpbm9kZXMNCj4gKyNbcmVwcihDKV0N
Cj4gKyNbZGVyaXZlKENsb25lLCBDb3B5KV0NCj4gK3B1YihjcmF0ZSkgZW51bSBWZXJzaW9uIHsN
Cj4gKyAgICBDb21wYXQsDQo+ICsgICAgRXh0ZW5kZWQsDQo+ICsgICAgVW5rbm93biwNCj4gK30N
Cj4gKw0KPiArLy8vIFJlcHJlc2VudHMgdGhlIGRhdGEgbGF5b3V0IGJhY2tlZCBieSB0aGUgSW5v
ZGUuDQo+ICsvLy8gQXMgRG9jdW1lbnRlZCBpbiBodHRwczovL2Vyb2ZzLmRvY3Mua2VybmVsLm9y
Zy9lbi9sYXRlc3QvY29yZV9vbmRpc2suaHRtbCNpbm9kZS1kYXRhLWxheW91dHMNCj4gKyNbcmVw
cihDKV0NCj4gKyNbZGVyaXZlKENsb25lLCBDb3B5LCBQYXJ0aWFsRXEpXQ0KPiArcHViKGNyYXRl
KSBlbnVtIExheW91dCB7DQo+ICsgICAgRmxhdFBsYWluLA0KPiArICAgIENvbXByZXNzZWRGdWxs
LA0KPiArICAgIEZsYXRJbmxpbmUsDQo+ICsgICAgQ29tcHJlc3NlZENvbXBhY3QsDQo+ICsgICAg
Q2h1bmssDQo+ICsgICAgVW5rbm93biwNCj4gK30NCj4gKw0KPiArI1tyZXByKEMpXQ0KPiArI1th
bGxvdyhub25fY2FtZWxfY2FzZV90eXBlcyldDQo+ICsjW2Rlcml2ZShDbG9uZSwgQ29weSwgRGVi
dWcsIFBhcnRpYWxFcSldDQo+ICtwdWIoY3JhdGUpIGVudW0gVHlwZSB7DQo+ICsgICAgUmVndWxh
ciwNCj4gKyAgICBEaXJlY3RvcnksDQo+ICsgICAgTGluaywNCj4gKyAgICBDaGFyYWN0ZXIsDQo+
ICsgICAgQmxvY2ssDQo+ICsgICAgRmlmbywNCj4gKyAgICBTb2NrZXQsDQo+ICsgICAgVW5rbm93
biwNCj4gK30NCj4gKw0KPiArLy8vIFRoaXMgaXMgZm9ybWF0IGV4dHJhY3RlZCBmcm9tIGlfZm9y
bWF0IGJpdCByZXByZXNlbnRhdGlvbi4NCj4gKy8vLyBUaGlzIGluY2x1ZGVzIHZhcmlvdXMgaW5m
b3MgYW5kIHNwZWNzIGFib3V0IHRoZSBpbm9kZS4NCj4gK2ltcGwgRm9ybWF0IHsNCj4gKyAgICBw
dWIoY3JhdGUpIGZuIHZlcnNpb24oJnNlbGYpIC0+IFZlcnNpb24gew0KPiArICAgICAgICBtYXRj
aCBleHRyYWN0IShzZWxmLjAsIElOT0RFX1ZFUlNJT05fQklULCBJTk9ERV9WRVJTSU9OX01BU0sp
IHsNCj4gKyAgICAgICAgICAgIDAgPT4gVmVyc2lvbjo6Q29tcGF0LA0KPiArICAgICAgICAgICAg
MSA9PiBWZXJzaW9uOjpFeHRlbmRlZCwNCj4gKyAgICAgICAgICAgIF8gPT4gVmVyc2lvbjo6VW5r
bm93biwNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAgIHB1YihjcmF0ZSkgZm4g
bGF5b3V0KCZzZWxmKSAtPiBMYXlvdXQgew0KPiArICAgICAgICBtYXRjaCBleHRyYWN0IShzZWxm
LjAsIElOT0RFX0xBWU9VVF9CSVQsIElOT0RFX0xBWU9VVF9NQVNLKSB7DQo+ICsgICAgICAgICAg
ICAwID0+IExheW91dDo6RmxhdFBsYWluLA0KPiArICAgICAgICAgICAgMSA9PiBMYXlvdXQ6OkNv
bXByZXNzZWRGdWxsLA0KPiArICAgICAgICAgICAgMiA9PiBMYXlvdXQ6OkZsYXRJbmxpbmUsDQo+
ICsgICAgICAgICAgICAzID0+IExheW91dDo6Q29tcHJlc3NlZENvbXBhY3QsDQo+ICsgICAgICAg
ICAgICA0ID0+IExheW91dDo6Q2h1bmssDQo+ICsgICAgICAgICAgICBfID0+IExheW91dDo6VW5r
bm93biwNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gK30NCj4gKw0KPiArLy8vIFJlcHJlc2Vu
dHMgdGhlIGNvbXBhY3QgaW5vZGUgd2hpY2ggcmVzaWRlcyBvbi1kaXNrLg0KPiArLy8vIFRoaXMg
aXMgZG9jdW1lbnRlZCBpbiBodHRwczovL2Vyb2ZzLmRvY3Mua2VybmVsLm9yZy9lbi9sYXRlc3Qv
Y29yZV9vbmRpc2suaHRtbCNpbm9kZXMNCj4gKyNbcmVwcihDKV0NCj4gKyNbZGVyaXZlKENsb25l
LCBDb3B5KV0NCj4gK3B1YihjcmF0ZSkgc3RydWN0IENvbXBhY3RJbm9kZUluZm8gew0KPiArICAg
IHB1YihjcmF0ZSkgaV9mb3JtYXQ6IEZvcm1hdCwNCj4gKyAgICBwdWIoY3JhdGUpIGlfeGF0dHJf
aWNvdW50OiB1MTYsDQo+ICsgICAgcHViKGNyYXRlKSBpX21vZGU6IHUxNiwNCj4gKyAgICBwdWIo
Y3JhdGUpIGlfbmxpbms6IHUxNiwNCj4gKyAgICBwdWIoY3JhdGUpIGlfc2l6ZTogdTMyLA0KPiAr
ICAgIHB1YihjcmF0ZSkgaV9yZXNlcnZlZDogW3U4OyA0XSwNCj4gKyAgICBwdWIoY3JhdGUpIGlf
dTogW3U4OyA0XSwNCj4gKyAgICBwdWIoY3JhdGUpIGlfaW5vOiB1MzIsDQo+ICsgICAgcHViKGNy
YXRlKSBpX3VpZDogdTE2LA0KPiArICAgIHB1YihjcmF0ZSkgaV9naWQ6IHUxNiwNCj4gKyAgICBw
dWIoY3JhdGUpIGlfcmVzZXJ2ZWQyOiBbdTg7IDRdLA0KPiArfQ0KPiArDQo+ICsvLy8gUmVwcmVz
ZW50cyB0aGUgZXh0ZW5kZWQgaW5vZGUgd2hpY2ggcmVzaWRlcyBvbi1kaXNrLg0KPiArLy8vIFRo
aXMgaXMgZG9jdW1lbnRlZCBpbiBodHRwczovL2Vyb2ZzLmRvY3Mua2VybmVsLm9yZy9lbi9sYXRl
c3QvY29yZV9vbmRpc2suaHRtbCNpbm9kZXMNCj4gKyNbcmVwcihDKV0NCj4gKyNbZGVyaXZlKENs
b25lLCBDb3B5KV0NCj4gK3B1YihjcmF0ZSkgc3RydWN0IEV4dGVuZGVkSW5vZGVJbmZvIHsNCj4g
KyAgICBwdWIoY3JhdGUpIGlfZm9ybWF0OiBGb3JtYXQsDQo+ICsgICAgcHViKGNyYXRlKSBpX3hh
dHRyX2ljb3VudDogdTE2LA0KPiArICAgIHB1YihjcmF0ZSkgaV9tb2RlOiB1MTYsDQo+ICsgICAg
cHViKGNyYXRlKSBpX3Jlc2VydmVkOiBbdTg7IDJdLA0KPiArICAgIHB1YihjcmF0ZSkgaV9zaXpl
OiB1NjQsDQo+ICsgICAgcHViKGNyYXRlKSBpX3U6IFt1ODsgNF0sDQo+ICsgICAgcHViKGNyYXRl
KSBpX2lubzogdTMyLA0KPiArICAgIHB1YihjcmF0ZSkgaV91aWQ6IHUzMiwNCj4gKyAgICBwdWIo
Y3JhdGUpIGlfZ2lkOiB1MzIsDQo+ICsgICAgcHViKGNyYXRlKSBpX210aW1lOiB1NjQsDQo+ICsg
ICAgcHViKGNyYXRlKSBpX210aW1lX25zZWM6IHUzMiwNCj4gKyAgICBwdWIoY3JhdGUpIGlfbmxp
bms6IHUzMiwNCj4gKyAgICBwdWIoY3JhdGUpIGlfcmVzZXJ2ZWQyOiBbdTg7IDE2XSwNCj4gK30N
Cj4gKw0KPiArLy8vIFJlcHJlc2VudHMgdGhlIGlub2RlIGluZm8gd2hpY2ggaXMgZWl0aGVyIGNv
bXBhY3Qgb3IgZXh0ZW5kZWQuDQo+ICsjW2Rlcml2ZShDbG9uZSwgQ29weSldDQo+ICtwdWIoY3Jh
dGUpIGVudW0gSW5vZGVJbmZvIHsNCj4gKyAgICBFeHRlbmRlZChFeHRlbmRlZElub2RlSW5mbyks
DQo+ICsgICAgQ29tcGFjdChDb21wYWN0SW5vZGVJbmZvKSwNCj4gK30NCj4gKw0KPiArcHViKGNy
YXRlKSBjb25zdCBDSFVOS19CTEtCSVRTX01BU0s6IHUxNiA9IDB4MWY7DQo+ICtwdWIoY3JhdGUp
IGNvbnN0IENIVU5LX0ZPUk1BVF9JTkRFWF9CSVQ6IHUxNiA9IDB4MjA7DQo+ICsNCj4gKy8vLyBS
ZXByZXNlbnRzIG9uLWRpc2sgY2h1bmsgaW5kZXggb2YgdGhlIGZpbGUgYmFja2luZyBpbm9kZS4N
Cj4gKyNbcmVwcihDKV0NCj4gKyNbZGVyaXZlKENsb25lLCBDb3B5LCBEZWJ1ZyldDQo+ICtwdWIo
Y3JhdGUpIHN0cnVjdCBDaHVua0luZGV4IHsNCj4gKyAgICBwdWIoY3JhdGUpIGFkdmlzZTogdTE2
LA0KPiArICAgIHB1YihjcmF0ZSkgZGV2aWNlX2lkOiB1MTYsDQo+ICsgICAgcHViKGNyYXRlKSBi
bGthZGRyOiB1MzIsDQo+ICt9DQo+ICsNCj4gK2ltcGwgRnJvbTxbdTg7IDhdPiBmb3IgQ2h1bmtJ
bmRleCB7DQo+ICsgICAgZm4gZnJvbSh1OiBbdTg7IDhdKSAtPiBTZWxmIHsNCj4gKyAgICAgICAg
bGV0IGFkdmlzZSA9IHUxNjo6ZnJvbV9sZV9ieXRlcyhbdVswXSwgdVsxXV0pOw0KPiArICAgICAg
ICBsZXQgZGV2aWNlX2lkID0gdTE2Ojpmcm9tX2xlX2J5dGVzKFt1WzJdLCB1WzNdXSk7DQo+ICsg
ICAgICAgIGxldCBibGthZGRyID0gdTMyOjpmcm9tX2xlX2J5dGVzKFt1WzRdLCB1WzVdLCB1WzZd
LCB1WzddXSk7DQo+ICsgICAgICAgIENodW5rSW5kZXggew0KPiArICAgICAgICAgICAgYWR2aXNl
LA0KPiArICAgICAgICAgICAgZGV2aWNlX2lkLA0KPiArICAgICAgICAgICAgYmxrYWRkciwNCj4g
KyAgICAgICAgfQ0KPiArICAgIH0NCj4gK30NCj4gKw0KPiArLy8vIENodW5rIGZvcm1hdCB1c2Vk
IGZvciBpbmRpY2F0aW5nIHRoZSBjaHVua2JpdHMgYW5kIGNodW5raW5kZXguDQo+ICsjW3JlcHIo
QyldDQo+ICsjW2Rlcml2ZShDbG9uZSwgQ29weSwgRGVidWcpXQ0KPiArcHViKGNyYXRlKSBzdHJ1
Y3QgQ2h1bmtGb3JtYXQocHViKGNyYXRlKSB1MTYpOw0KPiArDQo+ICtpbXBsIENodW5rRm9ybWF0
IHsNCj4gKyAgICBwdWIoY3JhdGUpIGZuIGlzX2NodW5raW5kZXgoJnNlbGYpIC0+IGJvb2wgew0K
PiArICAgICAgICBzZWxmLjAgJiBDSFVOS19GT1JNQVRfSU5ERVhfQklUICE9IDANCj4gKyAgICB9
DQo+ICsgICAgcHViKGNyYXRlKSBmbiBjaHVua2JpdHMoJnNlbGYpIC0+IHUxNiB7DQo+ICsgICAg
ICAgIHNlbGYuMCAmIENIVU5LX0JMS0JJVFNfTUFTSw0KPiArICAgIH0NCg0KSXQgaXMgcmVjb21t
ZW5kZWQgdG8gYWRkIGJsYW5rIGxpbmVzIGJldHdlZW4gY29kZSBibG9ja3MuIFRoaXMgcHJvYmxl
bSANCmV4aXN0cyBpbiBtYW55IHBsYWNlcyBpbiB0aGlzIHBhdGNoIHNldC4NCg0KPiArfQ0KPiAr
DQo+ICsvLy8gUmVwcmVzZW50cyB0aGUgaW5vZGUgc3BlYyB3aGljaCBpcyBlaXRoZXIgZGF0YSBv
ciBkZXZpY2UuDQo+ICsjW2Rlcml2ZShDbG9uZSwgQ29weSwgRGVidWcpXQ0KPiArI1tyZXByKHUz
MildDQo+ICtwdWIoY3JhdGUpIGVudW0gU3BlYyB7DQo+ICsgICAgQ2h1bmsoQ2h1bmtGb3JtYXQp
LA0KPiArICAgIFJhd0Jsayh1MzIpLA0KPiArICAgIERldmljZSh1MzIpLA0KPiArICAgIENvbXBy
ZXNzZWRCbG9ja3ModTMyKSwNCj4gKyAgICBVbmtub3duLA0KPiArfQ0KPiArDQo+ICsvLy8gQ29u
dmVydCB0aGUgc3BlYyBmcm9tIHRoZSBmb3JtYXQgb2YgdGhlIGlub2RlIGJhc2VkIG9uIHRoZSBs
YXlvdXQuDQo+ICtpbXBsIEZyb208KCZbdTg7IDRdLCBMYXlvdXQpPiBmb3IgU3BlYyB7DQo+ICsg
ICAgZm4gZnJvbSh2YWx1ZTogKCZbdTg7IDRdLCBMYXlvdXQpKSAtPiBTZWxmIHsNCj4gKyAgICAg
ICAgbWF0Y2ggdmFsdWUuMSB7DQo+ICsgICAgICAgICAgICBMYXlvdXQ6OkZsYXRJbmxpbmUgfCBM
YXlvdXQ6OkZsYXRQbGFpbiA9PiBTcGVjOjpSYXdCbGsodTMyOjpmcm9tX2xlX2J5dGVzKCp2YWx1
ZS4wKSksDQo+ICsgICAgICAgICAgICBMYXlvdXQ6OkNvbXByZXNzZWRGdWxsIHwgTGF5b3V0OjpD
b21wcmVzc2VkQ29tcGFjdCA9PiB7DQo+ICsgICAgICAgICAgICAgICAgU3BlYzo6Q29tcHJlc3Nl
ZEJsb2Nrcyh1MzI6OmZyb21fbGVfYnl0ZXMoKnZhbHVlLjApKQ0KPiArICAgICAgICAgICAgfQ0K
PiArICAgICAgICAgICAgTGF5b3V0OjpDaHVuayA9PiBTZWxmOjpDaHVuayhDaHVua0Zvcm1hdCh1
MTY6OmZyb21fbGVfYnl0ZXMoW3ZhbHVlLjBbMF0sIHZhbHVlLjBbMV1dKSkpLA0KPiArICAgICAg
ICAgICAgLy8gV2UgZG9uJ3Qgc3VwcG9ydCBjb21wcmVzc2VkIGlubGluZXMgb3IgY29tcHJlc3Nl
ZCBjaHVua3MgY3VycmVudGx5Lg0KPiArICAgICAgICAgICAgXyA9PiBTcGVjOjpVbmtub3duLA0K
PiArICAgICAgICB9DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICsvLy8gSGVscGVyIGZ1bmN0aW9u
cyBmb3IgSW5vZGUgSW5mby4NCj4gK2ltcGwgSW5vZGVJbmZvIHsNCj4gKyAgICBjb25zdCBTX0lG
TVQ6IHUxNiA9IDBvMTcwMDAwOw0KPiArICAgIGNvbnN0IFNfSUZTT0NLOiB1MTYgPSAwbzE0MDAw
MDsNCj4gKyAgICBjb25zdCBTX0lGTE5LOiB1MTYgPSAwbzEyMDAwMDsNCj4gKyAgICBjb25zdCBT
X0lGUkVHOiB1MTYgPSAwbzEwMDAwMDsNCj4gKyAgICBjb25zdCBTX0lGQkxLOiB1MTYgPSAwbzYw
MDAwOw0KPiArICAgIGNvbnN0IFNfSUZESVI6IHUxNiA9IDBvNDAwMDA7DQo+ICsgICAgY29uc3Qg
U19JRkNIUjogdTE2ID0gMG8yMDAwMDsNCj4gKyAgICBjb25zdCBTX0lGSUZPOiB1MTYgPSAwbzEw
MDAwOw0KPiArICAgIGNvbnN0IFNfSVNVSUQ6IHUxNiA9IDBvNDAwMDsNCj4gKyAgICBjb25zdCBT
X0lTR0lEOiB1MTYgPSAwbzIwMDA7DQo+ICsgICAgY29uc3QgU19JU1ZUWDogdTE2ID0gMG8xMDAw
Ow0KPiArICAgIHB1YihjcmF0ZSkgZm4gaW5vKCZzZWxmKSAtPiB1MzIgew0KPiArICAgICAgICBt
YXRjaCBzZWxmIHsNCj4gKyAgICAgICAgICAgIFNlbGY6OkV4dGVuZGVkKGV4dGVuZGVkKSA9PiBl
eHRlbmRlZC5pX2lubywNCj4gKyAgICAgICAgICAgIFNlbGY6OkNvbXBhY3QoY29tcGFjdCkgPT4g
Y29tcGFjdC5pX2lubywNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAgIHB1Yihj
cmF0ZSkgZm4gZm9ybWF0KCZzZWxmKSAtPiBGb3JtYXQgew0KPiArICAgICAgICBtYXRjaCBzZWxm
IHsNCj4gKyAgICAgICAgICAgIFNlbGY6OkV4dGVuZGVkKGV4dGVuZGVkKSA9PiBleHRlbmRlZC5p
X2Zvcm1hdCwNCj4gKyAgICAgICAgICAgIFNlbGY6OkNvbXBhY3QoY29tcGFjdCkgPT4gY29tcGFj
dC5pX2Zvcm1hdCwNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAgIHB1YihjcmF0
ZSkgZm4gZmlsZV9zaXplKCZzZWxmKSAtPiBPZmYgew0KPiArICAgICAgICBtYXRjaCBzZWxmIHsN
Cj4gKyAgICAgICAgICAgIFNlbGY6OkV4dGVuZGVkKGV4dGVuZGVkKSA9PiBleHRlbmRlZC5pX3Np
emUsDQo+ICsgICAgICAgICAgICBTZWxmOjpDb21wYWN0KGNvbXBhY3QpID0+IGNvbXBhY3QuaV9z
aXplIGFzIHU2NCwNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAgIHB1YihjcmF0
ZSkgZm4gaW5vZGVfc2l6ZSgmc2VsZikgLT4gT2ZmIHsNCj4gKyAgICAgICAgbWF0Y2ggc2VsZiB7
DQo+ICsgICAgICAgICAgICBTZWxmOjpFeHRlbmRlZChfKSA9PiA2NCwNCj4gKyAgICAgICAgICAg
IFNlbGY6OkNvbXBhY3QoXykgPT4gMzIsDQoNClNlbGY6OkV4dGVuZGVkKF8pID0+IHNpemVfb2Y6
OjxFeHRlbmRlZElub2RlSW5mbz4oKSBhcyBPZmYsDQpTZWxmOjpDb21wYWN0KF8pID0+IHNpemVf
b2Y6OjxDb21wYWN0SW5vZGVJbmZvPigpIGFzIE9mZiwNCg0KPiArICAgICAgICB9DQo+ICsgICAg
fQ0KPiArDQo+ICsgICAgcHViKGNyYXRlKSBmbiBzcGVjKCZzZWxmKSAtPiBTcGVjIHsNCj4gKyAg
ICAgICAgbGV0IG1vZGUgPSBtYXRjaCBzZWxmIHsNCj4gKyAgICAgICAgICAgIFNlbGY6OkV4dGVu
ZGVkKGV4dGVuZGVkKSA9PiBleHRlbmRlZC5pX21vZGUsDQo+ICsgICAgICAgICAgICBTZWxmOjpD
b21wYWN0KGNvbXBhY3QpID0+IGNvbXBhY3QuaV9tb2RlLA0KPiArICAgICAgICB9Ow0KPiArDQo+
ICsgICAgICAgIGxldCB1ID0gbWF0Y2ggc2VsZiB7DQo+ICsgICAgICAgICAgICBTZWxmOjpFeHRl
bmRlZChleHRlbmRlZCkgPT4gJmV4dGVuZGVkLmlfdSwNCj4gKyAgICAgICAgICAgIFNlbGY6OkNv
bXBhY3QoY29tcGFjdCkgPT4gJmNvbXBhY3QuaV91LA0KPiArICAgICAgICB9Ow0KPiArDQo+ICsg
ICAgICAgIG1hdGNoIG1vZGUgJiAwbzE3MDAwMCB7DQo+ICsgICAgICAgICAgICAwbzQwMDAwIHwg
MG8xMDAwMDAgfCAwbzEyMDAwMCA9PiBTcGVjOjpmcm9tKCh1LCBzZWxmLmZvcm1hdCgpLmxheW91
dCgpKSksDQoNCm1hdGNoIG1vZGUgJiBTZWxmOjpTX0lGTVQgew0KICAgICBTZWxmOjpTX0lGRElS
IHwgU2VsZjo6U19JRlJFRyB8IFNlbGY6OlNfSUZMTksgPT4gU3BlYzo6ZnJvbSgodSwgDQpzZWxm
LmZvcm1hdCgpLmxheW91dCgpKSksDQoNCj4gKyAgICAgICAgICAgIC8vIFdlIGRvbid0IHN1cHBv
cnQgZGV2aWNlIGlub2RlcyBjdXJyZW50bHkuDQo+ICsgICAgICAgICAgICBfID0+IFNwZWM6OlVu
a25vd24sDQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICsNCj4gKyAgICBwdWIoY3JhdGUpIGZu
IGlub2RlX3R5cGUoJnNlbGYpIC0+IFR5cGUgew0KPiArICAgICAgICBsZXQgbW9kZSA9IG1hdGNo
IHNlbGYgew0KPiArICAgICAgICAgICAgU2VsZjo6RXh0ZW5kZWQoZXh0ZW5kZWQpID0+IGV4dGVu
ZGVkLmlfbW9kZSwNCj4gKyAgICAgICAgICAgIFNlbGY6OkNvbXBhY3QoY29tcGFjdCkgPT4gY29t
cGFjdC5pX21vZGUsDQo+ICsgICAgICAgIH07DQo+ICsgICAgICAgIG1hdGNoIG1vZGUgJiBTZWxm
OjpTX0lGTVQgew0KPiArICAgICAgICAgICAgU2VsZjo6U19JRkRJUiA9PiBUeXBlOjpEaXJlY3Rv
cnksIC8vIERpcmVjdG9yeQ0KPiArICAgICAgICAgICAgU2VsZjo6U19JRlJFRyA9PiBUeXBlOjpS
ZWd1bGFyLCAgIC8vIFJlZ3VsYXIgRmlsZQ0KPiArICAgICAgICAgICAgU2VsZjo6U19JRkxOSyA9
PiBUeXBlOjpMaW5rLCAgICAgIC8vIFN5bWJvbGljIExpbmsNCj4gKyAgICAgICAgICAgIFNlbGY6
OlNfSUZJRk8gPT4gVHlwZTo6RmlmbywgICAgICAvLyBGSUZPDQo+ICsgICAgICAgICAgICBTZWxm
OjpTX0lGU09DSyA9PiBUeXBlOjpTb2NrZXQsICAgLy8gU29ja2V0DQo+ICsgICAgICAgICAgICBT
ZWxmOjpTX0lGQkxLID0+IFR5cGU6OkJsb2NrLCAgICAgLy8gQmxvY2sNCj4gKyAgICAgICAgICAg
IFNlbGY6OlNfSUZDSFIgPT4gVHlwZTo6Q2hhcmFjdGVyLCAvLyBDaGFyYWN0ZXINCj4gKyAgICAg
ICAgICAgIF8gPT4gVHlwZTo6VW5rbm93biwNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0K
PiArICAgIHB1YihjcmF0ZSkgZm4geGF0dHJfc2l6ZSgmc2VsZikgLT4gT2ZmIHsNCj4gKyAgICAg
ICAgbWF0Y2ggc2VsZiB7DQo+ICsgICAgICAgICAgICBTZWxmOjpFeHRlbmRlZChleHRlbmRlZCkg
PT4gew0KDQppZiBleHRlbmRlZC5pX3hhdHRyX2ljb3VudCA9PSAwIHsNCiAgICAgcmV0dXJuIDA7
DQp9DQoNCnRvIGF2b2lkIHN1YnRyYWN0IHdpdGggb3ZlcmZsb3cuDQoNClRoYW5rcywNCkppYW5h
bg0KDQo+ICsgICAgICAgICAgICAgICAgc2l6ZV9vZjo6PFhBdHRyU2hhcmVkRW50cnlTdW1tYXJ5
PigpIGFzIE9mZg0KPiArICAgICAgICAgICAgICAgICAgICArIChzaXplX29mOjo8Y19pbnQ+KCkg
YXMgT2ZmKSAqIChleHRlbmRlZC5pX3hhdHRyX2ljb3VudCBhcyBPZmYgLSAxKQ0KPiArICAgICAg
ICAgICAgfQ0KPiArICAgICAgICAgICAgU2VsZjo6Q29tcGFjdChfKSA9PiAwLA0KPiArICAgICAg
ICB9DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcHViKGNyYXRlKSBmbiB4YXR0cl9jb3VudCgmc2Vs
ZikgLT4gdTE2IHsNCj4gKyAgICAgICAgbWF0Y2ggc2VsZiB7DQo+ICsgICAgICAgICAgICBTZWxm
OjpFeHRlbmRlZChleHRlbmRlZCkgPT4gZXh0ZW5kZWQuaV94YXR0cl9pY291bnQsDQo+ICsgICAg
ICAgICAgICBTZWxmOjpDb21wYWN0KGNvbXBhY3QpID0+IGNvbXBhY3QuaV94YXR0cl9pY291bnQs
DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4gK3B1YihjcmF0ZSkgdHlwZSBD
b21wYWN0SW5vZGVJbmZvQnVmID0gW3U4OyBzaXplX29mOjo8Q29tcGFjdElub2RlSW5mbz4oKV07
DQo+ICtwdWIoY3JhdGUpIHR5cGUgRXh0ZW5kZWRJbm9kZUluZm9CdWYgPSBbdTg7IHNpemVfb2Y6
OjxFeHRlbmRlZElub2RlSW5mbz4oKV07DQo+ICtwdWIoY3JhdGUpIGNvbnN0IERFRkFVTFRfSU5P
REVfQlVGOiBFeHRlbmRlZElub2RlSW5mb0J1ZiA9IFswOyBzaXplX29mOjo8RXh0ZW5kZWRJbm9k
ZUluZm8+KCldOw0KPiAtLQ0KPiAyLjQ2LjANCj4gDQoNCg==

