Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4833F9254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 04:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbhH0C1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 22:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbhH0C1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:27:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D23C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 19:26:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so7682302edt.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 19:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tn7AXqoNlFEiSH5o/ASAVHYdKyToR0ttJRMjHQuhc2k=;
        b=kShX6RE57p3tTmkrpmlSTmebMyPgiIhmX67GY4jlYN5zdRMezqjEOqyo1BepHRZudO
         BET2EDCtfMFIb8nhAbGJxjZazPx17q3HLXlYnR1hMv1JicgUH+EgVj/BfNzSX8ME0bgg
         qyiPTolSSKhsUPz3NcC66HuIjkCnGBak211JB7HiLtCxOnt59LZWZ7hBF+Ldr7Tc8b15
         kIUjzOLBgJnvCTEwbil2XQbNsj1gjjyXEXkjGQJIGjIHmwe7ThZxyRrv+kvFyU1qe+2j
         iHbEYJUAW8m0A1Sq1L1VjflDHwDc3/exe7C2oeGPKgg9Awr0pKnogtcpHsmXLjVXlwMF
         /87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tn7AXqoNlFEiSH5o/ASAVHYdKyToR0ttJRMjHQuhc2k=;
        b=DnqzpQ0hoB0am2KlglVZ27nXnM8FXckbuaZJkbrpprKvwU6C6RRwOHvHP/jUqQekG5
         qjhi6kJqkFyCYSvFH6qoctP8L+VqfMNq2gkm8303cBWWNbcnbLrMdU0ArRidJ3TyM6UC
         P/0gl+Enm9m0hhxglp5IlQO7VapurSzMa3DL3zJutYfpImljqinn3kb5E5LMCRIsJCXV
         uYNCl9b8WdHGmw1bCBxbswdZHXsvnteH4fiwonbLF8YFt9xjRKTYkz5pgK6uEul05Xwd
         3SSQQBajwunE3PM7GWpADFcvmN/OPnEPHadb29v0RdYkgxP1phfaViONEu89OVFW82du
         9ZFg==
X-Gm-Message-State: AOAM530+K44d11ucmoDYhGKU0RTb0UBFRCkkRGAlFQXHp+WWSiezTjjL
        xftNU1V71R9yWOUEBcwpLbfLOm49VBpO4j03cE+P
X-Google-Smtp-Source: ABdhPJyAX69PQ+NxLWiGAYBLmdcOx3QvYk2/H1F/1d3DZLZ/12m47WckKKaur36QJcC5AJHYtraO8I6FNeqLBKEN87Q=
X-Received: by 2002:a05:6402:1642:: with SMTP id s2mr7461170edx.135.1630031171063;
 Thu, 26 Aug 2021 19:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-10-krisman@collabora.com> <CAOQ4uxi7otGo6aNNMk9-fVQCx4Q0tDFe7sJaCr6jj1tNtfExTg@mail.gmail.com>
 <87tujdz7u7.fsf@collabora.com> <CAOQ4uxhj=UuvT5ZonFD2sgufqWrF9m4XJ19koQ5390GUZ32g7g@mail.gmail.com>
 <87mtp5yz0q.fsf@collabora.com> <CAOQ4uxjnb0JmKVpMuEfa_NgHmLRchLz_3=9t2nepdS4QXJ=QVg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjnb0JmKVpMuEfa_NgHmLRchLz_3=9t2nepdS4QXJ=QVg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Aug 2021 22:26:00 -0400
Message-ID: <CAHC9VhT9SE6+kLYBh2d7CW5N6RCr=_ryK+ncGvqYJ51B7_egPA@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] fsnotify: Allow events reported with an empty inode
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
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

