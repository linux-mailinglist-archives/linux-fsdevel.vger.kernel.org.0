Return-Path: <linux-fsdevel+bounces-46790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF76A94F88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 12:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02893AA354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E292620F5;
	Mon, 21 Apr 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="ohUZW4wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0F14C25FA0A;
	Mon, 21 Apr 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232664; cv=none; b=ktdKeZVfZbQksdURXFLYhZ7aGEBmSK1zH5J/XXp1wkSOH3mSjHOOh7+WEt6h8SBBHwG4pcURcidcdLD+bAcxvuMAYIQ8gTGpnEtCMa69EcwzjtF9QLmy7sRsxvFE3pOloabwChLmLjSvkHrkoM6EL0QFV2fPGX5QBk2TPeKR15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232664; c=relaxed/simple;
	bh=duhNAeM4qnQvRG9T9MEItkigvOCJnMpC4Lj0H5VjsdM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Shu+HhadvyXc5vZ+RjyGBoyMOJ5GVaY3PZX+jbjoJ2m4PGnJ5Y0tyzJV9PhpoUZpZg0Ja/Q3vl0isMELsG/eIkecMiza2x2Ag7joSK/Un2C2fPU9DEN6l/hnHrIMEvkAd9tiHB7riBo5IViLawTK5dv/FJtuYFcO+cpPhH5xuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=ohUZW4wr; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.37])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id CC6AC192BB6571;
	Mon, 21 Apr 2025 18:49:56 +0800 (CST)
Received: from BJ01-ACTMBX-08.didichuxing.com (10.79.64.15) by
 BJ03-ACTMBX-01.didichuxing.com (10.79.71.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:30 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ01-ACTMBX-08.didichuxing.com (10.79.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:29 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Mon, 21 Apr 2025 18:50:29 +0800
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
Subject: [PATCH 0/3] ext4: Implement IOCB_DONTCACHE handling
Thread-Topic: [PATCH 0/3] ext4: Implement IOCB_DONTCACHE handling
Thread-Index: AQHbsqsyiCqqgNZbJ0inKTDAh3pcrQ==
Date: Mon, 21 Apr 2025 10:50:29 +0000
Message-ID: <20250421105026.19577-1-chentaotao@didiglobal.com>
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
	bh=duhNAeM4qnQvRG9T9MEItkigvOCJnMpC4Lj0H5VjsdM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ohUZW4wr63PVheohkKLXU0hAIVgu6yW994GThJgx/1TTecRjDeW2GzlsmX2a3MxGT
	 5Qs5HaeyjOfBSSnLDqmZsXBnBJ92NWEjg4tVcjvEBEfyYxU5Gyo/HykiIZ60TMUm/T
	 HrBhat3Y/ZiPMAfAH3qKEF0PKxPHKQDuB+d1afQg=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNClRoaXMgc2Vy
aWVzIGltcGxlbWVudHMgcHJvcGVyIGhhbmRsaW5nIG9mIElPQ0JfRE9OVENBQ0hFIGZsYWcNCmlu
IGV4dDQgZmlsZXN5c3RlbS4NCg0KVGFvdGFvIENoZW4gKDMpOg0KICBtbS9maWxlbWFwOiBpbml0
aWFsaXplIGZzZGF0YSB3aXRoIGlvY2ItPmtpX2ZsYWdzDQogIGV4dDQ6IGltcGxlbWVudCBJT0NC
X0RPTlRDQUNIRSBoYW5kbGluZyBpbiB3cml0ZSBvcGVyYXRpb25zDQogIGV4dDQ6IHN1cHBvcnQg
Rk9QX0RPTlRDQUNIRSBmbGFnDQoNCiBmcy9leHQ0L2ZpbGUuYyAgfCAgMiArLQ0KIGZzL2V4dDQv
aW5vZGUuYyB8IDIxICsrKysrKysrKysrKysrKysrLS0tLQ0KIG1tL2ZpbGVtYXAuYyAgICB8ICA2
ICsrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjM0LjENCg==

