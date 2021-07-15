Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3343C9C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhGOKHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231149AbhGOKH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626343476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/qLm57mbPWrZeJcdrgHK0l6gj+db50iQeEDK6SvJPI=;
        b=ceZpgh3Btge8Efd81/53GAqF0MbVu8l7ZzmhMUMAO4CYUyapaavg5QcYVbT8uriIQDv+6k
        Z4/FWrNBWy07AOiItxOb7/lA95xRUJPpg7aNQHOKjB4TKjIJIKZEj92pnjz0z2gD6p4/ko
        Um/TdCDv6/AW9Y9+UzMmAPoo4NWjQEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-zMuebjl5ObivlDZPLqUA_A-1; Thu, 15 Jul 2021 06:04:32 -0400
X-MC-Unique: zMuebjl5ObivlDZPLqUA_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC9910AEF98;
        Thu, 15 Jul 2021 10:04:29 +0000 (UTC)
Received: from localhost (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10AFB2C00F;
        Thu, 15 Jul 2021 10:04:27 +0000 (UTC)
Date:   Thu, 15 Jul 2021 11:04:27 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, miklos@szeredi.hu
Subject: Re: [PATCH v3 1/3] init: split get_fs_names
Message-ID: <YPAIK9wfhk7V6Xi9@stefanha-x1.localdomain>
References: <20210714202321.59729-1-vgoyal@redhat.com>
 <20210714202321.59729-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JuHm8BGS67qlvg5y"
Content-Disposition: inline
In-Reply-To: <20210714202321.59729-2-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--JuHm8BGS67qlvg5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 04:23:19PM -0400, Vivek Goyal wrote:
> From: Christoph Hellwig <hch@lst.de>
>=20
> Split get_fs_names into one function that splits up the command line
> argument, and one that gets the list of all registered file systems.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/do_mounts.c | 48 ++++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JuHm8BGS67qlvg5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDwCCsACgkQnKSrs4Gr
c8hXjwgAnj/tXk8SQSwMuw8hoXxqRU6EXvbwTvctsNlGAIONbV1sIb3Bn9/QZp6W
qeaiRi1GFk8aM5sMnlW+F+wRCsmW18Qhq3Umr9NcAVqjmbriRWTQ5lt8Z+/m8WQl
mawAlrsHrCX2gu+HjWRp+najwQ/VDUXCwAuX76rWtx6Mn1BBtLywe02oZwDEAGOg
+/r7MnZ18FeFtAd3qntCjBrLwgdFaTCwe8MCC1rpVwSqGaxTRGMiwSG+MOV1MKDv
fLdONf5m00nxtjArJIEh3deMWm/T5dKBLnHaMCuXz8QOhfXdYvy7IweX3nSfqIJJ
2iV6nJTNeOMTAJ4IEJyp5fNL36qc9Q==
=h3T0
-----END PGP SIGNATURE-----

--JuHm8BGS67qlvg5y--

