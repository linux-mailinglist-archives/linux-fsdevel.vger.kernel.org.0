Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DA45AC34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 20:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhKWT3b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 14:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhKWT3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:29:30 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB8C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 11:26:22 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x9so154640ilu.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DrbvvoEp3eEtdSVO2kavrMa/fNoSfDsL+n5mIG6yaDI=;
        b=C95P6igru4zfpgr3PJaXU9M4jhNp4ZSa2k55DvrzqcRkgMKA23+q0KKiFyzdmpS2He
         h/xVGOjMEQVQG4HVIZzRaJOxHquuSan5TmSXwHwQZOmqoi+OeawHuLdgtm6YWR1Kuzwg
         +jCGImbVZLJhO/Qs9Oo3jXNPTNX/MMXRw7TA1iw5ru2YoNm+4AbENWnVMvjELdT6fpbp
         wEvNhxGjH1JAvKQfb0uHLOS5ZXmIPsfSRf9TmMyS4Nw4E+hWqaUs7veAX4kBdmLTLFoD
         Tcji4/UYpH6kG4yf8WTyMIO1QDShTPm595tuRXJ6qLZF8QWAeouL8Nz3v2ahalZsGNdI
         2yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DrbvvoEp3eEtdSVO2kavrMa/fNoSfDsL+n5mIG6yaDI=;
        b=y0F59T/kYkp0ZwVGZwvuyHx1AtLG2Gb+NdfGczB0lWRVwTkYTK7gmNV8fg7+ZOEwn4
         oKW5Jppiw8UudvW2G6eT/xCwASeRYHLgKqhfTz4kf7AWuRJZ8Av2jeNpOGgZwIRN23V8
         IdL73111ck9+TT5XpNaBUttu5XJN/LV4uWalYd+wNVFjj+nRzygxsD9BOKjclGIQJ9Cx
         b9695pxoaoO4g4+uqw1gJTByXq42RSxbT840xNCJ+b5YirYXxoqQB9a/yzd+Jyw88BGz
         3Imu+PeZv6j8t8z7uM8GFT2BiCqyzUC0JAMRm7DA6tX/QwAVuQjOtxv/3SoMK4ktgSiA
         cYBA==
X-Gm-Message-State: AOAM53032323vdV9xUQDbHgKScy0mhy5XQPU52d5Nn21aLQwbIV4UqEL
        SYsAj0dE7DcoF6TeRl13YpdCJEWAYYvp3TWr/ofB5w==
X-Google-Smtp-Source: ABdhPJx1CpQZjFy666pSSIAS+fA8fBwP/PPp5NtA09eqEmvSwZX/Z+ORXd+k/8mWQNaRxEp11ZEVvLiHvWqpEp7Hjag=
X-Received: by 2002:a05:6e02:2167:: with SMTP id s7mr1388276ilv.228.1637695581046;
 Tue, 23 Nov 2021 11:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com>
 <YZvppKvUPTIytM/c@cmpxchg.org> <YZwjJjccnlL1SDSN@carbon.dhcp.thefacebook.com>
