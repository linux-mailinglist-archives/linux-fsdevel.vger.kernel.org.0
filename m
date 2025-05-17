Return-Path: <linux-fsdevel+bounces-49318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8B7ABAA2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76016166E23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B11FF1C9;
	Sat, 17 May 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRQ08jQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA72B2DA;
	Sat, 17 May 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487041; cv=none; b=WqagqUvr1jlkrzv95pFkumVuNrGsgDHLG6glcd3pYHkefKzbdYhWINhXVDOyb0C0SNxrKTt0fDVrBwIgZrPZIVILIkEBB3TcXUo1+iQSCRycT0/LZJ+iCYHCk8GRIueGoYBN372dKJB0PQ7U0nxQLcjM0KyvtdY/E9OzUatds5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487041; c=relaxed/simple;
	bh=ZTNgy9MX5ZJS9tKoHnIKWYhXmI4Y5Ga2vD+wJqgeEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zat/UvlaNJxBNbrHkIc2mSxlHEaKkY+g399WH2XUthgeuwWRlV2hhMfnoKZcreaR40Hc7nzC9Z4FuC/8FLBVfJ9r13eKC+fnoFo+kjBGvObtfeiRVmM1LtOKP9jC+m8ziFvet5IOyJEAWHaGgBkxA0/PHzs7uynzWORVLIhO460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRQ08jQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F86C4CEE3;
	Sat, 17 May 2025 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487040;
	bh=ZTNgy9MX5ZJS9tKoHnIKWYhXmI4Y5Ga2vD+wJqgeEuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRQ08jQv5nDgEDvM/sDPA1SpJ38hLvS89lleN7F9wJ1Z6koD7HsNOGmWejG41PXyn
	 ZJx/UXH8XqdpBZZ3kelzOd4MU2i00Re6x7Ln/7MEfUXRzF4zkjkyDs70YuTnb+J1HY
	 TGDNfc5+M0wf6QTyIpPVRe6/bz2oFaviOoEkTXFDUcHpFocXBFUGo1Q7SE1dnlV9CD
	 NprjrS3BLHidizdR818CmkHY/OjuWBxRcUw4dagPbMEqjubkRFxxLKtgJtpOEQ9mNX
	 aIBtfyZFpaYwC39l+FMGwzlii4RAb/vsOGixojRGBiIzaCoOrRWpU8dQFPtltWV3zG
	 5Atv5x+nqyigQ==
Date: Sat, 17 May 2025 15:03:52 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Rich Felker <dalias@libc.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <qthuiudgbwuxh4bwwpcvpbosqrz6rl4js46atvenhmujkbjnz4@crakvrigxnz6>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516142024.GA21503@mit.edu>
 <bsvslfjgcmzvcanxp3ay6ohitqulwuawwgzy234nfkj6ecdxbq@2uhld4vpitou>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sqtlrejcdkwkzdgg"
Content-Disposition: inline
In-Reply-To: <bsvslfjgcmzvcanxp3ay6ohitqulwuawwgzy234nfkj6ecdxbq@2uhld4vpitou>


--sqtlrejcdkwkzdgg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Rich Felker <dalias@libc.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516142024.GA21503@mit.edu>
 <bsvslfjgcmzvcanxp3ay6ohitqulwuawwgzy234nfkj6ecdxbq@2uhld4vpitou>
MIME-Version: 1.0
In-Reply-To: <bsvslfjgcmzvcanxp3ay6ohitqulwuawwgzy234nfkj6ecdxbq@2uhld4vpitou>

Hi,

On Sat, May 17, 2025 at 07:46:48AM +0200, Alejandro Colomar wrote:
> Hi Ted, Rich,
>=20
> On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
> > FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> > issue, and later changed it to returning 0 since applications
> > (particularly, any written prior to this interpretation) are prone to
> > interpret EINPROGRESS as an error condition rather than success and
> > possibly misinterpret it as meaning the fd is still open and valid to
> > pass to close again.

