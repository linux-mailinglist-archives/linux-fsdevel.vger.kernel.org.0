Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C652DD41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiESS7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiESS7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 14:59:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EAA88BB
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 11:59:02 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l15so4280062ilh.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtXD347NgGS/+YijWWiRuBafqv4C6u9VlK5CEu8TAEA=;
        b=eQti3jrkdY7scusFOxnuKhJ5Vf4Z+DDvEqC+qVkSzJirkfUkUo5yo7/PzJFKP1AnQd
         EOXByCNcv+7E3dhF7/eAZlUtc4Ds73cawnE2aCgg30dI7mHPxjhBBOoH1YSJQFqNtOr1
         R6LZoXW729dcASQMsmmF3k/+wo+sYd4kz14Sa2qe+rZR083fhb8vmsk7nO+eI7I5+46r
         B1WqKIZ6hq+/H8JAv3J/ab4RVaL/KfqCAbC/76TQsnKpljZd0qDTXT5ChI6MnY24iwgb
         lnWLpnhJC+QTbOm2LnMQ7SPKSoLPf/ImHkqspMRV5ORcKQKsElyIaKIG7d4X6ohSIUeO
         KuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtXD347NgGS/+YijWWiRuBafqv4C6u9VlK5CEu8TAEA=;
        b=rhgvQ+KS7dF0VNIsMBiWUWCCnAxTzoG3fHdzj88R+HBnqca7OBak02hoK/U1VTjHs7
         cxuSaWpqgPB+wIVLJg4/IsA9YDEO+2PWsAzVoXakIlb3hboVOiWMeoYJ1LT7oIbzv0Kp
         Me/APNKfriO/vzm+AL90yAJ4isfY6IBShkthXc8S02Ys6d6WxNhw6+qZCM0LtVQKy5Jo
         WVR25SyPKGPbmcRszFvHEuaAJsO9/478wB6VLrHVCbDDyGlxpvmgEGXHHM4UnSbghxR+
         7EMUx8OqgMmoMcFT0brPgEvrfvwp1FTlbTsu7aIfeqbbQRO9gp3RytpGcn8Z13iNWUX8
         1/7A==
X-Gm-Message-State: AOAM5304QBVrsq3ld00/Yt4um+fHZkBc5ZHU1WmutQxrtZdlPHwt44mk
        hXnC/DCTxHMcUbA1I2FQxDOlt7tqyjyHTzc2jxMH/Q==
X-Google-Smtp-Source: ABdhPJxroZKPAtKdyjG/WvTdRj8QijwwaYZoKH+fVYQqNh/ZqMiSWs7lA9A9PN2uIxTVX6Z0QHBF2y1TIkugRbTRbhE=
X-Received: by 2002:a92:da0c:0:b0:2cf:9e8e:d9d8 with SMTP id
 z12-20020a92da0c000000b002cf9e8ed9d8mr3662939ilm.192.1652986741747; Thu, 19
 May 2022 11:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-5-axelrasmussen@google.com> <fc320218-bef1-c373-e6a6-afa2f6c4b56c@linuxfoundation.org>
In-Reply-To: <fc320218-bef1-c373-e6a6-afa2f6c4b56c@linuxfoundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 19 May 2022 11:58:25 -0700
Message-ID: <CAJHvVcgiHzHcGr8++TMW4+D0PHJRzwL=B2OGOncWArZnUa0pwg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] userfaultfd: update documentation to describe /dev/userfaultfd
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 9:46 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> > Explain the different ways to create a new userfaultfd, and how access
> > control works for each way.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >   Documentation/admin-guide/mm/userfaultfd.rst | 38 ++++++++++++++++++--
> >   Documentation/admin-guide/sysctl/vm.rst      |  3 ++
> >   2 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> > index 6528036093e1..4c079b5377d4 100644
> > --- a/Documentation/admin-guide/mm/userfaultfd.rst
> > +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> > @@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
> >   Design
> >   ======
> >
> > -Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
>
> Please keep this sentence in there and rephrase it to indicate how it was
> done in the past.
>
> Also explain here why this new approach is better than the syscall approach
> before getting into the below details.

Hmm, so the old sentence I think was incorrect already. Notifications
of *the faults* aren't delivered and resolved through the syscall.
Rather, the syscall just gives you a file descriptor, and then
notification / resolution of faults happens though the file
descriptor, not through the syscall. So I think it needs to be
reworded in any case.

I think the overall structure of the doc as-is makes the most sense as
well - first explain how this will be used at a very high level, and
then go into the details (first how to create a userfaultfd, then how
to use it).

So, in the end I reworded the "Creating a userfaultfd" section, to
cover the two things you mentioned:

- Which is the "older" way and which is the "newer" way
- What the benefit of the newer way is

