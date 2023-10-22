Return-Path: <linux-fsdevel+bounces-890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9297D2681
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 00:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BC4B20D3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E113FF3;
	Sun, 22 Oct 2023 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SH+0HitW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BC125BB
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:17:10 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6EFE9
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 15:17:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-578b407045bso2017700a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698013028; x=1698617828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5qQrL2DwxfK/+XEnN2k2KNh9W8QIN/h2ok2w3SXfSA=;
        b=SH+0HitWPrAVN0WUuf87jRHL1QGNn428VZwVUXzYDIcuzzkegANabhB1cKVfNGFBkg
         sZniBP+Jee9hZW5Nwzo1U8qENJ7ikh8sJAsOzDnslfj5lA/LvIOgvo9f15U3r0STuUCf
         mHIJgeQ57wG/PuF6mjwF/yT3GUnIyf/AvJf/sMTkVsccc5FT+0mk7XA5IiORmtBU5Zej
         UlFyiR6D4vgW8EPsC85GHuHRrFpDn2RNhQ179EViZWQc/Au/Cbk5VeRxWUIUuv9Cuq/i
         5EhF5pzMG6rIqrwg/+GBgZZtOSf9PHTgfXNZguRzGKZgXv7+U/yWk5plWVs+GLDNygkz
         RKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698013028; x=1698617828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5qQrL2DwxfK/+XEnN2k2KNh9W8QIN/h2ok2w3SXfSA=;
        b=mBbZobJx1bAslmqYvo2ErV9DRzTNIJ2GacQnZMNFSHAQ7Y2aoMVIFduKAuFVSgZ9ZC
         CdvSxHxhzl5v5pXpZiteQi6hBAPd/GhWRE/fQFmsATV13NB9bh64vaXwNFpratcaB9tE
         FCFiMW2pqJkIYNxFsjmglNLaunRP2a6SdRrX7hBteRPkMgpo/+h3EfrKYqBfAKYp2qPq
         TVsil28cqYvYPt+PbFCvmD5ElhrdglO/OSkiW1cKVaUwHtETDgWtUGTnynQ+WBcQ0b7h
         wVg4MQclhtkQ2OWnCC7NcjSJDiU/BBjSh9OLpkRMkbqjngtlzSz6fzftFi7eSLikEtIY
         ENjA==
X-Gm-Message-State: AOJu0YzKELXQTHhiQGXLNe13lV7vLfC28stqGkE4RH/FEPt+xhvR6Hc0
	ERaw5Z2rmp1KK1eIF4p4IkFPAw==
X-Google-Smtp-Source: AGHT+IHfrxpNDhrr8nxge8J1PnrlKWhoGEGeQp+3Fb8nhCoq3diC1hyvVYj6bL9aNKHIKZ200bYlJQ==
X-Received: by 2002:a17:902:e844:b0:1c6:25c3:13d3 with SMTP id t4-20020a170902e84400b001c625c313d3mr8502730plg.6.1698013027990;
        Sun, 22 Oct 2023 15:17:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902eb4d00b001c3e732b8dbsm4858229pli.168.2023.10.22.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 15:17:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qugkp-002cGd-32;
	Mon, 23 Oct 2023 09:17:03 +1100
Date: Mon, 23 Oct 2023 09:17:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZTWfX3CqPy9yCddQ@dread.disaster.area>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area>
 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>

