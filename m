Return-Path: <linux-fsdevel+bounces-52755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB2FAE64AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559B31926E12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD42C324F;
	Tue, 24 Jun 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="Qifr+rop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C8F772C1591;
	Tue, 24 Jun 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767342; cv=none; b=d6458EPLuQol/S4fps9KlHHJKJf48Vxfi3cd6bQ1lvSW9Et0sYRBQ7WfdMmcqOXglPZ8oTjiHhaPRE7nFeWv6U4P1RFchs1Wp5AuDhOT+Y9sjSbgLW5t8rTwpyGZzQcA3g2ieY2hhE4e9HuxcjJDUVIBoZqWeX/fGF4xqalF54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767342; c=relaxed/simple;
	bh=1ehUN4pozehk6RNX9hnTmRUSny6p9WZqjeOjfOxTeM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=YI9WxZ5mgIF5aUnYqmlBpM15NhvrRj/j+l3W+zoHFpBxTRqPqdMGAh7nlgHR+4nn2uBdhGwQH1R57WuNemy3Q1ZslTO345QcXLOp4Z6Gc7K6CTXaOxmIrraeqPnvLdE4F7TasvNAzZKtTQza06AVJQeGbx/BNCJBgMWUybHZb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=Qifr+rop; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.21])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 092D9187957BA0;
	Tue, 24 Jun 2025 20:11:28 +0800 (CST)
