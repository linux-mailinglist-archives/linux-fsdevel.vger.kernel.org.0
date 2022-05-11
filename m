Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B468C523CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 20:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiEKSyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiEKSym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 14:54:42 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141141FD86E;
        Wed, 11 May 2022 11:54:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kk28so2766060qvb.3;
        Wed, 11 May 2022 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LxdUKX99jhfa5s0+IuZGD3X6A7IS8PJuDjuEfLK+f0=;
        b=bBk0WndcC79iIOJVGislC1gFOlMn9191qToLtc9QQhfgBrD2lOQnIVa++hAR/TIW4O
         cZ8RrvbnkDJ6phgx46NW6WKSRoQpvL+kr2YHgZsNuIhmMvZxyNH4HrNJkAmjBZBgL9GW
         KZI1jCRv2YB3RF4PIRNhWY4znM0PJqM3fFN+5BziDZuJY5FYuXGGb51W3bH5VMDS3x/J
         oXlMM1SPLwGGt7Rw9h0XII6bRYJRJGt1rrUxAtlGnex++mz/nfetQdHjuES1hDk9QQjI
         9yB1Lz8L5NFOAerewXTmSZlBlcrNesn23uTtGkAPOPxUyuOAd0DneHM4uL+ZGifU3VA/
         YhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LxdUKX99jhfa5s0+IuZGD3X6A7IS8PJuDjuEfLK+f0=;
        b=ogBSrYrdPGRstb9wg9dnmnq17tkJOuL4T4eOQxq+md/sq4WybvaLHr7FVq5clONF7p
         9TFkW9Ic/yhwpoIsaqdyDqgKPTt3fx9omDfduoCYCQS0Pr0NMO6FN9OouxNIgsEnmIo/
         FYYrVBQdynRkmK2e+vSeZG976535aIq3XMT7lQogzRvJffKjYrT6zzlfvDvvfIp0NZvg
         1O0kpLC0DQpYHfKU8Hk2/xKDRBZQYfbNbTeG3v/vJvhLdSUJ40LsyglSaD+NCacQhLmf
         iorbqVjorrLTJxM2FSPskbK2Xyf6m9LfmFdCsbTOPHjkn5aRnTRKDe2FhwC5/BRxkG2L
         Jr9g==
X-Gm-Message-State: AOAM531vI7Qd9sySsC0iKXg4knUDMfpSQRGTYoEHFqKxNIG0JHoWVYaw
        c5Vyw8a5NqjBXdOpE9oiXSpOqXw8twWPnaq2bu4=
X-Google-Smtp-Source: ABdhPJwN42lTlRomfW86X+KUNkzMnmsw0bv5H/5/9TqQA5XYBIHQbOZrRhXsD3aPelPyGicNPnvfj5SBvFiOtqSBLgU=
X-Received: by 2002:a05:6214:29e9:b0:45a:c341:baaf with SMTP id
 jv9-20020a05621429e900b0045ac341baafmr23570833qvb.77.1652295280186; Wed, 11
 May 2022 11:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <YnOmG2DvSpvvOEOQ@google.com> <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan> <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
 <20220506100636.k2lm22ztxpyaw373@quack3.lan> <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
 <20220511175231.d7re3p4tyn55claf@quack3.lan>
