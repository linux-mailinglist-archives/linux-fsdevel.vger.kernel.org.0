Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B04AB64A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbfIFKqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:46:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfIFKqg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:46:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AFE9195DD01;
        Fri,  6 Sep 2019 10:46:36 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92B3B5D712;
        Fri,  6 Sep 2019 10:46:30 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:46:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 05/18] Maintain count of in flight requests for
 VQ_REQUEST queue
Message-ID: <20190906104629.GM5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-6-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-6-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 06 Sep 2019 10:46:36 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:46PM -0400, Vivek Goyal wrote:
> As of now we maintain this count only for VQ_HIPRIO. Maintain it for
> VQ_REQUEST as well so that later it can be used to drain VQ_REQUEST
> queue.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOQUACgkQnKSrs4Gr
c8i06Qf/YsXsjq8+oavPjTWaNCzD+gEcjd+8mynWoVujlBAz0pFZFRAmIlq1Jfkx
a0SLeeftv9+xKQOx0U4hGY3m9qOVGA2f6fA+9vTrrJijt3O0QoY5wXN+0n0K0Qae
ewLQnKeKi12oPmQxy2xCjUT8MIW8xS+nx9PE14LN58+SmoyDx/FbWieHqtzAkKDy
ykr8KKp4NHWq/+ybm5n5ht0i++jvbtNk+Do4CXPes4Z0YrK1eH3Jqnlrcsx3TuT/
puv1rBv/9hUQYO/ub4McGshjdSxNlL+BuW0e6LczHlAK2kyFtV0dLbZVJJYdGeC5
mf6GHYgWCJo1e7tdyqx428bbty/Jhw==
=h20v
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--
