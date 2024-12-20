Return-Path: <linux-fsdevel+bounces-37938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B349F94EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AD2188A3CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A75218E87;
	Fri, 20 Dec 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R3lBbfA/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aquaw83M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975221883F;
	Fri, 20 Dec 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706421; cv=none; b=HR85N+cW7rBZBkUENZARkGnacR6TLh3hJhKh4kdJ+b5mlYNPPOeR9afs+4/g/ID19BsnI9FBiuOZ57npXsb3MoCHIbgjqc+kZQe1TF+5CbU18ScZICgD5wWZOg4lz4VQ/0uW3YGW7lt95P8Mlv4r3OfhF5M13uUGe0/lPIzXlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706421; c=relaxed/simple;
	bh=wj7+tuwiEUI3gtp4S0VH5Eby1OFfhC/zU8dpNMh4jGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6RVCzcYpWPMx3RP6wj/w04nwqLyn+Cvth66FxIghXYGMoDKmMcEb7rvVgqe5oMOVXF3/5ITt29Xdxp8sdNy22oxlKS18pHr5XCrgRycGqYy4Gbm24bzosXnxp8df2C2YvpKTjRkhLm3MMDxhkciiEPXVFNZGsGyJG5cMAnIDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R3lBbfA/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aquaw83M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Dec 2024 21:53:26 +0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734706417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ht45fejCu7H+QDNwRmev4uY5NU3Aqwk/YpHoxtuvxA=;
	b=R3lBbfA/6cLfAtPPhhs2MORbfqmSkI070icALwzCXHN/ASGlG3h9BcZ9SmR4A/gbRA8Gv+
	fGjF8RTIFlAKQaQ+xT/GNCBIBPrbj7XnlCktvj885o2Jy/sKFnd1WX5wlW6PlO3mM8j5/X
	VItXgvWpy2UHoBckE/O6nif6OQDIFU0/Htfhe+kx0V0k6EWwF1giGo6LEgba+8b2H+SAXI
	z+Drf8o/qoWHhV8M3ZOXQc/oi/i2u2ltbl1s28rEjQBHvLkINvrF+ykR6LdkGliMCniCN2
	QshZP2eAd+noSh5ljmED+tRGB7cVRXIvLGgaaTTQlhrZV5e19YZl4bC6D90q4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734706417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ht45fejCu7H+QDNwRmev4uY5NU3Aqwk/YpHoxtuvxA=;
	b=Aquaw83MWkxnVkXse3UPbJvtHX+kPGrJ9Oje6g1YKkbOOT6eblYF+X6e0KJVTvSqrihcTI
	TEw6N9eFL9NijBCA==
From: Nam Cao <namcao@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc: do_task_stat: Fix ESP not readable during
 coredump
Message-ID: <20241220145326.Q7Z6NQ7j@linutronix.de>
References: <cover.1730883229.git.namcao@linutronix.de>
 <11e1777296b7d06085c9fd341bafc4b9d82e6e4e.1730883229.git.namcao@linutronix.de>
 <20241217145923.GA29091@redhat.com>
 <20241217150913.GB29091@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217150913.GB29091@redhat.com>

Hi Oleg,

On Tue, Dec 17, 2024 at 04:09:14PM +0100, Oleg Nesterov wrote:
> On 12/17, Oleg Nesterov wrote:
> >
> > On 11/06, Nam Cao wrote:
> > >
> > > @@ -534,6 +517,23 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
> > >  		ppid = task_tgid_nr_ns(task->real_parent, ns);
> > >  		pgid = task_pgrp_nr_ns(task, ns);
> > >
> > > +		/*
> > > +		 * esp and eip are intentionally zeroed out.  There is no
> > > +		 * non-racy way to read them without freezing the task.
> > > +		 * Programs that need reliable values can use ptrace(2).
> >
> > OK,
> >
> > but then:
> >
> > > +		 * The only exception is if the task is core dumping because
> > > +		 * a program is not able to use ptrace(2) in that case. It is
> > > +		 * safe because the task has stopped executing permanently.
> > > +		 */
> > > +		if (permitted && task->signal->core_state) {
> > > +			if (try_get_task_stack(task)) {
> > > +				eip = KSTK_EIP(task);
> > > +				esp = KSTK_ESP(task);
> > > +				put_task_stack(task);
> >
> > How can the task->signal->core_state check help ?
> >
> > Suppose we have a task T1 with T1-pid == 100 and you read /proc/100/stat.
> > It is possible that the T1's sub-thread T2 starts the coredumping and sets
> > signal->core_state != NULL.
> >
> > But read(/proc/100/stat) can run before T1 gets SIGKILL from T2 and enters
> > the kernel mode?

Right, I missed that race, thanks for pointing it out.

> Can't the trivial patch below fix the problem?

It can. In fact this is the original fix we had. I thought that checking a
single "core_state" is simpler than checking 3 flags, oh well..

Can you send a proper patch, or should I do it?

Best regards,
Nam

> 
> Oleg.
> 
> 
> --- xfs/proc/array.c
> +++ x/fs/proc/array.c
> @@ -500,7 +500,7 @@
>  		 * a program is not able to use ptrace(2) in that case. It is
>  		 * safe because the task has stopped executing permanently.
>  		 */
> -		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE))) {
> +		if (permitted && (task->flags & (PF_EXITING|PF_DUMPCORE|PF_POSTCOREDUMP))) {
>  			if (try_get_task_stack(task)) {
>  				eip = KSTK_EIP(task);
>  				esp = KSTK_ESP(task);
> 