BTW, I don't think that's a correct interpretation.  The manual page
clearly says after close(2), even on error, the fd is closed and not
usable.  The issue I see is a program thinking it failed and trying to
copy the file again or reporting an error.

On the other hand, as Vincent said, maybe this is not so bad.  For
certain files, fsync(2) is only described for storage devices, so in
some cases there's no clear way to make sure close(2) won't fail after
EINTR (maybe calling sync(2)?).  So, maybe considering it an error
wouldn't be a terrible idea.

I don't know.


Cheers,
Alex

>=20
> Hmmm, this page will need a kernel/libc differences section where I
> should explain this.
>=20
> On Fri, May 16, 2025 at 10:20:24AM -0400, Theodore Ts'o wrote:
> > On Fri, May 16, 2025 at 09:05:47AM -0400, Rich Felker wrote:
> > =20
> > > In general, raw kernel interfaces do not conform to any version of
> > > POSIX; they're just a low-impedance-mismatch set of inferfaces that
> > > facilitate implementing POSIX at the userspace libc layer. So I don't
> > > think this should be documented as "Linux doesn't conform" but
> > > (hopefully, once glibc fixes this) "old versions of glibc did not
> > > conform".
> >=20
> > If glibc maintainers want to deal with breaking userspace, then as a
> > kernel developer, I'm happy to let them deal with the
> > angry/disappointed users and application programmers.  :-)
>=20
> Which breakage do you expect from the behavior that musl has chosen?
>=20
> I agree that the POSIX invention of EINPROGRESS is something that would
> break users.  However, in removing the error completely and making it a
> success, I don't see the same problem.  That is, if a program calls
> close(2) and sees a return of 0, or sees a return of -1 with EINTR on
> Linux, both mean "the file descriptor has been closed, and the contents
> of the file will *eventually* reach the file".
>=20
> In which cases do you expect any existing Linux program to behave
> differently on 0 and on EINTR?
>=20
>=20
> Have a lovely day!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--sqtlrejcdkwkzdgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgoiTEACgkQ64mZXMKQ
wql3Ng/+NDSwBY5r1YumzsfpQw+2rAqTuXa9sbA7Wcww6wELxJtsBVxi66Uz9W+N
GO7bjRCJcRMBUZqQPib/nZU6myLvUasiE2YTQI/Ba0LXO+L88M+l4CqIM5B6cAGb
XnJbQlMsRSnfmjemEYnmwtPVelIu1Yz82XLP0K8wIHHl/j3Qi/eoiBxqLeFGazSa
9Q1Fva8f51WD+yXAx8M3t7kH6d7MYYV96eYLnZIkp0c2Y6hsBlJHw38Jky9UYcOZ
HurC3l3Ky5QeipH+IwM/Yjn4KFYWTghDmyM0EVP/LAG4pnM2QlOD03e8kswAkvCU
q4eCx00+dIMBaj0OWI/d2SNefbJ/QICBVb6cYTNH0qnzMI7binsXgU1kBJfXIZSF
YRh2HSpUZbog3OTZc03uTtm5nWOs+fbvKJc5lHJj7ptLp96LKXDmxa1SONjJi1P5
2ApkrLctJa6bx3DZov45Z/s9Sr27eh0QWBqpgw6TJdinM4VIAMZCq354qePhsWvn
A8cuB9OVMo9gvQTcywjNJqzcKFwk5VxeMlzEEBF7ViTjUXGotX9jqZk8C9HE3R3o
9g0ipqXUH8M7bgsxRWIxAvrCs6t0s/JQiJGhSgG+g4q76h1BfYemGscLqBW7scJT
DmlXxQpn/xhTfHOqXFkdo6m06tUVuCnhJmA62Hm3Y8MUMmpZJEw=
=Gi4d
-----END PGP SIGNATURE-----

--sqtlrejcdkwkzdgg--

