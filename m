Return-Path: <linux-fsdevel+bounces-52379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E73AE283E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2F01BC2CC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB52D1EB1BF;
	Sat, 21 Jun 2025 09:22:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B11494A8;
	Sat, 21 Jun 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750497765; cv=none; b=LAU9wLe6DktWP/664UX8fpIn/wOY7I5CthRzbbPlDG6SGBzcdIlI1kP08GQD3rwFJUCM3Tuvy1HPDWA43PQTxzKVG7FlCDKWrFOq/jpwmNJtI4kVfy3XOX5blNeyBiSNa8F509Bm5lP/T4SH1tE1xmYvXQBypsoMWycv00y5MYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750497765; c=relaxed/simple;
	bh=IW7isRjTLoW+T4/DV/HZq1QMYESTQizLyehDftMSoyU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyqhJp+DLhO7S9t7A+GIHiTPhqSJKFI9LzXnDDqf52/jRd5XAGFEl/5zKgXU+jXu2j2g8nonKtaS1n6Rac52zO++lYhHhxZKi1f5yrLBZrxo3SemdoNrIXghQMS3EXGUofj9e+v/U4A/++Tr2W2AW+6s1GkHhqJmSiYyUYfqgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB2aXJ0aW9fZnM6IFJlbW92ZSByZXF1ZXN0IGFkZGl0?=
 =?gb2312?Q?ion_to_processing_list?=
Thread-Topic: [PATCH] virtio_fs: Remove request addition to processing list
Thread-Index: AQHb4dlpUCyax0B+7UiUt1kRzbOkt7QNVxZw
Date: Sat, 21 Jun 2025 09:21:12 +0000
Message-ID: <9f6cfbeb39ac477e80a3cdd7ce31d48e@baidu.com>
References: <20250620114925.2671-1-lirongqing@baidu.com>
In-Reply-To: <20250620114925.2671-1-lirongqing@baidu.com>
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
X-FEAS-Client-IP: 172.31.51.56
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IFNpbmNlIHZpcnRpb19mcyBkb2VzIG5vdCB1dGlsaXplIHRoZSBmdXNlX3BxdWV1ZS0+cHJv
Y2Vzc2luZyBsaXN0LCB3ZSBjYW4gc2FmZWx5DQo+IG9taXQgYWRkaW5nIHJlcXVlc3RzIHRvIHRo
aXMgbGlzdC4gVGhpcyBjaGFuZ2UgZWxpbWluYXRlcyB0aGUgYXNzb2NpYXRlZA0KPiBzcGluX2xv
Y2sgb3BlcmF0aW9ucywgdGhlcmVieSBpbXByb3ZpbmcgcGVyZm9ybWFuY2UuDQo+IA0KDQoNCnBs
ZWFzZSBpZ25vcmUgdGhpcyBtYWlsLCBzb3JyeSBmb3IgdGhlIG5vaXNlLCBJIG1pc3VuZGVyc3Rh
bmQgDQoNCg0KLUxpDQo=

