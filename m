Return-Path: <linux-fsdevel+bounces-78760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C0YGXfdoWlcwgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:07:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC141BBC93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DDEC305FB67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A336921B;
	Fri, 27 Feb 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDaDW2oN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EF369965
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215658; cv=pass; b=nIwjbFzma0zTAju2jW/2CTqXe+GETgLhm/WmMDmA2XoEmZ8XiJwuVXPB2e9x9zxa9pYELLO/DSqSTMBTY3bnzxMJ03rBYhxEHAOJlN6UKQnpy/FRI3Q0fqqtzThpT7rFyqdChe3rFi4+uIoKqq9CkNrhvGc3mnIzv7C8QEuJDuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215658; c=relaxed/simple;
	bh=qc/miJJ4tFaupPQJDIm6ervbtJ0nMibL2yrS8kNVkjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+MDWHh5E5AkpfQsKofe2wJTaV3VC0V+zRJHFFHKsAaQo4lekGsG3oM77VjiB2r5w4wYakAiehWrtKyG2BH6ir1v499HPTWv5UgNupljCyN9bCPElDw9DBWEv/SOzy410WF8Ne8ue144ttf9df13r1fLe1S/str4mKGu86qxVjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDaDW2oN; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a6cf8242so17732371cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772215652; cv=none;
        d=google.com; s=arc-20240605;
        b=YRPmUSeB1PQTM+B9zrAKEmIIdN/ugYodwSjfLo+setl0a7e3lgB5ZfmYFk9uwuFKeU
         x23CNmZWIAGjvAj7sjxHfAULl8ZHyDsA43MCFf612IUkMTZArQZ3851PSejp6VchCKp0
         m0tnKb7SETMPsHn3pUgtGVi2jAy+y4IfO0EWJ7EVql12d6WJyXtCEPYGRZuTfTuZZzMy
         kcJrn0UOW2L0k/sKcI2Iwj1iCFc3TnKKBVTvKcJfogjMVE9HU/7ffr67suxtfwg9w0aM
         R3x8Mafd2OdopiqG50IF5R+DWi8sd7Kcd3qWN7BIUm/sSusYOXm+j/2We7+p+LBR7Ei9
         jm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7PGwWnicT/w1KMZycbxgOXoAGuWBsm/1JmX9Ce7xQaA=;
        fh=VmM+hhRhimCxd4SRd5Pkbyll34CB2dikpiuq9dBa2uM=;
        b=PDNOeGHU1TmNx6nmqG1oYrk8+Ktz3KdxA70HJATvVmAKLxOHJt7oWaiNCiri1Zqui9
         izHuR5B03qqs+AvsyRYfF3gJV+yuBTWIbLq+Iku4pL2KK7hZBfETnDdmkXBbd5f2gBL0
         fTxMMtCnuZeegq4xmBHdIkhM9mOt9JzsGiG6NBnE5YK1teIYzJS6hA4JSMsdEhVI0X4P
         Oc+lMyRaPwaxH94mCVEQPkX4Xl9kVJFfjcR+JIezsPQ4yXkDMz1Tzdryd7mgySQ1Nj5e
         PZDg0+R9/wZItGtjBw3C+9+J7eFK74Dkii0hVCMBpFvhjfmwqDkMa5l0xiZFXBTkga5P
         oyKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772215652; x=1772820452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PGwWnicT/w1KMZycbxgOXoAGuWBsm/1JmX9Ce7xQaA=;
        b=lDaDW2oNRucyMtaTCwlWkoIGjThIZwulV4Cs77YI4JHfjR9/Vw2z5QaY/CkbcbgfKh
         4OAuOfmvDh4mp1BGA+86a+kmwDovZk56y9ME/cfimmtjUuvA6fvuaseQJK1txHdJZ/Ly
         l8oCojxFWqbjAl3zNpm+TZoSMUwBFil4aY7cwbYVnH0UbTUjTR7dUYmQgz4pxAoIoJ+p
         8PjwTHZU5uqW8v5rzS7TIYvfyWKsITM9yToX/TM47IZo0UzsYvzPJ643ZaZlUofsidqg
         4NGAKpJxo9MeNtuDlklVgPnzu5sPAXtfEL5F7WcXI/+vGnwVSOiPuzgBfu8DFXC9Lj2H
         VgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772215652; x=1772820452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PGwWnicT/w1KMZycbxgOXoAGuWBsm/1JmX9Ce7xQaA=;
        b=TlgDaT9M9TGSWLtfD6jYt9jUWWsinEghAzZZOYXUamGrtDWaAyI1fDC9Jab3zOvqbm
         8z2+gI02qUkirKP01Btv5xzykrnR18+4amOERiBaNxgbiCgw4zCeUKL0+6S2qZu7jMOs
         qL3n6l+6pD0rK0zi3BAMykSAvcNphh0qZOO0GyzYhtqYI4aL0X7ccz8fyzmhlXj+uR+r
         pkprvJntmtypeNd5LnbPRa5LAtzh9S0zIh0oaE5QxIBxe/Zb+S/0al+oi7NvU61rFHIx
         qHUvLkjofWa4X3RdTqvR0miythXtcV+7/dZvayu+TwlxopKhLALGngu0BGDYojEqy9uW
         5Vrg==
