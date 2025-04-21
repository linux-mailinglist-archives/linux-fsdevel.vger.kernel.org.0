Return-Path: <linux-fsdevel+bounces-46793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447C6A94F91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FE07A7846
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12BE263C8B;
	Mon, 21 Apr 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="hP+gH1aW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 643BA3D81;
	Mon, 21 Apr 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232666; cv=none; b=pF352+Bot2Pq+LKdOVJX6Z+NvqsJ3pFWO6NUgIHlDujhrkW5A5CAV9xDeWStvKAr+9kNllwPdxr78XJhlUEmjtzsuD3KVUnlI/2ToiAbgg2i2n6fH6J/fa25SkTdUZviDMPKimTGtAOGiXqj/vjAdPO1V6F9CFsuGAmrHZsypvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232666; c=relaxed/simple;
	bh=McnoqsM7OwZZHTfj0aes88UGnFIMmmjWOMz06TcW13Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=M4mSZxGN53Q/ZXXPbWOBa9Jk94PeQFL1jKG4y4vdybh5qaQcFX+KP9P5phRN57JBwfj/EJr+vX/XnmTrQAjZL2+WcbSgaQVSAOe7ssEDXUkTV380S62d1On0QLM0TCiCApkHPkwNOLl/pNPqs/392k3agkCC9wco4xRdyqUdWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=hP+gH1aW; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.37])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 4D9EA18B81F549;
	Mon, 21 Apr 2025 18:50:06 +0800 (CST)
