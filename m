Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9EAB671
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391415AbfIFKyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391388AbfIFKyz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:54:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E04110A8120;
        Fri,  6 Sep 2019 10:54:55 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB9875D6A9;
        Fri,  6 Sep 2019 10:54:49 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:54:48 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 09/18] virtiofs: Add an helper to start all the queues
Message-ID: <20190906105448.GQ5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-10-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zywvytGCXzdVpkje"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-10-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 06 Sep 2019 10:54:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zywvytGCXzdVpkje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:50PM -0400, Vivek Goyal wrote:
> This just marks are the queues are connected and ready to accept the
> request.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zywvytGCXzdVpkje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOvgACgkQnKSrs4Gr
c8gpQQgAmqp0vUor8BWsHmF4f+In/ZlxHyIx8n3wydsF7FDmfDqnXBAAB1qRRErW
2msRa5bwjkk9CUJdE9qVsrep5CjgqpApmNEGuCREhZcRpS7RFyZJaXbPhRI4ipII
VjAcP0OhH1iVnyy2kWy4EaTdmDAgqjCLZjB3rDKldsYq37sfwAlX0xWyWBwKgRLm
3g0KmiJa8E4aVlG01KfLrGd7+aschTC8Jm5p6XPVE8yN4tFCf0Ax3DbZ6PZen+ah
+BQQSXjYiyszHGT+F0E70ihwnaxZkqtiSOluPk0+db+DAvRC11OgYv54YdGXv6Gf
g2HoRAtGSvMStmfuZfboifUBFXVhyw==
=cHMM
-----END PGP SIGNATURE-----

--zywvytGCXzdVpkje--
