Return-Path: <linux-fsdevel+bounces-31100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8510991BC2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 03:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670751F221A4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 01:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A61E545;
	Sun,  6 Oct 2024 01:27:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7274C74;
	Sun,  6 Oct 2024 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728178050; cv=none; b=f4vLZ9n3P+T7dRkpcrRqIF1GkP3GnXLRBdl2xnFvdElh6/hFFyPFkt65l2MUyEx/iCJQT6aCpSZD33aJhFR+vSZkuQnGCWEM+VWP4wPm50b2Dgaguj2BPNZv6ELNRP2lruo5tltgcLL9kVs0t3yR0RDSU428Gkgv0p7tA8SlDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728178050; c=relaxed/simple;
	bh=AjcyHu2H/NRbcIb6sXYJSlea2CQS0l+v/PIIAVpCZj8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VplkTr1EXuLHo39J+fLylGt16Pqz/QJgDBhTY7tkSEYe6G98OtsS4fX4vzCZ4hqWS6J5qsUXn9J3LnB4O40jtCjcXMcC1514QSHVNAzW80UJXYsl7+udOd4m3R8CVazzSSJhqowOjyky2s5Rl2VA4JOCF0I3wz30a8dWa7tOxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id E9AA41014EFB1;
	Sat,  5 Oct 2024 18:20:53 -0700 (PDT)
Date: Sat, 5 Oct 2024 18:20:53 -0700 (PDT)
From: "Carl E. Thompson" <cet@carlthompson.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <345264611.558.1728177653590@mail.carlthompson.net>
In-Reply-To: <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
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
X-Mailer: Open-Xchange Mailer v7.10.6-Rev53
X-Originating-Client: open-xchange-appsuite

Here is a user's perspective from someone who's built a career from Linux (=
thanks to all of you)...

The big hardship with testing bcachefs before it was merged into the kernel=
 was that it couldn't be built as an out-of-tree module and instead a whole=
 other kernel tree needed to be built. That was a pain.

Now, the core kernel infrastructure changes that bcachefs relies on are in =
the kernel and bcachefs can very easily and quickly be built as an out-of-t=
ree module in just a few seconds. I submit to all involved that maybe that'=
s the best way to go **for now**.=20

Switching to out of tree for now would make it much easier for Kent to have=
 the fast-paced development model he desires for this stage in bcachefs' de=
velopment. It would also make using and testing bcachefs much easier for po=
wer users like me because when an issue is detected we could get a fix or n=
ew feature much faster than having to wait for a distribution to ship the n=
ext kernel version and with less ancillary risk than building and using a l=
ess-tested kernel tree. Distributions themselves also are very familiar wit=
h packaging up out-of-tree modules and distribution tools like dkms make us=
ing them dead simple even for casual users.

The way things are now isn't great for me as a Linux power user. I often wa=
nt to use the latest or even RC kernels on my systems to get some new hardw=
are support or other feature and I'm used to being able to do that without =
too many problems. But recently I've had to skip cutting-edge kernel versio=
ns that I otherwise wanted to try because there have been issues in bcachef=
s that I didn't want to have to face or work around. Switching to an out of=
 tree module for now would be the best of all worlds for me because I could=
 pick and choose which combination of kernel / bcachefs to use for each sys=
tem and situation.

Just my 2=C2=A2.

Carl



> On 2024-10-05 5:14 PM PDT Linus Torvalds <torvalds@linux-foundation.org> =
wrote:
>=20
> =20
> On Sat, 5 Oct 2024 at 16:41, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
> >
> > If what you want is patches appearing on the list, I'm not unwilling to
> > make that change.
>=20
> I want you to WORK WITH OTHERS. Including me - which means working
> with the rules and processes we have in place.
>=20
> Making the argument that we didn't have those rules twenty years ago
> is just stupid.  We have them NOW, because we learnt better. You don't
> get to say "look, you didn't have rules 20 years ago, so why should I
> have them now?"
>=20
> Patches appearing on the list is not some kind of sufficient thing.
> It's the absolute minimal requirement. The fact that absolutely *NONE*
> of the patches in your pull request showed up when I searched just
> means that you clearly didn't even attempt to have others involved
> (ok, I probably only searched for half of them and then I gave up in
> disgust).
>=20
> We literally had a bcachefs build failure last week. It showed up
> pretty much immediately after I pulled your tree. And because you sent
> in the bcachefs "fixes" with the bug the day before I cut rc1, we
> ended up with a broken rc1.
>=20
> And hey, mistakes happen. But when the *SAME* absolute disregard for
> testing happens the very next weekend, do you really expect me to be
> happy about it?
>=20
> It's this complete disregard for anybody else that I find problematic.
> You don't even try to get other developers involved, or follow
> upstream rules.
>=20
> And then you don't seem to even understand why I then complain.
>=20
> In fact, you in the next email say:
>=20
> > If you're so convinced you know best, I invite you to start writing you=
r
> > own filesystem. Go for it.
>=20
> Not at all. I'm not interested in creating another bcachefs.
>=20
> I'm contemplating just removing bcachefs entirely from the mainline
> tree. Because you show again and again that you have no interest in
> trying to make mainline work.
>=20
> You can do it out of mainline. You did it for a decade, and that
> didn't cause problems. I thought it would be better if it finally got
> mainlined, but by all your actions you seem to really want to just
> play in your own sandbox and not involve anybody else.
>=20
> So if this is just your project and nobody else is expected to
> participate, and you don't care about the fact that you break the
> mainline build, why the hell did you want to be in the mainline tree
> in the first place?
>=20
>                    Linus

