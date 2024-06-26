Return-Path: <linux-fsdevel+bounces-22540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2DC918ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7839A2832C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1940190066;
	Wed, 26 Jun 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWY+gloX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAB33C5;
	Wed, 26 Jun 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427692; cv=none; b=jYBRd86gjZYHm4mZ70r2e01cXb3k28otF9580ujcn5z5sFweg8X2BryUF3b9uePQevl04DfPOS/A8+PdDqZNXSrU72Ltqfp5YvAwKUahiuFzgucvlSkZ4yDatE/U1x+sBADSTUTmJyw5btxVrZblarhEziMiPAMvojWxaB8VJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427692; c=relaxed/simple;
	bh=MXyRv2/EuUiRnqhiVTr61Ncqv5aY90G16hLqfEyeGDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7iWHIhmaSB0c1OznyQdNU/ZKssHmbpsCreyJjDBl0MzhzRA4GsKnINCNAFcSrb1HGQ0eY1jXOl4410HM2PoTdKdQ4NtHasvz558d9WqG/lS+bDollb1VWXM8Q8htQWTYf2iwC3eMim9PWFizsYAOHfYVpK4KJ8F8C19QULjA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWY+gloX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803A9C116B1;
	Wed, 26 Jun 2024 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719427691;
	bh=MXyRv2/EuUiRnqhiVTr61Ncqv5aY90G16hLqfEyeGDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWY+gloX1tgUFyZWAI3YnonC4fKMGtbEvXQzke019LYMYyEW3dfLtBq2yQ+/zYkIR
	 r05Hl50V7te5V+pKcdOe/HIljDgZQDdqOW+lB5AqUwrMNF7me6N1CHyd/TnAiC0/P0
	 VBxH7vuPAViIH+8UK5Uakez8AjZR/XJ9A6h99UfvWtLjO+cKy1QYPUti61jZKoABN7
	 ugu3VDEr3fBPabliKF9l62A7aOc7Lb17Cqjxjupzzf8uH9U7ZaIiN41Wa9AQPx70zP
	 n9EKUoskgG0gWx2VnLqp/8FpHHIiyQqQNXyRn7ZDW5kKDAAKvtB6uHU7eGtxe6jQDt
	 leCY6mhctLaig==
Date: Wed, 26 Jun 2024 20:48:08 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] man-pages: add documentation for
 statmount/listmount
Message-ID: <zg4fe5xw3gp5tvrcrp5yk2e4ogkmrzv3q3omh3c33ybbfbczib@ev5vhgjjljec>
References: <cover.1719425922.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2ldyc6l75eqxkt6"
Content-Disposition: inline
In-Reply-To: <cover.1719425922.git.josef@toxicpanda.com>


--r2ldyc6l75eqxkt6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] man-pages: add documentation for
 statmount/listmount
References: <cover.1719425922.git.josef@toxicpanda.com>
MIME-Version: 1.0
In-Reply-To: <cover.1719425922.git.josef@toxicpanda.com>

Hi Josef,

