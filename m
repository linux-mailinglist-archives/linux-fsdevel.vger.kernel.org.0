Return-Path: <linux-fsdevel+bounces-67583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AFC43D5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 13:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF60188BFC3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE322EBDFB;
	Sun,  9 Nov 2025 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYbVgOxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD32EBDCD;
	Sun,  9 Nov 2025 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690833; cv=none; b=fpUYtgWYdD6iroeFN+aIjES3rYtXZKY+zHtK/dvWAsYEGNgKx8X57PAbUdhaEkF0yy9iH65GBaglc7c2reMIggxRCdhWPF4zfRvI6hoXlsG34unedbfGuQeupqcbCnZd1BS5Zh6S3pbJCW/FTjXl0gooIvq+vsC/Ml3EFFKrDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690833; c=relaxed/simple;
	bh=MUl+dTqbZ7YKKKUJEy7a4BIZnRoQfskt2IlZrrF+h24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSNu9zu1qNE/SDwl0ntoNKTjYaE16wvNa0v8OO8pBmRq2JP5QNTynhBPtjgyjeL5K0u9BTdWPsy7QESXIcgsTP2fL72QAYqqDWdnwFLvTIBdI07AA+wC652wrc1HrLtXmw7WnEg9Qd6MxDtror6/WQujrQzBFlLF3TPiZDF/WTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYbVgOxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F39C19423;
	Sun,  9 Nov 2025 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762690833;
	bh=MUl+dTqbZ7YKKKUJEy7a4BIZnRoQfskt2IlZrrF+h24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYbVgOxeR6H3AjeYrj/XMAsMU5/91mlBPu6I6I2Qhso2FiX/Jbxu/GvAcIQCG7l07
	 H1oUelvYVzAjO0kAhurJh9DwXLnGZmR6TbAeZNaKZdcnUgSdssNHNJhzyT4z03ExX6
	 uu6d8ocSA1FEBZNPsmxntlXkzpLc0NOUEoxPLPDprrkkqtccjt/ciHHD61yMaeLoON
	 5r5vz7BE13Up8FleS/dpu6uztj8HhcBf5za9n2/jMNys2su0r269+a8A9rmjDqdOyS
	 hE/8zhMxeBk6ogJVO1Xi1A1xECVerbjfJffslia3pPU/ufZ9vQX7B6gWtZrfeCGVut
	 qGBO0Hj4DMiIg==
Date: Sun, 9 Nov 2025 13:20:29 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Monakov <amonakov@ispras.ru>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] man/man2/flock.2: Mention non-atomicity w.r.t close
Message-ID: <u3b2gz7gc4iwrwomngg2gioxscu6lwucwl4egdhovh52u7dakb@knipbilujfex>
References: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
 <xvwzokj7inyw4x2brbuprosk5i2w53p3qjerkcjfsy6lg43krm@gp65tt2tg4kw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i2ksitioofyffpkb"
Content-Disposition: inline
In-Reply-To: <xvwzokj7inyw4x2brbuprosk5i2w53p3qjerkcjfsy6lg43krm@gp65tt2tg4kw>


--i2ksitioofyffpkb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Monakov <amonakov@ispras.ru>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] man/man2/flock.2: Mention non-atomicity w.r.t close
Message-ID: <u3b2gz7gc4iwrwomngg2gioxscu6lwucwl4egdhovh52u7dakb@knipbilujfex>
References: <181d561860e52955b29fe388ad089bde4f67241a.1760627023.git.amonakov@ispras.ru>
 <xvwzokj7inyw4x2brbuprosk5i2w53p3qjerkcjfsy6lg43krm@gp65tt2tg4kw>
MIME-Version: 1.0
In-Reply-To: <xvwzokj7inyw4x2brbuprosk5i2w53p3qjerkcjfsy6lg43krm@gp65tt2tg4kw>

Hi Alexander, Jan,

