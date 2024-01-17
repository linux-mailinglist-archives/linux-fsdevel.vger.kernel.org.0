Return-Path: <linux-fsdevel+bounces-8205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F2830F2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 23:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CDA1C23CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4098288D7;
	Wed, 17 Jan 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OK+yHujq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406A286B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530380; cv=none; b=XxJpDApKl20X575uYsApYjO/hVyxv7Ug04xZaSM4fc8fwFiSTTjfNyyg2FqZDVXKf043tLtd6xP3ZH6aAJBjmvppGuQ4jaSzhu/njhzjoG1uVv32P2O8vcBRQuggOfhQt/4L5ohpoDtzUNMKssJtqBUliwa7LLbxVH9cgAh4M5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530380; c=relaxed/simple;
	bh=fbGRpFNzjDJ58+XoKzZOb69zWNASCmMS9ecNHaJmtZM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=sVj7WIA52Ksj7MLeTrRqhGQh8RlrrwLP1SbrzLnw25zESl3pv75brH2L7qg25J2Vabr6gn4RkVRtx6I4pvYtFWVPmZdMYapd7rWnLUImVNoQNrWE8xIWp8ufIvXTbi+IW6cTQb4RKbpmXgCkWskwtz2c8QpLFmW8ysndT9kkhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OK+yHujq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso14101015ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 14:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705530378; x=1706135178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z/hRTX+MQ2pZDmJRifmLI1vSLH0o1ZgpBqyx2XxHN0=;
        b=OK+yHujqwR+5rXMuqSWZM/qUzQETYTMp8HCziT/DL6fg2mc+6RDZjj7Rr0iy+dq1jj
         RIY7KRzuO46OK6o5aMOsiuJUjH1255J8DEVyuYgwnxQhfGgQSo2yC/WZnLS6cyQ4GtZi
         ux51+yFDrzu5rsBdktdpMLGoj9W+p17H8yjyptljENOisvCOTCn+fho5pUI0q0CdkJW3
         bjVsCz7+8YYcIRUvJuAcrw5aM2DGUM60paMguWVgDC8dTVGJxF7srZSssr2x9YL2rZd9
         ggiupD456xhtbuLyCpZO8apf5lZfnqo6uQOeDZ83UXfWOMyJJSEx9EJ8TYWJgfQ7XxXL
         /GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705530378; x=1706135178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z/hRTX+MQ2pZDmJRifmLI1vSLH0o1ZgpBqyx2XxHN0=;
        b=CKVDaR7g2dOL7W+vzNfj9BCJEZB/9W4iIvfki0B/IXHdHOyNc1J4AV2DgWqc0mmNMC
         2aUXYncFfP1Ihbtpo7RCN/rPlgc5cK+ns2fNA8LWU6WPaO+KVxJQ9ipPWp+ElpcA2OPI
         jsfooV0I7F8a9Km9Ujs7kD3OJXhlHAaxZinfBcdjbEPrQzjx2O4yc8AzQg1g0VkNtRLI
         0t76xyTEq58MVcRq/kd4zysuHbPgeMfNp1O+NoEuMKvFLxpPTUZ3/3ESmPt+Ay81WkO1
         F1AdTZFfa0gEhKDBLF/m+YPfAgfTr8+L15Ep0He7cLyvvPZvaqu/KeJsY5PkMHopDYvR
         Bk3w==
X-Gm-Message-State: AOJu0YzowALW/IJNZpgUSIJ0XlmgPaK0eVJzrGHMCnT82Vya2udbPqDt
	PfwQeW0QwTRPHnkWJVgtahhOLhBk8jee1w==
X-Google-Smtp-Source: AGHT+IHXfhiJO0uOdn4WriD5J2oZVP6Jq3kTbXvHM9B9awAtkN42CQFn1wuH4PYtyXhbASYEzOE6mQ==
X-Received: by 2002:a17:902:db03:b0:1d6:f9a8:532d with SMTP id m3-20020a170902db0300b001d6f9a8532dmr1083027plx.107.1705530378063;
        Wed, 17 Jan 2024 14:26:18 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b001d5e5836292sm139483plo.130.2024.01.17.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 14:26:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rQEMR-00BlDA-00;
	Thu, 18 Jan 2024 09:26:15 +1100
Date: Thu, 18 Jan 2024 09:26:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	adrianvovk@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <ZahUBkqYad0Lb3/V@dread.disaster.area>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <ZabtYQqakvxJVYjM@dread.disaster.area>
 <20240117-yuppie-unflexibel-dbbb281cb948@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117-yuppie-unflexibel-dbbb281cb948@brauner>

