Return-Path: <linux-fsdevel+bounces-77194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAYHFSrKj2ndTgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 02:04:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013413A57A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 02:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07AE2300D4F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F073921ADB7;
	Sat, 14 Feb 2026 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWgzzo2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B21D5ABA
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031071; cv=pass; b=T5MDETtylItQGQNZEQ2pw+SZpRX0zqiw/8KQ63ovIxZs0UoKsniUwVBQND+h9uvIAI3bmD+d1jPFhUsyDOAzX+GmF2hhEbKwLU+Px85UvwUFJ87ZLaKS9XFH3RTYOKqo8BBkNixQO1p/gMXSqit4Je1zVMIKf4f9VWTIOpzUOo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031071; c=relaxed/simple;
	bh=oTZCOOs/E8crqnG31HR9W+mhx8d3x40UB7V6ulvKwNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYJkOR3ntGhyRt8ZINHb65aFVVmalCTi+uZJG9slih4AtSe939iwYjosgv6bQIAFG9tP5a3ZVLBS+VJ8LfgqqB35IuW8dK0hEOdVWgb79swouNhKpJpyept5wx9pKRwULqt/HEv7KZbKSRMXdY6BqVs/Wbt5Go4ri29Al+m+81U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWgzzo2L; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5069df1de6fso12035581cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 17:04:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771031069; cv=none;
        d=google.com; s=arc-20240605;
        b=NfE2KWLzs/vNZyoboXYkJ63Jgr2U8DsUMnT9Cqt72jatBLk3EJDlvwFMzjZuGLi81A
         xxsOdvb0cHWywfAag/R8yTFtN3KM3f1abwWwVlXq9Z9e80CCHKwSJUKYfnAJ4nFHs2bD
         gHRK7hb/2fB3PjFtdPRldXdHFs0k26oeIR9m5s8EHuqzCU3rpdX4WjGNwdZ2tc9tSQog
         rNUILw5KYzjyrRxXEF4ndItF/tfXmBD3FUyDjKnxKRHJ5yNd8kHoVY5xaQFLWKq4GpFI
         +uqWGWHErURLBZ3okBfSvxpu9rTTNDHga0KlAKr/m1E3s9MVSyj0qJoEng2lAcIrVvmd
         6s6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEO4onxYMcJcwlFhEyk+Ux/J7wYsAlvTwK9WsVU0yYw=;
        fh=hvs/d2xTmtwZAfsdbj4d405A+3q7NYpRVXND96H78BE=;
        b=dwISNgjMviQ0XeoqzkLkAYPzIHAuAdz9zzK/xVJoB+6PZTo7SbXzfnrsGTpq7JpAwj
         GYYtgmfSLd5wKTf/m64/IgW7dPN1PRLO4RQy2TQ67TMI0Ctt/OkyutScW8RB0tFIoJO5
         8ugFsvLayjCsXdVzp9kC/Co5KnCYGlx4mWsy9fIKMTPDTIP429GUo+1DESieukF8f2Fx
         6E1WBKCgOWwT4njQ4nS8Koud2O8Y/IwRtH5B/Di9dLQtU5bTxjnqYpIfcMnX1QROGzDF
         Jl4NiH5uj4ou/4ofUxJmh/FLcirE72uQH5S5DOXZupCUTPaUvNqFLh7CXyoLLLuDjjyM
         TyNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771031069; x=1771635869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEO4onxYMcJcwlFhEyk+Ux/J7wYsAlvTwK9WsVU0yYw=;
        b=GWgzzo2LyC+xoQKR/N6ZqEwuu7wlkRUGbCy16jnMu7iQeCL0AlYlL4E/O4EKuXe6Ca
         KpuPbvWLGyNZWwtBL8aFSRtImyxLtQ33B5yRObEER//R7/vKyCU/33nd95fqOHfzVX1B
         t+JaeqvJZm+pPp1pyupAzz4yD3h7MzUJH/Yo1gMFGfSXxDqOGA6HlK3ie3uVr8b6uSVD
         zb44mkF7xEc4U5LfGEc8lj3qbpp0ihsTEodPHdrHb32wNMKBDX4AW5GZSYszdtnDO5qa
         oF6K9oiPoGpswb+J5uY2KP7zqtoO5T0tM8Vk2VAcZssFXf2haFqrj8T75DMoDSeXLiLK
         qyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771031069; x=1771635869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEO4onxYMcJcwlFhEyk+Ux/J7wYsAlvTwK9WsVU0yYw=;
        b=gXYkJEpI80uVUp5atBDCSScGRlnvJksb6woelb3bdmKjkujbF7B3F0LEIO1kShpdh/
         oHHvXrnZDhIDZzFg0igq/ax0rKhWJLpmlQUdUH0nirV5NGCUCnIvQk35Q5ouMAusUncw
         YgEyUQ2ekPrS4/UrM/DijRPQRqyAMLBP5G/tX4YlVznLnamt/1zjYVzrr6AlT4DdXvZE
         VMYs9itbh+5zoyw2fPontzgi441pus5rdzYRR6r0bPL2SZgSB5g8XrxGPsmIZnxSmfwy
         mX9vYxyLh/+4gInYDl30CXadiL8hFNMp8zID5sQmPDLoq6ma7IGm1FRpDtIC/2uY7SyC
         ZfDA==