Received: from BJ03-ACTMBX-09.didichuxing.com (10.79.71.36) by
 BJ03-ACTMBX-01.didichuxing.com (10.79.71.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:31 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-09.didichuxing.com (10.79.71.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:30 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Mon, 21 Apr 2025 18:50:30 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.71.37
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH 2/3] ext4: implement IOCB_DONTCACHE handling in write
 operations
Thread-Topic: [PATCH 2/3] ext4: implement IOCB_DONTCACHE handling in write
 operations
Thread-Index: AQHbsqsziv0lExfK60SVnrHOwWRNng==
Date: Mon, 21 Apr 2025 10:50:30 +0000
Message-ID: <20250421105026.19577-3-chentaotao@didiglobal.com>
In-Reply-To: <20250421105026.19577-1-chentaotao@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1745232628;
	bh=McnoqsM7OwZZHTfj0aes88UGnFIMmmjWOMz06TcW13Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=hP+gH1aWxLE1wVWUYHWLzI4LnWSwZmg6wsn4feGMWV44Vlz4mS2UZBQUJrWnFJUlb
	 N0wINT8uMIhVDMbhWKrohD9tj/aug9Il29N5MHpFFmT0kUehl7pASjGVgHNuNFzRGs
	 vGdxQCIDwGhhf/JSXQwzw6XX6Gngac3+XBQ47bM8=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCkltcGxlbWVu
dCBJT0NCX0RPTlRDQUNIRSBmbGFnIGhhbmRsaW5nIGluIGV4dDQgd3JpdGUgcGF0aHM6DQoxLiBD
aGVjayBJT0NCX0RPTlRDQUNIRSBmbGFnIHBhc3NlZCB2aWEgZnNkYXRhDQoyLiBQcm9wYWdhdGUg
RkdQX0RPTlRDQUNIRSB0byBwYWdlIGNhY2hlIG9wZXJhdGlvbnMNCg0KRXhpc3Rpbmcgd3JpdGUg
YmVoYXZpb3IgcmVtYWlucyB1bmNoYW5nZWQgd2hlbiBJT0NCX0RPTlRDQUNIRSBpcyBub3Qgc2V0
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNv
bT4NCi0tLQ0KIGZzL2V4dDQvaW5vZGUuYyB8IDIxICsrKysrKysrKysrKysrKysrLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZnMvZXh0NC9pbm9kZS5jIGIvZnMvZXh0NC9pbm9kZS5jDQppbmRleCA5NGM3ZDJkODI4
YTYuLjc4N2RkMTUyYTQ3ZSAxMDA2NDQNCi0tLSBhL2ZzL2V4dDQvaW5vZGUuYw0KKysrIGIvZnMv
ZXh0NC9pbm9kZS5jDQpAQCAtMTE0NywxNiArMTE0NywyMiBAQCBzdGF0aWMgaW50IGV4dDRfd3Jp
dGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LA0KIHsNCiAJc3RydWN0IGlub2RlICppbm9kZSA9IG1hcHBpbmctPmhvc3Q7DQogCWludCByZXQs
IG5lZWRlZF9ibG9ja3M7DQorCWludCBpb2NiX2ZsYWc7DQogCWhhbmRsZV90ICpoYW5kbGU7DQog
CWludCByZXRyaWVzID0gMDsNCiAJc3RydWN0IGZvbGlvICpmb2xpbzsNCiAJcGdvZmZfdCBpbmRl
eDsNCisJZmdmX3QgZmdwID0gRkdQX1dSSVRFQkVHSU47DQogCXVuc2lnbmVkIGZyb20sIHRvOw0K
IA0KIAlyZXQgPSBleHQ0X2VtZXJnZW5jeV9zdGF0ZShpbm9kZS0+aV9zYik7DQogCWlmICh1bmxp
a2VseShyZXQpKQ0KIAkJcmV0dXJuIHJldDsNCiANCisJaW9jYl9mbGFnID0gKGludCkodWludHB0
cl90KSgqZnNkYXRhKTsNCisJaWYgKGlvY2JfZmxhZyAmIElPQ0JfRE9OVENBQ0hFKQ0KKwkJZmdw
IHw9IEZHUF9ET05UQ0FDSEU7DQorDQogCXRyYWNlX2V4dDRfd3JpdGVfYmVnaW4oaW5vZGUsIHBv
cywgbGVuKTsNCiAJLyoNCiAJICogUmVzZXJ2ZSBvbmUgYmxvY2sgbW9yZSBmb3IgYWRkaXRpb24g
dG8gb3JwaGFuIGxpc3QgaW4gY2FzZQ0KQEAgLTExODQsNyArMTE5MCw3IEBAIHN0YXRpYyBpbnQg
ZXh0NF93cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmcsDQogCSAqIHRoZSBmb2xpbyAoaWYgbmVlZGVkKSB3aXRob3V0IHVzaW5nIEdGUF9O
T0ZTLg0KIAkgKi8NCiByZXRyeV9ncmFiOg0KLQlmb2xpbyA9IF9fZmlsZW1hcF9nZXRfZm9saW8o
bWFwcGluZywgaW5kZXgsIEZHUF9XUklURUJFR0lOLA0KKwlmb2xpbyA9IF9fZmlsZW1hcF9nZXRf
Zm9saW8obWFwcGluZywgaW5kZXgsIGZncCwNCiAJCQkJCW1hcHBpbmdfZ2ZwX21hc2sobWFwcGlu
ZykpOw0KIAlpZiAoSVNfRVJSKGZvbGlvKSkNCiAJCXJldHVybiBQVFJfRVJSKGZvbGlvKTsNCkBA
IC0yOTE3LDYgKzI5MjMsOCBAQCBzdGF0aWMgaW50IGV4dDRfZGFfd3JpdGVfYmVnaW4oc3RydWN0
IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KIAkJCSAgICAgICBz
dHJ1Y3QgZm9saW8gKipmb2xpb3AsIHZvaWQgKipmc2RhdGEpDQogew0KIAlpbnQgcmV0LCByZXRy
aWVzID0gMDsNCisJaW50IGlvY2JfZmxhZzsNCisJZmdmX3QgZmdwID0gRkdQX1dSSVRFQkVHSU47
DQogCXN0cnVjdCBmb2xpbyAqZm9saW87DQogCXBnb2ZmX3QgaW5kZXg7DQogCXN0cnVjdCBpbm9k
ZSAqaW5vZGUgPSBtYXBwaW5nLT5ob3N0Ow0KQEAgLTI5MjgsMTAgKzI5MzYsMTUgQEAgc3RhdGlj
IGludCBleHQ0X2RhX3dyaXRlX2JlZ2luKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgYWRkcmVz
c19zcGFjZSAqbWFwcGluZywNCiAJaW5kZXggPSBwb3MgPj4gUEFHRV9TSElGVDsNCiANCiAJaWYg
KGV4dDRfbm9uZGFfc3dpdGNoKGlub2RlLT5pX3NiKSB8fCBleHQ0X3Zlcml0eV9pbl9wcm9ncmVz
cyhpbm9kZSkpIHsNCisJCXJldCA9IGV4dDRfd3JpdGVfYmVnaW4oZmlsZSwgbWFwcGluZywgcG9z
LCBsZW4sIGZvbGlvcCwgZnNkYXRhKTsNCiAJCSpmc2RhdGEgPSAodm9pZCAqKUZBTExfQkFDS19U
T19OT05ERUxBTExPQzsNCi0JCXJldHVybiBleHQ0X3dyaXRlX2JlZ2luKGZpbGUsIG1hcHBpbmcs
IHBvcywNCi0JCQkJCWxlbiwgZm9saW9wLCBmc2RhdGEpOw0KKwkJcmV0dXJuIHJldDsNCiAJfQ0K
Kw0KKwlpb2NiX2ZsYWcgPSAoaW50KSh1aW50cHRyX3QpKCpmc2RhdGEpOw0KKwlpZiAoaW9jYl9m
bGFnICYgSU9DQl9ET05UQ0FDSEUpDQorCQlmZ3AgfD0gRkdQX0RPTlRDQUNIRTsNCisNCiAJKmZz
ZGF0YSA9ICh2b2lkICopMDsNCiAJdHJhY2VfZXh0NF9kYV93cml0ZV9iZWdpbihpbm9kZSwgcG9z
LCBsZW4pOw0KIA0KQEAgLTI5NDUsNyArMjk1OCw3IEBAIHN0YXRpYyBpbnQgZXh0NF9kYV93cml0
ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcs
DQogCX0NCiANCiByZXRyeToNCi0JZm9saW8gPSBfX2ZpbGVtYXBfZ2V0X2ZvbGlvKG1hcHBpbmcs
IGluZGV4LCBGR1BfV1JJVEVCRUdJTiwNCisJZm9saW8gPSBfX2ZpbGVtYXBfZ2V0X2ZvbGlvKG1h
cHBpbmcsIGluZGV4LCBmZ3AsDQogCQkJbWFwcGluZ19nZnBfbWFzayhtYXBwaW5nKSk7DQogCWlm
IChJU19FUlIoZm9saW8pKQ0KIAkJcmV0dXJuIFBUUl9FUlIoZm9saW8pOw0KLS0gDQoyLjM0LjEN
Cg==