On Thu, Aug 26, 2021 at 6:45 AM Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Aug 26, 2021 at 12:50 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Wed, Aug 25, 2021 at 9:40 PM Gabriel Krisman Bertazi
> > > <krisman@collabora.com> wrote:
> > >>
> > >> Amir Goldstein <amir73il@gmail.com> writes:
> > >>
> > >> > On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
> > >> > <krisman@collabora.com> wrote:
> > >> >>
> > >> >> Some file system events (i.e. FS_ERROR) might not be associated with an
> > >> >> inode.  For these, it makes sense to associate them directly with the
> > >> >> super block of the file system they apply to.  This patch allows the
> > >> >> event to be reported with a NULL inode, by recovering the superblock
> > >> >> directly from the data field, if needed.
> > >> >>
> > >> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > >> >>
> > >> >> --
> > >> >> Changes since v5:
> > >> >>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
> > >> >> ---
> > >> >>  fs/notify/fsnotify.c | 16 +++++++++++++---
> > >> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> > >> >>
> > >> >> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > >> >> index 30d422b8c0fc..536db02cb26e 100644
> > >> >> --- a/fs/notify/fsnotify.c
> > >> >> +++ b/fs/notify/fsnotify.c
> > >> >> @@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
> > >> >>         fsnotify_clear_marks_by_sb(sb);
> > >> >>  }
> > >> >>
> > >> >> +static struct super_block *fsnotify_data_sb(const void *data, int data_type)
> > >> >> +{
> > >> >> +       struct inode *inode = fsnotify_data_inode(data, data_type);
> > >> >> +       struct super_block *sb = inode ? inode->i_sb : NULL;
> > >> >> +
> > >> >> +       return sb;
> > >> >> +}
> > >> >> +
> > >> >>  /*
> > >> >>   * Given an inode, first check if we care what happens to our children.  Inotify
> > >> >>   * and dnotify both tell their parents about events.  If we care about any event
> > >> >> @@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> > >> >>   *             @file_name is relative to
> > >> >>   * @file_name: optional file name associated with event
> > >> >>   * @inode:     optional inode associated with event -
> > >> >> - *             either @dir or @inode must be non-NULL.
> > >> >> - *             if both are non-NULL event may be reported to both.
> > >> >> + *             If @dir and @inode are NULL, @data must have a type that
> > >> >> + *             allows retrieving the file system associated with this
> > >> >
> > >> > Irrelevant comment. sb must always be available from @data.
> > >> >
> > >> >> + *             event.  if both are non-NULL event may be reported to
> > >> >> + *             both.
> > >> >>   * @cookie:    inotify rename cookie
> > >> >>   */
> > >> >>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> > >> >> @@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> > >> >>                  */
> > >> >>                 parent = dir;
> > >> >>         }
> > >> >> -       sb = inode->i_sb;
> > >> >> +       sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);
> > >> >
> > >> >         const struct path *path = fsnotify_data_path(data, data_type);
> > >> > +       const struct super_block *sb = fsnotify_data_sb(data, data_type);
> > >> >
> > >> > All the games with @data @inode and @dir args are irrelevant to this.
> > >> > sb should always be available from @data and it does not matter
> > >> > if fsnotify_data_inode() is the same as @inode, @dir or neither.
> > >> > All those inodes are anyway on the same sb.
> > >>
> > >> Hi Amir,
> > >>
> > >> I think this is actually necessary.  I could identify at least one event
> > >> (FS_CREATE | FS_ISDIR) where fsnotify is invoked with a NULL data field.
> > >> In that case, fsnotify_dirent is called with a negative dentry from
> > >> vfs_mkdir().  I'm not sure why exactly the dentry is negative after the
> > >
> > > That doesn't sound right at all.
> > > Are you sure about this?
> > > Which filesystem was this mkdir called on?
> >
> > You should be able to reproduce it on top of mainline if you pick only this
> > patch and do the change you suggested:
> >
> >  -       sb = inode->i_sb;
> >  +       sb = fsnotify_data_sb(data, data_type);
> >
> > And then boot a Debian stable with systemd.  The notification happens on
> > the cgroup pseudo-filesystem (/sys/fs/cgroup), which is being monitored
> > by systemd itself.  The event that arrives with a NULL data is telling the
> > directory /sys/fs/cgroup/*/ about the creation of directory
> > `init.scope`.
> >
> > The change above triggers the following null dereference of struct
> > super_block, since data is NULL.
> >
> > I will keep looking but you might be able to answer it immediately...
>
> Yes, I see what is going on.
>
> cgroupfs is a sort of kernfs and kernfs_iop_mkdir() does not instantiate
> the negative dentry. Instead, kernfs_dop_revalidate() always invalidates
> negative dentries to force re-lookup to find the inode.
>
> Documentation/filesystems/vfs.rst says on create() and friends:
> "...you will probably call d_instantiate() with the dentry and the
>   newly created inode..."
>
> So this behavior seems legit.
> Meaning that we have made a wrong assumption in fsnotify_create()
> and fsnotify_mkdir().
> Please note the comment above fsnotify_link() which anticipates
> negative dentries.
>
> I've audited the fsnotify backends and it seems that the
> WARN_ON(!inode) in kernel/audit_* is the only immediate implication
> of negative dentry with FS_CREATE.
> I am the one who added these WARN_ON(), so I will remove them.
> I think that missing inode in an FS_CREATE event really breaks
> audit on kernfs, but not sure if that is a valid use case (Paul?).

While it is tempting to ignore kernfs from an audit filesystem watch
perspective, I can see admins potentially wanting to watch
kernfs/cgroupfs/other-config-pseudofs to detect who is potentially
playing with the system config.  Arguably the most important config
changes would already be audited if they were security relevant, but I
could also see an admin wanting to watch for *any* changes so it's
probably best not to rule out a kernfs based watch right now.

I'm sure I'm missing some details, but from what I gather from the
portion of the thread that I'm seeing, it looks like the audit issue
lies in audit_mark_handle_event() and audit_watch_handle_event().  In
both cases it looks like the functions are at least safe with a NULL
inode pointer, even with the WARN_ON() removed; the problem being that
the mark and watch will not be updated with the device and inode
number which means the audit filters based on those marks/watches will
not trigger.  Is that about right or did I read the thread and code a
bit too quickly?

Working under the assumption that the above is close enough to
correct, that is a bit of a problem as it means audit can't
effectively watch kernfs based filesystems, although it sounds like it
wasn't really working properly to begin with, yes?  Before I start
thinking too hard about this, does anyone already have a great idea to
fix this that they want to share?

-- 
paul moore
www.paul-moore.com
