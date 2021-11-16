Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304D452EDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 11:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhKPKUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 05:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhKPKUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:20:18 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC1C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 02:17:21 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id m11so19842751ilh.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1QM8AKW5rCLdWswQ1PcWE7G6amUcVQfOA2HOJnupHE=;
        b=YO9KcfeV6oCJZxTCA38up2FrHFwJCtZss1LEpwB2Pnv8diLgW81FDXy03fz6kQHchs
         TqXyAezTk/ymE+8iz6KwKrpxFM/3VN5OcIAHzGppszyRDgEQO2SEJ/RhXHwRaV1Uqb3e
         eDT3+FEqURzZVV1Vy+B/emJ0tJRLqOFVdKhgE7bKZ+/3meE+NrVWdRSTVPRh8RToe4BR
         vS44JPbhOdK4QV58tXCo0ZbTHFmtkLP2B3EoHAu8wejNlwPL7B1xwIN8iv4ZcDDomoR4
         nI+sz4B1kTgEZ6zgsNj4FWV91LqESl+hA/LkVa6AuV2OFhAcuHuxMdJoNFhg0zdLhdhz
         KqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1QM8AKW5rCLdWswQ1PcWE7G6amUcVQfOA2HOJnupHE=;
        b=kY/i8x+te+/2Q9aEgMYW6tG96zSpA2Ert0AqWVlzF/r1vXg/fq2bMtHkNU5fxB34kj
         xtskCA4PN//U2dhEv6GtPT597iyaDbN9cHP8aY+ZDLmH526tV4C4i3K38rgrGdqIXsB6
         NDy/slojj2Jf5cdCoPIxtzhhChFsO6UWT5cpg2w44gEeTWDDLytbZEBvn7tGq2/UnTaG
         EjJvU0keGXDPg1a2tMEFxh5IFAHMpfsCh0uzjDIAKXJVRoJM3Rqb7b3+t0xItf3lOX5+
         9/LDYUeOMyCLD+TVwS6CYQ+aWzChN6eHL1+qw0ADkIxfKB9FT7Zi8L5AY7pN4dee5QsH
         IutQ==
X-Gm-Message-State: AOAM530jmSsGN9rCffKnLdB6d1JZ7tt4XhWelH/QrZybgnzXH4aE7CU6
        PjEaMNnxzurtt3ZtFXC3LnLeaysxR6kgb9rinVpwJw==
X-Google-Smtp-Source: ABdhPJy6WwO8mtKgC1cfXDxgttmwaE0wCOtrnvSZ8v2mF+zSstZy18ngGO/685EBIT1OrJ0xHIrKWIwXGD/N2m/ScJo=
X-Received: by 2002:a05:6e02:1561:: with SMTP id k1mr3761344ilu.135.1637057840850;
 Tue, 16 Nov 2021 02:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com> <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz> <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz> <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz>
In-Reply-To: <YZN5tkhHomj6HSb2@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 16 Nov 2021 02:17:09 -0800
Message-ID: <CAHS8izNTbvhjEEb=ZrH2_4ECkVhxnCLzyd=78uWmHA_02iiA9Q@mail.gmail.com>
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

