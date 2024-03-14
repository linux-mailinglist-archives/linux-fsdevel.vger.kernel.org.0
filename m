Return-Path: <linux-fsdevel+bounces-14390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FED87BB89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F33FB21F63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F36E616;
	Thu, 14 Mar 2024 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd4v42hJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B14691;
	Thu, 14 Mar 2024 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413388; cv=none; b=XloT1YIqtD/WcuRDzHc6tHrkDS8rQ8KqgWj1gDHOnBXYTUszI/YO2jrN66YTsqQMPdixtBFtyouxnJpkqxPnoBPq9N0FWKhOnqE61CnagCp6dHan8cAh9xf4Q+GzFNvPEFqYS1RLknMq2ODBpvhMPKVl2vxY8YEKSezrtrY8v7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413388; c=relaxed/simple;
	bh=XO6ORvnUUqNCoQFoeBALPciUHMxrzFjU+pE2kYe1iTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXtMUvWoarcXRubzejOMqde1BlDMcj+FlhuZZTmoZxEmjfCBXQ480JJImSJqJh6ciuftsIrAsCTiLzG5GalaNi0qWU48IxKCr7bh2BtRBtU1aGNmyv5ksEc3JN6JdGiwhXHePWGE7YHY2MXTdqHWOCKROuK33xM3Ziltuw4VGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd4v42hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB770C433C7;
	Thu, 14 Mar 2024 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710413388;
	bh=XO6ORvnUUqNCoQFoeBALPciUHMxrzFjU+pE2kYe1iTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qd4v42hJYNSmWhqb6U2QwY/IrP5PAuN3pB4aXJ9KW+LyaxBq6d8jAiQLCNyD27Bmz
	 tSZatq8aVdpx3VbzzgKEN6dAegm3rf563n4wFVnMnMJjhi/t0PPIidkgQoZPlan8Om
	 /RU7wTUUcF4L0rvqqWW3b210X6v+gCJ9Cix1kDwqe08sEmn1xcXHpJBmrmrH3nfPyQ
	 dAHt1PE3hdBvcXBJNO2gdBSzAGrtGoOX4ZOQjYDsVhKsOiLf+ZobVfKI8QY8p9/qR2
	 mOvOAyZSeVWgwKlvy1ODf4O7EJtQkSk0GzFzOmBv3AgDZ1FCldupqmAFGo+dmx/sUn
	 lnlGAXbz66tUg==
Date: Thu, 14 Mar 2024 11:49:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
Message-ID: <20240314-vollversammlung-aktenordner-f60fb363674c@brauner>
References: <0000000000003ea6ba0613882a96@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000003ea6ba0613882a96@google.com>

On Wed, Mar 13, 2024 at 03:23:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f1a876682f0 Merge tag 'vfs-6.9.uuid' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1541d101180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f0300fe4d5cae610
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b5ec5ccf7234cc6cb86
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484d70a180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b38d1180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9de3cd01214c/disk-0f1a8766.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/af661293680e/vmlinux-0f1a8766.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a439df6ad20e/bzImage-0f1a8766.xz

#syz fix: pidfs: remove config option 

