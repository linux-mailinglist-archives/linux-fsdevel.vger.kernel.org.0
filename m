Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D22EACBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbhAEOEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 09:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbhAEOEr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:04:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC9E22AAA;
        Tue,  5 Jan 2021 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609855446;
        bh=uxDx59odXyMKesoE6NM8YchGLsGRSMrggodBArlmtqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4UbT2yKHLGkVj+OjPy+Gn1Mb6jJx73ZX4UI68u5fXdFbgVYF5VvZHGMC6vH+T0Ve
         TuvfzLcAXDpiAS4krKUf7a84R5wZrfZOt/un+fifqMglOdvIP/1vN15lGZn16JHSqO
         21Xh1TyIYNgl5VN0IonuQaJPSDf0F3YCt60cK8eJWWKJYcUTZ9k3qN2GX+f+8/ycsn
         k/hm1eE0L2P04D6ClQuTFcHZVTZuIqF39tUz0+s+9cpijHiJ/Y6dKk72dhOQ7QTRxQ
         8b8/h+FQqfdbHoxguJTb0sPFAXPGBtPH2MDNgEt55N9+s1MxUhEE0DKleGScLFhqsT
         gfuCWhkMIXnpg==
Received: by earth.universe (Postfix, from userid 1000)
        id 40ADF3C0C94; Tue,  5 Jan 2021 15:04:04 +0100 (CET)
Date:   Tue, 5 Jan 2021 15:04:04 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: mmotm 2021-01-04-16-56 uploaded
 (drivers/power/supply/max8997_charger.c)
Message-ID: <20210105140404.plxeasjxipvqrehl@earth.universe>
References: <20210105005703.XhY3BDF8Y%akpm@linux-foundation.org>
 <6ed164be-e80e-e69f-c164-4e1c68465728@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6khxqy7wtk6opeka"
Content-Disposition: inline
In-Reply-To: <6ed164be-e80e-e69f-c164-4e1c68465728@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6khxqy7wtk6opeka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Mon, Jan 04, 2021 at 08:26:04PM -0800, Randy Dunlap wrote:
> Commit bb118e5178b3 in linux-next seems to introduce a few build problems:
>=20
> ld: drivers/power/supply/max8997_charger.o: in function `max8997_battery_=
extcon_evt_worker':
> max8997_charger.c:(.text+0xa3): undefined reference to `extcon_get_state'
> ld: max8997_charger.c:(.text+0x102): undefined reference to `extcon_get_s=
tate'
> ld: max8997_charger.c:(.text+0x161): undefined reference to `extcon_get_s=
tate'
> ld: max8997_charger.c:(.text+0x1c0): undefined reference to `extcon_get_s=
tate'
> ld: max8997_charger.c:(.text+0x21f): undefined reference to `extcon_get_s=
tate'
> ld: drivers/power/supply/max8997_charger.o: in function `max8997_battery_=
probe':
> max8997_charger.c:(.text+0x962): undefined reference to `extcon_get_edev_=
by_phandle'
> ld: max8997_charger.c:(.text+0xab0): undefined reference to `devm_extcon_=
register_notifier_all'
>=20
>=20
> CONFIG_EXTCON=3Dm
> CONFIG_CHARGER_MAX8997=3Dy
>=20
>=20
> Full randconfig file is attached.

Thanks for the report, I just force pushed an update for bb118e5178b3
("power: supply: max8997_charger: Set CHARGER current limit"), which
adds 'depends on EXTCON || !EXTCON' to config CHARGER_MAX8997 into
power-supply's for-next branch.

-- Sebastian

--6khxqy7wtk6opeka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/0cc4ACgkQ2O7X88g7
+procg/+OTWf0B4jomDbGLW6DuPmrJGbTurfSpsT7aEJtaExdH0bYSiaCL3hPsKF
RaQFbxWsfCbHMeEet5J9gdSayB3udV9klPPPnkI0L4MrVvkzCcl8WSV9IwN+KjfF
xGcT+HLSRT5ugkN4oM8DYDaPsLVmvbq9M0tJ7XXTY5uxzibE+nSeQlxr6rU2WXco
1P75eInawfipsyXoJ0WKeiV6Osct1G0Saq63NFNVMigu6c++/DPmq+qAGott3Cpy
+Jm7VLOOoMJdY+ovUUV5fECc1Mw2FZt0gfZR5Ue+nbqCl1VHw1hheMKlawXFfoGM
LCy/LNelv/7VktHcEFQISC+jH6/Qf9urhLmuaVFu/T3nuNb8q1qxF7kSs+cyyirc
3oUc3fzSkQNT7X1Yl8cXdqUsg+xgI4vIN1duGRhO1fQXzJ2yMqitTjgwjp1B2vwb
q2zebMSTETZMByr1tQOMqe+uogxLdOdDEyblpVccgjmDFYtL66KE3CWwYp17rtLm
UmFaG5unMUSau1/5woqhG0lj9t7mD8iWVMjtTJq2/BlputdJrxChwoGtaeV87qpE
NiwHQDo0mN/aRIEgdUjEYnvnD2bnc3ZrD5uQ6CSllzJ1AlrUEuEe2c50pwkCk7hr
LYY5Ckm8Rog8SERBo2FNuR301V2v8jFWYJXf3uh6i6Zxfci34js=
=i18e
-----END PGP SIGNATURE-----

--6khxqy7wtk6opeka--