X-Forwarded-Encrypted: i=1; AJvYcCWXsZf+3WpSv7OCu++hHqP8fdWCaYNuWjshh7kNj3cqvtYXD9+oAsuNdWshUMxp0g5nqy9sXDED5VuFNhBu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjjev33fV/8jrE3v5wXSA9sLJOfYB23IUPNnfHyb9z2SZTTk23
	AetRzNwFeqwhB87por3yAd2ftdLjzOfBVbl9sYoEudxd6D8+wHZrzV5lhH5uqz3uV2h2F1KyAgb
	sPBEVYI+oa0JBpuRwQMDGyUc+Q7b5mGc=
X-Gm-Gg: AZuq6aIqwCuqK6fdHniT2mMiVk3jf+epvR0FZei/s5KtQnhE3/JpQ+pGx814lJ8EiAo
	5BLCwERJNSol7rC63vnjwt++19NCj8vN+A/egOXcHMQKCpEVdIo8VkEdnCWDNmMis5guvB21qSo
	2krnSn9LXMbdSBTHPJe+BT/4sRPyobaXkJih42FhmsVM/Bt3hBUEQhV7nN0UXpwwwr8EGg9Ysoj
	7UzDyxi5KjWN+o1A2qUUtNqFp361cLdJtbTnT3/+PWb/bIJOO/SpN2qdp23dB10pGK2a48uTDlY
	5Tn7WA==
X-Received: by 2002:a05:622a:1a8e:b0:506:a289:fd3c with SMTP id
 d75a77b69052e-506b3f7e118mr19264171cf.17.1771031069054; Fri, 13 Feb 2026
 17:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <aYysaoP0y4_j9erG@fedora-2.fritz.box> <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
 <aY2gS8q0AclXbXJT@fedora-2.fritz.box> <CAJfpegvQPKEP_fYE0xg1RCN9dd4Fb8-eom3o53ewqgboRXW4hA@mail.gmail.com>
 <aY2sZifjV-Hl3t_j@fedora-2.fritz.box> <CAJfpegvZiBb6oJCeTeLDiHdUsKEkSLuifrmmMh3aRnXFBzkRkw@mail.gmail.com>
 <aY3Gkh8DKW_QTuTS@fedora.fritz.box>
In-Reply-To: <aY3Gkh8DKW_QTuTS@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Feb 2026 17:04:18 -0800
X-Gm-Features: AZwV_Qgi4Y71Ql48tXium0YyrgmYxJrhzKmHxxJWRdmZALhyQi2qkAYqiqn88Jo
Message-ID: <CAJnrk1b0_92GRejx4ojCc0_ARx2ttuvLgXW=_-yY4Ng+H+i9=w@mail.gmail.com>
Subject: Re: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to
 combine multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77194-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,birthelmer.de:email]
X-Rspamd-Queue-Id: 1013413A57A
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 4:34=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Thu, Feb 12, 2026 at 01:10:19PM +0100, Miklos Szeredi wrote:
> > On Thu, 12 Feb 2026 at 11:48, Horst Birthelmer <horst@birthelmer.de> wr=
ote:
> > > On Thu, Feb 12, 2026 at 11:23:56AM +0100, Miklos Szeredi wrote:
> > > > On Thu, 12 Feb 2026 at 10:53, Horst Birthelmer <horst@birthelmer.de=
> wrote:
> > > > >
> > > > >
> > > > > Exactly. And the FUSE_COMPOUND_SEPARABLE was actually there to te=
ll the fuse server,
> > > > > that we know that this is not done in this case, so the requests =
can be processed
> > > > > 'separately'.
> > > > > If that is missing the fuse server has to look at the combination=
 and decide wether it
