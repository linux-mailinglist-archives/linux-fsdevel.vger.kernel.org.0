Return-Path: <linux-fsdevel+bounces-74322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980AFD39A7B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6220B300509E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2930DD1E;
	Sun, 18 Jan 2026 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="halLDZNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFB2C21F6;
	Sun, 18 Jan 2026 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774985; cv=none; b=U30QywDlh3oswQmQomlHoKypLcgzyeeCDmB07EWU8w4BGEvIM3O5C9ZF0rIjotwUoYCwkMOmN54gCOEGUrVgmVwhNaXCBEsZgMSKpLkzZAwvaOv5CJDRAzwjqmgcwIIHIOZTZ/gOcudiuTmNHYnm0QWosexajgKErsYYeusaEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774985; c=relaxed/simple;
	bh=dsCQxyhrH1v6cjkYcvZB/mhb3trXAqJHMFOiDMtYaTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMYcJ9TU9VYi6nbDj1XMS30qm65x20NaOG12vR+k2Sq2Zzagr1H5xSbaFsQMMj3TwpF2LsyLCT4KMTnKZFgilqPqLC/npoplQPJJSSit/UJuC1z9rMyFyl9TvANLfgE0zBP4yAejpHKk3bek8eanPdThdJDjZqnY4sBtVl2PEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=halLDZNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D870C116D0;
	Sun, 18 Jan 2026 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768774985;
	bh=dsCQxyhrH1v6cjkYcvZB/mhb3trXAqJHMFOiDMtYaTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=halLDZNGoxbJBOpVxMLZBA3d1Be2UZSsYj6lQjlhqCyCwueqm4HQ3o+yEhxDnrW87
	 Ep8hICglF/48eZMOIEzvKmsqh+Mf86iD5nHL/G4YtdmlONbyH/H97/Ed2KjF1PVvHn
	 uSO7AklqrW2FLs8CgngrL5cAmKr5SMr5RrgFHCHs61hjUhF+OFrG3lx1jnqUsUeKCx
	 5eSCfEOgRLMqrX/lxmkorZUs1CRmMLCqTlKOoZ7PFZxhrlWfcnSB5uB6lx8hRogmI3
	 wHzTU8r0UFNp2c2xmjQNw48u8mbkWIXMdRZLtE2Oa96xpBKK3TlkaiUGU3v0fQDL3c
	 ZKrpqoP3qhK7g==
Date: Sun, 18 Jan 2026 23:23:01 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Rich Felker <dalias@libc.org>, Vincent Lefevre <vincent@vinc17.net>, 
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aW1dE9j91WAte1gf@devuan>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mr5k7uzoinhlwyzp"
Content-Disposition: inline
In-Reply-To: <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>


--mr5k7uzoinhlwyzp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Rich Felker <dalias@libc.org>, Vincent Lefevre <vincent@vinc17.net>, 
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aW1dE9j91WAte1gf@devuan>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>

Hi Zack and others,

Just a gentle ping.  It would be nice to have an agreement for some
patch.


Have a lovely night!
Alex

