Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB37B762D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 03:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjJDBQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjJDBQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:16:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E1B4
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 18:16:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-277550774e5so1050847a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 18:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696382188; x=1696986988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27OUlXqVAY5pph8VgkHut5jt4z0+Lj/b+tomTvgAza4=;
        b=QthoRRAX1baBx3h8rgX8Bw+0FWLigoJo7DUnxOe8B8MEIyrb06X5OX699/5nX02v3l
         WS4jjFjnGXObRCM4vjeoiySxa7JNxnN0Cz9O/PRrI4U8CPpHbNkryhS/Dxr5+pYrm973
         wA8j++f6kbITTUKETCGkYfbdu1ECHLJkTD/akDftkuLh6Gd4jRVnnbofGTK3vgP9q+vF
         /TPXXWnvwVcT/g9H8LI7JdEUKncDZQUc80d1NU6ZHu+1FHNh0iosVf5btk+Nt77RGF96
         qUUSrOrCmlAj1RsmykVACkKEGdByybTBtBPBTVQIhCcROLX6FWAXHkTBX79sqI/Th+S9
         wpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696382188; x=1696986988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27OUlXqVAY5pph8VgkHut5jt4z0+Lj/b+tomTvgAza4=;
        b=HQ7UHnl/qfSInTXLqT4WD0gEUc1q7iXpt3B7dH6KK9tRzZo7ZaZQP2puM7q6i3Sm5H
         fIoQaUfVYXD8YblZa7dgFGAsreY0Ax3ZtCE9c3lPWQSjP+gv7GemJx+sT2ZQNn0xudlm
         msgPl2L//zc19aNQE62u19P6D/UTYB5KagWEnf95mfeH+938yjCfturYTy0YUN3wrwlj
         migjSB20djipdkIipLvNHJSIlXIdKV3VzMvOKXBDI3JdChtVoCgkgjGRsGSetgVBCNvA
         60Yjp/kMz9oHCv+5OM4enw1ZLxlfN1XnbQ2p83WgJNWhR1018vYC5S5mG2a5D+DGNXBZ
         D9Fw==
X-Gm-Message-State: AOJu0Yxclpn+6XWX4+wWqlzMoTFtqo9u+k63wVEmtTQ+2tyJm4ICaUYT
        wN0tVasivc6rO8K53OvfJyBo4g==
X-Google-Smtp-Source: AGHT+IGAZMmhmKfxlRSU/a8+EGUxGlR0SLNCds5QUJ8ZXzl8PknPnruiTA+IGWcxcfozw3Ji0pNl7Q==
X-Received: by 2002:a17:90b:4ad2:b0:269:2682:11fb with SMTP id mh18-20020a17090b4ad200b00269268211fbmr964608pjb.8.1696382187364;
        Tue, 03 Oct 2023 18:16:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090aa39200b002609cadc56esm228044pjp.11.2023.10.03.18.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:16:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnqUx-0098Sr-2u;
        Wed, 04 Oct 2023 12:16:23 +1100
Date:   Wed, 4 Oct 2023 12:16:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 16/21] fs: iomap: Atomic write support
Message-ID: <ZRy850C0sceCsf1k@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-17-john.g.garry@oracle.com>
 <ZRuXd/iG1kyeFQDh@dread.disaster.area>
 <20231003164749.GH21298@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003164749.GH21298@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:47:49AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 03, 2023 at 03:24:23PM +1100, Dave Chinner wrote:
> > On Fri, Sep 29, 2023 at 10:27:21AM +0000, John Garry wrote:
> > > Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
> > > bio is being created and all the rules there need to be followed.
> > > 
> > > It is the task of the FS iomap iter callbacks to ensure that the mapping
> > > created adheres to those rules, like size is power-of-2, is at a
> > > naturally-aligned offset, etc.
> > 
> > The mapping being returned by the filesystem can span a much greater
> > range than the actual IO needs - the iomap itself is not guaranteed
> > to be aligned to anything in particular, but the IO location within
> > that map can still conform to atomic IO constraints. See how
> > iomap_sector() calculates the actual LBA address of the IO from
> > the iomap and the current file position the IO is being done at.
> > 
> > hence I think saying "the filesysetm should make sure all IO
> > alignment adheres to atomic IO rules is probably wrong. The iomap
> > layer doesn't care what the filesystem does, all it cares about is
> > whether the IO can be done given the extent map that was returned to
> > it.
> > 
> > Indeed, iomap_dio_bio_iter() is doing all these alignment checks for
> > normal DIO reads and writes which must be logical block sized
> > aligned. i.e. this check:
> > 
> >         if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> >             !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> >                 return -EINVAL;
> > 
> > Hence I think that atomic IO units, which are similarly defined by
> > the bdev, should be checked at the iomap layer, too. e.g, by
> > following up with:
> > 
> > 	if ((dio->iocb->ki_flags & IOCB_ATOMIC) &&
> > 	    ((pos | length) & (bdev_atomic_unit_min(iomap->bdev) - 1) ||
> > 	     !bdev_iter_is_atomic_aligned(iomap->bdev, dio->submit.iter))
> > 		return -EINVAL;
> > 
> > At this point, filesystems don't really need to know anything about
> > atomic IO - if they've allocated a large contiguous extent (e.g. via
> > fallocate()), then RWF_ATOMIC will just work for the cases where the
> > block device supports it...
> > 
> > This then means that stuff like XFS extent size hints only need to
> > check when the hint is set that it is aligned to the underlying
> > device atomic IO constraints. Then when it sees the IOMAP_ATOMIC
> > modifier, it can fail allocation if it can't get extent size hint
> > aligned allocation.
> > 
> > IOWs, I'm starting to think this doesn't need any change to the
> > on-disk format for XFS - it can be driven entirely through two
> > dynamic mechanisms:
> > 
> > 1. (IOMAP_WRITE | IOMAP_ATOMIC) requests from the direct IO layer
> > which causes mapping/allocation to fail if it can't allocate (or
> > map) atomic IO compatible extents for the IO.
> > 
> > 2. FALLOC_FL_ATOMIC preallocation flag modifier to tell fallocate()
> > to force alignment of all preallocated extents to atomic IO
> > constraints.
> 
> Ugh, let's not relitigate problems that you (Dave) and I have already
> solved.
> 
> Back in 2018, our internal proto-users of pmem asked for aligned
> allocations so they could use PMD mappings to reduce TLB pressure.  At
> the time, you and I talked on IRC about whether that should be done via
> fallocate flag or setting extszinherit+sunit at mkfs time.  We decided
> against adding fallocate flags because linux-api bikeshed hell.

Ok, but I don't see how I'm supposed to correlate a discussion from
5 years ago on a different topic with this one. I can only comment
on what I see in front of me. And what is in front of me is
something that doesn't need on-disk changes to implement....

> Ever since, we've been shipping UEK with a mkfs.xmem scripts that
> automates computing the mkfs.xfs geometry CLI options.  It works,
> mostly, except for the unaligned allocations that one gets when the free
> space gets fragmented.  The xfsprogs side of the forcealign patchset
> moves most of the mkfs.xmem cli option setting logic into mkfs itself,
> and the kernel side shuts off the lowspace allocator to fix the
> fragmentation problem.
> 
> I'd rather fix the remaining quirks and not reinvent solved solutions,
> as popular as that is in programming circles.
> 
> Why is mandatory allocation alignment for atomic writes different?
> Forcealign solves the problem for NVME/SCSI AWU and pmem PMD in the same
> way with the same control knobs for sysadmins.  I don't want to have
> totally separate playbooks for accomplishing nearly the same things.

Which is fair enough, but that's not the context under which this
has been presented.

Can we please get the forced-align stuff separated from atomic write
support - the atomic write requirements completely overwhelms small
amount of change needed to support physical file offset
alignment....

> I don't like encoding hardware details in the fallocate uapi either.
> That implies adding FALLOC_FL_HUGEPAGE for pmem, and possibly
> FALLOC_FL_{SUNIT,SWIDTH} for users with RAIDs.

No, that's reading way too much into it. FALLOC_FL_ATOMIC would mean
"ensure preallocation is valid for RWF_ATOMIC based IO contrainsts",
nothing more, nothing less. This isn't -hardware specific-, it's
simply a flag to tell the filesystem to align file offsets to
physical storage constraints so the allocated space works works
appropriately for a specific IO API.

IOWs, it is little different from the FALLOC_FL_NOHIDE_STALE flag
for modifying fallocate() behaviour...

> > This doesn't require extent size hints at all. The filesystem can
> > query the bdev at mount time, store the min/max atomic write sizes,
> > and then use them for all requests that have _ATOMIC modifiers set
> > on them.
> > 
> > With iomap doing the same "get the atomic constraints from the bdev"
> > style lookups for per-IO file offset and size checking, I don't
> > think we actually need extent size hints or an on-disk flag to force
> > extent size hint alignment.
> > 
> > That doesn't mean extent size hints can't be used - it just means
> > that extent size hints have to be constrained to being aligned to
> > atomic IOs (e.g. extent size hint must be an integer multiple of the
> > max atomic IO size). This then acts as a modifier for _ATOMIC
> > context allocations, much like it is a modifier for normal
> > allocations now.
> 
> (One behavior change that comes with FORCEALIGN is that without it,
> extent size hints affect only the alignment of the file range mappings.
> With FORCEALIGN, the space allocation itself *and* the mapping are
> aligned.)
> 
> The one big downside of FORCEALIGN is that the extent size hint can
> become misaligned with the AWU (or pagetable) geometry if the fs is
> moved to a different computing environment.  I prefer not to couple the
> interface to the hardware because that leaves open the possibility for
> users to discover more use cases.

