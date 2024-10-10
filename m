Return-Path: <linux-fsdevel+bounces-31526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F9998278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515BC1F24FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB71BDA89;
	Thu, 10 Oct 2024 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLFrRIZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBF1BBBFE;
	Thu, 10 Oct 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552993; cv=none; b=Js0Ygxx45VK67lT1xl7nxADxy+RJ5i8FFoao+hdeDiofdJUSIixrq1ZPRuMT1quuzgZzn8mxUMNYF0fwXeIrD7ICQo8lwllKe1egwe6X13AhohiXOfZ+jhWmS+Ko2XbuBsHm2PsHrE2lKhj82ldJ12UsZjg+/avBXfherlvWaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552993; c=relaxed/simple;
	bh=JFbhHv2Oze1IPUGsLc5fNEvqYkM859ccLOpwhaxPEaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcZYlHEopwLjwzbwjNFH4lIRWEGmedJJNke6ZZwzrah8P6L0iL6HDvOENWi9/JOdSTlYXGIk1CzpEW4LKTlA5kzcBYaz+oA11NdQnLet5oHLNH7gymQJACh5/xX/bAYAAzqJCDw/ivcGrI3Bew8txfHE18i6I3o4Id5RDUweKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLFrRIZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAACC4CEC5;
	Thu, 10 Oct 2024 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728552993;
	bh=JFbhHv2Oze1IPUGsLc5fNEvqYkM859ccLOpwhaxPEaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLFrRIZw6/+zm6NkXiC2jyOtHrwiSa4gpwpADacmKZ2tDdHjKSQxr5ALtmnfwc7h3
	 7xW9QiqfUnRrUhsh+tw3QuZ0MvAvP08oUo4d9g6dWQUfjO4REnJNMHSaF/2wiTKkGz
	 56VyPThszoMGHX47G85rhvzPpRYoKyUXizt34lNt5fM4Ec1BeGYWN9WdV2Yo6e/OAN
	 CwMWMaDEPovo4kLzm/VLmKZfM5hzHe0fvZbjfuJBY1/9yG5V8fJF6Z8QFH3CV6P0as
	 57wlGuVY+7pDxnuEsli2nfbCdOGAr0bankVphAhg27mWs/tYMG/zkhR71QkR4r/E87
	 Rshvbi0bWlDRw==
Date: Thu, 10 Oct 2024 11:36:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>, Jonathan Corbet <corbet@lwn.net>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241010-bewilligen-wortkarg-3c1195a5fb70@brauner>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <87msjd9j7n.fsf@trenco.lwn.net>
 <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009.205256-lucid.nag.fast.fountain-SP1kB7k0eW1@cyphar.com>

On Thu, Oct 10, 2024 at 07:56:53AM +1100, Aleksa Sarai wrote:
> On 2024-10-09, Jonathan Corbet <corbet@lwn.net> wrote:
> > luca.boccassi@gmail.com writes:
> > 
> > > As discussed at LPC24, add an ioctl with an extensible struct
> > > so that more parameters can be added later if needed. Start with
> > > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > > optionally.
> > 
> > I was looking this over, and a couple of questions came to mind...
> > 
> > > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > ---
> > 
> > [...]
> > 
> > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > index 80675b6bf884..15cdc7fe4968 100644
> > > --- a/fs/pidfs.c
> > > +++ b/fs/pidfs.c
> > > @@ -2,6 +2,7 @@
> > >  #include <linux/anon_inodes.h>
> > >  #include <linux/file.h>
> > >  #include <linux/fs.h>
> > > +#include <linux/cgroup.h>
> > >  #include <linux/magic.h>
> > >  #include <linux/mount.h>
> > >  #include <linux/pid.h>
> > > @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> > >  	return poll_flags;
> > >  }
> > >  
> > > +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> > > +{
> > > +	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> > > +	size_t usize = _IOC_SIZE(cmd);
> > > +	struct pidfd_info kinfo = {};
> > > +	struct user_namespace *user_ns;
> > > +	const struct cred *c;
> > > +	__u64 request_mask;
> > > +
> > > +	if (!uinfo)
> > > +		return -EINVAL;
> > > +	if (usize < sizeof(struct pidfd_info))
> > > +		return -EINVAL; /* First version, no smaller struct possible */
> > > +
> > > +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> > > +		return -EFAULT;
> > 
> > You don't check request_mask for unrecognized flags, so user space will
> > not get an error if it puts random gunk there.  That, in turn, can make
> > it harder to add new options in the future.
> 
> In fairness, this is how statx works and statx does this to not require
> syscall retries to figure out what flags the current kernel supports and
> instead defers that to stx_mask.

pidfd_info overwrites the request_mask with what is supported by the
kernel. I don't think userspace setting random stuff in the request_mask
is a problem. It would already be a problem with statx() and we haven't
seen that so far.

If userspace happens to set a some random bit in the request_mask and
that bit ends up being used a few kernel releases later to e.g.,
retrieve additional information then all that happens is that userspace
would now receive information they didn't need. That's not a problem.

It is of course very different to e.g. adding a random bit in the flag
mask of clone3() or mount_setattr() or any system call that changes
kernel state based on the passed bits. In that case ignoring unknown
bits and then starting to use them is obviously a big problem.

The other related problem would be flag deprecation and reuse of a flag
which (CLONE_DETACHED -> CLONE_PIDFD) also is only a real problem for
system calls that alter kernel state.

So overally, I think ignoring uknown bits in the request mask is safe.
It needs to be documented of course.

