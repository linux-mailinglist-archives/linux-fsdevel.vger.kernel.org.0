Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782AA4351D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhJTRtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhJTRsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:48:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0613C061773
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 10:46:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s61-20020a17090a69c300b0019f663cfcd1so1094095pjj.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0JoJJAhymZUhru82czrsY0Y2FZ4swxMwSG8/JZrk73k=;
        b=Z4wnyiiXYRhxaW4NIfc88HMA402/gbtJGEpMex87OnANM+fpmjvo0OoE1VOaCnNxeo
         v33whXf3v4XnFz2iy+inUm2hFjoukbJ+A8WMoaN6oUlwP88rCd9rj3esALNW1POlJ+xH
         kdg4o47jwNcfmBfItnxZeRpnel8obYwcSmHebRJTWIsmmpUE8a3X7wD6zeSJPhyODyQ5
         e4cedM9TJdcEK+kB/3A8gO+0QRQi3gZqYPIdzZ+pvZV8lHFODMPJ2bVlGCcBqXkZLvB4
         0jeW/ZLSKz0lt2zfQJ0w8cyam9uKoFCnB6usV1piEGOrKe1bCoUO018+yU5HSYr0UWb/
         Aoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0JoJJAhymZUhru82czrsY0Y2FZ4swxMwSG8/JZrk73k=;
        b=lIv0aP06OEfrpAOrs6BEeTXp2oSoPaoNOLlYL0kzU8ivHUEcfYfQ5yPltCvccwhqSM
         HF2lbQ4F+o85sItpztkG9tVxqBL+EcQWwdHntksWIQWUbAuB+ET+TYikckWNfFbDvsuM
         kVlsuPQpn+SP4PgdpFz3GRVqqqeoV8S2oJg4JsRw7UkKpxkTbu2xc6V/k6SyDwraZ4qb
         PxLy3WgBxffjPneav2q48ts3dtbVgmPCreGMvIQPbBYAXufiELa7pBHxD0AFrsATLiBt
         T8QllJEuxLleVgtzn11EC1Z/gbnFA83IX/BEe9wfPP+u0Y18kSKTw15A1IIWySrpHhY6
         5/3w==
X-Gm-Message-State: AOAM531MbZpLm2Da/Pno2lrjrIDZ1bfE3yQGq994cxjPdURQ7c5QYYIx
        vWiMuu37tZb5LU4gAgBMN1umwseo0mSH3aakUobP6g==
X-Google-Smtp-Source: ABdhPJzeABFJu2IW0WaErLejnsbROXYUGN3ugZOB8RZ6l2aFiqmEG4vsKANyoCpVFDnfiyoU37IAppxevBQWEv/e1s8=
X-Received: by 2002:a17:903:22cc:b0:13e:fa73:6fef with SMTP id
 y12-20020a17090322cc00b0013efa736fefmr444078plg.25.1634751973781; Wed, 20 Oct
 2021 10:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
 <YW13pS716ajeSgXj@dhcp22.suse.cz> <CAHS8izMnkiHtNLEzJXL64zNinbEp0oU96dPCJYfqJqk4AEQW2A@mail.gmail.com>
 <YW/cs51K/GyhhJDk@dhcp22.suse.cz>
In-Reply-To: <YW/cs51K/GyhhJDk@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 20 Oct 2021 10:46:02 -0700
Message-ID: <CAHS8izOcjfeakNC34C8=vsWPx_meexsgRkmY6Ga3TuPynH3OMA@mail.gmail.com>
Subject: Re: [RFC Proposal] Deterministic memcg charging for shared memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 2:09 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 18-10-21 07:31:58, Mina Almasry wrote:
> > On Mon, Oct 18, 2021 at 6:33 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 13-10-21 12:23:19, Mina Almasry wrote:
> > > > Below is a proposal for deterministic charging of shared memory.
> > > > Please take a look and let me know if there are any major concerns:
> > > >
> > > > Problem:
> > > > Currently shared memory is charged to the memcg of the allocating
> > > > process. This makes memory usage of processes accessing shared memo=
ry
> > > > a bit unpredictable since whichever process accesses the memory fir=
st
> > > > will get charged. We have a number of use cases where our userspace
> > > > would like deterministic charging of shared memory:
> > > >
> > > > 1. System services allocating memory for client jobs:
> > > > We have services (namely a network access service[1]) that provide
> > > > functionality for clients running on the machine and allocate memor=
y
> > > > to carry out these services. The memory usage of these services
> > > > depends on the number of jobs running on the machine and the nature=
 of
