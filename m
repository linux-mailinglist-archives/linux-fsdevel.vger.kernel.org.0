Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B4B36B65C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhDZQBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 12:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234496AbhDZQBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619452867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7Z91EmdEzGViA9uS6BhSNuizWMtWDUbKP0zpEO7eLo=;
        b=azwOvxsVok4s59XpDGvrjuInzct1LQDn484n3ShTgc1pcScr9SwML06VxA+U6esLJOl2r5
        cBPMuz2vHxW1uZUXWG6VEacf7zSr3rzxEVBf/kOsDEwfB2G5kyK5a0VVbPodn/XQFJr5Ij
        bNCctpzinpcTo7QmIFZgV9oCvOY4bGo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-PCM3N3h1MrauF3HgS5BLVw-1; Mon, 26 Apr 2021 12:00:50 -0400
X-MC-Unique: PCM3N3h1MrauF3HgS5BLVw-1
Received: by mail-yb1-f200.google.com with SMTP id c8-20020a25a2c80000b02904eda0a22b5dso7145085ybn.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 09:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7Z91EmdEzGViA9uS6BhSNuizWMtWDUbKP0zpEO7eLo=;
        b=rW+7fgP5OpZwtuQBemGNIMl3Kd4WGNKv0ncU9ugcWyc9pCXxCgPMD6ZHYtQyN01aXL
         wpwqE8P3Mceq1HZGGs/Ix5WOFwcXPaifTzhhEy8dLTfvJVorEZcGlS7Ft3C+iLVsngQ8
         yAloEFL4Dm6CgNu57yLpbjSK0AF1t0/lka+G3KqbSazZuXA3uaKceJdn2PUlJJtDRrj0
         9S+we1eviBDVqOMliM/1FirqoUcudXWXEtR1uYCFAu9vlcbCTeCDzkPDblFgapxUj1sL
         6aNC4yZW2E/ejpenW1FOQgkSJqBZ/K5TCKmS2oFuEN3R0q7jqMVdnUwlW759I8pQXKfF
         n0DQ==
X-Gm-Message-State: AOAM533z4ZGqruVfJmyw1aiikJG0cNr2nWmP0+ssqJ2RDOGaL2sAukid
        LLOHaLVV/AneR7az5ohmkubHxaYttgtolV2WSdLREZqDvqOmhLfreNgcomFH1F9xzOAC7qAbhKK
        pid/OPmlh3LzuaC/d4fvK7RFCfD5OR/hN9f6kLVcFWA==
X-Received: by 2002:a25:af41:: with SMTP id c1mr26458177ybj.340.1619452850311;
        Mon, 26 Apr 2021 09:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUra5CjghINxqaBt+Aqv4z7MU09/1zLmWqUX2ioLdVS800IQO7MQIvcbIxp2gk/KA53g3Qe+2woXFunX2cjSM=
X-Received: by 2002:a25:af41:: with SMTP id c1mr26458131ybj.340.1619452849989;
 Mon, 26 Apr 2021 09:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <20210421171446.785507-3-omosnace@redhat.com>
 <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com>
 <CAFqZXNv4gKFN5FV_Z8U82cOzauBggaqPE0WZZUdnNRxCQ3PVPw@mail.gmail.com>
 <CAEjxPJ5iWjcQGzfJy-5CLa+e95C+OmeQ_GAU44s+8ripuMJg9g@mail.gmail.com> <CAEjxPJ4beKsxwohdLtTQYCdeap1-0ERV+R+u3A5sSXrPJXqteg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4beKsxwohdLtTQYCdeap1-0ERV+R+u3A5sSXrPJXqteg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 26 Apr 2021 18:00:38 +0200
