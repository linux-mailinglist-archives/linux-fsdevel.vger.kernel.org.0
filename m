Return-Path: <linux-fsdevel+bounces-39125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD20A102FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E618883A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA63246348;
	Tue, 14 Jan 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="T/6MPyWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF422DC21;
	Tue, 14 Jan 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846907; cv=none; b=JcMXWMBFpdnaA4Lhyr+wBLZVrF9ZYK3xOXLiOdlT8hlh7Ke0LbKfSlVYtbfSXRHk80GyKCYIya4p5nnwAvchFXMrky6nv85RE05wzbjxagOuTrorQJxuBfr5IeWZsA0d4dBr0w5TcmFjwuy1ezQ6cmkuCo2ms6X1wdykvUSt6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846907; c=relaxed/simple;
	bh=xrRf/STHU4FI76n55CmKOZHnl+F1zNW7E4K/8QoRqw0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m28SL0OFSVS67Ao2LfSJpBU33Ikgz7aGohMPatH/npJWfgiwzMOhp4rQp6rHkT9IR7grZvxr629CzsZqlasfpswLWc8J8DegvjWCfBILGnAPa9GoqQAPLqf9wkMHdDLnJMIDuH9YtuXKgiBVjAwZJCBQtYWNXyxXCWKr1mJl0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=T/6MPyWJ; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736846873;
	bh=xrRf/STHU4FI76n55CmKOZHnl+F1zNW7E4K/8QoRqw0=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=T/6MPyWJN48ANFTLuhSUqBs6S/KW5VpV/i5ITCQ3JeUQvln+KxaPSmj5ytUOB7e0G
	 73stnV1pNBIdN2mdAu13onmjoy3IGTUZZmoUIEIpZnldDlfg8jyPXtct9UajVDwY2y
	 hcIt+k1uW/WhAV/mdjIxyZcxX62yY3WQSAL7BcJc=
X-QQ-mid: bizesmtpip3t1736846866ta2p9xq
X-QQ-Originating-IP: cr0VfyFDHnZqBzVNLZDAiWo3OGK/r1NXQUnAxuHJTrw=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 17:27:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 652092266574935630
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
Date: Tue, 14 Jan 2025 17:27:30 +0800
Cc: Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3AD44A5-CA04-40D1-B80D-82B23EB9EF28@m.fudan.edu.cn>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyTsQ4JOu2J2HM+Y4GC9kWT2eZFGRgSRJ96nz3wPukXvGnX853x3/46a
	wbM6osf70ZDXlFkfUnv0zoeSvWddl3ZdiMSnUkhGHzXIx/LIQofAsk9w77EAD1c2wqM6JgB
	XJF8OwOu5Zx8lK7HixP7hi1Qrt5N6Mojsxb5WkBp6ZzOB2T4jn2VjCvBKMasubVvdJo2LWm
	/LulTELWypG7S04ZilObUvqotRzgmWS4L2c4t5nc+6w0UqN0w77dVoW+Bx3GH53VWMWYQJ7
	ULq1T6SNwwIAQ67Z7du3uEw2jGGXew2+hmtrnScMxOjS2QJp2Scyk6WydDhFpxb1PIdp/X5
	ahygKzYzsVRxq1NvRNmtKqZ8efdqStFKNZviNzYErku/EPjPdjBJ6pyK7gYPbAJgSzMEphv
	otvRwZo+EyRX8/F5S1z3SYw6a1r+e9bK+XVfExURfSQPgACOQRhiow7BnpUoADxjU8LCygE
	NDUhnyz3YkAty2mHKq2UT3/iGJLcQ4u5Feeo0wLM9MfV0GPutteixRJM0+eQ+UeiMBxHU2J
	d/UPpmVHesaGBuamq/a41M+Ejw1WzRcSHT9g9+jr5wUnS5DCBDFbPB/6Z5QDx7y5JBuqWrY
	Fvp1NOuUDVOswZ993Be9/pavmktewFn8ENiQ3jsVTkTmriBFljKOXPBAetRFFuSbIViAQ5h
	SlQPMSCBF9FLNMYxLY1iB15lU6BqdHfMLtLzb1yMW3M9WcMxoTvVL1RoTtqNyTAwYGzd+Xy
	KAUTokBrUt4p5iwN+utzqRLPxYoS/yClph3Af7DURyA6gdNcmnT4Bb/PqYX+K14XnecSyng
	RqPPD1Xle0dIWMFIEtRFcH3k7raD0kNn8TTEE8D7Owa+Xza5s+SuvthWSf7j6HObmCxStX3
	njBxdgRy7atBEoTToupPP+iI5B/+2/UWGb+yCCn1SziMeO22Y6MgUh+deZ+UftflcblJoWG
	pOx7Ib1/MITMSdEfyOAXLQzoIZRhBFeWXMfEhpaFdOVXcp9eyvS/ouKiB0NB52SrPUGlkBE
	wt0YErTbYRfX2OGIGBWwTZwPTsd/M=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0


>=20
> Is there some political reason that collaboration isn't happening? =
I've
> found the syzbot people to be great to work with.
>=20
> I'll give some analysis on this bug, but in general I won't in the
> future until you guys start collaborating (or at least tell us what =
the
> blocker is) - I don't want to be duplicating work I've already done =
for
> syzbot.

Thanks, no political reasons, simply just researching this area and not =
familiar enough with it, I'll keep an eye out for this later.


>=20
> We need to know what the other threads are doing. Since lockdep didn't
> detect an actual deadlock, it seems most likely that the blocked =
thread
> is blocked because the thread holding the inode lock is spinning and
> livelocked.
>=20
> That's not in the dump, so to debug this we'd need to reproduce this =
in
> a local VM and poke around with e.g. top/perf and see what's going on.
>=20
> I've a tool to reproduce syzbot bugs locally in a single command [1], =
so
> that would be my starting point - except it doesn't work with your
> forked version. Doh.
>=20
> Another thing we could do is write some additional code for the hung
> task detector that, when lockdep is enabled, uses it to figure out =
which
> task it's blocked on and additionally print a backtrace for that.
>=20
> [1]: =
https://evilpiepirate.org/git/ktest.git/tree/tests/syzbot-repro.ktest
>=20
>>=20

Ok, I'll try it with this tool. For now, we are experimenting based on =
the early November 2024 version (df3dc63), let's see if we can debug =
this tool of yours.=

