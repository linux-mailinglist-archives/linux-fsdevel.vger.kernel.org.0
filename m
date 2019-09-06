Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C2AB630
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbfIFKke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfIFKkd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BB7285363;
        Fri,  6 Sep 2019 10:40:33 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B74D19C70;
        Fri,  6 Sep 2019 10:40:25 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:40:24 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 01/18] virtiofs: Remove request from processing list
 before calling end
Message-ID: <20190906104024.GI5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UthUFkbMtH2ceUK2"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-2-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 06 Sep 2019 10:40:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--UthUFkbMtH2ceUK2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:42PM -0400, Vivek Goyal wrote:
> In error path we are calling fuse_request_end() but we need to clear
> FR_SENT bit as well as remove request from processing queue. Otherwise
> fuse_request_end() triggers a warning as well as other issues show up.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UthUFkbMtH2ceUK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yN5gACgkQnKSrs4Gr
c8iH2Qf9FDlsSyo3aEDCwVuW5ufQrOhFl5xJgIrwu9zF7Q8xWoHeRxDRnuXqrpy0
IBO3sm8mijVdTypCJ8zrFIER28OnXnmNmRuZFPxmlDoSf1/G74BAX7qaLH8NTikF
CwJC4TUljhUvvGNKo9/jRu6qVKNcNxz8BXmxjIGBSWWGu90lmDwarFxX6arkWn+x
N8E6/S9dUi6f6jiEy0k0zNUUZ+i4bXhM3SsGXaNuoI/GzZQUG8016CUbYKDSxRxo
ov0FV+U9gy9GEDbuhy5LI5DrlYOzlpSe8OiNiw031NIlcrGmty1o75Dw4j0Bxzwr
zMlTa2f77G2tmrCucSRxbNT2u2u6xw==
=1d2m
-----END PGP SIGNATURE-----

--UthUFkbMtH2ceUK2--
