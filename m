Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0583597FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHUQF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 12:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfHUQF5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CDD1A2E0E8;
        Wed, 21 Aug 2019 16:05:57 +0000 (UTC)
Received: from localhost (ovpn-117-144.ams2.redhat.com [10.36.117.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C51325C221;
        Wed, 21 Aug 2019 16:05:52 +0000 (UTC)
Date:   Wed, 21 Aug 2019 17:05:51 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     wangyan <wangyan122@huawei.com>, linux-fsdevel@vger.kernel.org,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
Message-ID: <20190821160551.GD9095@stefanha-x1.localdomain>
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
 <20190820091650.GE9855@stefanha-x1.localdomain>
 <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 16:05:57 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 09:51:20AM +0200, Miklos Szeredi wrote:
> On Tue, Aug 20, 2019 at 11:16 AM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >
> > On Thu, Aug 15, 2019 at 08:30:43AM +0800, wangyan wrote:
> > > Hi all,
> > >
> > > I met a performance problem when I tested buffer write compared with =
9p.
> >
> > CCing Miklos, FUSE maintainer, since this is mostly a FUSE file system
> > writeback question.
>=20
> This is expected.   FUSE contains lots of complexity in the buffered
> write path related to preventing DoS caused by the userspace server.
>=20
> This added complexity, which causes the performance issue, could be
> disabled in virtio-fs, since the server lives on a different kernel
> than the filesystem.
>=20
> I'll do a patch..

Great, thanks!  Maybe wangyan can try your patch to see how the numbers
compare to 9P.

Stefan

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1da98ACgkQnKSrs4Gr
c8gFfggAyRL0QCaPyX1cmqi2FhRh2CeRCsiRY/htPGdMIsiAj/nnnw6LbyGXJuLn
I3SbKbto+tCFF5/I0Vvgm+9GxNuVvWTw7aRMH7G8HHHqM/gg+KJgtjdBTXizNqHK
l+tQxEEGIqqQ2k41QyUd49PDJ+7uL/KZEPUjS2zh/XYXUPpcyuP1Sdtkvi9Pd05q
WPMIXrUaC4enEM1+ucHp2guIJMILo1+D+uSUtCdquoywkK/xlQWrgTzu4/VYhj+D
/OvB951mJSr4BC9DXafuBoGzcJatO3vW5xN6I9Mqh8YOFg0CVQOM4JGzFKfIjKDw
rzKWye90d/We2s63UHvmiQMyfRxDzQ==
=wydV
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
