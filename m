Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E976C36CD75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhD0VA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbhD0VA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:00:27 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB80C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 13:59:40 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id s131so62882vka.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HWA17end2mHSBOn8PRau19glHvfoApvxJN4UI4e4wY=;
        b=kNKfv+4q0saGnCORBqm46p0HV1suwevJ9JVbPHr0+XvghY79DC/iZyAPTAZbGnYyB8
         GsVoDslhO3CtPXFtTJFi8d1kjKlo2fdd+BnIhvpxoI/3fiArqjvd8lbpl2ml1sEICYXP
         ArM0dSMfhO+OfBda5w/pxnXXTSJrti8/o5grX+0Alm+E4ao5/e7iFcRAsR/HXGQSsKLW
         odKQ7BvNIdD3QU7i1+UGWnBK/FnqkXdmn8fzWb1jS03ngBVhozHK2YuHtBb+GRFpu2Ix
         suwhUMmpONeubCHP/XZzACwfqYPDObWb9XpRXIhHBbRzW5nQukERhg6w6j0Bwwje4P1r
         Mnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HWA17end2mHSBOn8PRau19glHvfoApvxJN4UI4e4wY=;
        b=AQAQJ+iK+X5XT4uL8gyLDXic3lHqH5UfYK4co+VXli2B6JPhN2ygLcrFm/7AVJx8mV
         OYHkyPclOVjaNl7G8exsDZNObxV9oMkb8ZsMg/C9gd2dSmGAjcB/yP/tIm/86HCkqH/U
         lsDC4AaoFRS7EwQQoY3UyvJV+zNWeq7+D9mGJlo1JLLsSZc/k7nBODEn8F4FUK5WiyhB
         tBxqrk13l7yGtTbVkjL+aipF6KAGp31EyUnYYWbG5aLchQnGGpKgygzE8R8MGS0bMd6c
         mxOEwM2TS74v8Ya8rs2mQgT8B9gjEIZOUogwlTbxS8O3u43Ln9uR3yU4KEptYkr4JVov
         T+3Q==
X-Gm-Message-State: AOAM530DQjEGAF4FZq4dW52yJ5xDNVrhK7kDOV84XUdJk8hVtycLOIQS
        lBvVdsNoQ7g7/TXbXT+91bS9fDu3CvtgxGwav13O3Q==
X-Google-Smtp-Source: ABdhPJxMa8QlbqFVlyqY8hHnMQk9ocnkufGFrjkph7CyO1dQzyOGO3Wvrfuhmg+RWEuWS6Q7zIqJ4mhoHMxQkSMikXM=
X-Received: by 2002:a05:6122:2ad:: with SMTP id 13mr20756635vkq.11.1619557179939;
 Tue, 27 Apr 2021 13:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com> <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
 <20210427155414.GB6820@xz-x1> <CAJHvVciNrE_F0B0nu=Mib6LhcFhL8+qgO-yiKNsJuBjOMkn5+g@mail.gmail.com>
 <20210427180314.GD6820@xz-x1> <CAJHvVciMU=TDGxArtEQSq3n5DCLfYNWh7bVX_8dQL_dht4Q73w@mail.gmail.com>
 <20210427204250.GG6820@xz-x1>
In-Reply-To: <20210427204250.GG6820@xz-x1>
From:   Hugh Dickins <hughd@google.com>
Date:   Tue, 27 Apr 2021 13:59:12 -0700
Message-ID: <CANsGZ6YRucupVi8Hhu=4Y7yhoY+eFr0YVahLSXpSC2-AikX4qQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 1:42 PM Peter Xu <peterx@redhat.com> wrote:
> On Tue, Apr 27, 2021 at 01:29:14PM -0700, Axel Rasmussen wrote:
> > On Tue, Apr 27, 2021 at 11:03 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Apr 27, 2021 at 09:57:16AM -0700, Axel Rasmussen wrote:
> > > > I'd prefer to keep them separate, as they are not tiny patches (they
> > > > are roughly +200/-150 each). And, they really are quite independent -
> > > > at least in the sense that I can reorder them via rebase with no
> > > > conflicts, and the code builds at each commit in either orientation. I
> > > > think this implies they're easier to review separately, rather than
> > > > squashed.
> > > >
> > > > I don't have a strong feeling about the order. I slightly prefer
> > > > swapping them compared to this v4 series: first introduce minor
> > > > faults, then introduce CONTINUE.
> > > >
> > > > Since Peter also has no strong opinion, and Hugh it sounds like you
> > > > prefer it the other way around, I'll swap them as we had in some
> > > > previous version of this series: first introduce minor faults, then
> > > > introduce CONTINUE.
> > >
> > > Yes I have no strong opinion, but that's probably the least I prefer. :-)
> > >
> > > Because you'll declare UFFD_FEATURE_MINOR_SHMEM and enable this feature without
> > > the feature being completely implemented (without UFFDIO_CONTINUE, it's not
> > > complete since no one will be able to resolve that minor fault).
> > >
> > > Not a big deal anyway, but since we're at it... Basically I think three things
> > > to do for minor shmem support:
> > >
> > >   (1) UFFDIO_CONTINUE (resolving path)
> > >   (2) Handle fault path for shmem minor fault (faulting path)
> > >   (3) Enablement of UFFD_FEATURE_MINOR_SHMEM (from which point, user can detect
> > >       and enable it)
> > >
> > > I have no preference on how you'd like to merge these steps (right now you did
> > > 1 first, then 2+3 later; or as Hugh suggested do 1+2+3 together), but I'd still
> > > hope item 3 should always be the last, if possible...
> >
> > In that case, I'll split the patch which adds the faulting path in
> > two: add the faulting path hook and registration mode, and then in a
> > separate commit advertise the feature flag as available.
> >
> > Then I'll order them like so, which I think is the order Hugh finds
> > more natural:
> > 1. MInor fault registration / faulting path
> > 2. CONTINUE ioctl to resolve the faults
> > 3. Advertise the feature as supported
> >
> > Sound okay?
>
> Good to me, thanks Axel.

Okay.
