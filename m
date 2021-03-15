Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5048833C33E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 18:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhCORDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhCORCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:02:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D988C06175F;
        Mon, 15 Mar 2021 10:02:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so6047582wrc.3;
        Mon, 15 Mar 2021 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8p2q7TTL52jt+tpdzfJ0Qva0tj4WQjV5Cju4JoqSLnU=;
        b=ibfw00XGUXa4yv2uU25JMFYXlLgYHThulm2QJBo87ZAQZzz+YOAVutO+kkKE9z0cG7
         dOnj5hqr4fkmu60CtX7dD5dI+xhYNkcm7hcAYRmY39BjourhHkKDFzcZM11EXZPdHoTc
         4rgi+17HN1k06nYrg0Za+fAdwGGRpXqdoxW8/2urP1l/0Ez0ilOZfNqt5RarR8DdeGeg
         IlijuEYi09VUE2pI8Vxm1+qyu6nnAadE6bBcmOB4QmWM5QaT872Og2mwDrawCMqnPlqe
         XqTcd/vZMXugp+GL3u2gxALLR+sfKwPc1uF4prmZ5IhPXzX2eKb8eleMc4CxiVnorfIA
         6OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8p2q7TTL52jt+tpdzfJ0Qva0tj4WQjV5Cju4JoqSLnU=;
        b=J169Bg4rxIj9AqCVZ56gC7sfTqX4n6EK+0bQ63mv0ouC2rRrGjuhuEj9IJH1+4+yyZ
         10bZK92J1ATuc9EpjkQZskjjxabNO0AI0Q32K3EcchmHrDO04AWUbOHYWHUQZCq1qPZA
         1wUJ10W5Dg3i3S5B0kvHYzEXjn0oN3Abn6Lo1zIf+A3aDWRxXI1TAorKOuqBFRhyqzp8
         U+LVzrvkKqetH2k6y3nyYjgfhG9z6CfxsilhzvCMVIpv4pTL7vD1bb4nnzIwWOV80PyI
         RO31kYwxo7DRxjHXmUkELdG24PcNQLkuRk1JeqI1QmMONldbeZlDbZTtEo+pCfFZDOzr
         C7/Q==
X-Gm-Message-State: AOAM530TDTC89yKkle8bcVI/OIry6cc4z8DiJdJXuRkORziL1egPzq+M
        EAZJKcoxm8EdzLyHwJBDHRz4/VS50c0n2NjfDb8=
X-Google-Smtp-Source: ABdhPJz7He7hy0r9B23HIURuZxeUmcOF1cVBSfxuv6hORe4VG81qqTCrt4jg/CnBI+wKa7ynb+f7j3omovgCjpu8Aig=
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr594655wrn.255.1615827753146;
 Mon, 15 Mar 2021 10:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <161550398415.1983424.4857046033308089813.stgit@warthog.procyon.org.uk>
 <161550399833.1983424.16644306048746346626.stgit@warthog.procyon.org.uk>
