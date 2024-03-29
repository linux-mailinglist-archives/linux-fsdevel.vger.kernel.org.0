Return-Path: <linux-fsdevel+bounces-15664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFB89146C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 08:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A948A1F22F43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F974087D;
	Fri, 29 Mar 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APauY79q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF040852;
	Fri, 29 Mar 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697971; cv=none; b=jyiDOXVzovP/3ZOX1dB5UgsujYvE0LBw2Olw3ZYMVBt3RQvh5dTuLwfHjllEV3KkRPVYc7GajSDkn9VNuCMdXbB1atDifxDWpMeesEiQtEAjjLnL0YSbKp0m1VZZ8/aLMs5Y6Xov+f4abd3dq97CQY+5VP++OiuLCTnfn+rdQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697971; c=relaxed/simple;
	bh=4hxZn17jwTDW1j8EEbdmdBYX6Vcgvx8JwxaOFGf6h7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eClygHeOJ90vdk8i+vkK5Gcv2mO31RUR+QB4Ueresf/YB4Wse6HhiVzbdJlKG2Gw/lkGYMAYcyoymUNEjyCwNT9Kv6CVcztuK3/RlGYCzjLhZSh5o93HJYcDlPzo6DqIYFHuzVswKhKxAY/5f9Z61ir0AkvxuiIWAWl2/YsVkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APauY79q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A8EC433F1;
	Fri, 29 Mar 2024 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711697970;
	bh=4hxZn17jwTDW1j8EEbdmdBYX6Vcgvx8JwxaOFGf6h7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APauY79qIdzSDljHN+Bp4ugzsbbNsX+Fu39fqd4DA3ZHz6GG8a5f1J+jVY1+YVffU
	 Bhw8H2xwxVIPF97xDc0q7x5/nIIpe8rQNOqgZ285jHctrKnC6H8Gd4BThOTHzSO1O/
	 q1YhwoqevVIEr1i5Ne/pZ8IRKgMXZEID+QCDC5ytg2ecWl1SdKIL77gefCt2DQuaUF
	 sVbksM6MyinNp17Sy+PY7ICOgsL+D/j3NlYxOLPCObzI/rbHVEr5/RJ4p3nLHkrncZ
	 1oiOyGmFLEKbEtL//Tr7jEF09umajnLal3hczu2kYvJsh/7cYbDHfklJ2JqTgkIF4S
	 wDBEUBRlRiPnA==
Date: Fri, 29 Mar 2024 08:39:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING: ODEBUG bug in bdev_super_lock
Message-ID: <20240329-girlanden-futsch-7bcd27d91f17@brauner>
References: <000000000000aacdcb0614b939ad@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000aacdcb0614b939ad@google.com>

On Thu, Mar 28, 2024 at 07:20:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d1c4f9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c0a93c676799fdf466c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16577eb1180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106fa941180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9c0a93c676799fdf466c@syzkaller.appspotmail.com

#syz fix: fs,block: get holder during claim

