Return-Path: <linux-fsdevel+bounces-72335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DA5CEFE2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FCF6300A510
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C733090E1;
	Sat,  3 Jan 2026 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R76n3FZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7138307AD5;
	Sat,  3 Jan 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767436615; cv=none; b=cwmT5OVqAmf3Z9F2HhBKj+bA9mL0HgzhUf9oU+uqVV2RWRffUnvdx+GNIzS9krh6bq3XqXPqCX0e9K8N2Z25Tn7G5+MTH/UvHpzxldYJ0xoJ4Onf8gE3vRMVaaWnyNWNjLGC+18hRfvSS3fKC56s+wW1BIBol/P/M3aIXUuDUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767436615; c=relaxed/simple;
	bh=arEjnNSXWiPPsG0EU2mrZ5M7JoM5HEMOFezgrnG6GFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGSWdYm83GA79wW/OPYV/CsjRTlGPzHkn1mLFuqpVmhSn3gdYLvpNVYG4TWrHk8Zg9GHXxDJaUW0lHf1silaVlf/K+W5GS8WsPPk8cYUXmDINFpJwcT3lNZkMV8R45K6KAN5vIw1NF/XMfq4O0LeyAeMBkc7g3rt0LBtmj1MomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R76n3FZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CD1C113D0;
	Sat,  3 Jan 2026 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767436614;
	bh=arEjnNSXWiPPsG0EU2mrZ5M7JoM5HEMOFezgrnG6GFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R76n3FZKdQ5zKBUn4ThJvcz9/XmWmFFOQEN3PjuatyT5ElkkAUaXFvyEA7hCx/Scu
	 CEt1c3smA/LfQ+L9orGbzk9lrbvopKSMwTavp1DZ1B9k6hqAqtiuOXqp40rfstjit1
	 DvgkqThttVRmGGIgbVnqPo9hZ6ZyYLdsG9jeP/6C8RWVVt10wEE+jkgvLd9Dr7I5W7
	 p3I79xY3uGiwTVJeyx466RAfJ8lQgdggpYgigiT+rHHR3v1gPF9oex8a00eJCUNqNu
	 uaejIdOniSfV2NdeIYnUW98jGjr3EM3kbseCejygES7SSTGa6k4yXnoAamExYz8f6Y
	 n9ev7hCqaifug==
Date: Sat, 3 Jan 2026 11:36:47 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] sysctl: Add negp parameter to douintvec converter
 functions
Message-ID: <25gqrmbt5hzknu3244thjxo7o2tavliw2h7okp4xrbu42xntxp@flz66og5xlph>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
 <20260101-jag-dovec_consolidate-v2-4-ff918f753ba9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hdbrnsw2a5il4xoa"
Content-Disposition: inline
In-Reply-To: <20260101-jag-dovec_consolidate-v2-4-ff918f753ba9@kernel.org>


--hdbrnsw2a5il4xoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 01, 2026 at 01:57:08PM +0100, Joel Granados wrote:
> Updates all douintvec converter function signatures to include a bool
> *negp parameter. This is a preparation commit required to eventually
> generate do_proc_douintvec with a macro. The negp argument will be
> ignored as it is not relevant for the uint type. Note that
> do_proc_uint_conv_pipe_maxsz in pipe.c is also modified.
This breaks the compilation. It is fixed when all the calls to conv
are moved to the macro, but it is still something that should not be
there.

I'll correct this in my V3.

Best

--=20

Joel Granados

--hdbrnsw2a5il4xoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlY8TUACgkQupfNUreW
QU80xwv7B2TolV3O6GFMM4HOZkacQdbQtmRhL0tEAr6fbbw/0TJzxifx3NRmcDnF
fhp8jnycDd1UDWOVQBMDrggUfhT5yv1StrqI1+8qxFJAN+D16m0b18twaGqUGM2l
TQshDju/MwIKFiCb3e45vtLmk38+zIfknKl8JqkxDUkGzrW35TNEZ1DztLY2yeds
ymF8+aToiWzjGRiTQn6C2kvJIdOMI/VxGBkigP5yYDkq6wb2LLJdFsDgCPWfKQha
b6uUouOxVjN6zzGNVE55EqkTFI5ZK2Q+dhX/9JFJFd3YYfW1vKNdjVjn9k0Px0sD
uu/SrHO18UCKmre21TtFDElPdHTQh+s5+xQpsLq9MnubkoVMLGqsv3WzRrUS2rMi
rzlXvPQgPhXYSJHqKWSSxXJKCw/sZ6yvgRybmww/143dhT1Md4UmktvROj+IUPsE
b1eMHOs61m2YANvWBArQI2L4AiVbVgEVZ6iubPpcfFPdiPXSaxXzRxQ6M4zOpNOF
b9vsrb30
=PdG6
-----END PGP SIGNATURE-----

--hdbrnsw2a5il4xoa--

