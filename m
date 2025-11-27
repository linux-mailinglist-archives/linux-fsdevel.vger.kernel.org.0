Return-Path: <linux-fsdevel+bounces-70043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C23CCC8F2E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22B154EECB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F879335092;
	Thu, 27 Nov 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE8KEl+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEC334373;
	Thu, 27 Nov 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255989; cv=none; b=syueKelFBt2fmZZnHgDfcwqOeo4H/SOOMhGv0UC1xWsgb2bgIM1tkRZ7JVcFGkcXWT2CQrsbsOi43g8AQ8GpKeektnbT5aVF2uaabITcGL3szSmHcOHTjyrweHqnwgjtYEgziQCB+Pu4mDdil2YQyPfgz/YoD8hnX+5j7Vc6pq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255989; c=relaxed/simple;
	bh=3S098GTRAwAUOfOKcuFGBrlQrJ2w6p3jYQZPY4piJa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+eN0VuZYFZqOM6DpKJwBpjM8xdodTAIQ7vmOl0A7rtmNvp1rWT2GOtPS4kF8uXCNsLLRw0u4ix5zygVRYrvctdvlPRBYlELDTV0XuOTuJiNWvdi4TwQHJgyDF/2mPcHsmeHqek0kpxDWDubiJHiuCmHuT+6RcwXfQRi1Msd1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE8KEl+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BA8C4CEF8;
	Thu, 27 Nov 2025 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764255989;
	bh=3S098GTRAwAUOfOKcuFGBrlQrJ2w6p3jYQZPY4piJa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JE8KEl+oWam9/p4MBfbPqq2yG9n404V7ubJGOeyBY4fp7n1p4pcSv1QcdiK+4U8kB
	 xhWBjmn62v5OmNz9CuzH5Q2tU+HC8gHRAInEk5LV4MB2foCF2C8hcZkQTD4FkJNIiN
	 1zT3yHflgTKcCHr+xHwyNB6SZ5iTOYtYQKdisWv5CVJRP8lz90Rzisy1mhKseUwl0H
	 aU/JNbvpzHV/aCo0tABI0btRTmC2aTE1nj23uBJxCso+GYs+Qnju+eGH6IULLoEZkB
	 dhfVTGGYsNEPukyFxcVbu8o8i4akHpnQKjKU5Z20AnA7uFV0qqvwLhV4KWjhwvtN23
	 ugqtC2Z72wvKg==
Date: Thu, 27 Nov 2025 16:06:23 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Oliver Sang <oliver.sang@intel.com>, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, oe-lkp@lists.linux.dev, 
	ltp@lists.linux.itccccbjfeunckknjvluceftfithdduijkhkcinjndvek
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <qh2rxa43jjgbuarsab2wmjtj3mhpr7qngstjaizerh5cu4a6au@qvglk74vl4v3>
References: <202511251654.9c415e9b-lkp@intel.com>
 <aSWI07xSK9zGsivq@yuki.lan>
 <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
 <774fersjoa3ymtmorfoxs7xei3vjdf5h4dohkkjjgxo6qgpz5w@kqn6du5d62m7>
 <aSgygYnVBK1MxdOT@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="copjdub3atua5ehu"
Content-Disposition: inline
In-Reply-To: <aSgygYnVBK1MxdOT@yuki.lan>


--copjdub3atua5ehu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 12:14:09PM +0100, Cyril Hrubis wrote:
> Hi!
> > > > > PATH=3D/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sb=
in:/usr/bin:/lkp/lkp/src/bin
> > > > > 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> > > > > 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=3D2
> > > > > 2025-11-25 05:37:33 export LTPROOT=3D/lkp/benchmarks/ltp
> > > > > 2025-11-25 05:37:33 kirk -U ltp -f fs-00
> > > >=20
> > > > Oliver can you please record the test logs with '-o results.json' a=
nd
> > > > include that file in the download directory?
> > >=20
> > > I attached one results.json FYI.
> > I can see the errors and I can reproduce on my side. I'll take a look.
This is all fixed in linux-next. Feel free to scream at me if you see
more sysctl errors.

> > thx.
> >=20
> > BTW: I saw this path in the logs
> > /proc/sys/net/ipv5/neigh/default/anycast_delay
> >=20
> > not sure if "ipv5" is part of the suit, but worth mentioning from my
> > side.
>=20
> The proc01 test walks over proc files and attempts to read one after
> another. It does not invent paths that are not on the system already.

oops. I re-downloaded the json results and it was not there any more.
I probably inadvertently change the file while looking at it
Sorry for the noise.

Thx for the report

Best

--=20

Joel Granados

--copjdub3atua5ehu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmkoaOAACgkQupfNUreW
QU9UNAv+L7VYafZ8MesMo3B46A4EE+3cNw2T7tJse2SdMxZTc9rPWoz5+PYLAYLz
vvoFloQIGG6PyQOqvCUdbjJ81vmflWn4weo9yzdGYjCw4OD8awz3VFUTX0ts4Exf
MehtMnD53Ot+fHYeituI/tNgg5DdbEb4kRllz1woq7eERSrJHYXIxOsGIVB5QEz4
0CHQBV5cnt6gYcGGZ595QZYEAGN9i85dG3SPTmMb93UON+PHxdkHKtRhmZLA1epZ
q80yIFZPIfI5f/jras+lkZOwaLzFtGbhYWk17/9sMg6NNotWdYc54Ztq2OAV4ZfV
PRG83B0foAlnfIie9g0e1Uc/+ionl48O2fZgh2Z80aZqIMD8bbTDPYouwbuyuo2c
MZBv1poamdgO/U5o+Q+f6Gjz66ZIgYPN7qQY+jHl/Kb2vNCPXLHy6lKnXqHC6tHu
fO1hDR9WhAIKW62NdKGc+TB3ehAM3e64+/WS3PMVfW1VMZ0+zDbB3cUdzrZcDba8
IU1cuhSY
=WEhW
-----END PGP SIGNATURE-----

--copjdub3atua5ehu--

