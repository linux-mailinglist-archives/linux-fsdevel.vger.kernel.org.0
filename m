Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B24560B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiF2Un1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiF2UnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:43:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A02182E
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 13:43:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cl1so472831wrb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jun 2022 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jK9//luGxpfbLffwOAXZvUD0KZmVzGC+4VJ1Mf8Ewyg=;
        b=k5WSowoVnLxuxKjSPP3cp1XzTEAHY3y45UhQuF8UEDAyCTaVCqG/CT+GI0HDpCJiRr
         qY92QFJIvnA+icgYFsho+2NHk8VIu8knAAsA4n5acDav+H8Bx/JChuc9/xU2pHxunkqn
         Xa7V6+8eHKvHEzuihehfP5VnTNMUxG2sVEkn+lldtmnf/cCTkXjtmmUEqEhHB1ghA1+P
         XiNUznA+U4VlknZfH43Wecpj/M1WX+pi8c7VlQcttS6Tn+4WR79rWAWtr3AWhjkWvAlB
         8c14CN87gcOsljgVtquohoB6BqLa9yxRumbngWbW4Zv5Aafipq5gZb9HHF5pygsGcTHe
         sV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jK9//luGxpfbLffwOAXZvUD0KZmVzGC+4VJ1Mf8Ewyg=;
        b=lSn0SDYBOWYbG9C1cZTf8jc1f9qYAZdULJVbgBGPONPgmA5fkBIt06O0L4YipR19hZ
         aF3CI+mZcB/MYZHli/bmcb3pPibujSiI5gYKF0AhU1IuF1P/zVtcI2QUZSB8gaWkTn3Q
         Ifg+5ysgzN2C2ydWbEff0xKkWDtpw4AD6zaRuE14/Elq8s6wQohtUoX9LpsvLSmOrAjh
         s+S7m1mHzHyETT683GGTfknOi9npZNl2kuEcIgdx+WX+1PVtpb1BQnQy8SKOBcigYq1C
         IlhChuCXPggsLT2AUFVeOXrKKGKPGMujm21PSHw+gYaIUX2d47uBmUSFy+1gvqwrcBAa
         LEjg==
X-Gm-Message-State: AJIora/Xi9D6CuKjZy2QhsLloZ9L/0VH3wxfTYGGn/vWjf8t6fXgGear
        VDLpPCMANTdsO+pz6gLhESuTy7PL2u078kUAVJGjqQ==
X-Google-Smtp-Source: AGRyM1sdZpRIIt8pzdPqsysENF0+n2K+v1kR9bTNvP8/I1WmweNa1mfdcg2Fg6hW5XcLplZP4kyRd9qLNe68d2DEstQ=
X-Received: by 2002:a5d:52c6:0:b0:21b:9f39:78de with SMTP id
 r6-20020a5d52c6000000b0021b9f3978demr5179522wrv.699.1656535402268; Wed, 29
 Jun 2022 13:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220623220613.3014268-1-kaleshsingh@google.com>
 <20220623220613.3014268-2-kaleshsingh@google.com> <Yrrrz7MxMu8OoEPU@bfoster>
 <CAC_TJvejs5gbggC1hekyjUNctC_8+3FmVn0B7zAZox2+MkEjaA@mail.gmail.com> <YrxEUbDkYLE6XF6x@bfoster>
