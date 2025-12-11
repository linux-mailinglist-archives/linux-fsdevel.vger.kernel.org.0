Return-Path: <linux-fsdevel+bounces-71118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C921ACB60EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 476323001BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02431352B;
	Thu, 11 Dec 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="VE5Xb0N5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com [117.135.214.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510231328F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460433; cv=none; b=OPGTgz6p7TT8mhhRYGlRFRpUmYlfBIcYzB/da16RITd0fB3H8jdbr71e35fOoKOykYhxn7Q4nd9Miwp4f5qpeg06vcxkZZ3epzFeaKiQIdXhYz4ujOuZ7mbjX1paLWm8jKv+Ay+vlkqsYGtLGP6mhqIqvk54GcNnkeIsalm5ORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460433; c=relaxed/simple;
	bh=Sp4Fe1dJUGP9wJoLc92dWzO3BUN2bJkPT9GQyOlZwCc=;
	h=Content-Type:Message-ID:To:Cc:Subject:MIME-Version:From:Date; b=oMpxP5rU4UsJlYUmQxGAVNnt9o+xGNn5x/YQmZpQjISovb+MOFVOAc/aTG9IMAQj6itFXz1dtlIKjmVDxHoYkyoGrlCkhbfvnkOIftV0Hhws0/VB+JMDRy4fqf6+J9jvXgenFqQYLv8k2iASQyyc2vFEV8D95K9RKvg3jxaaaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=VE5Xb0N5; arc=none smtp.client-ip=117.135.214.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AA*AfQAzJ9UTkMPQtLhvWaq3.1.1765460422030.Hmail.2200013188@stu.pku.edu.cn>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	viro <viro@zeniv.linux.org.uk>, brauner <brauner@kernel.org>
Subject: =?UTF-8?B?W0JVR10gSHVuZyB0YXNrIGluIHBhdGhfb3BlbmF0IChwb3NzaWJsZSByd3NlbSBsb2NrIGludmVyc2lvbik=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_MAC_1.56.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 2200013188@stu.pku.edu.cn( [210.73.43.101] ) by ajax-webmail ( [127.0.0.1] ) ; Thu, 11 Dec 2025 21:40:22 +0800 (GMT+08:00)
From: Tianyu Li <2200013188@stu.pku.edu.cn>
Date: Thu, 11 Dec 2025 21:40:22 +0800 (GMT+08:00)
X-HM-Tid: 0a9b0d7f5c4009b6kunmd0b925ba6938
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTv2670zqzAM+7RIKOqUHUUyjnjpPRHs8I0th+
	pfToBLAHHPQiSvzTUYtFIRevI3h0H/rL8uiegUHR6ncan8g2rCDfuN4NnB7NuCz/pEOsh0h06tY6
	DNg6VLCaERPHZUYBx5sFyk7R3o0B88Kdr218k=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGU5JVkpDGExJQx1JGUoeGlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJSktVTEhVT0hVSktKWVdZFhoPEhUdFFlBWU9LSFVKS0hLT0NIVUpLS1
	VKQlkG
DKIM-Signature: a=rsa-sha256;
	b=VE5Xb0N5Iv/97+A/uNCYT6vb58KhuJsouw0RHID6Od0oM19HJPT84tI758xsi3gXhwWIqp7Avg80k6emiOTLgkZvGVAGuM+jf/utqkI2l8PuFmHVl/Yi+wcZs/g6P5BnxlBEWYP0W2BGdtWpYM52b6X/XLSt42aIU4AItu27c48=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=Sp4Fe1dJUGP9wJoLc92dWzO3BUN2bJkPT9GQyOlZwCc=;
	h=date:mime-version:subject:message-id:from;

