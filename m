Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90F3F2F87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbhHTPfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 11:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235928AbhHTPfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629473712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlytKq7WyOzUT/K3H+q4IM3u5JgzyFxG/3NBnWm69Pg=;
        b=Cf1bWojaTNt83PVXeGRtHQ3ccL4BOGQi6A8Ediw6zyyjIDD3f7dJeibvh/LlZ84/WsDKEN
        xXHb92xvS31+EEGH9c/A9K71FlX4GnsIi/gIHhQ7EXDPj34No4JOQsCUBToouNGmxllkSC
        7jCCBsK30+A3YLeRx+SNWRQ7yI8orbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-VcuasTi7PeW-W1WShJcDvw-1; Fri, 20 Aug 2021 11:23:13 -0400
X-MC-Unique: VcuasTi7PeW-W1WShJcDvw-1
Received: by mail-wm1-f72.google.com with SMTP id b196-20020a1c80cd0000b02902e677003785so4937395wmd.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 08:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlytKq7WyOzUT/K3H+q4IM3u5JgzyFxG/3NBnWm69Pg=;
        b=lQNXYiHxR02jZvcmq93ElSuFBFM0G0OUHnpH/HiHW+pZE/fGknuCj5GRyrx5SAYFho
         gEm/BmnBj2xj3lpW6T1HugSvM/8l/Rz0h3UWTW5P+VnqABZKpLC6cNNhv3DdXKsLDIqJ
         IY+PANlWUPd8AEwgV4BYWeL3jkzV0Nze/nT4cx+zmcKa2ojlpR76tDl4F4hhho0+qcE1
         tuYFrr6YTcwrmZZas1vA4TMjdxcr/msBjSj59L5Mog6SKASWpBSRCacQtnIEvTrmZepf
         XoxTUYDkcmMIjjIEXhnasMOI6xPocRaJreN5yocKGpwgxSK9G6HmPclUjupU4RLvHJAB
         +SiA==
X-Gm-Message-State: AOAM532gyqyw1pEYhBXpG0mvOEX/rTqnVYqiSZ9c1JYYAq12TKx4796K
        bdMXYMdP8rPXjFI7QQZ7uA6z98Br7LYzYSQ/FioBquwdVCihMa98b62k4/zKKiuql0gcISLQRCc
        of5tqy7kLf/ojPqel0upB8MJbT9dViZ9MCPTvXD1OpQ==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr4615316wmi.152.1629472985921;
        Fri, 20 Aug 2021 08:23:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUvS40eZJ1ySsWNGqcyFBL2tEQZaB8k3Slyb91HTve5oMdHFCyWX4WR3jQt8qnTrXHAXjGShbj4VZTgbuL91g=
X-Received: by 2002:a7b:c106:: with SMTP id w6mr4615303wmi.152.1629472985719;
 Fri, 20 Aug 2021 08:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210819194102.1491495-1-agruenba@redhat.com> <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com> <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
In-Reply-To: <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 20 Aug 2021 17:22:54 +0200
Message-ID: <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 3:11 PM Bob Peterson <rpeterso@redhat.com> wrote:
> On 8/20/21 4:35 AM, Steven Whitehouse wrote:
> > Hi,
> >
> > On Thu, 2021-08-19 at 21:40 +0200, Andreas Gruenbacher wrote:
> >> From: Bob Peterson <rpeterso@redhat.com>
> >>
> >> This patch introduces a new HIF_MAY_DEMOTE flag and infrastructure
> >> that
> >> will allow glocks to be demoted automatically on locking conflicts.
> >> When a locking request comes in that isn't compatible with the
> >> locking
> >> state of a holder and that holder has the HIF_MAY_DEMOTE flag set,
> >> the
> >> holder will be demoted automatically before the incoming locking
> >> request
> >> is granted.
> >>
> > I'm not sure I understand what is going on here. When there are locking
> > conflicts we generate call backs and those result in glock demotion.
> > There is no need for a flag to indicate that I think, since it is the
> > default behaviour anyway. Or perhaps the explanation is just a bit
> > confusing...
>
> I agree that the whole concept and explanation are confusing. Andreas
> and I went through several heated arguments about the semantics,
> comments, patch descriptions, etc. We played around with many different
> flag name ideas, etc. We did not agree on the best way to describe the
> whole concept. He didn't like my explanation and I didn't like his. So
> yes, it is confusing.
>
> My preferred terminology was "DOD" or "Dequeue On Demand"

... which is useless because it adds no clarity as to whose demand
we're talking about.

> which makes
> the concept more understandable to me. So basically a process can say
> "I need to hold this glock, but for an unknown and possibly lengthy
> period of time, but please feel free to dequeue it if it's in your way."
> And bear in mind that several processes may do the same, simultaneously.
>
> You can almost think of this as a performance enhancement. This concept
> allows a process to hold a glock for much longer periods of time, at a
> lower priority, for example, when gfs2_file_read_iter needs to hold the
> glock for very long-running iterative reads.

Consider a process that allocates a somewhat large buffer and reads
into it in chunks that are not page aligned. The buffer initially
won't be faulted in, so we fault in the first chunk and write into it.
Then, when reading the second chunk, we find that the first page of
the second chunk is already present. We fill it, set the
HIF_MAY_DEMOTE flag, fault in more pages, and clear the HIF_MAY_DEMOTE
flag. If we then still have the glock (which is very likely), we
resume the read. Otherwise, we return a short result.

Thanks,
Andreas

