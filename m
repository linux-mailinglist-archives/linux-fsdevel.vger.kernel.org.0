Return-Path: <linux-fsdevel+bounces-57061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4BAB1E7D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC063BCA3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07993275AFC;
	Fri,  8 Aug 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vGBQsss8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5B275869;
	Fri,  8 Aug 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654271; cv=none; b=iSPFnAhB6SWCwi5Xp+5R1LWl/oG4LQNAdJOQMzKAsggwEOw8gsQDvURh0J5CYuuQXuPOisW60rMVr3CNQr8eGQwQ6PwMVpdDb0h9hUgfylilwbNzK2uX2/NKXPkKB18qPCkzdR/Y9FtAOaYQrKS7UTOBsPVjW8iOdeu7G79y1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654271; c=relaxed/simple;
	bh=CAVgfdJ90dUDIezRN0k+ZX35JYdZ+PfLye2IJnEIk8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwVyp33M9gp5i41VcRV9LfJDomhn0B1ZroqnqwPe5Oaf7VT5CinnMobCfuJ0tPEP0SNoSJdhbkheQ/jXpqsm5cxv/nykOHo//4pbmJopRVcREO+PlJ60kq0HWmsalx1TsaRfUzR1Y1qO6eoUT0q3J2niknI00KzNrWZXRddXLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vGBQsss8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bz2bF5Znnz9t6B;
	Fri,  8 Aug 2025 13:57:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754654265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fG5JWPS96tLdBDXTerC2Faz++HzdpYFQ6B9vkIpLGg4=;
	b=vGBQsss8sfIaWGalD66ycUeqC8G5XGL6ZFq9GjGUWxDZwK1ReFVXnPmRGg8wLcIZFaL2O+
	eHjFzKgC8ZnnGUl77Vw3KoNDw6OvXbWd+st5MpbqyGcR+uko5ZX4cyHl6DkxN66mF0bHDS
	h3TcwtJUv97j36XahKlSn9/WZ7W9MiC/cwe+NLcwzUd+beRsB3r2vQyygPmYLy9/x0xz3A
	Pow1nKPn9et7jNKepzvROft0hKTvj9W58798XdAzxFmauD2J7CZZdi+9x6Rwsh+puNVVPL
	WegfI/MqFPbtA7z1ylU0ETTG5fHrZrsh+yM3HphmJpIxvRnD/fRTxk/Mo6PlMA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 8 Aug 2025 21:57:36 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <2025-08-08.1754654135-unarmed-sticky-beavers-choirs-7Xg1WL@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <19888ef84eb.11525d76e40004.7721042298577985399@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aopoj5j377wlbt5v"
Content-Disposition: inline
In-Reply-To: <19888ef84eb.11525d76e40004.7721042298577985399@zohomail.com>
X-Rspamd-Queue-Id: 4bz2bF5Znnz9t6B


--aopoj5j377wlbt5v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
MIME-Version: 1.0

On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
>  > If there are no messages in the message queue,
>  > read(2) will return no data and errno will be set to ENODATA.
>  > If the buf argument to read(2) is not large enough to contain the mess=
age,
>  > read(2) will return no data and errno will be set to EMSGSIZE.
>=20
> read(2) will return -1 in these cases? If yes, then, please, write this.

Yes (well, the syscall returns -EMSGSIZE). I'll try to add a note
without making the paragraph too wordy...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--aopoj5j377wlbt5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJXmMAAKCRAol/rSt+lE
b0+VAP9zbDmwUcjcon9nxKAi421+0vhQbrnBTPDbNx+UwxnYtwEA2A0XD6eFtl7e
4nbxBLxckCw1rZaL++TnywTNDooHzgM=
=3pG+
-----END PGP SIGNATURE-----

--aopoj5j377wlbt5v--

