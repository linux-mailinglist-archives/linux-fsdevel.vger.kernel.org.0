Return-Path: <linux-fsdevel+bounces-3136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE897F04CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 09:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86971F22138
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C45682;
	Sun, 19 Nov 2023 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+xpd1Oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292C131;
	Sun, 19 Nov 2023 00:19:21 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so8098256d6.0;
        Sun, 19 Nov 2023 00:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700381960; x=1700986760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNuXnTlSHam3h418dL4mSBk7yDgeovLaDNOcbSgaafs=;
        b=W+xpd1Oah3U/huFDbM4djaSMNbt5buy+k+E8Z2iR//49gGe9ZBmuPXz8Q00vtvZaej
         +8QSc73t7pCQE5c4hlSKke2/+1w2qGtsTb4DSNCxL0kmnk5sfFEQdaewwG83yW2RRRhF
         g3KS0P7wnV3s9l2xcxOQMgrCN94K/u4WDbr87OpUA7Uu4gWJzodCuhPv5EpqwEZfJXzu
         B2YFybMV3NFmjSFLG92WHnpS+6llKf8o/VDdx45+OPU7DxMDjC1dxidL3S5g3pe9g0uw
         M8m1H3KWgOb3pLdoyXQ/0XlIoNGvWvoiBEKaSLRo4E7nl5j26l/i5jjU+qkFBNXPBn8P
         TKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700381960; x=1700986760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNuXnTlSHam3h418dL4mSBk7yDgeovLaDNOcbSgaafs=;
        b=awa4yfwMAk/2zbIkRdpXhIuSKdqxBPDwEBQM5ZpVrW6reIuowasR8QkHQ47QltFhAK
         vQ1yvhPJ2o1oYXdvWPzj9iTvIrvA+Mss5VeuWRApVbaxMicWUqWHxkhHhVUTk47YiHdy
         0jcsg51nzfcQm6YMdhCLC8GPNQqhs4Qqn5S5KemOywgSSg+iEmRHHKj5uAVobtJhLTqn
         x4tHetzSIP0AMK4HhaOJR31baTwH7RN0BHHXkSDH/IpYKdymg/NK+MX4Nra/zZw78p/P
         e5YeIzBaa78TmDg+updPpt45eoJuAvUw7vDAIMJ0GVt4IpJyn4lJyrvOnmc0GV3pqiB7
         Qw2g==
X-Gm-Message-State: AOJu0YwVxL9EBASRexS46EYBGsuY7NJVxjYVG9FyCyODvrHkkY+JGhJL
	8XDg/Pw+LjOwNyM+OXkxDIoGTWPp+y3twsb5Nu4=
X-Google-Smtp-Source: AGHT+IEmdxPyAKsqqxA9UYNfx1FA7+1FtPpNbk64cnKpgOXH3AVhOKttQGpLrdtH9SfDyqPB8v5g4WKQDVfTZHXv9Ro=
X-Received: by 2002:a05:6214:5098:b0:66d:9945:5a93 with SMTP id
 kk24-20020a056214509800b0066d99455a93mr5934546qvb.9.1700381960302; Sun, 19
 Nov 2023 00:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111080400.GO1957730@ZenIV> <CAOQ4uxhQdHsegbwdqy_04eHVG+wkntA2g2qwt9wH8hb=-PtT2A@mail.gmail.com>
 <20231111185034.GP1957730@ZenIV> <CAOQ4uxjYaHk6rWUgvsFA4403Uk-hBqjGegV4CCOHZyh2LSYf4w@mail.gmail.com>
 <CAOQ4uxiJSum4a2F5FEA=a8JKwWh1XhFOpWaH8xas_uWKf+29cw@mail.gmail.com>
 <20231118200247.GF1957730@ZenIV> <CAOQ4uxjFrdKS3_yyeAcfemL-8dXm3JDWLwAmD9w3bY90=xfCjw@mail.gmail.com>
 <20231119072652.GA38156@ZenIV>
