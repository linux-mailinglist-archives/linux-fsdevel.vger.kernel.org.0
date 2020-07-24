Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3714B22CE86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXTOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgGXTOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:14:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B9C0619E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:14:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so11085031lji.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td+POTQLbLYOoIxNCct7GsW10BBA9n/4Q5dVUic9E/Y=;
        b=BmStlzF53IfQFR9lW1QEwB6WtPaCTo8kB/5l2ZVbvkNCRtpkKknR7R7gwnINKZMYbo
         9roTE/qL7vaPo+Cyso47Tup2l6wwhF0x/6bkHDYtEfCuAEAXNXPJrsNboG8KVxzjNeDZ
         VsPfwtpzBsiG/8I7JDAyVredl46a3Ru8+ROxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td+POTQLbLYOoIxNCct7GsW10BBA9n/4Q5dVUic9E/Y=;
        b=NEt000vJ7xcmRCOkgwDlC+OoCXKtVsv1/B9cEcR0NdbV3HEb7+gRQpcX1d9GXUHhXA
         +a2OOish+R+gtL0fWfPkKY9xJ9efD+zVhRws/wT72u1e0ACWK650CdNueB6SLUoRYwAX
         +BRIjs654D3MlRBoB+jwaXc97keg4VjjodATzRfn1NbQXKKf55U5YbVNADhRbLM3etPv
         M8b2Nt3d+DTzYhZxS2Pnjh7gLxKqOjMtgUt9P+Up3ezW/B5idxU/bS1bNMAoxvLOQFH4
         TefSxYlIqxmLJZL7EraRC1ZlGCa3tfPWCAq0QT4e0sOnFp6CLdztq5msjjYZ9Wj8BJe2
         DovQ==
X-Gm-Message-State: AOAM53322bqRCGhR7LK2wUuN6wCDWo1+cxZ2K8AO9A2ok+QUF19W5m6o
        9pakj7fDofKeSjU+xXimtM5dcXvoii0=
X-Google-Smtp-Source: ABdhPJy/bIMku+AiQR8wXXTzdP0BPH5mNDHgO1IZE8GUbMmylFf7QeNMoEcIvgKGCWuB1LWbyVAsrw==
X-Received: by 2002:a2e:8199:: with SMTP id e25mr4607336ljg.307.1595618077192;
        Fri, 24 Jul 2020 12:14:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b204sm511970lfd.48.2020.07.24.12.14.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 12:14:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id b25so11059797ljp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 12:14:35 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5228146ljj.312.1595618075547;
 Fri, 24 Jul 2020 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 12:14:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
Message-ID: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This just can't be right.

On Fri, Jul 24, 2020 at 6:12 AM David Howells <dhowells@redhat.com> wrote:
>
> +
> +/**
> + * sys_watch_mount - Watch for mount topology/attribute changes
> + * @dfd: Base directory to pathwalk from or fd referring to mount.
> + * @filename: Path to mount to place the watch upon
> + * @at_flags: Pathwalk control flags
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + */
> +SYSCALL_DEFINE5(watch_mount, [...]
> +               int, watch_id)
...
> +       if (watch_id < -1 || watch_id > 0xff)
> +               return -EINVAL;
...
> +       ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
> +       if (ret)
> +               goto err_path;
...
> +       if (watch_id >= 0) {
...
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;

So now you can basically allocate as much kernel memory as you want as
a regular user, as long as you have a mounted directory you can walk
(ie everybody).

Is there any limiting of watches anywhere? I don't see it.

I notice we already have this pattern elsewhere. I think we need to
fix this before we add more watch types.

Watch allocation shouldn't just be a kzalloc(). I think you should
have a "watch_allocate()" that does the initialization of id etc, but
also does some basic per-user watch resource tracking or something.

              Linus
