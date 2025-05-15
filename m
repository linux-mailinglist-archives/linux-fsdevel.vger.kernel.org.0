Return-Path: <linux-fsdevel+bounces-49199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC27AB91CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA57F4A4E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF225A349;
	Thu, 15 May 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlHedDjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4784B1E5A;
	Thu, 15 May 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344809; cv=none; b=e1afDAIURZp5XiFaOPOhtm9k3xSqR6HHgdLT47wcWy9WvRuKfogbuU+RigsoDuBYm4+Of3b++M33m2u+TYWdLuEiPXQ6bAdURJpTZ5TLcCt1li60V4Wk7WI11gTDSBV0Yu8dGWFWGS94I3lUQPzwEnLXlPQswZsiJmHgs647Bek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344809; c=relaxed/simple;
	bh=HS6+w7E1NcZ6wrFcfiMyTkG1om6UBuFGHI+0QFDjUPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t04gX9QgaSqySOKw7F4WBVvJP4S1yIFCiiYvhFf6FBFJMM2V00JUpc8iMc5+ubE9gWm4NryQ0DBeSYOeMy2Uzen0K3P228CywBkW3168kwmVTSbbRlniThRkR8nXTY2ShkzcjqUEihzu0ZkBtLRyJTisYLVHDZqPHXVZW19wgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlHedDjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B07BC4CEE7;
	Thu, 15 May 2025 21:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344808;
	bh=HS6+w7E1NcZ6wrFcfiMyTkG1om6UBuFGHI+0QFDjUPY=;
	h=Date:From:To:Cc:Subject:From;
	b=QlHedDjlakDAp1gn8VaRbKJMCQzo5/XaCmWPp6eLMfteoHVFsYFprtXgO+TmEtppK
	 kW2QLv8PxaHYVUIkqyI6m4GYhqc0JPBvtAhczjvKFC3WrLlFfdU2RaLvJ9XWXpKgWJ
	 IvU2MRJueGqcfNX4lnJTpZFXbklFM12yIXE14BGa4DJn/H8NMTj4N54/swrKabo/kf
	 yBNw2USqExQe9xvSKkRSoKxkZjEtbW8Y1RR8v/qDBMEpFJnD/O15bi5U0TiL1mT6W+
	 GC/XKev/ycXYx0gWumHLF1MEiNCyKExIuC7gp2awZvjZf+t1I7wuReWGJh0K4K1ShN
	 8DTZu6alzd75g==
Date: Thu, 15 May 2025 23:33:22 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjbv536r22wip45e"
Content-Disposition: inline


--rjbv536r22wip45e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: close(2) with EINTR has been changed by POSIX.1-2024
MIME-Version: 1.0

Hi,

I'm updating the manual pages for POSIX.1-2024, and have some doubts
about close(2).  The manual page for close(2) says (conforming to
POSIX.1-2008):

       The EINTR error is a somewhat special case.  Regarding the EINTR
       error, POSIX.1=E2=80=902008 says:

              If close() is interrupted by  a  signal  that  is  to  be
              caught,  it  shall  return -1 with errno set to EINTR and
              the state of fildes is unspecified.

       This permits the behavior that occurs on Linux  and  many  other
       implementations,  where,  as  with  other errors that may be re=E2=
=80=90
       ported by close(), the  file  descriptor  is  guaranteed  to  be
       closed.   However, it also permits another possibility: that the
       implementation returns an EINTR error and  keeps  the  file  de=E2=
=80=90
       scriptor open.  (According to its documentation, HP=E2=80=90UX=E2=80=
=99s close()
       does this.)  The caller must then once more use close() to close
       the  file  descriptor, to avoid file descriptor leaks.  This di=E2=
=80=90
       vergence in implementation behaviors provides a difficult hurdle
       for  portable  applications,  since  on  many   implementations,
       close() must not be called again after an EINTR error, and on at
       least one, close() must be called again.  There are plans to ad=E2=
=80=90
       dress  this  conundrum for the next major release of the POSIX.1
       standard.

TL;DR: close(2) with EINTR is allowed to either leave the fd open or
closed, and Linux leaves it closed, while others (HP-UX only?) leaves it
open.

Now, POSIX.1-2024 says:

	If close() is interrupted by a signal that is to be caught, then
	it is unspecified whether it returns -1 with errno set to
	[EINTR] and fildes remaining open, or returns -1 with errno set
	to [EINPROGRESS] and fildes being closed, or returns 0 to
	indicate successful completion; [...]

<https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>

Which seems to bless HP-UX and screw all the others, requiring them to
report EINPROGRESS.

Was there any discussion about what to do in the Linux kernel?


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--rjbv536r22wip45e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgmXZsACgkQ64mZXMKQ
wqkFJA//ck5GgMwRVyLAlSvDmZF+tGq++Oe7v/RnDABRbD3UyW/LpSubY0DmlqzO
nQZaW1LvrTthvAsljMxyR7MjEG7udyIjuuxUjOFU8U0HC9qQ6qJQB3ea/LLu3urs
xSsDjz7UKgGR24S8QyuINuVD5Wt6lFE/gA2rT9/U7dahbyN95ftOcXZHsCzbC84X
jNgEzLgVB1clfaMRGRSs/+BxZeHUNXv+Yq6VixywYmIkz0sQqdsbjH4N/Uf+5A9b
iAoOsEw/BFj1XkvjbjqVZrDaX7ESunz4+UJ0YbxVhwO3Ym1906RhLW3i3iksfPr5
bDIPVD92GXG3YGc60CjcQY6HfGqP89+zszrUUVywd+H3LaObKcFD+cMHPzVhLAeP
OnK/oYam0xzXtLYdgIimXUMv4NUCSQIrMNQPM9q86Bi05BysHkNkEVdXrtHwK91w
GhKq3l+fMecr4m+xVl26Un9DzT50ZTUn84/YZx4aDMG+H8+QHGyjmuwlfyi8Z4MQ
59P2n0SSTLemJbFA4f0oRixx34+CU0toysahWTO5j8pKPNWME6QcL07wFBXIS8Xd
yQk+u5fhOIoM5I67iNNd68LnpTutaZumLkMGnKilyzv6L7PftERshJCShYE2m6U4
Dci6+XaBHu+FsS3b6qhVwQuk/4AqTQS+fQkTi+tVaQr3RUaKnwE=
=Wf+k
-----END PGP SIGNATURE-----

--rjbv536r22wip45e--