Received: from BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) by
 BJ01-ACTMBX-02.didichuxing.com (10.79.64.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:07 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Jun 2025 20:12:06 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Tue, 24 Jun 2025 20:12:06 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.64.21
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "willy@infradead.org"
	<willy@infradead.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "tursulin@ursulin.net"
	<tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chentao325@qq.com" <chentao325@qq.com>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH v2 2/5] drm/i915: Refactor shmem_pwrite() to use kiocb and
 write_iter
Thread-Topic: [PATCH v2 2/5] drm/i915: Refactor shmem_pwrite() to use kiocb
 and write_iter
Thread-Index: AQHb5QEzn6fdfVPkO0uWBWKjWOz86Q==
Date: Tue, 24 Jun 2025 12:12:06 +0000
Message-ID: <20250624121149.2927-3-chentaotao@didiglobal.com>
In-Reply-To: <20250624121149.2927-1-chentaotao@didiglobal.com>
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
	s=2025; t=1750767110;
	bh=1ehUN4pozehk6RNX9hnTmRUSny6p9WZqjeOjfOxTeM0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Qifr+ropRG/92K7TGD9IbKdMJfUJJzKTzumy0UYxoyfZPPt0uzQ+Sra3AdLkBjHM5
	 MgGL+yys/X7ZeOMzUwScd3ofvCUYzbz6QdML1kgpct7ujUqOfxrxg70Ce1GMCaQOjM
	 6BI8kweokZ20ihAb8SpPgpVZp2s6y4OvoY0ky8UU=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClJlZmFjdG9y
cyBzaG1lbV9wd3JpdGUoKSB0byByZXBsYWNlIHRoZSAtPndyaXRlX2JlZ2luL2VuZCBsb2dpYw0K
d2l0aCBhIHdyaXRlX2l0ZXItYmFzZWQgaW1wbGVtZW50YXRpb24gdXNpbmcga2lvY2IgYW5kIGlv
dl9pdGVyLg0KDQpXaGlsZSBrZXJuZWxfd3JpdGUoKSB3YXMgY29uc2lkZXJlZCwgaXQgY2F1c2Vk
IGFib3V0IDUwJSBwZXJmb3JtYW5jZQ0KcmVncmVzc2lvbi4gdmZzX3dyaXRlKCkgaXMgbm90IGV4
cG9ydGVkIGZvciBrZXJuZWwgdXNlLiBUaGVyZWZvcmUsDQpmaWxlLT5mX29wLT53cml0ZV9pdGVy
KCkgaXMgY2FsbGVkIGRpcmVjdGx5IHdpdGggYSBzeW5jaHJvbm91c2x5DQppbml0aWFsaXplZCBr
aW9jYiB0byBwcmVzZXJ2ZSBwZXJmb3JtYW5jZSBhbmQgcmVtb3ZlIHdyaXRlX2JlZ2luDQp1c2Fn
ZS4NCg0KUGVyZm9ybWFuY2UgcmVzdWx0cyB1c2UgZ2VtX3B3cml0ZSBvbiBJbnRlbCBDUFUgaTct
MTA3MDANCihhdmVyYWdlIG9mIDEwIHJ1bnMpOg0KDQotIC4vZ2VtX3B3cml0ZSAtLXJ1bi1zdWJ0
ZXN0IGJlbmNoIC1zIDE2Mzg0DQogIEJlZm9yZTogMC4yMDVzLCBBZnRlcjogMC4yMTRzDQoNCi0g
Li9nZW1fcHdyaXRlIC0tcnVuLXN1YnRlc3QgYmVuY2ggLXMgNTI0Mjg4DQogIEJlZm9yZTogNi4x
MDIxcywgQWZ0ZXI6IDQuODA0N3MNCg0KUGFydCBvZiBhIHNlcmllcyByZWZhY3RvcmluZyBhZGRy
ZXNzX3NwYWNlX29wZXJhdGlvbnMgd3JpdGVfYmVnaW4gYW5kDQp3cml0ZV9lbmQgY2FsbGJhY2tz
IHRvIHVzZSBzdHJ1Y3Qga2lvY2IgZm9yIHBhc3Npbmcgd3JpdGUgY29udGV4dCBhbmQNCmZsYWdz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBUYW90YW8gQ2hlbiA8Y2hlbnRhb3Rhb0BkaWRpZ2xvYmFsLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jIHwgODEg
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgNjAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9n
ZW0vaTkxNV9nZW1fc2htZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9z
aG1lbS5jDQppbmRleCBkMDhhZGU5MzRkMTUuLjkyZDZhNDgxYTg0MiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9zaG1lbS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fc2htZW0uYw0KQEAgLTQwMCwxMiArNDAwLDEyIEBAIHN0
YXRpYyBpbnQNCiBzaG1lbV9wd3JpdGUoc3RydWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iaiwN
CiAJICAgICBjb25zdCBzdHJ1Y3QgZHJtX2k5MTVfZ2VtX3B3cml0ZSAqYXJnKQ0KIHsNCi0Jc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBvYmotPmJhc2UuZmlscC0+Zl9tYXBwaW5nOw0K
LQljb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zICphb3BzID0gbWFwcGluZy0+
YV9vcHM7DQogCWNoYXIgX191c2VyICp1c2VyX2RhdGEgPSB1NjRfdG9fdXNlcl9wdHIoYXJnLT5k
YXRhX3B0cik7DQotCXU2NCByZW1haW47DQotCWxvZmZfdCBwb3M7DQotCXVuc2lnbmVkIGludCBw
ZzsNCisJc3RydWN0IGZpbGUgKmZpbGUgPSBvYmotPmJhc2UuZmlscDsNCisJc3RydWN0IGtpb2Ni
IGtpb2NiOw0KKwlzdHJ1Y3QgaW92X2l0ZXIgaXRlcjsNCisJc3NpemVfdCB3cml0dGVuOw0KKwl1
NjQgc2l6ZSA9IGFyZy0+c2l6ZTsNCiANCiAJLyogQ2FsbGVyIGFscmVhZHkgdmFsaWRhdGVkIHVz
ZXIgYXJncyAqLw0KIAlHRU1fQlVHX09OKCFhY2Nlc3Nfb2sodXNlcl9kYXRhLCBhcmctPnNpemUp
KTsNCkBAIC00MjgsNjMgKzQyOCwyNCBAQCBzaG1lbV9wd3JpdGUoc3RydWN0IGRybV9pOTE1X2dl
bV9vYmplY3QgKm9iaiwNCiAJaWYgKG9iai0+bW0ubWFkdiAhPSBJOTE1X01BRFZfV0lMTE5FRUQp
DQogCQlyZXR1cm4gLUVGQVVMVDsNCiANCi0JLyoNCi0JICogQmVmb3JlIHRoZSBwYWdlcyBhcmUg
aW5zdGFudGlhdGVkIHRoZSBvYmplY3QgaXMgdHJlYXRlZCBhcyBiZWluZw0KLQkgKiBpbiB0aGUg
Q1BVIGRvbWFpbi4gVGhlIHBhZ2VzIHdpbGwgYmUgY2xmbHVzaGVkIGFzIHJlcXVpcmVkIGJlZm9y
ZQ0KLQkgKiB1c2UsIGFuZCB3ZSBjYW4gZnJlZWx5IHdyaXRlIGludG8gdGhlIHBhZ2VzIGRpcmVj
dGx5LiBJZiB1c2Vyc3BhY2UNCi0JICogcmFjZXMgcHdyaXRlIHdpdGggYW55IG90aGVyIG9wZXJh
dGlvbjsgY29ycnVwdGlvbiB3aWxsIGVuc3VlIC0NCi0JICogdGhhdCBpcyB1c2Vyc3BhY2UncyBw
cmVyb2dhdGl2ZSENCi0JICovDQorCWlmIChzaXplID4gTUFYX1JXX0NPVU5UKQ0KKwkJcmV0dXJu
IC1FRkJJRzsNCiANCi0JcmVtYWluID0gYXJnLT5zaXplOw0KLQlwb3MgPSBhcmctPm9mZnNldDsN
Ci0JcGcgPSBvZmZzZXRfaW5fcGFnZShwb3MpOw0KKwlpZiAoIWZpbGUtPmZfb3AtPndyaXRlX2l0
ZXIpDQorCQlyZXR1cm4gLUVJTlZBTDsNCiANCi0JZG8gew0KLQkJdW5zaWduZWQgaW50IGxlbiwg
dW53cml0dGVuOw0KLQkJc3RydWN0IGZvbGlvICpmb2xpbzsNCi0JCXZvaWQgKmRhdGEsICp2YWRk
cjsNCi0JCWludCBlcnI7DQotCQljaGFyIF9fbWF5YmVfdW51c2VkIGM7DQotDQotCQlsZW4gPSBQ
QUdFX1NJWkUgLSBwZzsNCi0JCWlmIChsZW4gPiByZW1haW4pDQotCQkJbGVuID0gcmVtYWluOw0K
LQ0KLQkJLyogUHJlZmF1bHQgdGhlIHVzZXIgcGFnZSB0byByZWR1Y2UgcG90ZW50aWFsIHJlY3Vy
c2lvbiAqLw0KLQkJZXJyID0gX19nZXRfdXNlcihjLCB1c2VyX2RhdGEpOw0KLQkJaWYgKGVycikN
Ci0JCQlyZXR1cm4gZXJyOw0KLQ0KLQkJZXJyID0gX19nZXRfdXNlcihjLCB1c2VyX2RhdGEgKyBs
ZW4gLSAxKTsNCi0JCWlmIChlcnIpDQotCQkJcmV0dXJuIGVycjsNCi0NCi0JCWVyciA9IGFvcHMt
PndyaXRlX2JlZ2luKG9iai0+YmFzZS5maWxwLCBtYXBwaW5nLCBwb3MsIGxlbiwNCi0JCQkJCSZm
b2xpbywgJmRhdGEpOw0KLQkJaWYgKGVyciA8IDApDQotCQkJcmV0dXJuIGVycjsNCi0NCi0JCXZh
ZGRyID0ga21hcF9sb2NhbF9mb2xpbyhmb2xpbywgb2Zmc2V0X2luX2ZvbGlvKGZvbGlvLCBwb3Mp
KTsNCi0JCXBhZ2VmYXVsdF9kaXNhYmxlKCk7DQotCQl1bndyaXR0ZW4gPSBfX2NvcHlfZnJvbV91
c2VyX2luYXRvbWljKHZhZGRyLCB1c2VyX2RhdGEsIGxlbik7DQotCQlwYWdlZmF1bHRfZW5hYmxl
KCk7DQotCQlrdW5tYXBfbG9jYWwodmFkZHIpOw0KLQ0KLQkJZXJyID0gYW9wcy0+d3JpdGVfZW5k
KG9iai0+YmFzZS5maWxwLCBtYXBwaW5nLCBwb3MsIGxlbiwNCi0JCQkJICAgICAgbGVuIC0gdW53
cml0dGVuLCBmb2xpbywgZGF0YSk7DQotCQlpZiAoZXJyIDwgMCkNCi0JCQlyZXR1cm4gZXJyOw0K
LQ0KLQkJLyogV2UgZG9uJ3QgaGFuZGxlIC1FRkFVTFQsIGxlYXZlIGl0IHRvIHRoZSBjYWxsZXIg
dG8gY2hlY2sgKi8NCi0JCWlmICh1bndyaXR0ZW4pDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotDQot
CQlyZW1haW4gLT0gbGVuOw0KLQkJdXNlcl9kYXRhICs9IGxlbjsNCi0JCXBvcyArPSBsZW47DQot
CQlwZyA9IDA7DQotCX0gd2hpbGUgKHJlbWFpbik7DQorCWluaXRfc3luY19raW9jYigma2lvY2Is
IGZpbGUpOw0KKwlraW9jYi5raV9wb3MgPSBhcmctPm9mZnNldDsNCisJaW92X2l0ZXJfdWJ1Zigm
aXRlciwgSVRFUl9TT1VSQ0UsICh2b2lkIF9fdXNlciAqKXVzZXJfZGF0YSwgc2l6ZSk7DQorDQor
CXdyaXR0ZW4gPSBmaWxlLT5mX29wLT53cml0ZV9pdGVyKCZraW9jYiwgJml0ZXIpOw0KKwlCVUdf
T04od3JpdHRlbiA9PSAtRUlPQ0JRVUVVRUQpOw0KKw0KKwlpZiAod3JpdHRlbiAhPSBzaXplKQ0K
KwkJcmV0dXJuIC1FSU87DQorDQorCWlmICh3cml0dGVuIDwgMCkNCisJCXJldHVybiB3cml0dGVu
Ow0KIA0KIAlyZXR1cm4gMDsNCiB9DQotLSANCjIuMzQuMQ0K

