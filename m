Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBB4BCB3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 01:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiBTAMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 19:12:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBTAMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:12:50 -0500
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 16:12:28 PST
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E22101E;
        Sat, 19 Feb 2022 16:12:27 -0800 (PST)
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4K1Qgr65zRzyP2;
        Sun, 20 Feb 2022 11:06:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1645315563;
        bh=fhKEWE2qN7BLNknFxf7cwRDVzk4QhK6JwHxrtjN4H4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jRSMFmYPNqQFDgCJZGzIs0QEolldSR7mUn+vKNXBn+wmWTrIZcf6CTQn8Rk3KloPM
         yvJwV2qI+EBeTEGQ8Am9EggKsbbB6ndCBcJMno0C4YEEowloRjTB0/YsIlPKe0Rb3e
         +2HlFILxNwUSc68J+1VJum3aUo2XKHcaZQ0c3KR1u/zm8RIx88xCV4tugnR/2raTdz
         oXN8rnI9Brr9k5ZPgSWPQgM9Ejdt8/vhrwEGumb6cGMQG5uRS1PBhq4oLX1+shcIgs
         c3icl/L7et2CADY5yoMUy7pjLIZvYirv28GUJlwWhgsuAiHmbmc24v/AC9Rf/6Ll5U
         li2jRI2WCaOGA==
Date:   Sun, 20 Feb 2022 11:05:19 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org,
        Zhen Ni <nizhen@uniontech.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/8] sched: Move a series of sysctls starting with
 sys/kernel/sched_*
Message-ID: <20220220110519.4c267c69@elm.ozlabs.ibm.com>
In-Reply-To: <Yg/jxFqiuyR/xB2s@bombadil.infradead.org>
References: <20220215114604.25772-1-nizhen@uniontech.com>
        <Yg3+bAQKVX+Dj317@bombadil.infradead.org>
        <20220217185238.802a7e2dd1980fee87be736c@linux-foundation.org>
        <Yg/jxFqiuyR/xB2s@bombadil.infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A_7RQbOzLU6cilHr=SxBuq/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/A_7RQbOzLU6cilHr=SxBuq/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Fri, 18 Feb 2022 10:21:56 -0800 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> On Thu, Feb 17, 2022 at 06:52:38PM -0800, Andrew Morton wrote:
> > On Wed, 16 Feb 2022 23:51:08 -0800 Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
> >  =20
> > > Are you folks OK if say Stephen adds a sysctl-next for linux-next so
> > > we can beat on these there too? =20
> >=20
> > Sure.  I just sent you a couple which I've collected. =20
>=20
> OK thanks! I've merged those into sysctl-next [0]
>=20
> Stephen,
>=20
> Can you add it to the set of trees you pull? I'll send a patch to add
> this to MAINTAINERS too then.
>=20
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl=
-next

Added from whenever the next linux-next tree gets done.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/A_7RQbOzLU6cilHr=SxBuq/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIRhb8ACgkQAVBC80lX
0GzueQgAkvmPVIX7H6WlKxMB4Zk4kOAaN4MZQytMEzU7k4MoUSMFWsw280y9rk/3
kXyVuFA8bs2VdnW5ETsVmVVhJ1PRLtKZJVq+1pW3QWjtkNmmASXKtZE2Uweh2wXV
e9FlpvZN53VtYtMv3FM+V1lae2SCCpQykl07tTxdXVUAKmdw0Y4XBi8zPo4XB8HP
9GqGrDoxVId/NqpyR9lXKIEqdZIzoGu8Ku1aPPYMfzEAzNaJhBK/NbSAtAEwnQjh
hwilcrLZtcUJ9MlaQZcBuTsEiHSPvobmqikpmIFTAVM0SfuvhZNSCzxG8Y3qGsyt
CKdx6nm63HirlEFj4AhQeExT8N/sYg==
=H2Cv
-----END PGP SIGNATURE-----

--Sig_/A_7RQbOzLU6cilHr=SxBuq/--
