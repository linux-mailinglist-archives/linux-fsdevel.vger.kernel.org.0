Return-Path: <linux-fsdevel+bounces-54458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C166FAFFEF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C186F1C86F23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9892D97BF;
	Thu, 10 Jul 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="H+PhF3Yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B4E9C2D63E7;
	Thu, 10 Jul 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142466; cv=none; b=ZOtMuMXwEnyNmKSHLDD9OBlZYtKNFGMaJ54/qtisl+LViqvOh/oO+/F8KzcXGTHB1lfWtfj67kP2J14EWxIU+isWXdBQ45wSaaawr/d+9FTl3YrwJryytHYXe/EBAd+qbZJY37enRyXMqXtGaIVmmcxMH3PlHP+oLew9EBA97Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142466; c=relaxed/simple;
	bh=mziai3oLFdsNo4lyKhB4xbXWsh53JEyB4xMDRA6AVSE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DHA7irW1voc9sXpsACDwQo4SjFyq5zTDi/t21oaRC+MRJfYAJluGtGFpLfWZTykGgQCSmOFzEFAS9LoqNljC9BupM5n5xsLXVfA23h9fdQt6aPb/DR80I99Kt4Q2WlFV5Muu7A7HP92j1iDazyXs+R0tpf3xRCir1MfuJu0Meno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=H+PhF3Yw; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id EC56E181988061;
	Thu, 10 Jul 2025 18:14:03 +0800 (CST)
