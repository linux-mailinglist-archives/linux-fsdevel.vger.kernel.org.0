Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328604578D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 23:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhKSWf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 17:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKSWf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:35:26 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34372C06173E
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 14:32:24 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w15so11690390ill.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 14:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vri4PdLKLggjhgJ5VxNKz964w0v9yx39CME6ZcKlI0Y=;
        b=RlkNcXh60XBJa98oBUAY2NBK/EpASa3MUbDj2vVfkyl/93WMDDSkSR4Qjn7S3DV9TW
         CuXaHuJHbpNvbNQ2DhoGyL9s8Q+a15CNVpe9OKEamq7eH7aEvGlTpgL8KO/XOG8C4qLs
         BLgmmSsKxl8cS8U1u5UEcXEuHANhEGRlWHHkWtsMyk9zzsRmHsB+8nmSfP2B8OvE2r/u
         oPA8EPnMvLfVNxg7G9sN1PuR3BiOA1wJ+2cL4wQm19Ef+itFNaogJuldhv7DNV7rFtSG
         Rftdw0fJDHiTw3gMsPI9Gi9VspXZl2QZSKk5VV9E7AneU0noBHUb92fjfyFXDQibN2iA
         Z1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vri4PdLKLggjhgJ5VxNKz964w0v9yx39CME6ZcKlI0Y=;
        b=EW9UXdh/O2IATihVos87UekKaPHztLn7hB+jBEbkOVEVngLnITovLzF4+XJfLerxgt
         cT35P4G5YItkM18JEVT3j/DPnEjPyXKYPXgEI3+IccbUmYvUTen2cQlwxYlI5DmCHMmE
         qQOEls8dC210G+KTFogt2FISuJTg9dbe9qr2Ai46TI437+I4adjf8NwyNPKjL+JlesY7
         eXyoY90Von1v4kx5jPqqDkDSl/oH69R4ySIypReZssiozbhGIKgCdQUU3/i4NDlozWks
         kZXkPMjrSWNV44xKZq1UxE4aWzhQfMOaEDMV5UkNX+Czpt1/Z9AGXt/eaxM0kCwFOBlh
         5fZQ==
X-Gm-Message-State: AOAM5325XCDPYFHRvHNYqqzrUaqmZmQGVIJJjAI/OMnATHf8UCawB247
        +Dcoivc7+u3he0LjmoAP3RwzT8ln0OslEFLOf7yd0w==
X-Google-Smtp-Source: ABdhPJyYMs25GW4tP+otsYKYWw1VA2Cth6i6zz1X0egvrczw7lq4sLqm9821DZgpPhdD1ocuiIBWKf/kEjnOFSXOccI=
X-Received: by 2002:a92:6b0b:: with SMTP id g11mr7489208ilc.146.1637361143401;
 Fri, 19 Nov 2021 14:32:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz> <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz> <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz> <CAHS8izNTbvhjEEb=ZrH2_4ECkVhxnCLzyd=78uWmHA_02iiA9Q@mail.gmail.com>
 <YZOWD8hP2WpqyXvI@dhcp22.suse.cz> <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
 <CALvZod7FHO6edK1cR+rbt6cG=+zUzEx3+rKWT5mi73Q29_Y5qA@mail.gmail.com> <YZYTaSVUWUhW0d9t@dhcp22.suse.cz>
In-Reply-To: <YZYTaSVUWUhW0d9t@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 19 Nov 2021 14:32:12 -0800
Message-ID: <CAHS8izM8F10Jf=n+U7o4He3nB7-43OZ9FEa0JWAo-Shai3oD7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
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

