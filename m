Return-Path: <linux-fsdevel+bounces-63747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55EBCCAA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68DF3BFCA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB42ED871;
	Fri, 10 Oct 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak50ItuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4D23D7CF;
	Fri, 10 Oct 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094057; cv=none; b=SYiYFrka8gDIC2ZBwsO8bsBGi1IDmx2cfHPY5+OHbmvKntynQJoojNLpSGPlmkBkai/gf5t1ZiEcBkmSbHI/cEOZARqYY1kwRML1QVYdih5e9VI1tHiINSPqu8peW6eINAzD9ETSFzbL9dVKEOoXkAMmD+TmqPQunzhpN+r0mWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094057; c=relaxed/simple;
	bh=m8TJNO/bWpmWjFb4gDQsBcKZF+85hI0Jn7x9zEm8NaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt4GaWgw6nafHNdJDL6gRJIIRHkcJYbgvA0aJ2x5W3XwD3AABlNDJ+oW39avSJ6Ntft4PXLG0+46qZoWJZldIXVv9MWmYHZnE7lrsbn5KyDOHIUscEMXjAf8IHGA2Mw9KDusKNCK3zBndE/oG2NTPzYFNp6/K+0n/XiSosVvI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak50ItuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A2C4CEF1;
	Fri, 10 Oct 2025 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760094056;
	bh=m8TJNO/bWpmWjFb4gDQsBcKZF+85hI0Jn7x9zEm8NaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ak50ItuIEj8MDvejDFoBE/Ig0Bk+dKAaaFOCbTH6hvz7/uOzrJQ2chsUXLSN8GR8n
	 6ecsJCNI55fdpXUpmGNMFItHchWtRLYKomadxm8PaOio1fuJdZ2uA3s6ZxldImOWWX
	 IOnQKcKvHnSfcxURqdBtNRXkuN3/wZ7UjQXpK6zrf9sYQvqhBKFM6R6xZekTBmWUZC
	 H6q9DUjYzGvZvlzUQKe/qhezxvRCu2lkaw1xhJaVgMsZE5Sl50fN4p/TIJvLdreNHc
	 84ZeZU2xD0Vw8HZiUFfE7kvfi+XiX+Xro2CPOstgGx3wGLSdNxqG4tx3cvoz+4yYWc
	 /G32lVETcpnow==
Date: Fri, 10 Oct 2025 13:00:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [GIT PULL 05/12 for v6.18] pidfs
Message-ID: <20251010-zwilling-beherbergen-21ab938f356a@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
 <20251001141812.GA31331@redhat.com>
 <20251006-liedgut-leiden-f3d51f4242c2@brauner>
 <20251007143418.GA12329@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007143418.GA12329@redhat.com>

On Tue, Oct 07, 2025 at 04:34:19PM +0200, Oleg Nesterov wrote:
> On 10/06, Christian Brauner wrote:
> >
> > On Wed, Oct 01, 2025 at 04:18:12PM +0200, Oleg Nesterov wrote:
> > > On 09/26, Christian Brauner wrote:
> > > >
> > > > Oleg Nesterov (3):
> > > >       pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
> > > ...
> > > > gaoxiang17 (1):
> > > >       pid: Add a judgment for ns null in pid_nr_ns
> > >
> > > Oh... I already tried to complain twice
> > >
> > > 	https://lore.kernel.org/all/20250819142557.GA11345@redhat.com/
> > > 	https://lore.kernel.org/all/20250901153054.GA5587@redhat.com/
> > >
> > > One of these patches should be reverted. It doesn't really hurt, but it makes
> > > no sense to check ns != NULL twice.
> >
> > Sorry, those somehow got lost.
> > Do you mind sending me a revert?
> 
> Thanks, will do.
> 
> But which one? I am biased, but I'd prefer to revert 006568ab4c5ca2309ceb36
> ("pid: Add a judgment for ns null in pid_nr_ns")
> 
> Mostly because abdfd4948e45c51b1916 ("pid: make __task_pid_nr_ns(ns => NULL)
> safe for zombie callers") tries to explain why this change makes sense and
> why it is not easy to avoid ns == NULL.
> 
> OK?

Yes, sounds perfect. Thank you!

