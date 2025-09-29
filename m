Return-Path: <linux-fsdevel+bounces-63012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B99BA8C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F591703D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB02ECE85;
	Mon, 29 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiJ5hUdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8C2ECD34;
	Mon, 29 Sep 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139637; cv=none; b=iNHmxaVlNJn4RENiZy8eYiFv/3ylHGYhZAo6lKDC7iQJ35w1ZOlgqYqWGVE8T8zO/HcXEkKnybXN0Mc4bstFMy/kDViWsW13GTH7mGlmO14Tm6fYYf9euLZSBSZKktpTFtN23m+I4D543C2pW7ETIkTN9XRlkx93TfI4rYwNGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139637; c=relaxed/simple;
	bh=IcBB4p77ulg56CDFEqg1DgkRSxZNM6H4ZDQTNwSyFYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv+NK3GdCX2N3MD/gSegfehq2XVU2rkqlraI6IRltY6CFJK0lk/S6audzrUFk1e8XjGpuUQme7AkI4r79yf3wG3WpZLKvn+u6M9VXqYa+Ixz+PzN7C8F+mrJyBlh5wKJkO8rHjxTyQisO5UlU858n1D5cVanTjIP8+yO0NEOYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiJ5hUdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67842C4CEF4;
	Mon, 29 Sep 2025 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139636;
	bh=IcBB4p77ulg56CDFEqg1DgkRSxZNM6H4ZDQTNwSyFYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FiJ5hUduzwTJIQ6rjcl3gcekaQ/ug2elSnrnXxdAk0ubdohlBlBbYvb3ukQtM4Njw
	 rLVEDmyE5buDouuEcVTUXA8giphDauULJ9reLccQKaFPxM47fVYrUgaPHq5naslkX5
	 GAdIU1uS0KpI0UakIBTqQf458nclumS/LjVReH+BoU1IMDm4QoCDomvMbn4ZmGx4Ek
	 ynVjEAAFgiXka2Egc0hHq2NQ9TlY9gpjuo+EGSkp6QGfH2QCpt6eEqAoY+gljILQf3
	 fobDJEPqkwQfLlvJHzie5w7Jhmy3lZOaJ8LwUKUnyteRy+AVfAWIgiBUvZpsExNE26
	 cgsxxkSFMQExg==
Date: Mon, 29 Sep 2025 11:53:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 08/12 for v6.18] core kernel
Message-ID: <20250929-starren-ersonnen-c6559a5110a0@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-core-kernel-eab0f97f9342@brauner>
 <aNfWQL6nLBrPNQTs@laps>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNfWQL6nLBrPNQTs@laps>

On Sat, Sep 27, 2025 at 08:19:12AM -0400, Sasha Levin wrote:
> On Fri, Sep 26, 2025 at 04:19:02PM +0200, Christian Brauner wrote:
> > Hey Linus,
> > 
> > /* Testing */
> > This contains the changes to enable support for clone3() on nios2 which
> > apparently is still a thing. The more exciting part of this is that it
> > cleans up the inconsistency in how the 64-bit flag argument is passed
> > from copy_process() into the various other copy_*() helpers.
> > 
> > gcc (Debian 14.2.0-19) 14.2.0
> > Debian clang version 19.1.7 (3+b1)
> > 
> > No build failures or warnings were observed.
> > 
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
> > 
> > The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> > 
> >  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> > 
> > are available in the Git repository at:
> > 
> >  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.18-rc1.clone3
> 
> Hi Christian,
> 
> After pulling this tag, I started seeing a build failure.
> 
> a9769a5b9878 ("rv: Add support for LTL monitors") which was merged a few weeks
> ago added a usage of task_newtask:
> 
> 	static void handle_task_newtask(void *data, struct task_struct *task, unsigned long flags)
> 
> But commit edd3cb05c00a ("copy_process: pass clone_flags as u64 across
> calltree") from this pull request modified the signature without updating rv.
> 
> ./include/rv/ltl_monitor.h: In function ‘ltl_monitor_init’:
> ./include/rv/ltl_monitor.h:75:51: error: passing argument 1 of ‘check_trace_callback_type_task_newtask’ from incompatible pointer type [-Wincompatible-pointer-types]
>    75 |         rv_attach_trace_probe(name, task_newtask, handle_task_newtask);
>       |                                                   ^~~~~~~~~~~~~~~~~~~
>       |                                                   |
>       |                                                   void (*)(void *, struct task_struct *, long unsigned int)
> ./include/rv/instrumentation.h:18:48: note: in definition of macro ‘rv_attach_trace_probe’
>    18 |                 check_trace_callback_type_##tp(rv_handler);                             \
>       |                                                ^~~~~~~~~~
> 
> I've fixed it up by simply:
> 
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 67031a774e3d3..5368cf5fd623e 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -56,7 +56,7 @@ static void ltl_task_init(struct task_struct *task, bool task_creation)
>         ltl_atoms_fetch(task, mon);
>  }
> -static void handle_task_newtask(void *data, struct task_struct *task, unsigned long flags)
> +static void handle_task_newtask(void *data, struct task_struct *task, u64 flags)
>  {
>         ltl_task_init(task, true);
>  }

Hm, thanks! That is only in -next, I guess. I probably didn't catch this
because I didn't have CONFIG_RV_REACTORS turn on (whatever that is).

@Linus please let me know if you want me to resend this pull request or
if you just want to apply this fixup directly. Thank you!

Christian

