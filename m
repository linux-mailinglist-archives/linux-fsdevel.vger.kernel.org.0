Return-Path: <linux-fsdevel+bounces-72305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA4CED02A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C463F3004F37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA5221FA0;
	Thu,  1 Jan 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmYvI6fV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBFC1FE47B;
	Thu,  1 Jan 2026 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272207; cv=none; b=WLnrJjfY+FU8FNHExqiPt4BltmI8KG6IbqTRnW+EqCimUJ/sZrNERGVwS+pHBouSmFPg8pBMD3jHoAbo36KSijxUBBZlNpWwEbSM+HU5Pi1zoH147tKGS7A7y3Sy2yd1crm2gv0OygOpp13x1vRUDwjiIcI6ItMzvJL6Timl6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272207; c=relaxed/simple;
	bh=wVVjxnr9DQMLxUQvSgB/rwCoqGsJ5g0sEe3/gwqRCfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTFgD5pCbFrxkDRO5J0fj3PFEl/daU2v0fjo1bJdsdb3ozXyZ4dV992gW9XW4yZK9daxUinSsp7UBG7yADStgPKQBT5EzDWPBMaP13/32FbBIlwFjgBuo0OElzBrF3f8UZDRQ7MGCOdmyEBeIEEMS3XKUI1diBmbmR40NQGbSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmYvI6fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ACFC4CEF7;
	Thu,  1 Jan 2026 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272206;
	bh=wVVjxnr9DQMLxUQvSgB/rwCoqGsJ5g0sEe3/gwqRCfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmYvI6fVTQpFwsHb73WhjpgP/DJNPozcw4cRwSDIWh3JUOySd+s7ZHg2xZdwU7qMd
	 W5dbcqoZEnuPAn2zHqWThYTH2IqYPowkw3IqNcyYCRoHdtOL+L9f/Qc2DCcq/leTqd
	 35arffD5CmaBHM/mBtS+CqH/wUM0dMp1ODgTS31kdGfhNk0AylLjhM6Yh/g4puwdbX
	 TQVX9ccXah7wIPnnb3+jpQV3Nnhv71diPawHY9ni9hA5Wn2jgMvlo0myAVtrsjVhJf
	 KSeFcpNGf5vquMxPbJ5HMuSb1SzxYp3LJYcK33uiKPwCRAeh6EVTZajyDCT4OEUXyp
	 S0J/zuOuqh83A==
Date: Thu, 1 Jan 2026 13:56:31 +0100
From: Joel Granados <joel.granados@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/9] sysctl: Generate do_proc_doulongvec_minmax with
 do_proc_dotypevec macro
Message-ID: <3745l5zib7vpnr45vkxrhrdbvcbu33msqa6uanglbmdt3t5qhy@kvsianv7swdl>
References: <20251219-jag-dovec_consolidate-v1-3-1413b92c6040@kernel.org>
 <202512291555.395cc7b0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="illmyazjuel2valq"
Content-Disposition: inline
In-Reply-To: <202512291555.395cc7b0-lkp@intel.com>


--illmyazjuel2valq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 03:17:58PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "blktests.block/020.fail" on:
>=20
> commit: 216729bf72d98eca7a48326bb17b577c3fde9634 ("[PATCH 3/9] sysctl: Ge=
nerate do_proc_doulongvec_minmax with do_proc_dotypevec macro")
> url: https://github.com/intel-lab-lkp/linux/commits/Joel-Granados/sysctl-=
Move-default-converter-assignment-out-of-do_proc_dointvec/20251219-202253
> patch link: https://lore.kernel.org/all/20251219-jag-dovec_consolidate-v1=
-3-1413b92c6040@kernel.org/
> patch subject: [PATCH 3/9] sysctl: Generate do_proc_doulongvec_minmax wit=
h do_proc_dotypevec macro
>=20
> in testcase: blktests
> version: blktests-x86_64-b1b99d1-1_20251223
> with following parameters:
>=20
> 	disk: 1HDD
> 	test: block-020
>=20
>=20
>=20
> config: x86_64-rhel-9.4-func
> compiler: gcc-14
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake)=
 with 32G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202512291555.395cc7b0-lkp@intel.=
com
>=20
> 2025-12-26 15:49:33 cd /lkp/benchmarks/blktests
> 2025-12-26 15:49:33 echo block/020
> 2025-12-26 15:49:33 ./check block/020
> block/020 (run null-blk on different schedulers with only one hardware ta=
g)
> block/020 (run null-blk on different schedulers with only one hardware ta=
g) [failed]
>     runtime    ...  42.071s
>     --- tests/block/020.out	2025-12-23 16:47:43.000000000 +0000
>     +++ /lkp/benchmarks/blktests/results/nodev/block/020.out.bad	2025-12-=
26 15:50:16.434082831 +0000
>     @@ -1,2 +1,10 @@
>      Running block/020
>     +iodepth: min value out of range: -16384 (1 min)
>     +_fio_perf: too many terse lines
>     +iodepth: min value out of range: -16384 (1 min)
>     +_fio_perf: too many terse lines
>     +iodepth: min value out of range: -16384 (1 min)
>     +_fio_perf: too many terse lines
>     ...
>     (Run 'diff -u tests/block/020.out /lkp/benchmarks/blktests/results/no=
dev/block/020.out.bad' to see the entire diff)

This is because the value returned after reading the ulong value in
/proc/sys/fs/aio-max-nr was negative (which should not happen). This is
a particular behavior for this .config that I did not encounter in my
tests.

I have reproduced it and corrected it in V2.

Best

--=20

Joel Granados

--illmyazjuel2valq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlWbvUACgkQupfNUreW
QU8NPAv9FMn0D7X3vIloUR+xu899sRXnmPx7XpfwVPDN8/OUtMtgNwY1FLfjVzYM
Z8uJjDnRcWcrj/v6b8sohiAEAlQ5ZvIWaul1wbtQCDAs62w16+brVQxt6g+S1Dw/
n9if9UVdhC3H1af8pAV7pOq6n2ZGT4VUaWuTjmrbkP2M6MJVM7iOypQKXNcNTKWP
xBAtacim5vZInU/KMKAxP7wOKkwvuNgRSBKZ6cr1S30Rt3KbXyGpNaEzDqiGcfYX
9/wxAlqaGjQg8suwj3eFXauh2/xdv1zTW9zBgH4/vgbz8WPLJ0C51jlrf+xQq75V
xg7pCo5zy8Aym9IZibKJ4VrgQDugTRKP6okubQQHixizMj5Egy2pXZ8wXj/hw+iX
zsGAtliYFp+w3X0QbbRvBbVQjlHk0UaTF3gbxJO7qKmKe1Msp82GD8eUlrNl4oim
ejB3XEQgu9za7xqM1JMP80Zkae5vQhOYygHs635H7uuHxu1rik7uy7LfYRKdZq29
JluFphEO
=W+JB
-----END PGP SIGNATURE-----

--illmyazjuel2valq--

