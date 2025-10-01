Return-Path: <linux-fsdevel+bounces-63198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9FCBB179D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 20:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E81C4E59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5F2D46B3;
	Wed,  1 Oct 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRi0H01d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0049620;
	Wed,  1 Oct 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342849; cv=none; b=ZO0/ZOFn/b3RsAtevLyypdOhjS1bZ40as45zLZri1QnIM8rPnLFNMtKZ0lDD+Ndr1ddPgj/ncMPHMtKT0GH2c+cFV2FWCjuikOEb+UU+NBVtQ+SepMmOb+38VgwK0+BwXpPzxsvMUXGXNe3Yp9vab2k1+fnl3vYQfirBCOJYpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342849; c=relaxed/simple;
	bh=RWkh2In6NeJlX7Zu0p4kcyT2zuEZ4+D6PLyRU9uV/bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2AwMmzFLF3kH2kfePx7k9gfxeamzTVUSAt0Vu+07i7nVgmJxNolCMQT9MUSE71AHMrr6jl1infxeOD6OOWE7HNAs17WW0X1Lf6vfOXV7dkPUfH/JtJ5nSOkT/1CMyFfxi5bfJXGjnFr/NMeC69ZE7slaogthp9xPpW2djUZ9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRi0H01d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29A0C4CEF1;
	Wed,  1 Oct 2025 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759342849;
	bh=RWkh2In6NeJlX7Zu0p4kcyT2zuEZ4+D6PLyRU9uV/bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRi0H01dAZGevaGb9Cj0CxImVQltEgXyMf+ZfzktHylR1bw52XHYzDWdxOaBfO7Wy
	 30fcFKozjYFTSqimdBP8RwSRTZ4fkuLpnjz3P9/c8zdac1mIzOfmct+K8EBKatmxLd
	 H6HRfuurqLWWZRnhcjZhGAL5UG2WQPKi4Z6HeraHKTThwLlH8sIIt/3+yM0bIfvZf7
	 xN51x2OuFXos3Ja9EAKMnMWDK9QQCLrO+FCK0qqRiQo3eBGt5R5+Te8HVOoPhEzsx1
	 MWUip2K41iroUltCCRLSX80nYu8VgQnX/SGgtThCnrY3IA/7vAFVtKP8kuMDEtMdpv
	 NjKvXPub7lwDg==
Date: Wed, 1 Oct 2025 20:20:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Message-ID: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pvasxid6oblmeza6"
Content-Disposition: inline
In-Reply-To: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>


--pvasxid6oblmeza6
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
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Message-ID: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>

Hi Aleksa, Askar,

On Thu, Sep 25, 2025 at 01:31:22AM +1000, Aleksa Sarai wrote:
> Back in 2019, the new mount API was merged[1]. David Howells then set
> about writing man pages for these new APIs, and sent some patches back
> in 2020[2].
>=20

[...]

>=20
> In addition, I have also included a man page for open_tree_attr(2) (as a
> subsection of the new open_tree(2) man page), which was merged in Linux
> 6.15.
>=20
> [1]: https://lore.kernel.org/all/20190507204921.GL23075@ZenIV.linux.org.u=
k/
> [2]: https://lore.kernel.org/linux-man/159680892602.29015.655186026043654=
4999.stgit@warthog.procyon.org.uk/
> [3]: https://github.com/brauner/man-pages-md
>=20
> Co-authored-by: David Howells <dhowells@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-authored-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

The full patch set has been merged now.  I've done a merge commit where
I've pasted this cover letter, and amended it so that Aleksa is the
author of the merge commit.  I've also included Askar's Reviewed-by tag
in the merge commit itself.

I'll have it in a separate branch for a few days, in case I need to fix
anything.  You can check it here:

<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?h=3Dfs>

I editorialized the titles, but other than that, I didn't do much.
I think I mentioned most of the changes in replies to each patch.

