Return-Path: <linux-fsdevel+bounces-44415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BBA68673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B3A3A8E82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2F42505C4;
	Wed, 19 Mar 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYThBfFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2220C46B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372055; cv=none; b=qDLouw9eqZ0CS4py3EZP5bd7zyzDFxH5hF0A/6iBV/E+5+4ZdLt276HcgMLTX2D6i9rOnekZqEXTrZvRbstID0EPiHihR3LMRIdJU5JqqNrrhr/dFaWvRxaXnmIQuwqBDhddSjTlDdnEeiLZrcA+h7eYdQLXP5BkyVRUfv7wQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372055; c=relaxed/simple;
	bh=hwUJk5uVE9ltrabdqyucQ5kvFNSSDgIpW2kesnMQZCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg0Q/A0q1nYmiCg/fEWPcYWmpBmgY1Y3mY+QGwSu/R4ixSWT3FVrRtD8vnVsm0tqddfD7f5io9kajwoUJWq36FZMbSE2fTaE7bspGbOGyALCfsMLV4DmmMqaiHzyxtbmWS092+ILQe8BDefKZ2wWQSAYeeOUz4fte1ypEYwcv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYThBfFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B78C4CEE9;
	Wed, 19 Mar 2025 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372054;
	bh=hwUJk5uVE9ltrabdqyucQ5kvFNSSDgIpW2kesnMQZCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYThBfFAC5osIDbeMImoGPMnq54hp3Ozv+sbfR76mIhbdsc7UzkprS19t9w6IZBt/
	 3iHO+Gc6G0mjeI8FlNg9s5L5S1W7ZeXoMV+saJs9PLK13iCKd4hzQjTZEubm/bR85k
	 H1Wu7ldeNM06ppS0bbhpBqOFXGPKjs0BXWDZ3g2EqP8Rzgtr9HIZY1atgLWhyM7tnu
	 wf1GiDe7wvUwYd5W/oGke+GMX6to8Bxn7IYAQFXcv4wEzERl3p6OMCrZ/w4fQHce7R
	 jTW8pyjb3qw2Kbf8gHiBCbbe0X+AoKH0rW6aQIYv/ouoHCu1cIBQotLCZiM7F521SI
	 aDOfqUZGn3ouw==
Date: Wed, 19 Mar 2025 09:14:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2] pidfs: ensure that PIDFS_INFO_EXIT is available
Message-ID: <20250319-behielt-zensieren-e63e234730d2@brauner>
References: <20250318-geknebelt-anekdote-87bdb6add5fd@brauner>
 <20250318142601.GA19943@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318142601.GA19943@redhat.com>

On Tue, Mar 18, 2025 at 03:46:54PM +0100, Oleg Nesterov wrote:
> I'll try to actually read this patch (and pidfs: improve multi-threaded
> exec and premature thread-group leader exit polling) tomorrow, but I am
> a bit confused after the quick glance...
> 
> 
> On 03/18, Christian Brauner wrote:
> >
> > +static inline bool pidfs_pid_valid(struct pid *pid, const struct path *path,
> > +				   unsigned int flags)
> > +{
> > +	enum pid_type type;
> > +
> > +	if (flags & CLONE_PIDFD)
> > +		return true;
> 
> OK, this is clear.
> 
> > +	if (flags & PIDFD_THREAD)
> > +		type = PIDTYPE_PID;
> > +	else
> > +		type = PIDTYPE_TGID;
> > +
> > +	/*
> > +	 * Since pidfs_exit() is called before struct pid's task linkage
> > +	 * is removed the case where the task got reaped but a dentry
> > +	 * was already attached to struct pid and exit information was
> > +	 * recorded and published can be handled correctly.
> > +	 */
> > +	if (unlikely(!pid_has_task(pid, type))) {
> > +		struct inode *inode = d_inode(path->dentry);
> > +		return !!READ_ONCE(pidfs_i(inode)->exit_info);
> > +	}
> 
> Why pidfs_pid_valid() can't simply return false if !pid_has_task(pid,type) ?
> 
> pidfd_open() paths check pid_has_task() too and fail if it returns NULL.
> If this task is already reaped when pidfs_pid_valid() is called, we can
> pretend it was reaped before sys_pidfd_open() was called?

We could for sure but why would we. If we know that exit information is
available then returning a pidfd can still be valuable for userspace as
they can retrieve exit information via PIDFD_INFO_EXIT and it really
doesn't hurt to do this.

