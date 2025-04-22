Return-Path: <linux-fsdevel+bounces-46947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31032A96D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB001702FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6728151D;
	Tue, 22 Apr 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ5qC8hY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463620E703;
	Tue, 22 Apr 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329406; cv=none; b=W0HbOi49nLL0M4i0lNRPll3V3g045PoM4fbtLtiH6bN89x1VI5hwhQ3qtQ/SAjNmysvO1hbO69isxxxpcTsEvc/dZhcLUS7Zjn5AvNZHqDoBDINTc950aKsqN4zAshHpFZ/ceA6V7Cu71HilmPw5E7I1NaqIQ0Z7uS2Ijr/kemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329406; c=relaxed/simple;
	bh=hKcxeqKWyeTCuzTpSV6W+TujKp1txyIh90uOBj/0X2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsv1u1MKc0bSEkmOcr7D2eBtllqRy/FngKDUGz4clEoNqu+kNVCugUVuWC5AfGF+ybbNA8VeHuBpsKfdwnr6Y0qPc28LLsCVZWt/gMZry8akjfKZA/9wDRzjgpnKTgJkMXgav+CqR3vdsBYaNYwTdY8OPcC5DGW7oWKejv7Wkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ5qC8hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD99DC4CEE9;
	Tue, 22 Apr 2025 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745329406;
	bh=hKcxeqKWyeTCuzTpSV6W+TujKp1txyIh90uOBj/0X2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ5qC8hYUjPN43zLgUGZ5XClaaVcm8Q/98qY5BTGWezjg3dGuQ8tnEFbw73f8tUym
	 k45c5Wn66BN5JUMOIR+RhHId6sYP+RrQ/oqg8FDCTzNHD1kfLhTcE2x1FlARHwfdXE
	 EqhrRwPgTgGK2NLo96duzn+Hl4R0BUIbXFpjqiIIR+dIkEPDv+7FwklxW3IGQAQ1zM
	 jOS84gZVH9Ch3Mh59V0Vw0mVUvlfqEbcR8JaEyxCNlyMp8bu2FjlCyhlBRDYCPcQvI
	 hDm0G7Oncmw8QT7JyJbJjHS6zTSYNFUPcC3DvTa596lgF0MKanJHJQprPqwZEIc2Ca
	 qXzT9ATmy7Ozg==
Date: Tue, 22 Apr 2025 15:43:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KCSAN: data-race in choose_mountpoint_rcu /
 umount_tree
Message-ID: <20250422-flogen-firmieren-105a92fbd796@brauner>
References: <6807876f.050a0220.8500a.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6807876f.050a0220.8500a.000f.GAE@google.com>

On Tue, Apr 22, 2025 at 05:11:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a33b5a08cbbd Merge tag 'sched_ext-for-6.15-rc3-fixes' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1058f26f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=85dd0f8b81b9d41f
> dashboard link: https://syzkaller.appspot.com/bug?extid=81fdaf0f522d5c5e41fb
> compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/718e6f7bde0a/disk-a33b5a08.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/20f5e402fb15/vmlinux-a33b5a08.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2dd06e277fc7/bzImage-a33b5a08.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+81fdaf0f522d5c5e41fb@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in choose_mountpoint_rcu / umount_tree

Benign, as this would be detected by the changed sequence count of
@mount_lock. I hope we won't end up with endless reports about:w
anything that we protect with a seqlock. That'll be very annoying.

