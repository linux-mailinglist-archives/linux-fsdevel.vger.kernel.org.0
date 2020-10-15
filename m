Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5DC28F660
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbgJOQG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbgJOQG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:06:56 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24946C0613D2;
        Thu, 15 Oct 2020 09:06:56 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y16so4804017ila.7;
        Thu, 15 Oct 2020 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSviFaUlRZhqHXOho6IhrclttyIXyuuZeaGDZdgwc+Y=;
        b=vM+txehey3vmFNSdhUqX2KQKqAuF6Eb+3Z5DWst/lW458b/E4eb8+L6wPrSz89B5yG
         8/ha6wq/0o8iwA+Ui/IHA9zcGacpqGVRFlTMpnH+2K81U1guK7xg58lA0b7eKE+QPRk7
         3ROWxuD12nIDLiVhF206sfIZpwNWqsQ0S9fSahbp78JdfJQsse3pcaprB9jcaEG8WeJ/
         eH1e5+ypMr8UFfaeu8yc7Rw8I7gsfqSrbS1xTRF/J4POUNjY81sG1+GP6AyLD0/LjyLk
         nGi7yC65BEQALrw7xqBFbmVRggGehzr/E0wJPb2YnX3BtKjr2WEsswx2OxiCf7YgrDew
         G/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSviFaUlRZhqHXOho6IhrclttyIXyuuZeaGDZdgwc+Y=;
        b=Sy+LN9rmHmk+RbPgDZ9LKxkPoq9MrpJqT5Tqs83VzzresNQ0npVlVGI9joy8+E++Qe
         mMpNx+s2C9Xdck7X0Ntneg3+OqoYhROQ1bTYAMSW20xtusBszeKhxlauxXAd+QIdgdSe
         3sjImwxhVkVH2Bzd46Km/5uFMkb7vj46TzJLleCzkNbDLR8nK7I1VKz4wvWDpHZfBJnH
         HCe5VTmjsIP7ecdH6FUNInPqzEcWcwELz8Jjf+bFP2B2wh4FkzC6NQ9dAcT8QAl4wQyG
         nQ5qBOk2gCmb7Rc34Zq/NuVwLPNBnrkGd+RJOn+18csiZyK4uexxT7iyuVpKkmn5MuOM
         lyIA==
X-Gm-Message-State: AOAM5321X4ysARY8fAUN85kEOXyl8FPMkBw1JXnmTP+PcA4b45Zrp3wd
        n+4MtTLyLyd1e0pSK/O12pgwywm8REmeHL1LhyY=
X-Google-Smtp-Source: ABdhPJxyT8V9XoytkAFzwxFI5kiQ584qJSeJStU76Q6wS29l+S5pZJXGQ3Wn0/e5b+GvOugOa94OWv5S4IozQ0Us2tU=
X-Received: by 2002:a92:6403:: with SMTP id y3mr3794772ilb.72.1602778015445;
 Thu, 15 Oct 2020 09:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
 <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
 <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com>
 <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net> <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 15 Oct 2020 19:06:44 +0300
Message-ID: <CAOQ4uxhyh4i_0sEtkDkAsEARRU_J2Df1xKRSVZP9st8QPTPnww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Very well, I will try to explain with code:
>
> int ovl_inode_is_open_for_write(struct inode *inode)
> {
>        struct inode *upper_inode = ovl_inode_upper(inode);
>
>        return upper_inode && inode_is_open_for_write(upper_inode);
> }
>
> void ovl_maybe_mark_inode_dirty(struct inode *inode)
> {
>        struct inode *upper_inode = ovl_inode_upper(inode);
>
>        if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
>                 mark_inode_dirty(inode);
> }
>
> int ovl_open(struct inode *inode, struct file *file)
> {
> ...
>        if (ovl_inode_is_open_for_write(file_inode(file)))
>                ovl_add_inode_to_suspect_list(inode);
>
>         file->private_data = realfile;
>
>         return 0;
> }
>
> int ovl_release(struct inode *inode, struct file *file)
> {
>        struct inode *inode = file_inode(file);
>
>        if (ovl_inode_is_open_for_write(inode)) {

Darn! that should have been (!ovl_inode_is_open_for_write(inode))
and it should be done after fput() and grabbing inode reference with
ihold() before fput().

>                ovl_maybe_mark_inode_dirty(inode);
>                ovl_remove_inode_from_suspect_list(inode);
>        }
>
>         fput(file->private_data);
>
>         return 0;
> }
>
> int ovl_drop_inode(struct inode *inode)
> {
>        struct inode *upper_inode = ovl_inode_upper(inode);
>
>        if (!upper_inode)
>                return 1;
>        if (upper_inode->i_state & I_DIRTY_ALL)
>                return 0;
>
>        return !inode_is_open_for_write(upper_inode);
> }
>
> static int ovl_sync_fs(struct super_block *sb, int wait)
> {
>         struct ovl_fs *ofs = sb->s_fs_info;
>         struct super_block *upper_sb;
>         int ret;
>
>         if (!ovl_upper_mnt(ofs))
>                 return 0;
>
>         /*
>          * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
>          * All the super blocks will be iterated, including upper_sb.
>          *
>          * If this is a syncfs(2) call, then we do need to call
>          * sync_filesystem() on upper_sb, but enough if we do it when being
>          * called with wait == 1.
>          */
>         if (!wait) {
>                 /* mark inodes on the suspect list dirty if thier
> upper inode is dirty */
>                 ovl_mark_suspect_list_inodes_dirty();
>                 return 0;
>         }
> ...
>
>
> The races are avoided because inode is added/removed from suspect
> list while overlay inode has a reference (from file) and because upper inode
> cannot be dirtied by overlayfs when overlay inode is not on the suspect list.
>
> Unless I am missing something.
>
> Thanks,
> Amir.
