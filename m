Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D722C453B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 22:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhKPVap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhKPVan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:30:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E5C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 13:27:45 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p23so376116iod.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAqud/vh+1ERMXO7VFZQI5QACQ9POTCaKsop5WrE94A=;
        b=JVanQV4LeRYY/JloPGVp2xsuyXcfeLVnubaopVcPpRpDJKBcFSSYjhHvZpeWA/yoz0
         lP41Ydi/iCsuo9qZkKaXhKU20YgCrptFxyWYq+zL3VP3++PpZrC9uHgAXRPuRVA8Yygh
         Kkf8LMMRUyXnYvLiT/QxJCczOWk1eejQ69bq5i4LW1S8onIOsGRkUXEklmqNYr9Zf1fT
         cxh99TMNbSemupZyw2rDbcpCLQWxZHWYUvUNBAzIpWOU+340u8cmIfU+4E3FidMf4uHR
         9uc931So8RIOO7JNqdSvWkcZmbjJoKyA/+u84uXhfDFzLLH75FF1DWc6uNbn3q2VMc9U
         kDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAqud/vh+1ERMXO7VFZQI5QACQ9POTCaKsop5WrE94A=;
        b=nDKyeI6E5kRRVTZE6K/fipWTqgGD4sgQt7bCqKz2Pl2YBW3g9DQ9JZaBwcEPMg4R3H
         xZAXwmZEH3LXB08nwUfyeJVxY/CAz0NZ3mWOCtn64HyclZQjf06VXYJuKVvGwefGNVme
         h5x4se/sGUFlR3b3Ar4dod7hwGm+RtGF1yytxiXVLYu/WgCxfsVtBKB63rW+T1DGE3kL
         jhAYyUMvcSBDjXhFme1wrW4crdo1yEKR8jbYy8A5XvHLiFi9nToVl7VA1Lh/+PbOEMSO
         soCWDKPzfZBpTtIWY3+jMTOSTY/L0fRzZrgyJk8eRA9BowfuvOcpXHs7dAx7Ssl6TuyO
         +XUQ==
X-Gm-Message-State: AOAM531O+7960qIdhTEYKi25rtQXYSJjVXVni8OkRKRDGhOub/6AON9t
        psjC4KIATigDBJ7HdAwcG7dohzRbQkfE3vwd2aqMFw==
X-Google-Smtp-Source: ABdhPJw69dj81qm4kOLVQEu5je/mOj48g5pdeNrVlPYWIwVbq402UI6+/sbt1Moe+r5ZgJzz/zkGkLvp9ynKuJmWLTc=
X-Received: by 2002:a05:6602:3c2:: with SMTP id g2mr7593735iov.65.1637098065126;
 Tue, 16 Nov 2021 13:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com> <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz> <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz> <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz> <CAHS8izNTbvhjEEb=ZrH2_4ECkVhxnCLzyd=78uWmHA_02iiA9Q@mail.gmail.com>
 <YZOWD8hP2WpqyXvI@dhcp22.suse.cz>
