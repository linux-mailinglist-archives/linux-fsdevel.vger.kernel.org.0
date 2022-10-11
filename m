Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9511F5FAE9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJKInj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJKInh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:43:37 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A374F687;
        Tue, 11 Oct 2022 01:43:35 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k6so11440592vsp.0;
        Tue, 11 Oct 2022 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/g1bHB+VtF7VlLHMnTIZaob13M0d/O+EU5C0KN4waQM=;
        b=mKonpw3h4v+s8oPW99RpE1NP7rp0f/mFfMFT0yQ23gDaSBD0+kS4XN8g76hHTNqECu
         F3dcpIaSbKPbjl/OCtMRwgFgoH1K5S55wDqECNjHsifqlVoDdIvY+KN4z+h5iOdArv6T
         0OzTOJLieU2cgI6xAB+rWIKNTPDz8ajtBTrcUKepjivYERyEiOFk9R0HbL+kRuqpIIs9
         tNZZ02bjifc1JIJuKlKQC2AAlXPxQu7UiElwfavk0iT4N5TxEAg0GoPoCxSInuASUXBt
         8JCiVJjAUcJ0kexK1Qa/52luL3HUkLfHzVeFmuEmXpGJTZwgLEV7tONLr8XYcJ+Vd2Ui
         2psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g1bHB+VtF7VlLHMnTIZaob13M0d/O+EU5C0KN4waQM=;
        b=4HXxcjwgV/uBMSEhc8ZOV37GQe4MwXYRHfjBOt3+RAT4aUNfO2Cgid1KyMu8cZtgrF
         45z5aUcX9aGGxtxGRPfyemndd5HkS/yaIQmhwNLe8s6F0N92lAgY3Kvx01fT6+ZQ90pv
         Mt9lkLwz628w+hTU2uvooJ4ysGZ9Bch3uIqrHwuyY8JS4SJTmLPHkRHA86eiBiG0ss7X
         vSYE9CbBB4iK23yjkCnwVYJ3/i5S30v91MTP8irI6427RhhvvaZPiXHLjY9JE5DKy9U+
         T1TqvNj5ZvhiVhtfsztIciCfIepQWYUjZn0q7MLhIITJLll8sOeu2Jkx8T1OkF0K3hpS
         1zNg==
X-Gm-Message-State: ACrzQf3BTaqu8VdPMTY/jjI/QReY4GBi/oegAtgEsoTvE10hVlc4wq/q
        3v+nYvvo36Ys94wwLCEq7u8Jt0HVUzoIUJUqfIeMf9r+YZQ=
X-Google-Smtp-Source: AMsMyM65voYefNZ2QSdAyP5k+gcGbmzSCIxeizqsFpRu2Uab8+vdrQLlyIAmZdBkA7K9lD4fgs3hIE+CqWwPCymNGjo=
X-Received: by 2002:a67:c190:0:b0:3a7:e91:9072 with SMTP id
 h16-20020a67c190000000b003a70e919072mr10973701vsj.36.1665477814502; Tue, 11
 Oct 2022 01:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221007140543.1039983-1-brauner@kernel.org> <20221007140543.1039983-4-brauner@kernel.org>
In-Reply-To: <20221007140543.1039983-4-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Oct 2022 11:43:22 +0300
Message-ID: <CAOQ4uxggKnsyi2DvVOCUQQ8hEZJjioing_H-M4y_Hq-wvRk0nA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] attr: use consistent sgid stripping checks
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

