Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC7368EAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbhDWIPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 04:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbhDWIPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:15:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F90C061574;
        Fri, 23 Apr 2021 01:14:45 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id y10so18183460ilv.0;
        Fri, 23 Apr 2021 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTDg6zKpQu7cJZ1DqdWrnVuB9GdhXUrPkPNL5cWVUoU=;
        b=aE3ECeuajeVMQgcnoBSuf7Z3TeBiQ/lS437h4ybxx+yOsC33xDXSuKmJGkzDfei9OJ
         V4PjSWxmYMuaaq7cghJDsuCVnHimX4v/dwmpZz4e0CvH4nrgMa0GL07DlXPBTg/PRSmR
         0lOYk+tQKEKZuNBpQ39ppzUDjHHO2CDX6k0rD4ja8k75Bxj9Kw2ekPxp4MhjKRAQStp+
         ZVxzwITqQhjf01SQ6ZNVPqwyuJ1VDFvYJHqzaYbWYEmdHCw+SpeSY0RWUYPQ98bmb85y
         KEwmdgAMCYi2I+cTXqR97g26qdyNSm6Yr6dLdHKgTMGYAoQHVF43zMrsUjSCfPdbDx3g
         JxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTDg6zKpQu7cJZ1DqdWrnVuB9GdhXUrPkPNL5cWVUoU=;
        b=KkagjUoDJfpb6k3Gjmq03XWek+On2/C5eMO8lyNNvo26fFZf4la0lHsfvlvvL3emL/
         E1Sc3JTmH68e025i0MDy4lJyiL57fWgeOqlPYgkaXOPjetS3IcJGUJxqh2KQOElEyEvj
         okBVwtzBR0soNIUKpyUo+HFVhWlZLuMZst8vYidoq68cNDPmxZefvwU/Unel2XjFkGpM
         Lf6/ZLbPz5oJQtsC6nEJbH9cuo+5ohAG+82IjudjTRJEvghYnZHSjD/ajql5gy8RS/5e
         ItF6iCtIA6i3smkWCx8iQmuOafn53CZTL92TYFsXBpalG9d53s2WN47VIesCOzuimlbS
         8uLQ==
X-Gm-Message-State: AOAM533v1W5Y/Ti50Pl+fx+mBVo1P8WlV1ixKVxLKuTyr5xCDDniYu/T
        A5PpjBMlZy7Lieh9Tuvx7zcxpu6PXA56EsLTcq4=
X-Google-Smtp-Source: ABdhPJzy/tF0+EBI4DAJ58uPJtkD06A/kUBEYti8E5fIhH/NZGiKAE9RdUrDYa1PyGEBdKVsNB+w25Re+FXgPH33Jx8=
X-Received: by 2002:a92:b74a:: with SMTP id c10mr1987086ilm.72.1619165685224;
 Fri, 23 Apr 2021 01:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618527437.git.repnop@google.com> <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein> <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein> <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz> <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com> <YIJ/JHdaPv2oD+Jd@google.com>
In-Reply-To: <YIJ/JHdaPv2oD+Jd@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 23 Apr 2021 11:14:34 +0300
Message-ID: <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:02 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Apr 23, 2021 at 10:39:46AM +0300, Amir Goldstein wrote:
> > On Fri, Apr 23, 2021 at 2:06 AM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > On Wed, Apr 21, 2021 at 10:04:49AM +0200, Jan Kara wrote:
> > > > On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > > > > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > > > > A general question about struct fanotify_event_metadata and its
> > > > > > extensibility model:
> > > > > > looking through the code it seems that this struct is read via
> > > > > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > > > > >
> > > > > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > > > > >
> > > > > > bytes. In addition you can return the info to the user about how many
> > > > > > bytes the kernel has written from fanotify_read().
> > > > > >
> > > > > > So afaict extending fanotify_event_metadata should be _fairly_
> > > > > > straightforward, right? It would essentially the complement to
> > > > > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > > > > which deals with user->kernel and you're dealing with kernel->user:
> > > > > > - If the user supplied a buffer smaller than the minimum known struct
> > > > > >   size -> reject.
> > > > > > - If the user supplied a buffer < smaller than what the current kernel
> > > > > >   supports -> copy only what userspace knows about, and return the size
> > > > > >   userspace knows about.
> > > > > > - If the user supplied a buffer that is larger than what the current
> > > > > >   kernel knows about -> copy only what the kernel knows about, zero the
> > > > > >   rest, and return the kernel size.
> > > > > >
> > > > > > Extension should then be fairly straightforward (64bit aligned
> > > > > > increments)?
> > > > >
> > > > > You'd think that it's fairly straightforward, but I have a feeling
> > > > > that the whole fanotify_event_metadata extensibility discussion and
> > > > > the current limitation to do so revolves around whether it can be
> > > > > achieved in a way which can guarantee that no userspace applications
> > > > > would break. I think the answer to this is that there's no guarantee
> > > > > because of <<reasons>>, so the decision to extend fanotify's feature
> > > > > set was done via other means i.e. introduction of additional
> > > > > structures.
> > > >
> > > > There's no real problem extending fanotify_event_metadata. We already have
> > > > multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> > > > flag and its effect, extended versions of the structure in
> > > > include/uapi/linux/fanotify.h). The key for backward compatibility is to
> > > > create extended struct only when explicitely requested by a flag when
> > > > creating notification group - and that would be the case here -
> > > > FAN_REPORT_PIDFD or how you called it. It is just that extending the
> > > > structure means adding 8 bytes to each event and parsing extended structure
> > > > is more cumbersome than just fetching s32 from a well known location.
> > > >
> > > > On the other hand extended structure is self-describing (i.e., you can tell
> > > > the meaning of all the fields just from the event you receive) while
> > > > reusing 'pid' field means that you have to know how the notification group
> > > > was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> > > > interpret the contents of the event. Actually I think the self-describing
> > > > feature of fanotify event stream is useful (e.g. when application manages
> > > > multiple fanotify groups or when fanotify group descriptors are passed
> > > > among processes) so now I'm more leaning towards using the extended
> > > > structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> > > > confusion.
> > >
> > > This approach makes sense to me.
> > >
> > > Jan/Amir, just to be clear, we've agreed to go ahead with the extended
> > > struct approach whereby specifying the FAN_REPORT_PIDFD flag will
> > > result in an event which includes an additional struct
> > > (i.e. fanotify_event_info_pid) alongside the generic existing
> >
> > struct fanotify_event_info_pidfd?
>
> Well, yeah? I mean, my line of thought was that we'd also need to
> include struct fanotify_event_info_header alongside the event to
> provide more meta-information about the additional event you'd expect
> to receive when FAN_REPORT_PIDFD is provided, so we'd end up with
> something like:
>
> struct fanotify_event_info_pidfd {
>        struct fanotify_event_info_header hdr;
>        __s32 pidfd;
> }
>
> Unless this of course is overbaking it and there's no need to do this?
>

We need this. I was just pointing out that you wrote fanotify_event_info_pid
must have been a typo.

Thanks,
Amir.
