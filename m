Return-Path: <linux-fsdevel+bounces-46336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F073A87411
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 23:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E22A3AAFF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1618D65E;
	Sun, 13 Apr 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ot6XUn21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423EE16C850
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Apr 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744581392; cv=none; b=SpbqXlOErlzL/OlHUB3NALzQysrC7aHrFxI+k08fLceEcWcjdg37ic47sNfPC4FKd58IpX7RTuXUTzq75I75Lz4kd5mmd+7nJrEZmr5j1Kr7WrXLcNcL5q3hBYJAfqdwvKJWftjLIKVl1QRpxCTk3jhd7pnk6uxs1n2hnjYTmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744581392; c=relaxed/simple;
	bh=ZGwyvhVohsHYoerb048m6P7e99+DhrhKFtPFNT1KHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=endPl1BpgD/x9K5JNajvvT5Bq3T2eM3smfvc2yuzBoV1QcxHDAfpwj1iJY8qmVDSAqGr5+P5yDpoCunE+31d+jlJIbpU1XkzvlJ3Pb54iwRiopWJ7ADjol3HwPGlM/MUwoVsUctGoLG/ZxmPEvSNtmCZQltdgyZwYY5yJQ9Xxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ot6XUn21; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 13 Apr 2025 17:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744581372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1yjFnQamiTjPe/VkGVTpXBnkVPJsiFAP2ZxRatOZeE=;
	b=Ot6XUn212kRkyI4rE8E1lVquW03cGGsOKK68dkhGSdS6ywjQzeons1cfklzzdWPw9UPs7S
	1BSwtBoNhrH9KUpI3fvev0Rm+zOhSAVdjE8mOMNaQJuL6G9pq6CnZZVansfw1gZBgSCYdY
	vLUV3AWrjFhVC8IIhrnMpEwu2atCrpc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] README: add supported fs list
Message-ID: <u2pigq4tq5aj5qvjrf3idna7hfdl6b4ciko5jvorkyorg25dck@4ti6fjx55hda>
References: <20250328164609.188062-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328164609.188062-1-zlang@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 29, 2025 at 12:46:09AM +0800, Zorro Lang wrote:
> To clarify the supported filesystems by fstests, add a fs list to
> README file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> 
> The v1 patch and review points:
> https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/
> 
> V2 did below things:
> 1) Fix some wrong english sentences
> 2) Explain the meaning of "+" and "-".
> 3) Add a link to btrfs comment.
> 4) Split ext2/3/4 to 3 lines.
> 5) Reorder the fs list by "Level".
> 
> Thanks,
> Zorro
> 
>  README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/README b/README
> index 024d39531..5ceaa0c1e 100644
> --- a/README
> +++ b/README
> @@ -1,3 +1,93 @@
> +_______________________
> +SUPPORTED FS LIST
> +_______________________
> +
> +History
> +-------
> +
> +Firstly, xfstests is the old name of this project, due to it was originally
> +developed for testing the XFS file system on the SGI's Irix operating system.
> +When xfs was ported to Linux, so was xfstests, now it only supports Linux.
> +
> +As xfstests has many test cases that can be run on some other filesystems,
> +we call them "generic" (and "shared", but it has been removed) cases, you
> +can find them in tests/generic/ directory. Then more and more filesystems
> +started to use xfstests, and contribute patches. Today xfstests is used
> +as a file system regression test suite for lots of Linux's major file systems.
> +So it's not "xfs"tests only, we tend to call it "fstests" now.
> +
> +Supported fs
> +------------
> +
> +Firstly, there's not hard restriction about which filesystem can use fstests.
> +Any filesystem can give fstests a try.
> +
> +Although fstests supports many filesystems, they have different support level
> +by fstests. So mark it with 4 levels as below:
> +
> +L1: Fstests can be run on the specified fs basically.
> +L2: Rare support from the specified fs list to fix some generic test failures.
> +L3: Normal support from the specified fs list, has some own cases.
> +L4: Active support from the fs list, has lots of own cases.
> +
> +("+" means a slightly higher than the current level, but not reach to the next.
> +"-" is opposite, means a little bit lower than the current level.)
> +
> ++------------+-------+---------------------------------------------------------+
> +| Filesystem | Level |                       Comment                           |
> ++------------+-------+---------------------------------------------------------+
> +| XFS        |  L4+  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
> +|            |       | notes.html#fstests-setup                                |
> ++------------+-------+---------------------------------------------------------+
> +| Ext4       |  L4   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext2       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Ext3       |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| overlay    |  L3   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| f2fs       |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| tmpfs      |  L3-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> ++------------+-------+---------------------------------------------------------+
> +| Ceph       |  L2   | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> ++------------+-------+---------------------------------------------------------+
> +| ocfs2      |  L2-  | N/A                                                     |
> ++------------+-------+---------------------------------------------------------+
> +| Bcachefs   |  L1+  | N/A                                                     |

I heavily use xfstests and look at the test results every day - I
believe that would indicate L3.

bcachefs specific tests are not generally in fstests beacuse there's
lots of things that ktest can do that fstests can't, and I find it a bit
more modern (i.e. tests that names, not numbers)

Not all tests are passing (and won't be for awhile), but the remaining
stuff is non critical (i.e. fsync() error behaviour when the filesystem
has been shutdown, or certain device removal tests where the behaviour
could probably use some discussion.

But if you find e.g. a configuration that produces a generic/388 pop,
that would go to the top of the pile.

(I do have a few patches to the tests for bcachefs in my tree that I
really ought to get upstream).