X-Forwarded-Encrypted: i=1; AJvYcCWf0g8UkdgJbje6YkCCjYIysh3Lz/bFbHC2EbGU29QjfP6FxIxmXYtK3ZS/pPOLymtPAGBTY/0oziQlBLp7@vger.kernel.org
X-Gm-Message-State: AOJu0YztqMenPdOIkn84QS4iHyb9hvOHVZ1QjkW/FDTfzLPZgaOBoJEj
	tmMfZPhdkcN8uH21ZN2YDNNsVu7qRWQIoQIv1nGepF/jWQ9K/swSLctt8r3G3RhCgbLQgFdv7xG
	u3yx4fov9/WyEdXd91zL4t5CuhRf+Fj4=
X-Gm-Gg: ATEYQzxEeXjKsiBROhg4CJTXke5Jw/6vVg3czpLN2uEvtfIDh6Sis1/VXglLr4Bm2gc
	H39Xauo18YBg4LAkrGEKWGuiykMm/zTRgmxzgNwg01ffWYpV+Xk0Q3b6ljbX9gzeqid9a8jjFLH
	kKefVSLCsvsa0CICGmdJG+RKcmIcwIoRGTYxw0c/O/Mo6Mkc2UhAdzUzK3+ZrIj0Ia7oEOhUpI6
	f/VTK6I4w8f0o6vJkIybMofBfXchrHDRwy9l9nJx1jkxe8r+lRTzwfnMJswyTLyUYVV9VPfBn5C
	yn3aXw==
X-Received: by 2002:ac8:7c50:0:b0:506:1c5e:d1c2 with SMTP id
 d75a77b69052e-507528cea2cmr43107751cf.27.1772215652155; Fri, 27 Feb 2026
 10:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box> <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
In-Reply-To: <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Feb 2026 10:07:20 -0800
X-Gm-Features: AaiRm51p1mB2JG0kUrj2ro5U6t_Q3NnlS0ll8DpEECaRTSTIoe_mJUO0TWgDOU8
Message-ID: <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
Subject: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78760-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.de:email,birthelmer.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ddn.com:email]
X-Rspamd-Queue-Id: 0BC141BBC93
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 9:51=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Thu, Feb 26, 2026 at 11:48=E2=80=AFPM Horst Birthelmer <horst@birthelm=
er.de> wrote:
> >
> > On Thu, Feb 26, 2026 at 11:12:00AM -0800, Joanne Koong wrote:
> > > On Thu, Feb 26, 2026 at 8:43=E2=80=AFAM Horst Birthelmer <horst@birth=
elmer.com> wrote:
> > > >
> > > > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > > >
> > > > The discussion about compound commands in fuse was
> > > > started over an argument to add a new operation that
> > > > will open a file and return its attributes in the same operation.
> > > >
> > > > Here is a demonstration of that use case with compound commands.
> > > >
> > > > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > > > ---
> > > >  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++=
++++--------
> > > >  fs/fuse/fuse_i.h |   4 +-
> > > >  fs/fuse/ioctl.c  |   2 +-
> > > >  3 files changed, 99 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc3932=
41bdf727e00a2bc714f35 100644
> > > > --- a/fs/fuse/file.c
> > > > +++ b/fs/fuse/file.c
> > > >  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid=
,
> > > > -                                unsigned int open_flags, bool isdi=
r)
> > > > +                               struct inode *inode,
> > >
> > > As I understand it, now every open() is a opengetattr() (except for
> > > the ioctl path) but is this the desired behavior? for example if ther=
e
> > > was a previous FUSE_LOOKUP that was just done, doesn't this mean
> > > there's no getattr that's needed since the lookup refreshed the attrs=
?
> > > or if the server has reasonable entry_valid and attr_valid timeouts,
> > > multiple opens() of the same file would only need to send FUSE_OPEN
> > > and not the FUSE_GETATTR, no?
> >
> > So your concern is, that we send too many requests?
> > If the fuse server implwments the compound that is not the case.
> >
>
> My concern is that we're adding unnecessary overhead for every open
> when in most cases, the attributes are already uptodate. I don't think
> we can assume that the server always has attributes locally cached, so
> imo the extra getattr is nontrivial (eg might require having to
> stat()).

Looking at where the attribute valid time gets set... it looks like
this gets stored in fi->i_time (as per
fuse_change_attributes_common()), so maybe it's better to only send
the compound open+getattr if time_before64(fi->i_time,
get_jiffies_64()) is true, otherwise only the open is needed. This
doesn't solve the O_APPEND data corruption bug seen in [1] but imo
this would be a more preferable way of doing it.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20240813212149.1909627-1-joannelk=
oong@gmail.com/

>
> Thanks,
> Joanne