On Thu, Nov 18, 2021 at 12:47 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 16-11-21 13:27:34, Mina Almasry wrote:
> > On Tue, Nov 16, 2021 at 3:29 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Can you elaborate some more? How do you enforce that the mount point
> > > cannot be accessed by anybody outside of that constraint?
> >
> > So if I'm a bad actor that wants to intentionally DoS random memcgs on
> > the system I can:
> >
> > mount -t tmpfs -o memcg=/sys/fs/cgroup/unified/memcg-to-dos tmpfs /mnt/tmpfs
> > cat /dev/random > /mnt/tmpfs
>
> If you can mount tmpfs then you do not need to fiddle with memcgs at
> all. You just DoS the whole machine. That is not what I was asking
> though.
>
> My question was more towards a difference scenario. How do you
> prevent random processes to _write_ to those mount points? User/group
> permissions might be just too coarse to describe memcg relation. Without
> memcg in place somebody could cause ENOSPC to the mount point users
> and that is not great either but that should be recoverable to some
> degree. With memcg configuration this would cause the memcg OOM which
> would be harder to recover from because it affects all memcg charges in
> that cgroup - not just that specific fs access. See what I mean? This is
> a completely new failure mode.
>
> The only reasonable way would be to reduce the visibility of that mount
> point. This is certainly possible but it seems rather awkward when it
> should be accessible from multiple resource domains.
>

So the problem of preventing random processes from writing to a mount
point is a generic problem on machine configurations where you have
untrusted code running on the machine, which is a very common case.
For us we have any number of random workloads or VMs running on the
machine and it's critical to limit their credentials to exactly what
these workloads need. Because of this, regardless of whether the
filesystem is mounted with memcg= or not, the write/execute/read
permissions are only given to those that need access to the mount
point. If this is not done correctly, there are potentially even more
serious problems than causing OOMs or SIGBUSes to users of the mount
point.

Because this is a generic problem, it's addressed 'elsewhere'. I'm
honestly not extremely familiar but my rough understanding is that
there are linux filesystem permissions and user namespaces to address
this, and there are also higher level constructs like containerd which
which limits the visibility of jobs running on the system. My
understanding is that there are also sandboxes which go well beyond
limiting file access permissions.

To speak more concretely, for the 3 use cases I mention in the RFC
proposal (I'll attach that as cover letter in the next version):
1. For services running on the system, the shared tmpfs mount is only
visible and accessible (write/read) to the network service and its
client.
2. For large jobs with subprocesses that share memory like kubernetes,
the shared tmpfs is again only visible and accessible to the processes
in this job.
3. For filesystems that host shared libraries, it's a big no-no to
give anyone on the machine write permissions to the runtime AFAIU, so
I expect the mount point to be read-only.

Note that all these restrictions should and would be in place
regardless of whether the kernel supports the memcg= option or the
filesystem is mounted with memcg=. I'm not extremely familiar with the
implementation details on these restrictions, but I can grab them.

> I cannot really shake off feeling that this is potentially adding more
> problems than it solves.
> --
> Michal Hocko
> SUSE Labs

On Thu, Nov 18, 2021 at 12:48 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 16-11-21 13:55:54, Shakeel Butt wrote:
> > On Tue, Nov 16, 2021 at 1:27 PM Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > On Tue, Nov 16, 2021 at 3:29 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > Yes, exactly. I meant that all this special casing would be done at the
> > > > shmem layer as it knows how to communicate this usecase.
> > > >
> > >
> > > Awesome. The more I think of it I think the ENOSPC handling is perfect
> > > for this use case, because it gives all users of the shared memory and
> > > remote chargers a chance to gracefully handle the ENOSPC or the SIGBUS
> > > when we hit the nothing to kill case. The only issue is finding a
> > > clean implementation, and if the implementation I just proposed sounds
> > > good to you then I see no issues and I'm happy to submit this in the
> > > next version. Shakeel and others I would love to know what you think
> > > either now or when I post the next version.
> > >
> >
> > The direction seems reasonable to me. I would have more comments on
> > the actual code. At the high level I would prefer not to expose these
> > cases in the filesystem code (shmem or others) and instead be done in
> > a new memcg interface for filesystem users.
>
> A library like function in the memcg proper sounds good to me I just
> want to avoid any special casing in the core of the memcg charging and
> special casing there.
>

Yes, this is the implementation I'm working on and I'll submit another version.


> --
> Michal Hocko
> SUSE Labs
