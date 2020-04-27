Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F41BA69D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgD0OjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 10:39:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727834AbgD0OjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587998341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I/4WwRZGV4l0PQN7otkYcihvi28ebMJ3k6SVii3+Tcw=;
        b=NYDFPGfdS6nczILdklYOPczhR5bXFAFqGwIiCk6ddsrc62mHv2yTffdVc60V0jh6P+qZUs
        3bEcAVRn43VHiffcd2LzBSZcblxP38Ev/P3E0EERUXdvkvcJc2zusxinE+dkhxa3QyhkeK
        yvmwO0qOi0hJZ89R2F/AbXuwSo3dEtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-nqj8gu48MgmTYWD3aw4Z7w-1; Mon, 27 Apr 2020 10:38:56 -0400
X-MC-Unique: nqj8gu48MgmTYWD3aw4Z7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB00107B265;
        Mon, 27 Apr 2020 14:38:55 +0000 (UTC)
Received: from localhost (ovpn-114-226.ams2.redhat.com [10.36.114.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D50585C1D4;
        Mon, 27 Apr 2020 14:38:51 +0000 (UTC)
Date:   Mon, 27 Apr 2020 15:38:50 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>
Subject: Re: [PATCH 1/2] fuse: virtiofs: Fix nullptr dereference
Message-ID: <20200427143850.GA1042399@stefanha-x1.localdomain>
References: <20200424062540.23679-1-chirantan@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200424062540.23679-1-chirantan@chromium.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2020 at 03:25:39PM +0900, Chirantan Ekbote wrote:
> virtiofs device implementations are allowed to provide more than one
> request queue.  In this case `fsvq->fud` would not be initialized,
> leading to a nullptr dereference later during driver initialization.
>=20
> Make sure that `fsvq->fud` is initialized for all request queues even if
> the driver doesn't use them.
>=20
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
>  fs/fuse/virtio_fs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6m7noACgkQnKSrs4Gr
c8ggGAf/elgVnCuZmIFzajbxqfTtmHhy/O61AV0xEo36kKbsbdFYHsBnOTsXOd/M
d07nBgW4UkQyyf91GJyvOYJC2yPzQvVaCWr/xJ+A0ja1O8LYaA92fgQrM/NPcPLq
q1sV0jFuHl55v5+xtoeJoYDhhLMrAWItR2Wx4D4Oo0WZyjV8ExabbS+phz6DQ4Oj
t86Sgc0n5x76UosfcDZo9OFOTylVh6ceoyqAZsn7t2LbmG8qgyVADCL6KuHdol5M
YJidOq8UNnnrUJ5mRuZ686OLCCWgdv/xynpxZxHgojhZu0S1KkJMqPYE6hnnPMz4
Q/e+0zklnZ4rjnaq6ZFBLlFDuhwUuQ==
=EFET
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

