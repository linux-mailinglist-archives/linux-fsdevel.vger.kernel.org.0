Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50B3105C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 08:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBEHWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 02:22:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40648 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhBEHWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612509741; x=1644045741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CtGa6PXGliWvj4xqnJ2iDsm1A39zzC/rmeqXuAW2a74=;
  b=VZ3q7NLSbF4XPrj1muUtXUzvi0mcARIP4eUiFiBXsdTUjVaLG6Jfu4Pa
   /0vfVhtYPr24orLwXNkdYDkREZENiJsUAGy70UbA5i3HZYNr/O8d0Mw9Q
   yJxCAg9DfccTaDONJ6ZLWkp5q8NBi13JDHtraRFaCHM0Zd7bTzBbAN3eG
   iuC9qC4TpYdGf4Dh0lL8F0Oznw8PI23IfrN4OJTQjpXSb8qc32Vfp1txu
   10Rh9FMtGQX0oRj2oY16eOhs3Fw2Fy3u7whOjbR8Z5BrxHe+y85SpnBux
   e0qnzhozBaQCf35sIkw/lG7nSAifObwmvcFB/hTulrMsew+c3SUeJfPyd
   A==;
IronPort-SDR: BPRBhwUJ+Wfrsp4p124KpPHvEJGgslbsrAZCSc/c58PbNZdRR+wC2xis1i2PB/65zf5qUp9xAD
 xE1jjY0r9TwmmNxTBqk7+bWid7hgAwMs+dFiy92mwCtajSgyUIA/oBWAk/EWBjZ7yJhTThR23R
 N/6d+9slV5uSe6B0a4uJG4hOYlBTlDJT506t/VQej38K78avCpdHUHDyiqS4cmI5j9vy5vQA7m
 X0orF51kD2uvJCQ7ymh+dztiJJEBwqQcE0wJ6z8yi9KwU+IyF2I39qdEECZlI/vUL5rKECIQG7
 5/A=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="269642017"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 15:21:15 +0800
IronPort-SDR: Y/JedinuIgBfimM2+/WdUQuIbmVRU8iPnGPCTp5/O8qV8nbctcVvGd0ZhoBQKvCKIytYxNuU5G
 Dcal0soDkrvX5p8GFA2Qrg28xbzRttMl/9q/J3XeTDuTHA9aIxQHHfCt/exJrLaycFM25JNz53
 0zujGuLceWZWSW7nEGNOKQ73U7nUil5Ax3iNT1UIhhBwV8QiMbcp4io65Uyfs2K5LoBzgSbeIR
 1WUjrpFShwCj7HZS1bpMcmcbESE6GD41r9ghR7I0A6XXcxMbDIGFC3lvt/RhPf7Tlw7TmXG9cO
 W3Et9vPuoWFc1g+p76dPYc02
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 23:05:12 -0800
IronPort-SDR: r3Nfrha7AR6I4IjM4xC0vcz/ixVGdK1WdMQwTTjHzoiP+wT+NFHGcZGBcvwti+7vZmEypesKvC
 wCzUBAZs5PuZz9w3nU+QKPO57HEPiremkatbEbmx5noz0t5DFUd7dOAR7kotaxuc/DLwbTSbn5
 FJQGNezpBHdKk7YV7IcQAsBESat4qS/Fyn0vkc6CXfbxV7FodfhKoRLLy1RpmilmilBw0guqj1
 3cs5iTMLKNMEXxvDEzOoujlckHLfSB2B6fBDP44NLx2Uq0vYduiDC7MF0jPjAtZemq8MJM1MVJ
 ClU=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 23:21:13 -0800
Date:   Fri, 5 Feb 2021 16:21:12 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v15 40/42] btrfs: zoned: serialize log transaction on
 zoned filesystems
Message-ID: <20210205072033.nxnbf5s2zlyofems@naota-xeon>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
 <CAL3q7H7UGEm14j1nNiX7FMkfdFq3dViw2o4uEdbZE+qpk7amLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7UGEm14j1nNiX7FMkfdFq3dViw2o4uEdbZE+qpk7amLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:50:45AM +0000, Filipe Manana wrote:
> On Thu, Feb 4, 2021 at 10:23 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> >
> > This is the 2/3 patch to enable tree-log on zoned filesystems.
> >
> > Since we can start more than one log transactions per subvolume
> > simultaneously, nodes from multiple transactions can be allocated
> > interleaved. Such mixed allocation results in non-sequential writes at the
> > time of a log transaction commit. The nodes of the global log root tree
> > (fs_info->log_root_tree), also have the same problem with mixed
> > allocation.
> >
> > Serializes log transactions by waiting for a committing transaction when
> > someone tries to start a new transaction, to avoid the mixed allocation
> > problem. We must also wait for running log transactions from another
> > subvolume, but there is no easy way to detect which subvolume root is
> > running a log transaction. So, this patch forbids starting a new log
> > transaction when other subvolumes already allocated the global log root
> > tree.
> >
> > Cc: Filipe Manana <fdmanana@gmail.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index c02eeeac439c..8be3164d4c5d 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -105,6 +105,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
> >                                        struct btrfs_root *log,
> >                                        struct btrfs_path *path,
> >                                        u64 dirid, int del_all);
> > +static void wait_log_commit(struct btrfs_root *root, int transid);
> >
> >  /*
> >   * tree logging is a special write ahead log used to make sure that
> > @@ -140,6 +141,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
> >  {
> >         struct btrfs_fs_info *fs_info = root->fs_info;
> >         struct btrfs_root *tree_root = fs_info->tree_root;
> > +       const bool zoned = btrfs_is_zoned(fs_info);
> >         int ret = 0;
> >
> >         /*
> > @@ -160,12 +162,20 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
> >
> >         mutex_lock(&root->log_mutex);
> >
> > +again:
> >         if (root->log_root) {
> > +               int index = (root->log_transid + 1) % 2;
> > +
> >                 if (btrfs_need_log_full_commit(trans)) {
> >                         ret = -EAGAIN;
> >                         goto out;
> >                 }
> >
> > +               if (zoned && atomic_read(&root->log_commit[index])) {
> > +                       wait_log_commit(root, root->log_transid - 1);
> > +                       goto again;
> > +               }
> > +
> >                 if (!root->log_start_pid) {
> >                         clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
> >                         root->log_start_pid = current->pid;
> > @@ -173,6 +183,17 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
> >                         set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
> >                 }
> >         } else {
> > +               if (zoned) {
> > +                       mutex_lock(&fs_info->tree_log_mutex);
> > +                       if (fs_info->log_root_tree)
> > +                               ret = -EAGAIN;
> > +                       else
> > +                               ret = btrfs_init_log_root_tree(trans, fs_info);
> > +                       mutex_unlock(&fs_info->tree_log_mutex);
> > +               }
> 
> So, nothing here changed since v14 - all my comments still apply [1]
> This is based on pre-5.10 code and is broken as it is - it results in
> every fsync falling back to a transaction commit, defeating the
> purpose of all the patches that deal with log trees on zoned
> filesystems.
> 
> Thanks.
> 
> [1] https://lore.kernel.org/linux-btrfs/CAL3q7H5pv416FVwThOHe+M3L5B-z_n6_ZGQQxsUq5vC5fsAoJw@mail.gmail.com/

Yes...

As noted in the cover letter, there is a fix for this issue
itself. However, the fix revealed other failures in fsync() path.
But, with further investigation, I found the failures are not really
related to zoned fsync() code. So, I will soon post two patches (one
incremental for this one, and one to deal with a regression case)..

> 
> 
> > +               if (ret)
> > +                       goto out;
> > +
> >                 ret = btrfs_add_log_tree(trans, root);
> >                 if (ret)
> >                         goto out;
> > @@ -201,14 +222,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
> >   */
> >  static int join_running_log_trans(struct btrfs_root *root)
> >  {
> > +       const bool zoned = btrfs_is_zoned(root->fs_info);
> >         int ret = -ENOENT;
> >
> >         if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &root->state))
> >                 return ret;
> >
> >         mutex_lock(&root->log_mutex);
> > +again:
> >         if (root->log_root) {
> > +               int index = (root->log_transid + 1) % 2;
> > +
> >                 ret = 0;
> > +               if (zoned && atomic_read(&root->log_commit[index])) {
> > +                       wait_log_commit(root, root->log_transid - 1);
> > +                       goto again;
> > +               }
> >                 atomic_inc(&root->log_writers);
> >         }
> >         mutex_unlock(&root->log_mutex);
> > --
> > 2.30.0
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
