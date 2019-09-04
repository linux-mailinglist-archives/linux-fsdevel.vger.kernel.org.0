Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34F3A921B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfIDSxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 14:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387735AbfIDSxd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:53:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8746B3090FCB;
        Wed,  4 Sep 2019 18:53:33 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0549360606;
        Wed,  4 Sep 2019 18:53:30 +0000 (UTC)
Date:   Wed, 4 Sep 2019 19:53:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, dgilbert@redhat.com
Subject: Re: [PATCH] fuse: reserve byteswapped init opcodes
Message-ID: <20190904185329.GL26826@stefanha-x1.localdomain>
References: <20190904123607.10048-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
In-Reply-To: <20190904123607.10048-1-mst@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 04 Sep 2019 18:53:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 08:36:33AM -0400, Michael S. Tsirkin wrote:
> virtio fs tunnels fuse over a virtio channel.  One issue is two sides
> might be speaking different endian-ness. To detects this,
> host side looks at the opcode value in the FUSE_INIT command.
> Works fine at the moment but might fail if a future version
> of fuse will use such an opcode for initialization.
> Let's reserve this opcode so we remember and don't do this.
>=20
> Same for CUSE_INIT.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/fuse.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wCCkACgkQnKSrs4Gr
c8ijOwf/TfmXEH7y7DsbNFNZ+jXaptreL15KyqzuTg6R2p5OldQtcWF2FkfZMCtZ
xxZrgwviXYe/olroFiF0VOZ4WBbiT6oMzQUeJWL05eW9PGQ0mJlniW8uhTf1nzJi
nsA1y+ORww/XKChOBu+q5pEjOKIPi/Apmu2myj2z1NCSZN9S4m6XKyvmWLgWoC6Y
Wc6dkJ/bVePoe60d34Dnp48nt2lmNCBRKEbgSfg01243vlaHZyVTRbmHJ55hqCcb
+vRrItDTsRKPhthy/PPEzsukjrw/MMupQgv4nPLhZ3vuu15eyi3zgQR+CEECZGXn
hssUHNtElEJ8S6YhDbyyMRTlQssKEg==
=y6tM
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
