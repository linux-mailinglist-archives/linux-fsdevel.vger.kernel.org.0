Return-Path: <linux-fsdevel+bounces-6243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74E815619
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 02:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9831C211B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13F17EB;
	Sat, 16 Dec 2023 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AUVdl8PS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3F136B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so575921a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 17:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702691555; x=1703296355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6t6LWkh9QArABZ9vx6356WU8okUDG/uwd9Bp0jKdzNw=;
        b=AUVdl8PSB2HZEHaNQST9imrGniAONpcj1Ghrn0shkaTH6WKyLK55L4mbOrW3v+LTb/
         HNrRNafni9qNxDo2PDgOE/WyzcBO5pJ8ieHmwo09n06jahmIDZkzG1tfGpRGu9VMw+bp
         7aZRUAwjzlAucuyXX1QS/BIzeosdIDAur6gC+Yu0BPkVrAzi5uHe8ksBu5hdmPqsoGI4
         ydl8H975jJjNGSaoNaWVlW6NVag8nbIwP7sFvtM7ecM9gFSHnNiGFcx3MSKHIDwJIivI
         i0RTSQBLZrgM7r9AVPOn8toH22FiqXDAK/DJMz2G0JLRtJJ+1lLOMDQQii+a0H8M+Iuf
         V1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702691555; x=1703296355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t6LWkh9QArABZ9vx6356WU8okUDG/uwd9Bp0jKdzNw=;
        b=AtYdIPtSiZqdcA3TCqQldY0XZerlHKwwn0dYURqkj2i8Y9d78sthFlzuVqduThe3Gi
         i+uL+SbVMhtT0Bi8Cq3Q6PrZ81yMl7mIUayPqqinFk28iscoy6HcZIBqNZiTfQFprJ5+
         2MTIxtgd5w4Q5B13/gLB2WB/OCzGh6pMmjxv91FqqJFqNBPNQntvBLXwK4CSuaSUjKrG
         aT6BLQ+xAHEiOZ2Ujp1CsmNVlxm6l+GFjkzR7x5iGXqEFYb+bosu+YbL72our0NZi++Q
         swafTA2GW72lrcCys92IFTkLMH/KREYKi5R+eurkeLnlOyvaLE0rSIU+v8M/7f34EnTW
         jMuA==
X-Gm-Message-State: AOJu0YzoKEv6V4AWcgR8CFz9QwyOT1/2vUvcvgNeETHgWC/4ADDE0fbV
	IwXNpxgsmsK9579RckB8I0RuXA==
X-Google-Smtp-Source: AGHT+IEGg8iW+nBj1jfCwiKkFKSNzmYSyRSqqadiTHllG+D7hkgQStbOPQ1ogLxTa0ryRzZKLlSW8g==
X-Received: by 2002:a17:903:41c9:b0:1d0:6ffd:9dfe with SMTP id u9-20020a17090341c900b001d06ffd9dfemr14421986ple.80.1702691555000;
        Fri, 15 Dec 2023 17:52:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902700c00b001bbb8d5166bsm14735663plk.123.2023.12.15.17.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 17:51:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rEJor-008tIe-1k;
	Sat, 16 Dec 2023 12:50:21 +1100
Date: Sat, 16 Dec 2023 12:50:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <ZX0CXWrHzgaKs0p7@dread.disaster.area>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170224845504.12910.16483736613606611138@noble.neil.brown.name>