In-Reply-To: <YZOWD8hP2WpqyXvI@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 16 Nov 2021 13:27:34 -0800
Message-ID: <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 3:29 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 16-11-21 02:17:09, Mina Almasry wrote:
> > On Tue, Nov 16, 2021 at 1:28 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 15-11-21 16:58:19, Mina Almasry wrote:
> > > > On Mon, Nov 15, 2021 at 2:58 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 12-11-21 09:59:22, Mina Almasry wrote:
> > > > > > On Fri, Nov 12, 2021 at 12:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Fri 12-11-21 00:12:52, Mina Almasry wrote:
> > > > > > > > On Thu, Nov 11, 2021 at 11:52 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu 11-11-21 15:42:01, Mina Almasry wrote:
> > > > > > > > > > On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> > > > > > > > > > to find a task to kill in the memcg under oom, if the oom-killer
> > > > > > > > > > is unable to find one, the oom-killer should simply return ENOMEM to the
> > > > > > > > > > allocating process.
> > > > > > > > >
> > > > > > > > > This really begs for some justification.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I'm thinking (and I can add to the commit message in v4) that we have
> > > > > > > > 2 reasonable options when the oom-killer gets invoked and finds
> > > > > > > > nothing to kill: (1) return ENOMEM, (2) kill the allocating task. I'm
> > > > > > > > thinking returning ENOMEM allows the application to gracefully handle
> > > > > > > > the failure to remote charge and continue operation.
> > > > > > > >
> > > > > > > > For example, in the network service use case that I mentioned in the
> > > > > > > > RFC proposal, it's beneficial for the network service to get an ENOMEM
> > > > > > > > and continue to service network requests for other clients running on
> > > > > > > > the machine, rather than get oom-killed when hitting the remote memcg
> > > > > > > > limit. But, this is not a hard requirement, the network service could
> > > > > > > > fork a process that does the remote charging to guard against the
> > > > > > > > remote charge bringing down the entire process.
> > > > > > >
> > > > > > > This all belongs to the changelog so that we can discuss all potential
> > > > > > > implication and do not rely on any implicit assumptions.
> > > > > >
> > > > > > Understood. Maybe I'll wait to collect more feedback and upload v4
> > > > > > with a thorough explanation of the thought process.
> > > > > >
> > > > > > > E.g. why does
> > > > > > > it even make sense to kill a task in the origin cgroup?
> > > > > > >
> > > > > >
> > > > > > The behavior I saw returning ENOMEM for this edge case was that the
> > > > > > code was forever looping the pagefault, and I was (seemingly
> > > > > > incorrectly) under the impression that a suggestion to forever loop
> > > > > > the pagefault would be completely fundamentally unacceptable.
> > > > >
> > > > > Well, I have to say I am not entirely sure what is the best way to
> > > > > handle this situation. Another option would be to treat this similar to
> > > > > ENOSPACE situation. This would result into SIGBUS IIRC.
> > > > >
> > > > > The main problem with OOM killer is that it will not resolve the
> > > > > underlying problem in most situations. Shmem files would likely stay
> > > > > laying around and their charge along with them. Killing the allocating
> > > > > task has problems on its own because this could be just a DoS vector by
> > > > > other unrelated tasks sharing the shmem mount point without a gracefull
> > > > > fallback. Retrying the page fault is hard to detect. SIGBUS might be
> > > > > something that helps with the latest. The question is how to communicate
> > > > > this requerement down to the memcg code to know that the memory reclaim
> > > > > should happen (Should it? How hard we should try?) but do not invoke the
> > > > > oom killer. The more I think about this the nastier this is.
> > > >
> > > > So actually I thought the ENOSPC suggestion was interesting so I took
> > > > the liberty to prototype it. The changes required:
> > > >
> > > > 1. In out_of_memory() we return false if !oc->chosen &&
> > > > is_remote_oom(). This gets bubbled up to try_charge_memcg() as
> > > > mem_cgroup_oom() returning OOM_FAILED.
> > > > 2. In try_charge_memcg(), if we get an OOM_FAILED we again check
> > > > is_remote_oom(), if it is a remote oom, return ENOSPC.
> > > > 3. The calling code would return ENOSPC to the user in the no-fault
> > > > path, and SIGBUS the user in the fault path with no changes.
> > >
> > > I think this should be implemented at the caller side rather than
> > > somehow hacked into the memcg core. It is the caller to know what to do.
> > > The caller can use gfp flags to control the reclaim behavior.
> > >
> >
> > Hmm I'm a bit struggling to envision this.  So would it be acceptable
> > at the call sites where we doing a remote charge, such as
> > shmem_add_to_page_cache(), if we get ENOMEM from the
> > mem_cgroup_charge(), and we know we're doing a remote charge (because
> > current's memcg != the super block memcg), then we return ENOSPC from
> > shmem_add_to_page_cache()? I believe that will return ENOSPC to the
> > userspace in the non-pagefault path and SIGBUS in the pagefault path.
> > Or you had something else in mind?
>
> Yes, exactly. I meant that all this special casing would be done at the
> shmem layer as it knows how to communicate this usecase.
>

Awesome. The more I think of it I think the ENOSPC handling is perfect
for this use case, because it gives all users of the shared memory and
remote chargers a chance to gracefully handle the ENOSPC or the SIGBUS
when we hit the nothing to kill case. The only issue is finding a
clean implementation, and if the implementation I just proposed sounds
good to you then I see no issues and I'm happy to submit this in the
next version. Shakeel and others I would love to know what you think
either now or when I post the next version.

> [...]
>
> > > And just a small clarification. Tmpfs is fundamentally problematic from
> > > the OOM handling POV. The nuance here is that the OOM happens in a
> > > different memcg and thus a different resource domain. If you kill a task
> > > in the target memcg then you effectively DoS that workload. If you kill
> > > the allocating task then it is DoSed by anybody allowed to write to that
> > > shmem. All that without a graceful fallback.
> >
> > I don't know if this addresses your concern, but I'm limiting the
> > memcg= use to processes that can enter that memcg. Therefore they
> > would be able to allocate memory in that memcg anyway by entering it.
> > So if they wanted to intentionally DoS that memcg they can already do
> > it without this feature.
>
> Can you elaborate some more? How do you enforce that the mount point
> cannot be accessed by anybody outside of that constraint?

So if I'm a bad actor that wants to intentionally DoS random memcgs on
the system I can:

mount -t tmpfs -o memcg=/sys/fs/cgroup/unified/memcg-to-dos tmpfs /mnt/tmpfs
cat /dev/random > /mnt/tmpfs

That will reliably DoS the container. But we only allow you to mount
with memcg=/sys/fs/cgroup/unified/memcg-to-dos if you're able to enter
that memcg, so I can just do:

echo $$ > /sys/fs/cgroup/unified/memcg-to-dos/cgroup.procs
allocate_infinited_memory()

So we haven't added an attack vector really. More reasonably a sys
admin will set up a tmpfs mount with
memcg=/sys/fs/cgroup/unified/shared-memory-owner, and set the limit of
the shared-memory-owner to be big enough to handle the tasks running
in that memcg _and_ all the shared memory. The sys admin can also
limit the tmpfs with the size= option to limit the total size of the
shared memory. I think the sys admin could also set permissions on the
mount so only the users that share the memory can read/write, etc.

I'm sorry if this wasn't clear before and I'll take a good look at the
commit messages I'm writing and put as much info as possible in each.

As always thank you very much for your review and feedback.

> --
> Michal Hocko
> SUSE Labs
