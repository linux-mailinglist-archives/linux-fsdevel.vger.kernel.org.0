Return-Path: <linux-fsdevel+bounces-49321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F8AABAA7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438EA1B632A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C831F9F61;
	Sat, 17 May 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOeQ+gjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913215680;
	Sat, 17 May 2025 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489590; cv=none; b=oZSEAdLrYuAEAFG9CPUjnzIC0+sZiFp3zY9RlvZ+6W+HngfOggq/YhuvPbVBUzB596AdbVKhNCJAuoifHEBZ3BykOcvLsV98RzGc+1gNuHeT99DIl96o9k7b1Wl8GKmzzN046CCCyyVxYy5wPBC3WDJAv/L/WSGu72rNHKgbU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489590; c=relaxed/simple;
	bh=ZpQKTvBcPNIq1cjZXftRu95p02HrkM9YQIkK+9SCqMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG+RHXbG///2OKXgp5mDRaSNeDfj9VoctNAjO3ZfM2o9Whg7FbtLDPN8jHt3ATMmPPYynyMEX8e2QhDClrfrQoiHlkjP6Nm9nC9JqIpJbRe2iSYSqHDZIMYZEisykh+0pyIFfX/Mabdy9oqjibPCiBB1gR2STFICg3tG1XKJljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOeQ+gjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5DAC4CEE3;
	Sat, 17 May 2025 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747489590;
	bh=ZpQKTvBcPNIq1cjZXftRu95p02HrkM9YQIkK+9SCqMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOeQ+gjvF3qWQ9sSSBDdLeO1k6rE3gI7gTGQZZC3bM9DQa7T8+XpaLOhSBhRaebxR
	 wza3PsVjO3ZIAe7uhjWS7e67nKbpNtgHF21sZQGd95GK2s0UoIYOdFcJYX/xZAz4p8
	 akoYxfUaGBGMf1ZLL0KLf8sEhzm4ZQZojsg7wzFNUpszdIelZuiLtOJu/8WsOBLGg2
	 vPKu8SUo7tOt2Sron6hcbzx1HtasyUBkI3CJ5G9NK+M2+mooKTo1PZFM8BQvEYzGjJ
	 eezeALnni/zzZWURqZ5PCMD4eyCTs+papB9QHV3jLl/KunhyjF0DdYK5YWshfgZd+/
	 wednDWWEIiRXA==
Date: Sat, 17 May 2025 15:46:23 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ofafdgg4oea4kcg"
Content-Disposition: inline
In-Reply-To: <20250517133251.GY1509@brightrain.aerifal.cx>


--2ofafdgg4oea4kcg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
MIME-Version: 1.0
In-Reply-To: <20250517133251.GY1509@brightrain.aerifal.cx>

On Sat, May 17, 2025 at 09:32:52AM -0400, Rich Felker wrote:
> On Fri, May 16, 2025 at 04:39:57PM +0200, Vincent Lefevre wrote:
> > On 2025-05-16 09:05:47 -0400, Rich Felker wrote:
> > > FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
> > > issue, and later changed it to returning 0 since applications
> > > (particularly, any written prior to this interpretation) are prone to
> > > interpret EINPROGRESS as an error condition rather than success and
> > > possibly misinterpret it as meaning the fd is still open and valid to
> > > pass to close again.
> >=20
> > If I understand correctly, this is a poor choice. POSIX.1-2024 says:
> >=20
> > ERRORS
> >   The close() and posix_close() functions shall fail if:
> > [...]
> >   [EINPROGRESS]
> >     The function was interrupted by a signal and fildes was closed
> >     but the close operation is continuing asynchronously.
> >=20
> > But this does not mean that the asynchronous close operation will
> > succeed.
>=20
> There are no asynchronous behaviors specified for there to be a
> conformance distinction here. The only observable behaviors happen
> instantly, mainly the release of the file descriptor and the process's
> handle on the underlying resource. Abstractly, there is no async
> operation that could succeed or fail.
>=20
> > So the application could incorrectly deduce that the close operation
> > was done without any error.
>=20
> This deduction is correct, not incorrect. Rather, failing with
> EINPROGRESS would make the application incorrectly deduce that there
> might be some error it missed (even if it's aware of the new error
> code), and absolutely does make all existing applications written
> prior to the new text in POSIX 2024 unable to determine if the fd was
> even released and needs to be passed to close again or not.

Hi Rich,

I think this is not correct; at least on Linux.  The manual page is very
clear that close(2) should not be retried on error:

   Dealing with error returns from close()
       A  careful  programmer  will  check the return value of close(),
       since it is quite possible that errors on  a  previous  write(2)
       operation  are  reported only on the final close() that releases
       the open file description.  Failing to check  the  return  value
       when  closing  a file may lead to silent loss of data.  This can
       especially be observed with NFS and with disk quota.

       Note, however, that a failure return should be used only for di=E2=
=80=90
       agnostic purposes (i.e., a warning to the application that there
       may still be I/O pending or there may have been failed  I/O)  or
       remedial  purposes (e.g., writing the file once more or creating
       a backup).

       Retrying the close() after a failure return is the  wrong  thing
       to  do,  since  this may cause a reused file descriptor from an=E2=
=80=90
       other thread to be closed.  This can  occur  because  the  Linux
       kernel  always  releases  the file descriptor early in the close
       operation, freeing it for reuse; the steps that  may  return  an
       error,  such as flushing data to the filesystem or device, occur
       only later in the close operation.

	...

       A careful programmer who wants to know about I/O errors may pre=E2=
=80=90
       cede close() with a call to fsync(2).


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--2ofafdgg4oea4kcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgoky8ACgkQ64mZXMKQ
wqnbzA//asjYoqURQNs1yk2wrp/N0N+XbSAyyeg6EZwjieqOShdpUVPbsOrdxRFL
P++sqaGJDF16ZqMUHFspTjYBo35cfOLBj8jx0EGZBapJ+esxZSyepfZ7MTTHqiYR
GwPAq3RzvjF+aw/8/t7esm7IqTIvOcmCuYT0+wYIFG6gyjzV1nxAwBqagRlxrmr9
fvmB4h8f+690KbTfwQKwrE6abW//oHNI894tVJ+wnaBncGXIUNQZ3dvbERE/RqC7
HlI1JC6kkIl/YXuOhCeHnVbi6r/IeVfa5e7eHmMDlghIHRlKpPJ9VFUf10VZuXem
XNbhf3HuE/BNNV6uss5dRWH0uogxp5gBGOReH4y0baLoFw0xA4SJykMqvspWelnc
OWuiEL5N61HyMaIhVpj4fhHprcRTXkb+3N5mZ5zROonOPmipN4QikWPCyTH4dn2A
XtpOsBe98SUzIJgWRiKDhnRl7h4/edEsZyf0RchRNz9EPTJuUNY9KaW/rPFAVoRc
onMO3V5VGZuxY4fZRT44zc27DoEdAiLEKsGmHB2IUHJs7Q3ps+un1T40a5x1tVbr
OkDMt48TwN9GXG9CjOs/uSUg4BzMdE/ZAuO0eJPO3y/6PlzcP2MrwYWcLZvsutXc
jKvYNuivt1a3ZloIU51JoAjINvvubmTFDgTvBo18v28JjkeJFtU=
=udm7
-----END PGP SIGNATURE-----

--2ofafdgg4oea4kcg--

