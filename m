Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A135BFCD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIULUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIULUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:20:21 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B5662A9A;
        Wed, 21 Sep 2022 04:20:20 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id g27so2983492vkl.3;
        Wed, 21 Sep 2022 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=anU1i7MF58NuViEAXkHY0FObccWlEMJ/allqA3IY4JU=;
        b=IUbNlfgnSKAWC3Fhvc11b0WnSQpC0q7oOEbHD9uvEUoeSIcKztG5+0U+NS0x5MpRsE
         r4hb+tOzwFa3461TcHU1CqIkivtkNqhq0u38Zg0qJ3jYYISg2jk78YHHsUvMPpsCh99W
         /5yFlvX+zv+FfGhW4qGbpmrK4NIqkb1y+2iz7L+EE3mceCOs9FL2Qn6OKeCtiVKqwb4h
         KSnm6+cn5C6Zj9+10szVvNxBbKkvKzVvOJ2HqR2EajFzkXiKWHjIlx3YeyS1nTv3EMvv
         fKvLxE4ywhPvXojpnVEWBOezpnY2eJr+Q/fYtGMOZq24Z5xNUfYJTCkYP1aBIw6sL5qS
         ZxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=anU1i7MF58NuViEAXkHY0FObccWlEMJ/allqA3IY4JU=;
        b=oH25gptimr11nRZc3ZVM4MFv4Y3tDl0MDe3S2hS83q6ENwOenUN89wegdg5QDoxdy0
         uFVJPn9jzuckmIgzpMyJ66sb16RfhtASomLy0qR49/SMpcZgSaaGJ/9n6uORp97wmY8F
         vkRYJWobb7nInVS8wLv1/LRA0UqWn63rT/j8AmxYryG8VSk80NJL+tGocuhf6cR/3qGo
         kPgUhqkXotsiTDAu9nkca7TTXYY+C9kyLENRAHrg9cTkkyTME++ww9gHszwPJgE8CDVJ
         gi5tSWI1JaAQH5Nj8uVUTbjgqS6DiTVoB+5n9WyCK33FG1X9pAsEKfObsy55jmN+zTAI
         Ypiw==
X-Gm-Message-State: ACrzQf2bLdP7Fz7TKksulpyZmXe6PSZ2HYP3zrMZqWPpI1do2DwHXO66
        QPsAvUn6euulxd/QEs5Wfv/2V5Bgb7PRE3s5HAA=
X-Google-Smtp-Source: AMsMyM4KSqcuc6B7TOWUec0eZnzNQqxNHwe+OgLBDCok4SOygwE6J+nXWOzEe2YbhujI+z6gYGk/noqCN6J172rhrPI=
X-Received: by 2002:a1f:a004:0:b0:398:3e25:d2a7 with SMTP id
 j4-20020a1fa004000000b003983e25d2a7mr10228391vke.36.1663759219145; Wed, 21
 Sep 2022 04:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan> <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan> <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
 <YyH61deSiW1TnY//@magnolia> <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
 <YyIR4XmDYkYIK2ad@magnolia> <20220919230947.GM3600936@dread.disaster.area>
 <20220920022439.GP3600936@dread.disaster.area> <CAOQ4uxgNBWpdpoXrqwhtGkMCLr3aAdv2=_oEYtafWK1WrP4-hw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgNBWpdpoXrqwhtGkMCLr3aAdv2=_oEYtafWK1WrP4-hw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Sep 2022 14:20:07 +0300
Message-ID: <CAOQ4uxj4uCRkqN+L1RYmY9Ey=eu3xp249Y6BYU-JQFjgGrOdQg@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Tue, Sep 20, 2022 at 6:08 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
[...]

> > As I just discussed on #xfs with Darrick, there are other options
> > we can persue here.
> >
> > The first question we need to ask ourselves is this: what are we
> > protecting against with exclusive buffered write behaviour?
> >
> > The answer is that we know there are custom enterprise database
> > applications out there that assume that 8-16kB buffered writes are
> > atomic. I wish I could say these are legacy applications these days,
> > but they aren't - they are still in production use, and the
> > applications build on those custom database engines are still under
> > active development and use.
> >
> > AFAIK, the 8kB atomic write behaviour is historical and came from
> > applications originally designed for Solaris and hardware that
> > had an 8kB page size. Hence buffered 8kB writes were assumed to be
> > the largest atomic write size that concurrent reads would not see
> > write tearing. These applications are now run on x86-64 boxes with
> > 4kB page size, but they still assume that 8kB writes are atomic and
> > can't tear.
> >
>
> Interesting. I did not know which applications needed that behavior.
> The customer benchmark that started the complaint uses 8k buffered
> IO size (as do the benchmarks that I posted in this thread), so far as
> I am concerned, fixing small buffered IO will solve the problem.
>
> > So, really, these days the atomic write behaviour of XFS is catering
> > for these small random read/write IO applications, not to provide
> > atomic writes for bulk data moving applications writing 2GB of data
> > per write() syscall. Hence we can fairly safely say that we really
> > only need "exclusive" buffered write locking for relatively small
> > multipage IOs, not huge IOs.
> >
> > We can do single page shared buffered writes immediately - we
> > guarantee that while the folio is locked, a buffered read cannot
> > access the data until the folio is unlocked. So that could be the
> > first step to relaxing the exclusive locking requirement for
> > buffered writes.
> >
> > Next we need to consider that we now have large folio support in the
> > page cache, which means we can treat contiguous file ranges larger
> > than a single page a single atomic unit if they are covered by a
> > multi-page folio. As such, if we have a single multi-page folio that
> > spans the entire write() range already in cache, we can run that
> > write atomically under a shared IO lock the same as we can do with
> > single page folios.
> >
> > However, what happens if the folio is smaller than the range we need
> > to write? Well, in that case, we have to abort the shared lock write
> > and upgrade to an exclusive lock before trying again.
> >

