Return-Path: <linux-fsdevel+bounces-75184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIHZGsvIcmkBpgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:03:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C76EE4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 02:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27F6300BD95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD435A923;
	Fri, 23 Jan 2026 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amT4iVaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81952357A3E;
	Fri, 23 Jan 2026 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130178; cv=none; b=HT5BzW4atFOEvhP6fmD1YcIKeNut+A7WUMmQlkC5Rq7jWFGC5t4h4Z3TZhz+gvY6IPLwKUtxT/QwLzQEUq+DrZiPI5kMq+tgFe2+PUBqidfg0X5eaw95gH0C5T7J9y6GXBPCfdDcD4N7opQVocRLkUFJSErYxDbl5K1lBIAcKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130178; c=relaxed/simple;
	bh=oOXoMNIYkU2bbdIVCwBjOMn0XV+l0LSgeYwJ5zZxeVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSw11Bf59sc5/6PVNtzFozpR43WT6AuMMultfQAIci3rQh8cxfkn0kL2Vytx3ZFEVHUrJa6vRJWQCcyRW6S4zui0CA7VVg3Ro3b5IqifarIq6jvxYyhIwqdD2AnTM+yBbGryFH7Wg95Wd7Fna9t7d4uY/9ufcReGSLUgNEyw0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amT4iVaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62648C116C6;
	Fri, 23 Jan 2026 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769130177;
	bh=oOXoMNIYkU2bbdIVCwBjOMn0XV+l0LSgeYwJ5zZxeVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amT4iVaSdQoD3GFFlMQyN/Q5ALxPdr8DAXfte+WEBw5bVwf5yHkABzHMxxRxZXaSy
	 dxJLc87h0FKgjljzkaTcsawbMbnnMgv8jYkLs0+13/2cPnYNVItO7M2Ces3+/JBzAm
	 N3UjCDQR3IxaBsc2vCW8/XqbDvC2OG5ZIfhl/PdHNOa1kDuNqtePeLUKkeDAb/1Jpd
	 rvOqCiWEkxAYUFgI8HN10rxsFJHTd8X7MvOqyWKv0AyK1WMw0A0QNs8cMxj/jGN7L+
	 Dj/P0zAjfnaKO+4HM/rdlP5/S+Khob9pEbKFl+U4EmcjGJVnG6vA8nnzL48xnwppQM
	 xyE7jKZjvDWwg==
Date: Fri, 23 Jan 2026 02:02:53 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aXLGdWGTrYo1s6v7@devuan>
References: <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bwnce3ol6egwwjc"
Content-Disposition: inline
In-Reply-To: <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75184-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C09C76EE4F
X-Rspamd-Action: no action


--3bwnce3ol6egwwjc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aXLGdWGTrYo1s6v7@devuan>
References: <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>

Hi Zack,

On Thu, Jan 22, 2026 at 07:33:58PM -0500, Zack Weinberg wrote:
[...]

> This is a full top-to-bottom rewrite of the manpage; please speak
> up if you don't like any of my changes to any of it, not just the
> new stuff about delayed errors.  It's written in freeform text for
> ease of reading; I'll do proper troff markup after the text is
> finalized.  (Alejandro, do you have a preference between -man
> and -mdoc markup?)

Strong preference for man(7).

[...]
> ERRORS
>        EBADF  The fd argument was not a valid, open file descriptor.
>=20
>        EINTR  The close() call was interrupted by a signal.
>               The file descriptor *may or may not* have been closed,
>               depending on the operating system.  See =E2=80=9CSignals and
>               close(),=E2=80=9D below.

Punctuation like commas should go outside of the quotes (yes, I know
some styles do that, but we don't).

[...]

> STANDARDS
>        POSIX.1-2024.
>=20
> HISTORY
>        The close() system call was present in Unix V7.

That would be simply stated as:

	V7.

We could also document the first POSIX standard, as not all Unix APIs
were standardized at the same time.  Thus:

	V7, POSIX.1-1988.

Thanks!


Have a lovely night!
Alex

>=20
>        POSIX.1-2024 clarified the semantics of delayed errors; prior
>        to that revision, it was unspecified whether a close() call
>        that returned a delayed error would close the file descriptor.
>        However, we are not aware of any systems where it didn=E2=80=99t.
>=20
> SEE ALSO
>        close_range(2), fcntl(2), fsync(2), fdatasync(2), shutdown(2),
>        unlink(2), open(2), read(2), write(2), fopen(3), fclose(3)

--=20
<https://www.alejandro-colomar.es>

--3bwnce3ol6egwwjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlyyLYACgkQ64mZXMKQ
wqkb/w//WgLRrKZaa8I2z10iUXBxBSOQT9hzwG4T2mXhnADVvq9fmVK6ALEYeefV
tZPVUb1s5OWh/X3YEIvnSQ847hMkiycxEmryEbdQZB1ZIs6CnnbtsTyEUsEVA9jX
Ecjkbzgpc6VEPTXuyjLZhQ5rw5VRLawUuYUI6cX8W2AfvbgE51cg9FcKmMt7aM0k
eiILb8lfi2nFxOQQu47+0A8YcTc8TNIIA4rqaJaT4iWum2SoSylLAOR0gGFqrXrT
WBH2O4cm/AVBUyRY/v9KRZE/fFNAU256Rfj2f/sDplBZPQ68w9bRTqBrAPwS9Vd0
xIy4KUSlon5A1UsFZKdC8SyOtfxPm3isstFb37cwVZtYA9JmW7pMa+6JyR+Uxa1u
oEW2JW2eG3qsQsqXoH4W9v10MEUVI02vCrHrvlkFjxitPpAsEDa9heMdJHIIlmKh
IFqIx1UxgYwSxO0Gfhsr/UICkSoNDHXVOSyVbrP97sPaLpg3ZtmPtQK+W43FXxof
SnKM9Bd5p1bHKgUj770SANoPARTo4EaM1iwRLqWxFeAYwRVHXZXBuI5V2iWEbhbB
N1FXeSsvYnSa1966EPTkpMzc8U6Jx+KLF6Xx2im0h2XfkDVDc+w8zUGj/pKWAev+
UArGLFUL+um5dT7uOcrnaPH6iD9Osc2cdBMGDSk7aEqs/YWCtwQ=
=jeMH
-----END PGP SIGNATURE-----

--3bwnce3ol6egwwjc--

