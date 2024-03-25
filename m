Return-Path: <linux-fsdevel+bounces-15230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F72688AC34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550A41FA0837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2561CAA1;
	Mon, 25 Mar 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI8R1bM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F01F19A;
	Mon, 25 Mar 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385891; cv=none; b=uBvvfUHeIAZnpGK1QpRFexRTTdOQg1PgntlfqQbrjTZ97i2K+vbPMDd/izdmje0Gv2RCm2sdEFQuVy2QAgFl0HJGMgUqZzlTwYhJiGodd3W9K/jZ0pK3t2yXfSanKhOaCHHQqJe9+WCMnAzK7F3Z7SWHKo7ZLdFoyZEzKPR4Znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385891; c=relaxed/simple;
	bh=e/xVjJ+Txpn1jD1gz/wJzBhLRQKHwgW2fvvAbF8e0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFATnhJ6hxGSNFRJeaf+T1jgnyw5OTqlJYFxPQnZB9aAvbAKoulW7ikAAWMcbkXRXJE4gkSTamFxD9F8EyM4ZIxu/591WOpSVGCePk1r747/2IAw+tBpaR7XpADW4+tD7VZ40RK3Mw5KaoE54Z22Ypx9DfY022UcwZMxFrEShao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI8R1bM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9C4C43330;
	Mon, 25 Mar 2024 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385890;
	bh=e/xVjJ+Txpn1jD1gz/wJzBhLRQKHwgW2fvvAbF8e0lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI8R1bM8qckBeAcjnlUX7Lgl53Io6VRBEFb4dyb/JkoXuYoy+lw58qfSUQPD/9tXa
	 adf9zddaD6dtBR+CBDJzW4z8uAhi/kbOzH4AoceK0tcA9yw47Z7MVd7hlAghwLxPxf
	 UH7TI206OX9qQOULEZF50QcJRWHiTNp9mIRfbb/iqCnzwAn9WD/dmaa+bpwFvrTyeW
	 OGZkfF6iVg4120XyhlmoNa8vsGb687faS2ekMhLG6NIwFjqo2QFRv/zTrjD+jiFRrG
	 BiEKehUeyaNrJln4unEr15fMRykb5r+gygnHJcdaZAUzHD3zNvj3WTXsVUrOCvBYSt
	 qu551LF2Metkg==
Date: Mon, 25 Mar 2024 09:58:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Taylor Jackson <taylor.a.jackson@me.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
	fstests <fstests@vger.kernel.org>
Subject: Re: [linux-next:master] [fs/mnt_idmapping.c]  b4291c7fd9:
 xfstests.generic.645.fail
Message-ID: <20240325165809.GA6375@frogsfrogsfrogs>
References: <202402191416.17ec9160-oliver.sang@intel.com>
 <20240220-fungieren-nutzen-311ef3e57e8a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-fungieren-nutzen-311ef3e57e8a@brauner>

On Tue, Feb 20, 2024 at 09:57:30AM +0100, Christian Brauner wrote:
> On Mon, Feb 19, 2024 at 02:55:42PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "xfstests.generic.645.fail" on:
> > 
> > commit: b4291c7fd9e550b91b10c3d7787b9bf5be38de67 ("fs/mnt_idmapping.c: Return -EINVAL when no map is written")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> The test needs to be updated. We now explicitly fail when no map is
> written.

Has there been any progress on updating generic/645?  6.9-rc1 is out,
and Dave and I have both noticed this regressing.

--D

> > 
> > [test failed on linux-next/master d37e1e4c52bc60578969f391fb81f947c3e83118]
> > 
> > in testcase: xfstests
> > version: xfstests-x86_64-c46ca4d1-1_20240205
> > with following parameters:
> > 
> > 	disk: 4HDD
> > 	fs: f2fs
> > 	test: generic-645
> > 
> > 
> > 
> > compiler: gcc-12
> > test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202402191416.17ec9160-oliver.sang@intel.com
> > 
> > 2024-02-17 15:04:19 export TEST_DIR=/fs/sda1
> > 2024-02-17 15:04:19 export TEST_DEV=/dev/sda1
> > 2024-02-17 15:04:19 export FSTYP=f2fs
> > 2024-02-17 15:04:19 export SCRATCH_MNT=/fs/scratch
> > 2024-02-17 15:04:19 mkdir /fs/scratch -p
> > 2024-02-17 15:04:19 export SCRATCH_DEV=/dev/sda4
> > 2024-02-17 15:04:19 export MKFS_OPTIONS=-f
> > 2024-02-17 15:04:19 echo generic/645
> > 2024-02-17 15:04:19 ./check generic/645
> > FSTYP         -- f2fs
> > PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.8.0-rc1-00033-gb4291c7fd9e5 #1 SMP PREEMPT_DYNAMIC Sat Feb 17 22:11:35 CST 2024
> > MKFS_OPTIONS  -- -f /dev/sda4
> > MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch
> > 
> > generic/645       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/645.out.bad)
> >     --- tests/generic/645.out	2024-02-05 17:37:40.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//generic/645.out.bad	2024-02-17 15:07:42.613312168 +0000
> >     @@ -1,2 +1,4 @@
> >      QA output created by 645
> >      Silence is golden
> >     +idmapped-mounts.c: 6671: nested_userns - Invalid argument - failure: sys_mount_setattr
> >     +vfstest.c: 2418: run_test - Invalid argument - failure: test that nested user namespaces behave correctly when attached to idmapped mounts
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/645.out /lkp/benchmarks/xfstests/results//generic/645.out.bad'  to see the entire diff)
> > Ran: generic/645
> > Failures: generic/645
> > Failed 1 of 1 tests
> > 
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240219/202402191416.17ec9160-oliver.sang@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
> 

