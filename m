Return-Path: <linux-fsdevel+bounces-46792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B20A94F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192841700F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1258263C86;
	Mon, 21 Apr 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="liixehVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0F1B325FA12;
	Mon, 21 Apr 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232666; cv=none; b=neVQ4rb+sSgKMrjlUn144AAvBczaBvunVF2d5kqncJgiIc5NZ3LPveJAp2XminKn8Ncaup/VWzcLR26vTk02HwrUON+AlfgulJRiofoTnglnYfrAxc+g8Atohki8KYw+1y2m8n5QqkLGkZwl5nFx2NAw/vSl83pXQYGLL+DD9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232666; c=relaxed/simple;
	bh=hFz97Lo2xaVpF4pAJScKj+lhnnOUupxcb9PG6LD3Pl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=C3Zy8Xbl9S1m7Ep0XQzdUa4217//tba6tx+0fyAuLBuP2OaBFXV2NO0BkoNeRXU6M3tSGkWSuZcFtxckh71mRvzPU+BBPnv2G+Dnzk4N2scOZWH6/8Rgtg5PNsNl8ELUgS22xvpGRD2ixRd0IAIy4vk3ewyDSZyuIb1JYBbOt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=liixehVr; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id CB857192BB6581;
	Mon, 21 Apr 2025 18:49:58 +0800 (CST)
Received: from BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:32 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-08.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 21 Apr 2025 18:50:31 +0800
Received: from BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787]) by
 BJ03-ACTMBX-07.didichuxing.com ([fe80::b00b:de35:2067:9787%7]) with mapi id
 15.02.1748.010; Mon, 21 Apr 2025 18:50:31 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: =?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	=?gb2312?B?s8LMzszOIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Subject: [PATCH 3/3] ext4: support FOP_DONTCACHE flag
Thread-Topic: [PATCH 3/3] ext4: support FOP_DONTCACHE flag
Thread-Index: AQHbsqszui5Ecff3LEGshtT9cUjseg==
Date: Mon, 21 Apr 2025 10:50:31 +0000
Message-ID: <20250421105026.19577-4-chentaotao@didiglobal.com>
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
	bh=hFz97Lo2xaVpF4pAJScKj+lhnnOUupxcb9PG6LD3Pl0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=liixehVrPYGClqy9waNISrhPdzL4qwDzk290xUSvvD/Yi2Rsr2MwkxZNSNTd6fu3A
	 uloOFN+PYNzfHJ1+ht9LCCRSySPulhYksJwRdGDgLZH1tmfHsc8PrlAbWBVP9p3MRE
	 /+Fkh4AfuuugpM+gh+y09VRmax+2lRFSkuLYORrY=

RnJvbTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5jb20+DQoNCkFmdGVyIHRo
ZSBjb3JlIGxvZ2ljIGZvciBoYW5kbGluZyBJT0NCX0RPTlRDQUNIRSB3YXMgaW1wbGVtZW50ZWQN
CmluIHRoZSBwcmV2aW91cyBwYXRjaCwgd2Ugbm93IGZvcm1hbGx5IGVuYWJsZSB0aGUgZmVhdHVy
ZSBieQ0KYWRkaW5nIEZPUF9ET05UQ0FDSEUgdG8gZXh0NCdzIGZpbGUgb3BlcmF0aW9ucyBmbGFn
cy4NCg0KU2lnbmVkLW9mZi1ieTogVGFvdGFvIENoZW4gPGNoZW50YW90YW9AZGlkaWdsb2JhbC5j
b20+DQotLS0NCiBmcy9leHQ0L2ZpbGUuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvZmlsZS5jIGIv
ZnMvZXh0NC9maWxlLmMNCmluZGV4IGJlYjA3OGVlNDgxMS4uYzUxNDkwM2Q4NWM3IDEwMDY0NA0K
LS0tIGEvZnMvZXh0NC9maWxlLmMNCisrKyBiL2ZzL2V4dDQvZmlsZS5jDQpAQCAtOTc3LDcgKzk3
Nyw3IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZXh0NF9maWxlX29wZXJhdGlvbnMg
PSB7DQogCS5zcGxpY2Vfd3JpdGUJPSBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlLA0KIAkuZmFsbG9j
YXRlCT0gZXh0NF9mYWxsb2NhdGUsDQogCS5mb3BfZmxhZ3MJPSBGT1BfTU1BUF9TWU5DIHwgRk9Q
X0JVRkZFUl9SQVNZTkMgfA0KLQkJCSAgRk9QX0RJT19QQVJBTExFTF9XUklURSwNCisJCQkgIEZP
UF9ESU9fUEFSQUxMRUxfV1JJVEUgfCBGT1BfRE9OVENBQ0hFLA0KIH07DQogDQogY29uc3Qgc3Ry
dWN0IGlub2RlX29wZXJhdGlvbnMgZXh0NF9maWxlX2lub2RlX29wZXJhdGlvbnMgPSB7DQotLSAN
CjIuMzQuMQ0K

