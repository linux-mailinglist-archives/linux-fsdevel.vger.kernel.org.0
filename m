Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9C5E6319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiIVND6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIVND5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:03:57 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1081FE9997
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 06:03:55 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id e1so3647762uaa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 06:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KB67rZxGgKPUYHEJgHPcB5WDsc4pGcLBh8W+rxAYwDE=;
        b=gK32b7zuvDLGgH+zYFEvCDVcpyZ1vh2USdqtVpfvYm8oaUdPTZ5RvPc1a3lZ0v/NrU
         6kId11k6xtAfYrVbyCLrgZaWrZO07GgKmG6m2pXv8ut48zuf7dUqv+zE0PJQmqfiIFj7
         cx1S6NOraXUa0zZEgy1dhR9C8NWFVJ60wdfvFYY5Rmjyq/uMJYEJkQLzM0hUDKjEQZdV
         KUVDDJ5MDFFtNZWnGU6Enf9MSIc/+haHRR5AFXO5Ro4jWB0d5LjR8nL6RTU/5M8jXREm
         qtNlgRyNG/mWXYlT5xVXcJM7SJboP9/DGmNA1E0zCVJDJbVXULk6lZ/rv8WiRX5C2U4j
         6Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KB67rZxGgKPUYHEJgHPcB5WDsc4pGcLBh8W+rxAYwDE=;
        b=RyNS+uZI870J9+jYo4C1fBLn0393+/rotdIZ41LupovzZj/gn0aDyyVOGmtUdAKFsm
         AzzVpQFbjrmg7HdK9gzvZqeZMzKDSj6C4ASuf+suWQyy+J6WsZ0QLOoIsm7VUt+bieyl
         pkpxb2iAGhBqNszm9IhipGL3qchK8+o74A1t8OK15lmQedvmlDf3sFvtGI3ahPI2+Oei
         6odvImkCvkNpBjexeTv9+m8XDXwCEaSOxbhg3wdSh5MHNlt1FhGqFOGngMHA6YKEOWFu
         Auvm6Wt0AS/K5orVRfiexLOu+49Mc8Qa1gozLvOSe/XBl4TYcbJqQ0nx3efav1a56mUP
         5hXA==
X-Gm-Message-State: ACrzQf1Ivf1DNTP88rRuFak0WPlGRihbHTPE2/PVSQzfbFw94fMwNGUR
        /eOIVfd8rFUYdfQZKxqSkNj7S8Uugok/HrKwjwzDHKKEZkw=
X-Google-Smtp-Source: AMsMyM7JI25frIaeO+fL8UH/AwpjbOdt/fYsA1WXklFB90bp+O84CJKa0Sbgq2zssOzJ5qE9lPh5PhVDMWcAcPGP4H4=
X-Received: by 2002:a9f:2067:0:b0:387:984d:4a8e with SMTP id
 94-20020a9f2067000000b00387984d4a8emr1190222uam.60.1663851833816; Thu, 22 Sep
 2022 06:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com> <20220922104823.z6465rfro7ataw2i@quack3>
