Return-Path: <linux-fsdevel+bounces-56956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52843B1D0FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 04:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC007212F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 02:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A11C7015;
	Thu,  7 Aug 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="sJGCq99k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC379EA;
	Thu,  7 Aug 2025 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534792; cv=none; b=O76bCnNm8SfRRhOHL4VJ3m81070kVHtTDUuahpvbQHvbCSKFUo0XEALCn5zLVtMyj+fwyb0MhTiqTTFf+WthfDk/mU9WBKWaEZLfNVzQqC/FwL3bgFmNHy+EGVjMWOrNcT7jnqB5NCibyLkEr3JMXSFcW81nX7QhwQcQmUNKXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534792; c=relaxed/simple;
	bh=6fytCeeUudLTY0ffUnh8JTpCldUAMNOKqbM15mFHfZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6yZjJ2LY3aRg1ftOReRmXhXOnXr9MrOd7PJWx/0zFXgywuDDleEskgID0p4pAEY4rbB7lgoPSrdiCsiNetzMAwdw/qUnxAnFPBgaJVc+GrPsP8C6Ar6BVEdz4i60IZ7IkMmnuMIKA00bY6/Lx2FFZYCoQOKoGoSVaO/ozy64YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=sJGCq99k; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4byBPY6Dbdz9t4B;
	Thu,  7 Aug 2025 04:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754534785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tub9/9osH95VcqyXOi1mtkKeG5xrj44pXKAdmNqMqBE=;
	b=sJGCq99kPI1k/JhV6zWQVYmo0T9/Xse07waxFNQPdPpkiBD+FLCjnckGgEW5Xd7QO/JrMO
	NeC5oNLAX73swxhjdQFCcnOptsSvJYPaxx2SOq+loy06v68MiRg8hq8Fj6VLJEhZV1hNaS
	DrKX5HGFY9CQJ0zUetyU8VGein+J4n/BJHjfHxAXdcOGs37VbXsjQQhBDktfKseoE8xzyt
	4S8QNJXYEeYtcTLXEOopLm3IGouEd5UOZw2nMeyj3yWJbRSrSI9N0MoL2HHcr/o8j3Xk2K
	4X3/dciU8tjQCG3jPgpFkiWIk17aA1uYA6z1TZzVEaVZT3WqH6EbwKWwGfQIgQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 7 Aug 2025 12:46:17 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Message-ID: <2025-08-07.1754534735-core-snowplow-plaid-exiles-anemic-gulls-v9Da77@cyphar.com>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
 <20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com>
 <20250806190751.GG222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esbkpzrhwvkavmb4"
Content-Disposition: inline
In-Reply-To: <20250806190751.GG222315@ZenIV>
X-Rspamd-Queue-Id: 4byBPY6Dbdz9t4B


--esbkpzrhwvkavmb4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
MIME-Version: 1.0

On 2025-08-06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Aug 07, 2025 at 03:55:23AM +1000, Aleksa Sarai wrote:
>=20
> > -		goto err_free;
> > -	ret =3D -EFAULT;
> > -	if (copy_to_user(_buf, p, n) !=3D 0)
> > -		goto err_free;
> > +	if (copy_to_user(_buf, p, n))
> > +		n =3D -EFAULT;
> >  	ret =3D n;
> > -
> > -err_free:
> >  	if (need_free)
> >  		kfree(p);
> >  	return ret;
>=20
> Minor nit: seeing that there's only one path to that return, I would
> rather turn it into
> 	return n;
> and dropped the assignment to ret a few lines above.  Anyway, that's
> trivially done when applying...

It felt odd to use "return ret;" at the start and switch to "return n;"
at the end, but feel free to change it when applying.

> Anyway, who's carrying fscontext-related stuff this cycle?  I've got
> a short series in that area, but there won't be much from me around
> there - a plenty of tree-in-dcache stuff, quite a bit of mount-related
> work, etc., but not a lot around the options-parsing machinery.
>=20
> Christian, do you have any plans around that area?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--esbkpzrhwvkavmb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJQTeAAKCRAol/rSt+lE
b94wAQCrCBDcIXw22aUu3figMXSuo1sk4u/y3z9goDq6pKhwEwEA2arOWYUnSBnh
o66eC1CZ/DJYZ+VQYJpyPsDGCErquwc=
=gJe2
-----END PGP SIGNATURE-----

--esbkpzrhwvkavmb4--

