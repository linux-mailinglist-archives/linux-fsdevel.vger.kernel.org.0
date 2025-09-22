Return-Path: <linux-fsdevel+bounces-62401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF7B91617
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEC83B3782
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2875D30C0FB;
	Mon, 22 Sep 2025 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxMQ+NBa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77169277CAE;
	Mon, 22 Sep 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547354; cv=none; b=edMSJoPXDK8KC+fCdVNRdIreB3niPyaIslWbqfsNoezfW22psEdHqkrbClTso78tWRgY4VITcna1Kih3flwTfM2bRnWPbNkBfkjcheRk/6cYxuUSwh3HIH6Hce34Ug3/7Q8QDEOmkCmpNd8zyXFFe0hE+1M0poicIMYYwOEgpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547354; c=relaxed/simple;
	bh=ZpKHIENUoUhwJkuDvGTZQgZeFO4daeKHvVKAGsIWa6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWtViyf41VLzS8pzeqWASgM2qEAd3YFZXrZvucJY0FdwWkUmv6tCUbgXvdk+ngjJzQW0Ygz2L5bYrTfsYaMC+ZAlAQBgEyrpj0aoM1wb+KxnKPFsjcGRb2UNW9cHkcKmZTottwKBN79fXTvLRnNZGcWFcRZfgK4KDu41aVRpEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxMQ+NBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE6CC4CEF0;
	Mon, 22 Sep 2025 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758547354;
	bh=ZpKHIENUoUhwJkuDvGTZQgZeFO4daeKHvVKAGsIWa6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxMQ+NBaYfUgnSnuDkJYaXuxgtOBdZrWoJREzP8yz4GQab96ehxCmsrBMhRAexhbd
	 AVY2Yu0ZfZcpCVvN/C4nr/4yhcYC+EjteZTvMibtAfkZEpIoTkWjm8xfyCp5DmUmLB
	 qbZIGeBMteZsO/RMH7VTcMN4sRjNU6GBHDdgEtuS+4M0vcPODsApRuouimWs9xIl+I
	 Qj1sntMi+lCClH8Q/tM89TjzY7Jq4MxM7iJw2HdQbQAj9K0r5kpT6Xn81kFPp7m3FC
	 J9hjJ4wNlclaLmnRETExM1XMIkV30rlXMUS5wxlKMEHH3URNBR2DD5DlE2qSNB4pc2
	 KqieoFBm+lNeQ==
Date: Mon, 22 Sep 2025 15:22:27 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
Message-ID: <aqhcwkln4fls44e2o6pwnepex6yec6lg2jnngrtck3g5pc6q5d@7zibx3l2vrjw>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>
 <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>
 <2025-09-22-sneaky-similar-mind-cilantro-u1EJJ2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gv4y3hrk7klyb5b"
Content-Disposition: inline
In-Reply-To: <2025-09-22-sneaky-similar-mind-cilantro-u1EJJ2@cyphar.com>


--7gv4y3hrk7klyb5b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 07/10] man/man2/open_tree.2: document "new" mount API
Message-ID: <aqhcwkln4fls44e2o6pwnepex6yec6lg2jnngrtck3g5pc6q5d@7zibx3l2vrjw>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-7-1261201ab562@cyphar.com>
 <gyhtwwu7kgkaz5l5h46ll3voypfk74cahpfpmagbngj3va3x7c@pm3pssyst2al>
 <2025-09-22-sneaky-similar-mind-cilantro-u1EJJ2@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-22-sneaky-similar-mind-cilantro-u1EJJ2@cyphar.com>

Hi Aleksa,

On Mon, Sep 22, 2025 at 08:09:47PM +1000, Aleksa Sarai wrote:
> > > +is lazy\[em]akin to calling
> >=20
> > I prefer em dashes in both sides of the parenthetical; it more clearly
> > denotes where it ends.
> >=20
> > 	is lazy
> > 	\[em]akin to calling
> > 	.BR umount2 (2)
> > 	with
> > 	.BR MOUNT_DETACH \[em];
>=20
> An \[em] next to a ";"? Let me see if I can rewrite it to avoid this...

You could use parentheses, maybe.

> > > +.IR "mount --bind" )
> >=20
> > You need to escape dashes in manual pages.  Otherwise, they're formatted
> > as hyphens, which can't be pasted into the terminal (and another
> > consequence is not being able to search for them in the man(1) reader
> > with literal dashes).
> >=20
> > Depending on your system, you might be able to search for them or paste
> > them to the terminal, because some distros patch this in
> > /etc/local/an.tmac, at the expense of generating lower quality pages,
> > but in general don't rely on that.
> >=20
> > I've noticed now, but this probably also happens in previous pages in
> > this patch set.
> >=20
> > While at it, you should also use a non-breaking space, to keep the
> > entire command in the same line.
> >=20
> > 	.IR \%mount\~\-\-bind )
>=20
> My bad, I think my terminal font doesn't distinguish between them well
> enough for it to be obvious. I'll go through and fix up all of these
> cases.

I should probably add an automated diagnostic.  At least the case of two
'--' together, which I've never seen useful unescaped, should be
diagnosed.  I'll add a make(1) 'lint-man-dash' target that catches this
with a regex.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--7gv4y3hrk7klyb5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjRTYwACgkQ64mZXMKQ
wqmm2A//QAHUgf3mNDz7yAdWfueHzIl/M5wGQa4+TZCh+4v+dwqkN7OFGtbtD42p
LO4vBmhKrX32iPDMaLrK5Luj7t5IgSSSHi9ZbkN1stgl8ku+XIdpq3ApYPuYKKyB
JecginBsLE9Z+tqRN5uzsLx+lyDdcPrq1F/5KVNCN53Dn1C9oz0+/tiWxNIQYo4Z
s6gvyGMTuPB31WzTXI0dzb2JxT/Dw+19lGWUJnpMl1HzCKMWLf+YFKXkydNH+6NZ
CDmX9DFPQsL/VIa9igU5jIyudpJs5kkH5dXqQHO3xbMS73OLjNhlJLeFLPNaXQa7
idx+L873f+7DQ4dD8UPmlKn3uVn99DkXPcYzmqFaLS1pCuBag5Q8YQkBASd9VJZn
bG/EhmKT0XhKkCj7ake/NraSmIPn1XO7IdwTS0S3vuZUqaHc9BW1zxisM116Qfbi
Ht7f4a+T4vOuesk6IBdpLgc0p5ZyRiQAx70dAOmOgzSvGsmQvKY9R8xpElbyKW2v
AixCwUXNzpga2TVI/eJb2KxcffSJk5WV/FYMyV3GpT+VieUcEcDzl9E3EpAiQWpO
6BVQFsXP9PwtsyuGLbtKtpAd1M+5xNkysuIymBvFKB1ysDc6IgTte/QrD8qAJPu4
JJozjcn5qG2NjWl22s5zSrmM83p/np56cGpQ15G3qTv+Sg9IJkQ=
=DYOq
-----END PGP SIGNATURE-----

--7gv4y3hrk7klyb5b--