In-Reply-To: <20220922104823.z6465rfro7ataw2i@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 22 Sep 2022 16:03:41 +0300
Message-ID: <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Fufu Fang <fangfufu2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 20-09-22 21:19:25, Amir Goldstein wrote:
> > On Wed, Sep 14, 2022 at 2:52 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > > > > > So I'd prefer to avoid the major API
> > > > > > > extension unless there are serious users out there - perhaps we will even
> > > > > > > need to develop the kernel API in cooperation with the userspace part to
> > > > > > > verify the result is actually usable and useful.
> > > > >
> > > > > Yap. It should be trivial to implement a "mirror" HSM backend.
> > > > > For example, the libprojfs [5] projects implements a MirrorProvider
> > > > > backend for the Microsoft ProjFS [6] HSM API.
> > > >
> > > > Well, validating that things work using some simple backend is one thing
> > > > but we are probably also interested in whether the result is practical to
> > > > use - i.e., whether the performance meets the needs, whether the API is not
> > > > cumbersome for what HSM solutions need to do, whether the more advanced
> > > > features like range-support are useful the way they are implemented etc.
> > > > We can verify some of these things with simple mirror HSM backend but I'm
> > > > afraid some of the problems may become apparent only once someone actually
> > > > uses the result in practice and for that we need a userspace counterpart
> > > > that does actually something useful so that people have motivation to use
> > > > it :).
> > >
> >
> > Hi Jan,
> >
> > I wanted to give an update on the POC that I am working on.
> > I decided to find a FUSE HSM and show how it may be converted
> > to use fanotify HSM hooks.
> >
> > HTTPDirFS is a read-only FUSE filesystem that lazyly populates a local
> > cache from a remote http on first access to every directory and file range.
> >
> > Normally, it would be run like this:
> > ./httpdirfs --cache-location /vdf/cache https://cdn.kernel.org/pub/ /mnt/pub/
> >
> > Content is accessed via FUSE mount as /mnt/pub/ and FUSE implements
> > passthrough calls to the local cache dir if cache is already populated.
> >
> > After my conversion patches [1], this download-only HSM can be run like
> > this without mounting FUSE:
> >
> > sudo ./httpdirfs --fanotify --cache-location /vdf/cache
> > https://cdn.kernel.org/pub/ -
> >
> > [1] https://github.com/amir73il/httpdirfs/commits/fanotify_pre_content
> >
> > Browsing the cache directory at /vdf/cache, lazyly populates the local cache
> > using FAN_ACCESS_PERM readdir hooks and lazyly downloads files content
> > using FAN_ACCESS_PERM read hooks.
> >
> > Up to this point, the implementation did not require any kernel changes.
> > However, this type of command does not populate the path components,
> > because lookup does not generate FAN_ACCESS_PERM event:
> >
> > stat /vdf/cache/data/linux/kernel/firmware/linux-firmware-20220815.tar.gz
> >
> > To bridge that functionality gap, I've implemented the FAN_LOOKUP_PERM
> > event [2] and used it to lazyly populate directories in the path ancestry.
> > For now, I stuck with the XXX_PERM convention and did not require
> > FAN_CLASS_PRE_CONTENT, although we probably should.
> >
> > [2] https://github.com/amir73il/linux/commits/fanotify_pre_content
> >
> > Streaming read of large files works as well, but only for sequential read
> > patterns. Unlike the FUSE read calls, the FAN_ACCESS_PERM events
> > do not (yet) carry range info, so my naive implementation downloads
> > one extra data chunk on each FAN_ACCESS_PERM until the cache file is full.
> >
> > This makes it possible to run commands like:
> >
> > tar tvfz /vdf/cache/data/linux/kernel/firmware/linux-firmware-20220815.tar.gz
> > | less
> >
> > without having to wait for the entire 400MB file to download before
> > seeing the first page.
> >
> > This streaming feature is extremely important for modern HSMs
> > that are often used to archive large media files in the cloud.
>
> Thanks for update Amir! I've glanced through the series and so far it looks
> pretty simple and I'd have only some style / readability nits (but let's
> resolve those once we have something more complete).
>
> When thinking about HSM (and while following your discussion with Dave) I
> wondered about one thing: When the notifications happen before we take
> locks, then we are in principle prone to time-to-check-time-to-use races,
> aren't we? How are these resolved?
>
> For example something like:
> We have file with size 16k.
> Reader:                         Writer
>   read 8k at offset 12k
>     -> notification sent
>     - HSM makes sure 12-16k is here and 16-20k is beyond eof so nothing to do
>
>                                 expand file to 20k
>   - now the file contents must not get moved out until the reader is
>     done in order not to break it
>

Good question.
The way I was considering to resolve this is that for evicting file
content, HSM would:

1. Try to take a write lease (F_SETLEASE) on the file
    to make sure no other users are accessing the file
2. Set the mark or persistent NODATA bit on the file
3. Drop the write lease
4. Evict file content

You can think of it as upgrading from a breakable write lease
to an unbreakable write lease.

This way, users cannot access or modify file content without
either triggering FAN_ACCESS_PERM/FAN_MODIFY_PERM
or preventing HSM from evicting file content until close().

And this fix in linux-next:
https://lore.kernel.org/linux-fsdevel/20220816145317.710368-1-amir73il@gmail.com/
makes sure that those users cannot open a file without either
triggering FAN_OPEN_PERM or preventing HSM from evicting file
content until close().

HSM signal handler for lease break would be rare and only needs to
drop the lease. If lease is dropped before the mark was successfully set,
abort the content evict.

I hope I got this right - this is a design that I did not POC yet,
but it is on my TODO.

BTW, evicting directory content is not something that I have on my radar
at the moment. Not sure how many HSMs do that anyway.
FWIW, it was never part of DMAPI.

