Return-Path: <linux-fsdevel+bounces-38385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21118A0137D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 10:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D328A3A0FA8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864C17278D;
	Sat,  4 Jan 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt0rG3VG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCA149C7B;
	Sat,  4 Jan 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735981554; cv=none; b=JhyRGaV5qMbMc4Z89M7Cz9w+iIy47MymZL8GxjEhjOiLbOpmlNGJTd+iCpTMoeU3bOJ7RI81dL2uanny8nNzjumIbfiIRVD9d0MdeQlrML5K4azlKWoyoEVI0NqHKBtAoffoanb05qHgQ6WlB+nsfZeQQC/uVNxF62qChHdjIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735981554; c=relaxed/simple;
	bh=Zdr7RTfQs13SLt0RR6y+htEU9KH1H0YQGvPzOAN681E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUI2BljsovZNzX6kG6V2eNV87+k58P/X6gRiQ10pG6rd/Hp4z59G3cv5oxe4RjfX2oFZPDj7dLAQrHcHdDi/3WAnHov68NHdAxsjFGtQlpezait5A2yzFC8hrU7i+sMZ0904nxMabpIoJMq7LDymxgeqZVuLGSul3pcLH36fDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt0rG3VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A2DC4CED1;
	Sat,  4 Jan 2025 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735981553;
	bh=Zdr7RTfQs13SLt0RR6y+htEU9KH1H0YQGvPzOAN681E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dt0rG3VG9Nk8QsmgFxn3cbEvqHjxcZlop3LHxc/WmKn0FpOANWie8c3QaMam8qM1a
	 KfW/JF8ZQO1NykS4B5S0qfYOi5gGSv2Y/rWtsXAz1reHjg+1C9YgRMRZ1FamUA8s8r
	 mbeSol9zKU22LvosH5zdjx6FR88XPgmTTtGqbZ11KclW4qyXy9TYj6GFVBQuM8fI9V
	 NDitKnvIXhHJo5aZ1ieaDVmcYNa/B/kf9dExGUsMqdkumTrCrWS+TnBz2BHDU6UPxk
	 FSQmKziotzk+c5OFR8OED8H1C4vuJJjxdASB9rbXQlA5Mq49VAqo9yVepqiNlWJ1gX
	 3vdxp9jPqNp2A==
Date: Sat, 4 Jan 2025 10:05:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Jeff Layton <jlayton@kernel.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs]  75ead69a71:
 kernel-selftests.filesystems/statmount.statmount_test.fail
Message-ID: <20250104-insgeheim-rezitieren-5e6dc33ca403@brauner>
References: <202412301338.77cc6482-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202412301338.77cc6482-lkp@intel.com>

On Mon, Dec 30, 2024 at 02:35:49PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.filesystems/statmount.statmount_test.fail" on:
> 
> commit: 75ead69a717332efa70303fba85e1876793c74a9 ("fs: don't let statmount return empty strings")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      8379578b11d5e073792b5db2690faa12effce8e0]
> [test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-7503345ac5f5-1_20241208
> with following parameters:
> 
> 	group: filesystems
> 
> 
> 
> config: x86_64-dcg_x86_64_defconfig-kselftests
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412301338.77cc6482-lkp@intel.com
> 
> 
> TAP version 13
> 1..2
> # timeout set to 300
> # selftests: filesystems/statmount: statmount_test
> # TAP version 13
> # 1..15
> # ok 1 listmount empty root
> # ok 2 statmount zero mask
> # ok 3 statmount mnt basic
> # ok 4 statmount sb basic
> # ok 5 statmount mount root
> # ok 6 statmount mount point
> # ok 7 statmount fs type
> # not ok 8 unexpected mount options: 'tmpfs' != ''

This test needs to be changed. We fixed mount option retrieval so it now
also retrieve security mount options with STATMOUNT_MNT_OPTS.

