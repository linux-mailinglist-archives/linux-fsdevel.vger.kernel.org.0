Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E27A5AE99A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiIFNax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 09:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiIFNav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCF15813
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662471049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCl6uulMyxrVlr2gxACbm/zfYRoeE0Wcxnn2cAdr1a0=;
        b=Ff+mlRqIJk6gNMi9Hicw8WZODv4/hZFwb5CHa75DS6GMwPlRqErB8sECZYbIZ0y5+V5+Ne
        GAdE/ee5nwZk+lKesZdyhcV1ZT4hv+5MpjoPyFrhjwvS7LJxIuo4pT80MFYeMWAv5O7Fie
        vW4frXd4uvv6iIy7BZ5f5QvQMlfyGlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-jATdod-ZPH2s4yFEqEid-Q-1; Tue, 06 Sep 2022 09:30:46 -0400
X-MC-Unique: jATdod-ZPH2s4yFEqEid-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C750F8039B2;
        Tue,  6 Sep 2022 13:30:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457AE40D296E;
        Tue,  6 Sep 2022 13:30:45 +0000 (UTC)
Date:   Tue, 6 Sep 2022 09:30:43 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     vgoyal@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: Drop unnecessary initialization in
 send_forget_request and virtio_fs_get_tree
Message-ID: <YxdLg8tI9OtVjbfe@fedora>
References: <20220906053848.2503-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S+kjWGQJm00xfWBG"
Content-Disposition: inline
In-Reply-To: <20220906053848.2503-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--S+kjWGQJm00xfWBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 01:38:48AM -0400, Deming Wang wrote:
> The variable is initialized but it is only used after its assignment.
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c..bffe74d44 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -414,7 +414,7 @@ static int send_forget_request(struct virtio_fs_vq *f=
svq,
>  {
>  	struct scatterlist sg;
>  	struct virtqueue *vq;
> -	int ret =3D 0;
> +	int ret;
>  	bool notify;
>  	struct virtio_fs_forget_req *req =3D &forget->req;
> =20

That causes an uninitialized access in the source tree I'm looking at
(c5e4d5e99162ba8025d58a3af7ad103f155d2df7):

  static int send_forget_request(struct virtio_fs_vq *fsvq,
                     struct virtio_fs_forget *forget,
                     bool in_flight)
  {
      struct scatterlist sg;
      struct virtqueue *vq;
      int ret =3D 0;
      ^^^^^^^
      bool notify;
      struct virtio_fs_forget_req *req =3D &forget->req;
 =20
      spin_lock(&fsvq->lock);
      if (!fsvq->connected) {
          if (in_flight)
              dec_in_flight_req(fsvq);
          kfree(forget);
          goto out;
      ...
      out:
      spin_unlock(&fsvq->lock);
      return ret;
             ^^^
  }

What is the purpose of this patch? Is there a compiler warning (if so,
which compiler and version)? Do you have a static analysis tool that
reported this (if yes, then maybe it's broken)?

Stefan

--S+kjWGQJm00xfWBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMXS4MACgkQnKSrs4Gr
c8hAnwgAr+QWzw860ulBE175xxGhGz+svhuLqPnyhkkQWyLQ+SsHglf6wgX8wyJo
3GImaRGa4ntB59O6CORrt1m7YIFLeCAob1b4AooxalOuXeP3st5ryPhMO81RovYL
L3hVXfFQQeDboa2r7KdH8EyT7sJSrzsOpLQpFfDXOrpDfQrdzZPwSRcU4DHr98QW
0ErLih20bpg/tptA1VY8+qfrXJMUYfFZkfcFgWo6F8GLFJGieGKKxEbAzOczz9IS
7mFLUtaRglCb9dDLItuOZwr40Uipgj1jqKx2JweQx2UYdt8hqZ6yRLbbOvxQH3R5
i+axLSVNdiXXrXNKkTGNKETbFwpEfw==
=3X2b
-----END PGP SIGNATURE-----

--S+kjWGQJm00xfWBG--

