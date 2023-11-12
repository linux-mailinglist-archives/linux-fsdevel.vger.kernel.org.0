Return-Path: <linux-fsdevel+bounces-2767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18297E8EEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 08:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 477D3B2096A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AAA5397;
	Sun, 12 Nov 2023 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2bROzAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B133E1
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 07:26:43 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A92D57;
	Sat, 11 Nov 2023 23:26:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41f155c862bso22707201cf.2;
        Sat, 11 Nov 2023 23:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699774001; x=1700378801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9nUY4k/7oE2vgXYBilWa/wCffSLxwwt+2LJzdriyvA=;
        b=i2bROzALuzkLUz3ywNkAxU1dcY/Vvtz6oRu+gUhNhsh0WnswlCQi5G/Rwo0kXY89BM
         9yfM+hwKg1pcfkt1/36tKP5JNMB9DnCg9ORANCBDPEbe9acvJsrsjqnvbDavqGGyW5F3
         4CJv/AG1uRKp1nyHe5Ua5fZq4L42VDc10wX4T1HzsX55PSZjB/zChFpeUCOdc/wuZ2kr
         uZh8pD+ZDU94rjd+ws0mIMXWWjOkYmcHB1FvAEEmfEZDwBydQ0uPOX80Ly5TM6uLmxVb
         yyu7RrIwCeq1OzDBTgpdRyX3ehhehraNyK2QComJp6uJPpGg46jkU4fvQrIuAvaFZBwD
         dt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699774001; x=1700378801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9nUY4k/7oE2vgXYBilWa/wCffSLxwwt+2LJzdriyvA=;
        b=enXJV0jwzFC4NG1iswYk7m0NeryeT15B/pG0sUK/8U+FiafajNpvUbcvPVZX+TOMTm
         lpKNoRhsFCjb/cZY6iHwm6WvwbyLElfMbWW7VmLalGWbDJAU5Wq/J9aXb2mt7IL7bYTS
         x0CY+w145yQC4KKUApOrzTGWhAJwcDGRTveym9gbFH3KvW1U8ZrhOubkSOZNBiGd6opb
         LM2O2oTtULDJe6HwffiCqhhZ/HGSEHrmm7cWS9MvlChJ6TXvQXqaRO+nYS02Dl1uILW0
         SWpASuKwJWOUe8jAL9Wl4OSHl4vYTKEUHjROqBMoP+YR7PpPvJWw34zIxkKwbGpzeLJJ
         mMSw==
X-Gm-Message-State: AOJu0YxSRtJWR7zO6IYIYs1Ils6cmnGlqEzUxtlpbPfsIEiS1fi5Y9ca
	V81wrWhY6sbfFogU5ooRoqDiUbbMrYRL4ornWU3GyTuxH6I=
X-Google-Smtp-Source: AGHT+IFn6HZ47qgF2A7YEqAyx9gwi+gOzTYmm9YUlEBhfQtvp3I9kQXE/J8LZSEirMKbFsM96xwcqiBNdPAnUtxCwRs=
X-Received: by 2002:a05:622a:50a:b0:41e:3e18:e094 with SMTP id
 l10-20020a05622a050a00b0041e3e18e094mr5491473qtx.26.1699774001037; Sat, 11
 Nov 2023 23:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111080400.GO1957730@ZenIV> <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
 <20231111185034.GP1957730@ZenIV> <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 12 Nov 2023 09:26:28 +0200
