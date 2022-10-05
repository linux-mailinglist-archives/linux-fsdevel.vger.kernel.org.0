Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67CB5F583B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJEQVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJEQVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:21:35 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526856C74C;
        Wed,  5 Oct 2022 09:21:34 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id t18so11528703vsr.12;
        Wed, 05 Oct 2022 09:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msMM6KzVUNtp5lXJeF0/mwiQThCb2ZAuVam6wM5kLFQ=;
        b=pteMfjoJxUtBKbv+DevwDlV1FjQJIN5SppkK8BfkVopCImDWvbnjyw1ZPhTCBymR3p
         3se//yx6Kb/e1hY9w77+kbLCcQhWXmgOFAK7RYutdcpMqpsAbyDViQjJQ1BB8tTt6UxP
         EtFxrhYV0o3fYdNTHgULqQTgxUQKoVvE1mmiX9vmJSHF+Fu+ubmJPd/pi0bKQ1AZSDkS
         pCkY/FYZeySq6KxfBEepiSkgnbNiCqFadYLB1jcO08BxOiDF/WFTdeDJy3YGzYcLNN8H
         sImcFL86fig9tx7hCYGvh/SHq5+9izyizbQq2mAdOyGQgFxNqYUXLwYUPeVHH1QmFWuC
         Vafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msMM6KzVUNtp5lXJeF0/mwiQThCb2ZAuVam6wM5kLFQ=;
        b=YVn9feBom6ZhWNONguI1sYMhua9jDBIA1vhFMV0xi4LJk/8Vf+Zp3X3PcOpu6E0dDb
         6wdp4zdfdKU/2/qZhy6BF/r94J3qXb70y9enr9x/zwT5kGZrZ6r3QWdysIoAxW5TM3bl
         N08GqAZ5Ns7hPML9XuQM2xRH6d4uObWQFDdb8J4vSJHqiWc0fRoP0tdpBK4vaYI3EruE
         HDCw+GybMsCRnV/VIV6z7tzi1OgMW7IIj5I+W9QB3VvBCJkG8l9+sG4f2iaGPys8MoVp
         YGmNKvMF2rxNVTYswbzUCmqXAIeFWnT4JvXEt61xrwFF3vTGAExSHnKS3Wb+isyN/xNP
         +5mQ==
X-Gm-Message-State: ACrzQf3FnBqiErKteddRkIr7d5GBROhDyv0ISKGsYqeRXGfuHGtRdBJT
        uEVP1bPqRsPHAnUHiiKd5pQOUDl8IbdYcHusbPI=
X-Google-Smtp-Source: AMsMyM6STjFO6iLw6sunBOugQUwsDJ2bwsBONTl2Pm0Jbv1ccuRnJlZf8p2bNEJR/Du0JUy8rVlBKaS9pKOXAxh++dA=
X-Received: by 2002:a67:e408:0:b0:3a6:89a9:d1ff with SMTP id
 d8-20020a67e408000000b003a689a9d1ffmr284715vsf.72.1664986893316; Wed, 05 Oct
 2022 09:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221005151433.898175-1-brauner@kernel.org> <20221005151433.898175-2-brauner@kernel.org>
In-Reply-To: <20221005151433.898175-2-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 Oct 2022 19:21:21 +0300
Message-ID: <CAOQ4uxhkrd_qbJPD-_TDkcL6GMs3O+U+Q7ftDri_zig7HD3D1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] attr: use consistent sgid stripping checks
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 5, 2022 at 6:14 PM Christian Brauner <brauner@kernel.org> wrote:
>
> Currently setgid stripping in file_remove_privs()'s should_remove_suid()
> helper is inconsistent with other parts of the vfs. Specifically, it only
> raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
> inode isn't in the caller's groups and the caller isn't privileged over the
> inode although we require this already in setattr_prepare() and
> setattr_copy() and so all filesystem implement this requirement implicitly
> because they have to use setattr_{prepare,copy}() anyway.
>
> But the inconsistency shows up in setgid stripping bugs for overlayfs in
> xfstests. For example, we test whether suid and setgid stripping works
> correctly when performing various write-like operations as an unprivileged
> user (fallocate, reflink, write, etc.):

Maybe spell out the failing fstests numbers?