On Tue, Nov 16, 2021 at 1:28 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-11-21 16:58:19, Mina Almasry wrote:
> > On Mon, Nov 15, 2021 at 2:58 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 12-11-21 09:59:22, Mina Almasry wrote:
> > > > On Fri, Nov 12, 2021 at 12:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 12-11-21 00:12:52, Mina Almasry wrote:
> > > > > > On Thu, Nov 11, 2021 at 11:52 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Thu 11-11-21 15:42:01, Mina Almasry wrote:
> > > > > > > > On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> > > > > > > > to find a task to kill in the memcg under oom, if the oom-killer
> > > > > > > > is unable to find one, the oom-killer should simply return ENOMEM to the
> > > > > > > > allocating process.
> > > > > > >
> > > > > > > This really begs for some justification.
> > > > > > >
> > > > > >
> > > > > > I'm thinking (and I can add to the commit message in v4) that we have
> > > > > > 2 reasonable options when the oom-killer gets invoked and finds
> > > > > > nothing to kill: (1) return ENOMEM, (2) kill the allocating task. I'm
> > > > > > thinking returning ENOMEM allows the application to gracefully handle
> > > > > > the failure to remote charge and continue operation.
> > > > > >
> > > > > > For example, in the network service use case that I mentioned in the
> > > > > > RFC proposal, it's beneficial for the network service to get an ENOMEM
> > > > > > and continue to service network requests for other clients running on
> > > > > > the machine, rather than get oom-killed when hitting the remote memcg
> > > > > > limit. But, this is not a hard requirement, the network service could
> > > > > > fork a process that does the remote charging to guard against the
> > > > > > remote charge bringing down the entire process.
> > > > >
> > > > > This all belongs to the changelog so that we can discuss all potential
> > > > > implication and do not rely on any implicit assumptions.
> > > >
> > > > Understood. Maybe I'll wait to collect more feedback and upload v4
> > > > with a thorough explanation of the thought process.
> > > >
> > > > > E.g. why does
> > > > > it even make sense to kill a task in the origin cgroup?
> > > > >
> > > >
> > > > The behavior I saw returning ENOMEM for this edge case was that the
> > > > code was forever looping the pagefault, and I was (seemingly
> > > > incorrectly) under the impression that a suggestion to forever loop
> > > > the pagefault would be completely fundamentally unacceptable.
> > >
> > > Well, I have to say I am not entirely sure what is the best way to
> > > handle this situation. Another option would be to treat this similar to
> > > ENOSPACE situation. This would result into SIGBUS IIRC.
> > >
> > > The main problem with OOM killer is that it will not resolve the
> > > underlying problem in most situations. Shmem files would likely stay
> > > laying around and their charge along with them. Killing the allocating
> > > task has problems on its own because this could be just a DoS vector by
> > > other unrelated tasks sharing the shmem mount point without a gracefull
> > > fallback. Retrying the page fault is hard to detect. SIGBUS might be
> > > something that helps with the latest. The question is how to communicate
> > > this requerement down to the memcg code to know that the memory reclaim
> > > should happen (Should it? How hard we should try?) but do not invoke the
> > > oom killer. The more I think about this the nastier this is.
> >
> > So actually I thought the ENOSPC suggestion was interesting so I took
> > the liberty to prototype it. The changes required:
> >
> > 1. In out_of_memory() we return false if !oc->chosen &&
> > is_remote_oom(). This gets bubbled up to try_charge_memcg() as
> > mem_cgroup_oom() returning OOM_FAILED.
> > 2. In try_charge_memcg(), if we get an OOM_FAILED we again check
> > is_remote_oom(), if it is a remote oom, return ENOSPC.
> > 3. The calling code would return ENOSPC to the user in the no-fault
> > path, and SIGBUS the user in the fault path with no changes.
>
> I think this should be implemented at the caller side rather than
> somehow hacked into the memcg core. It is the caller to know what to do.
> The caller can use gfp flags to control the reclaim behavior.
>

Hmm I'm a bit struggling to envision this.  So would it be acceptable
at the call sites where we doing a remote charge, such as
shmem_add_to_page_cache(), if we get ENOMEM from the
mem_cgroup_charge(), and we know we're doing a remote charge (because
current's memcg != the super block memcg), then we return ENOSPC from
shmem_add_to_page_cache()? I believe that will return ENOSPC to the
userspace in the non-pagefault path and SIGBUS in the pagefault path.
Or you had something else in mind?

> > To be honest I think this is very workable, as is Shakeel's suggestion
> > of MEMCG_OOM_NO_VICTIM. Since this is an opt-in feature, we can
> > document the behavior and if the userspace doesn't want to get killed
> > they can catch the sigbus and handle it gracefully. If not, the
> > userspace just gets killed if we hit this edge case.
>
> I am not sure about the MEMCG_OOM_NO_VICTIM approach. It sounds really
> hackish to me. I will get back to Shakeel's email as time permits. The
> primary problem I have with this, though, is that the kernel oom killer
> cannot really do anything sensible if the limit is reached and there
> is nothing reclaimable left in this case. The tmpfs backed memory will
> simply stay around and there are no means to recover without userspace
> intervention.
> --
> Michal Hocko
> SUSE Labs

On Tue, Nov 16, 2021 at 1:39 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 16-11-21 10:28:25, Michal Hocko wrote:
> > On Mon 15-11-21 16:58:19, Mina Almasry wrote:
> [...]
> > > To be honest I think this is very workable, as is Shakeel's suggestion
> > > of MEMCG_OOM_NO_VICTIM. Since this is an opt-in feature, we can
> > > document the behavior and if the userspace doesn't want to get killed
> > > they can catch the sigbus and handle it gracefully. If not, the
> > > userspace just gets killed if we hit this edge case.
> >
> > I am not sure about the MEMCG_OOM_NO_VICTIM approach. It sounds really
> > hackish to me. I will get back to Shakeel's email as time permits. The
> > primary problem I have with this, though, is that the kernel oom killer
> > cannot really do anything sensible if the limit is reached and there
> > is nothing reclaimable left in this case. The tmpfs backed memory will
> > simply stay around and there are no means to recover without userspace
> > intervention.
>
> And just a small clarification. Tmpfs is fundamentally problematic from
> the OOM handling POV. The nuance here is that the OOM happens in a
> different memcg and thus a different resource domain. If you kill a task
> in the target memcg then you effectively DoS that workload. If you kill
> the allocating task then it is DoSed by anybody allowed to write to that
> shmem. All that without a graceful fallback.

I don't know if this addresses your concern, but I'm limiting the
memcg= use to processes that can enter that memcg. Therefore they
would be able to allocate memory in that memcg anyway by entering it.
So if they wanted to intentionally DoS that memcg they can already do
it without this feature.
