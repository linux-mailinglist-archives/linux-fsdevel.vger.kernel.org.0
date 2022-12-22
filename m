Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF965434E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiLVOoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 09:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiLVOn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:43:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D207C2CC96;
        Thu, 22 Dec 2022 06:43:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so1862289wrs.6;
        Thu, 22 Dec 2022 06:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAa8j/qMYzXSJhGaDVvZ4VuFGxT3bDBHZw9aNEGawes=;
        b=eKs+TyyhWeFY1d+krY8Wmg/jmw7xMqZ+dzhxUqhC344ILJouLOKl8x8GyPSw4y5lBl
         SClk2fT1mX4p7m/moxyMcugReqB5/OsnwqA3YlHcLAIf97rlB76krMkr9cQxG0TeeNJb
         EBvAVwlX3XwCZEKC/M6mhTM3/xt31kCWLSI2LU4em9npDVUpmxK9AXkc2I1GnFWuRphI
         i+a44q6jITu2KV/ntzYtZ0u1zLA8J5YjR0kQT57Dylk9yLPjDRBkCiMuHsZ7MP+NdcwS
         sEiTXRDdEutCT1NzCkaf/pKk9zrt8a1EgJJ5BkDyCchR9BW2/hDiqH9ViDxwGm2XgCFY
         2uKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAa8j/qMYzXSJhGaDVvZ4VuFGxT3bDBHZw9aNEGawes=;
        b=JDMYgHrWUxiy8QDVSERvuGf5U9+hKc4TEDqtdCp8+X8B0XdXUiugM2iA+jEVAiKS3/
         t6u1oEy7U/r5fduL8+zjP0NvSDRHTwXUlVwyT6EnIpcwubV8nluiNjlb5rq0S38BX2YU
         9hS0YwDsqhAD6d8Foigvpmwh7k7tADc3MF4B3Eytf2HR2S+GcniuvppJf7r6mOO0SPme
         49DGskXiw0dtIDk3UxOEns0Os4pDOEZ0vzgRd5d592OolLlGS4dMHjPp42C6i+MUTSdV
         kLhp8rGQr+bF6JcfNMlxuscIUSpLQQ+xS9i+/3KXneXWOWN9OXtb/WTHAe5EDrA23tDh
         PQZg==
X-Gm-Message-State: AFqh2kqrs6bpSrY0u2x+tq8ieSput4FqwrqoX1SGTNbb/eGbBwN+bXBO
        R9HQbs/N0cYhZl0s4QYtiHQ=
X-Google-Smtp-Source: AMrXdXv3ZKh8d/b6pp/eiEUmOFSHgiZYPcnqngqh9Z7znob0+oJ+faGFY8WpUe1aNLwD7UKkpFVwXA==
X-Received: by 2002:adf:a4c3:0:b0:242:7279:a56b with SMTP id h3-20020adfa4c3000000b002427279a56bmr3945470wrb.56.1671720236318;
        Thu, 22 Dec 2022 06:43:56 -0800 (PST)
Received: from suse.localnet (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003d237d60318sm1401913wmo.2.2022.12.22.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:43:55 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] fs/ufs: Change the signature of ufs_get_page()
Date:   Thu, 22 Dec 2022 15:43:54 +0100
Message-ID: <2786049.Y6S9NjorxK@suse>
In-Reply-To: <Y6Pnh98KZj0D+FUR@iweiny-desk3>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
 <20221221172802.18743-3-fmdefrancesco@gmail.com>
 <Y6Pnh98KZj0D+FUR@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 22 dicembre 2022 06:13:43 CET Ira Weiny wrote:
