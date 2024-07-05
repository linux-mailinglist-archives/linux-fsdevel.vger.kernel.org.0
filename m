Return-Path: <linux-fsdevel+bounces-23246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F0928E71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 22:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608A5284614
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52F16D9B5;
	Fri,  5 Jul 2024 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s1PZHYML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2B1459FE;
	Fri,  5 Jul 2024 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213160; cv=none; b=X/zTGv0l+4SztZbgj8xC8lhF9SP5U965tiwgMy+ODP18p0U3FDxIEHB2MYNjz64+uq3zvJGQytOp6EKphXoKY4DlThfFK/Lkleye4Q0RXSobX7gOASh6iZbCWfCU2fujYmFN+fDL3bDBKSW9mIOEpkH/ERm2C82jWERTcJCYNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213160; c=relaxed/simple;
	bh=DusGE1cbAr1wr2RiyF/fWaMqiaLUnByl1oNy227VTkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvgBeYFRXHQQ6RjKN2l8KTo0px8zAVnSSgpybu5Y4GJzlGUwMLhr7hhooDDkKZJfQhJvsVvUbacgbtXPV4gJmBW+N9A0mXVXLMRsAtvcX9VMJD5isFQeHeELhB8prbByY2XYzyYvx0LVDm2PDaP8yXYtW3jhg/LsBxSdgNx2qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s1PZHYML; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/Kb85RBByRKA+7u8OSLey5Gf4F7B6fkoI9PSqKXpd2Q=; b=s1PZHYMLbcx7leKxCoOb+zA0Fz
	WIgyuKpHtDdcKqCLFMKJm8ZdS6QhpDzWXz3psaK/RrEFicjAvC9fRqL5HAT31ux5CfxQVeh4HKD0X
	Dx24gnQRdn8NofoFKxzTI/jnLJmmwJH1h45FomlHuaYKmQ1yIASsbnk8eT7XGeIaOpr7pax7/9R9L
	8mYcqfXnv1pbLDD9qjjTe0NbegNpKCrQ76+gi3XOO3yEIOPGi7NEb6y8eD/bv/s/jgiRHqnWvbz4C
	lN6+iO5k1jTKZfqtpQ8SSiC4ZitAY/UPwKEm1V9UOzJ7gah70FkWDPocpHML7eJpZHIMqILz2A6iW
	+Az7UDbg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPq1N-0000000GpGP-3COr;
	Fri, 05 Jul 2024 20:59:09 +0000
Message-ID: <27400c92-632b-4f58-956a-eb2cbb0cfe26@infradead.org>
Date: Fri, 5 Jul 2024 13:59:08 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] Documentation: add a new file documenting
 multigrain timestamps
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
 <20240705-mgtime-v3-5-85b2daa9b335@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240705-mgtime-v3-5-85b2daa9b335@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/5/24 10:02 AM, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/Documentation/filesystems/multigrain-ts.rst b/Documentation/filesystems/multigrain-ts.rst
> new file mode 100644
> index 000000000000..70d36955bb83
> --- /dev/null
> +++ b/Documentation/filesystems/multigrain-ts.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Multigrain Timestamps
> +=====================
> +
> +Introduction
> +============
> +Historically, the kernel has always used a coarse time values to stamp

                                       used coarse time values

