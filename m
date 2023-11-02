Return-Path: <linux-fsdevel+bounces-1884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1132F7DFBB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463231C2100B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCE1DDE9;
	Thu,  2 Nov 2023 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="o/YCnKX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC311736
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 20:49:00 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C278184
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:48:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5b6d6228so10925505ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698958139; x=1699562939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPlOQs4H3ojv1i5CDb/ZZoP+yLZogQLFBQAjO2TQLUE=;
        b=o/YCnKX1u8C0Z+1hwL705zfGU4AeLkcMPv+pp+POddh4meeWltMnDnMAEWpxpA2mOK
         YLMq2cFxCe9cIt66Xbc9XIEwenryooypNsCE8tJuGcqinNPuoVSPHUeMyQRa7B/5PVGE
         q6ICS2eZL4KeUTFXc6AWjWGySGmGMXmyrvtQ3mgY9snUKu8qzZFDId4UBoB8DREkQqW0
         6V24HKn9rHg8r2ElkKHWNex6RbAC65qZLRYGm42jQx3dVNIuIcZSiDhOPs9wF8XcICy9
         xwXeyQq2sYUV471MMMc+DfKL17R6qKnhcZ6C6o1cMiLos8RWu+t5noZjQtIBQZVOmsZb
         XfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958139; x=1699562939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPlOQs4H3ojv1i5CDb/ZZoP+yLZogQLFBQAjO2TQLUE=;
        b=Cat7IcPr0uevmcwpZaCNanGVEJ5psvRf8cJE54ip9TVu3SltrHt31x1qmX7HoxVT9f
         /2Lf0RFVbAdv+qpUVTSgoMr6X671TPmU5XylH355taLkSt9OV1nPVBwKb6Fup8FQ9jXJ
         FLSnYjhUew/h9NFbvU9W9BpwkJlxfQ5AcrZJzPJAT//e5ILbUceLGRYTkhSmw5NkG2On
         Ph+1NmhZJkjVl8RKNr1/YgHSHnfsB6kEQ3I3RNtO3MntjEPxcysJvS2xAYAaB56D/xBr
         nVh1QpLfdUPbIsxMOzCU78VkhmdjlMTTdvJ0Os8wAMYI8NSPcdpV+RuXFHJdaNTMTMGy
         c5Pw==
X-Gm-Message-State: AOJu0YxnCCM73hEPORXFlvQbhbRrgeu6yYS/wlUQq8rsbVBkS6NN9LFd
	ThO/iedqcnh1YJZq/MYC+XRdKljqcyVM+9eoQi0=
X-Google-Smtp-Source: AGHT+IE4Ajg7Dp58olVWG7i7o6t8cg/BphJAwnryFXtyTOEQ2IJedsUYfu/uVRiRP1oFGswlizAu3w==
X-Received: by 2002:a17:903:32c3:b0:1cc:453f:517b with SMTP id i3-20020a17090332c300b001cc453f517bmr13717854plr.0.1698958138903;
        Thu, 02 Nov 2023 13:48:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b001c61afa7009sm136641plb.114.2023.11.02.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:48:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qyecZ-007Nln-0P;
	Fri, 03 Nov 2023 07:48:55 +1100
Date: Fri, 3 Nov 2023 07:48:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>, viro@zeniv.linux.org.uk,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	dchinner@fromorbit.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG REPORT] next-20231102: generic/311 fails on XFS with
 external log
Message-ID: <ZUQLN7UBlK6MQoK3@dread.disaster.area>
References: <87bkccnwxc.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20231102-teich-absender-47a27e86e78f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102-teich-absender-47a27e86e78f@brauner>

On Thu, Nov 02, 2023 at 03:54:48PM +0100, Christian Brauner wrote:
> On Thu, Nov 02, 2023 at 06:06:10PM +0530, Chandan Babu R wrote:
> > Hi,
> > 
> > generic/311 consistently fails when executing on a kernel built from
> > next-20231102.
> > 
> > The following is the fstests config file that was used during testing.
> > 
> > export FSTYP=xfs
> > 
> > export TEST_DEV=/dev/loop0
> > export TEST_DIR=/mnt/test
> > export TEST_LOGDEV=/dev/loop2
> > 
> > export SCRATCH_DEV=/dev/loop1
> > export SCRATCH_MNT=/mnt/scratch
> > export SCRATCH_LOGDEV=/dev/loop3
> 
> Thanks for the report. So dm flakey sets up:
> 
> /dev/dm-0 over /dev/loop0
> /dev/dm-1 over /dev/loop2
> 
> and then we mount an xfs filesystem with:
> 
> /dev/loop2 as logdev and /dev/loop0 as the main device.
> 
> So on current kernels what happens is that if you freeze the main
> device you end up:
> 
> bdev_freeze(dm-0)
> -> get_super(dm-0) # finds xfs sb
>    -> freeze_super(sb)
> 
> if you also freeze the log device afterwards via:
> 
> bdev_freeze(dm-1)
> -> get_super(dm-1) # doesn't find xfs sb because freezing only works for
>                    # main device
> 
> What's currently in -next allows you to roughly do the following:
> 
> bdev_freeze(dm-0)
> -> fs_bdev_freeze(dm-0->sb)
>    -> freeze_super(dm-0->sb) # returns 0
> 
> bdev_freeze(dm-1)
> -> fs_bdev_freeze(dm-1->sb)
>    -> freeze_super(dm-1->sb) # returns -EBUSY
> 
> So you'll see EBUSY because the superblock was already frozen when the
> main block device was frozen. I was somewhat expecting that we may run
> into such issues.
> 
> I think we just need to figure out what we want to do in cases the
> superblock is frozen via multiple devices. It would probably be correct
> to keep it frozen as long as any of the devices is frozen?

So this series removed the blockdev freeze nesting code that dm
suspend/resume functionality used (i.e. it allowed concurrent bdev
freeze/thaw works and leaves the bdev frozen until the last thaw
occurs). Removing bd_fsfreeze_count essentially removed this nesting
ability.

IMO, bdev_freeze() should still nest freeze/thaw across all devices
in the filesystem like it used to on the main device. This implies
that freeze_super() needs to know that it is being called from
bdev_freeze() and needs a freeze counter to allow concurrent bdev
freezes and only thaw the fs when the last freeze goes away....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

