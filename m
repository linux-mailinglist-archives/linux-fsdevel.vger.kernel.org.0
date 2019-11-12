Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B089F8CE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLKd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 05:33:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLKd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573554838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuxahvL3kg1EGPXS8GSuqJmgg7QGAaS4yIWjCAFx7Cc=;
        b=c6VpgHZTX9ZRz1zQrb7z1yy2Y1dsHDNalKBygPFsMq4Qn4dFoXMVZYzcgRWrtXbabxRUrL
        YYnZ7lmDhpJAxsOsau2K9anxRP1VGEcxHUCLcu7shw97eoMCMkkTrwb2VdcnqCDtavJEHv
        DAaUDAMwmQYWptWnrZQhJrgtt00b4iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Y2ODGrCqMRC1KMNK5d05Fw-1; Tue, 12 Nov 2019 05:33:57 -0500
X-MC-Unique: Y2ODGrCqMRC1KMNK5d05Fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15D4F1005500;
        Tue, 12 Nov 2019 10:33:56 +0000 (UTC)
Received: from localhost (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7512F171F9;
        Tue, 12 Nov 2019 10:33:55 +0000 (UTC)
Date:   Tue, 12 Nov 2019 10:33:54 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, mszeredi@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] virtiofs: Fix old-style declaration
Message-ID: <20191112103354.GF463128@stefanha-x1.localdomain>
References: <20191111122359.43624-1-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191111122359.43624-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 08:23:59PM +0800, YueHaibing wrote:
> There expect the 'static' keyword to come first in a
> declaration, and we get warnings like this with "make W=3D1":
>=20
> fs/fuse/virtio_fs.c:687:1: warning: 'static' is not at beginning of decla=
ration [-Wold-style-declaration]
> fs/fuse/virtio_fs.c:692:1: warning: 'static' is not at beginning of decla=
ration [-Wold-style-declaration]
> fs/fuse/virtio_fs.c:1029:1: warning: 'static' is not at beginning of decl=
aration [-Wold-style-declaration]
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3KipIACgkQnKSrs4Gr
c8gdJwf+PUqmtiGDYcD4HiwZZWATLMxXmETqzmnRsTSpcZmilmmFYmNPT9MNuj7D
oPRTSg2Buso6+GYt3HILA0QBHzltRPFpGHFKGFo87AMHUs8Hya8Kn/Ixtlzd2yzk
uetQbToOHQ1BXjNmm8AVmXImi8hr6HVpNGfY08rcbiiw8f5pZeKEiXwLtWc/09Kl
pkOLTnMrheeXEWt8eVMTUfGaUeEeylz3XRUdObm9Oq5hbN1DbERRV3WbNI55a96q
n+X86cFuZP2dvI82+tS5bYl+DcGYkKWrM+kAKJWiwBO9vWTN/5M9UiJmdigSIFux
i47j9PEBMtc87VtbuU9ytoi8EF51MA==
=WtV3
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--

