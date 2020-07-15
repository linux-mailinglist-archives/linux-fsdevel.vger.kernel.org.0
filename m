Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4093220D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgGOMu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgGOMu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:50:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DDC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 05:50:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so2044284pfn.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ShVGtDM5xerpslVq+QO4NAQXlRlUc1FZogmGfNpoutY=;
        b=zfEz8H5E0uTrtiedmvrlTGbHtdxGX3RrMjMgJxif+xhNGImqKZRwVnxOB7SiJiHGZb
         EgfDXwV6eV0eYsRRBkuQtDnVaC/gA32Wm8PgvRC0S/grBe3RSNr07Qwb/U5MFJQCd+xu
         ZzRH0TwSYyHM7F+ByWaX4y+/lwLlfZropXcAtw4OEd6s5YhRov92z0a99VRfYJAAhfNf
         bZtJoVQi9SqMDg0zgDRRi4WZCRBAeTXicGV743fdg5EHoHEDZibVOgCS65ZUQ9HcWhdA
         loHkMsrB0ViJIeLN9ArV7hzmoxVeMMuJFVT9NdQFZG26b8lb2eJfYno6GYBY0w3mG5Fw
         aObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ShVGtDM5xerpslVq+QO4NAQXlRlUc1FZogmGfNpoutY=;
        b=s9U6Q+u+1AE0D52udZecrfuezRxSjKYlw39D8qDqyhKT7ocUG6xiVGzmu7fljBZrzl
         mdWwbm+MQy/MIjMUqPJy+OuCf5IBvnUTxqVZNkuKTbj4G2a5Pwhx3IHj4iSPYwx7YrZh
         yw7idIMv24qe0IKPKlQ/U5vFzpIVS0hZsPO5XiSmSXmXm8U9ETXEGwtDQcEMNLSRYltN
         UvgQeNTIgzU76aTGZ8yXD/Mmj6/MfZvp81rJU5cEX2UR3OBHbUz0jLMy0hyNedrldnKw
         BYm5Im/jrQk69S+E/AdLtxoGcFJVjq7uCsTjTbueJn1mS0X6IB2/oQ4SGV6+VGF28uRo
         ZZ5w==
X-Gm-Message-State: AOAM530O3HwWgX4zNOvmkVsL5PLsi1dS6GvNliUgWHNAId1L3Ffw886g
        xiPniz0rA83WjMSHfz31phvDfQ==
X-Google-Smtp-Source: ABdhPJy/Ln9peH7xxHmsqXkwnv/o960pFulImShZC6watVz+6vqqfalkLQT9ngLHhAPVGcqCMTcTqA==
X-Received: by 2002:a63:1f11:: with SMTP id f17mr7755201pgf.217.1594817426552;
        Wed, 15 Jul 2020 05:50:26 -0700 (PDT)
Received: from localhost ([2406:7400:73:f0a7:1936:cfd2:c2df:5e48])
        by smtp.gmail.com with ESMTPSA id ml8sm2037189pjb.47.2020.07.15.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:50:25 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Wed, 15 Jul 2020 08:50:18 -0400
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: block_dev.c: fix WARNING in submit_bio_check
Message-ID: <20200715125018.mjj6sj5uibd5s67b@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpn6rsynz3x3gxmk"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lpn6rsynz3x3gxmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

duplicating the logic in blkdev_get_by_path to
blkdev_get_by_dev to avoid a user-triggerable WARN
trying to write to a read-only block device.

blkdev_get_by_path() looks at
((mode & FMODE_WRITE) && bdev_read_only(bdev)) to check for write permissio=
ns.

A user-triggerable WARN can be avoided by doing the same with bdev_get_by_d=
ev.

Reported-by: syzbot+4c50ac32e5b10e4133e1@syzkaller.appspotmail.com
Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 fs/block_dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 64c4fe8181f2..472e3b046406 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1796,6 +1796,11 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fm=
ode_t mode, void *holder)
 	if (err)
 		return ERR_PTR(err);
=20
+	if ((mode & FMODE_WRITE) && bdev_read_only(bdev)) {
+		blkdev_put(bdev, mode);
+		return ERR_PTR(-EACCES);
+	}
+
 	return bdev;
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
--=20
2.20.1


--lpn6rsynz3x3gxmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8O+4kACgkQ471Q5AHe
Z2rFSwv/eUXmS0JEAwk4ovaLtuu9ly240wFQQBHwIyOidIuxiw0fnOKPfRpBFCHc
NDdVlZ3/IDfRbcT/5Td3wO+X4OmWPoE/mr2EClOxeYWFCcJV7oWzO+FBkkYb7P93
JmzuDtIYMsSVnIrAyjlwwCdlii0nW2eism0rIP2Ja30FsAvZR5l1pqw8ypjFpKrQ
tGot98tkBA5iAm5A2F/8iBpwX+kp/y5kEzXpfH8qgrslt3booQ4FLFcg+TCOeIaj
G1vPkY0fuVCsQZPXSta6RU89NI71AQKN5FhyujqpNa1hIiA5IYT4+c9ryRwzuJIr
fzLFygwWbFXLXtvgZ87BlhkSIayJMQNFUBrjA36BB0iN83fRyKr69K0i8BbG5QKU
FP/zryOsnO2AdbtBpB8OCPXq5era+hbeZnXncBzl9h9ApatmRWajO4D0mOXQRd7a
njx23nf5npJtjXeHmznhi+luoAeeLkK+te0hvGl2fmFhT/v7Zt8xa7D4bMnC18eh
ZkaRfIHq
=Pl6p
-----END PGP SIGNATURE-----

--lpn6rsynz3x3gxmk--