> On Wed, Dec 21, 2022 at 06:28:01PM +0100, Fabio M. De Francesco wrote:
> > Change the signature of ufs_get_page() in order to prepare this function
> > to the conversion to the use of kmap_local_page(). Change also those ca=
ll
> > sites which are required to conform its invocations to the new
> > signature.
> >=20
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> >  fs/ufs/dir.c | 49 +++++++++++++++++++++----------------------------
> >  1 file changed, 21 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> > index 69f78583c9c1..9fa86614d2d1 100644
> > --- a/fs/ufs/dir.c
> > +++ b/fs/ufs/dir.c
> > @@ -185,7 +185,7 @@ static bool ufs_check_page(struct page *page)
> >=20
> >  	return false;
> > =20
> >  }
> >=20
> > -static struct page *ufs_get_page(struct inode *dir, unsigned long n)
> > +static void *ufs_get_page(struct inode *dir, unsigned long n, struct p=
age
> > **p)>=20
> >  {
> > =20
> >  	struct address_space *mapping =3D dir->i_mapping;
> >  	struct page *page =3D read_mapping_page(mapping, n, NULL);
> >=20
> > @@ -195,8 +195,10 @@ static struct page *ufs_get_page(struct inode *dir,
> > unsigned long n)>=20
> >  			if (!ufs_check_page(page))
> >  		=09
> >  				goto fail;
> >  	=09
> >  		}
> >=20
> > +		*p =3D page;
> > +		return page_address(page);
> >=20
> >  	}
> >=20
> > -	return page;
> > +	return ERR_CAST(page);
> >=20
> >  fail:
> >  	ufs_put_page(page);
> >=20
> > @@ -227,15 +229,12 @@ ufs_next_entry(struct super_block *sb, struct
> > ufs_dir_entry *p)>=20
> >  struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
> >  {
> >=20
> > -	struct page *page =3D ufs_get_page(dir, 0);
> > -	struct ufs_dir_entry *de =3D NULL;
> > +	struct ufs_dir_entry *de =3D ufs_get_page(dir, 0, p);
>=20
> I don't know why but ufs_get_page() returning an address read really odd =
to
> me. But rolling around my head alternative names nothing seems better than
> this.

ufs_get_kaddr()?

> > -	if (!IS_ERR(page)) {
> > -		de =3D ufs_next_entry(dir->i_sb,
> > -				    (struct ufs_dir_entry=20
*)page_address(page));
> > -		*p =3D page;
> > -	}
> > -	return de;
> > +	if (!IS_ERR(de))
> > +		return ufs_next_entry(dir->i_sb, de);
> > +	else
> > +		return NULL;
> >=20
> >  }
> > =20
> >  /*
> >=20
> > @@ -273,11 +272,10 @@ struct ufs_dir_entry *ufs_find_entry(struct inode
> > *dir, const struct qstr *qstr,>=20
> >  		start =3D 0;
> >  =09
> >  	n =3D start;
> >  	do {
> >=20
> > -		char *kaddr;
> > -		page =3D ufs_get_page(dir, n);
> > -		if (!IS_ERR(page)) {
> > -			kaddr =3D page_address(page);
> > -			de =3D (struct ufs_dir_entry *) kaddr;
> > +		char *kaddr =3D ufs_get_page(dir, n, &page);
> > +
> > +		if (!IS_ERR(kaddr)) {
> > +			de =3D (struct ufs_dir_entry *)kaddr;
> >=20
> >  			kaddr +=3D ufs_last_byte(dir, n) - reclen;
> >  			while ((char *) de <=3D kaddr) {
> >  		=09
> >  				if (ufs_match(sb, namelen, name, de))
> >=20
> > @@ -328,12 +326,10 @@ int ufs_add_link(struct dentry *dentry, struct in=
ode
> > *inode)>=20
> >  	for (n =3D 0; n <=3D npages; n++) {
> >  =09
> >  		char *dir_end;
> >=20
> > -		page =3D ufs_get_page(dir, n);
> > -		err =3D PTR_ERR(page);
> > -		if (IS_ERR(page))
> > -			goto out;
> > +		kaddr =3D ufs_get_page(dir, n, &page);
> > +		if (IS_ERR(kaddr))
> > +			return PTR_ERR(kaddr);
> >=20
> >  		lock_page(page);
> >=20
> > -		kaddr =3D page_address(page);
> >=20
> >  		dir_end =3D kaddr + ufs_last_byte(dir, n);
> >  		de =3D (struct ufs_dir_entry *)kaddr;
> >  		kaddr +=3D PAGE_SIZE - reclen;
> >=20
> > @@ -395,7 +391,6 @@ int ufs_add_link(struct dentry *dentry, struct inode
> > *inode)>=20
> >  	/* OFFSET_CACHE */
> > =20
> >  out_put:
> >  	ufs_put_page(page);
> >=20
> > -out:
> >  	return err;
> > =20
> >  out_unlock:
> >  	unlock_page(page);
> >=20
> > @@ -429,6 +424,7 @@ ufs_readdir(struct file *file, struct dir_context=20
*ctx)
> >=20
> >  	unsigned chunk_mask =3D ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
> >  	bool need_revalidate =3D !inode_eq_iversion(inode, file->f_version);
> >  	unsigned flags =3D UFS_SB(sb)->s_flags;
> >=20
> > +	struct page *page;
>=20
> NIT: Does page now leave the scope of the for loop?
>=20

Strange...
I can't say why I did so.

> >  	UFSD("BEGIN\n");
> >=20
> > @@ -439,16 +435,14 @@ ufs_readdir(struct file *file, struct dir_context
> > *ctx)
> >=20
> >  		char *kaddr, *limit;
> >  		struct ufs_dir_entry *de;
>=20
> Couldn't that be declared here?

Yes, it could :-)

> Regardless I don't think this is broken.

Since I have to submit a new version of this series, there's no problem mov=
ing=20
the declaration of "page" back into the loop.

> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks,

=46abio
>
> > -		struct page *page =3D ufs_get_page(inode, n);
> > -
> > -		if (IS_ERR(page)) {
> > +		kaddr =3D ufs_get_page(inode, n, &page);
> > +		if (IS_ERR(kaddr)) {
> >=20
> >  			ufs_error(sb, __func__,
> >  		=09
> >  				  "bad page in #%lu",
> >  				  inode->i_ino);
> >  		=09
> >  			ctx->pos +=3D PAGE_SIZE - offset;
> >  			return -EIO;
> >  	=09
> >  		}
> >=20
> > -		kaddr =3D page_address(page);
> >=20
> >  		if (unlikely(need_revalidate)) {
> >  	=09
> >  			if (offset) {
> >  		=09
> >  				offset =3D ufs_validate_entry(sb, kaddr,=20
offset, chunk_mask);
> >=20
> > @@ -595,12 +589,11 @@ int ufs_empty_dir(struct inode * inode)
> >=20
> >  	for (i =3D 0; i < npages; i++) {
> >  =09
> >  		char *kaddr;
> >  		struct ufs_dir_entry *de;
> >=20
> > -		page =3D ufs_get_page(inode, i);
> >=20
> > -		if (IS_ERR(page))
> > +		kaddr =3D ufs_get_page(inode, i, &page);
> > +		if (IS_ERR(kaddr))
> >=20
> >  			continue;
> >=20
> > -		kaddr =3D page_address(page);
> >=20
> >  		de =3D (struct ufs_dir_entry *)kaddr;
> >  		kaddr +=3D ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
> >=20
> > --
> > 2.39.0




