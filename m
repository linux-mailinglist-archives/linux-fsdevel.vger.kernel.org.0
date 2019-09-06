Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8AAB759
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbfIFLug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 07:50:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfIFLug (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0113F190C106;
        Fri,  6 Sep 2019 11:50:36 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED2A5D9CA;
        Fri,  6 Sep 2019 11:50:27 +0000 (UTC)
Date:   Fri, 6 Sep 2019 12:50:26 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 11/18] virtiofs: stop and drain queues after sending
 DESTROY
Message-ID: <20190906115026.GS5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-12-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6zn93sY2JrH9m7VZ"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-12-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 06 Sep 2019 11:50:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:52PM -0400, Vivek Goyal wrote:
> During virtio_kill_sb() we first stop forget queue and drain it and then
> call fuse_kill_sb_anon(). This will result in sending DESTROY request to
> fuse server. Once finished, stop all the queues and drain one more time
> just to be sure and then free up the devices.
>=20
> Given drain queues will call flush_work() on various workers, remove this
> logic from virtio_free_devs().
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6zn93sY2JrH9m7VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ySAIACgkQnKSrs4Gr
c8hPCggAqxxAtpxUlxuyJ1JMZVearCJpL7Y98Ts25vXNZJKaGv/Z7w+0b1YNHE04
RuXVOEqhwAG5VKOIpPYs+SJwTEwWTgsHEdAgtprbwW+v/vrOlf3LEaC9QS7+Z6bZ
altTVdvWHQiqulsObNYVrgm/alLh75y8skYmwHHAK0EtbLoOwBnwzYNHyuOsH7tk
YdpXmipXCBBtjQrC9rWXSt0ug0xCm29uK/voTea5mrDVFTpTixcKJ2LM6jnT6r4v
mXBtZwegQNYew2LLapEqG+GNE2SSbMD765Z/MFyR48cksq/5mEbCOavSmN8S1HfH
zelxUzsGNaQAsRXvt+wUI8Y94D+aoQ==
=OYfd
-----END PGP SIGNATURE-----

--6zn93sY2JrH9m7VZ--