> > > > the requests made to the service, which makes the memory usage of
> > > > these services hard to predict and thus hard to limit via memory.ma=
x.
> > > > These system services would like a way to allocate memory and instr=
uct
> > > > the kernel to charge this memory to the client=E2=80=99s memcg.
> > > >
> > > > 2. Shared filesystem between subtasks of a large job
> > > > Our infrastructure has large meta jobs such as kubernetes which spa=
wn
> > > > multiple subtasks which share a tmpfs mount. These jobs and its
> > > > subtasks use that tmpfs mount for various purposes such as data
> > > > sharing or persistent data between the subtask restarts. In kuberne=
tes
> > > > terminology, the meta job is similar to pods and subtasks are
> > > > containers under pods. We want the shared memory to be
> > > > deterministically charged to the kubernetes's pod and independent t=
o
> > > > the lifetime of containers under the pod.
> > > >
> > > > 3. Shared libraries and language runtimes shared between independen=
t jobs.
> > > > We=E2=80=99d like to optimize memory usage on the machine by sharin=
g libraries
> > > > and language runtimes of many of the processes running on our machi=
nes
> > > > in separate memcgs. This produces a side effect that one job may be
> > > > unlucky to be the first to access many of the libraries and may get
> > > > oom killed as all the cached files get charged to it.
> > > >
> > > > Design:
> > > > My rough proposal to solve this problem is to simply add a
> > > > =E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesyste=
ms (namely tmpfs):
> > > > directing all the memory of the file system to be =E2=80=98remote c=
harged=E2=80=99 to
> > > > cgroup provided by that memcg=3D option.
> > >
> > > Could you be more specific about how this matches the above mentioned
> > > usecases?
> > >
> >
> > For the use cases I've listed respectively:
> > 1. Our network service would mount a tmpfs with 'memcg=3D<path to
> > client's memcg>'. Any memory the service is allocating on behalf of
> > the client, the service will allocate inside of this tmpfs mount, thus
> > charging it to the client's memcg without risk of hitting the
> > service's limit.
> > 2. The large job (kubernetes pod) would mount a tmpfs with
> > 'memcg=3D<path to large job's memcg>. It will then share this tmpfs
> > mount with the subtasks (containers in the pod). The subtasks can then
> > allocate memory in the tmpfs, having it charged to the kubernetes job,
> > without risk of hitting the container's limit.
>
> There is still a risk that the limit is hit for the memcg of shmem
> owner, right? What happens then? Isn't any of the shmem consumer a
> DoS attack vector for everybody else consuming from that same target
> memcg?

This is an interesting point and thanks for bringing it up. I think
there are a couple of things we can do about that:

1. Only allow root to mount a tmpfs with memcg=3D<anything>
2. Only processes allowed the enter cgroup at mount time can mount a
tmpfs with memcg=3D<cgroup>

Both address this DoS attack vector adequately I think. I have a
strong preference to solution (2) as it keeps the feature useful for
non-admins while still completely addressing the concern AFAICT.

> In other words aren't all of them in the same memory resource
> domain effectively? If we allow target memcg to live outside of that
> resource domain then this opens interesting questions about resource
> control in general, no? Something the unified hierarchy was aiming to
> fix wrt cgroup v1.
>

