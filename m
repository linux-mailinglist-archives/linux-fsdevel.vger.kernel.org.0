Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE574611FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 11:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhK2KZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 05:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236775AbhK2KXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638181203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6SaX+NTgiaFDnrzD5rOQdn6fQZIVXiBx5LgIgNJIdg=;
        b=Vbr5Vf2BhuLvUZVqzUr6aJYtFc8i/CZ528WhkFO5V+U1jpU0lelSxwRmjej6kK+sFwvmld
        /TDWyKCPHsjU1B3u+iXUcadFSoOPSGv5TvcJXZwObXTJolGxoSfhK3lgQv+C+kqF6FS0aW
        AkpR8GJIomzVS3khj1LGIKzeRnjwz7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-Lc5EhORMMfagTkSimab4og-1; Mon, 29 Nov 2021 05:19:59 -0500
X-MC-Unique: Lc5EhORMMfagTkSimab4og-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9340E343CB;
        Mon, 29 Nov 2021 10:19:58 +0000 (UTC)
Received: from localhost (unknown [10.39.195.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69EF960C13;
        Mon, 29 Nov 2021 10:19:52 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:19:51 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
Message-ID: <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z2Ce6dDVMZ60RS5B"
Content-Disposition: inline
In-Reply-To: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Z2Ce6dDVMZ60RS5B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 27, 2021 at 06:13:22PM +0800, Tiezhu Yang wrote:
> No need to generate virtio_fs.o first and then link to virtiofs.o, just
> rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
> in Makefile, also update MAINTAINERS. Additionally, rename the private
> header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
> and f2fs.h in fs/f2fs.

There are two separate changes in this patch (virtio_fs.c -> virtiofs.c
and fuse_i.h -> fuse.h). A patch series with two patches would be easier
to review and cleaner to backport.

I'm happy with renaming virtio_fs.c to virtiofs.c:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Z2Ce6dDVMZ60RS5B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGkqUcACgkQnKSrs4Gr
c8hcDwf9GKHQ6ydDAUWUl6kfFQdbJcYRM28PABP2g94fv4RMNpFyPVMxz6gMQ0pv
eplzXRrlAfIeHUMmw/6LAG6VMygzxo5dApigaKd94inPQbGvdQziO3axf3vKyshe
nk0GSOvwk0adN9LUvJOP4v/zaia6SrH/mTTNLCHRXyq/mnN5wPEImGHR1l4Sr+NM
spQp+XoBrjQEuikwBL9wEg7ZP+Oyy64tC0kzXzQnq4XY+UdVNIyLZ+BvAxJGJxtR
Fup9FzJNPiVRC7Y0Np12bQBa/wv+KAHH/g/GYOKpkHiCbczTCeDZUe+TcQNaJE0t
f+3+ZCQAbio2j/rvXWtoy+WK33we5A==
=GXwS
-----END PGP SIGNATURE-----

--Z2Ce6dDVMZ60RS5B--