SGksCgpJJ20gZW5jb3VudGVyaW5nIGEgaGFuZyBpbiBwYXRoX29wZW5hdCgpIHRoYXQgYXBwZWFy
cyB0byBpbnZvbHZlIGFuIHJ3c2VtIHJlYWRlciBiZWluZyBibG9ja2VkIGJ5IGEgd3JpdGVyIGlu
IHRoZSBzYW1lIHRnaWQuIFRoZSBpc3N1ZSB3YXMgZmlyc3QgZGV0ZWN0ZWQgYnkgYSBmdXp6aW5n
IGZyYW1ld29yayBvbiBMaW51eCA2LjE4LXJjNiwgYW5kIEkgaGF2ZSBjb25maXJtZWQgdGhhdCBp
dCBpcyByZXByb2R1Y2libGUgb24gTGludXggNi4xOC4KClRoZSB0YXNrIGdldHMgc3R1Y2sgaW4g
dGhlIGZvbGxvd2luZyBjYWxsIGNoYWluOgoKICAgIG9wZW5hdCAtJmd0OyBwYXRoX29wZW5hdCAt
Jmd0OyBvcGVuX2xhc3RfbG9va3VwcyAtJmd0OyBpbm9kZV9sb2NrX3NoYXJlZAoKVGhlIGtlcm5l
bCBsb2dzIGluZGljYXRlIHRoYXQgdGhlIHJlYWQtc2lkZSByd3NlbSBpcyBsaWtlbHkgb3duZWQg
YnkgYSBzaWJsaW5nIHRocmVhZCAod3JpdGVyKSwgd2hpY2ggc3VnZ2VzdHMgYSBwb3RlbnRpYWwg
VkZTL25hbWVpIGxvY2tpbmcgaW50ZXJhY3Rpb24uIFdoZW4gcmVwcm9kdWNlZCBvbiBhIHRlc3Qg
bWFjaGluZSwgdGhlIGNvZGUgd291bGQgc3RhYmx5IHRyaWdnZXIgYSBzZXZlcmFsLW1pbnV0ZSBo
YW5nLgoKQWRkaXRpb25hbCBpbmZvcm1hdGlvbiBpcyBwcm92aWRlZCBiZWxvdzoKCk1vcmUgaW5m
b3JtYXRpb24gaXMgcHJvdmlkZWQgYmVsb3c6CgogICAgS2VybmVsIHNvdXJjZTogaHR0cHM6Ly9j
ZG4ua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Y2LngvbGludXgtNi4xOC50YXIueHoKICAg
IEtlcm5lbCBjb25maWd1cmF0aW9uOiBodHRwczovL2dpdGh1Yi5jb20vajFha2FpL0tDb25maWdG
dXp6X2J1Zy9yYXcvcmVmcy9oZWFkcy9tYWluL3g4Ni9tYWlubGluZS1jb25maWcKICAgIEtlcm5l
bCBsb2coZnV6eik6IGh0dHBzOi8vZ2l0aHViLmNvbS9XeG0tMjMzL0tDb25maWdGdXp6X2NyYXNo
ZXMvcmF3L3JlZnMvaGVhZHMvbWFpbi81ZDlkNjg0ZTEwMTg0YzBlODNkNjE1NDEyYWJlYTVmNTk1
MzdmZjE4L3JlcG9ydDAKICAgIEtlcm5lbCBsb2cocmVwcm8pOiBodHRwczovL2dpdGh1Yi5jb20v
V3htLTIzMy9LQ29uZmlnRnV6el9jcmFzaGVzL3Jhdy9yZWZzL2hlYWRzL21haW4vNWQ5ZDY4NGUx
MDE4NGMwZTgzZDYxNTQxMmFiZWE1ZjU5NTM3ZmYxOC9yZXByb19yZXBvcnQwCiAgICBSZXByb2R1
Y3Rpb24gQyBDb2RlOiBodHRwczovL2dpdGh1Yi5jb20vV3htLTIzMy9LQ29uZmlnRnV6el9jcmFz
aGVzL3Jhdy9yZWZzL2hlYWRzL21haW4vNWQ5ZDY4NGUxMDE4NGMwZTgzZDYxNTQxMmFiZWE1ZjU5
NTM3ZmYxOC9yZXByby5jcHJvZwogICAgU3lzY2FsbCBzZXF1ZW5jZSBmb3IgcmVwcm9kdWN0aW9u
IChtb3JlIHByZWNpc2UpOiBodHRwczovL2dpdGh1Yi5jb20vV3htLTIzMy9LQ29uZmlnRnV6el9j
cmFzaGVzL3Jhdy9yZWZzL2hlYWRzL21haW4vNWQ5ZDY4NGUxMDE4NGMwZTgzZDYxNTQxMmFiZWE1
ZjU5NTM3ZmYxOC9yZXByby5wcm9nCiAgICBHQ0MgaW5mbzogaHR0cHM6Ly9naXRodWIuY29tL1d4
bS0yMzMvS0NvbmZpZ0Z1enpfY3Jhc2hlcy9yYXcvcmVmcy9oZWFkcy9tYWluLzBmODVmYzY2MWFm
MWUzYzY5YjI2Yjk3ZWFhYWE0M2Q2MjlkZTQ0OWMvZ2NjaW5mbwoKSSBob3BlIHRoaXMgcmVwb3J0
IGhlbHBzIGluIGlkZW50aWZ5aW5nIGFuZCByZXNvbHZpbmcgdGhlIGlzc3VlLiBUaGFua3MgZm9y
IHlvdXIgdGltZSBhbmQgYXR0ZW50aW9uLgoKQmVzdCByZWdhcmRzLApUaWFueXUgTGk=

