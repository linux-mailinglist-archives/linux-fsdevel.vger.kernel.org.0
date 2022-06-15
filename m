Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA754CD93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243847AbiFOPyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiFOPyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299E11D302
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655308452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEmJ1fJ8Yf6oDfx0MBc+zDdacxWq2un2XNoeG1V4KKU=;
        b=WjVXW4872yl6AdOAUoltvLR6pZUbFbqc0r50GMWvDkzkCrPUGLGWcSqopuwQT6ZIGKBrnO
        iYYpUBnSQBA3bJqgb7KLuzDy4pWF++D5IroxcnNsECVgWdFhgCVd+9YNEOvr3uF8nQvtHz
        p8zyDYPOW7SX49e/9s8IoyTlLI/ZLcY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-D_983ZWxOxWyh_k1LNsgaw-1; Wed, 15 Jun 2022 11:54:10 -0400
X-MC-Unique: D_983ZWxOxWyh_k1LNsgaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5728B38005CB;
        Wed, 15 Jun 2022 15:54:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2EE51415107;
        Wed, 15 Jun 2022 15:54:09 +0000 (UTC)
Date:   Wed, 15 Jun 2022 14:54:29 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     vgoyal@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtiofs: delete unused parameter for
 virtio_fs_cleanup_vqs
Message-ID: <YqnklWCUQBamzmJJ@stefanha-x1.localdomain>
References: <20220610020838.1543-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VSfWJTB4dTlkafrv"
Content-Disposition: inline
In-Reply-To: <20220610020838.1543-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--VSfWJTB4dTlkafrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 10:08:38PM -0400, Deming Wang wrote:
> fs parameter not used. So, it needs to be deleted.
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  fs/fuse/virtio_fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VSfWJTB4dTlkafrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKp5JUACgkQnKSrs4Gr
c8i8ogf+JVNIK5wafiTY0HlfRmCOIhYMJ8AbK4vwM0rKJeoQc+tgLDPQHHCVMGDM
lqtAdpnNzCHGOTTe8+sbTVhxhH+THmJvh1c7fX630vgW6MQWQICOT1ablFIJN/jF
4snTGcSXXaPWMp9B4YJp4n+LBkH3WPHLYGuy1tzgDSYRCnv7ofeKitJ5b3BVWhuc
zBgS6VNklGbEycPII0gUR8doCeW3laSbHT/3Cai3lVs6iqfZlv/wfvpG8gszeHqm
IFb5Y93cFAWvxZg11kx8g8Ps3GirNj/y1tq/USKPaQ1PlbQmSZKrSW/6eku2RMXO
yvOmooxFHUf/aUVMw/BqAynlUDfLLg==
=BmCq
-----END PGP SIGNATURE-----

--VSfWJTB4dTlkafrv--

