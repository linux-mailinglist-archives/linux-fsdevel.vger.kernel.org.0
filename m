Return-Path: <linux-fsdevel+bounces-57060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48CB1E7C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210E33AA289
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC0275AE9;
	Fri,  8 Aug 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="egIcImIJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02112275860;
	Fri,  8 Aug 2025 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654131; cv=none; b=NR12LLfQ7W5mhMkLdC8TWTkkSCzUWISLngaamSiW8EWtMWe92FUzNhGnPv1/QnspPTaYJuqsuwfGbwiBSmUktnoXOkZjnlO57vXxZjpZJsRJqs51jg0zv+TzDjR20LHiF4uXNqJfnuj4Fpy9VOqSiDrjhNLnS7dr+m3q1d/gGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654131; c=relaxed/simple;
	bh=j1iFPkLEAmTkGhtA+v5oK2zN/6c1oShcayNSSJekln0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlNbkbCD84XxHVsqmB0MQtPgRxPIwkO1qFH0pgakax0ZMUsHIk1+GRFm+Wr77ZO4NrHAINQr+r0QFcll5mOMoVmeoGduepctgUNmc98pEXKQqITZWXiOpaFQZQKr1+mrDraRE3O1j5HfdbNDeMOEllXECZWnksz1ZBa3qSA5Qyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=egIcImIJ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bz2XX66QLz9ty9;
	Fri,  8 Aug 2025 13:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754654124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMaM5szYKN3qFWMkEpTqrXdlKuBnXydRA4YHiDHA/9Q=;
	b=egIcImIJjKF7/IfjOV0R1Nw4dd7l5dZO1qMvAspQR0V4HF/5Isr61tUJ0yzQQwy8jp0Sem
	XcLHtaKMhT2hZxQvA3O3OjKmIlZbUKGaV47ZTAX1KtHTdY6ZVwO0a2MV+bZeiGSU1Uo1en
	FLkB0T02ycjhAoVdf3fqRNaOB+5R9U1/oGeyalxIkoofAMNxpStcQmZkqiLUOkTPtA70n/
	bCWvD7GLfLrOjrhXofvM5q+IfXDemykIcYiV6Z9bRJ0KrRo/Q/lVju/xwSDAi7syNi1Lpm
	uWvAjP8/iX9Ze9ewpTYa9thJvNRlXidkOdEjJrqQeoMPzltneFwG/Zy2MmHk0Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 8 Aug 2025 21:55:10 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
Message-ID: <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
 <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="chd6azrmxxoywhso"
Content-Disposition: inline
In-Reply-To: <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
X-Rspamd-Queue-Id: 4bz2XX66QLz9ty9


--chd6azrmxxoywhso
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
MIME-Version: 1.0

On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
> When I render "mount_setattr" from this (v2) pathset, I see weird quote m=
ark. I. e.:
>=20
> $ MANWIDTH=3D10000 man /path/to/mount_setattr.2
> ...
> SYNOPSIS
>        #include <fcntl.h>       /* Definition of AT_* constants */
>        #include <sys/mount.h>
>=20
>        int mount_setattr(int dirfd, const char *path, unsigned int flags,
>                          struct mount_attr *attr, size_t size);"
> ...

Ah, my bad. "make -R lint-man" told me to put end quotes on the synopsis
lines, but I missed that there was a separate quote missing. This should
fix it:

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index d44fafc93a20..46fcba927dd8 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -14,7 +14,7 @@ .SH SYNOPSIS
 .B #include <sys/mount.h>
 .P
 .BI "int mount_setattr(int " dirfd ", const char *" path ", unsigned int "=
 flags ","
-.BI "                  struct mount_attr *" attr ", size_t " size );"
+.BI "                  struct mount_attr *" attr ", size_t " size ");"
 .fi
 .SH DESCRIPTION
 The


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--chd6azrmxxoywhso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJXlngAKCRAol/rSt+lE
by9BAP4yMGtidqOpBrcBgGWWVVVChQPXqEuLZJoUx48cMFfZXAD/dlNXX2+IP0ZE
+obDnRBcywlV9Y55z6X1Gbrq5Kvm/wE=
=qGsv
-----END PGP SIGNATURE-----

--chd6azrmxxoywhso--

