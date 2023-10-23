Return-Path: <linux-fsdevel+bounces-967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77137D432F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 01:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A22281735
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 23:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127A24210;
	Mon, 23 Oct 2023 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xkP1Dwak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5024204
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 23:26:33 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA54D6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 16:26:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fb85afef4so3199391b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698103591; x=1698708391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Gux9V9VrIJG9Key4Kir8qGYfaDp/xU9ex2KP3eXys=;
        b=xkP1DwakmW2tHqe6HTIXjHePDfPnnKpC1IDOmDHfYMUyG/Eq2lT9idN9Ef8z7tpdNi
         TxgflPTKOf04PI0ONXMpfCKpZtNzGLNjlbctIakID0bLpGqjJp/SgentVqPuIBejZpVn
         EE+RaJC59adi7tTabh95D/t26ZhNFY4YOYOj/xkVe/wxgW2HlkRK6ipnqGUzTC/W05cY
         9Ra4J0t8lQwULEflPkMnk0IcOXv5eKo1oCWgq1s/kTBPNNfo6RbWF4PuD+U4nbCaFL+G
         4fZgYWNjcB4lKHB0+sd6Eg39LTkm7QDzbAlg/CVKo1l9WZnK+RGvfZxUt2mq1eBCqzC1
         zxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698103591; x=1698708391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Gux9V9VrIJG9Key4Kir8qGYfaDp/xU9ex2KP3eXys=;
        b=BHBxYNWTa+Azrr6KY20dJWcrGJFevPdPcgxwRTDUsEAmteNpTzqVw26OzstcVohFbX
         Xncnah9vGwa2aljWPZI7yJ75faRwqx9ZFsf7yiguPObbkPOgz+IktepTwW+D/qB58OoR
         K5cPIgyNggerMX2jt0P7XzJ1sUrG4g6szphDpmpninHLu0/yeOvDH7ffRZFMHbmE2821
         1uNSd5uElrprIDokBM7/pEibbAVQW0KG64O+PqldWBdH+N9KaH2fltpMuJpXfyI/ZlqK
         Q3r3lVM0l0dh2hxSZgKwKFbzPt/f/NrcKATY2v013rXE47mBHmhceif56vgQAJnFBB3x
         ZBsQ==
X-Gm-Message-State: AOJu0Yxc+J23sZgrqHakYe/8g+fhNsxVVu0JA57n4sKWfYP/9Hooq1l5
	xBkjBEPYRzsimYZMSwizWK9zsw==
X-Google-Smtp-Source: AGHT+IFbvK8ZgyXM/nA60wNancq6H/LuRCiF/m3G0/gTTq4ADSx4A3l6pnfh9u5eBcKsHipLBdZx2g==
X-Received: by 2002:a05:6a00:18a9:b0:692:780a:de90 with SMTP id x41-20020a056a0018a900b00692780ade90mr9935913pfh.30.1698103590604;
        Mon, 23 Oct 2023 16:26:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b006bee5ad4efasm6715066pfn.67.2023.10.23.16.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 16:26:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qv4JX-0034Zl-06;
	Tue, 24 Oct 2023 10:26:27 +1100
Date: Tue, 24 Oct 2023 10:26:27 +1100
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
Message-ID: <ZTcBI2xaZz1GdMjX@dread.disaster.area>
References: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
 <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area>
 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>

