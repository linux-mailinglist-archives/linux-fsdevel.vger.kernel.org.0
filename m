Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5395EF59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 06:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfD3ESL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 00:18:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39223 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3ESL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:18:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so6214178pgj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=yMy9zs6hjX7Jvjajf7EMD1xXihr0IEotc2Z47HCh9Ag=;
        b=x6npV4M329PHCMKpX8SfR7EikvhkLLYzfUYTOz7n0gQe9VzN8+kS3hCvlwknJvHski
         UJU3t7BBE+oEUY1vWLfd/MnMfcI8zVhkB/isG0T+jDvLh/Gq+fB67OuESzstxoxkSvSR
         UW3jcimf6fyL7CJKFrtIl6sWQrjOFIgg7U/9VexNc+gqwetj2wcASsAJIpLtaMEhbcBh
         wrrkIe+hF9+XjeVj1CxdVXqaAZZq/U9UbBBCDHjO6FRPscOongZEO/o4Pp1erOrj4vDA
         AY8ucY8fC+t4ab6Nxj75fMSqo3bjeAwilyig+MTI4tdL6tS0gLGY6E8N0FZ92IrHWpW5
         m9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=yMy9zs6hjX7Jvjajf7EMD1xXihr0IEotc2Z47HCh9Ag=;
        b=ollo1pIt82C1qSg7c0vTc2TWI66s0dyHUbeAE0xh5AWw6IpW0zDmw1AnWVUgcNvg9S
         gebWVbL44aHPORkHP+GnGwf4vOt1fsn1Uj3AIMFogBUWkcCP3WSwcWR8kqwSmWKySE3S
         f/BjRgso3LCZ4/Af647pio1PZR/TAIlkeyoMoKxdffFYwEvlkeTD2x8ap39q1ocD19fO
         dobNhDtz2GywJK80FUEvakCRFWlbaQXCjcGsJEYK5oqBIa2rev43fb44RlLd0Z0GCUhr
         y08clVJBPwgJ/3CzM/jxsZHkvKe/NU7qMokTCjmD1O4/HHuxPjR4V0iqWYF39FezuaZV
         notA==
X-Gm-Message-State: APjAAAXlx1JkB8zwkwVcGcXELw2EyG1UHD3mAhVFRgIvPVeOfIXBF0za
        97ax4JWf0lfl8UphK/dUOhbKMA==
X-Google-Smtp-Source: APXvYqynk5vC9/chCdVgv7S+JTpjZcSwCNSPom2SHwd5WBp8PA52niwL1Vg/su2jkJkKTOOTJgBqWw==
X-Received: by 2002:a63:1e12:: with SMTP id e18mr32529769pge.87.1556597890302;
        Mon, 29 Apr 2019 21:18:10 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id b5sm312925pfo.153.2019.04.29.21.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 21:18:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F01D238D-8A6C-4629-ABC5-4A8BAC25951F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_00BDFCFC-7769-480B-BD04-EE20FF8FE67E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Date:   Mon, 29 Apr 2019 22:18:04 -0600
In-Reply-To: <20190430030914.GF23075@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
 <20190430030914.GF23075@ZenIV.linux.org.uk>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_00BDFCFC-7769-480B-BD04-EE20FF8FE67E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 29, 2019, at 9:09 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Tue, Apr 16, 2019 at 11:01:16AM -0700, Linus Torvalds wrote:
>>=20
>> I only skimmed through the actual filesystem (and one networking)
>> patches, but they looked like trivial conversions to a better
>> interface.
>=20
> ... except that this callback can (and always could) get executed =
after
> freeing struct super_block.  So we can't just dereference ->i_sb->s_op
> and expect to survive; the table ->s_op pointed to will still be =
there,
> but ->i_sb might very well have been freed, with all its contents =
overwritten.
> We need to copy the callback into struct inode itself, unfortunately.
> The following incremental fixes it; I'm going to fold it into the =
first
> commit in there.
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index fb45590d284e..855dad43b11d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -164,6 +164,7 @@ int inode_init_always(struct super_block *sb, =
struct inode *inode)
> 	inode->i_wb_frn_avg_time =3D 0;
> 	inode->i_wb_frn_history =3D 0;
> #endif
> +	inode->free_inode =3D sb->s_op->free_inode;
>=20
> 	if (security_inode_alloc(inode))
> 		goto out;
> @@ -211,8 +212,8 @@ EXPORT_SYMBOL(free_inode_nonrcu);
> static void i_callback(struct rcu_head *head)
> {
> 	struct inode *inode =3D container_of(head, struct inode, i_rcu);
> -	if (inode->i_sb->s_op->free_inode)
> -		inode->i_sb->s_op->free_inode(inode);
> +	if (inode->free_inode)
> +		inode->free_inode(inode);
> 	else
> 		free_inode_nonrcu(inode);
> }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2e9b9f87caca..5ed6b39e588e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -718,6 +718,7 @@ struct inode {
> #endif
>=20
> 	void			*i_private; /* fs or device private =
pointer */
> +	void (*free_inode)(struct inode *);

It seems like a waste to increase the size of every struct inode just to =
access
a static pointer.  Is this the only place that ->free_inode() is called? =
 Why
not move the ->free_inode() pointer into inode->i_fop->free_inode() so =
that it
is still directly accessible at this point.

Cheers, Andreas






--Apple-Mail=_00BDFCFC-7769-480B-BD04-EE20FF8FE67E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlzHzH0ACgkQcqXauRfM
H+ASkQ/+KJdyGCkWq0gVJ+BAkcY8APT+2IghNpsqirVFNXOVmvA1RYQ4oaCSsRpx
0wLFNjoVJXaXJz6YUfsHXRevmUPZIHHm9R02RlY1jO/zGPCCK9OkzermwwDNzXQJ
LzPvlZweXcK0dqGQpzpf1HdN2gatQK4FBtQxsrhNezQ4rF0Ndz4kxdkx4TdefpEz
8rz113O2moFtRGROxkoDz4q3oFwW+mFp+ukJ+2cwCCCgvxNfew3fT0M7feV1WO+F
RpzZYf8KkR9HkHHSuaJHZNqzHmcJ7BSpX0UCCeh6jON5EJCUH/KRKbL8eEPY1Lqs
KYu471FVq6MxksRXXvXpvNV5CiTRpK52DMQCWgPVA/uswFMcIkemoyaclIgy9egj
vhx4nQD3FUHpSP6feWuzvTr3EJnwrGyJUjaQoqwFQ4zc09JlgMSlrv/7AalRwz4w
mBuU3trIyHIFVs60JGqoOaZ/fJqtUe42EBk08Mb/bLWwQH+ExIi+2X4C6kwwD12E
fKTCgrrLXa/X2dkKl1jQ6QKMIGOvr9H9uBpyz+L3GqYswMA6Zu6ENHockKiC4JZU
kTvM+xWOC70OIgeHqg/6QVteQjhCMrAre93kGvBswXAfehDuFiAuD5NHnZRG2gxX
qZZjgZ8D0L2RZQrWT85ZdxI+ynAYVhurZ1Uf+3oG+F319sRH0xw=
=NJT/
-----END PGP SIGNATURE-----

--Apple-Mail=_00BDFCFC-7769-480B-BD04-EE20FF8FE67E--
