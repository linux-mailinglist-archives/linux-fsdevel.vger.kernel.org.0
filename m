Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C323A70C0A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjEVOCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 10:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjEVOCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 10:02:32 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CC3E53;
        Mon, 22 May 2023 07:00:21 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-43931d2b92eso942572137.2;
        Mon, 22 May 2023 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684764020; x=1687356020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEIsFZ8irdYi/r84zw/P7G0vXgtk/uWzE9ABb35GWWY=;
        b=pqM2tRNgow4mYTRczgh4sEK3eiXY0fD5ph8vUaSqn4GN4KZfaeurTtpkSIyubVxH1I
         YVL7LATdQBxUD9AfoUv0YaSQ1cWNNTWV6+ybH4yK3z7IzJDV5GpucCqsuCI5muRJyev6
         fsnf+WvCZctHlVJ4QRJOrUq4Dng7j+GqtlpVgxDCnL4yJ309QPdGk2n959jNhkCeNn+Q
         eMeKhSaxAFBFlCEeroPFzQ+46I5YIIBOtAlU7KjuccMcQ65HAfd2J1+0nBtD+HHUR5T4
         GVBsgHDapxb1Jt7w2PsMVrhkRbKR/OmkyjjyoiASOgdAyXVhc76NY6P9Mqhi7b/e6RBb
         C0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684764020; x=1687356020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEIsFZ8irdYi/r84zw/P7G0vXgtk/uWzE9ABb35GWWY=;
        b=BLWk/01NKQ6698tXrjHU7bB0CNnWJBXum4uli74XepYuFsK/m97cec3LaykkthJv71
         NR3wKfho90jKssfydEqB2JwUhoBLRbk74hEXUtjEyN5nQ3+nQ7yu8iad/YBwdxhO4o4g
         O/dIbXZwAFmvlEw8et0hzxV2TbsBZ84qytkLQUmudA1ZImFk54DjhYULmWaxwK3mj/Uj
         8CG58//t9rh9/J1dE+J1unddSdnv7s+/wvr3RX1J9d6LR2Ypu9vHb+Wv/k5lwKddYP8M
         cGUqd1QzRqrs9hfCLx9T9FxtqELfz4jXw/hqE4KCxuM5bug1FOD3Jyb53QHTHWj36tYV
         Hy7A==
X-Gm-Message-State: AC+VfDxPKoihGqjY/gDJhPN8OqC7i12URnnQBywZIhBSiPK46nfVvs0Z
        rIeUI8+KBqJAOILXnefLKgCPMQzUfXoi1FPvlpM=
X-Google-Smtp-Source: ACHHUZ7B4hMBeYBsVxL5wraCCIO1z1bJH8HaKsoApI4gs/rTg6c29bjtZp2N+rvlwHwjVxa8kjKbNrG9QV/AgCw/yEg=
X-Received: by 2002:a67:ff86:0:b0:434:6d1b:8b15 with SMTP id
 v6-20020a67ff86000000b004346d1b8b15mr2608457vsq.25.1684764020472; Mon, 22 May
 2023 07:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <CAOQ4uxi7PFPPUuW9CZAZB9tvU2GWVpmpdBt=EUYyw60K=WX-Yg@mail.gmail.com> <9aced306f134628221c55530643535b89874ccc0.camel@linux.ibm.com>
In-Reply-To: <9aced306f134628221c55530643535b89874ccc0.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 May 2023 17:00:09 +0300
Message-ID: <CAOQ4uxjjLLGQM5BUgDrFdghYsFgShNA6tDpvC8vNg_jOh9WGAQ@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
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

