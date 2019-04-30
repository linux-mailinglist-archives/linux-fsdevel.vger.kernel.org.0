Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C4EFE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 07:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfD3F0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 01:26:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3F0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:26:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so1191992pfk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 22:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Bpxrrn0nhxg0QxbDmzcOwQzwDv1LTHTm0Bu1+pUS7w8=;
        b=nO/HIlKtfAK2/1SkYjs9tvdr0hQBtMHhY7aKlt/T59XLtvScCsjGuvSdoWwODP1Fnk
         g+y27oy0qEq3YmJhkAIzcoBj/FDGUGg1OmHRCyoHMXEvj7I1Ehr1BE63S0t5LbQ+FnP3
         ZuUmJmrlvmbkugShZo1RZv89Qy4f3wYp4XSTSej/hfm1wGpp9O5ibgr41I7rHXulXmnV
         9LmhdIyHB/TZbUkIkXJzL67/kmpRHd2uz03LuwTmfXQKOsWPx/Dw1O6NgYtADHgpe2Re
         2UQYk4/EjLTNVNm6BJLTbZjpJD2gjapyhvzuDPBtxBxL74BbueTzkv9OREFXIcwG+a3I
         R9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Bpxrrn0nhxg0QxbDmzcOwQzwDv1LTHTm0Bu1+pUS7w8=;
        b=USxf9QxX3FcD/qbBMtN2cQWpJuV2rFsxp6lsUys7w07yYKOfkU21Blvsx0xlAujrVi
         vQS0T+Vi54ZOVjMetD2aR+W1UhXuOCmprw0OQCVDE++Fr/dgpBlaNsCt18mNNiDOq5uH
         DVwCWcHQ9zieFt8H3iaPKzYHZ//QbvTOAMTlDPepOipEzCBu1IKbzRr+fwp3hHbDyjlS
         /DqJdhitSLTt50CyNhouKYUK7xl4GJT9kUezP1IQWoYhPt4IN1YMmStsIXrG186vWxFb
         C2jRb4O73Qalgh82/EcJZdXbQmj7N37gOjYPLRk4YAQAnCNEN3CFQcttrbA9E9HNeobt
         uDhA==
X-Gm-Message-State: APjAAAVAJt/RP4lGKgFuUT5PM4WhOrhBIL5I/kYzI8dDDzZoa3p1JJbP
        19Zd6pR3QlCMxcKPRhaEzPe6Kw==
X-Google-Smtp-Source: APXvYqw9y61EBVVqfdNsoj2n24fD1cpqlHi4M+njFWS/yRijvHvuAm+WHa/NpkTB4ca9k7JEsq0fcg==
X-Received: by 2002:a62:4852:: with SMTP id v79mr68254296pfa.72.1556601982356;
        Mon, 29 Apr 2019 22:26:22 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id m8sm54492464pgn.59.2019.04.29.22.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 22:26:21 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D81FA0ED-7F7D-4B57-BE9A-26C5941D8FFE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E49322AE-A695-47B8-8F15-BAD54F0C2D97";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC][PATCHSET] sorting out RCU-delayed stuff in
 ->destroy_inode()
Date:   Mon, 29 Apr 2019 23:26:15 -0600
In-Reply-To: <20190430042623.GJ23075@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <CAHk-=wh6cSEztastk6-A0HUSLtJT=9W38xMN5ht-OOAnL80jxg@mail.gmail.com>
 <20190430030914.GF23075@ZenIV.linux.org.uk>
 <F01D238D-8A6C-4629-ABC5-4A8BAC25951F@dilger.ca>
 <20190430042623.GJ23075@ZenIV.linux.org.uk>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_E49322AE-A695-47B8-8F15-BAD54F0C2D97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Apr 29, 2019, at 10:26 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Mon, Apr 29, 2019 at 10:18:04PM -0600, Andreas Dilger wrote:
