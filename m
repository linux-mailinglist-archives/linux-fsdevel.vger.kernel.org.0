Return-Path: <linux-fsdevel+bounces-1670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE737DD7F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 22:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CE7281854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7970F25103;
	Tue, 31 Oct 2023 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qbV2S0Bv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED7225AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 21:57:15 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B345CEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:57:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc4f777ab9so22015405ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698789433; x=1699394233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=szCh9307i2q1DFMEAhnIkYTKF2f+hTgpp2GiWPKJePA=;
        b=qbV2S0BvS5OJtw1knseZ3+RWzq9rli3rTM5FOMeAqxRtbm4ykQVx5RdUPBv+SnjoMq
         F6+LS5ZaRacc02BUrWZlrC6zGwxp+WW9vVK760yrCJcbg/T0bqXdMedEAJ9BJvC5fxhO
         jqjOlr7ALjPAJp+RvruUhI5YhrW8bJxHM5UW06DHuqv2f6hszkTeYgE5yaBKucBfRy3S
         lRejziOkgd1n4W+Lq/1l3pt1kuB1DTzuhkgWYyrhsDoqBKrXGbkvsejt5JsXwrxrRz9t
         XhIBBHt0MH2mmRaz5c6IRvqvVgaHn1eWFdjUS2XF9pL4xBjjlqmaUTiLW34kx+wEdmqF
         e4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698789433; x=1699394233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szCh9307i2q1DFMEAhnIkYTKF2f+hTgpp2GiWPKJePA=;
        b=Gzg+5hm5uDtNY/QbRtyxWqvLKbK0xuBBdTGNgo6GhloN0q47qiYjO6LJn7OvAg9Zt2
         +L0UqAVe4dylGKIc/Nsr4euVFdByeNlMwjQthb/Z66j2HmvYmMLXrkZEG+9ObtF8/Bc/
         Mn0RX5Yq/JOreaKDHPsD2Lv/9Fgk+VeA+uwDKcCm9g+XrVUUeKws4yOFNk0gZxdUXDXI
         8mzNLJpVMJNj5TIdYLCm4vsjlPdWZa7+x7ZWvb5mMFgcMH3DyhXKcl9c3DpF3Ob9ubRu
         SsITFroVWi6Ni220LA21esGH5aP/PNmvJfU8ChLgKDx9U67u1aROQ9mrfHEHlbxveIc/
         gaAw==
X-Gm-Message-State: AOJu0Yz3y5zo6qV2xwsJ3HZZDNb8f5WGG4j/9vL1+excWPb2LOqvlamd
	4ckgZLrTuaddg318fjlIMH+nmg==
X-Google-Smtp-Source: AGHT+IEkdz6VInz9I9z6HedqDhMWdU2akY7SrGm7m+57Hg4ynyS4hcELCgq1vLnV4gtcsSVabmIrSQ==
X-Received: by 2002:a05:6a20:7f97:b0:16b:9b5d:155d with SMTP id d23-20020a056a207f9700b0016b9b5d155dmr14636989pzj.30.1698789433008;
        Tue, 31 Oct 2023 14:57:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id q14-20020a056a0002ae00b0069023d80e63sm97894pfs.25.2023.10.31.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 14:57:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qxwjV-006Wsq-0G;
	Wed, 01 Nov 2023 08:57:09 +1100
Date: Wed, 1 Nov 2023 08:57:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZUF4NTxQXpkJADxf@dread.disaster.area>
References: <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>