In-Reply-To: <YrxEUbDkYLE6XF6x@bfoster>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 29 Jun 2022 13:43:11 -0700
Message-ID: <CAC_TJvcRd7=9xGXP5-t8v3g5iFWtYANpGA-nTqaGZBVTwa=07w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] procfs: Add 'size' to /proc/<pid>/fdinfo/
To:     Brian Foster <bfoster@redhat.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        David.Laight@aculab.com, Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 5:23 AM Brian Foster <bfoster@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 03:38:02PM -0700, Kalesh Singh wrote:
> > On Tue, Jun 28, 2022 at 4:54 AM Brian Foster <bfoster@redhat.com> wrote=
:
> > >
> > > On Thu, Jun 23, 2022 at 03:06:06PM -0700, Kalesh Singh wrote:
> > > > To be able to account the amount of memory a process is keeping pin=
ned
> > > > by open file descriptors add a 'size' field to fdinfo output.
> > > >
> > > > dmabufs fds already expose a 'size' field for this reason, remove t=
his
> > > > and make it a common field for all fds. This allows tracking of
> > > > other types of memory (e.g. memfd and ashmem in Android).
> > > >
> > > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > ---
> > > >
> > > > Changes in v2:
> > > >   - Add Christian's Reviewed-by
> > > >
> > > > Changes from rfc:
> > > >   - Split adding 'size' and 'path' into a separate patches, per Chr=
istian
> > > >   - Split fdinfo seq_printf into separate lines, per Christian
> > > >   - Fix indentation (use tabs) in documentaion, per Randy
> > > >
> > > >  Documentation/filesystems/proc.rst | 12 ++++++++++--
> > > >  drivers/dma-buf/dma-buf.c          |  1 -
> > > >  fs/proc/fd.c                       |  9 +++++----
> > > >  3 files changed, 15 insertions(+), 7 deletions(-)
> > > >
> ...
> > >
> > > Also not sure if it matters that much for your use case, but somethin=
g
> > > worth noting at least with shmem is that one can do something like:
> > >
> > > # cat /proc/meminfo | grep Shmem:
> > > Shmem:               764 kB
> > > # xfs_io -fc "falloc -k 0 10m" ./file
> > > # ls -alh file
> > > -rw-------. 1 root root 0 Jun 28 07:22 file
> > > # stat file
> > >   File: file
> > >   Size: 0               Blocks: 20480      IO Block: 4096   regular e=
mpty file
> > > # cat /proc/meminfo | grep Shmem:
> > > Shmem:             11004 kB
> > >
> > > ... where the resulting memory usage isn't reflected in i_size (but i=
s
> > > is in i_blocks/bytes).
> >
> > I tried a similar experiment a few times, but I don't see the same
> > results. In my case, there is not any change in shmem. IIUC the
> > fallocate is allocating the disk space not shared memory.
> >
>
> Sorry, it was implied in my previous test was that I was running against
> tmpfs. So regardless of fs, the fallocate keep_size semantics shown in
> both cases is as expected: the underlying blocks are allocated and the
> inode size is unchanged.
>
> What wasn't totally clear to me when I read this patch was 1. whether
> tmpfs refers to Shmem and 2. whether tmpfs allowed this sort of
> operation. The test above seems to confirm both, however, right? E.g., a
> more detailed example:
>
> # mount | grep /tmp
> tmpfs on /tmp type tmpfs (rw,nosuid,nodev,seclabel,nr_inodes=3D1048576,in=
ode64)
> # cat /proc/meminfo | grep Shmem:
> Shmem:              5300 kB
> # xfs_io -fc "falloc -k 0 1g" /tmp/file
> # stat /tmp/file
>   File: /tmp/file
>   Size: 0               Blocks: 2097152    IO Block: 4096   regular empty=
 file
> Device: 22h/34d Inode: 45          Links: 1
> Access: (0600/-rw-------)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: unconfined_u:object_r:user_tmp_t:s0
> Access: 2022-06-29 08:04:01.301307154 -0400
> Modify: 2022-06-29 08:04:01.301307154 -0400
> Change: 2022-06-29 08:04:01.451312834 -0400
>  Birth: 2022-06-29 08:04:01.301307154 -0400
> # cat /proc/meminfo | grep Shmem:
> Shmem:           1053876 kB
> # rm -f /tmp/file
> # cat /proc/meminfo | grep Shmem:
> Shmem:              5300 kB
>
> So clearly this impacts Shmem.. was your test run against tmpfs or some
> other (disk based) fs?

Hi Brian,

Thanks for clarifying. My issue was tmpfs not mounted at /tmp in my system:

=3D=3D> meminfo.start <=3D=3D
Shmem:               572 kB
=3D=3D> meminfo.stop <=3D=3D
Shmem:             51688 kB

>
> FWIW, I don't have any objection to exposing inode size if it's commonly
> useful information. My feedback was more just an fyi that i_size doesn't
> necessarily reflect underlying space consumption (whether it's memory or
> disk space) in more generic cases, because it sounds like that is really
> what you're after here. The opposite example to the above would be
> something like an 'xfs_io -fc "truncate 1t" /tmp/file', which shows a
> 1TB inode size with zero additional shmem usage.

From these cases, it seems the more generic way to do this is by
calculating the actual size consumed using the blocks. (i_blocks *
512). So in the latter example  'xfs_io -fc "truncate 1t" /tmp/file'
the size consumed would be zero. Let me know if it sounds ok to you
and I can repost the updated version.

Thanks,
Kalesh

>
> Brian
>
> > cat /proc/meminfo > meminfo.start
> > xfs_io -fc "falloc -k 0 50m" ./xfs_file
> > cat /proc/meminfo > meminfo.stop
> > tail -n +1 meminfo.st* | grep -i '=3D=3D\|Shmem:'
> >
> > =3D=3D> meminfo.start <=3D=3D
> > Shmem:               484 kB
> > =3D=3D> meminfo.stop <=3D=3D
> > Shmem:               484 kB
> >
> > ls -lh xfs_file
> > -rw------- 1 root root 0 Jun 28 15:12 xfs_file
> >
> > stat xfs_file
> >   File: xfs_file
> >   Size: 0               Blocks: 102400     IO Block: 4096   regular emp=
ty file
> >
> > Thanks,
> > Kalesh
> >
> > >
> > > Brian
> > >
> > > >
> > > >       /* show_fd_locks() never deferences files so a stale value is=
 safe */
> > > >       show_fd_locks(m, file, files);
> > > > --
> > > > 2.37.0.rc0.161.g10f37bed90-goog
> > > >
> > >
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