On Wed, Jan 17, 2024 at 02:19:43PM +0100, Christian Brauner wrote:
> On Wed, Jan 17, 2024 at 07:56:01AM +1100, Dave Chinner wrote:
> > On Tue, Jan 16, 2024 at 11:50:32AM +0100, Christian Brauner wrote:
> > > Hey,
> > > 
> > > I'm not sure this even needs a full LSFMM discussion but since I
> > > currently don't have time to work on the patch I may as well submit it.
> > > 
> > > Gnome recently got awared 1M Euro by the Sovereign Tech Fund (STF). The
> > > STF was created by the German government to fund public infrastructure:
> > > 
> > > "The Sovereign Tech Fund supports the development, improvement and
> > >  maintenance of open digital infrastructure. Our goal is to sustainably
> > >  strengthen the open source ecosystem. We focus on security, resilience,
> > >  technological diversity, and the people behind the code." (cf. [1])
> > > 
> > > Gnome has proposed various specific projects including integrating
> > > systemd-homed with Gnome. Systemd-homed provides various features and if
> > > you're interested in details then you might find it useful to read [2].
> > > It makes use of various new VFS and fs specific developments over the
> > > last years.
> > > 
> > > One feature is encrypting the home directory via LUKS. An approriate
> > > image or device must contain a GPT partition table. Currently there's
> > > only one partition which is a LUKS2 volume. Inside that LUKS2 volume is
> > > a Linux filesystem. Currently supported are btrfs (see [4] though),
> > > ext4, and xfs.
> > > 
> > > The following issue isn't specific to systemd-homed. Gnome wants to be
> > > able to support locking encrypted home directories. For example, when
> > > the laptop is suspended. To do this the luksSuspend command can be used.
> > > 
> > > The luksSuspend call is nothing else than a device mapper ioctl to
> > > suspend the block device and it's owning superblock/filesystem. Which in
> > > turn is nothing but a freeze initiated from the block layer:
> > > 
> > > dm_suspend()
> > > -> __dm_suspend()
> > >    -> lock_fs()
> > >       -> bdev_freeze()
> > > 
> > > So when we say luksSuspend we really mean block layer initiated freeze.
> > > The overall goal or expectation of userspace is that after a luksSuspend
> > > call all sensitive material has been evicted from relevant caches to
> > > harden against various attacks. And luksSuspend does wipe the encryption
> > > key and suspend the block device. However, the encryption key can still
> > > be available clear-text in the page cache.
> > 
> > The wiping of secrets is completely orthogonal to the freezing of
> > the device and filesystem - the freeze does not need to occur to
> > allow the encryption keys and decrypted data to be purged. They
> > should not be conflated; purging needs to be a completely separate
> > operation that can be run regardless of device/fs freeze status.
> 
> Yes, I'm aware. I didn't mean to imply that these things are in any way
> necessarily connected. Just that there are use-cases where they are. And
> the encrypted home directory case is one. One froze the block device and
> filesystem one would now also like to drop the page cache which has most
> of the interesting data.
> 
> The fact that after a block layer initiated freeze - again mostly a
> device mapper problem - one may or may not be able to successfully read
> from the filesystem is annoying. Of course one can't write, that will
> hang one immediately. But if one still has some data in the page cache
> one can still dump the contents of that file. That's at least odd
> behavior from a users POV even if for us it's cleary why that's the
> case.

A frozen filesystem doesn't prevent read operations from occurring.

> And a freeze does do a sync_filesystem() and a sync_blockdev() to flush
> out any dirty data for that specific filesystem.

Yes, it's required to do that - the whole point of freezing a
filesystem is to bring the filesystem into a *consistent physical
state on persistent storage* and to hold it in that state until it
is thawed.

> So it would be fitting
> to give users an api that allows them to also drop the page cache
> contents.

Not as part of a freeze operation.

Read operations have *always* been allowed from frozen filesystems;
they are intended to be allowed because one of the use cases for
freezing is to create a consistent filesystem state for backup of
the filesystem. That requires everything in the filesystem can be
read whilst it is frozen, and that means the page cache needs to
remain operational.

What the underlying device allows when it has been *suspended* is a
different issue altogether. The key observation here is that storage
device suspend != filesystem freeze and they can have very different
semantics depending on the operation being performed on the block
device while it is suspended.

IOWs, a device suspend implementation might freeze the filesystem to
bring the contents of the storage device whilst frozen into a
consistent, uptodate state (e.g. for device level backups), but
block device level suspend does not *require* that the filesystem is
frozen whilst the device IO operations are suspended.

> For some use-cases like the Gnome use-case one wants to do a freeze and
> drop everything that one can from the page cache for that specific
> filesystem.

So they have to do an extra system call between FS_IOC_FREEZE and
FS_IOC_THAW. What's the problem with that? What are you trying to
optimise by colliding cache purging with FS_IOC_FREEZE?

If the user/application/infrastructure already has to iterate all
the mounted filesystems to freeze them, then it's trivial for them
to add a cache purging step to that infrastructure for the storage
configurations that might need it. I just don't see why this needs
to be part of a block device freeze operation, especially as the
"purge caches on this filesystem" operation has potential use cases
outside of the luksSuspend context....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

