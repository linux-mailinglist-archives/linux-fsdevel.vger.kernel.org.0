Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1329AE1E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392171AbfJWOdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 10:33:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22343 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389995AbfJWOdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571841188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WspxuSJb6do4aql0hVCXNdvv2fcuucGIVT4sybM8WcI=;
        b=eLj1uog1kPgbQigoyvJsET9ZmqccC+GmCI+zJaPJSS7ENiwANJb4TIaSFIuoS2eGFQKqDS
        lmGL2Hs6PVWiDtGZblZU4t9M1c5n6a+9z8eo8AHsDNdLxDC8sN+ytUnpmweEfxDbRiduCU
        fKmXU4Bpur9uggTEiT4Kc3wRhxX4mXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-VGJTPuWKPrW8OOCHpdup5w-1; Wed, 23 Oct 2019 10:33:05 -0400
X-MC-Unique: VGJTPuWKPrW8OOCHpdup5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137EA5E6;
        Wed, 23 Oct 2019 14:33:03 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ABA360166;
        Wed, 23 Oct 2019 14:33:02 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:33:01 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     vgoyal@redhat.com, mszeredi@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: Remove set but not used variable 'fc'
Message-ID: <20191023143301.GG9574@stefanha-x1.localdomain>
References: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 10:02:49AM +0800, zhengbin wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> fs/fuse/virtio_fs.c: In function virtio_fs_wake_pending_and_unlock:
> fs/fuse/virtio_fs.c:983:20: warning: variable fc set but not used [-Wunus=
ed-but-set-variable]
>=20
> It is not used since commit 7ee1e2e631db ("virtiofs:
> No need to check fpq->connected state")
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Only affects the linux-next tree, not virtio-fs-dev or linux.git/master.
Same as "[PATCH -next] virtiofs: remove unused variable 'fc'"
(<20191023062130.23068-1-yuehaibing@huawei.com>).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wZJ0ACgkQnKSrs4Gr
c8jhWggAplRLEXTbMxEBBB5hAMuW2PcDsqSSuI5e+v70h1j8C/mzw4Z/QC3H/WQm
0IVc8kYWZQekjSx3t8oFsLOmiRLJ64wDG5ZimbbMt0GqE/IOkadGGEd45tGZIXMm
YHlvjfEROOsT5W+G0oGwnAfqEqgUiQ2dNvpYpvJqYGF1tSGyjqunT4uyFrywtG9W
2fPGZkaZTAJTOl5p2dm31bep4QUc5NmsovkfB8wCXk9PcunV9OlGrzJTZoWMKvJE
NeHQSl3L83M2TmdrU3r+1lu7ns9lyxkPa55V8JP77mtwbCARgzdwmhpih2vjRvIa
laHxW2WsAK11RTb3twS9EJhqWSDGAw==
=RixM
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--