In-Reply-To: <20231119072652.GA38156@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Nov 2023 10:19:08 +0200
Message-ID: <CAOQ4uxiu_qY-cSh5FcbWMh8yF6mumik8Jsv3qeTQ4qPi+80Rrw@mail.gmail.com>
Subject: Re: [RFC][overlayfs] do we still need d_instantiate_anon() and export
 of d_alloc_anon()?
To: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 9:26=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Nov 19, 2023 at 08:57:25AM +0200, Amir Goldstein wrote:
> > On Sat, Nov 18, 2023 at 10:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > >
> > > On Sun, Nov 12, 2023 at 09:26:28AM +0200, Amir Goldstein wrote:
> > >
> > > > Tested the patch below.
> > > > If you want to apply it as part of dcache cleanup, it's fine by me.
> > > > Otherwise, I will queue it for the next overlayfs update.
> > >
> > > OK...  Let's do it that way - overlayfs part goes into never-rebased =
branch
> > > (no matter which tree), pulled into dcache series and into your overl=
ayfs
> > > update, with removal of unused stuff done in a separate patch in dcac=
he
> > > series.
> > >
> >
> > Sounds good.
> >
> > > That way we won't step on each other's toes when reordering, etc.
> > > Does that work for you?  I can put the overlayfs part into #no-rebase=
-overlayfs
> > > in vfs.git, or you could do it in a v6.7-rc1-based branch in your tre=
e -
> > > whatever's more convenient for you.
> >
> > I've reset overlayfs-next to no-rebase-overlayfs, as it  had my version
> > with removal so far.
> >
> > For the final update, I doubt I will need to include it at all, because
> > the chances of ovl_obtain_alias() colliding with anything for the next
> > cycle are pretty slim, but it's good that I have the option and I will
> > anyway make sure to always test the next update with this change.
>
> OK...  Several overlayfs locking questions:
> ovl_indexdir_cleanup()
> {
>         ...
>         inode_lock_nested(dir, I_MUTEX_PARENT);
>         ...
>                 index =3D ovl_lookup_upper(ofs, p->name, indexdir, p->len=
);
>                 ...
>                         err =3D ovl_cleanup_and_whiteout(ofs, dir, index)=
;
>
> with ovl_cleanup_and_whiteout() moving stuff between workdir and parent o=
f index.
> Where do you do lock_rename()?  It's a cross-directory rename, so it *mus=
t*
> lock both (and take ->s_vfs_rename_mutex as well).  How can that possibly
> work?

62a8a85be835 ovl: index dir act as work dir

If ofs->indexdir exists, then ofs->wokdir =3D=3D ofs->indexdir.

That's not very nice. I know.

I will kill ofs->indexdir and change ovl_indexdir() to do:

struct dentry *ovl_indexdir(struct super_block *sb)
{
        struct ovl_fs *ofs =3D OVL_FS(sb);
        return ofs->config.index ? ofs->workdir : NULL;
}


>
> Similar in ovl_cleanup_index() - you lock indexdir, then call
> ovl_cleanup_and_whiteout(), with the same locking issues.
>
> Another fun question: ovl_copy_up_one() has
>         if (parent) {
>                 ovl_path_upper(parent, &parentpath);
>                 ctx.destdir =3D parentpath.dentry;
>                 ctx.destname =3D dentry->d_name;
>
>                 err =3D vfs_getattr(&parentpath, &ctx.pstat,
>                                   STATX_ATIME | STATX_MTIME,
>                                   AT_STATX_SYNC_AS_STAT);
>                 if (err)
>                         return err;
>         }
> What stabilizes dentry->d_name here?  I might be missing something about =
the
> locking environment here, so it might be OK, but...

Honestly, I don't think that anything stabilizes it...
As long as this cannot result in UAF, we don't care,
because messing with upper fs directly yields undefined results.
But I suspect that we do need to take_dentry_name_snapshot()
to protect against UAF. Right?

Miklos, am I missing something?

Thanks,
Amir.

