Return-Path: <linux-fsdevel+bounces-45310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166AA75C1B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 22:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04903A7B64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99721DDC0B;
	Sun, 30 Mar 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRr43ia8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F2524F;
	Sun, 30 Mar 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743365278; cv=none; b=Hx3zuZZ6xVowCn8T3QHjXC5wkGLeJUCHUwPCxU0BT8kt2c4hicGQo0YK3iQv5oxJX417JdUhNsoaTIclt8ZrdvLU2t6yaShnG5UEzTm1LjAryb6a8L1UX1+6s4pCrQOYu6KH/4L9yJOHsVw9N/sJrB8oyUERz+hGyKG1Jm1xUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743365278; c=relaxed/simple;
	bh=7QmN7infl+AWALWj4xdvsM0FLzR3ZY9CNGSP1D6kmOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCCkSLX+DOtRvfTVVkAoLLSHrBf/zEhepXD0lC3S8tA85JuUAwpcckLljbUCnpNLSBuA8LoagjfTziCSq0CxzB+639IUcrlEB1AQo9s/LlpTMnelKMhyxApWLRriDTPROuWxOJwqKr193xz4wIdewkxm7rVwgx9lun83PD89EqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRr43ia8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D551BC4CEDD;
	Sun, 30 Mar 2025 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743365277;
	bh=7QmN7infl+AWALWj4xdvsM0FLzR3ZY9CNGSP1D6kmOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRr43ia8dMCh3iZDkBlPhtxyTsE8Hqf3GlI2puSo4VDzlbVtIpd9D268o9r2IlcMv
	 y9ucyj6Tdy8Zv+ZcHw6v+ixrV6SmjPPIV+CzVY5xWkKRbNF/gU0WN5IQDhrjkvIU3K
	 FGXGP9rj8m0e/A/ueCiXav9a9XrT/fDA/t8+v1dqw5iJodcjjTlrI8ljp2j4uO/FIn
	 tbG9S6Qe/vj7TAkFpXGmAyQlaCzs0fVY4fJpa79ZES3Gj/FnKlsl8mP38Xj1VrybME
	 xmMD+Z4gZ7wH0DfFfWqd/cxm6DDVSDXnbugO11rxEBsdCFgMWzRVh4Q5Zbx4pnSimH
	 8JgdBqRBHdBfw==
Date: Sun, 30 Mar 2025 22:07:53 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] fanotify.7: Document extended response to permission
 events
Message-ID: <rp7bop6qae4xktexv5obztbzvbrewyitrnwpvhzil4rionzhdz@lxjqvlmqjj64>
References: <20250330153326.1412509-1-amir73il@gmail.com>
 <mwttu4y4pvussz2zug6dlmgioqcfwgqsup3fqhyfa437mi2k2p@bl5orpxlsa4z>
 <CAOQ4uxjppaLhRnWvm_Q7EwRYA9rDTE57xY7_DO0KJKLJngM+xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kl5dloyr7c4fpuor"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjppaLhRnWvm_Q7EwRYA9rDTE57xY7_DO0KJKLJngM+xw@mail.gmail.com>


--kl5dloyr7c4fpuor
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>
Subject: Re: [PATCH] fanotify.7: Document extended response to permission
 events
References: <20250330153326.1412509-1-amir73il@gmail.com>
 <mwttu4y4pvussz2zug6dlmgioqcfwgqsup3fqhyfa437mi2k2p@bl5orpxlsa4z>
 <CAOQ4uxjppaLhRnWvm_Q7EwRYA9rDTE57xY7_DO0KJKLJngM+xw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjppaLhRnWvm_Q7EwRYA9rDTE57xY7_DO0KJKLJngM+xw@mail.gmail.com>

Hi Amir,

On Sun, Mar 30, 2025 at 09:53:36PM +0200, Amir Goldstein wrote:
> > I prefer them in two patches.  You can send them in the same patch set,
> > though.
>=20
> ok
>=20
> I pushed the two patches to
> https://github.com/amir73il/man-pages/commits/fan_deny_errno
>=20
> Let me know if you want me to re-post them

Yes, please.

> > > This change to the documentation of fanotify permission event response
> > > is independent of the previous patches I posted to document the new
> > > FAN_PRE_ACCESS event (also v6.14) and the fanotify_init(2) flag
> > > FAN_REPORT_FD_ERROR (v6.13).
> > >
> > > There is another fanotify feature in v6.14 (mount events).
> > > I will try to catch up on documenting that one as well.
> > >
> > > Thanks,
> > > Amir.
> > >
> > >  man/man7/fanotify.7 | 60 +++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 59 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> > > index 6f3a9496e..c7b53901a 100644
> > > --- a/man/man7/fanotify.7
> > > +++ b/man/man7/fanotify.7
> > > @@ -820,7 +820,7 @@ This is the file descriptor from the structure
> > >  .TP
> > >  .I response
> > >  This field indicates whether or not the permission is to be granted.
> > > -Its value must be either
> > > +Its value must contain either the flag
> >
> > This seems unrelated.  Please keep it out of the patches.  If you want
> > to do it, please have a third trivial patch with "wfix" in the subject.
>=20
> what does wfix stand for?

