Return-Path: <linux-fsdevel+bounces-14455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C087CE31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5835F282A8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545D2E418;
	Fri, 15 Mar 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbt2cRue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED661C291;
	Fri, 15 Mar 2024 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510165; cv=none; b=mgTYl6j4cEQ4OfSFShN1nKSJ2PVC/tZE1wE9Map1Yzbp2/YYxEbF367Tm6yq59Jm2+/v/HJswYE4SMdZbK9Ku+xaRHfcaJK7/4w64QVfaxzhlTWXl0ElMvduKlAh+5F6tAUTYLBOZtQfO7edwgWHhJ31yKF8jIBAGgueMsPcuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510165; c=relaxed/simple;
	bh=yQjjoHAXiCtUEgUO5PE3VGVY3a1Pjgr3XTej8GW/Mhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmRajdxC+PZ2wwLLu8Q5kT2ht/FK/UdOMU4BWgaC0Tb36P1zHSi5zG9qgMIc5fAq9at9cPbu24Xv5zW0DHy7o/z8yyY+i8TkaghpuzN44QzhNbcMv6eZHsXzYwgFuY12Ad+/JMSYTvuBoRgkERIqCDlfQMKM3bJIxez+2d0vIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbt2cRue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D8C433F1;
	Fri, 15 Mar 2024 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710510165;
	bh=yQjjoHAXiCtUEgUO5PE3VGVY3a1Pjgr3XTej8GW/Mhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bbt2cRueQrFzlu5adTAhX82qM17+W0wzcYzfoZdlYx1J58zF77Ri4nQ0qKLP+CDg5
	 fThVJKrH6ggcBsrhrxqNWPB31SC6yx7vEHhyL6IUgpxNE2YB+PY9jWm4ecbe2tGkUD
	 VqXX0y6aP+Dwoot7lHy1opVGTe46Rf5Yhw5/SC5GYeRJHHf06EEKnEoVMX2Sd+Fv6f
	 B8EYcRCQrGF4o0wqNfj3+Jao1fXLw3fCPEkEKU1AS0WZkm+D1QQMaLE8YLNuWTQWqO
	 pXkCbLsd8j+oPPQ9xQa3lpoldYD05bZoRk2oVGIc9gRIDLD6wUNwPM3gKRurwDorcX
	 P485iX30ZjkOQ==
Date: Fri, 15 Mar 2024 14:42:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
Message-ID: <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
References: <202403151507.5540b773-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403151507.5540b773-oliver.sang@intel.com>

On Fri, Mar 15, 2024 at 04:16:33PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.readahead01.fail" on:
> 
> commit: cb12fd8e0dabb9a1c8aef55a6a41e2c255fcdf4b ("pidfd: add pidfs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 65d287c7eb1d14e0f4d56f19cec30d97fc7e8f66]
> [test failed on linux-next/master a1184cae56bcb96b86df3ee0377cec507a3f56e0]
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240309
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: f2fs
> 	test: syscalls-00/readahead01
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

Yes, this is an expected failure.
Before moving pidfds to pidfs they were based on anonymous inodes.
Anonymous inodes have a strange property: yhey have no file type. IOW,
(stat.st_mode & S_IFMT) == 0.

The readhead code looks at the filetype and if it isn't a regular file
then you'll get EINVAL. This is the case for anonymous inode based
pidfds:

        /*
         * The readahead() syscall is intended to run only on files
         * that can execute readahead. If readahead is not possible
         * on this file, then we must return -EINVAL.
         */
        ret = -EINVAL;
        if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
            (!S_ISREG(file_inode(f.file)->i_mode) &&
            !S_ISBLK(file_inode(f.file)->i_mode)))
                goto out;

However, pidfs makes them regular files so they're not caught by that
check anymore.

However, pidfs doesn't implement any readahead support. Specifically,
it'll have sb->s_bdi == noop_backing_dev_info. Which will mean the
readahead request is just ignored:

        if (IS_DAX(inode) || (bdi == &noop_backing_dev_info)) {
                switch (advice) {
                case POSIX_FADV_NORMAL:
                case POSIX_FADV_RANDOM:
                case POSIX_FADV_SEQUENTIAL:
                case POSIX_FADV_WILLNEED:
                case POSIX_FADV_NOREUSE:
                case POSIX_FADV_DONTNEED:
                        /* no bad return value, but ignore advice */
                        break;
                default:
                        return -EINVAL;
                }
                return 0;
        }

So I'd just remove that test. It's meaningless for pseudo fses.

