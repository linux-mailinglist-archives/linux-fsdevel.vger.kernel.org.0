Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9341A6111E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJ1MuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJ1MuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:50:21 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC072974
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 05:50:18 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id f68so2388499vkc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9rE3Md/1+Sjz+I6kwtrFkuMIJkq+h5JWfdWn9uQr27A=;
        b=T9/Vub2sNT5RKRSD0K1Szh/LxKtRmeQp8i1pGAAwzyHRU3wALGHgFif/I7nUa5YGTa
         MibvJ23OFlAQCtKquy9ecb/JS1iTpYomOquIu2NFzhSBI5AAliPDNBJTZNs4OAFeTZrg
         Zi4VADpMRMNPJbma3jQOgaZbQ/ABeLSbaokCxuRJjbKft3HWU/2E1NQEVLANY0GSNYPx
         LRb687Yo34GN+c6V999mKToNsNXg/7jiZdLNvyi8c1qTLIXyGf1iLpQLj59GThwWqbwB
         fnlAXR3Pme1FmwfyKk7LGgZ64MFLKQDWp4Vo1idy3Kd0BoF8PYPNEMVDgheN462fNIan
         gkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rE3Md/1+Sjz+I6kwtrFkuMIJkq+h5JWfdWn9uQr27A=;
        b=gl9xs1pUAdE4aao7mVmJgUnyzZSBPI7q/LzMeNm9T76G0uNGc87cO6Mp6t33ajXuop
         fihE3OFEHhh5fJXwACfcl2S9PJUytYY/KDh+dqzdg5r1V/0D4MaQ4ijFESgEwXFfYtp6
         BIWuV3Ghqt31hx0cJdzNBPBE5ZbdM88vsJR+GmskncWBkvkTESzkcvMtUQ31DMhZF/xR
         2F7HURP/9SzimVTuQyxckbS+KPhumzODrxRTMDHNe2QNIVaYi4WjV4/ab4EMYkCnoJwU
         gYYB2DB6fTOclJDDSGYmIn0hbGlv/AsoVlwu1R1Uu/imb2CSyIqUfIbawNNGkBRGe9EO
         21OQ==
X-Gm-Message-State: ACrzQf0meQQa2RoHZPSdzZ2cuvn42DMrXQY/EpA74wemwEsCjvq86oIj
        3Imgt0HowvIaYv82AZxfuCkgoGse0DYLS4vKRv/vRCpVPBQ=
X-Google-Smtp-Source: AMsMyM4gDSNHYE6wxKiQyII2UnH07wGZhOZjram0oUf4NcQyYMYef6FxsGS8ghyfLKw+rTCglKAWZH8LiHQrzE6ZxXM=
X-Received: by 2002:a1f:c2:0:b0:3b5:f7e5:fef0 with SMTP id 185-20020a1f00c2000000b003b5f7e5fef0mr14579357vka.11.1666961417602;
 Fri, 28 Oct 2022 05:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com> <20220922104823.z6465rfro7ataw2i@quack3>
In-Reply-To: <20220922104823.z6465rfro7ataw2i@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Oct 2022 15:50:04 +0300
Message-ID: <CAOQ4uxiNhnV0OWU-2SY_N0aY19UdMboR3Uivcr7EvS7zdd9jxw@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
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
[...]
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

Hi Jan,

It's been a while since I updated this topic.
I have been making progress on the wiki and POC, but it's not done yet.

I would like to poke your brain about my proposed solutions for the
TOCTOU race issues, because the solution is subtle and you may have
better ideas to suggest.

>
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
>

The current state of POC is that "populate of access" of both files
and directories is working and "race free evict of file content" is also
implemented (safely AFAIK).

The technique involving exclusive write lease is discussed at [1].
In a nutshell, populate and evict synchronize on atomic i_writecount
and this technique can be implemented with upstream UAPIs.

I did use persistent xattr marks for the POC, but this is not a must.
Evictable inode marks would have worked just as well.

Now I have started to work on persistent change tracking.
For this, I have only kernel code, only lightly tested, but I did not
prove yet that the technique is working.

The idea that I started to sketch at [2] is to alternate between two groups.

When a change is recorded, an evictable ignore mark will be added on the object.
To start recording changes from a new point in time (checkpoint), a new group
will be created (with no ignore marks) and the old group will be closed.

The core of the algorithm is the "safe handover" between groups.
This requires two infrastructure additions.

The first is FAN_MARK_SYNC [3] as described in commit message:
---
    Synchronous add of mark or remove/flush of marks with ignore mask
    provides a method for safe handover of event handling between two groups:

    - First, group A subscribes to some events with FAN_MARK_SYNC
    - Then, group B unsubscribes from those events

    This method guarantees that any event that both groups subscribed
    to, will be delivered to either group or to both of them.

    Note that FAN_MARK_SYNC provides no synchronization to the object
    interest masks, which are checked outside srcu read side.
    Therefore, this method does not provide any guarantee regarding
    delivery of events which only one of the groups is subscribed to.

    For example, if only group B was subscribed to FAN_OPEN_EXEC and only
    group A is subscribing only to FAN_OPEN, an execution of a binary file
    may not deliver FAN_OPEN_EXEC to group B nor FAN_OPEN to group A.
---

The second is to overlap fsnotify_mark_srcu read side with sb_start_write(),
for pre modify permission events [4] as described in commit message:
---
    fsnotify: acquire sb write access inside pre modify permission event

    For pre modify permission events, acquire sb write access before
    leaving SRCU and return >0 to signal that sb write access was acquired.

    This can be used to implement safe "handover" of pre modify permission
    events between two fanotify groups:

    - First, group A subscribes to pre modify events with FAN_MARK_SYNC
    - Then, a freeze/thaw cycle is performed on the filesystem
    - Finally, group B unsubscribes from those events

    This method guarantees that a pre modify event that both groups
    subscribed to will be delivered to either group or to both of them.

    In case that the pre modify event is delivered only to group B, the
    freeze/thaw cycle guarantees that the filesystem modification that
    followed that pre modify event was also completed, before the handover
    is complete and group B can be closed.

    For pre rename permission event, acquire sb write access after the
    second of the event pair (i.e. rename to) was authorized.
---

What do you think about this handover technique?
Do you think that it is workable or do you see any major flaws in it?
Would you use a different or an additional synchronization primitive
instead of abusing fsnotify_mark_srcu?

To clarify, the race that I am trying to avoid is:
1. group B got a pre modify event and recorded the change before time T
2. The actual modification is performed after time T
3. group A does not get a pre modify event, so does not record the change
    in the checkpoint since T

Thanks,
Amir.

[1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#invalidating-local-cache
[2] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#tracking-local-modifications
[3] https://github.com/amir73il/linux/commits/fan_mark_sync
[4] https://github.com/amir73il/linux/commits/fan_modify_perm