> > > > > will execute it as a 'compound' or return an error.
> > > >
> > > > I'd rather add some sub-op header flag that how to fill the missing
> > > > input.  E.g. use the nodeid from the previous op's result.
> > > >
> > > > If there's no flag, then the op is "separable".
> > > >
> > >
> > > This makes the handling on the fuse server side unnecessarily harder.
> > > With the current way I can check the flag in the compound header and =
let libfuse handle the
> > > compound by calling the request handlers separately, and not worry ab=
out a thing.

In my opinion, having the request marked at the individual request
header level as having a dependency on the request before it gives
more flexibility long term. With marking it at the compound header
level, all the requests will have to be assumed as sequentially
dependent whereas it might be the case that there's only a few
dependency chains between requests rather than all of the requests in
the compound being dependent on the request preceding it.

Thanks,
Joanne

> > >
> > > If the flag is not there, the fuse server itself
> > > (passthrough_hp from the PR already demonstrates this) has to handle =
the whole compound
> > > as a whole. I'm confident that this way we can handle pretty much eve=
ry semantically
> > > overloaded combination.
> >
> > Yeah, that's one strategy.  I'm saying that supporting compounds that
> > are not "separable" within libfuse should be possible, given a few
> > constraints.  Something very similar is done in io-uring.  It adds
> > complexity, but I think it's worth it.
> >
> > I also have the feeling that decoding requests should always be done
> > by the library, and if the server wants to handle compounds in special
> > way (because for example the network protocol also supports that),
> > then it should be done by bracketing the regular operation callbacks
> > with compound callbacks, that can allocate/free context which can be
> > used by the operation callbacks.
> >
>
> Right now we don't have it completely like this but very similar.
> The fuse server makes the final decision not the library.
>
> If it doesn't support a combination it gives control back to libfuse
> and if the FUSE_COMPOUND_SEPARABLE flag is set libfuse calls the handlers
> sequencially.
>
> The only drawback here is, (this actually makes handling a lot easier)
> that we have to have valid and complete results for all requests
> that are in the compound.
>
> > Not sure if I'm making sense.
> >
>
> I think we're getting there that I understand your perspective better.
>
> > >
> > > The other way would make the handling in libfuse or in the lowest lev=
el of the fuse server
> > > (for fuse servers that don't use libfuse) almost impossible without p=
arsing all the requests
> > > and all the flags to know that we would have been able to get away wi=
th very little work.
> > >
> > > I had thought of a hierarchical parsing of the compound.
> > > The fuse server can decide
> > > 1. does it handle compounds at all
> > > 2. does it support this particular compound (based on the opcodes and=
 the compound flags
> > > and the particular capabilities of the fuse server)
> > > 3. if the particular compound can not be handled can libfuse handle i=
t for us?
> > >
> > > This way we can have real atomic operations in fuse server, where it =
supports it.
> >
> > Yes, that's something definitely useful.   But I also think that the
> > fuse *filesystem* code in the kernel should not have to worry about
> > whether a particular server supports a particular combination of
> > operations and fall back to calling ops sequentially if it doesn't.
> > This could be all handled transparently in the layers below
> > (fs/fuse/dev.c, lib/fuse_lowelevel.c).
>
> I actually like this approach.
> lib/fuse_lowlevel.c is already there ... the kernel part does not do this=
 yet.
> I'll have a look and come up with a new version.
>
> > > I don't understand yet, why.
> > > I think we could actually implement a real atomic open if we craft a =
compound for it and
> > > the fuse server supports it. If not, we can go back to the way it is =
handled now.
> > >
> > > What am I missing here?
> >
> > I'm saying that there's no point in splitting FUSE_CREATE into
> > FUSE_LOOKUP + FUSE_MKNOD compound, since that would:
> >
> > a) complicate the logic of joining the ops (which I was taking about ab=
ove)
> > b) add redundant information (parent and name are the same in both ops)
> > c) we already have an atomic op that does both, so why make it larger
> > and less efficient?
> >
> > Thanks,
> > Miklos
>
> Thanks,
> Horst