In-Reply-To: <YZwjJjccnlL1SDSN@carbon.dhcp.thefacebook.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 23 Nov 2021 11:26:09 -0800
Message-ID: <CAHS8izNLevXz-Qyi7L-kecSnfEGiyYPXSv9myJrCFHqR222_Rg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 3:09 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Nov 22, 2021 at 02:04:04PM -0500, Johannes Weiner wrote:
> > On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> > > Problem:
> > > Currently shared memory is charged to the memcg of the allocating
> > > process. This makes memory usage of processes accessing shared memory
> > > a bit unpredictable since whichever process accesses the memory first
> > > will get charged. We have a number of use cases where our userspace
> > > would like deterministic charging of shared memory:
> > >
> > > 1. System services allocating memory for client jobs:
> > > We have services (namely a network access service[1]) that provide
> > > functionality for clients running on the machine and allocate memory
> > > to carry out these services. The memory usage of these services
> > > depends on the number of jobs running on the machine and the nature o=
f
> > > the requests made to the service, which makes the memory usage of
> > > these services hard to predict and thus hard to limit via memory.max.
> > > These system services would like a way to allocate memory and instruc=
t
> > > the kernel to charge this memory to the client=E2=80=99s memcg.
> > >
> > > 2. Shared filesystem between subtasks of a large job
> > > Our infrastructure has large meta jobs such as kubernetes which spawn
> > > multiple subtasks which share a tmpfs mount. These jobs and its
> > > subtasks use that tmpfs mount for various purposes such as data
> > > sharing or persistent data between the subtask restarts. In kubernete=
s
> > > terminology, the meta job is similar to pods and subtasks are
> > > containers under pods. We want the shared memory to be
> > > deterministically charged to the kubernetes's pod and independent to
> > > the lifetime of containers under the pod.
> > >
> > > 3. Shared libraries and language runtimes shared between independent =
jobs.
> > > We=E2=80=99d like to optimize memory usage on the machine by sharing =
libraries
> > > and language runtimes of many of the processes running on our machine=
s
> > > in separate memcgs. This produces a side effect that one job may be
> > > unlucky to be the first to access many of the libraries and may get
> > > oom killed as all the cached files get charged to it.
> > >
> > > Design:
> > > My rough proposal to solve this problem is to simply add a
> > > =E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesystems=
:
> > > directing all the memory of the file system to be =E2=80=98remote cha=
rged=E2=80=99 to
> > > cgroup provided by that memcg=3D option.
> > >
> > > Caveats:
> > >
> > > 1. One complication to address is the behavior when the target memcg
> > > hits its memory.max limit because of remote charging. In this case th=
e
> > > oom-killer will be invoked, but the oom-killer may not find anything
> > > to kill in the target memcg being charged. Thera are a number of cons=
iderations
> > > in this case:
> > >
> > > 1. It's not great to kill the allocating process since the allocating=
 process
> > >    is not running in the memcg under oom, and killing it will not fre=
e memory
> > >    in the memcg under oom.
> > > 2. Pagefaults may hit the memcg limit, and we need to handle the page=
fault
> > >    somehow. If not, the process will forever loop the pagefault in th=
e upstream
> > >    kernel.
> > >
> > > In this case, I propose simply failing the remote charge and returnin=
g an ENOSPC
> > > to the caller. This will cause will cause the process executing the r=
emote
> > > charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on t=
he pagefault
> > > path.  This will be documented behavior of remote charging, and this =
feature is
> > > opt-in. Users can:
> > > - Not opt-into the feature if they want.
> > > - Opt-into the feature and accept the risk of received ENOSPC or SIGB=
US and
> > >   abort if they desire.
> > > - Gracefully handle any resulting ENOSPC or SIGBUS errors and continu=
e their
> > >   operation without executing the remote charge if possible.
> > >
> > > 2. Only processes allowed the enter cgroup at mount time can mount a
> > > tmpfs with memcg=3D<cgroup>. This is to prevent intential DoS of rand=
om cgroups
> > > on the machine. However, once a filesysetem is mounted with memcg=3D<=
cgroup>, any
> > > process with write access to this mount point will be able to charge =
memory to
> > > <cgroup>. This is largely a non-issue because in configurations where=
 there is
> > > untrusted code running on the machine, mount point access needs to be
> > > restricted to the intended users only regardless of whether the mount=
 point
