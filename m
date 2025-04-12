Return-Path: <linux-fsdevel+bounces-46316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E187A86D11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7482A9A0CEF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D061E5B7E;
	Sat, 12 Apr 2025 13:00:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72473198857;
	Sat, 12 Apr 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744462824; cv=none; b=gquAYuaBugGJGFOtFgmTaN4Yex+lr3Gc1frWE8Zx2nMZZ/KmAnogTCWHgTC+0XdyIp58HF3uaXCZNg0ePIHXgJDLFB/JFb5+aRUlc31WP5csgMHiJIm5SMTLG3y5R2SjEwiOJDU+0NoqmX3yz3GXjoYw7slQkWJ3v4HlqkQzaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744462824; c=relaxed/simple;
	bh=78FY3uUEgQHjA/hkOpaHAclYMcpdZ7Ospdeu+GSuThw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1QP4s6nA4tn9lmvaZkCKxjsMwldjZz2jlMaZBKHEnl4WM8JBaC8uc1w9E9nWPVBElhFB/ptrAQEAzYtju5JgDzHyFemKVjNFN4elab6ZCDZECqlj9oY2p8sm0vKJdtCjLDeU1mZKXb4ApIVV8iHzs1FnDU1UleSjN50dQZ2bME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Christian Brauner <brauner@kernel.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz"
	<jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBmczogTWFrZSBm?=
 =?utf-8?Q?ile-nr_output_the_total_allocated_file_handles?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gZnM6IE1ha2UgZmlsZS1uciBv?=
 =?utf-8?Q?utput_the_total_allocated_file_handles?=
Thread-Index: AQHbqgqx8U1ad3cqaEyfyidqvoy/O7Od/lcAgAIBVBA=
Date: Sat, 12 Apr 2025 12:59:53 +0000
Message-ID: <6a0a7570ff6c4994aee74b9bef6799eb@baidu.com>
References: <20250410112117.2851-1-lirongqing@baidu.com>
 <20250411-gejagt-gelistet-88c56be455d1@brauner>
In-Reply-To: <20250411-gejagt-gelistet-88c56be455d1@brauner>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.53
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

IA0KPiBPbiBUaHUsIEFwciAxMCwgMjAyNSBhdCAwNzoyMToxN1BNICswODAwLCBsaXJvbmdxaW5n
IHdyb3RlOg0KPiA+IEZyb206IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4g
Pg0KPiA+IE1ha2UgZmlsZS1uciBvdXRwdXQgdGhlIHRvdGFsIGFsbG9jYXRlZCBmaWxlIGhhbmRs
ZXMsIG5vdCBwZXItY3B1DQo+ID4gY2FjaGUgbnVtYmVyLCBpdCdzIG1vcmUgcHJlY2lzZSwgYW5k
IG5vdCBpbiBob3QgcGF0aA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxp
cm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhhdCBtZWFucyBncmFiYmluZyBh
IGxvY2sgc3VkZGVubHkuIElzIHRoZXJlIGFuIGFjdHVhbCB1c2UtY2FzZSBiZWhpbmQgdGhpcz8N
Cg0Kd2FudCB0byBtb25pdG9yIGl0IHRvIGZpbmQgdGhlIGxlYWtpbmcgb2YgdGhlIGFsbG9jYXRl
ZCBmaWxlIGhhbmRsZXIgYnkgc29tZSBhcHBsaWNhdGlvbnMsIGJ1dCBmaW5kIGl0IGlzIGluYWNj
dXJhdGUNCg0KU28gSSB0aGluayB0aGlzIGlzIG5vdCBhIGhvdCBwYXRoLCAgcGVyY3B1X2NvdW50
ZXJfc3VtX3Bvc2l0aXZlIG1heSBiZSBhYmxlIHRvIGJlIHVzZWQNCg0KVGhhbmsNCi1MaQ0KDQoN
Cg==

