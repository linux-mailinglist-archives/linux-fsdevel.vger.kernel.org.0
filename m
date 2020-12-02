Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5042CC9EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgLBWtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387646AbgLBWtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:49:20 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7AC0617A6
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:48:40 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id m5so1775503pjv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9QfXOnDQXBcVNRGuammJHFxREgoMLaRZ+ETyqz3mSr4=;
        b=qmksV4Dals8a82iYZ6RK8iTVyq6BvbUIrYlGWlQ4O/dpBg0D4yX82WYzUNnAE7hJkr
         N8u9EtWId4CNnvU9sf2UIYJKK/91kqto6cPWMEOIYb/gkXMSps6xKX28m20aibsE3mBr
         VDOhSnMNyA3R6tzYwNFOIs+YNklblSN7U6U+J0VihswubYFQLsNzqwS3UBvEJN0Nmyec
         HCZ9oNIHzuiIWpY4buwK5YObY3wfTIKU2KeM1O1PBayhixMlEDFN+hepJR39diyLQrNe
         XVKVCKfT0Vtq0ecgex0eZJ8WyKiBOnEvPK9MzoVIcOBcpkOCekthdDwUuQ0Fn7V4VMJt
         toXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9QfXOnDQXBcVNRGuammJHFxREgoMLaRZ+ETyqz3mSr4=;
        b=Twhdj7rYQZ95HuUZ+2re7mTy+hjGRyT9WCcqgb07UXYbycJsdJFyKqxqrFbJ5G1MDl
         bSNPGTH0RP5wG0wsW23QpuV8aV7uOryrkeL9HPTjQbzBdPm1WkSIblH9gJf+c/R3puT1
         z0lVTEvR+ZYxB43m++fUp+4Ph/H345onrw81iOsM+Unmogl67rPskrwbOO6WY6v2H8ZR
         pHKGn2uPNYnXQHNDxohhprozgHRJVUgIXSa7ix6ThJ8dRsUqheB7VN+PW11PZgoPXCtH
         djlSuoWH3NKbSyJ9gXzgFJy2Yo/DRmqtbBVUAr25traiQpyCuN41EITSWfNqdbtwMsze
         iMyA==
X-Gm-Message-State: AOAM532Y9fJwYQkYwfaK6jVMA+JH9FwtE8i1t3adiU0HCInAbbSXj+ZK
        UAA+4IFpMq9Z6G8MEffr2dQ2DA==
X-Google-Smtp-Source: ABdhPJwGO33+14WKujPnINCQQRxu9coWEviCw1QTjdn6wzLYUL8K2FoZeAWtCeVe/xzwjeL4Ge2htA==
X-Received: by 2002:a17:902:b70d:b029:da:5196:1181 with SMTP id d13-20020a170902b70db02900da51961181mr232870pls.81.1606949320011;
        Wed, 02 Dec 2020 14:48:40 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id q4sm98773pgl.14.2020.12.02.14.48.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:48:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <317E7E03-9620-4610-8DA5-63221FE41F04@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B03EA783-7B75-4554-A00C-B7E221071E74";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/9] ext4: don't call fscrypt_get_encryption_info() from
 dx_show_leaf()
Date:   Wed, 2 Dec 2020 15:48:37 -0700
In-Reply-To: <20201125002336.274045-5-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-5-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_B03EA783-7B75-4554-A00C-B7E221071E74
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> The call to fscrypt_get_encryption_info() in dx_show_leaf() is too low
> in the call tree; fscrypt_get_encryption_info() should have already been
> called when starting the directory operation.  And indeed, it already
> is.  Moreover, the encryption key is guaranteed to already be available
> because dx_show_leaf() is only called when adding a new directory entry.
> 
> And even if the key wasn't available, dx_show_leaf() uses
> fscrypt_fname_disk_to_usr() which knows how to create a no-key name.
> 
> So for the above reasons, and because it would be desirable to stop
> exporting fscrypt_get_encryption_info() directly to filesystems, remove
> the call to fscrypt_get_encryption_info() from dx_show_leaf().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/namei.c | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 793fc7db9d28..7b31aea3e025 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -643,13 +643,7 @@ static struct stats dx_show_leaf(struct inode *dir,
> 
> 				name  = de->name;
> 				len = de->name_len;
> -				if (IS_ENCRYPTED(dir))
> -					res = fscrypt_get_encryption_info(dir);
> -				if (res) {
> -					printk(KERN_WARNING "Error setting up"
> -					       " fname crypto: %d\n", res);
> -				}
> -				if (!fscrypt_has_encryption_key(dir)) {
> +				if (!IS_ENCRYPTED(dir)) {
> 					/* Directory is not encrypted */
> 					ext4fs_dirhash(dir, de->name,
> 						de->name_len, &h);
> --
> 2.29.2
> 


Cheers, Andreas






--Apple-Mail=_B03EA783-7B75-4554-A00C-B7E221071E74
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IGcUACgkQcqXauRfM
H+CFUQ/7BW3B4eOfjKM/CmfaV3AGSXDkVCxci+BVZOXQd5jPh0jD6P+vnNHrVvaJ
OrmL9sLLzlXw39gLrZk21geNwdDWRXvNSp+mY0TmTjDBGeTvrQQydNMziRYs6xcS
+Dei6c8LQA05JAqTDHbzV9rVRE/Xxbdsux09cUB21Agt3ruFi/90TPK7G6s3ObJD
Asbh05XZ1JqaZ8W65AUPlQzwqrLXL8WCS/Qkfp0nsXWvebKRdrDtJ8FaEPjiZkeF
rhS72LzdH8Arwc4kHVe1TVw4txY0su010X14LXUIQXZT8MjZrkbArOtPut+XMrpX
8IdD3KaUFhBAvB89fK2QIN62Y+RRiPkSXQFHCz/P/S/ruRjxnjaG57PesasV/D4D
4aYArbY8+QgrpbqY8AayIDZNqOkf9xMc5xD3nm5hjqN1htXPnHxozSUa31+CXRuC
nSb1MvlGtQX6j2cpXtTrrm4jwVKW8W4JhMaUBWmaUTKvxmZvfBpOQ6BSfaSBHuDW
2mgj4jQAiqw/9ZIMY9QYKjQZszI9CUXXZdstrqhJhoQM6z4etgh3yKkvnp2gR9QP
xSwGVQ6D8z+AECS7YLnZIgrVyK4Fb9Adha36LbjFyvt0+sRroXbtMsorXLorJmQi
30z/sqoYZ5O7zhIvTegvrIJZrjuX6XPT80DQqhswJFw2fteJFsQ=
=Ks9F
-----END PGP SIGNATURE-----

--Apple-Mail=_B03EA783-7B75-4554-A00C-B7E221071E74--