Message-ID: <CAFqZXNuc4d=uzZWCXAV=m4WQpj+J9JyD5L0URKR8MLP39sm_HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: add capability to map anon inode types
 to separate classes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:20 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Apr 23, 2021 at 10:22 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Apr 23, 2021 at 9:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Thu, Apr 22, 2021 at 3:21 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > Unfortunately, the approach chosen in commit 29cd6591ab6f ("selinux:
> > > > > teach SELinux about anonymous inodes") to use a single class for all
> > > > > anon inodes and let the policy distinguish between them using named
> > > > > transitions turned out to have a rather unfortunate drawback.
> > > > >
> > > > > For example, suppose we have two types of anon inodes, "A" and "B", and
> > > > > we want to allow a set of domains (represented by an attribute "attr_x")
> > > > > certain set of permissions on anon inodes of type "A" that were created
> > > > > by the same domain, but at the same time disallow this set to access
> > > > > anon inodes of type "B" entirely. Since all inodes share the same class
> > > > > and we want to distinguish both the inode types and the domains that
> > > > > created them, we have no choice than to create separate types for the
> > > > > cartesian product of (domains that belong to attr_x) x ("A", "B") and
> > > > > add all the necessary allow and transition rules for each domain
> > > > > individually.
> > > > >
> > > > > This makes it very impractical to write sane policies for anon inodes in
> > > > > the future, as more anon inode types are added. Therefore, this patch
> > > > > implements an alternative approach that assigns a separate class to each
> > > > > type of anon inode. This allows the example above to be implemented
> > > > > without any transition rules and with just a single allow rule:
> > > > >
> > > > > allow attr_x self:A { ... };
> > > > >
> > > > > In order to not break possible existing users of the already merged
> > > > > original approach, this patch also adds a new policy capability
> > > > > "extended_anon_inode_class" that needs to be set by the policy to enable
> > > > > the new behavior.
> > > > >
> > > > > I decided to keep the named transition mechanism in the new variant,
> > > > > since there might eventually be some extra information in the anon inode
> > > > > name that could be used in transitions.
> > > > >
> > > > > One minor annoyance is that the kernel still expects the policy to
> > > > > provide both classes (anon_inode and userfaultfd) regardless of the
> > > > > capability setting and if one of them is not defined in the policy, the
> > > > > kernel will print a warning when loading the policy. However, it doesn't
> > > > > seem worth to work around that in the kernel, as the policy can provide
> > > > > just the definition of the unused class(es) (and permissions) to avoid
> > > > > this warning. Keeping the legacy anon_inode class with some fallback
> > > > > rules may also be desirable to keep the policy compatible with kernels
> > > > > that only support anon_inode.
> > > > >
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > >
> > > > NAK.  We do not want to introduce a new security class for every user
> > > > of anon inodes - that isn't what security classes are for.
> > > > For things like kvm device inodes, those should ultimately use the
> > > > inherited context from the related inode (the /dev/kvm inode itself).
> > > > That was the original intent of supporting the related inode.
> > >
> > > Hmm, so are you implying that anon inodes should be thought of the
> > > same as control /dev nodes? I.e. that even though there may be many
> > > one-time actual inodes created by different processes, they should be
> > > thought of as a single "static interface" to the respective kernel
> > > functionality? That would justify having a common type/label for all
> > > of them, but I'm not sure if it doesn't open some gap due to the
> > > possibility to pass the associated file descriptors between processes
> > > (as AFAIK, these can hold some context)...
> >
> > That was the original design (and the original patchset that we posted
> > in parallel with Google's independently developed one). We even had
> > example policy/controls for /dev/kvm ioctls.
> > Imagine trying to write policy over /dev/kvm ioctls where you have to
> > deal with N different classes and/or types and remember which ioctl
> > commands are exercised on which class or type even though from the
> > users' perspective they all occurred through the /dev/kvm interface.
> > It seemed super fragile and difficult to maintain/analyze that way.
> > Versus writing a single allow rule for all /dev/kvm ioctls.

So I went back and read the conversations on the original patches and
after thinking a bit more about it I'm getting more comfortable with
the idea to treat anonymous inodes as a kind of opened device node
file (which can be either an "imaginary" one as in the userfaultfd(2)
case or an existing real device node as in the KVM example), which has
just one type regardless of what process has created it.

I suppose if there are any properties of an open anonymous inode that
would be interesting from SELinux POV, they could be checked via a
separate class with an appropriate permission. For example, if we
wanted to control which domains can create & use usefaultfds without
vs. with the UFFD_USER_MODE_ONLY flag, we could introduce a new hook,
which would allow us to check an access vector like (current_sid,
current_sid, userfaultfd, kernel_mode) on any attempt to create or
inherit/receive an uffd without the UFFD_USER_MODE_ONLY flag. (In
fact, this might actually be a useful enhancement...)

So I'm retracting these patches for now.

> >
> > I guess we could discuss the alternatives but please have a look at
> > those original patches and examples.  If we go down this road, we need
> > some way to deal with scaling because we only have a limited number of
> > discrete classes available to us and potentially unbounded set of
> > distinct anon inode users (although hopefully in practice only a few
> > that we care about distinguishing).
>
> Actually, on second thought, we shouldn't be in any danger of running
> out of classes so nevermind on that point.
>
> >
> > > I thought this was supposed to resemble more the way BPF, perf_event,
> > > etc. support was implemented - the BPF and perf_event fds are also
> > > anon inodes under the hood, BTW - where each file descriptor is
> > > considered a separate object that inherits the label of its creator
> > > and there is some class separation (e.g. bpf vs. perf_event).
--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

