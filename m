Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0295E83559
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfHFPeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 11:34:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPeg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:34:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 462zFv3F9sz9sMr;
        Wed,  7 Aug 2019 01:34:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565105672;
        bh=5FHAJ2a0H+dgGw8qV5krRpvfMTW4QMVUNBiIFTz7ukc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dcShrCbsau/hwzLIEVX+xCQkjw8ytUmuBphP7Wzk0Os+PeYJL4E9AZojKIxsW/XCC
         xTyuNmwgEnwSEW6/Kz8amhaNxd/QkXfyj6TN7B3JHn6lyvGiqz9io4rs24B6/81qqU
         aHhTQCVVCoPKVEFdalsWvjQTI3tUyZFaUFc133mkcqknYyDVNSEChFStksBky28u+/
         GQO177sJv9EuIy1iyMEkE5ZTlNxx7pwHSxx0QCJI51C+dfkT0hpyUbfm+uzI+0mdxe
         ZEqmwK2hiOD8JXrhyc//NCp7AK7xY6zJ2JDZpiGvVhYTi+uG79dj7xnbSdH/Jt6dGk
         vLa4gCEEgqDLA==
Date:   Wed, 7 Aug 2019 01:34:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH RFC] erofs: move erofs out of staging
Message-ID: <20190807013423.02fd6990@canb.auug.org.au>
In-Reply-To: <20190806094925.228906-1-gaoxiang25@huawei.com>
References: <20190806094925.228906-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3zuq9Mbh_pVR5QZxswgd1wJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/3zuq9Mbh_pVR5QZxswgd1wJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gao,

One small suggestion: just remove the file names from the comments at
the top of the files rather than change them to reflect that they have
moved.  We can usually tell the name of a file by its name :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/3zuq9Mbh_pVR5QZxswgd1wJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1Jnf8ACgkQAVBC80lX
0GyktAf/awWVta3LRhqpez+RTEQC6IzKAlgR8ULIAJpHB3OZFNlv6Lxvbg3l/Jdq
XZAoR3RqQTr49hpHePfnENWdxIFa7DUCyOjO5MeWyP7VpVBEk48YSFnBUtPIzh7m
+UdrAt+zOdjzdRd6/v2DGhd8dXLZ+rsupL9XA75ak2iVEGjEnlTorjwKDaYy2VR+
cV0mFcFNBEHs2Ok2wTfYYzUx7id7/tcVfjWuzvyvd1d0Y53FLgWLvIVCsJNM0HmH
LlpVkiVpMFDCC3SMSiffhkOkNigEV1vY3wxlS2qniRz+qXbAMqPv8CRbtdO92bkM
LBThN5N6CBu+SqQgGSvGv08yzx+eqg==
=sZOX
-----END PGP SIGNATURE-----

--Sig_/3zuq9Mbh_pVR5QZxswgd1wJ--
