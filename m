Return-Path: <linux-fsdevel+bounces-57446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C04B219E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 02:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7621D624392
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E892D46D1;
	Tue, 12 Aug 2025 00:44:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE531CF5C6;
	Tue, 12 Aug 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959447; cv=none; b=QmJfUq414fe/QZZdOt78yZt/TPWmikTGzLaHlRpEBCxc1pGyLhuIEhBls0kce45C0qYMWuQzyOEU1D1r4h7micf6tXqPrvomUI+ss6jMNmoeh1o1kzNlKIyiduTkLohnNovu/whWWo9LmcdkOnCJzOJT0ATt/J+VpDsZcl5g/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959447; c=relaxed/simple;
	bh=mRAWBIV95BkuutBdA/+h8mf/Vigka9Kkrl/7nYZrY5w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lY+gvG8ruOCaDOpxLYlGqaCX6kZ8dBArxGq5SJrEy4oF7oh3bHWp5igl7km4AwEk+D16nnemghOT2CNX4JRRwUDXU1nivQu5GqTg2wzxxzcV7y23FEL0NlEYH4X5G0gdvDpOElE/8S6eJcSh/r5KLAuxpCGQOAVvOuTaXkJIQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id 85A5F1E3AE570;
	Mon, 11 Aug 2025 17:44:03 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:44:03 -0700 (PDT)
From: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Message-ID: <145928469.642.1754959443409@mail.carlthompson.net>
In-Reply-To: <28dbd3e0-8d5b-4dfe-a7e7-3a73347480f6@tnxip.de>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <514556110.413.1754936038265@mail.carlthompson.net>
 <28dbd3e0-8d5b-4dfe-a7e7-3a73347480f6@tnxip.de>
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite


> On 2025-08-11 11:40 AM PDT Malte Schr=C3=B6der <malte.schroeder@tnxip.de>=
 wrote:
> ...

> Frankly for me as a user who does probably not know the hole picture you
> seem to just be spewing paranoid hate into these threads which I do not
> quite understand.

I apologize for coming across that way. I guess I'm just very frustrated at=
 this whole situation and the fact that it appears from my perspective to b=
e damaging the reputation and credibility of Linux which is something I car=
e about very deeply.

And I'm angry. I'm angry because of the damage to Linux and because Kent ap=
pears to be misrepresenting events in a way that make others whom I respect=
 look bad. For example, here in this thread a key point Kent is claiming is=
 that no one has ever told him specifically anything that he's done wrong a=
nd essentially that other kernel developers are attacking him for no good r=
eason. That's simply not true. Linus has explained his mistakes to Kent on =
multiple occasions. Other kernel developers have tried to help him see what=
 he's doing wrong. Random users (including I) have tried to help him intera=
ct better with others. It is simply not true that no one has told him what =
he's done wrong.

There are many other things about Kent's recounting of events and things he=
 has said in this thread that also seem to be objectively not true. If anyo=
ne thinks it would be useful I can itemize those things I've noticed.

I'm also angry because I'm a long-time bcachefs supporter. I started using =
bcachefs years ago long before it was in the kernel. I've put a lot of my o=
wn work into running it, testing it and submitting bug reports. Up until a =
few months ago I had about 20 bcachefs filesystems of varying sizes spread =
across my personal workstations, servers and lab. I even integrated bcachef=
s as a core part of a relatively large (by my standards) project I'm hoping=
 to release some time before the end of the year. There were some warning s=
igns along the way but I ignored them because I really, really wanted bcach=
efs.=20

But eventually I had to ask myself... If Kent repeatedly brings conflict an=
d discord to a group that needs to work closely and trust each other, and i=
f Kent repeatedly makes the same interpersonal mistakes and doesn't learn f=
rom them, and if Kent seemingly regularly misrepresents things... Can I rea=
lly trust him or his code? My personal answer to that is "no." So I've migr=
ated everything I have from bcachefs and I'm angry about wasting all the ti=
me and effort I put into it.

Finally I'm angry because so many people appear to be thinking only of them=
selves. They appear to think: *I* really want to use bcachefs and it would =
be much more convenient for *me* if it were in the kernel therefore it shou=
ld be in the kernel and the other kernel developers should let Kent do what=
ever he wants no matter how it makes them feel about their work environment=
.

My opinion is that's a really great recipe for making Linux worse: Suck the=
 joy out of the other kernel developers' jobs by forcing them to work with =
someone who seemingly doesn't respect anyone but himself simply because *we=
* (the users) really want bcachefs. Go that route and valuable contributors=
 will mentally check out or worse leave altogether. It will spread like can=
cer (and probably already is). It's an absolute fact that people who are un=
happy in the workplace do worse work. Let's keep the kernel developers happ=
y.

Again, I apologize for being overly harsh.

Carl

PS: I do hope that Kent can work things out and figure out how to contribut=
e in a way that's useful for others and makes him happy. But we sometimes h=
ave to weigh giving someone like Kent another chance against the harm keepi=
ng him around does to other people we care about.