Message-ID: <CAOQ4uxiJSum4a2F5FEA=a8JKwWh1XhFOpWaH8xas_uWKf+29cw@mail.gmail.com>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and export
 of d_alloc_anon()?
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 10:05=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Sat, Nov 11, 2023 at 8:50=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
> >
> > On Sat, Nov 11, 2023 at 08:31:11PM +0200, Amir Goldstein wrote:
> > > > in ovl_lookup(), and in case we have d_splice_alias() return a non-=
NULL
> > > > dentry we can simply copy it there.  Sure, somebody might race with
> > > > us, pick dentry from hash and call ->d_revalidate() before we notic=
e that
> > > > DCACHE_OP_REVALIDATE could be cleaned.  So what?  That call of ->d_=
revalidate()
> > > > will find nothing to do and return 1.  Which is the effect of havin=
g
> > > > DCACHE_OP_REVALIDATE cleared, except for pointless method call.  An=
yone
> > > > who finds that dentry after the flag is cleared will skip the call.
> > > > IOW, that race is harmless.
> > >
> > > Just a minute.
> > > Do you know that ovl_obtain_alias() is *only* used to obtain a discon=
nected
> > > non-dir overlayfs dentry?
> >
> > D'oh...
> >
> > > I think that makes all the analysis regarding race with d_splice_alia=
s()
> > > moot. Right?
> >
> > Right you are.
> >
> > > Do DCACHE_OP_*REVALIDATE even matter for a disconnected
> > > non-dir dentry?
> >
> > As long as nothing picks it via d_find_any_alias() and moves it somewhe=
re
> > manually.  The former might happen, the latter, AFAICS, doesn't - nothi=
ng
> > like d_move() anywhere in sight...
> >
> > > You are missing that the OVL_E_UPPER_ALIAS flag is a property of
> > > the overlay dentry, not a property of the inode.
> > >
> > > N lower hardlinks, the first copy up created an upper inode
> > > all the rest of the N upper aliases to that upper inode are
> > > created lazily.
> > >
> > > However, for obvious reasons, OVL_E_UPPER_ALIAS is not
> > > well defined for a disconnected overlay dentry.
> > > There should not be any code (I hope) that cares about
> > > OVL_E_UPPER_ALIAS for a disconnected overlay dentry,
> > > so I *think* ovl_dentry_set_upper_alias() in this code is moot.
> > >
> > > I need to look closer to verify, but please confirm my assumption
> > > regarding the irrelevance of  DCACHE_OP_*REVALIDATE for a
> > > disconnected non-dir dentry.
> >
> > Correct; we only care if it gets reconnected to the main tree.
> > The fact that it's only for non-directories simplifies life a lot
> > there.  Sorry, got confused by the work you do with ->d_flags
> > and hadn't stopped to ask whether it's needed in the first place
> > in there.
> >
> > OK, so... are there any reasons why simply calling d_obtain_alias()
> > wouldn't do the right thing these days?
>
> None that I can think of.
>
> I will try it out and run the tests to see if I have missed something.
>

Tested the patch below.
If you want to apply it as part of dcache cleanup, it's fine by me.
Otherwise, I will queue it for the next overlayfs update.

Thanks,
Amir.

From 3415a62597161b03b2db48ca195af34d25afc5d5 Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 12 Nov 2023 08:55:57 +0200
Subject: [PATCH] ovl: stop using d_alloc_anon()/d_instantiate_anon()

Commit f9c34674bc60 ("vfs: factor out helpers d_instantiate_anon() and
d_alloc_anon()") was introduced so overlayfs could initialize a non-dir
disconnected overlay dentry before overlay inode is attached to it.

Since commit ("0af950f57fef ovl: move ovl_entry into ovl_inode"), all
ovl_obtain_alias() can do is set DCACHE_OP_*REVALIDATE flags in ->d_flags
and OVL_E_UPPER_ALIAS flag in ->d_fsdata.

The DCACHE_OP_*REVALIDATE flags and OVL_E_UPPER_ALIAS flag are irrelevant
for a disconnected non-dir dentry, so it is better to use d_obtain_alias()
instead of open coding it.

Since it has no more users, remove d_instantiate_anon() and do not export
d_alloc_anon().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/dcache.c            |  7 -------
 fs/overlayfs/export.c  | 22 +---------------------
 include/linux/dcache.h |  1 -
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..8afa9d2b636f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1866,7 +1866,6 @@ struct dentry *d_alloc_anon(struct super_block *sb)
 {
        return __d_alloc(sb, NULL);
 }
-EXPORT_SYMBOL(d_alloc_anon);

 struct dentry *d_alloc_cursor(struct dentry * parent)
 {
@@ -2115,12 +2114,6 @@ static struct dentry
*__d_instantiate_anon(struct dentry *dentry,
        return res;
 }

-struct dentry *d_instantiate_anon(struct dentry *dentry, struct inode *ino=
de)
-{
-       return __d_instantiate_anon(dentry, inode, true);
-}
-EXPORT_SYMBOL(d_instantiate_anon);
-
 static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnec=
ted)
 {
        struct dentry *tmp;
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 7e16bbcad95e..f2f41d4fb5d4 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -320,27 +320,7 @@ static struct dentry *ovl_obtain_alias(struct
super_block *sb,
        if (upper)
                ovl_set_flag(OVL_UPPERDATA, inode);

-       dentry =3D d_find_any_alias(inode);
-       if (dentry)
-               goto out_iput;
-
-       dentry =3D d_alloc_anon(inode->i_sb);
-       if (unlikely(!dentry))
-               goto nomem;
-
-       if (upper_alias)
-               ovl_dentry_set_upper_alias(dentry);
-
-       ovl_dentry_init_reval(dentry, upper, OVL_I_E(inode));
-
-       return d_instantiate_anon(dentry, inode);
-
-nomem:
-       dput(dentry);
-       dentry =3D ERR_PTR(-ENOMEM);
-out_iput:
-       iput(inode);
-       return dentry;
+       return d_obtain_alias(inode);
 }

 /* Get the upper or lower dentry in stack whose on layer @idx */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..c760553fb88a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -221,7 +221,6 @@ extern seqlock_t rename_lock;
 extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode =
*);
-extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *)=
;
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
--=20
2.34.1

