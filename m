Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA77BB61D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfIRKvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 06:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfIRKvf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:51:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF413811BF;
        Wed, 18 Sep 2019 10:51:35 +0000 (UTC)
Received: from localhost (unknown [10.36.118.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C68AE1001B23;
        Wed, 18 Sep 2019 10:51:30 +0000 (UTC)
Date:   Wed, 18 Sep 2019 11:51:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs@redhat.com, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] init/do_mounts.c: add virtiofs root fs
 support
Message-ID: <20190918105129.GJ26027@stefanha-x1.localdomain>
References: <20190906100324.8492-1-stefanha@redhat.com>
 <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
 <20190909070039.GB13708@stefanha-x1.localdomain>
 <CAFLxGvw51qeifCLwhV-8DKXNwC9=_5hFf==e7h4YCvFE5_Wz0A@mail.gmail.com>
 <20190917183029.GH1131@ZenIV.linux.org.uk>
 <20190917183425.GJ3370@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
In-Reply-To: <20190917183425.GJ3370@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 18 Sep 2019 10:51:35 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 07:34:25PM +0100, Dr. David Alan Gilbert wrote:
> * Al Viro (viro@zeniv.linux.org.uk) wrote:
> > On Tue, Sep 17, 2019 at 08:19:55PM +0200, Richard Weinberger wrote:
> >=20
> > > mtd, ubi, virtiofs and 9p have one thing in common, they are not bloc=
k devices.
> > > What about a new miscroot=3D kernel parameter?
> >=20
> > How about something like xfs!sda5 or nfs!foo.local.net/bar, etc.?  With
> > ubi et.al. covered by the same syntax...
>=20
> Would Stefan's patch work if there was just a way to test for non-block
> based fileystsmes and we replaced
>    !strcmp(root_fs_names, "virtiofs") by
>    not_block_based_fs(root_fs_names)
>=20
> Or is there some magic that the other filesystems do that's specific?

I will try this.

Stefan

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2CDDEACgkQnKSrs4Gr
c8gs/AgAv9VxZl8i2gfmfS0gmpYs3LWPWLMmUPTkehj4ThQGdXOQj4pv/tbqZ/MV
a/AM6mwKmhrD6ZNVrIj2Ft1Z5bURwCC/r6JoueOr5t2i0FGIyHYK3sbHJ2+8cg79
cmNXlnR7Dn1IsXITjDFJzovpQrN0bywWc3Leqga04+kDF3FlsvS8NMXYoiV8425o
ifbYwd/1fwqo17UARQzQuu5oYYX0F/X3AA5GQiqu3C1pXLYexDGHtj9aE1olfP5d
ayKOLZUB7DWkZuBPITpV3QgqSx4ONqntSJURE7eJzyYntSdqQlyIWG84lfFWJi60
+lmR36W6ZCROlGcY6Mk+1OskuOGsjg==
=6PWm
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
