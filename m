Return-Path: <linux-fsdevel+bounces-63307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6FEBB477A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F0173E88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53776248F5A;
	Thu,  2 Oct 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="syOZB0K1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEF136672
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421808; cv=none; b=gs0PRyW2US8FM3Qr50hK6nxJU4Q2hXG68yvb/KG8c9Rmt6PYEZl8/nbD5mRQX24CfZV6rSOcMg/PshJgWHqS1a0GG7c+nmjR8zDZP+NIxEAjvzA9iFdLi/j0ft4SIQR2hCsfJdjgE6LLCUFThMk1EHC/W4h223G4q7z9WRXqm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421808; c=relaxed/simple;
	bh=X+rJ33ekuJt2GT9axSRNB+eIwSkMLNjAicCcn3KnBPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB8QJyyI3rLgXVt/ZhE1+g9v/8ZC5AGfd1pcpwm01hRT22DCnOlYjVSHS6SeRCfw46Nr/n9i1aS8xhwSneco/TADVy1TWt6KAvgnZv2Ee5/gZLUi0YY+ESp8LVKCzFnB041ZXq4KtXNmDr8A+UYtCE3sQR6DYteHl/z+yrFfmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=syOZB0K1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Thu, 2 Oct 2025 17:16:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1759421803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QyVIOj/DwAWwSsSUjSOOk6J3fLpVMo0CM8h/pVnbq8U=;
	b=syOZB0K1NPlE1Y6j3v8WQjsB0i8K/a6n14PLRfZeTR6Ur35HWM7cS1ZMmyJEIqap7qN6sT
	/je/ynt1CbV1sz90aeDISV6wSH67mTE1AUkxUPygVGEDB/Dz/Tf+KSXBguNoZgBR1BT8cE
	MJnJb924yyHRC43gfxXZeo8swSM8sL4pIdbJvCkST+oITKNlJ+o9jw2NYn/BLGfAuAzA2L
	YcXARlFxOuzHDVw2qrAvd+Xef5V61v23Eq9/tDMu/k14DZGGakdXXI4LIX/PDTz9fR/h1F
	2AcqcR//Szh6lci44CZSG3WJMZx0Z5Bck+InxA8Svz6Qkh6t/m867qBHxARKhw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Cc: damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] kernel BUG in hfs_write_inode
Message-ID: <aN6laD5P8zq0F5ns@Bertha>
References: <00000000000089f55405ee486239@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000089f55405ee486239@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 25, 2022 at 01:45:41AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    65762d97e6fa Merge branch 'for-next/perf' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e324e3880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=56d0c7c3a2304e8f
> dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10983553880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13315ebb880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/52f702197b30/disk-65762d97.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/72189c2789ce/vmlinux-65762d97.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ec0349196c98/Image-65762d97.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/6bfea2266b7f/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> 

I simplified the reproducer previously while working on a patch for this bug and found it no longer reproduces on mainline. I just want to sanity check this by testing mainline with syzbot's repro:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.17

Thanks,

George