On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:
> On Sat, 09 Dec 2023, Chuck Lever wrote:
> > On Fri, Dec 08, 2023 at 02:27:26PM +1100, NeilBrown wrote:
> > > Calling fput() directly or though filp_close() from a kernel thread like
> > > nfsd causes the final __fput() (if necessary) to be called from a
> > > workqueue.  This means that nfsd is not forced to wait for any work to
> > > complete.  If the ->release of ->destroy_inode function is slow for any
> > > reason, this can result in nfsd closing files more quickly than the
> > > workqueue can complete the close and the queue of pending closes can
> > > grow without bounces (30 million has been seen at one customer site,
> > > though this was in part due to a slowness in xfs which has since been
> > > fixed).
> > > 
> > > nfsd does not need this.
> > 
> > That is technically true, but IIUC, there is only one case where a
> > synchronous close matters for the backlog problem, and that's when
> > nfsd_file_free() is called from nfsd_file_put(). AFAICT all other
> > call sites (except rename) are error paths, so there aren't negative
> > consequences for the lack of synchronous wait there...
> 
> What you say is technically true but it isn't the way I see it.
> 
> Firstly I should clarify that __fput_sync() is *not* a flushing close as
> you describe it below.
> All it does, apart for some trivial book-keeping, is to call ->release
> and possibly ->destroy_inode immediately rather than shunting them off
> to another thread.
> Apparently ->release sometimes does something that can deadlock with
> some kernel threads or if some awkward locks are held, so the whole
> final __fput is delay by default.  But this does not apply to nfsd.
> Standard fput() is really the wrong interface for nfsd to use.  
> It should use __fput_sync() (which shouldn't have such a scary name).
> 
> The comment above flush_delayed_fput() seems to suggest that unmounting
> is a core issue.  Maybe the fact that __fput() can call
> dissolve_on_fput() is a reason why it is sometimes safer to leave the
> work to later.  But I don't see that applying to nfsd.
> 
> Of course a ->release function *could* do synchronous writes just like
> the XFS ->destroy_inode function used to do synchronous reads.

What do you mean "could"? The correct word is "does".

> I don't think we should ever try to hide that by putting it in
> a workqueue.  It's probably a bug and it is best if bugs are visible.

Most definitely *not* a bug.

XFS, ext4 and btrfs all call filemap_flush() from their respective
->release methods. This is required to protect user data against
loss caused by poorly written applications that overwrite user data
in an unsafe manner (i.e. the open-truncate-write-close overwrite
anti-pattern).

The btrfs flush trigger is very similar to XFS:

	/*
         * Set by setattr when we are about to truncate a file from a non-zero
         * size to a zero size.  This tries to flush down new bytes that may
         * have been written if the application were using truncate to replace
         * a file in place.
         */
        if (test_and_clear_bit(BTRFS_INODE_FLUSH_ON_CLOSE,
                               &BTRFS_I(inode)->runtime_flags))
                        filemap_flush(inode->i_mapping);

XFS started doing this in 2006, ext4 in 2008, and git will tell you
when btrfs picked this up, too. IOWs, we've been doing writeback
from ->release for a *very long time*.

> Note that the XFS ->release function does call filemap_flush() in some
> cases, but that is an async flush, so __fput_sync doesn't wait for the
> flush to complete.

"async flush" does not mean it will not block for long periods of
time, it just means it won't wait for *all* the IO to complete.
i.e. if the async flush saturates the device, bio submission will
wait for previous IO that the flush submitted own IO to complete
before it can continue flushing the data.

But wait, it gets better!

XFS, btrfs and ext4 all implement delayed allocation, which means
writeback often needs to run extent allocation transactions. In
these cases, transaction reservation can block on metadata writeback
to free up journal space. In the case of XFS, this could be tens of
thousands of metadata IOs needing to be submitted and completed!.

Then consider that extent allocation needs to search for free space
which may need to read in metadata. i.e. extent allocation will end
up submitting and waiting on synchronous read IO. Also, reading that
metadata requires memory allocation for the buffers that will store
it - memory allocation can also block on IO and other subsystems to
free up memory.

Even less obvious is the stack usage issues calling ->release from
arbitrary code entails. The filesystem writeback stack is -deep-.

Remember all the problems we used to have with ->writepage() being
called from direct memory reclaim and so putting the writeback path
at arbitrary depths in the stack and then running out of stack
space?  We really don't want to go back to the bad old days where
filesystem write paths can be entered from code that has already
consumed most of the stack space....

Hence, IMO, __fput_sync() is something that needs to be very
carefully controlled and should have big scary warnings on it. We
really don't want it to be called from just anywhere...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

