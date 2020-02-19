Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF23C1652ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBSXIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 18:08:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45968 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBSXIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:08:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so1847428otp.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 15:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+b/hnzT2EVX6PsP41apCreu0TLShLliK5hvUBXDcdhg=;
        b=qIlUYzd/1xNdQTWozr3rnyU8nrLQyoqiBCS7An0VMpC+1xLFH+/vQkw0MpeRYPX3kV
         DMYkRfYvJs4yNdOPs62dxOgs0L0eJTu/Kn5rfdZz4c2nN4aRvBSbol5Rd5ltHkWE2j/r
         DHJKOv3OxVQfbCyg49Ja1bbxVoV5AJBbe0QN+iqpdt1pygJCis+5/wnc2VAuIp2Rudxp
         K28hrmMkh3mpLyFNVv2bFwANNfaM6JMFhcqkhWu8jZJVlNhETSr78kdLxgpz8aLH49UG
         FnEAH7GZ4+M6lrxmZ7Uphk+aNvThaOx45Bj7DcXlwmqFY2aYKMp3S62d+FmsPvyrYAj5
         SOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+b/hnzT2EVX6PsP41apCreu0TLShLliK5hvUBXDcdhg=;
        b=RtpACzitutMwtMQEw5n1P05ocsjfHmXtgmSBqjiK4iJESbVdz/eDlU3wlJH/Ta3cpR
         c3vc3ZXZ8yZ13i3ioqKILA9kebdPUvvPGj+HoVfl3rlICKnOFy7T0abf3KYX3BwK6IC4
         1XGf/r9twkkMCTHbJaCCwUVW6/ZGK4qmHboTUCnTRJp+bq4t/vTTY3dlx+bG2g0CTFnU
         QdhasoMrbxF1zH10QPbRBQHvlJZymEgk5wtITCloTkz6WZIDqxJtU94DmLCf1Iavf+7E
         3smrXOO9Yy9LpsryguQ2yUVLt4f4b+Nne7ozsQDJkkCKgLeepnhBe1s35MvDZ7za8ieb
         hmZw==
X-Gm-Message-State: APjAAAVFUjXLdrEiwhUA3WYRTfXuWeiyrSMQmKn9f59j4Yqp2c9mJVSX
        7w2dIbJTUL/rtyOB7cafgMEIVKKCdB3j+zud9fekoQ==
X-Google-Smtp-Source: APXvYqymq8C+IWZykVtXoDYEl/sBsbLdmJzjVdXLfHaGCka/F3YZemVTX4DcJK0wIaWoPsEJf0m8EHdynLmhmXHKNgc=
X-Received: by 2002:a05:6830:13c3:: with SMTP id e3mr6694844otq.180.1582153717156;
 Wed, 19 Feb 2020 15:08:37 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 20 Feb 2020 00:08:11 +0100
