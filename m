Return-Path: <linux-fsdevel+bounces-57415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F6B213FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F6D172C71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4A2DE1F0;
	Mon, 11 Aug 2025 18:14:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83A2D6E66;
	Mon, 11 Aug 2025 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936049; cv=none; b=BoOxC5q8TZpmRCCllgaYZxlTX0Y6xfjDIJX7rnK6XV/mVOPFmjrFFgp3R6HoYOFDUdR1iVk+WUebgoytgqyXJfjk6Qey/ciIh44/b81cxGC7iAb4PnZ9spJzUyTJXOoVhp/t/CcLFKkQhSGyCx1vteP8xl0AKrYxnOsDEPViq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936049; c=relaxed/simple;
	bh=cxoFCFETBOccsLdMwv3sh9Um/zOuhvG93S2CSNiIWzA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=giYPVeQRDIHtVqmASBU+GL35FSAABeawanriJEBnltqVC+5d00RIyQvaclmcwwX5oorbemnfho+ee1BiB9K897NpKEleTGLL1+xV/wpLLAwVYfXo0T8hRW1eRv2SRL4iwSpAZ930dUODZcNI1LafgWBrbxh5gtDdG8JAvM6EJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id 775F11E3AE570;
	Mon, 11 Aug 2025 11:13:58 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:13:58 -0700 (PDT)
From: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Message-ID: <514556110.413.1754936038265@mail.carlthompson.net>
In-Reply-To: <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
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

I seriously hope none of the kernel developers are foolish enough to be foo=
led (yet again) by this I'm-a-reasonable-guy-we-can-talk-this-out act. You'=
ve been there and done that.

Kent's perplexing behavior almost makes me want to put on a tinfoil hat. Is=
 it simply mental illness or is it something more? Is he being egged on by =
backers who *want* to destabilize the leadership of Linux for whatever reas=
on? It's hard to see how any individual could be this far out there without=
 help.

And I'll point out what's obvious to people who have followed this closely =
but may not be to people who read an occasional email thread like this one:=
 A very large portion of what Kent says including in this email is just fac=
tually wrong. Either he is an unashamed and extremely prolific liar or he i=
s very sick.

Carl

> On 2025-08-11 7:26 AM PDT Kent Overstreet <kent.overstreet@linux.dev> wro=
te:
>=20
> =20
> On Mon, Aug 11, 2025 at 12:51:11PM +0300, Konstantin Shelekhin wrote:
> > > =C2=A0Yes, this is accurate. I've been getting entirely too many emai=
ls from Linus about
> > > how pissed off everyone is, completely absent of details - or anythin=
g engineering
> > > related, for that matter.
> >=20
> > That's because this is not an engineering problem, it's a communication=
 problem. You just piss
> > people off for no good reason. Then people get tired of dealing with yo=
u and now we're here,
> > with Linus thinking about `git rm -rf fs/bcachesfs`. Will your users be=
 happy? Probably not.
> > Will your sponsors be happy? Probably not either. Then why are you keep=
 doing this?
> >=20
> > If you really want to change the way things work go see a therapist. A =
competent enough doctor
> > probably can fix all that in a couple of months.
>=20
> Konstantin, please tell me what you're basing this on.
>=20
> The claims I've been hearing have simply lacked any kind of specifics;
> if there's people I'd pissed off for no reason, I would've been happy to
> apologize, but I'm not aware of the incidences you're claiming - not
> within a year or more; I have made real efforts to tone things down.
>=20
> On the other hand, for the only incidences I can remotely refer to in
> the past year and a half, there has been:
>=20
> - the mm developer who started outright swearing at me on IRC in a
>   discussion about assertions
> - the block layer developer who went on a four email rant where he,
>   charitably, misread the spec or the patchset or both; all this over a
>   patch to simply bring a warning in line with the actual NVME and SCSI
>   specs.
> - and reference to an incident at LSF, but the only noteworthy event
>   that I can recall at the last LSF (a year and a half ago) was where a
>   filesystem developer chased a Rust developer out of the community.
>=20
> So: what am I supposed to make of all this?
>=20
> To an outsider, I don't think any of this looks like a reasonable or
> measured response, or professional behaviour. The problems with toxic
> behaviour have been around long before I was prominent, and they're
> still in evidence.
>=20
> It is not reasonable or professional to jump from professional criticism
> of code and work to personal attacks: it is our job to be critical of
> our own and each other's code, and while that may bring up strong
> feelings when we feel our work is attacked, that does not mean that it
> is appropriate to lash out.
>=20
> We have to separate the professional criticism from the personal.
>=20
> It's also not reasonable or professional to always escelate tensions,
> always look for the upper hand, and never de-escalate.
>=20
> As a reminder, this all stems from a single patch, purely internal to
> fs/bcachefs/, that was a critical, data integrity hotfix.
>=20
> There has been a real pattern of hyper reactive, dramatic responses to
> bugfixes in the bcachefs pull requests, all the way up to full blown
> repeated threats of removing it from the kernel, and it's been toxic.
>=20
> And it's happening again, complete with full blown rants right off the
> bat in the private maintainer thread about not trusting my work (and I
> have provided data and comparisons with btrfs specifically to rebut
> that), all the way to "everyone hates you and you need therapy". That is
> not reasonable or constructive.
>=20
> This specific thread was in response to Linus saying that bcachefs was
> imminently going to be git rm -rf'd, "or else", again with zero details
> on that or else or anything that would make it actionable.
>=20
> Look, I'm always happy to sit down, have a beer, talk things out, and
> listen.
>=20
> If there's people I have legitimately pissed off (and I do not include
> anyone who starts swearing at me in a technical discussion) - let me
> know, I'll listen. I'm not unapproachable, I'm not going to bite your
> head off.
>=20
> I've mended fences with people in the past; there were people I thought
> I'd be odds with forever, but all it really takes is just talking. Say
> what it is that you feel has affected, be willing to listen and turn,
> and it gets better.

