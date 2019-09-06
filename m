Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE494AB64F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfIFKrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:47:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfIFKrP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10F2D307D88D;
        Fri,  6 Sep 2019 10:47:15 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE1A60BF1;
        Fri,  6 Sep 2019 10:47:09 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:47:08 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 06/18] virtiofs: ->remove should not clean virtiofs fuse
 devices
Message-ID: <20190906104708.GN5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-7-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-7-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 10:47:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:47PM -0400, Vivek Goyal wrote:
> We maintain a fuse device per virt queue. This fuse devices are allocated
> and installed during mount time and should be cleaned up when super block
> is going away. Device removal should not clean it. Device removal should
> stop queues and virtuques can go away.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOSwACgkQnKSrs4Gr
c8h6Qwf/WpO4mnEca0Q5mo2lnzp1LNn53yJFIz8baldN1jOcw33zkeKDoJ8jQ4ij
1MbNgXpZWvKRM3ne2pDWOTfgU+JfCLruMSB7cgawvizBo2wsehRoCQ7Y+rEFrPhT
QkfKngAlQfkxdMH0s3efds0D/ra9rWftywFg4BxtNrwWwq85JA5bA6IulJBeydlL
kYibfDTxusBufOj57M6CzGNkcrhbBbGoGp29/WKGDTJPYr10IOINpG1VLMRalyyY
DR1y94cFvWz3qNz1CduPxLeBXjCfAjd9u9RNV+U/JnsmVDm6+csXA70wr7tmPjEY
mc+3IOwSwASzAjknAwn7k4QHKwpUmA==
=TIQ2
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--
