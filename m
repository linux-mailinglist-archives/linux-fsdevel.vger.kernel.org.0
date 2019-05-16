Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13888203BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfEPKkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:40:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39814 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEPKku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:40:50 -0400
Received: by mail-yw1-f66.google.com with SMTP id w21so1168070ywd.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rPYPWIBAaJYlxDTZi9bk2h0fc9W6HDzj2P2Kg0UDuQ=;
        b=WQM0mBZ5BUhsKcvmUSgHXZoRCbb0aewaoCEBnVvfzuDjpquyLQsv2eH0yxtLdMtB72
         w3YIdUswmGFS7WP7/JxS4XCNSW9sLr+PBoEyi/P9ld75ihqigmDccPdWT8z/9q6NlPiT
         8FnwWppXN6H0yeib9g97WS2TjZd782EZKIVkDkgaPHXm0PKSc3bdn2tmjkLKYgAjrA55
         nQBFDDnN5H0FfdMPV+SGXXzmbWgecrmLJ8OoKdqI7wIiQH7bhiiyAy5o4wOaB6/dxg1Z
         4UC7Ykk5BVGICiDJBT2b8QKF38AqFiJPHgnLYTCLuELKJHQtZUGpwhHdO8C7CAmrMH2w
         0XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rPYPWIBAaJYlxDTZi9bk2h0fc9W6HDzj2P2Kg0UDuQ=;
        b=r2rMyKx9NykzIXql6x56xb9WZjhTTdHADQabR6fyy12N+EMGrPZTWlFZyrHqXiQsy4
         XhEvvI1uZXkwXYihyI3Y4JkVw2ohbkFnbXugMs4mmzAiJ5SJMBrKo87h0NqqxKDVH4bb
         3PO16h7AoqqWHS5plQvBGsYjfz4hSdmw1XWDocoKqG6NnX03vPBCMYOoVLCpDucaSLI8
         sy6CxUtstArl3yjOm4TzhMWqGpSy4jEMhb01vVXTAsC1qQGjIAlkyGTOVDwgO2RqUKH0
         Bo5jL+zh8ihgXnuVjsuFALz08r7LHViDitzmTvAlJ73WBleXO4ACKJl7u81y3DDcN46B
         xaBQ==
X-Gm-Message-State: APjAAAU13WOSdNtIa3yf1ttpoAe/A2e/ny74GHX+B9ESD4Zm7q+QTfX6
        5xe9UBwN7qZFBe6LRT+d8pRpF8sH2qqnmaMkDi4=
X-Google-Smtp-Source: APXvYqzv9ljAWrk9JbqR+AC5BCLwcpydMXH9RcijNNELLBKfFt/5iUh9aGjoYOUzsgGinMFs4skaCYnexc/UbGTIA/A=
X-Received: by 2002:a81:9903:: with SMTP id q3mr22409898ywg.211.1558003249611;
 Thu, 16 May 2019 03:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com>
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 13:40:38 +0300
Message-ID: <CAOQ4uxhymVOA7=hGW7Tk4jyEiz4d6OWgkkL6WB-8qzeK2J_BGw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Sort out fsnotify_nameremove() mess
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 1:26 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Jan,
>
> What do you think will be the best merge strategy for this patch series?
>
> How about sending first 3 prep patches to Linus for applying at the end
> of v5.2 merge window, so individual maintainers can pick up per fs
> patches for the v5.3 development cycle?

Doh! I was going to CC Al on the entire series and forgot.

Al,

We could definitely use your input on this series in general and about
merge strategy in particular.
If you would agree to take the entire series through your tree, that could
make things considerably easier.
After all it, this patch set is more a vfs work than it is an fsnotify work.

Thanks,
Amir.

