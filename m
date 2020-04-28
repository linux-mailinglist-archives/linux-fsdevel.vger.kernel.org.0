Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9001BC224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgD1O75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 10:59:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23860 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727775AbgD1O75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588085995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMizUADMCnyh9k9hBQ8WVZCKsAA9nQtAjD9VxsSB1r8=;
        b=Z4RJE6/LF+mYna/xOCY2OzwnG+FX7WeDvMLpXdc1H0gKhtJx4UFF2SxMSYSjf3nATng8fJ
        pNQFZtKTf6TDeTOnYMNzAKKrqvluNvJRcp+EF5jNsvK+IERWysk2nSHuzb8HyvKAnXibX1
        RrvDiPIhWGeb1OxKGq1rbQDpNV7K+4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-yYIiLCOOMcKbwL749-RV-g-1; Tue, 28 Apr 2020 10:59:47 -0400
X-MC-Unique: yYIiLCOOMcKbwL749-RV-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF091009456;
        Tue, 28 Apr 2020 14:59:42 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B097E5C220;
        Tue, 28 Apr 2020 14:59:41 +0000 (UTC)
Date:   Tue, 28 Apr 2020 15:59:40 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Chirantan Ekbote <chirantan@chromium.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH] fuse, virtiofs: Do not alloc/install fuse device in
 fuse_fill_super_common()
Message-ID: <20200428145940.GC107541@stefanha-x1.localdomain>
References: <20200427180354.GD146096@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200427180354.GD146096@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2020 at 02:03:54PM -0400, Vivek Goyal wrote:
> As of now fuse_fill_super_common() allocates and installs one fuse device=
.
> Filesystems like virtiofs can have more than one filesystem queues and
> can have one fuse device per queue. Given, fuse_fill_super_common() only
> handles one device, virtiofs allocates and installes fuse devices for
> all queues except one.
>=20
> This makes logic little twisted and hard to understand. It probably
> is better to not do any device allocation/installation in
> fuse_fill_super_common() and let caller take care of it instead.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/fuse_i.h    |  3 ---
>  fs/fuse/inode.c     | 19 ++++++++++++-------
>  fs/fuse/virtio_fs.c |  9 +--------
>  3 files changed, 13 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6oRNwACgkQnKSrs4Gr
c8jeIgf/UuU/ixsyG5uelRBuxqqN9HbXJ6wwScvS222NvMKxWlFHWR8FgP28UGrV
ltKC2lNF3C+Yab5WrZ7au+a4hZEab5iYMVaAvT5Gxt5LK0XYnjK7xQrk+LsAcPWZ
bK/gZV+aaJZ7OtcgFLZDOC4hEs2sEenDS2bfE8zofC8vEItDzWp4FKtB9nCAtWRj
qn+m5kSFNXr4xz6ygbPJXaV3RdOw8CQh6UqRubtoL3aFzgCfIBIMDrmKCWpLt5Sz
FmjTUF1kYfL6lY5WFXiLAhTnV09gBav5S9GMdFmDQ7CFihc3/eAelITbS7YWc+tS
qlqHeaSsjvPgz1NhB+3jE9cUwYvw/A==
=8lPr
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

