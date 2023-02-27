Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D46A4687
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 16:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjB0Pyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjB0Pyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D116ADA
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 07:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677513232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSg5+r6je78Oo6DOHt1spvGdIu0PScSllKZjUp4heJA=;
        b=KZ/7agVI/jwe0IRgbSdkf0oYeZgrYvfXh0bs8d7kVk0Da9q0c3dn0274MgXm5PNzsl8V3Q
        ahJf+27OeU7bfTWKM96IKWRZAKZJYNJkGXiJeATeCTOBiFch9Icwq4bB5JKiBmTFnyZlCj
        gA9kgS1y00Im/+IYkagAZP2iLYKtJl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-inavr7DaPlSPxeWPDMSTeg-1; Mon, 27 Feb 2023 10:53:49 -0500
X-MC-Unique: inavr7DaPlSPxeWPDMSTeg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F14185A7A4;
        Mon, 27 Feb 2023 15:53:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 348811121314;
        Mon, 27 Feb 2023 15:53:47 +0000 (UTC)
Date:   Mon, 27 Feb 2023 10:53:45 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     vgoyal@redhat.com
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, akpm@linux-foundation.org,
        David Heidelberg <david@ixit.cz>
Subject: Re: [RESEND v2 PATCH] init/do_mounts.c: add virtiofs root fs support
Message-ID: <Y/zSCarxyabSC1Zf@fedora>
References: <20230224143751.36863-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RSf3QCTu5WhPlQBP"
Content-Disposition: inline
In-Reply-To: <20230224143751.36863-1-david@ixit.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--RSf3QCTu5WhPlQBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 03:37:51PM +0100, David Heidelberg wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Make it possible to boot directly from a virtiofs file system with tag
> 'myfs' using the following kernel parameters:
>=20
>   rootfstype=3Dvirtiofs root=3Dmyfs rw
>=20
> Booting directly from virtiofs makes it possible to use a directory on
> the host as the root file system.  This is convenient for testing and
> situations where manipulating disk image files is cumbersome.
>=20
> Reviewed-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2: added Reviewed-by and CCed everyone interested.
>=20
> We have used this option in Mesa3D CI for testing crosvm for
> more than one years and it's proven to work reliably.
>=20
> We are working on effort to removing custom patches to be able to do=20
> automated apply and test of patches from any tree.                       =
      =20
>=20
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/.gitlab-ci/crosvm-ru=
nner.sh#L85
>  init/do_mounts.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Vivek, do you remember where we ended up with boot from virtiofs? I
thought a different solution was merged some time ago.

There is documentation from the virtiofs community here:
https://virtio-fs.gitlab.io/howto-boot.html

Stefan

>=20
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 811e94daf0a8..11c11abe23d7 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -578,6 +578,16 @@ void __init mount_root(void)
>  			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
>  		return;
>  	}
> +#endif
> +#ifdef CONFIG_VIRTIO_FS
> +	if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> +		if (!do_mount_root(root_device_name, "virtiofs",
> +				   root_mountflags, root_mount_data))
> +			return;
> +
> +		panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
> +		      root_device_name);
> +	}
>  #endif
>  	if (ROOT_DEV =3D=3D 0 && root_device_name && root_fs_names) {
>  		if (mount_nodev_root() =3D=3D 0)
> --=20
> 2.39.1
>=20

--RSf3QCTu5WhPlQBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP80gkACgkQnKSrs4Gr
c8gQDAf/S5FKAUxYW0RXBL8p7kqYdskcOGTgDOV7axCS6K87pK4tYT7M3RqheN3+
edcQhwOIM1ycR+xuYS5AA60sUtNKlsF4RIZu8+ug1sJPoXZE2WDtQbMk4sCpctgt
oWQTTVA35jvOv8SnfVL6AYcYTtymB6bpXaX/cYdUn5ERaOleKRvt4E8Rpjv9hCjS
2pg+KhGCoTWLicimXqEmHZI4FwChxJgvmw8EmNmyNm9wzuh9xibsLbm0tB6wyIdt
f7FWURT1T+yIr8TIChaWUg7pb+HldwDxpcFSsLeZGgaPB22os24ZTalYNrd8KQrm
320U02Kiol90+QZLWEVXkJQ1z2HlmA==
=igqY
-----END PGP SIGNATURE-----

--RSf3QCTu5WhPlQBP--

