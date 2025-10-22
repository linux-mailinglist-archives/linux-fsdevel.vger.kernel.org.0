Return-Path: <linux-fsdevel+bounces-65063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD50BFA9A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A563B18DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571F2F99AA;
	Wed, 22 Oct 2025 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLC3Qv94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688D2F530E;
	Wed, 22 Oct 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118609; cv=none; b=BTdhusHgmzU3ginD8Ompv2OGXdEmtSS/j3EKUYTlPDE87tdKH5oMFaLuvjDGECSLvm3iEyAgZ0sqxzMwiSTNbxtogGR3YN5fzgPNRgIc5dyK6Rks0loO5oZSs2wMpkGNKsKjLDc+FDAIObnZp24jlIgqgOONmNclMXeGBOoKUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118609; c=relaxed/simple;
	bh=CdwqoIYNwleAnsXyjdRG5d+qDP1i41HQIvKLMb00c0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALdEPssdrwH3K7vuPYkcS6RGTb3zAXk3s7UNpVlv7Q83N2HxQzSa6x7q+cX42daW6+lwAkOeGM8gFlTIhvo0RfPoCmhz6e0beGEZ1JcOcbkCQ976Ha9v3sa6uZQMgDTVYziT4lWOc5bCYzQ/deUXg6jiHYW3E+yfJhcLDZLRQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLC3Qv94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEEDC4CEE7;
	Wed, 22 Oct 2025 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761118607;
	bh=CdwqoIYNwleAnsXyjdRG5d+qDP1i41HQIvKLMb00c0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLC3Qv94wmovrpGymrRdVNm0Xtvb8Nsy7JWZwp7J4a0HS4oJ9SP/4vrwSDoWAJSFD
	 CbDSZIjTY7/V/JInDLd1an1GgU206yO1p9+YB4iPSGxC0vgYP9Yax4Tltgmyq93BvZ
	 WsGQQ7ywdQTdflb3im8Jv4LHsQaHtTe7XxxszfCSetKnuYdaZgHKKcls0Lj/rq+mbE
	 9fgxJn8GiPDL+8nntiz5cen9JIjf/IDmXGIFHLP88VXsNAfkXKwRvzWyt5KB1ZGIRe
	 kb59QBvfIuItUL202UsTczztmnYtvrjDvST2R6heR6rfEX45xGRJ3zF+ghix0b+AZY
	 AdcCHwf3F0BHA==
Date: Wed, 22 Oct 2025 09:36:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple
 instances
Message-ID: <20251022-oberdeck-baucontainer-221cf7218f15@brauner>
References: <20251006103852.506614-1-luca.boccassi@gmail.com>
 <2hg43wshc3iklydtwx25ulqadzyuldkyi6wylgztzwendi5zhw@kw223cxay7qn>
 <CAMw=ZnR6QMNevxtxWysqi5UkDmbD68Ge=R5cVAxskqtmhb5m5A@mail.gmail.com>
 <bywtfrezkfevzz7y2ecq4w75nfjhz2qqu2cugwl3ml57jlom5k@b5bebz4f24sd>
 <CAMw=ZnSZmW=BFbLLSKsn7sze-FXZroQw6o4eJU9675VmGjzDRw@mail.gmail.com>
 <rleqiwn4mquteybmica3jwilel3mbmaww5p3wr7ju7tfj2d6wt@g6rliisekp2e>
 <CAMw=ZnTDw59GqW-kQkf1aTEHgmBRzcD0z9Rk+wpE_REEmaEJBw@mail.gmail.com>
 <2025-10-06-brief-vague-spines-berms-pzthvt@cyphar.com>
 <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>

On Mon, Oct 06, 2025 at 02:44:58PM +0100, Luca Boccassi wrote:
> On Mon, 6 Oct 2025 at 14:41, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> > > On Mon, 6 Oct 2025 at 12:57, Alejandro Colomar <alx@kernel.org> wrote:
> > > >
> > > > Hi Luca,
> > > >
> > > > On Mon, Oct 06, 2025 at 12:46:41PM +0100, Luca Boccassi wrote:
> > > > > > > > >  .TP
> > > > > > > > > +.B EINVAL
> > > > > > > > > +The source mount is already mounted somewhere else. Clone it via
> > > > > > [...]
> > > > > > > > > +.BR open_tree (2)
> > > > > > > > > +with
> > > > > > > > > +.B \%OPEN_TREE_CLONE
> > > > > > > > > +and use that as the source instead (since Linux 6.15).
> > > > > > > >
> > > > > > > > The parenthetical in that position makes it unclear if you're saying
> > > > > > > > that one should use open_tree(2) with OPEN_TREE_CLONE since Linux 6.15,
> > > > > > > > or if you're saying that this error can happen since that version.
> > > > > > > > Would you mind clarifying?  I think if you mean that the error can
> > > > > > > > happen since Linux 6.15, we could make it part of the paragraph tag, as
> > > > > > > > in unshare(2).
> > > > > > >
> > > > > > > I meant the former, the error is always there, but OPEN_TREE_CLONE can
> > > > > > > be used since 6.15 to avoid it. Sent v2 with this and the other fix,
> > > > > > > thanks for the prompt review.
> > > > > >
> > > > > > Hmmm, I see.  Why not use open_tree(2) and OPEN_TREE_CLONE before 6.15?
> > > > > > The syscall and flag existed, AFAICS.  I think we should clarify --at
> > > > > > least in the commit message--, why that version is important.
> > > > >
> > > > > It was just not supported at all, so it would still fail with EINVAL
> > > > > before 6.15 even with the clone.
> > > >
> > > > Thanks!  What's the exact commit (or set of commits) that changed this?
> > > > That would be useful for the commit message.
> > > >
> > > > > Would you like me to send a v3 or would you prefer to amend the commit
> > > > > message yourself?
> > > >
> > > > I can amend myself.
> > >
> > > Sorry, I am not a kernel dev so I do not know where it was introduced
> > > exactly, and quickly skimming the commits list doesn't immediately
> > > reveal anything. I only know that by testing it, it works on 6.15 and
> > > fails earlier.
> >
> > If I'm understanding the new error entry correctly, this might be commit
> > c5c12f871a30 ("fs: create detached mounts from detached mounts"), but
> > Christian can probably verify that.
> >
> > Just to double check that I understand this new error explanation -- the
> > issue is that you had a file descriptor that you thought was a detached
> > mount object but it was actually attached at some point, and the
> > suggestion is to create a new detached bind-mount to use with
> > move_mount(2)? Do you really get EINVAL in that case or does this move
> > the mount?
> 
> Almost - the use case is that I prep an image as a detached mount, and
> then I want to apply it multiple times, without having to reopen it
> again and again. If I just do 'move_mount()' multiple times, the
> second one returns EINVAL. From 6.15, I can do open_tree with
> OPEN_TREE_CLONE before applying with move_mount, and everything works.

Your use-case was to create a new detached filesystem via fsmount().
And then send that fd to multiple different mount namespaces. One of
those mount namespaces would manage to attach that mount. At that point
it's not possible to attach that mount in another different mount
namespace again. IOW, it's fine to move it around in the same mount
namespace but it's not fine to move it _across_ mount namespaces after
it has been attached to one. Only a detached mount can be moved across
mount namespaces freely.

And fyi, your original idea wouldn't have been able to address the
use-case. Even if it would've worked you would've simply moved the same
mount between different mount points defeating the purpose of having it
available at multiple locations.

Being able to create detached mounts from detached mounts mounts enables
that use-case. Now you can distribute the same filesystem across
different mount namespaces.

