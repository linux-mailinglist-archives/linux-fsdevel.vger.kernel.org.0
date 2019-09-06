Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4241AB641
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 12:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfIFKoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 06:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfIFKob (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B40D369CC;
        Fri,  6 Sep 2019 10:44:31 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 447CE60605;
        Fri,  6 Sep 2019 10:44:26 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:44:25 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 03/18] virtiofs: Pass fsvq instead of vq as parameter to
 virtio_fs_enqueue_req
Message-ID: <20190906104425.GK5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ee6FjwWxuMujAVRe"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-4-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 06 Sep 2019 10:44:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ee6FjwWxuMujAVRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:44PM -0400, Vivek Goyal wrote:
> Pass fsvq instead of vq as parameter to virtio_fs_enqueue_req(). We will
> retrieve vq from fsvq under spin lock.
>=20
> Later in the patch series we will retrieve vq only if fsvq is still conne=
cted
> other vq might have been cleaned up by device ->remove code and we will
> return error.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ee6FjwWxuMujAVRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yOIgACgkQnKSrs4Gr
c8g+8Qf9HHMGZxy914gG38i6e+DYwvC5CryjFWlCDopWdJemyDaSNvh8UTIgIHGs
swJeFt68ZxTzEW1c/YGufHhbxDlaDhTZEs6lfIvd7I+feMa1Ovwo3fZ4UfqFBiAp
SC12MZ7/8B8wMQ1z9IG2JykyYJqoe2jQLKzr1/bQ2rW/wsh7nK+i14SkbiR560z7
bAM610aHlhhm5IPmbDuKwvui2cwyMRnHsSSWatrM3IvuOoR9fd/5DhqPKoGALSNH
FLI3zz4UiELQl2ln/hAI46cFN5b3zOucaegRvn7+C4msZkccGjAMUshVh3UPpdjK
DLFNt7LWNZp+0euYiznREAKikwyZrA==
=O1h4
-----END PGP SIGNATURE-----

--ee6FjwWxuMujAVRe--
