Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C06542E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 12:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiFHKth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiFHKta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:49:30 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7957B1DC855
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 03:49:28 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y16so16247463ili.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ei5iSV8pPuCr8hbUHw/Tok7pBNeC03H/aj7DggndzyQ=;
        b=ZqtYV1INIbCdBZUgjGdRMi7txqhmi7Ks3Qle+74N7pxJqHq3jsjQU0NbheNkMJetET
         hlC5ZLRFZARAEPIMQn/52suO1vSdeeCdbOHJxKIRBA6uqsEfeeSYRNTRrFyKXUIObeSq
         DBPdGOcss35Ykg3K93i2aa/L9zvSVa78DWWE3kt47Bny9juvXr5VWbirxCfXRsGFAv52
         nINJ7SrWh4CNhb8pv+U7bJgXuTW9L9F2krSFta1jYL3yFa7OfObwa0aKToxIRAmaxoMf
         0AsBjm+ZRZbcGGVmUwoRXu+Dw4qixqXY31mc/2CHdtf64MBjEOCdcdJH3uBYGjdXaYhl
         xT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ei5iSV8pPuCr8hbUHw/Tok7pBNeC03H/aj7DggndzyQ=;
        b=as4i4StvkIcXNEoXNWxXECYhYBHY3e8V1GG+dFaGWwWznpjNnNcK1E+6CfvZbz5+r4
         UBfIeM+H9NGs/Xh7zlcLvojSqtSuX9bUmHSDFyp1hO7IMfXpyjRRFxpp+PbOhLwCbtZR
         BpJ+yetfFV7hhBlf0ZmYY7SQw6O3bZc3wySXWaWYpz6uSV8bwzkwDGz343+I1WMDoq/t
         u4CGURLVjNzmeGSPcwdlw6XSPrdDDbk7e2KATBiW7UTA7CySIpeHPQYJLf1IO6LLrZdh
         zCSzopClZGpm4IWbPIs8CkLpCa3qCxub3BZuhXIo0wO1kSnfLp53Fh1BFvyud/fyJOQG
         lXoA==
X-Gm-Message-State: AOAM533bwtCvpaW3uVKodhzPDqlAgJYnVaNsQj4CCTDXuYlaEL3Bt6Y+
        7yTq7Kds85GnC7rlcmdYYA67F/HOQGzvPAVYxZineA==
X-Google-Smtp-Source: ABdhPJy5JbtBBdC8isp5pdYCNujAdsrxp8ALyTqM8OXb8HRjNp5wkfHElynjjll2Sc9EeocQsitA84ghTueHAtZep+c=
X-Received: by 2002:a05:6e02:2190:b0:2d3:c951:20e4 with SMTP id
 j16-20020a056e02219000b002d3c95120e4mr18312306ila.216.1654685367712; Wed, 08
 Jun 2022 03:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com>
 <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
 <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
 <CAFQAk7hakYNfBaOeMKRmMPTyxFb2xcyUTdugQG1D6uZB_U1zBg@mail.gmail.com> <Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com>
In-Reply-To: <Ymfu8fGbfYi4FxQ4@miu.piliscsaba.redhat.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Wed, 8 Jun 2022 18:49:16 +0800
Message-ID: <CAFQAk7g9=7wtKR3oH3s+YApQJTD4OrvcRoh+K0Tk1E=mnnP4hQ@mail.gmail.com>
Subject: Re: [External] Re: Re: Re: [RFC PATCH] fuse: support cache
 revalidation in writeback_cache mode
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:09 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Apr 25, 2022 at 09:52:44PM +0800, Jiachen Zhang wrote:
>
> > Some users may want both the high performance of writeback mode and a
> > little bit more consistency among FUSE mounts. In the current
> > writeback mode implementation, users of one FUSE mount can never see
> > the file expansion done by other FUSE mounts.
>
> Okay.
>
> Here's a preliminary patch that you could try.
>
> Thanks,
> Miklos
>

Hi, Miklos,

Thanks for the patch, and sorry for the late reply. I have already
tried on an older
kernel version based on the same idea of your patch, and it works fine for some
simple manual tests. I still have some questions about this patch.

