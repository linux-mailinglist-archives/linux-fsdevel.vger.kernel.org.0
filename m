Return-Path: <linux-fsdevel+bounces-65516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8BC06681
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C943BEEDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E6631A567;
	Fri, 24 Oct 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtXz0iFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB7207A22;
	Fri, 24 Oct 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311057; cv=none; b=AFPJmb2YZDZYyMVe8QLca63xkGZiDk+CdhWPpNKs4nD0AOBZu89Y5L90UWHoX/0dM4QHOTw4OZe7NDz8CiHK0GyuNZMDXnZyyKgN74d3S/YhRn4VzEPh5VDXKWfApMbR1NzVjfbLo2AuY2KOd9PKJuFJFmg+I0Vn+3azMkpRYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311057; c=relaxed/simple;
	bh=EyAeLjD2mt8q0+a+IwgJteAu5pMwhBg01yOiKtaBrHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGYnyNhjMJKK415OsoXyqVQb62HcJB7RMvoc1Yy1X5vaFWAVr6E61MraB7Racrr2VJGbN+mgEK8h/yUNkNuyk8j6eLuoJJz/djrpYv0ydG+Av2RDc6BV0h3h3qk2ndCQ1TVoo0miS0itkgKvcsUUo1d83k4t/ErxGDM6f4N0umY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtXz0iFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB05C4CEF1;
	Fri, 24 Oct 2025 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761311056;
	bh=EyAeLjD2mt8q0+a+IwgJteAu5pMwhBg01yOiKtaBrHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtXz0iFzncEokMqHB0LPd/aZe9xXOXZNzLK/jV+K9uKtHNOIN42e2ze2n1B3cGaI6
	 kQd3ZeyJIgSIMK521q2gtUR01ZO3JO304GTj0mzIit3jNGhC/dWWbXbY6e8SF4jViD
	 3sF+WKySbv559ORkKa9mvW8apVhf9+LQcInbUsCUG6suv6Bu6jkpe9S+isvrnd7V7W
	 ItKrVmLzwMODHg3KAM8uVTnuNa51DtKN96gKnSWqJtiKvkw1cCEbBxGqYL3P8hdF9t
	 +LYQIETjJiW6aOpAgZCIRybmZ3rZ1O2OrCNRRP7Plnot95UR0dD5THFdXctj4roHXJ
	 vAF6VeowzzFYQ==
Date: Fri, 24 Oct 2025 15:03:17 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: fix kernel-doc format warning
Message-ID: <kyn7q3tjjxg45am326ykx4hbnqzffl2nkt77vl65qxa4p3kpz2@ysgkf3j3ch4m>
References: <20251017070802.1639215-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwzdj7e5is4kav6e"
Content-Disposition: inline
In-Reply-To: <20251017070802.1639215-1-rdunlap@infradead.org>


--pwzdj7e5is4kav6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:08:02AM -0700, Randy Dunlap wrote:
> Describe the "type" struct member using '@type' to avoid a kernel-doc
> warning:
>=20
> Warning: include/linux/sysctl.h:178 Incorrect use of kernel-doc format:
>  * enum type - Enumeration to differentiate between ctl target types
>=20
> Fixes: 2f2665c13af4 ("sysctl: replace child with an enumeration")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/sysctl.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-next-20251016.orig/include/linux/sysctl.h
> +++ linux-next-20251016/include/linux/sysctl.h
> @@ -176,7 +176,7 @@ struct ctl_table_header {
>  	struct ctl_node *node;
>  	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
>  	/**
> -	 * enum type - Enumeration to differentiate between ctl target types
> +	 * @type: Enumeration to differentiate between ctl target types
>  	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
>  	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
>  	 *                                       empty directory target to serve

Yes! I'll push it through with a little tweek by putting it together
with the general documentation for the ctl_table_header. That is the way
it is supposed to be (according to Documentation/doc-guide/kernel-doc.rst)

Best
--=20

Joel Granados

--pwzdj7e5is4kav6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmj7eQ0ACgkQupfNUreW
QU8yBQwAlFm8UKuMzczwawnfRf9Dl0Fmx5r+HK/PQIBKBtBXz7eV4ZjzXnNZ12IX
C24dwOF6lUq3TJQWn1uAYtnctoOGb95vMzi1Lo8IXNiOY/CiwNsJPHl4UYz//LFZ
tzICdE2UUfWXPNT5tOjryrvfM/wsNs28CNNvH2HwWUFuIRn53CqCAtiD1eBoP0HH
H5cj0/8Vy9xNksrohLoCvjhKsVIxdjJ59sToBWbIiOZxbJk3ekiwb5/qJ3RaQ/Wz
r+mlRk9s3gU9xbMGgXVZuj4QCTmds559c/BY7ekQ/eb6SlAQW0fv7aCvRjngsa9E
HZbZYy/nJkc+sibmvxcPfazHPmnQv1GwBYX00GQ/N40fZpv8ujaDGG1FaJCwrCSN
jEa2L/Tqze/z/eGdJ7Tp9Z/gBCmcJ5V29NuWmAOS/wUq2CF9S1OqQizFIKd3Lqf8
eE3uUtw8ngexZzB4CF6HkN8YZEyIEeGlYv4BSscd661WVo3Z4n4JxPGouHIjmwCX
WkHJaKxi
=eoQm
-----END PGP SIGNATURE-----

--pwzdj7e5is4kav6e--