Received: from BJ01-ACTMBX-09.didichuxing.com (10.79.64.19) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 18:14:07 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ01-ACTMBX-09.didichuxing.com (10.79.64.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 10 Jul 2025 18:14:06 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::2e1a:dd47:6d25:287e%7]) with mapi id
 15.02.1748.010; Thu, 10 Jul 2025 18:14:06 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.19
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
	"frank.li@vivo.com" <frank.li@vivo.com>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH v5 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Topic: [PATCH v5 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Thread-Index: AQHb8YNeZ4qN36tcAUqdp5GyKxo6Ug==
Date: Thu, 10 Jul 2025 10:14:06 +0000
Message-ID: <20250710101404.362146-1-chentaotao@didiglobal.com>
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
	s=2025; t=1752142446;
	bh=mziai3oLFdsNo4lyKhB4xbXWsh53JEyB4xMDRA6AVSE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=H+PhF3YwcCee3lPdivXlf6v9FLPQoxJl66az5BIOkth7ehmh8VHODIHRDGUqAjcdX
	 t6KHR5iPPamCvLrdsssLVaSAt8BIuCN/DQfOxDpZiSousmB2d4ophHTmAOfgK7Kx4S
	 Yqs7YtUY6H5oy3tFEfHmovNfWz29nJklgsA+7QF8=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClRoaXMgcGF0
Y2ggc2VyaWVzIHJlZmFjdG9ycyB0aGUgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIHdyaXRlX2Jl
Z2luKCkNCmFuZCB3cml0ZV9lbmQoKSBjYWxsYmFja3MgdG8gdGFrZSBjb25zdCBzdHJ1Y3Qga2lv
Y2IgKiBhcyB0aGVpciBmaXJzdA0KYXJndW1lbnQsIGFsbG93aW5nIElPQ0IgZmxhZ3Mgc3VjaCBh
cyBJT0NCX0RPTlRDQUNIRSB0byBwcm9wYWdhdGUgdG8gdGhlDQpmaWxlc3lzdGVtJ3MgYnVmZmVy
ZWQgSS9PIHBhdGguDQoNCkV4dDQgaXMgdXBkYXRlZCB0byBpbXBsZW1lbnQgaGFuZGxpbmcgb2Yg
dGhlIElPQ0JfRE9OVENBQ0hFIGZsYWcgYW5kDQphZHZlcnRpc2VzIHN1cHBvcnQgdmlhIHRoZSBG
T1BfRE9OVENBQ0hFIGZpbGUgb3BlcmF0aW9uIGZsYWcuDQoNCkFkZGl0aW9uYWxseSwgdGhlIGk5
MTUgZHJpdmVyJ3Mgc2htZW0gd3JpdGUgcGF0aHMgYXJlIHVwZGF0ZWQgdG8gYnlwYXNzDQp0aGUg
bGVnYWN5IHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBpbnRlcmZhY2UgaW4gZmF2b3Igb2YgZGlyZWN0
bHkNCmNhbGxpbmcgd3JpdGVfaXRlcigpIHdpdGggYSBjb25zdHJ1Y3RlZCBzeW5jaHJvbm91cyBr
aW9jYi4gQW5vdGhlciBpOTE1DQpjaGFuZ2UgcmVwbGFjZXMgYSBtYW51YWwgd3JpdGUgbG9vcCB3
aXRoIGtlcm5lbF93cml0ZSgpIGR1cmluZyBHRU0gc2htZW0NCm9iamVjdCBjcmVhdGlvbi4NCg0K
VGVzdGVkIHdpdGggZXh0NCBhbmQgaTkxNSBHRU0gd29ya2xvYWRzLg0KDQpUaGlzIHBhdGNoIHNl
cmllcyBpcyBiYXNlZCBvbiB0aGUgdmZzLTYuMTcubWlzYyBicmFuY2guDQoNCkNoYW5nZXMgc2lu
Y2UgdjQ6DQotIFVwZGF0ZWQgd3JpdGVfYmVnaW5fZ2V0X2ZvbGlvKCkgY29tbWVudCBhbmQgbWFk
ZSBpdCBzdGF0aWMgaW5saW5lIGluIGhlYWRlci4NCg0KVGFvdGFvIENoZW4gKDUpOg0KICBkcm0v
aTkxNTogVXNlIGtlcm5lbF93cml0ZSgpIGluIHNobWVtIG9iamVjdCBjcmVhdGUNCiAgZHJtL2k5
MTU6IFJlZmFjdG9yIHNobWVtX3B3cml0ZSgpIHRvIHVzZSBraW9jYiBhbmQgd3JpdGVfaXRlcg0K
ICBmczogY2hhbmdlIHdyaXRlX2JlZ2luL3dyaXRlX2VuZCBpbnRlcmZhY2UgdG8gdGFrZSBzdHJ1
Y3Qga2lvY2IgKg0KICBtbS9wYWdlbWFwOiBhZGQgd3JpdGVfYmVnaW5fZ2V0X2ZvbGlvKCkgaGVs
cGVyIGZ1bmN0aW9uDQogIGV4dDQ6IHN1cHBvcnQgdW5jYWNoZWQgYnVmZmVyZWQgSS9PDQoNCiBE
b2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1zL2xvY2tpbmcucnN0ICAgICB8ICAgNCArLQ0KIERvY3Vt
ZW50YXRpb24vZmlsZXN5c3RlbXMvdmZzLnJzdCAgICAgICAgIHwgICA2ICstDQogYmxvY2svZm9w
cy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTMgKystDQogZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX3NobWVtLmMgfCAxMTQgKysrKysrLS0tLS0tLS0tLS0tLS0t
LQ0KIGZzL2FkZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICstDQog
ZnMvYWZmcy9maWxlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjYgKystLS0NCiBm
cy9iY2FjaGVmcy9mcy1pby1idWZmZXJlZC5jICAgICAgICAgICAgICB8ICAgNCArLQ0KIGZzL2Jj
YWNoZWZzL2ZzLWlvLWJ1ZmZlcmVkLmggICAgICAgICAgICAgIHwgICA0ICstDQogZnMvYmZzL2Zp
bGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKy0NCiBmcy9idWZmZXIuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNiArKy0tLQ0KIGZzL2NlcGgvYWRkci5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICstDQogZnMvZWNyeXB0ZnMvbW1hcC5j
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiBmcy9leGZhdC9maWxlLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxMSArLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy9leHQyL2lub2RlLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxMSArKy0NCiBmcy9leHQ0L2ZpbGUuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMyArLQ0KIGZzL2V4dDQvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDMwICsrKy0tLQ0KIGZzL2YyZnMvZGF0YS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA4ICstDQogZnMvZmF0L2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMTggKystLQ0KIGZzL2Z1c2UvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDE0ICsrLQ0KIGZzL2hmcy9oZnNfZnMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAyICstDQogZnMvaGZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQg
Ky0NCiBmcy9oZnNwbHVzL2hmc3BsdXNfZnMuaCAgICAgICAgICAgICAgICAgICB8ICAgNiArLQ0K
IGZzL2hmc3BsdXMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstDQogZnMv
aG9zdGZzL2hvc3Rmc19rZXJuLmMgICAgICAgICAgICAgICAgICAgfCAgIDggKy0NCiBmcy9ocGZz
L2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOCArKy0tDQogZnMvaHVnZXRs
YmZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKy0NCiBmcy9qZmZzMi9maWxl
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyOCArKystLS0NCiBmcy9qZnMvaW5vZGUu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy9saWJmcy5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKy0NCiBmcy9taW5peC9pbm9kZS5jICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArLQ0KIGZzL25mcy9maWxlLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICA4ICstDQogZnMvbmlsZnMyL2lub2RlLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDggKy0NCiBmcy9udGZzMy9maWxlLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNCArLQ0KIGZzL250ZnMzL2lub2RlLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA3ICstDQogZnMvbnRmczMvbnRmc19mcy5oICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMTAgKy0NCiBmcy9vY2ZzMi9hb3BzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNiArLQ0KIGZzL29tZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3
ICstDQogZnMvb3JhbmdlZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0t
DQogZnMvdWJpZnMvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKy0NCiBm
cy91ZGYvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKy0NCiBmcy91
ZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLS0NCiBmcy92Ym94
c2YvZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQ0KIGluY2x1ZGUvbGlu
dXgvYnVmZmVyX2hlYWQuaCAgICAgICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS9saW51eC9m
cy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKystDQogaW5jbHVkZS9saW51eC9wYWdl
bWFwLmggICAgICAgICAgICAgICAgICAgfCAgMjcgKysrKysNCiBtbS9maWxlbWFwLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0KIG1tL3NobWVtLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDEyICstLQ0KIDQ4IGZpbGVzIGNoYW5nZWQsIDMyNyBpbnNl
cnRpb25zKCspLCAyOTUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4zNC4xDQo=