On Tue, Oct 31, 2023 at 07:29:18AM -0400, Jeff Layton wrote:
> On Tue, 2023-10-31 at 09:03 +0200, Amir Goldstein wrote:
> > On Tue, Oct 31, 2023 at 3:42 AM Dave Chinner <david@fromorbit.com> wrote:
> > > 
> > [...]
> > > .... and what is annoying is that that the new i_version just a
> > > glorified ctime change counter. What we should be fixing is ctime -
> > > integrating this change counting into ctime would allow us to make
> > > i_version go away entirely. i.e. We don't need a persistent ctime
> > > change counter if the ctime has sufficient resolution or persistent
> > > encoding that it does not need an external persistent change
> > > counter.
> > > 
> > > That was reasoning behind the multi-grain timestamps. While the mgts
> > > implementation was flawed, the reasoning behind it certainly isn't.
> > > We should be trying to get rid of i_version by integrating it into
> > > ctime updates, not arguing how atime vs i_version should work.
> > > 
> > > > So I don't think the issue here is "i_version" per se. I think in a
> > > > vacuum, the best option of i_version is pretty obvious.  But if you
> > > > want i_version to track di_changecount, *then* you end up with that
> > > > situation where the persistence of atime matters, and i_version needs
> > > > to update whenever a (persistent) atime update happens.
> > > 
> > > Yet I don't want i_version to track di_changecount.
> > > 
> > > I want to *stop supporting i_version altogether* in XFS.
> > > 
> > > I want i_version as filesystem internal metadata to die completely.
> > > 
> > > I don't want to change the on disk format to add a new i_version
> > > field because we'll be straight back in this same siutation when the
> > > next i_version bug is found and semantics get changed yet again.
> > > 
> > > Hence if we can encode the necessary change attributes into ctime,
> > > we can drop VFS i_version support altogether.  Then the "atime bumps
> > > i_version" problem also goes away because then we *don't use
> > > i_version*.
> > > 
> > > But if we can't get the VFS to do this with ctime, at least we have
> > > the abstractions available to us (i.e. timestamp granularity and
> > > statx change cookie) to allow XFS to implement this sort of
> > > ctime-with-integrated-change-counter internally to the filesystem
> > > and be able to drop i_version support....
> > > 
> > 
> > I don't know if it was mentioned before in one of the many threads,
> > but there is another benefit of ctime-with-integrated-change-counter
> > approach - it is the ability to extend the solution with some adaptations
> > also to mtime.
> > 
> > The "change cookie" is used to know if inode metadata cache should
> > be invalidated and mtime is often used to know if data cache should
> > be invalidated, or if data comparison could be skipped (e.g. rsync).
> > 
> > The difference is that mtime can be set by user, so using lower nsec
> > bits for modification counter would require to truncate the user set
> > time granularity to 100ns - that is probably acceptable, but only as
> > an opt-in behavior.
> > 
> > The special value 0 for mtime-change-counter could be reserved for
> > mtime that was set by the user or for upgrade of existing inode,
> > where 0 counter means that mtime cannot be trusted as an accurate
> > data modification-cookie.
> > 
> > This feature is going to be useful for the vfs HSM implementation [1]
> > that I am working on and it actually rhymes with the XFS DMAPI
> > patches that were never fully merged upstream.
> > 
> > Speaking on behalf of my employer, we would love to see the data
> > modification-cookie feature implemented, whether in vfs or in xfs.
> > 
> > *IF* the result on this thread is that the chosen solution is
> > ctime-with-change-counter in XFS
> > *AND* if there is agreement among XFS developers to extend it with
> > an opt-in mkfs/mount option to 100ns-mtime-with-change-counter in XFS
> > *THEN* I think I will be able to allocate resources to drive this xfs work.
> > 
> > Thanks,
> > Amir.
> > 
> > [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API
> 
> I agree with Christian that if you can do this inside of XFS altogether,
> then that's a preferable solution. I don't quite understand how ctime-
> with-change-counter is intended to work however, so I'll have to reserve
> judgement there.

Yeah, this is pretty straight forward to do in XFS, I think. We were
talking about it on #xfs yesterday afternoon, and it all we really
need to do is this:

1. remove SB_I_VERSION from the superblock.

	Now nothing external to the filesystem will access
	inode->i_version  - it's value is undefined for external
	access and cannot be used for any purpose except filesystem
	internal information.

2. Set sb->s_time_gran to a power of 2 between 2^10 and 2^20 (TBD).

	This now gives the timestamp granularity that we expose to
	the VFS and userspace of 1us to 1ms. It gives us the lower
	10-20 bits for the persistent timestamp change counter to be
	encoded into for on-disk storage and change attribute
	cookies.

	Using the s_time_gran field like this with an external
	change counter means nothing in the VFS is aware that we
	store more information in the timestamp fields on disk.
	Everything should just work as it currently does (e.g.
	timestamp comparisons).

	It also means userspace never sees this internal change
	counter and so all the problems with incremental changes to
	timestamps within a timer tick across multiple files (i.e.
	the mgts problem) don't occur with this setup.

3. Every time the timestamp is touched and the timestamp doesn't
change, we bump inode->i_version. If the timestamp changes, then we
zero inode->i_version.

	THis gives us a per-coarse-timer-tick change counter. When
	the timestamp itself changes, we reset the change counter
	because the high bits in the timestamp have changed and that
	prevents the change coutner from wrapping arbitrarily and
	any on-disk timestamp from going backwards due to change
	counter overflow.

4. When statx asks for the change attribute, we copy the timestamp
into it and fold in the current change counter value.

	This provides the uniqueness that is required for the change
	counter.

5. When-ever the inode is persisted, the timestamp is copied to the
on-disk structure and the current change counter is folded in.

	This means the on-disk structure always contains the latest
	change attribute that has been persisted, just like we
	currently do with i_version now.

6. When-ever we read the inode off disk, we split the change counter
from the timestamp and update the appropriate internal structures
with this information.

	This ensures that the VFS and userspace never see the change
	counter implementation in the inode timestamps.

7. We need to be able to override inode_needs_update_time()
behaviour, as it will skip timestamp updates if timestamps are
equal.

	When timestamps are equal in this case, we need to bump the
	change counter rather than "do nothing". Hence we need
	different logic here, or a new method to be provided so the
	filesystem can decide how/when timestamps get updated.


This last piece of the puzzle is the problematic one.

Ideally, I'd like to see the ->update_time() code path be inverted.
Instead of only being called at the bottom once the VFS has decided
what timestamps need to be changed, it gets called directly from the
high level timestamp modification code and uses VFS helpers to
determine if updates are needed. 

e.g. the current code flow for an atime update is:

touch_atime()
  atime_needs_update()
  <freeze/write protection>
  inode_update_time(S_ATIME)
    ->update_time(S_ATIME)
      <filesystem atime update>

I'd much prefer this to be:

touch_atime()
  if (->update_time(S_ATIME)) {
    ->update_time(S_ATIME)
      xfs_inode_update_time(S_ATIME)
        if (atime_needs_update())
	  <filesystem atime update>
  } else {
    /* run the existing code */
  }

Similarly we'd turn file_modified()/file_update_time() inside out,
and this then allows the filesystem to add custom timestamp update
checks alongside the VFS timestamp update checks.

It would also enable us to untangle the mess that is lazytime, where
we have to implement ->update_time to catch lazytime updates and
punt them back to generic_update_time(), which then has to check for
lazytime again to determine how to dirty and queue the inode.
Of course, generic_update_time() also does timespec_equal checks on
timestamps to determine if times should be updated, and so we'd
probably need overrides on that, too.

Sorting the lazytime mess for internal change counters really needs
for all the timestamp updates to be handled in the filesystem, not
bounced back and forward between the filesystem and VFS helpers as
it currently is, hence I think we need to rework ->update_time to
make this all work cleanly.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