In-Reply-To: <161550399833.1983424.16644306048746346626.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Mon, 15 Mar 2021 14:02:22 -0300
Message-ID: <CAB9dFdsTxs4NxprGG2vaj1pGE26qtZO7s2v+D5Gf=27op_94oQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] afs: Stop listxattr() from listing "afs.*" attributes
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 7:07 PM David Howells <dhowells@redhat.com> wrote:
>
> afs_listxattr() lists all the available special afs xattrs (i.e. those in
> the "afs.*" space), no matter what type of server we're dealing with.  But
> OpenAFS servers, for example, cannot deal with some of the extra-capable
> attributes that AuriStor (YFS) servers provide.  Unfortunately, the
> presence of the afs.yfs.* attributes causes errors[1] for anything that
> tries to read them if the server is of the wrong type.
>
> Fix the problem by removing afs_listxattr() so that none of the special
> xattrs are listed (AFS doesn't support xattrs).  It does mean, however,
> that getfattr won't list them, though they can still be accessed with
> getxattr() and setxattr().
>
> This can be tested with something like:
>
>         getfattr -d -m ".*" /afs/example.com/path/to/file
>
> With this change, none of the afs.* attributes should be visible.
>
> Changes:
> ver #2:
>  - Hide all of the afs.* xattrs, not just the ACL ones.
>
> Fixes: ae46578b963f ("afs: Get YFS ACLs and information through xattrs")
> Reported-by: Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003502.html [1]
> Link: http://lists.infradead.org/pipermail/linux-afs/2021-March/003567.html # v1
> ---
>
>  fs/afs/dir.c      |    1 -
>  fs/afs/file.c     |    1 -
>  fs/afs/inode.c    |    1 -
>  fs/afs/internal.h |    1 -
>  fs/afs/mntpt.c    |    1 -
>  fs/afs/xattr.c    |   23 -----------------------
>  6 files changed, 28 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 714fcca9af99..17548c1faf02 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -70,7 +70,6 @@ const struct inode_operations afs_dir_inode_operations = {
>         .permission     = afs_permission,
>         .getattr        = afs_getattr,
>         .setattr        = afs_setattr,
> -       .listxattr      = afs_listxattr,
>  };
>
>  const struct address_space_operations afs_dir_aops = {
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 85f5adf21aa0..960b64268623 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -43,7 +43,6 @@ const struct inode_operations afs_file_inode_operations = {
>         .getattr        = afs_getattr,
>         .setattr        = afs_setattr,
>         .permission     = afs_permission,
> -       .listxattr      = afs_listxattr,
>  };
>
>  const struct address_space_operations afs_fs_aops = {
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 1156b2df28d3..12be88716e4c 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -27,7 +27,6 @@
>
>  static const struct inode_operations afs_symlink_inode_operations = {
>         .get_link       = page_get_link,
> -       .listxattr      = afs_listxattr,
>  };
>
>  static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *parent_vnode)
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index b626e38e9ab5..1627b1872812 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -1509,7 +1509,6 @@ extern int afs_launder_page(struct page *);
>   * xattr.c
>   */
>  extern const struct xattr_handler *afs_xattr_handlers[];
> -extern ssize_t afs_listxattr(struct dentry *, char *, size_t);
>
>  /*
>   * yfsclient.c
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 052dab2f5c03..bbb2c210d139 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -32,7 +32,6 @@ const struct inode_operations afs_mntpt_inode_operations = {
>         .lookup         = afs_mntpt_lookup,
>         .readlink       = page_readlink,
>         .getattr        = afs_getattr,
> -       .listxattr      = afs_listxattr,
>  };
>
>  const struct inode_operations afs_autocell_inode_operations = {
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> index 4934e325a14a..7751b0b3f81d 100644
> --- a/fs/afs/xattr.c
> +++ b/fs/afs/xattr.c
> @@ -11,29 +11,6 @@
>  #include <linux/xattr.h>
>  #include "internal.h"
>
> -static const char afs_xattr_list[] =
> -       "afs.acl\0"
> -       "afs.cell\0"
> -       "afs.fid\0"
> -       "afs.volume\0"
> -       "afs.yfs.acl\0"
> -       "afs.yfs.acl_inherited\0"
> -       "afs.yfs.acl_num_cleaned\0"
> -       "afs.yfs.vol_acl";
> -
> -/*
> - * Retrieve a list of the supported xattrs.
> - */
> -ssize_t afs_listxattr(struct dentry *dentry, char *buffer, size_t size)
> -{
> -       if (size == 0)
> -               return sizeof(afs_xattr_list);
> -       if (size < sizeof(afs_xattr_list))
> -               return -ERANGE;
> -       memcpy(buffer, afs_xattr_list, sizeof(afs_xattr_list));
> -       return sizeof(afs_xattr_list);
> -}
> -
>  /*
>   * Deal with the result of a successful fetch ACL operation.
>   */

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
