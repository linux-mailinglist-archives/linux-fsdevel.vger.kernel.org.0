Return-Path: <linux-fsdevel+bounces-74680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFINEoq6b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:25:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A04884F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81E109CA3C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33A43D519;
	Tue, 20 Jan 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egLskHnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740193DA7C1;
	Tue, 20 Jan 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921954; cv=none; b=n5os+n96vEe1fHWxETDgYrxqIXrqWH5yofqLQTAN6yDK8W2pvSm58kkrbBLoMoCspg0bQwVbsI4k2RLEs+59Mow7JUwHaYL2fFuSiDmjY4tkA0iumAvWtblRKayWUoKeiloYJEIPeIBpB6LYywj3Aoq0oTBCvuj2YkaFJm5FxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921954; c=relaxed/simple;
	bh=VFC229AZuFdlJP7YaiN7RvBqAhpGSQlaVITbdAUfss8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uasJkstjtlSh/m3CPlkwGZ5uWhOWV5nvzWkNosv6jKlJcWNjraupTgjjpOxBupYhxAGcgRJq+S9o/vJVCfNZLM9gC0tC4o/yP8hyEuxN/uHagrHst6vlLXwL2pohrnpAlZhz9FXpRAtBtXXga6PgUDvNg8Enk2RoHCfNCjplWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egLskHnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBA8C19422;
	Tue, 20 Jan 2026 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768921954;
	bh=VFC229AZuFdlJP7YaiN7RvBqAhpGSQlaVITbdAUfss8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egLskHnhH/94aju3jK3FgZwZVfQ0G/6hVMAcH0JmBwyMlrqBpu+a/DYxADIrXZILA
	 3kjk/SNLlp7WZcpldaalT9sc2V0WtVPUpx4W3Lb5aw92v0lAStTRwKnQp/6nEyvYtW
	 R1rD8nqqKtFkep2PA4rHx0bFRbEpXijDTgVo65TAAJ9EFpGZDfLvVHDD9QOz4AjKxV
	 VAzpDu0l0t42l2QofjK9wXtxzo98Z4IajutAlInPLcbSB6noD3ROf+UxaxkcdO9Q44
	 sYkXQ4FXcB+Iomd+Wq1wM5jtbc87mQHC7hYO2xpv5j5P2ObxpyNRUBwvvxeKEpMo3O
	 2zAoBaEiTbJ4w==
Date: Tue, 20 Jan 2026 16:12:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <aW-awBnQ6RU8o19b@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
 <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwiekixizj7yf3bc"
Content-Disposition: inline
In-Reply-To: <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74680-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AD9A04884F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pwiekixizj7yf3bc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <aW-awBnQ6RU8o19b@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
 <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>

Hi Jeff,

On Tue, Jan 20, 2026 at 09:39:27AM -0500, Jeff Layton wrote:
> On Sun, 2026-01-18 at 16:42 +0100, Alejandro Colomar wrote:
> > From: Jeff Layton <jlayton@kernel.org>
> >=20
> > With Linux 6.19, userland will be able to request a delegation on a file
> > or directory.  These new objects act a lot like file leases, but are
> > based on NFSv4 file and directory delegations.
> >=20
> > Add new F_GETDELEG and F_SETDELEG manpages to document them.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > [alx: minor tweaks]
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >  man/man2/fcntl.2                |   5 +
> >  man/man2const/F_GETDELEG.2const | 265 ++++++++++++++++++++++++++++++++
> >  man/man2const/F_SETDELEG.2const |   1 +
> >  3 files changed, 271 insertions(+)
> >  create mode 100644 man/man2const/F_GETDELEG.2const
> >  create mode 100644 man/man2const/F_SETDELEG.2const
> >=20

[...]

> > diff --git a/man/man2const/F_GETDELEG.2const b/man/man2const/F_GETDELEG=
=2E2const
> > new file mode 100644
> > index 000000000..e4d98feed
> > --- /dev/null
> > +++ b/man/man2const/F_GETDELEG.2const
> > @@ -0,0 +1,265 @@

[...]

> > +.SH NOTES
> > +Delegations were designed to implement NFSv4 delegations for the Linux=
 NFS server.

Do we have a link to the NFSv4 specification of delegations?  It could
be useful, I think.  What do you think?

[...]

> This all looks great to me. Did you need me to make any other changes?

The only remaining doubt is the question above.

> Thanks for doing the cleanup! FWIW:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

You're welcome!  And thanks!  :-)


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--pwiekixizj7yf3bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlvm1cACgkQ64mZXMKQ
wql+RQ//VVIwqqxU0sBVJTko2FgmsP7dS78xT/McXJHwCLs1AVVilwaIy2dFsOzX
v4CMW0PVqzhxUyIwx3zv3v+uwSrYRMCPcBbcwW3Banz1odlQqtWThkWhTHwno5Xu
/9U7o0X+JrGgpmafNlU3ihVGBGr6Khz3oQrxP0Nu85aKc0bOyXDeYXD5TskcjytT
mN8jDbb0qocTqAMFJrn5f4ya+Fk7UKxiFiXJ24uNf+s1qdgszyiuwTvDNcWHqGOy
gxO8ZoaHX+YqwKLJqtv1D4Pk1UoWRvlZ8S38zXOLtVsoImOI8fCzMZww0Nb1TTAI
/uPd9/X4fv4puKHYWGfOypoGBteFlj3dzayWgF1pzRf03VZl3pIhBR/OCLYYPDaf
MFWqnsGxUy5Mxx80wrZUwW3F/dh4uhUffQjfdlHbNqtR4XpAO12QKh+fVvBiYmw3
uFUq1vo0RIuKoLQviiAsgUCUKyKnEUra4UVV1qk2kV8YZR+8Dn03GI2tCJtrgqtT
bMp2VYrxjm0cdGtHM3y+STF07ThdYQpYabUuLTaqkDLUhhIfuH9c2wvcgu9MkQNw
ZdukRuGjjsP5Cs3nyjYNrn5uJmSqtShxkt3TLn56vMI0QlMQJ/7NvQFqIGpekf61
UbfGfmPsxTXdGJkub2vWgawf1WQw2ubO3E+mJXSkxEFkFpgolgQ=
=xS8N
-----END PGP SIGNATURE-----

--pwiekixizj7yf3bc--