>
> The following d_delete() call sites have been audited and will no longer
> generate fsnotify event after this series:
>
> drivers/usb/gadget/function/f_fs.c:ffs_epfiles_destroy() - cleanup? (*)
> fs/ceph/dir.c:ceph_unlink() - from vfs_unlink()
> fs/ceph/inode.c:ceph_fill_trace() - invalidate (**)
> fs/configfs/dir.c:detach_groups() - cleanup (*)
> fs/configfs/dir.c:configfs_attach_item() - cleanup (*)
> fs/configfs/dir.c:configfs_attach_group() - cleanup (*)
> fs/efivarfs/file.c:efivarfs_file_write() - invalidate (**)
> fs/fuse/dir.c:fuse_reverse_inval_entry() - invalidate (**)
> fs/nfs/dir.c:nfs_dentry_handle_enoent() - invalidate (**)
> fs/nsfs.c:__ns_get_path() - invalidate (**)
> fs/ocfs2/dlmglue.c:ocfs2_dentry_convert_worker() - invalidate? (**)
> fs/reiserfs/xattr.c:xattr_{unlink,rmdir}() - hidden xattr inode
>
> (*) There are 2 "cleanup" use cases:
>   - Create;init;delte if init failed
>   - Batch delete of files within dir before removing dir
>   Both those cases are not interesting for users that wish to observe
>   configuration changes on pseudo filesystems.  Often, there is already
>   an fsnotify event generated on the directory removal which is what
>   users should find interesting, for example:
>   configfs_unregister_{group,subsystem}().
>
> (**) The different "invalidate" use cases differ, but they all share
>   one thing in common - user is not guarantied to get an event with
>   current kernel.  For example, when a file is deleted remotely on
>   nfs server, nfs client is not guarantied to get an fsnotify delete
>   event.  On current kernel, nfs client could generate an fsnotify
>   delete event if the local entry happens to be in cache and client
>   finds out that entry is deleted on server during another user
>   operation.  Incidentally, this group of use cases is where most of
>   the call sites are with "unstable" d_name, which is the reason for
>   this patch series to begin with.
>
> Thanks,
> Amir.
>
> Changes since v1:
> - Split up per filesystem patches
> - New hook names fsnotify_{unlink,rmdir}()
> - Simplify fsnotify code in separate final patch
>
> Amir Goldstein (14):
>   ASoC: rename functions that pollute the simple_xxx namespace
>   fs: create simple_remove() helper
>   fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
>   fs: convert hypfs to use simple_remove() helper
>   fs: convert qibfs/ipathfs to use simple_remove() helper
>   fs: convert debugfs to use simple_remove() helper
>   fs: convert tracefs to use simple_remove() helper
>   fs: convert rpc_pipefs to use simple_remove() helper
>   fs: convert apparmorfs to use simple_remove() helper
>   fsnotify: call fsnotify_rmdir() hook from btrfs
>   fsnotify: call fsnotify_rmdir() hook from configfs
>   fsnotify: call fsnotify_unlink() hook from devpts
>   fsnotify: move fsnotify_nameremove() hook out of d_delete()
>   fsnotify: get rid of fsnotify_nameremove()
>
>  arch/s390/hypfs/inode.c            |  9 ++-----
>  drivers/infiniband/hw/qib/qib_fs.c |  3 +--
>  fs/afs/dir_silly.c                 |  5 ----
>  fs/btrfs/ioctl.c                   |  4 ++-
>  fs/configfs/dir.c                  |  3 +++
>  fs/dcache.c                        |  2 --
>  fs/debugfs/inode.c                 | 20 +++------------
>  fs/devpts/inode.c                  |  1 +
>  fs/libfs.c                         | 32 +++++++++++++++++++++++
>  fs/namei.c                         |  2 ++
>  fs/nfs/unlink.c                    |  6 -----
>  fs/notify/fsnotify.c               | 41 ------------------------------
>  fs/tracefs/inode.c                 | 23 +++--------------
>  include/linux/fs.h                 |  1 +
>  include/linux/fsnotify.h           | 26 +++++++++++++++++++
>  include/linux/fsnotify_backend.h   |  4 ---
>  net/sunrpc/rpc_pipe.c              | 16 ++----------
>  security/apparmor/apparmorfs.c     |  6 +----
>  sound/soc/generic/simple-card.c    |  8 +++---
>  19 files changed, 86 insertions(+), 126 deletions(-)
>
> --
> 2.17.1
>