> +inodes. This value is updated on every jiffy, so any change that happens
> +within that jiffy will end up with the same timestamp.
> +
> +When the kernel goes to stamp an inode (due to a read or write), it first gets
> +the current time and then compares it to the existing timestamp(s) to see
> +whether anything will change. If nothing changed, then it can avoid updating
> +the inode's metadata.
> +
> +Coarse timestamps are therefore good from a performance standpoint, since they
> +reduce the need for metadata updates, but bad from the standpoint of
> +determining whether anything has changed, since a lot of things can happen in a
> +jiffy.
> +
> +They are particularly troublesome with NFSv3, where unchanging timestamps can
> +make it difficult to tell whether to invalidate caches. NFSv4 provides a
> +dedicated change attribute that should always show a visible change, but not
> +all filesystems implement this properly, causing the NFS server to substitute
> +the ctime in many cases.
> +
> +Multigrain timestamps aim to remedy this by selectively using fine-grained
> +timestamps when a file has had its timestamps queried recently, and the current
> +coarse-grained time does not cause a change.
> +
> +Inode Timestamps
> +================
> +There are currently 3 timestamps in the inode that are updated to the current
> +wallclock time on different activity:
> +
> +ctime:
> +  The inode change time. This is stamped with the current time whenever
> +  the inode's metadata is changed. Note that this value is not settable
> +  from userland.
> +
> +mtime:
> +  The inode modification time. This is stamped with the current time
> +  any time a file's contents change.
> +
> +atime:
> +  The inode access time. This is stamped whenever an inode's contents are
> +  read. Widely considered to be a terrible mistake. Usually avoided with
> +  options like noatime or relatime.
> +
> +Updating the mtime always implies a change to the ctime, but updating the
> +atime due to a read request does not.
> +
> +Multigrain timestamps are only tracked for the ctime and the mtime. atimes are
> +not affected and always use the coarse-grained value (subject to the floor).
> +
> +Inode Timestamp Ordering
> +========================
> +
> +In addition just providing info about changes to individual files, file
> +timestamps also serve an important purpose in applications like "make". These
> +programs measure timestamps in order to determine whether source files might be
> +newer than cached objects.
> +
> +Userland applications like make can only determine ordering based on
> +operational boundaries. For a syscall those are the syscall entry and exit
> +points. For io_uring or nfsd operations, that's the request submission and
> +response. In the case of concurrent operations, userland can make no
> +determination about the order in which things will occur.
> +
> +For instance, if a single thread modifies one file, and then another file in
> +sequence, the second file must show an equal or later mtime than the first. The
> +same is true if two threads are issuing similar operations that do not overlap
> +in time.
> +
> +If however, two threads have racing syscalls that overlap in time, then there
> +is no such guarantee, and the second file may appear to have been modified
> +before, after or at the same time as the first, regardless of which one was
> +submitted first.
> +
> +Multigrain Timestamps
> +=====================
> +Multigrain timestamps are aimed at ensuring that changes to a single file are
> +always recognizeable, without violating the ordering guarantees when multiple

          recognizable
according to what I can find on the web.

> +different files are modified. This affects the mtime and the ctime, but the
> +atime will always use coarse-grained timestamps.
> +
> +It uses an unused bit in the i_ctime_nsec field to indicate whether the mtime
> +or ctime has been queried. If either or both have, then the kernel takes
> +special care to ensure the next timestamp update will display a visible change.
> +This ensures tight cache coherency for use-cases like NFS, without sacrificing
> +the benefits of reduced metadata updates when files aren't being watched.
> +
> +The Ctime Floor Value
> +=====================
> +It's not sufficient to simply use fine or coarse-grained timestamps based on
> +whether the mtime or ctime has been queried. A file could get a fine grained
> +timestamp, and then a second file modified later could get a coarse-grained one
> +that appears earlier than the first, which would break the kernel's timestamp
> +ordering guarantees.
> +
> +To mitigate this problem, we maintain a global floor value that ensures that
> +this can't happen. The two files in the above example may appear to have been
> +modified at the same time in such a case, but they will never show the reverse
> +order. To avoid problems with realtime clock jumps, the floor is managed as a
> +monotonic ktime_t, and the values are converted to realtime clock values as
> +needed.
> +
> +Implementation Notes
> +====================
> +Multigrain timestamps are intended for use by local filesystems that get
> +ctime values from the local clock. This is in contrast to network filesystems
> +and the like that just mirror timestamp values from a server.
> +
> +For most filesystems, it's sufficient to just set the FS_MGTIME flag in the
> +fstype->fs_flags in order to opt-in, providing the ctime is only ever set via
> +inode_set_ctime_current(). If the filesystem has a ->getattr routine that
> +doesn't call generic_fillattr, then you should have it call fill_mg_cmtime to
> +fill those values.
> 

-- 
~Randy

