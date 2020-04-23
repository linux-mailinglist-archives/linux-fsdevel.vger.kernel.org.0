Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE301B6561
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 22:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDWU2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 16:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDWU2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:28:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DCC09B042
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 13:28:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so7624385lje.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giPR15AGo2ieKRr3YuoUOrhNULDHeEPLry+vrqvhGiE=;
        b=JQhx257sPEWqT9zRF6PD8JqbodRaG1MGCuGlHa53uJha8lI8D96q5xrXYbWjmV6xLd
         oywtHlBFUsxfiEyxeaj+g1ToDxzvFWnhXvi/Cn4OihPXDgNMAC9boLNLxKuDK6PnpbS7
         xmyHWYFSP2mhTikwCZUYiiY3pVwTxO/itjoVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giPR15AGo2ieKRr3YuoUOrhNULDHeEPLry+vrqvhGiE=;
        b=taGFwT/OGsSostYq6B92Fct4IcAYwCD8IPe2PcCgeT44w0YAvRoSwfApcG7vYT3DqH
         3IAtcPf3HCYe/zcLHgOPUlZjiqAXVhJ7I99qQbulSE65C0MR/DIRmYXzWWwJihSTrn2O
         GlOq4oOEiqsELwohViSfm4HznJofhq6ugc1v8DbloPvvWZoeGxajMAAeFBwgHJE6s1mz
         BqdF4RpUVwG1bkyG0n0lqxg6JOiMAKJM9TfD7NbKY7Nr0geQ9rLnzg3o1F6/55rfCPvX
         l57TP15HaCMV4mXIYYV7P0sJkKUivzj2Y5URxQ6yziRfFkgO9dMW7gtTnyQHDwZ5s5Jx
         ZdIg==
X-Gm-Message-State: AGi0PuYcQOUzFSDCzbAuIGzVpX3CnnytQduj+NmHqkxx8N6tZ5UAYQ78
        gr29VCTYHypoGl0T3ROrm3g/I6I9LK0=
X-Google-Smtp-Source: APiQypI8Cp0tw6dtiKBPu6P/R6Sr8VrXKyWMrnR4xEKV5gqxzD+HwVuRjHWvAsQNdoDm4gOsc+zCFQ==
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr3511696ljo.128.1587673716078;
        Thu, 23 Apr 2020 13:28:36 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 4sm2689243ljf.79.2020.04.23.13.28.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 13:28:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a21so7632337ljb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 13:28:34 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr3533041lji.201.1587673714229;
 Thu, 23 Apr 2020 13:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Apr 2020 13:28:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
Message-ID: <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:42 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> +void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
> +{
> +       /* pid_links[PIDTYPE_PID].next is always NULL */
> +       struct pid *npid = READ_ONCE(ntask->thread_pid);
> +       struct pid *opid = READ_ONCE(otask->thread_pid);
> +
> +       rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
> +       rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
> +       rcu_assign_pointer(ntask->thread_pid, opid);
> +       rcu_assign_pointer(otask->thread_pid, npid);
> +       WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
> +       WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
> +       WRITE_ONCE(ntask->pid, pid_nr(opid));
> +       WRITE_ONCE(otask->pid, pid_nr(npid));
> +}

This function is _very_ hard to read as written.

It really wants a helper function to do the swapping per hlist_head
and hlist_node, I think. And "opid/npid" is very hard to see, and the
naming doesn't make much sense (if it's an "exchange", then why is it
"old/new" - they're symmetric).

At least something like

        struct hlist_head *old_pid_hlist = opid->tasks + PIDTYPE_PID;
        struct hlist_head *new_pid_hlist = npid->tasks + PIDTYPE_PID;
        struct hlist_node *old_pid_node = otask->pid_links + PIDTYPE_PID;
        struct hlist_node *new_pid_node = ntask->pid_links + PIDTYPE_PID;

        struct hlist_node *old_first_node = old_pid_hlist->first;
        struct hlist_node *new_first_node = new_pid_hlist->first;

and then trying to group up the first/pprev/thread_pid/pid  accesses
so that you them together, and using a helper function that does the
whole switch, so that you'd have

        /* Move new node to old hlist, and update thread_pid/pid fields */
        insert_pid_pointers(old_pid_hlist, new_pid_node, new_first_node);
        rcu_assign_pointer(ntask->thread_pid, opid);
        WRITE_ONCE(ntask->pid, pid_nr(opid));

        /* Move old new to new hlist, and update thread_pid/pid fields */
        insert_pid_pointers(new_pid_hlist, old_pid_node, old_first_node);
        rcu_assign_pointer(otask->thread_pid, npid);
        WRITE_ONCE(otask->pid, pid_nr(npid));

or something roughly like that.

(And the above still uses "old/new", which as mentioned sounds wrong
to me. Maybe it should just be "a_xyz" and "b_xyz"? Also note that I
did this in my MUA, so I could have gotten the names and types wrong
etc).

I think that would make it look at least _slightly_ less like random
line noise and easier to follow.

But maybe even a rcu_hlist_swap() helper? We have one for regular
lists. Do we really have to do it all written out, not do it with a
"remove and reinsert" model?

                Linus
