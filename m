Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C535D3D12BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhGUPGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 11:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233168AbhGUPGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626882399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFs1/q4yY+GbvN10NaZ8rmyNV7qGajpsnDrARGRqfDc=;
        b=KDmc43Dr2kcWt1Lx7DFIE45SqQuSznYMouex83X9H2UY3iPFdO0dfodNwYAe5jsP9CEGj5
        0wHetVCvLMRxDdrTA6GEP/UlfuaYzu+N6JYjBP7+dJWityOhDLPaH9tiTW2z983etAk5YG
        kOsah78NGq2aLoc9XdIbZuhU1bxnMAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-nA6MEcdWN_m4GF-QEAgocA-1; Wed, 21 Jul 2021 11:46:35 -0400
X-MC-Unique: nA6MEcdWN_m4GF-QEAgocA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742461009E2D;
        Wed, 21 Jul 2021 15:46:34 +0000 (UTC)
Received: from localhost (ovpn-114-233.ams2.redhat.com [10.36.114.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3B37781E6;
        Wed, 21 Jul 2021 15:46:29 +0000 (UTC)
Date:   Wed, 21 Jul 2021 16:46:28 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, miklos@szeredi.hu
Subject: Re: [PATCH v3 3/3] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <YPhBVNvubLmPyS4o@stefanha-x1.localdomain>
References: <20210714202321.59729-1-vgoyal@redhat.com>
 <20210714202321.59729-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x9hm3usq3SofuOqJ"
Content-Disposition: inline
In-Reply-To: <20210714202321.59729-4-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--x9hm3usq3SofuOqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 04:23:21PM -0400, Vivek Goyal wrote:
> From: Christoph Hellwig <hch@lst.de>
>=20
> Just output the '\0' separate list of supported file systems for block
> devices directly rather than going through a pointless round of string
> manipulation.
>=20
> Based on an earlier patch from Al Viro <viro@zeniv.linux.org.uk>.
>=20
> Vivek:
> Modified list_bdev_fs_names() and split_fs_names() to return number of
> null terminted strings to caller. Callers now use that information to
> loop through all the strings instead of relying on one extra null char
> being present at the end.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/filesystems.c   | 27 +++++++++++++++----------
>  include/linux/fs.h |  2 +-
>  init/do_mounts.c   | 49 ++++++++++++++++++++--------------------------
>  3 files changed, 39 insertions(+), 39 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x9hm3usq3SofuOqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD4QVQACgkQnKSrs4Gr
c8j6+wf/eCIyLjfPbaC2bDpUsd1HX+xCEm2IM/YdGOrDpW+yfjV9l8Kn7JVEN5S5
Um28SMkN3Cz4S72hwcjCCfZ652Aq81+vzDpEo83525nrnyroPwhZVBGwYh5+dH99
/8DEa2OQKRlMuq2PjxC9vGu5tIURKt6Z0LkzdeDfWyHFpHD0ygkIzKwYWVFvmyvY
a3NYpNs6wguRyrXPa6+CCPZNaxnNx6p/XXzH/3dl8BjhM903pwO1l7J++hE0+Uq6
s+HasCIofJS2GiPkgoRlMXKhDt816VCPVH9azrOHbaxc2hgTo0Z7yiXwjjq3sEhy
ZFeQhqUc/90PNjzTp4tXHS7ruEbJWw==
=NMQh
-----END PGP SIGNATURE-----

--x9hm3usq3SofuOqJ--

