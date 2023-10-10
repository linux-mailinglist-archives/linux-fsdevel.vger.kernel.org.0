Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A717C038B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbjJJSiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjJJSiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AA9E
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696963081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+33WfwU3HlhFHBkjMEcCft5UPifUQvmDzciI/OvU/KU=;
        b=b9fz2x/qRRUU/SCHnzhTOE4BjZJDkM2EgasZF4bJg50WNLCb2q4Lm7NTk11Q/JznPNPAg/
        BAvtJED5GV9v8rvwzn/Mv/sCSfIgBWPwhIb3p/2xY68mBjYD873+es0a+nWWiTDXqMzH6G
        MN1F2iDWvRoWstuKgrCqUNl1vDOtils=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-9jSvZjBBNj2eBmtVA4fRyA-1; Tue, 10 Oct 2023 14:37:57 -0400
X-MC-Unique: 9jSvZjBBNj2eBmtVA4fRyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B9D4811E88;
        Tue, 10 Oct 2023 18:37:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55C2E1BA5;
        Tue, 10 Oct 2023 18:37:56 +0000 (UTC)
Date:   Tue, 10 Oct 2023 13:21:07 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, mzxreary@0pointer.de, gmaglione@redhat.com
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
Message-ID: <20231010172107.GC1754551@fedora>
References: <20231005203030.223489-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T8VF4ojPKKmYzx7M"
Content-Disposition: inline
In-Reply-To: <20231005203030.223489-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--T8VF4ojPKKmYzx7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 04:30:30PM -0400, Vivek Goyal wrote:
> virtiofs filesystem is mounted using a "tag" which is exported by the
> virtiofs device. virtiofs driver knows about all the available tags but
> these are not exported to user space.
>=20
> People have asked these tags to be exported to user space. Most recently
> Lennart Poettering has asked for it as he wants to scan the tags and mount
> virtiofs automatically in certain cases.
>=20
> https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
>=20
> This patch exports tags through sysfs. One tag is associated with each
> virtiofs device. A new "tag" file appears under virtiofs device dir.
> Actual filesystem tag can be obtained by reading this "tag" file.
>=20
> For example, if a virtiofs device exports tag "myfs", a new file "tag"
> will show up here.
>=20
> /sys/bus/virtio/devices/virtio<N>/tag
>=20
> # cat /sys/bus/virtio/devices/virtio<N>/tag
> myfs

If you respin this series, please mention that the tag is available at
KOBJ_BIND time, but not KOBJ_ADD. Just a sentence or two is enough to
help someone trying to figure out how to use this new sysfs attr with
udev.

>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--T8VF4ojPKKmYzx7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUliAMACgkQnKSrs4Gr
c8gFpAf/SA1MUx5Dcoz3offMIyO0nLEn2uqzbGVkJLn15fqnoQVtsD4UfggTlOxL
8ZmSwgKqiKN3JATLyROHnNKhpzAADppA/uWMz2Bl2Jhvc0h0YGliaO5+GMgDSuOC
YqbHbKvR0oiPpn40sscxuO1XQze+gzf3TNyQWTiIW5GZE5WrEKJrzI82mTAKxaAP
cglLQugKYy/GyWvtWQAy+vbvcQ2XWdIFMhICurBV4euSj9SN2GcWjDBby8xXylaJ
ehxZsZ41OmBVvybNV1JTne3bXn2yJJM9aKdNklDbOhUIaJ9zsLdNbBQwTmTeeT7W
kgyCdy/ppZbKlVkpAZeBQ0VbLx1qMg==
=Ef0b
-----END PGP SIGNATURE-----

--T8VF4ojPKKmYzx7M--

