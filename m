Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF68670F913
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjEXOtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjEXOtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 10:49:18 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F49B12F;
        Wed, 24 May 2023 07:49:17 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-439719278f9so48030137.2;
        Wed, 24 May 2023 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684939756; x=1687531756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N5qlYmiAXWULktRKXG/UhCtGDwPSyTxe/ySUVnkDwY=;
        b=dBC6KAHXClWFNV9kX0MloX3nIqucuJo05hM/8GvICpqF28QpnnqJOmaAQlwqMX/O9j
         2GOukayqhspD5qhn6UZzsJygD0RLGBIwhbCeknmRRvLt3bkKNCR/Ez6X+ClBnDFspeuC
         jAFtkYzQK+ed/CTpxtNQguk6tIcx9LMhCh8BksapC51YC2sKCsifbKwb6GKnUZj8xJ3Z
         k1o+bEairdfEH/W8P/mCkddEm3bjyoxc3nopSiqBCjrED9zrOEP5xXGJ6H9XxtgayTLV
         VEDFMrrpgBBLHZ/MfwkONNlkS6HEGW//MkoFhAb3lA/b0tYYLXz87kA5xFCOHrKJdZhX
         hNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939756; x=1687531756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N5qlYmiAXWULktRKXG/UhCtGDwPSyTxe/ySUVnkDwY=;
        b=N+n3jSv1yemIqNAN/ErSWFlaR8YJH2L+rtXCI/GVBbAzGox/LQpLPvf0wtbihCPhYU
         uZ9ntPthPkDM62bGk0K+5XPTXF1xoYM3JyVVbUPE6INzhiN1BkEAuS+66eYRskTziHQ2
         l0WnqS6RG80ShTAaDiHLG6HlVN64eKx6VVa8I5EtrY5Cp7Jm6Wg3oiSRpJpzqe6iNTzc
         nU0hY+iYZshjq1hjfu/PXXFPuQN/6Nx5G9O05JRfcoay1BdU+0Ume2FFmrCr0KwSpDnT
         CZqQ+vHTAk48yua76f4DHTXtobLk7k46U77so11XQ39CFzqMhfHFfeWhFHV14x0EzKg6
         Y+Nw==
X-Gm-Message-State: AC+VfDzHy/ymhMLsqMDqjeTEdR6jVwgfoGslHpKOTG+kkUaBja7BJkbZ
        q1gfTm4BUPJBlx4rkS0ilNFUDXhR0iSYJS3yvi2tx07K
X-Google-Smtp-Source: ACHHUZ5Na276cn6Z2FClsw695iYfEQWJzknvW+PQdi10nmwcQGnL6GhG54r2n63B2Jhww5r8YgNJF2I8O8W3J2twdN0=
X-Received: by 2002:a67:f101:0:b0:439:30df:6bb1 with SMTP id
 n1-20020a67f101000000b0043930df6bb1mr5753497vsk.1.1684939756394; Wed, 24 May
 2023 07:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
 <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com> <20230524140648.u6pexxspze7pz63z@quack3>
In-Reply-To: <20230524140648.u6pexxspze7pz63z@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 May 2023 17:49:05 +0300
Message-ID: <CAOQ4uxjhYajALo2fGzmcF6F84o_jvKnDcadUvfc+R=RrT-i8YA@mail.gmail.com>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file handles
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 5:06=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 24-05-23 11:38:17, Amir Goldstein wrote:
> > On Wed, May 24, 2023 at 9:34=E2=80=AFAM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > Hello Amir Goldstein,
> > >
> > > The patch 7ba39960c7f3: "fanotify: support reporting non-decodeable
> > > file handles" from May 2, 2023, leads to the following Smatch static
> > > checker warning:
> > >
> > >         fs/notify/fanotify/fanotify.c:451 fanotify_encode_fh()
> > >         warn: assigning signed to unsigned: 'fh->type =3D type' 's32m=
in-(-1),1-254,256-s32max'
> > >
> > > (unpublished garbage Smatch check).
> > >
> > > fs/notify/fanotify/fanotify.c
> > >     403 static int fanotify_encode_fh(struct fanotify_fh *fh, struct =
inode *inode,
> > >     404                               unsigned int fh_len, unsigned i=
nt *hash,
> > >     405                               gfp_t gfp)
> > >     406 {
> > >     407         int dwords, type =3D 0;
> > >     408         char *ext_buf =3D NULL;
> > >     409         void *buf =3D fh->buf;
> > >     410         int err;
> > >     411
> > >     412         fh->type =3D FILEID_ROOT;
> > >     413         fh->len =3D 0;
> > >     414         fh->flags =3D 0;
> > >     415
> > >     416         /*
> > >     417          * Invalid FHs are used by FAN_FS_ERROR for errors no=
t
> > >     418          * linked to any inode. The f_handle won't be reporte=
d
> > >     419          * back to userspace.
> > >     420          */
> > >     421         if (!inode)
> > >     422                 goto out;
> > >     423
> > >     424         /*
> > >     425          * !gpf means preallocated variable size fh, but fh_l=
en could
> > >     426          * be zero in that case if encoding fh len failed.
> > >     427          */
> > >     428         err =3D -ENOENT;
> > >     429         if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4) || fh_len =
> MAX_HANDLE_SZ)
> > >     430                 goto out_err;
> > >     431
> > >     432         /* No external buffer in a variable size allocated fh=
 */
