Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD2173B31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgB1PSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:18:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57028 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgB1PSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582903125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AxcU6JsvObe5CPeEChlcN5Y9RHe8jXuSK77Ya5A3Kw=;
        b=B9vAZHzoxwswckZXSPMD6REUIo60KwyIL8PLICpN2iE/JZdmu//4dSi2HbzP/4DN6vKAYs
        k9bRriRzW6/q4oBSF4fYCIMoQExUH4nrxKEV/q5XnlKYhS2pqGgk8RxRKPYAFmV2M5tOzm
        3E7Y+9nuMTIGAukY78CYk10SEUMrc7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-vzAgs2cUOuKAm2415svqjg-1; Fri, 28 Feb 2020 10:18:39 -0500
X-MC-Unique: vzAgs2cUOuKAm2415svqjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87158189F766;
        Fri, 28 Feb 2020 15:18:38 +0000 (UTC)
Received: from localhost (unknown [10.36.118.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DED0B5D9CD;
        Fri, 28 Feb 2020 15:18:37 +0000 (UTC)
Date:   Fri, 28 Feb 2020 15:18:36 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: Update stale comment in queue_interrupt()
Message-ID: <20200228151836.GB330319@stefanha-x1.localdomain>
References: <158289211567.437388.9236618474068379496.stgit@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <158289211567.437388.9236618474068379496.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2020 at 03:15:24PM +0300, Kirill Tkhai wrote:
> Fixes: 04ec5af0776e "fuse: export fuse_end_request()"
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ZL0wACgkQnKSrs4Gr
c8hdfwf/RzC3LZA3ryc/0ACwe12ZqWe8GB7U7L9frVA5Dp9iQG61anqWpzs5dBxS
01KBlXAb6FxqV/Y4l/tLu7z8mAucS166gGhISE6sH7OMdeeg4RcZ1kLT8SSo43ME
Ec5k1lNxg3S6+N37xKhQGLGyVIHWdvOs1ZJlIrIuBXGExm/4T9oD0lpPvVey6BCM
9iVcm7ZsraqxR9iDpPriGQRlFzBTEI+m58McRdlW9tb8iUzbrdKyZrbPVAEwauIx
sh+h3UVtUgS2jZi26N+E12Cw54gOzzkFqZXtYwCJPQzKLgUEth2mS5fUgkS7wt/T
d+5QBYc402M2AL0CvcDsyPIXtrezgQ==
=CBkO
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

