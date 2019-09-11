Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E11AFC79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfIKMZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 08:25:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfIKMZK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:25:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B8423060399;
        Wed, 11 Sep 2019 12:25:10 +0000 (UTC)
Received: from localhost (ovpn-116-185.ams2.redhat.com [10.36.116.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C55A71001959;
        Wed, 11 Sep 2019 12:25:04 +0000 (UTC)
Date:   Wed, 11 Sep 2019 14:24:58 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
Message-ID: <20190911122458.GA8859@stefanha-x1.localdomain>
References: <20190910151206.4671-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 11 Sep 2019 12:25:10 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 05:12:02PM +0200, Miklos Szeredi wrote:
> Git tree for this version is available here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-=
v5
>=20
> Only post patches that actually add virtiofs (virtiofs-v5-base..virtiofs-=
v5).
>=20
> I've folded the series from Vivek and fixed a couple of TODO comments
> myself.  AFAICS two issues remain that need to be resolved in the short
> term, one way or the other: freeze/restore and full virtqueue.

Thank you!  I am investigating freeze/restore.

Stefan

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1455oACgkQnKSrs4Gr
c8hWrggArzr0OOPSTmdQ2dbddY7tmvuQTZgyaLYh1W0gffJZH8gkHIH2rod4htHq
AWYZ7UxNWmHEdY4JHvMZCuxHMT8NScXWjGrkYbyE9amgj0b7PjtgRMiTJDFp2AMf
pr5rza+XUKxkeoVjdSHMThZEGXWn2PP3zEA/IftMSyL7XEHSVS47NRFTFScGDDwW
HpuWwzul31EFYU6ciPAGbAYPOcvDZCZv51ViJdnCcUMnzP3JMpdYyQy/2pcTauzm
1cvyoMStnkMl3uqTswNRCwRFGU5YVqjnxAWg6Gyqu4TyEa5hp96f97XKcFZRbBjv
LFwvgwMzPdO3dZqn3kBILCi/ZSR6MA==
=TbXq
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
