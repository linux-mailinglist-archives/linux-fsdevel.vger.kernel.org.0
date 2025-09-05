Return-Path: <linux-fsdevel+bounces-60330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C0B44D0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 07:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A9A1BC7E22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 05:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A1A255E40;
	Fri,  5 Sep 2025 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="wmtocSjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B88229B02;
	Fri,  5 Sep 2025 05:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049101; cv=none; b=QYm4uGI117YCuBI8buZp+WYitCaJ0ZSyQwWB6IbSG8TLEG2vcd+YkR8S8FTLA29mNv8lW4cuLDNOI2XpCy5gppZ8ROTQ2MD6vl0DDyJSYznXfxyM43tKC568qMmwvXbPkTvEVs2TWmV/GkmvDaRL8F85cVddcEgft8+uEcI6crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049101; c=relaxed/simple;
	bh=MfMe3Ux66lPxL42rUu5NhgoeUgh/nZCEWUq9lD51RJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHpIjPaPjm48RkxsrBys/GJ5C4XfM8sPUq6zQCcXxSoM+Lu/HpG5q8u9ITYX4Zfmv4eTl/KXWqW7rr1BMdBZ09o7F1mllbj0Zjd+jbMCQFJd7pzRnD1oddXpDvEg1LqfwSAhCc4MuwuWGSdu5FvLgJRMDl2vCKMPMT/dYV6WuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=wmtocSjH; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cJ4FY4RHFz9sqq;
	Fri,  5 Sep 2025 07:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1757049089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGAcrOOH0CnQ5I6y/BvJDOYZrnadTkoW7iPOFIVb7kA=;
	b=wmtocSjHAx2Xl2pOupR3Agi5dW3D4kNySdIxzyGfCCsxzmKMlSVTLU8R6B4ALA9mvamsel
	WGj0PB1COf7IyWz1DPcjas0crrrbmxqbhtqwbhxCkjFJLtuEU9p70wefU6ggeWMMLZzNbG
	J8oHYwB0lpaplEQl5/FMBkjnq9HDGhSgc/7ZM/Yg5l6AQ/ycLkf0Ro1QSFQseLdXFwgaKB
	obL4CRBE/8y9or76pzRQCswrdjW9ihymrT7SoxWlBaoYhgHqNCH6UIVxnHtzi5e8IlhuxJ
	nCuAvwx/NBRRiW8F/0ZYDnnftaRHkAQsT3zAcETHDmnjmSqAtcg/j+G2GBLnfA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 5 Sep 2025 15:11:15 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
	patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
Message-ID: <2025-09-05-armless-uneaten-venture-denizen-HnoIhR@cyphar.com>
References: <20250904062215.2362311-1-rdunlap@infradead.org>
 <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yvusjolxsif6sgdv"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4cJ4FY4RHFz9sqq


--yvusjolxsif6sgdv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
MIME-Version: 1.0

On 2025-09-04, Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Sep 4, 2025 at 8:22=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> >
> > Don't define the AT_RENAME_* macros at all since the kernel does not
> > use them nor does the kernel need to provide them for userspace.
> > Leave them as comments in <uapi/linux/fcntl.h> only as an example.
> >
> > The AT_RENAME_* macros have recently been added to glibc's <stdio.h>.
> > For a kernel allmodconfig build, this made the macros be defined
> > differently in 2 places (same values but different macro text),
> > causing build errors/warnings (duplicate definitions) in both
> > samples/watch_queue/watch_test.c and samples/vfs/test-statx.c.
> > (<linux/fcntl.h> is included indirecty in both programs above.)
> >
> > Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should b=
e allocated")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Alexander Aring <alex.aring@gmail.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: David Howells <dhowells@redhat.com>
> > CC: linux-api@vger.kernel.org
> > To: linux-fsdevel@vger.kernel.org
> > ---
> >  include/uapi/linux/fcntl.h |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
> > +++ linux-next-20250819/include/uapi/linux/fcntl.h
> > @@ -155,10 +155,16 @@
> >   * as possible, so we can use them for generic bits in the future if n=
ecessary.
> >   */
> >
> > +/*
> > + * Note: This is an example of how the AT_RENAME_* flags could be defi=
ned,
> > + * but the kernel has no need to define them, so leave them as comment=
s.
> > + */
> >  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> > +/*
> >  #define AT_RENAME_NOREPLACE    0x0001
> >  #define AT_RENAME_EXCHANGE     0x0002
> >  #define AT_RENAME_WHITEOUT     0x0004
> > +*/
> >
>=20
> I find this end result a bit odd, but I don't want to suggest another var=
iant
> I already proposed one in v2 review [1] that maybe you did not like.
> It's fine.
> I'll let Aleksa and Christian chime in to decide on if and how they want =
this
> comment to look or if we should just delete these definitions and be done=
 with
> this episode.

For my part, I'm fine with these becoming comments or even removing them
outright. I think that defining them as AT_* flags would've been useful
examples of how these flags should be used, but it is what it is.

Then again, AT_EXECVE_CHECK went in and used a higher-level bit despite
the comments describing that this was unfavourable and what should be
done instead, so maybe attempting to avoid conflicts is an exercise in
futility...

If it's too much effort to synchronise them between glibc then it's
better to just close the book on this whole chapter (even though my
impression is that glibc made a mistake or two when adding the
definitions).

In either case, feel free to take my

Acked-by: Aleksa Sarai <cyphar@cyphar.com>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--yvusjolxsif6sgdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaLpw8xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9NbwEA02CLCYrxglSSoPJK2a37
x4+43VSdH39lraFtf9jLTHEBAOVpoiIDX/SFZMEO7PSYUHZKFl/IG/zm/xWeNSYo
Zr4L
=ht91
-----END PGP SIGNATURE-----

--yvusjolxsif6sgdv--