In my very humble opinion there are valid reasons for processes inside
the same resource domain to want the memory to be charged to one of
them and not the others, and there are valid reasons for the target
memcg living outside the resource domain without really fundamentally
breaking resource control. So breaking it down by use case:

W.r.t. usecase #1: our network service needs to allocate memory to
provide networking services to any job running on the system,
regardless of which cgroup that job is in. You could say it's
allocating memory to a cgroup outside its resource domain but IMHO
it's a bit of a grey area. After all the network service is servicing
network requests for jobs inside of that resource domain, and
allocating memory on behalf of those jobs and not for its 'own'
purposes in a sense.

W.r.t. usecase #2: the large jobs (kubernetes) and all its sub-tasks
(pods) are all in the same resource domain, but we still would like
the shared memory deterministically charged to the large jobs and
doesn't end up as part of the sub-task usage. I don't have concrete
numbers (I'll work on getting them), but one can image a large job
which owns a 10GB tmpfs mount. The sub-tasks say each use at most
10MB, but they need access to the shared 10GB tmpfs mount. In that
case the sub-tasks will get charged for the 10MB they privately use
and anywhere between 0-10GB for the shared memory. In situations like
these we'd like to enforce that subtasks only use 10MB of 'their'
memory and that the total memory usage of the entire job doesn't use
memory beyond a certain limit, say 10.5GB or something. There is no
way to do that today AFAIK, but with deterministic shared memory
charging this is possible.

> You are saying that it is hard to properly set limits for
> respective services but this would simply allow to hide a part of the
> consumption somewhere else. Aren't you just shifting the problem
> elsewhere? How do configure the target memcg?
>
> Do you have any numbers about the consumption variation and how big of a
> problem that is in practice?
>

So for use case #1 I have concrete numbers. Our network service
roughly allocates around 75MB/VM running on the machine. The exact
number depends on the network activity of the VM and this is just a
rough estimate. There are anywhere between 0-128 VMs running on a the
machine. So the memory usage of the network service can be anywhere
between almost 0 to 9.6GB. Statically deciding the memory limit of the
network service's cgroup is not possible. Increasing/decreasing the
limit when new VMs are scheduled on the machine is also not very
workable, as the amount of memory the service uses depends on the
network activity of the VM. Getting the limit wrong has disastrous
consequences as the service is unable to serve the entire machine.
With memcg=3D this becomes a trivial problem as each VM pads its memory
usage with extra headroom for network activity. If the headroom is
insufficient only that one VM is deprived of network services, not the
entire machine.

W.r.t usecase #2, I don't have concrete numbers, but I've outlined
above one (hopefully) reasonable scenario where we'd have an issue.

> > 3. We would need to extend this functionality to other file systems of
> > persistent disk, then mount that file system with 'memcg=3D<dedicated
> > shared library memcg>'. Jobs can then use the shared library and any
> > memory allocated due to loading the shared library is charged to a
> > dedicated memcg, and not charged to the job using the shared library.
>
> This is more of a question for fs people. My understanding is rather
> limited so I cannot even imagine all the possible setups but just from
> a very high level understanding bind mounts can get really interesting.
> Can those disagree on the memcg?
>

I will admit I've thought about the tmpfs support as much as possible,
and that extending the support to other file system will generate more
concerns, maybe even concerns specific to that file system. I'm hoping
to build support for tmpfs and leave the implementation generic enough
to be extended afterwards.

I haven't thought of it thoroughly but I would imagine bind mounts
shouldn't be able to disagree on the memcg. At least right now I can't
think of a compelling use case for that.

> I am pretty sure I didn't get to think through this very deeply, my gut
> feeling tells me that this will open many interesting questions and I am
> not sure whether it solves more problems than it introduces at this momen=
t.
> I would be really curious what others think about this.

I would also obviously love to hear opinions of others (and thanks
Michal for taking the time to review). I think I'll work on posting a
patch series to the list and hope that solicits more opinions.

> --
> Michal Hocko
> SUSE Labs
