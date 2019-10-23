Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F08E1E36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392196AbfJWObT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 10:31:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389521AbfJWObT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571841078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NEpRmfIMlgMtQvCpBiyWHq35i58wkyDE9q0HwuYCkJw=;
        b=DVIgRYPgETaky0cdhsOeRnas2Spp/oTSN75tt8aVa1bXJykpWFcY3qJkIlWhdkbe/s+27O
        TJWN9MS0v2ojkX0dRR2kuercxzxRWLIRBnxU+JrQz2GEUaqrnwMNbuNW8p6hAv1jMddNr4
        CTt37xMJowpI6/4FeqaoxJaDsxdF+wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-9MNdKUhlPuOEt5UBzneH8A-1; Wed, 23 Oct 2019 10:31:15 -0400
X-MC-Unique: 9MNdKUhlPuOEt5UBzneH8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8EC800D49;
        Wed, 23 Oct 2019 14:31:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73E735DD61;
        Wed, 23 Oct 2019 14:31:13 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:31:12 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, mszeredi@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] virtiofs: remove unused variable 'fc'
Message-ID: <20191023143112.GF9574@stefanha-x1.localdomain>
References: <20191023062130.23068-1-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191023062130.23068-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 02:21:30PM +0800, YueHaibing wrote:
> fs/fuse/virtio_fs.c:983:20: warning:
>  variable fc set but not used [-Wunused-but-set-variable]
>=20
> It is not used since commit 7ee1e2e631db ("virtiofs:
> No need to check fpq->connected state")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wZDAACgkQnKSrs4Gr
c8ia7Af+MQeFLTLG0CFTE1qP7CUS9Bb7d/kyzFLEOhRKzGeQ/X5WF82X/8onbeeS
vWxhG9VDk5YfFMxJs/kCUsOdHyqzSqfU1neF08K+wgu2RsL9LwSvppC+RM68SbUV
+2fh6BaNdKNNtfxRi8Dbw+2xqKLnqlLyhBVCqc7jIAshVMwTeV8GiDAv5WMNWEhQ
8tXKiepCviHSBWHHE0hFQaczmLQQobtgxvJOE6Ooy0Cvd8daN5f3PiCIqpUfRPTx
4ojBtmkZN3Cdc9qHM9cQmqZ/AwdtTuCeTuqd5E096I4Zqm0oq+ZiCBmlt/BSKK+t
sPTRv0L6bdGD6UztBumMJcHOyGplaA==
=Ygrg
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--

