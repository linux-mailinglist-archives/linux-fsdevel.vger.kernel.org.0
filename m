Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B109476CE12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 15:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjHBNNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjHBNNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:13:35 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656551707
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 06:13:33 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RGC8m6lRMz9sRD;
        Wed,  2 Aug 2023 15:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1690982008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJ/RLwXoxohE8AwrXlKdCRj761UBocrPz0AowaL6gFU=;
        b=bLIvJm+reDfraH+z9Xr9rYA2M3/Q9kXqHJCzJgPi7MbT5ntYfVj+Lc7Jnq7pc//gcB6HAa
        6Iy+JyuFkoTKOgbOevHaa8AzSc3A+mKS6EbNcJh2sCSIvc0V+jzSklr/VSarwXn4a3lyMF
        K4jBqCQAtXggnmevqgWY1ipNy2sK0AF9Q6nGAF21d9dmzqUt24ugRr2QGJ/wm4jfiMXM0Q
        TDOO/6C2p9jVFVB0eiGCSNOf+XziDB+F7acBZylKJdZ74sPE91AUnUnH+YW7YavTCSJfpR
        7iZwWRHlbDHUxWUNG9MRe7tD32RoPMDe1l6ntn0HdqClLKHd9KNMl8tY7S88vg==
Date:   Wed, 2 Aug 2023 23:13:15 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 0/4] fs: add FSCONFIG_CMD_CREATE_EXCL
Message-ID: <20230802.131222-employed.twerp.smooth.flow-dFCtMe2BT3yW@cyphar.com>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vboaf45rx2z2ujqd"
Content-Disposition: inline
In-Reply-To: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vboaf45rx2z2ujqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-02, Christian Brauner <brauner@kernel.org> wrote:
> This introduces FSCONFIG_CMD_CREATE_EXCL which will allows userspace to
> implement something like mount -t ext4 --exclusive /dev/sda /B which
> fails if a superblock for the requested filesystem does already exist:

Looks good, nice to finally have a way to close this hole. :D

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vboaf45rx2z2ujqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZMpWawAKCRAol/rSt+lE
b3SjAQCpxgDaPvjsK4VDcnkhgV6TQ1MrSO0b+9V6iLl55/NmcgEApp/slmitMM/2
5TESffqIgU99lunTQzfDetqdGVnpIgo=
=VxNX
-----END PGP SIGNATURE-----

--vboaf45rx2z2ujqd--