Thanks a lot for your contributions!


Have a lovely night!
Alex

> ---
> Changes in v5:
> - `sed -i s|file descriptor based|file-descriptor-based|`.
>   [Alejandro Colomar]
> - fsconfig(2): use bullets instead of ordered list for workflow
>   description. [Alejandro Colomar]
> - mount_setattr(2): fix minor wording nit in new attribute-parameter
>   subsection.
> - fsopen(2): remove brackets around "message" for message retrieval
>   interface description. [Alejandro Colomar]
> - {move_mount,fspick}(2): fix remaining incorrect no-automount text.
>   [Askar Safin]
> - {fsmount,open_tree}(2): `sed -i s|MOUNT_DETACH|MNT_DETACH|g`.
>   [Askar Safin]
> - mount_setattr(2): fix copy-paste snafu in attribute-parameter
>   subsection. [Askar Safin]
> - *: clean `make -R build-catman-troff`. [Alejandro Colomar]
> - *: switch to \[em]\c where appropriate.
> - open_tree(2): clean up MNT_DETACH-on-close description and make it
>   slightly more prominent. [Alejandro Colomar]
> - open_tree(2): mention the distinction from open(O_PATH) with regards
>   to automounts. Askar suggested it be put in the section about
>   ~OPEN_TREE_CLONE, but the change in behaviour also applies to
>   OPEN_TREE_CLONE and it looked awkward to include it in the
>   dentry_open() case because O_PATH only gets mentioned in the following
>   paragraph (where I've put the text now). [Askar Safin]
> - {move_mount,open_tree{,_attr}}(2): fix column-width-related "make -R
>   check" failures.
> - *: fix remaining "make -R lint" failures.
> - open_tree_attr(2): add example using MOUNT_ATTR_IDMAP.
> - v4: <https://lore.kernel.org/r/20250919-new-mount-api-v4-0-1261201ab562=
@cyphar.com>
>=20
> Changes in v4:
> - `sed -i s|\\% |\\%|g`.
> - Remove unneeded quotes in SYNOPSIS. [Alejandro Colomar]
> - open_tree(2): fix leftover confusing usages of "attach" when referring
>   to file descriptors being associated with mount objects.
> - open_tree(2): rename "Anonymous mount namespaces" NOTES subsection to
>   the far more informative "Mount propagation" and clean up the wording
>   a little.
> - open_tree_attr(2): add a code comment about
>   <https://lore.kernel.org/all/20250808-open_tree_attr-bugfix-idmap-v1-0-=
0ec7bc05646c@cyphar.com/>
> - {fsconfig,open_tree_attr}(2): use _Nullable.
> - {fsmount,open_tree}(2): mention the the unmount-on-close behaviour is
>   actually lazy (a-la MNT_DETACH).
> - {fsconfig,mount_setattr}(2): improve "mount attributes and filesystem
>   parameters" wording to make it clearer that superblock and mount flags
>   are sibling properties, not the same thing.
> - open_tree(2): mention that any mount propagation events while the
>   mount object is detached are completely lost -- i.e., they don't get
>   replayed once you attach the mount somewhere.
> - fsconfig(2): fix minor grammatical / missing joining word issues.
> - fsconfig(2): fix final leftover `.IR A " and " B` cases.
> - fsconfig(2): explain that failed fsconfig(FSCONFIG_CMD_*) operations
>   render the filesystem context invalid.
> - fsconfig(2): rework the description of superblock reuse, as the
>   previous text was very wrong. (Though there has been discussion about
>   changing this behaviour...)
> - fsconfig(2): remove misleading wording in FSCONFIG_CMD_CREATE_EXCL
>   about how we are requesting a new filesystem instance -- in theory
>   filesystems could take this request into account but in practice none
>   do (and it seems unlikely any ever will).
> - fsconfig(2): mention that key, value, and aux must be 0 or NULL for
>   FSCONFIG_CMD_RECONF.
> - fsmount(2): fix usage of "filesystem instance" in relation to
>   fsmount() and open_tree() comparison. [Askar Safin]
> - move_mount(2): "as attached" -> "as a detached" [Askar Safin]
> - fspick(2): add note about filesystem parameter list being copied
>   rather than reset with FSCONFIG_CMD_RECONFIGURE. [Askar Safin]
> - v3: <https://lore.kernel.org/r/20250809-new-mount-api-v3-0-f61405c80f34=
@cyphar.com>
>=20
> Changes in v3:
> - `sed -i s|Co-developed-by|Co-authored-by|g`. [Alejandro Colomar]
>   - Add Signed-off-by for co-authors. [Christian Brauner]
> - `sed -i s|needs-mount|awaiting-mount|g`, to match the kernel parlance.
> - Fix VERSIONS/HISTORY mixup in mount_attr(2type) that was copied from
>   open_how(2type). [Alejandro Colomar]
> - Fix incorrect .BR usage in SYNOPSIS.
> - Some more semantic newlines fixes. [Alejandro Colomar]
> - Minor fixes suggested by Alejandro. [Alejandro Colomar]
> - open_tree_attr(2): heavily reword everything to be better formatted
>   and more explicit about its behaviour.
> - open_tree(2): write proper explanatory paragraphs for the EXAMPLES.
> - mount_setattr(2): fix stray doublequote in SYNOPSIS. [Askar Safin]
> - fsopen(2): rework structure of the DESCRIPTION introduction.
> - fsopen(2): explicitly say that read(2) errors in the message retrieval
>   interface are actual errors, not return 0. [Askar Safin]
> - fsopen(2): add BUGS section to describe the unfortunate -ENODATA
>   message dropping behaviour that should be fixed by
>   <https://lore.kernel.org/r/20250807-fscontext-log-cleanups-v3-0-8d91d62=
42dc3@cyphar.com/>.
> - fsconfig(2): add a NOTES subsection about generic filesystem
>   parameters.
> - fsconfig(2): add comment about the weirdness surrounding
>   FSCONFIG_SET_PATH.
> - {fspick,open_tree}(2): Correct AT_NO_AUTOMOUNT description (copied
>   from David, who probably copied it from statx(2)) -- AT_NO_AUTOMOUNT
>   applies to all path components, not just the final one. [Christian
>   Brauner]
> - statx(2): fix AT_NO_AUTOMOUNT documentation.
> - open_tree(2): swap open(2) reference for openat(2) when saying that
>   the result is identical. [Askar Safin]
> - fsmount(2): fix DESCRIPTION introduction, and rework attr_flags
>   description to better reference mount_setattr(2).
> - {fsopen,fspick,fsmount,open_tree}(2): don't use "attach" when talking
>   about the file descriptors we return that reference in-kernel objects,
>   to avoid confusing readers with mount object attachment status.
> - fsconfig(2): remove pidns argument example, as it was kind of unclear
>   and referenced kernel features not yet merged.
> - fsconfig(2): remove rambling FSCONFIG_SET_PATH_EMPTY text (which
>   mostly describes an academic issue that doesn't apply to any existing
>   filesystem), and instead add a CAVEATS section which touches on the
>   weird type behaviour of fsconfig(2).
> - v2: <https://lore.kernel.org/r/20250807-new-mount-api-v2-0-558a27b8068c=
@cyphar.com>
>=20
> Changes in v2:
> - `make -R lint-man`. [Alejandro Colomar]
> - `sed -i s|Glibc|glibc|g`. [Alejandro Colomar]
> - `sed -i s|pathname|path|g` [Alejandro Colomar]
> - Clean up macro usage, example code, and synopsis. [Alejandro Colomar]
> - Try to use semantic newlines. [Alejandro Colomar]
> - Make sure the usage of "filesystem context", "filesystem instance",
>   and "mount object" are consistent. [Askar Safin]
> - Avoid referring to these syscalls without an "at" suffix as "*at()
>   syscalls". [Askar Safin]
> - Use \% to avoid hyphenation of constants. [Askar Safin, G. Branden Robi=
nson]
> - Add a new subsection to mount_setattr(2) to describe the distinction
>   between mount attributes and filesystem parameters.
> - (Under protest) double-space-after-period formatted commit messages.
> - v1: <https://lore.kernel.org/r/20250806-new-mount-api-v1-0-8678f56c6ee0=
@cyphar.com>
>=20
> ---
> Aleksa Sarai (8):
>       man/man2/fsopen.2: document "new" mount API
>       man/man2/fspick.2: document "new" mount API
>       man/man2/fsconfig.2: document "new" mount API
>       man/man2/fsmount.2: document "new" mount API
>       man/man2/move_mount.2: document "new" mount API
>       man/man2/open_tree.2: document "new" mount API
>       man/man2/open_tree{,_attr}.2: document new open_tree_attr() API
>       man/man2/{fsconfig,mount_setattr}.2: add note about attribute-param=
eter distinction
>=20
>  man/man2/fsconfig.2       | 741 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  man/man2/fsmount.2        | 231 +++++++++++++++
>  man/man2/fsopen.2         | 385 ++++++++++++++++++++++++
>  man/man2/fspick.2         | 343 +++++++++++++++++++++
>  man/man2/mount_setattr.2  |  39 +++
>  man/man2/move_mount.2     | 646 ++++++++++++++++++++++++++++++++++++++++
>  man/man2/open_tree.2      | 709 ++++++++++++++++++++++++++++++++++++++++=
++++
>  man/man2/open_tree_attr.2 |   1 +
>  8 files changed, 3095 insertions(+)
> ---
> base-commit: f17990c243eafc1891ff692f90b6ce42e6449be8
> change-id: 20250802-new-mount-api-436db984f432
>=20
>=20
> Kind regards,
> --=20
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--pvasxid6oblmeza6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjdcPsACgkQ64mZXMKQ
wqke7BAAlcSpSz5fxY84SbRo4r0HZzq+N5BDpbcAasExUOGkCzIO/Nta/6tidFNA
YcRvcidJWAJ0KvyFTXCVDT3DOd+A8jd7IDujWVdLBVBt1doslJaHheVticsBVQEE
8+teyjEnyX8C0Mk5X+YSVvLwogqXIDHTkXLlfGAhrtpAQBbBnmBDZRRkBcUtqJMC
XUO2CNPahKXI3nPUJbmmp8sq55c7Rpx16SrIzg5mYEDVEQb/HfIvpOfVeAGhtN+M
L9bseUx0upAqTrSRm9bUIT6sf51poHqs2kTv6yX8Ay3/hXKC4Fnc/Zt4TU7kXLu6
RWk73J1W6Pal7bVIyQmIxaCOhmjhzuLhiMtBeLuRZ9m20w2XbjpIZApoxYChAqIk
9VdGq2Vh/HBker339iJl1J2U9Mjmc8gpWk3i1wNEZJ8ked1FRGfHIU8r3nFXPS8M
JfmW/q1svdTjlwV8a9/SxQJeA0hvrhRQVX05oBGs6rJoSLU72darOpv2/dbxY4wG
u4tNVOZ5qUcjZ9Y7io+7kI2uTrblqq52q2tDWDZ+zu6FVyW7wAbRDK3xPijuuCPq
uLoFV2y3+dbJILGawdCi1M4s+MG9PPop0ldhLD//svuZWgxymochsh+LgkVwlCYS
hhJN59qwuLzfSz/yYyb6nvgsDk72QdnVd496DF+uSJ/3NZhgkx8=
=dJMv
-----END PGP SIGNATURE-----

--pvasxid6oblmeza6--

