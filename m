Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387C2AB615
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfIFKgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:36:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfIFKgT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:36:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AB56308A958;
        Fri,  6 Sep 2019 10:36:19 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A5460605;
        Fri,  6 Sep 2019 10:36:13 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:36:13 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906103613.GH5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
In-Reply-To: <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 06 Sep 2019 10:36:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi,
> >
> > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > items and races w.r.t device removal.
> >
> > In this first round of cleanups, I have taken care of most pressing
> > issues.
> >
> > These patches apply on top of following.
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiof=
s-v4
> >
> > I have tested these patches with mount/umount and device removal using
> > qemu monitor. For example.
>=20
> Is device removal mandatory?  Can't this be made a non-removable
> device?  Is there a good reason why removing the virtio-fs device
> makes sense?

Hot plugging and unplugging virtio PCI adapters is common.  I'd very
much like removal to work from the beginning.

Stefan

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yNpwACgkQnKSrs4Gr
c8hY9AgAmU3k7f2gZ5ko9Rvr8+tXDTSrw1Uakzbgk+pEb54Z2M4jFGJgWglMNfqa
4PI0iDsPz1ikbT9wOhko7AGyaeX1/EQqmXWdBGgCjXVBekhLsOR4dOl/y6Q/1eW1
fEQ5B/Ngl1Z5AbMZ5xwlYA89Iq4yZCVn8IbyhkreLZ8KHzMc6CnQkNEM8goE1HgO
oSiD15lf3RiiwQlYbBabMOc3nOlIqebZKyk2oizbPfQLC9/afkmPcPv+sZfTMMwW
LXa6ZV7ZHxi6sgQSPaN/yh9Ve+2NvMcyPPYyAZFduruK5C/Rkx+Er/uzXgPDQ4j3
57uYA27caA6arIq+CUvclGvmk2+ajA==
=Llfc
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
