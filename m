Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E97B4B91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjJBGkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 02:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjJBGkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:40:32 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4251E0
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 23:40:27 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45269fe9d6bso7693182137.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 23:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696228827; x=1696833627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1T0KzQctsPAaaSmeyqhlMcp4bbzWgYEbL0QOu/KV1c=;
        b=nHx/IgBDk7ro3UxL+RA00M13fhx83KmPZqpCBk6VBgrPxj/fnHtsiHgEzLNF2icdH1
         XmozxP8ePCh++VV5ZXkrlkt/3lwTpB3GVQOIUxNeCEeZpTUmJ/Ol2IqtOUgqWcI6b+bJ
         jYPWzLYQhq4he3Ud1GRft+s+K3MNrdOT6XtuAITs0KMwE7Uas7tiyQDSz/MN9qFIzRmo
         saK1rfADWIkoDdoXgTN+B/zh2ZI+BLrSp4uPMYCK0oqE5ainhvtns20NiUyN8siKn0kC
         E3XsbH9Ujmlx3yUIC3w6hqxjsaU0aW5vL/zTov6NBLxKKS6VFJ5LKM3Sd2qpGwll62Ex
         Ilgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696228827; x=1696833627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1T0KzQctsPAaaSmeyqhlMcp4bbzWgYEbL0QOu/KV1c=;
        b=a+OrGgO4mQd4z6uaIBk+k53Gs8c6ISlKpXK9GCrLbMsHAaZLUEOPxhkpDErqUIWGdW
         uRhK5r4CSCMu9aEFEbl3TzAcdEl4p5VUNW/rasWskPzwomEG8jSTVdBkAZEgirRdQpxv
         L4ujiT5DpISZgaj5d10HOVQmeOOLZZTpJlBGaYjwLTfoCt+HLSm4p1SA12fydGdgztDY
         A+7tv4ZQ0jIPxqR0pc40JIBBjPy8Tk51hxKPo/eSgxIh7gHjRYNajbia3oJC3D3Dus1o
         JuKK8387nLATSkguaSHwrGvczt266jkQ3vzo/ESUlAFm7oqwKFHa8yXngWojjpzcFGga
         EeVw==
X-Gm-Message-State: AOJu0Yy7UOcR1Go2Iw+0NIqMCfKVpMeCG/F7k5t698T2NwrLDjY1Rs0w
        zti3HKiJsMO3uMZaMksta74lHQYNghBHAl3LSfOeUBPvldQ=
X-Google-Smtp-Source: AGHT+IF7NexOqES+RVR0lt6gLfFpCR71vihsKrZIPuLV7KNeiEnqgOWKRED0kPgi+jLMxjIbRTBaLMH4Mdo+zELGtJY=
X-Received: by 2002:a05:6102:3e1f:b0:454:78c5:a848 with SMTP id
 j31-20020a0561023e1f00b0045478c5a848mr10033683vsv.27.1696228826898; Sun, 01
 Oct 2023 23:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023613.GN3389589@ZenIV> <20231002023643.GO3389589@ZenIV> <20231002023711.GP3389589@ZenIV>
In-Reply-To: <20231002023711.GP3389589@ZenIV>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 2 Oct 2023 09:40:15 +0300
Message-ID: <CAOQ4uxjAcKVGT03uDTNYiSoG2kSgT9eqbqjBThwTo7pF0jef4g@mail.gmail.com>
Subject: Re: [PATCH 15/15] overlayfs: make use of ->layers safe in rcu pathwalk
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 5:37=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
> freed without an RCU delay on fs shutdown.  Fortunately, kern_unmount_arr=
ay()
> used to drop those mounts does include an RCU delay, so freeing is
> delayed; unfortunately, the array passed to kern_unmount_array() is
> formed by mangling ->layers contents and that happens without any
> delays.
>
> Use a separate array instead; local if we have a few layers,
> kmalloc'ed if there's a lot of them.  If allocation fails,
> fall back to kern_unmount() for individual mounts; it's
> not a fast path by any stretch of imagination.

If that is the case, then having 3 different code paths seems
quite an excessive over optimization...

I think there is a better way -
layout the mounts array linearly in ofs->mounts[] to begin with,
remove .mnt out of ovl_layer and use ofs->mounts[layer->idx] to
get to a layer's mount.

I can try to write this patch to see how it ends up looking.

Thanks,
Amir.

>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/overlayfs/ovl_entry.h |  1 -
>  fs/overlayfs/params.c    | 26 ++++++++++++++++++++------
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index e9539f98e86a..618b63bb7987 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -30,7 +30,6 @@ struct ovl_sb {
>  };
>
>  struct ovl_layer {
> -       /* ovl_free_fs() relies on @mnt being the first member! */
>         struct vfsmount *mnt;
>         /* Trap in ovl inode cache */
>         struct inode *trap;
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index b9355bb6d75a..ab594fd407b4 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -738,8 +738,15 @@ int ovl_init_fs_context(struct fs_context *fc)
>  void ovl_free_fs(struct ovl_fs *ofs)
>  {
>         struct vfsmount **mounts;
> +       struct vfsmount *m[16];
> +       unsigned n =3D ofs->numlayer;
>         unsigned i;
>
> +       if (n > 16)
> +               mounts =3D kmalloc_array(n, sizeof(struct mount *), GFP_K=
ERNEL);
> +       else
> +               mounts =3D m;
> +
>         iput(ofs->workbasedir_trap);
>         iput(ofs->indexdir_trap);
>         iput(ofs->workdir_trap);
> @@ -752,14 +759,21 @@ void ovl_free_fs(struct ovl_fs *ofs)
>         if (ofs->upperdir_locked)
>                 ovl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
>
> -       /* Hack!  Reuse ofs->layers as a vfsmount array before freeing it=
 */
> -       mounts =3D (struct vfsmount **) ofs->layers;

If we are getting rid of the hack, we should remove the associated
static_assert() statements in ovl_entry.h.

> -       for (i =3D 0; i < ofs->numlayer; i++) {
> +       for (i =3D 0; i < n; i++) {
>                 iput(ofs->layers[i].trap);
> -               mounts[i] =3D ofs->layers[i].mnt;
> -               kfree(ofs->layers[i].name);
> +               if (unlikely(!mounts))
> +                       kern_unmount(ofs->layers[i].mnt);
> +               else
> +                       mounts[i] =3D ofs->layers[i].mnt;
>         }
> -       kern_unmount_array(mounts, ofs->numlayer);
> +       if (mounts) {
> +               kern_unmount_array(mounts, n);
> +               if (mounts !=3D m)
> +                       kfree(mounts);
> +       }
> +       // by this point we had an RCU delay from kern_unmount{_array,}()
> +       for (i =3D 0; i < n; i++)
> +               kfree(ofs->layers[i].name);
>         kfree(ofs->layers);
>         for (i =3D 0; i < ofs->numfs; i++)
>                 free_anon_bdev(ofs->fs[i].pseudo_dev);
> --
> 2.39.2
>
