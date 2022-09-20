Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A1E5BDAAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 05:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiITDIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 23:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiITDIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:08:41 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2571A9;
        Mon, 19 Sep 2022 20:08:39 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id v192so716252vkv.7;
        Mon, 19 Sep 2022 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RNMdgUmRjTuUBIITDYxH8VCGqeC1BEg4zEjZy3sXB5c=;
        b=ZckckWJuiGSzze8s+GYP4pKMR6cKEtWq9NpsF6AKfNUaCZQotUkkmwdudL06gc9EbP
         EgX8s3UUQoGnnRk8E/r6e2GZ4rhMQIEEqkAHoJjdhGuN5FnaYIgH4NKkbpgvtVnk0zv7
         IixSK3Tbo0SqOtwflMz9HbL/stJxnyomGAl1CvZjJRXAXEADg5/luCY0YvDX5IywRGyb
         1oSJq+SBDZQLUK78/yt0+6o2/h+9UJ3cJHLyLIEPTD1FOk6A+N0qq4Bk12S3obOnLVry
         FVlzuuxWo2ez2aXI7hz8mLgv3X71ubpPm1GW7S795ArbOs6zM27s+SGgfOmaTN7OEGQ/
         scTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RNMdgUmRjTuUBIITDYxH8VCGqeC1BEg4zEjZy3sXB5c=;
        b=W9S9xpIRV11KF/PoiKrnA2JcrwTjdOJQltgn5J7BL0GJMrZS1BQPj5336WlvLOok2h
         gm8F3iXHNpsze7ljCHE+wDKCic1zroTOfPcCm76hENGJfXz0nQTLQnWDXmghOBcRAIYc
         Tr8R1miBijL8c5vjefc+0xy2IcIPBVSyC1XNA3Bl7hZg6uKnC3LgwkmuELxdeRckzNDl
         W2cPUqGEQlMUnk0+F869jxyBcGVjEkYwapvQQ4SUTk5+OuoqUhxfpQnOBGBrrs5PrLFT
         ZlKad+G7Rrbk3A/oH+8BBT/m0AUMXQSeEzH4094OpcKSaq1br3zdg7R2aPirbJpJWdTu
         Thag==
X-Gm-Message-State: ACrzQf1rQgTw90Jui3PkrX0+6vGmdllsuKcKZ9pRvLSqsxm1atWfb3eH
        eSGhzzxKr/HTBzvSE4UlL7BmgunR5VW7YTPP6oY=
X-Google-Smtp-Source: AMsMyM6bF2U4VpvwkVN1bBCJmf3eUGds/HJWrGFpDGp1H/cZyLc0FQ0Kc4qiKwGSFwn4qc1Hckbh91IVlvYGMR/Jz0w=
X-Received: by 2002:a1f:19cf:0:b0:375:6144:dc41 with SMTP id
 198-20020a1f19cf000000b003756144dc41mr7278073vkz.3.1663643318563; Mon, 19 Sep
 2022 20:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan> <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan> <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <CAOQ4uxguwnx4AxXqp_zjg39ZUaTGJEM2wNUPnNdtiqV2Q9woqA@mail.gmail.com>
 <YyH61deSiW1TnY//@magnolia> <CAOQ4uxhFJWW-ykyzomHCUWfWvbJNEmetw0G5mUYjFGoYJBb7NA@mail.gmail.com>
 <YyIR4XmDYkYIK2ad@magnolia> <20220919230947.GM3600936@dread.disaster.area> <20220920022439.GP3600936@dread.disaster.area>
In-Reply-To: <20220920022439.GP3600936@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Sep 2022 06:08:26 +0300
Message-ID: <CAOQ4uxgNBWpdpoXrqwhtGkMCLr3aAdv2=_oEYtafWK1WrP4-hw@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 5:24 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Sep 20, 2022 at 09:09:47AM +1000, Dave Chinner wrote:
> > On Wed, Sep 14, 2022 at 10:39:45AM -0700, Darrick J. Wong wrote:
> > > On Wed, Sep 14, 2022 at 07:29:15PM +0300, Amir Goldstein wrote:
> > > > > > Dave, Christoph,
> > > > > >
> > > > > > I know that you said that changing the atomic buffered read semantics
> > > > > > is out of the question and that you also objected to a mount option
> > > > > > (which nobody will know how to use) and I accept that.
> > > > > >
> > > > > > Given that a performant range locks implementation is not something
> > > > > > trivial to accomplish (Dave please correct me if I am wrong),
> > > > > > and given the massive performance impact of XFS_IOLOCK_SHARED
> > > > > > on this workload,
> > > > > > what do you think about POSIX_FADV_TORN_RW that a specific
> > > > > > application can use to opt-out of atomic buffer read semantics?
> > > > > >
> > > > > > The specific application that I want to modify to use this hint is Samba.
> > > > > > Samba uses IO threads by default to issue pread/pwrite on the server
> > > > > > for IO requested by the SMB client. The IO size is normally larger than
> > > > > > xfs block size and the range may not be block aligned.
> > > > > >
> > > > > > The SMB protocol has explicit byte range locks and the server implements
> > > > > > them, so it is pretty safe to assume that a client that did not request
> > > > > > range locks does not need xfs to do the implicit range locking for it.
>
> That doesn't cover concurrent local (server side) access to the
> file. It's not uncommon to have the same filesystems exported by
> both Samba and NFS at the same time, and the only point of
> co-ordination between the two is the underlying local filesystem....
>
> IOWs, when we are talking about local filesystem behaviour, what a
> network protocol does above the filesystem is largely irrelevant to
> the synchronisation required within the filesystem
> implementation....
>