On Wed, Jun 26, 2024 at 02:21:38PM GMT, Josef Bacik wrote:
> V2: https://lore.kernel.org/linux-fsdevel/cover.1719417184.git.josef@toxi=
cpanda.com/
> V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxi=
cpanda.com/
>=20
> v2->v3:
> - Removed a spurious \t comment in listmount.2 (took me a while to figure=
 out
>   why it was needed in statmount.2 but not listmount.2, it's because it l=
ets you
>   know that there's a TS in the manpage).

Yep; here's the Makefile relevant rule:

$ grepc -x mk -tr _LINT_man_tbl share/mk/
share/mk/lint/man/tbl.mk:$(_LINT_man_tbl): %.lint-man.tbl.touch: % $(MK) | =
$$(@D)/
	$(info	$(INFO_)GREP		$@)
	$(HEAD) -n1 <$< \
	| if $(GREP) '\\" t$$' >/dev/null; then \
		$(CAT) <$< \
		| if ! $(GREP) '^\.TS$$' >/dev/null; then \
			>&2 $(ECHO) "$<:1: spurious '\\\" t' comment:"; \
			>&2 $(HEAD) -n1 <$<; \
			exit 1; \
		fi; \
	else \
		$(CAT) <$< \
		| if $(GREP) '^\.TS$$' >/dev/null; then \
			>&2 $(ECHO) "$<:1: missing '\\\" t' comment:"; \
			>&2 $(HEAD) -n1 <$<; \
			exit 1; \
		fi; \
	fi
	$(TAIL) -n+2 <$< \
	| if $(GREP) '\\" t$$' >/dev/null; then \
		>&2 $(ECHO) "$<: spurious '\\\" t' not in first line:"; \
		>&2 $(GREP) -n '\\" t$$' $< /dev/null; \
		exit 1; \
	fi
	$(TOUCH) $@

Maybe I should expand those error messages to be a little bit more
clear.

> - Fixed some unbalanced " in both pages
> - Removed a EE in the nf section which is apparently not needed

You need to do:

=2Enf
foo
=2Efi
=2EEX
bar
=2EEE

You cannot nest them.  The following code is wrong (I discovered that
recently):

=2Enf
foo
=2EEX
bar
=2EEE
=2Efi

See this commit:

<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3Da=
911df9e88dedc801bed50eb92c26002729af9c0>
commit a911df9e88dedc801bed50eb92c26002729af9c0
Author: Alejandro Colomar <alx@kernel.org>
Date:   Mon Jun 17 01:18:39 2024 +0200

    man/, share/mk/: Fix nested EX/EE within nf/fi
   =20
    EX/EE can't be nested within nf/ni.  The mandoc(1) reports weren't
    spurious.
   =20
    Re-enable the mandoc(1) warnings, and fix the code.
   =20
    Fixes: 31203a0c8dbf ("share/mk/: Globally disable two spurious mandoc(1=
) wa>
    Link: <https://lists.gnu.org/archive/html/groff/2024-06/msg00019.html>
    Reported-by: Douglas McIlroy <douglas.mcilroy@dartmouth.edu>
    Cc: "G. Branden Robinson" <branden@debian.org>
    Signed-off-by: Alejandro Colomar <alx@kernel.org>


> v1->v2:
> - Dropped the statx patch as Alejandro already took it (thanks!)
> - Reworked everything to use semantic newlines
> - Addressed all of the comments on the statmount.2 man page
>=20
> Got more of the checks to run so found more issues, fixed those up, but n=
o big
> changes.  Thanks,

Thanks.  I'll review the patches soon, hopefully.

Have a lovely night!
Alex

>=20
> Josef
>=20
> Josef Bacik (2):
>   statmount.2: New page describing the statmount syscall
>   listmount.2: New page describing the listmount syscall
>=20
>  man/man2/listmount.2 | 111 +++++++++++++++++
>  man/man2/statmount.2 | 285 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 396 insertions(+)
>  create mode 100644 man/man2/listmount.2
>  create mode 100644 man/man2/statmount.2
>=20
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--r2ldyc6l75eqxkt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZ8YmgACgkQnowa+77/
2zLHRBAAjaTtj1/Ym66rGd/gDx+HCqb2DkcnUELoP8INvCLtXqPfA7VhXvmjQ/cc
W4MKmz316lQYK/u4UiSvTIuato972LgQiF/swefG5UnEYCxSLcDj5RBMuf824Hps
qiE7LfabMQeMbEImK282rmtniXhD7STiY5MRDYlnloU+0dLnQFY4ukacExHh5wbq
elYrdAUqMQIATTMaPEyiECzRhRxsTkWU9WhSByOZTSXV7qSKF++ObQadES7ylFZM
nvBrI8IubnoDMRxC3mDdL1KRQWsINn+hhtEFutjmW1sozB9uqFrOFISOSFSpnEZJ
RYvil7bhkLalnppUwJg2w6Y1hb0SE7/0d5flKB7LKsIUOVzGZcb8/t6A8H4R4lKw
+KE6vIFwqulIhdONGPX3LcktHrI6bX+3VUxxok6jXBn5ploRbkP2Mgpd+eLEsojH
Mk0+JP8Dw0MMCXFeMDPxiYQuUqjZEd8XoxA3QD4XyHzaSYmCZu+IBLEg3makBTGX
Y0LkECBxG5MJF79qF0OWcK2gfafFI/eaoplNR+bGuATvQvkskGoi9KJuzGVpJqVE
8w1CslMV5qj/L4pW++oG0YOT4b9Ek8kfpUy32Icrgu1JkdA4eKE8N1/HESJuOxVp
vSfvN1vn6cDKY/oNhGCWLU6CrUl4iz1NfOplF6YTr0Q3GEQAiC8=
=9a+l
-----END PGP SIGNATURE-----

--r2ldyc6l75eqxkt6--

