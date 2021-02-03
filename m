Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF81130DE08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 16:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhBCPXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 10:23:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234158AbhBCPXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612365726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+Sb5ZF8RHOsf9TT9bAcHXxUsxEE/AuGBDj+pmLSBng=;
        b=M/SJkUIBTps/oD3qK3oCZPgQFvm3s5vQ5WJ8hNFR/2lsCUg6nadJJq/bMj2uqaQqRvmOFC
        6icRts1z3Gr5ANeQhk9PMyY+20Ojgmr8zGXJN6gKnCxr3OARLyobJ+Gs+cW6U3ibicYjwT
        zgk1CJwhuVFjnfWVqt5p8uyk5wh/aaA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-r75DGb2-MrWvWpzRnAlbbQ-1; Wed, 03 Feb 2021 10:22:03 -0500
X-MC-Unique: r75DGb2-MrWvWpzRnAlbbQ-1
Received: by mail-qv1-f69.google.com with SMTP id b1so18005986qvk.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 07:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+Sb5ZF8RHOsf9TT9bAcHXxUsxEE/AuGBDj+pmLSBng=;
        b=U2W2L90IVeRHc2y0vyGHpnYumsVIk4shOyjD/OIHktdJFv7ShScLApEAivSO982tkf
         Yy0rAqRFpBFWRLohG8EhHErHmQAwxZd9Kgdo2eIB88upS8S85wecAGRUxIhEHCJXynap
         tUy52ISo1gYE/4udF3DqGhEB3fGeXhZJlYuUajhbT23Fc+GMFkpmw/UQglAZLXb2lk0b
         Pp2IyfhkwXS8kn66/7P6QXWMs/wZcjBsm/ofHEZs7VfNttb8R24FjZGxUAzJbVlZ+tRA
         +S+ZH55kCFPoyRItK99Adk0RZAcnyaKh+w5kKfhdAy5ofIuj8BG1sRqmQrUhd+Gm/YCr
         3SqQ==
X-Gm-Message-State: AOAM533aypxImw4p1XVyZ++KL7umhK4+seKBTDeeTfJK6JlzdY1dzmGi
        X7r4ql0Bohwd9meYWWN1qXXNfKCMERNeMeHSR8Rp2np6TXP6WGf2XSu1lkLf1hzDj+cpdkXACIx
        K5lvGTHEvaUeapiwiiN5D4XxQH6byNel17aeU3pLoAA==
X-Received: by 2002:ad4:5887:: with SMTP id dz7mr3293670qvb.44.1612365723127;
        Wed, 03 Feb 2021 07:22:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiPL/iCRPNnBTcQC2ruX9Zv5S0UWusaG1Tag8/YzDoHNsGisQQbATPZWoV6vO7w1JXdG8bWhk+VjP1Zc1jGyM=
X-Received: by 2002:ad4:5887:: with SMTP id dz7mr3293631qvb.44.1612365722811;
 Wed, 03 Feb 2021 07:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203124112.1182614-2-mszeredi@redhat.com>
 <20210203150448.GD7094@quack2.suse.cz>
In-Reply-To: <20210203150448.GD7094@quack2.suse.cz>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 3 Feb 2021 16:21:51 +0100
Message-ID: <CAOssrKesMbzG9bX5HiDvCJTpdrCkvP7cg5nsZHCy4_QkJNEVZg@mail.gmail.com>
Subject: Re: [PATCH 01/18] vfs: add miscattr ops
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 3, 2021 at 4:05 PM Jan Kara <jack@suse.cz> wrote:

[...]
> > +/**
> > + * miscattr_fill_xflags - initialize miscattr with xflags
> > + * @ma:              miscattr pointer
> > + * @xflags:  FS_XFLAG_* flags
> > + *
> > + * Set ->fsx_xflags, ->xattr_valid and ->flags (translated xflags).  All
> > + * other fields are zeroed.
> > + */
> > +void miscattr_fill_xflags(struct miscattr *ma, u32 xflags)
>
> Maybe call this miscattr_fill_from_xflags() and the next function
> miscattr_fill_from_flags()? At least to me it would be clearer when I want
> to use which function just by looking at the name...

