Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E4583A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiG1IXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiG1IXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:23:11 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7161DBA;
        Thu, 28 Jul 2022 01:23:10 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0FE8A1C0003; Thu, 28 Jul 2022 10:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658996588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXfM02GFzA8ELpnDKlyOIJmK9T5oL5LwlIPHTBNZ798=;
        b=X6lgA01XcFzrlnlOIHT7Y0KehfX6lFvZeL7ylIjA/9bAsKdg5i/1rt3bd3VPh9Uwmk5JT0
        PtI11zG4C2DfgHZQWByy4HJEgtgldNTlTCprskJeeuSAfQpLj3LnkrGX8ArxhY355m6mAw
        0JEA3Eni199N5DLQxMiVLxpPJq6zbUM=
Date:   Thu, 28 Jul 2022 10:23:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <20220728082307.GA15112@duo.ucw.cz>
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
 <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
 <YhXsQdkOpBY2nmFG@B-P7TQMD6M-0146.local>
 <3702afe7-2918-42e7-110b-efa75c0b58e8@opensource.wdc.com>
 <YhbYOeMUv5+U1XdQ@B-P7TQMD6M-0146.local>
 <YqFUc8jhYp5ijS/C@T590>
 <YqFashbvU+v5lGZy@B-P7TQMD6M-0146.local>
 <YqFx2GGACopPmLaM@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <YqFx2GGACopPmLaM@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > If you have actual report, I am happy to take account into it, otherw=
ise not
> > > sure if it is worth of time/effort in thinking/addressing one pure th=
eoretical
> > > concern.
> >=20
> > Hi Ming,
> >=20
> > Thanks for your look & reply.
> >=20
> > That is not a wild guess. That is a basic difference between
> > in-kernel native block-based drivers and user-space block drivers.
>=20
> Please look at my comment, wrt. your pure theoretical concern, userspace
> block driver is same with kernel loop/nbd.
>=20
> Did you see such report on loop & nbd? Can you answer my questions wrt.
> kernel thread B?

Yes, nbd is known to deadlock under high loads. Don't do that.

									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuJHawAKCRAw5/Bqldv6
8gEoAJ9zmwt5woMTM0cAO4S+OR5Z1j5hgQCgmiyqaOqsiNQinTaL5FiPFvKgf78=
=GB7n
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
