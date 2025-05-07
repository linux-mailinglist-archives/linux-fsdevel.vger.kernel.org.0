Return-Path: <linux-fsdevel+bounces-48341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEDFAADC25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45261C21E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADAB211476;
	Wed,  7 May 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="I866g5h3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFA748D;
	Wed,  7 May 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612249; cv=none; b=M8RgTVWNOwGBfdeVr2VARM5ztEx8MsSCi6vC/wMJntH/wxolbubE4LeD97POAwRZBXBWgB8JwXx0r2IYzNGYLOW67HWpgu7/fnNxQLTsmoqE4RMVqslsyOBZ/vVD+PzIVqB56i5iPfRVTn7yZZn96z5sePzMpJLIdtchRQwc+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612249; c=relaxed/simple;
	bh=ONKdy+w9gyMKFQEXUyZDqN8rmz0A1AXazcIgetb64o8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sr5DXATrGqANmPhl9yoQ6BYjqYL70l4h1K0K7Fv4rZSh9kNCVgrzRU2T+77OSuXm2Iv/E9JWa2OciKMVWp5Cn2CKU5rWYloY7QoruX8VPdsv+BmaNeatFEqFFvlZZK2/8oFZDkb7URceEgTANxhUk3GnZD3tUnmCLq/hO12n+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=I866g5h3; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1746612214;
	bh=ONKdy+w9gyMKFQEXUyZDqN8rmz0A1AXazcIgetb64o8=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=I866g5h3l/88iOQEgAMIP3SJI7+5Lxy2XkSVjn0tsufAFwHU6QJwDUQ9hGPWuEOnB
	 72E7OjFDpZHXlBra/RKyh7aoN/88Dk1v51xMEqu0wl5eQLNhxWt3FTfoSEUJxkkTFD
	 WksD/sHRvwOp3URtIW2mDkAXozpI1HxxLTXxrMTM=
X-QQ-mid: zesmtpip3t1746612207t5145e6a1
X-QQ-Originating-IP: YPTKlIROWMCFYMZ9/Uwc5rfUQLWe4dBAq2hngwjFGs8=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 May 2025 18:03:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4692290289710788905
EX-QQ-RecipientCnt: 8
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x268/0x290
From: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
In-Reply-To: <d8f947a94233710bffa498d9770ef23469aff073.camel@dubeyko.com>
Date: Wed, 7 May 2025 18:03:15 +0800
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "baishuoran@hrbeu.edu.cn" <baishuoran@hrbeu.edu.cn>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5703A932-C5B0-4C98-BC5D-133F6E7943B3@m.fudan.edu.cn>
References: <TYSPR06MB71580B4132B73E43C0D86517F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
 <1058be22b49415c3065ced5242988ff81e2e9218.camel@ibm.com>
 <d8f947a94233710bffa498d9770ef23469aff073.camel@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MQCbYOYzcCnkjtU6IFXzJA8EYQM7wP8wWlxy07rqQY2iix/Im8i4gSCj
	oybCBnJdBU3D3h96YspfxxP0mLb8GhL2THPbbhXMyM3a/aKYrYAA8mcf2eWM4k+PQ6CkTcp
	cN/lkLUStIUlxKIlVRJsgdTZ31DOKOIhQtuIJ9+4qc503zODfMJxcGQE1+tjpgmonRfNGCx
	JblB4b/G4bp5ft4pAKhfteyrXN1qDCiY5EEuwP9ZXl75qHtNvWTOAMZ7iwQjycpEI1mZf6D
	b+T3pEz+bTq5MHVAFSH6aXCojDGahKnxY2e3Wm5qqpnvuKaNieSdMr50+GKKr6iuVjoI8q5
	bcR07fKUl0/pnNwbcEiNX/LfMinnEM4fyhPHNBp6QyRycbmsC8ERQxMuvxfybGxa3A6amPe
	U6a3hCMrnYcsqosOygDoHnRd9tZFmjA9MjDonVNblb2VAm6W75jrHkrVgYWkEaD4dcntwVw
	bHX0E0DogI+WuUvKIdUwSaIM5I1UOvsuqxtVOGGdJfkzqd7Og4BSAG19P8vp0I7U6dRqJ8E
	UNstEJRi9muQLiFnQKMIESj9WYe+wZbg9GkrFvQdsLSaZlXBNNF5Bog/JhLDrgxZMiCuALc
	ISNWJ8vQQfUTzB9Ocx4+KOgWUGAXPps2AhoXKP00EAFr3MP3/sciA2hSksT1DgQufk1J79s
	LOelol/VsomWcxAWvj8mKp9bkX+tU5SBgtT7dynIgXJ+F8CpJvQ2EIsW4iTB7SH4v0g6X8D
	6CBTCxecyGDSzAy5W8UfPTsYkQRBKoYmd5avkxYSCC5SEw2ZBAdL0SJlsZjVRFiLQEeWNRj
	+KepM34fm7CjhOnHKZOx7rMu9IVeCx3taF9cY64+9jnSn3SJgSllZldES9Huj2qPBSJli9l
	sEqKluU0n7Bz2bZM8Kyj7Y0psyGKgcUFmYq8J86qDpr5muwAwEMz9CHOWgaIPJi8VTeZsqU
	bgThA+3HW8sfvbhr28/0l9Vlhy9dDK2OpyBL2D2bA7MHPYrUPNhLu3Ae50/hkaeBTjBSdr7
	BzT3Npx/O6OmOFT/YsnazI3bivms8=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0


> I have the fix and I would like to check it. I am trying to use the C
> reproducer for triggering the issue. Probably, I am doing something
> wrong. I have complied the kernel by using the shared kernel config =
and
> I have compiled the C reproducer. It works several hours already and I
> still cannot trigger the issue. Am I doing something wrong? How long
> should I wait the issue reproduction? Could you please share the
> correct way of the issue reproduction?
>=20
> Thanks,
> Slava.=20
>=20


Hi Slava,
Thank you for taking your time.

We originally obtained this issue's syz and C reproducers using =
Syzkaller's repro tool (refer to the URL below). The issue was triggered =
when we ran the syz reproducer through Syzkaller.

Url: =
https://github.com/google/syzkaller/blob/master/docs/reproducing_crashes.m=
d

Syzkaller also provides syz-execprog to verify whether the C program can =
trigger the issue. We are currently in the process of verifying whether =
the C reproducer can reliably reproduce the issue. Please allow us some =
time to complete this verification.

We'll follow up with you once we have more concrete results.

Best regards,
Kun=