>>>=20
>>> 	void			*i_private; /* fs or device private =
pointer */
>>> +	void (*free_inode)(struct inode *);
>>=20
>> It seems like a waste to increase the size of every struct inode just =
to access
>> a static pointer.  Is this the only place that ->free_inode() is =
called?  Why
>> not move the ->free_inode() pointer into inode->i_fop->free_inode() =
so that it
>> is still directly accessible at this point.
>=20
> i_op, surely?

Yes, i_op is what I was thinking.

> In any case, increasing sizeof(struct inode) is not a problem -

> if anything, I'd turn ->i_fop into an anon union with that.  As in,
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index fb45590d284e..627e1766503a 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -211,8 +211,8 @@ EXPORT_SYMBOL(free_inode_nonrcu);
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
> @@ -236,6 +236,7 @@ static struct inode *alloc_inode(struct =
super_block *sb)
> 			if (!ops->free_inode)
> 				return NULL;
> 		}
> +		inode->free_inode =3D ops->free_inode;
> 		i_callback(&inode->i_rcu);
> 		return NULL;
> 	}

> @@ -276,6 +277,7 @@ static void destroy_inode(struct inode *inode)
> 		if (!ops->free_inode)
> 			return;
> 	}
> +	inode->free_inode =3D ops->free_inode;
> 	call_rcu(&inode->i_rcu, i_callback);
> }

This seems like kind of a hack.  I guess your goal is to have =
->free_inode
accessible regardless of whether the filesystem has installed its own =
->i_op
methods or not, and i_fop is no longer used by this point.

That said, this seems better than increasing the size of struct inode.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2e9b9f87caca..92732286b748 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -694,7 +694,10 @@ struct inode {
> #ifdef CONFIG_IMA
> 	atomic_t		i_readcount; /* struct files open RO */
> #endif
> -	const struct file_operations	*i_fop;	/* former =
->i_op->default_file_ops */
> +	union {
> +		const struct file_operations	*i_fop;	/* former =
->i_op->default_file_ops */
> +		void (*free_inode)(struct inode *);
> +	};


Cheers, Andreas






--Apple-Mail=_E49322AE-A695-47B8-8F15-BAD54F0C2D97
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlzH3HgACgkQcqXauRfM
H+B8Uw/+Pe3e89BpYfhV3O4jATQofqb9PH/+i8TAZmKTVOC09IO5ole1zpaWHGV+
8FQmrVvHUrUZLvz3GZJYAA7djWqJHIN58yPUllps35f6SGqfj54rEwwq3QAFSqFR
kOiDHHtWpASu0oVRDG1Lw0xijx8wrTmfmdWOTTYSL0o58uFCFhcuBdU9oaBi/Wrs
9RHwrQb4pffl6aCMP6FTVp+DdqVtIRMQ4UNOKrJiwa8SLuJSCw1Nwj7tzwOIXu7e
z2R9sFUQHOVx1r7cOgCrP+zpIZTNmOI7lsJnPUwgod5i4lLJqBylrGmz9B/lWbln
2PPtaUkFbB1VVnhxnz4K06Fp2AEE3S8DEzAwEyitCnb+FKvV9fCdRC/m/mx1pFhj
Icc/L+2F8xuYcw1EqB/Nyc2UAVs7VgpUEnedUUwBWjg+Md5zT+BeZY6qOxzwGhXq
vp3O2hSlRhNjgsGVpkWt7awa6JlUbvw1F76ktl2tiqiWl45X75FOS2RyjLxFt8Yw
FIqp29O8HauMdaEQb1CXvgemvnzM3f6om8NCN6q+zAz8RUjwK6N1x+z0f95iHEq9
ZXxY4KYHW3cjhlhKyZpiowqlMq+1I43NWhJFhMi2AVrEzDBBleBSdH617/R6hNbd
XJMyvjDo67gvOJ1UJeX+wAISpQz5M6l6EEZqoe/GcZTEtR9UNfw=
=a4F4
-----END PGP SIGNATURE-----

--Apple-Mail=_E49322AE-A695-47B8-8F15-BAD54F0C2D97--
