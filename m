Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5971F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbfGWStp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 14:49:45 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40215 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfGWStp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:49:45 -0400
Received: by mail-yb1-f195.google.com with SMTP id j6so7977080ybm.7;
        Tue, 23 Jul 2019 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+nFMmvAHZoKKuRIumqq+vH7ksKEN4lOKs7AKbTh4l4=;
        b=jt33w5IV6DWsAGM+LMH+YDHLbJpJqVixE2xMhd1uVHq8PsomZRkwrzLVKP1nD1E75b
         r8ka4tFp+NsDUuP0Qm0Ltk+odrIMq8QmrfnZZ/FX1HqCdwZHxoFCAjBocDBJqQu1lsOI
         SHYUNvZByTrqHt+7suuHfFcL/t+giXYnmMRWRPeBP64KiNm0Pl/cbg3MwqVeUzEsWY4L
         9H5v5vCUDRo9BvuF5R0gFSqLuVs1cvL0xkr1lMnXPDqfWENaqdNet9odGI9m690c7VET
         7Gp7qDZkMXaDIToSOSA0bvJ2liXalmUnpwwBn0F1ahe7GMap2Nfik3Wzp3rH5Ab7fsuW
         IEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+nFMmvAHZoKKuRIumqq+vH7ksKEN4lOKs7AKbTh4l4=;
        b=Ys3kr74XAgsY8plfKMiBTjVAIvaZ7pjiwsy5oU6DNpalqDErFJKjCZ2/slABGakqT1
         AakfCNGOcGv+kJbCtZTJTQpR4MpXqoqM5PTXd39nx/PjKZ50uckiap3mo3jlBdUECjfE
         p8V0aFHZwE37xNkRs8O0RhYHCAqaxx+Lv3+Zu4gzym/xkYscxOncowxvvU2J2HPnn/z/
         sV3HS/91lWGnPvTDU/R8gf12RCjPVbjuaXKa1gYEWr5KB2OW2k7o/1T3I4NlNI4aroip
         sOvjkpUsljWyyjdDskwWmnOLobGnFmvkYqt7DrK/prZmGwn2HEE7wyI2VRIpYZ8MSpg8
         av8g==
X-Gm-Message-State: APjAAAXU4V8rLrcpy3xSSmf3Y9brYbHKiR2SEn20+4pqhqYVIkbikadu
        DHS2oxswdc5307j4dWdk2sfSYhxruDxCIoetChHHjg==
X-Google-Smtp-Source: APXvYqyHscdOs6f139YrkqweP1G1e41na4dibEzYfR1PYJSu3kKzLWQJ6f6g9m8I6ZGsTqDGjicAu/6AkrqI/VdKVSo=
X-Received: by 2002:a25:aaea:: with SMTP id t97mr46227201ybi.126.1563907783784;
 Tue, 23 Jul 2019 11:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190718143042.11059-1-acgoide@tycho.nsa.gov> <CAOQ4uxjCR76nbV_Lmoegaq6NqovWZD-XWEVS-X3e=BtDdjKkXQ@mail.gmail.com>
 <c74ad814-f188-37c6-9b3a-51178b538a2b@tycho.nsa.gov>
In-Reply-To: <c74ad814-f188-37c6-9b3a-51178b538a2b@tycho.nsa.gov>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Jul 2019 21:49:32 +0300
Message-ID: <CAOQ4uxjzwCjOsiwE6DuaXNvLQN2QKRyOc6Tkw-xFZohUZSMtNw@mail.gmail.com>
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] fanotify, inotify, dnotify,
 security: add security hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 7:17 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>
> On 7/18/19 12:16 PM, Amir Goldstein wrote:
> > On Thu, Jul 18, 2019 at 5:31 PM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> >>
> >> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> >> index a90bb19dcfa2..9e3137badb6b 100644
> >> --- a/fs/notify/fanotify/fanotify_user.c
> >> +++ b/fs/notify/fanotify/fanotify_user.c
> >> @@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops = {
> >>   };
> >>
> >>   static int fanotify_find_path(int dfd, const char __user *filename,
> >> -                             struct path *path, unsigned int flags)
> >> +                             struct path *path, unsigned int flags, __u64 mask)
> >>   {
> >>          int ret;
> >> +       unsigned int mark_type;
> >>
> >>          pr_debug("%s: dfd=%d filename=%p flags=%x\n", __func__,
> >>                   dfd, filename, flags);
> >> @@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char __user *filename,
> >>
> >>          /* you can only watch an inode if you have read permissions on it */
> >>          ret = inode_permission(path->dentry->d_inode, MAY_READ);
> >> +       if (ret) {
> >> +               path_put(path);
> >> +               goto out;
> >> +       }
> >> +
> >> +       switch (flags & FANOTIFY_MARK_TYPE_BITS) {
> >> +       case FAN_MARK_MOUNT:
> >> +               mark_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
> >> +               break;
> >> +       case FAN_MARK_FILESYSTEM:
> >> +               mark_type = FSNOTIFY_OBJ_TYPE_SB;
> >> +               break;
> >> +       case FAN_MARK_INODE:
> >> +               mark_type = FSNOTIFY_OBJ_TYPE_INODE;
> >> +               break;
> >> +       default:
> >> +               ret = -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       ret = security_inode_notify(path->dentry->d_inode, mask, mark_type);
> >
> > If you prefer 3 hooks security_{inode,mount,sb}_notify()
> > please place them in fanotify_add_{inode,mount,sb}_mark().
> >
> > If you prefer single hook with path argument, please pass path
> > down to fanotify_add_mark() and call security_path_notify() from there,
> > where you already have the object type argument.
> >
> I'm not clear on why you want me to move the hook call down to
> fanotify_add_mark(). I'd prefer to keep it adjacent to the existing
> inode_permission() call so that all the security checking occurs from
> one place.

Fine.

> Moving it down requires adding a path arg to that entire call
> chain, even though it wouldn't otherwise be needed.

That doesn't matter.

> And that raises the
> question of whether to continue passing the mnt_sb, mnt, or inode
> separately or just extract all those from the path inside of
> fanotify_add_*_mark().

You lost me. The major issue I have is with passing @inode argument
to hook for adding a mount watch. Makes no sense to me as @inode
may be accessed from any mount and without passing @path to hook
this information is lost.

>
> It also seems to destroy the parallelism with fanotify_remove_*_mark().

I don't know what that means.

> I also don't see any real benefit in splitting into three separate
> hooks, especially as some security modules will want the path or inode
> even for the mount or superblock cases, since they may have no relevant
> security information for vfsmounts or superblocks.

OK. that is an argument for single hook with @path argument.
That is fine by me.

Thanks,
Amir.