Please correct me if I am wrong, but with current upstream, the only
way that multi page folios are created for 4K block / 4K page setup are
during readahead.

We *could* allocate multi page folios on write to an allocated block range
that maps inside a single extent, but there is no code for that today.

It seems that without this code, any write to a region of page cache not
pre-populated using readahead, would get exclusive iolock for 8K buffered
writes until that single page folio cache entry is evicted.

Am I reading the iomap code correctly?

> > Of course, we can only determine if the write can go ahead once we
> > have the folio locked. That means we need a new non-blocking write
> > condition to be handled by the iomap code. We already have several
> > of them because of IOCB_NOWAIT semantics that io_uring requires for
> > buffered writes, so we are already well down the path of needing to
> > support fully non-blocking writes through iomap.
> >
> > Further, the recent concurrent write data corruption that we
> > uncovered requires a new hook in the iomap write path to allow
> > writes to be aborted for remapping because the cached iomap has
> > become stale. This validity check can only be done once the folio
> > has locked - if the cached iomap is stale once we have the page
> > locked, then we have to back out and remap the write range and
> > re-run the write.
> >
> > IOWs, we are going to have to add write retries to the iomap write
> > path for data integrity purposes. These checks must be done only
> > after the folio has been locked, so we really end up getting the
> > "can't do atomic write" retry infrastructure for free with the data
> > corruption fixes...
> >
> > With this in place, it becomes trivial to support atomic writes with
> > shared locking all the way up to PMD sizes (or whatever the maximum
> > multipage folio size the arch supports is) with a minimal amount of
> > extra code.
> >
> > At this point, we have a buffered write path that tries to do shared
> > locking first, and only falls back to exclusive locking if the page
> > cache doesn't contain a folio large enough to soak up the entire
> > write.
> >
> > In future, Darrick suggested we might be able to do a "trygetlock a
> > bunch of folios" operation that locks a range of folios within the
> > current iomap in one go, and then we write into all of them in a
> > batch before unlocking them all. This would give us multi-folio
> > atomic writes with shared locking - this is much more complex, and
> > it's unclear that multi-folio write batching will gain us anything
> > over the single folio check described above...
> >
> > Finally, for anything that is concurrently reading and writing lots
> > of data in chunks larger than PMD sizes, the application should
> > really be using DIO with AIO or io_uring. So falling back to
> > exclusive locking for such large single buffered write IOs doesn't
> > seem like a huge issue right now....
> >
> > Thoughts?
>
> That sounds like a great plan.
> I especially liked the "get it for free" part ;)
> Is there already WIP for the data integrity issue fix?
>

OK. I see your patch set.

> If there is anything I can do to assist, run the benchmark or anything
> please let me know.
>
> In the meanwhile, I will run the benchmark with XFS_IOLOCK_SHARED
> on the write() path.
>

As expected, results without exclusive iolock look very good [*].

Thanks,
Amir.

[*] I ran the following fio workload on e2-standard-8 GCE machine:

[global]
filename=/mnt/xfs/testfile.fio
norandommap
randrepeat=0
size=5G
bs=8K
ioengine=psync
numjobs=8
group_reporting=1
direct=0
fallocate=1
end_fsync=0
runtime=60

[xfs-read]
readwrite=randread

[xfs-write]
readwrite=randwrite

========================= v6.0-rc4 (BAD) =========
Run #1:
   READ: bw=7053KiB/s (7223kB/s)
  WRITE: bw=155MiB/s (163MB/s)

Run #2:
   READ: bw=4672KiB/s (4784kB/s)
  WRITE: bw=355MiB/s (372MB/s)

Run #3:
   READ: bw=5887KiB/s (6028kB/s)
  WRITE: bw=137MiB/s (144MB/s)

========================= v6.0-rc4 (read no iolock like ext4 - GOOD) =========
   READ: bw=742MiB/s (778MB/s)
  WRITE: bw=345MiB/s (361MB/s)

========================= v6.0-rc4 (write shared iolock - BETTER) =========
Run #1:
   READ: bw=762MiB/s (799MB/s)
  WRITE: bw=926MiB/s (971MB/s)

Run #2:
   READ: bw=170MiB/s (178MB/s)
  WRITE: bw=982MiB/s (1029MB/s)

Run #3:
   READ: bw=755MiB/s (792MB/s)
  WRITE: bw=933MiB/s (978MB/s)