On Fri, Oct 7, 2022 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
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
> xfstests (e.g., generic/673, generic/683, generic/685, generic/686,
> generic/687). For example, we test whether suid and setgid stripping works
> correctly when performing various write-like operations as an unprivileged
> user (fallocate, reflink, write, etc.):
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
>
> Notes:
>     /* v2 */
>     Amir Goldstein <amir73il@gmail.com>:
>     - mention xfstests that failed prior to that
>
>     Christian Brauner <brauner@kernel.org>:
>     - Use should_remove_sgid() in chown_common() just like we do in do_truncate().
>
>  fs/attr.c          |  2 +-
>  fs/fuse/file.c     |  2 +-
>  fs/inode.c         | 24 ++++++++----------------
>  fs/internal.h      |  3 ++-
>  fs/ocfs2/file.c    |  4 ++--
>  fs/open.c          |  8 ++++----
>  include/linux/fs.h |  2 +-
>  7 files changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index d0bb1dae425e..888b34e8c268 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -421,7 +421,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
>                 }
>         }
>         if (ia_valid & ATTR_KILL_SGID) {
> -               if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> +               if (mode & S_ISGID) {
>                         if (!(ia_valid & ATTR_MODE)) {
>                                 ia_valid = attr->ia_valid |= ATTR_MODE;
>                                 attr->ia_mode = inode->i_mode;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1a3afd469e3a..fccc2c7e88fd 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1313,7 +1313,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
>                         return err;
>
>                 if (fc->handle_killpriv_v2 &&
> -                   should_remove_suid(file_dentry(file))) {
> +                   should_remove_suid(&init_user_ns, file_dentry(file))) {
>                         goto writethrough;
>                 }
>
> diff --git a/fs/inode.c b/fs/inode.c
> index ba1de23c13c1..092a66324c65 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1949,26 +1949,17 @@ void touch_atime(const struct path *path)
>  }
>  EXPORT_SYMBOL(touch_atime);
>
> -/*
> - * The logic we want is
> - *
> - *     if suid or (sgid and xgrp)
> - *             remove privs
> - */
> -int should_remove_suid(struct dentry *dentry)
> +int should_remove_suid(struct user_namespace *mnt_userns, struct dentry *dentry)
>  {
> -       umode_t mode = d_inode(dentry)->i_mode;
> +       struct inode *inode = d_inode(dentry);
> +       umode_t mode = inode->i_mode;
>         int kill = 0;
>
>         /* suid always must be killed */
>         if (unlikely(mode & S_ISUID))
>                 kill = ATTR_KILL_SUID;
>
> -       /*
> -        * sgid without any exec bits is just a mandatory locking mark; leave
> -        * it alone.  If some exec bits are set, it's a real sgid; kill it.
> -        */
> -       if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
> +       if (unlikely(should_remove_sgid(mnt_userns, inode)))
>                 kill |= ATTR_KILL_SGID;

   kill |= should_remove_sgid(mnt_userns, inode);

>
>         if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
> @@ -1983,7 +1974,8 @@ EXPORT_SYMBOL(should_remove_suid);
>   * response to write or truncate. Return 0 if nothing has to be changed.
>   * Negative value on error (change should be denied).
>   */
> -int dentry_needs_remove_privs(struct dentry *dentry)
> +int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
> +                             struct dentry *dentry)
>  {
>         struct inode *inode = d_inode(dentry);
>         int mask = 0;
> @@ -1992,7 +1984,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
>         if (IS_NOSEC(inode))
>                 return 0;
>
> -       mask = should_remove_suid(dentry);
> +       mask = should_remove_suid(mnt_userns, dentry);
>         ret = security_inode_need_killpriv(dentry);
>         if (ret < 0)
>                 return ret;
> @@ -2024,7 +2016,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
>         if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
>                 return 0;
>
> -       kill = dentry_needs_remove_privs(dentry);
> +       kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
>         if (kill < 0)
>                 return kill;
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 9d165ab65a2a..b46881b7f8a0 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -139,7 +139,8 @@ extern int vfs_open(const struct path *, struct file *);
>   * inode.c
>   */
>  extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
> -extern int dentry_needs_remove_privs(struct dentry *dentry);
> +extern int dentry_needs_remove_privs(struct user_namespace *,
> +                                    struct dentry *dentry);
>
>  /*
>   * fs-writeback.c
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index 9c67edd215d5..e421491783c3 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1991,7 +1991,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>                 }
>         }
>
> -       if (file && should_remove_suid(file->f_path.dentry)) {
> +       if (file && should_remove_suid(&init_user_ns, file->f_path.dentry)) {
>                 ret = __ocfs2_write_remove_suid(inode, di_bh);
>                 if (ret) {
>                         mlog_errno(ret);
> @@ -2279,7 +2279,7 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
>                  * inode. There's also the dinode i_size state which
>                  * can be lost via setattr during extending writes (we
>                  * set inode->i_size at the end of a write. */
> -               if (should_remove_suid(dentry)) {
> +               if (should_remove_suid(&init_user_ns, dentry)) {
>                         if (meta_level == 0) {
>                                 ocfs2_inode_unlock_for_extent_tree(inode,
>                                                                    &di_bh,
> diff --git a/fs/open.c b/fs/open.c
> index 8a813fa5ca56..d955ecef758f 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -54,7 +54,7 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
>         }
>
>         /* Remove suid, sgid, and file capabilities on truncate too */
> -       ret = dentry_needs_remove_privs(dentry);
> +       ret = dentry_needs_remove_privs(mnt_userns, dentry);
>         if (ret < 0)
>                 return ret;
>         if (ret)
> @@ -721,10 +721,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>                 return -EINVAL;
>         if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
>                 return -EINVAL;
> -       if (!S_ISDIR(inode->i_mode))
> -               newattrs.ia_valid |=
> -                       ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
>         inode_lock(inode);
> +       if (!S_ISDIR(inode->i_mode))
> +               newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
> +                                    should_remove_sgid(mnt_userns, inode);

This is making me stop and wonder:
1. This has !S_ISDIR, should_remove_suid() has S_ISREG and
    setattr_drop_sgid() has neither - is this consistent?
2. SUID and PRIV are removed unconditionally and SGID is
    removed conditionally - this is not a change of behavior
    (at least for non-overlayfs), but is it desired???

Those questions could be dealt with in future patches if at all.

The change itself looks legit and solves a real problem, so you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Instead of Co-Developed-by ;-)

Thanks,
Amir.
