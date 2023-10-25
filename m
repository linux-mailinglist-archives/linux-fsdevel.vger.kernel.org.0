Return-Path: <linux-fsdevel+bounces-1134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B227D6476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 10:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A9C281CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E21C695;
	Wed, 25 Oct 2023 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="UTs0M7R4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1831C686
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 08:05:33 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D426B0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 01:05:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1caa371dcd8so36927805ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698221129; x=1698825929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TiIdV9I/vN4NVgu/NUA15BW6zhATVMOiHC4HTyzCHqs=;
        b=UTs0M7R4wts9o/uquvfK3s87E+x3YjsG+KRYaaleO19rL51Hsc3RU5x/Cx26E39mtm
         +txrFU+WF9mLa+9lIHh7GCDa6HBeq1xSTOfbUi62fMKjXS8zbAqvQbovWtIILHXJW4d0
         OjHtl42hpD5DgoAMUT1hTkwUl0N0lfbdwxZKyTP3O6HoDRtNjchLhRzGPNVmCr9AooUR
         2cprVGjIbLbyaHEajJAr4ee6EfGgmPRM92IvS356y1DEpzIxnKTqhyvbnLYeYVTWXxHN
         fAtr1cOIIppydKRBLQEJkTry01jqq3OopwEv7qYSnPgul7HXfNzmGgOPyI3m4V2Pzpey
         jPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221129; x=1698825929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiIdV9I/vN4NVgu/NUA15BW6zhATVMOiHC4HTyzCHqs=;
        b=RjnlIBqs3SVuGwcsGR/5272n5KXU8RkYEL9Bg/uVbl4b/SurmHHZ9MIhtJnxnbABcJ
         DuEYK+awa3hBb1j/DrDfmUXv/ec2CYLnKQXgT03XBH87A7KW9qIsG+SZLFlADrvE6QwY
         cFhw3TZ15A5wQDvZSS16Dp/MJ87G1d+Dg/Cp8FZIe/PZQkrEMr5ZDLVx4YiHI/zqFaIb
         uRF5/8CBR8STgbOfUNvQeKI2pl1413peDE13qN7E+w1SQENf8wNGWVtyoVOpsAh1ftBB
         NtFX0KJbU+l8PZ+vt8BkiRFxYog/2JUHgo5HQ+yebH1iwdEOQPzoAukEVXdGOtXhcgu2
         96mw==
X-Gm-Message-State: AOJu0YzzYhr3F9oPfKdhpuxzNjm2X0jlQy4UA/M5VUSeS7wgbbeGmqXO
	GWhm/oYolA3FpyWEwjMzxkZWzA==
X-Google-Smtp-Source: AGHT+IF43YsoxJyfCmigF2ByrRCajkxHiglXcP/PVFXGzk0/EIpOE4fGDG8KrZpVCFCUqgg1CO+/2g==
X-Received: by 2002:a17:902:f7cd:b0:1c6:30d1:7214 with SMTP id h13-20020a170902f7cd00b001c630d17214mr11982619plw.55.1698221129506;
        Wed, 25 Oct 2023 01:05:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001c61901ed2esm8529452plf.219.2023.10.25.01.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:05:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qvYtJ-003fEw-0V;
	Wed, 25 Oct 2023 19:05:25 +1100
Date: Wed, 25 Oct 2023 19:05:25 +1100
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
Message-ID: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
References: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area>
 <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area>
 <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>

On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > On Tue, Oct 24, 2023 at 6:40 AM Dave Chinner <david@fromorbit.com> wrote:
> > > 
> > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> > > > > 
> > > > > The problem is the first read request after a modification has been
> > > > > made. That is causing relatime to see mtime > atime and triggering
> > > > > an atime update. XFS sees this, does an atime update, and in
> > > > > committing that persistent inode metadata update, it calls
> > > > > inode_maybe_inc_iversion(force = false) to check if an iversion
> > > > > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> > > > > i_version and tells XFS to persist it.
> > > > 
> > > > Could we perhaps just have a mode where we don't increment i_version
> > > > for just atime updates?
> > > > 
> > > > Maybe we don't even need a mode, and could just decide that atime
> > > > updates aren't i_version updates at all?
> > > 
> > > We do that already - in memory atime updates don't bump i_version at
> > > all. The issue is the rare persistent atime update requests that
> > > still happen - they are the ones that trigger an i_version bump on
> > > XFS, and one of the relatime heuristics tickle this specific issue.
> > > 
> > > If we push the problematic persistent atime updates to be in-memory
> > > updates only, then the whole problem with i_version goes away....
> > > 
> > > > Yes, yes, it's obviously technically a "inode modification", but does
> > > > anybody actually *want* atime updates with no actual other changes to
> > > > be version events?
> > > 
> > > Well, yes, there was. That's why we defined i_version in the on disk
> > > format this way well over a decade ago. It was part of some deep
> > > dark magical HSM beans that allowed the application to combine
> > > multiple scans for different inode metadata changes into a single
> > > pass. atime changes was one of the things it needed to know about
> > > for tiering and space scavenging purposes....
> > > 
> > 
> > But if this is such an ancient mystical program, why do we have to
> > keep this XFS behavior in the present?
> > BTW, is this the same HSM whose DMAPI ioctls were deprecated
> > a few years back?

