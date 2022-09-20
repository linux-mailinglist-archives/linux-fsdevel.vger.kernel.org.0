Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89BD5BECB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 20:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiITSTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiITSTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:19:44 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E656B859
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 11:19:37 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id z14so1399246uam.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IboKmBN57P40J3Tdecb40UeOHLDfjqpyjocMb6mzORM=;
        b=EmElY7yNvdFP7by36L5IepUh2lm6UAA6pT6hZkMif9S61NrDHYxERWuO/x7JG76MeX
         lZZ7ggfSwgXBl/zxkFuUXYSZ9eupAvPzYs4V51gkd2yX8XmSuw1uA6bBVQR82gv2+1wh
         LtCu9nFpq6cCgU/T9uhbcB8kq6D04rUFxV+Pye3wsynRgli7RU3Np/3VR+8A9ZHTw7vJ
         pteJ6uNvRt1eSXRZphSIo6Ru/KiBu7aYs6TZdDEiq1An/THEgAoK73eWqlYw2l2P1zK7
         dglVHoU6iOxoysKttvJoClkI66ufx0LfaQDImyd6pfhNpxTyascQ78FphyPowHN6j67n
         BTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IboKmBN57P40J3Tdecb40UeOHLDfjqpyjocMb6mzORM=;
        b=vWWb88C8a8MkeT6e2cfzn9s7jcgKFv7wtUdb24vNQQ2bvWjnxBhw2Yxxv12HvfyZro
         P1jm6Owmv6ZhBVeaCvd48GMUUuc/MAt3Ys0f+VMy3ZGpTOBU6apWtrwUguobdd2BwEfo
         l6OaXNS8AWqU/MIhE1DxvO5g7Jy+p2YWj5IvlOD6j/lwUZDxr36TWxNhpTOVddf/NRdR
         GmyFvLxuX+rp2WQH+EqdQ1N26j8kzXCWThwnBWf30RVdHZqGrTLiYGgPN6a1DJWI0D/N
         I+YRWFhJYITYVOcPLVRxvCg+79BdHjM73Fs3c8SYca+V5WdufcGLhMuQ0tjITpXyC/Ap
         08dg==
X-Gm-Message-State: ACrzQf3bBrdnXIGME+QfEtOO1AS1Ysbp9+nyiGJJReSTnLCUHoAYY3uo
        vnoVmc/YGx8EXevEYF5l/HnXpY02VHtpw3jFgO0=
X-Google-Smtp-Source: AMsMyM47L/KOGabyqCmzgGILrfXo7XIHzW3RVwjbQohC24J42CeO4BBZxILwP4oKpr8v7bb6bhWiPOAqTtVhgcH26TU=
X-Received: by 2002:ab0:3c93:0:b0:3c0:b089:1081 with SMTP id
 a19-20020ab03c93000000b003c0b0891081mr2446526uax.9.1663697976965; Tue, 20 Sep
 2022 11:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Sep 2022 21:19:25 +0300
Message-ID: <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
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

On Wed, Sep 14, 2022 at 2:52 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > > So I'd prefer to avoid the major API
> > > > > extension unless there are serious users out there - perhaps we will even
> > > > > need to develop the kernel API in cooperation with the userspace part to
> > > > > verify the result is actually usable and useful.
> > >
> > > Yap. It should be trivial to implement a "mirror" HSM backend.
> > > For example, the libprojfs [5] projects implements a MirrorProvider
> > > backend for the Microsoft ProjFS [6] HSM API.
> >
> > Well, validating that things work using some simple backend is one thing
> > but we are probably also interested in whether the result is practical to
> > use - i.e., whether the performance meets the needs, whether the API is not
> > cumbersome for what HSM solutions need to do, whether the more advanced
> > features like range-support are useful the way they are implemented etc.
> > We can verify some of these things with simple mirror HSM backend but I'm
> > afraid some of the problems may become apparent only once someone actually
> > uses the result in practice and for that we need a userspace counterpart
> > that does actually something useful so that people have motivation to use
> > it :).
>

