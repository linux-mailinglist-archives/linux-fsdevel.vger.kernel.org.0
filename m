Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53093C9C5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhGOKHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241113AbhGOKHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626343485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jtFaLCASbyDalUPAKMsgKEAlK+8VCaXj/2PuSUEfwWQ=;
        b=cFZco2D3ycYqBCuc/6Har1lXvB/l5pBx03jwFgVGk3VxkEbsqYNNK8F1lAbWqnMUyQJCfp
        HCIp8TRFrN1rzRGjvPITZzgso3zSKsTirSyJH7I2UkhcOK4JO/I6ByIpZCclll4xK3lpRL
        hRjL6UIdc8ev6GzEokZCqrEWnGlyhWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-M4UrhY3kOQScGDb-dHZyJA-1; Thu, 15 Jul 2021 06:04:44 -0400
X-MC-Unique: M4UrhY3kOQScGDb-dHZyJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D7A181CD1C;
        Thu, 15 Jul 2021 10:04:37 +0000 (UTC)
Received: from localhost (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02B2760BF1;
        Thu, 15 Jul 2021 10:04:32 +0000 (UTC)
Date:   Thu, 15 Jul 2021 11:04:31 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, miklos@szeredi.hu
Subject: Re: [PATCH v3 2/3] init: allow mounting arbitrary non-blockdevice
 filesystems as root
Message-ID: <YPAIL1FJk6mzGXBQ@stefanha-x1.localdomain>
References: <20210714202321.59729-1-vgoyal@redhat.com>
 <20210714202321.59729-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="13TCeV9ER/8KiSw9"
Content-Disposition: inline
In-Reply-To: <20210714202321.59729-3-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--13TCeV9ER/8KiSw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 04:23:20PM -0400, Vivek Goyal wrote:
> From: Christoph Hellwig <hch@lst.de>
>=20
> Currently the only non-blockdevice filesystems that can be used as the
> initial root filesystem are NFS and CIFS, which use the magic
> "root=3D/dev/nfs" and "root=3D/dev/cifs" syntax that requires the root
> device file system details to come from filesystem specific kernel
> command line options.
>=20
> Add a little bit of new code that allows to just pass arbitrary
> string mount options to any non-blockdevice filesystems so that it can
> be mounted as the root file system.
>=20
> For example a virtiofs root file system can be mounted using the
> following syntax:
>=20
> "root=3Dmyfs rootfstype=3Dvirtiofs rw"
>=20
> Based on an earlier patch from Vivek Goyal <vgoyal@redhat.com>.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/do_mounts.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--13TCeV9ER/8KiSw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDwCC8ACgkQnKSrs4Gr
c8i4zwgAjAKuIsfOkllAfSxyhcwSXl4730G0xBWSUD/0ctkSnsi441CQf5bOsgVP
4bHyY1VbVzAIaVdBswhnn5fCWvJQrO0QR7objrJ5yeHUHb/jseX4/uIf9f5R6jyf
QZ8EdCZAqalfe51gdGH5CPckI63SCnXGCfo1LblWJvbyO+FJxO6NuzrRksfxm7MR
R3DpOIuSK1utF4FrfWUFor2sld6ivCyKKTTiKSpw6WY4I1NkWLEnMbxrji0aw6sp
huB/FMna/momhYzjxxs6HPHUA7iYZ01uw/b56BPohPnHgh1Ae4Oaci+PevzJg3tN
6p2KY9wjmBInwecZDEpeYJnOokMhsw==
=OvOE
-----END PGP SIGNATURE-----

--13TCeV9ER/8KiSw9--