> ---
>  fs/fuse/dir.c             |   35 ++++++++++++++++++++++-------------
>  fs/fuse/file.c            |   17 +++++++++++++++--
>  fs/fuse/fuse_i.h          |   14 +++++++++++++-
>  fs/fuse/inode.c           |   32 +++++++++++++++++++++++++++-----
>  include/uapi/linux/fuse.h |    5 +++++
>  5 files changed, 82 insertions(+), 21 deletions(-)
>
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -194,6 +194,7 @@
>   *  - add FUSE_SECURITY_CTX init flag
>   *  - add security context to create, mkdir, symlink, and mknod requests
>   *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
> + *  - add FUSE_WRITEBACK_CACHE_V2 init flag
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -353,6 +354,9 @@ struct fuse_file_lock {
>   * FUSE_SECURITY_CTX:  add security context to create, mkdir, symlink, and
>   *                     mknod
>   * FUSE_HAS_INODE_DAX:  use per inode DAX
> + * FUSE_WRITEBACK_CACHE_V2:
> + *                     - allow time/size to be refreshed if no pending write
> + *                     - time/size not cached for falocate/copy_file_range
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -389,6 +393,7 @@ struct fuse_file_lock {
>  /* bits 32..63 get shifted down 32 bits into the flags2 field */
>  #define FUSE_SECURITY_CTX      (1ULL << 32)
>  #define FUSE_HAS_INODE_DAX     (1ULL << 33)
> +#define FUSE_WRITEBACK_CACHE_V2        (1ULL << 34)
>
>  /**
>   * CUSE INIT request/reply flags
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -222,19 +222,37 @@ void fuse_change_attributes_common(struc
>  u32 fuse_get_cache_mask(struct inode *inode)
>  {
>         struct fuse_conn *fc = get_fuse_conn(inode);
> +       struct fuse_inode *fi = get_fuse_inode(inode);
>
>         if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
>                 return 0;
>
> +       /*
> +        * In writeback_cache_v2 mode if all the following conditions are met,
> +        * then allow the attributes to be refreshed:
> +        *
> +        * - inode is not dirty (I_DIRTY_INODE)
> +        * - inode is not in the process of being written (I_SYNC)
> +        * - inode has no dirty pages (I_DIRTY_PAGES)
> +        * - inode does not have any page writeback in progress
> +        *
> +        * Note: checking PAGECACHE_TAG_WRITEBACK is not sufficient in fuse,
> +        * since inode can appear to have no PageWriteback pages, yet still have
> +        * outstanding write request.
> +        */
> +       if (fc->writeback_cache_v2 && !(inode->i_state & (I_DIRTY | I_SYNC)) &&
> +           RB_EMPTY_ROOT(&fi->writepages))
> +               return 0;
> +

Do we need to lock the inode between this cleanness checking and attr updating?
There may be writes between the two procedures and we should not update the
attributes in such cases.

>         return STATX_MTIME | STATX_CTIME | STATX_SIZE;
>  }
>
> -void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
> -                           u64 attr_valid, u64 attr_version)
> +void fuse_change_attributes_mask(struct inode *inode, struct fuse_attr *attr,
> +                                u64 attr_valid, u64 attr_version,
> +                                u32 cache_mask)
>  {
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_inode *fi = get_fuse_inode(inode);
> -       u32 cache_mask;
>         loff_t oldsize;
>         struct timespec64 old_mtime;
>
> @@ -244,7 +262,7 @@ void fuse_change_attributes(struct inode
>          * may update i_size.  In these cases trust the cached value in the
>          * inode.
>          */
> -       cache_mask = fuse_get_cache_mask(inode);
> +       cache_mask |= fuse_get_cache_mask(inode);

Could we get the cache_mask only based on the fuse_get_cache_mask()
 in fuse_change_attributes()? Why the fuse_get_cache_mask() should
be called multiple times in fuse_dentry_revalidate() and
fuse_do_setattr() cases?

>         if (cache_mask & STATX_SIZE)
>                 attr->size = i_size_read(inode);
>
> @@ -1153,6 +1171,10 @@ static void process_init_reply(struct fu
>                                 fc->async_dio = 1;
>                         if (flags & FUSE_WRITEBACK_CACHE)
>                                 fc->writeback_cache = 1;
> +                       if (flags & FUSE_WRITEBACK_CACHE_V2) {
> +                               fc->writeback_cache = 1;
> +                               fc->writeback_cache_v2 = 1;
> +                       }
>                         if (flags & FUSE_PARALLEL_DIROPS)
>                                 fc->parallel_dirops = 1;
>                         if (flags & FUSE_HANDLE_KILLPRIV)
> @@ -1234,7 +1256,7 @@ void fuse_send_init(struct fuse_mount *f
>                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>                 FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>                 FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
> -               FUSE_SECURITY_CTX;
> +               FUSE_SECURITY_CTX | FUSE_WRITEBACK_CACHE_V2;
>  #ifdef CONFIG_FUSE_DAX
>         if (fm->fc->dax)
>                 flags |= FUSE_MAP_ALIGNMENT;
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -213,6 +213,7 @@ static int fuse_dentry_revalidate(struct
>                 FUSE_ARGS(args);
>                 struct fuse_forget_link *forget;
>                 u64 attr_version;
> +               u32 cache_mask;
>
>                 /* For negative dentries, always do a fresh lookup */
>                 if (!inode)
> @@ -230,6 +231,7 @@ static int fuse_dentry_revalidate(struct
>                         goto out;
>
>                 attr_version = fuse_get_attr_version(fm->fc);
> +               cache_mask = fuse_get_cache_mask(inode);
>
>                 parent = dget_parent(entry);
>                 fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
> @@ -259,9 +261,9 @@ static int fuse_dentry_revalidate(struct
>                         goto invalid;
>
>                 forget_all_cached_acls(inode);
> -               fuse_change_attributes(inode, &outarg.attr,
> -                                      entry_attr_timeout(&outarg),
> -                                      attr_version);
> +               fuse_change_attributes_mask(inode, &outarg.attr,
> +                                           entry_attr_timeout(&outarg),
> +                                           attr_version, cache_mask);
>                 fuse_change_entry_timeout(entry, &outarg);
>         } else if (inode) {
>                 fi = get_fuse_inode(inode);
> @@ -836,16 +838,23 @@ static int fuse_symlink(struct user_name
>
>  void fuse_flush_time_update(struct inode *inode)
>  {
> -       int err = sync_inode_metadata(inode, 1);
> +       struct fuse_conn *fc = get_fuse_conn(inode);
> +       int err;
>
> -       mapping_set_error(inode->i_mapping, err);
> +       if (!fc->writeback_cache_v2) {
> +               err = sync_inode_metadata(inode, 1);
> +               mapping_set_error(inode->i_mapping, err);
> +       }
>  }
>
>  static void fuse_update_ctime_in_cache(struct inode *inode)
>  {
>         if (!IS_NOCMTIME(inode)) {
> +               struct fuse_conn *fc = get_fuse_conn(inode);
> +
>                 inode->i_ctime = current_time(inode);
> -               mark_inode_dirty_sync(inode);
> +               if (!fc->writeback_cache_v2)
> +                       mark_inode_dirty_sync(inode);
>                 fuse_flush_time_update(inode);
>         }
>  }
> @@ -1065,7 +1074,7 @@ static void fuse_fillattr(struct inode *
>  }
>
>  static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
> -                          struct file *file)
> +                          struct file *file, u32 cache_mask)
>  {
>         int err;
>         struct fuse_getattr_in inarg;
> @@ -1100,9 +1109,9 @@ static int fuse_do_getattr(struct inode
>                         fuse_make_bad(inode);
>                         err = -EIO;
>                 } else {
> -                       fuse_change_attributes(inode, &outarg.attr,
> -                                              attr_timeout(&outarg),
> -                                              attr_version);
> +                       fuse_change_attributes_mask(inode, &outarg.attr,
> +                                                   attr_timeout(&outarg),
> +                                                   attr_version, cache_mask);
>                         if (stat)
>                                 fuse_fillattr(inode, &outarg.attr, stat);
>                 }
> @@ -1131,7 +1140,7 @@ static int fuse_update_get_attr(struct i
>
>         if (sync) {
>                 forget_all_cached_acls(inode);
> -               err = fuse_do_getattr(inode, stat, file);
> +               err = fuse_do_getattr(inode, stat, file, cache_mask);
>         } else if (stat) {
>                 generic_fillattr(&init_user_ns, inode, stat);
>                 stat->mode = fi->orig_i_mode;
> @@ -1277,7 +1286,7 @@ static int fuse_perm_getattr(struct inod
>                 return -ECHILD;
>
>         forget_all_cached_acls(inode);
> -       return fuse_do_getattr(inode, NULL, NULL);
> +       return fuse_do_getattr(inode, NULL, NULL, 0);
>  }
>
>  /*
> @@ -1833,7 +1842,7 @@ static int fuse_setattr(struct user_name
>                          * ia_mode calculation may have used stale i_mode.
>                          * Refresh and recalculate.
>                          */
> -                       ret = fuse_do_getattr(inode, NULL, file);
> +                       ret = fuse_do_getattr(inode, NULL, file, 0);
>                         if (ret)
>                                 return ret;
>
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2949,6 +2949,19 @@ static int fuse_writeback_range(struct i
>         return err;
>  }
>
> +static void fuse_update_time(struct file *file)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct fuse_conn *fc = get_fuse_conn(inode);
> +
> +       if (!IS_NOCMTIME(inode)) {
> +               if (fc->writeback_cache_v2)
> +                       inode->i_mtime = inode->i_ctime = current_time(inode);
> +               else
> +                       file_update_time(file);
> +       }
> +}
> +
>  static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>                                 loff_t length)
>  {
> @@ -3021,7 +3034,7 @@ static long fuse_file_fallocate(struct f
>         /* we could have extended the file */
>         if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>                 if (fuse_write_update_attr(inode, offset + length, length))
> -                       file_update_time(file);
> +                       fuse_update_time(file);
>         }
>
>         if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
> @@ -3135,7 +3148,7 @@ static ssize_t __fuse_copy_file_range(st
>                                    ALIGN_DOWN(pos_out, PAGE_SIZE),
>                                    ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
>
> -       file_update_time(file_out);
> +       fuse_update_time(file_out);

To avoid setting I_DIRTY_SYNC in writeback_cache_v2 mode, maybe we should
replace all file_update_time() in fuse by fuse_update_time().

There are also file_update_time()s in fuse_page_mkwrite(),
fuse_cache_write_iter(),
and fuse_finish_open().


>         fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
>
>         err = outarg.size;
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -654,6 +654,9 @@ struct fuse_conn {
>         /* show legacy mount options */
>         unsigned int legacy_opts_show:1;
>
> +       /* Improved writeback cache policy */
> +       unsigned writeback_cache_v2:1;
> +
>         /*
>          * fs kills suid/sgid/cap on write/chown/trunc. suid is killed on
>          * write/trunc only if caller did not have CAP_FSETID.  sgid is killed
> @@ -1049,8 +1052,17 @@ void fuse_init_symlink(struct inode *ino
>  /**
>   * Change attributes of an inode
>   */
> +void fuse_change_attributes_mask(struct inode *inode, struct fuse_attr *attr,
> +                                u64 attr_valid, u64 attr_version,
> +                                u32 cache_mask);
> +
> +static inline
>  void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
> -                           u64 attr_valid, u64 attr_version);
> +                           u64 attr_valid, u64 attr_version)
> +{
> +       return fuse_change_attributes_mask(inode, attr,
> +                                          attr_valid, attr_version, 0);
> +}
>
>  void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>                                    u64 attr_valid, u32 cache_mask);

Also, maybe we can add a FOPEN_INVAL_ATTR flag [1] to invalidate the
attr cache on
file open. With the writeback v2 patch and FOPEN_INVAL_ATTR, the close-to-open
consistency revalidations can be implemented in user-space fuse daemons.

[1] https://lore.kernel.org/linux-fsdevel/20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com/

Thanks,
Jiachen
