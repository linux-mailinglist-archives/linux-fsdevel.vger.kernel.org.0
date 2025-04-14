Return-Path: <linux-fsdevel+bounces-46356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF73A87D7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B405A17178A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB92698BE;
	Mon, 14 Apr 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twPqfKFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BE265CBC;
	Mon, 14 Apr 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626157; cv=none; b=rEfEGRDFeaXgMxuza3sf4tUBMtkEsZGPMKlBsrhGeGwjjb96K9k+YPLNvKXChj1x2d0TE9HLg0BmHDA4STEZJy8xfp4tYj55yVBulC7ROGxQTZLdnlSAQGt9PpCuOebspeSdmVwUPXMxD38V1Bf/HEg2HsPFJwv6IZ5Kk4gRu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626157; c=relaxed/simple;
	bh=pfswF9hFwztwkR136mS6DW2WqJS1nm6UTp53hrNgpts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg9tivB51ZHeJj53wgd/BJPHAsOb87Tdib5dZ2e+xBiJZFaRzTBbyGm6ua6Rj0th/5fe8Qcph5COUcUpKqkgqF7vDYzLMeRBPdF528sz+sYhKhWFr+tYW0YEKIsuQFZrX3pA3ir4XE7SD0uGucNlqS0Wu5gSGK7ex796myZMQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twPqfKFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21B0C4CEE5;
	Mon, 14 Apr 2025 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744626156;
	bh=pfswF9hFwztwkR136mS6DW2WqJS1nm6UTp53hrNgpts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twPqfKFpCOKJ42CXEzM/GZW8mil2udnHBVwvs1Bzu2mhTTRq1BYf3/BaGF/hYi80i
	 dMqJEEv/X0IE6T0TD/s2SxeTi+Uy3SW4sM7PIT3XX9PDZC9xVjnY/O5hanFtecn4aq
	 LICjqEP+mmnpzvK9lXYBz7DBNbhvfBl6APihNYStwbsZ/c1dz3qBaPWeLoEkxuLPmQ
	 g9mWS6Zh6JfiR1NnFXm91Ou+RfOWIhuO1lHDyn8kHrh/t6pq9L7bnXq7hTxMav1EZr
	 rOO86FwlpGuWGh/j5CdxLneyOl+Ddry3YjhEoMZAWbZ9Tf/pnF4V1zdlKd97+CQq+b
	 kjvJV4sa/uIwA==
Date: Mon, 14 Apr 2025 12:22:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+d11add3a08fc150ce457@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandeen@redhat.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Subject: Re: [syzbot] [kernfs?] INFO: task hung in __generic_file_fsync (5)
Message-ID: <20250414-canceln-sorgfalt-8ba540573ad6@brauner>
References: <67777f13.050a0220.11076.0003.GAE@google.com>
 <67fb0e75.050a0220.378c5e.0007.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67fb0e75.050a0220.378c5e.0007.GAE@google.com>

On Sat, Apr 12, 2025 at 06:08:05PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 00dac020ca2a2d82c3e4057a930794cca593ea77
> Author: Eric Sandeen <sandeen@redhat.com>
> Date:   Wed Feb 5 22:30:09 2025 +0000
> 
>     sysv: convert sysv to use the new mount api
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b380cc580000
> start commit:   ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
> dashboard link: https://syzkaller.appspot.com/bug?extid=d11add3a08fc150ce457
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1558f8b0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16612edf980000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: sysv: convert sysv to use the new mount api
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

syzbot should also suspect that sysv doesn't exist anymore in v6.15-rc1. :)

