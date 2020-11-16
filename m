Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6472B4ECD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgKPSDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgKPSDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:03:30 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F6C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 10:03:30 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4CZcPp1w58zQlK6;
        Mon, 16 Nov 2020 19:03:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id 0Q5bsH1rgBPM; Mon, 16 Nov 2020 19:03:22 +0100 (CET)
Date:   Tue, 17 Nov 2020 05:03:14 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Igor Zhbanov <izh1979@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Proposal for the new mount options: no_symlink and no_new_symlink
Message-ID: <20201116180314.5w5xlw7g63i43c3a@yavin.dot.cyphar.com>
References: <CAEUiM9PxZSCuBPSuwkcWxZ2Q-=WFfMU461u2WUnXCw8UBN6x6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gp5zf5xeyxw6wrah"
Content-Disposition: inline
In-Reply-To: <CAEUiM9PxZSCuBPSuwkcWxZ2Q-=WFfMU461u2WUnXCw8UBN6x6w@mail.gmail.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.00 / 15.00 / 15.00
X-Rspamd-Queue-Id: E7A8F171F
X-Rspamd-UID: d4d781
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gp5zf5xeyxw6wrah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-13, Igor Zhbanov <izh1979@gmail.com> wrote:
> I want to implement 2 new mount options: "no_symlink" and "no_new_symlink=
".
> The "nosymlink" option will act like "nodev", i.e. it will ignore all cre=
ated
> symbolic links.

nosymlink has already been implemented (though the name "nosymfollow"
was used to match that corresponding FreeBSD mount option) by Ross
Zwisler and is in Al's tree[1].

> And the option "no_new_symlink" is for more relaxed configuration. It will
> allow to follow already existing symbolic links but forbid to create new.
> It could be useful to remount filesystem after system upgrade with this o=
ption.

This seems less generally useful than nosymfollow and it doesn't really
match any other inode-type-blocking mount options. You could also
implement this using existing facilities (seccomp and AppArmor), so I'm
not sure much is gained by making this a separate mount option.

[1]: https://lkml.kernel.org/lkml/20200827201015.GC1236603@ZenIV.linux.org.=
uk/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gp5zf5xeyxw6wrah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX7K+4AAKCRCdlLljIbnQ
EjlkAP0eatNNn4XX9r3cVz+YZjx1XfgESRgJkqeLpwyoV0GsCwD+KERFK3QsYi4f
eHw+qpJcspTWrwSXyTW/xyw8jK5TSAg=
=vl0c
-----END PGP SIGNATURE-----

--gp5zf5xeyxw6wrah--
