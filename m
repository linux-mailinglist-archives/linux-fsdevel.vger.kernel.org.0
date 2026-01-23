Return-Path: <linux-fsdevel+bounces-75296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP/NFj2Jc2krxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:44:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4377369
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 261043021D1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE634325495;
	Fri, 23 Jan 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvV3w0XC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7B31ED81;
	Fri, 23 Jan 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179446; cv=none; b=TWKOcht8hcTqEu9irerxk7Oysk3EmgWMyTiTZiYBoiec/XTai4wnfjT8KjIIb8fSmugf6iD7oZ9jMjiiBrsOOKXv1MbEKh+zoj3C6ZwaoGdVQ6O4b4C4OsEALnY3u3EEr4YFyJI0MrpqqZYcOKjaq/ZT1Mr3CVDhueEouDQ2EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179446; c=relaxed/simple;
	bh=7aA2iBPGz7CS9W7yUpn5vca1/gwxNZxQ3K5P4SwSt2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkJ1ZfL8IkkdV4U3jZnRAN3whcHHcLxwKaKPviLTaatY/UnH0VZ1M8d2WWoiir0u4hIJ45yH5oPWlY8TUXGMACxr4+g6E4kyjtchfqWjy5h1ApaxCOeuG9kfuHwn2ZJBxyvYDJ5T8egQHJsUrUgui4/SHs7Nrf06zly5sDZ1Kaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvV3w0XC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04669C4CEF1;
	Fri, 23 Jan 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769179445;
	bh=7aA2iBPGz7CS9W7yUpn5vca1/gwxNZxQ3K5P4SwSt2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvV3w0XCz4ShVQ08BcQnHCMzFGh6Rjspu0j4W9Jq/OKU71NhrNXjXHHf/DOFNHU35
	 Nz+x/yHu0GrtZglOZaCGzbboqlmTHOHLapWqxwuDktcWIQeHm9Ov2MDiH8fMDph0GR
	 4p53wQNRYGpigr7siz8xQAvL5mO5Xih8WouD8H/h1yTAMKU39LulAw7qZbMCgzqJiG
	 B6waj5aTUOIy2V9Ee0rDn2rjX6ESzZqRD2yd7gUtkR8M1viabmM8LcwSiYRYvTp6nE
	 idrG3D6h5oirpghYcCYKMNaNyrGub8DVkIVWN4AnDaRmjbitWoOfi3vAsXa5ynTsZj
	 aPgAVV2lspYXA==
Date: Fri, 23 Jan 2026 15:44:01 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aXOIujSspUpEw1Fk@devuan>
References: <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <aXLGdWGTrYo1s6v7@devuan>
 <20260123013859.GI3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3qtp3e4oftcqpoam"
Content-Disposition: inline
In-Reply-To: <20260123013859.GI3183987@ZenIV>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75296-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6E4377369
X-Rspamd-Action: no action


--3qtp3e4oftcqpoam
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <aXOIujSspUpEw1Fk@devuan>
References: <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <aXLGdWGTrYo1s6v7@devuan>
 <20260123013859.GI3183987@ZenIV>
MIME-Version: 1.0
In-Reply-To: <20260123013859.GI3183987@ZenIV>

Hi Al,

On Fri, Jan 23, 2026 at 01:38:59AM +0000, Al Viro wrote:
> On Fri, Jan 23, 2026 at 02:02:53AM +0100, Alejandro Colomar wrote:
> > > HISTORY
> > >        The close() system call was present in Unix V7.
> >=20
> > That would be simply stated as:
> >=20
> > 	V7.
> >=20
> > We could also document the first POSIX standard, as not all Unix APIs
> > were standardized at the same time.  Thus:
> >=20
> > 	V7, POSIX.1-1988.
> >=20
> > Thanks!
>=20
> 11/3/71							 SYS CLOSE (II)
> NAME		close -- close a file
> SYNOPSIS	(file descriptor in r0)
> 		sys	close		/ close =3D 6.
> DESCRIPTION	Given a file descriptor such as returned from an open or
> 		creat call, close closes the associated file. A close of
> 		all files is automatic on exit, but since processes are
> 		limited to 10 simultaneously open files, close is
> 		necessary to programs which deal with many files.
> FILES
> SEE ALSO	creat, open
> DIAGNOSTICS	The error bit (c=E2=80=94bit) is set for an unknown file
> 		descriptor.
> BUGS
> OWNER		ken, dmr
>=20
> That's V1 manual.  In V3 we already get EBADF on unopened descriptor;
> in _all_ cases there close(N) ends up with descriptor N not opened.

Thanks!  Then it should actually be

	V1, POSIX.1-1988.

Let's not document the history change from V3, as those details are
better documented as part of the V3 manual and reading the sources.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--3qtp3e4oftcqpoam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlziTEACgkQ64mZXMKQ
wqkd9A//Qc5qH0/jH1XaCWuZ+6ydFHdwOswvivsa4M41c4y5qQZxrmV4La72BC/b
dPdYsqNGA+PkQK/3pR5a1jlXGhrg4mXqoXkqI8EQkaszUqPXMyKOirMn90gJR4xT
Xy4u35vSXUhdlrMWOf1h//P6LGKAMPFCPh1Dm1/uvSYNVY97boBZfGFU13/aChD3
mZOTOHybW1apxNgRFjevSBZ5t04CXTU+CcGmXQQdwwZE8lYi5bIosEIkWKefoDQR
yfv1E5lG1ETLlEPqZ76rayiFkmSq1abXJOk2uoYUOxV+7yDDkke2furjlXyFrpag
FdbjVWxVb9bvNpEF9gqc5QDTac14ESEKWYABon1MVOidVRAXG7/Sy2xa32tZ0tDi
VPbXPrbk30baUFJKY8yRG3ND90PDBh1BUe5on1o8Db9Zgect1/sZP9gv+w20Su8p
vvc8gY6z5Nf+rKcV/Cou99rjgFGAnLV2b7BeqKCOG1em+/wr8KuTK5ZnUsaSJ/xx
BCqPzsDB/5GtFy7Ov+kyEG+/iOcuzVvMhhxUM3EJs3uTQ8IiK41iEMnMrt+4Awn/
IookzT0oQhOs1sCSuboXFcpfUQICQmAR41S39NXLB56yNytb4mja2plYEfEGjC/L
18I0G+ydb17JD0DgDLe8Y0UawrMeG3u9/PqGS9og/00b/MfbJFU=
=gbeJ
-----END PGP SIGNATURE-----

--3qtp3e4oftcqpoam--

