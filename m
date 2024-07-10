Return-Path: <linux-fsdevel+bounces-23474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FB292CF23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88021C23943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555F194124;
	Wed, 10 Jul 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFSk2WEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FBD19004B;
	Wed, 10 Jul 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607015; cv=none; b=FLT3Y7m2w5WdXLyrlzfRYW1mUo3VWkUriBpZm9DSCZQJ9RVkWgkPKHiewcQGHNnq97t8NP29TFKuGl2ZRo0hpazrLuMoCNR2vWmRgKjWvGH05kjODy7JFlQbhWkAo+7Byc8bdm/SE2L5o9wSwwob4+R5wJZ0ZlkY/HgWKTuy94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607015; c=relaxed/simple;
	bh=lWbmWB8ABH5bAT2n/r47MFOEPgdeRF7pB/XTvjDxBD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaBBVokHPMnvI47visQxK9hPjb1w+xXT+LE1JwAS1hpK3D8uHYgqCCcZAilcIgunmtVOAt6NjnfU5N1Ig6+xMLX7xpuzuZX77dAqLhTyHQf8xeGDvsdX0X/4CtYrnSFvFYKgKFRxCZ1UeSkH2pzDVutVc+Xwka6RWDS/hWi4HUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFSk2WEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD55C32781;
	Wed, 10 Jul 2024 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720607014;
	bh=lWbmWB8ABH5bAT2n/r47MFOEPgdeRF7pB/XTvjDxBD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFSk2WEeaoaeHMtsy3Vznsh9py6gHwoonbfe6xRQKQnvUior+zlD9CdtBuaLW9olq
	 NdD5OdgV90HvOOIcWvBrtRWRBWfwmOfqE1EyAtgT1XiYpN+5RXvGYGQvEYimwvFxtp
	 3KNl0RSXxFJw/A/TtvZVOm7DXhc3LFTetOl1VZ6itgWQmvTUwAZ+rMoFt3/gZaNaY2
	 BSn47iSoAhiksD8Z0hczmOVdiADvRoyikbMRrjN2m0Pm4ZVx5kE45vREm/NF9ivakf
	 PjHAqMBrRJ3qaqkiEYZG9ZDcd27AsRwEhOz62p1oa+9qAgrf/MBwJzPeDOsLvNqiaq
	 YrHJlhwLxDUtg==
Date: Wed, 10 Jul 2024 12:23:30 +0200
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 1/3] statx.2: Document STATX_WRITE_ATOMIC
Message-ID: <ybvnpaat7vzjjspxsz25rvu4nrjkdlqbu5had7ykn3zgulbofb@rxqzi5u37ip5>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-2-john.g.garry@oracle.com>
 <udwezmj36we4bkvlnbxpuvrrikh5yejaf6yetxd2ig3ssgksrw@fi5hsutb7mmu>
 <8b3ce0be-779a-4649-ba6b-d78dabb7cbfc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3rkyyjs672jwsqe"
Content-Disposition: inline
In-Reply-To: <8b3ce0be-779a-4649-ba6b-d78dabb7cbfc@oracle.com>


--p3rkyyjs672jwsqe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, hch@lst.de, djwong@kernel.org, dchinner@redhat.com, 
	martin.petersen@oracle.com, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 1/3] statx.2: Document STATX_WRITE_ATOMIC
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-2-john.g.garry@oracle.com>
 <udwezmj36we4bkvlnbxpuvrrikh5yejaf6yetxd2ig3ssgksrw@fi5hsutb7mmu>
 <8b3ce0be-779a-4649-ba6b-d78dabb7cbfc@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8b3ce0be-779a-4649-ba6b-d78dabb7cbfc@oracle.com>

On Wed, Jul 10, 2024 at 11:11:33AM GMT, John Garry wrote:
> On 09/07/2024 17:48, Alejandro Colomar wrote:
> > On Mon, Jul 08, 2024 at 11:42:25AM GMT, John Garry wrote:
> > > From: Himanshu Madhani<himanshu.madhani@oracle.com>
> > >=20
> > > Add the text to the statx man page.
> > >=20
> > > Signed-off-by: Himanshu Madhani<himanshu.madhani@oracle.com>
> > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > > ---

> > > +to be a power-of-2.
> > > +.TP
> > > +.I stx_atomic_write_unit_max
> > You should probably merge both fields with a single paragraph.  See for
> > example 'stx_dev_major' and 'stx_dev_minor'.
>=20
> ok, I'll try to merge. I do note that we then will still have
> stx_atomic_write_segments_max in a separate paragraph.

Yep; since it's different that's correct.

Cheers,
Alex

>=20
> Thanks,
> John
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--p3rkyyjs672jwsqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaOYSIACgkQnowa+77/
2zIklQ/+OCSsqTuC19pnWXW7Ii8wF3/V71Cg65VZ6DaRY7E7VphA0MHRrC0UsKyS
YbT5Yzy8Ll89HdLLjsLKFCOhsmbvfqxyKVSbzds7h9ewnuKzFv8gXK36ehGl4AGK
UMtTnrRpf5wN+aAyg1ybUQZ5Ls4jA+uqmC3j4x8yd1X835roQHLfS099jtusigyL
1uaBOM4Mw2Bb656OduBpMG31vg80Kt4JwHxXBGbIOJw0koYYYGZv8eIQ3MSdsOx3
jFzGrA0rc5C7vWYVmUSvpGjiiSo+TmA/ZfGeA3I/cOM41b1HyrGXGv5LxNPrOaz8
/HaP5OtvzJWn3d71zWogYFGxkKiFT9SIGOPXThQ/2nfe/ANHWGCIvmm54HADLJNL
0eTAgvmuAIfED+12OxqWJSMNiWguQDj4bwTXGVRQzdHIvOWiVTMMTVPEQbfl98q6
5Q/kP5hP673rv5l84wJeYtLmiN9xB1AEofEndBfPM2vdOjRLEOpOycaU37M9dxxt
o0xWotakZRiZEvsG77hmcM66hAuKa8rJbYDoqKPjcY3+y471XskcTB4nMDPhkxcr
opt8euxafdrNKYEViW7167KGm33yhG2Y9ICKFoguEyBYvk0f4ARFkNWmSQA79tFi
20tuH73rLBH4wFY8rcB4oiYmK15gJVHnwcc/J6SyZdEeAoPDPv4=
=+Nih
-----END PGP SIGNATURE-----

--p3rkyyjs672jwsqe--