On Fri, Oct 20, 2023 at 08:12:45AM -0400, Jeff Layton wrote:
> On Fri, 2023-10-20 at 09:02 +1100, Dave Chinner wrote:
> > On Thu, Oct 19, 2023 at 07:28:48AM -0400, Jeff Layton wrote:
> > > On Thu, 2023-10-19 at 11:29 +0200, Christian Brauner wrote:
> > > > > Back to your earlier point though:
> > > > > 
> > > > > Is a global offset really a non-starter? I can see about doing something
> > > > > per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> > > > > as ktime_get_coarse_ts64. I don't see the downside there for the non-
> > > > > multigrain filesystems to call that.
> > > > 
> > > > I have to say that this doesn't excite me. This whole thing feels a bit
> > > > hackish. I think that a change version is the way more sane way to go.
> > > > 
> > > 
> > > What is it about this set that feels so much more hackish to you? Most
> > > of this set is pretty similar to what we had to revert. Is it just the
> > > timekeeper changes? Why do you feel those are a problem?
> > > 
> > > > > 
> > > > > On another note: maybe I need to put this behind a Kconfig option
> > > > > initially too?
> > > > 
> > > > So can we for a second consider not introducing fine-grained timestamps
> > > > at all. We let NFSv3 live with the cache problem it's been living with
> > > > forever.
> > > > 
> > > > And for NFSv4 we actually do introduce a proper i_version for all
> > > > filesystems that matter to it.
> > > > 
> > > > What filesystems exactly don't expose a proper i_version and what does
> > > > prevent them from adding one or fixing it?
> > > 
> > > Certainly we can drop this series altogether if that's the consensus.
> > > 
> > > The main exportable filesystem that doesn't have a suitable change
> > > counter now is XFS. Fixing it will require an on-disk format change to
> > > accommodate a new version counter that doesn't increment on atime
> > > updates. This is something the XFS folks were specifically looking to
> > > avoid, but maybe that's the simpler option.
> > 
> > And now we have travelled the full circle.
> > 
> 
> LOL, yes!
> 
> > The problem NFS has with atime updates on XFS is a result of
> > the default behaviour of relatime - it *always* forces a persistent
> > atime update after mtime has changed. Hence a read-after-write
> > operation will trigger an atime update because atime is older than
> > mtime. This is what causes XFS to run a transaction (i.e. a
> > persistent atime update) and that bumps iversion.
> > 
> 
> Those particular atime updates are not a problem. If we're updating the
> mtime and ctime anyway, then bumping the change attribute is OK.
> 
> The problem is that relatime _also_ does an on-disk update once a day
> for just an atime update. On XFS, this means that the change attribute
> also gets bumped and the clients invalidate their caches all at once.
> 
> That doesn't sound like a big problem at first, but what if you're
> sharing a multi-gigabyte r/o file between multiple clients? This sort of
> thing is fairly common on render-farm workloads, and all of your clients
> will end up invalidating their caches once once a day if you're serving
> from XFS.

So we have noatime inode and mount options for such specialised
workloads that cannot tolerate cached ever being invalidated, yes?

> > lazytime does not behave this way - it delays all persistent
> > timestamp updates until the next persistent change or until the
> > lazytime aggregation period expires (24 hours). Hence with lazytime,
> > read-after-write operations do not trigger a persistent atime
> > update, and so XFS does not run a transaction to update atime. Hence
> > i_version does not get bumped, and NFS behaves as expected.
> > 
> 
> Similar problem here. Once a day, NFS clients will invalidate the cache
> on any static content served from XFS.

Lazytime has /proc/sys/vm/dirtytime_expire_seconds to change the
interval that triggers persistent time changes. That could easily be
configured to be longer than a day for workloads that care about
this sort of thing. Indeed, we could just set up timestamps that NFS
says "do not make persistent" to only be persisted when the inode is
removed from server memory rather than be timed out by background
writeback....

-----

All I'm suggesting is that rather than using mount options for
noatime-like behaviour for NFSD accesses, we actually have the nfsd
accesses say "we'd like pure atime updates without iversion, please".

Keep in mind that XFS does actually try to avoid bumping i_version
on pure timestamp updates - we carved that out a long time ago (see
the difference in XFS_ILOG_CORE vs XFS_ILOG_TIMESTAMP in
xfs_vn_update_time() and xfs_trans_log_inode()) so that we could
optimise fdatasync() to ignore timestamp updates that occur as a
result of pure data overwrites.

Hence XFS only bumps i_version for pure timestamp updates if the
iversion queried flag is set. IOWs, XFS it is actually doing exactly
what the VFS iversion implementation is telling it to do with
timestamp updates for non-core inode metadata updates.

That's the fundamental issue here: nfsd has set VFS state that tells
the filesystem to "bump iversion on next persistent inode change",
but the nfsd then runs operations that can change non-critical
persistent inode state in "query-only" operations. It then expects
filesystems to know that it should ignore the iversion queried state
within this context.  However, without external behavioural control
flags, filesystems cannot know that an isolated metadata update has
context specific iversion behavioural constraints.

Hence fixing this is purely a VFS/nfsd i_version implementation
problem - if the nfsd is running a querying operation, it should
tell the filesystem that it should ignore iversion query state. If
nothing the application level cache cares about is being changed
during the query operation, it should tell the filesystem to ignore
iversion query state because it is likely the nfsd query itself will
set it (or have already set it itself in the case of compound
operations).

This does not need XFS on-disk format changes to fix. This does not
need changes to timestamp infrastructure to fix. We just need the
nfsd application to tell us that we should ignore the vfs i_version
query state when we update non-core inode metadata within query
operation contexts.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

