Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E42AEC69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKKIxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgKKIxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:53:12 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180AC0613D1;
        Wed, 11 Nov 2020 00:53:12 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f16so1421538otl.11;
        Wed, 11 Nov 2020 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTt8eNsbTj2hc7Fsdm5FJVkGnzmgKMJ/Dp/lxggjlCM=;
        b=VxqvT1DYKk7ExwW0O1/Fn95ePohINSTuLkDRIOq/IBsLepZqdOb8Era4egV1DESrLH
         9cbmCrntKBTtPiha5EQ6BkhsLW5RNAstB1kauuxMdWgMtYIpqSavkSuqQcBO3ZF/jxt6
         vUtSYhW8gx6S1pXHhRYSOmRsEJ72M7fdPgWpzHGb1eQzo6xUdYuh/+tbexorkxCjmi5k
         I5Tkkse3u+noQUMr2bF48DO+2J8Oi3BXmFACx95eqp5Ph7hmnPBQ7p4/ffPB0R4nk9rs
         cW7OyGO2Mee7PWzpywRsSSInBTMRkJgbZ24KSdPORrMmvCJz6zWYq/PRJYw5KqDFU5Xr
         V25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTt8eNsbTj2hc7Fsdm5FJVkGnzmgKMJ/Dp/lxggjlCM=;
        b=hiZ545X8egQlQZoucArAWOah7ExAl0LF/QB56MkB7Df5zLcM58iZkppu/kAvlBhhOs
         kEi9dN7v0N662wKJWieN+g+wdSlkeO2ZkgmGOBO6iVQu96vAKgFmDebAW8mIR7L+q+3B
         tjvxsUznr9nc/05lgfbencpUGxLLV76hGS6H0TnkNNPbSv/amUE7LFZjpXg+BpvtfHHS
         KHOvWIFjGOA9eNNzJtNGTQzP0AxGVeBVZzEvFWKFTH+p2GGVd3kdLaZJThQUbCYxqo5o
         EFY14usgYo10bCGXiobG+kLrb0Jha9oKmsyogXswlAIpA6piEluJip+ur0kOhN5Vovta
         P0mQ==
X-Gm-Message-State: AOAM532O40u92d6PGAOrpKCeOm000LC90+DMjXgXYQEk+k+giszZ4ipI
        TKTStaR8xf4wKwtd27R8ovVB68OL+D4iw/UYYm29hyO3
X-Google-Smtp-Source: ABdhPJy46xXTjsmLDFcW4tpOV6yPUcL32I2W0uehIXffxh5SO8nOCxmP1r1WSgfdLjSOH0hlKP/B9eO2+vz4kmPz2lc=
X-Received: by 2002:a9d:7ac4:: with SMTP id m4mr3607149otn.116.1605084792081;
 Wed, 11 Nov 2020 00:53:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <aa553faf9e97ee9306ecd5a67d3324a34f9ed4be.1602093760.git.yuleixzhang@tencent.com>
 <20201110200411.GU3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201110200411.GU3576660@ZenIV.linux.org.uk>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Wed, 11 Nov 2020 16:53:00 +0800
Message-ID: <CACZOiM1L2W+neaF-rd=k9cJTnQfNBLx2k9GLZydYuQiJqr=iXg@mail.gmail.com>
Subject: Re: [PATCH 01/35] fs: introduce dmemfs module
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 4:04 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Oct 08, 2020 at 03:53:51PM +0800, yulei.kernel@gmail.com wrote:
>
> > +static struct inode *
> > +dmemfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode,
> > +              dev_t dev);
>
> WTF is 'dev' for?
>
> > +static int
> > +dmemfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> > +{
> > +     struct inode *inode = dmemfs_get_inode(dir->i_sb, dir, mode, dev);
> > +     int error = -ENOSPC;
> > +
> > +     if (inode) {
> > +             d_instantiate(dentry, inode);
> > +             dget(dentry);   /* Extra count - pin the dentry in core */
> > +             error = 0;
> > +             dir->i_mtime = dir->i_ctime = current_time(inode);
> > +     }
> > +     return error;
> > +}
>
> ... same here, seeing that you only call that thing from the next two functions
> and you do *not* provide ->mknod() as a method (unsurprisingly - what would
> device nodes do there?)
>

Thanks for pointing this out. we may need support the mknod method, otherwise
the dev is redundant  and need to be removed.

> > +static int dmemfs_create(struct inode *dir, struct dentry *dentry,
> > +                      umode_t mode, bool excl)
> > +{
> > +     return dmemfs_mknod(dir, dentry, mode | S_IFREG, 0);
> > +}
> > +
> > +static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
> > +                     umode_t mode)
> > +{
> > +     int retval = dmemfs_mknod(dir, dentry, mode | S_IFDIR, 0);
> > +
> > +     if (!retval)
> > +             inc_nlink(dir);
> > +     return retval;
> > +}
>
> > +int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations dmemfs_file_operations = {
> > +     .mmap = dmemfs_file_mmap,
> > +};
>
> Er...  Is that a placeholder for later in the series?  Because as it is,
> it makes no sense whatsoever - "it can be mmapped, but any access to the
> mapped area will segfault".
>

Yes, we seperate the full implementation for dmemfs_file_mmap into
patch 05/35, it
will assign the interfaces to handle the page fault.

> > +struct inode *dmemfs_get_inode(struct super_block *sb,
> > +                            const struct inode *dir, umode_t mode, dev_t dev)
> > +{
> > +     struct inode *inode = new_inode(sb);
> > +
> > +     if (inode) {
> > +             inode->i_ino = get_next_ino();
> > +             inode_init_owner(inode, dir, mode);
> > +             inode->i_mapping->a_ops = &empty_aops;
> > +             mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> > +             mapping_set_unevictable(inode->i_mapping);
> > +             inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> > +             switch (mode & S_IFMT) {
> > +             default:
> > +                     init_special_inode(inode, mode, dev);
> > +                     break;
> > +             case S_IFREG:
> > +                     inode->i_op = &dmemfs_file_inode_operations;
> > +                     inode->i_fop = &dmemfs_file_operations;
> > +                     break;
> > +             case S_IFDIR:
> > +                     inode->i_op = &dmemfs_dir_inode_operations;
> > +                     inode->i_fop = &simple_dir_operations;
> > +
> > +                     /*
> > +                      * directory inodes start off with i_nlink == 2
> > +                      * (for "." entry)
> > +                      */
> > +                     inc_nlink(inode);
> > +                     break;
> > +             case S_IFLNK:
> > +                     inode->i_op = &page_symlink_inode_operations;
> > +                     break;
>
> Where would symlinks come from?  Or anything other than regular files and
> directories, for that matter...

You are right, so far it just supports regular files and directories.
