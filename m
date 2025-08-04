Return-Path: <linux-fsdevel+bounces-56648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391AB1A4CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 16:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F37D7A1B68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815E271472;
	Mon,  4 Aug 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG66nN0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0426B755;
	Mon,  4 Aug 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317445; cv=none; b=IOSjMBvbJq7iJSX7Fb8KvQNkrOTjHYEeQblhun/BZJbc9GdYjfoa+HrL02MUIJOnCLMQHneQPIIbRGC4rXFMc60nCAxB8mHRZbT2tS3L6BILKzvcvrYL862ijSh1EJ8y7NmQWJ0o+2PBbbC0tnPMiq+OfTj0kQLM48nDx4kxA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317445; c=relaxed/simple;
	bh=XgUMlZidrLg1tze+vp7RzDI/dCdqdxcMxPxHB1C779k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkmGaSuVzLNxj5lP69R/jgUv2Uy8Wn0WOBdNe2hQ2tEF6dhThU8+QKwUxED0JgNM9+wS5mK+PWI5wUHVbrt3whab6UDndMbSdsxdvIkSA77ShK3LVLsKLQs80Ob7GHENfCL6lmH0T7eK/xZvHu6x7zn/5tieZUxpCyFFlIDBuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG66nN0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1806CC4CEE7;
	Mon,  4 Aug 2025 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754317445;
	bh=XgUMlZidrLg1tze+vp7RzDI/dCdqdxcMxPxHB1C779k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rG66nN0fw8ArwK6YmYIJT48P4C4nJ5mCjWX+JLT4a8ThDoTiBGD+HPHoCse0r/XWH
	 I/tid93IGOUvGfzviZpkMtJi/bKHMeZtPEwEGiylZwRTdlgw7Iujy/LUYjNbPx6pWw
	 Ele+pYPJFNKfJlT+G5nTTtzuRykYcW/7NtzZd1hxp5XhP2dHepHJ8J85edS/QYphNo
	 mO1R7SStOOVf4nKvLAM2hxCsKubKaD+f/KIZ6KBdva0FIsgR5m+iDAyGjEb5RqYcB3
	 0cxGEQMlEhUqvqALQ4FMM8dBqKN+qJPrC3rqjXyTf19F8uK9vgD9PKo5xw09+Oab5y
	 nmkiruah+vr+w==
Date: Mon, 4 Aug 2025 16:24:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [GIT PULL 09/14 for v6.17] vfs bpf
Message-ID: <20250804-dammbruch-babypuppen-689a8e3421df@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-bpf-a1ee4bf91435@brauner>
 <ysgjztjbsmjae3g4jybuzlmfljq5zog3eja7augtrjmji5pqw4@n3sc37ynny3t>
 <20250731-matrosen-zugluft-12a865db6ccb@brauner>
 <CAADnVQKMNq3vWDzYocS6QojBDXDzC2RdE=VzTnd7C_SN6Jhn_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKMNq3vWDzYocS6QojBDXDzC2RdE=VzTnd7C_SN6Jhn_g@mail.gmail.com>

On Thu, Jul 31, 2025 at 02:57:52PM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 31, 2025 at 1:28 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > It's been in -next a few days. Instead of slapping some hotfix on top
> > that leaves the tree in a broken state the fix was squashed. In other
> > words you would have to reapply the series anyway.
> 
> That's not how stable branches work. The whole point of a stable
> branch is that sha-s should not change. You don't squash things
> after a branch is created.
> That extra fix could have been easily added on top.
> 
> > I mean, your mail is very short of "Linus, I'm subtly telling you what
> > mean Christian did wrong and that he's rebased, which I know you hate
> > and you have to resolve merge conflicts so please yell at him.". Come
> > on.
> 
> Not subtly. You made a mistake and instead of admitting it
> you're doubling down on your wrong git process.
> 
> > I work hard to effectively cooperate with you but until there is a
> > good-faith mutual relationship on-list I don't want meaningful VFS work
> > going through the bpf tree. You can take it or leave it and I would
> > kindly ask Linus to respect that if he agrees.
> 
> Look, you took bpf patches that BPF CI flagged as broken
> and bpf maintainers didn't even ack.
> Out of 4 patches that you applied one was yours that
> touched VFS and 3 were bpf related.
> That was a wtf moment, but we didn't complain,
> since the feature is useful, so we were happy to see
> it land even in this half broken form.
> We applied your "stable" branch to bpf-next and added fixes on top.
> Then you squashed "hotfix".
> That made all of our fixes in bpf-next to become conflicts.
> We cannot reapply your branch. We don't rebase the trees.
> That was the policy for years. Started long ago during
> net-next era and now in bpf-next too.
> This time we were lucky that conflicts were not that bad
> and it was easy enough for Linus to deal with them,
> but that must not repeat.

Ah, I see what you're complaining about now. But I'm still not happy
that we didn't manage to resolve this confusion earlier.

I was not clear in what way you did rely on that branch and that you
relied on me not folding in the mutex fix especially because you didn't
reply when I said I would fold it and you said that putting fixes on top
wouldn't work upthread.

If I'm aware that a branch is shared and relied upon then I won't change it.
I would've immediately rolled it back would I have know that this causes
issues for you but to me everything looked fine when I didn't hear back.