On Mon, May 22, 2023 at 3:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Sat, 2023-05-20 at 12:15 +0300, Amir Goldstein wrote:
> > On Fri, May 19, 2023 at 10:42=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > >
> > > On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> > > > So, I think we want both; we want the ovl_copyattr() and the
> > > > vfs_getattr_nosec() change:
> > > >
> > > > (1) overlayfs should copy up the inode version in ovl_copyattr(). T=
hat
> > > >     is in line what we do with all other inode attributes. IOW, the
> > > >     overlayfs inode's i_version counter should aim to mirror the
> > > >     relevant layer's i_version counter. I wouldn't know why that
> > > >     shouldn't be the case. Asking the other way around there doesn'=
t
> > > >     seem to be any use for overlayfs inodes to have an i_version th=
at
> > > >     isn't just mirroring the relevant layer's i_version.
> > > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > > >     Currently, ima assumes that it will get the correct i_version f=
rom
> > > >     an inode but that just doesn't hold for stacking filesystem.
> > > >
> > > > While (1) would likely just fix the immediate bug (2) is correct an=
d
> > > > _robust_. If we change how attributes are handled vfs_*() helpers w=
ill
> > > > get updated and ima with it. Poking at raw inodes without using
> > > > appropriate helpers is much more likely to get ima into trouble.
> > >
> > > In addition to properly setting the i_version for IMA, EVM has a
> > > similar issue with i_generation and s_uuid. Adding them to
> > > ovl_copyattr() seems to resolve it.   Does that make sense?
> > >
> > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > > index 923d66d131c1..cd0aeb828868 100644
> > > --- a/fs/overlayfs/util.c
> > > +++ b/fs/overlayfs/util.c
> > > @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
> > >         inode->i_atime =3D realinode->i_atime;
> > >         inode->i_mtime =3D realinode->i_mtime;
> > >         inode->i_ctime =3D realinode->i_ctime;
> > > +       inode->i_generation =3D realinode->i_generation;
> > > +       if (inode->i_sb)
> > > +               uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
> > > >s_uuid);
> >
> > That is not a possible solution Mimi.
> >
> > The i_gneration copy *may* be acceptable in "all layers on same fs"
> > setup, but changing overlayfs s_uuid over and over is a non-starter.
> >
> > If you explain the problem, I may be able to help you find a better sol=
ution.
>
> EVM calculates an HMAC of the file metadata (security xattrs, i_ino,
> i_generation, i_uid, i_gid, i_mode, s_uuid)  and stores it as
> security.evm.  Notrmally this would be used for mutable files, which
> cannot be signed.  The i_generation and s_uuid on the lower layer and
> the overlay are not the same, causing the EVM HMAC verification to
> fail.
>

OK, so EVM expects i_ino, i_generation, i_uid, i_gid, i_mode, s_uuid
and security xattr to remain stable and persistent (survive umount/mount).
Correct?

You cannot expect that the same EVM xattr will correctly describe both
the overlayfs inode and the underlying real fs inode, because they may
vary in some of the metadata, so need to decide if you only want to attest
overlayfs inodes, real underlying inodes or both.
If both, then the same EVM xattr cannot be used, but as it is, overlayfs
inode has no "private" xattr version, it stores its xattr on the underlying
real inode.

i_uid, i_gid, i_mode:
Should be stable and persistent for overlayfs inode and survive copy up.
Should be identical to the underlying inode.

security xattr:
Overlayfs tries to copy up all security.* xattr and also calls the LSM
hook security_inode_copy_up_xattr() to approve each copied xattr.
Should be identical to the underlying inode.

s_uuid:
So far, overlayfs sb has a null uuid.
With this patch, overlayfs will gain a persistent s_uuid, just like any
other disk fs with the opt-in feature index=3Don:
https://lore.kernel.org/linux-unionfs/20230425132223.2608226-4-amir73il@gma=
il.com/
Should be different from the underlying fs uuid when there is more
than one underlying fs.
We can consider inheriting s_uuid from underlying fs when all layers
are on the same fs.

i_ino:
As documented in:
https://github.com/torvalds/linux/blob/master/Documentation/filesystems/ove=
rlayfs.rst#inode-properties
It should be persistent and survive copy up with the
xino=3Dauto feature (module param or mount option) or
CONFIG_OVERLAY_FS_XINO_AUTO=3Dy
which is not the kernel default, but already set by some distros.
Will be identical to the underlying inode only in some special cases
such as pure upper (not copied up) inodes.
Will be different from the underlying lower file inode many in other cases.

i_generation:
For xino=3Dauto, we could follow the same rules as i_ino and get similar
qualities -
i_generation will become persistent and survive copy up, but it will not be
identical to the real underlying inode i_generation in many cases.

Bottom line:
If you only want to attest overlayfs inodes - shouldn't be too hard
If you want to attest both overlayfs inodes AND their backing "real" inodes=
 -
much more challenging.

Hope that this writeup helps more than it confuses.

Thanks,
Amir.
