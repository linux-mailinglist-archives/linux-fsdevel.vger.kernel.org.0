Return-Path: <linux-fsdevel+bounces-46361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82064A87E68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9143B62EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714B28A412;
	Mon, 14 Apr 2025 11:06:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F3283697;
	Mon, 14 Apr 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628783; cv=none; b=PpSP7f60gKOd8EuAeWHZXPtMAMdoBaW54zYV5WiXnVFD4ecTVOQKpMd4KSl7BxZDq5SRzQ7MgSPz68dL7fPwJuyHBUzp3k+Lh9ZDFPBz7LAUGQ8LPPZHp/kzD26kr7ia4auN7dJnWEh6C+KZFo5U0U/c7Jtu/zVNmanHyAnYD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628783; c=relaxed/simple;
	bh=KbKNHz0LKd92Dbpkf6xZRcLCDOWv0qrCpWFO+Js8TEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sX87wp3tGTZqdzXmSyTz0FiqxCsE1QkT758dwbKUZU6MDDGnis9pyGm6oWXfBlKkjYjnBakVdpCXDAEWo2TNl37SAP/ndOf5qzALYGnB74H0XKFMbJuJiKsvOwXhI96TF0Qf9eF1jCJLdbKEI5116oGLUuuQopHch29HJqXWLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Christian Brauner <brauner@kernel.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz"
	<jack@suse.cz>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogKHN1YnNldCkgW1BBVENIXSBm?=
 =?utf-8?B?czogTWFrZSBmaWxlLW5yIG91dHB1dCB0aGUgdG90YWwgYWxsb2NhdGVkIGZp?=
 =?utf-8?Q?le_handles?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IChzdWJzZXQpIFtQQVRDSF0gZnM6IE1ha2Ug?=
 =?utf-8?Q?file-nr_output_the_total_allocated_file_handles?=
Thread-Index: AQHbqgqx8U1ad3cqaEyfyidqvoy/O7Oib+KAgACVz6A=
Date: Mon, 14 Apr 2025 11:05:48 +0000
Message-ID: <0c3d84f1b91145ccba7d6d3222962be0@baidu.com>
References: <20250410112117.2851-1-lirongqing@baidu.com>
 <20250414-teuflisch-nahezu-396209d549ba@brauner>
In-Reply-To: <20250414-teuflisch-nahezu-396209d549ba@brauner>
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

DQo+IE9uIFRodSwgMTAgQXByIDIwMjUgMTk6MjE6MTcgKzA4MDAsIGxpcm9uZ3Fpbmcgd3JvdGU6
DQo+ID4gTWFrZSBmaWxlLW5yIG91dHB1dCB0aGUgdG90YWwgYWxsb2NhdGVkIGZpbGUgaGFuZGxl
cywgbm90IHBlci1jcHUNCj4gPiBjYWNoZSBudW1iZXIsIGl0J3MgbW9yZSBwcmVjaXNlLCBhbmQg
bm90IGluIGhvdCBwYXRoDQo+ID4NCj4gPg0KPiANCg0KDQpIaSBDaHJpc3RpYW4gQnJhdW5lcjoN
Cg0KQ291bGQgd2UgY2hhbmdlIHRoZSBjaGFuZ2Vsb2cgYXMgYmVsb3csIGl0IG1heWJlIG1vcmUg
cmVhc29uYWJsZQ0KDQogICAgZnM6IFVzZSBwZXJjcHVfY291bnRlcl9zdW1fcG9zaXRpdmUgaW4g
cHJvY19ucl9maWxlcw0KDQogICAgVGhlIGNlbnRyYWxpemVkIHZhbHVlIG9mIHBlcmNwdSBjb3Vu
dGVyIGNhbiBiZSByZWFsbHkgZ3Jvc3NseSBpbmFjY3VyYXRlDQogICAgYXMgQ1BVIGNvdW50IGlu
Y3JlYXNlcy4gYW5kIHByb2NfbnJfZmlsZXMgaXMgb25seSBhY2Nlc3NlZCB3aGVuIHJlYWRpbmcN
CiAgICBwcm9jIGZpbGUsIG5vdCBhIGhvdCBwYXRoLCBzbyB1c2UgcGVyY3B1X2NvdW50ZXJfc3Vt
X3Bvc2l0aXZlIGluIGl0LCB0byBtYWtlDQogICAgL3Byb2Mvc3lzL2ZzL2ZpbGUtbnIgbW9yZSBh
Y2N1cmF0ZQ0KDQp0aGFua3MNCg0KDQotTGkNCg0KPiBBcHBsaWVkIHRvIHRoZSB2ZnMtNi4xNi5t
aXNjIGJyYW5jaCBvZiB0aGUgdmZzL3Zmcy5naXQgdHJlZS4NCj4gUGF0Y2hlcyBpbiB0aGUgdmZz
LTYuMTYubWlzYyBicmFuY2ggc2hvdWxkIGFwcGVhciBpbiBsaW51eC1uZXh0IHNvb24uDQo+IA0K
PiBQbGVhc2UgcmVwb3J0IGFueSBvdXRzdGFuZGluZyBidWdzIHRoYXQgd2VyZSBtaXNzZWQgZHVy
aW5nIHJldmlldyBpbiBhIG5ldw0KPiByZXZpZXcgdG8gdGhlIG9yaWdpbmFsIHBhdGNoIHNlcmll
cyBhbGxvd2luZyB1cyB0byBkcm9wIGl0Lg0KPiANCj4gSXQncyBlbmNvdXJhZ2VkIHRvIHByb3Zp
ZGUgQWNrZWQtYnlzIGFuZCBSZXZpZXdlZC1ieXMgZXZlbiB0aG91Z2ggdGhlIHBhdGNoDQo+IGhh
cyBub3cgYmVlbiBhcHBsaWVkLiBJZiBwb3NzaWJsZSBwYXRjaCB0cmFpbGVycyB3aWxsIGJlIHVw
ZGF0ZWQuDQo+IA0KPiBOb3RlIHRoYXQgY29tbWl0IGhhc2hlcyBzaG93biBiZWxvdyBhcmUgc3Vi
amVjdCB0byBjaGFuZ2UgZHVlIHRvIHJlYmFzZSwNCj4gdHJhaWxlciB1cGRhdGVzIG9yIHNpbWls
YXIuIElmIGluIGRvdWJ0LCBwbGVhc2UgY2hlY2sgdGhlIGxpc3RlZCBicmFuY2guDQo+IA0KPiB0
cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zm
cy92ZnMuZ2l0DQo+IGJyYW5jaDogdmZzLTYuMTYubWlzYw0KPiANCj4gWzEvMV0gZnM6IE1ha2Ug
ZmlsZS1uciBvdXRwdXQgdGhlIHRvdGFsIGFsbG9jYXRlZCBmaWxlIGhhbmRsZXMNCj4gICAgICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy92ZnMvdmZzL2MvNjYzMTk1MTlmODlkDQo=