On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
> Taking everything said in this thread into account, I have attempted to
> wordsmith new language for the close(2) manpage.  Please let me know
> what you think, and please help me with the bits marked in square
> brackets. I can make this into a proper patch for the manpages
> when everyone is happy with it.
>=20
> zw
>=20
> ---
>=20
> DESCRIPTION
>     ... existing text ...
>=20
>     close() always succeeds.  That is, after it returns, _fd_ has
>     always been disconnected from the open file it formerly referred
>     to, and its number can be recycled to refer to some other file.
>     Furthermore, if _fd_ was the last reference to the underlying
>     open file description, the resources associated with the open file
>     description will always have been scheduled to be released.
>=20
>     However, close may report _delayed errors_ from a previous I/O
>     operation.  Therefore, its return value should not be ignored.
>=20
> RETURN VALUE
>     close() returns zero if there are no delayed errors to report,
>     or -1 if there _might_ be delayed errors.
>=20
>     When close() returns -1, check _errno_ to see what the situation
>     actually is.  Most, but not all, _errno_ codes indicate a delayed
>     I/O error that should be reported to the user.  See ERRORS and
>     NOTES for more detail.
>=20
>     [QUERY: Is it ever possible to get delayed errors on close() from
>     a file that was opened with O_RDONLY?  What about a file that was
>     opened with O_RDWR but never actually written to?  If people only
>     have to worry about delayed errors if the file was actually
>     written to, we should say so at this point.
>=20
>     It would also be good to mention whether it is possible to get a
>     delayed error on close() even if a previous call to fsync() or
>     fdatasync() succeeded and there haven=E2=80=99t been any more writes =
to
>     that file *description* (not necessarily via the fd being closed)
>     since.]
>=20
> ERRORS
>     EBADF  _fd_ wasn=E2=80=99t open in the first place, or is outside the
>            valid numeric range for file descriptors.
>=20
>     EINPROGRESS
>     EINTR
>            There are no delayed errors to report, but the kernel is
>            still doing some clean-up work in the background.  This
>            situation should be treated the same as if close() had
>            returned zero.  Do not retry the close(), and do not report
>            an error to the user.
>=20
>     EDQUOT
>     EFBIG
>     EIO
>     ENOSPC
>            These are the most common errno codes associated with
>            delayed I/O errors.  They should be treated as a hard
>            failure to write to the file that was formerly associated
>            with _fd_, the same as if an earlier write(2) had failed
>            with one of these codes.  The file has still been closed!
>            Do not retry the close().  But do report an error to the user.
>=20
>     Depending on the underlying file, close() may return other errno
>     codes; these should generally also be treated as delayed I/O errors.
>=20
> NOTES
>   Dealing with error returns from close()
>=20
>     As discussed above, close() always closes the file.  Except when
>     errno is set to EBADF, EINPROGRESS, or EINTR, an error return from
>     close() reports a _delayed I/O error_ from a previous write()
>     operation.
>=20
>     It is vital to report delayed I/O errors to the user; failing to
>     check the return value of close() can cause _silent_ loss of data.
>     The most common situations where this actually happens involve
>     networked filesystems, where, in the name of throughput, write()
>     often returns success before the server has actually confirmed a
>     successful write.
>=20
>     However, it is also vital to understand that _no matter what_
>     close() returns, and _no matter what_ it sets errno to, when it
>     returns, _the file descriptor passed to close() has been closed_,
>     and its number is _immediately_ available for reuse by open(2),
>     dup(2), etc.  Therefore, one should never retry a close(), not
>     even if it set errno to a value that normally indicates the
>     operation needs to be retried (e.g. EINTR).  Retrying a close()
>     is a serious bug, particularly in a multithreaded program; if
>     the file descriptor number has already been reused, _that file_
>     will get closed out from under whatever other thread opened it.
>=20
>     [Possibly something about fsync/fdatasync here?]
>=20
> BUGS
>     Prior to POSIX.1-2024, there was no official guarantee that
>     close() would always close the file descriptor, even on error.
>     Linux has always closed the file descriptor, even on error,
>     but other implementations might not have.
>=20
>     The only such implementation we have heard of is HP-UX; at least
>     some versions of HP-UX=E2=80=99s man page for close() said it should =
be
>     retried if it returned -1 with errno set to EINTR.  (If you know
>     exactly which versions of HP-UX are affected, or of any other
>     Unix where close() doesn=E2=80=99t always close the file descriptor,
>     please contact us about it.)
>=20
>     Portable code should nonetheless never retry a failed close(); the
>     consequences of a file descriptor leak are far less dangerous than
>     the consequences of closing a file out from under another thread.

--=20
<https://www.alejandro-colomar.es>

--mr5k7uzoinhlwyzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmltXUQACgkQ64mZXMKQ
wqnhWRAAmGubZJzYdwl5q65sObpsQN+Ok2jQM+Yy/U1E8Z2S/qejYo8lo+l7EiPN
otVSQMNwCi6iXSfF69Dlxygee2bQRKGy4h6hGxfsOKNW8+JhSLxgqNRSbnTcsDNN
DwaGHK+4TsWvgnLSw5NATJuAAKQb7Bg3O1u8Z6nGtUqbwmxoSYrcoFzRHO58jBNq
dZei0w2+q4TT/6c1oqpJoaoHcs8tQdKYg5auw88MGt4u1vfOasvw7Jq6x9W1n5lZ
DhEthGI4qPsY3bPmadryZOHmXzQxlrAsPFSYWgcUATe7o6LQe+AqqsOAivy0LThG
9RqWc6txbj7IEJOTc79AoRtagzsV9jzzwDQwm/9rQGfSO/ykpejnhg2YI4ctWqhV
9ZK/EoE8Wc6WIaRgqFHVgy/l9frkWBtj0GMGnxOMsGoYsIpSSaIGgIoaMbirzEuL
oN2yMdE1cSNY7uNWdykCcV/PvdZkW66i2AVz4LMY1zDjCxiGzG/xi1Q2L5Mx/CXv
JyW04h+t0wWzGtwkrrveyh3kMIzuuzjwV0D09REn3/y3gmUOQHEwGsZIxEuyRY2G
w9Ult7whUbrMSgAUjCzikevQhqPzqvTGQVdToLASZ9qaHIcy5XQ7IWe/UoxVqWGO
vgYg5vIHoz/fGU1BePWnnqJb1C6/V6wz1+hoYrqiQEwoYrzsKLM=
=RH+w
-----END PGP SIGNATURE-----

--mr5k7uzoinhlwyzp--