On Mon, Oct 23, 2023 at 10:45:21AM -0400, Jeff Layton wrote:
> On Mon, 2023-10-23 at 09:17 +1100, Dave Chinner wrote:
> > All I'm suggesting is that rather than using mount options for
> > noatime-like behaviour for NFSD accesses, we actually have the nfsd
> > accesses say "we'd like pure atime updates without iversion, please".
> > 
> > Keep in mind that XFS does actually try to avoid bumping i_version
> > on pure timestamp updates - we carved that out a long time ago (see
> > the difference in XFS_ILOG_CORE vs XFS_ILOG_TIMESTAMP in
> > xfs_vn_update_time() and xfs_trans_log_inode()) so that we could
> > optimise fdatasync() to ignore timestamp updates that occur as a
> > result of pure data overwrites.
> > 
> > Hence XFS only bumps i_version for pure timestamp updates if the
> > iversion queried flag is set. IOWs, XFS it is actually doing exactly
> > what the VFS iversion implementation is telling it to do with
> > timestamp updates for non-core inode metadata updates.
> > 
> > That's the fundamental issue here: nfsd has set VFS state that tells
> > the filesystem to "bump iversion on next persistent inode change",
> > but the nfsd then runs operations that can change non-critical
> > persistent inode state in "query-only" operations. It then expects
> > filesystems to know that it should ignore the iversion queried state
> > within this context.  However, without external behavioural control
> > flags, filesystems cannot know that an isolated metadata update has
> > context specific iversion behavioural constraints.
> 
> > Hence fixing this is purely a VFS/nfsd i_version implementation
> > problem - if the nfsd is running a querying operation, it should
> > tell the filesystem that it should ignore iversion query state. If
> > nothing the application level cache cares about is being changed
> > during the query operation, it should tell the filesystem to ignore
> > iversion query state because it is likely the nfsd query itself will
> > set it (or have already set it itself in the case of compound
> > operations).
> > 
> > This does not need XFS on-disk format changes to fix. This does not
> > need changes to timestamp infrastructure to fix. We just need the
> > nfsd application to tell us that we should ignore the vfs i_version
> > query state when we update non-core inode metadata within query
> > operation contexts.
> > 
> 
> I think you're missing the point of the problem I'm trying to solve.
> I'm not necessarily trying to guard nfsd against its own accesses. The
> reads that trigger an eventual atime update could come from anywhere --
> nfsd, userland accesses, etc.
>
> If you are serving an XFS filesystem, with the (default) relatime mount
> option, then you are guaranteed that the clients will invalidate their
> cache of a file once per day, assuming that at least one read was issued
> against the file during that day.
>
> That read will cause an eventual atime bump to be logged, at which point
> the change attribute will change. The client will then assume that it
> needs to invalidate its cache when it sees that change.
>
> Changing how nfsd does its own accesses won't fix anything, because the
> problematic atime bump can come from any sort of read access.

I'm not missing the point at all - as I've said in the past I don't
think local vs remote access is in any way relevant to the original
problem that needs to be solved. If the local access is within the
relatime window, it won't cause any persistent metadata change at
all. If it's outside the window, then it's no different to the NFS
client reading data from the server outside the window. If it's the
first access after a NFS client side modification, then it's just
really bad timing but it isn't likely to be a common issue.

Hence I just don't think it matters on bit, and we can address the
24 hour problem separately to the original problem that still needs
to be fixed.

The problem is the first read request after a modification has been
made. That is causing relatime to see mtime > atime and triggering
an atime update. XFS sees this, does an atime update, and in
committing that persistent inode metadata update, it calls
inode_maybe_inc_iversion(force = false) to check if an iversion
update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
i_version and tells XFS to persist it.

IOWs, XFS is doing exactly what the VFS is telling it to do with
i_version during the persistent inode metadata update that the VFS
told it to make.

This, however, is not the semantics that the *nfsd application*
wants. It does not want i_version to be updated when it is running a
data read operation despite the fact the VFS is telling the
filesystem it needs to be updated.

What we need to know is when the inode is being accessed by the nfsd
so we can change the in-memory timestamp update behaviour
appropriately.  We really don't need on-disk format changes - we
just need to know that we're supposed to do something special with
pure timestamp updates because i_version needs to be behave in a
manner compatible with the new NFS requirements....

We also don't need generic timestamp infrastructure changes to do
this - the multi-grained timestamp was a neat idea for generic
filesystem support of the nfsd i_version requirements, but it's
collapsed under the weight of complexity.

There are simpler ways individual filesystems can do the right
thing, but to do that we need to know that nfsd has actively
referenced the inode. How we get that information is what I want to
resolve, the filesystem should be able to handle everything else in
memory....

Perhaps we can extract I_VERSION_QUERIED as a proxy for nfsd
activity on the inode rather than need a per-operation context? Is
that going to be reliable enough? Will that cause problems for other
applications that want to use i_version for their own purposes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

