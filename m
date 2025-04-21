Return-Path: <linux-fsdevel+bounces-46791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C4A94F8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F253AA5E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8D262815;
	Mon, 21 Apr 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="euyvweeH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2BDC325FA24;
	Mon, 21 Apr 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232665; cv=none; b=Gfah5qB+W8I5XvM1krngFG7a/LtbkJhZ8Y5oJ1EkS1MdbD11ywcuJ0Mr1ioEzqfJL5EVc7LZ2i2XvXteNw8Cr9VhXDqVJ+PayWhcjdJMv4dfnuh6TRIVfSVGfRGhzxUAA4SMTPQO7s0Xk7H2I5zVWxdwsPeG46XHr1850QhEDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232665; c=relaxed/simple;
	bh=isUkKjuOetSgNBjU8SvHHjmefzbAw+3LH02RLvwAink=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=slLLSI4s0QyBny6/Yt4FH0l6Rzfi233nFib5DMkzaqS+s9MqZ34zBzH2ROQ9ETQ2xwSoJNsXR2aX2QJ8eyv+9F3428JoSHhQH9SZV6EpmAF+BCqUrP8aK+CDczYMSTx6yWqd3zdbk+M0c/FhVvLbjVuSQ/mF4z1eQ/58C4BvRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=euyvweeH; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.21])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id A5C82192BB6580;
	Mon, 21 Apr 2025 18:49:57 +0800 (CST)
Received: from BJ02-ACTMBX-09.didichuxing.com (10.79.65.18) by
 BJ01-ACTMBX-02.didichuxing.com (10.79.64.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:30 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ02-ACTMBX-09.didichuxing.com (10.79.65.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:30 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Mon, 21 Apr 2025 18:50:30 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.64.21
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH 1/3] mm/filemap: initialize fsdata with iocb->ki_flags
Thread-Topic: [PATCH 1/3] mm/filemap: initialize fsdata with iocb->ki_flags
Thread-Index: AQHbsqsyd5FrrvlD8E+DF/FkAUZ8QA==
Date: Mon, 21 Apr 2025 10:50:30 +0000
Message-ID: <20250421105026.19577-2-chentaotao@didiglobal.com>
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
	s=2025; t=1745232621;
	bh=isUkKjuOetSgNBjU8SvHHjmefzbAw+3LH02RLvwAink=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=euyvweeH+54Ovq55HqloJTd+oAulTzSJogLds7Yk+cNBKH96Z1JU1w3HiDgeHAVz7
	 e2BlBzS1OD4NQLw6s9icgGeucKjzhUeN7dVJxYLWP1MntG9V6oIPyXVOUPbR3GcISj
	 sWVUOdVHX9jyIFEnWC5mbxOep24arDbv4qCN+uaY=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCkluaXRpYWxp
emUgZnNkYXRhIHdpdGggJmlvY2ItPmtpX2ZsYWdzIHRvIGFsbG93IGZpbGVzeXN0ZW1zIHRvIGNo
ZWNrDQppb2NiIGZsYWdzIGxpa2UgSU9DQl9ET05UQ0FDSEUgZHVyaW5nIC0+d3JpdGVfYmVnaW4o
KS4NCg0KU2lnbmVkLW9mZi1ieTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5j
b20+DQotLS0NCiBtbS9maWxlbWFwLmMgfCA2ICsrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBi
L21tL2ZpbGVtYXAuYw0KaW5kZXggN2I5MGNiZWI0YTFhLi45MTc0YjYzMTBmMGIgMTAwNjQ0DQot
LS0gYS9tbS9maWxlbWFwLmMNCisrKyBiL21tL2ZpbGVtYXAuYw0KQEAgLTQwODcsNyArNDA4Nywx
MSBAQCBzc2l6ZV90IGdlbmVyaWNfcGVyZm9ybV93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0
cnVjdCBpb3ZfaXRlciAqaSkNCiAJCXNpemVfdCBvZmZzZXQ7CQkvKiBPZmZzZXQgaW50byBmb2xp
byAqLw0KIAkJc2l6ZV90IGJ5dGVzOwkJLyogQnl0ZXMgdG8gd3JpdGUgdG8gZm9saW8gKi8NCiAJ
CXNpemVfdCBjb3BpZWQ7CQkvKiBCeXRlcyBjb3BpZWQgZnJvbSB1c2VyICovDQotCQl2b2lkICpm
c2RhdGEgPSBOVUxMOw0KKwkJLyoNCisJCSAqIEluaXRpYWxpemUgZnNkYXRhIHdpdGggaW9jYiBm
bGFncyBwb2ludGVyIHNvIHRoYXQgZmlsZXN5c3RlbXMNCisJCSAqIGNhbiBjaGVjayBraV9mbGFn
cyAobGlrZSBJT0NCX0RPTlRDQUNIRSkgaW4gd3JpdGUgb3BlcmF0aW9ucy4NCisJCSAqLw0KKwkJ
dm9pZCAqZnNkYXRhID0gJmlvY2ItPmtpX2ZsYWdzOw0KIA0KIAkJYnl0ZXMgPSBpb3ZfaXRlcl9j
b3VudChpKTsNCiByZXRyeToNCi0tIA0KMi4zNC4xDQo=

