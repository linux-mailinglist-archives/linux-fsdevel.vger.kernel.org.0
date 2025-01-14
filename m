Return-Path: <linux-fsdevel+bounces-39124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA05A102E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78C2167EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC93233539;
	Tue, 14 Jan 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="N1JzSope"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76722DC20;
	Tue, 14 Jan 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846529; cv=none; b=dCvO+Ohk/KXRlrh9j8ukl/nM/tOjENcOmoAxGYnSnoLWRv4prPEX7emD9ydRc/Y1BrMWwpExuVynGlLKKI3JdOkN6csnSVkySvE2xRIa0syjKScDWFudEDU7LokG2FK0fADSYZPHejrWEBNARCjO+r2ps7h6W/ISURAsRB0XHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846529; c=relaxed/simple;
	bh=TH2vAVb5AYL70xvYA6GVhSGcPYch4D4kepXt8XTpHNg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YBX5p12Hd+on7aFLUyE8d6jISQBGxwLPt1BpXcS2tp3RuPwUAdsegBAfjuxgGIe8HiXgY6AncNaK/xG1QKnUgvf4GlFloCvkembsKB81myemw4jjOGilr5iWlDqsNAcabPGdQsCAX3BgS4ikj44J5FOiLEmijmv0900XqNHp7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=N1JzSope; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736846481;
	bh=TH2vAVb5AYL70xvYA6GVhSGcPYch4D4kepXt8XTpHNg=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=N1JzSopeTIqd0x8cfhJAR+bwkIh70Fo657j8vMJYySee64oPkRjMMwnZHPxsT16qM
	 2wA6REAwAuo7qXPpYr+5XZqeXe8kkM5n8hrO2tg4Gs6VkZb2ZcnrW/Yrrq4/DkR7MX
	 53zia2a57EWyA43UrKHgZnhmfhgMbtpFT2g3dZbE=
X-QQ-mid: bizesmtpsz9t1736846475t2a83y8
X-QQ-Originating-IP: IJ7GpVF/84LQcIPcLPnMYjf94O3hwgJRK67umQ0/mZ4=
Received: from smtpclient.apple ( [202.120.235.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 17:21:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10348364636119842022
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
Date: Tue, 14 Jan 2025 17:20:58 +0800
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9B23942-DDAF-45D5-A805-BCB40FBB9E5B@m.fudan.edu.cn>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MOes/g5XSnTfvRRouqbjJDa/YxzP3nIBkAMbAmK3SmdTib5uV0xKh19Y
	j2eEvZ8us+UWYJgXpsgGhd57Shji8uhwbpSb0cGAyIWc1IShcx+2kfuF1gbD/90ULk5f4aD
	JkZ4bvnEA/r5Lr3PkUBfwqlP4zdWlx3dGsIXRdyIOy7Aq98M1GzibKsiChmuumEbmPobmIG
	2AFrwDItjyEksmfbiA7WLO65V5L0sFp4XPwld+8ihtEBjBaEl1htH/JpmOtoY5PFIr0311G
	XEuCRVVKxILg3iTZ8kuTTKUGojJLnKeZJ11Ot1govlk3LR1aC9x2BY8KXsliNK9/mw4EbJY
	iekjTGcaEGjDpi9842Qhf6EXpQ0QphxpdN98ZmFQ7BgNsf1BnnE8zq96iqdXyddCYaM2QKA
	UDso3YZijz9NHYc8OOWxV8LSZWmB9FMK3uvy08q9vHTyWDy5SKzrQZeYi8n1azIOhHVGlqt
	fOEUnf6pIAdWBuxqTGijcAq2TR6KCB6sK3PYuSwCflXRFeKVEb2oAgEwoBjw6ZHBqmvCQSz
	E5kzBuisFLrU81Lvf1Uso2T76oTdGzaSgXTWwkSSb8HaR7fVSlZYXhlYukyqC8XDclfDBzM
	YnxARMDUQHIt4CKBGrl+m4S+ubMMnKwofuJ9if19mFtpuINnKdns1BqFa/bt3/Q4vIt/MjD
	hoVljcRF/JEkRTP9HuD9hbjMQeN9TEUMjvYr4OnIVpijt4kBZ7wscHyqWZVo8nLVOdGJtI6
	pDlj4W7Aqe7CW8pR5dD9VrrmTHQ37jjrp2LDS5dAk9jCWr4qoKGekRSJKZKwuenDLGRo95c
	Zx0a8YLoLVtpngfaomUMnraLGv2QXtDEFmTCkLNfQVVPPGlaJxVPL3spCzIqTlU0Amf/3R4
	inTlMcow5ZiMT3G5uU+NGH+CMJbrmG9kJsu+8iZtMOq8Odwg8Kc6QS/AJ9kjEuaZn8sLkXb
	W9l50GUFPn6/gd8XncSI70fwflgMJH8vZdMNomkC3LCRzG8ZB+P+wvC8i
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

>=20
> I suspect the bulk of the reports are coming from academia
> researchers. In lots of academia papers based on syzkaller I see "we
> also reported X bugs to the upstream kernel". Somehow there seems to
> be a preference to keep things secret before publication, so upstream
> syzbot integration is problematic. Though it is well possible to
> publish papers based on OSS work, these usually tend to be higher
> quality and have better evaluation.
>=20
> I also don't fully understand the value of "we also reported X bugs to
> the upstream kernel" for research papers. There is little correlation
> with the quality/novelty of research.

It's nice to have a statement from a report. Because academics may not =
be familiar with the process of reporting, and based on some of the =
wrong experiences with past Mailing lists, they may continue to use it =
and make this redundant process reproduce over and over again. I =
personally support this.=F0=9F=98=82

-kun=