Yes, more clarity for the cost of a longer name.  I'm not sure...

[...]
> > +/**
> > + * vfs_miscattr_get - retrieve miscellaneous inode attributes
> > + * @dentry:  the object to retrieve from
> > + * @ma:              miscattr pointer
> > + *
> > + * Call i_op->miscattr_get() callback, if exists.
> > + *
> > + * Returns 0 on success, or a negative error on failure.
> > + */
> > +int vfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +
> > +     if (d_is_special(dentry))
> > +             return -ENOTTY;
> > +
> > +     if (!inode->i_op->miscattr_get)
> > +             return -ENOIOCTLCMD;
> > +
> > +     memset(ma, 0, sizeof(*ma));
>
> So here we clear whole 'ma' but callers already set e.g. xattr_valid field
> and cleared the 'ma' as well which just looks silly...

Well spotted.   Fixed.

[...]
> > +/**
> > + * vfs_miscattr_set - change miscellaneous inode attributes
> > + * @dentry:  the object to change
> > + * @ma:              miscattr pointer
> > + *
> > + * After verifying permissions, call i_op->miscattr_set() callback, if
> > + * exists.
> > + *
> > + * Verifying attributes involves retrieving current attributes with
> > + * i_op->miscattr_get(), this also allows initilaizing attributes that have
> > + * not been set by the caller to current values.  Inode lock is held
> > + * thoughout to prevent racing with another instance.
> > + *
> > + * Returns 0 on success, or a negative error on failure.
> > + */
> > +int vfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
> > +{
> > +     struct inode *inode = d_inode(dentry);
> > +     struct miscattr old_ma = {};
> > +     int err;
> > +
> > +     if (d_is_special(dentry))
> > +             return -ENOTTY;
> > +
> > +     if (!inode->i_op->miscattr_set)
> > +             return -ENOIOCTLCMD;
> > +
> > +     if (!inode_owner_or_capable(inode))
> > +             return -EPERM;
> > +
> > +     inode_lock(inode);
> > +     err = vfs_miscattr_get(dentry, &old_ma);
> > +     if (!err) {
> > +             /* initialize missing bits from old_ma */
> > +             if (ma->flags_valid) {
> > +                     ma->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
> > +                     ma->fsx_extsize = old_ma.fsx_extsize;
> > +                     ma->fsx_nextents = old_ma.fsx_nextents;
> > +                     ma->fsx_projid = old_ma.fsx_projid;
> > +                     ma->fsx_cowextsize = old_ma.fsx_cowextsize;
> > +             } else {
> > +                     ma->flags |= old_ma.flags & ~FS_COMMON_FL;
> > +             }
> > +             err = miscattr_set_prepare(inode, &old_ma, ma);
> > +             if (!err)
> > +                     err = inode->i_op->miscattr_set(dentry, ma);
>
> So I somewhat wonder here - not all filesystems support all the xflags or
> other extended attributes. Currently these would be just silently ignored
> AFAICT. Which seems a bit dangerous to me - most notably because it makes
> future extensions of these filesystems difficult. So how are we going to go
> about this? Is every filesystem supposed to check what it supports and
> refuse other stuff (but currently e.g. your ext2 conversion patch doesn't do
> that AFAICT)? Shouldn't we make things easier for filesystems to provide a
> bitmask of changing fields (instead of flags / xflags bools) so that they
> can refuse unsupported stuff with a single mask check?

Ah, ext2 one is missing miscattr_has_xattr() check and doesn't use the
miscattr_fill_flags() helper.  It was one of the earlier fs I
converted, and the API wasn't so refined then.  Fixed.

Will review all conversions too for this type of omission.

Creating a  mask instead of bool makes sense, I'll look into this.

> To make things more complex, ext2/4 has traditionally silently cleared
> unknown flags for setflags but not for setxflags. Unlike e.g. XFS which
> refuses unknown flags.

Right. Not sure if this can be fixed.  Documenting rules and
exceptions should be a first step.

Thanks,
Miklos

