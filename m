Return-Path: <linux-fsdevel+bounces-56370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF0B16D82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C54F1AA529F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726C2BCF53;
	Thu, 31 Jul 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+RAzDcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FB24DCF8;
	Thu, 31 Jul 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950482; cv=none; b=cQ54pKgOtJ9lPr7vKWk/YA/lqTNrr8vI0TPxBoq0yCvnLsARuJE+4VtqAQdP0usSMpOnGmrn9vHK0eeuBlst2kxkS2pg7ZJwe5Db+m8sl8qpo7D6q3n3/y5xfafV64HPFSmLajcz/tDiglz5Mg9fnRIbtl1fJ7rCsm270dabUvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950482; c=relaxed/simple;
	bh=M2a+WGiTZ3R5ZG0sspqJR4vnEQX7RlRwAgvX6K1/sL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5TXD0BhWLgKuameitXzzxU23Xq2iozMrzPzUC9duGd1pphIASav4MD7usZOly7KjmjTvNnq1ncp4jjr8q0w9qxMcEFy6YZwD7nwtibpKam7A9xcwCm75VS+NqHGaC9MNSWyEyFDR/9nIVJVUtSg7aky8ABaYKAPplD+l9IAaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+RAzDcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56C7C4CEF6;
	Thu, 31 Jul 2025 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753950482;
	bh=M2a+WGiTZ3R5ZG0sspqJR4vnEQX7RlRwAgvX6K1/sL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+RAzDcZIoZz5QKIi8MkWngWzjfxyzUpTkNG/FOVZnfS/QXmf3zqME82CNXMtT0QG
	 kjlLIGKoVeDUj1GnGvSFBKYWEaDbbS3YElADICfpBPugPSEvv68ZIzBxcWMbzCiSxg
	 zgpxyPfMT6H1Inu3BZQ7Z0fdN8CcHjhUBJw1sRrVrjnJd/W+TD2HY1YTNlefTa0pCJ
	 u4pReeW+L+n8q7/ahr4opxrk/8oscA7tU2vUCx2JurnqMzkgxu3SMmg2RT/2Helfrv
	 Y3AK/OwJZKtZViZCv6PbXsFHWn6b4JtTMLFvfI63GCXp0D6VErDDDvINDPbH66DlsY
	 Vjjkd5OQXHXdA==
Date: Thu, 31 Jul 2025 10:27:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [GIT PULL 09/14 for v6.17] vfs bpf
Message-ID: <20250731-matrosen-zugluft-12a865db6ccb@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
 <20250725-vfs-bpf-a1ee4bf91435@brauner>
 <ysgjztjbsmjae3g4jybuzlmfljq5zog3eja7augtrjmji5pqw4@n3sc37ynny3t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ysgjztjbsmjae3g4jybuzlmfljq5zog3eja7augtrjmji5pqw4@n3sc37ynny3t>

On Tue, Jul 29, 2025 at 11:15:56AM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 25, 2025 at 01:27:15PM +0200, Christian Brauner wrote:
> > Hey Linus,
> > 
> > /* Summary */
> > These changes allow bpf to read extended attributes from cgroupfs.
> > This is useful in redirecting AF_UNIX socket connections based on cgroup
> > membership of the socket. One use-case is the ability to implement log
> > namespaces in systemd so services and containers are redirected to
> > different journals.
> > 
> > Please note that I plan on merging bpf changes related to the vfs
> > exclusively via vfs trees.
> 
> That was not discussed and agreed upon.
> 
> > /* Testing */
> 
> The selftests/bpf had bugs flagged by BPF CI.
> 
> > /* Conflicts */
> > 
> > Merge conflicts with mainline
> > =============================
> > 
> > No known conflicts.
> > 
> > Merge conflicts with other trees
> > ================================
> > 
> > No known conflicts.
> 
> You were told a month ago that there are conflicts
> and you were also told that the branch shouldn't be rebased,
> yet you ignored it.
> 
> > Christian Brauner (3):
> >       kernfs: remove iattr_mutex
> >       Merge patch series "Introduce bpf_cgroup_read_xattr"
> >       selftests/kernfs: test xattr retrieval
> > 
> > Song Liu (3):
> >       bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
> >       bpf: Mark cgroup_subsys_state->cgroup RCU safe
> >       selftests/bpf: Add tests for bpf_cgroup_read_xattr
> > 
> >  fs/bpf_fs_kfuncs.c                                 |  34 +++++
> >  fs/kernfs/inode.c                                  |  70 ++++-----
> >  kernel/bpf/helpers.c                               |   3 +
> >  kernel/bpf/verifier.c                              |   5 +
> >  tools/testing/selftests/bpf/bpf_experimental.h     |   3 +
> >  .../selftests/bpf/prog_tests/cgroup_xattr.c        | 145 +++++++++++++++++++
> >  .../selftests/bpf/progs/cgroup_read_xattr.c        | 158 +++++++++++++++++++++
> >  .../selftests/bpf/progs/read_cgroupfs_xattr.c      |  60 ++++++++
> 
> Now Linus needs to resolve the conflicts again.
> More details in bpf-next PR:
> https://lore.kernel.org/bpf/20250729180626.35057-1-alexei.starovoitov@gmail.com/

As many times before you seem to conveniently misremember the facts.

Every tree that has meaningful VFS changes such as adding new helpers
uses a shared branch. Such as in this case that touched kernfs and the
VFS.

The conflict arises from the fact that somehow you manage to maintain
all of the complexities of bpf but you refuse to make shared branches
work due to a simple merge conflict:

  "imo this shared branch experience wasn't good.
  We should have applied the series to bpf-next only.
  It was more bpf material than vfs. I wouldn't do this again."

  https://lore.kernel.org/r/CAADnVQ+pPt7Zt8gS0aW75WGrwjmcUcn3s37Ahd9bnLyzOfB=3g@mail.gmail.com

Something that we succesfully manage with all other subsystems. Is it
perfect? Of course not.

But instead of trying to come to a simple solution you just stop
replying. That's not how this works.

The branch had a bug and I informed you and told you how I would resolve
it in:

  https://lore.kernel.org/r/20250702-hochmoderne-abklatsch-af9c605b57b2@brauner

It's been in -next a few days. Instead of slapping some hotfix on top
that leaves the tree in a broken state the fix was squashed. In other
words you would have to reapply the series anyway.

I also explicitly told you as a reply to the very issue in the same thread:

  "Anything that touches VFS will go through VFS. Shared
  branches work just fine. We manage to do this with everyone else in the
  kernel so bpf is able to do this as well. If you'd just asked this would
  not have been an issue. Merge conflicts are a fact of kernel
  development, we all deal with it you can too."

  https://lore.kernel.org/r/20250702-anhaften-postleitzahl-06a4d4771641@brauner

For the record, I don't have a problem with some stuff going through
other trees. For example, if Jens wanted to do that I'd go "hell yeah,
let's try and make this work."

The reason I'm hesitant to do it here is because of continuous mails
like the one you sent here where you aggressively spin a story and then
try to make someone take the blame.

I mean, your mail is very short of "Linus, I'm subtly telling you what
mean Christian did wrong and that he's rebased, which I know you hate
and you have to resolve merge conflicts so please yell at him.". Come
on.

I work hard to effectively cooperate with you but until there is a
good-faith mutual relationship on-list I don't want meaningful VFS work
going through the bpf tree. You can take it or leave it and I would
kindly ask Linus to respect that if he agrees.

