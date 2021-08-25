Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531CF3F7CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbhHYTqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHYTqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 15:46:35 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A1EC061757;
        Wed, 25 Aug 2021 12:45:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id v2so678222ilg.12;
        Wed, 25 Aug 2021 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnwhZGSbVz1cHi9QYXwzyOJKs7Qb7Vq2MV9xehSdJNM=;
        b=mURN+S0GOpFVlPj+U8K+/RxA41mK3B0mHsgp03I+pus6mY+ZWTlrMrWo3a/9s0oQjZ
         k4KOevYeSP665t4uvQ0PwbjLVw57EUAtBdLSn4H2g2WqhwBT5gccMXzeQOMZ8BXBXwHD
         VOgb1v8IZ+7JSKEIBrBP9OF+3l1Mrlf3vgZCJszLpQ285+uVhkJ3JYF+cXCpTAI1XZ7r
         G/TZ7YOySqIuAvsKC/C8tKRSqMDIz+9P9Lrsga+JwpxMw7vyz3V2QyDv6YECFjsXQ2/7
         Kpx6PQcz9EC3T/gxR78HB6rWF0uPNr42xXS3uoINCJjWuIWSly3GWmNTpWXWV/G05jdP
         2whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnwhZGSbVz1cHi9QYXwzyOJKs7Qb7Vq2MV9xehSdJNM=;
        b=q9vJpasBkqpV/TdkNU13HiUXaK2cCAmQZnyk/8LINOoUkBJXi+4K4a97yAV1wugVCz
         3DVcWwhLoj1Pqq/ozCrJ2bpBKWwqZ6qMXBMIsXSIn32M1Kev1VYP5Ede7xUwr/zAg+MH
         +dPH/KQue1pfWISzYsG0npbhqba1LF7GZohEsKuZGuOAejOsRb001EjfmnusPc1zk0n4
         s71OAURHmXNHDPdwtshiyhWMSO8L1jFL7W9SbGZK2oSHf6jMnxmgFjrLW0dkWgmuYCUv
         vD8jT/Fbw5t6r6lZCvN//t3kaBi6x/sPAQD4y2RJE5tZ9nxMhHkJWgA11pwXOjAEGJVX
         AgxQ==
X-Gm-Message-State: AOAM530c/MhhYxBLt1M84DgwYRcAS8uRp1jZaU7hWN05WRO9+xOhNK36
        Z78XbhJx+AN0fIhF3ov/Yflyrwb1D/8QxFkKZ5w=
X-Google-Smtp-Source: ABdhPJxPgdSSE6OFTLjfM9tJheMr7V00JrIjxqQSpZV90ROmo9jlxmyf8aenHVUCx2avBhnXgJoJH/9ovLSayS6XC+I=
X-Received: by 2002:a92:c0ce:: with SMTP id t14mr12265ilf.72.1629920749120;
 Wed, 25 Aug 2021 12:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-10-krisman@collabora.com> <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
 <87tujdz7u7.fsf@collabora.com>
In-Reply-To: <87tujdz7u7.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Aug 2021 22:45:37 +0300
Message-ID: <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] fsnotify: Allow events reported with an empty inode
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 9:40 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Some file system events (i.e. FS_ERROR) might not be associated with an
> >> inode.  For these, it makes sense to associate them directly with the
> >> super block of the file system they apply to.  This patch allows the
> >> event to be reported with a NULL inode, by recovering the superblock
> >> directly from the data field, if needed.
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >>
> >> --
> >> Changes since v5:
> >>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
> >> ---
> >>  fs/notify/fsnotify.c | 16 +++++++++++++---
> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> >> index 30d422b8c0fc..536db02cb26e 100644
> >> --- a/fs/notify/fsnotify.c
> >> +++ b/fs/notify/fsnotify.c
> >> @@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
> >>         fsnotify_clear_marks_by_sb(sb);
> >>  }
> >>
> >> +static struct super_block *fsnotify_data_sb(const void *data, int data_type)
> >> +{
> >> +       struct inode *inode = fsnotify_data_inode(data, data_type);
> >> +       struct super_block *sb = inode ? inode->i_sb : NULL;
> >> +
> >> +       return sb;
> >> +}
> >> +
> >>  /*
> >>   * Given an inode, first check if we care what happens to our children.  Inotify
> >>   * and dnotify both tell their parents about events.  If we care about any event
> >> @@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> >>   *             @file_name is relative to
> >>   * @file_name: optional file name associated with event
> >>   * @inode:     optional inode associated with event -
> >> - *             either @dir or @inode must be non-NULL.
> >> - *             if both are non-NULL event may be reported to both.
> >> + *             If @dir and @inode are NULL, @data must have a type that
> >> + *             allows retrieving the file system associated with this
> >
> > Irrelevant comment. sb must always be available from @data.
> >
> >> + *             event.  if both are non-NULL event may be reported to
> >> + *             both.
> >>   * @cookie:    inotify rename cookie
> >>   */
> >>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> >> @@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> >>                  */
> >>                 parent = dir;
> >>         }
> >> -       sb = inode->i_sb;
> >> +       sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);
> >
> >         const struct path *path = fsnotify_data_path(data, data_type);
> > +       const struct super_block *sb = fsnotify_data_sb(data, data_type);
> >
> > All the games with @data @inode and @dir args are irrelevant to this.
> > sb should always be available from @data and it does not matter
> > if fsnotify_data_inode() is the same as @inode, @dir or neither.
> > All those inodes are anyway on the same sb.
>
> Hi Amir,
>
> I think this is actually necessary.  I could identify at least one event
> (FS_CREATE | FS_ISDIR) where fsnotify is invoked with a NULL data field.
> In that case, fsnotify_dirent is called with a negative dentry from
> vfs_mkdir().  I'm not sure why exactly the dentry is negative after the

That doesn't sound right at all.
Are you sure about this?
Which filesystem was this mkdir called on?

> mkdir, but it would be possible we are racing with the file removal, I

No. Both vfs_mkdir() and vfs_rmdir() hold the dir inode lock (on parent).

> guess?  It might be a bug in fsnotify that this case even happen, but
> I'm not sure yet.

fsnotify_data_inode() should not be NULL.
fsnotify_handle_inode_event() passes fsnotify_data_inode() to
callbacks like audit_watch_handle_event() that checks
WARN_ON_ONCE(!inode)

>
> The easiest way around it is what I proposed: just use inode->i_sb if
> data is NULL.  Since, as you said, data, inode and dir are all on the
> same superblock, it should work, I think.
>

It would be papering over another issue.
I don't mind if we use inode->i_sb as long as we understand the reason
for what you are reporting.

Please provide more information.

Thanks,
Amir.
