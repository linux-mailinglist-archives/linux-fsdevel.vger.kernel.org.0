Return-Path: <linux-fsdevel+bounces-62320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADDBB8D31B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 03:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7830217912E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F511624DF;
	Sun, 21 Sep 2025 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="f8b1ZJl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BD2F4A;
	Sun, 21 Sep 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758418439; cv=none; b=F/bZunO7pI2q2VChU0Rzzxl9RcukueToe5iF5yjUXxzdx3phlg79+lSgsRvwlcv9WZeF7yS4F+uZSHRH+N8Jru/NRbWH6ZJuo/xbw/qht09rLiC7htzsPRqiZBKIGUdt0bf5u2C5Xgl2rLrJdGnn3mxwJSbpgrtvW1aW51C381U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758418439; c=relaxed/simple;
	bh=eum0Inf5j/D2wGDHed9Hse32BrSEDt04Tl9cEMDkgQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp2lc+8wSSq+5X0vdnrWpDXR3FO+EOySJDjvq1Ya+AqHtATu03i2Q2CwQ4hcqBeOJwHBcQFVaJcP4bJI8IIP0J6A/a5WOT8OnRHPHsH32PgdjOecBuF3uvH7sqgOi5iI7qG+d7KPh33/YuGmBH7Mh+3TTIhKk4bUR06NSRFkp7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=f8b1ZJl1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cTpfz4Klcz9tDm;
	Sun, 21 Sep 2025 03:33:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758418427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3f6t6vmBYye0E4WtFhp7B8gfy+AGUsrH5RjZcfPxWfE=;
	b=f8b1ZJl1VflEK45c1k+XpXqo8jOv1O0XL2vgpmdxwO/Aue7t9Eju1URruWM5U+PqELbvB5
	Cyv7oeJ6JcgpV6xLBbg4dphi8NNS0ibnUV8W+wZNgoim/HeaPGhLlGI+PpjMtWAUY/+Uxn
	D326X+pWLLCWVI65Bi8ARRjMwLAzAihPFBemc0FGV8FZQ7OpjLHURpyxckPcl7KRZrWxTq
	vLSqHIFq5/0xSKkApJw0GE5lAywZCLBTefql46t8cKTaOeF2AZ6g8QCECSl/B9zHAOkvMF
	oRhfYoDpOK37ueq4DM13oe13Hn5JDyNj0CQbY9J6IxpA7ocpY2BI9zjkO4P7CQ==
Date: Sun, 21 Sep 2025 11:33:34 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
Message-ID: <2025-09-21-washed-creative-tenure-nibs-hssPyL@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>
 <zrifsd6vqj6ve25uipyeteuztncgwtzfmfnfsxhcjwcnxf2wen@xjx3y2g77uin>
 <2025-09-19-movable-minty-stopper-posse-7AufW3@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwjb6nrzo6dxs3w5"
Content-Disposition: inline
In-Reply-To: <2025-09-19-movable-minty-stopper-posse-7AufW3@cyphar.com>


--mwjb6nrzo6dxs3w5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
MIME-Version: 1.0

On 2025-09-20, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-09-19, Alejandro Colomar <alx@kernel.org> wrote:
> > Hi Aleksa,
> >=20
> > On Fri, Sep 19, 2025 at 11:59:43AM +1000, Aleksa Sarai wrote:
> > > This is loosely based on the original documentation written by David
> > > Howells and later maintained by Christian Brauner, but has been
> > > rewritten to be more from a user perspective (as well as fixing a few
> > > critical mistakes).
> > >=20
> > > Co-authored-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > Co-authored-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > >  man/man2/fsopen.2 | 384 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 384 insertions(+)
> > >=20
> > > diff --git a/man/man2/fsopen.2 b/man/man2/fsopen.2
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..7cdbeac7d64b7e5c969de=
e619a039ec947d1e981
> > > --- /dev/null
> > > +++ b/man/man2/fsopen.2
> > > @@ -0,0 +1,384 @@
> > > +.\" Copyright, the authors of the Linux man-pages project
> > > +.\"
> > > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > > +.\"
> > > +.TH fsopen 2 (date) "Linux man-pages (unreleased)"
> > > +.SH NAME
> > > +fsopen \- create a new filesystem context
> > > +.SH LIBRARY
> > > +Standard C library
> > > +.RI ( libc ,\~ \-lc )
> > > +.SH SYNOPSIS
> > > +.nf
> > > +.B #include <sys/mount.h>
> > > +.P
> > > +.BI "int fsopen(const char *" fsname ", unsigned int " flags );
> > > +.fi
> > > +.SH DESCRIPTION
> > > +The
> > > +.BR fsopen ()
> > > +system call is part of
> > > +the suite of file descriptor based mount facilities in Linux.
> >=20
> > Minor nitpick (I can amend that; no worries):
> >=20
> > Because 'file-descriptor-based' works as a single modifier of
> > facilities, it goes with hyphens.
>=20
> Will do for all of the new pages.

By the way, I'll wait for your review of all of the remaining man-pages
before sending v5. Thanks!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--mwjb6nrzo6dxs3w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaM9V7RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8FaAEAgxt7i7KVC477icQ2nXee
+07Nb+PeRvd/n8f4bdYp2+kA/A9g0PdvLFdVscUKDlU4nGnZJRZsoP6OIyn3n79G
TQ0L
=Ebeq
-----END PGP SIGNATURE-----

--mwjb6nrzo6dxs3w5--

