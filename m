Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A4464B85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 11:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348623AbhLAK1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 05:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232177AbhLAK1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638354236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0DFN0o7BK0vC4lSvVBvOKD7kQ9DIA3svi19e9Yt8yE=;
        b=DXrFvIfKm4/HdTNQkOGnRIOpCfCGLOnYgHd6GHDBAxBXkDIJgcN9j7LYmsOiyM29d8Vmrb
        N+DAJbSNFycP2G4ZIo4MYnsT/f9PET+693VQ/K9FTUw+GcxgQifhZDqN0Jog3CmseXAWAi
        Jq/YyBaNWaBxaCgVIKlN2WC88PkEnyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-m7gWlmizPt6BFyeOjzMlww-1; Wed, 01 Dec 2021 05:23:53 -0500
X-MC-Unique: m7gWlmizPt6BFyeOjzMlww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F55310144E1;
        Wed,  1 Dec 2021 10:23:51 +0000 (UTC)
Received: from localhost (unknown [10.39.195.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7796960C05;
        Wed,  1 Dec 2021 10:23:45 +0000 (UTC)
Date:   Wed, 1 Dec 2021 10:23:44 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
Message-ID: <YadNMH15rjrOHzUt@stefanha-x1.localdomain>
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
 <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
 <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cnKZjUtuNVB1GrhC"
Content-Disposition: inline
In-Reply-To: <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cnKZjUtuNVB1GrhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 29, 2021 at 09:27:17PM +0800, Tiezhu Yang wrote:
> On 11/29/2021 06:19 PM, Stefan Hajnoczi wrote:
> > On Sat, Nov 27, 2021 at 06:13:22PM +0800, Tiezhu Yang wrote:
> > > No need to generate virtio_fs.o first and then link to virtiofs.o, ju=
st
> > > rename virtio_fs.c to virtiofs.c and remove "virtiofs-y :=3D virtio_f=
s.o"
> > > in Makefile, also update MAINTAINERS. Additionally, rename the private
> > > header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/x=
fs
> > > and f2fs.h in fs/f2fs.
> >=20
> > There are two separate changes in this patch (virtio_fs.c -> virtiofs.c
> > and fuse_i.h -> fuse.h). A patch series with two patches would be easier
> > to review and cleaner to backport.
> >=20
> > I'm happy with renaming virtio_fs.c to virtiofs.c:
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
>=20
> Hi Stefan and Miklos,
>=20
> Thanks for your reply, what should I do now?
>=20
> (1) split this patch into two separate patches to send v3;
> (2) just ignore this patch because
> "This will make backport of bugfixes harder for no good reason."
> said by Miklos.

Miklos' point makes sense to me and he is the FUSE maintainer.

Stefan

--cnKZjUtuNVB1GrhC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGnTTAACgkQnKSrs4Gr
c8gonQf+OzY/cnbKn1ZoDeOvkjZe6Iu2Zwc31jjntY6hvhXceq7whiSMHsKPV9Ft
Vwx8avw6yQ6wWb7eVa4p0roX03f71/XRMNbET0n/wUslF6EPBKQ5F0XbuY8WTGoa
TKv+3X8BeFib3wqgdShIjy8wyYbo52XDPuq7OSZ6QYjvxbfe0NsxCbV+ZPrLNCKg
fx0gD1Nj/DSeWN7hZeJRM+odczWfLgPTDz0/jaRzZTH4VcmEETskjQ636/goCWxC
nu09wNjMrt+6SsyB9s98z7bYPqgWvvfFcJFsitutODbOIkLh00HOaj0hO7L0kKOR
uqCo91debqQ03ELHcqpK5QJtvYwb1Q==
=PTPH
-----END PGP SIGNATURE-----

--cnKZjUtuNVB1GrhC--

