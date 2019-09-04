Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CAA89C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfIDPyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 11:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfIDPyc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD3CE302C066;
        Wed,  4 Sep 2019 15:54:31 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8075B60126;
        Wed,  4 Sep 2019 15:54:20 +0000 (UTC)
Date:   Wed, 4 Sep 2019 16:54:19 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190904155419.GB25679@stefanha-x1.localdomain>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
 <CAJfpeguB6fFhghuFS420ZQ+JuQvTLc5TgsGjoB_RvFrSVf+v5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <CAJfpeguB6fFhghuFS420ZQ+JuQvTLc5TgsGjoB_RvFrSVf+v5w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 04 Sep 2019 15:54:32 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 11:17:35AM +0200, Miklos Szeredi wrote:
> On Tue, Sep 3, 2019 at 10:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >  fs/fuse/Kconfig                 |   11 +
> > > >  fs/fuse/Makefile                |    1 +
> > > >  fs/fuse/control.c               |    4 +-
> > > >  fs/fuse/cuse.c                  |    4 +-
> > > >  fs/fuse/dev.c                   |   89 ++-
> > > >  fs/fuse/dir.c                   |   26 +-
> > > >  fs/fuse/file.c                  |   15 +-
> > > >  fs/fuse/fuse_i.h                |  120 +++-
> > > >  fs/fuse/inode.c                 |  203 +++---
> > > >  fs/fuse/virtio_fs.c             | 1061 +++++++++++++++++++++++++++=
++++
> > > >  fs/splice.c                     |    3 +-
> > > >  include/linux/fs.h              |    2 +
> > > >  include/uapi/linux/virtio_fs.h  |   41 ++
> > > >  include/uapi/linux/virtio_ids.h |    1 +
> > > >  init/do_mounts.c                |   10 +
> > > >  15 files changed, 1462 insertions(+), 129 deletions(-)
> > > >  create mode 100644 fs/fuse/virtio_fs.c
> > > >  create mode 100644 include/uapi/linux/virtio_fs.h
> >
> > Don't the new files need a MAINTAINERS entry?
> > I think we want virtualization@lists.linux-foundation.org to be
> > copied.
>=20
> Yep.
>=20
> Stefan, do you want to formally maintain this file?

Vivek has been doing most of the kernel work lately and I would suggest
that he acts as maintainer.

But I'm happy to be added if you want two people or if Vivek is
unwilling.

Stefan

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1v3isACgkQnKSrs4Gr
c8i3IwgAkPNsvQFn07eQEq84FvAQliEAhVlQPhZtCsVbch+9uZMEFLknwvu44nDV
4jl49BomGl8bnL2zO9Fw3v8TDw2mcmvzIwGrb3r+TF1fX/Hdgt6I/GLk9sGX6Pnx
zaCOEFRPRWzo/wC//ljow5suXYiIhGkE9JrxRrTjgxSPbYIKTnoMxIJmXvsa/JWl
pnWGDMmMMH5ZucxT8iXJozyGqo/KKM04NtKxREt+Qdt1VvVvB92eevZ0uFiA/iah
ZlVDb+uBVx1t8hbXOOeb85HSUqL/qCQdm0e7FzBxhIg/dIGQgKqQb8Vw5cjEJu/i
Lb/NaWqBPfAHYb4ZRwHMznYrZBDaKQ==
=9DaP
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
