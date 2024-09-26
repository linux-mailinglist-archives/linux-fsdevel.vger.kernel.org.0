Return-Path: <linux-fsdevel+bounces-30193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB35987805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F1B1C21445
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12115DBC1;
	Thu, 26 Sep 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OyPAll4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67831157E61;
	Thu, 26 Sep 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369988; cv=none; b=KFZqSsudVxjUOnB/wp+EfxywikuXBeE8mdaTfQHbAfkgrDzUzZbovkJcKcgG+UsQDjRYSQzd5DAD+8Upt2RWhXNr0SD5LQ2aFp9JdFqjxxmVMao4sWuVt6b6pCd4NFOI0+U+OZSNXRV4cY8O5LFcVyzd8Hzx5Qw3h7Fp0oXmy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369988; c=relaxed/simple;
	bh=FvyFBt+Vd5UF2A+sqhYijCe2ynDIwnVNWV+evOwSXP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1SiIdFW46NHrhcKA1/acXKyGIfdRGzUO6oJuUKaO7IE995Z9i8dJ/BGNLPEXukuznYmuKMF8u2++mxYIMAZf1zO4VUmYKPWbE0C+E9tQSWDzm1kWYne+2qbSMhCE2v2YiytYXjJQE03FGKxmPteJxz7JnSgnr0CgGvlulVFyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OyPAll4O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=vZZTa11CAK73ciRtK/MoLNusDFg6dIj6Gmywiet9pEk=; b=OyPAll4OChxKP8zrcRtGRnwDsS
	zgKDZwCOCsLmEc3+M7QxVMRw982AGTIfUzIiE0r3n23a11U3UDZEMxLYNM618gxtGhCmRWJP9IslZ
	9+fiZSZkbwBnKX2dlUHKkc3YWMFduEcnt37crCl9ejx+ykHfIKIsY2xu7mT6c09KLkFB6Nj2shRI/
	b9o0cncTZMvy1eY9nrSfrqswutAzEmxTAPzp6LD6L9+WM7TNgOssSkIjNUWpwRnM5fRfscLCL093N
	0O2bR8GyaCgxQdhUQxbDRrz9hy5l7wu9KZI/IeAiNOYxC27i+h5n/x1QgIcty/TPcFVrW1NPOWxWe
	lyN231og==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1strpz-000000078sX-1WvG;
	Thu, 26 Sep 2024 16:59:32 +0000
Message-ID: <fadc1ea2-fb43-41e2-af8c-8a93cf9e7865@infradead.org>
Date: Thu, 26 Sep 2024 09:59:21 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] fs: multigrain timestamp redux
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jeff,

On 9/14/24 10:07 AM, Jeff Layton wrote:
> This is a fairly small update to the v7 set. It seems to pass all of my
> testing. Again, most of the changes are in the first two patches, but
> there are some differences in the patch that adds percpu counters as
> well.
> 
> Since the report of a performance regression came just before the merge
> window, it looks like we're going to have to wait for yet another
> release, so consider this version v6.13 material.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

> ---
> Jeff Layton (11):
>       timekeeping: move multigrain timestamp floor handling into timekeeper
>       fs: add infrastructure for multigrain timestamps
>       fs: have setattr_copy handle multigrain timestamps appropriately
>       fs: handle delegated timestamps in setattr_copy_mgtime
>       fs: tracepoints around multigrain timestamp events
>       fs: add percpu counters for significant multigrain timestamp events
>       Documentation: add a new file documenting multigrain timestamps
>       xfs: switch to multigrain timestamps
>       ext4: switch to multigrain timestamps
>       btrfs: convert to multigrain timestamps
>       tmpfs: add support for multigrain timestamps
> 
>  Documentation/filesystems/index.rst         |   1 +
>  Documentation/filesystems/multigrain-ts.rst | 121 ++++++++++++
>  fs/attr.c                                   |  60 +++++-
>  fs/btrfs/file.c                             |  25 +--
>  fs/btrfs/super.c                            |   3 +-
>  fs/ext4/super.c                             |   2 +-
>  fs/inode.c                                  | 278 +++++++++++++++++++++++++---
>  fs/stat.c                                   |  42 ++++-
>  fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
>  fs/xfs/xfs_iops.c                           |  10 +-
>  fs/xfs/xfs_super.c                          |   2 +-
>  include/linux/fs.h                          |  36 +++-
>  include/linux/timekeeping.h                 |   5 +
>  include/trace/events/timestamp.h            | 124 +++++++++++++
>  kernel/time/timekeeping.c                   |  83 +++++++++
>  kernel/time/timekeeping_debug.c             |  12 ++
>  kernel/time/timekeeping_internal.h          |   3 +
>  mm/shmem.c                                  |   2 +-
>  18 files changed, 742 insertions(+), 73 deletions(-)
> ---
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63

IME it would be better to make this series apply to linux-next-($latest)
instead of base mainline Linux. for integration reasons.

You can add

Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits

for all patches if you want to.


> change-id: 20240913-mgtime-20c98bcda88e
> 
> Best regards,

