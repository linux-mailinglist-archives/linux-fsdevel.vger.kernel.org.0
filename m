Return-Path: <linux-fsdevel+bounces-67918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA7C4D99D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E51F54F327B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875933559F8;
	Tue, 11 Nov 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9o0NZ/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F923009F8;
	Tue, 11 Nov 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862649; cv=none; b=cttK39N0xHZwrYdvXTD8Dos/SKEvK5sWAghj/5fKoYZmGoZ8kE7VG4YQjqGFwXB3u9nvwPEM7UJ36gx19pnneN6MOHs+M8oKxwGYBl8hmqQ1K4BpRFKTqcZUdf3dVbt67bBBAkQRiy6wmOB1xUZyRoLmf5Tg7xJEiLoF2sNOKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862649; c=relaxed/simple;
	bh=CXuSHy0O31aSj5lEOnrDTRMS+CyKcDRXkUzk/B6pN8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExcMxD7xnyTKMOvrLh1vOEWDACBhV90M5k5PMIy9CLyGLwVr45e3yCyNBYSAEvE4zGN6dgrReXT2LURxOnFo8KDWpqOTMA+4wmNUrjeDnAOH0D954NQBI0PsriOYGfIpMuwcXc7w1QmSIpwMBWgDECRKvfo1+GyY2lsgovB3RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9o0NZ/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBADC4CEF7;
	Tue, 11 Nov 2025 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762862649;
	bh=CXuSHy0O31aSj5lEOnrDTRMS+CyKcDRXkUzk/B6pN8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9o0NZ/JbFwc0f+dXwdos4UAh8440bpnL5TeGbCKyOfGKD2tdnW54cbgFD2Q1lqv+
	 XZeOb4LHNLZbP5jojQY33R+6tdtQhEzdHhovDkJ0xnU6X7wKw63U0A5CwNd0mMzGpm
	 9USvbr7UPvBhO6scn1T2nrQycv9252QaPeurZL6R719Mxlch60WxMkXwpUXYuXykQN
	 /smLJi9G0/OFRzJinqppGQzQYdiJIiKOrEn97bfPMPZhSVAhWZxHwtSpRddx+18gP7
	 2vh7WJjkjsABJwADhBthuN5WeGXHgcgIq4eJj9ovehL9/vPatK/na/fIGi1MU4syba
	 HAJaFhlxg6IGA==
Date: Tue, 11 Nov 2025 13:04:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_get
Message-ID: <20251111-komponente-verprellen-a5ba489f5830@brauner>
References: <690bfb60.050a0220.2e3c35.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <690bfb60.050a0220.2e3c35.0012.GAE@google.com>

On Wed, Nov 05, 2025 at 05:35:28PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    17490bd0527f Add linux-next specific files for 20251104
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1006532f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9995c0d2611ab121
> dashboard link: https://syzkaller.appspot.com/bug?extid=0a8655a80e189278487e
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1406532f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1166ff34580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a4d318147846/disk-17490bd0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/86641a470170/vmlinux-17490bd0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/35c008a540c8/bzImage-17490bd0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com

#syz test: https://github.com/brauner/linux.git namespace-6.19