Sure, but this isn't really a "forced" alignment. This is a feature
that is providing "file offset is physically aligned to an
underlying hardware address space" instead of doing the normal thing
of abstracting file data away from the physical layout of the
storage.

If we can have user APIs that say "file data should be physically
aligned to storage" then we don't need on-disk flags to implement
this. Extent size hints could still be used to indicate the required
alignment, but we could also pull it straight from the hardware if
those aren't set. AFAICT only fallocate() and pwritev2() need these
flags for IO, but we could add a fadvise() command to set it on a
struct file, if mmap()/madvise is told to use hugepages we can use
PMD alignment rather than storage hardware alignment, etc.

IOWs actually having APIs that simply say "use physical offset
alignment" without actually saying exactly which hardware alignment
they want allows the filesystem to dynamically select the optimal
alignment for the given application use case rather than requiring
the admin to set up specific configuration at mkfs time....



> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >  fs/iomap/direct-io.c  | 26 ++++++++++++++++++++++++--
> > >  fs/iomap/trace.h      |  3 ++-
> > >  include/linux/iomap.h |  1 +
> > >  3 files changed, 27 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index bcd3f8cf5ea4..6ef25e26f1a1 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -275,10 +275,11 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > >  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  		struct iomap_dio *dio)
> > >  {
> > > +	bool atomic_write = iter->flags & IOMAP_ATOMIC_WRITE;
> > >  	const struct iomap *iomap = &iter->iomap;
> > >  	struct inode *inode = iter->inode;
> > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > -	loff_t length = iomap_length(iter);
> > > +	const loff_t length = iomap_length(iter);
> > >  	loff_t pos = iter->pos;
> > >  	blk_opf_t bio_opf;
> > >  	struct bio *bio;
> > > @@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > >  		return -EINVAL;
> > >  
> > > +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
> > > +		if (iomap->flags & IOMAP_F_DIRTY)
> > > +			return -EIO;
> > > +		if (iomap->type != IOMAP_MAPPED)
> > > +			return -EIO;
> > > +	}
> > 
> > How do we get here without space having been allocated for the
> > write?
> > 
> > Perhaps what this is trying to do is make RWF_ATOMIC only be valid
> > into written space? I mean, this will fail with preallocated space
> > (IOMAP_UNWRITTEN) even though we still have exactly the RWF_ATOMIC
> > all-or-nothing behaviour guaranteed after a crash because of journal
> > recovery behaviour. i.e. if the unwritten conversion gets written to
> > the journal, the data will be there. If it isn't written to the
> > journal, then the space remains unwritten and there's no data across
> > that entire range....
> > 
> > So I'm not really sure that either of these checks are valid or why
> > they are actually needed....
> 
> This requires O_DSYNC (or RWF_DSYNC) for atomic writes to unwritten or
> COW space.

COW, maybe - I haven't thought that far through it. 

However, for unwritten extents we just don't need O_DSYNC to
guarantee all or nothing writes. The application still has to use
fdatasync() to determine if the IO succeeded, but the actual IO and
unwritten conversion transaction ordering guarantee the
"all-or-nothing" behaviour of a RWF_ATOMIC write that is not using
O_DSYNC.

i.e.  It just doesn't matter when the conversion transaction hits
the journal. If it doesn't hit the journal before the crash, the
write never happened. If it does hit the journal, then the cache
flush before the journal write ensures all the data from the
RWF_ATOMIC write is present on disk before the unwritten conversion
hits the journal.

> We want failures in forcing the log transactions for the
> endio processing to be reported to the pwrite caller as EIO, right?

A failure to force the log will result in a filesystem shutdown. It
doesn't matter if that happens during IO completion or sometime
before or during the fdatasync() call the application would still
need to use to guarantee data integrity.

RWF_ATOMIC implies FUA semantics, right? i.e. if the RWF_ATOMIC
write is a pure overwrite, there are no journal or cache flushes
needed to complete the write. If so, batching up all the metadata
updates between data integrity checkpoints can still make
performance much better.  If the filesystem flushes the journal
itself, it's no different from an application crash recovery
perspective to using RWF_DSYNC|RWF_ATOMIC and failing in the middle
of a multi-IO update....

Hence I just don't see why RWF_ATOMIC requires O_DSYNC semantics at
all; all RWF_ATOMIC provides is larger "non-tearing" IO granularity
and this doesn't change filesystem data integrity semantics at all.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
