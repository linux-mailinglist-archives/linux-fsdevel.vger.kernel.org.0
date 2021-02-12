Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDAF31A307
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhBLQnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 11:43:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231251AbhBLQmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 11:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613148078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ft1B0dmqfZyPUoyDvwnAfTze1mns3d3CFcFjBHQ5YEA=;
        b=aNRt9Ee3sV2xdj2/G38YJVresg4eVETnPdP9xDWtHOPJMqJe0efT11qDj6gc7WEQExSZGP
        N7/Y+Gsts8Ww7CUbqTDLJqyaxZ5vprO30+olfCn9kIjcjU4OnFYwHGeWme5ErQJOdiPEfT
        cJJ9GTyWMLNlBxzi8f30HU2JxnQJd9A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-lA5Er4YqODa3dqKbAG8UfQ-1; Fri, 12 Feb 2021 11:41:16 -0500
X-MC-Unique: lA5Er4YqODa3dqKbAG8UfQ-1
Received: by mail-ej1-f72.google.com with SMTP id p15so132377ejq.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 08:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ft1B0dmqfZyPUoyDvwnAfTze1mns3d3CFcFjBHQ5YEA=;
        b=poOXm2cyzVecsOo5kUG3AHW/kwaAmH57ZnJbh+r9R1ktB321UXYdGW3ufGuU/vw1T3
         s4DcuXr8iltJDXW0sJ/uMY2sZkx/JOaeZYntY8S2NVv48mfRQedDaT5CEm9aSYqTwE8F
         UEX/DJXXmiqPZhbxBtAL+UfU+ZihCeQx1y6k64RcWqB5fKAkm/pgUzEc8GMHhpo98ZYo
         oiqPmrX/kH0bWzVKRUpe9ErJYErjPif6PK817VF6LP5c7XV7InIdDiMHzBz/dPa1pcsh
         6IY8Kh2doP6D2vsf/d3CN3zHNW6UAn/2WV2kAETzqFEQfYLsB9qy2JolyOtxqFc7h/9m
         0EzQ==
X-Gm-Message-State: AOAM530DeGD/tEyztubBz0BB8bctsAJGjQ4UfEMyUL5h2tdqksBuE7r9
        krFUkwd1xB0YH0sQKQ9kwqFw5wKezNs0aOrckIb7U5FAPVnPwLcIgS2ZngfLF1nqXreoGjcwWkK
        bO5G65Ym6gQHgVzbDoiGA3TnqsXs8T83oECGLA/hFqw==
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr3897278ejd.229.1613148074941;
        Fri, 12 Feb 2021 08:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTIgnx7LJiTFOW+mhqlshoZww0YFi52MiJxBqcnsY+RGcoAoY9xA8AY8Yu0JSD5ZHRlga8wGOKDsNd1QerD6Y=
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr3897262ejd.229.1613148074745;
 Fri, 12 Feb 2021 08:41:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk> <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
 <27816.1613085646@warthog.procyon.org.uk>
In-Reply-To: <27816.1613085646@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 12 Feb 2021 11:40:38 -0500
Message-ID: <CALF+zOkRhZ6SfotHbWFMDYJ-qJxxOSMd8SUbrXd4w7rpOMoPKw@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs <linux-cachefs@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 6:20 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Also, honestly, I really *REALLY* want your commit messages to talk
> > about who has been cc'd, who has been part of development, and point
> > to the PUBLIC MAILING LISTS WHERE THAT DISCUSSION WAS TAKING PLACE, so
> > that I can actually see that "yes, other people were involved"
>
> Most of the development discussion took place on IRC and waving snippets of
> code about in pastebin rather than email - the latency of email is just too
> high.  There's not a great deal I can do about that now as I haven't kept IRC
> logs.  I can do that in future if you want.
>
> > No, I don't require this in general, but exactly because of the
> > history we have, I really really want to see that. I want to see a
> >
> >    Link: https://lore.kernel.org/r/....
>
> I can add links to where I've posted the stuff for review.  Do you want this
> on a per-patch basis or just in the cover for now?
>
> Also, do you want things like these:
>
>  https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
>  https://lore.kernel.org/linux-fsdevel/4467.1579020509@warthog.procyon.org.uk/
>
> which pertain to the overall fscache rewrite, but where the relevant changes
> didn't end up included in this particular patchset?  Or this:
>
>  https://listman.redhat.com/archives/linux-cachefs/2020-December/msg00000.html
>
> where someone was testing the overall patchset of which this is a subset?
>
> > and the Cc's - or better yet, the Reviewed-by's etc - so that when I
> > get a pull request, it really is very obvious to me when I look at it
> > that others really have been involved.
> >
> > So if I continue to see just
> >
> >     Signed-off-by: David Howells <dhowells@redhat.com>
> >
> > at the end of the commit messages, I will not pull.
> >
> > Yes, in this thread a couple of people have piped up and said that
> > they were part of the discussion and that they are interested, but if
> > I have to start asking around just to see that, then it's too little,
> > too late.
> >
> > No more of this "it looks like David Howells did things in private". I
> > want links I can follow to see the discussion, and I really want to
> > see that others really have been involved.
> >
> > Ok?
>
> Sure.
>
> I can go and edit in link pointers into the existing patches if you want and
> add Jeff's Review-and-tested-by into the appropriate ones.  You would be able
> to compare against the existing tag, so it wouldn't entirely invalidate the
> testing.
>
You can add my Tested-by for your fscache-next branch series ending at
commit  235299002012 netfs: Hold a ref on a page when PG_private_2 is set
This series includes your commit c723f0232c9f8928b3b15786499637bda3121f41
discussed a little earlier in this email thread.

I ran over 24 hours of NFS tests (unit, connectathon, xfstests,
various servers and all NFS versions) on your latest series
and it looks good.  Note I did not run against pNFS servers
due to known issue, and I did not do more advanced tests like
error injections.  I did get one OOM on xfstest generic/551 on
one testbed, but that same' test passed on another testbed,
so it's not clear what is happening there and it could very
well be testbed or NFS related.

In addition, I reviewed various patches in the series, especially the
API portions of the netfs patches, so for those, Reviewed-by is
appropriate as well. I have also reviewed some of the internals
of the other infrastructure patches, but my review is more limited
there.





> Also, do you want links inserting into all the patches of the two keyrings
> pull requests I've sent you?
>
> David
>