Message-ID: <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
> Add a superblock event notification facility whereby notifications about
> superblock events, such as I/O errors (EIO), quota limits being hit
> (EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
> process asynchronously.  Note that this does not cover vfsmount topology
> changes.  watch_mount() is used for that.
[...]
> @@ -354,6 +356,10 @@ void deactivate_locked_super(struct super_block *s)
>  {
>         struct file_system_type *fs = s->s_type;
>         if (atomic_dec_and_test(&s->s_active)) {
> +#ifdef CONFIG_SB_NOTIFICATIONS
> +               if (s->s_watchers)
> +                       remove_watch_list(s->s_watchers, s->s_unique_id);
> +#endif
>                 cleancache_invalidate_fs(s);
>                 unregister_shrinker(&s->s_shrink);
>                 fs->kill_sb(s);
[...]
> +/**
> + * sys_watch_sb - Watch for superblock events.
> + * @dfd: Base directory to pathwalk from or fd referring to superblock.
> + * @filename: Path to superblock to place the watch upon
> + * @at_flags: Pathwalk control flags
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + */
> +SYSCALL_DEFINE5(watch_sb,
> +               int, dfd,
> +               const char __user *, filename,
> +               unsigned int, at_flags,
> +               int, watch_fd,
> +               int, watch_id)
> +{
> +       struct watch_queue *wqueue;
> +       struct super_block *s;
> +       struct watch_list *wlist = NULL;
> +       struct watch *watch = NULL;
> +       struct path path;
> +       unsigned int lookup_flags =
> +               LOOKUP_DIRECTORY | LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
> +       int ret;
[...]
> +       wqueue = get_watch_queue(watch_fd);
> +       if (IS_ERR(wqueue))
> +               goto err_path;
> +
> +       s = path.dentry->d_sb;
> +       if (watch_id >= 0) {
> +               ret = -ENOMEM;
> +               if (!s->s_watchers) {

READ_ONCE() ?

> +                       wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
> +                       if (!wlist)
> +                               goto err_wqueue;
> +                       init_watch_list(wlist, NULL);
> +               }
> +
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;
> +
> +               init_watch(watch, wqueue);
> +               watch->id               = s->s_unique_id;
> +               watch->private          = s;
> +               watch->info_id          = (u32)watch_id << 24;
> +
> +               ret = security_watch_sb(watch, s);
> +               if (ret < 0)
> +                       goto err_watch;
> +
> +               down_write(&s->s_umount);
> +               ret = -EIO;
> +               if (atomic_read(&s->s_active)) {
> +                       if (!s->s_watchers) {
> +                               s->s_watchers = wlist;
> +                               wlist = NULL;
> +                       }
> +
> +                       ret = add_watch_to_object(watch, s->s_watchers);
> +                       if (ret == 0) {
> +                               spin_lock(&sb_lock);
> +                               s->s_count++;
> +                               spin_unlock(&sb_lock);

Where is the corresponding decrement of s->s_count? I'm guessing that
it should be in the ->release_watch() handler, except that there isn't
one...

> +                               watch = NULL;
> +                       }
> +               }
> +               up_write(&s->s_umount);
> +       } else {
> +               ret = -EBADSLT;
> +               if (READ_ONCE(s->s_watchers)) {

(Nit: I don't get why you do a lockless check here before taking the
lock - it'd be more straightforward to take the lock first, and it's
not like you want to optimize for the case where someone calls
sys_watch_sb() with invalid arguments...)

> +                       down_write(&s->s_umount);
> +                       ret = remove_watch_from_object(s->s_watchers, wqueue,
> +                                                      s->s_unique_id, false);
> +                       up_write(&s->s_umount);
> +               }
> +       }
> +
> +err_watch:
> +       kfree(watch);
> +err_wlist:
> +       kfree(wlist);
> +err_wqueue:
> +       put_watch_queue(wqueue);
> +err_path:
> +       path_put(&path);
> +       return ret;
> +}
> +#endif
[...]
> +/**
> + * notify_sb: Post simple superblock notification.
> + * @s: The superblock the notification is about.
> + * @subtype: The type of notification.
> + * @info: WATCH_INFO_FLAG_* flags to be set in the record.
> + */
> +static inline void notify_sb(struct super_block *s,
> +                            enum superblock_notification_type subtype,
> +                            u32 info)
> +{
> +#ifdef CONFIG_SB_NOTIFICATIONS
> +       if (unlikely(s->s_watchers)) {

READ_ONCE() ?

> +               struct superblock_notification n = {
> +                       .watch.type     = WATCH_TYPE_SB_NOTIFY,
> +                       .watch.subtype  = subtype,
> +                       .watch.info     = watch_sizeof(n) | info,
> +                       .sb_id          = s->s_unique_id,
> +               };
> +
> +               post_sb_notification(s, &n);
> +       }
> +
> +#endif
> +}
> +
> +/**
> + * notify_sb_error: Post superblock error notification.
> + * @s: The superblock the notification is about.
> + * @error: The error number to be recorded.
> + */
> +static inline int notify_sb_error(struct super_block *s, int error)
> +{
> +#ifdef CONFIG_SB_NOTIFICATIONS
> +       if (unlikely(s->s_watchers)) {

READ_ONCE() ?

> +               struct superblock_error_notification n = {
> +                       .s.watch.type   = WATCH_TYPE_SB_NOTIFY,
> +                       .s.watch.subtype = NOTIFY_SUPERBLOCK_ERROR,
> +                       .s.watch.info   = watch_sizeof(n),
> +                       .s.sb_id        = s->s_unique_id,
> +                       .error_number   = error,
> +                       .error_cookie   = 0,
> +               };
> +
> +               post_sb_notification(s, &n.s);
> +       }
> +#endif
> +       return error;
> +}
