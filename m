Return-Path: <linux-fsdevel+bounces-12059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68385AD96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 22:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291031F22330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443253E11;
	Mon, 19 Feb 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5cgRe57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF21EEFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377514; cv=none; b=S6LEoTkPzFUsQEaDHwlRc/kJ3wiy3xb/xAk0uRdzlfWelWQh/hiduGH1N1vMyj3O+90nApa/ykjYndTUNKY1gDpW+569VPv+u9a8rzicN+Pcb/EYV77wI8YYQKowOI5snV6BoePVqeMC1AK1OJVSP95tccUBJkrzPrUkulg6n48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377514; c=relaxed/simple;
	bh=dep7XUQ2910EwLTUwWUMzb9ZJm0RsvIY6pxbvSWna+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4OUVFOngHXn2WgtWM07MsF/sEwbwlrNJ1Y7ssu7VmecT6xmBxpZnLW9XzKgf/+tlMbhAIn82+SCoCNGjaxx5hRLORCj+pLLDVDitotm6JOQ0NTdK9JOa8rPNmE3+uAuN+zH5UVPnFTKy/mpxjmiBzzcurI3ZHIVZWVnUid2Fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5cgRe57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FAAC433C7;
	Mon, 19 Feb 2024 21:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708377513;
	bh=dep7XUQ2910EwLTUwWUMzb9ZJm0RsvIY6pxbvSWna+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5cgRe57V5HCh05psG66miBSQaNUgh6gjlHzOEwG/2py4PUbf9eb9xFt34KUkgAW2
	 nECDGhRNUpjU0lhD2bxwUpPBlLCiCNwgXYewl0LJF7WXw3XM0mrJY09/lW992j5AID
	 ogI+XH3SwmjolE9rF0OsT8k9uN9IfY3NFcea6nBdUsEzqxDUrCY1U/b/xePNb9F/Ss
	 6VhOz8Cd5qajDoW0x7d4qvSleaTZMH6hKcbbxEU/PCYCTJHZ1m56kXsUG9LORhh4oq
	 HDq5Et88fYo8zfoSoGp9MvtSXg8fxK40ICxi0Oz1vpvKRlj5ukYKk1q2OEageCb/Kj
	 CQ/HeTyRuk2Qg==
Date: Mon, 19 Feb 2024 22:18:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240219-deckung-zierpflanzen-054fa070b251@brauner>
References: <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
 <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
 <20240218-anomalie-hissen-295c5228d16b@brauner>
 <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner>
 <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
 <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com>
 <20240219-parolen-windrad-6208ffc1b40b@brauner>
 <CAHk-=wj81r7z9wVVV+=M57z9tcVY4M8dcy8fLj5rWHrf916vcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj81r7z9wVVV+=M57z9tcVY4M8dcy8fLj5rWHrf916vcQ@mail.gmail.com>

On Mon, Feb 19, 2024 at 10:34:47AM -0800, Linus Torvalds wrote:
> On Mon, 19 Feb 2024 at 10:05, Christian Brauner <brauner@kernel.org> wrote:
> >
> > @Linus, if you're up for it, please take a look at:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.pidfd
> >
> > The topmost 6 commits contain everything we've had on here.
> 
> Looks ok. The commit message on that last one reads a bit oddly,
> because the "Quoting Linus" part looks like it means just the first
> quote, even if it's really everything.
> 
> I'd suggest you just not attribute that explanation to me at all, and
> edit it down to just a neutral explanation of what is going on.

Done.

> 
> But the code itself looks fine, and I like how it just cleaned up the
> callers a lot now that they don't have that odd EAGAIN loop thing.

Yup.

> 
> I expected that to happen, of course, and it was the point of my
> suggestion, but it's still nice to actually see it as a patch that
> removes the nasty code rather than just my "I think that's ugly and
> could be done differently".

I've moved the shared cmpxchg() bit in {ns,pidfs}_prune_dentry() to a
tiny helper so the cmpxchg() isn't coded in the open and is documented
in a single location. Pushed.