Drop the attitude, Amir.

That "ancient mystical program" is this:

https://buy.hpe.com/us/en/enterprise-solutions/high-performance-computing-solutions/high-performance-computing-storage-solutions/hpc-storage-solutions/hpe-data-management-framework-7/p/1010144088

Yup, that product is backed by a proprietary descendent of the Irix
XFS code base XFS that is DMAPI enabled and still in use today. It's
called HPE XFS these days....

> > I mean, I understand that you do not want to change the behavior of
> > i_version update without an opt-in config or mount option - let the distro
> > make that choice.
> > But calling this an "on-disk format change" is a very long stretch.

Telling the person who created, defined and implemented the on disk
format that they don't know what constitutes a change of that
on-disk format seems kinda Dunning-Kruger to me....

There are *lots* of ways that di_changecount is now incompatible
with the VFS change counter. That's now defined as "i_version should
only change when [cm]time is changed".

di_changecount is defined to be a count of the number of changes
made to the attributes of the inode.  It's not just atime at issue
here - we bump di_changecount when make any inode change, including
background work that does not otherwise change timestamps. e.g.
allocation at writeback time, unwritten extent conversion, on-disk
EOF extension at IO completion, removal of speculative
pre-allocation beyond EOF, etc.

IOWs, di_changecount was never defined as a linux "i_version"
counter, regardless of the fact we originally we able to implement
i_version with it - all extra bumps to di_changecount were not
important to the users of i_version for about a decade.

Unfortunately, the new i_version definition is very much
incompatible with the existing di_changecount definition and that's
the underlying problem here. i.e. the problem is not that we bump
i_version on atime, it's that di_changecount is now completely
incompatible with the new i_version change semantics.

To implement the new i_version semantics exactly, we need to add a
new field to the inode to hold this information.
If we change the on disk format like this, then the atime
problems go away because the new field would not get updated on
atime updates. We'd still be bumping di_changecount on atime
updates, though, because that's what is required by the on-disk
format.

I'm really trying to avoid changing the on-disk format unless it
is absolutely necessary. If we can get the in-memory timestamp
updates to avoid tripping di_changecount updates then the atime
problems go away.

If we can get [cm]time sufficiently fine grained that we don't need
i_version, then we can turn off i_version in XFS and di_changecount
ends up being entirely internal. That's what was attempted with
generic multi-grain timestamps, but that hasn't worked.

Another options is for XFS to play it's own internal tricks with
[cm]time granularity and turn off i_version. e.g. limit external
timestamp visibility to 1us and use the remaining dozen bits of the
ns field to hold a change counter for updates within a single coarse
timer tick. This guarantees the timestamp changes within a coarse
tick for the purposes of change detection, but we don't expose those
bits to applications so applications that compare timestamps across
inodes won't get things back to front like was happening with the
multi-grain timestamps....

Another option is to work around the visible symptoms of the
semantic mismatch between i_version and di_changecount. The only
visible symptom we currently know about is the atime vs i_version
issue.  If people are happy for us to simply ignore VFS atime
guidelines (i.e. ignore realtime/lazytime) and do completely our own
stuff with timestamp update deferal, then that also solve the
immediate issues.

> > Does xfs_repair guarantee that changes of atime, or any inode changes
> > for that matter, update i_version? No, it does not.
> > So IMO, "atime does not update i_version" is not an "on-disk format change",
> > it is a runtime behavior change, just like lazytime is.
> 
> This would certainly be my preference. I don't want to break any
> existing users though.

That's why I'm trying to get some kind of consensus on what
rules and/or atime configurations people are happy for me to break
to make it look to users like there's a viable working change
attribute being supplied by XFS without needing to change the on
disk format.

> Perhaps this ought to be a mkfs option? Existing XFS filesystems could
> still behave with the legacy behavior, but we could make mkfs.xfs build
> filesystems by default that work like NFS requires.

If we require mkfs to set a flag to change behaviour, then we're
talking about making an explicit on-disk format change to select the
optional behaviour. That's precisely what I want to avoid.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