Hopefully this addresses the comment? I can tweak it more if needed.
In any case, thanks for taking a look at this series!

>
> > +Userspace creates a new userfaultfd, initializes it, and registers one or more
> > +regions of virtual memory with it. Then, any page faults which occur within the
> > +region(s) result in a message being delivered to the userfaultfd, notifying
> > +userspace of the fault.
> >
> >   The ``userfaultfd`` (aside from registering and unregistering virtual
> >   memory ranges) provides two primary functionalities:
> > @@ -39,7 +42,7 @@ Vmas are not suitable for page- (or hugepage) granular fault tracking
> >   when dealing with virtual address spaces that could span
> >   Terabytes. Too many vmas would be needed for that.>
> > -The ``userfaultfd`` once opened by invoking the syscall, can also be
> > +The ``userfaultfd``, once created, can also be
>
> This is sentence is too short and would look odd. Combine the sentences
> so it renders well in the generated doc.

Not 100% sure I understood the concern, but I do think it makes sense
to move "Vmas are not suitable ..." up into the same paragraph with
the other sentence about scalability. I'll do this in v3 as it looks a
bit nicer. This leaves the "The userfaultfd, once created, ..." part
alone, though. I think s/once opened by invoking the syscall/once
created/ is correct, since there are now various ways to create it. I
also think that second comma technically should have been there even
in the previous version.

>
> >   passed using unix domain sockets to a manager process, so the same
> >   manager process could handle the userfaults of a multitude of
> >   different processes without them being aware about what is going on
> > @@ -50,6 +53,37 @@ is a corner case that would currently return ``-EBUSY``).
> >   API
> >   ===
> >
> > +Creating a userfaultfd
> > +----------------------
> > +
> > +There are two mechanisms to create a userfaultfd. There are various ways to
> > +restrict this too, since userfaultfds which handle kernel page faults have
> > +historically been a useful tool for exploiting the kernel.
> > +
> > +The first is the userfaultfd(2) syscall. Access to this is controlled in several
> > +ways:
> > +
> > +- By default, the userfaultfd will be able to handle kernel page faults. This
> > +  can be disabled by passing in UFFD_USER_MODE_ONLY.
> > +
> > +- If vm.unprivileged_userfaultfd is 0, then the caller must *either* have
> > +  CAP_SYS_PTRACE, or pass in UFFD_USER_MODE_ONLY.
> > +
> > +- If vm.unprivileged_userfaultfd is 1, then no particular privilege is needed to
> > +  use this syscall, even if UFFD_USER_MODE_ONLY is *not* set.
> > +
> > +Alternatively, userfaultfds can be created by opening /dev/userfaultfd, and
> > +issuing a USERFAULTFD_IOC_NEW ioctl to this device. Access to this device is
>
> New ioctl? I thought we are moving away from using ioctls?

Hmm, looking at alternatives [1] am not sure I see a viable one:

We could have defined a new "userfaultfdfs" filesystem, but it seems
to me to be overkill for this feature.

We could have used a syscall instead and supported fine-grained access
control with a new capability, but this approach was rejected [2]
generally because we prefer to avoid adding capabilities, and this new
capability's scope (just userfaultfd) was considered too narrow.

So, I'm not sure of another better way to do this. I suppose one could
argue that the dislike of ioctls outweighs the usefulness of this
feature, but to me at least the tradeoff seems worth it. :)

[1]: https://www.kernel.org/doc/html/latest/driver-api/ioctl.html#alternatives-to-ioctl
[2]: https://lkml.org/lkml/2022/2/24/1012

>
> > +controlled via normal filesystem permissions (user/group/mode for example) - no
> > +additional permission (capability/sysctl) is needed to be able to handle kernel
> > +faults this way. This is useful because it allows e.g. a specific user or group
> > +to be able to create kernel-fault-handling userfaultfds, without allowing it
> > +more broadly, or granting more privileges in addition to that particular ability
> > +(CAP_SYS_PTRACE). In other words, it allows permissions to be minimized.
> > +
> > +Initializing up a userfaultfd
> > +------------------------
> > +
>
> This will generate doc warn very likley - extend the dashes to the
> entire length of the subtitle.

I'll fix this in v3.

>
> >   When first opened the ``userfaultfd`` must be enabled invoking the
> >   ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
> >   a later API version) which will specify the ``read/POLLIN`` protocol
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index f4804ce37c58..8682d5fbc8ea 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -880,6 +880,9 @@ calls without any restrictions.
> >
> >   The default value is 0.
> >
> > +An alternative to this sysctl / the userfaultfd(2) syscall is to create
> > +userfaultfds via /dev/userfaultfd. See
> > +Documentation/admin-guide/mm/userfaultfd.rst.
> >
> >   user_reserve_kbytes
> >   ===================
> >
>
> thanks,
> -- Shuah