Hi Jan,

I wanted to give an update on the POC that I am working on.
I decided to find a FUSE HSM and show how it may be converted
to use fanotify HSM hooks.

HTTPDirFS is a read-only FUSE filesystem that lazyly populates a local
cache from a remote http on first access to every directory and file range.

Normally, it would be run like this:
./httpdirfs --cache-location /vdf/cache https://cdn.kernel.org/pub/ /mnt/pub/

Content is accessed via FUSE mount as /mnt/pub/ and FUSE implements
passthrough calls to the local cache dir if cache is already populated.

After my conversion patches [1], this download-only HSM can be run like
this without mounting FUSE:

sudo ./httpdirfs --fanotify --cache-location /vdf/cache
https://cdn.kernel.org/pub/ -

[1] https://github.com/amir73il/httpdirfs/commits/fanotify_pre_content

Browsing the cache directory at /vdf/cache, lazyly populates the local cache
using FAN_ACCESS_PERM readdir hooks and lazyly downloads files content
using FAN_ACCESS_PERM read hooks.

Up to this point, the implementation did not require any kernel changes.
However, this type of command does not populate the path components,
because lookup does not generate FAN_ACCESS_PERM event:

stat /vdf/cache/data/linux/kernel/firmware/linux-firmware-20220815.tar.gz

To bridge that functionality gap, I've implemented the FAN_LOOKUP_PERM
event [2] and used it to lazyly populate directories in the path ancestry.
For now, I stuck with the XXX_PERM convention and did not require
FAN_CLASS_PRE_CONTENT, although we probably should.

[2] https://github.com/amir73il/linux/commits/fanotify_pre_content

Streaming read of large files works as well, but only for sequential read
patterns. Unlike the FUSE read calls, the FAN_ACCESS_PERM events
do not (yet) carry range info, so my naive implementation downloads
one extra data chunk on each FAN_ACCESS_PERM until the cache file is full.

This makes it possible to run commands like:

tar tvfz /vdf/cache/data/linux/kernel/firmware/linux-firmware-20220815.tar.gz
| less

without having to wait for the entire 400MB file to download before
seeing the first page.

This streaming feature is extremely important for modern HSMs
that are often used to archive large media files in the cloud.

For the next steps of POC, I could do:
- Report FAN_ACCESS_PERM range info to implement random read
  patterns (e.g. unzip -l)
- Introduce FAN_MODIFY_PERM, so file content could be downloaded
  before modifying a read-write HSM cache
- Demo conversion of a read-write FUSE HSM implementation
  (e.g. https://github.com/volga629/davfs2)
- Demo HSM with filesystem mark [*] and a hardcoded test filter

[*] Note that unlike the case with recursive inotify, this POC HSM
implementation is not racy, because of the lookup permission events.
A filesystem mark is still needed to avoid pinning all the unpopulated
cache tree leaf entries to inode cache, so that this HSM could work on
a very large scale tree, the same as my original use case for implementing
filesystem mark.

If what you are looking for is an explanation why fanotify HSM would be better
than a FUSE HSM implementation then there are several reasons.
Performance is at the top of the list. There is this famous USENIX paper [3]
about FUSE passthrough performance.
It is a bit outdated, but many parts are still relevant - you can ask
the Android
developers why they decided to work on FUSE-BFP...

[3] https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf

For me, performance is one of the main concerns, but not the only one,
so I am not entirely convinced that a full FUSE-BFP implementation would
solve all my problems.

When scaling to many millions of passthrough inodes, resource usage start
becoming a limitation of a FUSE passthrough implementation and memory
reclaim of native fs works a lot better than memory reclaim over FUSE over
another native fs.

When the workload works on the native filesystem, it is also possible to
use native fs features (e.g. XFS ioctls).

Questions:
- What do you think about the direction this POC has taken so far?
- Is there anything specific that you would like to see in the POC
  to be convinced that this API will be useful?

Thanks,
Amir.
