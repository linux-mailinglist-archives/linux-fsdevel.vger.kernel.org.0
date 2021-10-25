Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26E439334
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhJYKAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 06:00:41 -0400
Received: from artemis.server.nucleus.it ([51.89.16.243]:59359 "EHLO
        artemis.server.nucleus.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhJYKAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 06:00:41 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 06:00:40 EDT
Received: by artemis.server.nucleus.it (Postfix, from userid 257)
        id 09FA51A435F; Mon, 25 Oct 2021 11:50:23 +0200 (CEST)
X-Nucleus-Antivirus-policy: No
X-Nucleus-Antispam-policy:  No
X-Nucleus-IsRelay:         F
X-Nucleus-SourceIP:        151.44.60.102
X-Nucleus-Id:              8C06F1A4364
X-Nucleus-From:            marco@nucleus.it
X-Nucleus-Date:            2021-10-25 11:50:23 CEST
X-Nucleus-IsFetchMail:     F
Received: from lobo.localdomain (unknown [151.44.60.102])
        by artemis.server.nucleus.it (Postfix) with ESMTPA id 8C06F1A4364;
        Mon, 25 Oct 2021 11:50:23 +0200 (CEST)
Received: from lobo.lobo.dom (lobo.lobo.dom [127.0.0.1])
        by lobo.localdomain (Postfix) with ESMTP id EF22C762BA5;
        Mon, 25 Oct 2021 11:50:22 +0200 (CEST)
Date:   Mon, 25 Oct 2021 11:50:18 +0200
From:   Marco Felettigh <marco@nucleus.it>
To:     linux-fsdevel@vger.kernel.org
Cc:     agruenba@redhat.com
Subject: reiserfs mounted with acl and cp wrong permissions
Message-ID: <20211025115018.2873610c@lobo.lobo.dom>
Organization: Nucleus s.r.l.
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KqB1+tl7BsFISEDa5LM.HRl";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/KqB1+tl7BsFISEDa5LM.HRl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,
we have a problem with reiserfs 3.6 and cp permissions inconsistency
with a mount point mounted with user_xattr,acl.

I opened a bug on the Kernel Bugzilla, reiserfs section, some time ago:
https://bugzilla.kernel.org/show_bug.cgi?id=3D207971

but till now, no one answered.
I have also written into the reiserfs mailing list but no one answered
too.

I also tested on new kernels 5.14.10 and 5.15-rc4 but the problem
persists.

If you can take some time to investigate on this bug i would appreciate
it.

Thanks for the support and have a good day.

Marco Felettigh

--Sig_/KqB1+tl7BsFISEDa5LM.HRl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRgs4moDz/kAc8JPxco+KAxdHlzYQUCYXZ92gAKCRAo+KAxdHlz
YUK7AJ9N3AKu7sSRLr9NTPywzlVxKizlOgCfd2qxeDjGkq3Jupr4CNagurbSFsw=
=fElo
-----END PGP SIGNATURE-----

--Sig_/KqB1+tl7BsFISEDa5LM.HRl--