In-Reply-To: <20220511175231.d7re3p4tyn55claf@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 May 2022 21:54:27 +0300
Message-ID: <CAOQ4uxivwvUqu+4f5SKjH7YgdLZTjpq0EDohJ9UWsZsW2J5rwg@mail.gmail.com>
Subject: Re: Fanotify API - Tracking File Movement
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > @@ -491,19 +491,31 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> >       if (!inode) {
> >               /* Dirent event - report on TYPE_INODE to dir */
> >               inode = dir;
> > -             /* For FS_RENAME, inode is old_dir and inode2 is new_dir */
> > -             if (mask & FS_RENAME) {
> > -                     moved = fsnotify_data_dentry(data, data_type);
> > -                     inode2 = moved->d_parent->d_inode;
> > -                     inode2_type = FSNOTIFY_ITER_TYPE_INODE2;
> > -             }
> > +     } else if (mask & FS_RENAME) {
> > +             /* For FS_RENAME, dir1 is old_dir and dir2 is new_dir */
> > +             moved = fsnotify_data_dentry(data, data_type);
> > +             dir1 = moved->d_parent->d_inode;
> > +             dir2 = dir;
> > +             if (dir1->i_fsnotify_marks || dir2->i_fsnotify_marks)
> > +                     dir1_type = FSNOTIFY_ITER_TYPE_OLD_DIR;
> > +             /*
> > +              * Send FS_RENAME to groups watching the moved inode itself
> > +              * only if the moved inode is a non-dir.
> > +              * Sending FS_RENAME to a moved watched directory would be
> > +              * confusing and FS_MOVE_SELF provided enough information to
> > +              * track the movements of a watched directory.
> > +              */
> > +             if (mask & FS_ISDIR)
> > +                     inode = NULL;
>
> So I agree that sending FS_RENAME to a directory when the directory itself
> moves is confusing. But then it makes me wonder whether it would not be
> more logical if we extended FS_MOVE_SELF rather than FS_RENAME. Currently
> FS_MOVE_SELF is an inode event but we could expand it to provide new parent
> directory to priviledged listeners (and even old directory if we wanted).
> But I guess the concern is that we'd have to introduce a group flag for
> this to make sure things are backward compatible, whereas with FAN_RENAME
> we could mostly get away without a feature flag?
>

This thought has crossed my mind.
There are several issues with extending FS_MOVE_SELF besides the one
that you mentioned.
1. It is not needed for tracking movement of dir - the only reason we need to
    extend rename/create/delete for non-dir is because fid alone is not enough
    to find the moved inode new location
2. While we could extend FS_MOVE_SELF, we cannot extend FS_DELETE_SELF
    (and there is no FS_CREATE_SELF), so it is better to extend all the
    dirent events and not any self events
3. But the nock-out argument is the one that you wrote - we can (ab)use
    FAN_ERPORT_TARGET_FID as the backward compat barrier for changing
    the behavior of dirent events and it would almost look like we had
thought about
    this in advance ;)

> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index bb8467cd11ae..75f1048443a5 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -28,18 +28,19 @@
> >   */
> >  static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
> >                               struct inode *dir, const struct qstr *name,
> > -                             u32 cookie)
> > +                             struct inode *inode, u32 cookie)
>
> So you add 'inode' argument to fsnotify_name() but never actually use it?
> The only place where inode would be non-NULL is changed to use fsnotify()
> directly...

My bad, I wasn't going to extend fsnotify_name(), but then I thought of the
FAN_CREATE/FAN_DELETE case, so I wanted to make this more obvious
in the code that dirent events should be reported to the child inode,
but I forget
to use the extended fsnotify_name() for FAN_RENAME and left it using fsnotify().

>
> Also I'm not sure why you pass the inode for rename event now when the same
> inode is passed as 'dentry' in data? I feel like I'm missing something
> here.

The semantics of @inode argument vs. fsnotify_data_inode() are hard to
remember, but we documented them in fsnotify().

The meaning of @inode is that an event should be reported to @inode if inode
has a mark. Surely, one of the reasons for this distinction was fsnotify_name()
which carries the child inode information, but was not traditionally reported
to the child inode mark.

So when I pass positive @inode with FS_RENAME that is all it takes to
report the event on a watching child inode. The only needed minor change in
fsnotify() logic was to move if (mask & FS_RENAME) outside of if (!inode) {}.
All the rest is just tidying up the code.

If we are going to change fsnotify_name() then we need to see if there are
any other cases left where @inode is NULL and fsnotify_data_inode() is positive
(I didn't check) If not, then we may be able to drop the @inode argument.

Thanks,
Amir.
