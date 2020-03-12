Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AD183B09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 22:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgCLVJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 17:09:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46561 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLVJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:09:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id y30so3658651pga.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Jm0QuoVYWLIkEIZ1aBkYIS2YTC2nnJykHw8y19YRbks=;
        b=lG44gMEia2yLgM2EF2gUy3A+yfFoluTTTEHv1h8h40hRfZL7AlPyQlA7WYGXAVAHzi
         7QKR+Dvo0BqrSXJK1rkIhgiH4sRxoCYokpaBqrhIHYw1MotZQI3g+0Y3H6dYy+Sldh6b
         5x/arYiXXXIvikCJgNqNAY90rwJMaiA2hFzydsMa8m8K3p4RyNc9kQdgEgUWgNaE71Jr
         nA9iPZbBBYdfKcsxwknObDM5kENiyvEAG9YTEKLtbDbWdb/Ijt0Z0cMnbUETGeX6SJYE
         vpsHe0GKamqSYBlw5o1rTslT4QSxie1OOVRfAneDZt94IqcPgM8OBWZhK7nHfxnm2V/2
         sraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Jm0QuoVYWLIkEIZ1aBkYIS2YTC2nnJykHw8y19YRbks=;
        b=BLx2VVHdjN+Cc7lu2cAbU+rlFcBBsJngKeW782NMHXboToViJUsYTKU05OMYbI6ptO
         5rjKcncsPcOVQcdYz8Vda+amupzEZiBdzICwOKJPqk6fFX/YZzm+klkPtYa00OB3NGnE
         U9NG7zDFCNerCTVVt64i8ojqzsOhb4/2yAPkYQI/nw6q5t/1y3Mz04P1VoX/DohhfdBW
         zzZ1l0L40Bylesuu/rwr/SZ73zCNSk9AhL8gRcLQIkPe/J5BdczDjZLoMD9wHhj3twkq
         OlUafwpJPDf5wkFn/bKQ+59A8PzKYL8i6AtXyO0MeCWsApzhPfYW64Qtdq5vqh11J0XG
         6pCA==
X-Gm-Message-State: ANhLgQ29zurmIBJ9e7gBJQINp/bKE4kuLt527allSWrPuokTe/l+h9Cq
        Onz1MG2EzvfUpk0DYGLqxau+zg==
X-Google-Smtp-Source: ADFU+vvnMvf++5SeThoOT0hxto5shVB5W2x6CVGUKEKslSAuK/RCOMiFoVgRPFsV+DKEtEtzaqf+Pw==
X-Received: by 2002:a63:f455:: with SMTP id p21mr9480367pgk.430.1584047362999;
        Thu, 12 Mar 2020 14:09:22 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id t8sm9081309pjy.11.2020.03.12.14.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 14:09:21 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <23C0E698-9507-40FE-9F37-9F1C4CD55192@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0A2AC55E-C672-4E48-973E-0DE56BB09E8C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 1/4] kernfs: kvmalloc xattr value instead of kmalloc
Date:   Thu, 12 Mar 2020 15:09:09 -0600
In-Reply-To: <20200312200317.31736-2-dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
To:     Daniel Xu <dxu@dxuuu.xyz>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
 <20200312200317.31736-2-dxu@dxuuu.xyz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_0A2AC55E-C672-4E48-973E-0DE56BB09E8C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 12, 2020, at 2:03 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> xattr values have a 64k maximum size. This can result in an order 4
> kmalloc request which can be difficult to fulfill. Since xattrs do not
> need physically contiguous memory, we can switch to kvmalloc and not
> have to worry about higher order allocations failing.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/xattr.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..0d3c9b4d1914 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void =
*value, size_t size)
> 	if (len < sizeof(*new_xattr))
> 		return NULL;
>=20
> -	new_xattr =3D kmalloc(len, GFP_KERNEL);
> +	new_xattr =3D kvmalloc(len, GFP_KERNEL);
> 	if (!new_xattr)
> 		return NULL;
>=20
> @@ -882,7 +882,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, =
const char *name,
>=20
> 		new_xattr->name =3D kstrdup(name, GFP_KERNEL);
> 		if (!new_xattr->name) {
> -			kfree(new_xattr);
> +			kvfree(new_xattr);
> 			return -ENOMEM;
> 		}
> 	}
> @@ -912,7 +912,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, =
const char *name,
> 	spin_unlock(&xattrs->lock);
> 	if (xattr) {
> 		kfree(xattr->name);
> -		kfree(xattr);
> +		kvfree(xattr);
> 	}
> 	return err;
>=20
> --
> 2.21.1
>=20


Cheers, Andreas






--Apple-Mail=_0A2AC55E-C672-4E48-973E-0DE56BB09E8C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5qpPwACgkQcqXauRfM
H+C6PRAApl5bisDXFp/jGULE8gpDy3JaNCc1YAKuK3qMiZB5UjjbzcMkMR9k31ka
BEfal9TrS7iPffpjhYEXcjStZ/cOQYzp8X7BhN/e+cVP+C+KRxD8E7LniFjfO6ib
84FMjaCTwFcQzIymBQ8TFjk6QUAOBnOX+eILuWKtRcJegg/sSPq/lLwW1YwGxiOY
3884UCNusbn7R60JPNY/69+0z93a4zVj5qXLw7Ufzclsozvag8IVO/2S1XI8BWh5
CZlLGZXDoU1a3W2DqUC7Plajctgd/XuEjER1UrRiIsYKJnkK8gytcegPUedb/efR
zy58TVNiEHW76yDk0ZVyeIkcXb0p3yeBZVa6HNZ4b1pAd16JNkvdPxQkns5zITvL
fCJqSpHzRXoKCsh4Tb8xYv0mDyVx5V4VqIZHcn9sXSijak4E29vN+PebpbPomC4j
BypStjLh7f3bJ9toRIr3yiReVi4TxxytaewJ2ATRfevquO/dsdToec8j7ewhXhEC
WPpALISGRkrG5xRbDgaGl9Zm9A9a5UeMokR+wMmWIjMicmxLjFdH99afhC+LWEF/
DYSTvBiFu0e2m5RJNUe9iSPCt/moM43e6GwFZSUDJhRFIxgn3s15rUwWGlM36Pi9
HWwG7W9CsQcq2juUqt1g/Ui/7C1F+Frz9y0ofmy3pOGkG0irKUE=
=Kd+G
-----END PGP SIGNATURE-----

--Apple-Mail=_0A2AC55E-C672-4E48-973E-0DE56BB09E8C--