wording fix

$ cat CONTRIBUTING.d/patches/subject | sed -n '/Trivial subject/,+12p';
    Trivial subject
	For trivial patches, you can use subject tags:

		ffix	Formatting fix.
		tfix	Typo fix.
		wfix	Minor wording fix.
		srcfix	Change to manual page source that doesn't affect
			the output.

	Example:

		[PATCH v1] tcp.7: tfix

> this is not a typo fix, this is a semantic fix.
>=20
> It is not true that the value of response is either FAN_ALLOW or FAN_DENY
> those are flags in a bitset and the correct statement is that exactly
> one of them needs to be set.

I understand now.  Then, I think it's more important to have this in a
separate patch, to make sure we document the fix in a commit message.

> > > +macro:
> > > +.BR EPERM ,
> > > +.BR EIO ,
> > > +.BR EBUSY ,
> > > +.BR ETXTBSY ,
> > > +.BR EAGAIN ,
> > > +.BR ENOSPC ,
> > > +.BR EDQUOT .
> >
> > Should we have a manual page for FAN_DENY_ERRNO()?  (I think we should.)
> > I don't understand how it's supposed to work from this paragraph.
> >
>=20
>=20
> #define FAN_DENY_ERRNO(err) (FAN_DENY | (((err) & 0xff) << 24))
>=20
> combined FAN_DENY with a specific error, but I see no
> reason to expose the internals of this macro

Ahhh, thanks.

>=20
> This does not deserve a man page of its own IMO.
>=20
> If you have a suggested for better formatting, please suggest it

How about an example of using it?  I think that'd be more useful than a
lot of text.

> > > +Extra response records start with a common header:
> > > +.P
> > > +.in +4n
> > > +.EX
> > > +struct fanotify_response_info_header {
> > > +    __u8 type;
> > > +    __u8 pad;
> > > +    __u16 len;
> > > +};
> > > +.EE
> > > +.in
> > > +.P
> > > +The value of
> > > +.I type
> >
> > I'd say '.type' instead of 'type'.  I know there's no consistency about
> > it, but I'm going to globally fix that eventually.  Let's do it good for
> > new documentation.  The '.' allows one to easily know that we're talking
> > about a struct or union member.
> >
>=20
> Sounds like a good change to me.
>=20
> pushed requested fixes to github.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--kl5dloyr7c4fpuor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfppIsACgkQ64mZXMKQ
wqnyyA//ZbKsKedAyfB6ILOilryeIKlxTCBM06AnDrPPInP7dSqCVNCArYrin1Hz
xOLxuGTjvLFdow1bBCTd9ovgoWRyInrllBjeEqD5IIAUIHdgI8XKKPJdGIRRaYgb
EL1Z+ee7C8/qG8/RajwMkH73UUYriuSPFrkTjfyDAT1xX91zf8uQ55km49xw3GrS
4m9NnmrcETnbaQKn8zayj3zaESzKe6AWM9gfUjt9X0/+5XLm8rpZ5D9gz0dZXstH
1kmzaXaStWExrrkntqCOymX0wYRWg7aQRlRPpmW0X7y5OvbOEfzsUS5ejzShjxGM
sICDbhJ2GjnBnXi09dmQuQSICkPn53NS+YbtKwdtDafqU5rk4BAeiT6ZOX/PhBY2
K5dHr6gdhSrgzep9A64YOm/VnOShZHMN3xQBbBhNX6qMgKtLdDhSBTHmxTvrBxi9
/XamftKTvzdqDmv6uaQDHaIzAHX57i8ty52JlTQLfMRuZJFg3XHKTdYnQnk/nHX2
umUet2w3PUWspSFahp/tmPz3lU3bwVV61DTgBcikFFfcg9PGrHHJuXyrT70r6xVY
gM9utfIuOkDX93GExDtBG8iMbHC/jClzwgpm8yhN832Qlpy/8rkG5CoXZt60n782
8kznwS7NkzzrMmJqpFttAueA+0cC1jkfQV8SzZw6uRiEIN9ZSpg=
=NvhJ
-----END PGP SIGNATURE-----

--kl5dloyr7c4fpuor--

