Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32F64F1153
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbiDDIvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbiDDIvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A50E15FCF
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649062150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0RJO4YOIckljaxC1WSdxpeWFwKQ7UkOt90RkMFXKO4k=;
        b=Uah/bACm+Qzw0BmALKvx9MYopfFxCNKy5zFX6B8FlfR8QkFX2cXqSoe5Uds0cyPOalDvRa
        0CRXJPVrraX28S6gFv0zL9NayWntlDFaJgZMgyIIYP4QjJ0NOJmI9/PY+pSpPNnPOGmKFp
        32S5nQ65lK31XagzhdgAIlKM85pcj7w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-EPhsp-OiMlabi_TXNoruqw-1; Mon, 04 Apr 2022 04:49:07 -0400
X-MC-Unique: EPhsp-OiMlabi_TXNoruqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC8ED83395E;
        Mon,  4 Apr 2022 08:49:06 +0000 (UTC)
Received: from localhost (unknown [10.39.194.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B8111468973;
        Mon,  4 Apr 2022 08:49:05 +0000 (UTC)
Date:   Mon, 4 Apr 2022 09:49:04 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     miklos@szeredi.hu, vgoyal@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <YkqxAA9tKikFf6iX@stefanha-x1.localdomain>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="johlXlSqV4WB+rsv"
Content-Disposition: inline
In-Reply-To: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--johlXlSqV4WB+rsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 02, 2022 at 06:32:50PM +0800, Jeffle Xu wrote:
> Move dmap free worker kicker inside the critical region, so that extra
> spinlock lock/unlock could be avoided.
>=20
> Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--johlXlSqV4WB+rsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJKsQAACgkQnKSrs4Gr
c8i0SQgAiiCpauRR/VRZdej/Av1FxtiygazikyP74EifydRA7XuvYtXXTBsEUJvP
ZA03bAV0zFAqyG1EIjvGbXtjzw0zjsmbFYugfdIMwnv36drNn6tnSKT73+iEE7/b
iGsJWY/kLB8Muo+N4sZ0JpIfp3NsOFb14V/iLKFQfbH+hEClkoP9wM1etdkY3ogZ
NUgSmWRgk570CHDF85/CFu1zg7wG4KTeLWMa0o+uNSqXBPjOji90z/RsP5EZs6QT
Pk5Mmr/XRlgN0s0TR+NZc7EuP7Efgh4kZsViz9VkFEl+TPCDOvigsCTjDRTVRIgc
76EOklRhkCrNLaHJGUz7jL2GrHElIw==
=zLYr
-----END PGP SIGNATURE-----

--johlXlSqV4WB+rsv--