> > For the next steps of POC, I could do:
> > - Report FAN_ACCESS_PERM range info to implement random read
> >   patterns (e.g. unzip -l)
> > - Introduce FAN_MODIFY_PERM, so file content could be downloaded
> >   before modifying a read-write HSM cache
> > - Demo conversion of a read-write FUSE HSM implementation
> >   (e.g. https://github.com/volga629/davfs2)
> > - Demo HSM with filesystem mark [*] and a hardcoded test filter
> >
> > [*] Note that unlike the case with recursive inotify, this POC HSM
> > implementation is not racy, because of the lookup permission events.
> > A filesystem mark is still needed to avoid pinning all the unpopulated
> > cache tree leaf entries to inode cache, so that this HSM could work on
> > a very large scale tree, the same as my original use case for implementing
> > filesystem mark.
>
> Sounds good! Just with your concern about pinning - can't you use evictable
> marks added on lookup for files / dirs you want to track? Maybe it isn't
> great design for other reasons but it would save you some event
> filtering...
>

With the current POC, there is no trigger to re-establish the evicted mark,
because the parent is already populated and has no mark.

A hook on instantiate of inode in inode cache could fill that gap.
It could still be useful to filter FAN_INSTANTIATE_PERM events in the
kernel but it is not a must because instantiate is more rare than (say) lookup
and then the fast lookup path (RCU walk) on populated trees suffers almost
no overhead when the filesystem is watched.

Please think about this and let me know if you think that this is a direction
worth pursuing, now, or as a later optimization.

> > If what you are looking for is an explanation why fanotify HSM would be better
> > than a FUSE HSM implementation then there are several reasons.
> > Performance is at the top of the list. There is this famous USENIX paper [3]
> > about FUSE passthrough performance.
> > It is a bit outdated, but many parts are still relevant - you can ask
> > the Android
> > developers why they decided to work on FUSE-BFP...
> >
> > [3] https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf
> >
> > For me, performance is one of the main concerns, but not the only one,
> > so I am not entirely convinced that a full FUSE-BFP implementation would
> > solve all my problems.
> >
> > When scaling to many millions of passthrough inodes, resource usage start
> > becoming a limitation of a FUSE passthrough implementation and memory
> > reclaim of native fs works a lot better than memory reclaim over FUSE over
> > another native fs.
> >
> > When the workload works on the native filesystem, it is also possible to
> > use native fs features (e.g. XFS ioctls).
>
> OK, understood. Out of curiosity you've mentioned you'd looked into
> implementing HSM in overlayfs. What are the issues there? I assume
> performance is very close to native one so that is likely not an issue and
> resource usage you mention above likely is not that bad either. So I guess
> it is that you don't want to invent hooks for userspace for moving (parts
> of) files between offline storage and the local cache?
>

In a nutshell, when realizing that overlayfs needs userspace hooks
to cater HSM, it becomes quite useless to use a stacked fs design.

Performance is not a problem with overlayfs, but like with FUSE,
all the inodes/dentries in the system double, memory reclaim
of layered fs becomes an awkward dance, which messes with the
special logic of xfs shrinkers, and on top of all this, overlayfs does
not proxy all the XFS ioctls either.

The fsnotify hooks are a much better design when realizing that
the likely() case is to do nothing and incur least overhead and
the unlikely() case of user hook is rare.

> > Questions:
> > - What do you think about the direction this POC has taken so far?
> > - Is there anything specific that you would like to see in the POC
> >   to be convinced that this API will be useful?
>
> I think your POC is taking a good direction and your discussion with Dave
> had made me more confident that this is all workable :). I liked your idea
> of the wiki (or whatever form of documentation) that summarizes what we've
> discussed in this thread. That would be actually pretty nice for future
> reference.

Yeh, I need that wiki to organize my thoughts as well ;)

>
> The remaining concern I have is that we should demonstrate the solution is
> able to scale to millions of inodes (and likely more) because AFAIU that
> are the sizes current HSM solutions are interested in. I guess this is kind
> of covered in your last step of POCs though.
>

Well, in $WORK we have performance test setups for those workloads,
so part of my plan is to convert the in-house FUSE HSM
to fanotify and make sure that all those tests do not regress.
But that is not code, nor tests that I can release, I can only report back
that the POC works and show the building blocks that I used on
some open source code base.

I plan to do the open source small scale POC first to show the
building blocks so you could imagine the end results and
then take the building blocks for a test drive in the real world.

I've put my eye on davfs2 [1] as the code base for read-write HSM
POC, but maybe I will find an S3 FUSE fs that could work too
I am open to other suggestions.

[1] https://github.com/volga629/davfs2

When DeepSpace Storage releases their product to github,
I will be happy to work with them on a POC with their code
base and I bet they could arrange a large scale test setup.
(hint hint).

Thanks,
Amir.
