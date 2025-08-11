Return-Path: <linux-fsdevel+bounces-57325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE983B207D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFA794E2FE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9442D6621;
	Mon, 11 Aug 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfsFj2CH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837822D640D;
	Mon, 11 Aug 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911627; cv=none; b=ClSIbvhbNJGE3wKatsgqdClIbOPu0WOFEbUZrGrLtA4Cirk0hgTGRVW+gxkBQ5METOzW3Rjpbwpr/1VD0V2W6gXXEBLB5Adb3okiir3XFVd0ywzZH4oWuMB3YtMqKTtNBqoGOz3k1LGV/0ISR3vX2I3sSSup+05jpGuY8z5SwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911627; c=relaxed/simple;
	bh=bdl1TE3wEYNNmMpNx13gcAItLicZx/LsJ5QraJekwKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIk3fXt795Nrxce9BdyqdHxayZyRrz21miOCLa2CvubnqRDYKVrw4ww0YE5jYDWEyAoOyFyPTCVIcDJr7uhPQbVWNFwoXmtHaAlKm5eq1Si1P6Y8hZiRPf+fdtn40c8YD7ku02zrIeRy+q/7YPgfyr2+KFmmDo9AUWgdJT+XDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfsFj2CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709A3C4CEFC;
	Mon, 11 Aug 2025 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754911627;
	bh=bdl1TE3wEYNNmMpNx13gcAItLicZx/LsJ5QraJekwKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfsFj2CHlM89z0ZFtuDWWiWZpASfQ+arxzO+KODnqrurzTtbgAzfQmWC2OIa1vpbh
	 bqe7Om44PlUC7J5obfnA62AIv0d/HP3MnYE9H6gM8hYja7qPYrtDnxqyFbCakKG3qg
	 JC2RNj/YO4VzR4fPeIOblpNm95j4QQ7e+WzpzBkLyMNvIqI/PrTLtSHxNN0i8sxv9n
	 A1JykCB1kJOJ5wDh9iMWLOtbb9aLo+xLpmg5v8gRestcNTjO8VNHosJoEQUAggyOEC
	 iDQ3tEBdPXG1o9TzwpKKjIPMf7hZ1Ud/jLmndzjmtKAnew3HD2fqWsSf8W6xLew/NU
	 dX2EUMYakuEpA==
Date: Mon, 11 Aug 2025 13:27:01 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <5hwvf2iikfly5etcjmjmwvvlwwjx24vcxtcx5ph2tyddjei7ea@wismq7gycqtq>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
 <2025-08-09.1754760145-silky-magic-obituary-sting-3OnpC7@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhkatt56p6lnibbw"
Content-Disposition: inline
In-Reply-To: <2025-08-09.1754760145-silky-magic-obituary-sting-3OnpC7@cyphar.com>


--mhkatt56p6lnibbw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
 <2025-08-09.1754760145-silky-magic-obituary-sting-3OnpC7@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-08-09.1754760145-silky-magic-obituary-sting-3OnpC7@cyphar.com>

Hi Aleksa,

On Sun, Aug 10, 2025 at 03:32:25AM +1000, Aleksa Sarai wrote:
> On 2025-08-09, Askar Safin <safinaskar@zohomail.com> wrote:
> > I plan to do a lot of testing of "new" mount API on my computer.
> > It is quiet possible that I will find some bugs in these manpages durin=
g testing.
> > (I already found some, but I'm not sure.)
> > I think this will take 3-7 days.
> > So, Alejandro Colomar, please, don't merge this patchset until then.
>=20
> I don't plan to work on this again for the next week at least (I've
> already spent over a week on these docs -- writing, rewriting, and then
> rewriting once more for good measure; I've started seeing groff in my
> nightmares...), so I will go through review comments after you're done.
>
> There are some rough edges on these APIs I found while writing these
> docs, so I plan to fix those this cycle if possible (hopefully those
> aren't the bugs you said you found in the docs). Two of the fixes have
> already been merged in the vfs tree for 6.18 (the -ENODATA handling bug,
> as well as a bug in open_tree_attr() that would've let userspace trigger
> UAFs). (Once 6.18 is out, I will send a follow-up patchset to document
> the fixes.)
>=20
> FYI, I've already fixed the few ".BR \% FOO" typos. (My terminal font
> doesn't have a bold typeface, so when reviewing the rendered man-pages,
> mistakes involving .B are hard to spot.)

You can review in PDF if you want.  See the pdfman(1) script under
src/bin/.  It's quite portable:

	$ cat src/bin/pdfman=20
	#!/bin/bash
	#
	# Copyright, the authors of the Linux man-pages project
	# SPDX-License-Identifier: GPL-3.0-or-later

	set -Eeuo pipefail;
	shopt -s lastpipe;

	printf '%s\n' "${!#}.XXXXXX" \
	| sed 's,.*/,,' \
	| xargs mktemp -t \
	| read -r tmp;

	man -Tpdf "$@" >"$tmp";
	xdg-open "$tmp";

It works essentially like man(1), so you can pass any man(7) file as its
argument to read it as a PDF.

(You may or may not have it available in your system, if your distro
 packages a recent enough version of the project.)


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--mhkatt56p6lnibbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiZ04UACgkQ64mZXMKQ
wqn+Rg//cE0D1ACdqwB97w+VJ4X/09FRWYkNzZjdiAxipsgcbWHrt8mugn7T20mt
BoePq0DkHPiRIA3TX6wnYQzkHBaji4Ncv9R4pe3yxWAoFa6KXbghhmaAePg/xHqi
f7GlMVsx/8bSgXm+7cE/V+GRcSK9xLIzYCLRaNyZwaejt2GnNuZNpcvqkAsXi8dQ
MPf4kAQpflai7RRnK3+EDPuqp5W0u76okd5TdXNvnA28Rg5DJOFGNqyK9qM0wjFE
RGhWe0AlFdagzJB2AYawyyRJ1FpDZgtEs8y1C7v3Bxmt+XcxwdA7WsEpJvotF4Cp
Dbq3fGNKKf/nCsminEtRj5h/ETdjPGT7Nd5BegwElDSFSAHTrvpt8S+rwlqG3fFM
TFSqtSCezQkWH0bzdHKLXea5vSJ9bF4yzsS97FnaflZkHgVBKosJVrKA1zAeHfj2
8JXEHp1wZEaWPDKOPv5wfJCRVuLXORxL/yqa+FOIgbk9u0JeGQKCltdcpMepqPiu
bo5O2XRBDGf9KlMLjcrieZ3HWWYcmXe1uCM1+N6I1DBYSeOzKdv4e4d2U2AyueXI
rHR/OT01pVwR6NmulQCjnbwDWsR7h6qJII+BnEyzyiPnvH2TYtRoZA1+cov6Z0Fa
/w0TNO9CSPh4AKSpB4aTyTiPjfk6r+q+FE34Fun639xFhKT4ZOc=
=TBCD
-----END PGP SIGNATURE-----

--mhkatt56p6lnibbw--

