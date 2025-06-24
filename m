Return-Path: <linux-fsdevel+bounces-52711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2FAE5FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47734A2ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642626B2AC;
	Tue, 24 Jun 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRy59Od4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD93239072;
	Tue, 24 Jun 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754648; cv=none; b=ah5lw3H5w1o5FMijEI4Yb9AkqMHi4jqaCS7Q5sW4iKace0fuWoSzQWU+xHyXQ01kBw0pFuFqWeygh6QS6qncZjnrtCRUE4hE3LgphxY92prTb0Rsv3mIytvSsWlScxAlNhuRtPjH26wEEpn0a7tyd8Nr4uCJCz/Y4DgJe+fol2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754648; c=relaxed/simple;
	bh=SIsgi3afey44s25VI1BTV0rs+6t0jfF1bwFGJw+D9ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elZmSNrGgkMArYGkSdoNx65K5JWKhWSxEL96Sxvj1bQe96EaOldbNmEpm0fi9n4Dq2Kk5DgkSAv2HWbfJe5g02ztO9qS3R7EuCpnssKqck258LT+EuzwAPTLiOtnQ1+SfuYc15ODEyVLnCZYFvSF500IEsZdkU4x5fOVkd4AbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRy59Od4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A439C4CEE3;
	Tue, 24 Jun 2025 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750754647;
	bh=SIsgi3afey44s25VI1BTV0rs+6t0jfF1bwFGJw+D9ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRy59Od4UKvPAbkhyrtaZvicuZmVS2az4oISbzxVl8/AKzhJLPMwS4X54vIpn+WZb
	 fUtZpimFOJbprq0jXyybDbBfoLPd+0Qtti9H+OTwJqsMWqo0spW6EhZ91kqHKs3eyf
	 BAzFwajg48Me/SrLr2Ji5x6bMjKW0jce4Knr2qyvHdz2xJaRVX25szqBVQ1EX0PBHB
	 9WGpaiXirmxn1akyTlbPT33ECk4brv98N28truKgqpej01Koj7HGngjWjOmtuxss8g
	 jGYYx9jsdruDb1IEtQ5TGm+g13PFUwCxwkZFgTuqvNcQs7V6PuMBUw7UM78gPh38lK
	 6aVM5iQUPoxIw==
Date: Tue, 24 Jun 2025 10:44:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in pidfs_free_pid
Message-ID: <20250624-fratze-fahrgast-a75e524f3ea6@brauner>
References: <68599c8e.a00a0220.34b642.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68599c8e.a00a0220.34b642.000f.GAE@google.com>

On Mon, Jun 23, 2025 at 11:27:26AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5d4809e25903 Add linux-next specific files for 20250620
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=150ef30c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=58afc4b78b52b7e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=25317a459958aec47bfa
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a5330c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c9f6bc580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/16492bf6b788/disk-5d4809e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7be284ded1de/vmlinux-5d4809e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/467d717f0d9c/bzImage-5d4809e2.xz
> 
> The issue was bisected to:
> 
> commit fb0b3e2b2d7f213cb4fde623706f9ed6d748a373
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Jun 18 20:53:46 2025 +0000
> 
>     pidfs: support xattrs on pidfds
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a1b370580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a1b370580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a1b370580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com
> Fixes: fb0b3e2b2d7f ("pidfs: support xattrs on pidfds")

That is fixed on vfs-6.17.pidfs. :)

