Return-Path: <linux-fsdevel+bounces-31119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5DA991E38
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462BAB21986
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594F8176237;
	Sun,  6 Oct 2024 11:56:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91165364A0;
	Sun,  6 Oct 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215795; cv=none; b=WqEY92OOBt59zseCJGCa5RyQdWGYAOvX71bK3BqEZA9lcFQDZwzEjCzXh+OQ7S6reCG2oTPIZMjFzvmFv6PJ4/WvEif7r7vlhvsb/Y4QRgNMM/dUiwVK5A7cwqEGbmQ+a065QFYjmZdOUurYTbRhwtQOIG3c4/3AKtaNS3Dwers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215795; c=relaxed/simple;
	bh=fYm8XZM7szcIecmiSvIW0b+adLjsjNfHN8DO3gDpkPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxPbkzXW39NXLHCwk1fAMO9fUqihA36OW/dVNHThwb9RGqAgJ2qIxr+bq0L8MeobRSlNmM2EY6eb+R3RxdxPGu030e4yIF5134rvvsxSpjkzf6Q0vLdmHxkFb8GrZjV0GureG2SKYY0JCQx7f3sDlm9ZCnV5XMRDhv74MeqicLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 9E79A73FD6;
	Sun, 06 Oct 2024 11:49:23 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Date: Sun, 06 Oct 2024 13:49:23 +0200
Message-ID: <5987583.MhkbZ0Pkbq@lichtvoll.de>
In-Reply-To: <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
References:
 <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Kent, hi Linus.

Kent Overstreet - 06.10.24, 02:54:32 CEST:
> On Sat, Oct 05, 2024 at 05:14:31PM GMT, Linus Torvalds wrote:
> > On Sat, 5 Oct 2024 at 16:41, Kent Overstreet=20
<kent.overstreet@linux.dev> wrote:
> > > If what you want is patches appearing on the list, I'm not unwilling
> > > to
> > > make that change.
> >=20
> > I want you to WORK WITH OTHERS. Including me - which means working
> > with the rules and processes we have in place.
>=20
> That has to work both ways.

Exactly, Kent.

And it is my impression from reading the whole thread up to now and from=20
reading previous threads it is actually about: Having your way and your=20
way only.

That is not exactly "work both ways".

Quite similarly regarding your stand towards distributions like Debian.

Sure you can question well established rules all the way you want and=20
maybe you are even right about it. I do not feel qualified enough to judge=
=20
on that. I am all for challenging well established rules on justified=20
grounds=E2=80=A6

But=E2=80=A6 even if that is the case it is still a negotiation process. Ex=
pecting=20
that communities change well established rules on the spot just cause you=20
are asking for it=E2=80=A6 quite bold if you ask me. It would be a negotiat=
ion=20
process and work both ways would mean to agree on some kind of middle=20
ground. But it appears to me you do not seem to have the patience for such=
=20
a process. So it is arguing on both sides which costs a lot of energy of=20
everyone involved.

=46rom what I perceive you are actually actively working against well=20
established rules. And you are surprised on the reaction? That is kind of=20
naive if you ask me.

At least you wrote you are willing to post patches to the mailing list: So=
=20
why not start with at least that *minimal* requirement according to Linus=20
as a step you do? Maybe even just as a sign of good will towards the=20
kernel community? That has been asked of you concretely, so why not just=20
do it?

Maybe this can work out by negotiating a middle ground going one little=20
step at a time?


I still do have a BCacheFS on my laptop for testing, but meanwhile I=20
wonder whether some of the crazy kernel regressions I have seen with the=20
last few kernels where exactly related to having mounted that BCacheFS=20
test filesystem. I am tempted to replace the BCacheFS with a BTRFS just to=
=20
find out.

Lastly 6.10.12-1 Debian kernel crashes on a pool-spawner thread when I=20
enter the command =E2=80=9Ereboot=E2=80=9C. That is right a reboot crashes =
the system =E2=80=93 I=20
never have seen anything this crazy with any Linux kernel so far! I have=20
made a photo of it but after that long series of regressions I am even too=
=20
tired to post a bug report about it just to be told again to bisect the=20
issue. And it is not the first work queue related issue I found between 6.8=
=20
and 6.11 kernels.

Actually I think I just replace that BCacheFS with another BTRFS in order=20
to see whether it reduces the amount of crazy regressions I got so fed up=20
with recently. Especially its not fair to report all of this to the Lenovo=
=20
Linux community guy Mark Pearson in case its not even related to the new=20
ThinkPad T14 AMD Gen 5 I am using. Mind you that series of regressions=20
started with a T14 AMD Gen 1 roughly at the time I started testing=20
BCacheFS and I had hoped they go away with the new laptop. Additionally I=20
have not seen a single failure with BTRFS on any on my systems =E2=80=93 in=
cluding=20
quite some laptops and several servers, even using LXC containers =E2=80=93=
 for=E2=80=A6 I=20
don't remember when. Since kernel 4.6 BTRFS at least for me is rock=20
stable. And I agree, it took a huge lot of time until it was stable. But=20
whether that is due to the processes you criticize or other reasons or a=20
combination thereof=E2=80=A6 do you know for sure?

I am wondering: did the mainline kernel just get so much more unstable in=20
the last 3-6 months or may there be a relationship to the test BCacheFS=20
filesystem I was using that eluded me so far. Of course, I do not know for=
=20
now, but reading Carl's mails really made me wonder.

Maybe there is none, so don't get me wrong=E2=80=A6 but reading this thread=
 got me=20
suspicious now. I am happily proven wrong on that suspicion and I commit=20
to report back on it. Especially when the amount of regressions does not=20
decline and I got suspicious of BCacheFS unjustly.

Best,
=2D-=20
Martin