> > > memory is deterministly charged or not.
> >
> > I'm not a fan of this. It uses filesystem mounts to create shareable
> > resource domains outside of the cgroup hierarchy, which has all the
> > downsides you listed, and more:
> >
> > 1. You need a filesystem interface in the first place, and a new
> >    ad-hoc channel and permission model to coordinate with the cgroup
> >    tree, which isn't great. All filesystems you want to share data on
> >    need to be converted.
> >
> > 2. It doesn't extend to non-filesystem sources of shared data, such as
> >    memfds, ipc shm etc.
> >
> > 3. It requires unintuitive configuration for what should be basic
> >    shared accounting semantics. Per default you still get the old
> >    'first touch' semantics, but to get sharing you need to reconfigure
> >    the filesystems?
> >
> > 4. If a task needs to work with a hierarchy of data sharing domains -
> >    system-wide, group of jobs, job - it must interact with a hierarchy
> >    of filesystem mounts. This is a pain to setup and may require task
> >    awareness. Moving data around, working with different mount points.
> >    Also, no shared and private data accounting within the same file.
> >
> > 5. It reintroduces cgroup1 semantics of tasks and resouces, which are
> >    entangled, sitting in disjunct domains. OOM killing is one quirk of
> >    that, but there are others you haven't touched on. Who is charged
> >    for the CPU cycles of reclaim in the out-of-band domain?  Who is
> >    charged for the paging IO? How is resource pressure accounted and
> >    attributed? Soon you need cpu=3D and io=3D as well.
> >
> > My take on this is that it might work for your rather specific
> > usecase, but it doesn't strike me as a general-purpose feature
> > suitable for upstream.
> >
> >
> > If we want sharing semantics for memory, I think we need a more
> > generic implementation with a cleaner interface.
> >
> > Here is one idea:
> >
> > Have you considered reparenting pages that are accessed by multiple
> > cgroups to the first common ancestor of those groups?
> >
> > Essentially, whenever there is a memory access (minor fault, buffered
> > IO) to a page that doesn't belong to the accessing task's cgroup, you
> > find the common ancestor between that task and the owning cgroup, and
> > move the page there.
> >
> > With a tree like this:
> >
> >       root - job group - job
> >                         `- job
> >             `- job group - job
> >                         `- job
> >
> > all pages accessed inside that tree will propagate to the highest
> > level at which they are shared - which is the same level where you'd
> > also set shared policies, like a job group memory limit or io weight.
> >
> > E.g. libc pages would (likely) bubble to the root, persistent tmpfs
> > pages would bubble to the respective job group, private data would
> > stay within each job.
> >
> > No further user configuration necessary. Although you still *can* use
> > mount namespacing etc. to prohibit undesired sharing between cgroups.
> >
> > The actual user-visible accounting change would be quite small, and
> > arguably much more intuitive. Remember that accounting is recursive,
> > meaning that a job page today also shows up in the counters of job
> > group and root. This would not change. The only thing that IS weird
> > today is that when two jobs share a page, it will arbitrarily show up
> > in one job's counter but not in the other's. That would change: it
> > would no longer show up as either, since it's not private to either;
> > it would just be a job group (and up) page.
>
> In general I like the idea, but I think the user-visible change will be q=
uite
> large, almost "cgroup v3"-large. Here are some problems:
> 1) Anything shared between e.g. system.slice and user.slice now belongs
>    to the root cgroup and is completely unaccounted/unlimited. E.g. all p=
agecache
>    belonging to shared libraries.
> 2) It's concerning in security terms. If I understand the idea correctly,=
 a
>    read-only access will allow to move charges to an upper level, potenti=
ally
>    crossing memory.max limits. It doesn't sound safe.
> 3) It brings a non-trivial amount of memory to non-leave cgroups. To some=
 extent
>    it returns us to the cgroup v1 world and a question of competition bet=
ween
>    resources consumed by a cgroup directly and through children cgroups. =
Not
>    like the problem doesn't exist now, but it's less pronounced.
>    If say >50% of system.slice's memory will belong to system.slice direc=
tly,
>    then we likely will need separate non-recursive counters, limits, prot=
ections,
>    etc.
> 4) Imagine a production server and a system administrator entering using =
ssh
>    (and being put into user.slice) and running a big grep... It screws up=
 all
>    memory accounting until a next reboot. Not a completely impossible sce=
nario.
>
> That said, I agree with Johannes and I'm also not a big fan of this patch=
set.
>
> I agree that the problem exist and that the patchset provides a solution,=
 but
> it doesn't look nice (and generic enough) and creates a lot of questions =
and
> corner cases.
>

Thanks as always for your review and I definitely welcome any
suggestions for how to solve this. I surmise from your response and
Johannes's that we're looking here for a solution that involves no
configuration from the sysadmin, where the kernel automatically
figures out where is the best place for the shared memory to get
charged and there are little to no corner cases to handle. I honestly
can't think of one at this moment. I was thinking some opt-in
deterministic charging with some configuration from the sysadmin and
reasonable edge case handling could make sense.

> Btw, won't (an optional) disabling of memcg accounting for a tmpfs solve =
your
> problem? It will be less invasive and will not require any oom changes.

I think it will solve use case #1, but I don't see it solving use
cases #2 and #3. To be completely honest it sounds a bit hacky to me
and there were concerns on this patchset that sysadmin needs to rely
on ad-hoc mount write permissions to reliably use a memcg=3D feature,
but disabling tmpfs accounting is in the same boat and seems a more
dangerous? (as in mistakingly granting write access to a tmpfs mount
to a bad actor can reliably DoS the entire machine).
