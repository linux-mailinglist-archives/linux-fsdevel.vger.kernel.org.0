Return-Path: <linux-fsdevel+bounces-39386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7DA136C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F3B1889F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B01DBB13;
	Thu, 16 Jan 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="fuSneDYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7E1D9A50;
	Thu, 16 Jan 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020314; cv=none; b=rQ2l7zojQHfvp6npHC+JRCpKw8Rc5gNwYQMaqogmnx3Jds5883GOODeZwyCeoE+2vB9kGxgNR17fRAcL/XjTqDGoL9aXr72FH9FkaicjGPkz9FG+6/zuY1gEQ4Q6GXEWA65FFYzt4XUaiuf9iEUj8X+I6B2SRs6WaPY1lidersI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020314; c=relaxed/simple;
	bh=rQg18MnOpi0iRL1xsBPEEr2agWJPlJAJAhkSX+nBeHc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BUldxtPX0uwry+Dbiiu04U/nOeyGDcsHYLJq4Bvy2+25gOW/XQxzururdI+LOALU9/De46Jk+8ulqRDG8XZ4WLS2xUDgOZ3/f7Yr6sJZacJGfg4mtnEH0kjBiqtleDkISvD/L9bIn0av54KgZ1ILkxxM/lNuzRotV13/+drL6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=fuSneDYS; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1737020263;
	bh=rQg18MnOpi0iRL1xsBPEEr2agWJPlJAJAhkSX+nBeHc=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=fuSneDYSyV/ozY96K4KiD4/MRfX8RUn4pECH5JaBAwYrLd7sZHB8qkQDKIJvAAO7X
	 IeaSr9PGsWeTpMgYxOjMZd74ReiInc6Apv6gg7kfJiry/Nghs7Y+nx2ey7XMti5s3U
	 jgjYGCd4fMn2I83t+AGRXOS/uIZ07kspFTlz7lF8=
X-QQ-mid: bizesmtpip4t1737020256td9b9rh
X-QQ-Originating-IP: t5Ya/sP/koFKq0GD8TMRYajOAfezgqAiPbiwx1UABic=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 17:37:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16457540514336954107
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
In-Reply-To: <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
Date: Thu, 16 Jan 2025 17:37:24 +0800
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BCDEDB6-7A92-4401-A0A8-A12EF2F27ED0@m.fudan.edu.cn>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
 <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmPNY57tR1XnO8H0pthGhVLod8vXAp1LSKq+MbFPaCLkTpZDqRV8l+za
	P7SjsQdB9Y2JIZgaDfnJ3zHWd6StJh1gOFPPopLNN5+CSzWy2NiDXBg2vTrWCYvH6IIecQa
	72DGD72T4jKSgaXCPnaWwdUnAB0/6+zA92NvNiA5NqyQr9yTKE8ouIqWo837MVwlBQFz40T
	54gmdPJF1YaW0ARCDg16GBcwtnZqJuCkK+3tNXs7f6Zj7Iub1O2jKbQqzELkR0HHDjue+nh
	C6EtCcy48Vebmx9DzINaCwvO/SCpqU+qvkB5REU6M3L0zT37RZzKsxX0WmVFj5jAJAlObDo
	rlt5+Vltw0ZtXD/URqoFgp/OxkVx4TzxheLE7mUHRI/OdMzeULtT/uBl7YrLmqeG1+XRNOn
	+SFSeTj41FfXgkFnvEtkLgJ/Ji5dZINWqon9AUNdfAkNUIkziiCxJjqxdwYQR0fwZtEWtI/
	bpIsqwgd0pTZ6nRJFC467zWibxxEILjwFQnS51ysUUWZ4h0xUb90luj9C2Xn6QqlC2Su9VR
	oEDtS241McGGC13wIlhRrPj3h7vIg/bntQ/6PUopj1v+N9s0moTeyiqpBcLY5p1gRAB7tRC
	qBWsJQGZ4/WF4hBffyHWmDwoxlBv9gX1NoQHjfxEUzqEUt5eKDvU1GC41IKQnSQxE6h0KU4
	a1NdSLPkhQrBzsb1LOY9fTYCkkpKBV91gGzY4p/R8u0B3/MQ8jBLYt8eg0INAf+C4MIoF5x
	nvuV28CjANxWFx2sPe1F5uvuYxBnLXUe8eOLNg60ICK5bVLFSbPDg3vhc7VxWq+JaSaqRWV
	b3XWRgqOV/05TMI0ruLw65yMxKh2glmiG0ohlGEdzkDcsL+ReEwbFtI5bxB2u9asZD4NCcD
	K2BBEcGH31M21uRXL+ccoxY4z2tFSC3wL8lUW8bAKC72WWp4KuSDeFnwXHLJy6FO6XWyCrF
	viammO29WMsequzFlJht+6kITxJY5aDgKV8q6v/ZkcreViI9HcdlyTDITi8XWST31p9r7EP
	6RcHYqew==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0


>=20
> Makes sense. Sorry if I came off a bit strong, there's been a couple
> syzbot copycats and I find I keep repeating myself :)
>=20
> So, it sounds like you're getting nudged to work upstream, i.e. people
> funding you want you to be a bit better engineers so the work you're
> doing is taken up (academics tend to be lousy engineers, and vice
> versa, heh).
>=20
> But if you're working on fuzzing, upstream is syzbot, not the kernel -
> if there's a community you should be working with, that's the one.
>=20
> An individual bug report like this is pretty low value to me. I see a
> ton of dups, and dups coming from yet another system is downright
> painful.
>=20
> The real value is all the infrastructure /around/ running tests and
> finding bugs: ingesting all that data into dashboards so I can look =
for
> patterns, and additional tooling (like the ktest/syzbot integration, =
as
> well as other things) for getting the most out of every bug report
> possible.
>=20
> If you're working on fuzzing, you don't want to be taking all that on
> solo. That's the power of working with a community :) And more than
> that, we do _very_ much need more community minded people getting
> involved with testing in general, not just fuzzing.
>=20


Hi Kent,

Thank you for your insights.

I have a couple of questions I would like to ask for your advice on:

=46rom a testing perspective, we have modified syzkaller and discovered =
some issues. It=E2=80=99s true that researchers working on fuzzing often =
lack a deep understanding of the kernel, making it difficult to =
precisely determine the scope of reported problems. Meanwhile, syzbot =
provides a description of the reporting process (please refer to the =
link below) and encourages researchers to report bugs to maintainers. =
However, there seems to be a significant gap here=E2=80=94researchers =
may end up reporting bugs to the wrong maintainers or submitting reports =
that lack value. This seems like a serious issue. Could the kernel =
community consider establishing a standardized process to reduce wasted =
time on all sides and prevent researchers from inflating bug counts just =
to validate their papers?

Link: =
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kerne=
l_bugs.md

It is often suggested that researchers collaborate with syzbot. What =
should such collaboration look like in terms of form and content? =46rom =
a maintainer's perspective, how would you prefer to see researchers who =
report bugs work with syzbot? Since I=E2=80=99m new to this field, I=E2=80=
=99m not very familiar with the process and would greatly appreciate =
your guidance.=