Perhaps I did not explain my proposal well.
Maybe I should have named it POSIX_FADV_TORN_READ.
The fadvise() from nfs/smb server would affect only the behavior
of buffered reads on the open fd of that server, it will not affect
any buffered IO on that inode not associated with the application
that opted-in to this behavior.

Also, the nfs/smb server buffered writes are still under the same
exclusive IO lock as the rest of the callers.


> > > > > > For this reason and because of the huge performance win,
> > > > > > I would like to implement POSIX_FADV_TORN_RW in xfs and
> > > > > > have Samba try to set this hint when supported.
> > > > > >
> > > > > > It is very much possible that NFSv4 servers (user and kennel)
> > > > > > would also want to set this hint for very similar reasons.
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > How about range locks for i_rwsem and invalidate_lock?  That could
> > > > > reduce contention on VM farms, though I can only assume that, given that
> > > > > I don't have a reference implementation to play with...
> > > > >
> > > >
> > > > If you are asking if I have the bandwidth to work on range lock
> > > > then the answer is that I do not.
> > > >
> > > > IIRC, Dave had a WIP and ran some benchmarks with range locks,
> > > > but I do not know at which state that work is.
> > >
> > > Yeah, that's what I was getting at -- I really wish Dave would post that
> > > as an RFC.  The last time I talked to him about it, he was worried that
> > > the extra complexity of the range lock structure would lead to more
> > > memory traffic and overhead.
> >
> > The reason I haven't posted it is that I don't think range locks can
> > ever be made to perform and scale as we need for the IO path.
>
> [snip range lock scalability and perf issues]
>
> As I just discussed on #xfs with Darrick, there are other options
> we can persue here.
>
> The first question we need to ask ourselves is this: what are we
> protecting against with exclusive buffered write behaviour?
>
> The answer is that we know there are custom enterprise database
> applications out there that assume that 8-16kB buffered writes are
> atomic. I wish I could say these are legacy applications these days,
> but they aren't - they are still in production use, and the
> applications build on those custom database engines are still under
> active development and use.
>
> AFAIK, the 8kB atomic write behaviour is historical and came from
> applications originally designed for Solaris and hardware that
> had an 8kB page size. Hence buffered 8kB writes were assumed to be
> the largest atomic write size that concurrent reads would not see
> write tearing. These applications are now run on x86-64 boxes with
> 4kB page size, but they still assume that 8kB writes are atomic and
> can't tear.
>

Interesting. I did not know which applications needed that behavior.
The customer benchmark that started the complaint uses 8k buffered
IO size (as do the benchmarks that I posted in this thread), so far as
I am concerned, fixing small buffered IO will solve the problem.

> So, really, these days the atomic write behaviour of XFS is catering
> for these small random read/write IO applications, not to provide
> atomic writes for bulk data moving applications writing 2GB of data
> per write() syscall. Hence we can fairly safely say that we really
> only need "exclusive" buffered write locking for relatively small
> multipage IOs, not huge IOs.
>
> We can do single page shared buffered writes immediately - we
> guarantee that while the folio is locked, a buffered read cannot
> access the data until the folio is unlocked. So that could be the
> first step to relaxing the exclusive locking requirement for
> buffered writes.
>
> Next we need to consider that we now have large folio support in the
> page cache, which means we can treat contiguous file ranges larger
> than a single page a single atomic unit if they are covered by a
> multi-page folio. As such, if we have a single multi-page folio that
> spans the entire write() range already in cache, we can run that
> write atomically under a shared IO lock the same as we can do with
> single page folios.
>
> However, what happens if the folio is smaller than the range we need
> to write? Well, in that case, we have to abort the shared lock write
> and upgrade to an exclusive lock before trying again.
>
> Of course, we can only determine if the write can go ahead once we
> have the folio locked. That means we need a new non-blocking write
> condition to be handled by the iomap code. We already have several
> of them because of IOCB_NOWAIT semantics that io_uring requires for
> buffered writes, so we are already well down the path of needing to
> support fully non-blocking writes through iomap.
>
> Further, the recent concurrent write data corruption that we
> uncovered requires a new hook in the iomap write path to allow
> writes to be aborted for remapping because the cached iomap has
> become stale. This validity check can only be done once the folio
> has locked - if the cached iomap is stale once we have the page
> locked, then we have to back out and remap the write range and
> re-run the write.
>
> IOWs, we are going to have to add write retries to the iomap write
> path for data integrity purposes. These checks must be done only
> after the folio has been locked, so we really end up getting the
> "can't do atomic write" retry infrastructure for free with the data
> corruption fixes...
>
> With this in place, it becomes trivial to support atomic writes with
> shared locking all the way up to PMD sizes (or whatever the maximum
> multipage folio size the arch supports is) with a minimal amount of
> extra code.
>
> At this point, we have a buffered write path that tries to do shared
> locking first, and only falls back to exclusive locking if the page
> cache doesn't contain a folio large enough to soak up the entire
> write.
>
> In future, Darrick suggested we might be able to do a "trygetlock a
> bunch of folios" operation that locks a range of folios within the
> current iomap in one go, and then we write into all of them in a
> batch before unlocking them all. This would give us multi-folio
> atomic writes with shared locking - this is much more complex, and
> it's unclear that multi-folio write batching will gain us anything
> over the single folio check described above...
>
> Finally, for anything that is concurrently reading and writing lots
> of data in chunks larger than PMD sizes, the application should
> really be using DIO with AIO or io_uring. So falling back to
> exclusive locking for such large single buffered write IOs doesn't
> seem like a huge issue right now....
>
> Thoughts?

That sounds like a great plan.
I especially liked the "get it for free" part ;)
Is there already WIP for the data integrity issue fix?

If there is anything I can do to assist, run the benchmark or anything
please let me know.

In the meanwhile, I will run the benchmark with XFS_IOLOCK_SHARED
on the write() path.

Thanks!
Amir.
