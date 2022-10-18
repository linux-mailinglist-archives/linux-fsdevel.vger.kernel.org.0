Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26786033C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 22:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJRUIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJRUIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:08:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10987AC49E;
        Tue, 18 Oct 2022 13:08:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MsQ0K2psPz4xG9;
        Wed, 19 Oct 2022 07:08:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666123698;
        bh=+D0gWHeMBzegukkXy1SdA4pRcO2k+qIUSncTGFsmUrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IM3Ksofa7q0N07sdw4Y0BnnxOq+Wk9WHXYdxl+5xWiZfF0v0jENYfC4JiVjkSoplT
         hca7aER9mrQTT0ti1vO8s0szXz2OlHuYJnfmA3HWbGY3e3YEylxmKFLSEZ8aALQrN/
         1JbAb30DkDpMsQhLiQiFL1aHNGVdANiBMMxg2/qxN2NeV/CtZpp3SAXeM3YF61nO8+
         HFoEn9iCVLpuc5Wt2k4sv/tOQtQlB41/5FvNEDZ817atqJzaPiqWLp5gp2C4Dbb5DA
         Ylx2d7TfjyK/b6PYHqZ4XuB7fA8hDmFMOaMHpvPZZbLKjP16iiDfQ/NE0H13s5ecg5
         v1qvR5ALbD7Dg==
Date:   Wed, 19 Oct 2022 07:08:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 0/8] make statx() return DIO alignment information
Message-ID: <20221019070804.53eac15d@canb.auug.org.au>
In-Reply-To: <Y05QzQM2ed8sOJxC@sol.localdomain>
References: <20220827065851.135710-1-ebiggers@kernel.org>
        <YxfE8zjqkT6Zn+Vn@quark>
        <Yx6DNIorJ86IWk5q@quark>
        <20220913063025.4815466c@canb.auug.org.au>
        <20221018155524.5fc4e421@canb.auug.org.au>
        <Y05QzQM2ed8sOJxC@sol.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kxgvt//y.g1b5pnGQvTpgqK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/kxgvt//y.g1b5pnGQvTpgqK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Oct 2022 00:07:57 -0700 Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Oct 18, 2022 at 03:55:24PM +1100, Stephen Rothwell wrote:
> >=20
> > I notice that this branch has been removed.  Are you finished with it
> > (i.e. should I remove it from linux-next)?
> >  =20
>=20
> Yes, I think so.  This patchset has been merged upstream.  Any more patch=
es
> related to STATX_DIOALIGN should go in through the VFS or filesystem-spec=
ific
> trees.

OK, I have removed it.

--=20
Cheers,
Stephen Rothwell

--Sig_/kxgvt//y.g1b5pnGQvTpgqK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNPB6QACgkQAVBC80lX
0Gw+mAf/bGHv0gVJlUAUtMlO+X/kuJ8K1xyeTNlPrY/3kIPVHvURN4N84Z456Pqj
T0tguhmoNIHnsiHD/ho7QW/9KfYkkvi0RT5M3eWWZIEky6wIUIQVmcteXUGc/ml5
QveAoeyW+UizAfGCDpSYtIh/iTiNtzRtOFcwseOWwBnT07GLgqWH848IHFM5hPt8
FAqlSCuWunHR7xkkfWX9XXJkDla5e/5z9C1DLrKWqNtgk7haUOrtZh3h90nVfJpo
9mKAil+9j1DCFRmaJfWggK6qvwNYy0/erG23c8pXs94BPk6eN0WZ/2wmLfoAFES3
M8E+Ra5EMWsQNIdiwy64N23mBSJv0A==
=/mrd
-----END PGP SIGNATURE-----

--Sig_/kxgvt//y.g1b5pnGQvTpgqK--