>
> echo "Test 1 - qa_user, non-exec file $verb"
> setup_testfile
> chmod a+rws $junk_file
> commit_and_check "$qa_user" "$verb" 64k 64k
>
> The test basically creates a file with 6666 permissions. While the file has
> the S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. On a
> regular filesystem like xfs what will happen is:
>
> sys_fallocate()
> -> vfs_fallocate()
>    -> xfs_file_fallocate()
>       -> file_modified()
>          -> __file_remove_privs()
>             -> dentry_needs_remove_privs()
>                -> should_remove_suid()
>             -> __remove_privs()
>                newattrs.ia_valid = ATTR_FORCE | kill;
>                -> notify_change()
>                   -> setattr_copy()
>
> In should_remove_suid() we can see that ATTR_KILL_SUID is raised
> unconditionally because the file in the test has S_ISUID set.
>
> But we also see that ATTR_KILL_SGID won't be set because while the file
> is S_ISGID it is not S_IXGRP (see above) which is a condition for
> ATTR_KILL_SGID being raised.
>
> So by the time we call notify_change() we have attr->ia_valid set to
> ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
> ATTR_KILL_SUID is set and does:
>
> ia_valid = attr->ia_valid |= ATTR_MODE
> attr->ia_mode = (inode->i_mode & ~S_ISUID);
>
> which means that when we call setattr_copy() later we will definitely
> update inode->i_mode. Note that attr->ia_mode still contains S_ISGID.
>
> Now we call into the filesystem's ->setattr() inode operation which will
> end up calling setattr_copy(). Since ATTR_MODE is set we will hit:
>
> if (ia_valid & ATTR_MODE) {
>         umode_t mode = attr->ia_mode;
>         vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
>         if (!vfsgid_in_group_p(vfsgid) &&
>             !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
>                 mode &= ~S_ISGID;
>         inode->i_mode = mode;
> }
>
> and since the caller in the test is neither capable nor in the group of the
> inode the S_ISGID bit is stripped.
>
> But assume the file isn't suid then ATTR_KILL_SUID won't be raised which
> has the consequence that neither the setgid nor the suid bits are stripped
> even though it should be stripped because the inode isn't in the caller's
> groups and the caller isn't privileged over the inode.
>
> If overlayfs is in the mix things become a bit more complicated and the bug
> shows up more clearly. When e.g., ovl_setattr() is hit from
> ovl_fallocate()'s call to file_remove_privs() then ATTR_KILL_SUID and
> ATTR_KILL_SGID might be raised but because the check in notify_change() is
> questioning the ATTR_KILL_SGID flag again by requiring S_IXGRP for it to be
> stripped the S_ISGID bit isn't removed even though it should be stripped:
>
> sys_fallocate()
> -> vfs_fallocate()
>    -> ovl_fallocate()
>       -> file_remove_privs()
>          -> dentry_needs_remove_privs()
>             -> should_remove_suid()
>          -> __remove_privs()
>             newattrs.ia_valid = ATTR_FORCE | kill;
>             -> notify_change()
>                -> ovl_setattr()
>                   // TAKE ON MOUNTER'S CREDS
>                   -> ovl_do_notify_change()
>                      -> notify_change()
>                   // GIVE UP MOUNTER'S CREDS
>      // TAKE ON MOUNTER'S CREDS
>      -> vfs_fallocate()
>         -> xfs_file_fallocate()
>            -> file_modified()
>               -> __file_remove_privs()
>                  -> dentry_needs_remove_privs()
>                     -> should_remove_suid()
>                  -> __remove_privs()
>                     newattrs.ia_valid = attr_force | kill;
>                     -> notify_change()
>
> The fix for all of this is to make file_remove_privs()'s
> should_remove_suid() helper to perform the same checks as we already
> require in setattr_prepare() and setattr_copy() and have notify_change()
> not pointlessly requiring S_IXGRP again. It doesn't make any sense in the
> first place because the caller must calculate the flags via
> should_remove_suid() anyway which would raise ATTR_KILL_SGID.
>
> Running xfstests with this doesn't report any regressions. We should really
> try and use consistent checks.
>
> Co-Developed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  fs/attr.c          |  4 +++-
>  fs/fuse/file.c     |  2 +-
>  fs/inode.c         | 47 ++++++++++++++++++++++++++++++++--------------
>  fs/internal.h      |  3 ++-
>  fs/ocfs2/file.c    |  4 ++--
>  fs/open.c          |  2 +-
>  include/linux/fs.h |  2 +-
>  7 files changed, 43 insertions(+), 21 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 1552a5f23d6b..7573bc33e490 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -18,6 +18,8 @@
>  #include <linux/evm.h>
>  #include <linux/ima.h>
>
> +#include "internal.h"
> +

Leftover, not needed.

Thanks for the fast response :)

Amir.