On Thu, Oct 30, 2025 at 10:21:30AM +0100, Jan Kara wrote:
> On Thu 16-10-25 18:22:36, Alexander Monakov wrote:
> > Ideally one should be able to use flock to synchronize with another
> > process (or thread) closing that file, for instance before attempting
> > to execve it (as execve of a file open for writing fails with ETXTBSY).
> >=20
> > Unfortunately, on Linux it is not reliable, because in the process of
> > closing a file its locks are dropped before the refcounts of the file
> > (as well as its underlying filesystem) are decremented, creating a race
> > window where execve of the just-unlocked file sees it as if still open.
> >=20
> > Linux developers have indicated that it is not easy to fix, and the
> > appropriate course of action for now is to document this limitation.
> >=20
> > Link: <https://lore.kernel.org/linux-fsdevel/68c99812-e933-ce93-17c0-3f=
e3ab01afb8@ispras.ru/>
> >=20
> > Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
>=20
> The change looks good to me. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!  I've applied the patch, and appended the tag.
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3Da=
fdd0a64c5bad49d6030ddc488951aeb50f0b88e>


Have a lovely day!
Alex

>=20
> 								Honza
> > ---
> >  man/man2/flock.2 | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/man/man2/flock.2 b/man/man2/flock.2
> > index b424b3267..793eaa3bd 100644
> > --- a/man/man2/flock.2
> > +++ b/man/man2/flock.2
> > @@ -245,6 +245,21 @@ .SH NOTES
> >  and occurs on many other implementations.)
> >  .\" Kernel 2.5.21 changed things a little: during lock conversion
> >  .\" it is now the highest priority process that will get the lock -- m=
tk
> > +.P
> > +Release of a lock when a file descriptor is closed
> > +is not sequenced after all observable effects of
> > +.BR close (2).
> > +For example, if one process writes a file while holding an exclusive l=
ock,
> > +then closes that file, and another process blocks placing a shared lock
> > +on that file to wait until it is closed, it may observe that subsequent
> > +.BR execve (2)
> > +of that file fails with
> > +.BR ETXTBSY ,
> > +and
> > +.BR umount (2)
> > +of its underlying filesystem fails with
> > +.BR EBUSY ,
> > +as if the file is still open in the first process.
> >  .SH SEE ALSO
> >  .BR flock (1),
> >  .BR close (2),
> >=20
> > Range-diff against v0:
> > -:  --------- > 1:  181d56186 man/man2/flock.2: Mention non-atomicity w=
=2Er.t close
> > --=20
> > 2.49.1
> >=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--i2ksitioofyffpkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkQhw0ACgkQ64mZXMKQ
wqnN2Q//Z+PbivK/qNOGipga3ohs3ymSdFjaFCTz75FjDtkXa8BVnRakTgnvr91x
n3D1L3xy27OdjsplCQ529EhCvlrmpnQoPy0fH8qPDug8tqIEQYOvVt91UpfFbJG6
Yov0RWAQSt4GxBKZ9g553wmJI3dZjKmN8oM8yDQUHxaKGVmBP/oWUi8l9U5KJpHK
jmEvQ3pgEYHzh3k0G7S2gMp38WsTLFOvnEQUs6ekMOU+dqnzXTdc8ZjYM7GW3dEh
P4YeCmfqOh0DZzebGrRRztcAeECiHfvIAfE7BNAR+D8lWGMeAYJOAmpaGIiFebsF
+iGY6oes14hD7Jy1oRikaJJL+nDHtDNMXXSDS2v9wOR9BszdLj5iY0lpaH2F1WtX
g0clG/R8JdHHPhHrHc1ukQqxO0DEJ6wuuD0ZYdbJVH49B3+M0phgu2JrGYxUqoIa
ShEcESRg65ye6myq5rXbdHtdqr4ZJY44RSEsRKx64wOKgcmlHKzL7vNZ3xOTLJXM
eBXroC6kiRPNzx/EJk3udl5vTMPGalhMmcTL8HEy8xmmaCRTShT7UY2Atg28MkLe
qrm/Dxc6fipfeshjUjEIG2DfwVO1aKUDf/Hz5zAUtMuii8eu+FdoKuexZFc9zpoV
R+B6DS4avQ8+2Vrl062zK0Sag/REMbfWnV657twuJvQhEidM9bM=
=24qw
-----END PGP SIGNATURE-----

--i2ksitioofyffpkb--