> > >     433         if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
> > >     434                 /* Treat failure to allocate fh as failure to=
 encode fh */
> > >     435                 err =3D -ENOMEM;
> > >     436                 ext_buf =3D kmalloc(fh_len, gfp);
> > >     437                 if (!ext_buf)
> > >     438                         goto out_err;
> > >     439
> > >     440                 *fanotify_fh_ext_buf_ptr(fh) =3D ext_buf;
> > >     441                 buf =3D ext_buf;
> > >     442                 fh->flags |=3D FANOTIFY_FH_FLAG_EXT_BUF;
> > >     443         }
> > >     444
> > >     445         dwords =3D fh_len >> 2;
> > >     446         type =3D exportfs_encode_fid(inode, buf, &dwords);
> > >     447         err =3D -EINVAL;
> > >     448         if (!type || type =3D=3D FILEID_INVALID || fh_len !=
=3D dwords << 2)
> > >
> > > exportfs_encode_fid() can return negative errors.  Do we need to chec=
k
> > > if (!type etc?
> >
> > Well, it is true that exportfs_encode_fid() can return a negative value
> > in principle, as did exportfs_encode_fh() before it, if there was a
> > filesystem implementation of ->encode_fh() that returned a negative
> > value.  AFAIK, there currently is no such implementation in-tree,
> > otherwise current upstream code would have been buggy.
>
> Yes, I've checked and all ->encode_fh() implementations return
> FILEID_INVALID in case of problems (which are basically always only
> problems with not enough space in the handle buffer).
>
> > Patch 2/4 adds a new possible -EOPNOTSUPP return value from
> > exportfs_encode_inode_fh() and even goes further to add a kerndoc:
> >  * Returns an enum fid_type or a negative errno.
> > But this new return value is not possible from exportfs_encode_fid()
> > that is used here and in {fa,i}notify_fdinfo().
> >
> > All the rest of the callers (nfsd, overlayfs, name_to_hanle_at) already
> > check this same EOPNOTSUPP condition before calling, but there is
> > no guarantee that this will not change in the future.
> >
> > All the callers mentioned above check the unexpected return value diffe=
rently:
> > nfsd: only type =3D=3D FILEID_INVALID
> > fdinfo: type < 0 || type =3D=3D FILEID_INVALID
> > fanotify: !type || type =3D=3D FILEID_INVALID
> > overlayfs: type < 0 || type =3D=3D FILEID_INVALID
> > name_to_hanle_at: (retval =3D=3D FILEID_INVALID) || (retval =3D=3D -ENO=
SPC))
> >                 /* As per old exportfs_encode_fh documentation
> >                  * we could return ENOSPC to indicate overflow
> >                  * But file system returned 255 always. So handle
> >                  * both the values
> >                  */
> >
> > So he have a bit of a mess.
>
> Yeah, it's a bit messy. When checking ->encode_fh() implementations I've
> also noticed quite some callers use explicit numbers and not FILEID_*
> enums. This is not directly related to the problem at hand but I'm voicin=
g
> it in case someone looks for an easy cleanup project :)
>
> > How should we clean it up?
> >
> > Option #1: Change encode_fh to return unsigned and replace that new
> >                   EOPNOTSUPP with FILEID_INVALID
> > Option #2: change all callers to check negative return value
> >
> > I am in favor of option #2.
> > Shall I send a patch?
>
> When we have two different error conditions (out of buffer space, encodin=
g
> handles unsupported), I agree it makes sense to be able to differentiate
> them in exportfs_encode_fh() return value. However then it would make sen=
se
> to properly return -ENOSPC instead of FILEID_INVALID (as it is strange to
> have two different ways of indicating error) which means touching like 16
> different .encode_fh implementations. Not too bad but a bit tedious...

I would prefer leaving that to that "cleanup project" (maybe I will take
it on one day), but even if we leave the fs implementations as is (not
returning negative values) I think we should at least fortify the callers t=
hat
assume no negative return values.

I will send a patch and we will see the reaction.

Thanks,
Amir.
