Return-Path: <linux-fsdevel+bounces-40038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E2A1B5B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 13:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868C5161E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3721ADC9;
	Fri, 24 Jan 2025 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="Gy0W5YvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67A2B9BC;
	Fri, 24 Jan 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721446; cv=none; b=l333nKnO+AOVETk9N0ADlF2OS+aDh9wSfQZArhd7NdM+vfNtRK4DSMC69LooewPpJ/KiSXQe7lfp73SwP4nCQSe4YTDvNqhjV2yhG93XZWR6C/7hUU+x1sgb4WC7mE2yKQFdetINqDe6hpPCyzdfkGgxhkWgKzkDr3qOU+c0Udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721446; c=relaxed/simple;
	bh=G9KlpOkTJYKRq3NmnkF+XWUCbAXiWokOM6sXLcc2Kzg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SzVhiXuSJcifVWpQ6dm4G/3ZTI01/L0+DCCSmk4kvjK5ey/63BY4NCAqD1Jkk4/rBJBRfWyfMMqqIwPj6ivcX2xSI0GsTnhNo8grCVcALLONp4pwp5DL3i/fvi3h69YtUo0s8/M9Q5+WETIrBpPKBiErDsXcccy4m8xluzeqBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=Gy0W5YvU; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1737721396;
	bh=G9KlpOkTJYKRq3NmnkF+XWUCbAXiWokOM6sXLcc2Kzg=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=Gy0W5YvUVyZLDgtu/jOcXH+B5DTMQC1q4dqvVPfZfOcZE1PYKA982QhyQPR2z4L/e
	 rrm0v68PlAyfF7M5TdVuFVNM1kjYyvogoPPX4/HAAVCQM8RRgod3UebbIMp03lZFt2
	 bOLPBj2oQS3S1+EgPKcr1ySF9DWeTnvw8glDozcE=
X-QQ-mid: bizesmtpsz10t1737721390tjw765
X-QQ-Originating-IP: aIS1e1PxxtLg6N4SobOB8mrP2TAea8u6IuZiLZX3ZAE=
Received: from smtpclient.apple ( [117.188.120.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jan 2025 20:23:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10477524699845402753
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
In-Reply-To: <tkfjnls4rms7r7ajdwj3n4yxyexufrdunhgvzalegz6j35zbxm@fexthq26w7lr>
Date: Fri, 24 Jan 2025 20:22:57 +0800
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <900A37C1-9A21-46DF-8416-B8ABF1D0667C@m.fudan.edu.cn>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
 <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
 <5BCDEDB6-7A92-4401-A0A8-A12EF2F27ED0@m.fudan.edu.cn>
 <tkfjnls4rms7r7ajdwj3n4yxyexufrdunhgvzalegz6j35zbxm@fexthq26w7lr>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OHmFukASalOrJoP/yRIOxdn3fSIMbnVbqOITfOhcAgeVwKyWJSD95uXG
	VN0HcDY0i4duP7a7wzamf95CZk21l3JjQ4qaSHvKBUxS6x1UpqYaYLJd+C3eS7yubhwiMOZ
	9btoYBeIWTDhMRmbwcQpWshYtQ8X2TNT++T8nnyeH8HN2U2FxWIgmmbpCl1fsiMwb32Bqqc
	5OPMfYgDrVXRq/t+kxYyA4i3oTTntS+fU2lRDfBow27KlqQprl0pfo0XmqCULkL6D+Dqb4E
	Fj3APnvOsKNLAP4XTkl7lZMrtAaLjlCLY7Datl2TU+1osvNwvdR+nq0uJeOoDQUAKxq6AfE
	RTpWUsFTxa5ioHdi6/QNJ7XY4HRRQtSgEq9HJ1tnvbNseC/Fa4dXVPCzaEiDLZqz59t7Ws3
	RuAiEhad8E6+rzeOhUUvteqVREgg0JVQcE5YvZI5P6Fxf+N0K3/ruEkyoNRf+R/AmnhY0xi
	1l0xtIj1s1tHP7DpJsj7yiCyvcL10ZYhbaVRLayKSa9OoDd3sD6GHOaVg0V5YgpeGQX0goP
	HHYb3oGcpMHL3rT9sb50uS2giG6REdrEuwU/WIOfw92aWqOkAzTRe3qzIQxmqO9QDHjR9bE
	5VUmnHMyzj5N6pwPlHaHzZVN3U/DsIBh0fc611cjnhmHr1/hYF419S7BaIAgUnZxWjnTcqQ
	8BxHqqyYTHJEYh0ILa7+OhM0LEHZQnU++HgCZln9vh3jqnz6ma6R544h44JnBvXFtPgfmtB
	/MUI31N6obyVzOeX+5ytFVFGf0NcL+wZDZvhX7E8F/XP8Fp8g/l7nJUTFt6dxfYuXh/yUZh
	OcfoYqSmsEwLgYPHZLAwyvGyLN8xTA+WZEg06kSojVkRCxG37QFY7BYS/nP1D5oufnR9HUl
	OfkYX5kQvCeEg8r5EE4DMT/KbGjnh7Itrdkc0sNeDQ/rqIP6AKeX8q5bceyae1ytcPlIFlo
	4GO0r5kTMTl4moa2jRgYVfOKQ/HTuPeBorakpqihKodkgxJVoeXolAg3xKvS9Uojd5AESpr
	eyZW8AoBd403pHPRuP
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0


>=20
> Again: the standard mantra is "work wth upstream". If you forked =
syzbot
> and you're working on fuzzing, syzbot is your upstream, not the =
kernel.
>=20
> If you work with the syzbot people on getting your fuzz testing
> improvements merged, the process of reporting the bugs fuzzing finds =
to
> us kernel folks won't be on your plate anymore, and you get to focus =
on
> the stuff you actually want to be doing. :)
>=20
>> Link: =
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kerne=
l_bugs.md
>>=20
>> It is often suggested that researchers collaborate with syzbot. What
>> should such collaboration look like in terms of form and content? =
From
>> a maintainer's perspective, how would you prefer to see researchers
>> who report bugs work with syzbot? Since I=E2=80=99m new to this =
field, I=E2=80=99m not
>> very familiar with the process and would greatly appreciate your
>> guidance.
>=20
> Talk to the syzbot folks, they're a friendly bunch :)
>=20
> The main thing to keep in mind is that it's never _just_ about getting
> your code merged, you need to spend some time learning the lay of the
> land so you can understand where your work fits in, and what people =
need
> and are interested in - you want to make sure that you're not
> duplicating work, and you want your code to be as maintainable and
> broadly useful to everone else as it can be.
>=20
> Have you shared with them what your research interests are?


Sorry for late. Thank you very much for your advice, we=E2=80=99ll try =
to work with the syzbot community.=20

But an interesting interaction relationship is that for researchers from =
academia to prove the advanced technology of their fuzzer, they seem to =
need to use their personal finding of real-world bugs as an important =
experimental metric. I think that's why you get reports that are modeled =
after syzbot (the official description of syzkaller describes the =
process for independent reports). If the quality of the individual =
reports is low, it does affect the judgment of the maintainer, but also =
it is also a waste of everyone's time.

This seems to be a problem that exists in the linux, syzbot community =
and academia=E2=80=A6.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94
Best,
Kun


