Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512F2DF53F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Dec 2020 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgLTLcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Dec 2020 06:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgLTLb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Dec 2020 06:31:59 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A9FC0613CF;
        Sun, 20 Dec 2020 03:31:19 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id k8so6395301ilr.4;
        Sun, 20 Dec 2020 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLKcl/ocYUMPZqPT65EG6xHxr8q8Hzrk3PLO4y1nDoE=;
        b=B7tmzQi7dyxcDYjSX5nBnSc7NFQuaQ4gm1TcB10vXHasMa2Jq6RPJCnrIUgIcaqPDv
         juhx4d4vfkvlANTEDL44Mw60b8i6HXAGlLRlvSFKV8fMOUq2ternc7EUBZpSDdBuTUHX
         coEVpWWJfhFhz2X9gibXlmMfTCF58NvKEu/8b5Q4jag3vl60v9qJ49yNsPudHr1uEl5f
         H6Uk8oFa3o7PBZE9evcLGJexk7QgShBHR2BdeShXfXJKvu5hK/8n6CkmU8DhK4G+lqpl
         ADFIol1ybEXe6eB8h5RrBDwr1dr2b+DUaq5nA9DFp2JVmWWtPgJnFhvgIHPWk++UzOwJ
         LPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLKcl/ocYUMPZqPT65EG6xHxr8q8Hzrk3PLO4y1nDoE=;
        b=PWSfQeq7bY5eIDlC+PaC6z83/qa43LPyiH2VsaplPI4wNzo0sKsQLPMdncoin9BQDx
         X06gez8Dg92WTqBWd2F3bWAcS7JYMLU5tQl+Ec469VkTpEig9ydbdaSc0ptW5JCaBtSq
         ChVx/2dwpeWCzJIEHDMn4O1bOX/jiaFZG6hageAVTGQWBuchPA1bZl11bYzSyLWeOqzw
         pQ/0piD+OzpqRy/aS8VMWwh5h01OqiLRjP4I26gCrJ50a8WvcSyOTcKkBKCpHYS/rao3
         8sfdcq9DORdOo9d88F2cjmJ/f3e2cef8XuEI6hGDAvcZV0Z/P7F+wUrVU7w+i/Q8FOGZ
         N0Ow==
X-Gm-Message-State: AOAM533uYBv7Gq/1A6Q3eKLQPNmjepBChkn2KUsZUFkFWAfI7/43JLNy
        nOOte6IMLjg83reCB54nLX+EV/gfUNXEeyT2iMUBJV6Za48=
X-Google-Smtp-Source: ABdhPJznjmnveLVsH9lbdcoN7k8t477ijt0wBGVz18rU3LVeFdbomeZewWDLF0HgF7HjnfKI+PlmUYw6+v6+3AhUYCs=
X-Received: by 2002:a05:6e02:60f:: with SMTP id t15mr12290195ils.250.1608463878479;
 Sun, 20 Dec 2020 03:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20201218221129.851003-1-shakeelb@google.com> <CAOQ4uxiyd=N-mvYWHFx6Yq1LW1BPcriZw++MAyOGB_4CDkDKYA@mail.gmail.com>
 <CALvZod6uT+bH7NqooEbqMLC6ppcbu-v=QDQRyTcfWGUsQodYjQ@mail.gmail.com>
 <CAOQ4uxh3vEBMs8afudFU3zxKLpcKG7KuWEGkLiH0hioncum1UA@mail.gmail.com> <CALvZod6fua_SQ=1+MX_R52w8PVbFafSHgjcmhXdaRWkZtfe+cg@mail.gmail.com>
In-Reply-To: <CALvZod6fua_SQ=1+MX_R52w8PVbFafSHgjcmhXdaRWkZtfe+cg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 20 Dec 2020 13:31:07 +0200
Message-ID: <CAOQ4uxhNw12XSb7dVbUAGh+LdDzpVaF=LozoPTuXOjL8DGXn4Q@mail.gmail.com>
Subject: Re: [PATCH] inotify, memcg: account inotify instances to kmemcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 20, 2020 at 6:24 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sat, Dec 19, 2020 at 8:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Sat, Dec 19, 2020 at 4:31 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Sat, Dec 19, 2020 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Sat, Dec 19, 2020 at 12:11 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > Currently the fs sysctl inotify/max_user_instances is used to limit the
> > > > > number of inotify instances on the system. For systems running multiple
> > > > > workloads, the per-user namespace sysctl max_inotify_instances can be
> > > > > used to further partition inotify instances. However there is no easy
> > > > > way to set a sensible system level max limit on inotify instances and
> > > > > further partition it between the workloads. It is much easier to charge
> > > > > the underlying resource (i.e. memory) behind the inotify instances to
> > > > > the memcg of the workload and let their memory limits limit the number
> > > > > of inotify instances they can create.
> > > >
> > > > Not that I have a problem with this patch, but what problem does it try to
> > > > solve?
> > >
> > > I am aiming for the simplicity to not set another limit which can
> > > indirectly be limited by memcg limits. I just want to set the memcg
> > > limit on our production environment which runs multiple workloads on a
> > > system and not think about setting a sensible value to
> > > max_user_instances in production. I would prefer to set
> > > max_user_instances to max int and let the memcg limits of the
> > > workloads limit their inotify usage.
> > >
> >
> > understood.
> > and I guess the multiple workloads cannot run each in their own userns?
> > because then you wouldn't need to change max_user_instances limit.
> >
>
> No workloads can run in their own user namespace but please note that
> max_user_instances is shared between all the user namespaces.

/proc/sys/fs/inotify/max_user_instances is shared between all the user
namespaces, but it only controls the init_user_ns limits.
/proc/sys/user/max_inotify_instances is per user ns and it is the one that
actually controls the inotify limits in non init_user_ns.

That said, I see that it is always initialized to MAX_INT on non init user ns,
which is exactly the setup that you are aiming at:

$ unshare -U
$ cat /proc/sys/user/max_inotify_instances
2147483647
$ cat /proc/sys/fs/inotify/max_user_instances
128

Thanks,
Amir.
