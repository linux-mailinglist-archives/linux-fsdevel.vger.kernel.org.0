Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56527AB656
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbfIFKrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731211AbfIFKrp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F045D3086218;
        Fri,  6 Sep 2019 10:47:44 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63DDE19C70;
        Fri,  6 Sep 2019 10:47:39 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:47:38 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 07/18] virtiofs: Stop virtiofs queues when device is
 being removed
Message-ID: <20190906104738.GO5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-8-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-8-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 06 Sep 2019 10:47:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:48PM -0400, Vivek Goyal wrote:
> Stop all the virt queues when device is going away. This will ensure that
> no new requests are submitted to virtqueue and and request will end with
> error -ENOTCONN.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOUoACgkQnKSrs4Gr
c8hIyQf/VEB8Z1kkLZJY07A6TpGDbf4zwdPwITwfIrZm8CV5Muj+9w7GN5o9QylC
HcWecFIGEfC3JXeQdRnq/5rLiAhKXgFkAXo9qkS7uVwLSR1YS+iutJksY2M0V6z0
sYo8cHSn4X5umbDMrnvlasCdLLAj3IKtaBmHYr8Cm9kOBMLl+H/n77Pvdr36qsoK
BUNaNZtkGMFtKf+n7nJA1BXi/h+G3RhB6o1hyzdTF0VPLm0muWZda5jgc2cXTHnf
gQBGQiO/TqCt3bwqiS/fJLIW38/XcDy683UCXkEJiaXcLwX0LgwfHM1zPAVHyx/v
plygJH26nFKCsOQ2j9GueL6YA3uB2g==
=VU0e
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--
